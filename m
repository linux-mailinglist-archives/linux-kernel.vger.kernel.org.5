Return-Path: <linux-kernel+bounces-108797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF315881017
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89FF282940
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1443B19D;
	Wed, 20 Mar 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="jbjwjpsd"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EF739FED;
	Wed, 20 Mar 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931230; cv=none; b=SJP5c59zlz1/g4u2cPSQ8RZ6ODbBqzsSbfE2uNDhAdU9gBS7bpjD27Po/ycLWTcp3Kp8cbVImedST/CgXT507e4f/Sf7M9+0CGGgzS8h/5FcLrPpYStQ6IR1pp3itHtiW15X7b4rty+bfk+krtliqkusgWhNoPSB/03Ezo+PnfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931230; c=relaxed/simple;
	bh=ls6xLhp/KwBA1fCnfVdKXiKvpHzqIRtYfTSXA2EgX4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TZhJWC8GKa/NlLkwprTGzaL+wbLU+fc/6u8jBBfRwA8JtAsUuW1Swnu3lIfMF+ynysXc9JBetdwfRuNkJrtSZ1m4XDesG0L8ml2y49hBehgTD0lQUFvAxJ5l1KxpOPpG6T1IYMJGhhdY7K/ZVlZpZ5IgVI6jq0D+IMq08I8+doY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=jbjwjpsd; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=k/hQjJjKM/6k2dIpkZOd1CRB2GRUhhh9M/CTbWGkxv4=; b=jbjwjpsdmK16TTuRIvVxOmhZIc
	HlhCLjlWDtjLAD9FUfGYndwLoeClywCY8MSkgv3l8kFFL30PvXMfY8fFQafC7itVkT9bhXVsQc3P2
	8o5+caqTrTmGyCBCJkHfJUnxW2kLSdt66gTADdXVxy98l/ZaOA214ohvxJ3JFTsLJ0MqCAzmUaoAx
	wYOneq0ntlulQr8RziSi/iwJT1J6jWfQ1jpwNLr91Wdv6REaiqf70ygVvK5Bd20KbSecQNIXMpS8v
	o1ZvqXn5xAp1qQrPbLb/Lselh3/zNPuMH5Y8yZUExM+UFJZNqmWEL1jQkI26cEm6UR5pDFGzZQX40
	tajbO/GA==;
Received: from [89.212.21.243] (port=57750 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1rmsnx-005Tm8-0g;
	Wed, 20 Mar 2024 11:04:17 +0100
From: Andrej Picej <andrej.picej@norik.com>
To: haibo.chen@nxp.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH 0/2] i.MX93 ADC calibration settings
Date: Wed, 20 Mar 2024 11:04:04 +0100
Message-Id: <20240320100407.1639082-1-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi all,

we had some problems with failing ADC calibration on the i.MX93 boards.
Changing default calibration settings fixed this. The board where this
patches are useful is not yet upstream but will be soon (hopefully).

Since we had these patches laying around we thought they might also be
useful for someone else.

Best regards,
Andrej

Andrej Picej (2):
  iio: adc: imx93: Make calibration properties configurable
  dt-bindings: iio: adc: nxp,imx93-adc.yaml: Add calibration properties

 .../bindings/iio/adc/nxp,imx93-adc.yaml       | 15 +++++
 drivers/iio/adc/imx93_adc.c                   | 66 +++++++++++++++++--
 2 files changed, 76 insertions(+), 5 deletions(-)

-- 
2.25.1


