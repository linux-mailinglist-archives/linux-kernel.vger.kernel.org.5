Return-Path: <linux-kernel+bounces-43761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B08A84189F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3747B286257
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37DC36B17;
	Tue, 30 Jan 2024 01:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iBebQJ+J"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C9A36B1E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706579082; cv=none; b=QNHp2U8e7RBhxuPkfhqpJPCRfNGbWAAVJe3XyvrRFx86RX4xApID05tZ6KNuAqorXYE5q48/Iom6Lo/UmgVDXI+dG0+2OhFdyvk8ourZOO0njj+HlZ3aA9IxiWJwn+BnJceCkm8BUei7Ldn08mCO90UG3P/azz2ECOzxeoWqmFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706579082; c=relaxed/simple;
	bh=qGGdcouiCOTn3Xtx2VC0bbE/G1Gwmd8yM3HsETv9C0s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lGl4eyQ1dwornPqCQxfsIS6dToHXfzYEFxUCXNngALmpxW0tticAIRo+Dad/ZYZHVXoIJhteJYPW/TQZAT4enMa3JFUaoOYrHlutHL/FYw9g1zOIHzsHGavJ+bNdHMtuRjTOS/NYe1KNZAX9zqnm/8UouJe8LmIcfMhhFosKFKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iBebQJ+J; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60297bb7d44so64578087b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706579079; x=1707183879; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y1Y7vLTkmo8cyE0XH1YStz1wPF1Bx/yJQoozY6U5ttI=;
        b=iBebQJ+JRc7yAcwXfrUEMi8gARa7qw7aG+aTPC5oEHgMYs2EL1TxK+T4o0jgWOCXcc
         zm+bziIQ5cHrnk5m1xllu2+H3Z8NiE307SiVGrPPMTm+MOS9VFIH3vMKEE1H6X8oqhaK
         ka4FCEgr3LmH7FUTxsGlcqmrLjVDDsZpB+aGgPxuLB7dYhthAIxktliOwjBk656NFVEi
         6kNAERVRur1YvzM7dKaZIWVVZfZ82MMgDDxZ5Z/9Z34J8sH0qfSVHNrtykS4ehiK8KiU
         9WeHvTP3ruvPGnZE9RhZzaACWL4UQpK8FITsVJcp5Wp6lLlGu52mDAcOd5mgyjaxjQ+z
         LC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706579079; x=1707183879;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1Y7vLTkmo8cyE0XH1YStz1wPF1Bx/yJQoozY6U5ttI=;
        b=XBsC4HyQEx3vkrPaMDd7r1IdC9p6FhVDZHPgvQw/oRlXWf/hYBUWpAinecjeFJBcCm
         M6aI8fNTMud/COxFkSshmiuUQiR8Z6k29IcicigZTSR+VyVdX5kWHOE05oaucyh6gRs7
         QkfN/xjsZfuhtaZEVgHThbV4gfaWyTkqyLjXPlv7CaVaGfH1lGCn6JuFUEBY6v2e3UFW
         umhcd2SEaff9Vuo48vhsl2ySsohjwN0KFrAYnJPkYbkxwhGm3gO3rirBK+i5ehEGzr0r
         vI0DSRBSTRLi4yR8KOp8YHDXBfqPY/Z9a4dRe6+KsqzBR/4FJAYSlJlJ+aMD9dlxOqtZ
         grpA==
X-Gm-Message-State: AOJu0YwJ0MaKIb//V6X96UNKzOCm6c14X4W4upE7B8Dp60EPNkZ3D3q7
	ogzagrUXnv5Kbrd32YqdiwAdPxhEfnnV2iJ164GTCjEqpE06i0SU+a6e0CAQ9iOJYSa/yqkVtLG
	pbq+pYXg+OYGhznf6Bg==
X-Google-Smtp-Source: AGHT+IGyy9j0WVXdyAlRr7sgiCu+Mpt32BjEZHf0bFxVEhAafS8poK1FTjJc7/2OA3zVvwNPpzwQ4NYqU7tkOPeb
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:218d:b0:dc2:2af6:6ace with
 SMTP id dl13-20020a056902218d00b00dc22af66acemr2591033ybb.3.1706579079816;
 Mon, 29 Jan 2024 17:44:39 -0800 (PST)
Date: Tue, 30 Jan 2024 01:44:37 +0000
In-Reply-To: <20240130013438.565167-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240130013438.565167-1-hannes@cmpxchg.org>
Message-ID: <ZbhUhSLyNcTK0_gd@google.com>
Subject: Re: [PATCH] mm: zswap: fix objcg use-after-free in entry destruction
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 29, 2024 at 08:34:38PM -0500, Johannes Weiner wrote:
> In the per-memcg LRU universe, LRU removal uses entry->objcg to
> determine which list count needs to be decreased. Drop the objcg
> reference after updating the LRU, to fix a possible use-after-free.
> 
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")

Lots of hotfixes for zswap in v6.8 these couple of days :)

> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

Thanks!

