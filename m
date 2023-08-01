Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8CA76C07D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 00:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjHAWgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 18:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHAWgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 18:36:35 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7981BE3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 15:36:34 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1CEDCD51;
        Wed,  2 Aug 2023 00:35:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690929330;
        bh=xKbWPPFqpYA/6VBABvjVJI4UBDFcYiEPeXYPgjlljN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mfJpv3RWOrBUwo+xcEdhwgoYYXmsrd5dAJersIzx0x5DE58dlbOhd94MOd0PWq+0h
         REZKXRoXQLfIdSImu+BP9ihvUKSZ77ABlpk/slUjfGMDqdy3lInxKkew2zjCmbA3Rd
         3F7EuXwGPW2zZrC6A/Ejld/GELV8BNey0Jh3xdoo=
Date:   Wed, 2 Aug 2023 01:36:39 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/37] drm/xlnx/zynqmp_disp: Use correct kerneldoc
 formatting in zynqmp_disp
Message-ID: <20230801223639.GA335@pendragon.ideasonboard.com>
References: <20230317081718.2650744-1-lee@kernel.org>
 <20230317081718.2650744-3-lee@kernel.org>
 <20230319142432.GM10144@pendragon.ideasonboard.com>
 <20230320081700.GH9667@google.com>
 <20230320231551.GQ20234@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230320231551.GQ20234@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jon, Mauro, would you have any feedback on this ?
On Tue, Mar 21, 2023 at 01:15:51AM +0200, Laurent Pinchart wrote:
> Hi Lee,
> 
> (CC'ing Jon and Mauro)
> 
> On Mon, Mar 20, 2023 at 08:17:00AM +0000, Lee Jones wrote:
> > On Sun, 19 Mar 2023, Laurent Pinchart wrote:
> > > Thank you for the patch.
> > >
> > > On Fri, Mar 17, 2023 at 08:16:43AM +0000, Lee Jones wrote:
> > > > Fixes the following W=1 kernel build warning(s):
> > > >
> > > >  drivers/gpu/drm/xlnx/zynqmp_disp.c:151: warning: Function parameter or member 'blend' not described in 'zynqmp_disp'
> > > >  drivers/gpu/drm/xlnx/zynqmp_disp.c:151: warning: Function parameter or member 'avbuf' not described in 'zynqmp_disp'
> > > >  drivers/gpu/drm/xlnx/zynqmp_disp.c:151: warning: Function parameter or member 'audio' not described in 'zynqmp_disp'
> > > >
> > > > Cc: Hyun Kwon <hyun.kwon@xilinx.com>
> > > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > Cc: David Airlie <airlied@gmail.com>
> > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > Cc: Michal Simek <michal.simek@xilinx.com>
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > ---
> > > >  drivers/gpu/drm/xlnx/zynqmp_disp.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> > > > index 3b87eebddc979..63358f4898625 100644
> > > > --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> > > > +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> > > > @@ -128,9 +128,9 @@ struct zynqmp_disp_layer {
> > > >   * struct zynqmp_disp - Display controller
> > > >   * @dev: Device structure
> > > >   * @dpsub: Display subsystem
> > > > - * @blend.base: Register I/O base address for the blender
> > > > - * @avbuf.base: Register I/O base address for the audio/video buffer manager
> > > > - * @audio.base: Registers I/O base address for the audio mixer
> > > > + * @blend: .base: Register I/O base address for the blender
> > > > + * @avbuf: .base: Register I/O base address for the audio/video buffer manager
> > > > + * @audio: .base: Registers I/O base address for the audio mixer
> > >
> > > This is a hack, it won't work properly if the nested structures get
> > > extended with more fields.
> > 
> > The original doc is a hack, for it is not recognised kerneldoc format.  :)
> 
> I'll claim it's a bug, not a hack :-D
> 
> > > Is there a correct kerneldoc syntax for this code construct ?
> > 
> > Not that I'm aware of.
> > 
> > Unless it's been added since my last round of this stuff.
> 
> I haven't seen anything either. I tried moving the documentation inline,
> and the scripts/kernel-doc script ignores the comment blocks for the
> inner fields.
> 
> Mauro, Jon, is this a known issue ? If so, are there plans to fix it ?
> What's the recommended way to proceed here ?
> 
> > > >   * @layers: Layers (planes)
> > > >   */
> > > >  struct zynqmp_disp {

-- 
Regards,

Laurent Pinchart
