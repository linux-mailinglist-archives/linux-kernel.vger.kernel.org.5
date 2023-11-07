Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB087E419C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjKGOLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjKGOLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:11:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6666D71
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:11:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34139C433C8;
        Tue,  7 Nov 2023 14:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699366276;
        bh=ipLY44jql33d6wfFrPt7YcOzhZm0V3DcoEWXrrXmYKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2uHQ6kMCDh6WjgFy6QERZY/5WiQMGzQzqziHGTwHeetWXhDcG4o1TtdieEgqLg6k2
         RmZSrM+THi+9xFO+4MvergHtx5I8zoDyqlCwJh+nTdT084eGu+NiWdiuPFTFJ3SIlf
         DSORhZvGvgY2NJ6CDCTjfPvk8+fFx2Z7+JENhvN0=
Date:   Tue, 7 Nov 2023 15:11:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] mei: pxp: add dependency on Xe driver
Message-ID: <2023110700-emptier-retrain-08fd@gregkh>
References: <20231107134606.316651-1-alexander.usyskin@intel.com>
 <20231107134606.316651-6-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107134606.316651-6-alexander.usyskin@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 03:46:06PM +0200, Alexander Usyskin wrote:
> Optionally depend on either i915 or Xe drivers.
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>  drivers/misc/mei/pxp/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/mei/pxp/Kconfig b/drivers/misc/mei/pxp/Kconfig
> index 4029b96afc04..d9ae5483567f 100644
> --- a/drivers/misc/mei/pxp/Kconfig
> +++ b/drivers/misc/mei/pxp/Kconfig
> @@ -1,11 +1,10 @@
> -

Why this change here?

thanks,

greg k-h
