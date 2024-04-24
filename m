Return-Path: <linux-kernel+bounces-157703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB0B8B14D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF821F23E67
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC32115689A;
	Wed, 24 Apr 2024 20:44:32 +0000 (UTC)
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85191CF9A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.97.99.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713991472; cv=none; b=rSXkWLqC2r72DvovmOIq6cL45lkM0JZU3cwTe72fz1CuXd7BAeae1dr+NS630p1/HfCu4lXToeCZG+K5/rdyp9aBxqyagw7MG/pEp/TpypLWyPBVecqa48K2t7vTym1sURja16a98d89o0a23w7EC5DiVuxobPQ89kgQNAzHIYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713991472; c=relaxed/simple;
	bh=wPiZ4YfDBrjkq8EOtxQfcqvnjeuqIjnT0CsY8Wv3lfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IQInIxhKmBw0zrT0a8BzxxqPiUjdiN41DGo0tGvKzBieKYnShYJ4HC8RnD1wt791l3jGvfDYgnI5xGO24IyeZXVtIsi2+9Z1MSwbeUcZL6yRo6ENUHYXxWkX/lUZc+Rg5saldK5YjPPnK4NII6ky3OaMxqN7JopbLNS+cP/ZSRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; arc=none smtp.client-ip=3.97.99.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTPS
	id zZQArsKDq2Ui5zjTbreQf3; Wed, 24 Apr 2024 20:44:23 +0000
Received: from webber.adilger.int ([70.77.200.158])
	by cmsmtp with ESMTP
	id zjTarXbbcByQrzjTarsQi2; Wed, 24 Apr 2024 20:44:23 +0000
X-Authority-Analysis: v=2.4 cv=UOF+Hzfy c=1 sm=1 tr=0 ts=66296f27
 a=0Thh8+fbYSyN3T2vM72L7A==:117 a=0Thh8+fbYSyN3T2vM72L7A==:17 a=RPJ6JBhKAAAA:8
 a=QQdngafKVaWhNDnW0jYA:9 a=fa_un-3J20JGBB2Tu-mn:22
From: Andreas Dilger <adilger@dilger.ca>
To: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v2 RESEND] checkpatch: ignore deleted lines for comment context
Date: Wed, 24 Apr 2024 14:44:19 -0600
Message-Id: <20240424204419.98942-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMuoxvXHk1erK7k15w7kBQNnrO7HOExXPbc7cXMtHIImaB36sP6XYQgOi/ymzTfYMdNe9zxHrPocj9oN0u0N04ZuLmnsUOL6MXT/fu8ktgkGwFKRAgBm
 YZAfI4rqDQgJSwE4IFg98szDsz8Q4WwntKRD9pL8MmHzydbq8c5Aiom24rTAN8330i1VoAEHaK2njBceU2kEmQOhcO12oOKAxGi/dSSeTfhA7uTTp2DeG52f
 KvPvLdv5u6prx/7+9rDNfHlTbnZTuQne32noeYX11p1jK8va1qf/opsNGAC0OVnF

Don't consider lines being removed by a patch as part of the context.
Otherwise, false "WARNING: memory barrier without comment" and similar
warnings can be reported when a comment exists on the previous line.

For example, a change like below was previously incorrectly flagged
as not having a comment because ctx_locate_comment() considers the
modified '-' line not to be a comment:

	/* matched by smp_store_release() in some_function() */
 -	if (smp_load_acquire(&list->tail) == head))
 +	if (smp_load_acquire(&list->tail) == head) && flags == 0)

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
v1->v2: don't update the #warn line

 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..80691e3e3ef2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1974,6 +1974,7 @@ sub ctx_locate_comment {
 	for (my $linenr = $first_line; $linenr < $end_line; $linenr++) {
 		my $line = $rawlines[$linenr - 1];
 		#warn "           $line\n";
+		next if ($line =~ /^-/); # ignore lines removed by patch
 		if ($linenr == $first_line and $line =~ m@^.\s*\*@) {
 			$in_comment = 1;
 		}
-- 
2.25.1


