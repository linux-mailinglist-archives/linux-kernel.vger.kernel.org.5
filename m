Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6CA7D14EA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377927AbjJTRcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjJTRcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:32:03 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6267D7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:32:00 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c51388ccebso16185301fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dberlin.org; s=google; t=1697823119; x=1698427919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ut2SkANf/ZVDHXfZooLqBe2U4WYnVtyT3iNPMo0//aY=;
        b=rf9kGH/mb4G3kp+5LcDlpMmcyErOpkEBvhBaPPU5rF/hJu21iTBUcr/S2GDOqkh+4l
         XFwJoCgwso1mHiC20BUgR/hmribaPLXBb+32D67g7kCNGkNSHaRidS7Mz7AVsreTTnE8
         R3s2LYcqWbZSKXfsHnJusrvzCThQttMHPu7Yty7pIKlTACr/LWBaCqKGkSqYwW/676HH
         BPC4M8wz/k+s/gV8XgPleJMMkawLP/qmfVCcTPEtYBZTpfmD0r67qip7LIoJixELeflj
         m1BamBsEm8pbF8adek3ohugmoiRUfgSvDvkr6otysvdwDSMJp1zDbL3KcIXDOx6Tgaw5
         QkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697823119; x=1698427919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ut2SkANf/ZVDHXfZooLqBe2U4WYnVtyT3iNPMo0//aY=;
        b=s0aOBuJYXHA2wnGllxxhhreARQFEqxotUmsQANFOBfmcIc427OL2ikoFRrJXl/GGb9
         6VM1sWVyDaBxhAqCbbDnxur0CeX9q9Uvk+Hgrxob0nQe9tf6Gt4Z5sKPJD6OGO1z2hv9
         X2Vk4Jn/+VgiVQ9yhjDARE5B+HiTWd9csIizFtoV2i+33+uygnNT0jx6PQelvEFFITCg
         nj4tYwjyOoGZzkAVZJahXBU2/v4Zn1cBIDuL3O+2LzYCzIf18pVwZGmc/NYYqJp/B5AL
         ETuRswx1QFtM1OB9K+fC06033erZcM8WSXGcXyCuylS9UWRHyVi4zOy0/p9Yv0bASPNB
         qepA==
X-Gm-Message-State: AOJu0Yz150YHQS/Vr7vy8YeJ4OjeEudiMPaCKWABzRxFwOjwQFxNNL1M
        fNqqs1OLWgWuzVcDi6WoUZwd18hCSlWYejUrzxscig==
X-Google-Smtp-Source: AGHT+IHU4yo1cXJ7wXygQAw4CN7esET8fE1kWJLNeFtIZfKboD1vDyi/upxFWU1mBKGyUpOPJA09PoEbtn0td7w7vrw=
X-Received: by 2002:a2e:b8c4:0:b0:2c5:170d:942f with SMTP id
 s4-20020a2eb8c4000000b002c5170d942fmr1969481ljp.5.1697823118846; Fri, 20 Oct
 2023 10:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697650207.git.dberlin@dberlin.org> <079882bf4a7c026547ecf8ad50a2b7a49ade7130.1697650207.git.dberlin@dberlin.org>
 <b907f696-c966-54ef-3267-12833c6f5d91@broadcom.com>
In-Reply-To: <b907f696-c966-54ef-3267-12833c6f5d91@broadcom.com>
From:   Daniel Berlin <dberlin@dberlin.org>
Date:   Fri, 20 Oct 2023 13:31:47 -0400
Message-ID: <CAF4BwTWzxbpSqeCbcFQjSf3a4sJio8PME-H7w-_juQ3RCmKGmg@mail.gmail.com>
Subject: Re: [PATCH 4/5] wifi: brcmfmac: Support bss_info up to v112
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So, at least in the example code I have, all variants of the 109 and
112 structures both have bcnflags in that place - it was always
missing here.
For example, see
https://android.googlesource.com/kernel/google-modules/wlan/bcmdhd/bcm4398/=
+/refs/heads/android-gs-shusky-5.15-u-qpr1-beta2/include/wlioctl.h
and  compare v109 and v112 of bssinfo.

As such, the 109 and 112 structures are compatible given these definitions.

I don't know if what is there right now is wrong, or it is "yet
another variant" of the 109 structure that we need to handle.
Any idea what the ground truth is?

