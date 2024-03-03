Return-Path: <linux-kernel+bounces-89753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 778E886F51D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3155828421C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF2DFC09;
	Sun,  3 Mar 2024 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="bZVjHBzw"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0465BDDCD;
	Sun,  3 Mar 2024 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709472450; cv=none; b=WgMo2JK0lc3YPiSzu6fKvgvQxox/akKklxKvA1SkNpk2An6wRnkYa/Ix0YxUktXQbdyCns4zMvffmVPOkEmmUHyDzmnvKeBLNZuKMBXogQEfV5Feb63C0wSRO4Ls4iDljyepUmuZiXND2fkzKD/sq3CduWVPHkkT8TU8ZprdjYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709472450; c=relaxed/simple;
	bh=kOAHXIVkNpGVFPmgvWaDzJT7LEV1p/mFzFaumoZj+yo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=McONMhm2sbXmm/spH3jSzD9d67TM0p+RpaVI35qbnfnlE79+VGUQNDJESSMu/Gwo1EkSo3aP2VhCjAoGUjFhHdcmHqpoCYq+49kiZg1ChjPE5S8EG4X/F1iCfEFkP2aeQuRuGeSUVWICmXuRWcRHkUPiFfBkMgX5V9Ml1OEKQ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=bZVjHBzw; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709472436; bh=n2s+gXwdW2+QjJ47xTyefHF5QVT8S/PZfQcur2EDRe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bZVjHBzwFWvi1aAIK/H45S92QzrmGf2mfM/AjKqtoPKB2aTbwz4enpYAWw7AoRYZA
	 ysSfwQeC9qE4LhesPwAiFR/AIRVHQVa5i4q6AMToCKtpH1hk9ZdHBYzQ0MgNuCFw+N
	 /CcKYOsUPq2hqsZ7zGlZ8lFf3NvxCuNm93QX/xdo=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 6C4A707D; Sun, 03 Mar 2024 21:27:04 +0800
X-QQ-mid: xmsmtpt1709472433tjc79lwka
Message-ID: <tencent_AB8C6AC86B23355F8DE096369A2317AE5D06@qq.com>
X-QQ-XMAILINFO: OLnGMPzD2sDVlqXcDkXPfya9vVmqwpnozEkItOhSPtXL957hjtkeImGA1UZYiQ
	 jo2Uo435vxlL+75zCehrIzdy5SP/c32+zPuR4DTvciSO/xbVWSDw0NpLnkTyk2qRkZYm4PZzCz++
	 6j38P/IRN0bqbzlp8YiKEeeHnhKXVxkYF3+iJPMbL2vCAFqdekPQYpWNwu3T+dCV+JTU4oItwB8j
	 oUHvWPAIx1/6VwpQ4TzaZd6V4WacVTvHiOSV0KbkCC2UVKN5IyMCFDsTCt835YDVMPc/Wi/rDitm
	 7WyjsIhV7M08PuOxCZ17AcUyIPt3YrApfANVCTyd6BPyaP3/TuuJzhHIUkX5H9Yw1jFOtugl0e+6
	 A/JIcjRh6MUIJ9dsDCT2Xemevmk3QEZ/pNATezpo08JY/m3Yz5DZJrlqpP+xXK0Q+U7ydK7s0rCt
	 wkBYekbKY9rEa6Op/J4pb08FgkquGrwlWV2tmQrko3lnPJ46siVWKmqgmIcHAvYgHNHw+jXGteQb
	 hZRKEFm+x4Ztl0VUeqalpPesEdiweL5Ykdda2CYSsD3JlDWK2MvZsgZ1ZUgIP9UFFyBV1BoZQFkG
	 b/enTlqOSckY225yrzVzuI+BsdiO9vpqhHvGfu36FNnKyHQ6MYLQvAhn1OoST2Ra6pnRVQlAZiJh
	 A8TgZuEYldYl109DEXb9eKyqhKRj3PI4UrKuFR5emviKSAa3XEnpenYBA9Sw0jnWnYBmgzHrzmtR
	 PyUAV9YMqpTeg+9Wj+JHaMdCtFEB5+UnAzmA6Bk7jxFK/HMYmTaUdykYuAN8/lB6qqP5AdZkzhv2
	 JJ1y0o2qGwFOrPtC0AuRPth3ckdtIJNn0aK5g9pAu5fCLFp8E0BZDsbd13xgQEmaY0+VIqF7Huzo
	 ku+0HVuca18QrpTp4PsS5cIHTr4cr3GPatGEHwv49KYXQqRG0gpfHevig7yv78WQN6k8kRBGVyzE
	 RGOk28OXJByphC4BZz+35QLiQwCxfPx6n6PJ+VTlW143LxxFZZyNqb2jZ6RLPZ55PXWqnLr0qmzk
	 rUA/uKhFxqJZRe00XnblCOKfgeDWdJFAiv0wk1M/iybnlCIPpV
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH 5/5] riscv: config: enable SOC_CANAAN in defconfig
Date: Sun,  3 Mar 2024 21:26:27 +0800
X-OQ-MSGID: <20240303132627.553698-5-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com>
References: <tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since K230 has been supported, allow SOC_CANAAN to be selected to build dt
and drivers for it in defconfig.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 89a009a580fe..20b557ec28df 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -33,6 +33,7 @@ CONFIG_SOC_STARFIVE=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_THEAD=y
 CONFIG_SOC_VIRT=y
+CONFIG_SOC_CANAAN=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_PM=y
-- 
2.43.0


