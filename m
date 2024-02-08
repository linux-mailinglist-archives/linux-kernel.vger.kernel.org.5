Return-Path: <linux-kernel+bounces-57653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870B184DBD2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9FE31C24C84
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2E671B46;
	Thu,  8 Feb 2024 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nY08ObA9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355D271B58;
	Thu,  8 Feb 2024 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381934; cv=none; b=iBQOgW5CcxPy1nLu58I3GFl8OCwbtmc/Lk7VrKJqOGM4TO615LPMpiz7nOjxtAkJ2n0oH48XiBbIK79A1efMpd5q/6wK7teAiFWs9pph174Sz6K1cG2lpe3a7j7NRI1H4o0AVvuy+IsF9k0LKt/K+8clJMf+cwZIgzT4LuofA2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381934; c=relaxed/simple;
	bh=WGjy4Cm0cEOn+F+u0AjX0H2bpY30XTKx3DCJD60T9WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsCRccDtfe1zXF6GNw22OxvLl5aJsaA+Yi7Io+lsoXYDV2PNSH8bV34MQiH9EyJN7183KkeVgBR0hsbioF9iZLKwbASYL1eSrOugjat2XjT4sXVKo7R4/lWvzelhp+U/v0/xGoxgHu2GZZgDncsjiYSH7YUck6asCgAeMnbkqR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nY08ObA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69997C433F1;
	Thu,  8 Feb 2024 08:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707381933;
	bh=WGjy4Cm0cEOn+F+u0AjX0H2bpY30XTKx3DCJD60T9WI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nY08ObA9mT1r7BdDI4+PYZMJ5u34xPUmGzv18dfsF8Em8732jTJOMbNbTyoN87pF9
	 fc8fw9r6k5sKza1jJjXSIT5b/1FhiNa9UvFTNwCYHUVBjFyPU3R7BrVKPfOvtyyVZO
	 to0fM5gFUcrWWbx7m5NaeEa0mxxzeRg/xWziXcGG7XbyIwkt4M4nT78CcLTMOca3e3
	 z6vd+9tRfdOHtqKky+XLcZDol0BzBUbyqoMoVtt52FCv/dRhqR/3z6OtBi1laxffHx
	 BshFNRs59+jDW671Jzz16Zxz50WXaAoYuCER6s2pj42+1x8utsSZXLmnGiVE9EoBYw
	 5c41mD3T6eUaQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH 07/10] scsi: aic7xxx: aicasm: Trivial: Remove trailing whitespace
Date: Thu,  8 Feb 2024 08:44:19 +0000
Message-ID: <20240208084512.3803250-8-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240208084512.3803250-1-lee@kernel.org>
References: <20240208084512.3803250-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removing out of need rather than want.  I wish to make proper changes to
this file, but my editor is insistent on removing whitespace on save.
Rather than go down the rabbit hole of debugging my editor right now,
I'd rather stay productive.  So, out it comes!

EDIT: Found it.  Looks like 5a602de99797b ("Add .editorconfig file for
basic formatting") now forces editors to trim whitespace.

Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: Hannes Reinecke <hare@suse.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
---
 drivers/scsi/aic7xxx/aicasm/aicasm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aicasm/aicasm.c b/drivers/scsi/aic7xxx/aicasm/aicasm.c
index cd692a4c5f857..8d995186e557a 100644
--- a/drivers/scsi/aic7xxx/aicasm/aicasm.c
+++ b/drivers/scsi/aic7xxx/aicasm/aicasm.c
@@ -132,7 +132,7 @@ main(int argc, char *argv[])
 	/* Set Sentinal scope node */
 	sentinal = scope_alloc();
 	sentinal->type = SCOPE_ROOT;
-	
+
 	includes_search_curdir = 1;
 	appname = *argv;
 	regfile = NULL;
@@ -553,7 +553,7 @@ output_listing(char *ifilename)
 
 		if (func_values == NULL)
 			stop("Could not malloc", EX_OSERR);
-		
+
 		func_values[0] = 0; /* FALSE func */
 		func_count--;
 
@@ -561,13 +561,13 @@ output_listing(char *ifilename)
 		 * Ask the user to fill in the return values for
 		 * the rest of the functions.
 		 */
-		
-		
+
+
 		for (cur_func = SLIST_FIRST(&patch_functions);
 		     cur_func != NULL && SLIST_NEXT(cur_func, links) != NULL;
 		     cur_func = SLIST_NEXT(cur_func, links), func_count--) {
 			int input;
-			
+
 			fprintf(stdout, "\n(%s)\n", cur_func->symbol->name);
 			fprintf(stdout,
 				"Enter the return value for "
@@ -751,7 +751,7 @@ cs_alloc()
 	if (new_cs == NULL)
 		stop("Unable to malloc critical_section object", EX_SOFTWARE);
 	memset(new_cs, 0, sizeof(*new_cs));
-	
+
 	TAILQ_INSERT_TAIL(&cs_tailq, new_cs, links);
 	return new_cs;
 }
@@ -766,7 +766,7 @@ scope_alloc()
 		stop("Unable to malloc scope object", EX_SOFTWARE);
 	memset(new_scope, 0, sizeof(*new_scope));
 	TAILQ_INIT(&new_scope->inner_scope);
-	
+
 	if (SLIST_FIRST(&scope_stack) != NULL) {
 		TAILQ_INSERT_TAIL(&SLIST_FIRST(&scope_stack)->inner_scope,
 				  new_scope, scope_links);
-- 
2.43.0.594.gd9cf4e227d-goog


