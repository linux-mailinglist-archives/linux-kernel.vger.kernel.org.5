Return-Path: <linux-kernel+bounces-46852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B674B844571
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E41B295C90
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6060212BF22;
	Wed, 31 Jan 2024 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy0if5zj"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E87118E03
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720423; cv=none; b=U9Mtmv+XlPuZG6wwY4hKO/CV8yPUOjniwqdz1yQI/jL/MQMg7Wrq+svkhyDZgteX7AQXCZqztx7nnoDLYUc6pbQ2IS8vJR65Ojyi07xfag2P6caU6bngHKXoEAqRHkhu5R5BOIjt8rEhRKlpIYOCpg4XNKr7ZvMi8mGYXf4aHo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720423; c=relaxed/simple;
	bh=2RyS7nzzw3f0XKhSp4p2AfaSztdcwlpSoIFtns/Ns9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvIL59K6iuq+3ZjTxW/mh6dxK+K1zjMArlucBhBkIUOKx7gyNd7rURa4rGt5p//YEWfqx3TwYugQW1Ob6JPk3xn2sAlqtx6vIl8NM/giONIh44qceFgcQ4inztvOCovgkI2qjBiET0pT5OzhpVrH9j7bK/E+UpA/Bhv6Y/bEoEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dy0if5zj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d746856d85so30270345ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706720421; x=1707325221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pv98UMrrD1uW+PtrLRbSYOmRry5NiuDSVY0gdAUrGQ=;
        b=dy0if5zjYGE7Gu3riC3YtuW0Mepf0/drGJwQTYT8PBRVYm3tdEJ4BQQwFnABpBC3Hn
         sgm/KkVDtogAYvaIeU2X2IU1tlI/N7CIXplKyawyUoTvR5d2tCw2qivPP/AlfJpmKHlk
         CXBf8e5XSVcspGWbZuTMDgitHWR2rx5E5bkvbht7abDsw/gEdyLVLu8+jDcImDhKSeoa
         PyTKml9YvF+16Z62UOKnqms4KADJk5brct16cPWyEeZkQX+9ZP5acVMJKeuJ6idR4lIp
         Z5GXpta2ceqxzif1TGdhWb3myYZ/kLQJ+bQ5USHPfgk5zMpIS2iZ1XSJo+cx+UKrF3QX
         Gcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706720421; x=1707325221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pv98UMrrD1uW+PtrLRbSYOmRry5NiuDSVY0gdAUrGQ=;
        b=eMICaaqLA/FIS5UPnwwPI3anuOTmR42sDr6UgNrKA6gIJUI8Ql3gkt9xXlu/n/uzMI
         5xIpYqyPBknbykxFcHtHbCUK8BPHB1HpZHIn4OyHTD6kXJRCBWVYClpxMwXBEpgt6O6b
         cFQ3gmhuhn+A86SDp2wKNFcFxi0m2KmFcsZHLCAPyjXbywB993ADpOv/NJq0jJ9XoiF+
         2Vxwrq3b8jDLk8OwnnZvGPj3B8nV8Qb+jpMkCDvXKcwdTuuBKrUeLd7rtE5xS/KQbB1V
         +JnQu4LjZRUTCogkYaA8t9S5asZyjyeL4SCnD1s+tqQ6pLSmBqMfERNIut7Tkfp7SoPU
         BDyQ==
X-Gm-Message-State: AOJu0YxAPQvi6f01zJ8K/zBJpcEp18axJGZWZ35kiAGfX1ueO7r8c4IW
	kbU4SjMMn/G39P+DKFF+91c4frE01+3D+DQ8tZeZHMzxzytex1QzIKDSJl4hfLs=
X-Google-Smtp-Source: AGHT+IE4ynvsW1KIbCJQWwkDLRCwbqOv4YaHNy6bffIhajIxJBhYJ8dQzmJ1qoX+MBmdIf0Vsm3Aqg==
X-Received: by 2002:a17:903:25ca:b0:1d8:f39b:8a5f with SMTP id jc10-20020a17090325ca00b001d8f39b8a5fmr2038900plb.62.1706720421141;
        Wed, 31 Jan 2024 09:00:21 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id v19-20020a170902d09300b001d8d0487edbsm6512234plv.223.2024.01.31.09.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 09:00:20 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 31 Jan 2024 07:00:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>
