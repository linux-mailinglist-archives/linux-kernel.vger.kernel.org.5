Return-Path: <linux-kernel+bounces-101204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF5587A3F5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC371C2187D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C5B175BF;
	Wed, 13 Mar 2024 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XD3R5Vdz"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0387F19475;
	Wed, 13 Mar 2024 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317711; cv=none; b=NIFhd6DiyERN96z7Fdr8Yjy1sm71otDh63DHmj+gC35Mzuis9ypACZqaQn5zte6bT24XUEFS3ZpdAmOCNOL5enJLKkUYog/IUBgnzCbX/a4hN3pzJfINHo62oT49l0NCL4GLH0jdCimDAmpJjEJC54C5LespusOrr1bv2+MmOqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317711; c=relaxed/simple;
	bh=0/5NHjX0NcGpKOntWSLuLjYYeVXcWVtz8Vuf7DlE4Fw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JcnmHNx2mT/B6pjGG+uodCK/myTS5Fh7fArBfWyXMNDfiiKR2tjO1XRwX2fXf4/1KEzlqP//oTyuiBbjihlvafIR3RxOillRWK2piOooDu1vsZR8qIHIdgeI3P8FmC/pqWiyhHaoZtMofZXSqlN8YdnRahYi3VHtupOAIqBliV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XD3R5Vdz; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ckr01
	FJmxp54/m94lBfQ4L3mHTz6n6ShDxyLmRazeiY=; b=XD3R5VdzDfFXqGrRe6Dra
	w+q2v/JRQFXYeZdCrtazwT8bEctRReKZcdt6ZW8v8QKdvRAqn80sKpHuwW3j+S+A
	atjXWKWBvnoeTSTGF2dmbukwLJbghG9DEPK0pibCOpBCeePTkOhn2vbyQbb0QOoG
	alzWCwnKbGeJIpVpjrk8z8=
Received: from localhost.localdomain (unknown [39.144.138.148])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wDHpTBkYPFl51aWBg--.60890S2;
	Wed, 13 Mar 2024 16:14:28 +0800 (CST)
From: Xing Tong Wu <xingtong_wu@163.com>
To: andy.shevchenko@gmail.com,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Xing Tong Wu <xingtong.wu@siemens.com>,
	Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Henning Schild <henning@hennsch.de>
Subject: [PATCH v3 0/1] Patch Resent: Enabling LED Support for Siemens IPC BX-59A
Date: Wed, 13 Mar 2024 16:14:24 +0800
Message-Id: <20240313081425.2634-1-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHpTBkYPFl51aWBg--.60890S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr18ZrW8Kw1ftF4fJw4UCFg_yoW3Gwc_ur
	yvg3s7Aw18XF9xtay0yF1fZryayrWUArWUAa4ktrW7Kry3Zr1DJFnxArW5WryUXa1akr1k
	uFZrJw18Z347WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjLvKUUUUUU==
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/xtbB0gWg0GWXwhnpRwAAsg

From: Xing Tong Wu <xingtong.wu@siemens.com>

This patch has been resent to incorporate the necessary changes for
enabling LED control on the Siemens IPC BX-59A.

Based on:
 eccc489ef68d70cfdd850ba24933f1febbf2893e

changes since v2:
 - Add a period to the end of the commit message.
 - Use specialized interfaces to get platform data and drvdata.

changes since v1:
 - Creat a resource dynamically within the .probe() function to eliminate the use of global variables.

Xing Tong Wu (1):
  leds: simatic-ipc-leds-gpio: add support for module BX-59A

 .../leds/simple/simatic-ipc-leds-gpio-core.c  |  1 +
 .../simple/simatic-ipc-leds-gpio-f7188x.c     | 53 ++++++++++++++++---
 2 files changed, 48 insertions(+), 6 deletions(-)

-- 
2.25.1


