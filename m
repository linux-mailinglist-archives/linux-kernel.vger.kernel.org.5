Return-Path: <linux-kernel+bounces-118012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1D488B259
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990891F652D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C566CDA7;
	Mon, 25 Mar 2024 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWHERGah"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF05BACF;
	Mon, 25 Mar 2024 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401015; cv=none; b=PQ/IOijfdanNZ/bWL4VFhL7QEwKbx+Y5JOCey7mUJHOWuqUsuOkiEX0QpCAQu0oX2pGy2KInMDGKoRtcnX3t8FXKwyPR78j9Sdx4dZQWZLutXoC+L7OgvYfWqckWRHBk0Z906SeSCHGE82jLk//xx8idZTVwy91xvwHpAEaxXGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401015; c=relaxed/simple;
	bh=/f0dIsYOIRygaHco+WcWhZhJ3bqBRJRwcRAfUOCK4II=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FkWwcQBR65cfVVM0aCHsAkyX7J24oOrVZ5SSFz9Xab2qTORgtVaNq4gN/3+r+7WWsyQYpQNJI/Zq4cmEawq3szEE2kKvQEX/CsiKo9rQnTxdEiJhjojkNBI13yM1bAgkieqXz5Rj9c7fBwLB6KI1et1+eoNRl/So8/+fUaB3Cso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWHERGah; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4148ca200a7so2537495e9.0;
        Mon, 25 Mar 2024 14:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711401012; x=1712005812; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lHa+Fg4zMxP1YPvjmvv6HY8P99iXL0G+bBAReTO6ezs=;
        b=hWHERGahnbFIFas0yP7SZs+QG2sAtuX+g07TbKH6HxM+xewLH3UzrzUbkezYGErWO0
         QKU9JnPkuSIEYi4SBUAr0fVS3lqg5lGgovlZdAsyRVGgog4ZFuRks7F3W+6rGlcrgPfZ
         JZTsR2kuRmZG9ndlweNXZMR0DZAjV3n1RtNBQooDg6pNRAR5jyINLxrIrhWIzPTO7YKo
         qYhD7WreU7j9ViTu9vQjJl+C6y51aMdGGRZrRsIG+h/GEFrodkcrDweI62z2zMo+Vgig
         kfxQT6JSPnM7J/Yg+WBVcDUjdgnCX1wratO0Oe3fCZFu8OuoTpN4rs7TigbBMADrdfLC
         QwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711401012; x=1712005812;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHa+Fg4zMxP1YPvjmvv6HY8P99iXL0G+bBAReTO6ezs=;
        b=rM9dD7a840YifinzjJzsAlGJzv6ivXC7DggLcB78RVqcUHdC/KP8Sha4YcR80lpv8D
         DBv+hOhQK+8EBUkdn54DJqzXDP5spCGRbREzP5wAwnv/qi8+3+ACxUN0eCYBnadrPQn/
         tO9DSqsdEM+sz+xU9qKzqmuuE4xBxBBJwwhhSF09KCNHl9maVVt3WHCo45NdarlAnqPI
         bmj2UGZiJto9aFIPzuwkNlOoyVbmqODptoS/A3JL68nV3U1WN7tqUWihjv+sCngM3p1W
         FoV8EO+2Nbm4eLdhAJ7Yy/Aukn6Myy6DI1TBVGumXNYMYDWrLBw9y2tl9YEsBbD3J4ZV
         9ZJA==
X-Forwarded-Encrypted: i=1; AJvYcCWgnKHEi0f6aljxo2Fcs7o5nWUqad0hb0cnqsGAdR2zIOmdUNuofeFGWmM7ZSWWpey4EhFEOAzw1sodXaeca4P4bDkCTnrfOEsih4He1/UQFfQGF3Yhsz3NgaCZsoQBWuh5bXvurHb34A==
X-Gm-Message-State: AOJu0YxGj48lq3Avfq8rZJzwer8JCOUxiRSEpGOWPDToDqzuzOrXoWva
	C4x6DeZfUSG8yd/SxMcUihCG+aoHZDzioQJZ8AQYRk/1QeNfsV35
