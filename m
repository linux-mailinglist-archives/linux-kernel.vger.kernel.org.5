Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1BF797C92
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbjIGTLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjIGTLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 15:11:31 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59249B2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 12:11:27 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76f036041b4so61585885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 12:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1694113886; x=1694718686; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rjoGSDU0/HooIcKb5DWZOmZKoG/hkvgFro126iNNvaA=;
        b=I4nrtKqtnPftGEAJzBX4ERa+QgUPrBjV7Y1bz8AnSVh7mS4mT5+eDpGb25Rf+fd74e
         ebzrI5MfhgTLKQZs4wlGEiq3kwbKj7zTvnbp4NMivpbsZLI+XVNJtNS8dgUWdRz1g7hW
         ey/xQx+BsXYRX7pHoObBxkymYACp4a2mGQCXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694113886; x=1694718686;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjoGSDU0/HooIcKb5DWZOmZKoG/hkvgFro126iNNvaA=;
        b=YyMLnumNA4YlRNqc8ZRgvAGFzvkPL/49/uxHKblTpnNQ8CDenbh0Jit8021Mb43j/M
         9T+xH4RFrRDqqKT3vGfwF6tQ1Qdi2iDhmz1Lr6yhr/OmGo/EMLGX0zrGpdluktymfLlw
         1ItXzLA94IQx8R7svzb1P+wzSpT3s1/Pa4r2Ij1T6TYSenpF9cdl4cm47tN97Wr+S7H+
         mgbZhKlYftYW11vuowlGowdbJp8FhYLI5JpfWtzcTNo+gUOAeeF6Tne5gGKVQOBJBwRB
         PslUICANDBPiJvnIKKBlie9gpvodm+a7bZJF2LEtRHQNuypRJoJjsI7k0KGiR7dQb3GE
         Mynw==
X-Gm-Message-State: AOJu0Yz2FxTvD8weud74Z+4Ne/eQ5PZQt4zgtqNNWB2n7fx4SJO2823e
        l1B+p/BwfxYi9sZvXHgtzgfImg==
X-Google-Smtp-Source: AGHT+IGsnexiADxfZqGI0OoNyfKXgYD37pYBMbQY8GgZl19SxSU7tdJPJpf3ds+A6F89QJyXFZ66tw==
X-Received: by 2002:a05:620a:2407:b0:76e:ea58:3c2 with SMTP id d7-20020a05620a240700b0076eea5803c2mr5111632qkn.33.1694113886360;
        Thu, 07 Sep 2023 12:11:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x26-20020ae9e91a000000b0076f0edac509sm5987527qkf.90.2023.09.07.12.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 12:11:25 -0700 (PDT)
Message-ID: <2e7eb584-1aca-7529-af2f-62e388fe2c8a@broadcom.com>
Date:   Thu, 7 Sep 2023 12:11:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: s2idle breaks on machines without cpuidle support
To:     Hector Martin <marcan@marcan.st>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Kazuki <kazukih0205@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
References: <20230204152747.drte4uitljzngdt6@kazuki-mac>
 <20230206101239.dret3fv65cnzpken@bogus>
 <20230207194818.exskn3dhyzqwr32v@kazuki-mac>
 <20230208103511.w7jzxw6spy6humdn@bogus>
 <5f741a4f-f37d-079b-d464-59045ebef1ce@marcan.st>
 <20230208161805.2dlx66oxphl25p3c@bogus>
 <e069e779-3943-0f9a-6592-5b096a2a8076@marcan.st>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
