Return-Path: <linux-kernel+bounces-25568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DA582D2CC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5BDF1C20A32
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 00:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D021396;
	Mon, 15 Jan 2024 00:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+kUwrdf"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EBB3C0E;
	Mon, 15 Jan 2024 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso4028128a12.2;
        Sun, 14 Jan 2024 16:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705279779; x=1705884579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiHyUz9MWa8IOwndsZYuQ8RGJ7cOjISqLVJMLSNv/lU=;
        b=J+kUwrdflRQJ2DonxaCTaYMBXYdMA6PBElxxdBghu8lkseJJOz3TgU+z/XNgGgOLK7
         UaYV9ZNxziJqzWW5NqzXYN2HXnRAclP80V+m9Mph1v2YS5Jibmt+Nc3zBedFaXjIr1tI
         cX39OgpMIUxQXc9SR8rnQyfpqqo1phMIDqecUY+5nf4WZFQezzFUMTAKZPUJrDi5IXfD
         jTvfaNmAPNDFLWsSZip6IqmGnbP9HnrzNeGelYt/LLq2GueXmEkoBl/RB8OH9FGDNInH
         9gLKkM71bPgFSjuxmWAcH6x3jB9wH7ZtCp8disQAQ3kWsCOrAapf6DVp7Zpn+C9kYwqA
         F9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705279779; x=1705884579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiHyUz9MWa8IOwndsZYuQ8RGJ7cOjISqLVJMLSNv/lU=;
        b=aBuRaMwjtmU7DG/0k133lYHJZQ+nCPlIlW9HMG1UVL3dJl9Y/6MZ+DX7xKrTjDbjgX
         lcs6gUe72BmiL0NieL78UvojUmcKCkpiiQm18AU6LhTFhpzt+WNaCRfz7VigskYisfSN
         DMscLtPt8M8IldMPpQK958eaZ15hZUm5brCl0OvMfmDc3f0TFagabtP0/4rETaQFrbq5
         8y2KOwXWBSl363SFPrUEHCO+SQaUOBMFPJ7zUMlqHVo3DB2wl4WHcmIP+THq0S3WM9kx
         V74Ksxz884AJv2m1G8dpS0Q+Ix/XC57zHE1l8f5cLlBCUgntfwjeKdLQWH5mPcueBFyn
         JLgQ==
X-Gm-Message-State: AOJu0YyONza9g1EshOQMLaecI/3y5neWTxr7OSYdKzG6KtQNovmUhV5r
	dWowmBPP/PPLjDPTxlbBreAYrDMqDfuDNw==
X-Google-Smtp-Source: AGHT+IHpQPJ6Zh56XfXp3oFTraoVjRT/bLVWXn86o1jFW62TUAlj5jZgkX31SCZwPYwpc+ALBgwJtQ==
X-Received: by 2002:a05:6a00:17a6:b0:6d9:9de5:d121 with SMTP id s38-20020a056a0017a600b006d99de5d121mr2513546pfg.27.1705279779003;
        Sun, 14 Jan 2024 16:49:39 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79204000000b006d999f4a3c0sm6538365pfo.152.2024.01.14.16.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 16:49:38 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org,
	corbet@lwn.net
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 3/9] Documentation: ABI: update sysfs-gpio to reference gpio-cdev
Date: Mon, 15 Jan 2024 08:48:41 +0800
Message-Id: <20240115004847.22369-4-warthog618@gmail.com>
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

Update the sysfs-gpio interface document to refer to the gpio-cdev
interface that obsoletes it.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 Documentation/ABI/obsolete/sysfs-gpio | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/obsolete/sysfs-gpio b/Documentation/ABI/obsolete/sysfs-gpio
index b8b0fd341c17..da1345d854b4 100644
--- a/Documentation/ABI/obsolete/sysfs-gpio
+++ b/Documentation/ABI/obsolete/sysfs-gpio
@@ -28,5 +28,5 @@ Description:
 	    /label ... (r/o) descriptive, not necessarily unique
 	    /ngpio ... (r/o) number of GPIOs; numbered N to N + (ngpio - 1)
 
-  This ABI is deprecated and will be removed after 2020. It is
-  replaced with the GPIO character device.
+  This ABI is obsoleted by Documentation/ABI/testing/gpio-cdev and will be
+  removed after 2020.
-- 
2.39.2


