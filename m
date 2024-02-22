Return-Path: <linux-kernel+bounces-77291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C506F86034D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79AF828641C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BAA6E5F0;
	Thu, 22 Feb 2024 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QrQsRDCO"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830766E5E7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708631698; cv=none; b=dqOAnnDjK3MMV3gu7wDEGubeuOB1WklYRqOXdoOEnPzkZQ3twXKjGHiQ4MSX7EF/4p9ogockuiTJ9aPtpYWyjSiSmpmvi3QEKVJGI6yzQXaQY4Xyyuo5+GyR5CiukD6qcBrxsEJjMYZepdoRmNXxOwtf0XZjZrVsXbY8AWNKBsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708631698; c=relaxed/simple;
	bh=Cj4A0XNfpP/jcdIBJaF0khL5gYRSn6hfCTNH4xvBa5M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XYy6bb3mqnPo+t4pShJxwzdfCJmm1crMK4CqaCBHPDeHdhNdGp09bMjH0B7MH8Cs8am4M5IfLHHrF99wkz/RIH/2i3ejiroUVye0x8wy8mxNGo9d7Qq1yUq8741o80Ql4/Xs1m+b6earFwv3W+cSdVWaQBVeJQCbq2IFuIx8EgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QrQsRDCO; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-787a43e2e2dso5764985a.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1708631695; x=1709236495; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zaO4HntQYuGi4xB0LXDRxDw9ZCKSDVIF/cYsHdaQbM=;
        b=QrQsRDCOluaz2Y8aIl9wpB6mXt7FCR/hpRhtl+ragUH73elFnv+LkLPkj9mPkcyKHG
         00pUuEgEczi2MjJzwr0FD0VQB2JbxqOgv/YwYoBcTzijxaZoC7m9EjtnXhSh6RyPWsVx
         iconhueuekEve09iYq4OcveFLYxdbZlfj25ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708631695; x=1709236495;
        h=in-reply-to:autocrypt:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/zaO4HntQYuGi4xB0LXDRxDw9ZCKSDVIF/cYsHdaQbM=;
        b=a/ihpvio0vNrBQ4i824zaVpH1LkT5D7PcFDn/hiPbmrcqBoi3K/vMxwG5/6j2TWKD7
         pzUn8mAOUXCt9ERJfjd660ZgPdJCOcH15eKsbzF7ojuvW+iCo31Fpq8ByiKjCP87vqfn
         kKkSpdXubCtGIqfKI9vsCY7eTtxrPlJ+UXtDXef4B0PLz/+TFe0RDXB+fEcZ++Q3yTMJ
         te6PdrAlR8Xrj2uonNrQZ9U9ECM4Dif5AmYnOP/5sryNwN6bhxufII76isemEKi37JNd
         z8gMV/ACZBuvjuN4lxJmHk6hRSy0Y/YMqySBm+F9KQBt+g1k1Yomufl4z7sRRYCx2v3m
         OZ+w==
X-Forwarded-Encrypted: i=1; AJvYcCW4t8+hlZKhYdarMXemlkx0DxCSZ0dHyyjgYC6rwn/OPivkvYInVYPc3FfxrNDEGpfoVrB8D1nwFUgi+oq1JQSgcs82NhZzIUxNIkxy
X-Gm-Message-State: AOJu0YwJlvUt1tN35KwRLzx2sBk7GwdF2dK0PGIQ2LaUzFbnMWVwF1E1
	+ZD2OBEvbWl2VnU6X3mHnwNto2Wj7+ioz2NUk0bY5ujkRt6MBjvoCM4367q7GA==
X-Google-Smtp-Source: AGHT+IG+02QW+qSSWAfjP4Uo/K7FcJoXi4dz8dc67dCLdJEgoxZW8p1RnFAR5+Smi7h+fcujupYPHw==
X-Received: by 2002:a05:620a:1124:b0:787:1571:1ff8 with SMTP id p4-20020a05620a112400b0078715711ff8mr47062qkk.53.1708631695360;
        Thu, 22 Feb 2024 11:54:55 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bl5-20020a05620a1a8500b007879e6fea9fsm892629qkb.14.2024.02.22.11.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 11:54:52 -0800 (PST)
