Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F8E7560A5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjGQKiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjGQKiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:38:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554B7E58
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:38:50 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbca8935bfso39176085e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1689590329; x=1692182329;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o4P8ScFmC1v2rvp9n8m+qdLl5zy9bTIMS2FhBW3YR1w=;
        b=Ov/yPZtmX3sDCmlSBfLn/fzk6BeDJJb/KFnept2CRoYdIVUtva7T0KgE5bWjeEwVbn
         XkpKJ6au0HUAV41OSNtdFfStrxnC4G6QsygrRpbhw0F+dbZVf4BAJZpexF++RKDodzf4
         S0Zdk2QD0I8Zs//s87dEGfnmoiRzKeeMAdlso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689590329; x=1692182329;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4P8ScFmC1v2rvp9n8m+qdLl5zy9bTIMS2FhBW3YR1w=;
        b=hR4BnWXLarrzxnL2yml0LLxj4q8enAkbG2KndvjZoXrmejtGOxIREQ8BckHPJvgfua
         0XzGaH8rUVpmsYiQcYRHcAtCiiV8KdTS9g+nmNCx8E0snku0fxhuwlg3I+cE/FZY2l8c
         NoOuD7nI5vM1e/C8Zm10adf7bifKd5qb8xVIoMNvUqjzWwZ4jCiX6ZHh24n3/CKVbJPZ
         RMCKS3f1pRKEXSH4PXoXo9m+h0C69wj/999reCbm7pzQ1plZx4bKPwqi/Y4sfCZIZx/3
         0WPObspRT05Qk1L/00zef0QgT75i+MEmhqwuL7Ki04D2lAVma6egaHzbPXh1DV05mx4U
         Xo1w==
X-Gm-Message-State: ABy/qLbMCOZ7Gq7Wx1H5QO4m9ww8bjv0wx3Af2r6ufiCsQz2ldUmiOlN
        WSDJcy+han3WiJq3cMJmF1V6ZqX4VFJmptUviSgnkg==
X-Google-Smtp-Source: APBJJlFvGZH2UKgn01U+O6JBIOc5bUKFCAp2LXtR1VegCqqrQ5i6JC/d1qWa9YMGTJLF/6S3r6Ba5A==
X-Received: by 2002:a05:600c:2247:b0:3fb:bc4a:46ad with SMTP id a7-20020a05600c224700b003fbbc4a46admr8890045wmm.9.1689590328735;
        Mon, 17 Jul 2023 03:38:48 -0700 (PDT)
Received: from [192.168.47.133] ([37.166.39.101])
        by smtp.gmail.com with ESMTPSA id k2-20020a7bc402000000b003fc02e8ea68sm7848680wmi.13.2023.07.17.03.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 03:38:47 -0700 (PDT)
Message-ID: <f214c0a0-c9f6-bfbb-3d75-2a2f7602083f@broadcom.com>
Date:   Mon, 17 Jul 2023 12:38:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Backporting commits for generating rpi dtb symbols to stable
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Greg KH <greg@kroah.com>
Cc:     Aurelien Jarno <aurelien@aurel32.net>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230716162444.zzvkm4rh7s7lu37x@pali>
 <2023071644-earflap-amazingly-3989@gregkh>
 <20230716163852.jnd4u4ylvifgmpby@pali>
 <2023071611-lustiness-rename-8b47@gregkh>
 <20230716195150.ppa6vdjogjevlzgq@pali>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
