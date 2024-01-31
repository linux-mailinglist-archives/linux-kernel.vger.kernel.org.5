Return-Path: <linux-kernel+bounces-46707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515018442FF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44191F2521E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1BD86ADE;
	Wed, 31 Jan 2024 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="z6t67Rku"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3E983CD9
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714792; cv=none; b=Q9L0ihCMvDFkmmeJBTGoHen1vNLl1X/DiPLzHLzkkHxSCPk829HTQgzldsFtaD3Cf5Dn3LbxHnfyNZAF5ChgFZAW6YU/pMe78zcLWMScWhS6phLh25c8QrGxvxfpcBXwBb9nZqkNfOcFOmulZXSj1mVTLSLNk10t1zL6Uxhaa6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714792; c=relaxed/simple;
	bh=YhdqlDbRtVoCG49Fee1oryTXPJhRfqmt6BsqICmO8jY=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=uMyHHbvf//IZ5MGemv6PsXKGnXKjYoiP9oYMkx3JhNapSZcvzZKvJEdsuch0IY6tN+KeAFvmmXvYA6UGivWubaHnkXoOigbiuld8QqSCG17XZqY20yr2WCRIDrGQ2my/JquCZLkGqWKMnXcX8JZi8hwDP0dlF+taYRy8Wjfxitc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=z6t67Rku; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-290fb65531eso3090401a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1706714789; x=1707319589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tds5Q2huPOHh5n0mjSdchfbP7NOs95vZNLYyQQgzOVI=;
        b=z6t67Rku3HCNuAvRjqEWKVWi4w+Q9E8bnlGz12JJueh01lNB5PCDX1eqDnTSryiI8a
         nd9QrrvKxMO+dQ6vQZihqfP+mco15vcYGMKrh9gRpnzRrADbwyCJQd83up2lK7fqVpX4
         9y5zVEskEkrhYNRpzgSxBEh7348qAw4GKuo5DvwLVcAMuL2EwYHKXnwBWa6sThs4sT3X
         XHljwXdf8TxDjONzjLnX8cTP/aKv9+Eag/rVwTfduQE5l7WnmbCF2O988zM6Le22BE0j
         cZJv6qA8HnVcm2R+/mhqiRGHBpuBVQ1qhvB8NkhLzEGyW1ByI6ulyd3opO5d1Z6JVJw7
         OmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706714789; x=1707319589;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tds5Q2huPOHh5n0mjSdchfbP7NOs95vZNLYyQQgzOVI=;
        b=L9fkkYRDw4B0GpMCuHeR5Cq7lQyu3sY2tRTVhful7Uuy0rFoWqoFAX0MiTvrqgIvL1
         MLaBqC0rNUB2BgddGcawo77N9EaRJ15V22g6mZ88o/nTnl/MBgDuIEiso5rDs8mQ+NZT
         UmsHk5ecH7dkrtF/uU+UNR+RFADo6TlVq4eHMxcYcCeHYNvp9xxgzeY47NiXPidw5r+C
         gGJ8Yv1WhNapsceDouZOH6aKt05/VJ9wQJkh6MoO0uENBudRK9FCHopUcX8eXBs51CNW
         4s7Jf4ib6h5oM8SwBupzWTIe8ABX7OTXpb8cMxM7rlOIGcZp7ylPbx7b/+EAox3Kh5GU
         QuLA==
X-Gm-Message-State: AOJu0Yx2nhxgsAQvzX7cH/AG6AxVNINyQXuCzR/5IO8yBmkvmQMpNjLZ
	6wsNFMHpELPpAwuGTM1i+nFJy+LorSt9SRv4F/YSHHGmRdcqEIEPO3S2e7aaMx6xY3TU78ucNK8
	q
X-Google-Smtp-Source: AGHT+IFfWJ//NUV67mkLMGFxfKzr91vpMHCZHGXqpWMCKlsTGlW8qiZXLGaR4KKexvKCYnkkF45sug==
X-Received: by 2002:a17:90b:147:b0:295:c361:ed0e with SMTP id em7-20020a17090b014700b00295c361ed0emr1983339pjb.46.1706714789319;
        Wed, 31 Jan 2024 07:26:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXF0D4/vtHfCA+E8plMf07zXwOo0R46id9qg1+6NvqKj7MhoeMzbkhU78ODxyDJ/LwqPNwoS/nyWXP/oISgILhfRm7P1YEB89tDMtb18fRkA6CBNNvj9LxJ2KjhnQSpHcs+03LPysHMernWnhuLvBWTcuPvSw==
Received: from localhost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id pl8-20020a17090b268800b00295e3912eaesm1617556pjb.33.2024.01.31.07.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 07:26:28 -0800 (PST)
Date: Wed, 31 Jan 2024 07:26:28 -0800 (PST)
X-Google-Original-Date: Wed, 31 Jan 2024 07:26:27 PST (-0800)
Subject:     Re: [PATCH v4 0/2] lib: checksum: Fix issues with checksum tests
In-Reply-To: <20240124-fix_sparse_errors_checksum_tests-v4-0-bc2b8d23a35c@rivosinc.com>
CC: linux@roeck-us.net, David.Laight@aculab.com, linux-kernel@vger.kernel.org,
  Charlie Jenkins <charlie@rivosinc.com>, lkp@intel.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Message-ID: <mhng-f4463f17-6d60-4313-ac4e-2f00ba71df05@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 24 Jan 2024 20:37:23 PST (-0800), Charlie Jenkins wrote:
> The ip_fast_csum and csum_ipv6_magic tests did not have the data
> types properly casted, and improperly misaligned data.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Changes in v4:
> - Pad test values with zeroes (David)
> - Link to v3: https://lore.kernel.org/r/20240123-fix_sparse_errors_checksum_tests-v3-0-efecc7f94297@rivosinc.com
>
> Changes in v3:
> - Don't read memory out of bounds
> - Link to v2: https://lore.kernel.org/r/20240123-fix_sparse_errors_checksum_tests-v2-0-b306b6ce7da5@rivosinc.com
>
> Changes in v2:
> - Add additional patch to fix alignment issues
> - Link to v1: https://lore.kernel.org/r/20240119-fix_sparse_errors_checksum_tests-v1-1-2d3df86d8d78@rivosinc.com
>
> ---
> Charlie Jenkins (2):
>       lib: checksum: Fix type casting in checksum kunits
>       lib: checksum: Use aligned accesses for ip_fast_csum and csum_ipv6_magic tests
>
>  lib/checksum_kunit.c | 389 +++++++++++++++++----------------------------------
>  1 file changed, 129 insertions(+), 260 deletions(-)
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240119-fix_sparse_errors_checksum_tests-26b86b34d784

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

in case someone wants to take it.  I'm also happy to take this via the 
RISC-V tree, as I recently poked this stuff and that's what caused the 
failures.  Just let me know...

