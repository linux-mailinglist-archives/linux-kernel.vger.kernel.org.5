Return-Path: <linux-kernel+bounces-145880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F6A8A5C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72BC28297F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D57C13A87E;
	Mon, 15 Apr 2024 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="jNvNQZ51"
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EC741C77;
	Mon, 15 Apr 2024 20:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713213480; cv=none; b=pJqjwhG8hT5FPQA99kxzlLYNvhlKSw2/0c3l6lkx3IAP8PgaGNpIbXl/qS0PsBpLHno6deBcPUpndnjqm2n5KCr657xdWNCr3FqtPWfx1RVVsZrnyZr8BOv5v72p8TJtccB5EHm8T8tzULwEXNq6Z+PEhfxuujV47bDQUkuJriM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713213480; c=relaxed/simple;
	bh=Hx4NPSUILjcZmhJJEAyf+8xHw9GGsTlNvKFacX5G+uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJrrZwBIZTRBt51nWRQtQe3W4gM/WmXn4K6kT9InVGafgoEEoZryvR46wRliJmyR780wEcNwXkQCt17X5aw/wTPCklcEii6/g/GHVBcFCXE7oJSxGqMAoTeCIBskb2HBS8kHC+M+r8dGC/PnkxeeWvizVHClDBruIdspoTu8xG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=jNvNQZ51; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 24140980073;
	Mon, 15 Apr 2024 20:37:55 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 53E9813C2B0;
	Mon, 15 Apr 2024 13:37:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 53E9813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1713213474;
	bh=Hx4NPSUILjcZmhJJEAyf+8xHw9GGsTlNvKFacX5G+uA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jNvNQZ51Lpm5HGBs+4LLyCVu20Mvvkh60ZSRvTd4cl1w7df+wRDeNoiQkg+3+hXZ5
	 30VK0cmDwdKda2QVe/xp5O4leL92235uZ4QgYkRsT5NMqh0sZA2RJWGVcOtazslUw2
	 1WHWZtlXFxAfOBTqoVC0RXkFc3zWNxD9ZcuCS5Fw=
Message-ID: <de43c7e1-7e8c-bdbe-f59e-7632c21da24a@candelatech.com>
Date: Mon, 15 Apr 2024 13:37:54 -0700
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
To: Lee Jones <lee@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
 Johannes Berg <johannes@sipsolutions.net>
References: <30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com>
 <30819e01-43ce-638f-0cc6-067d6a8d03c7@candelatech.com>
 <89a9eec3-337f-3c9f-6bbe-00a26a15287c@candelatech.com>
 <20240411070718.GD6194@google.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20240411070718.GD6194@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1713213476-wf32vBeEnvC9
X-MDID-O:
 us5;at1;1713213476;wf32vBeEnvC9;<greearb@candelatech.com>;6d567af444ed5ba21bec93fef576b8bb

On 4/11/24 00:07, Lee Jones wrote:
> On Wed, 03 Apr 2024, Ben Greear wrote:
> 
>> On 4/2/24 10:38, Ben Greear wrote:
>>> On 4/2/24 09:37, Ben Greear wrote:
>>>> Hello,
>>>>
>>>> Sometime between rc1 and today's rc2, my system quit booting.
>>>> I'm not seeing any splats, it just stops.  Evidently before
>>>> sysrq is enabled.
>>>>
>>>> [  OK  ] Started Flush Journal to Persistent Storage.
>>>> [  OK  ] Started udev Coldplug all Devices.
>>>>            Starting udev Wait for Complete Device Initialization...
>>>> [  OK  ] Listening on Load/Save RF …itch Status /dev/rfkill Watch.
>>>> [  OK  ] Created slice system-lvm2\x2dpvscan.slice.
>>>>            Starting LVM2 PV scan on device 8:19...
>>>>            Starting LVM2 PV scan on device 8:3...
>>>> [  OK  ] Started Device-mapper event daemon.
>>>> iwlwifi 0000:04:00.0: WRT: Invalid buffer destination: 0
>>>> sysrq: This sysrq operation is disabled.
>>>>
>>>> I can start a bisect, but in case anyone knows the answer already, please let me know.
>>>>
>>>> Thanks,
>>>> Ben
>>>>
>>>
>>> So, deadlock I guess....
> 
> Does this help you in any way?
> 
> https://lore.kernel.org/all/bbcdbc1b-44bc-4cf8-86ef-6e6af2b009c3@gmail.com/
> 
Hello Lee,

I cannot see how that patch above would fix my issues since I am not using that driver,
but possibly some similar change needs to be made to iwlwifi.

Johannes, you had another suggestion: changing iwlwifi's request_module() to request_module_nowait() in
iwl_req_fw_callback()

Is that still best thing to try in your opinion?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



