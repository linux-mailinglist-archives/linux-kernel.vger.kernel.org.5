Return-Path: <linux-kernel+bounces-159550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DD78B3024
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24F11C22F36
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2BD13A41B;
	Fri, 26 Apr 2024 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWK9rQ2M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F0781207;
	Fri, 26 Apr 2024 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714112227; cv=none; b=bJtNERdAi6rzR2HylnyoTBdz1xFtmd4UuWBIIGJv7/m297mHJhE+WPX+6ypMJi9HubDSvcQOWIHefgzR31RXShvq/Qlc6JJtZg06+RnaVW/5DstGnCcvkPbnywP7beysnAhUFZgCJmkNg1qilE6KvSXGSvdQRecNekQQk0jtJmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714112227; c=relaxed/simple;
	bh=p4CueVvem0GTIiml8Fzg7bzXuPacvuMDFP1NdVUCOog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEmSrhX4i9kyW3xN+hQJldapuOV5rld2dChqVIjz0MQGLM/r/KCUoJnWbRVxqmvBNSTQ1zhDKQzzVly0rhc/yzYrRC6fHhMsBWpfSNfb5OZ2yHkscUkxOfRRD/xCmDH2lOY7ZYcjv1G4Ap3wrwmBqqysFmY7pr9H8OHX8fuAxhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWK9rQ2M; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714112225; x=1745648225;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p4CueVvem0GTIiml8Fzg7bzXuPacvuMDFP1NdVUCOog=;
  b=CWK9rQ2MHtE0V+JbxuwMeiTniVla0vFn4Jm5tgAhZ0gGRTK1c7hlnSBE
   0tr2qSchJ62AKH/QoiUwk0Ue+jMKsSHEa1JkosoqXty+FU2PkZxzLEMVc
   G696LbHJIu68w/YMaQlddcDGhPUjwHjmilAwertbNB440U/UN7FYg/PA7
   jLTj3f9vy21BQAm5gSoqR2eHY0IpyDSIO4hYG2wUt3M+ad0dRe3cff1St
   10q7QLRC9VMeKyJkiBvgvwGdN7zLxAGI7RBgPtTr20CxCKptSWHAwwqhQ
   ukT1HhMA0YMpdPa5lmUDc9GnOLsec35iruXE5VGbHsAHtF6mQOdK/pQkM
   w==;
X-CSE-ConnectionGUID: PcMyQ3ZLRcag9osC3/1vQg==
X-CSE-MsgGUID: AlOa5vmXSyW14j0lrb5irg==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="27357122"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="27357122"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 23:17:04 -0700
X-CSE-ConnectionGUID: DC67gJCrQbmbmlPfH4v4eA==
X-CSE-MsgGUID: eS7lAnUmRtmP5LWQfr6aeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="25319196"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.48.22])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 23:17:03 -0700
Message-ID: <3f69d64e-7c41-48de-a7a0-42ab99cd7e7d@intel.com>
Date: Fri, 26 Apr 2024 09:16:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mmc: core: check R1_STATUS for erase/trim/discard
To: Ulf Hansson <ulf.hansson@linaro.org>, Kamal Dasu <kamal.dasu@broadcom.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 ludovic.barre@st.com, f.fainelli@gmail.com,
 bcm-kernel-feedback-list@broadcom.com,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20240423200234.21480-1-kamal.dasu@broadcom.com>
 <CAPDyKFqLqbRx3gWCqT4G6mUVeMDWyA_f8T2_iYt07r_Ffqaaow@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFqLqbRx3gWCqT4G6mUVeMDWyA_f8T2_iYt07r_Ffqaaow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/04/24 19:18, Ulf Hansson wrote:
