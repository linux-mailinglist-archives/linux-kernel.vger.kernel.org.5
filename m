Return-Path: <linux-kernel+bounces-117364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A27088AA76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0251F65DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3003170CA6;
	Mon, 25 Mar 2024 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="0IJ02dZJ"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13246FE09;
	Mon, 25 Mar 2024 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380490; cv=none; b=BGce2VNMx37AcQL4SwFqIxNejZ1UdfAeFhHx6YlR4Ncl/RGRLAYwd54wxPdKojmahE/dXeLvgSI587TlGn3xC4eWjR+D+L1e5ftVNLS46Q7Xe0/kvWgX51eYu/xV3u5ZX76tyjsI3MI7sSdC6K92HLubk0pMfEWdHeIQ7ltxbYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380490; c=relaxed/simple;
	bh=5TNZ/0vXqU8T1qc7INc6viVA07FvS1UZfC3Iz40p8us=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=DYWCaDCC04VcHnW/QGQR9hoG6q/LvQmOYoWFtAzVERJLDAIZuzCt+pNu//uIPycGpu2ga/odkcwyg0zleG/PJjMG9jOX88m7+i8BVcKsaVN8vlS2zAnDssIW6xIYrLswNtTcIR5I3KlYTPYaa2r7DakEhi0dYxUyFSI1o2tWQw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=0IJ02dZJ; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1roltB-003KE7-37;
	Mon, 25 Mar 2024 16:05:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8+IJOcRrnTEfFitmECGtcWpIAwCHu/9+63TuWIfjEw0=; b=0IJ02dZJXALWDHAreLDC72TRan
	zLZRv2pU3/co53GzKa4ET1I3s5NLiZQUzpeEkeglKiAAlfUfN1RtoNRUoqhKEGmBUKLUp5sx2yCrE
	v1ANbUr7xuOqpNUdfjkwWUSqT/l1PzBOi727qxOd/7IYcKmgVnP1ACzJDdl3tzWXLsEXQ58fTOKB4
	c5CC8hQbuJ13Im+AShvlNsBM3MyYJJWRFdI+BrwavQXdGq27PPMd1I36TmQPCxkixzxMOS3wC7hru
	j2F4k+Csbovvx3sgmVv/7NFZR+sPphp5KnFtLNo0H9/lMdogwsDTHSq9IVChEz/wk3X37gSOD1XjN
	4sTx6kBw==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1roSqL-000Y1x-Oi; Sun, 24 Mar 2024 19:45:17 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1roSqK-000rkG-2I;
	Sun, 24 Mar 2024 19:45:16 +0100
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
Subject: [PATCH 0/2] Input: add ft5426
Date: Sun, 24 Mar 2024 19:44:13 +0100
Message-Id: <20240324184415.206587-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ft5426 touchscreen controller and the corresponding compatible.

Andreas Kemnade (2):
  dt-bindings: input: touchscreen: edt-ft5x06: Add ft5426
  Input: edt-ft5x06 - add ft5426

 .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml        | 1 +
 drivers/input/touchscreen/edt-ft5x06.c                           | 1 +
 2 files changed, 2 insertions(+)

-- 
2.39.2


