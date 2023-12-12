Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367F180EBE7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346548AbjLLMey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346538AbjLLMew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:34:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA46394;
        Tue, 12 Dec 2023 04:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702384499; x=1733920499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1t4WPBB2iV6mGz2IjxnelPLPuKPitQiGr3DtbVpwRDE=;
  b=MFtjG3Rz4EdHyJ0cuYXccAnB/E9yqRaZ2D0IxWnhlcFv7XCPcm3UO/1M
   VVzKiP7urUBvHAV8FjNLMtSuTaW+hUZPt7F2hT3JCTM5Ny1/zpDc0moK+
   i0r/ses+hj3nbAflDTLdWlspLWFq4j4Wt12g7kQsYW6iKF1m6BW6+WdzC
   C0XhYd4elvl0j9pVLN5Aa4vItLZRayv7g/tJd0Guoqr8r4tfuUyUr9IbH
   Sm3eiq/D8nLv2WrtLtlJb+yRGAnOI5iWQwYFa2ZxIs3x0iu2X+FalohPB
   r1yy0HueLrLL0Oqwx5NoYZTYet/fNh8Jtgfa99EeVWrtvngS91fs7zr6N
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1951097"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="1951097"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 04:34:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="896909252"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="896909252"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 04:34:52 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id BA8FD11F7E4;
        Tue, 12 Dec 2023 14:34:49 +0200 (EET)
Date:   Tue, 12 Dec 2023 12:34:49 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, linuxfancy@googlegroups.com,
        mhecht73@gmail.com, christophe.jaillet@wanadoo.fr,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v15 3/3] media: i2c: Add support for alvium camera
Message-ID: <ZXhTaaXZf2WMkAgr@kekkonen.localdomain>
References: <20231204094719.190334-1-tomm.merciai@gmail.com>
 <20231204094719.190334-4-tomm.merciai@gmail.com>
 <ZXhGQuqTZogWTJ42@kekkonen.localdomain>
 <ZXhHrhNQfn0uJMjk@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <ZXhIaB_NTDtSJmj5@kekkonen.localdomain>
 <ZXhPabGpUDJNSgiZ@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXhPabGpUDJNSgiZ@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On Tue, Dec 12, 2023 at 01:17:45PM +0100, Tommaso Merciai wrote:
> Hi Sakari,
> Just a clarification about the following warnings:
> 
> Fixed on my side with:
> 
> CHECK: Assignment operator '=' should be on the previous line
> 
> -       alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_8_LEG]
> -                                 = avail_fmt->yuv420_8_leg;
> +       alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_8_LEG] =
> +                                 avail_fmt->yuv420_8_leg;

This one seems good.

> 
> CHECK: line length of 81 exceeds 80 columns
> #1085: FILE: drivers/media/i2c/alvium-csi2.c:1085:
> +		if (!alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit])
> 
> CHECK: line length of 81 exceeds 80 columns
> #1102: FILE: drivers/media/i2c/alvium-csi2.c:1102:
> +		if (!alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit])
> 
> 
> Fixed on my side with:
> 
>         /* Create the alvium_csi2 fmt array from formats available */
>         for (fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
> -               if (!alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit])
> +               if (!alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt]
> +                               .fmt_av_bit])

I wouldn't introduce a line break in these two cases.

>                         continue;
> 
> Can be ok for you?
> If yes I'm going to prepare the patch on top of your media_tree/master
> branch.

Ack.

-- 
Sakari Ailus
