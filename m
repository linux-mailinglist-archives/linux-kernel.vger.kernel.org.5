Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C46E7FEE00
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345158AbjK3LeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345156AbjK3LeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:34:01 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D4210CE;
        Thu, 30 Nov 2023 03:34:06 -0800 (PST)
Received: from pyrite.rasen.tech (h175-177-049-156.catv02.itscom.jp [175.177.49.156])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 16425276;
        Thu, 30 Nov 2023 12:33:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701344007;
        bh=dUdQo/NnsNM0ahRbgo/sOvGeBK2fSa+ow0mpMw2kxiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ufA17wQ07OWsddNEeEKk0rpmFotp+SrjId4NeAj9f0nM69ANSnBI6AEOrAtqDsNEq
         NKXuDyvRnP7mJhrclRVYpchhgfyc8qhev4w3uA8yvJjWKEfRWvCj0VDewkdz8SeWBk
         BtLIO5D62xclXqLIGt9Mv8CGzVkIii01BMPsn2eA=
Date:   Thu, 30 Nov 2023 20:33:53 +0900
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        tomi.valkeinen@ideasonboard.com, umang.jain@ideasonboard.com,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] media: rkisp1: debug: Add register dump for IS
Message-ID: <ZWhzIeW0VlDRztmS@pyrite.rasen.tech>
References: <20231129092956.250129-1-paul.elder@ideasonboard.com>
 <170128834260.3048548.11979514587961676400@ping.linuxembedded.co.uk>
 <ZWhaFL48cgdHsOPN@pyrite.rasen.tech>
 <4881112.31r3eYUQgx@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4881112.31r3eYUQgx@steina-w>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 10:54:46AM +0100, Alexander Stein wrote:
> Hi Paul,
> 
> Am Donnerstag, 30. November 2023, 10:47:00 CET schrieb Paul Elder:
> > On Wed, Nov 29, 2023 at 08:05:42PM +0000, Kieran Bingham wrote:
> > > Quoting Paul Elder (2023-11-29 09:29:55)
> > > 
> > > > Add register dump for the image stabilizer module to debugfs.
> > > 
> > > Is the Image Stabilizer on all variants of the ISP?
> > > 
> > > I.e. is it valid register space on the RK3399 implementation?
> > 
> > Yes, it is.
> 
> Is there some public documentation available how this ISP works? For RK3399 or 
> i.MX8MP.

Not that I'm aware of. I've been told there's some leaked documentation
in the RK3288 (without registers), and another one for the RK3399 (with
registers)?


Paul

> 
> > 
> > > If so then:
> > > Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> > > 
> > > > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > > > ---
> > > > 
> > > >  .../platform/rockchip/rkisp1/rkisp1-debug.c    | 18 ++++++++++++++++++
> > > >  1 file changed, 18 insertions(+)
> > > > 
> > > > diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> > > > b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c index
> > > > 71df3dc95e6f..f66b9754472e 100644
> > > > --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> > > > +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> > > > @@ -139,6 +139,21 @@ static int rkisp1_debug_dump_mi_mp_show(struct
> > > > seq_file *m, void *p)> > 
> > > >  }
> > > >  DEFINE_SHOW_ATTRIBUTE(rkisp1_debug_dump_mi_mp);
> > > > 
> > > > +static int rkisp1_debug_dump_is_show(struct seq_file *m, void *p)
> > > > +{
> > > > +       static const struct rkisp1_debug_register registers[] = {
> > > > +               RKISP1_DEBUG_SHD_REG(ISP_IS_H_OFFS),
> > > > +               RKISP1_DEBUG_SHD_REG(ISP_IS_V_OFFS),
> > > > +               RKISP1_DEBUG_SHD_REG(ISP_IS_H_SIZE),
> > > > +               RKISP1_DEBUG_SHD_REG(ISP_IS_V_SIZE),
> > > 
> > > I expect so as you haven't added the register macros in this series so
> > > they must already be there ...
> > 
> > Yep :)
> > 
> > 
> > Paul
> > 
> > > > +               { /* Sentinel */ },
> > > > +       };
> > > > +       struct rkisp1_device *rkisp1 = m->private;
> > > > +
> > > > +       return rkisp1_debug_dump_regs(rkisp1, m, 0, registers);
> > > > +}
> > > > +DEFINE_SHOW_ATTRIBUTE(rkisp1_debug_dump_is);
> > > > +
> > > > 
> > > >  #define RKISP1_DEBUG_DATA_COUNT_BINS   32
> > > >  #define RKISP1_DEBUG_DATA_COUNT_STEP   (4096 /
> > > >  RKISP1_DEBUG_DATA_COUNT_BINS)> > 
> > > > @@ -235,6 +250,9 @@ void rkisp1_debug_init(struct rkisp1_device *rkisp1)
> > > > 
> > > >         debugfs_create_file("mi_mp", 0444, regs_dir, rkisp1,
> > > >         
> > > >                             &rkisp1_debug_dump_mi_mp_fops);
> > > > 
> > > > +
> > > > +       debugfs_create_file("is", 0444, regs_dir, rkisp1,
> > > > +                           &rkisp1_debug_dump_is_fops);
> > > > 
> > > >  }
> > > >  
> > > >  void rkisp1_debug_cleanup(struct rkisp1_device *rkisp1)
> 
> 
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
> 
> 
