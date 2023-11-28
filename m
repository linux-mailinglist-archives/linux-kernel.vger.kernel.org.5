Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C407FB210
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjK1GkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjK1GkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:40:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C51B194;
        Mon, 27 Nov 2023 22:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701153608; x=1732689608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lH2TN34CUFQU5hAf3pr7Vjg8a3BXiSZCqeRM4bcgPlw=;
  b=K3v9Mp2RfbVSebX3npUkcoyYcNZ5hzycE1SSy+SfnIGRbqPpJ26qx7Pl
   6dFtIuGJqD8q64tmiudxJqGo3gWRNhIyshrQhLpMkV2PAI7iUj7EPu2aV
   KEb9XG+KzpFI64GbnUa8IRYhw/Hh4hMTiSklFc3MLb8ERmpwnyOxS3Mkh
   PIL0nyyoLZ1u5l4Lxg7JxJY0zpSksnm5syxPfeLulXjgsspMKEqE/ndBc
   FxQFDaV4uluzJ5IUTvEQaKbQlmKkQ0FkIuZQOam/JeMvFKTfO3DiC9FB9
   Ifq/SZD4q6qOoJ21fg2wf8haWC48OfpyXTbdChmUYQF5r2Td4cUs45a1b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="373031922"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="373031922"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 22:40:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="718288182"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="718288182"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 22:40:05 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 9768C11F76A;
        Tue, 28 Nov 2023 08:40:02 +0200 (EET)
Date:   Tue, 28 Nov 2023 06:40:02 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] media: i2c: st-mipid02: use active state to store
 pad formats
Message-ID: <ZWWLQkjvovzJMc73@kekkonen.localdomain>
References: <20231125182057.1379357-1-alain.volmat@foss.st.com>
 <20231125182057.1379357-5-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125182057.1379357-5-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 07:20:52PM +0100, Alain Volmat wrote:
> Store formats information within pad allowing to simplify further more
> the driver (mutex / format store within the driver structure no more
> necessary).
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>

Applied with the following diff:

diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index 7af209905d7b..2cc07b3ed0da 100644
--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -563,8 +563,8 @@ static const struct v4l2_mbus_framefmt default_fmt = {
 	.height = 480,
 };
 
-static int mipid02_init_cfg(struct v4l2_subdev *sd,
-			    struct v4l2_subdev_state *state)
+static int mipid02_init_state(struct v4l2_subdev *sd,
+			      struct v4l2_subdev_state *state)
 {
 	*v4l2_subdev_state_get_format(state, MIPID02_SINK_0) = default_fmt;
 	/* MIPID02_SINK_1 isn't supported yet */
@@ -642,7 +642,6 @@ static const struct v4l2_subdev_video_ops mipid02_video_ops = {
 };
 
 static const struct v4l2_subdev_pad_ops mipid02_pad_ops = {
-	.init_cfg = mipid02_init_cfg,
 	.enum_mbus_code = mipid02_enum_mbus_code,
 	.get_fmt = v4l2_subdev_get_fmt,
 	.set_fmt = mipid02_set_fmt,
@@ -653,6 +652,10 @@ static const struct v4l2_subdev_ops mipid02_subdev_ops = {
 	.pad = &mipid02_pad_ops,
 };
 
+static const struct v4l2_subdev_internal_ops mipid02_subdev_internal_ops = {
+	.init_state = mipid02_init_state,
+};
+
 static const struct media_entity_operations mipid02_subdev_entity_ops = {
 	.link_validate = v4l2_subdev_link_validate,
 };
@@ -851,6 +854,7 @@ static int mipid02_probe(struct i2c_client *client)
 
 	bridge->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 	bridge->sd.entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
+	bridge->sd.internal_ops = &mipid02_subdev_internal_ops;
 	bridge->sd.entity.ops = &mipid02_subdev_entity_ops;
 	bridge->pad[0].flags = MEDIA_PAD_FL_SINK;
 	bridge->pad[1].flags = MEDIA_PAD_FL_SINK;

-- 
Sakari Ailus
