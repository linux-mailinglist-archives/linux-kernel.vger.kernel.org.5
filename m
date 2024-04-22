Return-Path: <linux-kernel+bounces-154049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCC28AD692
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0050283CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9AA1CD0C;
	Mon, 22 Apr 2024 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcmzcP3t"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A1620DFC;
	Mon, 22 Apr 2024 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821433; cv=none; b=FcPKAo/NYYn66BTjrV+mTkWrV2WDGJK2fG9zZcjXMwFWzg6+rGjbw/WvyPnCN1J0M0EFVij/fNv0kNN2bcyqXnSTbK1Kqz5H0/PgmcJDvPPm9GfQYB5hzCPZFbDPzdg4Wnh8tI6B1leGfxdtDb9nMvnIuqsmmUr8iKcgt8JKPNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821433; c=relaxed/simple;
	bh=D6H6tgVKSoF5+PVtpugRnr+fZR4mp5814z+JC7PQDsI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UdpduQP1MS7G3MbmKvpwb9A2rxxhwpjuvdiZgNOq/TnYZ1L03YsTXqlQL4CZdqdVtHB9EnnGLEPqX9SihC/x2QHPQgcLvTcCkqQMh6G1/nQHkCgzmgSpaiJRgf9+ahiVtZIc8aC7OqE7oHKdmv2yBB3pUiLxr/cfNFVwHgGnNLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcmzcP3t; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34b029296f5so1587290f8f.2;
        Mon, 22 Apr 2024 14:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713821430; x=1714426230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tKESjTucK4nTxwa5vtEgiHlzXe4qJMLDNifUugI6ya0=;
        b=YcmzcP3tJnyfKULNFvHRbYUlOyBWXXBwbiXxha8i0JexMMfcSQOXzwxkVT4SgeJ/zV
         uLJ36CMKEP+STluW+yugGbrGbuHaPVXLGtcxhapSPM/CZg8E4ozAmwqXlMYIA4ohARVy
         kMV05s4RmqtkRjrK0j6X5RXerfNrX41DZBm+jhdDaN/hNA1CaI44rXDqxfmEVF3oE5SW
         Ez16A7HfCookZUr2umBDemTLwVveSmcjAFC7miIQdFRVR5kWEnLREENkJfOqJydve8Cf
         JYrYPG50fFG2CFf9YAqhkh8vLLdPb8+1F2l31z6xc+7gZbcqvv7CejmJRpZb4RpOyV3Y
         +hAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713821430; x=1714426230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKESjTucK4nTxwa5vtEgiHlzXe4qJMLDNifUugI6ya0=;
        b=xBW7lZVl3LTb1/TC3zNAENLhsPLo3cAIHEY4q6XuIkT76lgbAdfHqZtTSVoFOreDq2
         VCZ47k/wLOZ2iQecvdBjXhDE5jTPPxg3LGJLlnWlID/EGMrGreyKm8MDcRgmZKwzB6Q3
         2q+sQ1eRTjH5qUpvaAzbbIEi8Cr/f3EgRUGSUY0lDVJa6L7PXoqQ8cLIwHEek3BlkPT9
         JtSGk5kB9AvBPsypW/npy1Di/jjy6zzVINrMnFLwcu8J+8Yd4nrHq0Ewu3fqrO/jXOSP
         ppvN2hE7PMnN2actQokuZidUfQFCFtRIOE6Yok6lD4Tlkta13v5BW2d86a3ihFjjsh3g
         cDsw==
X-Forwarded-Encrypted: i=1; AJvYcCWXA7DBNZHcQksDwrACgWGF/lYzM1n6Cf5kTESbFpBKMbvqEW4ijuH1sIO11mQGto+F+4ofO8JSJsWrUpVRvz4DakXQ52l3QNP5zB1gcOFl83oCT+J7lkEzoakYWLiVmgd182PtFk3kQ1uBC+ja0PwBGJ11p3af/sU24tFkKzIKdGhHUeeUs0T8g/8=
X-Gm-Message-State: AOJu0Yzhc66vHywoUG5r/BMqtnM6HpsME5VwS772Zg7oT/VwnPyzSpGw
	lEyctuj+r6UNTnh6F1OU/Seq4ilbK3maj54HqqXf6l8QF+CfLZVm
X-Google-Smtp-Source: AGHT+IHuRAue9uGWc3s6NyDnrcLPENmSmNVL0IO6/th4i9Gy47INXau0cr5w+D4R4JVSEOqckTWstg==
X-Received: by 2002:a05:6000:181c:b0:34a:481e:b1ea with SMTP id m28-20020a056000181c00b0034a481eb1eamr8579038wrh.18.1713821430263;
        Mon, 22 Apr 2024 14:30:30 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:ab0d:124:447c:bf37])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4844000000b00349f098f4a6sm12886793wrs.53.2024.04.22.14.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 14:30:29 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/6] Update compat strings for SD/MMC nodes on RZ/{G2L (family), G3S, V2M} SoCs
Date: Mon, 22 Apr 2024 22:30:00 +0100
Message-Id: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

- RZ/G2UL and RZ/Five ("r9a07g043")
- RZ/G2L(C) ("r9a07g044")
- RZ/V2L ("r9a07g054")
- RZ/G3S ("r9a08g045")
- RZ/V2M ("r9a09g011")

The SD/MMC Interface in the above listed SoCs is not identical to that of
R-Car Gen3. These SoCs have HS400 disabled and use fixed address mode.
Therefore, we need to apply fixed_addr_mode and hs400_disabled quirks.
'renesas,rzg2l-sdhi' is introduced as a generic compatible string for the
above SoCs where fixed_addr_mode and hs400_disabled quirks will be applied.

Cheers,
Prabhakar

Lad Prabhakar (6):
  dt-bindings: mmc: renesas,sdhi: Drop 'items' keyword
  dt-bindings: mmc: renesas,sdhi: Document RZ/G2L family compatibility
  mmc: renesas_sdhi: Add compatible string for RZ/G2L family, RZ/G3S,
    and RZ/V2M SoCs
  arm64: dts: renesas: r9a09g011: Update fallback string for SDHI nodes
  arm64: dts: renesas: rzg2l-family: Update fallback string for SDHI
    nodes
  arm64: dts: renesas: r9a08g045: Update fallback string for SDHI nodes

 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 38 ++++++++-----------
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |  4 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  4 +-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  4 +-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  6 +--
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi    |  6 +--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  8 ++--
 7 files changed, 31 insertions(+), 39 deletions(-)

-- 
2.34.1


