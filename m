Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7E77CC9E7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343958AbjJQR3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjJQR3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:29:05 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D516DAB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:29:02 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso9284656a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697563741; x=1698168541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbaoHGtRFkb4iQdi7piJDjd4r/VjAzI9OU8YnNVrjQk=;
        b=J5ZECETHOTFCjqDiaBpyziIQSsv/rUHWS0N6AqctiYOzNzKNv8Ri1QvIkIrLSQ+REQ
         +oAD/o5ZzJfdeU0WyLxVdFv2pKdNTlfLT33iQT3cxkXHhAEffd/1Xl4+Dr2HpnnUaWO+
         OorKU2cvQmExrwYIJG/dnHAlqQeTuXI2pa6qU8YmqWdGMVESBvTu6xKYYrb+FFtQb+vF
         mgv/FJZgV8nOK3GriTfSff3IIykl0aShhXiKBQe9z7ergDJlPUzrdyR3cDwsdj4hPzQW
         K37zBMcvhHHrTwV1594aFS4wM/IAh1C3wFHhFAq42Bs+QKGxtkFZdF/G6N2Kmfu8DnSG
         CUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697563741; x=1698168541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbaoHGtRFkb4iQdi7piJDjd4r/VjAzI9OU8YnNVrjQk=;
        b=LAVQTRyHTikIdvP6xZ2b17n5eBJITUJYAiF+8kp0K3JKQ8zj1w6CXxmrsSwCGWg0rU
         h/toVcJcEPl1QSUY0ofNIx4M0weOYJK23zRpSeF+I3nTtKWFihrOjDLhpxpoZ+9hEt3V
         ilGvdcRIH3OCXYlboMv0y6T76UqLC7KETnd5JBlNst2SKUIJ3qC8i+9We99VCaxe2kCS
         F6hnW0Rvg7jQ9VzX7eBKjAdcljC2qM5AiPuMJyGvBDIq+QCndWitNSLg7PxPs6SA2xCM
         9Qqzqa3nXwBHUZVPZXvRqt4ArEyydJ+5WmArCIYfB/n+naZlqFBQ42SY9B3GyanZ/hwR
         R90g==
X-Gm-Message-State: AOJu0Ywi4jlB0rgJznzzhoS2wCXl7It8jET883BVx11V1Aoe845BwtCT
        YH7411ZxvoMHPLu3T5UQ7mSYVm0HYkjHH9pTNbBgBrICCDtSdgdIGJ+Ztw==
X-Google-Smtp-Source: AGHT+IEEdof/SA6oeV0xMjDWOT8etyV5eJRD/VxqCEWFm4nunalOCqm6NO1Y/2Key1Cw4GX92D5gcv0E1+f0+MPOrto=
X-Received: by 2002:a50:baa7:0:b0:53e:d16e:9b7f with SMTP id
 x36-20020a50baa7000000b0053ed16e9b7fmr2648967ede.34.1697563741185; Tue, 17
 Oct 2023 10:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v2-1-6c7567e1d3b8@google.com>
 <CA+8PC_cZbchz-i0Wfhr1rE5M-xqUVdQZce94TowU=yqOynDBKg@mail.gmail.com>
In-Reply-To: <CA+8PC_cZbchz-i0Wfhr1rE5M-xqUVdQZce94TowU=yqOynDBKg@mail.gmail.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 17 Oct 2023 10:28:49 -0700
Message-ID: <CAFhGd8pxU=ZS3hodJxP5BPpf21rq66KKKNU9MHouimAjX+wHLw@mail.gmail.com>
Subject: Re: [PATCH v2] brcmfmac: replace deprecated strncpy
To:     Franky Lin <franky.lin@broadcom.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 9:49=E2=80=AFAM Franky Lin <franky.lin@broadcom.com=
> wrote:
>
>  Hi Justin,
>
> On Mon, Oct 16, 2023 at 3:14=E2=80=AFPM Justin Stitt <justinstitt@google.=
com> wrote:
> >
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> >
> > This patch replaces multiple strncpy uses. For easier reading, I'll lis=
t
> > each destination buffer and mention whether it requires either
> > NUL-termination or NUL-padding.
>
> Kudos to the detailed analysis of each instance. One thing I can think
> of to make this better is to split it into smaller patches so if any
> regression is observed, only the specific code causing it needs to be
> reverted. Maybe instance 2, 3, 4 can be handled in one patch since
> they are touching the country code in one file. The other instances
> each can be an individual patch.
>
> The "brcmfmac" in the title is not accurate. The change touches both
> brcmfmac and brcmsmac. So "brcm80211" would be more appropriate.

