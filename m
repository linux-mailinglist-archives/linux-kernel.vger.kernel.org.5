Return-Path: <linux-kernel+bounces-50219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322278475DC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81571F22853
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DB714AD28;
	Fri,  2 Feb 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="lmcwxENY"
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33A148FFA;
	Fri,  2 Feb 2024 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893908; cv=none; b=XFMwvQeqHiv9kMEhxjY0srgzmxWjRAJDlad9DEf6yBilJw18NOo0I2T3CnDWPIAAYLeNotUTHhqAK6wvLkMYGaTWN8EN6MKRkmeyXxfNlghxEMvIVPhcdEh3IZFPVLlED6ZQT4Cf9MP7to0uc5MHpm4iDQE80HeC+Ng31383QTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893908; c=relaxed/simple;
	bh=GkLG/Ih3ciDHb/oY1HR2jsSSQfa2qCVH7+o2y3bbOqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uK8NXyTp4ykcp/cXR9GWo1LfBEHRosjyIiAhAoivFk+ZwQH0cbQ5h2+Gc0Q+v6T2crbtP17C8IMeVrYN5zNDDzyfaNZe1R1cB3UtldIhYoR+SQylOfSDF++DcgyEA0k+fHtbdmk81tEU0OzHuHd7GDx4b9l9b5QXH5WA4qDKmsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=lmcwxENY; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2A6D0DB15D;
	Fri,  2 Feb 2024 18:05:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1706893503; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=lx9V86aOCoAPL/LyLN8xcbg6dQxC41aHPufhobywE20=;
	b=lmcwxENYGvL2rLhvh457biPQEGb0qn0FTvA+82BMy0UdX9yhmq64+x31APyaAJW4hq+rtw
	om2642Ta7fvqNaOn+u7CVL+RKOfIybzhIpUDW+JKqtU67BmwAv/yLz+aXiK53Ih913UWDo
	gv/rLAAQgrBXyiLKSgXRxqoDdNcGgIms2gZSZW6Gp+Puu7vZRC3y6i9hZiNQeY8tVPhN+V
	uhS69UIymgYRB93+0awiH7nB6IPHt5TtyMV6wUBr/GfSyjnOwhI1wmAO9UjXdZ6ZwroeZf
	tCuNFwnfBVRC1GSosR/inirJSSBCoIAVuZexpZ3LVWv/R0XBTes3Bz1uuoS00g==
From: Daniel Wagner <wagi@monom.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	stable-rt@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 0/1] Linux v4.19.306-rt132-rc1
Date: Fri,  2 Feb 2024 18:04:56 +0100
Message-ID: <20240202170457.29516-1-wagi@monom.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.306-rt132-rc1.

I reverted one -rt specific commit to be able to merge the 4.19.306
release:

  0cb152421350 ("crypto: scompress - serialize RT percpu scratch buffer access with a local lock")

because the stable backport

  f8f261f9ade2 ("crypto: scompress - Use per-CPU struct instead multiple variables")

seems to make the downstream -rt fix unnecessary.


Please scream at me if I messed something up. Please test the patches
too.

The -rc release is also available on kernel.org

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

on the v4.19-rt-next branch.

If all goes well, this patch will be converted to the next main
release on 2024-02-09.

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

