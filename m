Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685CD7FD36A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjK2J7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjK2J7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:59:22 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC9E1990
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:59:29 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2860f7942b0so1071620a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701251968; x=1701856768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pqia/2NzpbZY9qiZNmg2ovJTePTSQvWT73Ob6arAPV4=;
        b=IAq15ZQnUdZkr9x52XIHnOBk4rDNJIZUEFwksySXjNFgcddo7L0b44xSPS1or2Eiq4
         7ME81yNUskoGefxRSA19S/NjVpNs7J0uV+wNhN45Qv3TMzYjZv3jUQt1lWRQBS4/leu/
         FdD+1JLKZZyBDXZj9/CWmRFGl5E/jeU+J7L4Z0Q8zgg/tlDYlouacfiELVAh5aBAXAwF
         GkLvR4s9c08CG8l1awNVMMK3RYLm/OM1gS75qhJxvfhBvDNlcc0kTLtpIkyi2W1mVXiJ
         9DTQROmSnJ4mfu6lqcBn3xL1mDWkpMk7OrcKbkIYWxwn34N9S0pPiJRm0wANYworwTZP
         sRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701251968; x=1701856768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pqia/2NzpbZY9qiZNmg2ovJTePTSQvWT73Ob6arAPV4=;
        b=ku2nObsBMGRjuP253k3Ev5NLx9sxgfCTitvZ2d52E/dETvsO3Wf489ixlqZejsxfFi
         Vw3TR8IdbRShQ5s81l9gGG84d9E60rhadzZMBwkiLA0asJ36URDzrg0eQNBsmK9QQJyn
         QQgh6pVlSfYbJ8gXNYVZxh6G89u+RyAi6TaiyL13E1wzBRwSR3di3k4APDG/WiF7t12i
         lO3RMJ0h5citLsHRAeViXoC1dEzg3u4a+E1L86wqSFJZ/ZwWJew5uiz7nnYOJMSJRZcF
         5TjzH4ERDuBSwXDW5jsKWWD1qyD2J02sA2Z8E1xhiKH3FEqs7Kys1EdsSV/ZSv5PE+z1
         Eggw==
X-Gm-Message-State: AOJu0YwjtRlyUTOYkEJc0xKmvEh5gayxNM7vJIUT5ytpTLXBvxtZYY/I
        0zcq0avuuTsTVvsm5TbyP/dGgZ8jDyzYeKg86Nc=
X-Google-Smtp-Source: AGHT+IGVQZAjvlYII0VIC+bH8Gz1vLtNOlHFxMAS73O0Ff6RQUBhXE6Cgf3qGJ87IMNcMZZxw+p/bDi1Fm5WU+2E7uk=
X-Received: by 2002:a17:90a:e7cf:b0:280:215e:7ae2 with SMTP id
 kb15-20020a17090ae7cf00b00280215e7ae2mr21095545pjb.2.1701251968521; Wed, 29
 Nov 2023 01:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20231126151222.1556761-1-masahiroy@kernel.org>
In-Reply-To: <20231126151222.1556761-1-masahiroy@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 29 Nov 2023 01:59:17 -0800
Message-ID: <CAMo8BfLXVXsGp+UU-bypGM5-X--XE=AMeVeGCKwJqGqBywmKFw@mail.gmail.com>
Subject: Re: [PATCH] xtensa: replace <asm-generic/export.h> with <linux/export.h>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 7:12=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
> deprecated <asm-generic/export.h>, which is now a wrapper of
> <linux/export.h>.
>
> Replace #include <asm-generic/export.h> with #include <linux/export.h>.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/xtensa/include/asm/asmmacro.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks. Applied to my xtensa tree.

--=20
Thanks.
-- Max
