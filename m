Return-Path: <linux-kernel+bounces-131779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E35898BB0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A34D1C20CB9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ECF12AADB;
	Thu,  4 Apr 2024 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RptcxCAx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="edCftCBz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005D212B95;
	Thu,  4 Apr 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246352; cv=none; b=obuy1SqftF4Z2DpL73a8b8Kj/E5D12zpiSurk5M1CTqRi5Rx+Un3bvLXsR9wPSxVQwsp7Xx+fZSaXmwfCrPsS7uN2JVndh7sOGgevsucvHdAU9t2Jcmci/NI1QyYrFkpcYfSS3PQFXDB5sfsBpk0SPc/pfH/6Ph6/7F4TBnqL8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246352; c=relaxed/simple;
	bh=QZZOfpQkM1SWu3neklg/Bz+NRNA4/idND1m+FNU4EBU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rJWXTkXZ69mtHMp/z8Xy6cLRxXrC3naq5q1k1xNms4MaPoiWt/gxUPlqJIaGMpcUbErzBsIuthkCkhFk7r3dsCgMfiEuKpVbA4+auo1Wzlt7pihLm0caeK2n/wJikbzNmbafoGDkzTH3NYfbRiaYVge55G7Y0T1jpeIHPrtdwgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RptcxCAx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=edCftCBz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Apr 2024 15:59:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712246348;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h25tP7JhPRBjUVgxYgKGxplFqczigMYRDlGHY3+94MM=;
	b=RptcxCAx5f3p7x/Ds9girj8ZP2nbwEI4VWCV5Q0xjtuby1sc0J81ouwXpFv3xx/E6pzcRj
	bi7OfrEztd1DbluGMmZyNWWKBA/8MgQUlvJTwLryU1mHIK0qmEoeZJpDjZwBW13gKfMLUz
	KqeVHnjWyQsHoyrsP5/B3jMX0o0mTphAw24slwfNjVrKNc602xi/qeHK0FaP6ItcDMhXDa
	toeSOYn2vuEcMvTm52O1xDUDX4yv3rMgGt5cAnmVaaurvMeTuZRj4gzf5SY/FI9rgtRW7l
	YE2MV/ibrBxe6D24IdZjUrCb4XuwmwiH7i5hKMJj5oBT/snGIRLly52tKfzp8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712246348;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h25tP7JhPRBjUVgxYgKGxplFqczigMYRDlGHY3+94MM=;
	b=edCftCBzDpioaaUOyybLiB2BDOGsSzdXPwXMWS9oYOd1D+mmCjlc6Sfo0KReLNKDdWbn/r
	rp83JjEvKGRJelBA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,  <stable@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <CAEkJfYNiENwQY8yV1LYJ9LjJs%2Bx_-PqMv98gKig55=2vbzffRw@mail.gmail.com>
References:
 <CAEkJfYNiENwQY8yV1LYJ9LjJs%2Bx_-PqMv98gKig55=2vbzffRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171224634724.10875.17845377587984036276.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3ddf944b32f88741c303f0b21459dbb3872b8bc5
Gitweb:        https://git.kernel.org/tip/3ddf944b32f88741c303f0b21459dbb3872=
b8bc5
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 13 Mar 2024 14:48:27 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 04 Apr 2024 17:25:15 +02:00

x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()

Modifying a MCA bank's MCA_CTL bits which control which error types to
be reported is done over

  /sys/devices/system/machinecheck/
  =E2=94=9C=E2=94=80=E2=94=80 machinecheck0
  =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 bank0
  =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 bank1
  =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 bank10
  =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 bank11
  ...

sysfs nodes by writing the new bit mask of events to enable.

When the write is accepted, the kernel deletes all current timers and
reinits all banks.

Doing that in parallel can lead to initializing a timer which is already
armed and in the timer wheel, i.e., in use already:

  ODEBUG: init active (active state 0) object: ffff888063a28000 object
  type: timer_list hint: mce_timer_fn+0x0/0x240 arch/x86/kernel/cpu/mce/core.=
c:2642
  WARNING: CPU: 0 PID: 8120 at lib/debugobjects.c:514
  debug_print_object+0x1a0/0x2a0 lib/debugobjects.c:514

Fix that by grabbing the sysfs mutex as the rest of the MCA sysfs code
does.

Reported by: Yue Sun <samsun1006219@gmail.com>
Reported by: xingwei lee <xrivendell7@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/CAEkJfYNiENwQY8yV1LYJ9LjJs%2Bx_-PqMv98gKig55=
=3D2vbzffRw@mail.gmail.com
---
 arch/x86/kernel/cpu/mce/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b5cc557..84d41be 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2500,12 +2500,14 @@ static ssize_t set_bank(struct device *s, struct devi=
ce_attribute *attr,
 		return -EINVAL;
=20
 	b =3D &per_cpu(mce_banks_array, s->id)[bank];
-
 	if (!b->init)
 		return -ENODEV;
=20
 	b->ctl =3D new;
+
+	mutex_lock(&mce_sysfs_mutex);
 	mce_restart();
+	mutex_unlock(&mce_sysfs_mutex);
=20
 	return size;
 }

