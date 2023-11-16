Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9729A7EE698
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345435AbjKPSUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjKPSUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:20:19 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7093D4D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:20:14 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b40d5ea323so697751b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1700158814; x=1700763614; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qe2V3BbCb9UTSPbYfnHwAlTji1v+3NnyuczSR3mfR/0=;
        b=GtMT9fLCrxxjRQabEqk4jAD9Q9BYk52fdJ7DwPXxwZhMohhrJlMgE/H0uncF7gIjfQ
         85z7YkHl9RJFS86KVHrAkEBzaZzvM2xTYcu3xrQp1ZyU+2t0Z87DcaZc6VEIpQP4vYiy
         cY+nUVr9Ljf+QfyrTz8zdp0Qj/luEOUfi497U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700158814; x=1700763614;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qe2V3BbCb9UTSPbYfnHwAlTji1v+3NnyuczSR3mfR/0=;
        b=iMPrYJ7ZqdIWgBmw0NwuKRUiprxAvLZvALECiMUPCX5V6JnDLtJygmOmYnl/+qY9C+
         SBL1zD17KaBE7TXOEVQTzgDca1WH4Ewds+GHoAnRRJUWNiJdbLFJmzIVo4oHC23Vd2s+
         dm8h1pGoLvaOpuymPZtksR9e3iV11zcJ6eWMl643UUPfz85iABLxdueLzgAhJEXolGlN
         PRTHnewBUDKsNAXHVSJGT85RTmM5xmVyLqSzICAlfsIYZJUfNlLPo6I068jL6ccovEf2
         dt+1fD4tmWyQDLpLjajgIyPQK0S2katTKAMx2LNHw1vbqOIWR2CfpuXjOFYnrxh9pg/C
         7oSg==
X-Gm-Message-State: AOJu0YxVfzGs3FVQATZ/u/ZC8fu9JUaaomA7+yLCqrpFKjauHzNnm5S2
        s954pd6SMA4SRlADtfeCa4KvNg==
X-Google-Smtp-Source: AGHT+IEk/N8I3jhB2UbSAIWAocP+igZaUkZvlRo6AdpXMF1cdSGb8qInDV/grLtjRK80656F8rn4XQ==
X-Received: by 2002:a05:6358:e4a1:b0:16b:c810:667b with SMTP id by33-20020a056358e4a100b0016bc810667bmr9321225rwb.2.1700158813880;
        Thu, 16 Nov 2023 10:20:13 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id m9-20020ad44b69000000b00677e9c852b7sm541060qvx.108.2023.11.16.10.20.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Nov 2023 10:20:11 -0800 (PST)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Zheng Hacker <hackerzheng666@gmail.com>
CC:     Kalle Valo <kvalo@kernel.org>, Zheng Wang <zyytlz.wz@163.com>,
        <aspriel@gmail.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <johannes.berg@intel.com>,
        <marcan@marcan.st>, <linus.walleij@linaro.org>,
        <jisoo.jang@yonsei.ac.kr>, <linuxlovemin@yonsei.ac.kr>,
        <wataru.gohda@cypress.com>, <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>, <linux-kernel@vger.kernel.org>,
        <security@kernel.org>, <stable@vger.kernel.org>
Date:   Thu, 16 Nov 2023 19:20:06 +0100
Message-ID: <18bd95c97f0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAJedcCzj9SFbx-=xDymqJyV2fu0xjmz2RH4+gT+Gxsqubg35ZA@mail.gmail.com>
References: <20231106141704.866455-1-zyytlz.wz@163.com>
 <87o7g7ueom.fsf@kernel.org>
 <CAJedcCytuGmvubqbSZgsU3Db=rg=xM+kSuLZn8BSvA18Yn+9Jw@mail.gmail.com>
 <18ba5520da0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAJedcCxoL+L1QPaZty27k6kqR2JRjxPVY=BV5xn7BSPojbxe=A@mail.gmail.com>
 <fa0e7536-9b05-42fb-9fff-acd2ffad9af9@broadcom.com>
 <CAJedcCzj9SFbx-=xDymqJyV2fu0xjmz2RH4+gT+Gxsqubg35ZA@mail.gmail.com>
