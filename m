Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF42F7A23A1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjIOQbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbjIOQbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:31:10 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E61AC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:31:01 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-573249e73f8so1386089eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1694795461; x=1695400261; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8zW1uvOGtqvqh7qOFi217pWEIRVGtYIUXxk78m6XlA0=;
        b=FwpR4GfsoPHKYCXdf6IRbhS96ZB/GkIZaL39SGDeEVPdG7G9Z/tuPEdwIxx8womBYp
         JYsXkRb8bT7RxN94DmFfF7ctLy30VxMqQrWwpq3r0Fur7PvndQd8hRP2GTqJ17WHar5v
         k20cx9ywp5rWERkPYZ1to0f62z3YI6UiNY21w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694795461; x=1695400261;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zW1uvOGtqvqh7qOFi217pWEIRVGtYIUXxk78m6XlA0=;
        b=XDUzoAT2w9S0CmSC6bGzMfHh538mdMii/CWLxNrDDjuCBlDCaggPQEI/qI4FUlaFYz
         j4wZECbE9fLDxVvpa19latLHGEr5GavimqqER2msAayuMPzmJGSOm7Kuyv0kP3Qjt6hZ
         I4v0RXVd+H4sZghLTtd/qiBEDDUXmhpJEa6gsbAP4nGYEZ76S/waKYiojkrS5lCaApbt
         Ugm4zcTgMu+mcigupt647K2/S1gS5tnGbcpKhQ2L+kI10C41i997l7XWq6LgmHxvRIWh
         szvSzQlG/oKLzSUTqym8ChbrGpO0EhVZf34DY/xd5lczjRE818V9rzO2TdmfIFnZVYfS
         VAAQ==
X-Gm-Message-State: AOJu0YyDPIUKu+pikWpgG8Q91gJJ+UYOW2HyJOyrdZe4gmoprYXSYjwO
        usDqBPNm3tDDu/ZGl3maOtzRFA==
X-Google-Smtp-Source: AGHT+IH9f3ADCI/59RSTEiUOC9HhCU2jhg8ihwpIk9gmIuGtau7zFuA8Rg58crVle/qE5I9DWWauhw==
X-Received: by 2002:a05:6358:7249:b0:134:f28f:aa47 with SMTP id i9-20020a056358724900b00134f28faa47mr2905530rwa.23.1694795461046;
        Fri, 15 Sep 2023 09:31:01 -0700 (PDT)
Received: from [10.67.51.148] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y9-20020a0cd989000000b0063d2a70dff5sm1387579qvj.72.2023.09.15.09.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 09:31:00 -0700 (PDT)
Message-ID: <71ab660c-bee3-038f-665c-cda04f18cf6d@broadcom.com>
Date:   Fri, 15 Sep 2023 09:30:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 05/17] pmdomain: bcm: Move Kconfig options to the
 pmdomain subsystem
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-mips@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
References: <20230915092003.658361-1-ulf.hansson@linaro.org>
 <20230915092003.658361-6-ulf.hansson@linaro.org>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
