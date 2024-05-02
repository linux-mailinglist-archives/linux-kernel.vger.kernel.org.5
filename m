Return-Path: <linux-kernel+bounces-166400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8198B9A16
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106161F209B6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB24B65BB7;
	Thu,  2 May 2024 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizzup.org header.i=@wizzup.org header.b="m1Cu799q"
Received: from mail.wizzup.org (mail.wizzup.org [45.80.170.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6892C224DD;
	Thu,  2 May 2024 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.170.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714649501; cv=none; b=KIw0l0JGpVlzJYG1deVWXP9lVgy0eB3RXB28B9XDjZFGKqZkIMdmklGblafuThpWd/OlTGuDlsCwpBtHEgOG1nGtYsQcSbivQDwRn95NjdGCxzWFJYAOSgKV9alnltq9IbjCJ1kZ243ZAv4932X2yapDdbTi2cIHrJhnOwZgV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714649501; c=relaxed/simple;
	bh=hdlRoJM+2+2KyXCFmBsNc5FwpvzfatObu0siqf41d4k=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=RFhag1lveQgunCOxAgUXWQNmnNOklEAYBcqpU8F4NJK/T2rQSVcPK7RVsz2KiuXw6HaxdzzrCVzz9MrnEg7s/WMVoFuRNrPpeKn9zhz4gqNUA+KSV63VBVUhcJU/ADQF7o3ycI262AIDapYHQZTtZlsznywifzgMZhSSv5Nr5vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wizzup.org; spf=pass smtp.mailfrom=wizzup.org; dkim=pass (2048-bit key) header.d=wizzup.org header.i=@wizzup.org header.b=m1Cu799q; arc=none smtp.client-ip=45.80.170.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wizzup.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wizzup.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizzup.org;
	s=mail; h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=12nSVpVTm24HoKxg2WwBgVDSsEiN6QR/ZYeATsN2aPc=; b=m1Cu799qtbCNqb3mG5e6opplOR
	1UkXwfTZTohaT03VE5Brs/WULZnTUkjWDTb5h3HO96dzEiunu4tzoo6E6ZxnQWGFkP/bBR0JvZ5Gx
	VeYngiiTsXqRBASwZaNW8i3t8e3C9GmUeRK9n/Zyc57KN07WuFeaq+dVxAxIuizJobkarxTe+iTU1
	gTZfOvbTAZ4erb+w887nS8wpcbnkuCaKTUYqAhe9Do8VLgHVXtoGiqvAWtzRWHJiX1bChQwI6GvZL
	TJOFV8b0vQsRAxbFpmGoVL9pT36ufOzrmdii+BdgbQrLRP+QkuWGq0bBwCVhHRyzdShH5CyeZLu6Y
	/Wuq7eRw==;
Received: from [192.168.178.24] (helo=[0.0.0.0])
	by mail.wizzup.org with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <merlijn@wizzup.org>)
	id 1s2UlU-0000Bm-0D;
	Thu, 02 May 2024 11:38:16 +0000
Message-ID: <657f402f-3c22-48bb-8102-ab35a74444c1@wizzup.org>
Date: Thu, 2 May 2024 13:04:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: nl, en-US
To: linux-omap <linux-omap@vger.kernel.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, zhipeng.wang_1@nxp.com,
 Tony Lindgren <tony@atomide.com>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
 Carl Philipp Klemm <philipp@uvos.xyz>, "Sicelo A . Mhlongo"
 <absicsz@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org
From: Merlijn Wajer <merlijn@wizzup.org>
Subject: No cpufreq entries with omap2plus_defconfig since "cpufreq:
 dt-platdev: Support building as module" (commit 3b062a08)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I was looking at switching my Motorola Droid 4 phone from Linux 6.1 to 
Linux 6.6, and it no longer gets any cpufreq entries on boot, and I 
found cpufreq_dt was no longer loaded. I tried to force the issue by 
modprobe it, but to no avail. The same issue occurs on the latest 6.9.

After a bit of digging it looks like the problem is that 
cpufreq-dt-platdev can be built as a module and when this the case 
(apparently the default), cpufreq_dt doesn't work. With the 
omap2plus_defconfig, CONFIG_CPUFREQ_DT_PLATDEV is indeed set to module.

When I manually probe cpufreq-dt-platdev and cpufreq_dt, I get the 
cpufreq_entries back.

Searching around I found this debian bug report [1] which just flips the 
CONFIG_CPUFREQ_DT_PLATDEV back to '=y', but I think there might be a 
deeper issue here.

Is there a way to define this relationship/dependency for cpufreq-dt, so 
that it will automatically load this module?

Regards,
Merlijn

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1050587

