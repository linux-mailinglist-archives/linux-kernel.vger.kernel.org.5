Return-Path: <linux-kernel+bounces-44039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A2B841C85
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F050D1F26313
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65A753811;
	Tue, 30 Jan 2024 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="JShZgITq"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CE6524B5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706599369; cv=none; b=YsTq+6iI4VC7IqicVPQ6CSH2+TfQO4vEHYSNjuqxXlKqo9yamcss49IdmRuqf1x5hEv9YIXx6MaXv/kdUEaZf4fvc1dcSpomuE+Hgw5Iu63U1fiAqU/Fp4n0xm8r88y2NUKS2qC00AYj9I9FDjufoKiEHaN8FRTM+kIcvlujj4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706599369; c=relaxed/simple;
	bh=4wZVQ3MUPqyb++XM31Vg0f+fvdVh4WwymBV9Pwxx+Wo=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=s96Vv1F5q5hVPgtm4eK1s+tfNmYK/PrxQXshU4lchGYOA8uvm9XAKrXT2GEHBTIo9FVy3u5eTY7KWCijiEBTjrft2MgZHOx/9sYmpae0PXlMDat9opxv9ZzzVNWhxFvGwT8vHm8U4aoiKqcGdAzhuiEpY8lFb2fv4svLqakgVhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=JShZgITq; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Be2/IX5yY4GnnQoffKQ6fzMwghvWr6gj4nbJ8T3Jk88=;
  b=JShZgITqkmO27GrFH+GlSvHgFMTJ5RRaI6qK8qulGnntFeterIckIQyB
   9AbBY1VYJEcMLgrH4c2OFUyM+tapMk7j7N2VAuBY2bc12vm2tzWwcVGiq
   triK8mjdkVHxnfNULyb6p9m7kSpPT28qgP/m5cAwjrP0MxzDDUHdoylRX
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,707,1701126000"; 
   d="scan'208";a="78173033"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 08:22:40 +0100
Date: Tue, 30 Jan 2024 08:22:40 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
cc: Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>, 
    linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:9191:2-15: alloc
 with no test, possible model on line 9296 (fwd)
Message-ID: <alpine.DEB.2.22.394.2401300821440.3800@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

It would be good to make a NULL test for the kzalloc on line 9191.

julia

