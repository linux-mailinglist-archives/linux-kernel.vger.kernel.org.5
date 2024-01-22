Return-Path: <linux-kernel+bounces-33296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACD1836810
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01A31C22EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674C05D901;
	Mon, 22 Jan 2024 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzMhErnP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7E65D8FD;
	Mon, 22 Jan 2024 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935690; cv=none; b=FkQu186cFRtm5JLoLrAt02xTTh+/bwMxQNPEYG9ZDHtui6Zu/L7+1E+cCyOl5SFqCVcHBITEd5iE3t6xv6pZB+zv+rajqU6DPMh1UpqHKRXGhzrV4+veHrwNu9vAGJGH1CZHPHPCvd+tA1yEfOxHnivHsJwTgWAEUrtFV3FFunc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935690; c=relaxed/simple;
	bh=Y37+vUsxtsEdK0orfO8l3mHK/MfBa2CTxfPAVV0kW2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INxe43mTFBf+Q0Qryau6FMJNb9alOukeOakESc33aMoQzCqJpZGWcwOMi9Qoy7wIR8N1B3Tgn4blq4v0pLHUvXAynVTut2alNlKjBbMDIs32OIBS0dL5Ne+V106czsjMdNoDlq2pcG2j78K5KcO0OZFyEtj/WonLhOy6o2cNzhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzMhErnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B84C433C7;
	Mon, 22 Jan 2024 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935689;
	bh=Y37+vUsxtsEdK0orfO8l3mHK/MfBa2CTxfPAVV0kW2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TzMhErnPhREHhoOZDuuzsgefF3m+y4vhLxkfKvQSh0bEn/Nsikq8dDcfsjsUbL9YQ
	 8aFODoxHpaw1rIHyRHw9q8ItTaHlXREZIIQbC+iInT/0FpGBziYLaOFDIgxz19Gmru
	 IConAg/kRh4TQxCQRvSFtAOagSgIcaSQDZ4rHp2o3qi4gXWQHzwwKpRqNp4B78ujgz
	 rG5qGgiypamezqPmpstjn7z+l8khdrRVXHR05+BWhy9BecqH7xMQlvqXnfhNVkz9WO
	 iA9EvbWDLLO8jcLv2apz4Y9WXS7DMMTNHMZ6iX0ZWCbcK4qtb/WFRJ5wS4jWNCPtPk
	 RNHk4LLwPTb3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	PeiChen Huang <peichen.huang@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	qingqing.zhuo@amd.com,
	wenjing.liu@amd.com,
	mghaddar@amd.com,
	Jun.Lei@amd.com,
	trix@redhat.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 74/88] drm/amd/display: Fix minor issues in BW Allocation Phase2
Date: Mon, 22 Jan 2024 09:51:47 -0500
Message-ID: <20240122145608.990137-74-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[ Upstream commit aa5dc05340eb97486a631ce6bccb8d020bf6b56b ]

[Why]
Fix minor issues in BW Allocation Phase2.

[How]
- In set_usb4_req_bw_req(), link->dpia_bw_alloc_config.response_ready
  flag should be reset before writing DPCD REQUEST_BW.
- Fix the granularity for value of 2 in get_bw_granularity().
- Removed bandwidth allocation support display fw boot option as
  the fw would read feature enable status from bios.
- Clean up DPIA_EST_BW_CHANGED and DPIA_BW_REQ_SUCCESS cases in
  dpia_handle_bw_alloc_response().
- Removed allocate_usb4_bw and deallocate_usb4_bw.
- Optimized loop in get_lowest_dpia_index().
- Updated link_dp_dpia_allocate_usb4_bandwidth_for_stream() and
  set_usb4_req_bw_req() to always issue request bw.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: PeiChen Huang <peichen.huang@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dc/link/protocols/link_dp_dpia_bw.c       | 221 ++++++++----------
 .../dc/link/protocols/link_dp_dpia_bw.h       |   4 +-
 2 files changed, 101 insertions(+), 124 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index 7581023daa47..d6e1f969bfd5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -50,6 +50,7 @@ static bool get_bw_alloc_proceed_flag(struct dc_link *tmp)
 			&& tmp->hpd_status
 			&& tmp->dpia_bw_alloc_config.bw_alloc_enabled);
 }
