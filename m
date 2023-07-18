Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBC77580D2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjGRPYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjGRPYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:24:49 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440AFA1;
        Tue, 18 Jul 2023 08:24:48 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-579dd20b1c8so57077877b3.1;
        Tue, 18 Jul 2023 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689693887; x=1692285887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqTZ5VtJv8ZipGwySLiNWe25hUa+zEm1zPtVs7gkYp8=;
        b=sGvk5uwJCoJ2+n2g9dv6bCRgvzQZ6HJiqdlJgIA5/LQy2OGateHELNwdvmd019Eb8v
         jIg1NzETquzXwkqdtHMSi6UIbGByjGNJnu6O3WepGnyZOSW266SL6RgrG6WxdcJHeTmZ
         yNHDpnrUYri0oNmbxMn+3V06QY/vAK1XqU0DTQyqedhOcdwRgFO1zrX0BYictIjt5Oai
         kwR8+SbvAMfkBWTrEpEvLzwPZemcpLI8LxmqTYbuyBcB9MYSieWkNGCbx3jzCv2UhL5K
         +Xo35tlhJEfvmG/cMyKG7QTT2Zefxvm8hLp92jDvV/w3eqqTYgWflndPPdF7bAJhrJt5
         eI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689693887; x=1692285887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqTZ5VtJv8ZipGwySLiNWe25hUa+zEm1zPtVs7gkYp8=;
        b=S4b/l2FMrpwWH5zHGs5cZKLCWFEKDAM2f6TWcpbPzq2tuW9hMi9+b3+gOOYQ6Nvmqo
         LiEYMGOgBoJVbNwYE+YmrCjlOVf+gigpjAOsGG1cObH1yIawhXb5c6T1DBwYk4BklvCe
         Q6lrsxLLgCD+SmgED6QrRkFEHx8r1YPmzJ5ebSzZZDVYsxi3ChMRRUsJSpAMOAmkUgh9
         oaBpbSgi37A+gUoglWzW3l/LdF4O8b/LQO5tYJ/Brknwz533kb2zGty/GBxR2jXbC8Js
         jQ1EjLI68+EJZuY6IMi0Si5q1CzkyHDC8XlUnyGo3+j0oIi13voqUM40wOeIFp/6DvZk
         fHZw==
X-Gm-Message-State: ABy/qLZ8wKN0WLi3Nn24/+DJzH/FEWeIOFnBAQ+RcIsNVOyM5aYL0rDs
        fVImwTsDAIJ5kyFwQgsqWlUkoBh/4j8xSEme4m0=
X-Google-Smtp-Source: APBJJlFeoFh8RkvH70huNuLDuA25sSwc5wrkzJ2luG1WKpQiyBBCtvHuCzO2kNaOaZn0g4dlM0x4alr9fYe6EojReT8=
X-Received: by 2002:a25:d1ca:0:b0:ccd:8a80:e79d with SMTP id
 i193-20020a25d1ca000000b00ccd8a80e79dmr218335ybg.23.1689693887450; Tue, 18
 Jul 2023 08:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230717151624.3470714-1-carlos.bilbao@amd.com>
 <20230717151624.3470714-2-carlos.bilbao@amd.com> <CANiq72k+uB4Px=_kGNEiduc0AewC05XO2zTqC3+ABa0hcxui9w@mail.gmail.com>
 <f75bb80a-e49c-24e5-c897-7c4ecc804f84@amd.com>
In-Reply-To: <f75bb80a-e49c-24e5-c897-7c4ecc804f84@amd.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 18 Jul 2023 17:24:36 +0200
Message-ID: <CANiq72nmeXwS06w2AwJ5OdC14x_5Gp-GmksrBJXiUiZuy7y7hg@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] docs: Move rustdoc output, cross-reference it
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, ojeda@kernel.org, jani.nikula@linux.intel.com,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, konstantin@linuxfoundation.org,
        Akira Yokosawa <akiyks@gmail.com>,
        rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 3:50=E2=80=AFPM Carlos Bilbao <carlos.bilbao@amd.co=
m> wrote:
>
> On 7/17/23 11:37, Miguel Ojeda wrote:
> >
> > Also, I assume this is intended to be overridable by the user, right?
> > i.e. that is why you wrote the identifier as uppercase.
>
> That's true, I don't see any reason to make this uppercase.

I don't know -- perhaps users may want to override the output
location. `BUILDDIR` is intended to be overridable, so we should
consider what should be the behavior when one overrides one but not
the other. Or perhaps this one shouldn't be overridable, like you did
in v8, in which case we should still make sure things work if that one
(`BUILDDIR`) is overridden.

Cheers,
Miguel