Subject: Re: [RFC PATCH 3/3] workqueue: Enable unbound cpumask update on
 ordered workqueues
Message-ID: <Zbp8k1mbKuujC94q@slm.duckdns.org>
References: <20240130183336.511948-1-longman@redhat.com>
 <20240130183336.511948-4-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130183336.511948-4-longman@redhat.com>

Hello,

On Tue, Jan 30, 2024 at 01:33:36PM -0500, Waiman Long wrote:
> +/* requeue the work items stored in wq->o_list */
> +static void requeue_ordered_works(struct workqueue_struct *wq)
> +{
> +	LIST_HEAD(head);
> +	struct work_struct *work, *next;
> +
> +	raw_spin_lock_irq(&wq->o_lock);
> +	if (list_empty(&wq->o_list))
> +		goto unlock_out;	/* No requeuing is needed */
> +
> +	list_splice_init(&wq->o_list, &head);
> +	raw_spin_unlock_irq(&wq->o_lock);
> +
> +	/*
> +	 * Requeue the first batch of work items. Since it may take a while
> +	 * to drain the old pwq and update the workqueue attributes, there
> +	 * may be a rather long list of work items to process. So we allow
> +	 * queue_work() callers to continue putting their work items in o_list.
> +	 */
> +	list_for_each_entry_safe(work, next, &head, entry) {
> +		list_del_init(&work->entry);
> +		local_irq_disable();
> +		__queue_work_rcu_locked(WORK_CPU_UNBOUND, wq, work);
> +		local_irq_enable();
> +	}
> +
> +	/*
> +	 * Now check if there are more work items queued, if so set ORD_WAIT
> +	 * and force incoming queue_work() callers to busy wait until the 2nd
> +	 * batch of work items have been properly requeued. It is assumed
> +	 * that the 2nd batch should be much smaller.
> +	 */
> +	raw_spin_lock_irq(&wq->o_lock);
> +	if (list_empty(&wq->o_list))
> +		goto unlock_out;
> +	WRITE_ONCE(wq->o_state, ORD_WAIT);
> +	list_splice_init(&wq->o_list, &head);
> +	raw_spin_unlock(&wq->o_lock);	/* Leave interrupt disabled */
> +	list_for_each_entry_safe(work, next, &head, entry) {
> +		list_del_init(&work->entry);
> +		__queue_work_rcu_locked(WORK_CPU_UNBOUND, wq, work);
> +	}
> +	WRITE_ONCE(wq->o_state, ORD_NORMAL);
> +	local_irq_enable();
> +	return;
> +
> +unlock_out:
> +	WRITE_ONCE(wq->o_state, ORD_NORMAL);
> +	raw_spin_unlock_irq(&wq->o_lock);
> +}

I'm not a big fan of this approach. It's a rather big departure from how
things are usually done in workqueue. I'd much prefer sth like the
following:

- Add the ability to mark an unbound pwq plugged. If plugged,
   pwq_tryinc_nr_active() always fails.

- When cpumasks need updating, set max_active of all ordered workqueues to
  zero and flush them. Note that if you set all max_actives to zero (note
  that this can be another "plug" flag on the workqueue) first, all the
  ordered workqueues would already be draining, so calling flush_workqueue()
  on them sequentially shouldn't take too long.

- Do the normal pwq allocation and linking but make sure that all new
  ordered pwqs start plugged.

- When update is done, restore the max_actives on all ordered workqueues.

- New work items will now get queued to the newest dfl_pwq which is plugged
  and we know that wq->pwqs list contain pwqs in reverse creation order. So,
  from pwq_release_workfn(), if the pwq being released is for an ordered
  workqueue and not plugged, unplug the pwq right in front.

This hopefully should be less invasive.

Thanks.

-- 
tejun

