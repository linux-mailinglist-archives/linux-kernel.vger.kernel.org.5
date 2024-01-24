Return-Path: <linux-kernel+bounces-37711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D0583B43F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628871C21CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195BE135400;
	Wed, 24 Jan 2024 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwxtXzbE"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15551133990
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132853; cv=none; b=STVx5CtrZTwFUr5s93D4Q8uSBEa7i1BnJee1MNHPEkrrue2O6pJXlbsOIrk6sI6JDZ4XYmsqj0YPGSn0FspYrAxmLQR12H577Cq/jHgV4Rf1EPDCLJ5TYZjAplY/VrPC1P6Wt4V/oV3hW7+SLOV6yG1IEKqa+1+sS+2du4XGrYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132853; c=relaxed/simple;
	bh=iRVFpYRREhyk9t3Dg+gk/GrI+UevbaqTDe7W8QkKXjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQBdsacwmWWlNHd0hfuEFUaPx7aHXRhQzJgEZsi3y9WtepTPIOLuxUpqUfh1uvguR66QK9cWRsoln52hY+O7/p+bXuu6Ft8c+mnv9SNqeNqX/WM1FSsHTeYtPt59nuW2IyJ0vF+fhJn+AuDHmChKbItb6We3PPh6qPbBsusvr1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwxtXzbE; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cedfc32250so3361222a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 13:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706132851; x=1706737651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YujGiTWHdxgZYfVaBshMu3ZIXxPdLRsSpRObPAnRM4=;
        b=UwxtXzbEbdgdNxhfIPhVf22EngHRRqTmQ7s6Y2pMPRoIzN7rqEZ4aGmz5Pyvwzq2Fq
         ZDsdIgPUY5e3lqjwjSglBej40Y2G/IpMZYHgTmMM9EvI1Fp1ATDRehdC2XUKKV+992rw
         cqhU1RuebNRZO2r9XwSX/bOzLjUlZUeaeDM9orSDwGILCdNy7zWyKCL9Xz2BO3/Q2ojO
         DGlGhiKXQCih8oKQKUymEWz9eJqQ6d28WzhM+B+58Ab+kZ7isQD32fOOD56z1VoHNe8T
         3GIYjivANDgGGE2QJVxt7NJ7Zv5ChbgGOqwuUO9EL0NLewk4YohV1sTtNx09IpsYoUbX
         6+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706132851; x=1706737651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YujGiTWHdxgZYfVaBshMu3ZIXxPdLRsSpRObPAnRM4=;
        b=cQ7wz+qD8ul8K4I1mof6VsTDYUgIrLSOvEUYERZlFBKwu2diZwpviYkKQ4uScuvazA
         sKuZ5Iu2WTYbInjsb4EmCHwPXYopN9nLc30XMDxY1whDgcGg8QXxVZlNmwmNl6iA4Kya
         btmrAC/RLdRXomftWAbDlcfg/WAYOp0OqHZnmpY9XxZQXqpCaoRhMo9Z5XSLtjue0y/R
         wD4kLZ2uo1hNzbwL4tPZu4T3+DEUbHwqvT/WJR2IOMSbkM9KK6OHQs6l42JQp4J9P0WD
         lopv2ZhjDXTKz2eb+qtVit9qhMx8+vF8VxmQ51L+h7n8BALL5ACSt7eTfJuw06JGEaUA
         o7CQ==
X-Gm-Message-State: AOJu0Yzg64w8lKjcbTFv2mPk0iNiTQehtAcPzRV6KAQF+UatFRV5Kj52
	9GsYOLJMrArscTXeuPp04qPxO3Nd0kcyJcQ4Faf8Cnsism0y2NR6
X-Google-Smtp-Source: AGHT+IFKHfy31mZJMyO0agazThwpVCtfY5q+BXzBm4FtZP9JFxjh4D9ATkrOl10fQegdYWQS/Oe9DQ==
X-Received: by 2002:a05:6a20:c505:b0:19b:5b8e:7b84 with SMTP id gm5-20020a056a20c50500b0019b5b8e7b84mr50112pzb.119.1706132851229;
        Wed, 24 Jan 2024 13:47:31 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id o14-20020a056a00214e00b006dcd6a5ba14sm4417043pfk.59.2024.01.24.13.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 13:47:30 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 24 Jan 2024 11:47:29 -1000
From: Tejun Heo <tj@kernel.org>
To: Leonardo Bras <leobras@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] wq: Avoid using isolated cpus' timers on
 unbounded queue_delayed_work
Message-ID: <ZbGFce8ixJKb6umE@slm.duckdns.org>
References: <20240124082938.2527697-2-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124082938.2527697-2-leobras@redhat.com>

On Wed, Jan 24, 2024 at 05:29:37AM -0300, Leonardo Bras wrote:
> +	/*
> +	 * If the work is cpu-unbound, and cpu isolation is in place, only
> +	 * schedule use timers from housekeeping cpus. In favor of avoiding
> +	 * cacheline bouncing, run the WQ in the same cpu as the timer.
> +	 */
> +	if (cpu == WORK_CPU_UNBOUND && housekeeping_enabled(HK_TYPE_TIMER))
> +		cpu = housekeeping_any_cpu(HK_TYPE_TIMER);

Would it make more sense to use wq_unbound_cpumask?

Thanks.

-- 
tejun

