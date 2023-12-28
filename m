Return-Path: <linux-kernel+bounces-12674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A53481F8C2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5F01F242D2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C162EAF3;
	Thu, 28 Dec 2023 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cP++dU7l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C77F4E1;
	Thu, 28 Dec 2023 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3ef33e68dso40191615ad.1;
        Thu, 28 Dec 2023 05:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703769428; x=1704374228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yN/BwR58sjs6Z6HNo7x/JKwvYgjONzYk0BGkAM4zBTw=;
        b=cP++dU7l5K23F16rYhlsogkj0dJtZJCvNtVYdyTjBBHkjRb66U3XV4AK0jX33kJqHS
         bPOOnHUuhmhg7J8YGUdJpHgfm/L1yWcF6o2FGHolmOzrIhmTVHm3gNzVAOJuB0PSNYIK
         r9cMkwtvftKbTYJ2cVd1c/KHEQ21KINi2ZMC81Ua0Vl5ExLsnjQAUl9NSscJhbHSDf+E
         6pDxTDpB+WrB9ju/fP9qdlDmPKbofpGhpIbarR4fIcEi3t5XQzJ7W8iWpnZ8Qt4yv76e
         +Tjl1yArr6V6Gpa5ya+I+IiQg71WoW255gxfpk1XSIBqwXvHIUPRuWAVxaXzBlolMWKj
         pfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703769428; x=1704374228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yN/BwR58sjs6Z6HNo7x/JKwvYgjONzYk0BGkAM4zBTw=;
        b=qOs74FatyujBwn3l9jHdoKKcnaxt8MpFHAOwx888esrYeMukwSYKv1ZI/F7tdXGjz/
         rkpeEq2OeknqT/dXuy5GqZK+tG5OM8IhWM0/B50OxWpl7V6JRfhZQ2V8YlDIiKwVSxyy
         FNNaO3PyoJHMixLGvtZLmdwVcjZzSZXItqgKEHHBpROKcbFoN7A2WSL6xv6luq2mzLcO
         lyqEBTLSizDwerNRUFTSx/TC0PvJFdya3hbKkh3iIWbN4U+wzX+BKFYwORm6eUiW6nw4
         5FH36mgcx/WVDGu5MAiGpfoBn+bfvl6xXhTZzLWzuRoShn7yUIC7QMO68tFUpqbIlTrC
         ZUoQ==
X-Gm-Message-State: AOJu0YwKv7l/XT3TdII29F6waWQyhRUCmYvFbRnmXeOs/hZaw37jTSuv
	8xYMguprrVaJG6HswJf9FUc=
X-Google-Smtp-Source: AGHT+IF+99H9vFulPcHP15rmUhxkM0gfuVWxtxhJUptQjIgcwPzGk7WYL5NXp8Vf+AEfz6qattXg1g==
X-Received: by 2002:a17:902:784c:b0:1d4:7855:cdf6 with SMTP id e12-20020a170902784c00b001d47855cdf6mr3456088pln.30.1703769428408;
        Thu, 28 Dec 2023 05:17:08 -0800 (PST)
Received: from localhost.localdomain ([2408:8207:2540:8c00:3708:559:ea20:9883])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902db0a00b001d0b4693539sm13864221plx.189.2023.12.28.05.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 05:17:08 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	sfr@canb.auug.org.au
Cc: liujianfeng1994@gmail.com,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/3] dt-bindings: media: rockchip-vpu: Add RK3588 compatible
Date: Thu, 28 Dec 2023 21:16:17 +0800
Message-Id: <20231228131617.3411561-4-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228131617.3411561-1-liujianfeng1994@gmail.com>
References: <20231228131617.3411561-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible for rk3588 Hantro G1 vpu decoder.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---
 Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
index c57e1f488..ba41446f6 100644
--- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
@@ -25,6 +25,7 @@ properties:
           - rockchip,px30-vpu
           - rockchip,rk3568-vpu
           - rockchip,rk3588-av1-vpu
+          - rockchip,rk3588-vpu
       - items:
           - const: rockchip,rk3188-vpu
           - const: rockchip,rk3066-vpu
-- 
2.34.1


