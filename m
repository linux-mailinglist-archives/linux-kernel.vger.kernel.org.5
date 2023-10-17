Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609317CC912
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjJQQtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQQtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:49:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EF4AB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:49:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53e04b17132so9765714a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697561358; x=1698166158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DttUtOLhFuPQXJmtgFAiN2AMJwg/X33rEehouGZ0ddw=;
        b=BZxaFWnGxcWDJ2UDtSHWYAnhjCSqWnnGMZF/vWjbKzNMWFuaXGiYvNdxnX80fRr08h
         7OHt/EDofkp131zCs80ZiCGDIOOhVqXAW1O4WtN+n8YCs4HG7JMSgAh6mOOSLhIA9KYi
         5vBeORgCGu8PaKfV2xeAV4CmCdJUhlQKBdCk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697561358; x=1698166158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DttUtOLhFuPQXJmtgFAiN2AMJwg/X33rEehouGZ0ddw=;
        b=g+k6eMRgD9nE6ONmzTyWLMll2nqnAlUlDoT0aiWyOIwTqh17+NdZqk9ZPLqAN14m+Q
         Ww/aCHX8gW7ksqeg36llQMdcKDeEPljDAEVj5i4AyZj9jPhgThkDuQumbSHbdfimAtEs
         GnfCyByWjc6jfMTyFWcGGxR4ogOuwMLpnhUGbBtan2IiCXc6iPxw5+wN6dI2yywI8kmo
         HUyifoQarMdVPspf8P/CZ1SUUf6/AfmtTdKK5u++0szr8oec+AkN5ExMLgBrV75MSqkP
         alYV2lFd6n3seW5ogaMSBcYzTsJc6Q54ruROKK5VrtF7SAJq6NtjDC06Y0MiEoc+Udsm
         0r6g==
X-Gm-Message-State: AOJu0YzbMDUOiYg9llzxDlpWRXXwWogyTfrUL36xADhV2xOXihs3M7aG
        6fuQvo/4+/1GIt6rOkmpEMZ934ENTj61raVinEnIlw==
X-Google-Smtp-Source: AGHT+IGRkUdhXbmnsUGtlvDgYD5avMz7od1k0yFfEJrjgyIGhjrEGq1DpoU5phQx8mEKsyVL8N2pOyQwcLxPwopMOPY=
X-Received: by 2002:a05:6402:40c8:b0:526:9cfb:c12 with SMTP id
 z8-20020a05640240c800b005269cfb0c12mr2336566edb.38.1697561358293; Tue, 17 Oct
 2023 09:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v2-1-6c7567e1d3b8@google.com>
In-Reply-To: <20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v2-1-6c7567e1d3b8@google.com>
From:   Franky Lin <franky.lin@broadcom.com>
Date:   Tue, 17 Oct 2023 09:48:51 -0700
Message-ID: <CA+8PC_cZbchz-i0Wfhr1rE5M-xqUVdQZce94TowU=yqOynDBKg@mail.gmail.com>
Subject: Re: [PATCH v2] brcmfmac: replace deprecated strncpy
To:     Justin Stitt <justinstitt@google.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c558a80607ec4d56"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c558a80607ec4d56
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Hi Justin,

On Mon, Oct 16, 2023 at 3:14=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> This patch replaces multiple strncpy uses. For easier reading, I'll list
> each destination buffer and mention whether it requires either
> NUL-termination or NUL-padding.

Kudos to the detailed analysis of each instance. One thing I can think
of to make this better is to split it into smaller patches so if any
regression is observed, only the specific code causing it needs to be
reverted. Maybe instance 2, 3, 4 can be handled in one patch since
they are touching the country code in one file. The other instances
each can be an individual patch.

The "brcmfmac" in the title is not accurate. The change touches both
brcmfmac and brcmsmac. So "brcm80211" would be more appropriate.

Thanks,
- Franky

