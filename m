Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F61F7BD116
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 01:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344915AbjJHXMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 19:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344886AbjJHXMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 19:12:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F728A6;
        Sun,  8 Oct 2023 16:12:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06E8C433C7;
        Sun,  8 Oct 2023 23:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696806767;
        bh=IvopNiW6tj1nPOzE97+6cDbEZ/BcfmuyPxWJDcE5g5w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lu8SMj0RZHiS+3br9gOg/sC4Jj5oUJpmiqeiDtp+wP2Ms4jfvpGM1lmX55LR/8y4L
         cJec8aTiXcPnPOCGIAZTOXOOoTnhyLyHaejcKqdcCXiuQk6Bu1g9O0bZZCyMKXUBOb
         Ycjwe1KfzxMsNS91EPVXpRizi9SOflGPgCz9/3BGV8bfHRtr2Txx6L0J+Ow5qVIG7w
         7pjw5M2W2NfnLtUn+YLmJVLTGGXi4W7KzbelVL1EJfDrwaxlvmuCAHeZcWSDXmAeOe
         nADpSbuQ3bzeSpeTTaOF37B9mcJraMqqIZ65CgalMbhh9TOWRpRt9bI12PI/jcQaq5
         HrQxuR1Xfn4mQ==
Date:   Mon, 9 Oct 2023 01:12:43 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the
 v4l-dvb-next tree
Message-ID: <20231009011243.2e335927@sal.lan>
In-Reply-To: <20231009082604.42686ef2@canb.auug.org.au>
References: <20231009082604.42686ef2@canb.auug.org.au>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 9 Oct 2023 08:26:04 +1100
Stephen Rothwell <sfr@canb.auug.org.au> escreveu:

> Hi all,
> 
> Commits
> 
>   854dd87cd511 ("media: atomisp: Drop atomisp-ov5693 sensor driver")
>   b529c3c4eee9 ("media: atomisp: Disable VCM for OV5693 for now")
>   f7a8b46b7e61 ("media: atomisp: gc0310: Stop setting v4l2_subdev.fwnode to the endpoint fwnode")
>   c154618b7a95 ("media: atomisp: Drop VIDEO_ATOMISP_ISP2401 Kconfig option")
>   ab17dc50170f ("media: atomisp: Drop ia_css_debug_dump_debug_info() and functions only used by it")
>   b2740e3fdf92 ("media: atomisp: Simplify some if (IS_ISP2401...) statements")
>   56b3c81493f8 ("media: atomisp: atomisp_v4l2: Removed unnecessary code")
>   fd32a7f23375 ("media: atomisp: sh_css: Removed #ifdef ISP2401 to make the driver generic")
>   efb478661b14 ("media: atomisp: sh_css: Removed #ifdef ISP2401 to make code generic")
>   b3afac839e2e ("media: atomisp: sh_css: Renamed sh_css_config_input_network()")
>   74e7ec2c7f62 ("media: atomisp: sh_css: Removed #ifdef ISP2401 to make driver generic")
>   ea0f4d2e67f7 ("media: atomisp: sh_css_sp: Remove #ifdef ISP2401 to make driver generic")
>   3916493b92f8 ("media: atomisp: sh_css: Removed #ifdef ISP2401 to make the driver generic")
>   28b8f4c86351 ("media: atomisp: sh_css_mipi: Removed unused code ia_css_mipi_frame_enable_check_on_size()")
>   cfdd05590693 ("media: atomisp: atomisp_compat_css20: Removed #ifdef ISP2401 to make driver generic")
>   039bb46fbc08 ("media: atomisp: hive_isp_css_include: Removed #ifdef ISP2401 to make driver generic")
>   88e3390ed25e ("media: atomisp: binary: Removed #ifdef ISP2401 to make driver generic")
>   df971033fac2 ("media: atomisp: ia_css_raw.host: Remove #ifdef ISP2401 to make the driver generic")
>   0b1fc1b12393 ("media: atomisp: Mark ia_css_isys_240?_init() static")
>   02e9eeec18da ("media: atomisp: Remove aliases for MIPI_FORMAT_2400_CUSTOM0")
>   93bc853183af ("media: atomisp: Remove empty isys_public.h")
>   75c80ec9d771 ("media: atomisp: isys_init: Initiate atomisp in a generic manner")
>   631d166598d7 ("media: atomisp: rx: Removed #if defined(ISP2401) to make driver generic")
>   060a3193b9c8 ("media: atomisp: Compile the object codes for a generic driver")
>   a81163d5dcee ("media: atomisp: ifmtr: Removed #if defined(ISP2401) to make driver generic")
>   a3af16862768 ("media: atomisp: pipeline: Removed #if defined(ISP2401) to make driver generic")
>   f292caaeb4d2 ("media: atomisp: hive_isp_css_common: Removed #if defined(ISP2401) to make driver generic")
>   95387bd0863a ("media: atomisp: isys: Removed #if defined(ISP2401) to make driver generic")
>   772471047769 ("media: atomisp: css_2401_system: Remove #ifdef ISP2401 to make the driver generic")
>   f240e30e3736 ("media: atomisp: Included both input system headers")
>   1370da977f30 ("media: atomisp: Make two individual enum to define the MIPI format")
>   7aa7aa46aa6f ("media: atomisp: ia_css_debug: Removed debug codes for dumping status")
>   cc26d3654ef7 ("media: atomisp: Remove v4l2_ctrl_s_ctrl(asd->run_mode) calls from atomisp_open()")
>   a583e0efd3fd ("media: atomisp: Remove support for custom run-mode v4l2-ctrl on sensors")
>   c5e0d1df8e55 ("media: atomisp: Add some higher resolutions to atomisp_enum_framesizes()")
>   5cfbe44773f7 ("media: atomisp: Change atomisp_enum_framesizes() too small cut off from 2/3th to 5/8th")
>   3068c8c4e7cb ("media: atomisp: Clamp width to max 1920 pixels when in ATOMISP_RUN_MODE_PREVIEW")
>   480293b781bf ("media: atomisp: Fix missing v4l2_fh_release() in atomisp_open() error exit")
>   f8fe8b85e067 ("media: atomisp: sh_css_internal: sh_css_params: Unifying sh_css_sp_group data structure")
>   90e9e32a0738 ("media: atomisp: Removed unused HAS_WATCHDOG_SP_THREAD_DEBUG debug")
>   42887db60c58 ("media: atomisp: ia_css_debug: Removed unused codes for debug")
> 
> are missing a Signed-off-by from their committers.

This is likely due to a rebase that Hans did at the tree. Those patches
were originally committed by me, but the rebase changed the committer
data.

Regards,
Mauro

> 
