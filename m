Return-Path: <linux-kernel+bounces-20647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9518282E9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D61286224
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2521036AE3;
	Tue,  9 Jan 2024 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKj4zOgC"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414E8364D4;
	Tue,  9 Jan 2024 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bbb4806f67so2537329b6e.3;
        Tue, 09 Jan 2024 01:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704791879; x=1705396679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H81WNcgEuRcj9vRkVpM+pIQnKvMNYSKJ0QdzyPMV5tY=;
        b=ZKj4zOgCH8+uLzg+PDBJGhVMtUfEadSN2V0z+eRezQaaTJCA03N+eZ70JgzY5y3Gtt
         FCvbPsub05fUOwFLp9HyzKakvZoXfd/Gg/Dw417abGo6njTxCE9r/VfE1CUJL8y784u4
         qezh4n218VQT5j+CBRANKPYPf49O73CdiB9urjRqAhkMhkXTgRfvDugdbeAkWoARI+Ur
         D8HJgQqmVzr/+TQrmviozSJuOy+YykRHr+RDp0nIaZkzuo3z149Nulnfgs/LYh5oeELR
         +m3azzW/BentufQA79Ek1BQ833MHoiw4jpix6kG8PCYiPj7e229+MOxv3EYB1OrOCdpS
         zBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704791879; x=1705396679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H81WNcgEuRcj9vRkVpM+pIQnKvMNYSKJ0QdzyPMV5tY=;
        b=JxNeSmxecd+fvQiimQyCdCC6R99yao5f1PKgpJw/KP21eoHT00RDnByMv6ldS8o0PZ
         egllz0StrqdBwIidkSMsMU3rVpxmYHMMMxD0scKgVwT9gbQhQNvM60xJpovPIrlcHJZK
         vIyuw7OUo2j43XJ3UH5MPia8LX6qNv+6KGEtBwRh7wYp0pXPaVWhIOFlExQSSFH3qce/
         j3PquDM4FWW/phP4QZjUdyvpmP957g3Ccf9GgfNmTQcf6e5S9taq3himfs4pIGp/y7T4
         PbPG/kKqCUPROVnpo7L+AeYpnNsTvipqoXftzGHI6yUIxnsJfKKyZDMr5+yl49sRKPXq
         V1wQ==
X-Gm-Message-State: AOJu0YwFJZ12QtYnNMNYI4fFcsWwsEekfDSZgScDPGqDSZexlJeGN5UT
	Isze1oW22vrh7ZFwCZRwzfc=
X-Google-Smtp-Source: AGHT+IF9asNbyA9kkyAZ3O4yJzTefiBP0hcPNyNfOXkQmcM6Og0+Eno5oA4eW2Y9x802ozv6mjy78g==
X-Received: by 2002:a05:6808:309c:b0:3bd:3fa9:426c with SMTP id bl28-20020a056808309c00b003bd3fa9426cmr235310oib.52.1704791879121;
        Tue, 09 Jan 2024 01:17:59 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id o14-20020a05680803ce00b003bbe0c5195csm276580oie.26.2024.01.09.01.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 01:17:58 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH 4/4] riscv: dts: add resets property for uart node
Date: Tue,  9 Jan 2024 17:17:51 +0800
Message-Id: <18e1093a7f1357af7d9e9df12ede2e99725632e3.1704790558.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1704790558.git.unicorn_wang@outlook.com>
References: <cover.1704790558.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add resets property for uart0 for completeness, although it is
deasserted by default.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index f59081d4f0ee..03266f216021 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -327,6 +327,7 @@ uart0: serial@7040000000 {
 			clock-frequency = <500000000>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			resets = <&rstgen RST_UART0>;
 			status = "disabled";
 		};
 	};
-- 
2.25.1