In-Reply-To: <20230716195150.ppa6vdjogjevlzgq@pali>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000061cc020600ac677c"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000061cc020600ac677c
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/16/2023 9:51 PM, Pali Rohár wrote:
> On Sunday 16 July 2023 21:08:38 Greg KH wrote:
>> On Sun, Jul 16, 2023 at 06:38:52PM +0200, Pali Rohár wrote:
>>> On Sunday 16 July 2023 18:32:42 Greg KH wrote:
>>>> On Sun, Jul 16, 2023 at 06:24:44PM +0200, Pali Rohár wrote:
>>>>> Hello,
>>>>>
>>>>> I see that raspberry pi bootloader throws ton of warnings when supplied
>>>>> DTB file does not contain /__symbols__/ node.
>>>>>
>>>>> On RPI 1B rev1 it looks like this:
>>>>>
>>>>> dterror: no symbols found
>>>>> dterror: no symbols found
>>>>> dterror: no symbols found
>>>>> dterror: no symbols found
>>>>> dterror: no symbols found
>>>>> dterror: no symbols found
>>>>> dterror: no symbols found
>>>>> dterror: no symbols found
>>>>> dterror: no symbols found
>>>>> dterror: no symbols found
>>>>>
>>>>> Bootloader also propagates these warnings to kernel via dtb property
>>>>> chosen/user-warnings and they can be read by simple command:
>>>>>
>>>>> $ cat /sys/firmware/devicetree/base/chosen/user-warnings
>>>>> ...
>>>>>
>>>>> Upstream Linux kernel build process by default does not generate
>>>>> /__symbols__/ node for DTB files, but DTB files provided by raspberrypi
>>>>> foundation have them for a longer time.
>>>>>
>>>>> I wanted to look at this issue, but I figured out that it is already
>>>>> solved by just recent Aurelien's patches:
>>>>>
>>>>> e925743edc0d ("arm: dts: bcm: Enable device-tree overlay support for RPi devices")
>>>>> 3cdba279c5e9 ("arm64: dts: broadcom: Enable device-tree overlay support for RPi devices")
>>>>>
>>>>> My testing showed that /__symbols__/ node is required by rpi bootloader
>>>>> for overlay support even when overlayed DTB file does not use any DTB
>>>>> symbol (and reference everything via full node path). So seems that
>>>>> /__symbols__/ node is crucial for rpi bootloader even when symbols from
>>>>> them are not used at all.
>>>>>
>>>>> So I would like to ask, would you consider backporting these two
>>>>> raspberry pi specific patches to stable kernel trees? Upstream kernel
>>>>> would get rid of those bootloader warnings and also allow users to use
>>>>> overlayed dtbs...
>>>>
>>>> What kernel tree(s) should these be applied to?  What trees did you test
>>>> them for?
>>>>
>>>> Also, adding dt-overlay support does not seem like a stable kernel fix,
>>>> as this isn't a bugfix from what I can tell, right?
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>
>>> I wanted to discuss what do you think about it. As I wrote my motivation
>>> was to understood and get rid of those warnings "dterror: no symbols
>>> found" from bootloader when using DTB files from mainline kernel (as
>>> opposite of the DTB files from rpi foundation). And fix for it was just
>>> to generate DTB files from kernel via dtc's -@ parameter, same what are
>>> doing those mentioned patches (but they describe different problem for
>>> which is same fix). I thought that fixing those bootloader warnings is a
>>> bugfix.
>>
>> Why not just use the next kernel version instead?  What's forcing you to
>> use an older stable kernel that didn't have dt-overlay support?
>>
>> thanks,
>>
>> greg k-h
> 
> Why not use the next kernel? It is pretty simple, next is the
> development tree, not for production.

Maybe "next" should have not been taken as designating linux-next, but 
whichever kernel version you are currently using wait for 6.5 final and 
use it since it does contains Aurelien's commits.

> And as I wrote in previous email,
> I do not need here dt-overlay support. I wanted to get rid off that
> warning messages.

The motivation does not seem appropriate to warrant a stable backport, 
besides as noted in the commit message including relocation information 
inflates the resulting .dtb files, which could be seen as a regression.
-- 
Florian

--00000000000061cc020600ac677c
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
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEukrdJ179pWGA+x
KZKG47bsapSLVHvesLQ2r9OZxOl2MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMDcxNzEwMzg0OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQALSuqLXy895kNwmxp2xJod++7sJEKo2qoL
UnIXcXgT0PDbBxF4S8jbAi/Il1H0tKcKzGEhjI99PLkK3Jmc8IJL0vqNmjMwjDyVCSs0IWU3U+No
16NmDDqhPGhNwu6yWa4eZlAV9zmhisOZvWJDqakLzfb1XSr/KpAIM5HZkSTg5DxXe2YWR4HItKvl
AXaI6upY1uoLZc8ceMxjvtk1PShj9z8hdFPe7JWIAiB5hpzJfPNareftKt2D4mcrspBh6Ybvug/O
RvvdQjdhcEjtln7oC7ny+BXsW7ANeebbEUc5rqfBc3YNdo/dPwOuadrPq5SdTUgchD8ttYriVKk1
Rnyw
--00000000000061cc020600ac677c--