Message-ID: <ad91eec0-39da-4b9c-8da7-f1e98bb4565b@broadcom.com>
Date: Thu, 22 Feb 2024 11:54:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/14] serial: 8250_of: Switch to use
 uart_read_port_properties()
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-tegra@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Paul Cercueil <paul@crapouillou.net>, Vladimir Zapolskiy <vz@mleia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andi Shyti <andi.shyti@linux.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-11-andriy.shevchenko@linux.intel.com>
 <0a828f2c50de712940fb9a881702ac1678a35b7c.camel@codeconstruct.com.au>
 <ZddKzHplwOX7naLv@smile.fi.intel.com> <Zdd5m2xIPlGI0_Qv@smile.fi.intel.com>
 <Zdd6lnXwvpPPUhRR@smile.fi.intel.com>
 <e5fd9d8b-84eb-4ef9-82ab-ff4ecc41c0d5@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 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
In-Reply-To: <e5fd9d8b-84eb-4ef9-82ab-ff4ecc41c0d5@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000466c550611fdd1d9"

--000000000000466c550611fdd1d9
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/22/24 09:39, Florian Fainelli wrote:
> On 2/22/24 08:47, Andy Shevchenko wrote:
>> On Thu, Feb 22, 2024 at 06:43:08PM +0200, Andy Shevchenko wrote:
>>> On Thu, Feb 22, 2024 at 03:23:24PM +0200, Andy Shevchenko wrote:
>>>> On Thu, Feb 22, 2024 at 11:07:05AM +1030, Andrew Jeffery wrote:
>>>>> On Wed, 2024-02-21 at 20:31 +0200, Andy Shevchenko wrote:
>>>>>> Since we have now a common helper to read port properties
>>>>>> use it instead of sparse home grown solution.
>>>>>
>>>>> I did some brief testing of the series for the Aspeed machines under
>>>>> qemu, building them on top of v6.8-rc5:
>>>>>
>>>>> export ARCH=arm
>>>>> export CROSS_COMPILE=arm-linux-gnueabihf-
>>>>> make aspeed_g5_defconfig
>>>>> make -j$(nproc)
>>>>> qemu-system-arm -M rainier-bmc -nographic -no-reboot -kernel 
>>>>> arch/arm/boot/zImage -dtb 
>>>>> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb -initrd ...
>>>>>
>>>>> I got an oops during boot, which bisected to this change:
>>>>
>>>> Thank you for prompt testing! I will look at it.
>>>
>>> I found the issue, will be fixed in next version.
>>
>> Whoever is going to test this series, the
>>
>> -        port->iotype = use_defaults ? UPIO_MEM : port->iotype;
>> +        port->iotype = UPIO_MEM;
>>
>> should be applied to uart_read_port_properties() implementation.
>>
> 
> Thanks, on 8250_bcm7271.c with the above hunk applied, I did not spot 
> any differences between the values returned by stty or a cat 
> /sys/class/tty/ttyS0/* before or after, the console remained fully 
> functional. I will see if I can run an additional test where I removed 
> the DT's "clocks" property and confirm that the fall back to 
> "clock-frequency" works.
> 
> Thanks Andy!

Also appears to work properly on a Raspberry Pi 4 with the console using 
the bcm2835-aux driver, will provide Tested-by tags on the next 
submission, thanks!
-- 
Florian


--000000000000466c550611fdd1d9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQeQYJKoZIhvcNAQcCoIIQajCCEGYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3QMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIrCd38u/oVscFAk
fpw+Yp/ecbqnJ7cSOMWoDk2QBR7jMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MDIyMjE5NTQ1NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAT7pkvO4yFP+2tyXNfIDklnHDJSIXVP9U8
9s8a5pzyL0iXM+bVInLBMsNX4O1oD6vpi5LC82oJxc6VMTab+H/AtSvLYg/Ydot62HUXUX+Epuyp
caucTG4rQNl6lJlq1U9bfHIw6rOojpmG/KjnGGPIVvd4H7ZuD3WWXXy92t4MezuVQm2j5WW0dBM/
lJEX51xnPcP3Dq9ZE3Sg84vlHh1UMEk4WlZ+uKS4K95m5qubao+XuhT+TAl7RVnQq3bkJMyAK0FY
8pGd8NksNWE7iknQOxkl2B9lOBE5JenTOkkpn2FlGWjcVp0A1JMnx3pJTd1enOch9hKM/QMrX8Os
AOo8
--000000000000466c550611fdd1d9--

