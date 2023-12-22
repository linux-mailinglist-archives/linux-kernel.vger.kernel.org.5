Return-Path: <linux-kernel+bounces-9665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2918481C93E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB4A1C22034
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5847718053;
	Fri, 22 Dec 2023 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IXMBb+pw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727AA1774D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d3dfcc240so16340695e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 03:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1703244963; x=1703849763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PKt5Y+2fZyiY47Rm5M/31Sq2kMuO+mRAN0xTp0Tfkq4=;
        b=IXMBb+pwBWbta0XGLqni7mQPZRopgFHXzLEnl/jsRf32rajOc6tGndqm4r5aKUh16s
         +dNKEqp9/l/gJKzSoj4ahvzJKZLm8FXYQrcjCoFiPSfl8ttGIXiEjZtoxHXHK8nQOMdy
         YhdYdIJ1DFJnADt95qnXAD7INGxAlV1GCh3fRZ8neLNkH1VKV6730Q+zIQS/LQXYjiSr
         Tdgqs4ubeZIZKXfYD0uHUKA+hGIxwpAOi+3ky5qRVI2EcHjq19jtC19ZEZ0xDldwfinZ
         spStRxotGXLcaiKhyUDfQxDDlrRnZ3BQebtO2jCh9MQ8lda1PZCTQH4ebSdeddocUh4x
         5kdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703244963; x=1703849763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKt5Y+2fZyiY47Rm5M/31Sq2kMuO+mRAN0xTp0Tfkq4=;
        b=MDbN5f0Vn5YM12o+7fMdua81vrcBYvrQvrR+4FQG8nzR4/bP0e/oyfGgYAoNd7O+eq
         v0TzI1eBzgpofXRfLcsA6MMMGjf2ty/OSikRdia/+MlXsUH1nIZNs4vJe8j6WjEkoGog
         4mDv0ZILlttIS8H9s9wRJ4BM2INZ0f1ZHDFmOa55hk50XQeGdNkxDZIlOZXhuesRxNQa
         Qo+Ea0tNzHcw5a0Kta6I38a3HNj3kJFbbzN4Q7IUAMBMn/N47BjqgXEx9E/bicK4pxEq
         Ur+6NRFNNAfv2tvQyyiXL+T1z/z9HTcnRqO1/+0JRfzaKqPMM3GkLqFlZX3/YcFxH4Lt
         238g==
X-Gm-Message-State: AOJu0YxWFN7D3R3+FtEpJzrpYCaSGy9sHLclnDplZcEXhOFyCXe3V1RS
	wW/dUlMGrt4SZSjo8cIOZEyt6VrJTG/JJA==
X-Google-Smtp-Source: AGHT+IGy+fcx3A6yDZXutooPrNrl87u19VR8Ine5jP95X3D2QiZZp0U8QET+YLUb6wukTZMzX0Otog==
X-Received: by 2002:a05:600c:21a:b0:40d:2e56:f13d with SMTP id 26-20020a05600c021a00b0040d2e56f13dmr389347wmi.275.1703244963339;
        Fri, 22 Dec 2023 03:36:03 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id fl6-20020a05600c0b8600b0040b30be6244sm6802472wmb.24.2023.12.22.03.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:36:02 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshihiro.shimoda.uh@renesas.com,
	wsa+renesas@sang-engineering.com,
	mitsuhiro.kimura.kc@renesas.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net v2 0/1] net: ravb: fixes for the ravb driver
Date: Fri, 22 Dec 2023 13:35:51 +0200
Message-Id: <20231222113552.2049088-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds one fix for the ravb driver to wait for the operating
mode to be applied by hardware before proceeding.

Thank you,
Claudiu Beznea

Changes in v2:
- dropped patch 2/2 from v1 ("net: ravb: Check that GTI loading request is
  done")
- kept a single "Fixes" entry in commit description
- updated commit description for patch 1/1
- introduce ravb_set_opmode() that does all the necessities for
  setting the operating mode (set DMA.CCC and wait for CSR.OPS) and call it
  where needed; this should comply with all the HW manuals requirements as
  different manual variants specify different modes need to be checked in
  CSR.OPS when setting DMA.CCC.
 
Claudiu Beznea (1):
  net: ravb: Wait for operation mode to be applied

 drivers/net/ethernet/renesas/ravb_main.c | 52 ++++++++++++++----------
 1 file changed, 31 insertions(+), 21 deletions(-)

-- 
2.39.2


