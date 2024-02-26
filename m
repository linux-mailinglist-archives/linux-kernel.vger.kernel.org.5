Return-Path: <linux-kernel+bounces-81458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AE4867634
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C31B1C28888
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA18286631;
	Mon, 26 Feb 2024 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="MzVOEbQx"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E78E8529F;
	Mon, 26 Feb 2024 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953277; cv=none; b=mVzcyULBoo6VaSlLttA/i2fajdjypoNDEOAQh3RPNADYnD1W0c0FYA2QU03ltyJupbT2/dnltbiT+I2OaDnsN+dC31/g08lppcjyjUqoRHiM7CiymyqLqRDOkC43/8JY2U7FbX8oC/aHr0eO5nOQB1gNgvfuT7SzhehpMMXU8Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953277; c=relaxed/simple;
	bh=y1rHoM1PmsWaO0MLcbhFFvY5L+UAqwxsnigGbmSxneQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eaWudIkWCeabpf+zp/2XApRPyMRQxv2p09y8dn0f+EtgB0UFVFy/5GCcNOKSXtCAarDVGtkjzzBgXQwmf2zAxN4f0Aiz+ltqu5gU2Z3YFXtwVW+YasCixTxSCTvt7ZUqEHKeVs29QSs08sBfyk7G1KWTRmnEMcH677xFbgxnVG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=MzVOEbQx; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 6B899200F809;
	Mon, 26 Feb 2024 14:14:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 6B899200F809
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708953273;
	bh=YND8YDjnCKUnnw5aps81Jl33wEbPNlCkIx5CZfyc34w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MzVOEbQxv4GAtYgk3T1NDIpY0BGvSoionFEZ+xB6j2cWF58/eB8jccXawu4EmuvfS
	 JCRZoer1UUej5tbHGRxtdbx/+zGNvsnW6oBXXkV3alfEEvGENXK0frKn+2NjL89JkM
	 BO/FvMO8arE+hT7hYYk36wdnybQbGLtEM21Lg2OFm4mj12SN5iPRBETPK9MiCCRHqt
	 WZ6gXEf0noI0+6fWeD7MJjvmkyFB3h8aPWSUfPmyMacL44hi4YdeI8gV1RPmto8uhj
	 PW7pWL6mg2Zuxhy9apxPZ4yTZAliIX+uFCNzblJNT55AmLwz9B3wj2aCvKoZH6uVpQ
	 uHfjri6u4IGiQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v5 1/3] uapi: ioam6: API for netlink multicast events
Date: Mon, 26 Feb 2024 14:14:10 +0100
Message-Id: <20240226131412.10214-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226131412.10214-1-justin.iurman@uliege.be>
References: <20240226131412.10214-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new api to support ioam6 events for generic netlink multicast. A
first "trace" event is added to the list of ioam6 events, which will
represent an IOAM Pre-allocated Trace Option-Type. It provides another
solution to share IOAM data with user space.

Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 include/uapi/linux/ioam6_genl.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/uapi/linux/ioam6_genl.h b/include/uapi/linux/ioam6_genl.h
index ca4b22833754..1733fbc51fb5 100644
--- a/include/uapi/linux/ioam6_genl.h
+++ b/include/uapi/linux/ioam6_genl.h
@@ -49,4 +49,24 @@ enum {
 
 #define IOAM6_CMD_MAX (__IOAM6_CMD_MAX - 1)
 
+#define IOAM6_GENL_EV_GRP_NAME "ioam6_events"
+
+enum ioam6_event_type {
+	IOAM6_EVENT_UNSPEC,
+	IOAM6_EVENT_TRACE,
+};
+
+enum ioam6_event_attr {
+	IOAM6_EVENT_ATTR_UNSPEC,
+
+	IOAM6_EVENT_ATTR_TRACE_NAMESPACE,	/* u16 */
+	IOAM6_EVENT_ATTR_TRACE_NODELEN,		/* u8 */
+	IOAM6_EVENT_ATTR_TRACE_TYPE,		/* u32 */
+	IOAM6_EVENT_ATTR_TRACE_DATA,		/* Binary */
+
+	__IOAM6_EVENT_ATTR_MAX
+};
+
+#define IOAM6_EVENT_ATTR_MAX (__IOAM6_EVENT_ATTR_MAX - 1)
+
 #endif /* _UAPI_LINUX_IOAM6_GENL_H */
-- 
2.34.1


