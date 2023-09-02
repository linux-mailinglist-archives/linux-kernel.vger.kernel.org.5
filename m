Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089C37905CC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 09:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351735AbjIBHh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 03:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbjIBHh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 03:37:28 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93C290
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 00:37:25 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-414b802a399so6591cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 00:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693640245; x=1694245045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGzJAOBv39wC+eBwHXRCdW6LDCDBMBeVwYp5p5ZAHp4=;
        b=cHiAt8u0yxeVemDZcNHcIo1a1hbPymDF7Rklnp5uO0z0Ck7zAdHHX4Sl3QuQs9lo/a
         C9zVBBth3J4oWj0i0xTkZGdxbSymV/q4ageQHqesI4wRWRsG9vaJPCZOp9sjz/5lWazP
         hkQn9R6QG74xPyWXxXBROSG4qHbIxIYVWOqCgzAx919VHRKRHl+hJXgqzvQgr/+j2bqi
         E25dsc9B3mEX+zWxjQ1IAj7Lnd1tpkUPrFpR0nKQBYE8lVZGXOmjow3SOUXhlvGnhQs2
         0rEflR1vQzkckskdyJSGytDhroKM3Z1R0VvSKPft4AwCMxoQkjt4iMzBcQS9hD8GMVyT
         t26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693640245; x=1694245045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGzJAOBv39wC+eBwHXRCdW6LDCDBMBeVwYp5p5ZAHp4=;
        b=Dyfq5JcQyAqYPoXYErzALKWukkm4TPloKJOnLEIrYgoG+iRkWcZeczz4QCvGxC0UTO
         XIoe6FLrB8tuukt79yT+v4AzamAu1TciG0ApVoNCsCRWCvEn9ZSLHZYeMktKymdfk2Zg
         p62TiD7YwoD16eAc1KVnFpBuE6IikG20EqrkRd5v2TIq64oPeDU6mP66GTU0Rx3cl2X/
         KSBBCMK9fdWexxzgOzljgz90SxokxFhMI3WalMu8gh+nnjsbXRlFW2xpP0EXV7wQanPe
         GbK87uygphcL39XcXXl9f6zp1/GGo104OL6t9UeJltpEuSb8V+ukpG6C69RbXRw4+NnU
         9GSw==
X-Gm-Message-State: AOJu0YxzRH2/g6Q2DZpkhkV6bY7ZU43Bf7wQk81aRLhTVMd4ktnSmJ45
        OY+AUmLeLwMoybiKr5wMEfdsPs0rUfJFjWyFajPvxzWz2j1l5IB2kDs=
X-Google-Smtp-Source: AGHT+IElCtXsEuqc1xIgnbAqRpIeaZJHksxJD/VhGd3OpQEYv8Tb+4JLhJvWWlP8G9VUHoqJzbp8NIqn7VYR3Qykng4=
X-Received: by 2002:a05:622a:c6:b0:403:b1d0:2f0a with SMTP id
 p6-20020a05622a00c600b00403b1d02f0amr142084qtw.28.1693640244542; Sat, 02 Sep
 2023 00:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230902071631.204529-1-renmingshuai@huawei.com>
In-Reply-To: <20230902071631.204529-1-renmingshuai@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 2 Sep 2023 09:37:13 +0200
Message-ID: <CANn89iJ2aFYjQp639O6mDj7vhiNV5w_EVsMxM2jQGBHfHbOtOQ@mail.gmail.com>
Subject: Re: net/sched: Discuss about adding a new kernel parameter to set the
 default value of flow_limit
To:     r30009329 <renmingshuai@huawei.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, davem@davemloft.net,
        jiri@resnulli.us, yanan@huawei.com, liaichun@huawei.com,
        chenzhen126@huawei.com
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

On Sat, Sep 2, 2023 at 9:16=E2=80=AFAM r30009329 <renmingshuai@huawei.com> =
wrote:
>
> How about adding a new kernel parameter to set the default value of flow_=
limit
>  when the default qidsc is set to fq? Although We can use the tc to modif=
y the
>  default value of flow_limit, it is more convenient to use a kernel param=
eter to
>  set the default value, especially in scenarios where the tc command is
>  inconvenient or cannot be used.

Hmm, can you define 'inconvenient' ?
It seems to be an issue with the tool or the toolchain ?
The 'cannot be used' argument seems strange to me.
If I understand correctly, you want a generic mechanism for all qdisc
default parameters,
in case the 'default qdisc' is XXX instead of pfifo_fast.

kernel parameters should be reserved to specific cases when
programmers have no other way.

rtnetlink is the way to go really, sorry !
