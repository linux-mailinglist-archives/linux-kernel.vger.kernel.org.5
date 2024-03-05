Return-Path: <linux-kernel+bounces-92647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE4B87235F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 627AEB25032
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D957127B7B;
	Tue,  5 Mar 2024 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="BH4WM1r6"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB5F8664C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654328; cv=pass; b=n9kJVkj9xI9V1ZpkmJ+sgKICZbx8YqE4gQbYQx3z7zQoC+eMY8yGZSS0HBEw+cJaIwOAeKVyMRKbPdOq71V0Oah2t4iTeDwSQE9Cgx7GiiRVg7vudwGgmh2ueuFULhTlqPn3QzFpgnu49hQySvey4/dnYa4emSbSSmTNI9TXYps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654328; c=relaxed/simple;
	bh=gciH/ztoj7lWGDfba0UzkiWhgNW+zyYgq3sZ39TQuAY=;
	h=Date:Message-ID:From:To:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jpn+D2K4pe6eEyLRZc+P6vYMU9EK71neQlauJFjRM3+M24yVm5gHJY/vaH8BfyUdqU5He9S4CVQ+S/pKwhAkLx0yZLRXFD1RuG7tuRZAPqF9xi1gCxj9B+iRtgwQVwAP0GaXnKa39RtOYBheCbXm9NYU795wUb098+eZ37A6lpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=BH4WM1r6; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1709654321; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jZM3hK2gygQQ59o4FFoDN4zgXM1MeYdIVSZk1E0yZZBUVHba34LCy8zeQE2nTG+0pnL98eB9Um4E0b3od38lIGjVQgtWV/Qy/Zgjg29BHJCvmdEMn1x2Xxcf9Lhx4SCEi1ww46ahsomyCL8nrQ9qbYYieMdUHIWzss0pjUcoWBU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1709654321; h=Content-Type:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=UJLFWjmbAiqCiDzXMe/4tVK1nnRlgLmIGo8BlDiChsM=; 
	b=OEcwwwY1+2yqAhuPgrILUOX1727TR4vCtuRR8GtP9t3oX5FZ0mVULF0R5HB/+fh3qs/TbpkS3aQHdIk1+3FUSF0wvTjLbV8NhhmUrqbUdC7frnMXjk/dp5GHDMKx8cMonGJfjCr4uFTdm1RIaQzPYeNRU7U//7UCUC5OU2ZhKig=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1709654321;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:Message-ID:From:From:To:To:Subject:Subject:In-Reply-To:References:MIME-Version:Content-Type:Message-Id:Reply-To:Cc;
	bh=UJLFWjmbAiqCiDzXMe/4tVK1nnRlgLmIGo8BlDiChsM=;
	b=BH4WM1r633XEnj46xKqj9qqucaU7PiW8nI7PvSO4S1X7oJy44SUuGaqioemrT39v
	ZupupQTYucpgjqCwnCiEBqUAqXzkYqoPRpn/GJJ8KxTMCAZt4ZDGmWaUDCeTbIKjxLZ
	tiaOmBhiyLU10G6OE0UZ3Ae3J6Lj8pqi5HOlwJP8=
Received: from lchen-jiaolong.linux.beauty (116.169.7.108 [116.169.7.108]) by mx.zohomail.com
	with SMTPS id 1709654319739846.0364140338595; Tue, 5 Mar 2024 07:58:39 -0800 (PST)
Date: Tue, 05 Mar 2024 23:47:32 +0800
Message-ID: <87edcor88b.wl-me@linux.beauty>
From: Li Chen <me@linux.beauty>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] checkpatch: Add warning for msleep with durations suitable for ssleep
In-Reply-To: <87frx4r8dt.wl-me@linux.beauty>
References: <87frx4r8dt.wl-me@linux.beauty>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?ISO-8859-4?Q?Goj=F2?=) APEL-LB/10.8 EasyPG/1.0.0
 Emacs/29.2 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

This patch enhances checkpatch.pl by introducing a warning for instances
where msleep() is used with durations that are multiples of 1000
milliseconds. Such durations are more semantically appropriate for
ssleep().

The goal is to encourage developers to use the most fitting sleep function,
improving code readability.

Warn when msleep(x000); can be replaced with ssleep(x);
Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 scripts/checkpatch.pl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..a32df4ead5d4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6599,6 +6599,16 @@ sub process {
 			}
 		}
 
+# warn about msleep() calls with durations that should use ssleep()
+if ($line =~ /\bmsleep\s*\((\d+)\);/) {
+    my $ms_duration = $1;
+    if ($ms_duration >= 1000 && ($ms_duration % 1000) == 0) {
+        my $ss_duration = $ms_duration / 1000;
+        WARN("SSLEEP",
+             "Prefer ssleep($ss_duration) over msleep($ms_duration);\n" . $herecurr);
+    }
+}
+
 # check for comparisons of jiffies
 		if ($line =~ /\bjiffies\s*$Compare|$Compare\s*jiffies\b/) {
 			WARN("JIFFIES_COMPARISON",
-- 
2.44.0


