Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280837C680E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbjJLInG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbjJLImq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:42:46 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF6F170E
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:41:38 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4181462ebf0so4716581cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697100098; x=1697704898; darn=vger.kernel.org;
        h=in-reply-to:subject:from:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a5AXzvkRhIgktf903821mHbiLvWilSfTnXHuU1DzCi4=;
        b=P3anZ1XmLn7mEnJt9DpTQEodvyJVHeAPLhJ0aT1OyCJUa68YlgCtQH3o3aw/yijrDS
         E7SPDLN6m0Xu+rrlh1bdmvMPUvE1cHAGQLNJF3xH5Y/xDAaxt1lyAqKvuYpnHTmAttSy
         lnoemRv5QbARc90gEjDA1q6LfmQJEl4A3qPmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697100098; x=1697704898;
        h=in-reply-to:subject:from:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5AXzvkRhIgktf903821mHbiLvWilSfTnXHuU1DzCi4=;
        b=WY3J/niuE840pRCyF1hZTMFi+NQb5zxO12HQMWzeslABoNUWQhy3UoXcqVO5meozqz
         SeT/uyXgbDW/OtpPCaDefCvDthEkeqE/y2STbzOzLRhY1Q1e5tIKm3ZXn687PmBnzHlz
         eel1rTq8V7TCOmgEBSUIBBjs6a0eJB0HtkRMCsZGjfRs/2yyelLPL6i2N9d4On0xAPTj
         Buo46aR+kag220l6HHEL/rgurxb2i0mhVLFMjGHPm3KdZXqQ7EcQRJZzOcnYAgH9TWsS
         3H4QpFAD4ceRJrYlRx8EGbmtDU7Sp12Kl13pE5FdMt0FyRy19mw4AsQRF5o2WBPGpK0G
         TMcw==
X-Gm-Message-State: AOJu0YxJb/qC+y4Wz82+dQ8LiHLaAOwzHVYC/ziZiN3S7rRPaGPCSJMQ
        b/3s44EIXYNv5qjajmxFz/zpKg==
X-Google-Smtp-Source: AGHT+IG/xYhMsoy2Od9DmHPQGXfMFZYYJ6Qkqyef4pRWNq8/5JRcYHp7P2ZEvP5E+5Sq1IwfOjhyJA==
X-Received: by 2002:a05:622a:20b:b0:412:2ed3:38ec with SMTP id b11-20020a05622a020b00b004122ed338ecmr25380586qtx.18.1697100097764;
        Thu, 12 Oct 2023 01:41:37 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id ci10-20020a05622a260a00b004109d386323sm6007061qtb.66.2023.10.12.01.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 01:41:36 -0700 (PDT)
Message-ID: <14ce82c5-f807-59bd-30ec-7eff5066e4f0@broadcom.com>
Date:   Thu, 12 Oct 2023 10:41:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To:     Hector Martin <marcan@marcan.st>, Kalle Valo <kvalo@kernel.org>,
        Neal Gompa <neal@gompa.dev>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        SHA-cyfmac-dev-list@infineon.com,
        brcm80211-dev-list.pdl@broadcom.com,
        Asahi Linux <asahi@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phil Elwell <phil@raspberrypi.org>
References: <6f78e624-62ee-3ae5-1db4-a0411566def8@yandex.ru>
 <CAGRGNgU7aySyUny9aG_+wXiKJ7j1weosa-rZDY4_WAXbq-3ABg@mail.gmail.com>
 <87ttr454bh.fsf@kernel.org> <3c5a3e7a-b332-4a77-51ba-bed3cad1e79f@marcan.st>
 <e1ee4d76-f717-a67c-8099-7b91192ba1ca@yandex.ru>
 <e470902a-35eb-9bb4-7a9e-167f985c98bb@marcan.st>
 <CAEg-Je-mpcrEoM_nD3_8A=gZhdWpn3hxfGZNEfGRNupGwRdetw@mail.gmail.com>
 <87edi14fvp.fsf@kernel.org> <cce5765d-342f-4811-ab7f-fb41ede0b3a1@marcan.st>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: On brcm80211 maintenance and support
