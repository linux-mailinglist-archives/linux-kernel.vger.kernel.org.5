Return-Path: <linux-kernel+bounces-130426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387D28977E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697EA1C2461C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410E2153822;
	Wed,  3 Apr 2024 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="eox94OUZ"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA091534EB;
	Wed,  3 Apr 2024 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167933; cv=none; b=e8coIh4T83cC+qINqFTrukTRbt+6UvUFxbBFPz2Nt8nEDeMD1YCjl2q/S/LNXVe2j7dz9m5B+PeSbpvf+bKXY9RotnGNQVKTyvBCACrwpdE3wkvosykFl2k08J+2UvDoAWshjDYsDJFlCyvl9k8wpeoEpXhL5XP3ofxUtKTqtJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167933; c=relaxed/simple;
	bh=ls/Wl+t538/eyOzWoGEtw1hbqlvvWed9Zqy1LROxzjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p61IW6bKjsIEfoPWvZOg2U1GrvpJtoZwKTZsKFx6onDC+Xy23GLyhr5fSncxGLLyfCBWiPekkefAQG8p+/F57TNJwnt/EdRclitslrXyG51HRJRiHD7BcqGQ/sLU2RIvbFHiBPdIKSZ7PhS0mBKCbyI7gJEG8tHMp19Ovjkuc6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=eox94OUZ; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 3fdfa96d231f61a8; Wed, 3 Apr 2024 20:12:09 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E52B5662F36;
	Wed,  3 Apr 2024 20:12:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712167929;
	bh=ls/Wl+t538/eyOzWoGEtw1hbqlvvWed9Zqy1LROxzjA=;
	h=From:To:Cc:Subject:Date;
	b=eox94OUZupFTdTikxF0UEV6dtZfC8f8xK1c6ylqG4eFfZMySBONUI7N+y6kGmJIdh
	 XhD/shOpVMs9lXtjhqBFu1E40WGzhic2LpTC3VkoOmkpv//ytcHfR8tqpuLJZcrOyY
	 ONqAfcKhFqFMc/ll+sEyBOxLy/2X3EsHVbndypvuRB49dLQFeV+DSA+JyZnteEuLIG
	 6Pd5kDu6h9/HsbHo8Gb5q7SQBsX6k2t3hJMjM8OK+GRJeGnd9ev2NyiDxYfE1Zjcb+
	 3VR3Aycw6KXsdSMOCjayc/LOqD6VSh6yyPjpZ2oyMTyFVNy04MxUQVNxpFBtbDMfqw
	 HjPJtZMtbTo6Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 0/2] thermal: gov_step_wide: Two cleanups
Date: Wed, 03 Apr 2024 20:09:55 +0200
Message-ID: <5766468.DvuYhMxLoT@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudefiedgjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

Hi Everyone,

The patches in this series clean up the step-wise thermal governor
and are not expected to alter its functionality.

Please see the changelogs of the patches for details.

The patches should apply directly on top of 6.9-rc2.

Thanks!




