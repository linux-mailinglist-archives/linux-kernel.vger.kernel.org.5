Return-Path: <linux-kernel+bounces-11911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCEA81ED6E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB891C21715
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A4263C6;
	Wed, 27 Dec 2023 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="l+JbFlnh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786F25671
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-594bea92494so633529eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 00:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1703667026; x=1704271826; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l29Vl8Dt8C/GDHCSU2oPfWsYSaEWlVwYc5ssoVYbD70=;
        b=l+JbFlnh7S8tXlSs1umDn6ZFyTyPjhxFg2cOwcEf4gm8I+Ljq98utbFIzeAWWEVYEe
         T0jE7vquEUaPlSXl+i8PT88L2+/dCg9jC3B7XIs48ImPhiqRw16IZkTy/GGPzUOg4gx9
         EZGzoKvrg5GRs4UKoZU799jgNN4stEOUYZeiqfrTaRK1bnMUCRmH6OKOnxqc7Lwxy+Dq
         WZ021VWb+5jvm6PBg1e5L8VJnrs89lntKLVXW9D4GiqgeFvY3eVaJp06T+OR7Edg+7VW
         YgOBu5pbjdAevWF9xCRmnpd29DBVg2sorweNs1CePf1EaHj5ylIBvtF0zI+j0rz85tlB
         vgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703667026; x=1704271826;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l29Vl8Dt8C/GDHCSU2oPfWsYSaEWlVwYc5ssoVYbD70=;
        b=Zr5RpaCGlVwmkC+aoFgFd32yxoaVC4Hu8GEb2zKYCvsM6McJ0KqlrwKFGmj3fBwIyD
         bZjpjo5gvCYwXM9HSaQndRPCnHOWvCHMEXaV6EBZ/wxSDvcG4bXM1vAFe+Rb1NzF6tfW
         rkuz8iMMCFcq9LgyVwRAddydRMjulIa7EHDJOaGy/+MHP7p3AfFbuuYX/Wj3VCLu9Bzh
         pgtMHH+HZiedhSIwE8p8vMME7kDuqVFSYjTWsUhDagHQ+2BEt6sQCn30RyMASVo6NxeA
         QkIlx5VitvI0J6FWA2yiM2SMRrsTuf8+Uf46Eq1b9s/JPnaNTfCpMPm7KORdWSoJt2vb
         JIlQ==
X-Gm-Message-State: AOJu0Yzei7pj3GMluO1RpvljZ/pSSegAZYIh1rx6g2I7pkXUFOpqEDHW
	BhFwPdKW+7/+91UvRTgc0uOj7PlBKFTIfA==
X-Google-Smtp-Source: AGHT+IFcFGcr0Bv3LQAW7dd06uC6OWCWaINEihuHeK4fHl01S1TNHj6WqigqhinDZ+IUgD5l+SzgZw==
X-Received: by 2002:a05:6358:109:b0:173:b09:630 with SMTP id f9-20020a056358010900b001730b090630mr5665968rwa.34.1703667026384;
        Wed, 27 Dec 2023 00:50:26 -0800 (PST)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id c26-20020aa781da000000b006d9d39354bcsm3157505pfn.74.2023.12.27.00.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 00:50:26 -0800 (PST)
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linus.walleij@linaro.org,
	dianders@chromium.org,
	xiazhengqiao@huaqin.corp-partner.google.com
Subject: [PATCH v3 0/2] HID: i2c-hid: elan: Add ili2901 timing
Date: Wed, 27 Dec 2023 16:50:11 +0800
Message-Id: <20231227085013.1317-1-xiazhengqiao@huaqin.corp-partner.google.com>
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

Change in v3:
- PATCH 1/2: Modify title and commit
- PATCH 2/2: No change
- Link to v2: https://lore.kernel.org/all/20231226023737.25618-2-xiazhengqiao@huaqin.corp-partner.google.com/

Change in v2:
- PATCH 1/2: Modify compatible properties values
- PATCH 2/2: No change
- Link to v1: https://lore.kernel.org/all/20231225092843.5993-3-xiazhengqiao@huaqin.corp-partner.google.com/

xiazhengqiao (2):
  dt-bindings: HID: i2c-hid: elan: Introduce Ilitek ili2901
  HID: i2c-hid: elan: Add ili2901 timing

 .../devicetree/bindings/input/elan,ekth6915.yaml          | 5 +++--
 drivers/hid/i2c-hid/i2c-hid-of-elan.c                     | 8 ++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.17.1


