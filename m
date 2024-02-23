Return-Path: <linux-kernel+bounces-78975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384CD861B95
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4F51C22A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10A612CD8B;
	Fri, 23 Feb 2024 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2pgIZN7M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w0RTxYkq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2pgIZN7M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w0RTxYkq"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D577142649
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712863; cv=none; b=EpXDQZf5AS5R1bG4rhna1u+ezhBlRcLLWBRL2asWW8jXR7awEH/vuV75q+im4d3ltvnIIp6sFPU2eRyl/ggiwCmM3ijUO9eF5FT/Mpf8fu4bpIavj9dlaKT+NrUCROe18nRVEdV4r/MTLKfwkRgvm9rL9vikiz1b0jK7qZLYW0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712863; c=relaxed/simple;
	bh=XEJyJuE3iDgp5Yng6UletIUmKt9m1Y+5GGOt7cPegGw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CZwr7ju6VWuOvNFreDtbqeuGJZ71zh3765M276V4TMPq9HEY3wIY5qWbusXzPx5A5bTPWqj5isMWTVrBEgZv3jtCYo6l4a09AkuqxLT60zJ5zoNsUmNhXzU/AfSnpK6GPGkfqTT8gIFRp8BeV8SO82iOLxwralgBKGopUukpNAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2pgIZN7M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w0RTxYkq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2pgIZN7M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w0RTxYkq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 039261FC26;
	Fri, 23 Feb 2024 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708712859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jFPvU6fb5RZSwRXjaHsGExL2vu2XY+R4lmvjGVLfKDA=;
	b=2pgIZN7MM6mn08ivR/pl0Z/SZbZJi+SVFITbXVbV55zjlyh+axlmtA28Ob3T5Wdo43hsTc
	MKDx/gz4LSfNa/5h9N8NzZGNLvmzHNdGfevCe5+VERaRPpu/BH9zQJQfYbUAXKwxrjfqp8
	MKITDItNrlYt6Pph2j6R8N6SwX8PZn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708712859;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jFPvU6fb5RZSwRXjaHsGExL2vu2XY+R4lmvjGVLfKDA=;
	b=w0RTxYkqn6lPsTMR61gqIHfzY/LejF3hVLRoTXu4qhD3YUDEjgNJUHSlB5tq92IkkJt3NX
	IFh9lHVDsmV/ckCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708712859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jFPvU6fb5RZSwRXjaHsGExL2vu2XY+R4lmvjGVLfKDA=;
	b=2pgIZN7MM6mn08ivR/pl0Z/SZbZJi+SVFITbXVbV55zjlyh+axlmtA28Ob3T5Wdo43hsTc
	MKDx/gz4LSfNa/5h9N8NzZGNLvmzHNdGfevCe5+VERaRPpu/BH9zQJQfYbUAXKwxrjfqp8
	MKITDItNrlYt6Pph2j6R8N6SwX8PZn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708712859;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jFPvU6fb5RZSwRXjaHsGExL2vu2XY+R4lmvjGVLfKDA=;
	b=w0RTxYkqn6lPsTMR61gqIHfzY/LejF3hVLRoTXu4qhD3YUDEjgNJUHSlB5tq92IkkJt3NX
	IFh9lHVDsmV/ckCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBEDE133DC;
	Fri, 23 Feb 2024 18:27:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zj5DMZrj2GUaTQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 23 Feb 2024 18:27:38 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 0/3] cleanup of SLAB_ flags
Date: Fri, 23 Feb 2024 19:27:16 +0100
Message-Id: <20240223-slab-cleanup-flags-v2-0-02f1753e8303@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIXj2GUC/22Nyw6CMBBFf4XM2jFtKc+V/2FY1DpAE1JIRxqV8
 O9W4tLlOck9dwOm4IihzTYIFB272SdQpwzsaPxA6O6JQQmlhZIN8mRuaCcyfl2wn8zAaOtSa1m
 QtTVBGi6Bevc8otcu8ej4MYfX8RHl1/5ySvzLRYkCqSwqyqu80dpceGU62zd0+75/ANpg8i6yA
 AAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=XEJyJuE3iDgp5Yng6UletIUmKt9m1Y+5GGOt7cPegGw=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBl2OOPG1gBtDkksy5t20lOzP2N4CSXyxrsDwd0s
 01QGR/m+zCJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZdjjjwAKCRC74LB10kWI
 mmavB/9y5AI6D6IRww4XMiiwjjYlhMmza4+TL9mAHyfVi8XpuIwqg006twc5K90zh55wDZTaOMV
 5x2bQLz3DZ8wXClbIqMwagmHpF2COF6dhzwEPi2sYkklX+d1vWOafBnlw0oA+wNbl3Wb059yLog
 TbRNeQ1TyL1AVvyvYt+Ad2EqZNpwdPhc/ejFwHhqlZrpMkRH/GXRNOT6xfTnsZg8uFc84q/kDSH
 50sbJijMHg56BIQrZ77wlMEX+EX2c8zmFm7r8Ij14CR5zBNHudZ0y+EbwZBneWYQx+/Wrzocvf8
 K1ZPa0fBU96x0wOYdNb8eg/g24hvX4ekw5rDFhHwTp+wFv6p
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2pgIZN7M;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=w0RTxYkq
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLycmwa99sdzp837p77658kns5)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,arm.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[20];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -1.51
X-Rspamd-Queue-Id: 039261FC26
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
Changes in v2:
- Collect R-b, T-b (thanks!)
- Unify all disabled flags's value to a sparse-happy zero with a new macro (lkp/sparse).
- Rename __SF_BIT to __SLAB_FLAG_BIT (Roman Gushchin)
- Rewrod kasan_cache_create() comment (Andrey Konovalov)
- Link to v1: https://lore.kernel.org/r/20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz

---
Vlastimil Babka (3):
      mm, slab: deprecate SLAB_MEM_SPREAD flag
      mm, slab: use an enum to define SLAB_ cache creation flags
      mm, slab, kasan: replace kasan_never_merge() with SLAB_NO_MERGE

 include/linux/kasan.h |  6 ----
 include/linux/slab.h  | 97 ++++++++++++++++++++++++++++++++++++---------------
 mm/kasan/generic.c    | 22 ++++--------
 mm/slab.h             |  1 -
 mm/slab_common.c      |  2 +-
 mm/slub.c             |  6 ++--
 6 files changed, 79 insertions(+), 55 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240219-slab-cleanup-flags-c864415ecc8e

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


