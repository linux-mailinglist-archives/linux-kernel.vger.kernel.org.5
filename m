Return-Path: <linux-kernel+bounces-51741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3EB848EC8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C62FB21A2A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E5B225B2;
	Sun,  4 Feb 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="MOdtd64h"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEACC224E0;
	Sun,  4 Feb 2024 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707059203; cv=none; b=tQk5B05+yCa7afR9z5czkqwZfyoyKr+isKbJAEJRLIk0g0G7+hn7cRCG+c00P/yNCNeGCsOt+hI1VagUryEUWPPRQSOdkPljAt3qWKnNf+5X9o29pEjkKEObbxl7X/dyxTluziULt7V8jT/M/G2h6VhhQdJcP9SN/Uh+Mr16Q9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707059203; c=relaxed/simple;
	bh=ZN6JpnKgsg6TAuxH18C8IUu1XeyPKn8TemC5O9spX14=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=laAx/+fq4bxjNO8ERKT5yzwcsqb2SbWUbsga8VA1yk5B6f2xcl1+PXGeEVEV9jNWWI+BEVhhrQyWJXht5/33qesxDjPcWsTetKlnHoxKQb77V+ungdEqdj1AN8K+VJXRDLU/onsa2bd6DXDVppmaGHY+Y3z71ys6WDHa48MpKPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=MOdtd64h reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so2300922a12.0;
        Sun, 04 Feb 2024 07:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707059201; x=1707664001;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vi/JlahQB7RMdLZiZn6ffPYKmMKaMXk+BX02n7bUJBE=;
        b=AkA15VC+P0uovY/MOXQa1iWYoICN3bStCnnhtx3X2iXG//1C2GQbQuCkwOcOBVb6Kg
         +Yyyb63o3r/FEsflit1WOm75etG2EH/p4HlA2NhQFgqj9PqHOMIopFXhBEE1YT3LoX5H
         AaKfxIR1iKyRQiqhhZNtUaGHzqvumueTfHRe8v+r1ILNwri6wWUHRJIIrZVMK+InYJco
         wJI4k3TDbPGsVS3T+5Beb/UwmwB/zziQp8ReOTTmkkIBqhtKNReqW0QhnavvuKH4kame
         n1P+LdBDDLCor6aS7VhpEQx8PYVQ/9AilHjaviItIuJB86htQkSbzsiYimJJoVIOI67u
         LrxQ==
X-Gm-Message-State: AOJu0YxpFv3Pmr3R0PTBxsx5ThzKdBnoJbJwdOgfFU3GFJeX/3Yvwtsh
	G4AnSLGurny/wwsRHSzJHj8A+q9c4AgBziKTiUUqYe7v3a8Nxce2WFkC801xzLGk7g==
X-Google-Smtp-Source: AGHT+IH4OiIa6kPSiTbZITimK0Cy8yEbZMRiR9vYpd0fm0ArCmadY0wmrfOwy3zeZ6mo7dMpRrjpXg==
X-Received: by 2002:a17:902:708c:b0:1d9:63d1:e619 with SMTP id z12-20020a170902708c00b001d963d1e619mr6955526plk.29.1707059201073;
        Sun, 04 Feb 2024 07:06:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVViz/wPuNcf9MMFZ6PY9JhxAL21iEhguc32HLTSbWBVnuEWq5t7ImOul7k32jl9SzjGVfv0Ush89uZPa3R6izxD/32O8H9XEeaR9ke5Rl7CfLJDMyzprt1JGQqsGSj6rf9A/BtdLclpA==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id z17-20020a170903409100b001c407fac227sm4678883plc.41.2024.02.04.07.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 07:06:40 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707059198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vi/JlahQB7RMdLZiZn6ffPYKmMKaMXk+BX02n7bUJBE=;
	b=MOdtd64h71G7MXVIFX9QkxlvIgahH8E0hxa4JWVd1ebLq3hn2soeSSLWBun0QqQCCh9exh
	a7eVbsSQsrPXORD7rXItdoi989JHKTtXTpIaSjXb3sPah7cukw8CsB2IfcRDAuCVBDIApB
	MD4uyOXgh2PsmC/cewhzu4kU9lfNlwfG1a4EE9WJkBnTApfLkBJQ+3bjcGAw4cxG3hcvPH
	+0vraQxCRZbJA9OG6SuC+PF+h58fXk+0qKjnJkGkSXPLW9Bz6KjluKok8t56SK4LTKcS1g
	CujC7w4RHWC0SN9BAoc971nXSnLdtqijM6OB1w867WV9t/RtPxDzRfFhcShHOQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/2] mips: struct bus_type cleanup
Date: Sun, 04 Feb 2024 12:06:56 -0300
Message-Id: <20240204-bus_cleanup-mips-v1-0-05af5e9a7ead@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABCov2UC/x3M0QpAMBSA4VfRubaaYxSvImnm4BSzdiIl7265/
 C7+/wGhyCTQZg9Eulj48AlFnoFbrV9I8ZQMqNFo1EaNpwxuI+vPoHYOokYqpwpdU1OJkLIQaeb
 7X3b9+36sdJsoYgAAAA==
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=ZN6JpnKgsg6TAuxH18C8IUu1XeyPKn8TemC5O9spX14=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv6gcpCYU248jEkaXwLbzadv/JrsdNGqTmkE5U
 +7e01xKuQ6JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+oHAAKCRDJC4p8Y4ZY
 pv6jD/9g4KmFRZU9tGMw8Trdiy/iNVAvj+z++ip1GpLvst78VTJh75v+cakxYJD7i7z22DIsC+G
 fZzr+H1fYzcagA8muYm4Mw2BtsK+6yR3Jk9LMZ7H/yVMS7dFXnPS5m+oaTVBrDG8FXdx1c9szBb
 8OIwfjEHfYskv1nxK31lzeG6AC8ruw5jr/VhWFfXG9crUj7ghr5EqVM6baCggN39/2EJanY6vEX
 WueQzKcJ82rBk1OrTMWt3yAxna86+4bw72/w6rliVE9+kbr7uYKFOTxwb9F60aDvmRO+aqmNYN0
 ZYvUW2WlbzJTCrMGIA+8tQ9RIStQbWFT2RB9I4xylokmusLLhi/7GX5VCt1p19pA/Aa4mSdsqik
 n1nc3QoSHs7toURXR+3FefZ0dWNpEWSyEDc97xludSBqUR1HtisdDWlu6ejeNiSY4yWcRIXcLmI
 r0i9ut5uYgiDM7wOV/OFvsiUPpv/nOsLUUNXee8QlBtIBwKgE1+uhoK+RijbP4RuCADJ6Wd70r/
 CxYKwnNCrJoRWHidjPwlPuaY1fBd+btf3vFtzbRAkn7V6NxqG3flsRSlK0yobJN7LkXasMdS3SW
 3ocljnbWYd76JMzMblZQFK6aHqFUWKiXwyzMElcpTWUDJRBFIh6NNA5nG1SkhmqxkJKg6FGvqHQ
 x4tzBV0V2jIV5RQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This series is part of an effort to cleanup the users of the driver
core, as can be seen in many recent patches authored by Greg across the
tree (e.g. [1]). Specifically, this series is part of the task of
splitting one of his TODOs [2].

---
[1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

---
Ricardo B. Marliere (2):
      mips: sgi-ip22: make gio_bus_type const
      mips: txx9: make txx9_sramc_subsys const

 arch/mips/sgi-ip22/ip22-gio.c  | 4 ++--
 arch/mips/txx9/generic/setup.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240204-bus_cleanup-mips-be3d52c96e32

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


