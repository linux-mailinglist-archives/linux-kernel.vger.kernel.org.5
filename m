Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34D977D926
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241643AbjHPDho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241624AbjHPDek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:34:40 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D44B19A1;
        Tue, 15 Aug 2023 20:34:02 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-56ce156bd37so4326271eaf.3;
        Tue, 15 Aug 2023 20:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692156841; x=1692761641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAMo8UO/F4IX8+HmDn6jnGZsN563n8kTyHS8EOKnG1A=;
        b=RfCLXjPus0PH70XAvr9Gs/pAzt2y084kyuO+o7LeZMtcs934AHxXVx2jk4NX75cGg6
         GMFxvWGtcSZz3v2/SNvgvkS8F799no/2htXJriQ1LcPGw1O+OQXyX4adQBB/hNbEoZUF
         6MFWWoLWYUriFXU2kusTY61OnuYO/a6zjcZ3fuJuv1h1j5erdXIzw7cpth/7d+ujiBGX
         XrINDCY4GIbQoyuU9QTCLHxhnxWIpNrLoX0BsyenXnKsL427LsaLUN+Z/b5alUG9KJmp
         wu4KaOOV0Ch1pvED8R1AV3tfbZREyl+LD5u0ck/G8M5lg/+36Tr2g+TPWiqItY7UX885
         E3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692156841; x=1692761641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAMo8UO/F4IX8+HmDn6jnGZsN563n8kTyHS8EOKnG1A=;
        b=iUg3+u0i/HYZ4IKjSz7D7Psi3T96HLtZXA9sxbMRL8uKnFImxEU+1dZSsy137lWSqi
         gCpQx1UycbDCs5BlwhSyS3xT89ymwpPbkFZfCrQWU70CB5JkPgBEz4TnqPrfK7UrU9yt
         2QjtbOaR/JJA9YST8qsfVdAOEFju1ID4OigU4ST+1nC4kQa8o5P2CnWUMKC8pVdprri9
         FA0Yhnr/+zG8jaJuOsnkFpmsKQGXaL/T/am7Sj17tUOafFMPpZC3OVNX/n5T/ZHIBKjm
         iilnkjj6B15OJPdBsjCCLvJRbiRf5T9+WaSr9uIavnFmBNz6l1uyHB6iNG/Rh1YNDKRM
         /vgA==
X-Gm-Message-State: AOJu0YyEQC4eXABwZHN89nNAIKw6qmgdPR/5Xc/qN5tEI+gmd86fPCqO
        BSqXQFY90SSWk1SEootVniwHfTpsji7hxw3Jd1eLOiJV
X-Google-Smtp-Source: AGHT+IHhxZPeQHC1dWpHiqj3NvvjdIt/de90SAtG05XdcyZg33sttdtBK8ATtBN31Or5YX6K7TPDT3B2oviZILb8OJ0=
X-Received: by 2002:a05:6870:b52c:b0:1aa:f3:5b3b with SMTP id
 v44-20020a056870b52c00b001aa00f35b3bmr821137oap.17.1692156841106; Tue, 15 Aug
 2023 20:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230815231117.15169-1-aford173@gmail.com> <CAOMZO5Cw5bFD3U6KXkuobUCmZbjYsL_=gZobeKFXGQo55aA+Vg@mail.gmail.com>
In-Reply-To: <CAOMZO5Cw5bFD3U6KXkuobUCmZbjYsL_=gZobeKFXGQo55aA+Vg@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 15 Aug 2023 22:33:49 -0500
Message-ID: <CAHCN7xL2BA0+Z5GhrvuS0j+s6WOLVScaC9DQ1+AxHYjY6DwAAA@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] arm64: dts: imx8mp: Fix SDMA2/3 clocks
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 8:58=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Adam,
>
> On Tue, Aug 15, 2023 at 8:11=E2=80=AFPM Adam Ford <aford173@gmail.com> wr=
ote:
> >
> > A previous patch to remove the Audio clocks from the main clock node
>
> Nit: Instead of referring to "A previous patch", it would be clearer
> to explicitly
> refer to the actual commit.

I tried to do that with the fixes tag below.  Do you want me to
re-submit the patches with this changed?  I was hoping to avoid
referencing the same patch and hash twice in the same commit message.

adam
>
> > was intended to force people to setup the audio PLL clocks per board
> > instead of having a common set of rates since not all boards may use
> > the various audio PLL clocks for audio devices.
> >
> > Unfortunately, with this parenting removed, the SDMA2 and SDMA3
> > clocks were slowed to 24MHz because the SDMA2/3 clocks are controlled
> > via the audio_blk_ctrl which is clocked from IMX8MP_CLK_AUDIO_ROOT,
> > and that clock is enabled by pgc_audio.
> >
> > Per the TRM, "The SDMA2/3 target frequency is 400MHz IPG and 400MHz
> > AHB, always 1:1 mode, to make sure there is enough throughput for all
> > the audio use cases."
> >
> > Instead of cluttering the clock node, place the clock rate and parent
> > information into the pgc_audio node.
> >
> > With the parenting and clock rates restored for  IMX8MP_CLK_AUDIO_AHB,
> > and IMX8MP_CLK_AUDIO_AXI_SRC, it appears the SDMA2 and SDMA3 run at
> > 400MHz again.
> >
> > Fixes: 16c984524862 ("arm64: dts: imx8mp: don't initialize audio clocks=
 from CCM node")
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
