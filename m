Return-Path: <linux-kernel+bounces-53962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FEE84A87D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0541D28E44A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC0A1AB7F3;
	Mon,  5 Feb 2024 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYaC5QlP"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C414B5CD;
	Mon,  5 Feb 2024 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167533; cv=none; b=nAUUVnMDqCNEsLT64tdCnU187Keeqz3PITH1d0HD7sc4J+v1RqOxtSCzH93/CYjXjqkHmo4m0purHUO4MOUZUHz1MW1ilSnzN9mh20ycvhz9cNzmhLrYSjoVoHSpaA/19rIH+KuSZq+trrb7eG4lC27lxcDb1BVhqKUQSsRsM6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167533; c=relaxed/simple;
	bh=XQF2uBcHLuFqq+yOdvxRNweyMEUC2bS20cGYte1KJfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHMVGtHoB0DgBvJUWY9wI0ve/EiO7Pcx7FLqqW1yz2Rnt5NQ/vljAY/YDyifilyLE6D4ukIm6pguxVpkfahy7rlee0Mx3suNQrXN8j0fr7aCqkw5itfjsyXq9fNYc+3XJzExkYwbjgnpN37A2twykm69u0eRl2Xszk0O4vbzbbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYaC5QlP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d72f71f222so39275205ad.1;
        Mon, 05 Feb 2024 13:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707167531; x=1707772331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Epr4P9xrHmvsudGJkegcnKp7KkOU0wqtIemIFUjl3bk=;
        b=TYaC5QlPtuqysLNh/j3l9nJuXNgKkJ4EGmoXf3dgR5QKviJdT/tp3lME/hi+kIX2jQ
         7F48TkU7532tbkkfpbCv/4G1oy3DTvM1FiiYt/gpsYIQF3GZa8zPSClVNJmBD0GHtlz2
         o6rMmx/SFF5SzXatM6/8h3AnP/b4vjQZfnEoSXjSvYv6U7M85KRdIfhtgmh3UlCC3KY/
         tR9zyTGo/mCjY7tP1vElUneoVoiFv5JA4GIjevLUEuxmgcz78ac/yoAvlhdHMuwhNtyT
         yFUDEq4u1FuY/wFtt/wa2QLEIRPhXtKZuc+C4bJs/PdT3ZuuUX84Q2dmULzDW2dsWy4W
         FKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707167531; x=1707772331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Epr4P9xrHmvsudGJkegcnKp7KkOU0wqtIemIFUjl3bk=;
        b=MfH5WpXHKr4iT4wTkuH1fcY3tZlY6nOVnZ5ODs2pAfuKofFychYvaqYoW1kuS6S75J
         GQ7wGOS7pNgP/95MppLXtpmCrV77pFZ6dG5Z7g/iavSdCtQCZewvlKaxnOSCqZpcUuNo
         pJyln3ybfKdJM6IZfHYabRC3/9uXzZqRG9QV2SArBpvwLTJHYF+Owl9pOApsUUGX/oBQ
         PrxxcYq4ru9mwRjgBh/4CqzrpX71j15WhUMJAVTMy/IBUlWEObtpW8PfKipqHnoDnwED
         2pQMrJ0Z/YdNMeoH2bVmH751AbUyT89AgpsSqkKAYuLpK/ePJWf+BBZeJ8PxS1taV4t0
         qs6A==
X-Gm-Message-State: AOJu0Ywhkby2x4GW89BFEPstfm3BNGEeYWVQQ7iUCPNkltXWXlcr2+Nd
	Bv3o0Pkea/NUb3h/OtHVLRPwIGby07SZOP47jg81RrRs85agdABo
X-Google-Smtp-Source: AGHT+IFf/wc235Q1LsngiAKkLZZRq99Fmkw9x7bucgz2Q7qPcj5sGnzopUSeVLnlgrt66ScPcyoO1A==
X-Received: by 2002:a17:902:ee81:b0:1d7:7347:d80e with SMTP id a1-20020a170902ee8100b001d77347d80emr706714pld.37.1707167531226;
        Mon, 05 Feb 2024 13:12:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVH5hLCVOvQ/utBPhijRYjEQzo0ZfJlK8Mhbyv3NVNlvgGrEhEMGKUy2+tlE0QIR2Txxu4BFELRanLyPgDRi9VbwYk8nkzD/6OORH608lnF0xTYa6oM6Jh708OvEET5XjMDC/hYrbk7OoN4VfhlbPv947Q2gAHulnGXZ0vOqfKS2YYJy1S73aI6b9VAY624SxEJWF/2viuz8Nf1ySJYj0ejOOfIlvPmcPI9WwaPspCbTxlZgeCr65PvcXtZg+XFU6pAlWROfsue43g8zwt9GTFnowAlOKM6ONBTJ3qKMFxwVXCspC4/vElpKs79HfK6RMylLKWQRvvtpbEraBuyKqhf0qhCirbrG/4MAlYEMxnJNx7vVvy6JCfNb7fj6ateYbCMh/Bcr+I9byyuZ9CyfN1HE2GkfqisDBzrMjcOhP0iEULMMeRLwCjNjOtVYOc=
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902d3cd00b001d9609f2e30sm326986plb.1.2024.02.05.13.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:12:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Feb 2024 11:12:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Allen <allen.lkml@gmail.com>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	msnitzer@redhat.com, ignat@cloudflare.com, damien.lemoal@wdc.com,
	bob.liu@oracle.com, houtao1@huawei.com, peterz@infradead.org,
	mingo@kernel.org, netdev@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCHSET wq/for-6.9] workqueue: Implement BH workqueue and
 convert several tasklet users
Message-ID: <ZcFPKaWwxJhgy8HQ@slm.duckdns.org>
References: <20240130091300.2968534-1-tj@kernel.org>
 <ZcACvVz83QFuSLR6@slm.duckdns.org>
 <CAOMdWSLNMqsZNJ-oCLN2RjckZmJSvdU_Yq0F0frmqMqa67Oy1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWSLNMqsZNJ-oCLN2RjckZmJSvdU_Yq0F0frmqMqa67Oy1g@mail.gmail.com>

Hello, Allen.

On Mon, Feb 05, 2024 at 12:50:28PM -0800, Allen wrote:
> Thank you. I am basing my work on the branch you have
> pushed.(or-6.9-bh-conversions)
> https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/log/?h=for-6.9-bh-conversions
> 
> In the order of priority, I have started converting drivers/media/*,
> drivers/dma/* followed by drivers/net/*
> which constitutes the majority. Putting my plan out here so that the
> work is not duplicated.
> I will write back in a day and share the branch for review.

That's great. Thanks.

> W.r.t the conversion, there are drivers which call
> tasklet_[disable/enable](), which I suppose
> can be ignored in the case of workqueues, I am not entirely sure if
> this is the right approach.
> Please correct me if I am wrong.

I don't think we can ignore them. I was just looking at tasklet_kill() and
thought we're good because that seemed to map well to cancel_work_sync().
workqueue doesn't have the counterpart for tasklet_[disable/enable](). I'll
look through them and think on it.

Thanks.

-- 
tejun

