Return-Path: <linux-kernel+bounces-49600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF99846D11
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD750B21746
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878FB77646;
	Fri,  2 Feb 2024 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPRpDt2b"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C277642;
	Fri,  2 Feb 2024 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866765; cv=none; b=mYKdlIh6EQvOnh48vUO8HR4lkdaa/5TgT1MJb3j4tDiYH/KMhXfQfoHEPVeG7PvqMswV3UuLdepRBnvRB5E13O2Q+WiSpqtswNNH1wBYPbuL0N5b61xNrpSKvVj8giiKDzwrFxku70Qy4nSpXa2quQPNAzUz1NJOAV0H25qFIhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866765; c=relaxed/simple;
	bh=i6VzPQcmaHZz+lcT8P1hT/YUY2f63rXFfOJiBuDetT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c6dIWIThCqO0hPEimP2g0j6E3KWnUY1yxsPuPsqOnz+IrmFBceT8LfjvtHI7NODghXjpaeqhNE2bEbJfKlBDgoP+pi8nusjfYW9HgALiQ6H+wQ08ZBy1nR1Z6V15jVPyg5HA2l3B9TN7Ic3SwMGSDI6an1J1eOaDU+A7qDyA6Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPRpDt2b; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fc654a56dso3737405e9.3;
        Fri, 02 Feb 2024 01:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706866762; x=1707471562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4GGWELPS9iWSYGrtv1b7XMN4fN8IDBU9iRWYuxavx4=;
        b=SPRpDt2b0GiYd1qFajfvYEgDxgThrt+9sn/DoWWu45VjK0wLJdXIWxfSHZeYI4H+g4
         fUjEUThmkkNfsW7lsiCUFtwFBo3tqgx2NqJQckKzfLzXBw1pOVTWq5z26cnwDV69BwrM
         f/+1AF+VcygwAG7RrvWXnq6JPrHfy4k+5OcD6pobQqOUsQ8ugTvbf8WzBXW0VTWDdkG4
         Ch5bvEHDQJ2GDGEz4fd3GCVubCrAFW71IPRnPhorDZexIrkfFCxv3JO1YYmVDUi0R+Bs
         OTXSEFnolNyZ4gw69MYra5HgpgiQW1EA2bHZv6fc7tbuatJTl+P2quTvb4+ukJw6VqXO
         ZNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706866762; x=1707471562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4GGWELPS9iWSYGrtv1b7XMN4fN8IDBU9iRWYuxavx4=;
        b=J1Z78RTg2UdsnM5qR6PvONOvUqYcQ4YGVCQSoOb4oAbOdMToH6epBGnsME10dqUkeQ
         78R/yu3Bn4lFgFkm+maaNtGAvQwXvYcS1ewHqYOrahMemias+oJBfR+nnueyDmBSgtTs
         cRkpdJGxFsLrNnC+A64zs0QT+5ZsnpwRYNgzDf+VrfsSqPsvAWhYPXkMRzIQcK7Xrwca
         RHTuI9giPGTJC42yXD7H/Ny+rFena5+5lWhXr1DY/eG88HQwf4Nbt9NrCy7O03/rpXL9
         SVftysLmU0C3yz4fBcH4cKHf50MdvjTQRMmW1X/YQkFQ2t5ltj8tEuxdc2npviTh7C4r
         8OIg==
X-Gm-Message-State: AOJu0Yx3uZAhHL1p76ls9hXlymQP2wrOXvIRUScYQM8qaXqclLzslwEg
	byrryXe2XpIcp9JCo/13fHIp8Gm8HHPmEECcJz5fQPfwVNAAOrwt
X-Google-Smtp-Source: AGHT+IHNr2h/8blidDKe6nUWzOdZhzdSWxNhMSkJDWY2u3jEMaBPIAO2blmRLKGvxbpg9FeldoKfaw==
X-Received: by 2002:a05:600c:511e:b0:40e:b93c:940f with SMTP id o30-20020a05600c511e00b0040eb93c940fmr1071810wms.28.1706866762070;
        Fri, 02 Feb 2024 01:39:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUUDg5EKFQ6lKeH9tifuLilUYhCj+nfQEiF++RwxrqZX1gmgZ3PdfwsfFlXLyW/qT66RfC1faoHZr5iti+ILaEnAdwZqkcBRuwcAQulhGelTDo8gDkcAiKNLLBzxtIvR7O0yvQmg8YMGQIBE7LHkYOMX/Kp5HgfZSlvm/8760AC2vo67DHZHfwL/wOIA/6cjyxnkirnXb9cQlQinMzIvS+S52+Z1j0oMGDyCpS4zHNni1qDziqtv1oicd5FoleHyTHoV39sG2E/waRq4k2PohF69lYzR0/wfNlSNg5L0FUFuKiRxeTahzx1QckDULcSRwxBBVdfftPZTlbEt3h++AwsaSqIzQPjYHsg/zKvQgaZjMkOt69K2BF/GhFxnt5Zl0KQVyIV/zgDMtHdrptrwzEfR2A8maw69+EKGxGiY42hTyYsuRZ4oL8tqXLLKXg/bAJ8WXNeswlezOJBvJ+0EqV1JAKWCtyBsK+IoiA6k+M=
Received: from prasmi.home ([2a00:23c8:2500:a01:a994:230a:9969:dbf7])
        by smtp.gmail.com with ESMTPSA id bg10-20020a05600c3c8a00b0040fbdf77ca3sm3827530wmb.42.2024.02.02.01.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 01:39:21 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/3] Renesas RZ/G2L family and RZ/G3S add missing IRQC interrupts
Date: Fri,  2 Feb 2024 09:39:04 +0000
Message-Id: <20240202093907.9465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

This patch series aims to add the missing bus-error and eccram error
interrupts for RZ/G2L family and RZ/G3S SoC.

Cheers,
Prabhakar

Lad Prabhakar (3):
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update
    interrupts
  arm64: dts: renesas: rz-g2l-family: Add missing interrupts from IRQC
    IP block
  arm64: dts: renesas: r9a08g045: Add missing interrupts of IRQC node

 .../renesas,rzg2l-irqc.yaml                   | 44 +++++++++++++++----
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   | 12 ++++-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    | 22 +++++++++-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    | 22 +++++++++-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  8 +++-
 5 files changed, 93 insertions(+), 15 deletions(-)

-- 
2.34.1


