Return-Path: <linux-kernel+bounces-27652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 295A282F3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED571F2490D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BA11CD24;
	Tue, 16 Jan 2024 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBOWXujF"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025C21CD10;
	Tue, 16 Jan 2024 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428591; cv=none; b=dI6TboCt0ZZ+2j9Chs+DTxI+YXVv3i/mTdKKvrB4dViHiqo7Tw0E1wDrdzaLATtzZEhjZ4CF+uqwl7gPwovLv6M4jhrKGn+nWhvMHiTPtGXNNangX6rMRp2FBZJeQIGYhPEdCSk96BamSQGJJ9D5bwZAwh3PDa+ks3s6EZAqlIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428591; c=relaxed/simple;
	bh=OZ6qT5H7gUGQcQ4dmXEFu6J/Unk+wv7oC3SQ7K4u91I=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=d4sUY3mF9gePV28xjPu7dwufzKPFwa9ANv0nkUUj6PDrFRfdBX7CvIHRnLBV3TSzV/NU1WHO/9RAf+Xcky0KJfaXG6ihuPdgYGrxxgft3VhMQVVFIIJKJ4PlaNz6RIHry301qVt48seFik9TGKaTGcqcrUYVpOfkQm8CHKBLBHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBOWXujF; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e86a76c11so5695885e9.2;
        Tue, 16 Jan 2024 10:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705428588; x=1706033388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=If228pjOeVfV9yZ/ZGaoDXhQ/Dz1ExXqs1+aqm8Cwjk=;
        b=XBOWXujFFqffH9496XNeCnJQV9tdC8jnG59eco8OrTxKS/4NeEB3Vkj6gX2IjogbJG
         iqhfXcRmxmt8LReocvJE9pt/ISJyXZ2M2SkJojFmYHmAjMfkYaul+fpGdE66tsKf1tYg
         eIqyWETfzIk+dIE8Y0azb3TKn225xk8WxgNJT0OlEtCs7in+Xb0h18wEya+KC7vEmRPa
         zwGGGV93nb7793Rdsc3bb72hVKVRQQhNdLBUAc3f0A1ldFUZxKbr5Pg8ct0Lyi2Vw9bT
         y0qx405Ja6YIH6Woa6czsfv4tgb2tDzp8IG2HTF9rCeUPQ56hKk9nJq+Jl0SYwnsCNZg
         TnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705428588; x=1706033388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=If228pjOeVfV9yZ/ZGaoDXhQ/Dz1ExXqs1+aqm8Cwjk=;
        b=UCDT+qkQFOPHFaKdr2MZ4H/KRuVid4PPKcyGsHCVJj3kXlwF2KHfNAIOzqfYfHM48r
         ovrQx0f8aA/YbwUpXK096p3Bw4zStXpKoxzfBHdyM43ErcxzmMdA81X6/THINzkamzOF
         IPsMQA0PMI2DLg8m6vsMhikKS7eAAjanTltjDFJDKJ7+lHyR6pWjyE9jXQ7XmsByOVj+
         KQWtpFW++siZyR9k3HhramX2evjCgUs1/rDio6Ul5odFYx7hLz4fiw4adGal4dybRb9O
         KfXmDvEU38FHIIfQ3qtPgtubSdAPgVdoaIW/roFHV1oH/C03AHK/Rov1MuUBX7QDwoBK
         7zrQ==
X-Gm-Message-State: AOJu0YzjxGbAxuwgvUvncH2CBw00Rujl7SlQgI/kD22ZXO+Il0Kpzh7f
	1PkYfZNUKaylUtRnqjkw8Zo=
X-Google-Smtp-Source: AGHT+IHy7OW1zG1UPyHvt7j7pYMKohRkWh+k4fYc/0MxPSM+XqtRXuxNR8WWuihEjVrBs/pThyN4JA==
X-Received: by 2002:a05:600c:3793:b0:40d:5b0e:2f5c with SMTP id o19-20020a05600c379300b0040d5b0e2f5cmr2901761wmr.52.1705428587969;
        Tue, 16 Jan 2024 10:09:47 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c3b9200b0040e4ca7fcb4sm20074528wms.37.2024.01.16.10.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 10:09:47 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] hpfs: remove redundant variable r
Date: Tue, 16 Jan 2024 18:09:46 +0000
Message-Id: <20240116180946.2321779-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable r is being assigned a value but it isn't being read
afterwards. The assignment is redundant and so r can be removed.

Cleans up clang scan build warning:
warning: Although the value stored to 'r' is used in the enclosing
expression, the value is never actually read from 'r'
[deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/hpfs/namei.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index 9184b4584b01..9b546ec6e614 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -547,8 +547,7 @@ static int hpfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	de.hidden = new_name[0] == '.';
 
 	if (new_inode) {
-		int r;
-		if ((r = hpfs_remove_dirent(old_dir, dno, dep, &qbh, 1)) != 2) {
+		if (hpfs_remove_dirent(old_dir, dno, dep, &qbh, 1) != 2) {
 			if ((nde = map_dirent(new_dir, hpfs_i(new_dir)->i_dno, new_name, new_len, NULL, &qbh1))) {
 				clear_nlink(new_inode);
 				copy_de(nde, &de);
-- 
2.39.2


