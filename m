Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039FC757931
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjGRKTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjGRKTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:19:43 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAFD135
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:19:42 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-78666994bc2so257772939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689675581; x=1692267581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KnZqAz+ZSbit1NWu+8ZTkLn2QtMaumYJ7wvLcVZXsk=;
        b=BpLje/DqieLKVniRvH64FZjfe0YA6dGh3TrjCJ7miJCSVQRHUUeCaZ4mgsgQnoppU+
         EhTDt+jhE5Ng7zd+Cw4ToyTAxsDkAa3pjhzkm9pyv7Sj+A1/CufNzYMvV3RPez0WKZzs
         IPLDmdcJCxvfH1BNPWEnl20xElYX98Z0vK5sONn4sK61ex5g7bzOodlDap78irMt0tT9
         hWMtYJmFwhnrYHpbrzmBaOYuSGf6syGU5bhtR5nqWO59HyegQz0JPBfikiu8S0INaIn+
         tS6JZ0QO0ebEIw06OC/1oKwZVjw4jVV5d/zGnYu/fne9GGEHo0/nqOOpa8zgyigiNEj4
         qlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689675581; x=1692267581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KnZqAz+ZSbit1NWu+8ZTkLn2QtMaumYJ7wvLcVZXsk=;
        b=jt7IJy1k7AtlHSCoqakb8dSpszUs2rPCh6tDdGVS5Di9b0zZUQzuk/NKznwD8bS0Gn
         L0xq7G0nWhgoEnbRiVe7kvSCYxwmuFbUZknxae9il7MHMzfSrRlMZmScVqx2S+dlS5rk
         kYUKXLzwwvxXdJNF5MTr8KgaGw5AP2KhebSWt97VWIztM1rZBV1Q6IrElsDRdN2Qml2U
         bOganyxxjLgMzMVo1gEjlgme9orZPeywh5SlAA4V0jgx5ZFew/TKdDm/gUdzTEqllhd2
         ypwd8VqTTRAsZBcGgmi/kVMR+zc0yILmBBl/kfdGqwXFgfeSzG49QcLte0MJfAim38cf
         aRJQ==
X-Gm-Message-State: ABy/qLa0zPyA+pNsaT//lUD5hIPNDhaE8K3QQWywHZ6WzNO0qgtLR5rw
        dA3deRY5HPRPilDxLAVCY9nL5Ws3mmREbeUXt2tXKQ==
X-Google-Smtp-Source: APBJJlF8khGgyh8Xqzu55R/sZ5Jp31RmqvsqGAqDckcqYD5jeXA130LRvLCjFYgnhdOSk7ltbIJy806G2OKl7yOSCj4=
X-Received: by 2002:a05:6602:3056:b0:785:cdf7:eaee with SMTP id
 p22-20020a056602305600b00785cdf7eaeemr1941256ioy.12.1689675581608; Tue, 18
 Jul 2023 03:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230717113709.328671-1-glider@google.com> <20230717113709.328671-3-glider@google.com>
 <ZLU8QGuFAGxTpbm8@smile.fi.intel.com>
In-Reply-To: <ZLU8QGuFAGxTpbm8@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 18 Jul 2023 12:19:05 +0200
Message-ID: <CAG_fn=V9RDmybXnsf0j=ENeR6H5Vcjx-AJY0KjNG4EFLJmmUJQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] lib/test_bitmap: add tests for bitmap_{set,get}_value()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 3:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Jul 17, 2023 at 01:37:05PM +0200, Alexander Potapenko wrote:
> > Add basic tests ensuring that values can be added at arbitrary position=
s
> > of the bitmap, including those spanning into the adjacent unsigned
> > longs.
>
> I always in favour of a new test case!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> >
> > ---
> > This patch was previously called
> > "lib/test_bitmap: add tests for bitmap_{set,get}_value_unaligned"
>
> Hint, you may always just link to lore mail archive for easier access and
> handling. Also with `b4` at hand the lore link can be used to resurrect
> a discussion (in case it's needed).

Will add the link in v4
(guess you didn't want it in the final patch description, correct?)
