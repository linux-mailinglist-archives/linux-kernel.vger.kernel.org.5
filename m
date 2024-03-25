Return-Path: <linux-kernel+bounces-116770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 825E988A3B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F24C1F3DA37
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDEC14A60B;
	Mon, 25 Mar 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VOh6MWc0"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492CB1870CB;
	Mon, 25 Mar 2024 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360090; cv=none; b=PmaUjRxVfQdb6P8NYwCiyI+mvVfScVeFfG2te0vpvaWP4RkKQZuzG6zLRG1woG6CJkUxLrAZjUgqOLJiZKzwCHmZSEaER0WdgT9XvrT5PS3mMwaL6Z1aV4PyH1l3P2HGPyZMjt7U/ifsGMoReYX7Ns+elW3h9CRGyH+iIxEkn7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360090; c=relaxed/simple;
	bh=CqL8N3jTBybuBJNQiRBKr+JMOLQvMsgRNLLqDTJ9OJ0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DLl+SozkaGbSzGlvMbeZaoMBEQF320Qp7tSPMebuYqvB8K7PkRhqHk2cBBRrZ1gjY2qAhLEg2RyiwyHXvZXt7jOrg1eGR8yFhrfPHFhhE4JVLz2tnL7pFL/7RfLkMj0+xpPWjX9dLApwqjUdizkaWXIXZKxBVk7iYNV95tES31o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VOh6MWc0; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711360085; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=QmV+g4GmhsxbZGKeBGO2QlNGUE+VuS1qiEGgbu8EpKw=;
	b=VOh6MWc0hBgULdgEa8EUijWA92CqIjYcGrrFAmC88UMqwoHbjLwAhFChIhErqVEtGuVaRdw4ZCNfH+jjQ77m0iQWTrYe1++onhtk0t8wpJ5bTANk2n1HmCVr3DjoAvTTEq0sztso/61DJtatEppxUUkdjNGZX+/al2BI+jFXQ3w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W3EQlKh_1711360081;
Received: from 30.178.67.255(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W3EQlKh_1711360081)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 17:48:04 +0800
Message-ID: <6109a3e3-ca88-4a4d-86c5-c4eb0d7f6f9c@linux.alibaba.com>
Date: Mon, 25 Mar 2024 17:47:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitao Hu <yaoma@linux.alibaba.com>
Subject: Re: [PATCHv12 4/4] watchdog/softlockup: report the most frequent
 interrupts
To: Thomas Gleixner <tglx@linutronix.de>, dianders@chromium.org,
 liusong@linux.alibaba.com, akpm@linux-foundation.org, pmladek@suse.com,
 kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com,
 tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
 jan.kiszka@siemens.com
Cc: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 yaoma@linux.alibaba.com
References: <20240306125208.71803-1-yaoma@linux.alibaba.com>
 <20240306125208.71803-5-yaoma@linux.alibaba.com> <87zfuofzld.ffs@tglx>
Content-Language: en-US
In-Reply-To: <87zfuofzld.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Thomas

On 2024/3/24 04:43, Thomas Gleixner wrote:
> On Wed, Mar 06 2024 at 20:52, Bitao Hu wrote:
>> +	if (__this_cpu_read(snapshot_taken)) {
>> +		for_each_active_irq(i) {
>> +			count = kstat_get_irq_since_snapshot(i);
>> +			tabulate_irq_count(irq_counts_sorted, i, count, NUM_HARDIRQ_REPORT);
>> +		}
>> +
>> +		/*
>> +		 * We do not want the "watchdog: " prefix on every line,
>> +		 * hence we use "printk" instead of "pr_crit".
>> +		 */
> 
> You are not providing any justification why the prefix is not
> wanted. Just saying 'We do not want' does not cut it and who is 'We'. I
> certainly not.
> 
> I really disagree because the prefixes are very useful for searching log
> files. So not having it makes it harder to filter out for no reason.
> 


Regarding the use of printk() instead of pr_crit(), I have had a
discussion with Liu Song and Douglas in PATCHv1:
https://lore.kernel.org/all/CAD=FV=WEEQeKX=ec3Gr-8CKs2K0MaWN3V0-0yOsuret0qcB_AA@mail.gmail.com/

Please allow me to elaborate on my reasoning. The purpose of the
report_cpu_status() function I implemented is similar to that of
print_modules(), show_regs(), and dump_stack(). These functions are
designed to assist in analyzing the causes of a soft lockup, rather
than to report that a soft lockup has occurred. Therefore, I think
that adding the "watchdog: " prefix to every line is redundant and
not concise. Besides, the existing pr_emerg() in the watchdog.c file
is already sufficient for searching useful information in the logs.
The information I added, along with the call tree and other data, is
located near the line with the "watchdog: " prefix.

Are the two reasons I've provided reasonable?

Best Regards,

	Bitao Hu