User-Agent: AquaMail/1.48.0 (build: 104800386)
Subject: Re: [PATCH v5] wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000304a3d060a4912f1"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000304a3d060a4912f1
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On November 15, 2023 4:00:46 PM Zheng Hacker <hackerzheng666@gmail.com> wrote:

> Arend van Spriel <arend.vanspriel@broadcom.com> 于2023年11月13日周一 17:18写道：
>>
>> On November 8, 2023 4:03:26 AM Zheng Hacker <hackerzheng666@gmail.com>
>> wrote:
>>
>>> Arend Van Spriel <arend.vanspriel@broadcom.com> 于2023年11月6日周一 23:48写道：
>>>>
>>>> On November 6, 2023 3:44:53 PM Zheng Hacker <hackerzheng666@gmail.com> wrote:
>>>>
>>>>> Thanks! I didn't test it for I don't have a device. Very appreciated
>>>>> if anyone could help with that.
>>>>
>>>> I would volunteer, but it made me dig deep and not sure if there is a
>>>> problem to solve here.
>>>>
>>>> brcmf_cfg80211_detach() calls wl_deinit_priv() -> brcmf_abort_scanning() ->
>>>> brcmf_notify_escan_complete() which does delete the timer.
>>>>
>>>> What am I missing here?
>>>
>>> Thanks four your detailed review. I did see the code and not sure if
>>> brcmf_notify_escan_complete
>>> would be triggered for sure. So in the first version I want to delete
>>> the pending timer ahead of time.
>>
>> Why requesting a CVE when you are not sure? Seems a bit hasty to put it
>> mildly.
>
> I'm sure the issue exists because there's only cancler of timer but not woker.
> As there's similar CVEs before like : https://github.com/V4bel/CVE-2022-41218,
> I submit it as soon as I found it.

Ah, yes. The cancel_work_sync() can also be done in 
brcmf_notify_escan_complete().

Regards,
Arend



--000000000000304a3d060a4912f1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQdwYJKoZIhvcNAQcCoIIQaDCCEGQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3OMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVYwggQ+oAMCAQICDE79bW6SMzVJMuOi1zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMTQzMjNaFw0yNTA5MTAxMTQzMjNaMIGV
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEFyZW5kIFZhbiBTcHJpZWwxKzApBgkqhkiG
9w0BCQEWHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDxOB8Yu89pZLsG9Ic8ZY3uGibuv+NRsij+E70OMJQIwugrByyNq5xgH0BI22vJ
LT7VKCB6YJC88ewEFfYi3EKW/sn6RL16ImUM40beDmQ12WBquJRoxVNyoByNalmTOBNYR95ZQZJw
1nrzaoJtK0XIsv0dNCUcLlAc+jHkngD+I0ptVuWoMO1BcJexqJf5iX2M1CdC8PXTh9g4FIQnG2mc
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCEogqnRNtku8akJcOV
/BRcd3rq78aGvYQrQETNNY9fgTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzExMTYxODIwMTRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEA19NksM2NmnoLr4IsZ/H9fImc/Rt0qFiSWgWV
ent2bF4/d2zFgxIy3XAGKGvsMvTiE5mVAJHvPVaIugWAXbIJySQbihU6yD2Hrf1tNqD+s8WJykpz
lMZ4Jhw7rb+RNDUYoSmDZmhlhp2rVqpDoGV4C7f7aZGgtDnLbnMfGcEnbxbjfoDiwBxvebOAYK4Q
+frnM+Naidoc0wnnHPTy4S8n/CCN0n1KuXYMK94GoCfT0Op47+qxb4v+gtr9uacjtCh6h6843Nht
IMpHvvCO7rfVb3EVl92ZEOasbcWZ6HJdURrLu5ia0DWf3kx3D2pXpT8+PHTozLU+dJIPSh55t0Fr
gg==
--000000000000304a3d060a4912f1--
