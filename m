Return-Path: <linux-kernel+bounces-132383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFD18993D5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243021F27691
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BA92E40F;
	Fri,  5 Apr 2024 03:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DvAniAIG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E4F23769;
	Fri,  5 Apr 2024 03:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712287520; cv=none; b=dqgMw1B4++oYvotUHYrJqjHmCSHsHcdLEl88bmxFx9230++RoAn/m34ugM09UP2U7Hq5m/XOQXnqt/JynkJIvg9gIBqti8EcUCh3Gyhzxj6pi8qjgxZSgYrZwaFktY6l5tHdYDNHB3btkkgzJT2EDxeHmXe8GzprvPZ0er3upZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712287520; c=relaxed/simple;
	bh=Z51gfqNYcN1zsxtDZiTM7bT3apioGlhfYZ1G5RPlRDM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QuY8yDyj9a3s5cb45dn7W9babi8262wiyGektVssPcWerUPcPc0sT8MrwfhBrDvqDxe3XTRJuO5DK5WiL6alL8JR6HvP+DbibwJgTHhm5EcPTDjcCTK01DKmej9IAGsa+3uino13PJuwz0wwNSDy4cQdTYbabT9WwwpMCwMy/pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DvAniAIG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712287519; x=1743823519;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Z51gfqNYcN1zsxtDZiTM7bT3apioGlhfYZ1G5RPlRDM=;
  b=DvAniAIGJp/rOer3NK6QYef8AyrzTFOiiNrFsnpqFmjD4ZShq3xsLym7
   FF9v0GIB43KaOaFcjXWu2y05rXPmC/3i1nDdiRQ+HaAnhxdUWGUPaRPvB
   vDxC8MNz9fIYfe2qM4BymnsmuiLAQOG141xepInyRaK9ShzBYcZwqzX5H
   nrLxhiGkLfobhD3MGuC/SjGW3F/nT29gw53b3LpQH+Mp34idm+H5kIU4J
   bUjhFeMR4qmvU2rLZOG3KPwrWaJWyE7gOOmW5q9ghn20gN94dCM/VUbUL
   0bp1ryZeuAFsP+ULmWgZbHjWwYzzVeUuFFFyrbI3rINkt+l4ohIUj1kNZ
   A==;
X-CSE-ConnectionGUID: rVQDF6SiRs+jH1CNzyO45A==
X-CSE-MsgGUID: G1rexNCBR2+rX2yXx/B28Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="25112476"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="25112476"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:25:16 -0700
X-CSE-ConnectionGUID: XOQbBmscSu2F9M47Fk1p8Q==
X-CSE-MsgGUID: WmUU+lXsTOaVXwWJXz/3Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18955992"
Received: from alexpabo-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.209.49.45])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:25:15 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH V3 9/9] tools: intel_sdsi: Add current meter support
Date: Thu,  4 Apr 2024 20:25:07 -0700
Message-Id: <20240405032507.2637311-10-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405032507.2637311-1-david.e.box@linux.intel.com>
References: <20240405032507.2637311-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support to read the 'meter_current' file. The display is the same as
the 'meter_certificate', but will show the current snapshot of the
counters.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

V3 - no changes

