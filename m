Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16517C8DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjJMTyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMTyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:54:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1BBBE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:54:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so3863752a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697226846; x=1697831646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nr5rTcvx3Bqes76zmwwUrfRUqUSHDocyP1SazHWr+w=;
        b=djcfVWzgXcmHpwjkTng5NwzHLhHeTcuTOg1UE7SXquOkVesAbN5DsrQrmETYpVO2YV
         /ctBV5PnIvsdRvRIZQ+A/1fVqDDaJMc0lzQjazR8+jZ+CDNtV+yuXsyu7D9G1U9YHmyA
         kt8orGquHe2FZ7kRPACc9elns1cBPpIsTlYoVWIMgkyHcM57GNmzXjDoXcG5pWzjWixA
         siIMHUvWpcw3KvXjXsR68OgtTW5QJsm0pdjPA891TmLajS+fOYVT5M5Bz7DdbcLJux9G
         1pNfngINuldZ08In7wISM0WVReHGRnrUUBkGlRQ0WbIzV0E1wYWia1Q+y8kbKpnrCfQV
         vWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697226846; x=1697831646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nr5rTcvx3Bqes76zmwwUrfRUqUSHDocyP1SazHWr+w=;
        b=XGpO8ii54qg2UuAB7z/JDH3ljPta6FtqJadbenIjC8zKMa3jq/SejTgiXIo7TbV9Nm
         3TqTAXF3izPQGA6S/oakN5xtu1zAwlIWE/lzNRFA9Qr4ZrGdDVVGsVb+vdbTaGZzhloz
         giyS/EB5xU0ItZ4bDCkwUa1nSSmb9IbWS+X8LDnZXVe2j+SeSPBdXKcRYmOC3kjHDOa4
         gJD8+Jb2I1/UzFEm28Gv78eJ4bZ73vXS0YIPLiTij4lq5ss91JzczotLpqLUg6Lj3Jc/
         EgLNEl05mXCsyR2txv5aEK912IsqIw4gW7JFXFy/fo4ZWTnH7Ta0Dz/r1WZu693hj2LN
         ar3Q==
X-Gm-Message-State: AOJu0YyHU3N0EGf9pkdLzTZCJBRaM3ObYtFgldz79PLprhcfIXr2kQIb
        OBH+wJUcMOPs1FQEw7bMgtx2ukgyXnmmLG3ddumoig==
X-Google-Smtp-Source: AGHT+IEmQdB6jTOkef10X9umxYczo2MAno9vooZhhnlm41Ql4LMTSfvVX0/maWT0UikblvZ6Cn/oh+PSpaj7EXAV2fs=
X-Received: by 2002:a50:c8cd:0:b0:53e:21f6:d784 with SMTP id
 k13-20020a50c8cd000000b0053e21f6d784mr4099063edh.8.1697226845814; Fri, 13 Oct
 2023 12:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
 <15af4bc4-2066-44bc-8d2e-839ff3945663@lunn.ch>
In-Reply-To: <15af4bc4-2066-44bc-8d2e-839ff3945663@lunn.ch>
From:   Justin Stitt <justinstitt@google.com>
Date:   Fri, 13 Oct 2023 12:53:53 -0700
Message-ID: <CAFhGd8pmq3UKBE_6ZbLyvRRhXJzaWMQ2GfosvcEEeAS-n7M4aQ@mail.gmail.com>
Subject: Re: [PATCH] net: phy: tja11xx: replace deprecated strncpy with ethtool_sprintf
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 5:22=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > -     for (i =3D 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++) {
> > -             strncpy(data + i * ETH_GSTRING_LEN,
> > -                     tja11xx_hw_stats[i].string, ETH_GSTRING_LEN);
> > -     }
> > +     for (i =3D 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++)
> > +             ethtool_sprintf(&data, "%s", tja11xx_hw_stats[i].string);
> >  }
>
> I assume you are using "%s" because tja11xx_hw_stats[i].string cannot
> be trusted as a format string? Is this indicating we need an
> ethtool_puts() ?

Indeed, it would trigger a -Wformat-security warning.

An ethtool_puts() would be useful for this situation.

>
>         Andrew
