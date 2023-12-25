Return-Path: <linux-kernel+bounces-10972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFFD81DF77
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 10:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B61B2144E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 09:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED8B6AA4;
	Mon, 25 Dec 2023 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="ITQwgbqw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F884C67
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1f060e059a3so3017485fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 01:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1703496538; x=1704101338; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBInASZcVvL/r9rvuQRwtnvS/Zl6KYpAUl/NW6mS2Gw=;
        b=ITQwgbqwVaiqViCbAzrnzqkIC9IFFEbUhhcpNSgLLBSkUocGja6U+T6KvBhQlwqHDh
         1smEdJEa01ruOEnZ8erM+Yc70DaTZpkjUMlgUzKQgxrHNvsL/XVlAH/BnCpvJNvnzDZl
         NLjIAAgghwNNOGnsTGcu7EO/6eUTq+V//zssaLiedkh9J+GqcWiNMJDiOEac8ZSKsH+D
         VNZlhUDk/qJCw1g3cKjcKfRKbWyB6EAbjAg08E24VzLxv8GfwJIGiGMitFV5d58Qew6Y
         VaAuWtowfhga6DwPHHbxChJYv7UYB61paX8x3akgWnKn363d7CRI+if2vo+Ef7pDvrvr
         SxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703496538; x=1704101338;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBInASZcVvL/r9rvuQRwtnvS/Zl6KYpAUl/NW6mS2Gw=;
        b=p/J06HZ9vuoXnxICfqCkQz6ljPs1o/qi4XFpNoGLs3tP/52ZTbaMatCMywm0Iowklt
         apOFlUqa61pNj+hb844hbRTFvjYlJM60LyrEeJ6JX8mpbxC6Jl4LgAaCeqx4LxL26Ywz
         xiPw4iw4aZZ+37QKrWe3dwcCGILqD7N0pze5gH9x9GNfglyQlUJ1vWaVt7ZBPgZ6ThzU
         LKZ4gzbduAoxb/rLXGND+ONVCcIxKaEquDE/b1bpPCZ6vv4aZsC7DwhlutqRpX0IBF4C
         ITtKC3a7Af1OYC1t85CVTxLvuw7UT8mAEGA2kGcAkwfWE4qWd5s3v+I67ixzVh2Ts6h7
         Pw9A==
X-Gm-Message-State: AOJu0YyUWe6bdX6dPKiy8Db4rhFwsZvfQNcjEAFwsS6fnDEJjZXOKGI4
	n4ipWAMLgpFc+ctwVkIH+TiZ/MgE8cr4sw==
X-Google-Smtp-Source: AGHT+IFvIMgmkkBfDwIHiof9PGJCbvmXyTDi6GD1Xm5fmMsuSZXd2xjZROTbdftQGnN7rldD95YHtA==
X-Received: by 2002:a05:6870:9726:b0:203:64c3:7b86 with SMTP id n38-20020a056870972600b0020364c37b86mr7505650oaq.44.1703496537956;
        Mon, 25 Dec 2023 01:28:57 -0800 (PST)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id l16-20020a656810000000b005cdfa6f5aeesm4393267pgt.94.2023.12.25.01.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 01:28:57 -0800 (PST)
From: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
To: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	dianders@chromium.org,
	xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [v1 0/2] HID: i2c-hid: elan: Add ili2901 timing
Date: Mon, 25 Dec 2023 17:28:41 +0800
Message-Id: <20231225092843.5993-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

ILI2901 requires reset to pull down time greater than 10ms,
so the configuration post_power_delay_ms is 10, and the chipset
initial time is required to be greater than 100ms,
so the post_gpio_reset_on_delay_ms is set to 100.

xiazhengqiao (2):
  dt-bindings: HID: i2c-hid: elan: Introduce bindings for Ilitek ili2901
  HID: i2c-hid: elan: Add ili2901 timing

 .../devicetree/bindings/input/elan,ekth6915.yaml          | 1 +
 drivers/hid/i2c-hid/i2c-hid-of-elan.c                     | 8 ++++++++
 2 files changed, 9 insertions(+)

-- 
2.17.1


