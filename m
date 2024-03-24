Return-Path: <linux-kernel+bounces-113288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E9D888321
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1227F2854C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABBD18E0F0;
	Sun, 24 Mar 2024 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkG1QYwp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEB818E0D2;
	Sun, 24 Mar 2024 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320089; cv=none; b=gN6NeN1SDJ1rhCiRi7ZgAZFUtFwGtbucwjhYHRQ6RkS4Pb7gy6W5wRGn3fJjzprRM2s0iTN82glItwl2j11avgi9Fo9B0ADDpU61vvZwxZKXqG94lzHTY+FK6woKQuBByaJqrDSjuRwaNbi9m74zO5zm9uPHsVOud4KGBfMIcBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320089; c=relaxed/simple;
	bh=tfC0CJv+EuNve4rNiL1lZoeJA6p65O56r/r2E6wkOnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJRB8BkCzV9blhgM9C9abwidt3PFxbeGaxZkvOC86Xi0kpIc7sGenuoLCwL3oNdhlP7U2iXWGrUopD6eEket2OCk8FIz0LTnmoQNV8zQheW3LBcgkBkXyR/qP0Fka+hVnihnx3V+qRYjq6gCnPpI+2LJaTuRoH7m4B4TL/rq1nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkG1QYwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AFFC433F1;
	Sun, 24 Mar 2024 22:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320088;
	bh=tfC0CJv+EuNve4rNiL1lZoeJA6p65O56r/r2E6wkOnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PkG1QYwpYi+joAJ+FwvM9rRqrUpNzLrUCENP7svZMnpFbujCpjIGAwoSamTCwetR8
	 u3NfZVwLqmlb1bv+G/n+TLwpCnZrd2u1oC668na40tLghQliisr6YDi6US4ujMTVUG
	 XfadJOmjR1Em3uUHxyAY0FQxUL8X3MlGMufGajiF6wz2V36UVNrsCZ4tqME96dp1K4
	 L/wrcmHhR7fuaHdw0RnPIfNCvcyYDACiXttpTTrvDi5lyt2lV9hcWmKgbUvzi498at
	 BcyKHzB3CMcZ0KjdUC7n+pN/cpeTb3+l2rZYZVYvATT844lNq+Q8bDCPctvMg89p4O
	 u9dfYADAWojuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 397/715] media: dt-bindings: techwell,tw9900: Fix port schema ref
Date: Sun, 24 Mar 2024 18:29:36 -0400
Message-ID: <20240324223455.1342824-398-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Rob Herring <robh@kernel.org>

[ Upstream commit c9cd7308d64b13741ee03be81836a324fc4d657d ]

The port@0 node doesn't define any extra properties in the port or endpoint
nodes, so the $ref should be to "/properties/port" instead as it restricts
extra properties.

Fixes: 0f82ffa9a295 ("media: dt-bindings: media: i2c: Add bindings for TW9900")
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/media/i2c/techwell,tw9900.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml b/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
index e37317f810722..c9673391afdbd 100644
--- a/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
@@ -36,7 +36,7 @@ properties:
 
     properties:
       port@0:
-        $ref: /schemas/graph.yaml#/$defs/port-base
+        $ref: /schemas/graph.yaml#/properties/port
         description: Analog input port
 
         properties:
-- 
2.43.0


