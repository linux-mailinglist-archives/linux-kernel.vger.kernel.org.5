Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7135C809316
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbjLGVIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjLGVIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:08:14 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34781716;
        Thu,  7 Dec 2023 13:08:19 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-59064bca27dso665121eaf.0;
        Thu, 07 Dec 2023 13:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701983299; x=1702588099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cT8aoY+rEUbS2cmho5uFAl6BrXELpVToy3OJdxx6OrM=;
        b=LyNnwWagJp0D7TbUx6FE+b6nvhHt1TJiXvBPdjailIhJcBWxw6alwEzS5ixQ9hRKsm
         /t4mg0W/VVLgZdeRAm5BA+htOhgkEB+gVHKL/l9TyMKj2ZKEBWSZ+yf0Y0uO8270/oI9
         pnI45uauZjL/tLe9FtjNV5cj0J9XNmrnmuh4OtNXjjzey6Fh+ugPnd3DjL2otnzrrX78
         mJk/LPn/QteA1jgzvx/JP1T5KkQJO6zdaWX/zMVwb9qE5gHeMG6Su0KKMAeMLa5bC4bu
         nTt4e2XjgsWk+2TVw4r6eKqV6i1RC0DUcu2TKhI0l41QIGVKxzuesqhQCh8bzxU7NxO5
         xdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983299; x=1702588099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cT8aoY+rEUbS2cmho5uFAl6BrXELpVToy3OJdxx6OrM=;
        b=YyHQeAVup2nwq8rqZQ6Pes/fBJVqX88rfosIB3skwpsnH4CgRPE3TbEC6e0IKsdrv5
         MWRtocPcwZzi0+kO4CQ3K0TYR4yUoQaZ+vgmZpV4m+7X0lPsWBSbQp9KGWQDwqxxTeNa
         CM6VtthyTzDqR7btZmCDi+B96qI8xYdpNQIM1gCnJJJobn3xWvFFeJYMxbOcJqQ6afZA
         cE/nH+lip1VJJri3KkaLZnHqwfK7LrqYQxPqEch0UilKNlek+mK4cGd7PipvSavBLhh+
         FEoZYx1MY/3Vu/1F5ct5bGyIlEl7CflUd/4jXnaWJhZg4PjQuG2b2A3rZyqCreMx75gR
         t7oQ==
X-Gm-Message-State: AOJu0YwfYb8HzqicPmHgvHDifsoRPaixQEdGgCZBg8rs7LyLJSDWT6VB
        tk8ggguUzYgQYwCYghUqdNRzDbO7t2lnsFs6E30=
X-Google-Smtp-Source: AGHT+IG83QhY+pRKk3BmyKEfFMPW4XrmoG6/c8wZ9DRo4O/G68kHGBkfM+q/nfwoojAXScdP2rjxHN46fkRs2UFh+lY=
X-Received: by 2002:a05:6820:1508:b0:590:69cf:d99 with SMTP id
 ay8-20020a056820150800b0059069cf0d99mr1980369oob.3.1701983299115; Thu, 07 Dec
 2023 13:08:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701722991.git.dxu@dxuuu.xyz> <a385991bb4f36133e15d6eacb72ed22a3c02da16.1701722991.git.dxu@dxuuu.xyz>
 <ZXGx7H/Spv634xgX@gauss3.secunet.de>
In-Reply-To: <ZXGx7H/Spv634xgX@gauss3.secunet.de>
From:   Eyal Birger <eyal.birger@gmail.com>
Date:   Thu, 7 Dec 2023 13:08:08 -0800
Message-ID: <CAHsH6GtmhP=hZcf2Qv=21dAOSb5dD4GDa+QYdLFz9_FsCZq6tA@mail.gmail.com>
Subject: Re: [devel-ipsec] [PATCH bpf-next v4 01/10] xfrm: bpf: Move
 xfrm_interface_bpf.c to xfrm_bpf.c
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexei.starovoitov@gmail.com, devel@linux-ipsec.org,
        eddyz87@gmail.com, edumazet@google.com,
        Eyal Birger <eyal@metanetworks.com>, yonghong.song@linux.dev,
        kuba@kernel.org, bpf@vger.kernel.org, pabeni@redhat.com,
        davem@davemloft.net
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

Hi Daniel,

On Thu, Dec 7, 2023 at 3:52=E2=80=AFAM Steffen Klassert via Devel
<devel@linux-ipsec.org> wrote:
>
> On Mon, Dec 04, 2023 at 01:56:21PM -0700, Daniel Xu wrote:
> > This commit moves the contents of xfrm_interface_bpf.c into a new file,
> > xfrm_bpf.c This is in preparation for adding more xfrm kfuncs. We'd lik=
e
> > to keep all the bpf integrations in a single file.

This takes away the nice ability to reload the xfrm interface
related kfuncs when reloading the xfrm interface.

I also find it a little strange that the kfuncs would be available
when the xfrm interface isn't loaded.

So imho it makes sense that these kfuncs would be built
as part of the module and not as part of the core.

Eyal.
