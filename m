Return-Path: <linux-kernel+bounces-143455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ED08A3961
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD3B2848E6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1C229AB;
	Sat, 13 Apr 2024 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="I8NcdD/e";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="I8NcdD/e"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19C037E;
	Sat, 13 Apr 2024 00:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712968380; cv=none; b=mTuQwrHETK3iNwA+3iShWdaAaJg/mN0xUYcKGKQhzQvvYBguEq+I8X+3wnEZrqdHqT3VR3hMnDhxHE8Noco17QZqLIDXAI8J2MTmhl7wgZ9QXabs/HsIPJjtn094g9DHEVNxSbULuuR+VdC4dGNl6+ULLIMjl8ZF14z50acfPBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712968380; c=relaxed/simple;
	bh=coyk5nt8YNwTSTgY3qFZSAF1qy56yQEwiyGek0JLb04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gBaq8Ja/qsNL8xOC6HCFPz/HjpQyAY3PPQpHBULFuo/qVDD8hfaqylzApyGwaaaG9weH2aebFCDiExQUPE5W1zydMfKOrjxiuJGnh9YyuhGoU1fhC19H6v53PbeogRZdclWGS5X82ePKI8SUiDO2WRljoK05gHR0PhgEdgfn9f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=I8NcdD/e; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=I8NcdD/e; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DAC6022C4A;
	Sat, 13 Apr 2024 00:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712968375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ga9BDy950sqrkymKo/DX0soSuDFkOI9AzOuH62JvhYw=;
	b=I8NcdD/e1cLEL+nxIyxQnHqKpsUPCfjG7jRi48rRO496Fg9sqJd96AMINZ//aK1SXlaaBk
	yx4TdpyriWgtaSgGl3g1WhSlTJSfzkL68Mk4dsPaxMgqIS5ivgz8XTOgNTqZPx+CdO/iOO
	ZzXxGKsXCAQYTDO6ttOJiJVn4fGySh8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712968375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ga9BDy950sqrkymKo/DX0soSuDFkOI9AzOuH62JvhYw=;
	b=I8NcdD/e1cLEL+nxIyxQnHqKpsUPCfjG7jRi48rRO496Fg9sqJd96AMINZ//aK1SXlaaBk
	yx4TdpyriWgtaSgGl3g1WhSlTJSfzkL68Mk4dsPaxMgqIS5ivgz8XTOgNTqZPx+CdO/iOO
	ZzXxGKsXCAQYTDO6ttOJiJVn4fGySh8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE3361368B;
	Sat, 13 Apr 2024 00:32:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /MuCKrfSGWZhGAAAD6G6ig
	(envelope-from <jeffm@suse.com>); Sat, 13 Apr 2024 00:32:55 +0000
Received: from localhost.localdomain (silencio.work.jeffm.io [192.168.111.21])
	by mail.work.jeffm.io (Postfix) with ESMTPS id 52F881014592;
	Fri, 12 Apr 2024 20:32:50 -0400 (EDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id B6E721079455; Fri, 12 Apr 2024 20:22:54 -0400 (EDT)
From: Jeff Mahoney <jeffm@suse.com>
To: Wayne Lin <Wayne.Lin@amd.com>,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jeff Mahoney <jeffm@suse.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/mst: Fix NULL pointer dereference in drm_dp_add_payload_part2 (again)
Date: Fri, 12 Apr 2024 20:22:52 -0400
Message-ID: <20240413002252.30780-1-jeffm@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: 0.20
X-Spam-Level: 
X-Spamd-Result: default: False [0.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[25.85%];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,ffwll.ch,suse.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

Commit 54d217406afe (drm: use mgr->dev in drm_dbg_kms in
drm_dp_add_payload_part2) appears to have been accidentially reverted as
part of commit 5aa1dfcdf0a42 (drm/mst: Refactor the flow for payload
allocation/removement).

I've been seeing NULL pointer dereferences in drm_dp_add_payload_part2
due to state->dev being NULL in the debug message printed if the payload
allocation has failed.

This commit restores mgr->dev to avoid the Oops.

Fixes: 5aa1dfcdf0a42 ("drm/mst: Refactor the flow for payload allocation/removement")
Cc: stable@vger.kernel.org
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 03d528209426..3dc966f25c0c 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -3437,7 +3437,7 @@ int drm_dp_add_payload_part2(struct drm_dp_mst_topology_mgr *mgr,
 
 	/* Skip failed payloads */
 	if (payload->payload_allocation_status != DRM_DP_MST_PAYLOAD_ALLOCATION_DFP) {
-		drm_dbg_kms(state->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
+		drm_dbg_kms(mgr->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
 			    payload->port->connector->name);
 		return -EIO;
 	}
-- 
2.44.0