X-Google-Smtp-Source: AGHT+IHwUG7lgiTgUhsX/xhrE1HHTwnNVcfKrWgfERSPAClH1BUhRRnO4HZLVlOl0/D04HoX4cjcAw==
X-Received: by 2002:a05:600c:3509:b0:414:28d2:912 with SMTP id h9-20020a05600c350900b0041428d20912mr5460831wmq.28.1711401011598;
        Mon, 25 Mar 2024 14:10:11 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-36af-6d49-8348-9a76.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:36af:6d49:8348:9a76])
        by smtp.gmail.com with ESMTPSA id n39-20020a05600c502700b004148c3685ffsm1520768wmr.3.2024.03.25.14.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 14:10:11 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/4] dt-bindings: rtc: convert multiple devices to
 dtschema
Date: Mon, 25 Mar 2024 22:10:07 +0100
Message-Id: <20240325-rtc-yaml-v2-0-ff9f68f43dbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC/oAWYC/0XM0QqDIBTG8VeJcz2HHoutXe09RhdqVgcyQ0MW4
 bvPBWOX/4+P3wHRBrIRHtUBwSaK5JcSeKnATGoZLaO+NCDHmktEFjbDduVmVt+klI3RQysElPs
 a7EDvk3p1pSeKmw/7KSfxXX+I/CNJMM64aXqBWuh72z9Hp2i+Gu+gyzl/AIfbDeqgAAAA
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711401010; l=1935;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=/f0dIsYOIRygaHco+WcWhZhJ3bqBRJRwcRAfUOCK4II=;
 b=cDjz8ri6PBDinOTDCbRQo44LTn7RFqHKHWWLBPfIsaJYomfEEp1xnA1Z9t62UWucOtGveZjMT
 fSDdkCqeradADagHkMAMzPkyWs5EjZieCmEqsGJnXW+RnZiVey2219a
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series converts the following existing bindings to dtschema:

- armada-380-rtc
- alphascale,asm9260
- digicolor-rtc (moved to trivial-rtc)
- nxp,lpc1788-rtc

All bindings include at least one compatible that is referenced in the
existing dts (arch/arm). Those dts could be tested against the new
bindings.

It might be worth mentioning that the reference to nxp,lpc1788-rtc in
arch/arm/boot/dts/nxp/lpc/lpc18xx.dtsi also includes another compatible
called nxp,lpc1850-rtc, which is not documented or supported by existing
drivers. That generates a warning when testing against nxp,lpc1788-rtc.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- General: reference to rtc.yaml
- digicolor-rtc: move to trivial-rtc
- Link to v1: https://lore.kernel.org/r/20240323-rtc-yaml-v1-0-0c5d12b1b89d@gmail.com

---
Javier Carrasco (4):
      dt-bindings: rtc: armada-380-rtc: convert to dtschema
      dt-bindings: rtc: alphascale,asm9260-rtc: convert to dtschema
      dt-bindings: rtc: digicolor-rtc: move to trivial-rtc
      dt-bindings: rtc: nxp,lpc1788-rtc: convert to dtschema

 .../bindings/rtc/alphascale,asm9260-rtc.txt        | 19 -------
 .../bindings/rtc/alphascale,asm9260-rtc.yaml       | 52 +++++++++++++++++++
 .../devicetree/bindings/rtc/armada-380-rtc.txt     | 24 ---------
 .../devicetree/bindings/rtc/digicolor-rtc.txt      | 17 ------
 .../bindings/rtc/marvell,armada-380-rtc.yaml       | 51 ++++++++++++++++++
 .../devicetree/bindings/rtc/nxp,lpc1788-rtc.txt    | 21 --------
 .../devicetree/bindings/rtc/nxp,lpc1788-rtc.yaml   | 60 ++++++++++++++++++++++
 .../devicetree/bindings/rtc/trivial-rtc.yaml       |  2 +
 8 files changed, 165 insertions(+), 81 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240322-rtc-yaml-473335cbf911

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