+
 static void reset_bw_alloc_struct(struct dc_link *link)
 {
 	link->dpia_bw_alloc_config.bw_alloc_enabled = false;
@@ -59,6 +60,11 @@ static void reset_bw_alloc_struct(struct dc_link *link)
 	link->dpia_bw_alloc_config.bw_granularity = 0;
 	link->dpia_bw_alloc_config.response_ready = false;
 }
+
+#define BW_GRANULARITY_0 4 // 0.25 Gbps
+#define BW_GRANULARITY_1 2 // 0.5 Gbps
+#define BW_GRANULARITY_2 1 // 1 Gbps
+
 static uint8_t get_bw_granularity(struct dc_link *link)
 {
 	uint8_t bw_granularity = 0;
@@ -71,16 +77,20 @@ static uint8_t get_bw_granularity(struct dc_link *link)
 
 	switch (bw_granularity & 0x3) {
 	case 0:
-		bw_granularity = 4;
+		bw_granularity = BW_GRANULARITY_0;
 		break;
 	case 1:
+		bw_granularity = BW_GRANULARITY_1;
+		break;
+	case 2:
 	default:
-		bw_granularity = 2;
+		bw_granularity = BW_GRANULARITY_2;
 		break;
 	}
 
 	return bw_granularity;
 }
+
 static int get_estimated_bw(struct dc_link *link)
 {
 	uint8_t bw_estimated_bw = 0;
@@ -93,31 +103,7 @@ static int get_estimated_bw(struct dc_link *link)
 
 	return bw_estimated_bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
 }
-static bool allocate_usb4_bw(int *stream_allocated_bw, int bw_needed, struct dc_link *link)
-{
-	if (bw_needed > 0)
-		*stream_allocated_bw += bw_needed;
-
-	return true;
-}
-static bool deallocate_usb4_bw(int *stream_allocated_bw, int bw_to_dealloc, struct dc_link *link)
-{
-	bool ret = false;
-
-	if (*stream_allocated_bw > 0) {
-		*stream_allocated_bw -= bw_to_dealloc;
-		ret = true;
-	} else {
-		//Do nothing for now
-		ret = true;
-	}
 
-	// Unplug so reset values
-	if (!link->hpd_status)
-		reset_bw_alloc_struct(link);
-
-	return ret;
-}
 /*
  * Read all New BW alloc configuration ex: estimated_bw, allocated_bw,
  * granuality, Driver_ID, CM_Group, & populate the BW allocation structs
@@ -128,7 +114,12 @@ static void init_usb4_bw_struct(struct dc_link *link)
 	// Init the known values
 	link->dpia_bw_alloc_config.bw_granularity = get_bw_granularity(link);
 	link->dpia_bw_alloc_config.estimated_bw = get_estimated_bw(link);
+
+	DC_LOG_DEBUG("%s: bw_granularity(%d), estimated_bw(%d)\n",
+		__func__, link->dpia_bw_alloc_config.bw_granularity,
+		link->dpia_bw_alloc_config.estimated_bw);
 }
+
 static uint8_t get_lowest_dpia_index(struct dc_link *link)
 {
 	const struct dc *dc_struct = link->dc;
@@ -141,12 +132,15 @@ static uint8_t get_lowest_dpia_index(struct dc_link *link)
 				dc_struct->links[i]->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
 			continue;
 
-		if (idx > dc_struct->links[i]->link_index)
+		if (idx > dc_struct->links[i]->link_index) {
 			idx = dc_struct->links[i]->link_index;
+			break;
+		}
 	}
 
 	return idx;
 }
+
 /*
  * Get the Max Available BW or Max Estimated BW for each Host Router
  *
@@ -186,6 +180,7 @@ static int get_host_router_total_bw(struct dc_link *link, uint8_t type)
 
 	return total_bw;
 }
+
 /*
  * Cleanup function for when the dpia is unplugged to reset struct
  * and perform any required clean up
@@ -194,42 +189,50 @@ static int get_host_router_total_bw(struct dc_link *link, uint8_t type)
  *
  * return: none
  */
