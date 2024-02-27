Return-Path: <linux-kernel+bounces-83563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8F3869B79
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39E51F264F9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F5D14830C;
	Tue, 27 Feb 2024 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksmKWCJt"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D5D1482FA
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049703; cv=none; b=YXzGV/U2R7m42QhSVnZv0eXOEsJav0dFG/q2WS4fKkI/Le27z+FzAbSrFIvfsMIH8J+EPqBlc8b9YvYtoqrw+WebNXgWTDdbWvEKp+Lqpa2O4dLcKhMYFSH3g4tbverjHUK2khsgfrsjYUIkQuhmGUy/oIhygHINtDkkqWjLPlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049703; c=relaxed/simple;
	bh=PfIAZI8U/Ed1rg3JAVmSj9XDKnHNNZKz5arRsiU7nzU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VlhBRERd6HcRRKRf27Vvxi6eyE2yJty4hYz34u8vsl+FaXXYM85ipUZIC4zv1z2b2IQ3ZJdumIVVT8IBzQ2qRTsOHrK+UD3KNd5zUX2FwM8gOELe4KxG3eAUZv+9qDIAGuMkm6jOBodcyjZ5YN3HPwtAgeNIjS93lIfe7NptkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksmKWCJt; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512f892500cso2562622e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709049699; x=1709654499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X56hJwde2d0DSwQh7BdZYX6K5vlX3nWxYW7Jl2hEtLc=;
        b=ksmKWCJtuZ3X7m86eiWcKjTzHsXMup8aLMclIM0fkFL4rLK1FWfMeAOQr0el6qsq+n
         P4+IvEEJzBHuR6iBi4fq2RMBi52RIxACKubS17E2YlvsiH3A2pdNLFJYV6uM7zu41rCV
         W/JMZh+icYRT425cD0+taNkVHUqbCx1ne0baSm6zEXDOOJRDoguxzHJMYz56FTZMe5Qj
         KmOm+vGQidIxQ6ztxAEZoO1unUZ152jwWD/RNrKdgDAahWsAVsrJHLlB23+o47pkvgNh
         ZqdQWpH6mNH83Uq0mpOdkNUrzIht4uk5CXqdqRQ5zs68YQtwGUOWywR1y1j9/qdNPZaE
         Bs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709049699; x=1709654499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X56hJwde2d0DSwQh7BdZYX6K5vlX3nWxYW7Jl2hEtLc=;
        b=CncOTu/m/c0se+loqGwFU3fwX0GJl7Z+132Wy2Ov3oEiAL5yqH48O08HWlF6pM1U9q
         jjsYlQUdXAjiOOY9MSxuntIx3SjnsYyjj3adHiMEmrEtNrrul6Xn3dEhBYQ/y6yLy/70
         TJcj/2WZG1nCjhGsQdDhiZfK9ANi2kcbI4bi3TQ/U9+9e5m6OmoVcbcRiG52yWr+XjRY
         kYk63usnoM9AqHw8iblACoRwDLmYbH2IGJ0nRpfxr7jXeHxHHYumVHXj9hYdqRe0F9dW
         SyBmaxW5iKUYYcBxqERkwy0Zx0eKEs1FiZUsV9rq/Ho/ZbWGnycFjbrdQ+hCexEnw6cI
         HSGg==
X-Forwarded-Encrypted: i=1; AJvYcCWBNg0IV5Tuby/XOdqoKw+JqjeIiif4I+2EiAhnNCdPcboDPhKDWc5rga4VAvQKQFwawOz+DNOOCeQUjg9xGHcaYEho4/n2m93vXfCZ
X-Gm-Message-State: AOJu0Yy7BFHcHJU67KFntNuuAdxYiG2BthwdJU1TjnUKYnxKjMqI9OPF
	ZclRxRMjD7C7c6UHe7Y5itH1duInlaoUBfOjBQkq9zT9TQujw3hK
X-Google-Smtp-Source: AGHT+IFTr6AmoUCHJEtTWViHhncMvoKYgtkSIcxKwsADKaQBG1SR1opO+tMXXDG/egIRck4dnUZYSw==
X-Received: by 2002:ac2:5457:0:b0:513:5d5:189a with SMTP id d23-20020ac25457000000b0051305d5189amr1215412lfn.68.1709049699255;
        Tue, 27 Feb 2024 08:01:39 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id x18-20020ac24892000000b005128d0e2a07sm1228190lfc.308.2024.02.27.08.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:01:38 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: vireshk@kernel.org
Cc: johan@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 1/2] staging: greybus: Replace __attribute__((packed)) by __packed in various instances
Date: Tue, 27 Feb 2024 17:01:12 +0100
Message-Id: <20240227160113.111264-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch makes the following changes:
 * Replaces '__attribute__((packed))' by '__packed' in various locations
   to remove checkpatch warning

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/greybus/greybus_authentication.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/greybus_authentication.h b/drivers/staging/greybus/greybus_authentication.h
index 48b4a9794d3c..ee88f880cfe3 100644
--- a/drivers/staging/greybus/greybus_authentication.h
+++ b/drivers/staging/greybus/greybus_authentication.h
@@ -44,7 +44,7 @@
 /* IOCTL support */
 struct cap_ioc_get_endpoint_uid {
 	__u8			uid[8];
-} __attribute__ ((__packed__));
+} __packed;
 
 struct cap_ioc_get_ims_certificate {
 	__u32			certificate_class;
@@ -53,7 +53,7 @@ struct cap_ioc_get_ims_certificate {
 	__u8			result_code;
 	__u32			cert_size;
 	__u8			certificate[CAP_CERTIFICATE_MAX_SIZE];
-} __attribute__ ((__packed__));
+} __packed;
 
 struct cap_ioc_authenticate {
 	__u32			auth_type;
@@ -64,7 +64,7 @@ struct cap_ioc_authenticate {
 	__u8			response[64];
 	__u32			signature_size;
 	__u8			signature[CAP_SIGNATURE_MAX_SIZE];
-} __attribute__ ((__packed__));
+} __packed;
 
 #define CAP_IOCTL_BASE			'C'
 #define CAP_IOC_GET_ENDPOINT_UID	_IOR(CAP_IOCTL_BASE, 0, struct cap_ioc_get_endpoint_uid)
-- 
2.40.1


