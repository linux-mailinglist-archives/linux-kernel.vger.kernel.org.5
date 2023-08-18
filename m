Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F42781124
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378876AbjHRRCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378935AbjHRRB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:01:56 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A353AAA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:01:53 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso881301a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692378113; x=1692982913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ccOpBH+0zGB6h/+g5NT+SFG7IlLk8LZC3n5h35bndA0=;
        b=DUF4JU4OAisFb2znDTDbV+7kSb3FgaFzFM3D0Kiebf+RV/EfREumhrpVzh/N+h+9Ts
         egrt5cdmHUOY3QAp4RC0X5+JP8rpuaUVHjMtC9cUpRf/LArJ1QufHDVa2YMs0NuKZpFR
         QA8B1dnxUK4HqTcn0lmKoeWwZis6D8+M6WkuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692378113; x=1692982913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccOpBH+0zGB6h/+g5NT+SFG7IlLk8LZC3n5h35bndA0=;
        b=VFCwTeH8Gahn1zuoaQYygYjAUeqdfq87VfzTGyL6WUSNUQmhBzXzbNuxhrewTC/3SO
         8bSfsqUPOqvGnheBFyBBfvURpnY4O+tTf6MDX7GgrmKX0OhkEpMzPi56ZVer3t3cfOZu
         EqUoiwEfMfNZJZXdCgMiG93X2QPKGdFVz5indKNMw8Isa65RJ977683RN9M6jkBqVu4u
         CL1kz073lBX35n8RrUkAjSJ7HZntSAclI3gcZ7pTdQHiZVIDpQNNpQ5VQJ1GIx53opKA
         5jhWi46TXwwNzEL6L+l+ZsQ4eTVbYTLfGFQyR1Ki1S4TjTSmxGQLPOKWz92AzVum3oGA
         kL9Q==
X-Gm-Message-State: AOJu0Yy4RrDj97ShH2vXL16APS0mTqX7yBN0W0Lzy0X11deCJ5aY5jak
        krimAblbdShamF6w8eYb3zoranCYrRtyKTX/m68maA==
X-Google-Smtp-Source: AGHT+IFNMrMmyypjHvRkY6RVrVt1hXc/7HF9esDlXUnlbPkZjdiWgxkTl2xYg/SyumF3ZhaZmarTgQ==
X-Received: by 2002:a17:90b:33c2:b0:269:154b:6290 with SMTP id lk2-20020a17090b33c200b00269154b6290mr2976289pjb.24.1692378113260;
        Fri, 18 Aug 2023 10:01:53 -0700 (PDT)
Received: from chromium.org (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id a17-20020a17090abe1100b0026b76edd607sm1790707pjs.15.2023.08.18.10.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 10:01:52 -0700 (PDT)
Date:   Fri, 18 Aug 2023 17:01:51 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, bleung@chromium.org
Subject: Re: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Message-ID: <ZN+j/z97Yy0wv/if@chromium.org>
References: <20230718024703.1013367-1-utkarsh.h.patel@intel.com>
 <20230718024703.1013367-2-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718024703.1013367-2-utkarsh.h.patel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Utkarsh,

Sorry I was out on leave, so didnt get to this earlier.


On Jul 17 19:47, Utkarsh Patel wrote:
>  
> +/**
> + * cros_typec_get_cable_vdo() - Get Cable VDO of the connected cable
> + * @port: Type-C port data
> + * @svid: Standard or Vendor ID to match
> + *
> + * Returns the Cable VDO if match is found and returns 0 if match is not found.
> + */
> +static int cros_typec_get_cable_vdo(struct cros_typec_port *port, u16 svid)
return type should be u32.

> +{
> +	struct list_head *head = &port->plug_mode_list;
> +	struct cros_typec_altmode_node *node;
> +	u32 ret = 0;
> +
> +	list_for_each_entry(node, head, list) {
> +		if (node->amode->svid == svid)
> +			return node->amode->vdo;
> +	}
> +
> +	return ret;
> +}
> +
>  /*
>   * Spoof the VDOs that were likely communicated by the partner for TBT alt
>   * mode.
> @@ -432,6 +453,9 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
>  
>  	/* Cable Discover Mode VDO */
>  	data.cable_mode = TBT_MODE;
> +
> +	data.cable_mode |= cros_typec_get_cable_vdo(port, USB_TYPEC_TBT_SID);
> +
>  	data.cable_mode |= TBT_SET_CABLE_SPEED(pd_ctrl->cable_speed);
>  
>  	if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE)
> @@ -522,8 +546,10 @@ static int cros_typec_enable_usb4(struct cros_typec_data *typec,
>  	/* Cable Type */
>  	if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE)
>  		data.eudo |= EUDO_CABLE_TYPE_OPTICAL << EUDO_CABLE_TYPE_SHIFT;
> -	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
> +	else if (cros_typec_get_cable_vdo(port, USB_TYPEC_TBT_SID) & TBT_CABLE_RETIMER)
>  		data.eudo |= EUDO_CABLE_TYPE_RE_TIMER << EUDO_CABLE_TYPE_SHIFT;
We shouldn't need to call cros_typec_get_cable_vdo more than once. Either call it once earlier
when you are crafting the data.cable_mode member and then re-use that variable here. Or don't
call it there and just call it here.

> +	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
> +		data.eudo |= EUDO_CABLE_TYPE_RE_DRIVER << EUDO_CABLE_TYPE_SHIFT;
>  
>  	data.active_link_training = !!(pd_ctrl->control_flags &
>  				       USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
> -- 
> 2.25.1
> 
