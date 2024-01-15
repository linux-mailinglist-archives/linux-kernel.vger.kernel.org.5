Return-Path: <linux-kernel+bounces-25567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E480582D2C9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80ABB1C2094A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 00:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D800D17D2;
	Mon, 15 Jan 2024 00:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6uPeFtM"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFEE20F4;
	Mon, 15 Jan 2024 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bb53e20a43so5867752b6e.1;
        Sun, 14 Jan 2024 16:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705279769; x=1705884569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbGb8zBMQYQKYcbDGRHhZWu6ZjU/ySFVlEqOv4kf1cQ=;
        b=l6uPeFtMUGF6Gq+oyIugpIu8IaMi+COCaHcmeWJmUj3zQAQLbuecDlraisVBWYvgYK
         idCejcsEruXCAT1UyrcXjwkLM/6e2WfhfGAlfgP8GvAdbZB+qgylIclJcVFTw3uVSEK7
         dgzRK0HYYPLRvGBqJxOk/y3LEU16HfAEnqgnIdkIwTdGip2q6AlL7sjuk3MmeqivytPD
         NBo154Yh2OOqQBstxBftmwgDQNNB0Z5kI8BZ1oPoq3bu/0vJRbCK5iT9Cpsu8MP7cucW
         oKJjqRXVdpCHhV5rvFIBL/K6/4k1d2VgUP+NAROw3AZY+ETIAdal1WbiH06CdFq0ISIu
         SYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705279769; x=1705884569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbGb8zBMQYQKYcbDGRHhZWu6ZjU/ySFVlEqOv4kf1cQ=;
        b=LtolOoXg3ByUxJfI7Dp5bZlQGDxRZU2G2TjDEAF4ebk2ZQI8+2RhFYwdG1URvkPr47
         nu11SyAXbQDZX+fhqVCHu23ShHDrtZc/90zWeICxeumjwPEn+NjKSdRZTV71jz7LcK4U
         Kgoo/Kr7awVZGdx+RYjEFq3aP//IaIRgUKgd+EzRMRpIgqe5pANEElliM+IUnOx2Z62u
         hFgCH43bYf7Ww2SqbGD5/rAs9CaY95ZdR3CgrBxwOUnfQ2Ynq87uqwayTmbn5dTvB1VM
         v2pf9YsOs6JBokE+94Zc0nx9bM1mWcbr/WyVjkjROHeyKP41jZZakNJ/60FQ3satU+58
         P+jw==
X-Gm-Message-State: AOJu0Yy8K+kJLTI/b+wKONtEhZk/yEed8Wv7HtnmVq6sY2LD41Ma0Bkp
	lwH8CLqMN9GflU8KxonQ09sonx9nolczSA==
X-Google-Smtp-Source: AGHT+IG29p5+vCkQP/j3ICy5UNtO+jCfUgPK1JmqidHnVL6Veqp7REuXnn2uMxpOJT49jtRkAlCp8g==
X-Received: by 2002:a54:468b:0:b0:3bb:edfd:42db with SMTP id k11-20020a54468b000000b003bbedfd42dbmr4423368oic.63.1705279768873;
        Sun, 14 Jan 2024 16:49:28 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79204000000b006d999f4a3c0sm6538365pfo.152.2024.01.14.16.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 16:49:28 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org,
	corbet@lwn.net
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 2/9] Documentation: ABI: update gpio-cdev to reference chardev.rst
Date: Mon, 15 Jan 2024 08:48:40 +0800
Message-Id: <20240115004847.22369-3-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115004847.22369-1-warthog618@gmail.com>
References: <20240115004847.22369-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the gpio-cdev interface document to refer to the new
chardev.rst.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 Documentation/ABI/testing/gpio-cdev | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/gpio-cdev b/Documentation/ABI/testing/gpio-cdev
index 66bdcd188b6c..c9689b2a6fed 100644
--- a/Documentation/ABI/testing/gpio-cdev
+++ b/Documentation/ABI/testing/gpio-cdev
@@ -6,8 +6,9 @@ Description:
 		The character device files /dev/gpiochip* are the interface
 		between GPIO chips and userspace.
 
-		The ioctl(2)-based ABI is defined and documented in
-		[include/uapi]<linux/gpio.h>.
+		The ioctl(2)-based ABI is defined in
+		[include/uapi]<linux/gpio.h> and documented in
+		Documentation/userspace-api/gpio/chardev.rst.
 
 		The following file operations are supported:
 
@@ -17,8 +18,8 @@ Description:
 		ioctl(2)
 		  Initiate various actions.
 
-		  See the inline documentation in [include/uapi]<linux/gpio.h>
-		  for descriptions of all ioctls.
+		  See Documentation/userspace-api/gpio/chardev.rst
+		  for a description of all ioctls.
 
 		close(2)
 		  Stops and free up the I/O contexts that was associated
-- 
2.39.2