> + Wolfram, Adrian (to see if they have some input)
> 
> On Tue, 23 Apr 2024 at 22:02, Kamal Dasu <kamal.dasu@broadcom.com> wrote:
>>
>> When erase/trim/discard completion was converted to mmc_poll_for_busy(),
>> optional ->card_busy() host ops support was added. sdhci card->busy()
>> could return busy for long periods to cause mmc_do_erase() to block during
>> discard operation as shown below during mkfs.f2fs :
>>
>> Info: [/dev/mmcblk1p9] Discarding device
>> [   39.597258] sysrq: Show Blocked State
>> [   39.601183] task:mkfs.f2fs       state:D stack:0     pid:1561  tgid:1561  ppid:1542   flags:0x0000000d
>> [   39.610609] Call trace:
>> [   39.613098]  __switch_to+0xd8/0xf4
>> [   39.616582]  __schedule+0x440/0x4f4
>> [   39.620137]  schedule+0x2c/0x48
>> [   39.623341]  schedule_hrtimeout_range_clock+0xe0/0x114
>> [   39.628562]  schedule_hrtimeout_range+0x10/0x18
>> [   39.633169]  usleep_range_state+0x5c/0x90
>> [   39.637253]  __mmc_poll_for_busy+0xec/0x128
>> [   39.641514]  mmc_poll_for_busy+0x48/0x70
>> [   39.645511]  mmc_do_erase+0x1ec/0x210
>> [   39.649237]  mmc_erase+0x1b4/0x1d4
>> [   39.652701]  mmc_blk_mq_issue_rq+0x35c/0x6ac
>> [   39.657037]  mmc_mq_queue_rq+0x18c/0x214
>> [   39.661022]  blk_mq_dispatch_rq_list+0x3a8/0x528
>> [   39.665722]  __blk_mq_sched_dispatch_requests+0x3a0/0x4ac
>> [   39.671198]  blk_mq_sched_dispatch_requests+0x28/0x5c
>> [   39.676322]  blk_mq_run_hw_queue+0x11c/0x12c
>> [   39.680668]  blk_mq_flush_plug_list+0x200/0x33c
>> [   39.685278]  blk_add_rq_to_plug+0x68/0xd8
>> [   39.689365]  blk_mq_submit_bio+0x3a4/0x458
>> [   39.693539]  __submit_bio+0x1c/0x80
>> [   39.697096]  submit_bio_noacct_nocheck+0x94/0x174
>> [   39.701875]  submit_bio_noacct+0x1b0/0x22c
>> [   39.706042]  submit_bio+0xac/0xe8
>> [   39.709424]  blk_next_bio+0x4c/0x5c
>> [   39.712973]  blkdev_issue_secure_erase+0x118/0x170
>> [   39.717835]  blkdev_common_ioctl+0x374/0x728
>> [   39.722175]  blkdev_ioctl+0x8c/0x2b0
>> [   39.725816]  vfs_ioctl+0x24/0x40
>> [   39.729117]  __arm64_sys_ioctl+0x5c/0x8c
>> [   39.733114]  invoke_syscall+0x68/0xec
>> [   39.736839]  el0_svc_common.constprop.0+0x70/0xd8
>> [   39.741609]  do_el0_svc+0x18/0x20
>> [   39.744981]  el0_svc+0x68/0x94
>> [   39.748107]  el0t_64_sync_handler+0x88/0x124
>> [   39.752455]  el0t_64_sync+0x168/0x16c
> 
> Thanks for the detailed log!
> 
>>
>> Fix skips the card->busy() and uses MMC_SEND_STATUS and R1_STATUS
>> check for MMC_ERASE_BUSY busy_cmd case in the mmc_busy_cb() function.
>>
>> Fixes: 0d84c3e6a5b2 ("mmc: core: Convert to mmc_poll_for_busy() for erase/trim/discard")
>> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
>> ---
>>  drivers/mmc/core/mmc_ops.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>> index 3b3adbddf664..603fbd78c342 100644
>> --- a/drivers/mmc/core/mmc_ops.c
>> +++ b/drivers/mmc/core/mmc_ops.c
>> @@ -464,7 +464,8 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
>>         u32 status = 0;
>>         int err;
>>
>> -       if (data->busy_cmd != MMC_BUSY_IO && host->ops->card_busy) {
>> +       if (data->busy_cmd != MMC_BUSY_IO &&
>> +           data->busy_cmd != MMC_BUSY_ERASE && host->ops->card_busy) {
>>                 *busy = host->ops->card_busy(host);
>>                 return 0;
>>         }
> 
> So it seems like the ->card_busy() callback is broken in for your mmc
> host-driver and platform. Can you perhaps provide the information
> about what HW/driver you are using?
> 
> The point with using the ->card_busy() callback, is to avoid sending
> the CMD13. Ideally it should be cheaper/faster and in most cases it
> translates to a read of a register. For larger erases, we would
> probably end up sending the CMD13 periodically every 32-64 ms, which
> shouldn't be a problem. However, for smaller erases and discards, we
> may want the benefit the ->card_busy() callback provides us.
> 
> I would suggest that we first try to fix the implementation of the
> ->card_busy() callback for your HW. If that isn't possible or fails,
> then let's consider the approach you have taken in the $subject patch.

Note, sdhci drivers can override host->ops.  For example,
sdhci-omap.c has:

	host->mmc_host_ops.card_busy = sdhci_omap_card_busy;

Probably, if ->card_busy() cannot be supported, then setting
it to NULL would work.

	host->mmc_host_ops.card_busy = NULL; /* Cannot detect card busy */