-static bool dpia_bw_alloc_unplug(struct dc_link *link)
+static void dpia_bw_alloc_unplug(struct dc_link *link)
 {
-	if (!link)
-		return true;
-
-	return deallocate_usb4_bw(&link->dpia_bw_alloc_config.sink_allocated_bw,
-			link->dpia_bw_alloc_config.sink_allocated_bw, link);
+	if (link) {
+		DC_LOG_DEBUG("%s: resetting bw alloc config for link(%d)\n",
+			__func__, link->link_index);
+		link->dpia_bw_alloc_config.sink_allocated_bw = 0;
+		reset_bw_alloc_struct(link);
+	}
 }
+
 static void set_usb4_req_bw_req(struct dc_link *link, int req_bw)
 {
 	uint8_t requested_bw;
 	uint32_t temp;
 
-	// 1. Add check for this corner case #1
-	if (req_bw > link->dpia_bw_alloc_config.estimated_bw)
+	/* Error check whether request bw greater than allocated */
+	if (req_bw > link->dpia_bw_alloc_config.estimated_bw) {
+		DC_LOG_ERROR("%s: Request bw greater than estimated bw for link(%d)\n",
+			__func__, link->link_index);
 		req_bw = link->dpia_bw_alloc_config.estimated_bw;
+	}
 
 	temp = req_bw * link->dpia_bw_alloc_config.bw_granularity;
 	requested_bw = temp / Kbps_TO_Gbps;
 
-	// Always make sure to add more to account for floating points
+	/* Always make sure to add more to account for floating points */
 	if (temp % Kbps_TO_Gbps)
 		++requested_bw;
 
-	// 2. Add check for this corner case #2
+	/* Error check whether requested and allocated are equal */
 	req_bw = requested_bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
-	if (req_bw == link->dpia_bw_alloc_config.sink_allocated_bw)
-		return;
+	if (req_bw == link->dpia_bw_alloc_config.sink_allocated_bw) {
+		DC_LOG_ERROR("%s: Request bw equals to allocated bw for link(%d)\n",
+			__func__, link->link_index);
+	}
 
-	if (core_link_write_dpcd(
+	link->dpia_bw_alloc_config.response_ready = false; // Reset flag
+	core_link_write_dpcd(
 		link,
 		REQUESTED_BW,
 		&requested_bw,
-		sizeof(uint8_t)) == DC_OK)
-		link->dpia_bw_alloc_config.response_ready = false; // Reset flag
+		sizeof(uint8_t));
 }
+
 /*
  * Return the response_ready flag from dc_link struct
  *
@@ -241,6 +244,7 @@ static bool get_cm_response_ready_flag(struct dc_link *link)
 {
 	return link->dpia_bw_alloc_config.response_ready;
 }
+
 // ------------------------------------------------------------------
 //					PUBLIC FUNCTIONS
 // ------------------------------------------------------------------
@@ -277,27 +281,27 @@ bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link)
 				DPTX_BW_ALLOCATION_MODE_CONTROL,
 				&response,
 				sizeof(uint8_t)) != DC_OK) {
-			DC_LOG_DEBUG("%s: **** FAILURE Enabling DPtx BW Allocation Mode Support ***\n",
-					__func__);
+			DC_LOG_DEBUG("%s: FAILURE Enabling DPtx BW Allocation Mode Support for link(%d)\n",
+				__func__, link->link_index);
 		} else {
 			// SUCCESS Enabled DPtx BW Allocation Mode Support
-			link->dpia_bw_alloc_config.bw_alloc_enabled = true;
-			DC_LOG_DEBUG("%s: **** SUCCESS Enabling DPtx BW Allocation Mode Support ***\n",
-					__func__);
+			DC_LOG_DEBUG("%s: SUCCESS Enabling DPtx BW Allocation Mode Support for link(%d)\n",
+				__func__, link->link_index);
 
 			ret = true;
 			init_usb4_bw_struct(link);
+			link->dpia_bw_alloc_config.bw_alloc_enabled = true;
 		}
 	}
 
 out:
 	return ret;
 }
+
 void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t result)
 {
 	int bw_needed = 0;
 	int estimated = 0;
-	int host_router_total_estimated_bw = 0;
 
 	if (!get_bw_alloc_proceed_flag((link)))
 		return;
@@ -306,14 +310,22 @@ void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t res
 
 	case DPIA_BW_REQ_FAILED:
 
-		DC_LOG_DEBUG("%s: *** *** BW REQ FAILURE for DP-TX Request *** ***\n", __func__);
+		/*
+		 * Ideally, we shouldn't run into this case as we always validate available
+		 * bandwidth and request within that limit
+		 */
+		estimated = bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
 