---------- Forwarded message ----------
Date: Tue, 30 Jan 2024 06:48:05 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:9191:2-15: alloc with
     no test, possible model on line 9296

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
CC: Alex Hung <alex.hung@amd.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   41bccc98fb7931d63d03f326a746ac4d429c1dd3
commit: b2139c96dc954b58b81bc670fc4ea5f034ed062c drm/amd/display: Drop 'acrtc' and add 'new_crtc_state' NULL check for writeback requests.
date:   11 days ago
:::::: branch date: 22 hours ago
:::::: commit date: 11 days ago
config: x86_64-randconfig-104-20240129 (https://download.01.org/0day-ci/archive/20240130/202401300629.ICnCt983-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202401300629.ICnCt983-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:9191:2-15: alloc with no test, possible model on line 9296

vim +9191 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

c81e13b929df2fd Alex Hung            2023-12-01  8952
fff7b95a5046be0 Alan Liu             2023-06-27  8953  /**
fff7b95a5046be0 Alan Liu             2023-06-27  8954   * amdgpu_dm_atomic_commit_tail() - AMDgpu DM's commit tail implementation.
fff7b95a5046be0 Alan Liu             2023-06-27  8955   * @state: The atomic state to commit
fff7b95a5046be0 Alan Liu             2023-06-27  8956   *
fff7b95a5046be0 Alan Liu             2023-06-27  8957   * This will tell DC to commit the constructed DC state from atomic_check,
fff7b95a5046be0 Alan Liu             2023-06-27  8958   * programming the hardware. Any failures here implies a hardware failure, since
fff7b95a5046be0 Alan Liu             2023-06-27  8959   * atomic check should have filtered anything non-kosher.
fff7b95a5046be0 Alan Liu             2023-06-27  8960   */
fff7b95a5046be0 Alan Liu             2023-06-27  8961  static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
fff7b95a5046be0 Alan Liu             2023-06-27  8962  {
fff7b95a5046be0 Alan Liu             2023-06-27  8963  	struct drm_device *dev = state->dev;
fff7b95a5046be0 Alan Liu             2023-06-27  8964  	struct amdgpu_device *adev = drm_to_adev(dev);
fff7b95a5046be0 Alan Liu             2023-06-27  8965  	struct amdgpu_display_manager *dm = &adev->dm;
fff7b95a5046be0 Alan Liu             2023-06-27  8966  	struct dm_atomic_state *dm_state;
fff7b95a5046be0 Alan Liu             2023-06-27  8967  	struct dc_state *dc_state = NULL;
fff7b95a5046be0 Alan Liu             2023-06-27  8968  	u32 i, j;
fff7b95a5046be0 Alan Liu             2023-06-27  8969  	struct drm_crtc *crtc;
fff7b95a5046be0 Alan Liu             2023-06-27  8970  	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
fff7b95a5046be0 Alan Liu             2023-06-27  8971  	unsigned long flags;
fff7b95a5046be0 Alan Liu             2023-06-27  8972  	bool wait_for_vblank = true;
fff7b95a5046be0 Alan Liu             2023-06-27  8973  	struct drm_connector *connector;
fff7b95a5046be0 Alan Liu             2023-06-27  8974  	struct drm_connector_state *old_con_state, *new_con_state;
fff7b95a5046be0 Alan Liu             2023-06-27  8975  	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
fff7b95a5046be0 Alan Liu             2023-06-27  8976  	int crtc_disable_count = 0;
fff7b95a5046be0 Alan Liu             2023-06-27  8977
fff7b95a5046be0 Alan Liu             2023-06-27  8978  	trace_amdgpu_dm_atomic_commit_tail_begin(state);
fff7b95a5046be0 Alan Liu             2023-06-27  8979
06b1661e45b4a58 Qingqing Zhuo        2023-08-03  8980  	if (dm->dc->caps.ips_support) {
06b1661e45b4a58 Qingqing Zhuo        2023-08-03  8981  		for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
06b1661e45b4a58 Qingqing Zhuo        2023-08-03  8982  			if (new_con_state->crtc &&
06b1661e45b4a58 Qingqing Zhuo        2023-08-03  8983  				new_con_state->crtc->state->active &&
06b1661e45b4a58 Qingqing Zhuo        2023-08-03  8984  				drm_atomic_crtc_needs_modeset(new_con_state->crtc->state)) {
8e57c06bf4b0f51 Nicholas Kazlauskas  2023-12-04  8985  				dc_dmub_srv_apply_idle_power_optimizations(dm->dc, false);
06b1661e45b4a58 Qingqing Zhuo        2023-08-03  8986  				break;
06b1661e45b4a58 Qingqing Zhuo        2023-08-03  8987  			}
06b1661e45b4a58 Qingqing Zhuo        2023-08-03  8988  		}
06b1661e45b4a58 Qingqing Zhuo        2023-08-03  8989  	}
06b1661e45b4a58 Qingqing Zhuo        2023-08-03  8990
fff7b95a5046be0 Alan Liu             2023-06-27  8991  	drm_atomic_helper_update_legacy_modeset_state(dev, state);
fff7b95a5046be0 Alan Liu             2023-06-27  8992  	drm_dp_mst_atomic_wait_for_dependencies(state);
fff7b95a5046be0 Alan Liu             2023-06-27  8993
fff7b95a5046be0 Alan Liu             2023-06-27  8994  	dm_state = dm_atomic_get_new_state(state);
fff7b95a5046be0 Alan Liu             2023-06-27  8995  	if (dm_state && dm_state->context) {
fff7b95a5046be0 Alan Liu             2023-06-27  8996  		dc_state = dm_state->context;
fff7b95a5046be0 Alan Liu             2023-06-27  8997  		amdgpu_dm_commit_streams(state, dc_state);
fff7b95a5046be0 Alan Liu             2023-06-27  8998  	}
fff7b95a5046be0 Alan Liu             2023-06-27  8999
0c8620d63d41fb0 Bhawanpreet Lakha    2019-09-16  9000  	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
0c8620d63d41fb0 Bhawanpreet Lakha    2019-09-16  9001  		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
0c8620d63d41fb0 Bhawanpreet Lakha    2019-09-16  9002  		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
7db7ade270ae8e1 Harry Wentland       2023-12-01  9003  		struct amdgpu_dm_connector *aconnector;
7db7ade270ae8e1 Harry Wentland       2023-12-01  9004
7db7ade270ae8e1 Harry Wentland       2023-12-01  9005  		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
7db7ade270ae8e1 Harry Wentland       2023-12-01  9006  			continue;
7db7ade270ae8e1 Harry Wentland       2023-12-01  9007
7db7ade270ae8e1 Harry Wentland       2023-12-01  9008  		aconnector = to_amdgpu_dm_connector(connector);
0c8620d63d41fb0 Bhawanpreet Lakha    2019-09-16  9009
3cf7cd3f770a0b8 Hersen Wu            2023-03-28  9010  		if (!adev->dm.hdcp_workqueue)
3cf7cd3f770a0b8 Hersen Wu            2023-03-28  9011  			continue;
3cf7cd3f770a0b8 Hersen Wu            2023-03-28  9012
e8fd3eeb5e8711a hersen wu            2022-11-15  9013  		pr_debug("[HDCP_DM] -------------- i : %x ----------\n", i);
e8fd3eeb5e8711a hersen wu            2022-11-15  9014
e8fd3eeb5e8711a hersen wu            2022-11-15  9015  		if (!connector)
e8fd3eeb5e8711a hersen wu            2022-11-15  9016  			continue;
e8fd3eeb5e8711a hersen wu            2022-11-15  9017
e8fd3eeb5e8711a hersen wu            2022-11-15  9018  		pr_debug("[HDCP_DM] connector->index: %x connect_status: %x dpms: %x\n",
e8fd3eeb5e8711a hersen wu            2022-11-15  9019  			connector->index, connector->status, connector->dpms);
e8fd3eeb5e8711a hersen wu            2022-11-15  9020  		pr_debug("[HDCP_DM] state protection old: %x new: %x\n",
e8fd3eeb5e8711a hersen wu            2022-11-15  9021  			old_con_state->content_protection, new_con_state->content_protection);
e8fd3eeb5e8711a hersen wu            2022-11-15  9022
e8fd3eeb5e8711a hersen wu            2022-11-15  9023  		if (aconnector->dc_sink) {
e8fd3eeb5e8711a hersen wu            2022-11-15  9024  			if (aconnector->dc_sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
e8fd3eeb5e8711a hersen wu            2022-11-15  9025  				aconnector->dc_sink->sink_signal != SIGNAL_TYPE_NONE) {
e8fd3eeb5e8711a hersen wu            2022-11-15  9026  				pr_debug("[HDCP_DM] pipe_ctx dispname=%s\n",
e8fd3eeb5e8711a hersen wu            2022-11-15  9027  				aconnector->dc_sink->edid_caps.display_name);
e8fd3eeb5e8711a hersen wu            2022-11-15  9028  			}
e8fd3eeb5e8711a hersen wu            2022-11-15  9029  		}
e8fd3eeb5e8711a hersen wu            2022-11-15  9030
0c8620d63d41fb0 Bhawanpreet Lakha    2019-09-16  9031  		new_crtc_state = NULL;
e8fd3eeb5e8711a hersen wu            2022-11-15  9032  		old_crtc_state = NULL;
0c8620d63d41fb0 Bhawanpreet Lakha    2019-09-16  9033
e8fd3eeb5e8711a hersen wu            2022-11-15  9034  		if (acrtc) {
0c8620d63d41fb0 Bhawanpreet Lakha    2019-09-16  9035  			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
e8fd3eeb5e8711a hersen wu            2022-11-15  9036  			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
e8fd3eeb5e8711a hersen wu            2022-11-15  9037  		}
e8fd3eeb5e8711a hersen wu            2022-11-15  9038
e8fd3eeb5e8711a hersen wu            2022-11-15  9039  		if (old_crtc_state)
e8fd3eeb5e8711a hersen wu            2022-11-15  9040  			pr_debug("old crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
e8fd3eeb5e8711a hersen wu            2022-11-15  9041  			old_crtc_state->enable,
e8fd3eeb5e8711a hersen wu            2022-11-15  9042  			old_crtc_state->active,
e8fd3eeb5e8711a hersen wu            2022-11-15  9043  			old_crtc_state->mode_changed,
e8fd3eeb5e8711a hersen wu            2022-11-15  9044  			old_crtc_state->active_changed,
e8fd3eeb5e8711a hersen wu            2022-11-15  9045  			old_crtc_state->connectors_changed);
e8fd3eeb5e8711a hersen wu            2022-11-15  9046
e8fd3eeb5e8711a hersen wu            2022-11-15  9047  		if (new_crtc_state)
e8fd3eeb5e8711a hersen wu            2022-11-15  9048  			pr_debug("NEW crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
e8fd3eeb5e8711a hersen wu            2022-11-15  9049  			new_crtc_state->enable,
e8fd3eeb5e8711a hersen wu            2022-11-15  9050  			new_crtc_state->active,
e8fd3eeb5e8711a hersen wu            2022-11-15  9051  			new_crtc_state->mode_changed,
e8fd3eeb5e8711a hersen wu            2022-11-15  9052  			new_crtc_state->active_changed,
e8fd3eeb5e8711a hersen wu            2022-11-15  9053  			new_crtc_state->connectors_changed);
e8fd3eeb5e8711a hersen wu            2022-11-15  9054  	}
e8fd3eeb5e8711a hersen wu            2022-11-15  9055
e8fd3eeb5e8711a hersen wu            2022-11-15  9056  	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
e8fd3eeb5e8711a hersen wu            2022-11-15  9057  		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
e8fd3eeb5e8711a hersen wu            2022-11-15  9058  		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
e8fd3eeb5e8711a hersen wu            2022-11-15  9059  		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
e8fd3eeb5e8711a hersen wu            2022-11-15  9060
3cf7cd3f770a0b8 Hersen Wu            2023-03-28  9061  		if (!adev->dm.hdcp_workqueue)
3cf7cd3f770a0b8 Hersen Wu            2023-03-28  9062  			continue;
3cf7cd3f770a0b8 Hersen Wu            2023-03-28  9063
e8fd3eeb5e8711a hersen wu            2022-11-15  9064  		new_crtc_state = NULL;
e8fd3eeb5e8711a hersen wu            2022-11-15  9065  		old_crtc_state = NULL;
e8fd3eeb5e8711a hersen wu            2022-11-15  9066
e8fd3eeb5e8711a hersen wu            2022-11-15  9067  		if (acrtc) {
e8fd3eeb5e8711a hersen wu            2022-11-15  9068  			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
e8fd3eeb5e8711a hersen wu            2022-11-15  9069  			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
e8fd3eeb5e8711a hersen wu            2022-11-15  9070  		}
0c8620d63d41fb0 Bhawanpreet Lakha    2019-09-16  9071
0c8620d63d41fb0 Bhawanpreet Lakha    2019-09-16  9072  		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
0c8620d63d41fb0 Bhawanpreet Lakha    2019-09-16  9073
0c8620d63d41fb0 Bhawanpreet Lakha    2019-09-16  9074  		if (dm_new_crtc_state && dm_new_crtc_state->stream == NULL &&
0c8620d63d41fb0 Bhawanpreet Lakha    2019-09-16  9075  		    connector->state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED) {
0c8620d63d41fb0 Bhawanpreet Lakha    2019-09-16  9076  			hdcp_reset_display(adev->dm.hdcp_workqueue, aconnector->dc_link->link_index);
0c8620d63d41fb0 Bhawanpreet Lakha    2019-09-16  9077  			new_con_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
97f6c91787d9fc5 Bhawanpreet Lakha    2019-09-26  9078  			dm_new_con_state->update_hdcp = true;
0c8620d63d41fb0 Bhawanpreet Lakha    2019-09-16  9079  			continue;
0c8620d63d41fb0 Bhawanpreet Lakha    2019-09-16  9080  		}
0c8620d63d41fb0 Bhawanpreet Lakha    2019-09-16  9081
e8fd3eeb5e8711a hersen wu            2022-11-15  9082  		if (is_content_protection_different(new_crtc_state, old_crtc_state, new_con_state,
e8fd3eeb5e8711a hersen wu            2022-11-15  9083  											old_con_state, connector, adev->dm.hdcp_workqueue)) {
82986fd631fa04b hersen wu            2022-11-15  9084  			/* when display is unplugged from mst hub, connctor will
82986fd631fa04b hersen wu            2022-11-15  9085  			 * be destroyed within dm_dp_mst_connector_destroy. connector
82986fd631fa04b hersen wu            2022-11-15  9086  			 * hdcp perperties, like type, undesired, desired, enabled,
82986fd631fa04b hersen wu            2022-11-15  9087  			 * will be lost. So, save hdcp properties into hdcp_work within
82986fd631fa04b hersen wu            2022-11-15  9088  			 * amdgpu_dm_atomic_commit_tail. if the same display is
82986fd631fa04b hersen wu            2022-11-15  9089  			 * plugged back with same display index, its hdcp properties
82986fd631fa04b hersen wu            2022-11-15  9090  			 * will be retrieved from hdcp_work within dm_dp_mst_get_modes
82986fd631fa04b hersen wu            2022-11-15  9091  			 */
82986fd631fa04b hersen wu            2022-11-15  9092
e8fd3eeb5e8711a hersen wu            2022-11-15  9093  			bool enable_encryption = false;
e8fd3eeb5e8711a hersen wu            2022-11-15  9094
e8fd3eeb5e8711a hersen wu            2022-11-15  9095  			if (new_con_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED)
e8fd3eeb5e8711a hersen wu            2022-11-15  9096  				enable_encryption = true;
e8fd3eeb5e8711a hersen wu            2022-11-15  9097
82986fd631fa04b hersen wu            2022-11-15  9098  			if (aconnector->dc_link && aconnector->dc_sink &&
82986fd631fa04b hersen wu            2022-11-15  9099  				aconnector->dc_link->type == dc_connection_mst_branch) {
82986fd631fa04b hersen wu            2022-11-15  9100  				struct hdcp_workqueue *hdcp_work = adev->dm.hdcp_workqueue;
82986fd631fa04b hersen wu            2022-11-15  9101  				struct hdcp_workqueue *hdcp_w =
82986fd631fa04b hersen wu            2022-11-15  9102  					&hdcp_work[aconnector->dc_link->link_index];
82986fd631fa04b hersen wu            2022-11-15  9103
82986fd631fa04b hersen wu            2022-11-15  9104  				hdcp_w->hdcp_content_type[connector->index] =
82986fd631fa04b hersen wu            2022-11-15  9105  					new_con_state->hdcp_content_type;
82986fd631fa04b hersen wu            2022-11-15  9106  				hdcp_w->content_protection[connector->index] =
82986fd631fa04b hersen wu            2022-11-15  9107  					new_con_state->content_protection;
82986fd631fa04b hersen wu            2022-11-15  9108  			}
82986fd631fa04b hersen wu            2022-11-15  9109
e8fd3eeb5e8711a hersen wu            2022-11-15  9110  			if (new_crtc_state && new_crtc_state->mode_changed &&
e8fd3eeb5e8711a hersen wu            2022-11-15  9111  				new_con_state->content_protection >= DRM_MODE_CONTENT_PROTECTION_DESIRED)
e8fd3eeb5e8711a hersen wu            2022-11-15  9112  				enable_encryption = true;
e8fd3eeb5e8711a hersen wu            2022-11-15  9113
e8fd3eeb5e8711a hersen wu            2022-11-15  9114  			DRM_INFO("[HDCP_DM] hdcp_update_display enable_encryption = %x\n", enable_encryption);
e8fd3eeb5e8711a hersen wu            2022-11-15  9115
b1abe5586ffcb15 Bhawanpreet Lakha    2019-08-28  9116  			hdcp_update_display(
b1abe5586ffcb15 Bhawanpreet Lakha    2019-08-28  9117  				adev->dm.hdcp_workqueue, aconnector->dc_link->link_index, aconnector,
e8fd3eeb5e8711a hersen wu            2022-11-15  9118  				new_con_state->hdcp_content_type, enable_encryption);
0c8620d63d41fb0 Bhawanpreet Lakha    2019-09-16  9119  		}
0c8620d63d41fb0 Bhawanpreet Lakha    2019-09-16  9120  	}
e7b07ceef2a650e Harry Wentland       2017-08-10  9121
02d6a6fcdf68c4d David Francis        2018-12-18  9122  	/* Handle connector state changes */
c2cea7063b85fc2 Leo (Sunpeng  Li     2017-10-12  9123) 	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
54d76575246798f Leo (Sunpeng  Li     2017-10-12  9124) 		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
54d76575246798f Leo (Sunpeng  Li     2017-10-12  9125) 		struct dm_connector_state *dm_old_con_state = to_dm_connector_state(old_con_state);
54d76575246798f Leo (Sunpeng  Li     2017-10-12  9126) 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
135fd1b35690b8b Rodrigo Siqueira     2023-06-21  9127  		struct dc_surface_update *dummy_updates;
19afd79951e6303 Nathan Chancellor    2019-02-01  9128  		struct dc_stream_update stream_update;
b232d4ed92eafb0 Nicholas Kazlauskas  2019-05-28  9129  		struct dc_info_packet hdr_packet;
e7b07ceef2a650e Harry Wentland       2017-08-10  9130  		struct dc_stream_status *status = NULL;
b232d4ed92eafb0 Nicholas Kazlauskas  2019-05-28  9131  		bool abm_changed, hdr_changed, scaling_changed;
e7b07ceef2a650e Harry Wentland       2017-08-10  9132
19afd79951e6303 Nathan Chancellor    2019-02-01  9133  		memset(&stream_update, 0, sizeof(stream_update));
19afd79951e6303 Nathan Chancellor    2019-02-01  9134
44d09c6a577c8ed Harry Wentland       2018-03-15  9135  		if (acrtc) {
0bc9706db3a35b6 Leo (Sunpeng  Li     2017-10-12  9136) 			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
44d09c6a577c8ed Harry Wentland       2018-03-15  9137  			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
44d09c6a577c8ed Harry Wentland       2018-03-15  9138  		}
0bc9706db3a35b6 Leo (Sunpeng  Li     2017-10-12  9139)
e7b07ceef2a650e Harry Wentland       2017-08-10  9140  		/* Skip any modesets/resets */
0bc9706db3a35b6 Leo (Sunpeng  Li     2017-10-12  9141) 		if (!acrtc || drm_atomic_crtc_needs_modeset(new_crtc_state))
e7b07ceef2a650e Harry Wentland       2017-08-10  9142  			continue;
e7b07ceef2a650e Harry Wentland       2017-08-10  9143
54d76575246798f Leo (Sunpeng  Li     2017-10-12  9144) 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
c1ee92f94ce3b9a David Francis        2018-11-26  9145  		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
c1ee92f94ce3b9a David Francis        2018-11-26  9146
b232d4ed92eafb0 Nicholas Kazlauskas  2019-05-28  9147  		scaling_changed = is_scaling_state_different(dm_new_con_state,
b232d4ed92eafb0 Nicholas Kazlauskas  2019-05-28  9148  							     dm_old_con_state);
b232d4ed92eafb0 Nicholas Kazlauskas  2019-05-28  9149
b232d4ed92eafb0 Nicholas Kazlauskas  2019-05-28  9150  		abm_changed = dm_new_crtc_state->abm_level !=
b232d4ed92eafb0 Nicholas Kazlauskas  2019-05-28  9151  			      dm_old_crtc_state->abm_level;
b232d4ed92eafb0 Nicholas Kazlauskas  2019-05-28  9152
b232d4ed92eafb0 Nicholas Kazlauskas  2019-05-28  9153  		hdr_changed =
72921cdf8ac248c Maxime Ripard        2021-04-30  9154  			!drm_connector_atomic_hdr_metadata_equal(old_con_state, new_con_state);
b232d4ed92eafb0 Nicholas Kazlauskas  2019-05-28  9155
b232d4ed92eafb0 Nicholas Kazlauskas  2019-05-28  9156  		if (!scaling_changed && !abm_changed && !hdr_changed)
c1ee92f94ce3b9a David Francis        2018-11-26  9157  			continue;
e7b07ceef2a650e Harry Wentland       2017-08-10  9158
b6e881c947417e7 Dmytro Laktyushkin   2019-09-13  9159  		stream_update.stream = dm_new_crtc_state->stream;
b232d4ed92eafb0 Nicholas Kazlauskas  2019-05-28  9160  		if (scaling_changed) {
54d76575246798f Leo (Sunpeng  Li     2017-10-12  9161) 			update_stream_scaling_settings(&dm_new_con_state->base.crtc->mode,
b6e881c947417e7 Dmytro Laktyushkin   2019-09-13  9162  					dm_new_con_state, dm_new_crtc_state->stream);
e7b07ceef2a650e Harry Wentland       2017-08-10  9163
02d6a6fcdf68c4d David Francis        2018-12-18  9164  			stream_update.src = dm_new_crtc_state->stream->src;
02d6a6fcdf68c4d David Francis        2018-12-18  9165  			stream_update.dst = dm_new_crtc_state->stream->dst;
02d6a6fcdf68c4d David Francis        2018-12-18  9166  		}
02d6a6fcdf68c4d David Francis        2018-12-18  9167
b232d4ed92eafb0 Nicholas Kazlauskas  2019-05-28  9168  		if (abm_changed) {
02d6a6fcdf68c4d David Francis        2018-12-18  9169  			dm_new_crtc_state->stream->abm_level = dm_new_crtc_state->abm_level;
02d6a6fcdf68c4d David Francis        2018-12-18  9170
02d6a6fcdf68c4d David Francis        2018-12-18  9171  			stream_update.abm_level = &dm_new_crtc_state->abm_level;
02d6a6fcdf68c4d David Francis        2018-12-18  9172  		}
70e8ffc55b98f31 Harry Wentland       2017-11-10  9173
b232d4ed92eafb0 Nicholas Kazlauskas  2019-05-28  9174  		if (hdr_changed) {
b232d4ed92eafb0 Nicholas Kazlauskas  2019-05-28  9175  			fill_hdr_info_packet(new_con_state, &hdr_packet);
b232d4ed92eafb0 Nicholas Kazlauskas  2019-05-28  9176  			stream_update.hdr_static_metadata = &hdr_packet;
b232d4ed92eafb0 Nicholas Kazlauskas  2019-05-28  9177  		}
b232d4ed92eafb0 Nicholas Kazlauskas  2019-05-28  9178
54d76575246798f Leo (Sunpeng  Li     2017-10-12  9179) 		status = dc_stream_get_status(dm_new_crtc_state->stream);
57738ae40f33c89 Nirmoy Das           2021-05-27  9180
57738ae40f33c89 Nirmoy Das           2021-05-27  9181  		if (WARN_ON(!status))
57738ae40f33c89 Nirmoy Das           2021-05-27  9182  			continue;
57738ae40f33c89 Nirmoy Das           2021-05-27  9183
3be5262e353b8ab Harry Wentland       2017-07-27  9184  		WARN_ON(!status->plane_count);
e7b07ceef2a650e Harry Wentland       2017-08-10  9185
02d6a6fcdf68c4d David Francis        2018-12-18  9186  		/*
02d6a6fcdf68c4d David Francis        2018-12-18  9187  		 * TODO: DC refuses to perform stream updates without a dc_surface_update.
02d6a6fcdf68c4d David Francis        2018-12-18  9188  		 * Here we create an empty update on each plane.
02d6a6fcdf68c4d David Francis        2018-12-18  9189  		 * To fix this, DC should permit updating only stream properties.
02d6a6fcdf68c4d David Francis        2018-12-18  9190  		 */
135fd1b35690b8b Rodrigo Siqueira     2023-06-21 @9191  		dummy_updates = kzalloc(sizeof(struct dc_surface_update) * MAX_SURFACES, GFP_ATOMIC);
02d6a6fcdf68c4d David Francis        2018-12-18  9192  		for (j = 0; j < status->plane_count; j++)
efc8278eecfd5e6 Anson Jacob          2021-02-18  9193  			dummy_updates[j].surface = status->plane_states[0];
98e6436d3af5fef Anthony Koo          2018-08-21  9194
02d6a6fcdf68c4d David Francis        2018-12-18  9195
02d6a6fcdf68c4d David Francis        2018-12-18  9196  		mutex_lock(&dm->dc_lock);
f7511289821ffcc Rodrigo Siqueira     2022-10-06  9197  		dc_update_planes_and_stream(dm->dc,
efc8278eecfd5e6 Anson Jacob          2021-02-18  9198  					    dummy_updates,
3be5262e353b8ab Harry Wentland       2017-07-27  9199  					    status->plane_count,
02d6a6fcdf68c4d David Francis        2018-12-18  9200  					    dm_new_crtc_state->stream,
f7511289821ffcc Rodrigo Siqueira     2022-10-06  9201  					    &stream_update);
02d6a6fcdf68c4d David Francis        2018-12-18  9202  		mutex_unlock(&dm->dc_lock);
135fd1b35690b8b Rodrigo Siqueira     2023-06-21  9203  		kfree(dummy_updates);
e7b07ceef2a650e Harry Wentland       2017-08-10  9204  	}
e7b07ceef2a650e Harry Wentland       2017-08-10  9205
8799c0be89ebb99 Yunxiang Li          2022-09-21  9206  	/**
8799c0be89ebb99 Yunxiang Li          2022-09-21  9207  	 * Enable interrupts for CRTCs that are newly enabled or went through
8799c0be89ebb99 Yunxiang Li          2022-09-21  9208  	 * a modeset. It was intentionally deferred until after the front end
8799c0be89ebb99 Yunxiang Li          2022-09-21  9209  	 * state was modified to wait until the OTG was on and so the IRQ
8799c0be89ebb99 Yunxiang Li          2022-09-21  9210  	 * handlers didn't access stale or invalid state.
8799c0be89ebb99 Yunxiang Li          2022-09-21  9211  	 */
8799c0be89ebb99 Yunxiang Li          2022-09-21  9212  	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
8799c0be89ebb99 Yunxiang Li          2022-09-21  9213  		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
8799c0be89ebb99 Yunxiang Li          2022-09-21  9214  #ifdef CONFIG_DEBUG_FS
8799c0be89ebb99 Yunxiang Li          2022-09-21  9215  		enum amdgpu_dm_pipe_crc_source cur_crc_src;
8799c0be89ebb99 Yunxiang Li          2022-09-21  9216  #endif
b5e83f6fe1f003f Nicholas Kazlauskas  2019-04-08  9217  		/* Count number of newly disabled CRTCs for dropping PM refs later. */
fe2a19652918a52 Lyude Paul           2018-06-21  9218  		if (old_crtc_state->active && !new_crtc_state->active)
fe2a19652918a52 Lyude Paul           2018-06-21  9219  			crtc_disable_count++;
fe2a19652918a52 Lyude Paul           2018-06-21  9220
54d76575246798f Leo (Sunpeng  Li     2017-10-12  9221) 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
e1fc2dca1295c4f Leo (Sunpeng  Li     2017-10-18  9222) 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
66b0c973d7f74e3 Mario Kleiner        2019-03-29  9223
585d450c76d1d58 Aurabindo Pillai     2020-08-12  9224  		/* For freesync config update on crtc state and params for irq */
585d450c76d1d58 Aurabindo Pillai     2020-08-12  9225  		update_stream_irq_parameters(dm, dm_new_crtc_state);
057be086603feb2 Nicholas Kazlauskas  2019-04-15  9226
8e7b6fee9b03d68 Wayne Lin            2021-02-09  9227  #ifdef CONFIG_DEBUG_FS
d98af2725d42e85 Wayne Lin            2021-04-27  9228  		spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
d98af2725d42e85 Wayne Lin            2021-04-27  9229  		cur_crc_src = acrtc->dm_irq_params.crc_src;
d98af2725d42e85 Wayne Lin            2021-04-27  9230  		spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
8e7b6fee9b03d68 Wayne Lin            2021-02-09  9231  #endif
585d450c76d1d58 Aurabindo Pillai     2020-08-12  9232
8fe684e97c86e35 Nicholas Kazlauskas  2020-07-13  9233  		if (new_crtc_state->active &&
8fe684e97c86e35 Nicholas Kazlauskas  2020-07-13  9234  		    (!old_crtc_state->active ||
8fe684e97c86e35 Nicholas Kazlauskas  2020-07-13  9235  		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
585d450c76d1d58 Aurabindo Pillai     2020-08-12  9236  			dc_stream_retain(dm_new_crtc_state->stream);
585d450c76d1d58 Aurabindo Pillai     2020-08-12  9237  			acrtc->dm_irq_params.stream = dm_new_crtc_state->stream;
8fe684e97c86e35 Nicholas Kazlauskas  2020-07-13  9238  			manage_dm_interrupts(adev, acrtc, true);
8799c0be89ebb99 Yunxiang Li          2022-09-21  9239  		}
8799c0be89ebb99 Yunxiang Li          2022-09-21  9240  		/* Handle vrr on->off / off->on transitions */
8799c0be89ebb99 Yunxiang Li          2022-09-21  9241  		amdgpu_dm_handle_vrr_transition(dm_old_crtc_state, dm_new_crtc_state);
e2881d6d0a26534 Rodrigo Siqueira     2021-01-07  9242
24eb937416fde5d Rodrigo Siqueira     2021-01-07  9243  #ifdef CONFIG_DEBUG_FS
8799c0be89ebb99 Yunxiang Li          2022-09-21  9244  		if (new_crtc_state->active &&
8799c0be89ebb99 Yunxiang Li          2022-09-21  9245  		    (!old_crtc_state->active ||
8799c0be89ebb99 Yunxiang Li          2022-09-21  9246  		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
8fe684e97c86e35 Nicholas Kazlauskas  2020-07-13  9247  			/**
8fe684e97c86e35 Nicholas Kazlauskas  2020-07-13  9248  			 * Frontend may have changed so reapply the CRC capture
8fe684e97c86e35 Nicholas Kazlauskas  2020-07-13  9249  			 * settings for the stream.
8fe684e97c86e35 Nicholas Kazlauskas  2020-07-13  9250  			 */
8e7b6fee9b03d68 Wayne Lin            2021-02-09  9251  			if (amdgpu_dm_is_valid_crc_source(cur_crc_src)) {
86bc221918925a0 Wayne Lin            2021-03-02  9252  #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
d98af2725d42e85 Wayne Lin            2021-04-27  9253  				if (amdgpu_dm_crc_window_is_activated(crtc)) {
d98af2725d42e85 Wayne Lin            2021-04-27  9254  					spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
c0459bddd1955df Alan Liu             2022-10-20  9255  					acrtc->dm_irq_params.window_param.update_win = true;
1b11ff764aefc0a Alan Liu             2022-10-19  9256
1b11ff764aefc0a Alan Liu             2022-10-19  9257  					/**
1b11ff764aefc0a Alan Liu             2022-10-19  9258  					 * It takes 2 frames for HW to stably generate CRC when
1b11ff764aefc0a Alan Liu             2022-10-19  9259  					 * resuming from suspend, so we set skip_frame_cnt 2.
1b11ff764aefc0a Alan Liu             2022-10-19  9260  					 */
c0459bddd1955df Alan Liu             2022-10-20  9261  					acrtc->dm_irq_params.window_param.skip_frame_cnt = 2;
d98af2725d42e85 Wayne Lin            2021-04-27  9262  					spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
d98af2725d42e85 Wayne Lin            2021-04-27  9263  				}
86bc221918925a0 Wayne Lin            2021-03-02  9264  #endif
bbc49fc0326be4f Wayne Lin            2021-04-28  9265  				if (amdgpu_dm_crtc_configure_crc_source(
bbc49fc0326be4f Wayne Lin            2021-04-28  9266  					crtc, dm_new_crtc_state, cur_crc_src))
bbc49fc0326be4f Wayne Lin            2021-04-28  9267  					DRM_DEBUG_DRIVER("Failed to configure crc source");
8799c0be89ebb99 Yunxiang Li          2022-09-21  9268  			}
8fe684e97c86e35 Nicholas Kazlauskas  2020-07-13  9269  		}
2130b87b2273389 Nathan Chancellor    2022-10-14  9270  #endif
8fe684e97c86e35 Nicholas Kazlauskas  2020-07-13  9271  	}
e7b07ceef2a650e Harry Wentland       2017-08-10  9272
420cd472082697d David Francis        2019-03-01  9273  	for_each_new_crtc_in_state(state, crtc, new_crtc_state, j)
4d85f45c73a22bc Daniel Vetter        2019-09-03  9274  		if (new_crtc_state->async_flip)
420cd472082697d David Francis        2019-03-01  9275  			wait_for_vblank = false;
420cd472082697d David Francis        2019-03-01  9276
e7b07ceef2a650e Harry Wentland       2017-08-10  9277  	/* update planes when needed per crtc*/
5cc6dcbd45a60be Leo (Sunpeng  Li     2017-10-12  9278) 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, j) {
54d76575246798f Leo (Sunpeng  Li     2017-10-12  9279) 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
e7b07ceef2a650e Harry Wentland       2017-08-10  9280
54d76575246798f Leo (Sunpeng  Li     2017-10-12  9281) 		if (dm_new_crtc_state->stream)
fff7b95a5046be0 Alan Liu             2023-06-27  9282  			amdgpu_dm_commit_planes(state, dev, dm, crtc, wait_for_vblank);
e7b07ceef2a650e Harry Wentland       2017-08-10  9283  	}
e7b07ceef2a650e Harry Wentland       2017-08-10  9284
c81e13b929df2fd Alex Hung            2023-12-01  9285  	/* Enable writeback */
c81e13b929df2fd Alex Hung            2023-12-01  9286  	for_each_new_connector_in_state(state, connector, new_con_state, i) {
c81e13b929df2fd Alex Hung            2023-12-01  9287  		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
c81e13b929df2fd Alex Hung            2023-12-01  9288  		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
c81e13b929df2fd Alex Hung            2023-12-01  9289
c81e13b929df2fd Alex Hung            2023-12-01  9290  		if (connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
c81e13b929df2fd Alex Hung            2023-12-01  9291  			continue;
c81e13b929df2fd Alex Hung            2023-12-01  9292
c81e13b929df2fd Alex Hung            2023-12-01  9293  		if (!new_con_state->writeback_job)
c81e13b929df2fd Alex Hung            2023-12-01  9294  			continue;
c81e13b929df2fd Alex Hung            2023-12-01  9295
c81e13b929df2fd Alex Hung            2023-12-01 @9296  		new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
c81e13b929df2fd Alex Hung            2023-12-01  9297
b2139c96dc954b5 Srinivasan Shanmugam 2024-01-13  9298  		if (!new_crtc_state)
b2139c96dc954b5 Srinivasan Shanmugam 2024-01-13  9299  			continue;
b2139c96dc954b5 Srinivasan Shanmugam 2024-01-13  9300
f872e2f5f0beabd Alex Hung            2023-12-01  9301  		if (acrtc->wb_enabled)
f872e2f5f0beabd Alex Hung            2023-12-01  9302  			continue;
f872e2f5f0beabd Alex Hung            2023-12-01  9303
c81e13b929df2fd Alex Hung            2023-12-01  9304  		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
c81e13b929df2fd Alex Hung            2023-12-01  9305
c81e13b929df2fd Alex Hung            2023-12-01  9306  		dm_set_writeback(dm, dm_new_crtc_state, connector, new_con_state);
f872e2f5f0beabd Alex Hung            2023-12-01  9307  		acrtc->wb_enabled = true;
c81e13b929df2fd Alex Hung            2023-12-01  9308  	}
c81e13b929df2fd Alex Hung            2023-12-01  9309
6ce8f316673f614 Nicholas Kazlauskas  2019-07-11  9310  	/* Update audio instances for each connector. */
6ce8f316673f614 Nicholas Kazlauskas  2019-07-11  9311  	amdgpu_dm_commit_audio(dev, state);
6ce8f316673f614 Nicholas Kazlauskas  2019-07-11  9312
7230362c78d4410 Alex Deucher         2020-12-10  9313  	/* restore the backlight level */
7fd13baeb7a3a48 Alex Deucher         2021-07-08  9314  	for (i = 0; i < dm->num_of_edps; i++) {
7fd13baeb7a3a48 Alex Deucher         2021-07-08  9315  		if (dm->backlight_dev[i] &&
4052287a75eb3fc Shirish S            2022-03-11  9316  		    (dm->actual_brightness[i] != dm->brightness[i]))
7fd13baeb7a3a48 Alex Deucher         2021-07-08  9317  			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
7fd13baeb7a3a48 Alex Deucher         2021-07-08  9318  	}
83a3439ddb28e15 Hans de Goede        2022-06-20  9319
e7b07ceef2a650e Harry Wentland       2017-08-10  9320  	/*
e7b07ceef2a650e Harry Wentland       2017-08-10  9321  	 * send vblank event on all events not handled in flip and
e7b07ceef2a650e Harry Wentland       2017-08-10  9322  	 * mark consumed event for drm_atomic_helper_commit_hw_done
e7b07ceef2a650e Harry Wentland       2017-08-10  9323  	 */
4a580877bdcb837 Luben Tuikov         2020-08-24  9324  	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
0bc9706db3a35b6 Leo (Sunpeng  Li     2017-10-12  9325) 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
e7b07ceef2a650e Harry Wentland       2017-08-10  9326
0bc9706db3a35b6 Leo (Sunpeng  Li     2017-10-12  9327) 		if (new_crtc_state->event)
0bc9706db3a35b6 Leo (Sunpeng  Li     2017-10-12  9328) 			drm_send_event_locked(dev, &new_crtc_state->event->base);
e7b07ceef2a650e Harry Wentland       2017-08-10  9329
0bc9706db3a35b6 Leo (Sunpeng  Li     2017-10-12  9330) 		new_crtc_state->event = NULL;
e7b07ceef2a650e Harry Wentland       2017-08-10  9331  	}
4a580877bdcb837 Luben Tuikov         2020-08-24  9332  	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
e7b07ceef2a650e Harry Wentland       2017-08-10  9333
29c8f23425e0709 Leo Li               2019-01-07  9334  	/* Signal HW programming completion */
29c8f23425e0709 Leo Li               2019-01-07  9335  	drm_atomic_helper_commit_hw_done(state);
e7b07ceef2a650e Harry Wentland       2017-08-10  9336
e7b07ceef2a650e Harry Wentland       2017-08-10  9337  	if (wait_for_vblank)
320a127437e5d3c Andrey Grodzovsky    2017-11-14  9338  		drm_atomic_helper_wait_for_flip_done(dev, state);
e7b07ceef2a650e Harry Wentland       2017-08-10  9339
e7b07ceef2a650e Harry Wentland       2017-08-10  9340  	drm_atomic_helper_cleanup_planes(dev, state);
97028037a38ae40 Lyude Paul           2018-06-04  9341
e6b27cf515a7813 Alex Deucher         2023-06-09  9342  	/* Don't free the memory if we are hitting this as part of suspend.
e6b27cf515a7813 Alex Deucher         2023-06-09  9343  	 * This way we don't free any memory during suspend; see
e6b27cf515a7813 Alex Deucher         2023-06-09  9344  	 * amdgpu_bo_free_kernel().  The memory will be freed in the first
e6b27cf515a7813 Alex Deucher         2023-06-09  9345  	 * non-suspend modeset or when the driver is torn down.
e6b27cf515a7813 Alex Deucher         2023-06-09  9346  	 */
e6b27cf515a7813 Alex Deucher         2023-06-09  9347  	if (!adev->in_suspend) {
5f6fab247c7f206 Alex Deucher         2020-12-04  9348  		/* return the stolen vga memory back to VRAM */
5f6fab247c7f206 Alex Deucher         2020-12-04  9349  		if (!adev->mman.keep_stolen_vga_memory)
5f6fab247c7f206 Alex Deucher         2020-12-04  9350  			amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory, NULL, NULL);
5f6fab247c7f206 Alex Deucher         2020-12-04  9351  		amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
e6b27cf515a7813 Alex Deucher         2023-06-09  9352  	}
5f6fab247c7f206 Alex Deucher         2020-12-04  9353
1f6010a96273c31 David Francis        2018-08-15  9354  	/*
1f6010a96273c31 David Francis        2018-08-15  9355  	 * Finally, drop a runtime PM reference for each newly disabled CRTC,
97028037a38ae40 Lyude Paul           2018-06-04  9356  	 * so we can put the GPU into runtime suspend if we're not driving any
97028037a38ae40 Lyude Paul           2018-06-04  9357  	 * displays anymore
97028037a38ae40 Lyude Paul           2018-06-04  9358  	 */
fe2a19652918a52 Lyude Paul           2018-06-21  9359  	for (i = 0; i < crtc_disable_count; i++)
97028037a38ae40 Lyude Paul           2018-06-04  9360  		pm_runtime_put_autosuspend(dev->dev);
fe2a19652918a52 Lyude Paul           2018-06-21  9361  	pm_runtime_mark_last_busy(dev->dev);
e7b07ceef2a650e Harry Wentland       2017-08-10  9362  }
e7b07ceef2a650e Harry Wentland       2017-08-10  9363

:::::: The code at line 9191 was first introduced by commit
:::::: 135fd1b35690b8be8c0f8de4324128a6a99afa95 drm/amd/display: Reduce stack size

:::::: TO: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

