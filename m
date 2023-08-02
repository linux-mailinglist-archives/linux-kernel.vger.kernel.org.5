Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD81D76C54A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjHBGay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjHBGav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:30:51 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A3D2701;
        Tue,  1 Aug 2023 23:30:47 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 4366717B488;
        Wed,  2 Aug 2023 08:30:44 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1690957844; bh=Kew5VrVJRtBYWMvLbgJeSUgat0b2rneiIFXJZAJVDrU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pUfZcaMQv+8qBr6qUSW0xBC8VSdrM1RWNipTNYyt+qQnBUf/ovuQzqoGp/7kewdIW
         Cz4NqpgAcoRAieSV3GRh9re6AgqNpTfCJBRtZhsgqLEYOvOHIKGEJX2gMop5usFH+6
         MWNoDiURoRDPSLdnhbwA8L0o29U/w0C8IU+sC2L91gI+74gQeqsJW82SSH+saQFqDE
         OiLK2gHSItbwDO0E8mLBB22qONCb7IAY08vnw1QHTOCK6pm/ulyu+c/3bUgrN9GkHI
         yMxNeC38dHC4NosDCsngPozn6OAU9n6wzN0EbqUYuyqxyh/y6ByHdoLOqldOAlItR5
         IAgb5RBQxafjA==
Date:   Wed, 2 Aug 2023 08:30:43 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Franky Lin <franky.lin@broadcom.com>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Ian Lin <ian.lin@infineon.com>,
        Wright Feng <wright.feng@cypress.com>,
        Hector Martin <marcan@marcan.st>,
        Prasanna Kerekoppa <prasanna.kerekoppa@cypress.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ramesh Rangavittal <ramesh.rangavittal@infineon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ryohei Kondo <ryohei.kondo@cypress.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Brian Henriquez <brian.henriquez@cypress.com>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <SHA-cyfmac-dev-list@infineon.com>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH v1 1/3] wifi: brcm80211: drop struct brcmf_p2p_scan_le
Message-ID: <20230802083043.092c2798@meshulam.tesarici.cz>
In-Reply-To: <CA+8PC_evb-6Y3dKnAN4BN=ODEVxY5-cDb6Lc72u0j1WBtx7p1A@mail.gmail.com>
References: <cover.1690904067.git.petr.tesarik.ext@huawei.com>
        <b94c048c8decefeca41ceac5f826da67a8d727a8.1690904067.git.petr.tesarik.ext@huawei.com>
        <327159d6-f520-bea1-c6b0-facda7c26699@huaweicloud.com>
        <CA+8PC_evb-6Y3dKnAN4BN=ODEVxY5-cDb6Lc72u0j1WBtx7p1A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 17:08:55 -0700
Franky Lin <franky.lin@broadcom.com> wrote:

