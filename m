Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB93A756958
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjGQQju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjGQQjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:39:49 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43761188;
        Mon, 17 Jul 2023 09:39:48 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso4756546276.2;
        Mon, 17 Jul 2023 09:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689611987; x=1692203987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dep2ufCvsTVWnMw4J18S4qsT64DKZiebtvC9dmtZjCI=;
        b=CTAwiBDqQy9GtRwb/HdB54PXCB7VeOHU13p+1RZAFQYCgnrLM9v6KG0mgnnDshZRIx
         BwR6MXcslMCYk4upruZVAzZmw7xGmkYUdVlZeIOc11ME3Y8NcsEs7z2B3NbYaQcKQF90
         IYWe2jqa/XYYx9HVv7RY76RMdHb/XqQgYG0dF/DXthLFI4XyA3Novy9+iihQlk/Ay+Fp
         Uts0MBbvGkC4JVpWqyZ4yAjY4A50twv3xHqu2JFZZXjMqnCly1Dd1N+7tc4fmpU2BJ3s
         pFCAqT3ZtHLsIs/KGeYpk7zfmlmhZoO1QFEMsyrMoMZ2eRA4IR3LpA6VXJ/qLDg+SbqJ
         iWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689611987; x=1692203987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dep2ufCvsTVWnMw4J18S4qsT64DKZiebtvC9dmtZjCI=;
        b=iR4U0tvsqJk45XxZUPN/2Cq5tfW9+OSM0Xg4R2u99GJLxmiHg2FY3wi4oflMPhXZwU
         1407in/pJWJTmUwp8vrHuZoS5ERNIttX86Y6PVAzo9Sp7293R+BYLmsczesbvQvtS/3S
         3GHNwIc6hUbKwgb+mCJHP5PHggvCGegnEyRz58gx8bg0xIpwBMNDWMGZ+5MgID7Q1mee
         b2UY/oO380C1B1rLsphG8gotwyptvFJaxRsz9vj1fXBoXEewtMRjlrKGm7yDjvulZI0n
         jgKEQT7r0H7cUrAio/J5cmsMNiwZ0GT5pMJ4RrYnPmP/IceYBV7MZeyHzs7qNGUBcGSb
         iSUQ==
X-Gm-Message-State: ABy/qLZHOWE2m4apyqQk27tEwICyk/4rjoO4d1ifngK3x2ZD4Hk9PA6A
        LG8nYw6MT6BP6kCGb0xww6d+Unm+5r9vaMCFDaU=
X-Google-Smtp-Source: APBJJlEEvlRpBI8q1JHQaPw9F5g/vpoqEDpZwHC11S2jW6Ls7+rdJ8O1FOoLqF+V5ULw3yEAQranp12fDnRdCFu8BKk=
X-Received: by 2002:a25:db88:0:b0:cce:6b3a:3815 with SMTP id
 g130-20020a25db88000000b00cce6b3a3815mr4959215ybf.47.1689611987440; Mon, 17
 Jul 2023 09:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230717151624.3470714-1-carlos.bilbao@amd.com> <20230717151624.3470714-3-carlos.bilbao@amd.com>
In-Reply-To: <20230717151624.3470714-3-carlos.bilbao@amd.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 17 Jul 2023 18:39:36 +0200
Message-ID: <CANiq72=jiEqYfEvcRAxXsm1BCODnpxmWZOmbGB_YwM=pUGYEeA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] docs: Integrate rustdoc generation into htmldocs
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, ojeda@kernel.org, jani.nikula@linux.intel.com,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, konstantin@linuxfoundation.org,
        Akira Yokosawa <akiyks@gmail.com>
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

On Mon, Jul 17, 2023 at 5:17=E2=80=AFPM Carlos Bilbao <carlos.bilbao@amd.co=
m> wrote:
>
> +       # Let Sphinx know we will include rustdoc
> +       ALLSPHINXOPTS   +=3D  -t rustdoc

This is needed in the previous patch, no? I don't know if it fails or
just does not work, but either way, perhaps you can split that from
the first commit to put it last.

> +else
> +       @echo "   Skipping Rust documentation since CONFIG_RUST is not y.=
"
> +endif

Is this printed for everybody? If so, then I think it is a good idea
for the future, but perhaps a bit annoying right for most users right
now.

Cheers,
Miguel
