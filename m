Return-Path: <linux-kernel+bounces-69283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE4285869C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB4528461C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F5E13957E;
	Fri, 16 Feb 2024 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SM6rjcwx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2BC13849D;
	Fri, 16 Feb 2024 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708114745; cv=none; b=XONPX9qSD3wyG437xNs2GaJK7bVz6iSfXq3P3jhgxwfoCbak2zFVgVD9sWM2YaIyNGCeEV0ovICa2+I7SjbZfiD9gCCJ1ebgtLIr7guZBqdHSzvNch5n4XLlw3UQ1MKbrJCpJKFpBGFiwJk0/Ku70q9Ft9F3XsqAqDcEPLKvDLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708114745; c=relaxed/simple;
	bh=6eqb8z+YRD+7o3nqKcv62mbMgN1UXlnx1IdOEL7t4zA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qPH/qWRxJU6FQ8M9aMsWXR9MCcaZbFSal/Cix0eISjZgOM7MXL508yjwlIre2RtEifGZUl7tPD5ccAn3Z37Fe4bzzomIAmsblCmhjpk5dTBGSWg8x+0Ppw26Nf4vROle9UQ0sKYvK2oPotoUiGeWIveZ+I0TWVTkgsM0/1QCyNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SM6rjcwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748E7C433F1;
	Fri, 16 Feb 2024 20:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708114744;
	bh=6eqb8z+YRD+7o3nqKcv62mbMgN1UXlnx1IdOEL7t4zA=;
	h=From:To:Cc:Subject:Date:From;
	b=SM6rjcwxl2cx8YGTIqP3rCYMjvxxdPdK/I8JZSGRcnknxVW6bSUTXCMypB20ExxHx
	 GHX2dvZ1k5letr3+VsGFue3lsqLWshN0HgHmmKsGoXYlrwXHcmySPQC29l7ynMFbj0
	 YGdwi/dbpY4q1R8FGCocOvaCifeDO+fNjDSjFd17r2tWPyO0o91IPdIPNSs+rnnO1H
	 0cpVxulmw9LoWCURNDFNrqc2a3NSmO9/vJVK7heKoP93UFQ/Mw18CzcmXPg9exxubH
	 DyAdJ4oWAT9rYQZcC8YlJHpXJvXMvg9/Kn3Iu36uXUEuVSB7Hs0hxNsheTWDSAfug2
	 ApJ+7sdQ/3pJQ==
From: SeongJae Park <sj@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: SeongJae Park <sj@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Set the field name for subsystem profile section
Date: Fri, 16 Feb 2024 12:19:02 -0800
Message-Id: <20240216201902.10095-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subsystem profile section entry identifier is not having its field name
that can be parsed by maintainers_include.py, unlike other sections
which have their own human-readable field names.  As a result, profile
sections on rendered rst file is having weird name, 'P:'.  Set the field
name as 'Subsystem Profile'.

Fixes: 4699c504e603 ("Maintainer Handbook: Maintainer Entry Profile")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..25fa30bec35f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24,7 +24,7 @@ Descriptions of section entries and preferred order
 	   filing info, a direct bug tracker link, or a mailto: URI.
 	C: URI for *chat* protocol, server and channel where developers
 	   usually hang out, for example irc://server/channel.
-	P: Subsystem Profile document for more details submitting
+	P: *Subsystem Profile* document for more details submitting
 	   patches to the given subsystem. This is either an in-tree file,
 	   or a URI. See Documentation/maintainer/maintainer-entry-profile.rst
 	   for details.
-- 
2.39.2