If we need to separate the structures and support 3 variants (2 109
variants, 1 112 variant), we probably need to start figuring out the
more general structure versioning issue.

We just aren't implementing the bigger ones (for example, there are 5
versions of pfn scanresults, and 6 versions of roam profiles. Most are
still in use, AFAIK)
Any thoughts?

For the bss info here, I suspect I could hide most of this, and use a
structure of function pointers + versioned data that returns the
nn-versioned info that is being asked about (IE the same way we do
with buscore, etc).

IE struct bss_info_data {
void *versioned_data;
nl80211_band (*get_band_for_idx)(struct bss_info_data *, u8 idx);
}

Most of the time we are converting it from this structure to 80211 info, et=
c.

I haven't looked too hard to see if we are really digging around in
this structure, but I would suspect it could be encapsulated.
This would in turn let us avoid using feature flags to control
structure versions (we would just set them after querying the
firmware), and would make it easier to clean up/refactor code.

I'm open to other ideas as well.


On Fri, Oct 20, 2023 at 5:59=E2=80=AFAM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 10/19/2023 3:42 AM, Daniel Berlin wrote:
> > From: Hector Martin <marcan@marcan.st>
> >
> > The structures are compatible and just add fields, so we can just treat
> > it as always v112. If we start using new fields, that will have to be
> > gated on the version.
>
> Seems EHT is creeping in here.
>
> Having doubts about compatibility statement (see below)...
>
> > Signed-off-by: Hector Martin <marcan@marcan.st>
> > ---
> >   .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  5 ++-
> >   .../broadcom/brcm80211/brcmfmac/fwil_types.h  | 37 +++++++++++++++++-=
-
> >   2 files changed, 36 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.=
c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > index 4cf728368892..bc8355d7f9b5 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > @@ -3496,8 +3496,9 @@ static s32 brcmf_inform_bss(struct brcmf_cfg80211=
_info *cfg)
> >
> >       bss_list =3D (struct brcmf_scan_results *)cfg->escan_info.escan_b=
uf;
> >       if (bss_list->count !=3D 0 &&
> > -         bss_list->version !=3D BRCMF_BSS_INFO_VERSION) {
> > -             bphy_err(drvr, "Version %d !=3D WL_BSS_INFO_VERSION\n",
> > +         (bss_list->version < BRCMF_BSS_INFO_MIN_VERSION ||
> > +         bss_list->version > BRCMF_BSS_INFO_MAX_VERSION)) {
> > +             bphy_err(drvr, "BSS info version %d unsupported\n",
> >                        bss_list->version);
> >               return -EOPNOTSUPP;
> >       }
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_type=
s.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> > index 1077e6f1d61a..81f2d77cb004 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> > @@ -18,7 +18,8 @@
> >   #define BRCMF_ARP_OL_HOST_AUTO_REPLY        0x00000004
> >   #define BRCMF_ARP_OL_PEER_AUTO_REPLY        0x00000008
> >
> > -#define      BRCMF_BSS_INFO_VERSION  109 /* curr ver of brcmf_bss_info=
_le struct */
> > +#define      BRCMF_BSS_INFO_MIN_VERSION      109 /* min ver of brcmf_b=
ss_info_le struct */
> > +#define      BRCMF_BSS_INFO_MAX_VERSION      112 /* max ver of brcmf_b=
ss_info_le struct */
> >   #define BRCMF_BSS_RSSI_ON_CHANNEL   0x0004
> >
> >   #define BRCMF_STA_BRCM                      0x00000001      /* Runnin=
g a Broadcom driver */
> > @@ -323,28 +324,56 @@ struct brcmf_bss_info_le {
> >       __le16 capability;      /* Capability information */
> >       u8 SSID_len;
> >       u8 SSID[32];
> > +     u8 bcnflags;            /* additional flags w.r.t. beacon */
>
> Ehm. Coming back to your statement "structures are compatible and just
> add fields". How are they compatible? You now treat v109 struct as v112
> so fields below are shifted because of bcnflags. So you read invalid
> information. This does not fly or I am missing something here.
>
> >       struct {
> >               __le32 count;   /* # rates in this set */
> >               u8 rates[16]; /* rates in 500kbps units w/hi bit set if b=
asic */
> >       } rateset;              /* supported rates */
> >       __le16 chanspec;        /* chanspec for bss */
> >       __le16 atim_window;     /* units are Kusec */
>
> [...]
