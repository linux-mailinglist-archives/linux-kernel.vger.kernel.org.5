Return-Path: <linux-kernel+bounces-39927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8537783D786
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78512299F55
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B7121A0E;
	Fri, 26 Jan 2024 09:34:13 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5768B21A05
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261653; cv=none; b=VMzWdBv85CjRysUlDWyWk5RzhsKtFs8QHq978m/mwYTEop+V3imqPhrx0blg/pfQ/c2YGsW6M5opUT0uOAF4OP2UusHMPmpwYYUtAWLmfEGJQFssJZGrcgjmEgOGjijqhVAfoVEkvKH8cXcGQIiNXDvuz00steaN53Hv/+Gd9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261653; c=relaxed/simple;
	bh=pm6DmcB6Xevi9+8K41DwzDSdkrHIT1yqO0/FwWchEQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+UiVa5wT3ATSVXnOW3olOYkanMvaixzk7ZhZTY7+BnMavER75osE4vRZT4yQLshZlXqA0hwbXYOVbwH0W9/ubpeEeJixUux97gRLhUm7sOnC5rYaJ1NWVczazqrro7dnKh7+0RypVY9smT/xOM9MQAeNReNjNU5R6QuGyRLM04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a298accc440so29065366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:34:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706261649; x=1706866449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4m7ei5V0+8cvO6yteUGltVZjJaFEngTKa3PCSMprx9o=;
        b=IB6UGh8LYY0ihxjoODMxCzW7PwyRkL4lK+SYVNleHyLZLTZ+YaVl0yoPuJJ8GQANJo
         vghJbgGgcMlOoxqLOhfbTtsxqVTeASW5VCZqyNbYWE+6sMcdVbj0BtxZO5ZMfqBWZPPN
         PzFptfH8LM6vrIrEcCa8SXb11qUVtKQ+PzFBeqbXn6O+9QTOdYowWk4bZXYe80xjGgX4
         yQay8HvjnATaSVi3PEnXDyeAXX7RuQvLHn8blMGaHElDUKcSLoI24pg9OX17eIOfBVXP
         t2i1aJAGXU+tq4XWqic59/WxMUVz4s6hVVouoqXlgomfuGXfV6ga36KSj5+PCHgr8Wjt
         4dhw==
X-Gm-Message-State: AOJu0Yz5rTjgEuQl9bxOAMf1moFhCqrg4N4S/ZaioSyJ14rYwVc4HQ94
	3tDdSKoT4dK+KQ6CIt7wyUHUgxYwHjMhxwWuWk2uZ71lSkAb3vII
X-Google-Smtp-Source: AGHT+IFiFqHRN05Fupqkxzl6myPgAkVT9+6JV+1X7V35QfZInZdYcrG4Xl0151863URCS5odbkR2aQ==
X-Received: by 2002:a17:907:bb85:b0:a31:1f94:70c2 with SMTP id xo5-20020a170907bb8500b00a311f9470c2mr947253ejc.69.1706261648908;
        Fri, 26 Jan 2024 01:34:08 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-117.fbsv.net. [2a03:2880:31ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id ku17-20020a170907789100b00a32fb8e79e1sm423912ejc.65.2024.01.26.01.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 01:34:08 -0800 (PST)
Date: Fri, 26 Jan 2024 01:34:06 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+a1deb5533794ff31868e@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	muchun.song@linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] possible deadlock in __unmap_hugepage_range
Message-ID: <ZbN8jvab1Orbu/Ui@gmail.com>
References: <00000000000063895c060fd59596@google.com>
 <20240126012540.045d8521de02fab64f3cbf78@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126012540.045d8521de02fab64f3cbf78@linux-foundation.org>

On Fri, Jan 26, 2024 at 01:25:40AM -0800, Andrew Morton wrote:
> On Fri, 26 Jan 2024 01:04:29 -0800 syzbot <syzbot+a1deb5533794ff31868e@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    8bf1262c53f5 Add linux-next specific files for 20240124
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1218a7abe80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=ff4b59a824278780
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a1deb5533794ff31868e
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151a9cf7e80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164b70cfe80000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/7696d711072d/disk-8bf1262c.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/92cd47c28072/vmlinux-8bf1262c.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/add5c7493418/bzImage-8bf1262c.xz
> > 
> > The issue was bisected to:
> > 
> > commit 947b031634e7af3d265275c26ec17e2f96fdb5a1
> > Author: Breno Leitao <leitao@debian.org>
> > Date:   Wed Jan 17 17:10:57 2024 +0000
> > 
> >     mm/hugetlb: restore the reservation if needed
> 
> Thanks.  But moments after I moved this into mm.git's
> mm-hotfixes-stable branch, in preparation for upstreaming.
> 
> I have fully dropped the patches titled
> 
> 	mm/hugetlb: restore the reservation if needed
> 	selftests/mm: run_vmtests.sh: add hugetlb_madv_vs_map
> 

Thanks Andrew. Let me investigate it. I post as I find what's wrong.

