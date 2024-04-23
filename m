Return-Path: <linux-kernel+bounces-155369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0F88AE971
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F65B1F250EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2207313B58A;
	Tue, 23 Apr 2024 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z5Y8iPty";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2qRowrdR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fkg8i3TO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1XvpnQg1"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3936A03F;
	Tue, 23 Apr 2024 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882453; cv=none; b=GZU+UC6uOEjA8oNUBGFSVxHy+pZxpAM88SZwmMwTZHcQK9I4VjDzdFKjm/a3ngS6XpvZpxnAv73bVZ4fRHISnOCkxst6xEvn0d2uZ7wMdOvRBfL/tQ0F+IZmL7a4V4UBBPuPANAGxjo45xM9ilKy94QUEnpaTPzj8EzOaVrn2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882453; c=relaxed/simple;
	bh=sCTX9KuTywRM/pWRYqSYFtiiuUiSaGUp7UzV1B5BGeE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hIvZFbX5thtdU9nK3L/qXfS+c2F9tbsBXqjbaN3+cSUCclN0shswROSwIm8KnJVwbes0/MQHlWl+o8icg8hXSc5AJ8E9Z8qB7/8veHjF3vxMWmoT4uhZKxuoMdDAxb1kyVxvFqi7512txOkl0rk7G1rQoWmj7drYr26filULXCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z5Y8iPty; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2qRowrdR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fkg8i3TO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1XvpnQg1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C54506006B;
	Tue, 23 Apr 2024 14:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713882450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K6b1flxTTrxOdv+q2tkFyEXERe9nDT45zxP7j+afeUI=;
	b=z5Y8iPtyjN1x3XkyagDdrcFLsX0ii57/iBnRLmsbF0sL5X4p2jKal1xz4M2W3wKyCWvXYc
	AS3wdTxKqp55mwpOkJgg7Nxle6pnHaP8/xqh0YGVOTrWVXHueJP2yAAQu/LUF9OmFWyn1Q
	1zDmZyZwOyjCNB7jUbarSl0f6Zck3KM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713882450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K6b1flxTTrxOdv+q2tkFyEXERe9nDT45zxP7j+afeUI=;
	b=2qRowrdRAGiiKmywVePCSVuFnvpambBS6xK/NowGwpYvHcC8BvoYJD11Lxv8/S9Jxbo5Pb
	SjVWQnhX07cZ4VAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713882448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K6b1flxTTrxOdv+q2tkFyEXERe9nDT45zxP7j+afeUI=;
	b=fkg8i3TO67ggAnsS2oYoWUMEwytWzSLRNfyx8m+8uGG4QZPu9jxcrAATB/gMlfrbHK8cWY
	Sy+4lBfo4xmlWS7fZICT8I+W0Nx0hysitjyNQ8DzHlRKopanjn2kv4QuWdY1RA/Sil8SpL
	DeJonSTodfanS80tfwUBUhVM9qlRZhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713882448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K6b1flxTTrxOdv+q2tkFyEXERe9nDT45zxP7j+afeUI=;
	b=1XvpnQg1T711xESPLAPi7TzL1moQ1rk4Vf4pMy0mqVjEsnnGq7xrmTJYKfL0xuNhTEDw8d
	FSNxGczKt89Al2Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 123EB13929;
	Tue, 23 Apr 2024 14:27:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nlbjOE/FJ2ZefAAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Tue, 23 Apr 2024 14:27:27 +0000
Date: Tue, 23 Apr 2024 16:27:24 +0200
From: Jean Delvare <jdelvare@suse.de>
To: linux-s390@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [PATCH RFC] s390/pci: Drop unneeded reference to CONFIG_DMI
Message-ID: <20240423162724.3966265a@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.92
X-Spam-Level: 
X-Spamd-Result: default: False [-3.92 / 50.00];
	BAYES_HAM(-2.62)[98.32%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email]

The S/390 architecture doesn't support SMBIOS, so CONFIG_DMI will
never be defined there. So we can simply omit these preprocessing
directives and speed up the build a bit.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
Niklas, you added these preprocessing directives as part of commit
81bbf03905aa ("s390/pci: expose a PCI device's UID as its index").
I do not understand the purpose. Am I missing something?

 arch/s390/pci/pci_sysfs.c |    4 ----
 1 file changed, 4 deletions(-)

--- linux-6.8.orig/arch/s390/pci/pci_sysfs.c
+++ linux-6.8/arch/s390/pci/pci_sysfs.c
@@ -156,7 +156,6 @@ static ssize_t uid_is_unique_show(struct
 }
 static DEVICE_ATTR_RO(uid_is_unique);
 
-#ifndef CONFIG_DMI
 /* analogous to smbios index */
 static ssize_t index_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
@@ -186,7 +185,6 @@ static struct attribute_group zpci_ident
 	.attrs = zpci_ident_attrs,
 	.is_visible = zpci_index_is_visible,
 };
-#endif
 
 static struct bin_attribute *zpci_bin_attrs[] = {
 	&bin_attr_util_string,
@@ -229,8 +227,6 @@ static struct attribute_group pfip_attr_
 const struct attribute_group *zpci_attr_groups[] = {
 	&zpci_attr_group,
 	&pfip_attr_group,
-#ifndef CONFIG_DMI
 	&zpci_ident_attr_group,
-#endif
 	NULL,
 };

-- 
Jean Delvare
SUSE L3 Support

