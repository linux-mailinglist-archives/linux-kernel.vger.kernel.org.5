Return-Path: <linux-kernel+bounces-77539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BA386070B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92C2BB214E9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607647175E;
	Thu, 22 Feb 2024 23:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="IjRtkDRW"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D346B199AD;
	Thu, 22 Feb 2024 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708644843; cv=none; b=GbN/prKGaPLbaaWHMX+ahCys4EISIzKbd70D6I+UWftli4HaLRTB2A4BIOcvV4vv3ON1xudG7mL3/ADhVhJA+ZXVvUv2g8FVxKTpXe/fKhtH/8GSLwJ4LSMCjiuoC7hW6AVF1QXTrZ3r2ryQFoK1oDFak4l+xogIOzNoGpMa93M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708644843; c=relaxed/simple;
	bh=lYSbqhb9aelgiyV2bHdQgyY0ObK/yrK8TqQKdtUu/qM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HxtJPEylCP1mgX76MZ2SmBWepEXQFDZycJ+9ElZ2rsJxnLuEkxgNkfmce81HRG/WFjgLgihNx0BjZDie2KNvq3FoumoQj+VRVMsdqBElLcW1Txfm5TLmPa39tf/m6e3OPOVSxe/tpMX3ENACUixfGyWSuAia3RAhvNDPnLEi1og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=IjRtkDRW; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id D2883200C97D;
	Fri, 23 Feb 2024 00:33:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be D2883200C97D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708644837;
	bh=LcVhwtN+UqJjMSh3FfAL9zHi7+WPp9yvrVRqAgObzSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IjRtkDRWdbBNd+C7rjucPifnfstJjCMjeNQLZIkHnJYurMlyxUTtftZqsCsgVI7Fr
	 +0TH0V6d99wRsq5A2lq5bIV61NTIHMPE+BNukEbl6MO5gkbZVOEVVVx/H+oTBj7p69
	 3NdG/vPug+95Hf8jbsz0MSde/jtkDxgNQQHv/DbjpLo7CwEANHbEbw6KIywkQSHAql
	 Jt9XPNg+qG0SzC4jo9EzP0Q2ObopGWaUYv+v+zyuEPfdoaSm5ZHFy/ODCcKSazkzEq
	 /5TEhIDDTj+5GiTqo8IE9NW+7W0nhNWhf48pjEOIu6aSWd5OlCF+fc5N51Z/nSUQEx
	 bT7ekACTzq2Sg==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v3 1/3] uapi: ioam6: API for netlink multicast events
Date: Fri, 23 Feb 2024 00:33:35 +0100
Message-Id: <20240222233337.5342-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222233337.5342-1-justin.iurman@uliege.be>
References: <20240222233337.5342-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new api to support ioam6 events for generic netlink multicast. A
first "trace" event is added to the list of ioam6 events, which will
represent an IOAM Pre-allocated (or Incremental) Trace Option-Type. It
provides another solution to share IOAM data with user space.

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


