Return-Path: <linux-kernel+bounces-24294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F7F82BA84
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E8B2875D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 04:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42BA5B5BA;
	Fri, 12 Jan 2024 04:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqYuSoHZ"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E410A5B5B1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-58e256505f7so3047801eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705035167; x=1705639967; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMzzmG1PU01z52zMYQ4mz/0VyGI2Cib5puWp6/ySFDQ=;
        b=cqYuSoHZ7WeTBp/qJWmgN7JLSB9Tc72zccUIwUz7WBGExHFgV5qMRQgPDdbSmnjUnb
         sbuBlSoJstPMBHGOKgnKK6fWAVYx+5jdtZhET4QCZf5N82wyWjXXTKs02jT2XdzAWogi
         aJwjOysOivmYx0gqp6J7ezbf1cvQN/ALXfWayvxasqbB3DL3/np94ReyGHDzxQYgURl/
         xgRkZatZJ871rKjtmTBwDC9y0qI0txjY6YJkeAy36DldmkurMvPeZK3tpCHu2QYo2cfz
         CUCHa88e229sGJHQ88dc7n0GvKZjSJIwxhKHi3/PLi0NCuOrql0kTOCdOZES7UVND22M
         O/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705035167; x=1705639967;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMzzmG1PU01z52zMYQ4mz/0VyGI2Cib5puWp6/ySFDQ=;
        b=a91ioObLbVYASMLpjS75eD0N1oHYAXDOWTd0JULJahFw1Z724OdBJXU3NbBXH+A7HJ
         V7v/0jKKRAFKBXimGYbkTYlnu9GrMueii1R+gne9xNOy/FXKMpHA7/I58HOCCe0tER2O
         oKhhG69VfL434g5F372djqXE8ai+xfNu214jaRw+fC1YoMOM4672VkgL/kWMFPrfwuyC
         eQPbKAISjTzB+Ss8u4LUvmVUS4T+8thqryN5iu/+p9e9UR7H8XOO2gj3Bqbx2/M/yvI7
         cNuZYvlH5ZVvFWgt54GsNbKYPwEUXBfBc7jvo+Uoi7RAZluoqZezM0ku8Dsvzew8fxZ4
         Eu1g==
X-Gm-Message-State: AOJu0YwlllZ4JhspkkM+sgD35RxMB5Bw9xdfj3vAKakWm0KhNa5Okx7l
	H0MyS8jNoxVE5TQAPCJnJv0=
X-Google-Smtp-Source: AGHT+IFJgzyRwboVdy9LT1n7++9wIf2SdbFJSaOXKeS6HdcURnC4aOSek9WjGWLY9zlN65VH6PnX9g==
X-Received: by 2002:a05:6358:6a44:b0:16e:271d:1db7 with SMTP id c4-20020a0563586a4400b0016e271d1db7mr965001rwh.2.1705035166719;
        Thu, 11 Jan 2024 20:52:46 -0800 (PST)
Received: from pop-os ([27.4.4.207])
        by smtp.gmail.com with ESMTPSA id l22-20020a62be16000000b006d9b38f2e75sm2183645pff.32.2024.01.11.20.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 20:52:46 -0800 (PST)
Date: Fri, 12 Jan 2024 10:22:43 +0530
From: Pranav Athreya <pranavsubbu@gmail.com>
To: Forest Bond <forest@alittletooquiet.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Pranav Athreya <pranavsubbu@gmail.com>
Subject: [PATCH v2] staging: vt6655: Remove extra blank lines between code
 blocks
Message-ID: <ZaDFm6XX7HiGWn58@pop-os>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Adhere to Linux kernel coding style.

Reported by checkpatch:

drivers/staging/vt6655/rxtx.h:22: CHECK: Please don't use multiple blank lines

Signed-off-by: Pranav Athreya <pranavsubbu@gmail.com>
---
v2: Fixed commit message to only mention files that are being changed.

 drivers/staging/vt6655/rxtx.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vt6655/rxtx.h b/drivers/staging/vt6655/rxtx.h
index a67757c9bb5c..be1e5180d57b 100644
--- a/drivers/staging/vt6655/rxtx.h
+++ b/drivers/staging/vt6655/rxtx.h
@@ -19,7 +19,6 @@
 #define DEFAULT_MSDU_LIFETIME_RES_64us	8000 /* 64us */
 #define DEFAULT_MGN_LIFETIME_RES_64us	125  /* 64us */
 
-
 /*---------------------  Export Definitions -------------------------*/
 
 /*---------------------  Export Variables  --------------------------*/
-- 
2.34.1


