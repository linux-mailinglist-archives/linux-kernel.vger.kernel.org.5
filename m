Return-Path: <linux-kernel+bounces-37621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD9783B2AC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD90B26EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1BE133425;
	Wed, 24 Jan 2024 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bsa8IUuC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EOYy6Szk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bsa8IUuC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EOYy6Szk"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BDD7C091;
	Wed, 24 Jan 2024 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126448; cv=none; b=g7rms3m3ViODiXT95YEX7OR4B5TQ4S2/wtFQfATMBdLco5KS6eO3u4JkQ0letXO5Hw0Es+gMp9N63kAvjHxchmyh8X1F3uxTUN/M8dah3TN/9DLn9V3EYzGXVvhsTezG7USdEyownKGdpTPgIRpjuo5LMt8UduNXqGfg2qDsZhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126448; c=relaxed/simple;
	bh=9WDyjkO8pqVbP2nVSHovZI6utBCUXWI/CXKQZzAtRR4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d13nOg7ETFILYbL4E4IFa6ucnb5gheu1NcaCEqyuUaPekPCLJu8jpFOMvqxiKAwbAjaQ5cgVoD5LRRDZWCwNbRCOlYomN0fmgjcMJ2hCWw1fkfRWT8mRu3kl7pkT6JOJ6uxsd2bM070BLJvhOd4wZo3DG6UPxikFgy14MftVDc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bsa8IUuC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EOYy6Szk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bsa8IUuC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EOYy6Szk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E6FF91FD86;
	Wed, 24 Jan 2024 20:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706126438;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9WDyjkO8pqVbP2nVSHovZI6utBCUXWI/CXKQZzAtRR4=;
	b=bsa8IUuCyMQj1+5ItOzpNLdT3qdq3WAbbs74m+bMYKF3/aEFHrCdTg/aopMIA1+P5rr7F7
	OXA9djRAkR3q1QnmreJnFedun0RcykvGehlArbCGiDdNeWFsg1uRHZPiuPnjbAIJJDQYRm
	ni+6hgt8WFYyXsGO3BqM7u7UOsNyl0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706126438;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9WDyjkO8pqVbP2nVSHovZI6utBCUXWI/CXKQZzAtRR4=;
	b=EOYy6Szke58Zr9Lku7VcdziX/RE4c9vZQ+FTkLpmeNUfbRUUnifytgPO2APKmdhByCrJcF
	gNEs5G4mZat2c2Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706126438;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9WDyjkO8pqVbP2nVSHovZI6utBCUXWI/CXKQZzAtRR4=;
	b=bsa8IUuCyMQj1+5ItOzpNLdT3qdq3WAbbs74m+bMYKF3/aEFHrCdTg/aopMIA1+P5rr7F7
	OXA9djRAkR3q1QnmreJnFedun0RcykvGehlArbCGiDdNeWFsg1uRHZPiuPnjbAIJJDQYRm
	ni+6hgt8WFYyXsGO3BqM7u7UOsNyl0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706126438;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9WDyjkO8pqVbP2nVSHovZI6utBCUXWI/CXKQZzAtRR4=;
	b=EOYy6Szke58Zr9Lku7VcdziX/RE4c9vZQ+FTkLpmeNUfbRUUnifytgPO2APKmdhByCrJcF
	gNEs5G4mZat2c2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 748AE1333E;
	Wed, 24 Jan 2024 20:00:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iLkFGWZssWVAYgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 24 Jan 2024 20:00:38 +0000
Date: Wed, 24 Jan 2024 21:00:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ltp@lists.linux.it
Subject: bcachefs fails to mount loop device on kernel
Message-ID: <20240124200032.GA343522@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[36.87%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.70

Hi all,

bcachefs fails to mount loop device on kernel on both 6.7 and 6.8.0-rc1.
Is mounting loop even supported?

dd if=/dev/zero of=test_file bs=400M count=1
losetup /dev/loop0 test_file
mkfs.bcachefs /dev/loop0

mount -t bcachefs -o loop test_file /mnt
=> Unknown command /dev/loop0

modprobe bcachefs
mount -t bcachefs -o loop test_file /mnt
=> mount: /mnt: failed to setup loop device for test_file.

mount -t bcachefs test_file /mnt
=> Unknown command test_file

mount -t bcachefs -o loop /dev/loop0 /mnt
=> Unknown command /dev/loop1

mount -t bcachefs /dev/loop0 /mnt
=> Unknown command /dev/loop0

bcachefs mount /dev/loop0 /mnt
=> Unknown command mount

Thanks for info.

Kind regards,
Petr

