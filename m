Return-Path: <linux-kernel+bounces-110256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51911885C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7570D1C21E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C252B12836A;
	Thu, 21 Mar 2024 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rBJFnCZ8"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F703127B75
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035286; cv=none; b=gy2YOJZWX+U0a2CoOKR/dqqEO+XhxViqX1T3GWMT9ASnKqXNOvJNC+QCpnA776ojohvfSOH8Bip1Xmlo5nLfbxDQ18VAKT8T2YAwVIl3ihDNVf97n1whggfU9KkkJi0+9z2x8cFZUZLfvumnR7/V4gMKlA7cMo9boe2itl/xdqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035286; c=relaxed/simple;
	bh=0zc0ujxsUZDSCIMa8DgsBxEKHxlROrz8eSt1YZrNcQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hk0mvwWSJxsyZMgiGuP4KUM93fmAoG6c73lXIWQl4AF0zFOQxzlZI1TezxCmldDWcdZDl/SpEzkgUyRH+T6DolgtaVfYMnzpay+FA5lJZ4JTvr+SaQRqbcXgaaa2awTkh3uflb8ngtPb/AbAF7lss+uVVPpsfXa7wQlEv03Oz7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=rBJFnCZ8; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a468004667aso163225266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711035280; x=1711640080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jJZsBHwcwq2EKhTfcmV2KDI1h+H2DDxIsRSU6ooknBA=;
        b=rBJFnCZ8c3RnzjxFqOxzxWJgQxe7jDYkFCqIH/I+fB+EkHpRmALmBcSvc3iZuvZzpS
         c1FgWMQ97WBNK5QcioH/mp7nJdfZk62SZbHxQMBc3o9a+KEwOdDWM4kLQj43RWvEbpIq
         CSiqr72MaK2JeaSuZNIhqY17FnnOacF1o4Cet+NLrV/bAcWuEpVeBcQLByR9el/ESeAh
         5rXJrIMtwBIIW7tMCcIyszaR5Lt0CoAY0hdyQVFG3y0sO/Xm5QytDbkoNLP7wqMLUktT
         4cG3UYMwpAg6HShIi7aClPYV2rMipYC5FZ5Y0Mi88qQHF59MltgMvJXQI4bsNXMoa+wF
         VcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711035280; x=1711640080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJZsBHwcwq2EKhTfcmV2KDI1h+H2DDxIsRSU6ooknBA=;
        b=r5AXOG2cUDflqCUmhhRLkxzStIu/bxssBnFLsBIy0vT3LJa51OagFQaxkKISlCP82T
         0FmUElc6pSW4UX8I24gZ7dQRbzuJqiwX1+cYwWB0WZRiMbMdaNO8Oax/SrAEO0fQtPdk
         2m8zYMUTGUPCjowXtHL2Sj4ubaloQf0XRXO0mySODLAoz+vQxCtFTMDiZeA+46Im5zk9
         n2gqOXbtPenzvuYOnxshxzt202sBHTPH4l4g0KW0xi+yqo7tcosQRF6LKthSM16/FDBw
         6HORBDNQoBheF72Q67sa9Og/K+adi0PuYfUgn6Fv7twKgPSUfssiNlw3qlEHTsPcWlC6
         e75w==
X-Forwarded-Encrypted: i=1; AJvYcCVVWCDHhA7uYs4HAnjkdcX2Gd/gevOgLX0yojeYRElU6dpPKWGXYmLGrQZfQg5dlXPn0jHZVPLYDPX0H4TDeWH+qGuXA5y2Mo/UyHJr
X-Gm-Message-State: AOJu0YyoWJFfgk7lInYLDfPEFt84XrHWmtwOdHoJV65rhc3VXJJD0x04
	Q5pD/oKoE3e/8j1VtBJotFyO1Uvphc6Zpg2GLIPz3IMepA27j+MsA1QyfGFN3Xw=
X-Google-Smtp-Source: AGHT+IGBqgVfVrdiQ/+9M8CkXnHsQmBgBd+MDFecT1hmDvu9F6AyiYmNOC25nNXzC5ijEZZ+4GiHwQ==
X-Received: by 2002:a17:906:ee89:b0:a46:be83:36e2 with SMTP id wt9-20020a170906ee8900b00a46be8336e2mr10664449ejb.24.1711035280409;
        Thu, 21 Mar 2024 08:34:40 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906725300b00a46a9c38a64sm39732ejk.65.2024.03.21.08.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 08:34:39 -0700 (PDT)
