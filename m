Return-Path: <linux-kernel+bounces-77274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A252E860303
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4374A1F270BA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336A373F1B;
	Thu, 22 Feb 2024 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eupYjtqa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3199954910;
	Thu, 22 Feb 2024 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630837; cv=none; b=IJQNxGhtPWbEj/nm8CCrdGJHk+/cBqv30tnXKog3JKoQOzgzxOp6/3fEvFPHAsk31IZgfnrIPfr4gVecg7aa4Qd+f/XT/Eskwl5Bbfc4yJc5s1DifxBGfAoTsygJcM7In1+Nce6Zy6ixj6qSzPD9nQ+X5wR/UgikKPT7elsDon8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630837; c=relaxed/simple;
	bh=uvgjDgyr2mOgCCPMtw6TqBlBBsSGCf6QAlqQ67J+xZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UpradkDJPbPaGzZgzwo+RytQpVgNIhFqKGb5d1fK3AUK6g/2+kK6Ekct6UMGIoC9AmFbgXFfyx+TuZ8Fu1h4p7w3lE4zBBS1efb00Iei+R+C5qRCiOpO3PYgYHbF0gli8UQGs9BsiUMQy36PalRqNb88JxGId8vW9107pLYUicc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eupYjtqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDB8AC4166B;
	Thu, 22 Feb 2024 19:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708630836;
	bh=uvgjDgyr2mOgCCPMtw6TqBlBBsSGCf6QAlqQ67J+xZ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eupYjtqa3Zyf7mZhH06Mkuy5oJCuPdnRwtvg7lDsBVDbpvSdL8Ab+Rp8HDdOTJJc0
	 bD4iskMqxEzngGqALc2+4HHfSPJWLZdMe7Lg6ZuSWPhgUt4F+Qkb/7I0pdILaGQHag
	 E5QEA6WwhKYnWIp/zeBR4Ke6AuNniGnXR2xSXu/S6zY6IUM4LRWBJNnfNrqbrbHEf3
	 VO5JSb1nDKDuOATn9HzeLYw0J60C2NctomnAWppoYmvtb+688PxfkM6yzm4uF11Gwk
	 sJx69akeW7Hl950jwyyV7zOFUJBfFfwFpvzjdpaXejpRnHBEJ6VhIvMOd9B7xaqGli
	 lglj7vOdzEYLw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5783C54E4C;
	Thu, 22 Feb 2024 19:40:36 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 23 Feb 2024 03:40:15 +0800
Subject: [PATCH v4 5/7] dt-bindings: clock:
 hisilicon,clock-reset-controller: add Hi3798MV200 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-clk-mv200-v4-5-3e37e501d407@outlook.com>
References: <20240223-clk-mv200-v4-0-3e37e501d407@outlook.com>
In-Reply-To: <20240223-clk-mv200-v4-0-3e37e501d407@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708630834; l=875;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=gv2xXV2PHkOmWiSsfnHxLP0K9i/ux85MGELzPj9FllI=;
 b=+jf7ao5QN80YG7oizQRY6/67M5d7pTHi916Qvz3LG2uMbbsCM9BOs5gy33kanq12qiKnHQFry
 uCvI6sBVzF7BwNXweipxYeUp7rSAXXCiSU4tXN5htron68OH2B5xyxi
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

This SoC is similar to Hi3798CV200.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml b/Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml
index 251156905a7b..a4af12aa3f08 100644
--- a/Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml
+++ b/Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml
@@ -23,6 +23,8 @@ properties:
               - hisilicon,hi3798cv200-sysctrl
               - hisilicon,hi3516cv300-crg
               - hisilicon,hi3516cv300-sysctrl
+              - hisilicon,hi3798mv200-crg
+              - hisilicon,hi3798mv200-sysctrl
           - const: syscon
           - const: simple-mfd
 

-- 
2.43.0


