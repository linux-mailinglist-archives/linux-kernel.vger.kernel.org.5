Return-Path: <linux-kernel+bounces-149512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DFE8A923D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 513FDB222C5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B92C548EA;
	Thu, 18 Apr 2024 05:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="1d36Sz7G"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C4914294
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713416670; cv=none; b=M6h+4PcuEA+ACFpK7iGFdPxyzjl4XXgNMQI7tXtbLmaNc9kGqZvFu3UmeMq/LLGmtESzItsV9XNSiCyYiEVBcZn8ytItFym1RDuCxkXakzhavCfgG/+CFD1U6126Bk04imuGyilCQpC7QmEQp7A57lKuTXwjOeyL+KET2l25MzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713416670; c=relaxed/simple;
	bh=HtQ81hpO6BgEAwhQOdAXLA4cT2p4a8PXAxRIP8ZxS6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gywbvvEviCbli872TuMRilnc2I1e3oDAjiTUK6BIdJ5Fjgoxc4hpiY99jxudXW+nRIVDKeejTl5qR8jyJXTy5FY0VPGOoobT9HqAkD8Y146CuUSrZJp6c6FAh1TO3z3n+ZzwQLlUatIWHA1j9mbzYSEeuaBg1Gz8Ag6W0MmL4DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=1d36Sz7G; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so260987a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 22:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1713416668; x=1714021468; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uZS/gH98RhR+rW1L2HynWgy0vHmnLFJe0tDkcJXmYYg=;
        b=1d36Sz7Gl1vJo3LFD+cq+p39KbjalhTPWm736M3pqw1kfizUUhAiXGODt+XiA2dYH7
         lxFxXsN1juUpM2hZT0ig+cUXN47+MXB9tOnDzQxXsQslKzPV0AIXz0C852v1nKj9djez
         Yyo+heJ2mMJvTKk5Jrxh9dzQwA3rC9aeDLcPFuBqjcipHYf0nv01c4TjeTpuEm6waQAj
         Gl+vVlQLwkOhsiY+8Q22jbLhfHAR/YBVXdKi4fqPT8t9br6R/EI+jYHuTLTuJyHAPmDQ
         VZcbGPjaeonV/c+jVpr4PgjcrbqOollyllVj0WlPFVPoHZZj8ScZLcjpI1AXb/fcUE5/
         Pptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713416668; x=1714021468;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZS/gH98RhR+rW1L2HynWgy0vHmnLFJe0tDkcJXmYYg=;
        b=CJP537uyy0/DGrHiQVQeWF9DzrRD6g4Wn3SXaXcaOfFMY0Ede819EWlsiTNEKl0y9Q
         UZqi+GYOWVYiwOW2Fk8kwsreo3AbDRkn8e7HTFEJpVpCn40lSDhvYEXwXKUSgRUkYisS
         3DpmKZNP/ekr6N57Ah9lG6S4NXVSTxgkMvn55BI3wLfSNgUVPiEUbcWD9VgiuH2rP1j+
         qQxmA/APc3I7K/DXr3wvI3DQOriWxOgCI/XUVOxbtxQXqjoe6vsce8l5ju3jcWxesv1V
         FHuQeRJLZSuhgcU4iLWkXHltBydn4j3iFx449CdaMzRXQpogCC6anzCYgWrN1+7hCXF4
         UMVA==
X-Forwarded-Encrypted: i=1; AJvYcCU8DPc+TfYU2PHgMSAcRem2YjGuP/jPhJrZEckaQ7SGYQuP5xJHiozrXjjonspE0GXjmNL2VfcEDRWvMWr/58+wvdgu04lQ14BQvgLx
X-Gm-Message-State: AOJu0YxTIcVnidJ1LtBh9iKl8PUQE2JpeXo6juDXeJ0jyq0QCRp+BqoS
	o2LOkKXafoQMGbQobR8AMcULv1KKuz+veGhcxXbjFovfcUjbqXA7TrMIfOndMH0=
X-Google-Smtp-Source: AGHT+IEI86PUw8O21UjigTajTmSqTEHHm4lfjxjnxkU/mitVvHvxv0kzZQ7L15gYKxZj0ArIgU5qXw==
X-Received: by 2002:a05:6a21:7888:b0:1a7:74e4:efa5 with SMTP id bf8-20020a056a21788800b001a774e4efa5mr2397589pzc.2.1713416668289;
        Wed, 17 Apr 2024 22:04:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-56-237.pa.nsw.optusnet.com.au. [49.181.56.237])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090adb4c00b0029df9355e79sm561867pjx.13.2024.04.17.22.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 22:04:27 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rxJwe-001xzN-1w;
	Thu, 18 Apr 2024 15:04:24 +1000
