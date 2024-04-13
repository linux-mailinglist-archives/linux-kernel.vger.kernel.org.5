Return-Path: <linux-kernel+bounces-143532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03E98A3A98
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E0CEB2361D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9DF182BB;
	Sat, 13 Apr 2024 03:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp4eOUFL"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE12EEA9
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 03:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712978297; cv=none; b=hkTc+696i9BSNHlvcw1MTMJeuqYD5FlPmXoqOiKuHa9iTFp2uLFIO9fOKZycGol6g2jkNMdNvu0TdA+H1uouWsMb3pehvtqQfrtzmuqMMVPnA8JaF3F5GZwtOD9AdiDL/veXylq8G4OrXZmLG5WAVBKh1bBrpf+WjPqgCZzcRmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712978297; c=relaxed/simple;
	bh=Fama9Su1+zJu7/zSs5t57yOZMei5xDHkLujGRBWKBKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uEclKEMvikaPSzd1qpjHzJeg9OtHOu0KeUcQo5EjSRW0sDDI2bx6lDeD+PE4nhldAUTR0YKAd86oI1DC+60siz8lQMyCDxFfMtI8cAjERyUyOpk9MGNzSWjf9kEMQefE1Qf+toGxDd2xXmfdQj4Eli0ah0hsBcBQGWZo5qmeT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp4eOUFL; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a469dffbdfeso46579466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712978294; x=1713583094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PNnFVE6OxAC9vi6MOO4Z+HaTgoU0dnwIGRx/mpHEgUA=;
        b=Xp4eOUFLhhdcJIizdNGX4hxL9MZPxLaLmLmkwovu1pUF9gTqdeSiQLv2PomfU5fjk+
         04m+ZTpmM5s5Cfm1EJ0Ym7osnaQvfX7dt41tcdhJ8T3g/NI3kuWwd+q2diJrBrRleucM
         HtCTfgljZQjwUUmGp0kSZn5Mu3Ih8dqxq0sF/Wgx+npWOEf347h/wC1+Xxl46Vq2moHr
         8v23e5Iau0krZK6NTHVZ1mS3ZPXnuZwKH7MvkcbhxzpN1dPyrG3y+8y2jb6NVm8WCuWJ
         45yIIzYCZnvjGz7JfYgrWORTbjGl60MckARx3canYLwLQPqMCVRPKTVMzOj4cNMoH3YZ
         IAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712978294; x=1713583094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNnFVE6OxAC9vi6MOO4Z+HaTgoU0dnwIGRx/mpHEgUA=;
        b=MDd8HGGxUf/mXaeqJ6Qy2wRyLOpWwKvgTT+7eqTQGVDceOMkQhq3Te6T/BLl43YEbl
         rHHzYpBGqiZId/IUj+iCcAJFoL+C31UrnqsGXGAfTlHIl8p8g649hTO8AHICHUa2QaIt
         SODAif6XcW4dQUwbcmVb+0yATJxVGw/TXG4ETBEusTbaBgxKm4T3SwjA6K0qV2jTLQpX
         XlajlPhqMCAfeJ4iTe1VcYo76Kl+hIJ3qHMDFWbwYQERGZwoy3xT5FJPp/DIydFxPMIa
         Lj9KPbBKON4YYhZ55QF7z6F111fK2MZgPEgFfQGxCwln85rMn2vcGK7pMW8AFh/osXBV
         497Q==
X-Gm-Message-State: AOJu0YyYCBcLGvi9cdpgF/Lf/AsQR5Pgg33uuvt47KmAffqNyM8P0F9Y
	XWe7RKKwPxbi1zwb2FHOKuKhguWIfmIXw9Z72HbEZ6gwv4MT31gl0SE6PcT4
X-Google-Smtp-Source: AGHT+IEoRr1BXhNT33CwKQB7WNo688HaHNYsVo8mJA+Hk5OaW9zxOC3HPhro1PhDEYACC3i9jGCV2g==
X-Received: by 2002:a17:907:6d24:b0:a52:431e:636a with SMTP id sa36-20020a1709076d2400b00a52431e636amr1046090ejc.7.1712978293773;
        Fri, 12 Apr 2024 20:18:13 -0700 (PDT)
Received: from dmitrii-TM1701.. ([2001:8f8:1d36:b77d:8995:4615:5d13:26])
        by smtp.gmail.com with ESMTPSA id g4-20020a1709063b0400b00a51bbee7e55sm2450153ejf.53.2024.04.12.20.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 20:18:13 -0700 (PDT)
From: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dmitrii.bundin.a@gmail.com,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	bp@suse.de,
	gongruiqi1@huawei.com,
	rdunlap@infradead.org,
	michal.wajdeczko@intel.com
Subject: [PATCH] drm/i915/guc: Fix UB due to signed int overflow
Date: Sat, 13 Apr 2024 06:17:47 +0300
Message-Id: <20240413031747.2416581-1-dmitrii.bundin.a@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix compile errors of the form "FIELD_PREP: mask is not constant" caused
by signed integer constant overflow. Files affected:

drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c

Reproducible with gcc 7.5

Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
---
 drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h b/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
index 58012edd4eb0..8814d4cd371c 100644
--- a/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
+++ b/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
@@ -29,7 +29,7 @@
  */
 
 #define GUC_KLV_LEN_MIN				1u
-#define GUC_KLV_0_KEY				(0xffff << 16)
+#define GUC_KLV_0_KEY				(0xffffU << 16)
 #define GUC_KLV_0_LEN				(0xffff << 0)
 #define GUC_KLV_n_VALUE				(0xffffffff << 0)
 
-- 
2.34.1


