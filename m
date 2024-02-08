Return-Path: <linux-kernel+bounces-58339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCED784E4E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7170E1F28F99
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7237E570;
	Thu,  8 Feb 2024 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0NDLlb3"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803C37D41A;
	Thu,  8 Feb 2024 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409242; cv=none; b=VnclOdDDuftRO0Mw2g7XIADsKLkI8TbQezXk9h819BA16ZWiPaa70VhSnMQVH98qdnE9CDhpfdZx8D0zyBbT0gIn8zE3Pz+F//jraUOsBmdijfMQ46SxKrFYyhv2yb6kUnlZafa99zc8TfIrnGlUsTIHtrE2sj4EqJ8ZT+3TA1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409242; c=relaxed/simple;
	bh=1SkKkWhTJGgzD/ZccxzkHHOYAO7VIBbYNXc5kKSdiX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L1c2WtK1QUMBmCO0UcbMGwXUlvSklkPbyOpu6Ih983zUJRolB2PrOdEnkTm+9eLMJ6inNPh1v9n4EoSX3bMfp0qcSD7cs2HXjIX6s51XApK6zY4FRQ1X+zO6gf+A8gJallkiJ9tdiERM/CiqMCS5v+uS1/WWOiw1To2QZHAm8TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0NDLlb3; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d0aabed735so644861fa.0;
        Thu, 08 Feb 2024 08:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707409238; x=1708014038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e6z/JgST9no8pB5BzZG8Bf892TgUvHGoWpZKJQHLBUs=;
        b=A0NDLlb3woGug/QcLj+DYNkLjHZPJu6upK94VOQq9jtFka55LKGJkVCWGZ3CxzwsSC
         TDqBW6+i2dp0AbJiXHxwHmWVi+QEwnk1akhHE0HZ17bIIVbNV1WLu9J0pzyleM82kjzl
         RoY94Oesmm37jLvLyJkdnt8EFApJSOgEcMwo94fIn7EtCdJJ+52D8nJ67mBTDd0fB9Kk
         /4KzAxAbLED3VTKEhBHYX98sbNv5RmBFhrPUn2QsJRNa67/kmZKmZo33CO3mLhLnKbOo
         ksloqlWqMYIFXhisss7St14G0TQhWipOMeXBEu3IQBjo1ZteZNx1aQFHTBt1qJY9w72Y
         EE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707409238; x=1708014038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6z/JgST9no8pB5BzZG8Bf892TgUvHGoWpZKJQHLBUs=;
        b=Lh6YMeS+ljClWwwB7B8J98sVuF4r7lOkixCb91p5JtXmSJFb+mkE/1BF05cCsDe1I+
         U77C4ZpN0D+vMc7KJrAvNNaShtigB5eVorJpvI7WcvB4n42Q6uQDZWmRFKrrHTgpG41g
         sI7j3RR9fGpkK9OyYzXllSyIp/sHYOq6n/aW274JGHTsnCY3hrXlwO56hNFxCYDlz08L
         D7MdKGUUUgFenxrMVjDm4IyZ7XwuHXayjLGQLckmdtmRImNG1Fw7tSmr8DlKkDVjFtaw
         ziP1pQdhRkfPns/XNFjFRvWnpNRAjrWW589QqlIHmOlLc0OTSAejtwVERlEerU7vpLKN
         Vltg==
X-Forwarded-Encrypted: i=1; AJvYcCXn4MZG0x4qr/trc1h/ysUqOPjcB8szOiM7IqgGUDf562ENAg3rBz6f/vZ4Owmn6wWXruOSDXaPkv5BcnrKheBenGwTxaF6Tqje4BVh
X-Gm-Message-State: AOJu0Yy05r77gwxHbJf2pNTyUcVv9XbxVGmEiFj38zks8n419f+7TByb
	pYwGv3pbkg2FvJJUemg3yRcbvRC8S3n1NHolz2P/qaMefrD4viuaJd4P33vUc0HpUg==
X-Google-Smtp-Source: AGHT+IGDdyQrjW70/yoOIesZPrmMmLqZxw1T4h2r0rU4q651bv7Yt0+mV7hIObQB93hclj7kuftHew==
X-Received: by 2002:a05:651c:2224:b0:2d0:c95a:f3c2 with SMTP id y36-20020a05651c222400b002d0c95af3c2mr5008473ljq.10.1707409238195;
        Thu, 08 Feb 2024 08:20:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX8aL6LQtpi6UgyYDitfO/Mndjn0RbURdnY2o6bUZCmPBSbZ2QHoFyVc5Sjg5Z+I4ZlR64Q0VC2HTm9BazU0ciJHY2MN/VZrJlVsmI0zg7Nh5oPF34z+ahgHs3ljTVKclHGZiXXeJ74JHsSOBF2rXnUDjinBTrPMb4jv8UF48uAb81VdqCMKoAMGxq9Q2x8kd9BzPARb+RL
Received: from sacco-Inspiron-5559.. (88-160-103-158.subs.proxad.net. [88.160.103.158])
        by smtp.gmail.com with ESMTPSA id e7-20020a2e8ec7000000b002d0cff1016asm32369ljl.51.2024.02.08.08.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:20:37 -0800 (PST)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: corbet@lwn.net,
	brauner@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [PATCH] docs: filesystems: fix typo in docs
Date: Thu,  8 Feb 2024 17:20:32 +0100
Message-Id: <20240208162032.109184-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch resolves a spelling error in the filesystem documentation.

It is submitted as part of my application to the "Linux Kernel Bug
Fixing Spring Unpaid 2024" mentorship program of the Linux Kernel
Foundation.

Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
 Documentation/filesystems/files.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/files.rst b/Documentation/filesystems/files.rst
index 9e38e4c221ca..eb770f891b27 100644
--- a/Documentation/filesystems/files.rst
+++ b/Documentation/filesystems/files.rst
@@ -116,7 +116,7 @@ before and after the reference count increment. This pattern can be seen
 in get_file_rcu() and __files_get_rcu().
 
 In addition, it isn't possible to access or check fields in struct file
-without first aqcuiring a reference on it under rcu lookup. Not doing
+without first acquiring a reference on it under rcu lookup. Not doing
 that was always very dodgy and it was only usable for non-pointer data
 in struct file. With SLAB_TYPESAFE_BY_RCU it is necessary that callers
 either first acquire a reference or they must hold the files_lock of the
-- 
2.34.1