-		// Update the new Estimated BW value updated by CM
-		link->dpia_bw_alloc_config.estimated_bw =
-				bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
+		DC_LOG_ERROR("%s: BW REQ FAILURE for DP-TX Request for link(%d)\n",
+			__func__, link->link_index);
+		DC_LOG_ERROR("%s: current estimated_bw(%d), new estimated_bw(%d)\n",
+			__func__, link->dpia_bw_alloc_config.estimated_bw, estimated);
 
+		/* Update the new Estimated BW value updated by CM */
+		link->dpia_bw_alloc_config.estimated_bw = estimated;
+
+		/* Allocate the previously requested bandwidth */
 		set_usb4_req_bw_req(link, link->dpia_bw_alloc_config.estimated_bw);
-		link->dpia_bw_alloc_config.response_ready = false;
 
 		/*
 		 * If FAIL then it is either:
@@ -326,68 +338,34 @@ void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t res
 
 	case DPIA_BW_REQ_SUCCESS:
 
-		DC_LOG_DEBUG("%s: *** BW REQ SUCCESS for DP-TX Request ***\n", __func__);
-
-		// 1. SUCCESS 1st time before any Pruning is done
-		// 2. SUCCESS after prev. FAIL before any Pruning is done
-		// 3. SUCCESS after Pruning is done but before enabling link
-
 		bw_needed = bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
 
-		// 1.
-		if (!link->dpia_bw_alloc_config.sink_allocated_bw) {
-
-			allocate_usb4_bw(&link->dpia_bw_alloc_config.sink_allocated_bw, bw_needed, link);
-			link->dpia_bw_alloc_config.sink_verified_bw =
-					link->dpia_bw_alloc_config.sink_allocated_bw;
+		DC_LOG_DEBUG("%s: BW REQ SUCCESS for DP-TX Request for link(%d)\n",
+			__func__, link->link_index);
+		DC_LOG_DEBUG("%s: current allocated_bw(%d), new allocated_bw(%d)\n",
+			__func__, link->dpia_bw_alloc_config.sink_allocated_bw, bw_needed);
 
-			// SUCCESS from first attempt
-			if (link->dpia_bw_alloc_config.sink_allocated_bw >
-			link->dpia_bw_alloc_config.sink_max_bw)
-				link->dpia_bw_alloc_config.sink_verified_bw =
-						link->dpia_bw_alloc_config.sink_max_bw;
-		}
-		// 3.
-		else if (link->dpia_bw_alloc_config.sink_allocated_bw) {
-
-			// Find out how much do we need to de-alloc
-			if (link->dpia_bw_alloc_config.sink_allocated_bw > bw_needed)
-				deallocate_usb4_bw(&link->dpia_bw_alloc_config.sink_allocated_bw,
-						link->dpia_bw_alloc_config.sink_allocated_bw - bw_needed, link);
-			else
-				allocate_usb4_bw(&link->dpia_bw_alloc_config.sink_allocated_bw,
-						bw_needed - link->dpia_bw_alloc_config.sink_allocated_bw, link);
-		}
-
-		// 4. If this is the 2nd sink then any unused bw will be reallocated to master DPIA
-		// => check if estimated_bw changed
+		link->dpia_bw_alloc_config.sink_allocated_bw = bw_needed;
 
 		link->dpia_bw_alloc_config.response_ready = true;
 		break;
 
 	case DPIA_EST_BW_CHANGED:
 
-		DC_LOG_DEBUG("%s: *** ESTIMATED BW CHANGED for DP-TX Request ***\n", __func__);
-
 		estimated = bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
-		host_router_total_estimated_bw = get_host_router_total_bw(link, HOST_ROUTER_BW_ESTIMATED);
 
-		// 1. If due to unplug of other sink
-		if (estimated == host_router_total_estimated_bw) {
-			// First update the estimated & max_bw fields
-			if (link->dpia_bw_alloc_config.estimated_bw < estimated)
-				link->dpia_bw_alloc_config.estimated_bw = estimated;
-		}
-		// 2. If due to realloc bw btw 2 dpia due to plug OR realloc unused Bw
-		else {
-			// We lost estimated bw usually due to plug event of other dpia
-			link->dpia_bw_alloc_config.estimated_bw = estimated;
-		}
+		DC_LOG_DEBUG("%s: ESTIMATED BW CHANGED for link(%d)\n",
+			__func__, link->link_index);
+		DC_LOG_DEBUG("%s: current estimated_bw(%d), new estimated_bw(%d)\n",
+			__func__, link->dpia_bw_alloc_config.estimated_bw, estimated);
+
+		link->dpia_bw_alloc_config.estimated_bw = estimated;
 		break;
 
 	case DPIA_BW_ALLOC_CAPS_CHANGED:
 
-		DC_LOG_DEBUG("%s: *** BW ALLOC CAPABILITY CHANGED for DP-TX Request ***\n", __func__);
+		DC_LOG_ERROR("%s: BW ALLOC CAPABILITY CHANGED to Disabled for link(%d)\n",
+			__func__, link->link_index);
 		link->dpia_bw_alloc_config.bw_alloc_enabled = false;
 		break;
 	}
@@ -409,11 +387,11 @@ int dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int pea
 		set_usb4_req_bw_req(link, link->dpia_bw_alloc_config.sink_max_bw);
 
 		do {
-			if (!(timeout > 0))
+			if (timeout > 0)
 				timeout--;
 			else
 				break;
-			fsleep(10 * 1000);
+			msleep(10);
 		} while (!get_cm_response_ready_flag(link));
 
 		if (!timeout)
@@ -428,37 +406,36 @@ int dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int pea
 out:
 	return ret;
 }
-int link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int req_bw)
+
+bool link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int req_bw)
 {
-	int ret = 0;
+	bool ret = false;
 	uint8_t timeout = 10;
 
+	DC_LOG_DEBUG("%s: ENTER: link(%d), hpd_status(%d), current allocated_bw(%d), req_bw(%d)\n",
+		__func__, link->link_index, link->hpd_status,
+		link->dpia_bw_alloc_config.sink_allocated_bw, req_bw);
+
 	if (!get_bw_alloc_proceed_flag(link))
 		goto out;
 
-	/*
-	 * Sometimes stream uses same timing parameters as the already
-	 * allocated max sink bw so no need to re-alloc
-	 */
-	if (req_bw != link->dpia_bw_alloc_config.sink_allocated_bw) {
-		set_usb4_req_bw_req(link, req_bw);
-		do {
-			if (!(timeout > 0))
-				timeout--;
-			else
-				break;
-			udelay(10 * 1000);
-		} while (!get_cm_response_ready_flag(link));
+	set_usb4_req_bw_req(link, req_bw);
+	do {
+		if (timeout > 0)
+			timeout--;
+		else
+			break;
+		msleep(10);
+	} while (!get_cm_response_ready_flag(link));
 
-		if (!timeout)
-			ret = 0;// ERROR TIMEOUT waiting for response for allocating bw
-		else if (link->dpia_bw_alloc_config.sink_allocated_bw > 0)
-			ret = get_host_router_total_bw(link, HOST_ROUTER_BW_ALLOCATED);
-	}
+	if (timeout)
+		ret = true;
 
 out:
+	DC_LOG_DEBUG("%s: EXIT: timeout(%d), ret(%d)\n", __func__, timeout, ret);
 	return ret;
 }
+
 bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed_per_dpia, const unsigned int num_dpias)
 {
 	bool ret = true;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
index 7292690383ae..981bc4eb6120 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
@@ -59,9 +59,9 @@ bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link);
  * @link: pointer to the dc_link struct instance
  * @req_bw: Bw requested by the stream
  *
- * return: allocated bw else return 0
+ * return: true if allocated successfully
  */
-int link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int req_bw);
+bool link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int req_bw);
 
 /*
  * Handle the USB4 BW Allocation related functionality here:
-- 
2.43.0


