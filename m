Return-Path: <linux-kernel+bounces-166727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267678B9E95
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12AF1F211FF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC03C15EFD0;
	Thu,  2 May 2024 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="rE80tuXV"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6690615D5BE
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667451; cv=none; b=r3KVfhMoR6ulHUzgHeDaH8XaiafFS9ujmETPXev0IPdlRwxdcVCe3QisLoKhA/qm+kwr5kW8V2d8Z+bzN1lsar0K4EY1KERwR9YKwpMryYKmWCurlfNi0/3MtaTMBNq/8/Rd4qdzwy2byvq4vbwVBypfg5lUl9HnzX/W+9ztq9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667451; c=relaxed/simple;
	bh=4zlpv+DhkaBiyYsvVgDDjEkJDrbSWHV2ilnz+UjRAb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kNo7U1vxv7wJ2KZbGo3rUQAWyGmlVy4c+xywrwbIIyqqK6OwWew0dKn5YxtGEcpfeObmL3o+LwsUj5EZyBqqxulk2dfhgOWBelyj1XwO198w+ShQ3L8CcYHkSNSN3DV89ERlaAXDm6ixz+ijxIUfZrayPLxNAvSdsZDAzIUjUC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=rE80tuXV; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=BWNBfZG7kizyb6cHFecEfxf40LvY/HI+GlksidfEVfM=; b=rE80tuXVfWce54OV
	ILx3QP/PdlOSWIjm0v6HLcqRL3+4rghrm1hW0VDOkiqjrddRzClSEf3oGdW8qyzDJ/EeMxgUoTYU5
	ju29HqyrKPHPH6/fAY0mStlhFpVCc3X2gWCpK/pOS9lXfx1wUaOMDV2Jy7meB4cEnoZvHtZ4W/0Rn
	bMJ5VocIDOyrPSL6TSaRaGFaQK1wcXwrrX5g0nyP1LQ/8jOrz8jbTY8H5Y1pdOJJSUajpKpU0Zfe/
	GIpzxWv3V/o0yotn7tbP14HttqXnoQyctL2ikQdPUVKYkN5AOOIAVsQ9qQYuh1Xg3cTqB1DvRY6k9
	/GP6Bagc8bL7GgqTTQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s2Yfp-004ILZ-1S;
	Thu, 02 May 2024 15:48:41 +0000
From: linux@treblig.org
To: sudipm.mukherjee@gmail.com
Cc: arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	linux-parport@lists.infradead.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/3] parport: Cleanup some pre-devmodel code
Date: Thu,  2 May 2024 16:48:20 +0100
Message-ID: <20240502154823.67235-1-linux@treblig.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

There are some remenants of the pre-devmodel code
still in the parport drivers; try and clean some of them out.

This series should have no visible change, all the drivers
already use the devmodel, it's just removing the flags
that say that, and cleaning out no longer used function pointers.
(To me the most useful bit is removing the no longer used
'attach' pointer, so if you've got code that's trying to use
it you'll get educated).

Trivially tested in qemu, I can still write to the lp;

Also checked with grep -r 'struct parport_driver' . -A 9
to see if I've missed any.

(I found this while dragging the out-of-tree ppscsi code
into working on head, so that I could use my prehistoric
HP PP scanner)

Dave

Dr. David Alan Gilbert (3):
  parport: Remove 'drivers' list
  parport: Remove attach function pointer
  parport: Remove parport_driver.devmodel

 drivers/ata/pata_parport/pata_parport.c  | 1 -
 drivers/auxdisplay/ks0108.c              | 1 -
 drivers/auxdisplay/panel.c               | 1 -
 drivers/char/lp.c                        | 1 -
 drivers/char/ppdev.c                     | 1 -
 drivers/i2c/busses/i2c-parport.c         | 1 -
 drivers/input/joystick/db9.c             | 1 -
 drivers/input/joystick/gamecon.c         | 1 -
 drivers/input/joystick/turbografx.c      | 1 -
 drivers/input/joystick/walkera0701.c     | 1 -
 drivers/input/serio/parkbd.c             | 1 -
 drivers/net/hamradio/baycom_epp.c        | 1 -
 drivers/net/hamradio/baycom_par.c        | 1 -
 drivers/net/plip/plip.c                  | 1 -
 drivers/parport/daisy.c                  | 1 -
 drivers/parport/share.c                  | 9 ---------
 drivers/pps/clients/pps_parport.c        | 1 -
 drivers/pps/generators/pps_gen_parport.c | 1 -
 drivers/scsi/imm.c                       | 1 -
 drivers/scsi/ppa.c                       | 1 -
 drivers/spi/spi-butterfly.c              | 1 -
 drivers/spi/spi-lm70llp.c                | 1 -
 include/linux/parport.h                  | 6 ------
 sound/drivers/mts64.c                    | 1 -
 sound/drivers/portman2x4.c               | 1 -
 25 files changed, 38 deletions(-)

-- 
2.44.0


