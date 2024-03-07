Return-Path: <linux-kernel+bounces-95777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00B287526D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADA56B26745
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F40212EBF1;
	Thu,  7 Mar 2024 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="no9EwJpz"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07B31EB23
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823235; cv=none; b=skeuFY0dHUi+jw2H5LIUmzoPz99BhPizsH00uVDgzoJg3SG4IwXi364mc9ysx4rxM0VBIX7mzNCaQ4JAcwDHMiXorlUyrFkSf5Axf1qJ8yjKSzkGi5aIADRGSs6krm7kpT/FWTuECVXfyuCnncb+TAGibK+K1bA//gHOC3qgZLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823235; c=relaxed/simple;
	bh=BgaQiwD2BgE2lKCqkagvr7pupcRGUo7bbnxMpXhwpC8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PLHByFklu3baO0DSTxFCP4tsLHzLDxX5YSyXfSZfoVeZUbyZxiKd4+cbsJHjmJzmd5Mt72BZUC0pRESjfpwo2EPgeB7pCL/+asN97ucQTp0rQTqS63LyP+FvuSKYqGkSM2Uo5HL1FXrFpQJO8Ek78vM0neqOS3wwJGhapefF20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=no9EwJpz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d18931a94so592475f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709823232; x=1710428032; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fBoKZX7YdfM81IXupkrtTPI9Yz71/qN8rU0jTLZj8s0=;
        b=no9EwJpzk6qHj5ddI4BQkm7S6fs6fK9FGaPH+RvW4TOzt55no9lhPQiQ1A5OXmczub
         eMxhU6cdNUzLTqTgf3vli0E0lYo55uaOXvV84Wt7CGlDrAS2sVElg5LiaXeOEBmGAJBc
         VTrN9NnXq+mfXdb1vXnPVbdkP4fD+xJYcPumd8DmgvFBYseISP5H+Nb5DcoWRi1k7k81
         qBGEyzA0dwWpBEMldDhIINL2ry/VLHhDnvpBEe3hqKPh6HTilawfc+H6p5RNkGNaxEA9
         d0PPK42NGGUoXoWb7nYtgZQ9EZk55fOpY72Bs9cDKcNstQsS8VVPc1PiYueQ/09/gSMU
         qQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709823232; x=1710428032;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBoKZX7YdfM81IXupkrtTPI9Yz71/qN8rU0jTLZj8s0=;
        b=jzzXp64l2yjwYQBubAnIt2rYZqyQqmL9WVm5Jc1pravCGrxUK/s8aiDabRrIc4p2wo
         IpQLDgGSWAz+bLMZmksGsovkI3ttGEVMajdiPeOWrXeFTnfnjRH2GjhmWQTCk6MMTPk+
         u+PAwaMDDTvaXmiMCTMDhT/WAdg27YuTO8fXNRnLAfjz8E29ea8fPpdWGUFYY/pJ38kO
         wsMKRIGB524h1WSqs+b327MeYF9ysN1iNMlpi40NcZwk8yV7ZoPvdMsNx3QzQUkFVcAy
         XEgwQ5IdUEavyH74HDUG24KrcaIXPh1op5/YEbHPdTLAQf2Blc/szcIzvJcbvpvQDBqB
         Vb2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKQnxnR3IYMBA0W3msUb7u/AkbM5wHb+WrC0Eq3+3xwz5bZ9UXIGO8snSTUDjW7BBEDz/bKA3kVbgDH5C5nYaUsdL9ocYjVuyR3M0j
X-Gm-Message-State: AOJu0YxIxI+oHPoeE6veR15uPkVoq3D6F154VmRFmCxbLLcTmuujNYl+
	W1Hkr4k/Rs6Mnoqwz4Co/dD+9RkWwTxuH72tzne7GSxfI8udmTU3lBZzB3iScaM=
X-Google-Smtp-Source: AGHT+IFUEjlHro6WzlyWyuQ9cBGMioeI8bttkvKQcFN/hfeGvu18fOUyFwICBJE39CTWU8Z6PG+XTw==
X-Received: by 2002:adf:e80d:0:b0:33d:1416:713b with SMTP id o13-20020adfe80d000000b0033d1416713bmr13031380wrm.69.1709823232228;
        Thu, 07 Mar 2024 06:53:52 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600016ce00b0033e25e970c2sm16211635wrf.88.2024.03.07.06.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 06:53:51 -0800 (PST)
Date: Thu, 7 Mar 2024 17:53:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chris Mason <clm@fb.com>, Qu Wenruo <wqu@suse.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] btrfs: qgroup: delete unnecessary check in
 btrfs_qgroup_check_inherit()
Message-ID: <cb21ce67-e9d8-4844-8c70-eb42f6ac4aee@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This check "if (inherit->num_qgroups > PAGE_SIZE)" is confusing and
unnecessary.

The problem with the check is that static checkers flag it as a
potential mixup of between units of bytes vs number of elements.
Fortunately, the check can safely be deleted because the next check is
correct and applies an even stricter limit:

	if (size != struct_size(inherit, qgroups, inherit->num_qgroups))
		return -EINVAL;

The "inherit" struct ends in a variable array of __u64 and
"inherit->num_qgroups" is the number of elements in the array.  At the
start of the function we check that:

	if (size < sizeof(*inherit) || size > PAGE_SIZE)
		return -EINVAL;

Thus, since we verify that the whole struct fits within one page, that
means that the number of elements in the inherit->qgroups[] array must
be less than PAGE_SIZE.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/btrfs/qgroup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 5f90f0605b12..a8197e25192c 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3067,9 +3067,6 @@ int btrfs_qgroup_check_inherit(struct btrfs_fs_info *fs_info,
 	if (inherit->num_ref_copies > 0 || inherit->num_excl_copies > 0)
 		return -EINVAL;
 
-	if (inherit->num_qgroups > PAGE_SIZE)
-		return -EINVAL;
-
 	if (size != struct_size(inherit, qgroups, inherit->num_qgroups))
 		return -EINVAL;
 
-- 
2.43.0


