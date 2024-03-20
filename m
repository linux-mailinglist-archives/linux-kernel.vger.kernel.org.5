Return-Path: <linux-kernel+bounces-108912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9158811D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97B4DB23105
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760E93FE3D;
	Wed, 20 Mar 2024 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elDQzjL5"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797D940873;
	Wed, 20 Mar 2024 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710938818; cv=none; b=bMoMf2O4tAYOISsa6133eTPCZ/B29OmYviizSoIR1MIhNeIvC33e+zEOF5s03Z9dUblPfh2ST1N5Meo9kEwINV4BOTtWvOQzKF6VnQ5nPVK3C6oq6o8g+TbjS+NVoeBTND5D0XNVh1gWPFN2As4+fBYL/hm0UPotHJM9e+1dXM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710938818; c=relaxed/simple;
	bh=qG8vU2VNbKP5oWa019GPK79bBq9y97fVA9aDgoKPkbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OAeGO6VEizePmcmMGRBtxhLzF4diQDvJ5Hux/QvCtW4B81eToE9sT6J3c3yXbETgidFAaofuz/Ui7xGbcmxNe5NjB0bwybxbJeYNN6W8HJJGMp+pta9w6ze0mQsPX/o3OhaT6RIS3s1lyJ/ob65vDDqQABPmke9OAIhM5W/TtmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elDQzjL5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e04ac4209eso14968205ad.1;
        Wed, 20 Mar 2024 05:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710938817; x=1711543617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSN+FDXXyYc0p+FXZb4g9T/TuLHmj5IB4QRgcl+NvwM=;
        b=elDQzjL528QB/K8rig1yfGrw/Uv9MNBjZX8/tH25ynCNklf+hlvIRReFQQ6lbTs9MN
         /cyeL1AZF3ifTdCgdZqLZ+KnALE94flw0G+XzHYGVdm3bk9FjXvjrkuysp7NIj092h4O
         GnVrONVJmLq2en1rU+UGR9INh2O1RAsHg8QpDLVHNwWTNA6jrNttDAAJ62rsnbUc8TXj
         13/jThCsVzMSZm/MCzlf7Crryo7e+DGemPaOBb/OEj4PavAp/gJZ4R/aQdXrBw0qkdnT
         tvDIAjeVueJCwe7QbgtMYhAp9HKUjPfE+z0cBwfXHDch2Krmm8JMUWJ2Po/7uorteAVo
         J5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710938817; x=1711543617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSN+FDXXyYc0p+FXZb4g9T/TuLHmj5IB4QRgcl+NvwM=;
        b=VT7CxjTdYH9B3NApLmLcG84NsO5DDRS1ZZYrDbHjU5tLTEzfPfN329kg14vN73wObP
         5NCku0Hkq/c9Yf9McC+VsBSeMvt+B985E/PJYXX6Ry/9fhfPSVIgRtmrlRMDibmI0NHk
         AICIQij9n/T4DLGWwoNv1VkxQprw38kt2aJXtmUPpQPfBoSJBSzzWBWUHsVGpf1lJNdE
         6IS1O0ZEUHzGX3Egq0FqaoqFGpOEnnkikXJaiPsCvRgsHIpPIiTQ7+pJxMFXptmtY9SC
         1RkCNIReHLo8V0u9Amyi7c0wiZ692zoUkzDqerwsGdLQsR2CBe5CsJYpaeFYyOD3PwLY
         jpSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4MjhcX7DE5NJ/twuw3mwPRM1lrtUOnDg8JbS9TyHtX6qxx8kPepY62DdKa6LkwlO0VjfLKbawag0ckwiU4ZgmlJ0jXJsPx4AImXnnghG+tzGKTxMb38DF2X0OWl4NXPUMfG8m4igIAA==
X-Gm-Message-State: AOJu0YxSooOwae+CVNmj/RIe3BvyFtt7HBSX3BMJAXDgl8/23oGT0gwv
	+CeyW5IWVu4ceoRVhzFn4GEM94qOi9wzvb/1etlHxsY0NNBgN+4q
X-Google-Smtp-Source: AGHT+IGBSLCxUJjMvyQEMyZhLnm6rU96mG5p6AlorUhB5IfhmOkGeiS+w67cbCMG3pv6iors13f0Bw==
X-Received: by 2002:a17:902:cccd:b0:1e0:2a4b:e51b with SMTP id z13-20020a170902cccd00b001e02a4be51bmr10253211ple.32.1710938816881;
        Wed, 20 Mar 2024 05:46:56 -0700 (PDT)
Received: from localhost.localdomain (FL1-125-193-23-126.chb.mesh.ad.jp. [125.193.23.126])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902ea0e00b001dda32430b3sm13441004plg.89.2024.03.20.05.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 05:46:56 -0700 (PDT)
From: INAGAKI Hiroshi <musashino.open@gmail.com>
To: pavel@ucw.cz,
	lee@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	INAGAKI Hiroshi <musashino.open@gmail.com>
Subject: [PATCH 0/2] dt-bindings: leds: add LED_FUNCTION_* mainly for router devices
Date: Wed, 20 Mar 2024 21:43:15 +0900
Message-ID: <20240320124431.221-1-musashino.open@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds some LED_FUNCTION_* definitions mainly for router
devices.
Those definitions are useful for OpenWrt or something.

INAGAKI Hiroshi (2):
  dt-bindings: leds: add LED_FUNCTION_MOBILE for mobile network
  dt-bindings: leds: add LED_FUNCTION_SPEED_* for link speed on LAN/WAN

 include/dt-bindings/leds/common.h | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.25.1


