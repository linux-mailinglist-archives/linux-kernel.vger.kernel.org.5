Return-Path: <linux-kernel+bounces-95156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B550B8749FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB21281983
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BA082D78;
	Thu,  7 Mar 2024 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsmkY0cP"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3DE8288B;
	Thu,  7 Mar 2024 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801071; cv=none; b=TickUx3QIrhja+Gin01W1DvV1aOUYDVBKebygCgZmKFGkY/pqMkfYVvp2LyDA5kNOmhOSp2zCwSMDqA/Fr+ZthVUOvDa6Ih3dMAJhknyj75cMwERQdR4p1YaVqryTRSpTZM84tXjwYLtDdPVJTdm5gtYD9+nAJ6pgquJrHRXJsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801071; c=relaxed/simple;
	bh=fm0iBgE4SabS3Bl2mSLF5myIjuvQi4ZNn/Ua5rusr/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nIU9JtZXFlRSIRWSAwwHnQWcubjotLbggAoNA99eZGrrNtOqAo/ztMdGDXYx8ovLSPT9aMcyNINm/lrIQkvoDOQA4qXKU8lVkb0a6dqyXl/+Tft8zw81C7LE2WwRad0IJTNz/7cI6hRexysf2P5bYUy4mPmo5slqEycATAJDDW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsmkY0cP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a441d7c6125so68781466b.2;
        Thu, 07 Mar 2024 00:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709801067; x=1710405867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FoquaOEmQrmaw/2L6NuqbXwLRBOw43U2O3ew7WfCd14=;
        b=VsmkY0cPweUZnYnUTeYld9D1+jj814ZYbIy0/N/gwxN9oydDD3dCoyK+8GR3xb8ViV
         90CehsmEYcQHJFr20wEBVo2XZ7bO+POc0K+F6ZjAPHx4Mz4WzNwNaCLEMmnUmpQeqsyS
         r2QIA9byhbmpyi6TCaLZSnFdb5wiUqLnXphnBaxj0hZNFd/rMSQRnDJPZ1WrHHsP4b2V
         1thUURn42Q2JIAuRzAivu5qDAyfdk9o6GIH2ZgtsqiHb6fEJhKSTW87shwR4X4K1SJ1g
         PdvxVqVEdLHbewFl5BlHBBH6NCv8dYLQ+lUERUd4hZD7rO4+4sYzsLbv3NWyyoDftdre
         bGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709801067; x=1710405867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FoquaOEmQrmaw/2L6NuqbXwLRBOw43U2O3ew7WfCd14=;
        b=St3BUjJxmrx3m2c+Kcb03EYPFhKufHufy1mznqPxQNF7ToK8p+POlN/sVi9aCyQ5Um
         FlwkLq0Gjnxzpqthx5e3wuyX47cZQmHzO/jdycJapaaok3IlqQHX0C+BD5X0Wa7UIWBX
         rFPi59nphyZklMihkEcESTdSFhRUynRGDYSfGu3toRRIlXfIi89KfQ7oZRRgsBjPmljh
         e1M0ph7HXwDgOr5YLySyqvOHdNNetYVbjKnNht95qcQfvJdC6ORVKgM+szdwBHdwo5Zg
         xzVhbpVSfHIZl94qrIaHDshtUEJv/RcjatVdpYUtaDUN7FVWSaIviW6Jdps1igiurBQt
         awmg==
X-Forwarded-Encrypted: i=1; AJvYcCX28G2DvAEbaqUDX1vIEiCEtUHCm81VzSr9bGfMsFVy98OTetfuGBNlgkNQlPawtyhApInol+2KinKkenncxq2rY+i9ZTXVuS20qzwBWbeGqctD1Z/YVJ+YH1TFOGZfn0pMpc6XXtkTOkM=
X-Gm-Message-State: AOJu0Yw7ErkD7estvdC8pz8Qy9V2/0RvbOwDkxyvtE8C70P/AWEFuTYy
	c93ZRDSNgUDJg9mKTCoD8J/5TS0dHf1RUQSJsEZi2bxOrXBT/JEoYLdHujY9
X-Google-Smtp-Source: AGHT+IFZL6NYsiT1l/iU8GebYvDLrylEs3PS0k2he6H/eKFsZQ/jSQkbM2UHgRAgw+obMCIHmMgI7A==
X-Received: by 2002:a17:906:b08:b0:a45:248e:b253 with SMTP id u8-20020a1709060b0800b00a45248eb253mr8650257ejg.76.1709801067308;
        Thu, 07 Mar 2024 00:44:27 -0800 (PST)
Received: from localhost.localdomain ([213.55.225.151])
        by smtp.gmail.com with ESMTPSA id s23-20020a170906a19700b00a44899a44ddsm7074215ejy.11.2024.03.07.00.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 00:44:26 -0800 (PST)
From: Ali Zahraee <ahzahraee@gmail.com>
To: sakari.ailus@linux.intel.com,
	bingbu.cao@intel.com,
	tian.shu.qiu@intel.com,
	mchehab@kernel.org,
	gregkh@linuxfoundation.org
Cc: Ali Zahraee <ahzahraee@gmail.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com
Subject: [PATCH] Documentation: media: remove documentation of obsolete struct members
Date: Thu,  7 Mar 2024 09:44:04 +0100
Message-Id: <20240307084404.7796-1-ahzahraee@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These struct members were removed from the struct, but their
documentation is still there, which causes warnings from sphinx during
building of the docs.

Signed-off-by: Ali Zahraee <ahzahraee@gmail.com>
---
 drivers/staging/media/ipu3/include/uapi/intel-ipu3.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h b/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
index caa358e0bae4..4aa2797f5e3c 100644
--- a/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
+++ b/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
@@ -2485,11 +2485,9 @@ struct ipu3_uapi_anr_config {
  *		&ipu3_uapi_yuvp1_y_ee_nr_config
  * @yds:	y down scaler config. See &ipu3_uapi_yuvp1_yds_config
  * @chnr:	chroma noise reduction config. See &ipu3_uapi_yuvp1_chnr_config
- * @reserved1: reserved
  * @yds2:	y channel down scaler config. See &ipu3_uapi_yuvp1_yds_config
  * @tcc:	total color correction config as defined in struct
  *		&ipu3_uapi_yuvp2_tcc_static_config
- * @reserved2: reserved
  * @anr:	advanced noise reduction config.See &ipu3_uapi_anr_config
  * @awb_fr:	AWB filter response config. See ipu3_uapi_awb_fr_config
  * @ae:	auto exposure config  As specified by &ipu3_uapi_ae_config
@@ -2724,7 +2722,6 @@ struct ipu3_uapi_obgrid_param {
  * @acc_ae: 0 = no update, 1 = update.
  * @acc_af: 0 = no update, 1 = update.
  * @acc_awb: 0 = no update, 1 = update.
- * @__acc_osys: 0 = no update, 1 = update.
  * @reserved3: Not used.
  * @lin_vmem_params: 0 = no update, 1 = update.
  * @tnr3_vmem_params: 0 = no update, 1 = update.
-- 
2.34.1