Got it, will send new revision with a new subject + split up patches.

>
> Thanks,
> - Franky
>
> >
> > 1) ifp->ndev->name
> >
> > We expect ifp->ndev->name to be NUL-terminated based on its use in
> > format strings within core.c:
> > 67 |       char *brcmf_ifname(struct brcmf_if *ifp)
> > 68 |       {
> > 69 |            if (!ifp)
> > 70 |                    return "<if_null>";
> > 71 |
> > 72 |            if (ifp->ndev)
> > 73 |                    return ifp->ndev->name;
> > 74 |
> > 75 |            return "<if_none>";
> > 76 |       }
> > ...
> > 288 |       static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *=
skb,
> > 289 |                                              struct net_device *n=
dev) {
> > ...
> > 330 |       brcmf_dbg(INFO, "%s: insufficient headroom (%d)\n",
> > 331 |                 brcmf_ifname(ifp), head_delta);
> > ...
> > 336 |       bphy_err(drvr, "%s: failed to expand headroom\n",
> > 337 |                brcmf_ifname(ifp));
> >
> > In this context, a suitable replacement is `strscpy` [2] due to the fac=
t
> > that it guarantees NUL-termination on the destination buffer without
> > unnecessarily NUL-padding.
> >
> > 2) wlc->pub->srom_ccode
> >
> > We're just copying two bytes from ccode into wlc->pub->srom_ccode with
> > no expectation that srom_ccode be NUL-terminated.
> > wlc->pub->srom_ccode is only used in regulatory_hint():
> > 1193 |       if (wl->pub->srom_ccode[0] &&
> > 1194 |           regulatory_hint(wl->wiphy, wl->pub->srom_ccode))
> > 1195 |               wiphy_err(wl->wiphy, "%s: regulatory hint failed\n=
", __func__);
> >
> > We can see that only index 0 and index 1 are accessed.
> > 3307 |       int regulatory_hint(struct wiphy *wiphy, const char *alpha=
2)
> > 3308 |       {
> > ...  |          ...
> > 3322 |          request->alpha2[0] =3D alpha2[0];
> > 3323 |          request->alpha2[1] =3D alpha2[1];
> > ...  |          ...
> > 3332 |       }
> >
> > Since this is just a simple byte copy with correct lengths, let's use
> > memcpy(). There should be no functional change.
> >
> > 3) wlc->country_default, 4) wlc->autocountry_default
> >
> > FWICT, these two aren't used anywhere. At any rate, let's apply the sam=
e
> > reasoning as above and just use memcpy().
> >
> > 5) di->name
> >
> > We expect di->name to be NUL-terminated based on its usage with format
> > strings:
> > |       brcms_dbg_dma(di->core,
> > |                     "%s: DMA64 tx doesn't have AE set\n",
> > |                     di->name);
> >
> > Looking at its allocation we can see that it is already zero-allocated
> > which means NUL-padding is not required:
> > |       di =3D kzalloc(sizeof(struct dma_info), GFP_ATOMIC);
> >
> > 6) wlc->modulecb[i].name
> >
> > We expect each name in wlc->modulecb to be NUL-terminated based on thei=
r
> > usage with strcmp():
> > |       if (!strcmp(wlc->modulecb[i].name, name) &&
> >
> > NUL-padding is not required as wlc is zero-allocated in:
> > brcms_c_attach_malloc() ->
> > |       wlc =3D kzalloc(sizeof(struct brcms_c_info), GFP_ATOMIC);
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Changes in v2:
> > - add other strncpy replacements
> > - Link to v1: https://lore.kernel.org/r/20231016-strncpy-drivers-net-wi=
reless-broadcom-brcm80211-brcmfmac-cfg80211-c-v1-1-4234807ca07e@google.com
> > ---
> > Note: build-tested only.
> >
> > I've grouped these all into a single patch instead of a series as many
> > of the replacements are related to others and rely on context from one
> > another to justify changes.
> > ---
> >  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
> >  drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c      | 2 +-
> >  drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c  | 6 +++---
> >  drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c      | 3 +--
> >  drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c     | 4 ++--
> >  5 files changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.=
c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > index 2a90bb24ba77..7daa418df877 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > @@ -866,7 +866,7 @@ struct wireless_dev *brcmf_apsta_add_vif(struct wip=
hy *wiphy, const char *name,
> >                 goto fail;
> >         }
> >
> > -       strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
> > +       strscpy(ifp->ndev->name, name, sizeof(ifp->ndev->name));
> >         err =3D brcmf_net_attach(ifp, true);
> >         if (err) {
> >                 bphy_err(drvr, "Registering netdevice failed\n");
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/d=
rivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> > index d4492d02e4ea..6e0c90f4718b 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> > @@ -2334,7 +2334,7 @@ struct wireless_dev *brcmf_p2p_add_vif(struct wip=
hy *wiphy, const char *name,
> >                 goto fail;
> >         }
> >
> > -       strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
> > +       strscpy(ifp->ndev->name, name, sizeof(ifp->ndev->name));
> >         ifp->ndev->name_assign_type =3D name_assign_type;
> >         err =3D brcmf_net_attach(ifp, true);
> >         if (err) {
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c=
 b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
> > index 5a6d9c86552a..f6962e558d7c 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
> > @@ -341,7 +341,7 @@ struct brcms_cm_info *brcms_c_channel_mgr_attach(st=
ruct brcms_c_info *wlc)
> >         /* store the country code for passing up as a regulatory hint *=
/
> >         wlc_cm->world_regd =3D brcms_world_regd(ccode, ccode_len);
> >         if (brcms_c_country_valid(ccode))
> > -               strncpy(wlc->pub->srom_ccode, ccode, ccode_len);
> > +               memcpy(wlc->pub->srom_ccode, ccode, ccode_len);
> >
> >         /*
> >          * If no custom world domain is found in the SROM, use the
> > @@ -354,10 +354,10 @@ struct brcms_cm_info *brcms_c_channel_mgr_attach(=
struct brcms_c_info *wlc)
> >         }
> >
> >         /* save default country for exiting 11d regulatory mode */
> > -       strncpy(wlc->country_default, ccode, ccode_len);
> > +       memcpy(wlc->country_default, ccode, ccode_len);
> >
> >         /* initialize autocountry_default to driver default */
> > -       strncpy(wlc->autocountry_default, ccode, ccode_len);
> > +       memcpy(wlc->autocountry_default, ccode, ccode_len);
> >
> >         brcms_c_set_country(wlc_cm, wlc_cm->world_regd);
> >
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c b/d=
rivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
> > index b7df576bb84d..3d5c1ef8f7f2 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
> > @@ -584,8 +584,7 @@ struct dma_pub *dma_attach(char *name, struct brcms=
_c_info *wlc,
> >                       rxextheadroom, nrxpost, rxoffset, txregbase, rxre=
gbase);
> >
> >         /* make a private copy of our callers name */
> > -       strncpy(di->name, name, MAXNAMEL);
> > -       di->name[MAXNAMEL - 1] =3D '\0';
> > +       strscpy(di->name, name, sizeof(di->name));
> >
> >         di->dmadev =3D core->dma_dev;
> >
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c b/=
drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
> > index b3663c5ef382..34460b5815d0 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
> > @@ -5551,8 +5551,8 @@ int brcms_c_module_register(struct brcms_pub *pub=
,
> >         /* find an empty entry and just add, no duplication check! */
> >         for (i =3D 0; i < BRCMS_MAXMODULES; i++) {
> >                 if (wlc->modulecb[i].name[0] =3D=3D '\0') {
> > -                       strncpy(wlc->modulecb[i].name, name,
> > -                               sizeof(wlc->modulecb[i].name) - 1);
> > +                       strscpy(wlc->modulecb[i].name, name,
> > +                               sizeof(wlc->modulecb[i].name));
> >                         wlc->modulecb[i].hdl =3D hdl;
> >                         wlc->modulecb[i].down_fn =3D d_fn;
> >                         return 0;
> >
> > ---
> > base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> > change-id: 20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brc=
mfmac-cfg80211-c-a20108421685
> >
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> >

Thanks
Justin
