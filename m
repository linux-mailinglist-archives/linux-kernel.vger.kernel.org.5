Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C8B7FEC4C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbjK3Jys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbjK3Jyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:54:46 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676F99A;
        Thu, 30 Nov 2023 01:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1701338089; x=1732874089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hnCrBJas0jHQljOR6WgW83uYftpb7okUoxTkkR1KEP0=;
  b=f4yDez26/NW9ycGezqecZMSzjmRIMYmE/8N9ICAf7hDrfgfXGrv/D+rm
   RhBb1BdPkaC5Rc6x2Eqw2ecGHeqtFNIXaLsWnp/kPSmsk13DyN+Itc78e
   30thGbIumx2Mk33w9AokbYBGhGjWfePdrpHwrUTyFMGyl/LJ0u2MXvBFj
   opM/lo7dEDbthhlWe1sCB5bMkCy/BvNy6C2C/DjtPt934HGheS73wc+Mf
   2zXMncYR2F8j6XnIhhNtVSkNyg7gJGAgaQxjmbjtH7jNMVTMuGGlRRVZl
   toKYmeR+2TMsOe0EgxrUGd+1RtqmLY4OVJv+eB+k27m9R21eHx+Vo2hG8
   A==;
X-IronPort-AV: E=Sophos;i="6.04,237,1695679200"; 
   d="scan'208";a="34256271"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 30 Nov 2023 10:54:47 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 84613280075;
        Thu, 30 Nov 2023 10:54:47 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        tomi.valkeinen@ideasonboard.com, umang.jain@ideasonboard.com,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] media: rkisp1: debug: Add register dump for IS
Date:   Thu, 30 Nov 2023 10:54:46 +0100
Message-ID: <4881112.31r3eYUQgx@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <ZWhaFL48cgdHsOPN@pyrite.rasen.tech>
References: <20231129092956.250129-1-paul.elder@ideasonboard.com> <170128834260.3048548.11979514587961676400@ping.linuxembedded.co.uk> <ZWhaFL48cgdHsOPN@pyrite.rasen.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Am Donnerstag, 30. November 2023, 10:47:00 CET schrieb Paul Elder:
> On Wed, Nov 29, 2023 at 08:05:42PM +0000, Kieran Bingham wrote:
> > Quoting Paul Elder (2023-11-29 09:29:55)
> >=20
> > > Add register dump for the image stabilizer module to debugfs.
> >=20
> > Is the Image Stabilizer on all variants of the ISP?
> >=20
> > I.e. is it valid register space on the RK3399 implementation?
>=20
> Yes, it is.

Is there some public documentation available how this ISP works? For RK3399=
 or=20
i.MX8MP.

Best regards,
Alexander

>=20
> > If so then:
> > Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> >=20
> > > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > > ---
> > >=20
> > >  .../platform/rockchip/rkisp1/rkisp1-debug.c    | 18 ++++++++++++++++=
++
> > >  1 file changed, 18 insertions(+)
> > >=20
> > > diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> > > b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c index
> > > 71df3dc95e6f..f66b9754472e 100644
> > > --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> > > +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> > > @@ -139,6 +139,21 @@ static int rkisp1_debug_dump_mi_mp_show(struct
> > > seq_file *m, void *p)> >=20
> > >  }
> > >  DEFINE_SHOW_ATTRIBUTE(rkisp1_debug_dump_mi_mp);
> > >=20
> > > +static int rkisp1_debug_dump_is_show(struct seq_file *m, void *p)
> > > +{
> > > +       static const struct rkisp1_debug_register registers[] =3D {
> > > +               RKISP1_DEBUG_SHD_REG(ISP_IS_H_OFFS),
> > > +               RKISP1_DEBUG_SHD_REG(ISP_IS_V_OFFS),
> > > +               RKISP1_DEBUG_SHD_REG(ISP_IS_H_SIZE),
> > > +               RKISP1_DEBUG_SHD_REG(ISP_IS_V_SIZE),
> >=20
> > I expect so as you haven't added the register macros in this series so
> > they must already be there ...
>=20
> Yep :)
>=20
>=20
> Paul
>=20
> > > +               { /* Sentinel */ },
> > > +       };
> > > +       struct rkisp1_device *rkisp1 =3D m->private;
> > > +
> > > +       return rkisp1_debug_dump_regs(rkisp1, m, 0, registers);
> > > +}
> > > +DEFINE_SHOW_ATTRIBUTE(rkisp1_debug_dump_is);
> > > +
> > >=20
> > >  #define RKISP1_DEBUG_DATA_COUNT_BINS   32
> > >  #define RKISP1_DEBUG_DATA_COUNT_STEP   (4096 /
> > >  RKISP1_DEBUG_DATA_COUNT_BINS)> >=20
> > > @@ -235,6 +250,9 @@ void rkisp1_debug_init(struct rkisp1_device *rkis=
p1)
> > >=20
> > >         debugfs_create_file("mi_mp", 0444, regs_dir, rkisp1,
> > >        =20
> > >                             &rkisp1_debug_dump_mi_mp_fops);
> > >=20
> > > +
> > > +       debugfs_create_file("is", 0444, regs_dir, rkisp1,
> > > +                           &rkisp1_debug_dump_is_fops);
> > >=20
> > >  }
> > > =20
> > >  void rkisp1_debug_cleanup(struct rkisp1_device *rkisp1)


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


