Return-Path: <linux-kernel+bounces-21442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3891828F28
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6F31C24B35
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7A63E493;
	Tue,  9 Jan 2024 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niHz1rzh"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF403E472
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 21:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9b2c8e2a4so3072866b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 13:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704836918; x=1705441718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gb3K/gOcl8BRe9//TyWaKiPeebESIuPP76iDut9cCg4=;
        b=niHz1rzheAIsPdmL749GLsU9/Cd2xjjVSyPaC8S9lBTqBT4RVnrIBbsDjdsdiW1j8t
         IIVUVepvDUtXooohAiNjXOeleCtpfI399KP9IxOQgUJEW2wnPxdBnasm44PpyKhEQN2y
         8Wie4jwyVGAnHm6TqS+JmU0bBcyGG/cOwLtrc6Lai12MvZOhXH9in6dyH8MGvtzSJ4GN
         3lhxgUIdZQtLLrdz6Dolo083053vZnyyq4AYOXhFSJAQ9WVcscTyL5AfzauRaqdrq+J8
         b4RhrHJQJoJoMxPn8/ElTJle47r6dsqac5cdMjYCruENyeBK0bBQgkZgo8zUtBdCPoMD
         kesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704836918; x=1705441718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gb3K/gOcl8BRe9//TyWaKiPeebESIuPP76iDut9cCg4=;
        b=nQBX4oIdd0HMO0SOLgxjKPevOAhdyjIWRCGW0XDteLYtDyZ6o1DXmldylBOHEZFqnF
         xYrex5hGxQ5nyVwWz6TxUwQWne2Rb5no29BjALq+Y/dfrCHWbKV/lAe+4sBSzFc44P06
         hf6ut1fdb8UNOjFQtLj52hZ+CG38EpsgTIdKYxPNBSH7bXQckFAS2i775Xrg/g8LOi1M
         d6rw5Oaj4vHZXwT3TWWBkUpkJSVpae1gvMQWf+tUe2D1zPA09Qer0vn2zK0QLg5Qz00l
         dmc4eiqMOaaji4inJY5DH6Q/fwCjiosLz/SxRzOnNJlKE8hm5CM++CLTTnOi7TH3UOYM
         +cBg==
X-Gm-Message-State: AOJu0YyuTA4HqvDHj2q1Ah7Iq0zptjJUS94TlpNn2qUEQSJ6Y/w42JdW
	XE7WtfAj9nv3053rKRrZ40A=
X-Google-Smtp-Source: AGHT+IH8sJnR3C1dqJpAXTXoHTLf7iZg6CCh1LWMeSDjVJY7HaLSDzqUdBnAsvLOYixJIx41Es8qDQ==
X-Received: by 2002:a05:6a20:2d98:b0:199:fdc0:a180 with SMTP id bf24-20020a056a202d9800b00199fdc0a180mr175232pzb.63.1704836918115;
        Tue, 09 Jan 2024 13:48:38 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:fd50])
        by smtp.gmail.com with ESMTPSA id d13-20020a62f80d000000b006ce9c8c4001sm2107941pfh.47.2024.01.09.13.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 13:48:37 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: gregkh@linuxfoundation.org
Cc: andrea.righi@canonical.com,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	geert@linux-m68k.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/3] kernfs: Rearrange kernfs_node fields to reduce its size on 64bit
Date: Tue,  9 Jan 2024 11:48:03 -1000
Message-ID: <20240109214828.252092-3-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109214828.252092-1-tj@kernel.org>
References: <20240109214828.252092-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Moving .flags and .mode right below .hash makes kernfs_node smaller by 8
bytes on 64bit.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/kernfs.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 99aaa050ccb7..03c3fb83ab9e 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -206,6 +206,9 @@ struct kernfs_node {
 
 	const void		*ns;	/* namespace tag */
 	unsigned int		hash;	/* ns + name hash */
+	unsigned short		flags;
+	umode_t			mode;
+
 	union {
 		struct kernfs_elem_dir		dir;
 		struct kernfs_elem_symlink	symlink;
@@ -220,8 +223,6 @@ struct kernfs_node {
 	 */
 	u64			id;
 
-	unsigned short		flags;
-	umode_t			mode;
 	struct kernfs_iattrs	*iattr;
 };
 
-- 
2.43.0


