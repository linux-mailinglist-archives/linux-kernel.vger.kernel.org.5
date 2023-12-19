Return-Path: <linux-kernel+bounces-5021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8712E81856F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18F1BB242F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4A3156E7;
	Tue, 19 Dec 2023 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AH0bHB93"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E0156C7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3e6c37a61so392555ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 02:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702982375; x=1703587175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXUONicHDrcXn5yOmVQBBsRw7TDnkiEQtlJXRIcG9Q8=;
        b=AH0bHB93/dc509HkQP/p70rqqqMkrnurtgRIfXbqtW8uSm7K4MSbplZFOXG12mnl7t
         SLrPa6y0Sxz0ArzV0/o4FMv4yCxmOoKean6dSDUhr/DqaSRyOf54EMddVboo62QdKJUc
         oc7wz9d/tkiqNA9NeqeiIBcaP0Xn6Y/SIq0IAmrjXc1b5HDONSpSTnmrCNbMlrLMJDRa
         pMoPaUrl3iDX2LUnsAyCgbzdHpwKh7HNwYOiCU0ULR/YrmDZZLGsdoBUerNJPYb5M07I
         y9rmNoGw3JgvmTtuJ8vVdqqbzshCxTVsqyRYDx2Jcjwz6NdZ0LjLt2qLdYxsWsU/pI0C
         J2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702982375; x=1703587175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXUONicHDrcXn5yOmVQBBsRw7TDnkiEQtlJXRIcG9Q8=;
        b=btF+uRjhE1cP/iDW3g7MgYgAgkD2fNPEqJO/9zV/TuoLaPxzHiwFKkTUSJjwnNSuAr
         vl6VtoYsp+6J7PoN+zrq3sAVyQz6DOU0SX29+RvpxSB/XsWIb0iY52bJ7f8udnL3UacB
         tOVKyaTlFKAVacMa3Bx2hVwWKgZ9LYYCJLVFIWQOfxJDssNYBPt7SRMCykDEGQ1pBC1C
         kfB+fi4/kgEaKIdyz4bNepPB4QK+Wdr363HtQs9Iv0G81w9WWwEvRinfGirgEsaD3n/k
         /D9RqZo8Pg5n+trq/Ewp32UKEcqLXc2tDP5RQcEE+FWSq6y8MYKpEMZCVP27NmLs8XPB
         1VtQ==
X-Gm-Message-State: AOJu0YxRwcK3mQk/Vp9X9eaOQKas/IYBR+3pi9iKK/cFQsjbbUaEPnCf
	CHEPQiM30GI8xW5m+AvNLpQ=
X-Google-Smtp-Source: AGHT+IHzn7jtRZjLFf7llLDQqbmYYVqic2LjPkkfsmtJexRIP78IR7QcPLBoMzDzJU7tNKmPDJcZIA==
X-Received: by 2002:a17:902:76c7:b0:1d3:45b7:bc26 with SMTP id j7-20020a17090276c700b001d345b7bc26mr5472819plt.54.1702982375065;
        Tue, 19 Dec 2023 02:39:35 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902ed1500b001d3ad367fb4sm651369pld.155.2023.12.19.02.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 02:39:34 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: fuqiang.wang@easystack.cn
Cc: bhe@redhat.com,
	dyoung@redhat.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	vgoyal@redhat.com,
	ytcoode@gmail.com
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Date: Tue, 19 Dec 2023 18:39:28 +0800
Message-ID: <20231219103928.98465-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3765549d-892e-4102-9b56-9add1d0a8089@easystack.cn>
References: <3765549d-892e-4102-9b56-9add1d0a8089@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 19 Dec 2023 16:55:16 +0800, fuqiang wang <fuqiang.wang@easystack.cn> wrote:

> Thank you very much for your patient comment. This change does indeed improve
> readability. But as a combination of these two, how do you feel about moving
> crash_setup_memmap_entries() behind vzalloc().

I don't quite understand what you're trying to express.

> The image->elf_load_addr is determined by arch_kexec_locate_mem_hole(), this
> function can ensure that the value is within the range of [crashk_res.start,
> crashk_res.end), but it seems that it cannot guarantee that its value will
> always be equal to crashk_res.start. Perhaps I have some omissions, please
> point them out.

Because elfcorehdr is the first one and only one that allocates memory from the
starting address of crashk_res, and the starting address of crashk_res meets
the alignment requirement of elfcorehdr.

elfcorehdr requires 4k alignment, and the starting address of crashk_res is
16M aligned.

Therefore, image->elf_load_addr should be equal to crashk_res.start.

