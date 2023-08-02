Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA2176C7AA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjHBH5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjHBH47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:56:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90311213A;
        Wed,  2 Aug 2023 00:54:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5221f3affe4so8797452a12.0;
        Wed, 02 Aug 2023 00:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690962888; x=1691567688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHFpvjYyT+C6FQOobZ/lAA4Uv30nY9VZPx6Wltel8aw=;
        b=A0iAhBZZ0MlcxykiFcmGYSIB1Kg5mGSZ4EaNgrLjv4zn7epsJlIiKZLiNLbc5RIZgk
         m4XIn1zTxuBL6PKBo12fEHSyLzMm4xZjmUKh8LT+vey0XbuMQGOMKA0b82I73oi4xv8t
         fUQi5te6+qvpNF8ENoGxzg9aEOHkDmeJyEJkg7s24+sTX5qMR53n5T1hek77Hhhjhwye
         lJAnP8PYrgEkcEBNTwQyK7HtS9kdBz2tAXwgbwbilB5qauFQVw9SAmPJ2ssAfyLRtVWf
         8Uc3mgDZuKxc3JhMQxcz4CGd661TKXFU7wAIOIdlTjogIkevBl4T+oAoswRkmRPbcsva
         xdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690962888; x=1691567688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHFpvjYyT+C6FQOobZ/lAA4Uv30nY9VZPx6Wltel8aw=;
        b=mGKBsxY3HfXpn/3x0IMS3LipWlwbboeR5B8BUgBepiu4eXeDA87XhiuR1VfRvyXWbq
         HQa+JJgQSvhXuo8nYvJXFgV/mB9AWAtuhJcrAC6+jo9+lna5nqtBSSRfawhPYmAtostn
         2wODmIOUwfnrKSFa6RP6sbFHtIAtYAKv7xQ6hrqrsZI+DoSTARo5PI1r2Og8mFGKCWgF
         3qLLB35GsCHKFCHp0t/pLIaH7pWQMj5E5orNBfMS2bF9xkBLrxiyib/domC3AfVEsOob
         BzgORF6a7mjTj+2xwHD0oRlH7LGr0IDPODNCzeCP7zEgOuzRbA327eYbqYJeaor+Tz3m
         AUIw==
X-Gm-Message-State: ABy/qLZ8KRctEYXu//XLWYOuOmzCLydXXfhq7Hp/8fJcpp8OsknruNBp
        COHxwxJf6l/obYi86RS3SFe2RrAq6IZNC2GzlQ0=
X-Google-Smtp-Source: APBJJlG0yx6JC4dmyFUtVR6Blc8Xu31KjFmAzNdj46E9aT3WBkkf8L1wuH36ReifMBB6mhPq4O5+DeSzfm+DhQj85lI=
X-Received: by 2002:a05:6402:60e:b0:522:27c4:3865 with SMTP id
 n14-20020a056402060e00b0052227c43865mr3924074edv.41.1690962887837; Wed, 02
 Aug 2023 00:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230801082433.548206-1-daniel.baluta@oss.nxp.com>
 <20230801082433.548206-2-daniel.baluta@oss.nxp.com> <87cz06uypz.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87cz06uypz.wl-kuninori.morimoto.gx@renesas.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 2 Aug 2023 10:54:35 +0300
Message-ID: <CAEnQRZAn2W3kD-FsUdjKR7TuYvZwkSXOKBUgwLrqDBeGXV3bFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: simple-card: Introduce playback-only/capture
 only DAI link flags
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org, robh+dt@kernel.org, spujar@nvidia.com,
        tiwai@suse.com, perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 2:31=E2=80=AFAM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
>
> Hi Daniel
>
> Thank you for your patch.
> This is not a big deal, but...
>
> > We need this to signal that DAI link supports only 1 direction that
> > can only be either playback or capture.
> (snip)
> > +     if (of_property_read_bool(node, "playback-only"))
> > +             is_playback_only =3D true;
> > +
> > +     if (of_property_read_bool(node, "capture-only"))
> > +             is_capture_only =3D true;
>
> More simply
>
>         is_playback_only =3D of_property_read_bool(node, "playback-only")=
;
>         is_capture_only  =3D of_property_read_bool(node, "capture-only");


Good point. Will fix in v2.

>
> > +     ret =3D asoc_simple_parse_link_direction(dev, node, prefix,
> > +                                            &is_playback_only,
> > +                                            &is_capture_only);
> > +     if (ret < 0)
> > +             return 0;
> > +
> > +     dai_link->playback_only =3D is_playback_only;
> > +     dai_link->capture_only =3D is_capture_only;
>
> It doesn't overwrite when error case, so
> More simply
>
>         ret =3D asoc_simple_parse_link_direction(dev, node, prefix,
>                                                 &dai_link->playback_only,
>                                                 &dai_link->capture_only);

Can do this because dai_link->playback_only is a bitfield.
