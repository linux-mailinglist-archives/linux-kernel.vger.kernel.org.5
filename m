Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756B579D631
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjILQYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbjILQX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:23:58 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4454F10EB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:23:54 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-414f0b707d5so121cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694535833; x=1695140633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N+ugFgOb5iS2vOO7DahZWqOi4I/gSUmJb5jnpjTlaDk=;
        b=p2OD/8DBtrf9InTP8QjeMInf6vuOGmkKpLtTGUER3ChxofUDqqUJe3xbwNk8ObjEv3
         nY36eO4sG2lp63UAuofwJO4dAfI2qqdCoAyA5FwV9tOgMdMowe52Qg7yHVSvSCM3V2WA
         +q8yTrHWN9w66TDiQG9k7njHqPPZnmS9o5zoe1RsYQgvmcvp92moZ3qsNANmb9616fpG
         Q9NlDrO0JxLRHcAgRKFfPwrpput908fl+UFh0ctheRPWMRfjgi54Oa5YvNMoR7zlpBSi
         3g9CIJMo8ZafBlxL9dyXu8HfWvR+2Q0dEqFudw1MJNc8GbseFxTzOtkHcubHXrEeCIhI
         6OLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694535833; x=1695140633;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+ugFgOb5iS2vOO7DahZWqOi4I/gSUmJb5jnpjTlaDk=;
        b=HkpHunE+ockOjF2AgnD13W4snDlZLtJ8D2A8B+EA24Rz0T2Z0TExzzEtEo5fwXfe4T
         AumyHNxSWztMyyyqT50jUJdUfP7LQlbySs6xpigWb0OqKqYndyWtafXm8C7c59wNGkKY
         XMcrBiqTr0UXtb6A8k+2jNYZPlvYyJoezCaBGA9r7yFbbVHQkQM4YYsGakc11QhL/zaM
         8VyZoRyfpsJYtLAr7iz/oATs2km+mO44iCP260r0kif8mfsa0cejBEXtbrj6NLmJ1ADy
         CzEXClByUCh5Y+nZ17caWc26rjXpGlgI/XDiG8zPvbhTSc5Itq1RxmpI17/ieTjJST7G
         Ts6w==
X-Gm-Message-State: AOJu0YzWD+dWS5J8tPOgu+lm3dKLxML5LyIilH0vbyRy/OMB66B4tWRV
        fHMNDI40q9dHp+cZ9ml2eSBxDOXCC6bS/GGoMBjK
X-Google-Smtp-Source: AGHT+IGZKq1neVdPa5doNGKg4ZeW48OcCeQNtBQcguqv/oZA7QzGQDO5RyH2blcv1AqWSyJKVDQlyqsbKQeiYJ53mNw=
X-Received: by 2002:ac8:6b04:0:b0:405:4662:d1b6 with SMTP id
 w4-20020ac86b04000000b004054662d1b6mr729qts.0.1694535832436; Tue, 12 Sep 2023
 09:23:52 -0700 (PDT)
MIME-Version: 1.0
From:   Joshua Pius <joshuapius@google.com>
Date:   Tue, 12 Sep 2023 12:23:14 -0400
Message-ID: <CAFs7P=hZVfUnTKYgOUwfwT6S9TO72iuJMBPbBG0i+U-4Au=O=Q@mail.gmail.com>
Subject: Re: [v3] drm/i915/display/lspcon: Increase LSPCON mode settle timeout
To:     Ankit K Nautiyal <ankit.k.nautiyal@intel.com>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Pablo Ceballos <pceballos@google.com>,
        Niko Tsirakis <ntsirakis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, we've proposed this change before. The reasoning is still the
same. Added below to include in this thread as well. Is there a reason
the below explanation and test is not sufficient?

