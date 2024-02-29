Return-Path: <linux-kernel+bounces-87372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519C886D38D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D6D1C228BF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0247613C9F8;
	Thu, 29 Feb 2024 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MBqQ6pv2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA42C134411;
	Thu, 29 Feb 2024 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235892; cv=none; b=J3KV/i0IYn3wL7n3BkIlD7kApcjSLPhXZp0lEidnTPWUwTpJHsQFX3tOIvMN0641fOx3llN35VWiyRW/aMCm8HFVDToyjtlAZvTaJy+8Y0vCdaet0E0OcD5XERDlVzozMSzL8/55ert13U0cGsAyiLXr8QFSUNlGoS41RSkStxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235892; c=relaxed/simple;
	bh=YqL7w/yusbcYydh4ITQceifk1FO1VxHPmNk4up1BPaY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DwxzUtH0ZfnOz4wFjk+qYpsG/aqIW1E24ZKCGqh0DgzQiHX78WiflkEaK0S6812xAdi3487hzjtrI3bq62vsOfYx8v4e/xewcSv+Hjsolz/ZXySpgI7cZ1+qTE7N05jut5G6OSEFJyHJg3uLC0VY3d+JJtkV6jWjH9y07/J/tVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MBqQ6pv2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709235888;
	bh=YqL7w/yusbcYydh4ITQceifk1FO1VxHPmNk4up1BPaY=;
	h=From:Subject:Date:To:Cc:From;
	b=MBqQ6pv2w/6veo/rg9b7O0NuOtiQVHb20ijcg5MfI5FtnxAV0UyEZn6YDgXdVBwuU
	 IAqnr9BKxSD4xlWBauXKzQd+/k1ryOto1ADIQOHI+KrgTP/VdhTWshilNL4pR/3otv
	 GQ3aBRk46OhksMg2ZCcVFjQFgBin8Ipt28wOlbQR+90hIoCJSkHrCU/tWnIBSQ22R7
	 yr9lfAY19V6P7I3gNm/7luShAwRwGfCMBROZBsmTskK/54qlKKA3bEhJC+sMoq8kQn
	 tU1V+Fch0BL/oYyO0f648XKNFJREG279ILhbLzTBqzWg6ev6Uk0T/OV9laO52I0wse
	 YNgHdXJv90LwA==
Received: from [192.168.1.200] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AC87F3780C22;
	Thu, 29 Feb 2024 19:44:45 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH 0/4] arm64: dts: mediatek: Add missing gce-client-reg
 properties to mt8192 and mt8195
Date: Thu, 29 Feb 2024 14:44:27 -0500
Message-Id: <20240229-gce-client-reg-add-missing-mt8192-95-v1-0-b12c233a8a33@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJve4GUC/x3NwQqDMAyA4VeRnBeowYrdq8gOJY1dYHbSiAjiu
 6/s+F3+/wKTqmLw7C6ocqjptzT0jw74HUsW1NQM5GhwRAEzC/JHpexYJWNMCVc105Jx3ac+EAa
 PyXl2ow88cYSW2qosev438+u+f81vl9Z2AAAA
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Allen-KH Cheng <allen-kh.cheng@mediatek.com>, 
 Tinghan Shen <tinghan.shen@mediatek.com>, 
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>, 
 "Nancy.Lin" <nancy.lin@mediatek.com>, kernel@collabora.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

This series adds the gce-client-reg properties to the nodes where it was
missing in order to avoid "error -2 can't parse gce-client-reg property"
errors and possibly improve the performance. The separation of the
commits was done in order for each one to have a single Fixes tag and
therefore be more easily backported.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Nícolas F. R. A. Prado (4):
      arm64: dts: mediatek: mt8192: Add missing gce-client-reg to mutex
      arm64: dts: mediatek: mt8195: Add missing gce-client-reg to vpp/vdosys
      arm64: dts: mediatek: mt8195: Add missing gce-client-reg to mutex
      arm64: dts: mediatek: mt8195: Add missing gce-client-reg to mutex1

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 1 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 5 +++++
 2 files changed, 6 insertions(+)
---
base-commit: 2ae0a045e6814c8c1d676d6153c605a65746aa29
change-id: 20240229-gce-client-reg-add-missing-mt8192-95-d05c0659c8ca

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


