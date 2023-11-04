Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200F17E0E9B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 10:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjKDJb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 05:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjKDJb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 05:31:57 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857A41BC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 02:31:54 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-586753b0ab0so1493615eaf.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 02:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699090314; x=1699695114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEOeKmfbASkra2W4jNK3PMNKAWiWNXvajiTJylEOdMA=;
        b=gR3jDaKMKlUeEjt12P3DZmb0HLxkZN3c07NOg+uTExnZY7mPZU/zukoeaOmCMFza1E
         MJx1h9w275XDTlVH9I69qv+vyXBMsWVZheDAqaTCPBNiO+hIxbFl0+8MDjpVoto75eNh
         Bn2zxAHdnqp0gh/X+8vv6GsP30obSv5UF77IHQ/2pqAKSBPZatsS92r/uShpk5CVVkIE
         xlHuuL5dqGIeccgPMxXTZqs2SFhE7xjCOauT010BYQvElVRmZg9otduOk0iHypOpg1Ne
         QXHbVGjD5OVGYjg/3moFDbDtNWhJRuK5sf+JdLoUlqot8EJvoitN/A1UMWfHwo2/xRvS
         nw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699090314; x=1699695114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEOeKmfbASkra2W4jNK3PMNKAWiWNXvajiTJylEOdMA=;
        b=lw/xU0ujwj/c7bIokAtITpTwTsVRxs+sxLggKJyXkkevcqeRHSWwysIzwnZhY6CdRx
         +fj+QIl4CQRSfixn9PRdZoEu54rhBlSKkF7fy4K98vK37BBvsdXU9AT3AZoUt+ocVL2Q
         l0mkIAdn1SEmb8ndjIGXXb/xUNgH3w4QCVn8SXozDj1DPy7n+bQxESJxUvwaTpsjPB84
         vgg7EKfNZefMsCqyL1i2DK3lMQO03yFRwU2dgl5NiHbVo9c8czLT7Ug3Q/Db7OAlTVfV
         f1eOhjhoxot4V9BioZa1d/FhyeV+T42IslB4Vqi+Ti34n2I2Z7y9orLNgX6rqe6kawqo
         fj0w==
X-Gm-Message-State: AOJu0YyKzss7j3U63DUOmU7B1Ep1N42+swy5tIgPvq+kAlmQqPASEVXY
        Qvu+KNwW9SEYRlueKYAfXQ4wFide24t8LcNGFLs=
X-Google-Smtp-Source: AGHT+IFYxuPz9CvSNapWXTCgRjgBZp9C8l/Pgsq9lqW/wK/OwhdS4iuOdc0Lc+52SEBTBj44i73lqeBCIU4endx0yXk=
X-Received: by 2002:a05:6358:52c8:b0:169:a814:5ce6 with SMTP id
 z8-20020a05635852c800b00169a8145ce6mr11597762rwz.14.1699090313688; Sat, 04
 Nov 2023 02:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231104090603.4253-1-wuqiang.matt@bytedance.com>
In-Reply-To: <20231104090603.4253-1-wuqiang.matt@bytedance.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sat, 4 Nov 2023 02:31:42 -0700
Message-ID: <CAMo8BfK4zDfdh9-WLq+gg1B47ht5hxhvH_j5veEj6JG38meTuw@mail.gmail.com>
Subject: Re: [PATCH v1] locking/atomic: xtensa: define arch_cmpxchg_local as __cmpxchg_local
To:     "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc:     chris@zankel.net, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, palmer@rivosinc.com, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, mattwu@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 4, 2023 at 2:06=E2=80=AFAM wuqiang.matt <wuqiang.matt@bytedance=
.com> wrote:
>
> The xtensa architecture already has __cmpxchg_local defined upon the
> native __cmpxchg_u32 and __generic_cmpxchg_local

This description does not make clear why this change is needed. Could you
please expand it to cover the 'why' part?

> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
> ---
>  arch/xtensa/include/asm/cmpxchg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/=
cmpxchg.h
> index 675a11ea8de7..956c9925df1c 100644
> --- a/arch/xtensa/include/asm/cmpxchg.h
> +++ b/arch/xtensa/include/asm/cmpxchg.h
> @@ -108,7 +108,7 @@ static inline unsigned long __cmpxchg_local(volatile =
void *ptr,
>   * them available.
>   */
>  #define arch_cmpxchg_local(ptr, o, n)                                   =
      \
> -       ((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr), (unsigned lon=
g)(o),\
> +       ((__typeof__(*(ptr)))__cmpxchg_local((ptr), (unsigned long)(o),  =
      \
>                         (unsigned long)(n), sizeof(*(ptr))))
>  #define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr),=
 (o), (n))
>  #define arch_cmpxchg64(ptr, o, n)    arch_cmpxchg64_local((ptr), (o), (n=
))
> --
> 2.40.1
>


--=20
Thanks.
-- Max
