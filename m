Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDB17F9CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjK0JlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjK0JlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:41:09 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8842186
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:41:14 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-544455a4b56so5260931a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701078073; x=1701682873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vUCQNPnxA0WhE9IVSXozKQomqPo1RPr5tq7lygXHnZw=;
        b=PSWLExw4Qo895aEHnG4Gm5EW/d6TYz4++ADzxLY2kZiKJB2IMnjiXbl0CA86YYd9j9
         H+UzEiKPuF2gi2FPgvnoUQh53XkmDwS+U3hAOLOLnY02Q3CsCImSZ2BaG1JpTYu+MLGh
         kzb/5NXrpwygR6NO5reYlqB2Dcb9YeHtPzdcTdP7fPfP8dbynMWfBEEDH+fvNG5OVufD
         Get5ONdnCmmxcFYiAP+2moKsgjoFGWPgnK6p6mskCtKI0JTGLmmemqWSQeFi4alaqgbg
         UyZvsioRLl2pmUrpJak29FUtsWdtlXp67X/WEsRsQWCo9DioRDF/lQSwAaSZHjCisyWN
         4VCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701078073; x=1701682873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUCQNPnxA0WhE9IVSXozKQomqPo1RPr5tq7lygXHnZw=;
        b=xUNKfV0pXvGlWaulSxRppRPml4Lh4L6hUswR39pdWKNekLHW9dyaKYRLGvEm6fEcRM
         3DJORQa5tzc96EGraS+VuzXBiEPAzcWJFqBizwIa1QY+CxjadNfEOdC7hFd8gxL/dFIZ
         iM3w8NYiEJZR0H5bKECEoSiCb3vNsHLsUdaczbCa1jMmARjt0xIw68Doj/jP63znZa47
         ae8bsjI5IPxGDQr7tOLrM/rmcneG9mIzPAVpmEVp/Gubg38MV9B8qun30WKuBrzAzaWm
         kF+7Pug/Lo37/3jI9aks5xRx0FScGlOXkWW1Bs9iFXynKPIBsGeyQ7hb8oCZ/O/ROvQu
         5xeg==
X-Gm-Message-State: AOJu0YzlaiJroQ5gPb7j4ieKY8XS73uI2sQDT0d2rbDA7CH5mMloTrSf
        69cD1FsXrUHm9W0sDOtGfyHKqA==
X-Google-Smtp-Source: AGHT+IGeUdvZVC5a7Ar3svAcCBK16pGi6SCrexZsSH+Aonc7To6tkU/2mL2ZItVW0+Ph42jB8baJFA==
X-Received: by 2002:a50:9e0f:0:b0:547:b96:1172 with SMTP id z15-20020a509e0f000000b005470b961172mr7473450ede.28.1701078073323;
        Mon, 27 Nov 2023 01:41:13 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id m11-20020a056402050b00b00548a2d1737bsm5053723edv.35.2023.11.27.01.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 01:41:12 -0800 (PST)
Date:   Mon, 27 Nov 2023 10:41:11 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Sachin Bahadur <sachin.bahadur@intel.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net v4] ice: Block PF reinit if attached to bond
Message-ID: <ZWRkN12fhENyN4PY@nanopsycho>
References: <20231127060512.1283336-1-sachin.bahadur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127060512.1283336-1-sachin.bahadur@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Nov 27, 2023 at 07:05:12AM CET, sachin.bahadur@intel.com wrote:
>PF interface part of Bond should not allow driver reinit via devlink. Bond
>config will be lost due to PF reinit. PF needs to be re-added to Bond
>after PF reinit. ice_devlink_reload_down is called before PF driver reinit.
>If PF is attached to bond, ice_devlink_reload_down returns error.
>
>Fixes: trailer
>Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>Signed-off-by: Sachin Bahadur <sachin.bahadur@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_devlink.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
>index f4e24d11ebd0..5fe88e949b09 100644
>--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>@@ -457,6 +457,10 @@ ice_devlink_reload_down(struct devlink *devlink, bool netns_change,
> 					   "Remove all VFs before doing reinit\n");
> 			return -EOPNOTSUPP;
> 		}
>+		if (pf->lag && pf->lag->bonded) {
>+			NL_SET_ERR_MSG_MOD(extack, "Remove all associated Bonds before doing reinit");

Nack. Remove the netdev during re-init, that would solve your issue.
Looks like some checks are needed to be added in devlink code to make
sure drivers behave properly. I'm on in.



>+			return -EBUSY;
>+		}
> 		ice_unload(pf);
> 		return 0;
> 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
>--
>2.25.1
>
>
