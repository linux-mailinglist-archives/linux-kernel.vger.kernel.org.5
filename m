Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B06876BBF6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjHASIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjHASIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:08:44 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2991210D;
        Tue,  1 Aug 2023 11:08:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe383c1a26so3856873e87.1;
        Tue, 01 Aug 2023 11:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690913312; x=1691518112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nas0AweN10zWYTWttDcfjEFMCRYBHpH9zSmnxdV53u0=;
        b=f5NTAN1JLSRZ2+aFg/6zFOPPNjQZyPu2SqnWLCTVtpjfsXLr6yOShAPHoIbOUwiZIa
         3whwUY4GvL6vi/SU2Tvbt/ycr9U4mFxrBOuhq8En5m9PN545txooicsV+BWDlx3LBCx4
         HOCQ5Kww+p/Ri/JIzNcXaELYTBKlhdXcOs9NRl6VfbpKkHzp+ghj3XC3HfGi0OaA2NIz
         8OdrUStok5XoKzEjRlZd4heDBH2mx8se8Ce6cbdImCLe7BSnEbsb0M/HpZIjxn1PySii
         gDceRuH/j+Y18V/Yk2p0fFBPEgLPTdaTVEGriX6z1tRx4Z+7dYv/TKwFPrbzj7sCOYdk
         MMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690913312; x=1691518112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nas0AweN10zWYTWttDcfjEFMCRYBHpH9zSmnxdV53u0=;
        b=WCV7UgwDfYOq5FbfqmWygwk9IQXNifg7pvXlOf5TFj7DaBcU0h5JqcjCluW9Oo0lcT
         hhZ/TmtdTpL2ED/jmybeGDreDhuTNS42u0GpqNveEbriCNe/PgGNivfudLrV4wA6qAaY
         8PmREPsCFZjurmCbBnhH0Cv2SXpgP+/UpebtT5TTQfoa/hnhFRskFN2iO0gTxNJGwjoX
         a+OqB4cDsS3kq9cmCwsLKnKcx29VeSH3yWwSZ0WMUsxdo3/bS8JtmGjLghs1I2uJfjyL
         ZcKD7x/A8XVynOrusiarK1u3kJSPjHMyBYJyHJbZZvNO6UlzA7OxqvP90q50OjHTS/FE
         gqJg==
X-Gm-Message-State: ABy/qLaIJ8NIPQeXguuxiRI+IsBb1NX9zzcYsSAimVH2SHS3h2oXIi++
        KHcdGfIyoE9sBNMbzU/cpuqgdgpcAXXHqn8I/sQ=
X-Google-Smtp-Source: APBJJlFDpbpxqL7TpaRFaW/ohZ1CcICVBTt/+pzdYA9WXXSDhC3jueiBVoUI1ne6Il4vBBlKs3gqapwEocCPxrhSNIA=
X-Received: by 2002:a2e:95cc:0:b0:2b9:cf90:ab9c with SMTP id
 y12-20020a2e95cc000000b002b9cf90ab9cmr2838657ljh.8.1690913311619; Tue, 01 Aug
 2023 11:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-fp4-bluetooth-v2-0-3de840d5483e@fairphone.com>
 <CABBYNZJPw=Oxi+J2oA=6aosEZjCBK=u=8HEJywzRJCCrmGnkGA@mail.gmail.com>
 <CSMMO2ZBOS6Y.3SAQOHDLW68ME@otso> <CUH4IE1600FN.2SYHOEBM2LS1K@otso>
In-Reply-To: <CUH4IE1600FN.2SYHOEBM2LS1K@otso>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 1 Aug 2023 11:08:19 -0700
Message-ID: <CABBYNZJaYRrL+_X-+N5c=DTONg6DD-k_npE2UcLTf6m+H8qccA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add WCN3988 Bluetooth support for Fairphone 4
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Tue, Aug 1, 2023 at 3:07=E2=80=AFAM Luca Weiss <luca.weiss@fairphone.com=
> wrote:
>
> Hi Luiz,
>
> On Mon May 15, 2023 at 8:12 AM CEST, Luca Weiss wrote:
> > On Fri May 12, 2023 at 10:53 PM CEST, Luiz Augusto von Dentz wrote:
> > > Hi Luca,
> > >
> > > On Fri, May 12, 2023 at 6:58=E2=80=AFAM Luca Weiss <luca.weiss@fairph=
one.com> wrote:
> > > >
> > > > Add support in the btqca/hci_qca driver for the WCN3988 and add it =
to
> > > > the sm7225 Fairphone 4 devicetree.
> > > >
> > > > Devicetree patches go via Qualcomm tree, the rest via their respect=
ive
> > > > trees.
> > >
> > > Just to be sure, patches 1-2 shall be applied to bluetooth-next the
> > > remaining are going to be handled elsewhere?
> >
> > Sounds good.
>
> Is anything missing for the patches 1 & 2 to be applied? I don't see
> them yet in linux-next. Should I resend them?

Looks like this set is no longer on patchwork, could you please resend?

> Regards
> Luca
>
> >
> > >
> > > > --
> > > > Previously with the RFC version I've had problems before with Bluet=
ooth
> > > > scanning failing like the following:
> > > >
> > > >   [bluetooth]# scan on
> > > >   Failed to start discovery: org.bluez.Error.InProgress
> > > >
> > > >   [  202.371374] Bluetooth: hci0: Opcode 0x200b failed: -16
> > > >
> > > > This appears to only happen with driver built-in (=3Dy) when the su=
pported
> > > > local commands list doesn't get updated in the Bluetooth core and
> > > > use_ext_scan() returning false. I'll try to submit this separately =
since
> > > > this now works well enough with =3Dm. But in both cases (=3Dy, =3Dm=
) it's
> > > > behaving a bit weirdly before (re-)setting the MAC address with "su=
do
> > > > btmgmt public-addr fo:oo:ba:ar"
> > > >
> > > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > > ---
> > > > Changes in v2:
> > > > - Add pinctrl & 'tlmm 64' irq to uart node
> > > > - Pick up tags
> > > > - Link to v1: https://lore.kernel.org/r/20230421-fp4-bluetooth-v1-0=
-0430e3a7e0a2@fairphone.com
> > > >
> > > > ---
> > > > Luca Weiss (4):
> > > >       dt-bindings: net: qualcomm: Add WCN3988
> > > >       Bluetooth: btqca: Add WCN3988 support
> > > >       arm64: dts: qcom: sm6350: add uart1 node
> > > >       arm64: dts: qcom: sm7225-fairphone-fp4: Add Bluetooth
> > > >
> > > >  .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |   2 +
> > > >  arch/arm64/boot/dts/qcom/sm6350.dtsi               |  63 +++++++++=
++++
> > > >  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  | 103 +++++++++=
++++++++++++
> > > >  drivers/bluetooth/btqca.c                          |  13 ++-
> > > >  drivers/bluetooth/btqca.h                          |  12 ++-
> > > >  drivers/bluetooth/hci_qca.c                        |  12 +++
> > > >  6 files changed, 201 insertions(+), 4 deletions(-)
> > > > ---
> > > > base-commit: f2fe50eb7ca6b7bc6c63745f5c26f7c6022fcd4a
> > > > change-id: 20230421-fp4-bluetooth-b36a0e87b9c8
> > > >
> > > > Best regards,
> > > > --
> > > > Luca Weiss <luca.weiss@fairphone.com>
> > > >
>


--=20
Luiz Augusto von Dentz
