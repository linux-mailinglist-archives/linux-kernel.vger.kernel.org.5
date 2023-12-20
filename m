Return-Path: <linux-kernel+bounces-6633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C20819B40
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8381C24E72
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018C51DA5D;
	Wed, 20 Dec 2023 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYZs0GOy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9151DA27
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c690c3d113so4168093a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 01:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703064030; x=1703668830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSahWqN/XPOUg/6X2/I93IlKLYoJC4R549QbBR0j2hg=;
        b=PYZs0GOyW5xpvMBErtRlGAX9+WNeMfPD3pv2XFPVGvcXDVSUbkLzHOsyQuRcuEogTg
         CdiS79jEVONDz2FkSYgdTj+oaH6Aa3Tc9hrdnUWc+6v+T7wY/Y+Kmkpcf3SRUFTSsRDM
         KI01+7uScjsKTwv67S03x5qraeBW+YY9pBZj0U7cWUwRKv9lotWSCNJapyOaABBflh/N
         /EvsWcHccxoBYlsbKFBpPULmTnJsRYHIGM3k4QPQ+1D9p33s9SPJp4ZcHV91y1f+kdAn
         FwxZQy1zTXewyX9BPCLUcfj/EdF0zsrVPB1UkmvQvVtY7MV5tZOXuglDvcf1XXPFHY1G
         xsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703064030; x=1703668830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSahWqN/XPOUg/6X2/I93IlKLYoJC4R549QbBR0j2hg=;
        b=BKEn+FO/2dRPNphSvn2U6Lp/36lHL+rHGVhiEPeCy+6c+BmU3yDDjCLpXDvvG6id90
         GjdfOycYTx7SuQ+5WzEh5ZwOEITSyQmZp6J7x0a/PGbQo04iV5OuII/Hv81Zhz2VmH/z
         udVLUXdRNOKl3jU9ArvVaZhdJIBqI3sFEZaM2xDRIQQ9pXTPq+pVPoE4B/L8NW25RR+7
         VrWVcs/OsDD2TyCtyM23NGpnogZbxPAOfSZr7XQ605zvMkGEYqARHW5B6A5R9Nhkd59F
         eHoasapleVfrNKg2QFibqaEJkIZGdJJjJKkbSojaTKLWQvEKHZCMpVrUPdxZVY5lnTt3
         SDnA==
X-Gm-Message-State: AOJu0Yw9wKTTL1FVEhBztR32PyLPkegIEwPLZ4yr5fpBCoGqFRigvNBl
	b9ySq8d9JZ568iRS7i7lZL/ZMghcEtRXK7mKTrA=
X-Google-Smtp-Source: AGHT+IGcm+TBuVgueD5L9DlG3jGDvL5lIcWYMNhgPuLZ6k/AlS6qHfq9/cDETn7O2+oBzTWhPyGgC1+zJJBmSrxBNyA=
X-Received: by 2002:a05:6a20:7b21:b0:194:a26a:15a8 with SMTP id
 s33-20020a056a207b2100b00194a26a15a8mr1971508pzh.23.1703064030213; Wed, 20
 Dec 2023 01:20:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220072529.1036099-1-tj@kernel.org>
In-Reply-To: <20231220072529.1036099-1-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Wed, 20 Dec 2023 17:20:18 +0800
Message-ID: <CAJhGHyACBBW5wnYTTz7S+AgLMhLYOsfxTnN6VHodCgECqEFeEg@mail.gmail.com>
Subject: Re: [PATCHSET wq/for-6.8] workqueue: Implement system-wide max_active
 for unbound workqueues
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 3:25=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> A pool_workqueue (pwq) represents the connection between a workqueue and =
a
> worker_pool. One of the roles that a pwq plays is enforcement of the
> max_active concurrency limit. Before 636b927eba5b ("workqueue: Make unbou=
nd
> workqueues to use per-cpu pool_workqueues"), there was one pwq per each C=
PU
> for per-cpu workqueues and per each NUMA node for unbound workqueues, whi=
ch
> was a natural result of per-cpu workqueues being served by per-cpu pools =
and
> unbound by per-NUMA pools.
>
> In terms of max_active enforcement, this was, while not perfect, workable=
.
> For per-cpu workqueues, it was fine. For unbound, it wasn't great in that
> NUMA machines would get max_active that's multiplied by the number of nod=
es
> but didn't cause huge problems because NUMA machines are relatively rare =
and
> the node count is usually pretty low.
>

Hello, Tejun

The patchset seems complicated to me.  For me, reverting a bit to the behav=
ior
of 636b927eba5b ("workqueue: Make unbound workqueues to use per-cpu
pool_workqueues"), like the following code (untested, just for showing
the idea),
seems simpler.

max_active will have the same behavior as before if the wq is configured
with WQ_AFFN_NUMA. For WQ_AFFN_{CPU|SMT|CACHE}, the problem
isn't fixed.

Thanks
Lai

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2989b57e154a..d0f133f1441b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4364,8 +4364,16 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
                        ctx->dfl_pwq->refcnt++;
                        ctx->pwq_tbl[cpu] =3D ctx->dfl_pwq;
                } else {
+                       int head_cpu;
+
                        wq_calc_pod_cpumask(new_attrs, cpu, -1);
-                       ctx->pwq_tbl[cpu] =3D alloc_unbound_pwq(wq, new_att=
rs);
+                       head_cpu =3D cpumask_first(new_attrs->__pod_cpumask=
);
+                       if (!ctx->pwq_tbl[head_cpu]) {
+                               ctx->pwq_tbl[cpu] =3D
alloc_unbound_pwq(wq, new_attrs);
+                       } else {
+                               ctx->pwq_tbl[head_cpu]->refcnt++;
+                               ctx->pwq_tbl[cpu] =3D ctx->pwq_tbl[head_cpu=
];
+                       }
                        if (!ctx->pwq_tbl[cpu])
                                goto out_free;
                }

