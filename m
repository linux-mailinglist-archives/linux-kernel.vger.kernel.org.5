Return-Path: <linux-kernel+bounces-33024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5015D83635A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08BB6292058
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936703A1D6;
	Mon, 22 Jan 2024 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHLCpe/L"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6B38392;
	Mon, 22 Jan 2024 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927043; cv=none; b=eTct6ifZPdt7uixQW7ViSYG55q2NoGjiN3oXR8xP+TtTFHNpzT17nKR6QuDH5vFZD1hW69W4GPcNOcbHTnzcz1QR8z7+++2sPOJIJtlOmI7IIZyN+JYAkwNZmBXV3VhUnNAFJlcsfffeyzSFFkVkNaDc33xNCF4BHhbOmsG2HdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927043; c=relaxed/simple;
	bh=bpxM3RStjvD61WzsBU6kT2NOhtFk8N6MEyotM4Ym22k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p2TT4GqbGj3JBIHCb2Bp86704PJpOxAvrXyyH6HzNl8ZGlIuJY/em2yUzeBeBo5Sh+CBsYaYrhaHAzK0DtaU8CqqgBRGpTDkNfQGyihTppE9E5XK8m93C/TPZqAbdhZawNeeJ44XEhEOdq41Q9hPJ8BcRC5i1yOhe3wKwRBgsCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHLCpe/L; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6dbd7f1a300so1433629b3a.1;
        Mon, 22 Jan 2024 04:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705927042; x=1706531842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3lSn2MWXdNHAKKYN20GWKP0NyTBXGMz5ougI0ZHeluE=;
        b=EHLCpe/L+j9L7ezTzq61peN305+789kR/2LyEzbtWuUb+NxmutsxiQkiFxM8d2aVap
         57YUgop2MKNsFgOwcpnR/kzy/5XKkkisnfFv2Ws6rLgaMyuavoHVetxRCdNmYMqZfE9M
         OmvwE06vyvsJ/oA18SwcqeO3x2FZ+3aF2ZeVCELfIB1BxucGXuyxhSeHQetx8yE4Vq1A
         IKP0Y8p5pZDQFAfSUMWVos1tTDXrFqiP3maJZIbXCx+vh3BWiNmyF28o1rwnzmp4QGQz
         ZoZSkTal9skgRCy3wyDa5tps8YIU8CHPAXGnzqnrwymBK8AvfzKMffqJmODo0LdqyTWD
         KtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705927042; x=1706531842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3lSn2MWXdNHAKKYN20GWKP0NyTBXGMz5ougI0ZHeluE=;
        b=shQqiyPle3BZ3Iez5j+END5FEx1wi9dYZpbmAFmS4Kb3XfjVjHDrz2F9TihTkl+Jxa
         /1gTvbwG263fbbOlliDpvaVrBQ+Q51mgwhJAhTaZqYFLUNXZ3btoQJ/Z8YWVES+fgY9n
         zJiXnGVRhXUgIDxpYN1AOsbTXAa/eXxdmhH/gdUr2mbKWvNwfDR0j5ERY1nw908XyAOZ
         h0lZOutJUwegjYUlfVqg8hwb8ibJqQVIAyOY2+67nYtZYWhCoWEoK4fjjPISLkabah1Z
         Kqn4IMXxSsAVYfGe6ad7QPKM5hOwgtBEFKA62hqv9zOrt32RpWFvDQZXTIMwn6hB8VIn
         L3AQ==
X-Gm-Message-State: AOJu0YzYI68T/enON4JElnKFLyNHOs58KtYEhA6/W/b43k82mZnjR7Fp
	ZgyW9iqwBa9qRU3+yE3tLIdn2p5CySZ5Ml0VDIXXdpt4hkKeY1ah
X-Google-Smtp-Source: AGHT+IFVmQXiROx88TY1ca3O5wEcfWhZWvXngQMo0u9K7Q3dTjxCK+cRBPReoEWHw1gnygPYgSJtZg==
X-Received: by 2002:a05:6a00:198c:b0:6db:db2e:46f0 with SMTP id d12-20020a056a00198c00b006dbdb2e46f0mr3156551pfl.53.1705927041974;
        Mon, 22 Jan 2024 04:37:21 -0800 (PST)
Received: from hdebian.corp.toradex.com ([201.82.41.210])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a0021d300b006d9be753ac7sm9452933pfj.108.2024.01.22.04.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 04:37:21 -0800 (PST)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH v1 0/2] nxp: imx: Add support for Apalis Evaluation Board v1.2
Date: Mon, 22 Jan 2024 09:34:58 -0300
Message-ID: <20240122123526.43400-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

This patch series introduces support for the new Apalis Evaluation Board
v1.2. With the introduction of v1.2, a common dtsi file, containing 
shared configurations for both apalis-eval.dts and apalis-eval-v1.2.dts,
has been created. The eval and eval-v1.2 dts files will now capture the
differences between these two boards. Additionally, updates have been
made to nxp/imx/Makefile and arm/fsl.yaml to accommodate these changes.

Hiago De Franco (2):
  dt-bindings: arm: fsl: Add toradex,apalis_imx6q-eval-v1.2 board
  arm: dts: nxp: imx: Add support for Apalis Evaluation Board v1.2

 .../devicetree/bindings/arm/fsl.yaml          |   3 +-
 arch/arm/boot/dts/nxp/imx/Makefile            |   1 +
 .../dts/nxp/imx/imx6q-apalis-eval-v1.2.dts    | 198 ++++++++++++++++++
 .../boot/dts/nxp/imx/imx6q-apalis-eval.dts    | 108 +---------
 .../boot/dts/nxp/imx/imx6q-apalis-eval.dtsi   | 120 +++++++++++
 5 files changed, 323 insertions(+), 107 deletions(-)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval-v1.2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval.dtsi

-- 
2.43.0


