Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC157D7F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344572AbjJZI5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjJZI5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:57:37 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFA31AB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:57:34 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d81d09d883dso457641276.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698310654; x=1698915454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d15OUBlXoCJoUgZsOraHwb/V6/eE2WDwET5ZkyPx89I=;
        b=VGdVAsYlb1hiv6kYyLytVrbDKNuOdBKi4pUjHe7VTA0caJu5yvrVqPQRJ4t1D1W3eM
         KrRqxJbEzYlDOjvyawUifn1SAELQ0MzA1CNT+qdG7F41T8pZVVHyzMF4EK0XNDog02Kr
         yHB54LgJiZAn+ymc813OAcm6xilxRpqujqgyvNY9llbMF81w10IFXKTJRjE9yAWpaIQp
         XiAymVmXqElSI3X0gDuKN48mBnzthQxStmQ2YMj2TjTUKeV3NnqwTILbYfZzqCdtp4GB
         ZEEU7F4ZK3yoFqKZPb4f9IUKM/OBhoKizEliZRLh0UwVOXP48ehxQWuWMdY5PNFq7M18
         JyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698310654; x=1698915454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d15OUBlXoCJoUgZsOraHwb/V6/eE2WDwET5ZkyPx89I=;
        b=wHkk0sdotN2OePsC3x98RtKfvO1S3y5G1MIlBtcKKp4tsY58+33tIzbHbR7LcwBApY
         7kTNQdDf8GD6PaMvY0HFrt9jgMDxPtRiwTfiSIbDEQ/viqpFTzDGdF9+AvZ6R8KHPr9v
         kNyFB2tlCtIRUURktPFjOKYXzH5rcZRMbMnIyMObdnQKKrvqkUFSY7ah4WASb6kcWphB
         uNNZ1ukWf1w3DZAP/gWmcWU2/8BCa9bVoB4t91x5i0ZQIl7oPB/VbqUGKsBKaKoQ6Mdp
         NwjmFJsoIUq6ieqCZM29DCGoBB9B+Se+x2Gg82klz7iopK3+2Nv2RahJGS3XFsES6iIO
         E0mg==
X-Gm-Message-State: AOJu0YzNQSmXLSL1gK1dikGMrtDZposwIN0n216tGiExIIbLoOnDRa+4
        p69k1X5IUBUy9+Jav8OXzblSrg/QTvdCmnInkzr26g==
X-Google-Smtp-Source: AGHT+IFhzh3jp3HfNlJ8La8+jINi5sy551LrNDFQM80H3MVmgkxMCbioFraPFHdJrZNwGJJzriw+6D047YqUbWdNHEc=
X-Received: by 2002:a25:fb01:0:b0:da0:9735:b012 with SMTP id
 j1-20020a25fb01000000b00da09735b012mr2234616ybe.11.1698310654073; Thu, 26 Oct
 2023 01:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231025103957.3776-1-keith.zhao@starfivetech.com>
 <20231025103957.3776-7-keith.zhao@starfivetech.com> <70805ff2-56a8-45e1-a31c-ffb0e84749e5@linaro.org>
 <3twc4zoohon7uujypgjtlnryfmebx4osvpykagnwr5nemmqz2w@w4vw55uswebh>
In-Reply-To: <3twc4zoohon7uujypgjtlnryfmebx4osvpykagnwr5nemmqz2w@w4vw55uswebh>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 26 Oct 2023 11:57:22 +0300
Message-ID: <CAA8EJppxQ7J8DEDFsWzPL8bDpNW-KY0nhUA++zDBRpMCpP-bkA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] drm/vs: Add hdmi driver
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Keith Zhao <keith.zhao@starfivetech.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jagan Teki <jagan@edgeble.ai>,
        Rob Herring <robh+dt@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Shawn Guo <shawnguo@kernel.org>, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 at 11:07, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Thu, Oct 26, 2023 at 01:23:53AM +0300, Dmitry Baryshkov wrote:
> > > +static int starfive_hdmi_register(struct drm_device *drm, struct starfive_hdmi *hdmi)
> > > +{
> > > +   struct drm_encoder *encoder = &hdmi->encoder;
> > > +   struct device *dev = hdmi->dev;
> > > +
> > > +   encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
> > > +
> > > +   /*
> > > +    * If we failed to find the CRTC(s) which this encoder is
> > > +    * supposed to be connected to, it's because the CRTC has
> > > +    * not been registered yet.  Defer probing, and hope that
> > > +    * the required CRTC is added later.
> > > +    */
> > > +   if (encoder->possible_crtcs == 0)
> > > +           return -EPROBE_DEFER;
> > > +
> > > +   drm_encoder_helper_add(encoder, &starfive_hdmi_encoder_helper_funcs);
> > > +
> > > +   hdmi->connector.polled = DRM_CONNECTOR_POLL_HPD;
> > > +
> > > +   drm_connector_helper_add(&hdmi->connector,
> > > +                            &starfive_hdmi_connector_helper_funcs);
> > > +   drmm_connector_init(drm, &hdmi->connector,
> > > +                       &starfive_hdmi_connector_funcs,
> > > +                       DRM_MODE_CONNECTOR_HDMIA,
> >
> > On an embedded device one can not be so sure. There can be MHL or HDMI
> > Alternative Mode. Usually we use drm_bridge here and drm_bridge_connector.
>
> On an HDMI driver, it's far from being a requirement, especially given
> the limitations bridges have.

It's a blessing that things like MHL / HDMI-in-USB-C / HDMI-to-MyDP
are not widely used in the wild and are mostly non-existing except
several phones that preate wide DP usage.
Using drm_connector directly prevents one from handling possible
modifications on the board level. For example, with the DRM connector
in place, handling a separate HPD GPIO will result in code duplication
from the hdmi-connector driver. Handling any other variations in the
board design (which are pretty common in the embedded world) will also
require changing the driver itself. drm_bridge / drm_bridge_connector
save us from those issues.

BTW: what are the limitations of the drm_bridge wrt. HDMI output? I'm
asking because we heavily depend on the bridge infrastructure for HDMI
output. Maybe we are missing something there, which went unnoticed to
me and my colleagues.

-- 
With best wishes
Dmitry
