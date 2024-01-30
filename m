Return-Path: <linux-kernel+bounces-44948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D662842951
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332011F279F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F0B128379;
	Tue, 30 Jan 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijtKg/qp"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447911272C2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632088; cv=none; b=L4zz22TZW4s7gNTE5FEqXxE79uH8IkpqQKqxoUoziREgKI6OBdGn05EfgZh8jbvfHRl7kjwDdueQLxlYegNcOq89SyKpxbl0Q1yxdAVAejaulPvkf3f3ZBHkNKtn9PR4O3i3aNZjA0OpzFNcGpURtdxz3JkmKoBoJbHM3JtrCQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632088; c=relaxed/simple;
	bh=lZ2QdKsKANiIGhW7Io639hVF2FfyxCTuzxzpjUE1bgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3u3zGavGGbz4thGy9a/SBoKl06nCRsKyjjZF/I33bgeCmQjYwcUA9eNS6badheGNEesdJnG+6BvCVSw4dy334ZdJLdoY7V2wSEMQFXG2Z9s6gbajlW8rA/+ohlGlSZJeGfoAC8qCXNOcw2oiPV80FYNGIRD7f/0uLRmSnqnW8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijtKg/qp; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3637849122dso7278105ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706632086; x=1707236886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGF9L+rs+xHCa+3li1td7rVlO9eeL6/0jDOgKgH81yc=;
        b=ijtKg/qpz3lvMsZ8ACyJBH55mFbiygfsfZy77/G61N0QB+igWbjuPSZRIQw6QhRgV/
         maZARUVes+Zf5hLTy+BXSISAHRxEDfUCfcsrNnXhst3rgB6Owy/oKzpImGH2vpK5deig
         OZEFAFsTnR/xSsu0cAovhEcaYqXZyVKvFMmApA0qa7WH7hISYy+4hmubVDsKxq+ZgJ94
         slP+7enIWn1aQjNY5pebIObhqC9u5iK1hcbxpNCOqMuIpCe6ZMnzPl1ydEkVvFEedJ4U
         MRTf/YLhImLRpfKq/p4JhHbUsHMxgCiZtRlmlkWYT0H3EwPCg8sS8pb+4Ndx8TQmasjv
         KUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706632086; x=1707236886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGF9L+rs+xHCa+3li1td7rVlO9eeL6/0jDOgKgH81yc=;
        b=ufIQ7ulSnNabrhKUmBNadz37/c/SmlGJ5VsJSPaU1Re6bqZQ9tMaDIydCqg+U10jQi
         4B6hoSXESS5+AeY6HcyYkvGRVrdJq1ILpSWG0ENcUOu7R2M+27cBdRQ9muo0dRULJ+Eq
         jG7r2/wYrkjWs6BPUTaPLcvZS/QBfHIPFonlESyx/hNRVnjVCwHqdtWz8hSiO1XxE1xX
         F0lnm3yX36kgdonTAmk7DJBPTS+Xq9R4DRZze15/bK3NErkN4jUQOuLRCNEKBgaFKd0Y
         23EBN0LurkL9iFZRS47vn2VSRgEGVP7z5DPPTeoL0CqhviCgoyD+og4P4Bb+ldDeekHV
         mdyA==
X-Gm-Message-State: AOJu0Yzw5KF+AtA6nRvzFfkQcNSoj1mAI8OrY7rZv4h+ktvwG1CNXHTx
	7OJfmHQlBbdQ+Q8A2tYjyVjBJhKPbsmKJtMJejmB+DH5KY8Z3BlFO+tPlBIaXK2jpNAlDzNelDC
	c6NMkriENuhOyzz5bArkrwLe6Z8M=
X-Google-Smtp-Source: AGHT+IGJiL1hY/anTy3fqAxN3T5sfeCNfKYpqUFWVfQ4aoaVcIsjRXjxWAMglDZEw0Rw/T8zmBp8yOtng9mKS0YaiBM=
X-Received: by 2002:a92:c74d:0:b0:363:812b:3d4b with SMTP id
 y13-20020a92c74d000000b00363812b3d4bmr5889525ilp.16.1706632086373; Tue, 30
 Jan 2024 08:28:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-5-hannes@cmpxchg.org>
In-Reply-To: <20240130014208.565554-5-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jan 2024 08:27:55 -0800
Message-ID: <CAKEwX=MjJRaHKJYELY7JtqPGxACMvpDp_bFx31zR68XeYZGsng@mail.gmail.com>
Subject: Re: [PATCH 04/20] mm: zswap: warn when referencing a dead entry
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> Put a standard sanity check on zswap_entry_get() for UAF scenario.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/zswap.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 9f05282efe3c..0c6adaf2fdb6 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -542,6 +542,7 @@ static void zswap_entry_free(struct zswap_entry *entr=
y)
>  /* caller must hold the tree lock */
>  static void zswap_entry_get(struct zswap_entry *entry)
>  {
> +       WARN_ON_ONCE(!entry->refcount);
>         entry->refcount++;
>  }
>
> --
> 2.43.0
>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

