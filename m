Return-Path: <linux-kernel+bounces-8167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B19781B2FE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FAF71C238D2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACC54D593;
	Thu, 21 Dec 2023 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C6mSVE0X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331214D139
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d3dfcc1a4so3735625e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 01:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703152662; x=1703757462; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:references:cc:to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8Z3UY1BLe+t4pqyWo+mYhUp86dVOGFhMJqE0u0yRjw=;
        b=C6mSVE0X0MCC4FU8IJ/kEQXBy6HkekedPnnuCqQDJomlpFP7MguSp7OjEIjgpeQJVO
         ttYPdkdgfgm/zfHJmXr5G/p+rQa93BtPef2F3cyClWtP8veigxScpWq8t07AifAIDGFV
         nbb6OddstQ/DLtTQ274MzzybG+w0AHMbun9Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703152662; x=1703757462;
        h=in-reply-to:autocrypt:references:cc:to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x8Z3UY1BLe+t4pqyWo+mYhUp86dVOGFhMJqE0u0yRjw=;
        b=LXTK7/X9kFizPNTARml6nnyEMjohtoAWU7/mhhshQ82qgTGOOAReMEG4U0Ogg+U0v1
         VhTP3kSuRLwJBuJecfMxMWC/SgECWrdi88KwGsqvnivWutNYksrjqVEjTq8nmtoywTZp
         nVUNkbt/HYRVs5JD6wwuK2hM7gbcZFzCQ+Psj7oXkpScJVqJ6ClH8CL+0830x18hfD2z
         stYebzgO+6hZ3mnsedA8LLqzr37cHJXCuYusYVK/LNOolA7WX1W2L8bxvxn1jo2Kikpg
         WV34dOhTRpm8Epoxr99XaEg3D32Zf0QxjZ8AWwdO0qa+DB13wpvYIXLLnsELZtea4OL5
         ed3A==
X-Gm-Message-State: AOJu0Yzftb7SiW+you46Sp9WzPRxYCSWPBkDhsGuN4T5wf+YGrPiRBbj
	5GGDogUeqK/yzAXEAkKQ7iV+eA==
X-Google-Smtp-Source: AGHT+IHnFyvKpxTlgrFjID1b6h1zu8Yb0SgU+JIt4HhycaslMcbNSGmdtil+RBccLpWBVJtt0Ssddg==
X-Received: by 2002:a05:600c:141:b0:40d:4156:b6d4 with SMTP id w1-20020a05600c014100b0040d4156b6d4mr48355wmm.160.1703152662397;
        Thu, 21 Dec 2023 01:57:42 -0800 (PST)
Received: from [10.230.42.27] ([192.19.152.250])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d4744000000b003365e685102sm1629739wrs.29.2023.12.21.01.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 01:57:41 -0800 (PST)
Message-ID: <31292508-f881-4457-a4bf-2ca0b8e8f435@broadcom.com>
Date: Thu, 21 Dec 2023 10:57:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
To: Hector Martin <marcan@marcan.st>, Kalle Valo <kvalo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Berlin <dberlin@dberlin.org>, Arend van Spriel
 <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>, asahi@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, David Airlie <airlied@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
 <170281231651.2255653.7498073085103487666.kvalo@kernel.org>
 <18c80d15e30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <1b51997f-2994-46e8-ac58-90106d1c486d@marcan.st>
 <c392f901-789a-42e2-8cf7-5e246365a1ca@broadcom.com>
 <CAF4BwTXNtu30DAgBXo4auDaDK0iWc9Ch8f=EH+facQ-_F-oMUQ@mail.gmail.com>
 <87r0jiqmnx.fsf@kernel.org> <01bd8c68-1b9c-49b2-8ace-1c7d1b5192ad@marcan.st>
 <CAHk-=whDLKZZEuxU_jEhZRdeWjXAkL8=J_JRk2Ar6wp9UK3h2w@mail.gmail.com>
 <871qbhqio8.fsf@kernel.org> <4c89b71e-8667-40fe-add0-205748de51ef@marcan.st>
 <bdb078c0-2f45-485a-86a0-bb7d0b5e3516@broadcom.com>
 <d5e26dd4-483d-4662-ba83-5cb19187b24a@marcan.st>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <d5e26dd4-483d-4662-ba83-5cb19187b24a@marcan.st>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000076d1c4060d0221d1"

