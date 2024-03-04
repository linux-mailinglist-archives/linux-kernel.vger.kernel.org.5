Return-Path: <linux-kernel+bounces-90800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7BD87052F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64CAB1C23612
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A2D3FB02;
	Mon,  4 Mar 2024 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KFqjWutX"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2CE4778C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565410; cv=none; b=O2gHdiWL46VQf3zlswi6JPKcttqp7Dqk7BwTRL/RmkFMd9KcBHOSQExqEDl8Id75WuVe2SAMfHAbLehfpSiiiaLeoo1RoNt+vkksLH4PNwoPyeKwtXvDxyJC8DZC12BkXII2TYh8H4I+DoWzusngHbHjQlwFkPoX3RPHPXjMPno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565410; c=relaxed/simple;
	bh=iIg1m/HJGO+YBecXFqvZUlmsxmUTnWYkXWH5ivM16oA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=sJDRduC54tXiSHgTBaUog6aexkqdm8uBMN/z4MGynOmAzz/kOmDWu6GaBElmy6DghTike+U0D/va8AjHffiuiW81lhgFM4lW6IsFp/jcMGlWre/pdiSkuO0TLF3/JxvQnRmLsaltfSd1T4WZ8ofXDU5IgFVZ6VixHmQqRW0PZO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KFqjWutX; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709565403; bh=s7QEg+O5WzM5yI1q1lQPoUf0e90dpB5qxk5MpOdViLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KFqjWutXOWrgnx+YBQrMGfQZm37zOqEe59oGBjA+c+aIgHZnZjosnKK5+XCh/cfQA
	 BqHw1cYOfjIQv2SIfijRPNR0r8Cbtmd+M53YzE/P+mmRAVaSFc9PG+9GlQgXQnfqaj
	 dwqA3HbLp4/7G+Awn5vzQySpSQGiUqk1rCKxbFwE=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 42726AAD; Mon, 04 Mar 2024 23:16:39 +0800
X-QQ-mid: xmsmtpt1709565399tgkhp07d9
Message-ID: <tencent_4EBC1BA5F988047DB4691C1D714D636E4209@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NoN+Knf0Ay9A6Og7gvJ/GmKJTIgfR9/r0iceG/xbDQNEolu02CbB
	 U0eMZGsivnZkYrCZjgoBJRq4r0rcMCyXIN2gO2XkFhn2z0KstNf2ncy7tJdCw3YkWIZgfLIITsi6
	 cfju+qoziZMpTegHNUDPKRKx9gf9ip1bllwbakjF1teNWm6ugXBf+kiE5Ed9WZuceVRzA/o8Licn
	 SfCVH93e113sJFrxNRgM+6/V2eIK6tX6zG7suGHITZxM8W7sGmhwcdqlCn4weAlO8hm1S9d3lFEW
	 F+0XCWdS1Q3lf92IsUXyjHeZYhNZGkWbTtmuXYGozjaOfcsmG4aHvtMK2VNzy3jzT6t1uZANK3Fj
	 F3zaASNUkWYEFgbrvgMFAW0R8z+PFQgLYgfYS0KecLkZNLGIsuA1RROrG2FmyXoMlb+t+a3xgoGy
	 l29d3gCXnBYAzX002s9r2f28H2qPRTpaoi9giVj8OrH+sIP+YxA21AHM4+CHW3iSJWKP0vHg4g2a
	 BrPvbi8NDnL6Mv0THAouYmcW0m/lImjo4h8z7sDl5zBz+kuNwGrpjBxEtvDOGT5EzNxkW5CFCEJJ
	 XjkNi8grjGOYDi4xzpZ/P8QI6Mq8pQvJ7FzcNb7NidEioZ+MYJemFWGWg+RyxYCDita2WffFJLzQ
	 9OITInRwrA6sxYX/+wXvyUy8aCjZrpS0om1t7jydCwJSv/IP5r+wBJYBZvB5XQm2mohs+1UBJXgR
	 guPZeC2eyG0mLgfxQKuiQ4mrKFdXxYDSGO93t8KsQjaT6CPm47Nyo02SqDmuVz64MCRwkh4FtDj7
	 QzFxXyzZp+yw1FeYtbV5EWe2PGUDT8HO/DERYHeYRhWvLF0gQcSqwGtP+MFKOpjSFh5b9NG6vOLE
	 yeF6WQqL3c+i0E6+wKs8B3lAFdFANTZoCKC//8whQrjkpr1NZ9bO2PYBWYxJZmwy0yH7ZYo2in9L
	 0ymoZg9wEY2sfGO9KDkQCohYIF/QnbavfoTvL/gho8binJsskS8qaX9yga2IcEbjFYct55XEShIj
	 ELbwR0LR8suArhY0wBEPe56P1xqtUR6BbcedFC5jbENLVlV4lj
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/7] dt-bindings: riscv: Add T-HEAD C908 compatible
Date: Mon,  4 Mar 2024 23:16:20 +0800
X-OQ-MSGID: <20240304151626.759150-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_64A9B4B31C2D70D5633042461AC9F80C0509@qq.com>
References: <tencent_64A9B4B31C2D70D5633042461AC9F80C0509@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The thead,c908 is a RISC-V CPU core from T-HEAD Semiconductor which used
in Canaan Kendryte K230 SoC.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 9d8670c00e3b..e853a7fcee8a 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -47,6 +47,7 @@ properties:
               - sifive,u74
               - sifive,u74-mc
               - thead,c906
+              - thead,c908
               - thead,c910
               - thead,c920
           - const: riscv
-- 
2.43.0


