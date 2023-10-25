Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9D97D78CE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 01:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjJYXmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 19:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjJYXmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 19:42:04 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B57185
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 16:41:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-508126afb9bso353848e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 16:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698277317; x=1698882117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8VIiqLkglYqJ+Q19MxelXV/EJXHtj9elKsbPyNgJFE=;
        b=X4iZxpwW9noy6PCl7Fek6l3YBr1XUibRBJzDmAgzP82lCayz5gergKKAzLCpu/Kq6o
         DtfuzkoO0yo4/vuZRPQcNn4YL5P/DJJ7u/C0IpZRCTohn+pqVr68KgK+zeWZjh5b24rm
         1tQOfnDf16ZjAs3diwlNVYQPZ9ySH2PkAoFAbilPzGQ69pxx9KidtW3mV9hc1h13tK0q
         krp2qZD2+8mn/zePSDw4fmw9665OgUIVOnqUHF+GHy/qc4VzsLBOHIywuTWF/o2lWhNL
         4Y2KiGLsEtyo6EP6dbyJ3gp13vxn8wUd4YOMTTZw2ue97ytaTPbrGWuBb/dCIr3QzHt6
         ZNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698277317; x=1698882117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8VIiqLkglYqJ+Q19MxelXV/EJXHtj9elKsbPyNgJFE=;
        b=PXa7p8/XLlMstXKIvCfyAJPGrARLUhSzsR04C8UoSNdQnKrlPCmV1yQwWmYEJFqTRf
         ni5HbB6bc2UNXSdI6yaF/7+ZFAlH/etZtoRglDOPMYF5/cnip5dtrXwM7m8/CDBLGG+i
         xNgz3wdmEJltIA7gMVWbW+sW4wC2C7rgIx4aeuMEuiYdL6YG3w/kfmv4+u7hGjufaI+f
         5rYIHLyZCpTflbRrGZ3kmlOssA9dsVSmV1/TCFAp/40XkJ2LKwZEpey+t3bGkvOnP9zz
         C8QMFt4nCY7x60dhjC+LprU9igmYvppwzrfk2/0wv1oQBrJ8QtU+ah9cxRYxUhrhWHnf
         QKsA==
X-Gm-Message-State: AOJu0YxIsDyESUBOCk2XmsRkBgtdwwgMEDAIrPGU833JeMqwcHrLFEoN
        zUSGdYhA4fc7hg5LF9jVyH+UZqRcJzcgXT2LkhkFQg==
X-Google-Smtp-Source: AGHT+IFvspkBVEQcaXlvdiXLBc5/Nnce7QqmAyRawMvbFwO+bR8RKg0bupAzqNCymHeTUjheo+zdDooay+3N3QXOwCg=
X-Received: by 2002:a19:6716:0:b0:500:9a29:bcb8 with SMTP id
 b22-20020a196716000000b005009a29bcb8mr11657885lfc.4.1698277316604; Wed, 25
 Oct 2023 16:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
 <15af4bc4-2066-44bc-8d2e-839ff3945663@lunn.ch> <CAFhGd8pmq3UKBE_6ZbLyvRRhXJzaWMQ2GfosvcEEeAS-n7M4aQ@mail.gmail.com>
 <0c401bcb-70a8-47a5-bca0-0b9e8e0439a8@lunn.ch> <CAFhGd8p3WzqQu7kT0Pt8Axuv5sKdHJQOLZVEg5x8S_QNwT6bjQ@mail.gmail.com>
 <CAFhGd8qcLARQ4GEabEvcD=HmLdikgP6J82VdT=A9hLTDNru0LQ@mail.gmail.com>
 <202310131630.5E435AD@keescook> <a958d35e-98b6-4a95-b505-776482d1150c@lunn.ch>
 <202310141935.B326C9E@keescook>
In-Reply-To: <202310141935.B326C9E@keescook>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 25 Oct 2023 16:41:43 -0700
Message-ID: <CAFhGd8r3=ndtYgjK3O5KV_wrd5OL+0hP6RjqBwhJXgc0jr1hDw@mail.gmail.com>
Subject: Re: [PATCH] net: phy: tja11xx: replace deprecated strncpy with ethtool_sprintf
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 7:36=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Sat, Oct 14, 2023 at 03:55:41AM +0200, Andrew Lunn wrote:
> > > I've been told that this whole ethtool API area is considered
> > > deprecated. If that holds, then I don't think it's worth adding new
> > > helpers to support it when ethtool_sprintf() is sufficient.
> >
> > I think deprecated is too strong. The current API is not great, so
> > maybe with time a new API will emerge. But given there are around 160
> > users of the API, probably over 100 drivers, it will be 20 years or
> > more before all that hardware becomes obsolete and the drivers are
> > removed.
> >
> > > Once you're done with the strncpy->ethtool_sprintf conversions I thin=
k
> > > it would be nice to have a single patch that fixes all of these
> > > "%s"-less instances to use "%s". (Doing per-driver fixes for that cas=
e
> > > seems just overly painful.)
> >
> > I guess it is the same amount of effort to replace them with
> > ethtool_puts()?
>
> Yup, right. If adding ethtool_puts() makes sense, then I totally agree.

Thanks for the discussion here.

I've sent a series [1] implementing ethtool_puts() and sending out a
wave of replacements.

[1]: https://lore.kernel.org/all/20231025-ethtool_puts_impl-v1-0-6a53a93d3b=
72@google.com/
>
> --
> Kees Cook

Thanks
Justin
