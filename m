Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A927608CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 06:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjGYEoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 00:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjGYEn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 00:43:58 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB28173F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 21:43:54 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R94DP2XGnzBRydY
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:43:49 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1690260229; x=1692852230; bh=yoXvsWFvf4lKS3sGNABj8yYPLom
        //8oxSw6PzoA5XC0=; b=cfdL1uME29Wi+vu6AB8vmDcXtRTcjiQtd491WU8OtKD
        Eq4UhKsYI78gbMHXrARnLoZCBoPrwDfqXWRup6h7le1dyQ6E9lgJ02hHPDyb22no
        U5aXzR00sAWLmJPF4kAEddNaontPwdns1JtIuQmCzd3jdlk/+EKlYxKHsfVLbWK7
        myVNDmYX19MrjlY/H3ynRg7ha8NmrHk1cib7blpapztwxUXjFJHTJGh8uqvPHfBE
        SCW1C0ceXdeQKLdWXDIFUKZttdnLQa2OdvrCBPfsdNVABlWiBTD6uFCVTDO2dNr4
        QR5cjGrFFvBpWL/zxgkrwnttEY49GI34LGnrChiSACw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id k2m7NmeAlmmy for <linux-kernel@vger.kernel.org>;
        Tue, 25 Jul 2023 12:43:49 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R94DN6rDnzBRDrQ;
        Tue, 25 Jul 2023 12:43:48 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 25 Jul 2023 12:43:48 +0800
From:   wuyonggang001@208suo.com
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: Fix format error
In-Reply-To: <20230725043946.33470-1-zhanglibing@cdjrlc.com>
References: <20230725043946.33470-1-zhanglibing@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <6bf7217253d188c37004e8793bd58c88@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the error(s):

ERROR: space required before the open parenthesis '('

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  drivers/gpu/drm/radeon/r300.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r300.c 
b/drivers/gpu/drm/radeon/r300.c
index 9c1a92fa2af6..25201b9a5aae 100644
--- a/drivers/gpu/drm/radeon/r300.c
+++ b/drivers/gpu/drm/radeon/r300.c
@@ -249,7 +249,7 @@ void r300_ring_start(struct radeon_device *rdev, 
struct radeon_ring *ring)

  	/* Sub pixel 1/12 so we can have 4K rendering according to doc */
  	gb_tile_config = (R300_ENABLE_TILING | R300_TILE_SIZE_16);
-	switch(rdev->num_gb_pipes) {
+	switch (rdev->num_gb_pipes) {
  	case 2:
  		gb_tile_config |= R300_PIPE_COUNT_R300;
  		break;
@@ -638,7 +638,7 @@ static int r300_packet0_check(struct 
radeon_cs_parser *p,
  	track = (struct r100_cs_track *)p->track;
  	idx_value = radeon_get_ib_value(p, idx);

-	switch(reg) {
+	switch (reg) {
  	case AVIVO_D1MODE_VLINE_START_END:
  	case RADEON_CRTC_GUI_TRIG_VLINE:
  		r = r100_cs_packet_parse_vline(p);
@@ -1180,7 +1180,7 @@ static int r300_packet3_check(struct 
radeon_cs_parser *p,
  	ib = p->ib.ptr;
  	idx = pkt->idx + 1;
  	track = (struct r100_cs_track *)p->track;
-	switch(pkt->opcode) {
+	switch (pkt->opcode) {
  	case PACKET3_3D_LOAD_VBPNTR:
  		r = r100_packet3_load_vbpntr(p, pkt, idx);
  		if (r)
