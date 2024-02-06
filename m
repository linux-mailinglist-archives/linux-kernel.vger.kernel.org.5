Return-Path: <linux-kernel+bounces-54111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A089D84AAF0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E021F24F8C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2C14A08;
	Tue,  6 Feb 2024 00:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcPc2FTm"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9FC4A02
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707177902; cv=none; b=bdcpp0qp3/WFfiyhi7vEpyc/3y7kduZbRgVXsolsMYjy3LV74ZYD+ALZ0XidBrwPVEQQOSdMspLP63Q0VRUrbxAgr74paomng7cGA3na9lu1iHw2NkCtSXR3qM0MbkINdulTv/HbDlKaBu2q2xvOHwIEmg7d7SN6CCdcSFMd4Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707177902; c=relaxed/simple;
	bh=psWXJCTJ++nnIOoeAlSD7GIyMRWEuWxsSjf1mNPqqAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SudRo0VVBH1/A5UY+I0Z1a49WIsPhlc+ktn46irSBjcIPmaR6Zb4JARKzoD0NdGvrHwg7iZEZkdy4dAPGJWwgA8FhjuuwlrLGRgXadYRKexCTh45BOA6yVXGiFVlcxOajWRfc+niE1zNdTbX5OUj7WpOUQEo0naoddq94yZi5sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcPc2FTm; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6da9c834646so4029905b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 16:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707177900; x=1707782700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOORU3ocIizNBlePylvH6BnL7JMGtggAGg4oYomnTLo=;
        b=DcPc2FTmHGrRbsPN8ARw93kp72oMdgyn0ukx2CodsxeOKONPEDlWxGKZgb0F/4s+wu
         bCvTIAFYhGrde7kXx7QA7/6tf/Ub7sCBcr3PHtz6IzHdyz/itjurgm4UzaIG3av8B+YQ
         zZr5rNlDD8qG8MWOgoJE99pIuforCkn7tGtJ7DPljTtrzoxKeU/GNMNozMtwIdHu5KRa
         8CiXbNEwRRbSgrytzMc0jpUbWbIafQIbsYiEYz4AVfA8Y7qT6U4PhSWNNOEtrNSFTPxr
         pFthggsGb2UFKxrb90Ig/GnEXEkOSGKapcALJZ1l9Z6W52J4skbrz0YY/Z0El7Vtyo4f
         hlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707177900; x=1707782700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOORU3ocIizNBlePylvH6BnL7JMGtggAGg4oYomnTLo=;
        b=IlNjnW203V6+ud4+p/Ztz6tysOeJ5EwCjcBSm4OSkE+tbuW5jG9DYHfGd2x1SmlfO3
         8RN+/OV1WLChEYitvXiCiRsTx/MoaJIYc7yuGpm0G5rvJHaX+Ww6jcE/Dg9b7y5POfeX
         F3fil//hn/GGYVkaECn0hkYC5yHTdq/sYb78p0yp88CmEZigFn7UBkQOBBlL4roayOvR
         P0+UWPqW+D0h140uygufE+pGTZ6hIeTSViCKYOy4YsdGE2emDmqexo6u+SYJpRKn94Nv
         wgcTvP7CFnnECPp+5kfAd0ddxLE0+p9rLgDHF/Xtp6gVNy/XEro3lPsqznwgDefyalPi
         rc9A==
X-Gm-Message-State: AOJu0YyJVwH1QtqNFZf/2bYgM71KNsstEMAvBfOPIjj9vYsHf1dQkMxz
	GKi5ciuOadygCyNyD1x8ov52ANndu5SRzx7mTQrsA+Gr0Ht0tglG
X-Google-Smtp-Source: AGHT+IHXaVmyfynFYQg3CbFfEsnTkkF7KskS9sLvCPg8+v8KcGtVVUcHxl8UlO29cZNtkH/ICIZm+w==
X-Received: by 2002:aa7:868f:0:b0:6e0:3ef3:db3c with SMTP id d15-20020aa7868f000000b006e03ef3db3cmr1027997pfo.29.1707177900125;
        Mon, 05 Feb 2024 16:05:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXbTAiE6ZlFO3wzdD7u+tdLxGgK9H5mambq+eOxN8Lq2llnoVgVCPauLdePbGNDBzJNeqyb5Jr1CfM7oIlzPNZcd+AAetm21ZF459DoLxwZn7S0LHm/yM++jdX5IsmtgGhGc/wDlM2o3fU+EQoDDAVVX4xutviU4vF62nQkwSB1UWrB8gBuUgFQPdjhHabL8o/zkiKIKE7MFG+/8/M+hlf1IUiZ5PYAtmUQlux8Jk+SJzB7AyVFS76PyiIY18hOeTVMFpXGUQ==
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id o1-20020a056a001b4100b006ddc7ed6edfsm476810pfv.51.2024.02.05.16.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 16:04:59 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Feb 2024 14:04:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>, Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <cshulyup@redhat.com>
Subject: Re: [PATCH-wq v3 0/4] workqueue: Enable unbound cpumask update on
 ordered workqueues
Message-ID: <ZcF3qmion7H6qyYY@slm.duckdns.org>
References: <20240205194602.871505-1-longman@redhat.com>
 <ZcE8pUuHfa7gVZs6@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcE8pUuHfa7gVZs6@slm.duckdns.org>

On Mon, Feb 05, 2024 at 09:53:09AM -1000, Tejun Heo wrote:
> On Mon, Feb 05, 2024 at 02:45:58PM -0500, Waiman Long wrote:
> >  v3:
> >   - [v2] https://lore.kernel.org/lkml/20240203154334.791910-1-longman@redhat.com/
> >   - Drop patch 1 as it has been merged into the for-6.9 branch.
> >   - Use rcu_access_pointer() to access wq->dfl_pwq.
> >   - Use RCU protection instead of acquiring wq->mutex in
> >     apply_wqattrs_cleanup().
> 
> Looks like we raced each other. I'll wait for v4.

BTW, please don't bother to handle __WQ_ORDERED being cleared. We are very
close to removing the implicit ORDERED promotion, so we should be able to
apply the patch to remove the distinction between explicitly and implicitly
ordered workqueues.

Thanks.

-- 
tejun

