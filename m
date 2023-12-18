Return-Path: <linux-kernel+bounces-2909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996F1816419
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 226C6B20AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63D811CA8;
	Mon, 18 Dec 2023 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPhYYv0K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D114C11711;
	Mon, 18 Dec 2023 01:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6d9d209c9bbso2267609a34.0;
        Sun, 17 Dec 2023 17:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702862949; x=1703467749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRWJvmM8+hpVsGJoyvu2YuvVcQVJUfQcuTmMveSE8/s=;
        b=dPhYYv0K+27O1UaiUwzTK1fRfCZrX4n1IJf6uQgEDIhw8lLixBrAnlWzVG14MXIz5O
         eUKy4pm/k4uAd33tlYqm38JiNmS6e+uNBJUa7t+Su+EvzJ9yz3g+iwgjrROiCYmFEdw6
         xWfr8EL01JiNQYxjIpYogoym0yvtbe0xJsyVNkSQelTo6NyX0k/W2ub10Idz66JpJPuw
         EMlAV7nwACqI8lobxphyQl/HInWnVKO+UsS95bM4EKkZSBnlPAY9J7jpGETc9HyvE4Wq
         HrXNkK7C67amznPotHAYt3Jtty7yQED3kzWpku7P/IY1G0wHWRVw3vYYPM2qEnyyuhWi
         eYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702862949; x=1703467749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRWJvmM8+hpVsGJoyvu2YuvVcQVJUfQcuTmMveSE8/s=;
        b=hxD7P/ZIEmCB7jBeIrrWB3mGi0w9irjk2XND0BCnA5TKVi92AfKwO+eQ7aXZgJlg22
         HRxYFh1/WCEPccYdAEOyF7Fk/3bqUpD4Gx70OXPmNg3e0Zvv7kW3srtIh4gIMY64vuQ3
         8Zk91waKLXGwBas/cKGCCPN+IuIELebw+l1EE8lpsohQJkGw/EVROAfW7/3EnCk872Sb
         vJroO0DQ4G82JMHejfkItTNZ2GUI9EWJuGEf42PtTOAe7LqlhSPzATcnNc1Drytshqxv
         9lBIvQ50R8Hgmt3bhxWaPe01QWIrxovAb/DFTldhlzRlR8cXfOT3toeJFAgfqDwGGgVP
         olEQ==
X-Gm-Message-State: AOJu0YzKmJoTqBz93nBaq5c0TEWAPBFSiyBrwxX1ZPDCF/qhG1xhTU8p
	Y1CzvI/FT+7XElNB127eFhs=
X-Google-Smtp-Source: AGHT+IEtpmNJei4+QhmEPNWe2n/m3Ke0gpe8rMs2fyyBrNBnELNFolv2m2e5X0IjBTmhtfUH48Z6EQ==
X-Received: by 2002:a9d:638a:0:b0:6d9:d44d:cf1e with SMTP id w10-20020a9d638a000000b006d9d44dcf1emr17069720otk.13.1702862948962;
        Sun, 17 Dec 2023 17:29:08 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s6-20020a625e06000000b006d64c4cb661sm1414014pfb.200.2023.12.17.17.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 17:29:08 -0800 (PST)
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	axboe@kernel.dk,
	ebiggers@kernel.org
Cc: zhiguo.niu@unisoc.com,
	ke.wang@unisoc.com,
	yibin.ding@unisoc.com,
	hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH v5 RESEND 5/5] dm-crypt: Fix lost ioprio when queuing write bios
Date: Mon, 18 Dec 2023 09:27:46 +0800
Message-Id: <20231218012746.24442-6-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218012746.24442-1-hongyu.jin.cn@gmail.com>
References: <CAMQnb4O15c=JC-zkCJD0U9GWwWko+Hez1iU7+cc3vhNSG86p9w@mail.gmail.com>
 <20231218012746.24442-1-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyu Jin <hongyu.jin@unisoc.com>

The original submitting bio->bi_ioprio setting can be retained by
struct dm_crypt_io::base_bio, we set the original bio's ioprio to
the cloned bio for write.

Link: https://lore.kernel.org/dm-devel/alpine.LRH.2.11.1612141049250.13402@mail.ewheeler.net

Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
---
 drivers/md/dm-crypt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 6de107aff331..7149da6555b8 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1683,6 +1683,7 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
 				 GFP_NOIO, &cc->bs);
 	clone->bi_private = io;
 	clone->bi_end_io = crypt_endio;
+	clone->bi_ioprio = io->base_bio->bi_ioprio;
 
 	remaining_size = size;
 
-- 
2.34.1


