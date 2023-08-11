Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7787778C84
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbjHKK6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjHKK6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:58:14 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFF8E5D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 03:58:14 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1c0ed1a670cso1304170fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 03:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1691751493; x=1692356293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTZHlIAGFEKdBi+63oyh+zLAlOMK7WRYXs/qS8i665k=;
        b=dDL1mJ5EMOzT8YvEmZ4l1tIcJ1TJk0Uqva/ASePz3Ga6Wcis3jaKf4ezZuVbIa4hzD
         2EA0EJrQ372K8lQZxYpPc+RLD3emKSarHpaH/1FJuu+VK/g8Ic8nps6+RC7zqtFXS0vP
         D6wZPKS7FDKL7xDmPjjJqZd4f+pOlCBezTq32PnA7TAWE4VXd8U/YtPVXHAVZ/VYyQq6
         OYNocL6EkaH10PDuI3FqOseCAMNFTIVpkVNUXatxhCksmm9VP54Qb5Jx+zEzJGLaNDgx
         4bwXISlqmrazPxZqsLkeCNh5yQ+uqxYm/o6TifisqWzt3nv1mEXiLDuEDjmzWSd5sM2l
         3cFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691751493; x=1692356293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTZHlIAGFEKdBi+63oyh+zLAlOMK7WRYXs/qS8i665k=;
        b=dG4lZNb9N9+6AUVHp/y3I7k2BB9itD/ncjKUhbM2qUoha1El7kH7iUZKMjXh+bJDD5
         XXjNWDtbg+3dOvLfUkyPOssR3lacBwvOSvgsLiP4+PuoxdXWur6lA+vRooQ1iN6lTAI+
         4oD4xWVMfZ+ao0TcgxhCsqclEO+fM98MhK3FnAWs68Ig2Qt/X7QobDyUQyplEXtqzzGl
         PV907wCJLgpm5itnKfF+xhpI5i/Xz43O0nr/cBVyYUFcSDSm40TnN49bcUh3hlv47Ome
         S0VDw6+bUg1vOBCa6I8FndWT148N16vBckhQ5INlSm8pqqkJoOSJAQNV9TAaNWaedCGx
         7o8Q==
X-Gm-Message-State: AOJu0Yyy1goK0KVkoxxfabznFml6UM3CFtt3xwraRz/DdmAhwvfA/g5n
        yKSVyz1MkN0bCHcXNSysAze0Ww0knZRXp18ykEGh0Q==
X-Google-Smtp-Source: AGHT+IHwvpYX/pdfzxZKgq4aPW/Ny1wl4QEiy9jIL7OFwLrp8ndXGkFmB85Yt7jWyJQGpeOUcOmXkPZeF87k09xeuiU=
X-Received: by 2002:a05:6870:41d3:b0:1bb:b13c:7f9c with SMTP id
 z19-20020a05687041d300b001bbb13c7f9cmr1568597oac.57.1691751492879; Fri, 11
 Aug 2023 03:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230810102309.223183-1-robert.marko@sartura.hr>
 <20230810102309.223183-2-robert.marko@sartura.hr> <ZNYTWya4OM8pmcZf@vergenet.net>
In-Reply-To: <ZNYTWya4OM8pmcZf@vergenet.net>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Fri, 11 Aug 2023 12:58:02 +0200
Message-ID: <CA+HBbNE14wWUvxBjcFP61TQVX8nVsxZs6Cc=Kr3PQDM9Pe0v4w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: phy: Introduce PSGMII PHY interface mode
To:     Simon Horman <horms@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, luka.perkov@sartura.hr,
        Gabor Juhos <j4g8y7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:54=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Thu, Aug 10, 2023 at 12:22:55PM +0200, Robert Marko wrote:
> > From: Gabor Juhos <j4g8y7@gmail.com>
> >
> > The PSGMII interface is similar to QSGMII. The main difference
> > is that the PSGMII interface combines five SGMII lines into a
> > single link while in QSGMII only four lines are combined.
> >
> > Similarly to the QSGMII, this interface mode might also needs
> > special handling within the MAC driver.
> >
> > It is commonly used by Qualcomm with their QCA807x PHY series and
> > modern WiSoC-s.
> >
> > Add definitions for the PHY layer to allow to express this type
> > of connection between the MAC and PHY.
> >
> > Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>
> ...
>
> > diff --git a/include/linux/phy.h b/include/linux/phy.h
> > index ba08b0e60279..23756a10d40b 100644
> > --- a/include/linux/phy.h
> > +++ b/include/linux/phy.h
> > @@ -147,6 +147,7 @@ typedef enum {
> >       PHY_INTERFACE_MODE_XGMII,
> >       PHY_INTERFACE_MODE_XLGMII,
> >       PHY_INTERFACE_MODE_MOCA,
> > +     PHY_INTERFACE_MODE_PSGMII,
>
> Hi Gabor an Robert,
>
> Please add PHY_INTERFACE_MODE_PSGMII to the kernel doc for phy_interface_=
t
> which appears a little earlier in phy.h

Hi,
I already have it prepared as part of v2, will send it later today.

Regards,
Robert
>
> >       PHY_INTERFACE_MODE_QSGMII,
> >       PHY_INTERFACE_MODE_TRGMII,
> >       PHY_INTERFACE_MODE_100BASEX,
>
> ...



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
