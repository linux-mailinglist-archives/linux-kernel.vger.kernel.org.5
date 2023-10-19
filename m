Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6867CF21A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjJSILs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjJSILr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:11:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9645C132
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:11:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D7CC433C8;
        Thu, 19 Oct 2023 08:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697703105;
        bh=ISQsf0Hn5tal6+77OQ0DmTsebpQ1g3nMnle8JLPADPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oqO8lOm74cmnzq+OWrD9AMGREsPV+8MBVKSTfr1B2ccFnxaCmZ5wXZdC11EFXcvhO
         DkEiQDADKHYXCi/xXYYwFiXsmTCnJT7kE+3iSwSk6hnelMY26G7SKDtvdnOPtsZr/M
         fwVxJCkykP6Pt93qUvm6bbV5pd7IkeeCFYukdfnUmYyRghPrBdP9Oi5oiXBfyWQVEJ
         Ey80Zi61usSxAAOq8PtCuS/o5Fr5D/AqYJd3JESRBB1PQzXW7l7e9lQSfrG5C9zueb
         WrmgWyZqi2lc39IFelf4UwzIlGu5fzF+55HeCI1Sl4yL73AfiFAQ24Av32Ep9xvmIg
         5+8K7yo3cYBUQ==
Date:   Thu, 19 Oct 2023 10:11:40 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Icenowy Zheng <uwu@icenowy.me>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/loongson: Add support for the DC in LS2K1000 SoC
Message-ID: <76nxdwa6m7qyqvala4akc2rptuylhrqyoz2x5rjua4hppoxk7x@wwn37gwuvrms>
References: <20231011162638.819080-1-suijingfeng@loongson.cn>
 <26565c5e13e72c64214a7f67ab6f2d9d876fa4bd.camel@icenowy.me>
 <037ec619-c170-4ca6-897e-04fccd58c62a@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <037ec619-c170-4ca6-897e-04fccd58c62a@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 06:28:01PM +0800, Sui Jingfeng wrote:
> Hi,
> 
> 
> On 2023/10/13 16:22, Icenowy Zheng wrote:
> > 在 2023-10-12星期四的 00:26 +0800，Sui Jingfeng写道：
> > > LS2K1000 is a low end SoC (two core 1.0gHz), it don't has dedicated
> > > VRAM.
> > > It requires the framebuffer to be phisically continguous to scanout.
> > > The
> > > display controller in LS2K1000 don't has built-in GPIO hardware, the
> > > structure (register bit field) of its pixel, DC, GPU, DDR PLL are
> > > also
> > > defferent from other model. But for the display controller itself,
> > > Most of
> > > hardware features of it are same with ls7a1000.
> > > 
> > > Below is a simple dts for it.
> > Why don't you write a proper, YAML-formatted binding?
> > 
> This patch use only one DT property, that is the "memory-region = <&display_reserved>;".
> But the memory-region property is a common property, I means that everyone know how to
> use this property. I'm not sure the if YAML documentation is strictly required now.

AFAIK it is, and even if it's not, please do it.

Maxime
