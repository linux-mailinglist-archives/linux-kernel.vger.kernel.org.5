Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAE077E668
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344716AbjHPQ3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344709AbjHPQ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:29:15 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7390F173F;
        Wed, 16 Aug 2023 09:29:14 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so834578a12.0;
        Wed, 16 Aug 2023 09:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692203354; x=1692808154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDwTPJw+5ucZMyeoaXg4Y3bABbR60PDLoOBlQrwY1jg=;
        b=paLtg+ZCT6g2zAkxL08b100Ise2GGAjj+J1pD7w0/a7CxKOU6vyWdy8XHDcUhoGohg
         giLp452lGlJZHY1PYB/sgUPZh2UsFRooXUrg1SM3+fFQA0M9M+lULqj6o4BI9xa7h/El
         vw7RNewAruvaJvqxv/FmNvouBEBXDjYhsdg0B/ICKpGYxjH0BkLRuVmIevKd2OE0nKZc
         QwejWbof71Lu1VyIPcYJtSay6HlO5wfEbtqy8ezs2+RxOtrQzCJldVc8guzMXYLmUsZ5
         YeotVoE2DYnggx0JD/jw2J7yiDHlOsPFukq9Yp9ZgY+sxzweX15rqzbPK/v7vsQX65El
         Cfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692203354; x=1692808154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDwTPJw+5ucZMyeoaXg4Y3bABbR60PDLoOBlQrwY1jg=;
        b=ExTf2kcgWWxmckX3tQ/TsjjUAX5HgqhK1MD84RGCDEUvjXG/F4uUZezOjcaSIbt4TG
         k7YhrNnd8A9swwLf8pbM5SAoFjPq8r67VlW+9/3v6CcFbb86lYbv4+F+jJCT5axmel8p
         a5cvWttuZlXw+YSJDv7bBA3A/6GlUYl64SvTuiKnO0evijiUEhPGcDRXuZqyDJ4F2dMV
         dLBBu8JEkI86BrGKtqxDOnHfEBiDXOdA+OqIwNJDgg9z/8w3qffXj3uG0LEipX4q2HJw
         /PhESTGsqd5Ge0J63XfbcmViK1jMIfH6CcjDjPDdaE0pdprLq8XT5v1AmFeYFUmwL+v/
         +gWQ==
X-Gm-Message-State: AOJu0YxdBKuEgj5M85nPxrZGdmXNvrrPHxTORjKZiDx1bwLQU6jXZ1HL
        WgpqBtK8CvvDMCHQADWs/zofBUh+OoAn8PfK/oQ=
X-Google-Smtp-Source: AGHT+IE2wAHu4qgJXHj7jeWuhe1a2iuhfrVjwcBDyHwA4GqsOz4k1VsQbuW8ersWNzjlYQ/Mlyon0h466UVJLelP8gw=
X-Received: by 2002:a17:90a:2a8f:b0:26c:fd49:8b3e with SMTP id
 j15-20020a17090a2a8f00b0026cfd498b3emr1367509pjd.3.1692203353851; Wed, 16 Aug
 2023 09:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-0-3889b1b2050c@pengutronix.de>
 <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-3-3889b1b2050c@pengutronix.de>
 <6a894ff0-3232-4ef0-5e26-95471cc33ed9@roeck-us.net> <20230504142708.l4xo4sbl7wzsrbql@pengutronix.de>
In-Reply-To: <20230504142708.l4xo4sbl7wzsrbql@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 16 Aug 2023 13:29:02 -0300
Message-ID: <CAOMZO5CCpeQLOhxvOCHjuip_DkVeZokGH_WgewxqyE+L40dvgw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] usb: typec: tcpci: clear the fault status bit
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Guenter Roeck <linux@roeck-us.net>, andreas@fatal.se,
        jun.li@nxp.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Thu, May 4, 2023 at 11:27=E2=80=AFAM Marco Felsch <m.felsch@pengutronix.=
de> wrote:

> > Also, why not just write the bit unconditionally, similar
> > to TCPC_ALERT ?
>
> Thought about this too.. I will change it in the v3.

Was there ever a v3 for this patch?

Thanks
