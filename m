Return-Path: <linux-kernel+bounces-132568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A1D8996B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B811F23063
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A7D12EBEF;
	Fri,  5 Apr 2024 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6Y0eSj9"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B985912EBEE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712302811; cv=none; b=SCTTqCjuY/CobNmzCZyp29kxAIMS0xRdu2gJp1Dw17TOpO1XEzmoyJkE1CcmytvbgNym2i4wQGDzEvcnXq0qgHHLTpJq4BpOacckmcHLKAce9qG/xoZUOtTMY8upHl46L510k2DM9B1vv6PvbRbGap5q9OAe5rWoSdJMUxzfO24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712302811; c=relaxed/simple;
	bh=MhqSyX6UHvibWFRk/FMAS4YhWCcFYzenPIT5fsaXvgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k6HWPGkdwIPVlcwKa0/KY5dZzX19+q9tdAPoZiEc2h8/rX9vTeXkeCGXAXdq1SnYHSH1AknSLzJl1ZC6mXl24cj9p0a185q+QB54nejsbGnIYO//6NQn+wIHokAFkqkHuaU1ooqwBBLL899t2xaTxBW/jHaqczV9VzZ68nxNpf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6Y0eSj9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343e7c20686so204542f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712302808; x=1712907608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x+3LCp79E/Lh9YihvxuRprMNpc++Xix/ji1hpk1cR4c=;
        b=W6Y0eSj9ORXNseTRvYNYvfQexQRgN5EuISDIyqzEhh/SN4ZM9cWxlOzuxbQvOhNQXN
         Uu//iC8iYLeTXZknKp6MzHm1y9+Dg4wQT618RlRHWpOJ+KK2lQh4MHrTWXyddNv1mKfL
         BYCLm/9QZg9nP+xsXfmA/t3+cqkYuZtKRjp3MX+eeM5pwLKSwEv/pmbciMcIzTN7Ua+B
         Z7fjcsTKw7uPpN+n7+VNSUkuKyg2LQWM1U18bqn6Mv3OtLx1L1HRPvCSIMAyx7kRrxGc
         ZKsO/NDwqSgYihIv3yIoUYZM23/DBDwOzj/zv8U6FQ9zsfMFiQsBOLpXROfSTVJeLbgK
         a/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712302808; x=1712907608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+3LCp79E/Lh9YihvxuRprMNpc++Xix/ji1hpk1cR4c=;
        b=g4jVi213MPsvzEoJtv+3C5ZGK8URZeAM+qmiZvw1QGzVjbGeHFbbCOL3UhWAVToA2c
         8JjWx8XisFjn9WKT75XLYq4rorIpUz10zoIuncEpkUNPf05BEOEqQ5HPzyimZXL2QUeu
         UcNKcRQxMDcDXkogN587uhceJm/7buxnC+RY7Pk/BMEp7wCYGWzWyb2q0BqahIAml5lf
         J+243B6G5WNuhHbCJuJ+VbQMk+t08sPVHfHvlDBVIM0JUFcVY5sSX3tQwdBDKpQ0O6cI
         WRnUQtLncc+Wzak91CPZj3kP6xhr2FrFil15TQ2euhdQal/NMtMqfYq7vc3LkESPWf8+
         YTpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqOM1ZDN4MN8IJaB+XaL7r+yoLgOoxDv5WIWgsAEjgLPui2/bPkUNkqYT4K4KdDarjJ9t0ygoT6zPJB8BeVTRdgICIWZigzJBS3zFW
X-Gm-Message-State: AOJu0YxW+daiTbdYi2p4/c7WTGL3YET1i/g6U9/l+fKCFKgBLEic+tMw
	h9hXH/kuCvXX9omIkockSrz0TCv3xhiobxf1rqRpCl4kr6qa9mmm
X-Google-Smtp-Source: AGHT+IHgtniqebPWb8hYYuKuadt02pO2NBU70LozXXNGdnP0B2+WFpQn3wd0Zg2EkqCzROhrIyfocA==
X-Received: by 2002:adf:fe0a:0:b0:341:d6c3:5c4f with SMTP id n10-20020adffe0a000000b00341d6c35c4fmr647634wrr.21.1712302807997;
        Fri, 05 Apr 2024 00:40:07 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:737b:ef00:2bdf:f41a:ebd1:fb2c])
        by smtp.gmail.com with ESMTPSA id l10-20020adfe58a000000b003434f526cb5sm1311643wrm.95.2024.04.05.00.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 00:40:07 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] staging: pi433: Cleanup & fix potential resource leak.
Date: Fri,  5 Apr 2024 10:39:53 +0300
Message-Id: <20240405074000.3481217-1-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset improves readability, maintainability & fixes 1 bug:
        - Rename device related vars.
        - Update pi433_receive param type.
        - Remove duplicated code in pi433_init.
        - Reorder pi433_exit calls.
        - Fix a potential debugfs resource leak.

v2->v1:
Followed by Dan Carpenter's <dan.carpenter@linaro.org> comments:
        - Remove empty "fail" goto tag.
        - Reorder pi433 init & exit calls so they have reverse order.
        - Add "unreg_spi_drv" goto tag.
        - Check "debugfs_create_dir" return value.
        - Update "if" statements for consistency.
        - Rename pi433_init return var to the more common used "ret".
v2->v3:
Followed by more of Dan Carpenter's <dan.carpenter@linaro.org> comments:
        - Undo pi433 init calls reordering.
        - Remove "unreg_spi_drv" tag.
        - Undo return value check for "debugfs_create_dir".
        - Undo "if" statements update.
        - Undo pi433_init return var renaming.
        - Split patch 5 into 3: duplicate code removal, bug fix, reorder
          exit calls.


Shahar Avidar (7):
  staging: pi433: Rename struct pi433_device buffer field to tx_buffer.
  staging: pi433: Rename struct pi433_device instances to pi433.
  staging: pi433: Replace pi433_receive param void type to struct
    pi433_device.
  staging: pi433: Rename "pi433_dev" of type "dev_t" to "pi433_devt"
  staging: pi433: Remove duplicated code using the "goto" error recovery
    scheme.
  staging: pi433: Add debugfs_remove in case of driver register fails.
  staging: pi433: Reorder pi433_exit cleanup calls.

 drivers/staging/pi433/pi433_if.c | 690 +++++++++++++++----------------
 1 file changed, 345 insertions(+), 345 deletions(-)


base-commit: a103e5ad21992384b0b4332df52e0467107eb113
prerequisite-patch-id: 91943193af2fea74182be67fb583235a3fbeb77b
prerequisite-patch-id: 2cad031ba6a0782a67ab1645ff034a8be65c2e76
prerequisite-patch-id: 1a852ed8f9d133aec7c651fd9007e59e39c55fb7
-- 
2.34.1


