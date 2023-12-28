Return-Path: <linux-kernel+bounces-12817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BA981FA64
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 18:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE7C1C21E14
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2504AF9D3;
	Thu, 28 Dec 2023 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VGVL2mLa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3283BF9D1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shakeelb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6d9a003ad63so1416325b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 09:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703785488; x=1704390288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65JQ/neOF7E3BZSaK6HoyZ6K6WgbLqHeOrTyvZc9PLU=;
        b=VGVL2mLa0NYXoyQxoXwA1ILkN5ZYYniIRHMkCCNCG5uRRS9uR1hW3VX4tNjpYn684t
         NBpJMaXeoUCWbPmFi1nVomQc5NQZofjjkm57XymvNTwXwLXkYqm9gNn+2NW1Ye2dpLeE
         QEQUOSirHs21rGxQoboWsvMZIazvXTdXhk7KCJVJra0CL4vbjC09GXddMCTaLj7oWnDV
         Lhg2C3vA0sfi/ZyYotnFfdqyAEVZDQq3ql7FosjEIy1DtEgozV3NoB0pZEF/5fUp0n1s
         hcYBAK8p1z7ZUZ68ozeySvAsypJBPEWmFEFPOVE1GxKmwI3pz5I/EJTDC1MJCFESzlG3
         Q3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703785488; x=1704390288;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=65JQ/neOF7E3BZSaK6HoyZ6K6WgbLqHeOrTyvZc9PLU=;
        b=NBMo6B3Cft+75sPblcjiSqZ+kfVdJJvEvafP8SxzUbAi+IhqT0SAq/5ETASqZ7KF9Z
         BDQjoc1+pBwvjX/J+arSy0MDrRT6eHA4PJ9xqPEIbY4PxqJtshmKuYhBs/ALqYVxi8uP
         OLXwfNTZCZaVJDxvOr/XwDNjEhdi1j70bSbZjsK0oLdwDpxMvA8IY1pRVVKSvkIsNLox
         qYQ5myj11H8uxoEqyS/q03tThqb2ilWA50xxz5Vfs7D2RCxPYyeDwGyXGEJk4xm7A1vr
         e+FZYC/RPD7M1axYVuYJ1233ftGDGaJcFBm/SNUJ3KJScvMokz9mt4frLyf3nX1W0pvl
         HL8g==
X-Gm-Message-State: AOJu0Yw99rSeaPgFnBCDz9nxr4lQWpmZTvtFn97CB/wtx5iR8BK4wqxB
	2RfcaaQEkArdAB1Lp1BJc5RTdvIdTmsy8qYFSjsY
X-Google-Smtp-Source: AGHT+IFb2CXNnGtVi7vAiAt//7yCV6ai4yoXf39E1uk/GpboNY4ZFW1gXuKJl0CU1VDUIGOLxEfybw/xpppznA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:aa7:8592:0:b0:6d9:f3b5:2d4 with SMTP id
 w18-20020aa78592000000b006d9f3b502d4mr22538pfn.2.1703785488525; Thu, 28 Dec
 2023 09:44:48 -0800 (PST)
Date: Thu, 28 Dec 2023 17:44:46 +0000
In-Reply-To: <CAJD7tkbqtrJqD9=5f-ZZBcWyX9t-e=fenJdDU5U=GDpbbWrzrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231228073055.4046430-1-shakeelb@google.com> <CAJD7tkbqtrJqD9=5f-ZZBcWyX9t-e=fenJdDU5U=GDpbbWrzrw@mail.gmail.com>
Message-ID: <20231228174446.6jakusrp7272y3ze@google.com>
Subject: Re: [PATCH] mm: ratelimit stat flush from workingset shrinker
From: Shakeel Butt <shakeelb@google.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 07:13:23AM -0800, Yosry Ahmed wrote:
> On Wed, Dec 27, 2023 at 11:31=E2=80=AFPM Shakeel Butt <shakeelb@google.co=
m> wrote:
> >
> > One of our internal workload regressed on newer upstream kernel and on
> > further investigation, it seems like the cause is the always synchronou=
s
> > rstat flush in the count_shadow_nodes() added by the commit f82e6bf9bb9=
b
> > ("mm: memcg: use rstat for non-hierarchical stats"). On further
> > inspection it seems like we don't really need accurate stats in this
> > function as it was already approximating the amount of appropriate
> > shadow entried to keep for maintaining the refault information. Since
>=20
> s/entried/entries
>=20
> > there is already 2 sec periodic rstat flush, we don't need exact stats
> > here. Let's ratelimit the rstat flush in this code path.
>=20
> Is the regression observed even with commit 7d7ef0a4686a ("mm: memcg:
> restore subtree stats flushing")? I think the answer is yes based on
> internal discussions, but this really surprises me.
>=20

Yes, the regression was on latest mm-stable branch of Andrew's mm tree.

> Commit f82e6bf9bb9b removed the percpu loop in
> lruvec_page_state_local(), and added a flush call. With  7d7ef0a4686a,
> the flush call is only effective if there are pending updates in the
> cgroup subtree exceeding MEMCG_CHARGE_BATCH * num_online_cpus(). IOW,
> we should only be doing work when actually needed, whereas before we
> used to have multiple percpu loops in count_shadow_nodes() regardless
> of pending updates.
>=20
> It seems like the cgroup subtree is very active that we continuously
> need to flush in count_shadow_nodes()? If that's the case, do we still
> think it's okay not to flush when we know there are pending updates? I
> don't have enough background about the workingset heuristics to judge
> this.

Not all updates might be related to the stats being read here. Also the
read value is further divided by 8 and manipulated more in
do_shrink_slab(). So, I don't think we need less than 2 seconds accuracy
for these stats here.

