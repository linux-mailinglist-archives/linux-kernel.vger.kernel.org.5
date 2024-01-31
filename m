Return-Path: <linux-kernel+bounces-45715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B136B843491
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8F0AB24C55
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA4B12B79;
	Wed, 31 Jan 2024 03:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jmoon.dev header.i=@jmoon.dev header.b="VTud8Wq1"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3F7748A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706672303; cv=none; b=T2cmKJ1Ae/DzA32k+QbQA76qJy1rrv37ydsYO/dT0lSbmKkMLPwu+dq5+zdeOwNTYHxHyuBJUsH5p20NvxJxEPHsSVDh09UbyyNu9Cq0Ms7W98HuWf1iqNMJIJqdhx7E5uZ2jE3klNYD6a6wwmbV7tUZs47tRSZQkDigX1GnVr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706672303; c=relaxed/simple;
	bh=mpEjd6SN2y0d2j8Tr8Pb/b6KXrr+2Vosdvx6+U+t+EI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bPxv0WsxIaNmajL1wEvmRmDBY8ymxUxWvBhBi9rJziPpFSFKsWNmjtire//L9XQDg5zfduwld2Yu6WBOX+gh8TmbHQpwIe/LtYJ8wI+DnBd3IISZOc8ooESWbFLZ1z9I2z2ULLOzl9DoI8prm90hJkM4EIXO8YJ8kgWRGXGaS2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmoon.dev; spf=pass smtp.mailfrom=jmoon.dev; dkim=pass (2048-bit key) header.d=jmoon.dev header.i=@jmoon.dev header.b=VTud8Wq1; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmoon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmoon.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jmoon.dev;
	s=protonmail3; t=1706672282; x=1706931482;
	bh=mpEjd6SN2y0d2j8Tr8Pb/b6KXrr+2Vosdvx6+U+t+EI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=VTud8Wq18m4MFaT0PsxzbDxQ0AMGnNWTCC0FkREmxSMJez5/CoyknTu6dqknt/IHI
	 P2XA0JDaFo8y8fgQIFXHuD/exAkkXLvMMNEvbW7cTYn9qsMdVUbLb0Q1FUfReuZb3S
	 tVG3MMVHHJNMCX9aGLKowY4UJn7oJ3NcQRbTTEdoRd1HauiEuPFF7Gs+6jf5zVB/+o
	 uvqyaiAGmu0wqbCf1D2sL0LI0sCQf1gX46NM+CCCfFNvWhd1LrFzLkhY1TVtSXtsAI
	 fm+ZeNIxlwkbgbSbh/YJV9UB6IYa/pv+IcOPtrt7VY7gWMeG5AfiN1LfTqN3Q2djb0
	 CBB3qLhS+rovQ==
Date: Wed, 31 Jan 2024 03:37:50 +0000
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
From: John Moon <john@jmoon.dev>
Cc: John Moon <john@jmoon.dev>, Trilok Soni <quic_tsoni@quicinc.com>, Elliot Berman <quic_eberman@quicinc.com>
Subject: (No Subject)
Message-ID: <20240131033751.46495-1-john@jmoon.dev>
Feedback-ID: 18069581:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Date: Tue, 30 Jan 2024 18:57:45 -0800
Subject: [PATCH] mailmap: switch email address for John Moon

Add current email address as QUIC email is no longer active.

Signed-off-by: John Moon <john@jmoon.dev>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 04998f7bda81..8ae00bd3708a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -289,6 +289,7 @@ Johan Hovold <johan@kernel.org> <johan@hovoldconsulting=
com>
 John Crispin <john@phrozen.org> <blogic@openwrt.org>
 John Fastabend <john.fastabend@gmail.com> <john.r.fastabend@intel.com>
 John Keeping <john@keeping.me.uk> <john@metanate.com>
+John Moon <john@jmoon.dev> <quic_johmoo@quicinc.com>
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
 John Stultz <johnstul@us.ibm.com>
 <jon.toppins+linux@gmail.com> <jtoppins@cumulusnetworks.com>
--=20
2.43.0