This issue affected several different CometLake-based Chrome OS device
designs. The details of the original report are in the Google partner
issue tracker (issue # 178169843), but I believe this requires a
Google partner account to access:
https://partnerissuetracker.corp.google.com/issues/178169843

The summary is that we were seeing these "*ERROR* LSPCON mode hasn't
settled" messages in the kernel logs followed by the display not
working at all. We increased the timeout to 500ms while investigation
continued and this reduced the number of occurrences of this issue:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/7b2899fc1a6f9409e8075b3153baaf02c4d1fc75

The problem continued to occur on about 2% of devices even after
increasing the timeout to 500ms. The investigation continued in issue
# 188035814, with engineers from Parade and Intel involved.
Ultimately, the recommendation from Intel engineers was to increase
the timeout further:
https://partnerissuetracker.corp.google.com/issues/188035814

The timeout was then increased to 1000ms:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/a16cfc2062e768c8e5ad8fa09b8ca127aa1ead9a

I recently ran 100 reboot trials on one device and found that the
median time for the LSPCON mode to settle was 440ms and the max was
444ms. But we know from the original reports that even after we set
the timeout to 500ms the issue continued to happen on some small
percentage of devices. So this is why I picked the larger value of
800ms.

>> This is to eliminate all cases of "*ERROR* LSPCON mode hasn't settled",
>> followed by link training errors. Intel engineers recommended increasing
>> this timeout and that does resolve the issue.
>>
>> On some CometLake-based device designs the Parade PS175 takes more than
>> 400ms to settle in PCON mode. 100 reboot trials on one device resulted
>> in a median settle time of 440ms and a maximum of 444ms. Even after
>> increasing the timeout to 500ms, 2% of devices still had this error. So
>> this increases the timeout to 800ms.
>>
>> Signed-off-by: Pablo Ceballos <pceballos@google.com>
>
>I think we've been here before. Do you have a publicly available gitlab
>issue with the proper logs? If not, please file one at [1].
>
>BR,
>Jani.
>
>[1] https://gitlab.freedesktop.org/drm/intel/issues/new
>
>
>> ---
>>
>> V2: Added more details in the commit message
>> V3: Only apply the increased timeout if the vendor is Parade
>>
>> drivers/gpu/drm/i915/display/intel_lspcon.c | 21 ++++++++++++++++++++-
>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_lspcon.c b/drivers/gpu/drm/i915/display/intel_lspcon.c
>> index bb3b5355a0d9..b07eab84cc63 100644
>> --- a/drivers/gpu/drm/i915/display/intel_lspcon.c
>> +++ b/drivers/gpu/drm/i915/display/intel_lspcon.c
>> @@ -153,6 +153,24 @@ static enum drm_lspcon_mode lspcon_get_current_mode(struct intel_lspcon *lspcon)
>>   return current_mode;
>>  }
>>
>> +static u32 lspcon_get_mode_settle_timeout(struct intel_lspcon *lspcon)
>> +{
>> + u32 timeout_ms = 400;
>> +
>> + /*
>> + * On some CometLake-based device designs the Parade PS175 takes more
>> + * than 400ms to settle in PCON mode. 100 reboot trials on one device
>> + * resulted in a median settle time of 440ms and a maximum of 444ms.
>> + * Even after increasing the timeout to 500ms, 2% of devices still had
>> + * this error. So this sets the timeout to 800ms.
>> + */
>> + if (lspcon->vendor == LSPCON_VENDOR_PARADE)
>> + timeout_ms = 800;
>> +
>> + return timeout_ms;
>> +}
>> +
>> +
>>  static enum drm_lspcon_mode lspcon_wait_mode(struct intel_lspcon *lspcon,
>>       enum drm_lspcon_mode mode)
>>  {
>> @@ -167,7 +185,8 @@ static enum drm_lspcon_mode lspcon_wait_mode(struct intel_lspcon *lspcon,
>>   drm_dbg_kms(&i915->drm, "Waiting for LSPCON mode %s to settle\n",
>>      lspcon_mode_name(mode));
>>
>> - wait_for((current_mode = lspcon_get_current_mode(lspcon)) == mode, 400);
>> + wait_for((current_mode = lspcon_get_current_mode(lspcon)) == mode,
>> + lspcon_get_mode_settle_timeout(lspcon));
>>   if (current_mode != mode)
>>   drm_err(&i915->drm, "LSPCON mode hasn't settled\n");
