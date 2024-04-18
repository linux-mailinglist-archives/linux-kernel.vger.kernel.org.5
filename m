Return-Path: <linux-kernel+bounces-149475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5EC8A9197
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C90728354E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780F952F6E;
	Thu, 18 Apr 2024 03:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hGvvMsUG"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB6E79D0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713411460; cv=none; b=P3ti+/ykjakazb6HvkefRtB06yLytcMpzc/Oj6auSkveC906qEgSOtHdJY7DB49NbNMbihM+Nn7MOo2m6ATFeY9Tx1ps1l8aG68TYVFaXSMUPBOqS5mEHA841qIIVontxqNOWDOeKExiVQ0i+vUEbLw3gPPwAyt0Nn9lDSCYWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713411460; c=relaxed/simple;
	bh=WZaxj6bXYHVYrMhQfKuEdbONMJSQN688QForWPOgYb4=;
	h=Message-ID:Date:MIME-Version:In-Reply-To:To:Cc:From:Subject:
	 Content-Type; b=b+HX5ATsSfj4nLwatju0qdUp9rOFIB+NRwTYw1SrO3MaNe1TUIOUr9XsOF/57BeiuLWV5aSQSm2mS7izLKyH0OS/nMy/KP4ko0G7sOq2kjIQinNTeyfh4XhBUOXcxnxY15oJXy7y/a/nXYo8QMqKDxbaYzrDqOCs/4qw6TOr1ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hGvvMsUG; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713411455; h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type;
	bh=qirc/bhxTSDu/b8x/EOAeTegkZ+480CGTi9cv2mXRRM=;
	b=hGvvMsUGDgNYIfBaLWF6NUUBqvkfZ2kRXy2b4epqefMuN1k/UXcyMvB3fDUmLOZExbEKuTO+Azczr8wzCgjOq1+ttfquFNjwzmpmmPz86Am0TtHvdOAE2HTSuizYQLnh0UHf+Jig2GzWY/LXVR6XuBWoXJIU6YyqELmP/Yvqw7I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W4nHQIz_1713411452;
Received: from 30.97.48.213(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0W4nHQIz_1713411452)
          by smtp.aliyun-inc.com;
          Thu, 18 Apr 2024 11:37:34 +0800
Message-ID: <c3959f3e-ca17-4c27-9dd2-504b95f2653c@linux.alibaba.com>
Date: Thu, 18 Apr 2024 11:37:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <ZiCOybMoVyNK6gPT@chenyu5-mobl2>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Abel Wu <wuyun.abel@bytedance.com>,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>,
 Tim Chen <tim.c.chen@intel.com>, Tiwei Bie <tiwei.btw@antgroup.com>,
 Honglei Wang <wanghonglei@didichuxing.com>, Aaron Lu <aaron.lu@intel.com>,
 Chen Yu <yu.chen.surf@gmail.com>, Yujie Liu <yujie.liu@intel.com>,
 linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
From: Tianchen Ding <dtcccc@linux.alibaba.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, we've found a bug about reweight_eevdf(). Would you also please try this 
patchset?

https://lore.kernel.org/all/20240306022133.81008-1-dtcccc@linux.alibaba.com/

Thanks.

