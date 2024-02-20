Return-Path: <linux-kernel+bounces-73394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A68885C1E9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB911C23410
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AE7768EE;
	Tue, 20 Feb 2024 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nMby2dQa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dvg7bYDI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nMby2dQa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dvg7bYDI"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1F9762EC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448329; cv=none; b=Yc/G9tLoX6zEydaJ0bM8g1a+sCQFd8BBFKaS2Lq6J8XWWkNCOrXdwPwjwC9RBRNFddrBo4BW1vG7VcGLY/5iQU/8KpUB/vEkLmvzPqJOa9etxHSADGwkfgvqYD8MQLAKe8dYBCrc4WzHIpNsbwb40k3HqNdWpC43q2PKk+gLtFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448329; c=relaxed/simple;
	bh=IL6IiPFaj8L1SHxsifDq30uFwnNpt+3POqEQFoB3w0c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CllSs5uV93wddHgAwJXE0HM67gqEYDD9j1D/DSfmNnaGDulX1qIQYE9kQabpiYIIo9o77C7lI1cjlmqwRTN4Avt4U42pHJGpCJ2N4Hut4uBpx2ATn6FMn2MyHQ4ALiNfz06+e8Z9utRLPttw2xSHp/+xZABX1NNy3g+Kha07kT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nMby2dQa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dvg7bYDI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nMby2dQa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dvg7bYDI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1F2AE1F45F;
	Tue, 20 Feb 2024 16:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708448325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IbsSj4kPNKqeufwtGIRDxU3H/ANejP0NGaedjXyeBmw=;
	b=nMby2dQaZBQLJ+hSqHNyWRpkovG6YoED+MQrK/wcTKjs9DdXocgp2HkVkh4jL47opqZ59s
	alu0O3v/Hb0GotorzSTNYYIeTze3It2JSzrg3gItlPQW2SSRUgYaiH1LVLjKRv3tt2ADHB
	CreuBVUFqlNBYJRdGs83aQqMhdAdz/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708448325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IbsSj4kPNKqeufwtGIRDxU3H/ANejP0NGaedjXyeBmw=;
	b=Dvg7bYDI7jBbBbXPUcFK9RGsvmeh1YwOoTjCgEljDYbW10kokyzrfXfZn9ztXWz5ygA1b4
	rBVq+eb2yvGN+pBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708448325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IbsSj4kPNKqeufwtGIRDxU3H/ANejP0NGaedjXyeBmw=;
	b=nMby2dQaZBQLJ+hSqHNyWRpkovG6YoED+MQrK/wcTKjs9DdXocgp2HkVkh4jL47opqZ59s
	alu0O3v/Hb0GotorzSTNYYIeTze3It2JSzrg3gItlPQW2SSRUgYaiH1LVLjKRv3tt2ADHB
	CreuBVUFqlNBYJRdGs83aQqMhdAdz/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708448325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IbsSj4kPNKqeufwtGIRDxU3H/ANejP0NGaedjXyeBmw=;
	b=Dvg7bYDI7jBbBbXPUcFK9RGsvmeh1YwOoTjCgEljDYbW10kokyzrfXfZn9ztXWz5ygA1b4
	rBVq+eb2yvGN+pBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC4FD139D0;
	Tue, 20 Feb 2024 16:58:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w9cGOUTa1GVKXQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 20 Feb 2024 16:58:44 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 0/3] cleanup of SLAB_ flags
Date: Tue, 20 Feb 2024 17:58:24 +0100
Message-Id: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADDa1GUC/x3MMQqAMAxA0atIZgO2VFGvIg41Rg2UKg2KIN7d4
 viG/x9QTsIKffFA4ktU9phhygJo83FllDkbbGVdZU2HGvyEFNjH88Al+FWR2sY5UzNRy5DDI/E
 i9z8dxvf9AAO1YOtkAAAA
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Zheng Yejian <zhengyejian1@huawei.com>, 
 Xiongwei Song <xiongwei.song@windriver.com>, 
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
 Vlastimil Babka <vbabka@suse.cz>, Steven Rostedt <rostedt@goodmis.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1607; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=IL6IiPFaj8L1SHxsifDq30uFwnNpt+3POqEQFoB3w0c=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBl1No4DszrrX8bOb0HuwiWoDUq2/UBLf1izr1zC
 ofjfOXIfueJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZdTaOAAKCRC74LB10kWI
 mtb4B/9PLg3CcTI1ueE6xDEvkINOsywJ7L7b+M9ykvZu7hP6O09Z/ODodo42j2o18006IrzeLM9
 ag2Hea+OS2X0SZncBYIUydENSmTMdmaI3hrW9oVadH0sKZb/Qme3icKO4fA/HIomAgPOOsKtFmE
 CgkjqAg4gH4fDyXCMsE0h7MkFmzK/MWB9X3uunAR+2BQ7LQxvy7Tqx01bDiVwkYTNVyms4hkHqv
 x0Ih7n/T+W3OIM3GL9rgJ0opFSSsFyfVDrrzWPwfKjOgpAlDhiRcroCYFTW/agKdeoDMNY0CE6f
 Lq3obltIVTB/uCWeakaSxiv9BEpNMyUQlvAKxTZtsw483eXT
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLqdadssyy1w6u3twx3pq4jyny)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[20];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FREEMAIL_TO(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,arm.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

This started by the report that SLAB_MEM_SPREAD flag is dead (Patch 1).
Then in the alloc profiling series we realized it's too easy to reuse an
existing SLAB_ flag's value when defining a new one, by mistake.
Thus let the compiler do that for us via a new helper enum (Patch 2).
When checking if more flags are dead or could be removed, didn't spot
any, but found out the SLAB_KASAN handling of preventing cache merging
can be simplified since we now have an explicit SLAB_NO_MERGE (Patch 3).

The SLAB_MEM_SPREAD flag is now marked as unused and for removal, and
has a value of 0 so it's a no-op. Patches to remove its usage can/will
be submitted to respective subsystems independently of this series - the
flag is already dead as of v6.8-rc1 with SLAB removed. The removal of
dead cpuset_do_slab_mem_spread() code can also be submitted
independently.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Vlastimil Babka (3):
      mm, slab: deprecate SLAB_MEM_SPREAD flag
      mm, slab: use an enum to define SLAB_ cache creation flags
      mm, slab, kasan: replace kasan_never_merge() with SLAB_NO_MERGE

 include/linux/kasan.h |  6 ----
 include/linux/slab.h  | 86 +++++++++++++++++++++++++++++++++++++--------------
 mm/kasan/generic.c    | 16 +++-------
 mm/slab.h             |  1 -
 mm/slab_common.c      |  2 +-
 mm/slub.c             |  6 ++--
 6 files changed, 71 insertions(+), 46 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240219-slab-cleanup-flags-c864415ecc8e

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


