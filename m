Return-Path: <linux-kernel+bounces-84923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AA186ADC0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C2B29193F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435F6151CF9;
	Wed, 28 Feb 2024 11:32:09 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2021273524;
	Wed, 28 Feb 2024 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119928; cv=none; b=G8ww27AKRbH8h/EZaBaom1MViLOu4CLoLj17xF89EvQHT4Ty+wIPLKDIrly5xDKzwg2VTZXgok0gl63g+3IJ1DOGrZk8+sHQMzL47vYn6y8k1R8oeFxAI00GjpmRvr5uqLubNjB2n3hcpM/Y8wtwjcBXCnNHAIo5q1Dj3oH4SFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119928; c=relaxed/simple;
	bh=xfokqmnN1hXAoQigXny2P/sjBScjiho/EWfxSdAhYj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H88DOyacGUvaqsiSihdM2O9JXrFv4mASa/G2hMSXz6OS1qt4omJ9PtxVo6U0EoaKoWqR14fkli8QD29H5+RD/R93AkoBu/s2x4E1EipjxrUZgo4ktVEwZ7PV7QmR/K+Bn67dSKO44Fa/nH1jGhddKA36+HGzaXwyNoCXKOZ69Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-564fd9eea75so6825044a12.3;
        Wed, 28 Feb 2024 03:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709119925; x=1709724725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPc6h8vGachk83ubTaMre+MHbC4ZFxj395rd+hZ7iVc=;
        b=wPp4Plj3ii3URkT/t6hUAxjYMAhNiUMLFcRh+HU+mCEmUJNIm5EQG9Hcpw1nkaooXM
         u+J2k5U1peNsdKFps6jfgHModvm5lJGjf+2Qqbp4sDN3t7C0RU1OOBPlwr/j8CzZ+jOq
         zZPDtRNsT4iTkFX7OCdkjGs/V3dZwkaFmcv2lqoNy53Tv9I1lBAeUk6i1PFfr5ZGZEZA
         023fofZTEZ3v8+MhN09RxuS7gOs5+eOG8CcD9YdF5LgA2SgcKJJYFes9rq3h1c8neqwA
         e+3/Ymg/XbxYvaRmK+tY1hSX4Ovb31KGImIXo8fu+wKIXAO62HP9ZEWrRbyvF0rOiOj0
         eCRw==
X-Forwarded-Encrypted: i=1; AJvYcCVY1M1Nj3/1epGHBwY5+G0+BeBMtGFedC00SARF61GkVkPitAImBWjUBpf7zVK8YlweUhKUcJMHJuNJsIEor+IFvGFFJLJPbyPuqr3p
X-Gm-Message-State: AOJu0YxpVqqnKsTXS+vbuFPB0UXYeYgDmaWjQVs32zunyJN7wl9JNdo9
	/eteeeJv5azpUKJw3dtfqwk3BiZJJzaRh/1pnLe1x2Lv1voI5C8ZZoH3kRkL
X-Google-Smtp-Source: AGHT+IFl1/H1/1Apa8TAsSMASHDA9z60Tdx1lChlAG9+XL9WpynmSWwUs4fs0dhHtXr3IGC9AugNpw==
X-Received: by 2002:a50:cc92:0:b0:565:a5aa:22e5 with SMTP id q18-20020a50cc92000000b00565a5aa22e5mr8397110edi.26.1709119925262;
        Wed, 28 Feb 2024 03:32:05 -0800 (PST)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id en9-20020a056402528900b0056679104c1bsm253779edb.37.2024.02.28.03.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 03:32:04 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	dsahern@kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>
Subject: [PATCH net-next 1/2] net: get stats64 if device if driver is configured
Date: Wed, 28 Feb 2024 03:31:21 -0800
Message-ID: <20240228113125.3473685-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228113125.3473685-1-leitao@debian.org>
References: <20240228113125.3473685-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the network driver is relying in the net core to do stats allocation,
then we want to dev_get_tstats64() instead of netdev_stats_to_stats64(),
since there are per-cpu stats that needs to be taken in consideration.

This will also simplify the drivers in regard to statistics. Once the
driver sets NETDEV_PCPU_STAT_TSTATS, it doesn't not need to allocate the
stacks, neither it needs to set `.ndo_get_stats64 = dev_get_tstats64`
for the generic stats collection function anymore.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 275fd5259a4a..3577620e39bd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10701,6 +10701,8 @@ struct rtnl_link_stats64 *dev_get_stats(struct net_device *dev,
 		ops->ndo_get_stats64(dev, storage);
 	} else if (ops->ndo_get_stats) {
 		netdev_stats_to_stats64(storage, ops->ndo_get_stats(dev));
+	} else if (dev->pcpu_stat_type == NETDEV_PCPU_STAT_TSTATS) {
+		dev_get_tstats64(dev, storage);
 	} else {
 		netdev_stats_to_stats64(storage, &dev->stats);
 	}
-- 
2.43.0


