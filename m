Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E8477D803
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 03:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241073AbjHPB6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 21:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240840AbjHPB6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:58:10 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915F41FE7;
        Tue, 15 Aug 2023 18:58:09 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-790dcf48546so28201239f.0;
        Tue, 15 Aug 2023 18:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692151089; x=1692755889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad7ks/gqRcM772r54juY5Ni4nGO1bdTguKO7vk1J9xQ=;
        b=ePUqiVoYSm9qW8zbzcuL2LIsDEY4l4ubZapPD19gWa3olDnn24vc54r8a9+QtJcfs0
         4vN9Fxi2EpvyK7n7ttDycG3g8Tp0RVmt8/MYtYO5l9O2doPbgrEisjkl9Wvkf85tXRBW
         Z5RKtCNW4VxIJBTqMnecVKnSUE2Ppti1HKHVTtjRV8ltIPi1s7XKU26Mp5AwYo2C5kin
         TThm/wkbmgDZmRArKDCNmvLwr3b/qCdKqor0PRYtzdO3/7teWg36B1HDIcyucDTGNP/D
         xCyBZWvGgWnXGMQ2Xm9vyJcwTxshSjG8iTmMocjpUn6pLcDY2wbWDO3pLYHOMWcrjHzQ
         aCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692151089; x=1692755889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ad7ks/gqRcM772r54juY5Ni4nGO1bdTguKO7vk1J9xQ=;
        b=SREf7rww1iBbgKElLPkAx4Hm4PiWIZFBV3Zwyay4Y5ppjb4qGJ2rVdnYEbnCP8MYZI
         uOpGIj6BigHcws5YSMuETkmxIvV31p325Md0PUvOSlJaPl4vm+IK46JMGVQ8UJODRV/h
         v1XZi+wiVl8B3dpL9fVZWzIvxvdWtgh74kF2SjulP5Wm7jOMUO4PIwYSStDJqXeqzdCC
         Y0XPtfc5Pawh8W+lU1w9NV76YBdbYNkJV9h5e2pE/F4Ujbm/vPc9szk20Vo71fEtsQMT
         SKtrUYtVLvRDZJqfJZjG6U0ZL9P8ejFWBG4hLrqMfis6zIt4BWHSjVIcUhf6XVinJ5kI
         tgqw==
X-Gm-Message-State: AOJu0YyziO5t/siRrftNfDBIsn78BlOEY3ayvid8HO09gsEM1EiucEel
        Wtv1vu4hgV5jprMZ7A0WtWwysAOdeGXSN1HGzLA=
X-Google-Smtp-Source: AGHT+IF/SWi3XRFfRrTthn4s7TkYWds670zji0ekasPbscRDR6kW6nMQXkM6w9WK74rdsWGf1GxzQHASJUGP7BjLkLQ=
X-Received: by 2002:a92:d090:0:b0:349:5d26:506a with SMTP id
 h16-20020a92d090000000b003495d26506amr947471ilh.0.1692151088870; Tue, 15 Aug
 2023 18:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230815231117.15169-1-aford173@gmail.com>
In-Reply-To: <20230815231117.15169-1-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 15 Aug 2023 22:57:57 -0300
Message-ID: <CAOMZO5Cw5bFD3U6KXkuobUCmZbjYsL_=gZobeKFXGQo55aA+Vg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] arm64: dts: imx8mp: Fix SDMA2/3 clocks
To:     Adam Ford <aford173@gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Tue, Aug 15, 2023 at 8:11=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> A previous patch to remove the Audio clocks from the main clock node

Nit: Instead of referring to "A previous patch", it would be clearer
to explicitly
refer to the actual commit.

> was intended to force people to setup the audio PLL clocks per board
> instead of having a common set of rates since not all boards may use
> the various audio PLL clocks for audio devices.
>
> Unfortunately, with this parenting removed, the SDMA2 and SDMA3
> clocks were slowed to 24MHz because the SDMA2/3 clocks are controlled
> via the audio_blk_ctrl which is clocked from IMX8MP_CLK_AUDIO_ROOT,
> and that clock is enabled by pgc_audio.
>
> Per the TRM, "The SDMA2/3 target frequency is 400MHz IPG and 400MHz
> AHB, always 1:1 mode, to make sure there is enough throughput for all
> the audio use cases."
>
> Instead of cluttering the clock node, place the clock rate and parent
> information into the pgc_audio node.
>
> With the parenting and clock rates restored for  IMX8MP_CLK_AUDIO_AHB,
> and IMX8MP_CLK_AUDIO_AXI_SRC, it appears the SDMA2 and SDMA3 run at
> 400MHz again.
>
> Fixes: 16c984524862 ("arm64: dts: imx8mp: don't initialize audio clocks f=
rom CCM node")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
