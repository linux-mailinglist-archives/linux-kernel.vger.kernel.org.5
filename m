Return-Path: <linux-kernel+bounces-166847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CFB8BA0CF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55940284B71
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B2C17A931;
	Thu,  2 May 2024 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="cH6BO/we"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE6F5F874;
	Thu,  2 May 2024 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714676310; cv=none; b=fBQ71uGw+MNBOI+f4qilr+FaZKbgWZCskYtLrYwMytqvOms3E3iLUrrQfLTISpW8kYrZIYsTWC38FXL4fdQXpYjpIs5yfYv3IYfDUNy3Zr3khyROvlqjBcBRyLPcsXLv3dF3U1YgMefyDox1xClGFQsW2DrhD9brUC8fhtWn0gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714676310; c=relaxed/simple;
	bh=bl5dLedeVHinTwXbPr8vyAKTOVFkp3ArQKY63gLQgT8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=dbsQGU5CoIAd/3JKNF7uDed4WfnAw2WS2qu31TN+Y3bag0PjIizmpPR93i15ivIWCyaTz0o6zj2URzybvYol4QwdUo/SVwJXpP36cgv1Osq/TAu/pRoOdWdEY1hZOaLrc+hY+TeDGHle7+qQSbPeVSUkzg7P2rEOTS3mY47EG9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=cH6BO/we; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s2bdQ-005SoR-14;
	Thu, 02 May 2024 20:58:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k0L8BTxNF+69px0G08v0iOgQoWbsdwgMdGo71CzG22I=; b=cH6BO/we91ZSYRnlUMBlNeokn+
	k8l+yPhzO93Y5sdhoZLwI6RzP23hv5PctvKsv5MBnw2DSG4pPTOLhSgPI/c8iv/PnHZsHvpeoLESk
	OhCXfvpNgf+egEcNyxzw41YAtpBamrVf7hQzWCgbvgzWJs/ShgMkkkfXgWr9mK1Ne0hUDTDbsT/M8
	AiE6EvatcR3zsavQ0dVERJB2YMqj1f3OIRJ2NJgmyT04o9kuXw9GGxqcTFbvnWriRiKLdt5de7KCz
	ZgmGsQKikNJYRx0mAxnRw7V0JDiyQWGlVguQRjPl0bj2kC4h7PKO56IdYKCn4Wm+6MwZ/Ysuyt+lY
	9i8pUXKw==;
Received: from p200300c20737c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:737:c200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s2bdO-000RVV-01;
	Thu, 02 May 2024 20:58:23 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s2bdO-003JBr-28;
	Thu, 02 May 2024 20:58:22 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andreas@kemnade.info,
	hdegoede@redhat.com,
	andy.shevchenko@gmail.com,
	u.kleine-koenig@pengutronix.de,
	siebren.vroegindeweij@hotmail.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Input: Add ektf2232 support
Date: Thu,  2 May 2024 20:58:17 +0200
Message-Id: <20240502185819.788716-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the EKTF2232 to the ektf2127 driver which
contains support for similar chips.

Add the needed compatible to bindings and convert them.

Andreas Kemnade (2):
  dt-bindings: touchscreen: convert elan,ektf2127 to json-schema
  Input: ektf2127 - add ektf2232 support

 .../bindings/input/touchscreen/ektf2127.txt   | 25 --------
 .../input/touchscreen/elan,ektf2127.yaml      | 59 +++++++++++++++++++
 drivers/input/touchscreen/ektf2127.c          | 15 ++++-
 3 files changed, 72 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/elan,ektf2127.yaml

-- 
2.39.2