--00000000000076d1c4060d0221d1
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

- SHA-cyfmac-dev-list@infineon.com

On 12/21/2023 1:49 AM, Hector Martin wrote:
> 
> 
> On 2023/12/21 4:36, Arend van Spriel wrote:
>> On 12/20/2023 7:14 PM, Hector Martin wrote:
>>>
>>>
>>> On 2023/12/20 19:20, Kalle Valo wrote:
>>>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>>>
>>>>>> Just recently a patch was posted to remove the Infineon list from
>>>>>> MAINTAINERS because that company cares so little they have literally
>>>>>> stopped accepting emails from us. Meanwhile they are telling their
>>>>>> customers that they do not recommend upstream brcmfmac and they should
>>>>>> use their downstream driver [1].
>>>>>
>>>>> Unquestionably broadcom is not helping maintain things, and I think it
>>>>> should matter.
>>>>>
>>>>> As Hector says, they point to their random driver dumps on their site
>>>>> that you can't even download unless you are a "Broadcom community
>>>>> member" or whatever, and hey - any company that works that way should
>>>>> be seen as pretty much hostile to any actual maintenance and proper
>>>>> development.
>>>>
>>>> Sadly this is the normal in the wireless world. All vendors focus on the
>>>> latest generation, currently it's Wi-Fi 7, and lose interest on older
>>>> generations. And vendors lose focus on the upstream drivers even faster,
>>>> usually after a customer project ends.
>>>>
>>>> So in practise what we try to do is keep the drivers working somehow on
>>>> our own, even after the vendors are long gone. If we would deliberately
>>>> allow breaking drivers because vendor/corporations don't support us, I
>>>> suspect we would have sevaral broken drivers in upstream.
>>>>
>>>>> If Daniel and Hector are responsive to actual problem reports for the
>>>>> changes they cause, I do think that should count a lot.
>>>>
>>>> Sure, but they could also respect to the review comments. I find Arend's
>>>> proposal is reasonable and that's what I would implement in v2. We
>>>> (linux-wireless) make abstractions to workaround firmware problems or
>>>> interface conflicts all the time, just look at ath10k for example. I
>>>> would not be surprised if we need to add even more abstractions to
>>>> brcmfmac in the future. And Arend is the expert here, he has best
>>>> knowledge of Broadcom devices and I trust him.
>>>>
>>>> Has anyone even investigated what it would need to implement Arend's
>>>> proposal? At least I don't see any indication of that.
>>>
>>> Of course we can implement it (and we will as we actually got a report
>>> of this patch breaking Cypress now, finally).
>>>
>>> The question was never whether it could be done, we're already doing a
>>> bunch of abstractions to deal with just the Broadcom-only side of things
>>> too. The point I was trying to make is that we need to *know* what
>>> firmware abstractions we need and *why* they are needed. We can't just
>>> say, for every change, "well, nobody knows if the existing code works or
>>> not, so let's just add an abstraction just in case the change breaks
>>> something". As far as anyone involved in the discussions until now could
>>> tell, this code was just something some Cypress person dumped upstream,
>>> and nobody involved was being responsive to any of our inquiries, so
>>> there was no way to be certain it worked at all, whether it was
>>> supported in public firmware, or anything else.
>>>
>>> *Now* that we know the existing code is actually functional and not just
>>> dead/broken, and that the WSEC approach is conversely not functional on
>>> the Cypress firmwares, it makes sense to introduce an abstraction.
>>
>> Just a quick look in the git history could have told you that it was not
>> just dumped upstream and at least one person was using it and extended
>> it for 802.11r support (fast-roaming):
>>
>>
>> author	Paweł Drewniak <czajernia@gmail.com>	2021-08-24 23:13:30 +0100
>> committer	Kalle Valo <kvalo@codeaurora.org>	2021-08-29 11:33:07 +0300
>> commit	4b51de063d5310f1fb297388b7955926e63e45c9 (patch)
>> tree	ba2ccb5cbd055d482a8daa263f5e53531c07667f
>> /drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> parent	81f9ebd43659320a88cae8ed5124c50b4d47ab66 (diff)
>> download	wireless-4b51de063d5310f1fb297388b7955926e63e45c9.tar.gz
>> brcmfmac: Add WPA3 Personal with FT to supported cipher suites
>> This allows the driver to connect to BSSIDs supporting SAE with 802.11r.
>> Tested on Raspberry Pi 4 Model B (STA) and UniFi 6LR/OpenWRT 21.02.0-rc2.
>> AP was set to 'sae-mixed' (WPA2/3 Personal).
>>
>> Signed-off-by: Paweł Drewniak <czajernia@gmail.com>
>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>> Link: https://lore.kernel.org/r/20210824221330.3847139-1-czajernia@gmail.com
> 
> Sure, but we also had user reports of it *not* actually working (maybe
> it regressed?). We didn't know whether it was functional with the
> linux-firmware blobs in any way, I wanted confirmation of that. And we
> also didn't know that the patch *would* break it at all; perhaps the
> Cypress firmware had also grown support for the WSEC mechanism.
> 
> That's why I wanted someone to actually confirm the code worked (in some
> subset of cases) and the patch didn't, before starting to introduce
> conditionals. There is, of course, also the element that the Cypress
> side has been long unmaintained, and if nobody is testing/giving
> feedback/complaining, perhaps it's better to err on the side of maybe
> breaking something and see if that gets someone to come out of the
> woodwork if it really breaks, rather than tiptoeing around the code
> without knowing what's going on and without anyone actually testing things.

