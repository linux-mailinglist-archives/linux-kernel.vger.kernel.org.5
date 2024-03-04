Return-Path: <linux-kernel+bounces-90805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AC0870537
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2861F25D83
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EB5524B4;
	Mon,  4 Mar 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XIXpNosk"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9604AEFD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565419; cv=none; b=RUP7NwmfL3A6agdh9ToeL4k7N/FmonhmAvfl/x7wN770C+FYd4meitfevyPFHe5gSZlLvGKu/3aNc/IEFcegRUpMjg5GTtKvnOcYtmm+ZMy4nGwKY+XuuJK4GhcgTpUB0Gx0CqebBHpYR+JsEajUExFquE+3Zl0Z3Whe5NF9qmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565419; c=relaxed/simple;
	bh=CjFyzFbpm3pHQdLOEiOSHfMP0scTVcINbBhHBnj4ZFA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=QqvZIolS9tqg30TuWQxUScvlnOKEHxsz+xl1YQ8VJjA7FUwItJMYPwBpTh8JK75Qico0DAGDukLO04WsAPqvkHsF/B1REcyO8AckMV5RUOADg4RkfvZUX+sLPtjFvTURtbvSbmuNn4/ZtcAjPwgda4KnECUvHjAIxhLBAQpfZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XIXpNosk; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709565407; bh=nJidGdrVKa9+98drhoLdbDX2xCdE6XKT/ou4UGPQ/5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XIXpNoskD2SzVNX+Peds2tkeV0A5Lg3YB8rIMfmIGAKB5JH5CTW00nrC8+5CV2T54
	 0y2NR57NGy2C5BNuLdoXsYjkIW4Xc9Vwlc+7BUbTMUfVyVJxTD9Iv7R2DY+wghS+4B
	 fO2ED/m+13+Ftk08EsHKpl79G9AsST9gN3xrBcT4=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 42726AAD; Mon, 04 Mar 2024 23:16:39 +0800
X-QQ-mid: xmsmtpt1709565404tp2y8ecwp
Message-ID: <tencent_84166A6B39E6E062C4F8872436FAF1D10A0A@qq.com>
X-QQ-XMAILINFO: M01fr8RkAJIF4wUbDHP5mIGbxbh9iR1w5XGbdFmx5J74WeZ48s/OPys7QOl9TZ
	 xL6Lrk54S3w4AIOydTjq+lfT61tTdueWAUmYcOeIP0mXpXsr89m7vhje1INUkgv2vRgHkDi8/IXd
	 V+yA91cWwTaRhMuJJg+3LxI2AlyCTT6m5h4HTsfc+5RyM+tkWP5HKmKsxLWdeFSRmydNvwA9HUiE
	 n6BJar9CzGKQvuju0y9mwgKh4g9v32/VaY/Q8lqvLYHCtEirOTO5+Rb6tsfxssGJKGRtr9jkKvrS
	 Q/5DgU6t6RMhjpNycpOF93435WmT2tZmvQ63BksFQsBp84H7wWX+qi0PHveFQWRec8bP92B6kJyz
	 KXO4ffteq/4mKND7cdpYpbU7OEZLIH4KX/s6gbcp7ZdW8imx+4xqwfToeAn3uuUgMaVMxnIKg9M8
	 /8sHqkx25NYqBmLQo49m1957kqJZmuZhTu1R9Iwlfg1xU1HOtVZmH9dmGfQnVhL6kK7JippVFbNZ
	 Sl9T1kn+Gjo5/+jg1eg03pf72xjFvn51bNhdQtjDDmxri2sjfOdtbOv9ISF7Ij0U1OrlrqZbzR3e
	 Du6g9AnLhD+dLPtODPQBMcknPBQ3jPOZMBI8IcTNj62MiAExj7tvJxZ/3qbFAc1gsBLBmz34cyvd
	 5XZNbY/GheHqSdhyRzX3T2mhPZK3+ZglFORCaaULpKTC+PDI1jUjYJj0ntR4/7ZSb0oZvdMmM/Gv
	 12nD9wcCobiYtYfFScPvpEypSbT/4uPdXVPAWexoJjnC8PeKpwhKtrAhodSabyEXfIvUbep+LooH
	 U82isaF0Qi47jeNhcXhkoQqP7oY3hYiBGpemI2r6U5McEuFEndRabKi7cAhxP1sly0hTQbTriDCs
	 onDhjJki6xzhO4+NsSo581Oq0l26nlLvNrsHXpX/vi/GKF5gXtvD49KS8ace6cVN88BQ4lGbfdJG
	 Pj+lxaUuiDtAmV981zwfSI9shc9BPj9ryIhfwEUvZjJnNK8IKls24KtJSfoIJgPNKd8NDJdHTWZr
	 vRv5OkbLN01G8kSgvTDrCqrN9z4MLCdXW77S4wo29I4gIpQ/ti
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v2 3/7] dt-bindings: timer: Add Canaan K230 CLINT
Date: Mon,  4 Mar 2024 23:16:22 +0800
X-OQ-MSGID: <20240304151626.759150-3-cyy@cyyself.name>
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

Add compatible string for Canaan K230 CLINT.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index fced6f2d8ecb..9840a21c40ca 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -37,6 +37,7 @@ properties:
           - const: sifive,clint0        # SiFive CLINT v0 IP block
       - items:
           - enum:
+              - canaan,k230-clint
               - allwinner,sun20i-d1-clint
               - sophgo,cv1800b-clint
               - sophgo,cv1812h-clint
-- 
2.43.0