V2 - Set the name of the file to be opened once.

 tools/arch/x86/intel_sdsi/intel_sdsi.c | 49 ++++++++++++++++----------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 0c9670ba1f15..98d1ce9187ce 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -185,6 +185,7 @@ struct sdsi_dev {
 enum command {
 	CMD_SOCKET_INFO,
 	CMD_METER_CERT,
+	CMD_METER_CURRENT_CERT,
 	CMD_STATE_CERT,
 	CMD_PROV_AKC,
 	CMD_PROV_CAP,
@@ -332,13 +333,14 @@ static void get_feature(uint32_t encoding, char *feature)
 	feature[0] = name[3];
 }
 
-static int sdsi_meter_cert_show(struct sdsi_dev *s)
+static int sdsi_meter_cert_show(struct sdsi_dev *s, bool show_current)
 {
 	char buf[METER_CERT_MAX_SIZE] = {0};
 	struct bundle_encoding_counter *bec;
 	struct meter_certificate *mc;
 	uint32_t count = 0;
 	FILE *cert_ptr;
+	char *cert_fname;
 	int ret, size;
 	char name[4];
 
@@ -348,7 +350,6 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 
 	if (!s->regs.en_features.sdsi) {
 		fprintf(stderr, "SDSi feature is present but not enabled.\n");
-		fprintf(stderr, " Unable to read meter certificate\n");
 		return -1;
 	}
 
@@ -363,15 +364,17 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 		return ret;
 	}
 
-	cert_ptr = fopen("meter_certificate", "r");
+	cert_fname = show_current ? "meter_current" : "meter_certificate";
+	cert_ptr = fopen(cert_fname, "r");
+
 	if (!cert_ptr) {
-		perror("Could not open 'meter_certificate' file");
+		fprintf(stderr, "Could not open '%s' file: %s", cert_fname, strerror(errno));
 		return -1;
 	}
 
 	size = fread(buf, 1, sizeof(buf), cert_ptr);
 	if (!size) {
-		fprintf(stderr, "Could not read 'meter_certificate' file\n");
+		fprintf(stderr, "Could not read '%s' file\n", cert_fname);
 		fclose(cert_ptr);
 		return -1;
 	}
@@ -738,7 +741,7 @@ static void sdsi_free_dev(struct sdsi_dev *s)
 
 static void usage(char *prog)
 {
-	printf("Usage: %s [-l] [-d DEVNO [-i] [-s] [-m] [-a FILE] [-c FILE]]\n", prog);
+	printf("Usage: %s [-l] [-d DEVNO [-i] [-s] [-m | -C] [-a FILE] [-c FILE]\n", prog);
 }
 
 static void show_help(void)
@@ -747,8 +750,9 @@ static void show_help(void)
 	printf("  %-18s\t%s\n", "-l, --list",           "list available On Demand devices");
 	printf("  %-18s\t%s\n", "-d, --devno DEVNO",    "On Demand device number");
 	printf("  %-18s\t%s\n", "-i, --info",           "show socket information");
-	printf("  %-18s\t%s\n", "-s, --state",          "show state certificate");
-	printf("  %-18s\t%s\n", "-m, --meter",          "show meter certificate");
+	printf("  %-18s\t%s\n", "-s, --state",          "show state certificate data");
+	printf("  %-18s\t%s\n", "-m, --meter",          "show meter certificate data");
+	printf("  %-18s\t%s\n", "-C, --meter_current",  "show live unattested meter data");
 	printf("  %-18s\t%s\n", "-a, --akc FILE",       "provision socket with AKC FILE");
 	printf("  %-18s\t%s\n", "-c, --cap FILE>",      "provision socket with CAP FILE");
 }
@@ -764,21 +768,22 @@ int main(int argc, char *argv[])
 	int option_index = 0;
 
 	static struct option long_options[] = {
-		{"akc",		required_argument,	0, 'a'},
-		{"cap",		required_argument,	0, 'c'},
-		{"devno",	required_argument,	0, 'd'},
-		{"help",	no_argument,		0, 'h'},
-		{"info",	no_argument,		0, 'i'},
-		{"list",	no_argument,		0, 'l'},
-		{"meter",	no_argument,		0, 'm'},
-		{"state",	no_argument,		0, 's'},
-		{0,		0,			0, 0 }
+		{"akc",			required_argument,	0, 'a'},
+		{"cap",			required_argument,	0, 'c'},
+		{"devno",		required_argument,	0, 'd'},
+		{"help",		no_argument,		0, 'h'},
+		{"info",		no_argument,		0, 'i'},
+		{"list",		no_argument,		0, 'l'},
+		{"meter",		no_argument,		0, 'm'},
+		{"meter_current",	no_argument,		0, 'C'},
+		{"state",		no_argument,		0, 's'},
+		{0,			0,			0, 0 }
 	};
 
 
 	progname = argv[0];
 
-	while ((opt = getopt_long_only(argc, argv, "+a:c:d:hilms", long_options,
+	while ((opt = getopt_long_only(argc, argv, "+a:c:d:hilmCs", long_options,
 			&option_index)) != -1) {
 		switch (opt) {
 		case 'd':
@@ -794,6 +799,9 @@ int main(int argc, char *argv[])
 		case 'm':
 			command = CMD_METER_CERT;
 			break;
+		case 'C':
+			command = CMD_METER_CURRENT_CERT;
+			break;
 		case 's':
 			command = CMD_STATE_CERT;
 			break;
@@ -832,7 +840,10 @@ int main(int argc, char *argv[])
 			ret = sdsi_read_reg(s);
 			break;
 		case CMD_METER_CERT:
-			ret = sdsi_meter_cert_show(s);
+			ret = sdsi_meter_cert_show(s, false);
+			break;
+		case CMD_METER_CURRENT_CERT:
+			ret = sdsi_meter_cert_show(s, true);
 			break;
 		case CMD_STATE_CERT:
 			ret = sdsi_state_cert_show(s);
-- 
2.34.1


