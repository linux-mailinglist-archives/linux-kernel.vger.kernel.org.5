Return-Path: <linux-kernel+bounces-77316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D039D8603A3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5361F25811
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202ED6E602;
	Thu, 22 Feb 2024 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="XbDoxXo+"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976EF548F8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633680; cv=none; b=hO9aHy7ulHLTd5iONKTjdrdYaOBWKXsAJJ/RKFAhRU8RZhx0VUfyS6p2kengKHp44No4+5VSL8C7o9BocIX/Ttuzh76r0+1AVl7LDf+E5d74RdEhP3+OKevH5v42gRyCvbyAkGjPOFqjrV3SdrShhq3fbe1mHnuPCQll+TNzz8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633680; c=relaxed/simple;
	bh=avyuv3iKJxIAJhpGZWo/e1hMUT8XV1s0LLys3Rmf4T0=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=l3b1kiVSGoangZB12gFJhiS/Tu9xGbGn3rUlhjVzp5zgSMWqgBHNBS01GGBxPTrMak1A/XEdpVBcKOgBvIRaXE3X5G4is9M745xFABho33eIKmEkJX77yKVHrk2bzFbIOZpD1oSBUT0LNV6Sazm6tqRX2aOY3zqQz/xQN607JcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=XbDoxXo+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-299b818d63aso186278a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1708633678; x=1709238478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMkKetkZkINcK+p7xdjU7GTdwyp8HakTTA83cqYMQQc=;
        b=XbDoxXo+XX/XHECn6Pf8h2eWEnsN30tJJni4FdyB3iHR+L/r7GME2+1F/NJ6+PkHtJ
         dX+OedXpXx7+ifxwD61k/0Ebw/NJtFyuiAjJyFZsCXm4mAPzc72kqtpUVSAwXZY5WWu3
         400NAHhbtMnTZWAO7Xf7xt8fqJ3TbHrXIU/sSpbe+jIyyQcMT4TaJ7xHauaDN8PSvvPq
         Z2hUc9bIJJadVKkGW6Ty85mru8FNvfIqvOZYDUFhiN3UhJO5Fx2UM5vCfYypaSmHMv1t
         CvYYaXIOY38Jic3Wj1JmeG06lwLIqE48TD3V/Wzik1LtPTqkRzrYwNx+uGmj75g1siVo
         yqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708633678; x=1709238478;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMkKetkZkINcK+p7xdjU7GTdwyp8HakTTA83cqYMQQc=;
        b=uZwTo13yFaIihtv3cwIWuJwu6em0NUDPbxKKaBYPhiNqndbs7W8WEN4oYFzZqJXW1O
         XXaeUURwIiIfnL4FMLa8+s++5MJT5ztLB3aUSeL5s+FIIp1c1eK/cct6nWE7fuIhE1Ts
         dqFRsUqLu+SQSeE+E1lD4jJFLPMcf6XLSI9acBCnoVaZ0RJwE6l0jN8/k2gnLWsiYHpY
         B8IqmO9fH+gGb6bPPgBpAX9jHyssw3Ouic8KczpseBu0Pv5/ZcpyIg6LOJOsShJRcd/o
         THSn1fAqKVpF/UJO5bPSBj9Ray3QkIpvskNpCG/ukAFjXACGAdfmUnu2njAqcbClxyFV
         9UQA==
X-Forwarded-Encrypted: i=1; AJvYcCUzCsH9eiAG9ErQKoedeYf0cd6DHezQ3TmMKwnMCYQjCiOMUDDi9289/ZVduA9/2Jor0cmrtmLfaiOdFF4UHCbPMjPSLEDIPQlxGiph
X-Gm-Message-State: AOJu0YxxjslSwkc7ZZcyLpcAeoGsgsKSnERITen3O+JY5dvsmNz1jqQb
	3NFJ2pvEaFuzYdxPkMHb79OInKTnO5S+QqfFp8bMhotnQLTd8xlioOjvsxskCQg=
X-Google-Smtp-Source: AGHT+IHL7VexlrO86UE8LOJmxlR+p/3Hr8EiNRr7vZJNZi6xH+sjAfAHUWR0hgm/1PrMN+L+1XSLCQ==
X-Received: by 2002:a17:90a:8c8f:b0:299:7626:b13b with SMTP id b15-20020a17090a8c8f00b002997626b13bmr5192333pjo.14.1708633677776;
        Thu, 22 Feb 2024 12:27:57 -0800 (PST)
Received: from localhost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id qc17-20020a17090b289100b002993743e4a7sm4383286pjb.20.2024.02.22.12.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:27:57 -0800 (PST)
Date: Thu, 22 Feb 2024 12:27:57 -0800 (PST)
X-Google-Original-Date: Thu, 22 Feb 2024 12:27:55 PST (-0800)
Subject:     Re: [PATCH v9 0/2] lib: checksum: Fix issues with checksum tests
In-Reply-To: <20240221-fix_sparse_errors_checksum_tests-v9-0-bff4d73ab9d1@rivosinc.com>
CC: linux@roeck-us.net, David.Laight@aculab.com, akpm@linux-foundation.org,
  deller@gmx.de, James.Bottomley@hansenpartnership.com, linux-parisc@vger.kernel.org,
  viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>,
  lkp@intel.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Message-ID: <mhng-7bd71679-7e7b-459d-8d6f-068a0ee090ba@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 21 Feb 2024 18:55:48 PST (-0800), Charlie Jenkins wrote:
> The ip_fast_csum and csum_ipv6_magic tests did not work on all
> architectures due to differences in endianness and misaligned access
> support. Fix those issues by changing endianness of data and aligning
> the data.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Changes in v9:
> - Revert back to v7, the changes to v8 were not needed
> - Link to v8: https://lore.kernel.org/r/20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com
>
> Changes in v8:
> - Change ipv6_magic test case to use memcpy to avoid misalignment
> - Add Guenter's tested-by to patch 1 but not patch 2 since the later has
>   changed
> - Link to v7: https://lore.kernel.org/r/20240212-fix_sparse_errors_checksum_tests-v7-0-bbd3b8f64746@rivosinc.com
>
> Changes in v7:
> - Incorporate feedback for test_csum_ipv6_magic from Guenter and Al
> - Link to v6: https://lore.kernel.org/r/20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com
>
> Changes in v6:
> - Fix for big endian (Guenter)
> - Link to v5: https://lore.kernel.org/r/20240130-fix_sparse_errors_checksum_tests-v5-0-4d8a0a337e5e@rivosinc.com
>
> Changes in v5:
> - Add Guenter's tested-by
> - CC Andrew Morton
> - Link to v4: https://lore.kernel.org/r/20240124-fix_sparse_errors_checksum_tests-v4-0-bc2b8d23a35c@rivosinc.com
>
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
>  lib/checksum_kunit.c | 396 ++++++++++++++++++---------------------------------
>  1 file changed, 136 insertions(+), 260 deletions(-)
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240119-fix_sparse_errors_checksum_tests-26b86b34d784

I put a 

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

on the v4, but looks like it got lost.  I'm happy to take this via the 
RISC-V tree, as that's how I merged the broken patches in the first 
place, but no big deal if someone else wants to pick it up.

It looks like the issues are all resolved and such, but there's been a 
long tail of them so I'm not 100% sure here...