Date: Thu, 18 Apr 2024 15:04:24 +1000
From: Dave Chinner <david@fromorbit.com>
To: Xiubo Li <xiubli@redhat.com>
Cc: linux-xfs@vger.kernel.org, chandan.babu@oracle.com, djwong@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: xfs : WARNING: possible circular locking dependency detected
Message-ID: <ZiCp2ArgSzjGQZql@dread.disaster.area>
References: <a0caa289-ca02-48eb-9bf2-d86fd47b71f4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0caa289-ca02-48eb-9bf2-d86fd47b71f4@redhat.com>

On Thu, Apr 18, 2024 at 11:39:25AM +0800, Xiubo Li wrote:
> Hi all
> 
> BTW, is this a known issue and has it been fixed already ? I can reproduce
> this always with my VMs:
> 
> 
> <4>[ 9009.171195]
> <4>[ 9009.171205] ======================================================
> <4>[ 9009.171208] WARNING: possible circular locking dependency detected
> <4>[ 9009.171211] 6.9.0-rc3+ #49 Not tainted
> <4>[ 9009.171214] ------------------------------------------------------
> <4>[ 9009.171216] kswapd0/149 is trying to acquire lock:
> <4>[ 9009.171219] ffff88811346a920 (&xfs_nondir_ilock_class){++++}-{4:4},
> at: xfs_reclaim_inode+0x3ac/0x590 [xfs]
> <4>[ 9009.171580]
> <4>[ 9009.171580] but task is already holding lock:
> <4>[ 9009.171583] ffffffff8bb33100 (fs_reclaim){+.+.}-{0:0}, at:
> balance_pgdat+0x5d9/0xad0
> <4>[ 9009.171593]
> <4>[ 9009.171593] which lock already depends on the new lock.
> <4>[ 9009.171593]
> <4>[ 9009.171595]
> <4>[ 9009.171595] the existing dependency chain (in reverse order) is:
> <4>[ 9009.171597]
> <4>[ 9009.171597] -> #1 (fs_reclaim){+.+.}-{0:0}:
> <4>[ 9009.171603]        __lock_acquire+0x7da/0x1030
> <4>[ 9009.171610]        lock_acquire+0x15d/0x400
> <4>[ 9009.171614]        fs_reclaim_acquire+0xb5/0x100
> <4>[ 9009.171618] prepare_alloc_pages.constprop.0+0xc5/0x230
> <4>[ 9009.171622]        __alloc_pages+0x12a/0x3f0
> <4>[ 9009.171625]        alloc_pages_mpol+0x175/0x340
> <4>[ 9009.171630]        stack_depot_save_flags+0x4c5/0x510
> <4>[ 9009.171635]        kasan_save_stack+0x30/0x40
> <4>[ 9009.171640]        kasan_save_track+0x10/0x30
> <4>[ 9009.171643]        __kasan_slab_alloc+0x83/0x90
> <4>[ 9009.171646]        kmem_cache_alloc+0x15e/0x4a0
> <4>[ 9009.171652]        __alloc_object+0x35/0x370
> <4>[ 9009.171659]        __create_object+0x22/0x90
> <4>[ 9009.171665] __kmalloc_node_track_caller+0x477/0x5b0
> <4>[ 9009.171672]        krealloc+0x5f/0x110
> <4>[ 9009.171679]        xfs_iext_insert_raw+0x4b2/0x6e0 [xfs]
> <4>[ 9009.172172]        xfs_iext_insert+0x2e/0x130 [xfs]

The only krealloc() in this path is:

	new = krealloc(ifp->if_data, new_size,
                        GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);

And it explicitly uses __GFP_NOLOCKDEP to tell lockdep not to warn
about this allocation because of this false positive situation.

Oh. I've seen this before. This is a KASAN bug, and I'm pretty sure
I've posted a patch to fix it a fair while back that nobody seemed
to care about enough to review or merge it.

That is: kasan_save_stack() is doing a fixed GFP_KERNEL allocation
in an context where GFP_KERNEL allocations are known to generate
lockdep false positives.  This occurs depsite the XFS and general
memory allocation code doing exactly the right thing to avoid the
lockdep false positives (i.e. using and obeying __GFP_NOLOCKDEP).

The kasan code ends up in stack_depot_save_flags(), which does a
GFP_KERNEL allocation but filters out __GFP_NOLOCKDEP and does not
add it back. Hence kasan generates the false positive lockdep
warnings, not the code doing the original allocation.

kasan and/or stack_depot_save_flags() needs fixing here.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