>
> 1) ifp->ndev->name
>
> We expect ifp->ndev->name to be NUL-terminated based on its use in
> format strings within core.c:
> 67 |       char *brcmf_ifname(struct brcmf_if *ifp)
> 68 |       {
> 69 |            if (!ifp)
> 70 |                    return "<if_null>";
> 71 |
> 72 |            if (ifp->ndev)
> 73 |                    return ifp->ndev->name;
> 74 |
> 75 |            return "<if_none>";
> 76 |       }
> ...
> 288 |       static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *sk=
b,
> 289 |                                              struct net_device *nde=
v) {
> ...
> 330 |       brcmf_dbg(INFO, "%s: insufficient headroom (%d)\n",
> 331 |                 brcmf_ifname(ifp), head_delta);
> ...
> 336 |       bphy_err(drvr, "%s: failed to expand headroom\n",
> 337 |                brcmf_ifname(ifp));
>
> In this context, a suitable replacement is `strscpy` [2] due to the fact
> that it guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
>
> 2) wlc->pub->srom_ccode
>
> We're just copying two bytes from ccode into wlc->pub->srom_ccode with
> no expectation that srom_ccode be NUL-terminated.
> wlc->pub->srom_ccode is only used in regulatory_hint():
> 1193 |       if (wl->pub->srom_ccode[0] &&
> 1194 |           regulatory_hint(wl->wiphy, wl->pub->srom_ccode))
> 1195 |               wiphy_err(wl->wiphy, "%s: regulatory hint failed\n",=
 __func__);
