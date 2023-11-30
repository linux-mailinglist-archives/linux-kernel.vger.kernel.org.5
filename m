Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FE57FECA8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjK3KSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjK3KSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:18:40 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709D41A3;
        Thu, 30 Nov 2023 02:18:46 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bba1dd05fso1130794e87.0;
        Thu, 30 Nov 2023 02:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701339524; x=1701944324; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c5FGYC1au+a2xY09Qm1hrPpvUGudmGYI587sIOf2nQU=;
        b=i1bt4jRaVzh/qQfiI9kPe/qG2sYVIUEKCrcaqfxSgwtnBDinnCqGPWxuWcvBjr6lo1
         /M0YSWEh5c219Zkl0AfAMzOUkfRHQZQx7xOB5qN/B+19dY4XQUTZEzTUyChQTpLUtq8J
         Mh5shUHV7khkfzW7b2Hbbl7qp/hXhEI3s7VknPG6sbtv+i94e8z/FCBHgRh1hNoCpR8o
         5i0jTW/Z9LDtyT5K7N5KRLErUcN68xprmyVXDWhRo82+NzmbgCuIf6fPxqNEHwVSeBnO
         fkZ6oq+ZC6qPKvaM/+HBybP0Nf5Lc4/x3vcYDXJlJ0eTKikC/lZVTsghp0SsFlfRYh7V
         wFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701339524; x=1701944324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5FGYC1au+a2xY09Qm1hrPpvUGudmGYI587sIOf2nQU=;
        b=cCtZLqMw8vvKfmRnMf9EcAfoCLphlYhF3HlffT6lxN0OG7ht/ZXIBpwzPPKbdsgPQI
         zvEKfR/iqvXwozRc20S8TCYWnQ2DQTaqSVYnPfJKV1NVbAPI14IYA3KeDjcKdII9G7jV
         L8I6O7Q0EFBAGJOtsp7/sJeOoiI8/kY46Y6EUGZcjzd4LS26rMQ9SfYoWIKawbyTyALC
         UekwMBl+QgqoCB7sbE6irEcrQUk9okn5817Q7tJrXFjcg0BekdYCnWpfkJSqEyy0wTip
         PktLbCun0t9y4JzBNlf+4E/ogUuC+X1jDb3S3J9jAhb33Ba5SsmKfuV/hm4C1v4Ds4JO
         qocA==
X-Gm-Message-State: AOJu0YzsyOS3vX6YsEukBnIXhPIdGgfoxsq1gldUuz9JwVtt10CtSmK5
        /6OJJRod9Ul4+aoKYK1W2Sw=
X-Google-Smtp-Source: AGHT+IEZ+H12n904PcCJ7l4olz+SFWc7iywSBqp3Ai7Zj9ZXEYMer4AAaHhzG9aSVrfDt+Sq3y9b3Q==
X-Received: by 2002:ac2:504f:0:b0:50b:bf06:ea0b with SMTP id a15-20020ac2504f000000b0050bbf06ea0bmr4812487lfm.53.1701339524296;
        Thu, 30 Nov 2023 02:18:44 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-2-39-143-167.cust.vodafonedsl.it. [2.39.143.167])
        by smtp.gmail.com with ESMTPSA id hg10-20020a05600c538a00b0040b398f0585sm1566915wmb.9.2023.11.30.02.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 02:18:43 -0800 (PST)
Date:   Thu, 30 Nov 2023 11:18:41 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        tomi.valkeinen@ideasonboard.com, umang.jain@ideasonboard.com,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] media: rkisp1: debug: Add register dump for IS
Message-ID: <ZWhhgQPSgKkkK/ma@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

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

For the ISP there is some public docs into imx8mp reference manual at page 5895
chapter:

13.14 Image Signal Processor (ISP)

https://www.nxp.com/webapp/Download?colCode=IMX8MPRM
https://www.nxp.com/design/development-boards/i-mx-evaluation-and-development-boards/evaluation-kit-for-the-i-mx-8m-plus-applications-processor:8MPLUSLPD4-EVK

This is not the full docs I think but cover some part of the ISP
functionality.

Hope this help.

Regards,
Tommaso

> 
> Best regards,
> Alexander
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
> 
