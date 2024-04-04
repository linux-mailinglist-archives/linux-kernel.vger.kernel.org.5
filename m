Return-Path: <linux-kernel+bounces-130992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB4F8981A4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A22D5B2610B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680AA5C8FE;
	Thu,  4 Apr 2024 06:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9uqG2YF"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446855A116;
	Thu,  4 Apr 2024 06:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712213319; cv=none; b=OjSREZOvm6CS9Jtf/0FJCnC0HfVGtEbtw7zssHVQ/Udtwkl4CeB8xjgh/paDzjpFjX7He4tmRlsBozy6o4Xte4id4Ki2pQbkbB0fVxAs1I3fTp9ru+8jYULNs9BiFQY96y+8RorwTYxvocuhux4etJmc2BZJjWpNuNlAKPsgbV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712213319; c=relaxed/simple;
	bh=r6MCN9ZvsIa1h8Zy/FXDGNAgtZIDgAXA7dgDy16XxlM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AujyB1olWUAQcoRh0gkmczNX9B8iITKybVYfeO+DyKT44ntJUo/E13uBLRFmZUpgf/vRu5zrcSx2bUdjnY0hD/FncOPE1mShSKyxwk8wzpGZBXiv0rXcqcPh8a/MxP/QG6DlTgJaONT1hpBU8aiP/cfV1arh6I9EdjAXuSaaUas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9uqG2YF; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c5d9383118so115563b6e.1;
        Wed, 03 Apr 2024 23:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712213317; x=1712818117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RF2XRM49fP88q8qplmZ5n8Vm82ly5DhzkFDvFlIuMIc=;
        b=f9uqG2YFHpDEDXa0hqGGeb9YIF4B1YFcIC6wPBw2ExONNvo1/+cKT0I9eB2zNHLJMJ
         MCgQei496zcYi1vBwStisJIYjgnk4qt9il7BV/A+Sz2NWi5xup/86+M3dQenUMNDisPT
         viwls/uwtoJ58ARkmpIAxR530fQLQatZli9cCA9j7zAATLuez5pK8F4MbRoRCW++1C8o
         xoGmZ7zAfGzghii13MkzB2QGDeZGd+fABwB4AilrWVoBI1hyJcGAl7mQhqbxWdN9tqQf
         YMayo+IjItdD6ZSbmq1ZaZ49F6yWXhP7KkkSLL3amtDajpG41MO8Fklqu4ZrJTwFGn8S
         Cuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712213317; x=1712818117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RF2XRM49fP88q8qplmZ5n8Vm82ly5DhzkFDvFlIuMIc=;
        b=cdBWtfxz+6qmeewru8lQ8LXCKDcV3K6tNf6jQ/jB44acwVa3qktNmXlDLxXp8gpdw0
         k3fWbTmjL/nj7lOEBzimuezLVifKsdnZJe1uX2zcBeFClF7EPwZJSw/w5N5iaemFELSm
         MrwePwLSAPy/HVZQxqR4v7TLGIyOwAkdmMw7DsX8aH7jFgtLy39mVpDtzUOna9V1I16z
         o114MeF5Llrv1RND3/iypxksixT2jG4Fdd3wKsoSG8kuuHgGOziMDtO6F/Dw7hLVU1aE
         ouQo8RkF3osb1xH6HCg5IrHWw2dJPWA4gWj46HVj+0M0d0/oJRWDCqegLuti5qFObN/d
         EDxw==
X-Forwarded-Encrypted: i=1; AJvYcCUAHl4/xcmSU9Rz8Zm8meJoeltIUoC4t9GVhU1WeEJKSC/h7HNVQY45cj1kvHh5XqUGVPL84a65asX28+HQZP1lBROOsQwVyrMTzOgAwzgnqa0iQQ4esJyIzmhXEXOUI5x0uhmVYBP+
X-Gm-Message-State: AOJu0YyLeCiZ0ZJGmEbZzgqKlX8WXNSgMGGRgjJTmGx0+PgcYFUHf7Nf
	R9wF2NvCZahZ+Zv91R8LneA9tCc4NVGOErUsIPHqRLQbzQXvROaz
X-Google-Smtp-Source: AGHT+IG0T+NoyS2rni8cVrIvKuX08YygHmPNxHAsFUsvJu+tqpCv7cDZgk9gvcLObGtpsg30CzST2A==
X-Received: by 2002:a05:6808:d54:b0:3c5:d6d0:86e4 with SMTP id w20-20020a0568080d5400b003c5d6d086e4mr1421313oik.19.1712213317244;
        Wed, 03 Apr 2024 23:48:37 -0700 (PDT)
Received: from kaiwan-dell-7550.wlan ([205.254.163.212])
        by smtp.gmail.com with ESMTPSA id w10-20020aa79a0a000000b006e6aee6807dsm9624857pfj.22.2024.04.03.23.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 23:48:34 -0700 (PDT)
From: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
To: Carlos Bilbao <carlos.bilbao@amd.com>
Cc: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Subject: [PATCH v2 1/1] docs: Add relevant kernel publications to list of books; LKP 2E
Date: Thu,  4 Apr 2024 12:18:28 +0530
Message-Id: <20240404064828.208531-1-kaiwan.billimoria@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the 2nd edition of my 'Linux Kernel Programming' book is recently published
(29 Feb 2024), this patch is to request it's addition to the book list.
Thanks,
Kaiwan.

Signed-off-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
---
 Documentation/process/kernel-docs.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 8660493b91d0..66bab5b04f9f 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -75,6 +75,17 @@ On-line docs
 Published books
 ---------------
 
+	* Title: **Linux Kernel Programming: A Comprehensive and practical guide to
+Kernel Internals, Writing Modules, and Kernel Synchronization**
+
+      :Author: Kaiwan N Billimoria
+      :Publisher: Packt Publishing Ltd
+      :Date: February, 2024
+      :Pages: 826
+      :ISBN: 978-1803232225
+      :Notes: 2nd Edition
+
+
     * Title: **Linux Kernel Debugging: Leverage proven tools and advanced techniques to effectively debug Linux kernels and kernel modules**
 
       :Author: Kaiwan N Billimoria
@@ -91,6 +102,7 @@ Published books
       :Date: March, 2021
       :Pages: 754
       :ISBN: 978-1789953435
+      :Notes: 1st Edition
 
     * Title: **Linux Kernel Programming Part 2 - Char Device Drivers and Kernel Synchronization: Create user-kernel interfaces, work with peripheral I/O, and handle hardware interrupts**
 
-- 
2.40.1


