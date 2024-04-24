Return-Path: <linux-kernel+bounces-157398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AA68B10FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1441C242E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB8D16D9AE;
	Wed, 24 Apr 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="rL2hf2iA"
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B74B16D338;
	Wed, 24 Apr 2024 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979585; cv=none; b=mOaI7dRRmehTggEvg3UhmIB0JGkiN9Zj0FYCquY1nAQvEMqtzWKj7dKom0V/7JhIioLxKm0vDpyZaj6q4Wjwnc/FCosNFaswLyKb1276sFDy6NIGeDnx97SAuuLmkMdtXD33nRYxbpzaZPERtvXLrrw907T60mVm0UJIEIzWkiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979585; c=relaxed/simple;
	bh=d3O6GKUqu6OUvUeJOd060p3Y2QLwo5uZRyG+P9OO/zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBDWesmCEwn7ueQW+jU86M6yVWOGdlm7IfdHBAPhROXTKQ1Lf3EEA8QhupE+ZwRExc4kzOiD8mD3+80l42qf+RsBslxrVODyXdhC8Jw/D1qR59x6ZGeODAq6K5rDhvluEFVrv666pJkgFiYqmsnD+q1MZ7aDkdADr0BywW2GjT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=rL2hf2iA; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 912D22C0079;
	Wed, 24 Apr 2024 17:26:14 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id DC9BC13C2B0;
	Wed, 24 Apr 2024 10:26:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com DC9BC13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1713979574;
	bh=d3O6GKUqu6OUvUeJOd060p3Y2QLwo5uZRyG+P9OO/zs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rL2hf2iAE5wFYMtov1SzEYtVLCBMODa89Jwabm7q1rJSeK7uQ+MVHGGANIlfAZV4o
	 WgXXOpMQFASQ9/71/aX/ajVi7geGjh8cujqIwP/ea+9XdUgAROp+EflgFwMBAVzyqd
	 UV5FcPttMF1MkTVps1CHstbGWKGRAmFWl3KnAVHA=
Message-ID: <6eba2967-e2de-d9f1-3794-01cf4e88c56c@candelatech.com>
Date: Wed, 24 Apr 2024 10:26:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: 6.9.0-rc2+ kernel hangs on boot (bisected, maybe LED related)
Content-Language: en-US
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Lee Jones <lee@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Johannes Berg <johannes@sipsolutions.net>
References: <30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com>
 <30819e01-43ce-638f-0cc6-067d6a8d03c7@candelatech.com>
 <89a9eec3-337f-3c9f-6bbe-00a26a15287c@candelatech.com>
 <20240411070718.GD6194@google.com>
 <de43c7e1-7e8c-bdbe-f59e-7632c21da24a@candelatech.com>
 <8736ebc8881e1e0cabfbbf033725a3123a5e8e90.camel@sipsolutions.net>
 <bc420f3a-5809-4c4a-80ad-ccd8a46853b6@leemhuis.info>
 <8ab88be5de30bcbd0d1cac3cfde6b2085dcfc8fb.camel@sipsolutions.net>
 <0197efe8-828b-43ae-85c9-5d521913a289@leemhuis.info>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <0197efe8-828b-43ae-85c9-5d521913a289@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1713979576-bliQDCpf6f_C
X-MDID-O:
 us5;at1;1713979576;bliQDCpf6f_C;<greearb@candelatech.com>;d71741af030859b5073d777f43f1a679

On 4/23/24 02:29, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 23.04.24 11:06, Johannes Berg wrote:
>> On Tue, 2024-04-23 at 11:00 +0200, Linux regression tracking (Thorsten
>> Leemhuis) wrote:
>>> On 16.04.24 08:17, Johannes Berg wrote:
>>>> On Mon, 2024-04-15 at 13:37 -0700, Ben Greear wrote:
>>>>>
>>>>> Johannes, you had another suggestion: changing iwlwifi's request_module() to request_module_nowait() in
>>>>> iwl_req_fw_callback()
>>>>>
>>>>> Is that still best thing to try in your opinion?
>>>>
>>>> I guess so, I don't have any better ideas so far anyway ...
>>>
>>> [adding the iwlwifi maintainer; thread starts here:
>>> https://lore.kernel.org/lkml/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/
>>>
>>> ]
>>>
>>> Johannes, Miri, what's the status wrt to this regression? From here
>>> things look somewhat stalled -- but maybe there was progress and I just
>>> missed it.
>>
>> What do you want? It got bisected to an LED merge, but you ping _us_?
>> Way to go ...
> 
> Sorry, to me it sounded a bit like you had an idea for a fix and were
> going to give it a try -- similar to how the maintainers for a r8169
> driver and the igc driver provided fixes for bugs recent LED changes
> exposed.
> 
> But sure, you are right, in the end some LED change seems to have cause
> this, so the duty to fix it lies in that field. Therefore:
> 
> Lee, what's the status here to get this fixed before the final?
> 
> Ciao, Thorsten

Hello Johannes,

This patch makes the problem go away in my testbed with 24 Intel
iwlwifi radios.  My guess is that it is just papering over the problem, but
maybe good enough?  Would you like me to submit as official
patch to linux-wireless?

$ git diff
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 4696d73c8971..993177e1de27 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1744,7 +1744,7 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
          * or hangs loading.
          */
         if (load_module)
-               request_module("%s", op->name);
+               request_module_nowait("%s", op->name);
         failure = false;
         goto free;


Thanks,
Ben

> 
> 
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



