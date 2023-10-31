Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2AB7DCCE0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344211AbjJaMUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344219AbjJaMUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:20:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6D0DA;
        Tue, 31 Oct 2023 05:20:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B11C433C7;
        Tue, 31 Oct 2023 12:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698754828;
        bh=yI9cIfjDH0p+ULOykOKr6PiIJjrMLZUkCkzDvV4S17A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/PbD1qChBUcGOzVjCdP50zTg+0CzyiNe7xs7hlIkMO8lEikHuPOO3vEdSXX5Kj8h
         u1hUAEb5Ja5KG815zFuBi7QzNpoz/Uccm1sO74Qa9n65tz0ehnGHfGGXJysa7vXLYr
         atPnpm9IqDu3+G0BD0q+48ya4E73jCDl8I36kOBc=
Date:   Tue, 31 Oct 2023 13:20:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Jos=E9?= Pekkarinen <jose.pekkarinen@foxhound.fi>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, skhan@linuxfoundation.org,
        dillon.varone@amd.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dri-devel@lists.freedesktop.org, Xinhui.Pan@amd.com,
        linux-kernel@vger.kernel.org, samson.tam@amd.com,
        SyedSaaem.Rizvi@amd.com, aurabindo.pillai@amd.com,
        stable@vger.kernel.org, daniel@ffwll.ch, george.shen@amd.com,
        alexander.deucher@amd.com, Jun.Lei@amd.com, airlied@gmail.com,
        christian.koenig@amd.com
Subject: Re: [PATCH] drm/amd/display: remove redundant check
Message-ID: <2023103141-clear-scale-897a@gregkh>
References: <20231030171748.35482-1-jose.pekkarinen@foxhound.fi>
 <2023103115-obstruct-smudgy-6cc6@gregkh>
 <3ab58c1e48447798d7525e7d2f42f1a2@foxhound.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ab58c1e48447798d7525e7d2f42f1a2@foxhound.fi>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 01:42:17PM +0200, José Pekkarinen wrote:
> On 2023-10-31 07:48, Greg KH wrote:
> > On Mon, Oct 30, 2023 at 07:17:48PM +0200, José Pekkarinen wrote:
> > > This patch addresses the following warning spotted by
> > > using coccinelle where the case checked does the same
> > > than the else case.
> > > 
> > > drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c:4664:8-10:
> > > WARNING: possible condition with no effect (if == else)
> > > 
> > > Fixes: 974ce181 ("drm/amd/display: Add check for PState change in
> > > DCN32")
> > > 
> > > Cc: stable@vger.kernel.org
> > 
> > Why is this relevant for stable?
> 
>     Hi,
> 
>     I was asked to send it for stable because this code
> looks different in amd-staging-drm-next, see here.
> 
> https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c#L4661

I don't know what I am looking at, sorry.

>     Feel free to let me know if this is wrong, or if I
> need to review some other guidelines I may have missed.

Please see the list of rules for stable patches:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Does "remove code that does nothing" fit here?

thanks,

greg k-h
