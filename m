Return-Path: <linux-kernel+bounces-45718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D2E84349C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A959A28A33E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E2B14F78;
	Wed, 31 Jan 2024 03:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jmoon.dev header.i=@jmoon.dev header.b="QyU4oknw"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B11412B81
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706672631; cv=none; b=bMYg2fj7gSdk9neWS21IomwfrjyycEszKRsfp+IAaTKvaUQ5p7ljmmDSj1fYpTkLrWZMpAPu6bXWxMq6qzgsDf+gk8W0xCqfc1PX3UPMKAlUE08luuZRQhKKhlfGlJ1bnOTNd6thMzeDniKwlXceBiRUvHxADeBBtfIPhsUnm2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706672631; c=relaxed/simple;
	bh=uz3FfBBgjtBqsaC5lQhvIHcRGG7TVhJhiaUPcxVuoEU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eWgExwsKk0z103UKgB8ce9lrrZOx6XQOd1+YRkmyOPo0lMhjDL1cJbIqg9LThO/k/Sq+nkUx0vDb0ex+9C/MWeiglceUFSv6d23c7yPba+PJzfFk2Pcr8FbrO7ALHSa1qBfJCYesyd/9w4wJhHmqT7ZQzty3O9S5OGcfeZjSRRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmoon.dev; spf=pass smtp.mailfrom=jmoon.dev; dkim=pass (2048-bit key) header.d=jmoon.dev header.i=@jmoon.dev header.b=QyU4oknw; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmoon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmoon.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jmoon.dev;
	s=protonmail3; t=1706672611; x=1706931811;
	bh=uz3FfBBgjtBqsaC5lQhvIHcRGG7TVhJhiaUPcxVuoEU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QyU4oknwLitCQAvn0AzGm9AbKV4c1MWO1QWk/j5cj2MWQZi8yavV0M5ZaqTGZTnXi
	 XQUdW0Yq8OazvR3TCYSwaADcmqwYQnCecdoBeO8bki7/LA7bZWtq5P+wCn21rvl47z
	 4rcvHEGjN5mUMZZnnOsk7BEZ0gmzYCRkfD8MspdRmFe2ztMT6dfshc0KgzRqInfw3H
	 flMXsLkDZMG6CyLNAqpb1UatGrr9c0HSOEikxsgIp7wx9mKy3MVLvbPj+K99jYRn20
	 VQ/CUJ4lArae9gpytLC46TDirmVoLF7WAcQm8evxSbtTWe7/2p3WI0AYf1fEKQOg6d
	 ohftpUbZ5kI8w==
Date: Wed, 31 Jan 2024 03:43:18 +0000
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
From: John Moon <john@jmoon.dev>
Cc: John Moon <john@jmoon.dev>, Trilok Soni <quic_tsoni@quicinc.com>, Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH] mailmap: switch email address for John Moon
Message-ID: <20240131034311.46706-1-john@jmoon.dev>
Feedback-ID: 18069581:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

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



