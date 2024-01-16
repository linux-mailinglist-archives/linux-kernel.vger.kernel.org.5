Return-Path: <linux-kernel+bounces-28280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0846282FC7C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2BF28E3F9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032F728E38;
	Tue, 16 Jan 2024 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVdXIDPt"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D885E1F939
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705439097; cv=none; b=ZsOkCeugQ1/iP6jC9Tauz3OedVlOUdEbW4WPGtJFhsapdCmZuyIX7XO5SeQ8g2sw6LRG8r53+hVZqbpkxZJCTKIw8tCDYW09kuenDK/89576lL65VVixC1LjiwXFSmc+CVJ7wJEbX0ZU1ptUcYlqbOX7ujQ4MApNy8L1OS7eRm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705439097; c=relaxed/simple;
	bh=bN0R2ktw3y3yOUxOO+GkQNyVTZGVa6wVUz74DbWPQwI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAldKU/laqW2R8zEberQyLzEBjNTiQd+DBImcfYxcnT+d5d10f6rvvUpPiR6MGoZPmG8vol10X0XX0wNlIJaOSrwbxKRebYH1/dUPGFjoyTw7s5y2GUrj1oAhLd59Dp8luvBOeJge2u2PaKQ242actzP4fGvhKvCia5C9T3SeZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVdXIDPt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d5f56912daso4832275ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705439095; x=1706043895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8/1MkLrY46twcleZVXWMzSMWv+lZYgmR+jwLYasltk=;
        b=UVdXIDPt178d09NLHJzKu4xn8Xb3ssdqwj8Sq5JDVf2wtJpiu4gMmZpjDgsIE36iI+
         dH69xSnW9VJ2NepF5z5hwh26+Z3N34a1ZrTX+HfGRzrD+DBH4/K/TIZvR4V2zjkChxEY
         kIeuEKPHWLFEK9Z+TJ0GE10ET897bC3IJoER9dP3tE/tBspxMzI+pAiy4WOxAKXPgQUV
         hmtAT2BWOYey4OqLnToRYNqC/bNhujfAlV3UEkazyt6UpBgwxVUTjfulRNdgcFE8EOoE
         Yu5Pt2oU4PmPauQl7jizgfKLrJeaoA6/p3D9bCvIdfKIUsOGOWUOeQZy3hiVbTEQbFEe
         roUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705439095; x=1706043895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8/1MkLrY46twcleZVXWMzSMWv+lZYgmR+jwLYasltk=;
        b=c9SlrrcLDISV/tE1SlaDLVT5+vou3ilL007VlyDLCoJy9tySKnJOZAntsvGoSI3rAL
         sCSw30mAcjDKXXXsBcRMGQD6l9GgIBxKC2VenSNIZD5aja/ZEMRyehwjGpmO46zPH6BX
         zTPSwM1U+mHSBWd51szLsqTdzqZQLkO3NsXbusy6CnsLFT2738OvT66ZLDhSwslFhJEY
         MMPdRaSp93tKiVnExLBG+L+2WOWxojnem/1Vd+/k3zhx9CNQfz8Oo7S5/b66FUzjP9xV
         9mZ6dm7tGqNFJjAg/kw/lQNfe4glorFF5mEntg4VX/hH9kDKCNrX7rxdQdfXpUEgmGin
         e/Yg==
X-Gm-Message-State: AOJu0Yws9yTheQZJMcVgXugVlnivCuq4Bkne5RQoykjdYsfyH+z0qSUP
	nQX6Vk7WTvnKm/bCiY5MNg8IcnPI8Mg=
X-Google-Smtp-Source: AGHT+IEB6/wErKxlYlRfD9klAwsgXLTl+oVm9qxUTurveCO9A++FmoEhDdP74z6TrNUFpGkTw7MG1w==
X-Received: by 2002:a17:903:1450:b0:1d0:6ffe:a1a with SMTP id lq16-20020a170903145000b001d06ffe0a1amr9959703plb.120.1705439095044;
        Tue, 16 Jan 2024 13:04:55 -0800 (PST)
Received: from localhost (dhcp-72-235-13-140.hawaiiantel.net. [72.235.13.140])
        by smtp.gmail.com with ESMTPSA id ja20-20020a170902efd400b001d5e7348692sm1676062plb.277.2024.01.16.13.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 13:04:54 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Jan 2024 11:04:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: Re: [PATCHSET wq/for-6.8] workqueue: Implement system-wide
 max_active for unbound workqueues
Message-ID: <ZabvdYTNhj6fiHgl@slm.duckdns.org>
References: <20231220072529.1036099-1-tj@kernel.org>
 <e3r47rru6go5fqxl5issvduzzmsxrtkefigrkfcnqiuouxm467@72hfzpblzr36>
 <ZaCMkV_pjPfhZmrn@mtj.duckdns.org>
 <znrr4upkwnaehoifwcfuhk25ddv4kriyhrymqawcvnxseampml@drwl73kklgmq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <znrr4upkwnaehoifwcfuhk25ddv4kriyhrymqawcvnxseampml@drwl73kklgmq>

Hello,

On Mon, Jan 15, 2024 at 05:46:07AM +0000, Naohiro Aota wrote:
> CPU: Intel(R) Xeon(R) Platinum 8260 CPU, 96 cores
> NUMA nodes: 2
> RAM: 1024 GB
> 
> However, for another benchmark experiment I'm doing, I booted the machine
> with "numa=off mem=16G" kernel command-line. I admit this is an unusual
> setup...

So, does that end up using only memory from one node while making the kernel
unaware of NUMA topology?

> On that machine, I create a fresh btrfs with "mkfs.btrfs -d raid0 -m raid0
> <devices>" with 6 SSD devices. And, I run the following command on the FS.
> 
> fio --group_reporting --eta=always --eta-interval=30s --eta-newline=30s \
>     --rw=write --fallocate=none \
>     --direct=1 --ioengine=libaio --iodepth=32 \
>     --filesize=100G \
>     --blocksize=64k \
>     --time_based --runtime=300s \
>     --end_fsync=1 \
>     --directory=${MNT} \
>     --name=writer --numjobs=32
> 
> tools/workqueue/wq_dump.py output is pasted at the
> bottom. "btrfs-endio-write" is the workqueue, which had many workers on the
> unpatched kernel.

If so, I'm not sure how meaningful the result is. e.g. The perf would depend
heavily on random factors like which threads end up on which node and so on.
Sure, if we're slow because we're creating huge number of concurrent
workers, that's still a problem but comparing relatively small perf delta
might not be all that meaningful. How much is the result variance in that
setup?

> FYI, without the kernel command-line (i.e, numa=on and all RAM available as
> usual), as shown below, your patch series (v1) improved the performance
> significantly. It is even better than the reverted case.
> 
> - misc-next, numa=on
>   WRITE: bw=1121MiB/s (1175MB/s), 1121MiB/s-1121MiB/s (1175MB/s-1175MB/s), io=332GiB (356GB), run=303030-303030msec
> - misc-next+wq patches, numa=on
>   WRITE: bw=2185MiB/s (2291MB/s), 2185MiB/s-2185MiB/s (2291MB/s-2291MB/s), io=667GiB (717GB), run=312806-312806msec
> - misc-next+wq reverted, numa=on
>   WRITE: bw=1557MiB/s (1633MB/s), 1557MiB/s-1557MiB/s (1633MB/s-1633MB/s), io=659GiB (708GB), run=433426-433426msec

That looks pretty good, right?

Thanks.

-- 
tejun

