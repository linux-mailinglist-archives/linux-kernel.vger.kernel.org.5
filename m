Return-Path: <linux-kernel+bounces-9744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4545481CA9C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43451F24EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AD4199A4;
	Fri, 22 Dec 2023 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djF4ytLB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C1F18E06
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28abca51775so1134477a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 05:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703251243; x=1703856043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WT4MjJ9bS77O5qTpD5figlXHQdMav7Y2fGf4WbcZiI=;
        b=djF4ytLBHYzZBBXVlYcWehnbyO2HkxiBg2qtm9Bi4aHEXA8PE+84DcJ5Yd+zyQyhYS
         pxHKuT4hQLMR0yOMyeEgbew6/myrN4bh54lk/brPW7YMxufJQo0MFUaXb0cq4Bsk11RU
         F4B6zOiedqfrijpH3yrmceQ3a1lsT3cJGp1R5z5ziOUtC0nHLXyMAq1GFagzmgOR5iDS
         DtPiRKCAlDTAb7RrvWw9YFrELTvdOi8o1P1OMP3UX+d+vI6h3x7zdkUd0lhg5DCuT+RX
         El2qTmq7TvFRihDscGX+um4kyPKgRFp/PKR/birvR0NGe6OtTUWcHSRHDbI06E23endc
         APrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703251243; x=1703856043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WT4MjJ9bS77O5qTpD5figlXHQdMav7Y2fGf4WbcZiI=;
        b=VI08croSS6b+eybMNcaAlkkdAluiWH0BtLgcRC5Ii8/Q/dp+BZhFd6qN/LvH6ONp4k
         4f+VpDZZ2Qpx3DwGbMnuum/swz5GP17hARJUUdtuIn7yb4Z7uKwI75FTq8JXd3RAIiEk
         Skir5X7wiZ75mjMyCc7fevGLismKGrLkp3QF/pRbh15N0su9NQVdo/hK0jvKY+jfHZRz
         85fuVDvKTgnTeCS0ie+6ISkgsUYpgBB2iLykZykwxQBGouMCUGglQC3S6bSA4Eb9Aij7
         +Eh5ahplXx8bIyUN4k7qiSeGgFn1RXHL/nkFd5x77yAapQ374yKdkQ4ZrssowzYf6Br4
         n1cQ==
X-Gm-Message-State: AOJu0YwElpDI5/c/o3pvpZJTcP8bzJeG+Uz0J37ky5Pv9yOQv9cDPbRk
	ZSiGBlE9WpSLks0grYYVCLSx3bKgLZI=
X-Google-Smtp-Source: AGHT+IHwN7ttdc36kO6cjjpCx99jIHOvvfzu+69mfoVOfHGuh6eea0V34pCRS+MxhMLrxr3KkHUItQ==
X-Received: by 2002:a17:90a:c213:b0:28a:dcd2:7bea with SMTP id e19-20020a17090ac21300b0028adcd27beamr720337pjt.32.1703251242835;
        Fri, 22 Dec 2023 05:20:42 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id y21-20020a17090ad71500b0028b43d3250csm3563166pju.43.2023.12.22.05.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 05:20:42 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: akpm@linux-foundation.org
Cc: bhe@redhat.com,
	ebiederm@xmission.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH] kexec_core: fix the assignment to kimage->control_page
Date: Fri, 22 Dec 2023 21:20:33 +0800
Message-ID: <20231222132033.92651-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221141258.7113f9b2599ea6d3b6638e08@linux-foundation.org>
References: <20231221141258.7113f9b2599ea6d3b6638e08@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Dec 2023 14:12:58 -0800, Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 21 Dec 2023 12:23:08 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:
> 
> > image->control_page represents the starting address for allocating the next
> > control page, while hole_end represents the address of the last valid byte
> > of the currently allocated control page.
> > 
> > Therefore, after successfully allocating a control page, image->control_page
> > should be updated to `hole_end + 1`, rather than hole_end.
> 
> Thanks.  Again, please include a description of the userspace-visible effects of the bug.

This bug actually does not affect the correctness of allocating control
pages, because image->control_page is currently only used in
kimage_alloc_crash_control_pages(), and this function, when allocating
control pages, will first align image->control_page up to the nearest
`(1 << order) << PAGE_SHIFT` boundary, then use this value as the starting
address of the next control page. This ensures that the newly allocated
control page will use the correct starting address and not overlap with
previously allocated control pages.

Although it does not affect the correctness of the final result, it is
better for us to set image->control_page to the correct value, in case it
might be used elsewhere in the future, potentially causing errors.

