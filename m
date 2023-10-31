Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFFE7DD6A2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 20:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjJaTSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 15:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjJaTS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 15:18:29 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39005C2;
        Tue, 31 Oct 2023 12:18:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507c1936fd5so156035e87.1;
        Tue, 31 Oct 2023 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698779905; x=1699384705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T3Ilp1TvpF5zU2TkWdi5gCXbyF9euMGcOrcfI60aWtc=;
        b=UCyaNxWsPj3MCgUY32+L7ejyFlivu+i6oFfbjSfFSlBlGm18SMdw1Nv4auJH9hCUlJ
         AHnx42rUyeDOJmTAa4rlezjRk3E2piKT6FwMvaxczZmtHch+JHo8MKqF/IPKQ37Vb87F
         gWIJPDhiya4Set8xeTi8o/wQ5qRcfPG7b87FM/1ISRcfvLB+vQqGhgAPjCeBOygQbofR
         kHESZ+3ucCKgU/HSLD3bajcORVi7Y/W3+ar6JEGZPsuWUygJ4LcSr0z3m6fZrv9lafR9
         s3eo+/faK+MdTNJ+m0sOUTFIiLpRxA/TivFjeb8fETmR7deC0V9Gn4AAD1winS+bJ5OF
         dLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698779905; x=1699384705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3Ilp1TvpF5zU2TkWdi5gCXbyF9euMGcOrcfI60aWtc=;
        b=WTslIPHZffQeVoroXclMeluEAeQyST4l5vEy2gv2TA5bFA/F6N2stvU/KTayyr8R1q
         2oiCw2PxaLQ8i3qLEpg+rE+Vm4jm3ZObbaDmP6wmdOxrejGxP7jUye/k0bvgSW9n4GLe
         HRSvtIuC4aljzo9ViRnqsCKF18ZJc3QMeIfOAai8FE+p2JyJpdVRB9VLhRMJ/m5cjAP+
         zKSjN4a6tBXLtpGD3Jy6KBCVCZKa4bNA7s3QEOHbKJ9oiunFPY1EQMWc0zeJUW6XvCyb
         xGUsN2rUjuuI+Fs+FWq96YLwcamW9DOWgoXtPSefL0QroMLWIwxTg5ogSpZE7l2lpzK+
         PHaQ==
X-Gm-Message-State: AOJu0YxpFcuIHYWA2rYP7fVoQ4mdk/ad5j4s5IjlO5bccHYgM9qV9Qt2
        8vysbNdPvtb/m4r8yWiTRf/4CD7FV3SShV9RTHw=
X-Google-Smtp-Source: AGHT+IFnzoS6t5OCUWrhdKLuf0bp8kakj9QntRpu1H9/imngPp3EjTqpWPh05Yt9SAohU/tt0aJzPMSYroXdfTtag+E=
X-Received: by 2002:a05:6512:3ba9:b0:508:15dc:ec11 with SMTP id
 g41-20020a0565123ba900b0050815dcec11mr1591469lfv.30.1698779905027; Tue, 31
 Oct 2023 12:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf> <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf> <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
In-Reply-To: <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
From:   Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date:   Tue, 31 Oct 2023 16:18:13 -0300
Message-ID: <CAJq09z4+3g7-h5asYPs_3g4e9NbPnxZQK+NxggYXGGxO+oHU1g@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't have any other RTL8366RB systems than the D-Link DIR-685.
>
> I however have several systems with the same backing ethernet controller
> connected directly to a PHY and they all work fine.

Hi Linus,

I ported TL-WR1043nd to DSA using RTL8366RB on OpenWrt main. Do you
need some help testing the switch?

I just need to test ping with different sizes?

Regards,

Luiz
