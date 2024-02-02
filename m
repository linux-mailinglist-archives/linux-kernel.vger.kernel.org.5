Return-Path: <linux-kernel+bounces-50232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10296847613
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7BF1C24FE5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DE014A4DE;
	Fri,  2 Feb 2024 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpIgD3/9"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C6114A4F0;
	Fri,  2 Feb 2024 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706894964; cv=none; b=Xe9KVIplmuTKNPgo4xYVIaaaRxnUQ6VOZEPwzET1R//e9i5uL/OEAwGwEUAktjeVtOJK2Jrs1zzy/Bi6V7sG3d+WrPkkrT0k4giqkTl4w51Lk+Jd3DsfkJtqzj4pnDK/6q82fvpgfPA1wkIyGBPBjC3Exc63dAe1QCuJx+vk2W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706894964; c=relaxed/simple;
	bh=2bSArbKYkVHDGGCfc6i2dzgspi7zxkpn93VId/cTZCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrOyy8Yt0RJpbTls3kdbXRPPa9AgP2g5aCxlPZqwsEbauZ2Zh6+cmOHCnEs0MqywTEun1v6tLWRItiLGIjfsVJDNkcgesgik9vo92qSZSxX6vzB5CZqtMQnOC+UeA5ForjJ+WwTN/EHfZsHNzr6kjAGTDTYsPQZVt1W0ahBwQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpIgD3/9; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5dbf050821fso1621497a12.2;
        Fri, 02 Feb 2024 09:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706894958; x=1707499758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qvCQ0WG1c/2jh+URC+HLop9pZd7x9TV23fRrBN2u978=;
        b=KpIgD3/9xwpuJbMC+NjuTeKG+sA4cbVy0+CVzxLvrIAcX+ogL0VO1FXrb00zdnbXf/
         gAcGRsIwKYkuL0p9n/5F7zJnrzj0iuO9Ot82qKfaLCjVxWpB8GJlDVTfv4x8S8aIXBRi
         KbXCiZt5Ixgkn2lNLyIdYWNOPwfektlbRuEw6QNECQBDLehuy4xTiKvWB/ab3QAtzu28
         2txJE9Aw/9r6MN/oTxbeiU2uL1a2jdofDXHBdSxckzLxqjxPm9pKcNf9KAyiIza7nT1/
         cu4OGg8PcHZHzcrdzkLMibwOGjtip4tUbTaUQyzvc1whFyDcghwO0YUm+P3RU3wKeyZP
         N6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706894958; x=1707499758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvCQ0WG1c/2jh+URC+HLop9pZd7x9TV23fRrBN2u978=;
        b=S6EtBFwgqu8C+Gkz+m0OzarVH3VpwD0wKFtl1tGBH7qxPIbaZv7eE0gCLqylZ/1S6d
         rVIOCefIayNMJY/Zylop/1l0iMSQKBpOFAGLTOWVBatHTWZHyKoYw2nUXHKYBEYgM2Q8
         KsATGco01hsR9pzmuyoxh8aERb2j+Pko9p82b3QZxINkSbGhBg8EXnKh5q6lfJbSJL+3
         K3P2dRQGhqL5l4SCOSrjnASydOOMMTPkbvxkDpQchwftboOqt4iEwZNkNVQA3g9GRAPq
         XWuOLg0ayaF3CAX+MhlMJwqqovZvcHLm1PoYz0gWmua/2D8teydlzKHctRMS48ncdV3R
         ktzw==
X-Gm-Message-State: AOJu0YylceaBxzasqdc6OpOROQPgqFKDjLxUg3VY0fg2mOj6xIPwggHM
	LVuJsXsG2Ib0lBFzYje6Yr/z4cY6uswurtLzimIoAYFaePVayuiTqaDHoR8acb8=
X-Google-Smtp-Source: AGHT+IF1Hy3XkzGGAtkm0jQedhjZ6GjQERKVtsfsKgwdpjHWJQIL321TdSDkGSYDx3Sj0dhPMrlU0w==
X-Received: by 2002:a05:6a20:9f88:b0:19c:8fcf:97ca with SMTP id mm8-20020a056a209f8800b0019c8fcf97camr2643818pzb.60.1706894958224;
        Fri, 02 Feb 2024 09:29:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUJ4vG1yFOtAi02O14GiFWGHSPCgs0+7LQF3H0O/wL1Z7TdOEaZ3Z9/yEJjkMQ/6HCdP70hVAhowUgdye9G3ACDwL5Va469z7sU/Yn4LSQ4XGJfLPvCUEOjxN8dYXZ5I8OQ7Ax9s30lMTlWo0Cak9MQ4DRpX77rRKj1zBVGfG4nk+tI3L9faiqI9i039Pv4DAuHX53g
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id y9-20020a62ce09000000b006db85b12036sm1943005pfg.137.2024.02.02.09.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:29:17 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 2 Feb 2024 07:29:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: Helge Deller <deller@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH][RFC] workqueue: Fix kernel panic on CPU hot-unplug
Message-ID: <Zb0mbHlIud_bqftx@slm.duckdns.org>
References: <ZbqfMR_mVLaSCj4Q@carbonx1>
 <ZbrJq3X63hIMkbl2@slm.duckdns.org>
 <8a266076-b3dc-4a39-aac4-089e2ef77da3@gmx.de>
 <ZbvM1V8CYNeds14r@slm.duckdns.org>
 <e6916a78-7872-442d-922d-31ea3920da4f@gmx.de>
 <ZbxHuS6vOc0MB7-R@slm.duckdns.org>
 <983189ec-e8fc-41ef-bad7-cfebad20ac83@gmx.de>
 <f75e7606-0904-4e97-b337-e8f74843e87d@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f75e7606-0904-4e97-b337-e8f74843e87d@gmx.de>

Hello, Helge.

On Fri, Feb 02, 2024 at 09:41:38AM +0100, Helge Deller wrote:
> In a second step I extended your patch to print the present
> and online CPUs too. Below is the relevant dmesg part.
> 
> Note, that on parisc the second CPU will be activated later in the
> boot process, after the kernel has the inventory.
> This I think differs vs x86, where all CPUs are available earlier
> in the boot process.
> ...
> [    0.000000] XXX workqueue_init_early: possible_cpus=ffff  present=0001  online=0001
..
> [    0.228080] XXX workqueue_init: possible_cpus=ffff  present=0001  online=0001
..
> [    0.263466] XXX workqueue_init_topology: possible_cpus=ffff  present=0001  online=0001

So, what's bothersome is that when the wq_dump.py script printing each cpu's
pwq, it's only printing for CPU 0 and 1. The for_each_possible_cpu() drgn
helper reads cpu_possible_mask from the kernel and iterates that, so that
most likely indicates at some point the cpu_possible_mask becomes 0x3
instead of the one used during boot - 0xffff, which is problematic.

Can you please sprinkle more printks to find out whether and when the
cpu_possible_mask changes during boot?

Thanks.

-- 
tejun

