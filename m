Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C22F7A7B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbjITLxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbjITLxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:53:23 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0B692
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:53:17 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5789de5c677so2038731a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695210797; x=1695815597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUnxZNH0dOlLHPQB9Zz2zvwD5zJY9wSryj3LYDqZfxo=;
        b=J0KaFsfnkmB5CmNPqu8PfENsG6fJo9uXqtNvVyIxjC03Exi5Upy7upFdbFvSlZi0jy
         WDfKnas/YZ2b+wcOvjUWcUZV6ASxw4nkEfVlG7HSXhlXlUwY3avxtgvMGnAEh4vC2VNB
         dd3tEJHspe7muWf+IvbOJhONwQQva6amkp6xY/L0Q/Ol4dC4p1x0F5C8SxEKcjqHmhJp
         O9xVGwdLt1B1TBHIUfwGDI6IC0y/GJ9j6gTLkly8UDkAVUHOxzvnZBUSiIfvVe1JpHY0
         lugBRklqTxiwxYUQOyajUdh8wW3dczvfAOgIEfQOB7hJzOQHizPCsnAr4kuk863NYnQc
         w6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695210797; x=1695815597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUnxZNH0dOlLHPQB9Zz2zvwD5zJY9wSryj3LYDqZfxo=;
        b=vs11PIiMbF/fnYY11zakBtFrxnf1X50tb+lxEtYu5wRQZtCORXdqE5zJ0DMTDhH9XJ
         q/oNrU4yBJ5ChysDWo6JL4m7PXGKqx4gMykNe3GAgJ9g4W8bxorZqLiPYc1R11INiYjZ
         AyPEkrZi47xo6XdmplfohBf5XB9L+r3Xe7dn7vbEda+NXqFkoqdXHSLPJGp9BPgzXONX
         HdXY/mHhBfKWUeG7KlHId9n4MoQogc139eQ2WWBYfGVaNfA4oclSmxBs80tL0giQOV6D
         e5ZVtAdfTPGPui0ptWw8nbAFM7h65dHM3s3PTz+pATe8C7IVuN99oYirjs36MiK5IvfM
         C/bA==
X-Gm-Message-State: AOJu0Yz8eBqycdkCWmyVF6JjWvSiVAGpBPJ5WtHP8NFqk3dYC90i4eVT
        Z1ORWcJ9sEDu7f7dl1NP4Q3nSHf8/wdeSX85zQI=
X-Google-Smtp-Source: AGHT+IGz5wWSPTM/J3WojDjpiCRtNNQHcZVwNPhOZHdi8IAF1iNFD4Smr+yYmu41WmG2tPmTam4WNX3R82mg4+F+9rA=
X-Received: by 2002:a17:90a:f815:b0:26b:6a2f:7d90 with SMTP id
 ij21-20020a17090af81500b0026b6a2f7d90mr2405287pjb.23.1695210797252; Wed, 20
 Sep 2023 04:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230920052139.10570-1-rdunlap@infradead.org> <20230920052139.10570-2-rdunlap@infradead.org>
In-Reply-To: <20230920052139.10570-2-rdunlap@infradead.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 20 Sep 2023 04:53:05 -0700
Message-ID: <CAMo8BfJs-yygU8UbS5nsSNVVVRVhJMvXAcgScNAX9NNP6tt4Eg@mail.gmail.com>
Subject: Re: [PATCH 01/16] xtensa: FSF: define XCHAL_HAVE_DIV32
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Chris Zankel <chris@zankel.net>
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
> When variant FSF is set, XCHAL_HAVE_DIV32 is not defined,
> so add the define for FSF to prevent build warnings:
>
> arch/xtensa/lib/divsi3.S:9:5: warning: "XCHAL_HAVE_DIV32" is not defined,=
 evaluates to 0 [-Wundef]
>     9 | #if XCHAL_HAVE_DIV32
> arch/xtensa/lib/modsi3.S:9:5: warning: "XCHAL_HAVE_DIV32" is not defined,=
 evaluates to 0 [-Wundef]
>     9 | #if XCHAL_HAVE_DIV32
>
> Fixes: 173d6681380a ("xtensa: remove extra header files")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: lore.kernel.org/r/202309150556.t0yCdv3g-lkp@intel.com
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  arch/xtensa/variants/fsf/include/variant/core.h |    1 +
>  1 file changed, 1 insertion(+)

If this configuration overlay doesn't define that macro then other
configurations
from that era may have similar issue. I've posted a different fix that
adds a default
definition for XCHAL_HAVE_DIV32 to asm/core.h instead.

--=20
Thanks.
-- Max
