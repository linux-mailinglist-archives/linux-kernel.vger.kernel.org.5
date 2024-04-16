Return-Path: <linux-kernel+bounces-147734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 154F18A7859
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1DB1C217D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D35213A3E5;
	Tue, 16 Apr 2024 23:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHNJaSO2"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0E42375B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308803; cv=none; b=McqA6nn+kQqDJ1OJihmdrcz1m8zymPZFt1IwNfXb07nFfZrcXUA+28eBx9iRh6mI//1eOclMw8BAvJhTiYRXCowcETLz/dfOiEA1Nv+mrJK32UbekoSFXC9uyWL4AJyOMN2VEZpZKQIttOlJVAGLO9AMrNCeH6KaLEOL0XnFQM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308803; c=relaxed/simple;
	bh=276kf9zpC8PtcfD0t9xKRrFqjJ9g/in2eYSc79cMQuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fB1ao2RFKS8KSLifBLB2BWm7cHPCzAmj02FfRmv3qP3cIl7trQOcgNjLtpL1q+hjvrPTGEQzpdVyYHE145W8GwGrUbE8YfwHVdrC1X1XsY+Yw4YOLISroZ3M0ZEpRkzJ61Ufo1RGpnjhFLg2QZJMLV0tcPiHv7OdzGFEK1Md7JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHNJaSO2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso4578540b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713308802; x=1713913602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8XsGKjaexJ8hn4FT6evgYRRwtcE3VtBU27qMOyTo2E=;
        b=JHNJaSO2msLgywDZiaC4jzDnUmddSpd/zepD1PcyqQpFlTJcWvgQo9CSNpPtcnaOT5
         dYBLYZBLRBar611q3W1Nm71ElBl3EPUnVq7uau4YzzVpDwU/zaJmiwXQGqDiVBGvXSTI
         tPwDJ+GNT+X38I9yUIF9qtv8TlPE264GZKtPELBxBSi878hcOnVzGIQLCbU/yzChMK0y
         QBN83KQFYf6nv6Y/FpSG5NyjossII0QMHJABkZS4nw4fWYtkJoVDpFI6FoEJ2y2eI/jU
         3ncu4TwIPN6jPp1I/Nlx1eK+OACteLB0ZfHtXOmIGXjX87U8uQrmzZAmzcSdsS5S7v/O
         JZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713308802; x=1713913602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8XsGKjaexJ8hn4FT6evgYRRwtcE3VtBU27qMOyTo2E=;
        b=kpMmyefb6ggAggY8MNPxFAHh/dKCcdjIjEr9Zibm3B4cl5oY5R5w3L/hAOVUjuZ2tY
         n8bUbD6hQlN4COt6+p2K7OYHE/15lLTh2C4r5scDQEVOKhu/q8kIUx68Np48XvH2j9WC
         517uMNohPtluIE1yGwQ7T7rekLMZvrCpLqmyFh93LEn8heIBPyeguJJEw6YU2mfPTW5/
         UXz/MBR1+BtoiFpAvXSrDh8CCjgwoGg0SPPgEhWXwvQYLo0yFByYaBlGBZ09M/TGuQQw
         VVjYHtB/mEWJNjCzOOAYEF07HwUaGx6vaOTaUo4gnLqs48Juz/FjCYgTAENK3ysRFtQG
         eRmg==
X-Forwarded-Encrypted: i=1; AJvYcCVXZYWbhhVgKdleevkuNhT/ClQg274uQVSve9FRdvXGTM1T6ckpT1xhWmIMlibwsbVRj7dY4TSGZqfKaOhoXWPfXsMAN8nLsaLnBhgK
X-Gm-Message-State: AOJu0YydpiiUnefV12+w00Z0otYLeExxRyaW7KTpUYFqSkkA8HFvS1M6
	ikrCRUHsynkjvGAt+SLQKXr99uC3qPmmCcoRGhzWPLfgd98w/MvZ
X-Google-Smtp-Source: AGHT+IGW1kmvAs9hivpdijIVvs/2TQ9Nisxffwlud4AdIFkfPKCpyX6o0aQlOMl8y4+ub8B07Uj60A==
X-Received: by 2002:a05:6a00:1147:b0:6ee:1508:eda0 with SMTP id b7-20020a056a00114700b006ee1508eda0mr19535977pfm.18.1713308801708;
        Tue, 16 Apr 2024 16:06:41 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id f15-20020a056a00228f00b006ed1ea5219csm9450242pfe.130.2024.04.16.16.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:06:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Apr 2024 13:06:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix selection of wake_cpu in kick_pool()
Message-ID: <Zh8EfxdVdiIj_27H@slm.duckdns.org>
References: <20240415053550.538722-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415053550.538722-1-svens@linux.ibm.com>

Hello,

On Mon, Apr 15, 2024 at 07:35:49AM +0200, Sven Schnelle wrote:
> @@ -1277,7 +1277,8 @@ static bool kick_pool(struct worker_pool *pool)
>  	    !cpumask_test_cpu(p->wake_cpu, pool->attrs->__pod_cpumask)) {
>  		struct work_struct *work = list_first_entry(&pool->worklist,
>  						struct work_struct, entry);
> -		p->wake_cpu = cpumask_any_distribute(pool->attrs->__pod_cpumask);
> +		p->wake_cpu = cpumask_any_and_distribute(pool->attrs->__pod_cpumask,
> +							 cpu_online_mask);

I think this can still race with the last CPU in the pod going down and
return nr_cpu_ids. Maybe something like the following would be better?

	int wake_cpu;

	wake_cpu = cpumask_any_distribute_and(...);
	if (wake_cpu < nr_cpus_ids) {
		p->wake_cpu = wake_cpu;
		// update stat;
	}

This generally seems like a good idea but isn't this still racy? The CPU may
go down between setting p->wake_cpu and wake_up_process().

Thanks.

-- 
tejun