In-Reply-To: <20230915092003.658361-6-ulf.hansson@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000716ed906056851ff"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000716ed906056851ff
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/23 02:19, Ulf Hansson wrote:
> The Kconfig options belongs closer to the corresponding implementations,
> hence let's move them from the soc subsystem to the pmdomain subsystem.
> 
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: <linux-mips@vger.kernel.org>
> Cc: <linux-rpi-kernel@lists.infradead.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/pmdomain/Kconfig     |  1 +
>   drivers/pmdomain/bcm/Kconfig | 46 ++++++++++++++++++++++++++++++++++++
>   drivers/soc/bcm/Kconfig      | 42 --------------------------------
>   3 files changed, 47 insertions(+), 42 deletions(-)
>   create mode 100644 drivers/pmdomain/bcm/Kconfig
> 
> diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
> index 482d9e970e14..ddc05d6af100 100644
> --- a/drivers/pmdomain/Kconfig
> +++ b/drivers/pmdomain/Kconfig
> @@ -4,5 +4,6 @@ menu "PM Domains"
>   source "drivers/pmdomain/actions/Kconfig"
>   source "drivers/pmdomain/amlogic/Kconfig"
>   source "drivers/pmdomain/apple/Kconfig"
> +source "drivers/pmdomain/bcm/Kconfig"
>   
>   endmenu
> diff --git a/drivers/pmdomain/bcm/Kconfig b/drivers/pmdomain/bcm/Kconfig
> new file mode 100644
> index 000000000000..9311e90b7707
> --- /dev/null
> +++ b/drivers/pmdomain/bcm/Kconfig
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menu "Broadcom PM Domains"
> +
> +config BCM2835_POWER
> +	bool "BCM2835 power domain driver"
> +	depends on ARCH_BCM2835 || (COMPILE_TEST && OF)
> +	default y if ARCH_BCM2835
> +	select PM_GENERIC_DOMAINS if PM
> +	select RESET_CONTROLLER
> +	help
> +	  This enables support for the BCM2835 power domains and reset
> +	  controller.  Any usage of power domains by the Raspberry Pi
> +	  firmware means that Linux usage of the same power domain
> +	  must be accessed using the RASPBERRYPI_POWER driver
> +
> +config RASPBERRYPI_POWER
> +	bool "Raspberry Pi power domain driver"
> +	depends on ARCH_BCM2835 || (COMPILE_TEST && OF)
> +	depends on RASPBERRYPI_FIRMWARE=y
> +	select PM_GENERIC_DOMAINS if PM
> +	help
> +	  This enables support for the RPi power domains which can be enabled
> +	  or disabled via the RPi firmware.
> +
> +config BCM_PMB
> +	bool "Broadcom PMB (Power Management Bus) driver"
> +	depends on ARCH_BCMBCA || (COMPILE_TEST && OF)
> +	default ARCH_BCMBCA
> +	select PM_GENERIC_DOMAINS if PM
> +	help
> +	  This enables support for the Broadcom's PMB (Power Management Bus) that
> +	  is used for disabling and enabling SoC devices.
> +
> +if SOC_BCM63XX
> +
> +config BCM63XX_POWER
> +	bool "BCM63xx power domain driver"
> +	depends on BMIPS_GENERIC || (COMPILE_TEST && OF)
> +	select PM_GENERIC_DOMAINS if PM
> +	help
> +	  This enables support for the BCM63xx power domains controller on
> +	  BCM6318, BCM6328, BCM6362 and BCM63268 SoCs.
> +
> +endif # SOC_BCM63XX

That is confusing, SOC_BCM63XX remains defined in 
drivers/soc/bcm/Kconfig, but we now made BCM63XX_POWER's visibility 
conditional upon a Kconfig symbol defined elsewhere, I would just drop 
the "if" condition completely.
-- 
Florian


--000000000000716ed906056851ff
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
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHMjXR1Mb7tkrghY
ifSmy9W60ovmR8CAnz8OdMRHYVlDMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMDkxNTE2MzEwMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDyWA17HJtEb5UqEon5RPKcLAmXcpGwUXDK
Y7AMPYwTdFy9U4bZjFNIYNQrViUKd4+JM8tWMcOA82I0bC6/TwQonm5keBC17RA54r86lXSdmGG0
vOZSMVH5KflygqfyTwn0Zj+Zp2U8aUZkq21GZ8tLokxUzXsqDEPYp9qvctXCsBN5Rnse8lZPRWZ6
i4e9FvqONeyebeeyQEByHAUdDrgu/x0Y3ne+rgGZP5F+fPXGkTnvpp3vuByjs38BHyhNRJsSebhy
uTOa4yVtKqTgRznhOYLVUElWzX9qZEq7PlOkeyasI2FywC6+8W6D+NYh7rBcgexdY05AKAL0wUoL
BATO
--000000000000716ed906056851ff--
