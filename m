Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF0880E58A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345949AbjLLIJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjLLIJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:09:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45069B8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:09:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5770C433C9;
        Tue, 12 Dec 2023 08:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702368598;
        bh=DZOkSoIr87VtnL1V3GfRTuV5FLX7wYkz5v52z+Xj/u0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nO7P7OnJpk8fbinPF/P1b0+FRIrOevhyKinqt/1glfvcrdcHxDkrqgqv51zbm5trj
         Hq5l5FnvTLUg7zIiSdAcare6KUYH44xLORWad8KNyk1uTBIAeZXesqjmLwm+e2lVnl
         VKQiQ/TXQPuVpDU9s6hy+Az9ajOgHa2dV7yP1NqgWphMXV0o8Uo7vWgHRqhLjT51YR
         YZGYdsYWh8sLOS8K4BZgcRC0oBA4EDw2VMc9UwyU7G6jMmm2mCDN4od2rqWBbmWVTo
         DGgUy2zP4VthQ30vgXJTKS+HkDLL/3Mqblfu7dmTCIP6AkFss+ycB3B4Sr9YQn6YwH
         n51PI7pDw0c8g==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-202c4368762so1332933fac.2;
        Tue, 12 Dec 2023 00:09:58 -0800 (PST)
X-Gm-Message-State: AOJu0YxSqhUAnPIMCBIf5q2ONB+kOcqTnd1PHmG4tmR1tSiY8ud5e6Mk
        lWYP92QDSbegCmkhXyH5/mkXzEPpqb/1kW70+2c=
X-Google-Smtp-Source: AGHT+IFw/p6xKvOm4GvGvxSXnYJ6nT+UwE1PSX6srErUMKGirtjMDCPjf8dTtBWbeDBvzsP9VdTidyWzC8q1b3M4/rE=
X-Received: by 2002:a05:6870:818c:b0:1fb:75b:1315 with SMTP id
 k12-20020a056870818c00b001fb075b1315mr7449288oae.103.1702368598334; Tue, 12
 Dec 2023 00:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20231208181802.88528-3-leobras@redhat.com> <ZXgMa57Ere6FJCJB@infradead.org>
In-Reply-To: <ZXgMa57Ere6FJCJB@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 12 Dec 2023 17:09:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQiJW0eFYQZN0wuURhrdc-8y7=TcEazpxhLf=+mRbKHHQ@mail.gmail.com>
Message-ID: <CAK7LNAQiJW0eFYQZN0wuURhrdc-8y7=TcEazpxhLf=+mRbKHHQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/1] scripts: Introduce a default git.orderFile
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Leonardo Bras <leobras@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 4:32=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> Urrg, hell no.  Alphabetic order is the only one allowing sensible
> searching.  If you have a different preference use your local .gitconfig
> instead of enforcing completely random preference on others.



Unlike .gitignore, this feature is opt-in rather than enforced.

To use this, you need to run

'git config diff.orderFile scripts/git.orderFile'

or

'git diff -C scripts/git.orderFile'



Indeed, the file order is subjective, leaving
us a question "do we need it in upstream"?

At least, it is harmless for people who have no interest.


--
Best Regards
Masahiro Yamada