Date: Thu, 21 Mar 2024 16:34:37 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 net] ice: Fix freeing uninitialized pointers
Message-ID: <ZfxTjYUPAFz_LRlk@nanopsycho>
References: <0efe132b-b343-4438-bb00-5a4b82722ed3@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0efe132b-b343-4438-bb00-5a4b82722ed3@moroto.mountain>

Thu, Mar 21, 2024 at 03:42:12PM CET, dan.carpenter@linaro.org wrote:
>Automatically cleaned up pointers need to be initialized before exiting
>their scope.  In this case, they need to be initialized to NULL before
>any return statement.
>
>Fixes: 90f821d72e11 ("ice: avoid unnecessary devm_ usage")
>Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


>---
>v2: I missed a couple pointers in v1.
>
>The change to ice_update_link_info() isn't required because it's
>assigned on the very next line...  But I did that because it's harmless
>and makes __free() stuff easier to verify.  I felt like moving the
>declarations into the code would be controversial and it also ends up
>making the lines really long.
>
>		goto goto err_unroll_sched;
>
>	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) =
>		kzalloc(sizeof(*pcaps), GFP_KERNEL);

Yeah, that is why I'm proposing KZALLOC_FREE helper:
https://lore.kernel.org/all/20240315132249.2515468-1-jiri@resnulli.us/


>
> drivers/net/ethernet/intel/ice/ice_common.c | 10 +++++-----
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
> 2 file changed, 6 insertion(+), 6 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
>index 4d8111aeb0ff..6f2db603b36e 100644
>--- a/drivers/net/ethernet/intel/ice/ice_common.c
>+++ b/drivers/net/ethernet/intel/ice/ice_common.c
>@@ -1002,8 +1002,8 @@ static void ice_get_itr_intrl_gran(struct ice_hw *hw)
>  */
> int ice_init_hw(struct ice_hw *hw)
> {
>-	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
>-	void *mac_buf __free(kfree);
>+	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
>+	void *mac_buf __free(kfree) = NULL;
> 	u16 mac_buf_len;
> 	int status;
> 
>@@ -3272,7 +3272,7 @@ int ice_update_link_info(struct ice_port_info *pi)
> 		return status;
> 
> 	if (li->link_info & ICE_AQ_MEDIA_AVAILABLE) {
>-		struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
>+		struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
> 
> 		pcaps = kzalloc(sizeof(*pcaps), GFP_KERNEL);
> 		if (!pcaps)
>@@ -3420,7 +3420,7 @@ ice_cfg_phy_fc(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
> int
> ice_set_fc(struct ice_port_info *pi, u8 *aq_failures, bool ena_auto_link_update)
> {
>-	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
>+	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
> 	struct ice_aqc_set_phy_cfg_data cfg = { 0 };
> 	struct ice_hw *hw;
> 	int status;
>@@ -3561,7 +3561,7 @@ int
> ice_cfg_phy_fec(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
> 		enum ice_fec_mode fec)
> {
>-	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
>+	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
> 	struct ice_hw *hw;
> 	int status;
> 
>diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
>index 255a9c8151b4..78b833b3e1d7 100644
>--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
>+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
>@@ -941,11 +941,11 @@ static u64 ice_loopback_test(struct net_device *netdev)
> 	struct ice_netdev_priv *np = netdev_priv(netdev);
> 	struct ice_vsi *orig_vsi = np->vsi, *test_vsi;
> 	struct ice_pf *pf = orig_vsi->back;
>+	u8 *tx_frame __free(kfree) = NULL;
> 	u8 broadcast[ETH_ALEN], ret = 0;
> 	int num_frames, valid_frames;
> 	struct ice_tx_ring *tx_ring;
> 	struct ice_rx_ring *rx_ring;
>-	u8 *tx_frame __free(kfree);
> 	int i;
> 
> 	netdev_info(netdev, "loopback test\n");
>-- 
>2.43.0
>
>
>

