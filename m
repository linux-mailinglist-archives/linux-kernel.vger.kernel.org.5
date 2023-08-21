Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A577D782A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbjHUN1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjHUN1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:27:47 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7885F8F;
        Mon, 21 Aug 2023 06:27:45 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9a1869f2c06so324056066b.0;
        Mon, 21 Aug 2023 06:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692624464; x=1693229264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+iFwgTYe6alOqlhRqK0d1Txw36ocFuLjRCLnCJY2MY=;
        b=glhxce2bBkGqmRfW15Hwgy0j0BlSFJKXQU7HEYq15yE79mNe/b4vwHojRNMkTD2rM/
         g7IgqH93uJH7KAeqkejDClXYy441N4XM807/+Ld4d0817y7GuX6FwhA/hI6AxmESzP4b
         t/jqO+UTa+gpL5dPhGItXhSA6xyD/QZwc2238ApbMEojgX7qiA0atDX/MHw9aEQFAuak
         yEMiSzu0G0kOIFAh6pmq/nkC58ec0bggFQZQBb6pqzEpuCd8DE45BV8yHxNd2GgJynRL
         HHElLjAfKt3cwp+f0aDMQft5+N7/2IZ8H1sU8gK9PFp8CxjvHGOjzooEMohTH8rzzNrD
         Zfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692624464; x=1693229264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+iFwgTYe6alOqlhRqK0d1Txw36ocFuLjRCLnCJY2MY=;
        b=OuDZb+UwwVg/DYHqC1JuoQ34f+St9g+7f+MzPG2vA21PWAWzS5v7kINWDSRYJ0/j4G
         TEKRoodi++gaOQxK6oo0or0nxPUjSb20/eoBtow5nJuLxRcMfcSJfWZIU58wmRVFov5l
         Y4NkpXfRpnaLqFQAyFlFwyQdMBHra2YCxg9ypI8fWhsZ6C6cTxTsZ6KAG8zv/w5dS3OR
         9Z9STjay1J8C84xtTXeiiiBj6nrjeVNdxOYixOmHrV6FV1tslIwRCvJi/1RQMDErwwab
         lSatq/ddUqEWlw+xczYDmc4y1nbXibl4T7WeF11y2DlY1CG1Y3z5IDFuAbzEyB7uK2Je
         Deuw==
X-Gm-Message-State: AOJu0Yw7ve4Bg+khBSBVAM7oizAVSrI2xs252SMnIUAxuuTq0ktxxLpb
        VATjCHjq4xWgsAaXZ4d/CNAcGXpY8UIDroQQWSM=
X-Google-Smtp-Source: AGHT+IH+t4GWbCUro8fWUdvspcxpEZAy2Wn1mIHuSevK73gBQcvl2B6Qi3H1dL0YcyW1ddaNJXwdWH5nA//+XpzVfDE=
X-Received: by 2002:a17:906:d4:b0:9a1:8ce6:620e with SMTP id
 20-20020a17090600d400b009a18ce6620emr4403593eji.17.1692624463867; Mon, 21 Aug
 2023 06:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230816111310.1656224-1-keguang.zhang@gmail.com>
 <20230816111310.1656224-4-keguang.zhang@gmail.com> <ZOESdApO8NN8kDQc@vergenet.net>
In-Reply-To: <ZOESdApO8NN8kDQc@vergenet.net>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Mon, 21 Aug 2023 21:27:27 +0800
Message-ID: <CAJhJPsX1k1L3yWt0k2P+_fNuUFipeYTSnyMdGvTdpviForbbwQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] net: stmmac: Add glue layer for Loongson-1 SoC
To:     Simon Horman <horms@kernel.org>
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

On Sun, Aug 20, 2023 at 3:05=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Wed, Aug 16, 2023 at 07:13:09PM +0800, Keguang Zhang wrote:
> > This glue driver is created based on the arch-code
> > implemented earlier with the platform-specific settings.
> >
> > Use syscon for SYSCON register access.
> >
> > Partialy based on the previous work by Serge Semin.
>
> Hi Keguang Zhang,
>
> as it looks like there will be a v3 for other reasons,
> a minor nit from my side: Partialy -> Partially
>
Will do.
Thanks!
> ...



--=20
Best regards,

Keguang Zhang