That is because you distrust the intent that Cypress was really 
contributing. They were and I trusted them to not just throw in a 
feature like WPA3. When Infineon took over they went mute. Upon 
reviewing your patch (again) I also sent an email to them asking 
specifically about the status of the sae_password interface. I did not 
use the mailing list which indeed bounces these days (hence removed 
them) but the last living soul that I had contact with about a year ago 
whether they were still comitted to be involved. I guess out of 
politeness or embarrassment I got confirmation they were and never heard 
from him again. The query about the sae_password interface is still pending.

> It's not about this *specific* patch, it's about the general situation
> of not being able to touch firmware interfaces "just in case Cypress
> breaks" being unsustainable in the long term. I wasn't pushing back
> because I think this particular one will be hard, I was pushing back
> because I can read the tea leaves and see this is not going to end well
> if it's the approach we start taking for everything. We *need* someone
> to be testing patches on Cypress, we can't just "try not to touch it"
> and cross our fingers. That just ends in disaster, we are not going to
> succeed in not breaking it either way and it's going to make the driver
> worse.

I admire you ability of reading tea leaves. You saw the Grim I reckon. 
Admittedly your responses on every comment from my side (or Kalle for 
that matter) was polarizing every discussion. That is common way people 
treat each other nowadays especially online where a conversation is just 
a pile of text going shit. It does not bring out the best in me either, 
but it was draining every ounce of energy from me so better end it by 
stepping out.

I added the ground work for multi-vendor support, but have not decided 
on the approach to take. Abstract per firmware interface primitive or 
simply have a cfg80211.c and fwil_types.h per vendor OR implement a 
vendor-specific cfg80211 callback and override the default callback 
during the driver attach, ie. in brcmf_fwvid_wcc_attach(). The latter 
duplicates things, but lean towards that as it may be easier on the 
long-term. What do your tea leaves tell you ;-)

Regards,
Arend


--00000000000076d1c4060d0221d1
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAhrkBS+9gXA2eNivyV
OZGQNuCB0+TkGa+NbN1OultHAjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzEyMjEwOTU3NDJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEA8FNjX8k6BL6yhhrWnNJlTrZzRvmucuAOf1gT
EFtP5wFUnrTedxwRZHYaD342TQLkcQWKyNB6mzFAPgovsOtXb5F9sQIVRcNeEqPytqhR1zfozvcp
FGgnmAIr/xgaEJSusc0W+i2Y9RTju9YhK5fPmK25pRGhRbkO/iGsZO6gN6xQM/3NavD4+7G4YzUb
W2rY5lXxEl501p2N+6CfDzw3XXub73RtWksGkwm+HdNcVa/n6U4sC0DXeH7LtJW0WWIz5B8u2jcI
DOvyIBstNcj9FbLXwCi8dwXy+hvmqNp/zbpwr6giOUKFu0FF3n/9G6Ii1A5LQ8tq3g6Xj4IzUY1t
Kg==
--00000000000076d1c4060d0221d1--

