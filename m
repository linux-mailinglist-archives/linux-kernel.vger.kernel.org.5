Return-Path: <linux-kernel+bounces-88849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6F986E774
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFDAC1C251CB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363E8C8E1;
	Fri,  1 Mar 2024 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPyjuNKQ"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5D179C2;
	Fri,  1 Mar 2024 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314747; cv=none; b=AcsWAIph84OM7+YfJsYeoroJkVkNHBNRCVYkA+AXO8cs4g258KY4g0tZrMX99UOusUXLz1+UQRXYnEdI/Mr7MYZBJ+mALNTvTkdHlUsHQjSOfWiO7RHG0JOHGRRVuVzao0Z7EqwKG+3XVrIPcx5xKAcYry15fb2SNGT5sVa28Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314747; c=relaxed/simple;
	bh=ebff8M+k/K6Wd1OgQ0pC/rYolW4WIr6/wiuY1cwp9d4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BZKijp6AsNChoNNLYRiup5qo7Jkva3opOwGLzy6eUPZYkphIWtIdqNVH1Az2HdAyh94zrtLXYgJk+zHIJejuHFJDmGMiIq32SQDYnKqrpLmtQgseQ0sj1ykYeReS1wREYlkIOJkeBvVkel5cFt9+N7mQmtwt7t3Ph9eWgpLNvWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPyjuNKQ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a26fa294e56so450018766b.0;
        Fri, 01 Mar 2024 09:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709314744; x=1709919544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=arCunWF6dZb0FdspcIOQcAPY/BFPdx5+j+0Wod9wh5s=;
        b=QPyjuNKQH+MoMTwuIvWsue5SiRNI0Ph67I2vgF7XPGg8KVJIoZ3YJXVbinaaHHnaTu
         Y/9CNctWTUa1PSoMyJ0E9BtKiLAHYt1CegWzLi9oW5b66jM4O1+KgBNieZVUcp0ZTbFz
         ju1jDgi8JJFFAMVBndzj5ZmIK+WPDkXG+euK2fAY+X3e+KnepIzptacczZDcYcEPwCla
         s2bfu0UO/EkVyKXz1fPT6CFN+O2gOuNq8B5jlLWECyaLZXxM9piTfvxF4h9/lZTOCwIb
         ZPIsyUTs44k46AjJO3jD6sX6xPOsMp3++EPDoPZrfGbT2kAqdbtPhaDVqNlxWP7Fwr/1
         P/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709314744; x=1709919544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=arCunWF6dZb0FdspcIOQcAPY/BFPdx5+j+0Wod9wh5s=;
        b=BRY9B7/cp94zlxdbTjMg9ufj9Q6v0vgXadlYPnWQrMZ4n6xEeyDXhCWhhgDGJtHz9a
         1kkzplQKyaGXT/oXZWhSBbSb0e56NPUipzryog93smxa6nIH34I/cNd7tulViw5OPGsv
         Ay/LyTx8Q31Hj1F0x+5XgrLcOspuF5XXOmJRLPgoqDHDHHG6MP+kr7/p0QtOWWnGF7Uc
         b/7hZjp1ywZlMcJ1/NiL3KDqn0Y6DsHup9AU5X05APdzbbnLpSQb7QDF0MVlH12jlOzr
         3UT4jmelSwmKQpHv3nmJ3ziHqAY7ovPf/qmqrwD95kSd46T/lZukZzE6bdl7c5Fvxp2k
         U/eA==
X-Forwarded-Encrypted: i=1; AJvYcCWebNrT61JpsvWZNZKfdrhYNenxkOGmZhjfn6XlzGOuWYflOwAGhR82DtRT6OmeSaRQpB0GGdMkXrfgA9eF07ewu2n21CehgaPbggeu
X-Gm-Message-State: AOJu0YwdNyAtxM4civVSW/1LeEBWx0mFrhy/oLq47qth9vrsuARfxC/A
	laBVUIXf3qq/r8hP1KNbjhVmuBdtQVj4bY4jpikwW8AXwT1l9cndFl8B6avo
X-Google-Smtp-Source: AGHT+IE7AXO3E6G2ne+1f2DYdXoxnjHQYIU25pwZk7+DrB1wXm1nxF4HttFQpm6oGSN3UUV57/slSA==
X-Received: by 2002:a17:906:b84e:b0:a3e:4d4c:d120 with SMTP id ga14-20020a170906b84e00b00a3e4d4cd120mr1724508ejb.12.1709314744157;
        Fri, 01 Mar 2024 09:39:04 -0800 (PST)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id re8-20020a170906d8c800b00a43815bf5edsm1864522ejb.133.2024.03.01.09.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:39:03 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fix for 6.8-rc7
Date: Fri,  1 Mar 2024 18:37:09 +0100
Message-ID: <20240301173710.2004467-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.8-rc7

for you to fetch changes up to 51d31149a88b5c5a8d2d33f06df93f6187a25b4c:

  ceph: switch to corrected encoding of max_xattr_size in mdsmap (2024-02-26 19:20:30 +0100)

----------------------------------------------------------------
A patch to catch up with mdsmap encoding rectification which ended up
being necessary after all to enable cluster upgrades from problematic
v18.2.0 and v18.2.1 releases.

----------------------------------------------------------------
Xiubo Li (1):
      ceph: switch to corrected encoding of max_xattr_size in mdsmap

 fs/ceph/mdsmap.c | 7 ++++---
 fs/ceph/mdsmap.h | 6 +++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

