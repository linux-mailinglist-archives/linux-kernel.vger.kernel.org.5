Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D371E7A7BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbjITLzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbjITLzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:55:00 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E75B9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:54:54 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-27489f78e52so4174458a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695210893; x=1695815693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SegRVwPy3T4Drw15gY3BMKb819flE9DBZjuEZxE8SHs=;
        b=EWhMsdHWucBVDP6vYIJi7x5xeVFxktef3umE8wh6qmv0G/tS9y8bXkqN+vb2Gr6UW4
         dhrjH8H2j8eK0ImLK87wN0tWWYEiXNugYzBtzlVkVQVVyUSrpcRVKG+nHOGNfCNv/Tzp
         3Z5/GF3uft9SSDZoz4TIpEeI/l0Kme7iRV4V/DTvE34TAwKGnaKvaHn7Ow1t/2E5VpFk
         fyb0fa29Jin/v3QPj+IEQZbC7izTlFe5apnZH11nGRV9IHFshQG9kcN9NpQJRHo+JxiY
         S61ztzHVzidvStsviZ+vAQVgwxogQTxkn3FasXUqpEdLUOkWC8w8Ns3O8ZbjGmEdkCRT
         Qc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695210893; x=1695815693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SegRVwPy3T4Drw15gY3BMKb819flE9DBZjuEZxE8SHs=;
        b=t4Psobqg4jKQRLx3PFpw0cS+BIPg4V+Ykt0uEsAjmKhrjXUuWEh2WAjXYe9VjSJ4fQ
         t2CjDdbp8ddaW3iJTkM83qHRYnR6KvIH6R+JiE5OQh2HoesuVqUoe60YBTVEkBFEfBHs
         TZrzkl7E542Aso9ABBW6HSEk5OJG/FiN0juvVlPrdom/KW316WQn/IKuCONsuH44Bl0u
         Nnp3fbtXa1QP7kOPZhpDcZmupLHf9ippDmfamAROBYbQGfMJe90yBr8SUDzfi8LbYBy/
         GZokps8u4SzRMlgVIO3/WOZPBf7Vr8P1xqJlmSyZvN0g+AqspeFkcMl62vMQ38KXA0ds
         ZNlQ==
X-Gm-Message-State: AOJu0YwcMWtSmvAdaVPvygx65XwBYgTMWFFot7aqUdMk0uRT9UgGQVzR
        Uv5yxmcUcxWd11EHapphZD5PkKd+OmHMm9MsWTc=
X-Google-Smtp-Source: AGHT+IE/BPHXLd4hag8jyMe1TlVptfK/q3aIbYRMWRAaeP6MW4nEzvtIV/IzRcxvcUw6u95E0EjbzIXNtCWp5VkSodM=
X-Received: by 2002:a17:90a:de8a:b0:274:4fb:3610 with SMTP id
 n10-20020a17090ade8a00b0027404fb3610mr2363065pjv.47.1695210893556; Wed, 20
 Sep 2023 04:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230920052139.10570-1-rdunlap@infradead.org> <20230920052139.10570-17-rdunlap@infradead.org>
In-Reply-To: <20230920052139.10570-17-rdunlap@infradead.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 20 Sep 2023 04:54:42 -0700
Message-ID: <CAMo8Bf+UpPzHd_Dc-236sMRcGZ6ynwG3mY-7NCtApbLdzvjsNw@mail.gmail.com>
Subject: Re: [PATCH 16/16] xtensa: boot/lib: add missing prototypes for functions
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 10:21=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Add function prototypes for exit(), zalloc(), and gunzip() to the
> boot library code.

exit() and zalloc() don't need to be public. I've posted a different fix th=
at
makes these two functions static.


> arch/xtensa/boot/lib/zmem.c:8:6: warning: no previous prototype for 'exit=
' [-Wmissing-prototypes]
>     8 | void exit (void)
> arch/xtensa/boot/lib/zmem.c:13:7: warning: no previous prototype for 'zal=
loc' [-Wmissing-prototypes]
>    13 | void *zalloc(unsigned size)
> arch/xtensa/boot/lib/zmem.c:35:6: warning: no previous prototype for 'gun=
zip' [-Wmissing-prototypes]
>    35 | void gunzip (void *dst, int dstlen, unsigned char *src, int *lenp=
)
>
> Fixes: 4bedea945451 ("xtensa: Architecture support for Tensilica Xtensa P=
art 2")
> Fixes: e7d163f76665 ("xtensa: Removed local copy of zlib and fixed O=3D s=
upport")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  arch/xtensa/boot/lib/zmem.c |    4 ++++
>  1 file changed, 4 insertions(+)

--=20
Thanks.
-- Max
