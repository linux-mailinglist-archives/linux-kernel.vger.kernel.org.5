Return-Path: <linux-kernel+bounces-159067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1048B28E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99220284888
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9749A152515;
	Thu, 25 Apr 2024 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="GwFer7Rr"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C202135A;
	Thu, 25 Apr 2024 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072504; cv=none; b=bY4qA8ktwou7iq03zYZ58ziE/1wYjgSz4BWAdlHNfoaCfMoaPkyyq8cV2T5CF6QouEI+pGGhUGcQtw9ySpaDrsIOPfPjLSTYDMZaeqZ8dKpHrnpgx6R85Ye98v11MDaDSE3XKRGXRg9Fs36SZNX5NvsBILsnQOy7nrd0/QH4fes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072504; c=relaxed/simple;
	bh=QvJQW5/tPo0PBeZh3lFDVxmj9QN7Tn9WNxdlpoVVeNY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TunpT3ntry9uzveQ+nclyBkjIo5yb+q5vjTxVJ+h2mE+QSV3hwYfHJZBtbfGoZ32kutTTy2tIryMQXyniIaXYgFsqZNDaH+psjg8XkU4gZG+OPD+cWZMlyHlpABOy8siuQppJxiPqwRfOZcNaXUVSlB4YhnkftQtUWIPSmpjnQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=GwFer7Rr; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1714072501; bh=QvJQW5/tPo0PBeZh3lFDVxmj9QN7Tn9WNxdlpoVVeNY=;
	h=From:Subject:Date:To:Cc;
	b=GwFer7RrH2IJE270lw3hm7pfGbT4mYC1lv8Z6Y/bAeIj3aE6z1KDckCMY9jpSkAB4
	 zF/+bqHi2R0655+ZPwDvtVzGelgcjbjMjUsiogWXpwleOHhDOLsQxueagp69IQBuHb
	 N9DXOUlq890EiyDYcDeovCsuJTM9OgIr8EaROius=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/2] Mark qcom,ipc as deprecated in two schemas
Date: Thu, 25 Apr 2024 21:14:29 +0200
Message-Id: <20240425-qcom-ipc-deprecate-v1-0-a8d8034253ea@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJWrKmYC/x2MQQqAIBAAvxJ7bsG0CPpKdLB1qz2kphFB9Pek4
 wzMPJA5CWcYqgcSX5Il+AJNXQFt1q+M4gqDVrpVre7woLCjRELHMTHZk9H0dpnZGLKOoITFL3L
 /03F63w+/XJkZZAAAAA==
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=QvJQW5/tPo0PBeZh3lFDVxmj9QN7Tn9WNxdlpoVVeNY=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmKqugrhDSHoYG60xXLK1PX+EXWogXQO/qABGhn
 OJQRloOgpmJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZiqroAAKCRBy2EO4nU3X
 VhazEADSzmJbKb1diAv9PI8AKWDeJtScDVudXGSs8YSkjoFRx6c+gZ4JtSYcktnXEVB2mPGS1e9
 Z8pOgceZZf6k+oEvDFObS9y8Vtu+UUG23rmf19VSFy6GoT3PmYMUznceGQBjs4jJdhzDmS3VhFd
 3r5e7jLGBDderm7mbMxJXlWyxJ9Z7a/48c3WnBw7jSmpI8lxoFXNxBzwvyh4sWN0anKKr+66efe
 SQcx8WQhq9QTwPOsxSOKdQ4uY/fkYoKUpP4ru9pdo4yxawFOLbBm/7Vz+VXOnRszY5P/mUpFEEv
 2TeBfgZSa0xQu8lCX1LkgijPFhCO1pHvSs1k4+CCW3A5FSOEuBTWLgqzJOorW4er3Mr4hOkEFrc
 7dLryo8M8D/hch//VeDO5E3LNajZBqkAX95HtQw3MlJvxvMTv54vNn4SFX9qHdNJ+amxe2d7LCa
 0AxRuhVdf5m4UW5/30RbqJYzlMYetWt0roVgj0uOFmWsS5hHVbSGWiDKyLP/Ry/cXWnA/n3uSO1
 ZojTFgz+l/D3IzyF414qU2j3GtpALrB2FSVZjtEIFWc3RQCNadWz2Syzx+vasiH/p7idjaMcEDY
 e02ZUo1yNELQq5O04zlAaDiOXF+vJYJAuNnbStfuhR/lCYNzaKiVwGZ+S6rnNf6ycQhUpWvHhDp
 fucrWnFpcy0NNqQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

The mboxes property has been supported in those bindings since a while
and was always meant to the replace qcom,ipc properties, so let's mark
qcom,ipc as deprecated - and update the examples to use mboxes.

Related:
https://lore.kernel.org/linux-arm-msm/20240424-apcs-mboxes-v1-0-6556c47cb501@z3ntu.xyz/

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (2):
      dt-bindings: remoteproc: qcom,smd-edge: Mark qcom,ipc as deprecated
      dt-bindings: soc: qcom,smp2p: Mark qcom,ipc as deprecated

 Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml | 3 ++-
 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)
---
base-commit: a59668a9397e7245b26e9be85d23f242ff757ae8
change-id: 20240425-qcom-ipc-deprecate-37afbe33cadc

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


