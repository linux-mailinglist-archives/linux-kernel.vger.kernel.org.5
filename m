Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F2976C15D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 02:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjHBAJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 20:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHBAJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 20:09:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1AF1BFD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 17:09:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c10ba30afso74078966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 17:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690934962; x=1691539762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZsbdEz2CFbytM/SBZM7e6Zd7crzV8+VL6FzrphMbQA=;
        b=Y/Ij+ZT0IpASeQ0mgk9R4EtwL+ZaSFpxaPbooNDa/+P/HbnBzqxiLR0bvd6Wp9k7hM
         dO8mmZgbl9r+hoNWEaoIe2NwlboW8eXj6IiorVQyhdCr1wJ9NynsyXr/mo7wVknn+OfN
         EJXwELSpJ0726AGHlutgy/bSPpHno1UXiUCiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690934962; x=1691539762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ZsbdEz2CFbytM/SBZM7e6Zd7crzV8+VL6FzrphMbQA=;
        b=Ko0nMZTbq/tfwmC/eDSqf67ASTUDaeenrio9Sx+KyL6Zh/HxfiD08D3BKtYKJdylzF
         1Q4TqibXdpr+PQwvZrDoIrj4mWSySMDb50VCd/maCmZtxOboBQtwjU/WEIJkKjI0sjmE
         vpLV3kb6ANNe1n8pyYtwURXHk/MJwfa5B3QU5a1v5FtLn81enr+u8EyKP4hEnOvCDzqm
         PBl32KgWjkzQQFjDMpnblyLuhEKog+J/X2o2W3xmSEhxNjyx8iWtRCugICTPp55YssuT
         Ii8SslsgA80pgLSC2t0Bdvtr32/iZzGChftLKhVwPseKOYNRQ3U4L7/SXLQJAkQ8RKfb
         8WOw==
X-Gm-Message-State: ABy/qLb5en4GocaKRc9SS6W7e7RBOb3sN1lzcJvGqj06dQNBM53+43hb
        iEyDQUbRd4GjmjmcFR6MMDLMPP7DoZDNRbtSavG4Yg==
X-Google-Smtp-Source: APBJJlHoNL6vK4eTUL0+i9xVrv7+rE0O1PORY92RgRpH/DEBVbz3occcfsy3G2hoWqK+d1pGx2YX7rH9m38neK+L1o8=
X-Received: by 2002:a17:907:7711:b0:997:e7d0:e26d with SMTP id
 kw17-20020a170907771100b00997e7d0e26dmr5285711ejc.4.1690934962387; Tue, 01
 Aug 2023 17:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690904067.git.petr.tesarik.ext@huawei.com>
 <b94c048c8decefeca41ceac5f826da67a8d727a8.1690904067.git.petr.tesarik.ext@huawei.com>
 <327159d6-f520-bea1-c6b0-facda7c26699@huaweicloud.com>
In-Reply-To: <327159d6-f520-bea1-c6b0-facda7c26699@huaweicloud.com>
From:   Franky Lin <franky.lin@broadcom.com>
Date:   Tue, 1 Aug 2023 17:08:55 -0700
Message-ID: <CA+8PC_evb-6Y3dKnAN4BN=ODEVxY5-cDb6Lc72u0j1WBtx7p1A@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] wifi: brcm80211: drop struct brcmf_p2p_scan_le
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
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
        Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ca1bbd0601e5798f"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000ca1bbd0601e5798f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 1, 2023 at 10:57=E2=80=AFAM Petr Tesarik
<petrtesarik@huaweicloud.com> wrote:
>
> On 8/1/2023 5:36 PM, Petr Tesarik wrote:
> > From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> >
> > The 'S' scan method is not implemented. The type member is always writt=
en
> > as 'E' and never read. Consequently, struct brcmf_p2p_scan_le can be
> > replaced with struct brcmf_escan_params_le.
>
> Seeing that Hans has already fixed the actual issue with the flex array,
> this whole series is not needed.
>
> But maybe this simplification has some value on its own?

I don't think this change would work.

