Return-Path: <linux-kernel+bounces-27517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50A482F179
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9F2280E27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89201C295;
	Tue, 16 Jan 2024 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqNcLPQF"
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38711C692;
	Tue, 16 Jan 2024 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-337b976773fso694479f8f.0;
        Tue, 16 Jan 2024 07:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705418745; x=1706023545; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zZuo2d2M/Q3k3wMquD1aUIkNWWB/iRajsNBkYvbeXdk=;
        b=FqNcLPQFhK2gHIK19I44oH+YeI0jkkYbJtM7OJFY8yhNqRR/4ckuOiz/5mDuY82XOu
         9ikkU0XX5zc7+OsHMXBbEpEJb8NXW0N/MhwmtCVzqJ0t9LR3AkMODSdWLq81aVmOTQMo
         h3RALaiSD79EFLNJCb5eKlJclFbqSi7RbeinO2CbtBZ3SzXFJJjwVT7IdHvRitc+JeaN
         s/tAw6/gE8jkVT6JUnGx4obuzusLIrKZkBCkv/viYgSwQFRbcdBqupvz11e78sh0kShD
         pA1119EsX6pS+Fz+ivAW+44hh+aPyJ6GcBu2EKQqIiZgEuwKSf7TLUqOBi2BEFF9ypbM
         cN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705418745; x=1706023545;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZuo2d2M/Q3k3wMquD1aUIkNWWB/iRajsNBkYvbeXdk=;
        b=poRTmA3Qxr5Mp6KMZul0B9PRvo25wpoGkCuWMJW1fpmoFCs/JIAxIsfjxYJ0sPebjV
         62XLSOXII1ec1KKWdKj3yUrwRP4HR+C0+771r/tFmU4ZO3jRg8DRqItqWO3D3lq2C0rE
         Rp9tK6AU226A1y7bHKti3NFpxCVGAXdFxW3LInxsJIS5u1LTouWXZeiGvC0X6lxcqiHb
         VAChzy8NX7lt2vaza/B8aC5iUQDzmtBkdyD6dBkUhjzBTPoHKzTrwi+nmNdd2VRR/h+b
         bSY3CqlRQN1GGLeR5GGtXZ/c/3KfBpPmmseYmVMK6WsgeAyF0zmK/5d9D9lWRVlwmgp0
         k5Qw==
X-Gm-Message-State: AOJu0YwRhmn8IFZd/9qmaj8vOkDS5+kjSzMFg5zy0k7ZXIb1wmRyfGJd
	XbyvG7Tx4uhzt5i3dgkF6+cBy62EVZ6rzwUT+aWj10jJ84YCGQ==
X-Google-Smtp-Source: AGHT+IFqsLujXCGmkVjTWmvELVAmznVKBkn692ZvXuqoD94Ym+aIoa9jl6vcfVDtn8E0zbZkTHbxKdaMS705q300VrM=
X-Received: by 2002:a7b:cd95:0:b0:40e:5f22:34ed with SMTP id
 y21-20020a7bcd95000000b0040e5f2234edmr3944070wmj.211.1705418744853; Tue, 16
 Jan 2024 07:25:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Tue, 16 Jan 2024 16:25:34 +0100
Message-ID: <CADFWO8FBDNvu-sZS6Lo_kbEuonPJ5MOUChSZpNR0B0htuu-Mqg@mail.gmail.com>
Subject: [PATCH 3/3] MAINTAINERS: Add Sensirion SDP500
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Angel Iglesias <ang.iglesiasg@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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

