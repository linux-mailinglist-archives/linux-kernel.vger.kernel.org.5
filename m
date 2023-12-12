Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119DD80E7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjLLJnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLLJnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:43:18 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731A5E3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:43:24 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BC6gnqx004028;
        Tue, 12 Dec 2023 10:43:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=selector1; bh=2m3Til5/b9PZ2Uwec07k
        8iVtFn56gHhKsPS0il+OJ94=; b=KMZ2mVUe8vsxP7R3iqs5mlYRt4+WTLik1H3U
        GzUwCoS2717f49PR5dq/XZS5IjbcGRwPbQEadSs051dsH6JQoCFM9EVyEnt/FAKm
        itwChVoAoiitn7CyE298rfHxCqYeY2HthJM7BrRL7+aNDyRjCygbI9MAXFyDZt5+
        YzFzq88juHPrBJGSSR/F/xt+8x0MMTxKotcADgZJlUfFt9WzmpZJ2+uf4klov9VY
        lHjNJjov5JEDcUXgl5aABYc9027npY5mq9xmqV+YG+Tb+PZsWw5sXBEj8QiXG/f4
        ReDKpoacgMHDm4xGUdstg6ToFP6o0GMv9GvUN3VhbQdExkJjoA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uvehmauxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 10:43:14 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0D26610005A;
        Tue, 12 Dec 2023 10:43:14 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EF977215139;
        Tue, 12 Dec 2023 10:43:13 +0100 (CET)
Received: from localhost (10.201.20.114) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Dec
 2023 10:43:13 +0100
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Antonio Borneo <antonio.borneo@foss.st.com>,
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= 
        <clement.legoffic@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] checkpatch: use utf-8 match for spell checking
Date:   Tue, 12 Dec 2023 10:43:10 +0100
Message-ID: <20231212094310.3633-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.114]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_03,2023-12-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code that checks for misspelling verifies, in a more
complex regex, if $rawline matches [^\w]($misspellings)[^\w]

Being $rawline a byte-string, a utf-8 character in $rawline can
match the non-word-char [^\w].
E.g.:
	./script/checkpatch.pl --git 81c2f059ab9
	WARNING: 'ment' may be misspelled - perhaps 'meant'?
	#36: FILE: MAINTAINERS:14360:
	+M:     Clément Léger <clement.leger@bootlin.com>
	            ^^^^

Use a utf-8 version of $rawline for spell checking.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Reported-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 25fdb7fda112..58646bd6ef56 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3477,7 +3477,8 @@ sub process {
 # Check for various typo / spelling mistakes
 		if (defined($misspellings) &&
 		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
-			while ($rawline =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
+			my $rawline_utf8 = decode("utf8", $rawline);
+			while ($rawline_utf8 =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
 				my $typo = $1;
 				my $blank = copy_spacing($rawline);
 				my $ptr = substr($blank, 0, $-[1]) . "^" x length($typo);

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.42.0

