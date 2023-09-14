Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9247A0478
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbjINMxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbjINMxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:53:12 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5A61FD0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 05:53:08 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-564af0ac494so678251a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 05:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1694695988; x=1695300788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Kzj7q3PuwQuc6Wj5PjDv+5qYh0eJJ29SOGWZm5BnJs=;
        b=PdQ8V8J1KSv51vF4oEV4utTE8W5ky46LOumcAsheyzw/HEmNnBG8BLo3X89f11j0g1
         Jy4hRJ5vYBxlnRQSV6rg9kbLUKQ1iOebJ4r+sTWsFLgmES1Y+IX/XHsRHo3eOyV002mW
         zt64H1N5EzI3HNWDjBgfbevd0Aui1HtTFubQN5aGwpm1pmWS+xDfOaBSX0i1jY6kI5qM
         tuzMEO6YjKTGOe9JNZfPCWkIgt4dg9OJKy8ffD9Sw4HC7RdONF+PsZbvOlOTQrY7BQws
         h7DYMyTZ0HeS//qWrxJAm3vHoE1FRbhEEqDQSULicJEt8F8GpRZkvGDdoOSKcssmAY5g
         Vb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694695988; x=1695300788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Kzj7q3PuwQuc6Wj5PjDv+5qYh0eJJ29SOGWZm5BnJs=;
        b=lrXaw6D+pA02tDP31c9b+M+p/G8rqeIx3hlthcMgmy2pCUECsDakb99Fs+HeE3eFKJ
         qfYdwJ55uB0hD3eem/Kk6ufQU3NuDzweCfa20bzP+OMQjbvbL7bFJ5w5E5RrqhIzv38v
         rgR8tqLiPdRJZJQa83ZV/2AtfEFJKxPNTzzPfqEUsX5Ucze0vYLH5BpguvCoSKjQ0aZp
         i6d+nTlPfD3mwKDFvKuoB63yGFiani4wIW/b/OhoSdUMwrUS1gDORNnoq6CvNixMzIWZ
         DDCNDHTKLqvGv6HS9mgmNBgHzfXwnakBAn4kALz7jhtM4QqAg3tPd4AUJd2r0Vfcob/b
         ybrA==
X-Gm-Message-State: AOJu0YwJqqvM5rdPxTamfLPjH0pruXVWpBgqVklp/yQytHwrDbbmUXUE
        A3/tqmx+ciP8NTyzbzkMJgIhOrG5ceh0Su4l2i2Uug==
X-Google-Smtp-Source: AGHT+IG7PB0fNBhr7nKrGoWxSpgFuuPxwIf9ND3dYqEhlSQ6oe9344/guJDq9c9uJ1i6Kg2xdy/2rNtYLjO/BmmsMI8=
X-Received: by 2002:a05:6a21:329c:b0:12e:98a3:77b7 with SMTP id
 yt28-20020a056a21329c00b0012e98a377b7mr6278495pzb.59.1694695987694; Thu, 14
 Sep 2023 05:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230914094550.1519097-1-robert.marko@sartura.hr>
 <20230914094550.1519097-2-robert.marko@sartura.hr> <5bcf3091-af8d-47de-b276-3dccc0997850@lunn.ch>
In-Reply-To: <5bcf3091-af8d-47de-b276-3dccc0997850@lunn.ch>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Thu, 14 Sep 2023 14:52:56 +0200
Message-ID: <CA+HBbNFoC=Wr0-Yk==R_bNBOuLw=vjqK3VckK1H5DUSj1NVK-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: marvell: eDPU: add support for version
 with external switch
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 2:51=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +&mdio {
> > +     status =3D "disabled";
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&smi_pins>;
> > +
> > +     /* Actual device is MV88E6361 */
> > +     switch: switch@0 {
> > +             compatible =3D "marvell,mv88e6190";
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +             reg =3D <0>;
> > +             status =3D "disabled";
> > +
> > +             ports {
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +
> > +                     port@0 {
> > +                             reg =3D <0>;
> > +                             label =3D "cpu";
> > +                             phy-mode =3D "2500base-x";
> > +                             managed =3D "in-band-status";
> > +                             ethernet =3D <&eth0>;
> > +                     };
> > +
>
> So ports 1 through 7 are completely unused?

Yes, only 3 ports are used.
Regards,
Robert
>
> > +                     port@9 {
> > +                             reg =3D <9>;
> > +                             label =3D "downlink";
> > +                             phy-mode =3D "2500base-x";
> > +                             managed =3D "in-band-status";
> > +                     };
>
>         Andrew



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
