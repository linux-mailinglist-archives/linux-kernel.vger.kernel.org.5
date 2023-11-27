Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0817FA3FB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjK0PDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjK0PDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:03:08 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C815127
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:03:14 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-db40b699d2bso3810208276.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701097393; x=1701702193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGECS7hQ9z7O8g2r5L0bNaVk88br4ZWd2DQT3SC6LRo=;
        b=Wp7LujTg4LfZcv28YDJaVSs41WopJJg/J6Qck1i6rscY0kQbjdhZVJ87T4vpFYx+Ac
         5h7tvoH/m0bhL66i2ERWzQfQfWzS+0b6CINwRvFLpl5rFVL0zMTVkSnXGrp33N3ObQaP
         hSHctpB4rPCvAemnufqnUb/Z83q9lsqZfJk8SAYc5DDAe+ParZEYZ/wqlFPLx2L82uX1
         v3eRBOcbygh+6p6nDDHLhvliKVw90jLDOiWemuDKWZTOlhNn2cpGi/1zjd9bV5eR8tzY
         wHISyaekBbT/dSCbXM/FaPTHs/p3aCZ5SaY9iL8pJGwQnFDnYXu2RKrAZfHMDMijgj9U
         Ac3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701097393; x=1701702193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGECS7hQ9z7O8g2r5L0bNaVk88br4ZWd2DQT3SC6LRo=;
        b=molnwTB91Xw94Rv5kNF7+sgi3vyggJdImBKU8e9XuaHJApghuS6jrEioRsyCtMchHQ
         F/Jp6SDcJ0NOGsggRnSoim6Pfg6qfqISl2/ekld7xFW0YEQPmFJd4KzGrmK3T/9kjDaW
         XqoqZcG8WITxnXztK25DRNutBsy2j8hjOqYsh2AkGGDypYBijxIak0HGvf6h5VZrHb6a
         MZ3bhPoU9faZQQOb+qr10G61UFLqu5VgEAsqXFM3UF8hKeewAdArTywQfJjmCU4nKwTP
         XvJKWaAoK3n3GuclxBXU58UYMRNguXo+eqx9ZdKqYD8iEiXfgjUUuU4zZ8XGrSedsjvV
         tHTA==
X-Gm-Message-State: AOJu0YwneE3RgmNnKshJ9QEfSlVC14CtrsXvz3Mm7kY5pK+Q8X5Jvmee
        g+f2+KDGwpG07r6jYFpKYIueZNz9ycQHIhi1ecU4
X-Google-Smtp-Source: AGHT+IGWFWX4nZPEY4/r2GM+zJBz8aBYpVp3/NycgX3NsxoWQhG2nQBJqmmnxJUC/Y8LXiDmxbnvm64m3VvefvSfC3s=
X-Received: by 2002:a25:6987:0:b0:db4:158:b9d9 with SMTP id
 e129-20020a256987000000b00db40158b9d9mr12095112ybc.1.1701097392639; Mon, 27
 Nov 2023 07:03:12 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYs6WafDBtSbcLpoyWehQyBPNeX37PvsP6HzSotXr3dYLg@mail.gmail.com>
In-Reply-To: <CA+G9fYs6WafDBtSbcLpoyWehQyBPNeX37PvsP6HzSotXr3dYLg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Nov 2023 10:03:01 -0500
Message-ID: <CAHC9VhRrxX=LcXmLxyMwF6_rZEEYO+5DG_3EaeWsAoVY9CuSXA@mail.gmail.com>
Subject: Re: lsm_list_modules_test.c:104:22: error: 'LSM_ID_IMA' undeclared
 (first use in this function); did you mean 'LSM_ID_YAMA'?
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Casey Schaufler <casey@schaufler-ca.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 5:43=E2=80=AFAM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Following build errors noticed while building selftests lsm tests for x86
> with gcc-13 toolchain on Linux next-20231127 tag.
>
> Build log:
> ------
> selftest/lsm/lsm_list_modules_test
> lsm_list_modules_test.c: In function 'correct_lsm_list_modules':
> lsm_list_modules_test.c:104:22: error: 'LSM_ID_IMA' undeclared (first
> use in this function); did you mean 'LSM_ID_YAMA'?
>   104 |                 case LSM_ID_IMA:
>       |                      ^~~~~~~~~~
>       |                      LSM_ID_YAMA
> lsm_list_modules_test.c:104:22: note: each undeclared identifier is
> reported only once for each function it appears in
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

A fix was posted last week and should be merged this week, lore link below:

https://lore.kernel.org/linux-security-module/20231122160742.109270-2-paul@=
paul-moore.com/

--=20
paul-moore.com
