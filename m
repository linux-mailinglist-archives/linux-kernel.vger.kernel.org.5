Return-Path: <linux-kernel+bounces-152095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B44D8AB8D5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFBF51F21599
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1266FD9;
	Sat, 20 Apr 2024 02:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWAhjaoh"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3980D625
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 02:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713580866; cv=none; b=D17yc1j2DHXDUCP8YBksND9JZfVZJPReNTyOWgp+Rj3WuEuUyzQilqL3f2wp8+JI2X1Q8cCFlKxAUlvHDsKSHr8XxPCnsNE/G0aDbatZe+wNK47sYtNwz99ekssSa+YLoyI9+a6r/6eNdPD2xPeZfe74uyiyWzi5LSDtSE2n0os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713580866; c=relaxed/simple;
	bh=WnDKoF43rGKHBFX9wId0eAqt9FNHwqM5SXYYZGgXU40=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=grPrL+L0diR8ORUkL9YQmc/8A++YFz6Af4MqVkW+DwK1y6Fc7cjxQPfLtqhAbSz+H5/EqjiNIMUTW0AqXofcqKx1RSWmK0J56iOeOBCX1gkaIxC3xzyhc95/mwlI+rQD45lxrDNpE4VOaZkcbD/XXa7css9AGgZ+LFUi5GA8y1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WWAhjaoh; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so3198283e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 19:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713580863; x=1714185663; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka09RLa2D8cd7MUnxWwNSTSulzyGO8xmtqt8/hCCE6E=;
        b=WWAhjaohO/BC11EFMmH3DuwTcXQtkeZByyQQJvTIwZ/Ti+SgmrCYzNNktJabunuvi4
         6asc5SIWvWHuU74PhGr0MJPnZWiDHFS0xDXV136oAA1MNGwoE3Nq5RZ3+T4S7c3/HwBQ
         0BGRkJfTFjAMDylN+gq5uuotFn2lnk6BpNmehtPuO6mIOwyZsOpw95XVAa7r5a+4aB/5
         iI4BIq0fD8vLHsDfGRtihvL08IA5mOFtoququaAuknUMMI8hoPPhtTz1LTn3oj34h1Ig
         vMp/xd3faF34s0dlxjtGzdI3+vcIAIRDCVcPmTiWg8/vQ1jhe8UZscNOlXiNXhGrk/YC
         LeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713580863; x=1714185663;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ka09RLa2D8cd7MUnxWwNSTSulzyGO8xmtqt8/hCCE6E=;
        b=Ot6PVtUAle2LlqT/GI0SczzWeLRHx4PZ8EgxMN7GsmHL6RLConehLqNf3ohhNKF+gA
         r3xyuT6KbbK82qLeniJmsT/Oee4/SdjbqqsZ0AyDPv/fiIBYsDn3/G+Iows2ekp63czz
         no6rUEaKNx8/knPMMaUeYC1XHmSEwtuMpnguL/JWhZpXI7eN4x1CZmxK+Nyg19/GDAy1
         WNADxNuWuunfgpijbgWtd5OUFPYiqV1w1iH9pO+0pwmpPsCZc0qPI6FdLSNWI5dnboJR
         kZJRXwJoVR6i6K6ETCe+YPvjit2NAuM2XBQ+ehtTsK3Jl9GiDEjU4++3iiRs5MoCGMtm
         W6mw==
X-Forwarded-Encrypted: i=1; AJvYcCWWCCPZ3By1CTKjH66ngkhunzpein3b2aTIFY8pxDmZpenCKX8bUSKXJrdIShY6/4Z19D2M7epbyrxcc0u60gRYbdhT3aNxVbOCWMhI
X-Gm-Message-State: AOJu0YyVEMVKfiMGoUvzKCtqcutwd8GiVWXJfzkPcUcDZuvg9qf6jOfr
	zwQvPir6oziFVtYdSLeosoh6QfoOpvk5oLrgHHc5SZpGY3o7bcQpNUsSS/Be4zs=
X-Google-Smtp-Source: AGHT+IEdjJXBFb5w49+fE8NoJQfuH+OO2sjGj2Uz4GZt2MgBoQ+8VACBUKhVAr7kAgjhUCv+o8HcSA==
X-Received: by 2002:a05:6512:2027:b0:516:d18b:eaea with SMTP id s7-20020a056512202700b00516d18beaeamr2100925lfs.33.1713580863266;
        Fri, 19 Apr 2024 19:41:03 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p1-20020a19f001000000b00518c69b3903sm956951lfc.84.2024.04.19.19.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 19:41:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/2] drm/panel: two fixes for lg-sw43408
Date: Sat, 20 Apr 2024 05:41:00 +0300
Message-Id: <20240420-panel-sw43408-fix-v1-0-b282ff725242@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADwrI2YC/x2MWwqAIBAAryL73YLaFtVVoo8eay2EhUIF0t2TP
 mdgJkHkIByhUwkCXxLl8BlMoWDeRr8yypIZrLakyWo8R887xptK0g06edC5uqJ2NtZMDLk7A2f
 9P/vhfT+h6DYrYwAAAA==
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=646;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=WnDKoF43rGKHBFX9wId0eAqt9FNHwqM5SXYYZGgXU40=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmIys+0HvzUeklhoAa/Wvr+hJ00ZA693pY2m20+
 MDs211otJGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZiMrPgAKCRCLPIo+Aiko
 1UJeB/9eALufS4MclyWW91OqSYOkuYXZm1GgWZ4tvkSA2otVRDZdCjAtmOOfQIxEYr2v3LgsRnI
 ZZRQtwhgvgIp5iS25hSeHFOZp3Mtl11m1Jz4DmGoNXMPlWh1hw0qe1F2ArWZEc8KQvgS1bJk6L4
 /XTyWI0iuY+i/PDMrz5s5KLMMkL4pSOteMEhY/CjGHhBkThxdkT2WdAtt+oUIEWIVda+5YTUqt8
 1j+DNMF05je9MYIH/MFm/aua27MjPIzwCaXobYcEF7CgdTcxpgCtItP5g6em5jpvdkMbTPJeC3B
 Dum2Ej6r5ciu385ngagFZQAS6EV2fob2UGRSp2z/coh5oSu5
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Fix two issues with the panel-lg-sw43408 driver reported by the kernel
test robot.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (2):
      drm/panel/lg-sw43408: depends on CONFIG_DRM_DISPLAY_DP_HELPER
      drm/panel/lg-sw43408: mark sw43408_backlight_ops as static

 drivers/gpu/drm/panel/Kconfig            | 1 +
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
---
base-commit: a35e92ef04c07bd473404b9b73d489aea19a60a8
change-id: 20240420-panel-sw43408-fix-ff6549c121be

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


