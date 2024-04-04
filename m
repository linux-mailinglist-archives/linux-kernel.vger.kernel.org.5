Return-Path: <linux-kernel+bounces-132063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA42898F43
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FDD28B394
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666C31350D2;
	Thu,  4 Apr 2024 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="cyqplY5a"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36CA134407;
	Thu,  4 Apr 2024 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712260471; cv=none; b=jSVvICOiGZWs/AxlkeZp+DCbMkxhmdHKMYiGYqg813b2AIgHqkeuHqESac256HUVSsvJ8ZZg+ugCaYDkKmktT3kaH7RW0j5UPeP/fFZSHZSRL/nAwyoTDJB69Ae+jT5MUc/fcY6+USNqM+OPz4ZYRPDhC4GghOmxZyY4IEZxw0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712260471; c=relaxed/simple;
	bh=OlO4PIHmPsTE541L+9NMSjmEYGQ++NNCUzMajiAgdwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hvcut+ksYu55cOWmbcUvxNMlcJ98HxCB+OKJ6MhlpwkYmHEQ8bKJNJsj7d+RimdDCZ2nWvnyQ2+GSKHo+0j8jVwS3XGNFRkV9yHripxXlPK4v3vo7ENZdML27uzDkDKkC6HMmOxdEhHPKaBol1kS0cxA18TU5B9h6XUHRMlSENE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=cyqplY5a; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsTAJ-003qni-15;
	Thu, 04 Apr 2024 21:54:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NbSFYz9D1FIQYOfc0iSgyKRs2fNkJ3RrkETpJyXlmSo=; b=cyqplY5aELZK2UQcF6s2d4MxUl
	VXYQVK/m8ZJ2lk8sB3MBRuLqY25WYAAuaCapoJz6iQQjh5EfCLWje17wrkGonpJeosd8zsQkom/0U
	V46oL4L8aWpK+hvRKe5N4I1dbzyWtG2/vb3fB4UzQtDqpbB8Au+jZ2ATOezUOjrQIMVICiEbbrH4E
	xqsQCTPY9CeO57AhYMWHIaJDtIY4js2+W7Y9+kaJOtM4W9TkCqMYdYclCQoD+yFRkRlUxQndvuo7D
	nc24omdSL3BmjPwjpE0/C6SuMzlPskpyeetQ8bpQz+C1xPnJny06SPv9z6k9BjxZ1RjukrZhzG3WH
	KKiRQLKw==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsTAH-000Ngj-2q;
	Thu, 04 Apr 2024 21:54:26 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsTAH-002nNT-2g;
	Thu, 04 Apr 2024 21:54:25 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mazziesaccount@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 1/2] dt-bindings: mfd: Add ROHM BD71879
Date: Thu,  4 Apr 2024 21:54:22 +0200
Message-Id: <20240404195423.666446-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404195423.666446-1-andreas@kemnade.info>
References: <20240404195423.666446-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As this chip was seen in several devices in the wild, add it.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml         | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
index 0b62f854bf6b..07f99738fcf6 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
@@ -17,7 +17,12 @@ description: |
 
 properties:
   compatible:
-    const: rohm,bd71828
+    oneOf:
+      - const: rohm,bd71828
+
+      - items:
+          - const: rohm,bd71879
+          - const: rohm,bd71828
 
   reg:
     description:
-- 
2.39.2


