Return-Path: <linux-kernel+bounces-117816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F9D88AFE5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773C51F6198D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6731B815;
	Mon, 25 Mar 2024 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="GtOje9iq"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35AE11737;
	Mon, 25 Mar 2024 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394742; cv=none; b=BJCp4mYLdw+4kIb3IhiDx6NPRxBsr4+YEqr859Rk7+DV4/dyGm3wd1L4qi0qUi9Q+KrJbLrFGuNkbFYFnQIg7mcoGgRKUdmJkF7J6MH+UwmEpQ3Gt0TSzS1uaVaJBU+BHzP8ddOcnGtj2s/q76QoXuU+imuMvWjKwxVdYYJqkug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394742; c=relaxed/simple;
	bh=7Ao6hgbs6zd2+/k8hcg0ppXPOOuhRm5VnYgK60E+nqM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XDBhS7LmKuMK/9nwPQCHbFvZJSezbzD/DehbA5ctLXOYUunS8OpxSZljyP9aXh1z6dk6+Xi6m/z7QyCgrao0xHZgTfy1ED97doIi17YrbvIlDMOUIKk8ZVaZ5ZdNIfSINyc6P2fGTvKSwqYnUacrDLXoEAfyq6etA6ZrUFnN0DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=GtOje9iq; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1ropws-003Nrb-15;
	Mon, 25 Mar 2024 20:25:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZVuJ4s1A7uTLKsPm+L4vMdsUPg3nGtnNHl8Jqf+5Lj8=; b=GtOje9iqO2ApKj+rAd2M/JDC7O
	MIyAYovojFHqPorH4aJ8XZxUcYOnWbT/u08V4PgB36OId5AHiD7by0YALEroaDDEEBPlYmkCvOC99
	9wMtGcUm5o6nvPgeACx66hKeKaIdXElvg0vZnSllYZ2hvGbriSAXgfB7g5sZe0aECP9VoUNIRjyB2
	yPmuoPbtTw6GiP63l0WxJj5LNKHYHoXaeBxRAjPN3GOrcmHEVbDLL+HqtGVXQxhF2c9wvxgKgfkKJ
	ny12l0M0/tMjuOOQKkeFt0ZDd0G0NWqOfd9Ks92lclFj8S/0+emanRZtL0lmxjmJb340mlfM91LMg
	5sek/Ltw==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1ropwq-0000d5-2S;
	Mon, 25 Mar 2024 20:25:33 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1ropwq-0014oy-11;
	Mon, 25 Mar 2024 20:25:32 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andreas@kemnade.info,
	o.rempel@pengutronix.de,
	dario.binacchi@amarulasolutions.com,
	u.kleine-koenig@pengutronix.de,
	hdegoede@redhat.com,
	p.puschmann@pironex.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	caleb.connolly@linaro.org
Subject: [PATCH 1/2] dt-bindings: input: touchscreen: edt-ft5x06: Add ft5426
Date: Mon, 25 Mar 2024 20:25:31 +0100
Message-Id: <20240325192531.256854-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324184415.206587-1-andreas@kemnade.info>
References: <20240324184415.206587-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible for ft5426.
Searches for documentation reveal neither edt nor evervision
as some related company, only FocalTech.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
index f2808cb4d99df..17b05522eacd9 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
@@ -40,6 +40,7 @@ properties:
       - edt,edt-ft5506
       - evervision,ev-ft5726
       - focaltech,ft6236
+      - focaltech,ft5426
 
   reg:
     maxItems: 1
-- 
2.39.2


