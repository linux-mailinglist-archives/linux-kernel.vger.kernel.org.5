Return-Path: <linux-kernel+bounces-145505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A258A5715
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C965A284893
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBB08175E;
	Mon, 15 Apr 2024 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jvp3+qiU"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6692580046;
	Mon, 15 Apr 2024 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197211; cv=none; b=UWc9X6qdV4gV65tjUkVNr8R5O2Zdmt9MSZvPX0twqQ0QAuVDm39/lalexHUL98DaiKIi9iM5NQ9XODUyRHW1Bq9YBUlJZDMxtluBhWSy9o3Eas3SFXIWutKDvSkeiNo/vPCh4B0qhYPsUR7GLL44YYWkA3YnkTHOvUP5XKIsxkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197211; c=relaxed/simple;
	bh=u1JCRRKzjl8qykx2k9hA7pqCSuJlx9ieUvrB1zSrnaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IaNfBRP1O1Mpc86d3eC5sjdm231JpKxxZ/mD0SUbLJxwbsWjF+09SPpkaXcF9FtrE4UvnApMftfyxUh0yCfD90b1sbs+ofZWAVZe+u9GjH2dOTfLkMed6hRmZn635WXrv6ViJgxEVDqd8oRCAZkHPyD856SQWaiz6w80chMBJAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jvp3+qiU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6eff9dc1821so972231b3a.3;
        Mon, 15 Apr 2024 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713197210; x=1713802010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XZ0hl5wvzDiV5OaUiC6GQia70++FDm51nSD2qz6+gxI=;
        b=Jvp3+qiUN+0bkZuGQclPRG+4aPOJva2eJh1DlbXxlOltFvF2oL//UZLvV3wIduTj7s
         JzEMImwLlunibn8g0bIMtKKcR5MjVg8E2Oyio0fVcAGd3A26cJISyN96WuidxMRSXNZs
         7qMphV+W1udGo1GLo+3WMxDN2dZbY/vetOhkS6plo2dfBe3BAfq6q4ypr0RFxn1vqnuR
         o/UBQSccmiH3gldrOO14FV1kCIpiDM5nBJIi6sSh5yhEycW+iH+xMIfCnJ7YHHrCSKLb
         LqKDp/suX8whPBaUmmqMNuSetl6TA2vva2QRhMNfLje1Zy+Um9WeiFwfb9AQESjiYk5M
         /JpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197210; x=1713802010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZ0hl5wvzDiV5OaUiC6GQia70++FDm51nSD2qz6+gxI=;
        b=p3PZvm+No2LPkq3wr+W2rwD/kxwjeDzJwjTTtoQu1nTym8OCigGSuN0YRLJ3uYEZvT
         +Pf2ZfA3WXb53q03BadcpWw1m1sPPNkMWxBf7VHTCW3b1CUlfNvhCTrdrN4j9bibHD5t
         alZHOtX+r9Y2MX/kzjL+N9MkMCOtmqb0yKjti7SiCd70l7nOp/Erkh8BY7jCXrkpNY8D
         teC178PSZ4VKoJ+1qi0MlMJoGaiQNoHCq41ZtTE4sHjMImyqjzpovyjN6MGxNJBKzRjK
         /LHZyFjb3OnWwbUanDKn7TWJwlxuqlTFK4LR5Dd3UF8XDdC9RuSFs+pgJxnzG+zkXcir
         Urdg==
X-Forwarded-Encrypted: i=1; AJvYcCUw40D7gJBmcl0CMTSouy64W6BS83IDlywaINHcMHUfFN3Bd69PQAiUXrVE0zcEzVCjgsZjyMUakZ9WqJbwaZcOiOP6SbTOahIdtHWgyA6Mg9XLoIazl/Ln2otFHipfO8m80Mck
X-Gm-Message-State: AOJu0YzWzrVL3x1ywRt7fBU7r8zlwu1Oa+/CUkTHIrju3I+yfeB834WT
	zOpE0ycwFCYN9b0OEtO2PDA4ZtzBqIxK03QleBvYTz5wehjaF75h
X-Google-Smtp-Source: AGHT+IHbh8tNg77nATSHoTkIIdZZIBNUTvd1fRqJhsJm8FfiM0ZTsfx/M5xl3/GHmJSgMJqTuVBkig==
X-Received: by 2002:a05:6a21:8015:b0:1a9:9c20:6ca with SMTP id ou21-20020a056a21801500b001a99c2006camr8124174pzb.23.1713197209674;
        Mon, 15 Apr 2024 09:06:49 -0700 (PDT)
Received: from dev0.. ([49.43.161.106])
        by smtp.gmail.com with ESMTPSA id gk11-20020a056a00848b00b006ed045af796sm7306920pfb.88.2024.04.15.09.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:06:49 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Abhinav Jain <jain.abhinav177@gmail.com>
Subject: [PATCH] inet: inet_defrag: Removing the usage of refcount_inc_not_zero
Date: Mon, 15 Apr 2024 16:06:19 +0000
Message-Id: <20240415160619.8249-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove refcount_inc_not_zero as per the listed TODO in the file.
Used spin_(un)lock and refcount_* functions for synchronization.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 net/ipv4/inet_fragment.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index c88c9034d630..e4838bbe0abb 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -358,7 +358,6 @@ static struct inet_frag_queue *inet_frag_create(struct fqdir *fqdir,
 	return q;
 }
 
-/* TODO : call from rcu_read_lock() and no longer use refcount_inc_not_zero() */
 struct inet_frag_queue *inet_frag_find(struct fqdir *fqdir, void *key)
 {
 	/* This pairs with WRITE_ONCE() in fqdir_pre_exit(). */
@@ -375,8 +374,14 @@ struct inet_frag_queue *inet_frag_find(struct fqdir *fqdir, void *key)
 		fq = inet_frag_create(fqdir, key, &prev);
 	if (!IS_ERR_OR_NULL(prev)) {
 		fq = prev;
-		if (!refcount_inc_not_zero(&fq->refcnt))
+		spin_lock(&fq->lock);
+		if (refcount_read(&fq->refcnt) > 0) {
+			refcount_inc(&fq->refcnt);
+			spin_unlock(&fq->lock);
+		} else {
+			spin_unlock(&fq->lock);
 			fq = NULL;
+		}
 	}
 	rcu_read_unlock();
 	return fq;
-- 
2.34.1


