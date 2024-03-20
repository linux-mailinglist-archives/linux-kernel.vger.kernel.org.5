Return-Path: <linux-kernel+bounces-109366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A026B88181B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398DA1F239FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7D485655;
	Wed, 20 Mar 2024 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gdbz4OBe"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753325026C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710964002; cv=none; b=nAwbVWWx8KXjyzAGN2MbRnYE34+eBcJPvxMpUBJjMpU2VnJZqAFaZK7jIlH7X/Z5Kn8jlhqg3dSE3DwI1RAX1Nh9qhMUno5RPVm4yiHp8W5bLR29grVZiWKdfgcM8w8bfM1A1AKtcnGzkwXbzoQYzgrULEVC1A8eriOfc7fI1Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710964002; c=relaxed/simple;
	bh=XrEzq6bloqFAKXeMdsNDdUP3x8FUbwhce87927qkd+w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N0MrqaYtKqSOEulzBfCrfaSeNDpTFtKnrooGqFL8sg9GSnoKVA/EGBDrEgH+mH/Y27OLenNMCmqbQmb3+j9ElmEwfPaYAj7MqrVuRIj+FMDSNBccCkptJ1h9aIU459sZbejeRtgTOBSZ3Owh3gn+30uod+vDD606m4kqDCo5A38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gdbz4OBe; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608ad239f8fso2981057b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710964000; x=1711568800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrEzq6bloqFAKXeMdsNDdUP3x8FUbwhce87927qkd+w=;
        b=Gdbz4OBe/Q4lt6LHkIGIg4Ii8mru77ms3HHeUJMvg3euKZGAdl1hG7HKlCbnreLdQw
         UDqwZPgBxSipXW+VQkZa3xrmpL7KtpVCv4es07MxJ0Z+CIeVkTkQ/fvJPdrqx6Kgw+iR
         JU2VV2MotjgIqHRcKQG1alrHC8rN/IbTfAH3l3fuKe8m8A7lb3JjrVNBTL/hmCyEAcPA
         +P0sWJMiuCw//R7Vr8hO343j+ig5efsVUiFz4DSYMd+eCaU7esIuJHwJz4U0x4kZCa3W
         bagHP0woTX+CGtioTEaCchect1mVGzdkq9EXGcwq5Q9LlEkIs41KBcihewnwHiANJsTq
         AZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710964000; x=1711568800;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XrEzq6bloqFAKXeMdsNDdUP3x8FUbwhce87927qkd+w=;
        b=hp5mIy0DxLlOi6qICB7JS2jkxeaGE23FipURSIOBRojPvEd2ERugwIpLfSDzEp+8el
         qPiPn8BNcOtcQQjO2F3EjH2LT19pecDMmTGG1PmuoXjo/lfLKsZfo8n8zMM+xGif+/T2
         tx/nSnjuT+ZEqzmD8Q/4hDfy84T8H8GNA/OoCr8hhnVbIMo9NzpxnmgfigkOlloQqNNn
         /uT6yqliTQu27J+0hbGf9Tw4ZjV26Hefb6I9Fbr0roo9q+LgM+MmMq97Q3djB5QE/ml8
         qnJqhQLpbP5+41h03AERghC5YSLLwHydUJu9ErjDFkwedfcb1m57QeNpz6Y4sYYJ1XFK
         wFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7H+PL8XsMISH/ouDbYfVMdlgsAxUa/kfZLWD9LI6U3A6mjnU4vPa9s3mvDeep7rcZHVBIwdai3njGL/1TU4919NefE9BrBrB2mQvR
X-Gm-Message-State: AOJu0Ywof9TBHfA1pbBkLTvVhcYFT5Mpc/eqfEDXU4vlXtYP1S2S80jZ
	P0vx7XsZvRIAIUaTZmAQ4mv0RmjjDmEDp/TFNBYby2gkXWCEyQDzwWXZf182iO/Q5zQ+B9Wz/0Y
	aLyf/1X+/yzwLGIeUWA==
X-Google-Smtp-Source: AGHT+IEUTHvL7ops/yDEmsyCXTNTxscb7Xm4n1jWorxuCQwiXOuUfKaDdr58boqVN6ULIKJYdnnD6rt71Uj2N+9f
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:4847:0:b0:60a:16ae:38ee with SMTP
 id v68-20020a814847000000b0060a16ae38eemr4307414ywa.3.1710964000440; Wed, 20
 Mar 2024 12:46:40 -0700 (PDT)
Date: Wed, 20 Mar 2024 19:46:38 +0000
In-Reply-To: <CANeU7Q=AXzG05BPcKPJvMDzmc8QK4UDKz+zaLQAx=RCrcsBkVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240319-zswap-xarray-v7-1-e9a03a049e86@kernel.org>
 <Zfp-iWaDfqeCOElt@google.com> <CANeU7Q=yxf0dnerTOZfe_ioeCbjnZd2Fpb-szvW7-Q1BzCUpOw@mail.gmail.com>
 <ZfqPK7AVunq2SC1l@google.com> <20240320100803.GB294822@cmpxchg.org>
 <Zfs06maKhjH_gXqL@google.com> <20240320192558.GF294822@cmpxchg.org>
 <Zfs6TP8pdmNHcDfA@google.com> <CANeU7Q=AXzG05BPcKPJvMDzmc8QK4UDKz+zaLQAx=RCrcsBkVA@mail.gmail.com>
Message-ID: <Zfs9HjKzKlw6qGjb@google.com>
Subject: Re: [PATCH v7] zswap: replace RB tree with xarray
From: Yosry Ahmed <yosryahmed@google.com>
To: Chris Li <chrisl@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Nhat Pham <nphamcs@gmail.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 12:41:48PM -0700, Chris Li wrote:
> On Wed, Mar 20, 2024 at 12:34=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> > > you can expect it to be coherent.
> >
> > Fair enough, but don't we still need a barrier there? Couldn't some
> > initializations still be reorder after zswap_lru_add()?
>=20
> I am under the impression that the lru list handling function already
> handles the barrier. If an explicit barrier is needed, wouldn't all
> other lru callers have barriers sprinkling all over the place?

list_lru_add() holds a lock, which implies a compiler barrier. I was
wondering if we need smp_wmb() to prevent other CPUs from observing a
partially initialized entry during writeback.

I am not sure if the list lru makes such assumptions about the need for
barriers.

