Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5853A784FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 06:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjHWElW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 00:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjHWElV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 00:41:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7EDCF1;
        Tue, 22 Aug 2023 21:41:18 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52683da3f5cso6328270a12.3;
        Tue, 22 Aug 2023 21:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692765677; x=1693370477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgoWVF3pm7wU7q7UCBum90uz1R81GW8DD73zqtBdd6Y=;
        b=Hpdu8noAS+v1YyTNdWtwrAVwDfoQo+ZoA5XtukaWbdR7eM0tR5VDXjS4fHpuPpVD1O
         6YW22HyMJqFOfu5vhjhSQAaR22qX/3HL3+DuMaE1hVomSiTeJj42R/DZdGD5W+QqeWZg
         3Qy1Cdc5wzxY8aD3WOet8G+bTgGedRP32ntW/edhB9X5XsIAVlwBkz6K1TzNmRHlTGpK
         oLEVUblHuByzdI/alUExrgtiUdZ6xSYkbQJTb+qujUCpubBgfzd24XkG5QddtlpM5B+5
         Lcdv2U8aMl8AQKAGXJ2TxeQnEsZCzTSY5RNND+HNivHAtCEIoD0oeRaHau6vZYGnYBpI
         QlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692765677; x=1693370477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgoWVF3pm7wU7q7UCBum90uz1R81GW8DD73zqtBdd6Y=;
        b=f7RIFpsS2pxFO3zCGC4B/tAjbzeoRqpYhB/3F3n2i9NBbp5UvJazrxlMiP1TRggTjj
         SwXouIb+IuNtKkDkXWSVBMO2HXaOR3HZmZIySmZGHdnQ12bj8vVl5GlC3KBHw976VPgj
         YR1p8Cl/0ce8GmbTGyWzkGGDx+MkI/1YI5eAuwTs5A3a1sp3OkKWU8PQoBONHQiHGPwf
         4M7X0OeKNW7I+QGG5daX4cbPK4SIgVgfIPhHfIGPUblEud/y+tq19P8ayrRkAeY91Nh/
         ieVroEhUO8GxdqaFZltl7RYfKlvNNBnhU9gQ3ygtIPwM3zikaOYqmBscdA1EE9bacl1Z
         cqoQ==
X-Gm-Message-State: AOJu0YxQ2wQ8tQn3uP6Ylx/y5aU7NhMlKqSCx/RedvqtCTtgDbYFKNzx
        VRcdM53B/mcFnAdm2zMGRFyDM+L8ozLGQ/2XB+g=
X-Google-Smtp-Source: AGHT+IEO4ehvmh+jYSdQE7shcSQ7Ptoz5DtqJ1XDaWYtWplznzcbrlWcxqFld7ybHmjTNDSinW7ZBPLf88Kb8CCw52w=
X-Received: by 2002:a05:6402:60f:b0:51d:fa7c:c330 with SMTP id
 n15-20020a056402060f00b0051dfa7cc330mr8482900edv.26.1692765676530; Tue, 22
 Aug 2023 21:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230816111310.1656224-1-keguang.zhang@gmail.com>
 <20230816111310.1656224-4-keguang.zhang@gmail.com> <c3454ad9-1874-4301-b1b1-4f76886802fb@lunn.ch>
 <CAJhJPsWVRJg7zNeXPDovkBM4pm7hD+RP21DRxt0726VXtzvCHw@mail.gmail.com>
 <150ae6c1-8a2f-4fd7-b012-a53a909919d4@lunn.ch> <CAJhJPsUatqsa_D_RZ8ej33cGPRixhi7A2=2VBOSJVK6xNAA0jA@mail.gmail.com>
 <ebcd20c4-b0ba-41aa-b8fa-ad26481c3707@lunn.ch>
In-Reply-To: <ebcd20c4-b0ba-41aa-b8fa-ad26481c3707@lunn.ch>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Wed, 23 Aug 2023 12:40:40 +0800
Message-ID: <CAJhJPsVwfGsuzzHx-zVwz=T7zw-+bJ2MZ1YUffiU7NvU4X9njw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] net: stmmac: Add glue layer for Loongson-1 SoC
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
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

On Wed, Aug 23, 2023 at 11:46=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> > I understand the delay issue of RGMII.
> > Just tried phy-mode =3D "rgmii-id", it still works.
>
> That indicates something is broken. Both "rgmii-id" and "rgmii" should
> not work, just one of them. What PHY driver are you using?
>
I used generic PHY driver.
Both "rgmii" and "rgmii-id" work with this driver.
The PHY is RTL8211E.
So I switch the PHY driver to Realtek driver.
Now only "rgmii-id" works.
Thanks!

>     Andrew
>


--
Best regards,

Keguang Zhang
