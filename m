Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582627B7A06
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241681AbjJDI2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjJDI2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:28:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E83883;
        Wed,  4 Oct 2023 01:28:15 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31f71b25a99so1807353f8f.2;
        Wed, 04 Oct 2023 01:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696408094; x=1697012894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2yRwJ/7iREzqBe4BdcV/tJQGnF/hrf8riPhHgSOhEw=;
        b=WD9ZQZI7WBN5r8Y6gItR+IEq/sBg/xMiuoYLfPimuyp0RWIwfERDcCmnMAYbkFPNog
         Xm2Gh4uoM0uyueXbI3ziQK7V7yWWfYXsBug4fkEHQfSJDL+KS1SbS6fPufB6bEN9j3pl
         TuZfR/HCk0EjKZTCV1EOKrNIAWj7Y3VzlBhCR2wS6khZuxkzAxfd+opWmI9npU5qt4Xx
         8jtgootzP2vfKeTfDnzrp/QWz7d6VfWjajDbkAOTbKD6ZqRLIRmRJSXYlr7hSimFx7PW
         lA0sNnfohDCHw5KRJF8mp6oflZ5Gecz5J9eAk3+VXCQaviKDaxAfDQ1L8ulmWKjBorw5
         7ejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696408094; x=1697012894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2yRwJ/7iREzqBe4BdcV/tJQGnF/hrf8riPhHgSOhEw=;
        b=ROIdAjDjbsQyLLnGd8FqAqUwOPN9u3rFgFW3a1sfYVYSX67C+DnY+vbBIftq86Tw9S
         hCTFCLAR/sE0mnARGqgBPxVc7F/Q2pYCnKeJWevpxP4vospWc4kQPYNZ1K3kSlHuZkJS
         iFqJrWZ5Hj8zv2JTDIZwYd/aArrEXaKv5fMnZWHDPyN4l6xISj0nlIGn5zMIt6XtECiz
         +9sjbgGZ3apQPGjZhYwOkaecNbPPFLLR8/OqCBwMkcop2cNavxKCLlD511fza7gNrt6d
         t5a/1uJrIK9vQQ5CxepodlN1O5SDn1SpIqVFLaAt5NxetgsqKbdGE3/cyjj4TatiMoOV
         XIKw==
X-Gm-Message-State: AOJu0YyhFWaSRvKDU9JAqLLEJMqQYmqMqHIoNs6d5nsnljLg/IHBcrwF
        7GbUB/49Dbxbf1ia24E5qkE=
X-Google-Smtp-Source: AGHT+IFxQd2U1GXGAXigVpqGDqbCkb54Gqt1CaOxUHcHY0qZp3vpcOLh5uMbRNt0Tm7+Xvt6dWYbcg==
X-Received: by 2002:a5d:61ce:0:b0:31a:d8c0:cb8b with SMTP id q14-20020a5d61ce000000b0031ad8c0cb8bmr1522942wrv.25.1696408093617;
        Wed, 04 Oct 2023 01:28:13 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id r2-20020a5d4982000000b00323330edbc7sm3432701wrq.20.2023.10.04.01.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 01:28:13 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     alexander.stein@ew.tq-group.com
Cc:     abelvesa@kernel.org, aford173@gmail.com, bbara93@gmail.com,
        benjamin.bara@skidata.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, frank@oltmanns.dev,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        mripard@kernel.org, mturquette@baylibre.com, peng.fan@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        shawnguo@kernel.org
Subject: Re: [PATCH 00/13] imx8mp: first clock propagation attempt (for LVDS)
Date:   Wed,  4 Oct 2023 10:28:06 +0200
Message-Id: <20231004082806.2895789-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <12810050.O9o76ZdvQC@steina-w>
References: <12810050.O9o76ZdvQC@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam, Alexander!

On Wed, 4 Oct 2023 at 10:04, Alexander Stein <alexander.stein@ew.tq-group.com> wrote:
> Am Dienstag, 3. Oktober 2023, 15:28:05 CEST schrieb Adam Ford:
> > On Sun, Sep 17, 2023 at 5:40 PM Benjamin Bara <bbara93@gmail.com> wrote:
> > > Hi!
> > >
> > > Target of this series is to dynamically set the rate of video_pll1 to
> > > the required LVDS clock rate(s), which are configured by the panel, and
> > > the lvds-bridge respectively.
> > >
> > > Some background:
> > > The LVDS panel requires two clocks: the crtc clock and the lvds clock.
> > > The lvds rate is always 7x the crtc rate. On the imx8mp, these are
> > > assigned to media_disp2_pix and media_ldb, which are both
> >
> > Could the LDB driver be updated to take in the crtc clock as a
> > parameter, then set the media_ldb to 7x crct clock.  I wonder if that
> > might simplify the task a bit.
>
> I'm not sure if you had something different in mind, but I guess this happens
> already in fsl_ldb_atomic_enable(), although using the mode clock.
> As this might not always be possible, commit bd43a9844bc6f ("drm: bridge: ldb:
> Warn if LDB clock does not match requested link frequency") was added to
> indicate something might be wrong.
> The main problem here is that both media_ldb and crct clock are not in a
> parent<->child relationship, but are siblings, configurable individually.

Yes, this already happens. First, the mode is set (which sets the CRTC
rate). Next, LDB sets the LVDS rate. Both do not have "access" to the
PLL, because the clocks haven't configured CLK_SET_RATE_PARENT. What
might be a working (but IMHO dirty) hack, is to give the LDB the PLL
clock as input too. Then it could set the PLL, LDB, CRTC rate (CRTC rate
must be set again after PLL is set!).

> > I still have concerns that the CLK_SET_RATE_PARENT may break the
> > media_disp1_pix if media_disp2_pix is changing it.
> > I think we should consider adding some sort of configurable flag to
> > the CCM that lets people choose  if CLK_SET_RATE_PARENT should be set
> > or not in the device tree instead of hard-coding it either on or off.
> > This would give people the flexibility of stating whether
> > media_disp1_pix, media_disp2_pix, both or neither could set
> > CLK_SET_RATE_PARENT.

Probably we could do that (for now) by adding a second (optional) clock
to LDB. If it is set, the LDB driver should also set the LVDS rate on
this clock. This would then be set to the parent PLL.

> > I believe the imx8mp-evk can support both LVDS-> HDMI and DSI->HDMI
> > bridges, and I fear that if they are trying to both set different
> > clock rates, this may break something and the clocks need to be
> > selected in advance to give people a bunch of HDMI options as well as
> > being able to divide down to support the LVDS.
> >
> > I think some of the displays could be tied to one of the Audio PLL's,
> > so I might experiment with splitting the media_disp1_pix and
> > media_disp2_pix from each other to see how well .

Yes, you probably could also tie them to one of the other available
PLLs. We "could" also do that automatically, by not setting
CLK_SET_RATE_REPARENT and adapting the clk-divider driver to look for a
better suitable parent. However, I guess the outcome is currently quite
unpredictable, so this would require a lot of additional work. Just to
mention it here too: I created a small spin-off of this series[1] with
the changes of this series which affect the core.

Probably using the optional clock for LDB is a suitable short-term
solution?

Regards
Benjamin