>
> We can see that only index 0 and index 1 are accessed.
> 3307 |       int regulatory_hint(struct wiphy *wiphy, const char *alpha2)
> 3308 |       {
> ...  |          ...
> 3322 |          request->alpha2[0] =3D alpha2[0];
> 3323 |          request->alpha2[1] =3D alpha2[1];
> ...  |          ...
> 3332 |       }
>
> Since this is just a simple byte copy with correct lengths, let's use
> memcpy(). There should be no functional change.
>
> 3) wlc->country_default, 4) wlc->autocountry_default
>
> FWICT, these two aren't used anywhere. At any rate, let's apply the same
> reasoning as above and just use memcpy().
>
> 5) di->name
>
> We expect di->name to be NUL-terminated based on its usage with format
> strings:
> |       brcms_dbg_dma(di->core,
> |                     "%s: DMA64 tx doesn't have AE set\n",
> |                     di->name);
>
> Looking at its allocation we can see that it is already zero-allocated
> which means NUL-padding is not required:
> |       di =3D kzalloc(sizeof(struct dma_info), GFP_ATOMIC);
>
> 6) wlc->modulecb[i].name
>
> We expect each name in wlc->modulecb to be NUL-terminated based on their
> usage with strcmp():
> |       if (!strcmp(wlc->modulecb[i].name, name) &&
>
> NUL-padding is not required as wlc is zero-allocated in:
> brcms_c_attach_malloc() ->
> |       wlc =3D kzalloc(sizeof(struct brcms_c_info), GFP_ATOMIC);
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - add other strncpy replacements
> - Link to v1: https://lore.kernel.org/r/20231016-strncpy-drivers-net-wire=
less-broadcom-brcm80211-brcmfmac-cfg80211-c-v1-1-4234807ca07e@google.com
> ---
> Note: build-tested only.
>
> I've grouped these all into a single patch instead of a series as many
> of the replacements are related to others and rely on context from one
> another to justify changes.
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c      | 2 +-
>  drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c  | 6 +++---
>  drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c      | 3 +--
>  drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c     | 4 ++--
>  5 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c =
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 2a90bb24ba77..7daa418df877 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -866,7 +866,7 @@ struct wireless_dev *brcmf_apsta_add_vif(struct wiphy=
 *wiphy, const char *name,
>                 goto fail;
>         }
>
> -       strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
> +       strscpy(ifp->ndev->name, name, sizeof(ifp->ndev->name));
>         err =3D brcmf_net_attach(ifp, true);
>         if (err) {
>                 bphy_err(drvr, "Registering netdevice failed\n");
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/dri=
vers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> index d4492d02e4ea..6e0c90f4718b 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> @@ -2334,7 +2334,7 @@ struct wireless_dev *brcmf_p2p_add_vif(struct wiphy=
 *wiphy, const char *name,
>                 goto fail;
>         }
>
> -       strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
> +       strscpy(ifp->ndev->name, name, sizeof(ifp->ndev->name));
>         ifp->ndev->name_assign_type =3D name_assign_type;
>         err =3D brcmf_net_attach(ifp, true);
>         if (err) {
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c b=
/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
> index 5a6d9c86552a..f6962e558d7c 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
> @@ -341,7 +341,7 @@ struct brcms_cm_info *brcms_c_channel_mgr_attach(stru=
ct brcms_c_info *wlc)
>         /* store the country code for passing up as a regulatory hint */
>         wlc_cm->world_regd =3D brcms_world_regd(ccode, ccode_len);
>         if (brcms_c_country_valid(ccode))
> -               strncpy(wlc->pub->srom_ccode, ccode, ccode_len);
> +               memcpy(wlc->pub->srom_ccode, ccode, ccode_len);
>
>         /*
>          * If no custom world domain is found in the SROM, use the
> @@ -354,10 +354,10 @@ struct brcms_cm_info *brcms_c_channel_mgr_attach(st=
ruct brcms_c_info *wlc)
>         }
>
>         /* save default country for exiting 11d regulatory mode */
> -       strncpy(wlc->country_default, ccode, ccode_len);
> +       memcpy(wlc->country_default, ccode, ccode_len);
>
>         /* initialize autocountry_default to driver default */
> -       strncpy(wlc->autocountry_default, ccode, ccode_len);
> +       memcpy(wlc->autocountry_default, ccode, ccode_len);
>
>         brcms_c_set_country(wlc_cm, wlc_cm->world_regd);
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c b/dri=
vers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
> index b7df576bb84d..3d5c1ef8f7f2 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
> @@ -584,8 +584,7 @@ struct dma_pub *dma_attach(char *name, struct brcms_c=
_info *wlc,
>                       rxextheadroom, nrxpost, rxoffset, txregbase, rxregb=
ase);
>
>         /* make a private copy of our callers name */
> -       strncpy(di->name, name, MAXNAMEL);
> -       di->name[MAXNAMEL - 1] =3D '\0';
> +       strscpy(di->name, name, sizeof(di->name));
>
>         di->dmadev =3D core->dma_dev;
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
> index b3663c5ef382..34460b5815d0 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
> @@ -5551,8 +5551,8 @@ int brcms_c_module_register(struct brcms_pub *pub,
>         /* find an empty entry and just add, no duplication check! */
>         for (i =3D 0; i < BRCMS_MAXMODULES; i++) {
>                 if (wlc->modulecb[i].name[0] =3D=3D '\0') {
> -                       strncpy(wlc->modulecb[i].name, name,
> -                               sizeof(wlc->modulecb[i].name) - 1);
> +                       strscpy(wlc->modulecb[i].name, name,
> +                               sizeof(wlc->modulecb[i].name));
>                         wlc->modulecb[i].hdl =3D hdl;
>                         wlc->modulecb[i].down_fn =3D d_fn;
>                         return 0;
>
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmf=
mac-cfg80211-c-a20108421685
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>

--000000000000c558a80607ec4d56
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
BZrfei1PlO2m9d3AfpeD7Y1pVL1SrZC1yvhXeDO463M8rGKz/l8XZrJY1P6qU8U6QwxjFgXr5o5B
9N6Yw9IhwXhZI3m6F1pe3mMdZ9cFC3xS3Ke+awIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdmcmFua3kubGluQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU0v383z+6bcUXkukYi4fq7VBiM6swDQYJ
KoZIhvcNAQELBQADggEBABUIiuJPuLq9vbb6/7d0VJ6LS6osA6kNs0Tph9iEX49TxPQJtvA97oy4
AgPCjWNiAMLkmu+kNQKlNZG3Vl3S4A+VMOogB6aKtiLlz73Cs0sPgpohw6GSS41TKVt17PrAzo0o
/xuXczzIbtvrpoi6OnGlsW4aVCqQSOqKUamG8wU8u3/h+iPM1rr4z6ZHdyrllNi+ukH/Z6Dpn6wF
ATUa+n5ReFZpli4TzcqVHw7i+OaB23TMHCwed4OPFm0H3zcCJgVtgt3z95IPak7bBuYLAGMT2c3K
Xkdn27MnpydqZw5mnP970DgyUMHXY3Jvj65UAVioJUr4LkNBL7Tsk/6q0FExggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxcbvtv+NUbtJoPDWwwDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINJL+qDh7+dEqg2/lLNzR8TtrHttWu1qkNFYFBg+
37fgMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAxNzE2NDkx
OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQBLJs7X775QOHM6mnJdESuqp9+qoQDWDggsTv1+AD8c5bgMqNdtI/LNvI+9
WBWF0UNbjXtk03iSsGXLE45RYGgxwP2oBoRCj6UQNXsYSxd1zCGRNLwryJgqyMTAZNHw8GMw0tAL
a3sPOWGwJVyUg5IfSXgDTtR+TsOoNQtUtHgVNXGthWciuDLI/dYiNbpHLKOhkP6tOQi+eFnBYVOK
3UV5REjO7uOjxaTzRKRnjIecRv77v2+8nk0FCIgRVXFe8TQR0ZeUQiHIWCjcCXpaTUI1K17NyN4S
YgnXKrm90fTAe0BP72/HybhiW1Vnaf5jgTGDY5bFgPHE58nsqT0blqsm
--000000000000c558a80607ec4d56--
