Return-Path: <linux-kernel+bounces-37642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3CD83B2F6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61C71F22E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F691339B1;
	Wed, 24 Jan 2024 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE9tWOUM"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6899C811E4;
	Wed, 24 Jan 2024 20:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706127688; cv=none; b=gQnzlIxXxS+zUVwcZnX35vlcTmi/ATysUR6S5Q7k5wYVIklCUV4lxIx0EcIJR9emb46RZP6ZPksv3WNleU6OytMadNlwQKAEc9rrnb3df7t1TpnbTTzhtf5vAV/8Ax7lV0aG0NkwPUH3hXK/bY07fHgG2DM4N6mr93bb8yUn/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706127688; c=relaxed/simple;
	bh=VW4mEIcdmik+s5egPBqVRNRoX+de9lNQLbQm1R62l4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rg5D6nY/Men2++/HidMMjr6l8BMnbIizrsdVLF3vnF/TB3ACo0prjmKlnv0iF8Y1/34NQbTRfynsPmO+x4ROtFyixXeoYhEJBwB0sQPG7Gt/PbbEUdQUIVv39DIAK1Hw/g06FoNLxDbFkRLIo3yQajqLLMZTGrjn5WrtDpLvy4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dE9tWOUM; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a30f7c9574eso170657666b.0;
        Wed, 24 Jan 2024 12:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706127684; x=1706732484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ChRDax5hJj6+YTMJxBY2kDCwCF/6rG7mvJwTLJmb7rA=;
        b=dE9tWOUM77q/4kHPm/tDtrU+45nkBMUvKLbNmTNtB/NDpbytEiNHIaz+9ekSZ3rzmE
         dUEAorsqjzuermmH6NnLwByRNbXe1r18LXZkVGPhfiyjtSlAO2+NDx6QRuR529rUqIg+
         l0GQzmzCU0hKSh4meoECT4IwjYGlyi19We4YxFna0I5hqPedJyn7Lqm2Md1embd5r4YR
         ugBt2ctMkdjemWTmKDbGYRZIhW8cORgN9AQUN8LbTBFni61E9bu/uKv7gEEJReFKDD5c
         iFB1ldxvVpcCtMTe0/vlQy7olIuWUQ6Bb78C4lV7xSz3MQtAaX9ZTAcueIUEDb2s5ELD
         i6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706127684; x=1706732484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChRDax5hJj6+YTMJxBY2kDCwCF/6rG7mvJwTLJmb7rA=;
        b=YDkuT/yQduEhyPK9lU0Hdm99GSjjCvR6VrLuhpDovu+Z+5ArTrMLKiDBeyujDkcUNR
         7nErHkYL56ZgdY+z4Bbi7leT5Iueq2YVZGu8ApPlkaKOymrAdYqlhcvyoHj5pEi4Zctn
         +uL7/gdf+CLjLyv0IWjAvI94oAX1UvJMSnTsIwKscw0WdO8ZyMbxbGLr572+Tak/wutx
         kN0sEPT0Ky2AgBYXMDfM93Ark00KPjIEMhReK943UYFrcJKLq9ALY8WpWmr40hLialw4
         q75DMgcQp7eKKw5WAHVLm5QtI8AW9uwnnj7SNTGtw5rPA5Luk0hLgqaYTjbAGQD/gedz
         vASQ==
X-Gm-Message-State: AOJu0Yzu+tFI+HMMjgSW7ahN6yuIDxjmMah3K8Ou4Zc937aDRu1UHk91
	alSotZ9wEPEIixALCag5pzRl3zqlSxJtiAXpKxTHNUhtqpq5RwdZ
X-Google-Smtp-Source: AGHT+IFdiG2NXpLxaUC69wnle/LvaJbZhVfrAQgsr2s46zHIaM+Y9faBfFjTZ7KPYhHCqlzfWoe7fQ==
X-Received: by 2002:a17:906:5294:b0:a31:49ad:f37e with SMTP id c20-20020a170906529400b00a3149adf37emr256936ejm.73.1706127684298;
        Wed, 24 Jan 2024 12:21:24 -0800 (PST)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id su13-20020a17090703cd00b00a26a93731c5sm226398ejb.111.2024.01.24.12.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 12:21:23 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 6.8-rc2
Date: Wed, 24 Jan 2024 21:21:06 +0100
Message-ID: <20240124202109.1567593-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.8-rc2

for you to fetch changes up to ded080c86b3f99683774af0441a58fc2e3d60cae:

  rbd: don't move requests to the running list on errors (2024-01-22 00:14:10 +0100)

----------------------------------------------------------------
A fix to avoid triggering an assert in some cases where RBD exclusive
mappings are involved and a deprecated API cleanup.

----------------------------------------------------------------
Christophe JAILLET (1):
      rbd: remove usage of the deprecated ida_simple_*() API

Ilya Dryomov (1):
      rbd: don't move requests to the running list on errors

 drivers/block/rbd.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