In-Reply-To: <e069e779-3943-0f9a-6592-5b096a2a8076@marcan.st>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006d1dd10604c9a018"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006d1dd10604c9a018
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/23 08:45, Hector Martin wrote:
> On 09/02/2023 01.18, Sudeep Holla wrote:
>> On Thu, Feb 09, 2023 at 12:42:17AM +0900, Hector Martin wrote:
>>> On 08/02/2023 19.35, Sudeep Holla wrote:
>>>> On Wed, Feb 08, 2023 at 04:48:18AM +0900, Kazuki wrote:
>>>>> On Mon, Feb 06, 2023 at 10:12:39AM +0000, Sudeep Holla wrote:
>>>>>>
>>>>>> What do you mean by break ? More details on the observation would be helpful.
>>>>> For example, CLOCK_MONOTONIC doesn't stop even after suspend since
>>>>> these chain of commands don't get called.
>>>>>
>>>>> call_cpuidle_s2idle->cpuidle_enter_s2idle->enter_s2idle_proper->tick_freeze->sched_clock_suspend (Function that pauses CLOCK_MONOTONIC)
>>>>>
>>>>> Which in turn causes programs like systemd to crash since it doesn't
>>>>> expect this.
>>>>
>>>> Yes expected IIUC. The per-cpu timers and counters continue to tick in
>>>> WFI and hence CLOCK_MONOTONIC can't stop.
>>>
>>> The hardware counters would also keep ticking in "real" s2idle (with
>>> hypothetical PSCI idle support) and often in full suspend. There is a
>>> flag for this (CLOCK_SOURCE_SUSPEND_NONSTOP) that is set by default for
>>> ARM. So this isn't why CLOCK_MONOTONIC isn't stopping; there is
>>> machinery to make the kernel's view of time stop anyway, it's just not
>>> being invoked here.
>>>
>>
>> Indeed, and I assumed s2idle was designed with those requirements but I
>> think I may be wrong especially looking at few points you have raised
>> provide my understanding is aligned with yours.
>>
>>> This is somewhat orthogonal to the issue of PSCI. These machines can't
>>> physically support PSCI and KVM at the same time (they do not have EL3),
>>> so PSCI is not an option. We will be starting a conversation about how
>>> to provide something "like" PSCI over some other sort of transport to
>>> solve this soon. So that will "fix" this issue once it's all implemented.
>>>
>>
>> All the best for the efforts.
>>
>>> However, these machines aren't the only ones without PSCI (search for
>>> "spin-table" in arch/arm64/boot/dts, this isn't new and these aren't the
>>> first).
>>
>> Yes I am aware of it and if you see arch/arm64/kernel/smp_spin_table.c
>> we don't support CPU hotplug or suspend for such a system.
> 
> We certainly support s2idle, except it's kind of broken as stated. Try
> it, it works :-)
> 
> I didn't do anything special to enable s2idle on Apple platforms other
> than make sure random drivers weren't broken and there was at least one
> driver capable of triggering a wakeup. I just compile with
> CONFIG_SUSPEND and s2idle works. Except for the part where
> CLOCK_MONOTONIC keeps running. So generic kernels on spin_table
> platforms ought to expose (broken) s2idle by default already.
> 
>>> It seems broken that Linux currently implements s2idle in such a
>>> way that it violates the userspace clock behavior contract on systems
>>> without a cpuidle driver (and does so silently, to make it worse).
>>
>> Just to check if I understand this correctly, are you referring to:
>> cpuidle_idle_call()->default_idle_call() if cpuidle_not_available()
>> And the problem is it idles there in wfi but CLOCK_MONOTONIC isn't
>> stopping as expected by the userspace ? If so, fair enough. If not, I
>> may be missing to understand something.
> 
> Right. I'm not too certain on the details of exactly what suspend
> machinery is running/supposed to, because this CLOCK_MONOTONIC issue was
> a surprise to me when it came up. From my point of view s2idle "just
> worked", it's only now that this has come up that we're realizing it's
> winding up in a very different codepath to what would happen were
> cpuidle/PSCI available. This was all silent from the user POV (it all
> looks like it suspends/resumes normally as far as I can tell).
> 
>>> So that should be fixed regardless of whether we end up coming up with a
>>> PSCI alternative or not for these platforms.
>>
>> If above understanding is correct, I agree. But not sure what was the
>> motivation behind the current behaviour.
>>
>>> There's no fundamental reason why s2idle can't work properly with plain WFI.
>>>
>>
>> Fair enough. I hadn't thought much of it before as most of the platforms
>> I have seen or used have at-least one deeper than WFI state these days.
>> On arm32, this was common but each platform managed suspend_set_ops
>> on its own and probably can do the same s2idle_set_ops.
> 
> Yeah, we do have one deeper idle state (and we should figure out how to
> implement a PSCI alternative to enable it soon, since in particular for
> certain SoCs plain WFI is quite a power hog since it keeps all the core
> clusters powered up and at least partially clocked). But since we don't
> have that yet, we've been using WFI-only s2idle so users have *some*
> suspend ability.

Same here. I would caution against assuming that a cpuidle driver is 
always available. There are tons of systems out there that only support 
WFI as their idle state and in that case there is no backing cpuidle 
driver either, that is cpuidle_not_available() returns false. There were 
also report on x86 where PSCI is not available:

https://github.com/systemd/systemd/issues/9538
https://bugzilla.kernel.org/show_bug.cgi?id=200595

Having recently been affected in the same way by this bug, it would be 
nice if we could do something about it. I tried to do the following:

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 3f8c7867c14c..d021f6ceb352 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -90,9 +90,11 @@ void __cpuidle default_idle_call(void)
         if (current_clr_polling_and_test()) {
                 local_irq_enable();
         } else {
+               RCU_NONIDLE(tick_freeze());
                 stop_critical_timings();
                 arch_cpu_idle();
                 start_critical_timings();
+               RCU_NONIDLE(tick_unfreeze());
         }
  }

but this is not quite working and I am getting tons of warnings from 
ktime_get_seconds() early on boot.

Is there a point at which it is safe to call tick_freeze() and 
tick_unfreeze()? It is not obvious to me how cpuidle goes about not 
hitting those same warnings, short of being initialized later.

Thanks!
-- 
Florian


--0000000000006d1dd10604c9a018
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
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICXBEpJMLbWs/mC9
O6yST6XiuGs3t880snr08aiv9VkFMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMDkwNzE5MTEyNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAhuw6iY18f5KeuwGo8Ai0s750IzPSPcTWN
RnhkhKZyxDs2lDpzLenctXg8e3zOIqkFWJC0UcG8rCrFZp9ADDXdUayKtW8ZfgiE6H1xJZSvCJuM
RnTqgUWOSrlHmLwIgK8R2YUXOFwxQrWLL9W5jyQAxsHj92UvniJwnn5TWFzvrSCx42MQA/ZqbcrM
akpkgb4DjjsagXxiRbOvsdhoYKJa10EAvmH7ICybRExFpqWIj/s1wVg/i2J3zSQGXitnDv8HzJvo
uJ+JsnpjU1wRdgovQW8WMe6QTOBBSeE3DxaJcgBUNjnnB0XRFXhsxqp+P3lZOr2c5QKM8rAeUE4F
7hvK
--0000000000006d1dd10604c9a018--
