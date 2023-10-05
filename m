Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529A77BA925
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjJESb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjJESb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:31:56 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E829C9F;
        Thu,  5 Oct 2023 11:31:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-27909dabf1cso296524a91.1;
        Thu, 05 Oct 2023 11:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696530713; x=1697135513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2WQ61S9JRRXerRwVjcd6ONvIOqeXxJCrw12591ed3o=;
        b=QzZSAK95Og2ss03Rv2PBHEn/XN9JCK1/6rLiuGNDb+ISAPP8tI+S1Qh19IJUxOIRwi
         itLaCbhPo0uGn8nv6bvxitAQGyGEnufx3RA/N+19GQAU2Stybyif9TQXwePUtshWyXQ3
         tI50POa/V8rxdZ8X+t5ZyStaMPb+FDk625YECuB94eooOAgBga4LtC28ucVCHyaxkRzp
         YnjIGU1sCCXEka7WqHTwl54xxt8UsqGMMkb+ksY9jKFtrrD5RyVJOJdLvCNgi4jbSiOd
         AVmRSJ+mxn23RoQcjlGwug4EMdr2j3502y08ogyy2rCPvxpqxr8pysNiUJ9LWQLZ0oyX
         NMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696530713; x=1697135513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2WQ61S9JRRXerRwVjcd6ONvIOqeXxJCrw12591ed3o=;
        b=pJBkyASGDDSnO8683/B+i1nrI2GyPenruj7JodVutRv9TQMHCEm3G4T2KROb4bziAv
         xumc0d9V7PIWzgJ7AD9jukgltkk1k+8RsLmBv/anLkkLGbPc7Bi/V5l8Duxrql+9HciY
         gzaPaNJ6i99zF4aIACMDYuWXcvnkAy8TMDHsV5cX+7RJ/q45bfULmEx/j/fqPoVoSSQ4
         WfDRT438DxR8XBzFFwXYjEuOdxWuaNwLH5myOk0GH3/kXsHfgwTmy4uFBAtaUMFSXeBH
         fsR+I90x66xeRCeBzAJj6DE8LcQ4Bfq3Q8x9uzxkSJN0/LjFgJg2oaxcYTrSkkQ1ALs4
         uEcw==
X-Gm-Message-State: AOJu0YxXkU2j+iMJF9qvpTj5WFX/QaxK33V9sKmkeeXJ6qiSj6ngronD
        GWH0z5bSMTa7ttKPlA4IygCIaJxf413xzh1ka1A=
X-Google-Smtp-Source: AGHT+IHxE2O9h14dUVLPYcRAdpVlJ/GL9fvrASEtVvxA3peFJ/TbCgJE5wW6732gSn9p/IzRkvbEezsQMg9tUA50OlU=
X-Received: by 2002:a17:90a:4143:b0:268:ca63:e412 with SMTP id
 m3-20020a17090a414300b00268ca63e412mr5453128pjg.4.1696530713317; Thu, 05 Oct
 2023 11:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231004234657.44592-1-aford173@gmail.com> <20231004234657.44592-2-aford173@gmail.com>
In-Reply-To: <20231004234657.44592-2-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 5 Oct 2023 15:31:41 -0300
Message-ID: <CAOMZO5A1fWvoz_Dv8ou9sYucJB5a1pbx0+sAdKkyVCstJ2WRvQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] arm64: dts: imx8mm-beacon: Add DMIC support
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
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

On Wed, Oct 4, 2023 at 8:47=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
>
> The baseboard has a connector for a pulse density microphone.
> This is connected via the micfil interface and uses the DMIC
> audio codec with the simple-audio-card.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