> On Tue, Aug 1, 2023 at 10:57=E2=80=AFAM Petr Tesarik
> <petrtesarik@huaweicloud.com> wrote:
> >
> > On 8/1/2023 5:36 PM, Petr Tesarik wrote: =20
> > > From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> > >
> > > The 'S' scan method is not implemented. The type member is always wri=
tten
> > > as 'E' and never read. Consequently, struct brcmf_p2p_scan_le can be
> > > replaced with struct brcmf_escan_params_le. =20
> >
> > Seeing that Hans has already fixed the actual issue with the flex array,
> > this whole series is not needed.
> >
> > But maybe this simplification has some value on its own? =20
>=20
> I don't think this change would work.
>=20
> > Petr T
> > =20
> > > Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
> > > ---
> > >  .../broadcom/brcm80211/brcmfmac/p2p.c         | 38 ++++-------------=
--
> > >  1 file changed, 8 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b=
/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> > > index d4492d02e4ea..915f95760470 100644
> > > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> > > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> > > @@ -123,23 +123,6 @@ enum brcmf_p2p_disc_state {
> > >       WL_P2P_DISC_ST_SEARCH
> > >  };
> > >
> > > -/**
> > > - * struct brcmf_p2p_scan_le - P2P specific scan request.
> > > - *
> > > - * @type: type of scan method requested (values: 'E' or 'S').
> > > - * @reserved: reserved (ignored).
> > > - * @eparams: parameters used for type 'E'.
> > > - * @sparams: parameters used for type 'S'.
> > > - */
> > > -struct brcmf_p2p_scan_le {
> > > -     u8 type;
> > > -     u8 reserved[3];
> > > -     union {
> > > -             struct brcmf_escan_params_le eparams;
> > > -             struct brcmf_scan_params_le sparams;
> > > -     };
> > > -};
> > > -
> > >  /**
> > >   * struct brcmf_p2p_pub_act_frame - WiFi P2P Public Action Frame
> > >   *
> > > @@ -646,14 +629,14 @@ static s32 brcmf_p2p_escan(struct brcmf_p2p_inf=
o *p2p, u32 num_chans,
> > >  {
> > >       struct brcmf_pub *drvr =3D p2p->cfg->pub;
> > >       s32 ret =3D 0;
> > > -     s32 memsize =3D offsetof(struct brcmf_p2p_scan_le,
> > > -                            eparams.params_le.channel_list);
> > > +     s32 memsize =3D offsetof(struct brcmf_escan_params_le,
> > > +                            params_le.channel_list);
> > >       s32 nprobes;
> > >       s32 active;
> > >       u32 i;
> > >       u8 *memblk;
> > >       struct brcmf_cfg80211_vif *vif;
> > > -     struct brcmf_p2p_scan_le *p2p_params;
> > > +     struct brcmf_escan_params_le *eparams;
> > >       struct brcmf_scan_params_le *sparams;
> > >
> > >       memsize +=3D num_chans * sizeof(__le16);
> > > @@ -667,8 +650,8 @@ static s32 brcmf_p2p_escan(struct brcmf_p2p_info =
*p2p, u32 num_chans,
> > >               ret =3D -EINVAL;
> > >               goto exit;
> > >       }
> > > -     p2p_params =3D (struct brcmf_p2p_scan_le *)memblk;
> > > -     sparams =3D &p2p_params->eparams.params_le;
> > > +     eparams =3D (struct brcmf_escan_params_le *)memblk;
> > > +     sparams =3D &eparams->params_le;
> > >
> > >       switch (search_state) {
> > >       case WL_P2P_DISC_ST_SEARCH:
> > > @@ -698,11 +681,6 @@ static s32 brcmf_p2p_escan(struct brcmf_p2p_info=
 *p2p, u32 num_chans,
> > >
> > >       brcmf_p2p_set_discover_state(vif->ifp, search_state, 0, 0);
> > >
> > > -     /*
> > > -      * set p2p scan parameters.
> > > -      */
> > > -     p2p_params->type =3D 'E';
> > > -
> > >       /* determine the scan engine parameters */
> > >       sparams->bss_type =3D DOT11_BSSTYPE_ANY;
> > >       sparams->scan_type =3D BRCMF_SCANTYPE_ACTIVE;
> > > @@ -747,9 +725,9 @@ static s32 brcmf_p2p_escan(struct brcmf_p2p_info =
*p2p, u32 num_chans,
> > >               sparams->channel_list[i] =3D cpu_to_le16(chanspecs[i]);
> > >
> > >       /* set the escan specific parameters */
> > > -     p2p_params->eparams.version =3D cpu_to_le32(BRCMF_ESCAN_REQ_VER=
SION);
> > > -     p2p_params->eparams.action =3D  cpu_to_le16(WL_ESCAN_ACTION_STA=
RT);
> > > -     p2p_params->eparams.sync_id =3D cpu_to_le16(0x1234);
> > > +     eparams->version =3D cpu_to_le32(BRCMF_ESCAN_REQ_VERSION);
> > > +     eparams->action =3D  cpu_to_le16(WL_ESCAN_ACTION_START);
> > > +     eparams->sync_id =3D cpu_to_le16(0x1234);
> > >       /* perform p2p scan on primary device */
> > >       ret =3D brcmf_fil_bsscfg_data_set(vif->ifp, "p2p_scan", memblk,=
 memsize); =20
>=20
> Firmware is expecting struct brcmf_p2p_scan_le as the parameter for
> "p2p_scan" iovar.

Ah, you're right, the layout is defined by the firmware protocol, and I
missed that part.

Sorry for the fuss,
Petr T
