Return-Path: <linux-kernel+bounces-164266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DED8B7B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0394F1F220B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2B7179658;
	Tue, 30 Apr 2024 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/Oq/jVM"
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com [209.85.166.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1839117B4F1;
	Tue, 30 Apr 2024 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490862; cv=none; b=lfdJDxY7Vkq6oOBobSFk7q4kvD5EK0IHdFzIPLCkgRZjuP9iyoH0Ozpb1XXBVEVUh//E3m7dPnB0Q3pLfOk8xFRAigAQ2vb4mFsEjn/aq02CinJGcAlZQEBS9LQ5YOqq2y0O1nUF5MLafjNzM8FbePPQWvas4JnIg8fGoEnEgh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490862; c=relaxed/simple;
	bh=jWF+R6k2K8uFH2ZwLb7M5SwfeSLuAYQBwMI3KrqqS9o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QebiqatfXUIiuFAYm8anjWTEXJpSJKNrT3V93TK+T2gnaXEEZBkT9zENj+DN806Tx5BWo7acTnTJVefCKgB8TjDONK2uT/+FeeyOeZsbv9AXIH3HpDMfDRdTWEprBlXSiXU0giktt1arDFk6ZX7071yFxZmch4cGkds5yYvvxk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/Oq/jVM; arc=none smtp.client-ip=209.85.166.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f67.google.com with SMTP id ca18e2360f4ac-7da04b08b82so161583239f.0;
        Tue, 30 Apr 2024 08:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714490860; x=1715095660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S6EiQe0sO4zpsi2K9SK5LkhEBFfWw4caydHufI3cd9g=;
        b=K/Oq/jVMUmhDzXuWEYpTr+AqNe0D4lhc6yJwQESDsSLH70cOD+D580khWgnG/MA8eu
         TboDGuAZFay+ZVQQbLzi2sWcEt5zMBUvCpaEXJ+uly/kIEV7Pt1dQh2hL+upwfVS70jN
         6cHwHM3gMRbYRFHhVYBvWNMxu623BCHhjmsQELXspXP6ALSokPFxbK4onpNhcANJArc1
         61rf/j4eHVWCm2y6PY2zdMWvnUAz/oiKJ0vdnA2ui7Y2jypZFSsEN6R6i31CpcvCpwni
         eVv6mHSCMTU3oOAAt98HC1hKtaZGdlbkfk5IXB7mLsKyPN41ePF1Ijn4Zar9kpxYEua5
         eoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490860; x=1715095660;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S6EiQe0sO4zpsi2K9SK5LkhEBFfWw4caydHufI3cd9g=;
        b=qPd8hJGdtnWboYkP4sqMH3vyv1JjSm7xT7NRHfGGMwsHAANGHu8KO0Sq344K3NQxsj
         62bKBkwB5EieKo/zP5c9mLB6iuXs5WseqNBxzJuHW4prF7FTs+n60BazaTd0R1lxsPG5
         zFyvb3WnY1xOnwWUglzsKnimrgUv5FB9P7SagwP/QsiINdAgfI9wIlJ8WauVwsFruyAU
         MHTb5YuK1BLwKzEUKf9OCpeir74bjaaam7ksCcdbed/UplmsaAbg0b3+iY27ZHUibB3a
         E2pugyaRxE+sQbWt+Drkk0fXcwX2LKFDYYRWUpQE01aehCUB6SpzAFa9R20V+h2DO8TX
         xwpw==
X-Forwarded-Encrypted: i=1; AJvYcCUnAOLLzfoWRxBvlVWcZIvqKco2EVtAzKut3n2usxPuTYgSJ3+1R6l6nr0Xepr3Du19i2qDemVCsEzC/7mpYFf0RBDtWxUBnsqLHvF7iewmCPx5pFOYQIPSq0b6088rrgOmvd0P6qs45g==
X-Gm-Message-State: AOJu0Yx1OrQMsmOMvAvghyPiVlXirEbdgWy0FKCiTTg83yF/xfST86JQ
	d52KADQ0yqVtTf3wJhTjivUkxYxDrIE4tXLkbwfyUCXEplS7C3jaZsR45K5ybC0KfvMeWNfbusW
	R0fnHVRXqM8ZkiKJaGuJ2pvBKE+e7fmzPRz4=
X-Google-Smtp-Source: AGHT+IE0//FQwR5UIdVVFw2WGgKiJkdMJcXHNiF4QNIpntmkbmTTI+WUxzf9IYa+Nz70K6B3N/w9svoZP0aAL9JqlIM=
X-Received: by 2002:a5e:924b:0:b0:7d5:dd91:4b47 with SMTP id
 z11-20020a5e924b000000b007d5dd914b47mr171678iop.7.1714490860191; Tue, 30 Apr
 2024 08:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Tue, 30 Apr 2024 17:27:27 +0200
Message-ID: <CADFWO8Ghcmno8rgJ1WGyEvcjdrTEZr4_TXfhLjXQymzmR5FKPQ@mail.gmail.com>
Subject: [PATCH v2 3/3] MAINTAINERS: Add Sensirion SDP500
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Angel Iglesias <ang.iglesiasg@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From c4437fd0ea296c4c964b1fb924144ae24a2ce443 Mon Sep 17 00:00:00 2001
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Mon, 15 Jan 2024 14:57:57 +0100
Subject: [PATCH 3/3] MAINTAINERS: Add Sensirion SDP500

Add myself as a maintainer for Sensirion SDP500 pressure sensor driver

Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 40c754b4c39c..11e8f353dc9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19533,6 +19533,12 @@ S:    Maintained
 F:    Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
 F:    drivers/iio/chemical/scd4x.c

+SENSIRION SDP500 DIFFERENTIAL PRESSURE SENSOR DRIVER
+M:    Petar Stoykov <pd.pstoykov@gmail.com>
+S:    Maintained
+F:    Documentation/devicetree/bindings/iio/pressure/sdp500.yaml
+F:    drivers/iio/pressure/sdp500.c
+
 SENSIRION SGP40 GAS SENSOR DRIVER
 M:    Andreas Klinger <ak@it-klinger.de>
 S:    Maintained
-- 
2.30.2

