Return-Path: <linux-kernel+bounces-14613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0864821FA7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A79D7B220FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E7114F81;
	Tue,  2 Jan 2024 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="R3zXFw4w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047BF14F89
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4029bOla028296;
	Tue, 2 Jan 2024 17:10:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	selector1; bh=kPETBoGH+akjcEbMQz/7+ofwHwOQ7qKVNhjHOwjNL2A=; b=R3
	zXFw4wttd7VqVoeDFAMoxQy2IbpeaunrpFeptzgyTd3Mu2vHHmDtdXqrI9jRxKJY
	0XCQq+kd1OLw6vQg1QGatoGBcg8XZ0Ik4KknQRL4trYns2yUgHFoh556UhtVaRNF
	GjL53p6pG9QTqmkZS3G5DO+aUh8bMnoLi7RJSOiMmA+7Om21t+99pl5sySuIizpY
	Ws1QOL0SVFWJQtR3ZwM0guR6riMxRhkOSbFjcHXHNhMrF/KkyQ1DguUQf8lmFftj
	qWrVNqsISHLa0b58Eoo/Ugx6z/PF1fqGk3jc3rBFr5dA5bqotv9iRitqYvnzjlck
	NmvV+NM+gxNwqZSRpMyA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3va978gmxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 17:10:46 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EA840100062;
	Tue,  2 Jan 2024 17:10:45 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E1F852B5687;
	Tue,  2 Jan 2024 17:10:45 +0100 (CET)
Received: from localhost (10.201.20.114) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 2 Jan
 2024 17:10:45 +0100
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn
	<lukas.bulwahn@gmail.com>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=
	<clement.leger@bootlin.com>,
        =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=
	<clement.legoffic@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2] checkpatch: use utf-8 match for spell checking
Date: Tue, 2 Jan 2024 17:10:38 +0100
Message-ID: <20240102161038.22347-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212094310.3633-1-antonio.borneo@foss.st.com>
References: <20231212094310.3633-1-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_04,2024-01-02_01,2023-05-22_02

The current code that checks for misspelling verifies, in a more
complex regex, if $rawline matches [^\w]($misspellings)[^\w]

Being $rawline a byte-string, a utf-8 character in $rawline can
match the non-word-char [^\w].
E.g.:
	./scripts/checkpatch.pl --git 81c2f059ab9
	WARNING: 'ment' may be misspelled - perhaps 'meant'?
	#36: FILE: MAINTAINERS:14360:
	+M:     Clément Léger <clement.leger@bootlin.com>
	            ^^^^

Use a utf-8 version of $rawline for spell checking.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Reported-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
Changes in v2:
- use $rawline_utf8 also in the while-loop's body;
- fix path of checkpatch in the commit message.
---
 scripts/checkpatch.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 25fdb7fda112..2d122d232c6d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3477,9 +3477,10 @@ sub process {
 # Check for various typo / spelling mistakes
 		if (defined($misspellings) &&
 		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
-			while ($rawline =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
+			my $rawline_utf8 = decode("utf8", $rawline);
+			while ($rawline_utf8 =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
 				my $typo = $1;
-				my $blank = copy_spacing($rawline);
+				my $blank = copy_spacing($rawline_utf8);
 				my $ptr = substr($blank, 0, $-[1]) . "^" x length($typo);
 				my $hereptr = "$hereline$ptr\n";
 				my $typo_fix = $spelling_fix{lc($typo)};

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.42.0


