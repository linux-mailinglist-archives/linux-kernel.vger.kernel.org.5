Return-Path: <linux-kernel+bounces-58620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8113784E8EC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349F5289CF0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA70383AC;
	Thu,  8 Feb 2024 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iutf54a1"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCF638390
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420385; cv=none; b=TqrSkE3iYuPMcCZQ9yh+68pLvR+nCYx2cCntqiVJjQoKTip+FtusGNY59ldVEd+0M5Q+XEMSABeR3i0wlB6E1y6ByhYuDCGJbrMC/umy5KibhbTaU8l/Yf4RW/oDWqLfAgcliYtYCmkXfCCF76h32sMIuIFYIFLelpTA4Zan/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420385; c=relaxed/simple;
	bh=byF0RdGCs4OK/Ai+smBd8HikD6r0WF0O6R1+z/6nYV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSf/DlkWihuOEi+Ili6TYeyyNGalx0iolzZd3mZiaXxQj3QqoSotuPyJkXvovQRZ+HUQElDgYiexxxTjnAyl7ateF2GCoU2l5tiMAB9JM7fjk2cyOk5htoWZZVwEqn/TgS9V4RqmMUW/EcxLypK+FXk//0qy01C6nj5K80uiRyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iutf54a1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d93edfa76dso1330755ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 11:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707420383; x=1708025183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjWbmDXoJ9G/mPfdl/rmA94/z6SAtRwpg8a/7R9JzWU=;
        b=Iutf54a1WMyA7ETSkC3mO5yKwU+PPQXZr5+huhUJck9w9urnBOIpoJvi13TcdKhth1
         hQXcgCyjBx6Bgw2duNXW8BqcvFwoy+P6TkKCuJNgfpu7KCrhnmw2yXo39aOQTlzjObLX
         uxNx7UP9T3VGEYj9uQzEazeDTHk+Mbet+Glp3x0wfXoGR4OsIcMLBu3BomlAGwZVqKDD
         cDw3NkQHdNtS6dc7Pwb5jv3rExAox1AfN/ueEtZ1xdtgDhGp99XsFgJBHsHwElAHM/D/
         VBIbDCOsVWIq48NFn1OzceVzvpmaM5TxupQz2p1sw9WWj2M8RtyoqpcOMUAZUDEAgi8c
         BGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707420383; x=1708025183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjWbmDXoJ9G/mPfdl/rmA94/z6SAtRwpg8a/7R9JzWU=;
        b=M4iTT2OeGTbW/Xdk+N56H7uWsoRtDg13hYw4Ns8MDPg984qa6Z7CDToVY7K+8R/K+q
         goUHrvJr+E0SloQ4TgDrNaDdqbmvTqn1cCCqMJwf/q7fDyh5DDnaoeztQedtDV0lTwpU
         pjA6/38T4Ec/R/C9ndhk2MoIvvCyJlYu1EaDQI2BWzDQS7iQP8J3dOrDO+2r6jSqN+Nt
         9YgZlXSZ8fmB3TDSceBpkLiOydPCE+dZAjPjgtxHsRUNibTVcYPMzcTtX6pXgMoSa057
         TAxgihECtYfUbOab1acVzm8tTajznqO2bbpJlQ9lPULz8CLOzWZyW+R4iel/3qD+7pKb
         mcnw==
X-Forwarded-Encrypted: i=1; AJvYcCW5pB+GynWSNsD8aHaC8O//pSTJEDMzV0prxByZli6yH8KgxgHa9M4Cq8v1naj+ZlVERg2cReQ6AkoHRyVsJ32xOPbT9sbsA/x2Bb59
X-Gm-Message-State: AOJu0Yx8XDd7DjjizD6756NZ58EYp1GX3fvn68WeSADHcCAImTLgxX8p
	H4RPYrCaNxwH/O5pv3bdhsNw1/9RlwPOoCOEoZhq5A2Yh2SD5zpJ
X-Google-Smtp-Source: AGHT+IEMZ3o7yt6TMYwM4R88H+UPSoIi8JaVKKTIlpohS9iUF98c4Jwso0vULBg6fl0mCzfeEKHY3w==
X-Received: by 2002:a17:902:7d96:b0:1d9:5923:c242 with SMTP id a22-20020a1709027d9600b001d95923c242mr138328plm.42.1707420382707;
        Thu, 08 Feb 2024 11:26:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVg5W0+YKuGF6RYT5T4o4krKqZa1v5mtQ0RTeOMOzK+8fPkW3M1LO7emb5PLZAspb71uBF6yvAhfo7jWwRwYm4oanxp6FXUxBRLJTsVTKJmN8h6HWBaF4Jja2zr4JlWGhFv4p4LnuuMEcWrJuwIWhxz87X3pAUsHDL+YvXCYjYqqAdL3uuSk5wOVrrpqJtu9PNFdD7Riw6fAdzEUtIHGZDkd1F6MxWddtGnagHY1/rZHN0WIYMR4QvfWJoGS1CoY1zScD03WQ==
Received: from localhost ([2620:10d:c090:400::4:3c45])
        by smtp.gmail.com with ESMTPSA id mi3-20020a170902fcc300b001d944bf2d83sm123911plb.7.2024.02.08.11.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 11:26:22 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 8 Feb 2024 09:26:21 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>, Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <cshulyup@redhat.com>
Subject: Re: [PATCH wq/for-6.9 v5 0/4] workqueue: Enable unbound cpumask
 update on ordered workqueues
Message-ID: <ZcUq3VnputFml3LK@slm.duckdns.org>
References: <20240208161014.1084943-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208161014.1084943-1-longman@redhat.com>

On Thu, Feb 08, 2024 at 11:10:10AM -0500, Waiman Long wrote:
>  v5:
>   - [v4] https://lore.kernel.org/lkml/20240207011911.975608-1-longman@redhat.com/
>   - Streamline patch 2 by simplifying unplug_oldest_pwq() and calling it
>     only in pwq_release_workfn().
> 
>  v4:
>   - [v3] https://lore.kernel.org/lkml/20240205194602.871505-1-longman@redhat.com/
>   - Rebase on the latest for-6.9 branch again & discard the use of
>     __WQ_ORDERED_EXPLICIT and resetting of __WQ_ORDERED.
>   - Add a new patch 1 to change the ordering of pwq's in wq->pwqs from
>     oldest to newest.
>   - Change the terminalogy from freeze/thaw to plug/unplug.
>   - Allow more than 2 pwq's in wq->pwqs of ordered workqueue but only the
>     oldest one is unplugged. This eliminates the need to wait for
>     the draining of extra pwq in workqueue_apply_unbound_cpumask().
> 
>  v3:
>   - [v2] https://lore.kernel.org/lkml/20240203154334.791910-1-longman@redhat.com/
>   - Drop patch 1 as it has been merged into the for-6.9 branch.
>   - Use rcu_access_pointer() to access wq->dfl_pwq.
>   - Use RCU protection instead of acquiring wq->mutex in
>     apply_wqattrs_cleanup().

Applied the series w/ (w/ the updated second patch) to wq/for-6.9.

Thanks for working on this. It's really great that this got solved finally.

-- 
tejun

