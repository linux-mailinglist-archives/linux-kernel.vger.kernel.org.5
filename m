Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253DB7BB849
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjJFMzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjJFMzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:55:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AADFB;
        Fri,  6 Oct 2023 05:55:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BABDC433C8;
        Fri,  6 Oct 2023 12:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696596940;
        bh=CaAJAaUkmo9qFT1sX60nD4yOm7k2sG7FItez9Toav58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X2GNxUhFC7tJomuVmbcvsseypuRzGAo1ahYukNqrvZpo7bRZmjANxOOPmsjPg+gbI
         I5nxwBLtCFWfNcv/XvvnEB4DZzCgz7F+USMCHnbNGZJ3Zj4BHZ9UXgzUbTg/y1THYo
         eNjWYI832+Dptq140gHxRMcBE2Vbex9d3jMYi2kc=
Date:   Fri, 6 Oct 2023 14:55:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     sakari.ailus@linux.intel.com, davthompson@nvidia.com,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.1 000/259] 6.1.56-rc1 review
Message-ID: <2023100624-aneurism-overboard-55ac@gregkh>
References: <20231004175217.404851126@linuxfoundation.org>
 <ZR6rvGqpwdSeOeHt@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR6rvGqpwdSeOeHt@duo.ucw.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 02:27:40PM +0200, Pavel Machek wrote:
> Hi!
> 
> > This is the start of the stable review cycle for the 6.1.56 release.
> > There are 259 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> Here are some issues:
> 
> > Sakari Ailus <sakari.ailus@linux.intel.com>
> >     media: via: Use correct dependency for camera sensor drivers
> > Sakari Ailus <sakari.ailus@linux.intel.com>
> >     media: v4l: Use correct dependency for camera sensor drivers
> 
> These are is unsuitable for 6.1 as the VIDEO_CAMERA_SENSOR symbol does
> not exist in 6.1. Please drop.

It is in the 6.1.y tree, please look closer.
