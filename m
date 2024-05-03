Return-Path: <linux-kernel+bounces-168009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D848BB22D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6379AB23B2C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BD51586D3;
	Fri,  3 May 2024 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="R105vteL"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E188158210;
	Fri,  3 May 2024 18:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759789; cv=none; b=GFu5ynbj2MgRYkY5qkrRompZwgw4gsl+gBsinl3bNDll/JxfH4+FqQvmKj3htrC1izCsTXxkYgGb1Jz7KHamNHRWOfyJt/RKXhzrAoWbU7mpijevnxBgFm6l77BELu6dLDygU+U7ARWsPuhH17nDRPILkZ34t9POfRgXTBWv1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759789; c=relaxed/simple;
	bh=KTQbo88HL9DMqt/voiTSmZpfkoFSYoSSyH8bMCHFzSE=;
	h=From:Subject:Date:Message-ID:To; b=JJtvc7PgpELdPr5iTL/JBx/Xe8JE0ljAD5Y8bMyPV4qBWECNFJsoO6q9hhNbYAOO0/a7NJ+HyUCehUyp9KTUilA/Mabg6Jc57YCTxvk2xkYAb7Z43EjvaADiHWeXP/zrjZaWkwwrQF9JgrjFdFA+5wcN05gFW91bdqQmXLFGOfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=R105vteL; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from canonical.com (1.general.jsalisbury.us.vpn [10.172.66.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1AE073F6D2;
	Fri,  3 May 2024 18:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714759779;
	bh=JpzLh643eu4d1Q70R2e1LKtn4Ak4f3w0HOVexQRqJxk=;
	h=From:Subject:Date:Message-ID:To;
	b=R105vteLOJR7CDHnqx22BQcOPZs5NDXscUmIY2/FupSwUTvKNszB7/JzecZWh+sKE
	 HPbkvizsdw2wuekWDh81k6NtQ6U53QyVWZOfCj8ymH4P+R+110PskgogRyEwENY1Ms
	 CMRKPxEsW8WPDXiadmwZS5EbIZ/5k3Q55h5uGEMLDcGPBkP7hb98tH9Fl1N+SoI+JE
	 EZ1Zwzd/5sYB4joQCI6JDPR9s3uoa4Seu+RhM7IH0fB1NxnU0HRDp6JtpB+zYqdJc1
	 NYchc3HaHqqxt8M1ajYvEkXbVuaUr0XCZ+Ul16hWdhYOqVnAymGqJzA9hgdQYjFm+0
	 u3A/o0kDQ/Mfw==
From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [ANNOUNCE] 5.15.158-rt76
Date: Fri, 03 May 2024 18:07:39 -0000
Message-ID: <171475965938.1184573.6478662190940634586@jupiter.home.arpa>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.158-rt76 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: c5c5389dfcb81eda122e18fbfb3342483e8dab53

Or to build 5.15.158-rt76 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.158.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.158-rt76.patch.xz


Enjoy!
Joseph Salisbury

