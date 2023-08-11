Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CAB779AC3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 00:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbjHKWkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 18:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbjHKWkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:40:02 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755352D5B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 15:40:01 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6418d37f006so7309056d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 15:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1691793600; x=1692398400;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YuI0ePov3Z0koQBEZTX+a6gmqpdNN7KwPiKci/H2HIk=;
        b=KrVakcZLCquMn5jxUNsVPXTTvWD+pbBLtdyyLj7b3a+KiAPO8lZ01N8/xYgaxWxn9x
         uC1iEzZ4Oe9VGC8ssQbESOqtQkgEMfHrnsS2UjUrdKbE4qpoiGsIECerBs4vruhlTP3R
         j0FFZ7RCmWH+2SFphYayn282gIPS0LuIJnREg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691793600; x=1692398400;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuI0ePov3Z0koQBEZTX+a6gmqpdNN7KwPiKci/H2HIk=;
        b=VB4jEpPcLbWh0tx6nW+WejxmSkJwM4q2NZ+zZB9sAKFUtf8vNFdPLuESzhVnkhod00
         ispCQOC0rrReDv3mvL40QWVmGD4jqJHqpHa1Hla+4E2WDkZJtjdGVE4x5iLmBRrIO0BZ
         nQ5po2+b8xlzZLie9scORp+t9ip34A+ba2/eNgSXujlNTx6c8l0tWJuIlk577mypwn58
         jM6gtg/rwIFxlg1U8luZ1Ivzj1xaoydSnaU2taOTQy++482TdudJ4gm3IfCYHz7z9BZA
         uBbCmtZ3F3tZzWlfV3IPZhSt59TYSL0bM7lRfuV4eIjF2lpgDbZLwQ0LSVFSNuHFCisn
         d8mg==
X-Gm-Message-State: AOJu0YyRJ7Xw3JX5M5iC2hlr25lVNHG5WS8lsJC6rmbNO9d1O+xPZtmx
        LwWMJXhAaKa8cDNV++ooQD2ECw==
X-Google-Smtp-Source: AGHT+IEizOMbioRq6ckFd+WFGYrW3QDe3XauyoYlsyXdp0oanpqCuBEsP6zRf23otZHixC5HC6xKtw==
X-Received: by 2002:a0c:e150:0:b0:63d:318c:7dfb with SMTP id c16-20020a0ce150000000b0063d318c7dfbmr2925096qvl.13.1691793600575;
        Fri, 11 Aug 2023 15:40:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q17-20020a0c8b11000000b0063d1f967268sm1536403qva.111.2023.08.11.15.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 15:40:00 -0700 (PDT)
Message-ID: <6f7fd397-2b63-be20-fa9c-c26298226088@broadcom.com>
Date:   Fri, 11 Aug 2023 15:39:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] net: phy: broadcom: add support for BCM5221 phy
To:     Andrew Lunn <andrew@lunn.ch>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Reinhart <jimr@tekvox.com>,
        James Autry <jautry@tekvox.com>,
        Matthew Maron <matthewm@tekvox.com>
References: <20230811215322.8679-1-giulio.benetti@benettiengineering.com>
 <0188dd19-7fcb-4bfe-945d-6cb5b57ae80a@lunn.ch>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
In-Reply-To: <0188dd19-7fcb-4bfe-945d-6cb5b57ae80a@lunn.ch>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009cc4420602ad64ce"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000009cc4420602ad64ce
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/23 15:16, Andrew Lunn wrote:
> On Fri, Aug 11, 2023 at 11:53:22PM +0200, Giulio Benetti wrote:
>> This patch adds the BCM5221 PHY support by reusing
>> brcm_fet_config_intr() and brcm_fet_handle_interrupt() and
>> implementing config_init()/suspend()/resume().
>>
>> Sponsored by: Tekvox Inc.
> 
> That is a new tag. Maybe you should update
> Documentation/process/submitting-patches.rst ?
> 
>> +static int bcm5221_config_init(struct phy_device *phydev)
>> +{
>> +	int reg, err, err2, brcmtest;
>> +
>> +	/* Reset the PHY to bring it to a known state. */
>> +	err = phy_write(phydev, MII_BMCR, BMCR_RESET);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	/* The datasheet indicates the PHY needs up to 1us to complete a reset,
>> +	 * build some slack here.
>> +	 */
>> +	usleep_range(1000, 2000);
>> +
>> +	/* The PHY requires 65 MDC clock cycles to complete a write operation
>> +	 * and turnaround the line properly.
>> +	 *
>> +	 * We ignore -EIO here as the MDIO controller (e.g.: mdio-bcm-unimac)
>> +	 * may flag the lack of turn-around as a read failure. This is
>> +	 * particularly true with this combination since the MDIO controller
>> +	 * only used 64 MDC cycles. This is not a critical failure in this
>> +	 * specific case and it has no functional impact otherwise, so we let
>> +	 * that one go through. If there is a genuine bus error, the next read
>> +	 * of MII_BRCM_FET_INTREG will error out.
>> +	 */
>> +	err = phy_read(phydev, MII_BMCR);
>> +	if (err < 0 && err != -EIO)
>> +		return err;
> 
> It is pretty normal to check the value of MII_BMCR and ensure that
> BMCR_RESET has cleared. See phy_poll_reset(). It might not be needed,
> if you trust the datasheet, but 802.3 C22 says it should clear.
> 
>> +	/* Enable auto MDIX */
>> +	err = phy_clear_bits(phydev, BCM5221_AEGSR, BCM5221_AEGSR_MDIX_DIS);
>> +	if (err < 0)
>> +		return err;
> 
> It is better to set it based on phydev->mdix_ctrl.
> 
>> @@ -1288,6 +1431,7 @@ static struct mdio_device_id __maybe_unused broadcom_tbl[] = {
>>   	{ PHY_ID_BCM53125, 0xfffffff0 },
>>   	{ PHY_ID_BCM53128, 0xfffffff0 },
>>   	{ PHY_ID_BCM89610, 0xfffffff0 },
>> +	{ PHY_ID_BCM5221, 0xfffffff0 },
> 
> This table has some sort of sorting. I would put this new entry before
> PHY_ID_BCM5241.
> 
>>   #define PHY_ID_BCM50610			0x0143bd60
>>   #define PHY_ID_BCM50610M		0x0143bd70
>>   #define PHY_ID_BCM5241			0x0143bc30
>> +#define PHY_ID_BCM5221			0x004061e0
> 
> The value looks odd. Is the OUI correct? Is that a broadcom OUI?

Yes it is correct and yes it is assigned to Broadcom.
-- 
Florian


--0000000000009cc4420602ad64ce
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINppL7iS4jIoea//
oRIX17CSlnjEFkVicezJXBnHQ80vMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMDgxMTIyNDAwMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA6zZaxHcbFeqNwsLBxXXHtbjJQ6IkaAk+T
wnk7eT1l4FLloEPplQqaQq1h49/UvKQhTvbOOakQTkK8U50QuKS7mqueXhPLkQI055WycJMD3QBr
ektWq6lqobItldgp6j4i0l9L1XpLXOrTOmMnhbku1YAxnz3XjRcSf5JqtfGSaupFCEee6DO6MTMG
Zk7Xr32IwN1/ntzi19d06Bl9DW8oW4WQe3iaztRSfsRq0li3Fd/hfOGdfycYYPWSFBfenHvShI6l
R+XVvghNRUPnM8bmG8VGIhsNCQS/oS0A3mwNpGOJ6v5JHPhQKu3A1tJ2ioCM4aI5hDGT5DISS7Zr
sOl2
--0000000000009cc4420602ad64ce--