> Petr T
>
> > Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
> > ---
> >  .../broadcom/brcm80211/brcmfmac/p2p.c         | 38 ++++---------------
> >  1 file changed, 8 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/d=
rivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> > index d4492d02e4ea..915f95760470 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> > @@ -123,23 +123,6 @@ enum brcmf_p2p_disc_state {
> >       WL_P2P_DISC_ST_SEARCH
> >  };
> >
> > -/**
> > - * struct brcmf_p2p_scan_le - P2P specific scan request.
> > - *
> > - * @type: type of scan method requested (values: 'E' or 'S').
> > - * @reserved: reserved (ignored).
> > - * @eparams: parameters used for type 'E'.
> > - * @sparams: parameters used for type 'S'.
> > - */
> > -struct brcmf_p2p_scan_le {
> > -     u8 type;
> > -     u8 reserved[3];
> > -     union {
> > -             struct brcmf_escan_params_le eparams;
> > -             struct brcmf_scan_params_le sparams;
> > -     };
> > -};
> > -
> >  /**
> >   * struct brcmf_p2p_pub_act_frame - WiFi P2P Public Action Frame
> >   *
> > @@ -646,14 +629,14 @@ static s32 brcmf_p2p_escan(struct brcmf_p2p_info =
*p2p, u32 num_chans,
> >  {
> >       struct brcmf_pub *drvr =3D p2p->cfg->pub;
> >       s32 ret =3D 0;
> > -     s32 memsize =3D offsetof(struct brcmf_p2p_scan_le,
> > -                            eparams.params_le.channel_list);
> > +     s32 memsize =3D offsetof(struct brcmf_escan_params_le,
> > +                            params_le.channel_list);
> >       s32 nprobes;
> >       s32 active;
> >       u32 i;
> >       u8 *memblk;
> >       struct brcmf_cfg80211_vif *vif;
> > -     struct brcmf_p2p_scan_le *p2p_params;
> > +     struct brcmf_escan_params_le *eparams;
> >       struct brcmf_scan_params_le *sparams;
> >
> >       memsize +=3D num_chans * sizeof(__le16);
> > @@ -667,8 +650,8 @@ static s32 brcmf_p2p_escan(struct brcmf_p2p_info *p=
2p, u32 num_chans,
> >               ret =3D -EINVAL;
> >               goto exit;
> >       }
> > -     p2p_params =3D (struct brcmf_p2p_scan_le *)memblk;
> > -     sparams =3D &p2p_params->eparams.params_le;
> > +     eparams =3D (struct brcmf_escan_params_le *)memblk;
> > +     sparams =3D &eparams->params_le;
> >
> >       switch (search_state) {
> >       case WL_P2P_DISC_ST_SEARCH:
> > @@ -698,11 +681,6 @@ static s32 brcmf_p2p_escan(struct brcmf_p2p_info *=
p2p, u32 num_chans,
> >
> >       brcmf_p2p_set_discover_state(vif->ifp, search_state, 0, 0);
> >
> > -     /*
> > -      * set p2p scan parameters.
> > -      */
> > -     p2p_params->type =3D 'E';
> > -
> >       /* determine the scan engine parameters */
> >       sparams->bss_type =3D DOT11_BSSTYPE_ANY;
> >       sparams->scan_type =3D BRCMF_SCANTYPE_ACTIVE;
> > @@ -747,9 +725,9 @@ static s32 brcmf_p2p_escan(struct brcmf_p2p_info *p=
2p, u32 num_chans,
> >               sparams->channel_list[i] =3D cpu_to_le16(chanspecs[i]);
> >
> >       /* set the escan specific parameters */
> > -     p2p_params->eparams.version =3D cpu_to_le32(BRCMF_ESCAN_REQ_VERSI=
ON);
> > -     p2p_params->eparams.action =3D  cpu_to_le16(WL_ESCAN_ACTION_START=
);
> > -     p2p_params->eparams.sync_id =3D cpu_to_le16(0x1234);
> > +     eparams->version =3D cpu_to_le32(BRCMF_ESCAN_REQ_VERSION);
> > +     eparams->action =3D  cpu_to_le16(WL_ESCAN_ACTION_START);
> > +     eparams->sync_id =3D cpu_to_le16(0x1234);
> >       /* perform p2p scan on primary device */
> >       ret =3D brcmf_fil_bsscfg_data_set(vif->ifp, "p2p_scan", memblk, m=
emsize);

Firmware is expecting struct brcmf_p2p_scan_le as the parameter for
"p2p_scan" iovar.

Regards,
- Franky

--000000000000ca1bbd0601e5798f
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
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBRf1HppcsIWEG3YgHPacs4LAjk40zPPAZM8vyyM
zcKkMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgwMjAwMDky
MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQCFoj61E3R2uX5jQoG74WpK/M6LdPuB3oSFbvlI8rfKrnueLAtPxUXI11pG
FzZJkhGfJtTsHdK/pCl7wjEe+bW9bnh8Na5tYlrXgS5xUgpitqKdcLDP3fwhKNHlc2cKEQ2e78Fs
ODcKx1qPQyJlKGjVz/ZgdTQiFzZIdb0fxjwKxiy6amY+1FdZJx5exi2+QFiVpM9rTrIcqkijVMI9
6RJNl3ULnpPWCxnYRw8xyz17hv0QG/8Ga2TSIac1yi1HxT48z28Okl9m7k6QIeG6xWS4jG/W6fhu
cZt3PbpGmgMMra//oegQLKKb90eefnoudRyB+DlUq91wm0PANzAP4Zpd
--000000000000ca1bbd0601e5798f--
