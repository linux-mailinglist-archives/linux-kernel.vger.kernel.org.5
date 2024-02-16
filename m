Return-Path: <linux-kernel+bounces-68225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BA4857786
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B9FEB2205B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2671BDE1;
	Fri, 16 Feb 2024 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWpVj+lj"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269991798E;
	Fri, 16 Feb 2024 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071564; cv=none; b=RtyYDyhegc/w2sdrTkZuJxiy50u+aCMJkNyD+kS032rT8h5uJRclVtou2YfvshiY3fN8dxOu5Qa2wQI0FgCAF0BSXxgBUguP2yxG61rEJKtAcdjcufrnYL8RUwhAErFgJ07dBBk5an0lQmgbYoVqC6vT6NwJnyfck1wtr5RlUEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071564; c=relaxed/simple;
	bh=8ZH4X7IkAgYh1aAOxTz7Kvex+GWC3Fv0EXF6Y70Bd4w=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qW2NRpCZiU3UnyP/ccvNLrA2WjSzGqTe3s+MVs5Vi1KlWNoxoNE/V/amzEN/v4pY01Yw+EZ+BAGQPHPbGrx5SWtdptYevVQ5x+2OYWCNA/rtOQCuo6ohdv2wUu3uR9aRDbv8XsKS0gB0QdkRZX/III5HAl+BGPnCzOLM4Dvat48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWpVj+lj; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3566c0309fso209572266b.1;
        Fri, 16 Feb 2024 00:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708071561; x=1708676361; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkcZNtVWFcpaYRh5KBkVLspCvZTJEh/dDf70Iu1sYYo=;
        b=KWpVj+ljcvwFrQ31N3APbWWfn+AHBNhKl8xtNODtNCuqDbATzYDskiyhG9ggvxfUvo
         lAL1YTTMlcGM/3vBlO7F24Zz2+zzD5ntSHq0vqmJykmJuToO6UevPKLIrjmtSCPoEwUW
         QmJg/IA8kyYb14EZb/nkB8neqLC2eZ7OZm2Q8f2yWjhpMv2wwlC5HyA9GlkNJ+YAzgPD
         lIyzWUuADnnHNjSAD8CeqkMF/npgn+2lWViJlPA51G8Gvfya63TL+uDL7+DfRulk2Rb8
         0pwPYWiosydQSLTEMA2+yiH9LSLbVkYXlmPeoDab43yrpShfR65aSJTv1KLMgT8cz+6C
         rDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708071561; x=1708676361;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkcZNtVWFcpaYRh5KBkVLspCvZTJEh/dDf70Iu1sYYo=;
        b=LS8MNuMzEmB+KApaMuyi5vH+AiuwCtQxSJ8pDPYgKpJz8xdm/4tpEuHIC0oF/kJAg7
         Yz3sAMLdiKVqd0Xc38Q/Z0avq6U8PNDGJ71w1s8sDUEtIuXGPbZ0MW1ttViswRoi37D/
         uBTOdT060jsm0OYcxSNSiKZ3w0Ar1v+cmqGbZCJIkxeX92oxnYlDFQBcz41hoMDDzfb9
         0XTKB1FlDXnEvdLbegHVHZ4cjUAR0FjZXkWD8bPpZJZgbi7gpN1Gw7fMnJUNgRUEx+Zx
         zodgLBYVlsmixd0Lw+Pge2xEX3izdVkkZp9ZtIVlff7pmSrapnu1syoaz+zsOVlGWbNh
         XVJg==
X-Forwarded-Encrypted: i=1; AJvYcCWA9TTlGlrNUO/pfW6LgpuF3CGnQ8xw+C+xHVgQGsNXyFMG9BOSB1cIwh0C5dtkU54joqp+sbaEbF+peOEqu3O5wp3IcCa56CD9AABUs6nB9+Q48PtU3Mk5LaRkOLQz0tOYXQ5zF1LQNiwx7Yk=
X-Gm-Message-State: AOJu0YylrR+37XeuDMndBIMgf1pwf0V1JLaIKfiRMY+mpGXt1zOcXbDJ
	H0z3ZbMhVg4mkFKHCuC7m89WoaKHuuLZE2sxuRzXPBCCeEQElv/0
X-Google-Smtp-Source: AGHT+IFXSBfbEqhz1EqCn2tCMy8Z7/w/zHz7KZ1UE8gVdsg6Mxzu1Z26+TLjMUeJRJmfDryyxt9c1A==
X-Received: by 2002:a17:906:261a:b0:a3d:4e12:c0c1 with SMTP id h26-20020a170906261a00b00a3d4e12c0c1mr2585282ejc.39.1708071561103;
        Fri, 16 Feb 2024 00:19:21 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:e91e:623:d202:a9b3])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a3be730d63fsm1332888ejb.13.2024.02.16.00.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 00:19:20 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-bcachefs@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: repair file entries in THREAD WITH FILE
Date: Fri, 16 Feb 2024 09:19:17 +0100
Message-Id: <20240216081917.16302-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit ead021e0fe5b ("thread_with_file: Lift from bcachefs") adds the
section THREAD WITH FILE with file entries to the relevant header files
thread_with_file.h and thread_with_file_types.h in include/linux/.

The commit however unintentionally refers to files with a .c extension, but
the header files are of course with .h extension. Fortunately, the script
'./scripts/get_maintainer.pl --self-test=patterns' notices that.

Adjust the file entries to use the right extension.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37bcf01bf1d1..d881bddabf17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22025,8 +22025,8 @@ M:	Kent Overstreet <kent.overstreet@linux.dev>
 M:	Darrick J. Wong <djwong@kernel.org>
 L:	linux-bcachefs@vger.kernel.org
 S:	Maintained
-F:	include/linux/thread_with_file.c
-F:	include/linux/thread_with_file_types.c
+F:	include/linux/thread_with_file.h
+F:	include/linux/thread_with_file_types.h
 F:	lib/thread_with_file.c
 
 THUNDERBOLT DMA TRAFFIC TEST DRIVER
-- 
2.17.1