In-Reply-To: <cce5765d-342f-4811-ab7f-fb41ede0b3a1@marcan.st>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007e63ad060780e811"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007e63ad060780e811
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/11/2023 1:28 PM, 'Hector Martin' via BRCM80211-DEV-LIST,PDL wrote:
> 
> 
> On 2023/10/11 19:23, Kalle Valo wrote:
>> Neal Gompa <neal@gompa.dev> writes:
>>
>>> On Sat, Oct 7, 2023 at 8:51 AM Hector Martin <marcan@marcan.st> wrote:
>>>
>>>>
>>>> On 07/10/2023 00.48, Dmitry Antipov wrote:
>>>>> On 10/6/23 18:34, Hector Martin wrote:
>>>>>
>>>>>> For better or worse, if nobody else does, I'm willing to sign up to
>>>>>> maintain the chips shipping on Apple ARM64 machines (i.e. BCM4378,
>>>>>> BCM4387, BCM4388 - that last one I have bringup for downstream, just got
>>>>>> it done this week) and partially BCM4377 as a bonus (since I have access
>>>>>> to an older Intel Mac with that one, and already did bringup for it,
>>>>>> though my access is sporadic). I'm already playing part time maintainer
>>>>>> anyway (other folks have already sent us patches I'll have to upstream),
>>>>>> and we need this driver to keep working and continue to support new chips.
>>>>>
>>>>> Good news. Would you capable to consider some generic (not hooked to any
>>>>> particular hardware) things like [1] ?
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/linux-wireless/20230703162458.155942-1-dmantipov@yandex.ru/
>>>>>
>>>>
>>>> Sure, I've done cleanup type stuff myself too.
>>>>
>>>
>>> Can we please get this done so that the pile of Broadcom patches can
>>> actually start landing again? It's been frustrating watching patch
>>> submissions be ignored for over a year now. At least add Hector as a
>>> co-maintainer and allow him to land stuff people have been using
>>> outside to get Broadcom Wi-Fi to *work*.
>>>
>>> Having stuff sit on the pile and be *ignored* is frustrating for
>>> contributors and users, and massively disincentivizes people from
>>> working in upstream Linux.
>>
>> Your email reminds me of this comic:
>>
>> https://xkcd.com/2347/
>>
>> In the last few years we seem to be getting more of these "Work faster!"
>> emails and honestly it's getting frustrating for us maintainers. If
>> Linux wireless is important for you then help us! You can review
>> patches, run tests on real hardware, write hwsim test cases[1], fix
>> compiler warnings[2] etc. to help us maintainers and speed up
>> development. There's so much to do and while you gain experience on the
>> wireless development you can help even more.
>>
>> Also take it into account that it's not just simple to "take patches"
>> and be done with it. There are high quality requirements, the code needs
>> to have no compiler warnings and must not cause any regressions in
>> existing setups. That's not easy at all, especially as our hardware
>> testing is basically limited to few the most active drivers. And let
>> alone there are very exotic hardware out there and it's impossible to
>> test all of them.
> 
> I think we need to qualify this "no regressions" "rule". People regress
> our machines in mainline all the time. We catch it and get it fixed,
> sometimes in RCs, sometimes it goes all the way to stable and needs to
> get fixed there. We've had patches break everything from Bluetooth LE
> pairing to core memory management to the point we needed earlycon to
> diagnose it. That last one was a blatantly wrong patch to core Linux MM,
> it wasn't even something specific to our platform, but even that got
> past review (it just happened to break us specifically due to a
> coincidence).
> 
> The review process doesn't magically avoid regressing things. "No
> regressions" is impossible without someone actually testing things.
> Claiming otherwise is dishonest. So if I end up as maintainer here I
> certainly am not going to promise "no regressions" for chips I can't
> test, without someone interested in those chips testing them. Of course
> I'll take regression fixes when they do happen and someone notices, but
> I can't know in advance until someone does.

I do not think Kalle was claiming that. Regression will happen as it is 
simply not possible to verify each patch on all devices supported by the 
driver.

> Consider a patch that changes some codepath in the driver. I can't know
> whether the original logic was always broken, or whether it worked on
> some chips, and whether the new logic works on those chips or will
> regress them, without testing. This is a regular occurrence with
> brcmfmac, due to the complexity and variability of the firmware
> interface. Often multiple versions of stuff are supported, or some
> structures can be extended, but sometimes they can't. It's a mess, and
> without firmware source code nor any official specs, there is no way to
> know exactly what is intended and what the backwards compatibility
> requirements are.
> 
> The only way to avoid that is to gratuitously introduce version/chip
> gates for *every single change affecting behavior from the firmware
> POV*, which is a complete non-starter and would quickly yield a giant
> mess of spaghetti code. It's bad enough having to support explicit
> ABI-breaking changes in firmware, and having to deal with multiple
> versions of huge structures and convert between them. Trying to outright
> keep existing logic identical for "other chips" is just not going to
> happen, not without first having confirmation of what the requirements
> are from someone who has the required docs/source.

> I have a patch to enable WPA3 in Broadcom chipsets (yes, the driver is
> in such a sorry state it doesn't even support that yet). The current
> support attempt was added by a Cypress engineer and uses a completely
> different firmware mechanism. Is that supposed to actually work? Does it
> work currently? Is that the case for all Cypress firmwares? Or only
> some? Does the alternate mechanism we have for Broadcom chips work too?
> Only Cypress can answer those questions ahead of time, and they aren't
> (they ignored me last time I brought this up). So my current patch just
> replaces the mechanism with the known-working one for Broadcom chips.

This is mainly why I introduced the vendor-split concept so we can keep 
the Cypress mechanism and allow a different mechanism for Broadcom 
chips. The Cypress mechanism did not work for the Broadcom chips I have 
so I wanted to test it on the Cypress chips I got shipped long ago and 
they simply do not come up. Have not tried with RPi as it is not running 
vanilla kernel. Could try with a backports driver.

> Next time I send a bunch of our downstream patches, I'm going to resend
> that WPA3 patch. And if it regresses Cypress WPA3 support, tough luck.
> If someone catches it (Phil?) and it turns out the existing support is
> the only way to do things on Cypress, I'll rework the patch to
> conditionally support both styles. But if nobody does, and nobody cares,
> then I'm sorry if I regress things, but there is no way to avoid it. We
> can't be gratuitously gating every single change just to hope to avoid
> regressions, without any confirmation of what is required. That just
> doesn't scale.

The "no regressions" rule is an important one throughout the kernel. 
Trying to avoid it makes sense, but I have to agree that for brcmfmac 
there is not enough coverage to give any guarantee. As long you are 
prepared to fix things when a regression report comes in that should be 
fine depending on how often there is a need to revert/fix things as it 
can disrupt the normal flow of patches.

Regards,
Arend

--0000000000007e63ad060780e811
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBKVKawcIVpAXcoteLc
JWKsbeIxWjhycsDZmgsvKFnttTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzEwMTIwODQxMzhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAvtgRbrUwVVSETMGBEa0J/kefqr4zZ2butIQ1
uRuwg5saH2KyHgfemXDbINFjq5YriJko+wx1XjlQgnHVuzaqoTlYLjcTh25fc9AlS2PIXC8SWuWa
vAPQIrNHTOzoM3K5+JRpWeHxr/nqv2u8k6dHVeoH25rE0fe9ms1FCLR2D1cVCMHVeL0z+wd6YruL
gp5utB9hmgN2Xo+lbAIKVh0Z3oU26eTLpKUl7jAzog/6m4N9TwScftqiC5/F7UOXmVg33IhvXi7I
OxZwGuJN5TO3p502pUU3fbIx9JXeL0JjZdpMobSwbDfn5jVfP0v2cB8lD/QLzZgsSw79qpE4SiMu
0A==
--0000000000007e63ad060780e811--
