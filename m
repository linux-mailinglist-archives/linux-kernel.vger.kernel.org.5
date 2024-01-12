Return-Path: <linux-kernel+bounces-24657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0450882BFD1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E760CB22751
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19F259B46;
	Fri, 12 Jan 2024 12:35:03 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BFA59168
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso67195857b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 04:35:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705062900; x=1705667700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2fE2I/CkNEhhUluiKg9277c0700OaK8BT2j8WWc7VU=;
        b=Pd4fAPcCMIgXnJ/XnFrHsdd+qReuXeQC+P4W4LHK4jjkh74C05rmAiGikLM6E1pmZP
         XhG17bmoDYQ+F1Z5embdJRUf9vWJJ3GVMRYe8K/84X8n52tdKfUBUnM+9DK38T/x3pRS
         HuYLjwFkC/FV2c/U5taVsW4NN0YwdOwxUoJsZsiAZ0otQPf+LwtIswaXnl0MxQ2niWs/
         FfemJlGxfrSkgLAuz9fdAY0u8U2XhzoDLAC0dSe1trDFJlCgXbyEMXfP9XC25L+UJVR5
         LqfTtVfltBpSiAjdZTqbv9xt4tHG4qmoZQEXrozueKUNoc57kMwTP0flKsaSLZc6MnyD
         IDfw==
X-Gm-Message-State: AOJu0YwGAh61njZdhrJAjaJFCJVb0G5ZO9wbLtkt1Kg3ZwIDF9eWqEbZ
	KK9izz/nKgsCgTedPQXIEm8Ywdkbs7ZE0Q==
X-Google-Smtp-Source: AGHT+IGH9LwRgCwbaczfrs6nG3ONi4rBKdrJC4TWwREfzGdFJ6Kq7Jk1bEtsjY0DeTGfPOj7tRMJPw==
X-Received: by 2002:a81:ac1c:0:b0:5d8:2b37:e085 with SMTP id k28-20020a81ac1c000000b005d82b37e085mr1180958ywh.20.1705062899986;
        Fri, 12 Jan 2024 04:34:59 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id fq3-20020a05690c350300b005e8f5b53d6bsm1258014ywb.22.2024.01.12.04.34.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 04:34:59 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso67195757b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 04:34:59 -0800 (PST)
X-Received: by 2002:a05:690c:b90:b0:5fb:c044:f087 with SMTP id
 ck16-20020a05690c0b9000b005fbc044f087mr1028761ywb.35.1705062899697; Fri, 12
 Jan 2024 04:34:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109214828.252092-1-tj@kernel.org>
In-Reply-To: <20240109214828.252092-1-tj@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 12 Jan 2024 13:34:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW4iYbi-cwGBZgiS72=hP9X9r9Tc_UQaYBAsC=KNox2dw@mail.gmail.com>
Message-ID: <CAMuHMdW4iYbi-cwGBZgiS72=hP9X9r9Tc_UQaYBAsC=KNox2dw@mail.gmail.com>
Subject: Re: [PATCHSET driver-core-next] kernfs: Protect kernfs_find_and_get_node_by_id()
 with RCU
To: Tejun Heo <tj@kernel.org>
Cc: gregkh@linuxfoundation.org, andrea.righi@canonical.com, ast@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tejun,

On Tue, Jan 9, 2024 at 10:48=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> The BPF helper bpf_cgroup_from_id() calls kernfs_find_and_get_node_by_id(=
)
> which acquires kernfs_idr_lock, which is an non-raw non-IRQ-safe lock.
> kernfs_idr_lock used to be a non-irq-safe lock which could lead to deadlo=
cks
> as bpf_cgroup_from_id() can be called from any BPF programs including e.g=
.
> the ones that attach to functions which are holding the scheduler rq lock=
.
>
> To resolve the situation dad3fb67ca1c ("kernfs: convert kernfs_idr_lock t=
o
> an irq safe raw spinlock") converted kernfs_idr_lock to an irq-safe raw
> spinlock. However, this was also broken as we call idr_alloc*() while
> holding the lock and idr itself uses an non-irq-safe lock and also calls
> into memory allocator.
>
> Let's instead RCU protect kernfs_node and kernfs_root so that
> kernfs_find_and_get_node_by_id() can use rcu_read_lock() instead of
> kernfs_idr_lock. While this unfortunately increases the size of kernfs_no=
de,
> it's the most straightforward thing to do and there likely are other plac=
es
> that can take advantage of RCU protection and improve scalability too.
>
> Please see the patch descriptions for more details.
>
> This patchset is on top of the current driver-core-next - dad3fb67ca1c
> ("kernfs: convert kernfs_idr_lock to an irq safe raw spinlock"), and also
> available in the following git branch.
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git kernfs-use-rcu

No more BUGs seen (with v2) on the few platforms I tried, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

