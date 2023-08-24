Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977CD7879BD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243600AbjHXUzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243608AbjHXUzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:55:16 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDE31BC2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:55:14 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4109d468ca9so1159761cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692910514; x=1693515314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9veUMJ/z882K9hkHEmh4pAoTDmJO4VmWvc8gTfMi6Q=;
        b=cNir2zO4Jw1bY15AO+BvLzyudCZQgZOZ6wmKu3gTiOE6O5d8uld/TL1ezLjaI6QYbm
         WOGGPHYDU/pK4dxlnF7Ms+FTC/sMRd3w0UHs5vWl7Ok8xxNThnUi40LTsEqvRgt612yt
         78aWAjEVTurY9yP/vzKIVztJ70N6XuOBe4TzTTYoIN4ZaN51LMOSChOtgvQbcVaqgblP
         cXZz8KRbjOvTDGzMC8MqwpETfoHXd3UWkIm9s5iVgENo6DP/sbX4cOh9u7J1okj8PlZZ
         BokMSSDN911JlFclyP8hVqyb+sA6fCfvwhQTmJ3jDmPDMIreFp+riuf57qJzWHHRcB6x
         9FPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692910514; x=1693515314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9veUMJ/z882K9hkHEmh4pAoTDmJO4VmWvc8gTfMi6Q=;
        b=QmxYgDK3opDJdAejt1BHZ7orxtzhNS4psLNavkZYkXE+LOYc0D6BP6GWh8AqbQ7eOD
         4/dqio+b01SriYzT8BlpWfzbYdtCOkCCaMp56lSt256IwdKd2tXSy2rrv2HyR69cdXi9
         4En9vB1VihCqjR/WBL/SlbxyxPqCtdDu8HDnDK1u6sOi40c5LCpHNFdpSM4B1VEzLSNA
         tZRulJ6vnBRxBB1DjaWmZaZNWKVo9RQDsMvpUtM+ZazEgB28ChqU6d2vzQnxHsNRqdGx
         CuPzM9pSbBFTdj5hP+23X2wSv5PpMmGJvrF6JIx47l2hIh0S1E7KJmx5nxj6FQ3C2qbX
         FAIA==
X-Gm-Message-State: AOJu0Yz072vUoqaZ/tmS46WfkWIKiQXdd4dR1oi58PbIFaZE95JwFdY7
        ouqgmmRD0tTeCsywzmkfqXvnnzyCz4ZeuaV86zeicg==
X-Google-Smtp-Source: AGHT+IGp1K8B09Bdl+oZ3RkqbVetgjSDMnQuEIy2o3NTYbqmOnwJtltpQ9JU5CwHn6kcCYZRMLaYXjyuarXlr9l4qDA=
X-Received: by 2002:a0c:e2ca:0:b0:64f:3b07:c50a with SMTP id
 t10-20020a0ce2ca000000b0064f3b07c50amr13629295qvl.58.1692910513818; Thu, 24
 Aug 2023 13:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230824-docs-v1-1-67e061278b8f@google.com> <20230824184910.GA2015748@dev-arch.thelio-3990X>
In-Reply-To: <20230824184910.GA2015748@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 24 Aug 2023 13:55:03 -0700
Message-ID: <CAKwvOdkas2gmcyVKSp0DSXC56jxUB1HW8XRYKVBfS0sz3MSi5w@mail.gmail.com>
Subject: Re: [PATCH] Documentation/llvm: refresh docs
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, Tom Rix <trix@redhat.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 11:49=E2=80=AFAM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> On Thu, Aug 24, 2023 at 11:03:17AM -0700, ndesaulniers@google.com wrote:
> > -We provide prebuilt stable versions of LLVM on `kernel.org <https://ke=
rnel.org/pub/tools/llvm/>`_.
> > -Below are links that may be useful for building LLVM from source or pr=
ocuring
> > -it through a distribution's package manager.
> > +We provide prebuilt stable versions of LLVM on `kernel.org
> > +<https://kernel.org/pub/tools/llvm/>`_. These have been optimized with=
 profile
> > +data for building Linux kernels. Below are links that may be useful fo=
r
>
> Maybe make a note of why this matters? ", which should lower kernel
> build times compared to non-optimized LLVM toolchains."?

Oh, I forgot to address this in v2. Will send a v3.

--=20
Thanks,
~Nick Desaulniers
