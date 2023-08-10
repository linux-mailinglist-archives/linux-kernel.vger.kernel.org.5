Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38803777899
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbjHJMgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjHJMgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:36:46 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5454D2127
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:36:46 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bd0911c95dso818412a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691671005; x=1692275805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLVaJVKLV2tg0oYwHA1aDMqXvCf6iBmxhvyfLRwXavw=;
        b=bRvpRZfcix8nR6Phx4mVEJYPLBHGjzdWQ/FvkJRYWNiVr5wyGPvPc8WZ+Hk+mzOY/e
         ehcD84LCv6aU7ErsLf7gaDsS2r5Qlk7pQhsVVWsXGetlhH4Zo+ICm1rWEMe3sBh5CKHd
         UJw2HDPY7HNlgL1O8t0EyrfSN2Hn4UTbewqPNKUeJpFC+x4Y3brDMaxV6rdAwcaPTSVI
         4n/62kTJ8DCv/reORpd4ER+MTrHW9UzzUgHpO6CNrxf5GIxEJLncXShLn+wQazp9VmPb
         NoqYxFpvTtepm9gri+7N5/20fs7CPPwAFQDYkOXKBD5kF3UQz6Yo7mkBYlauCH0KTftU
         iM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691671005; x=1692275805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLVaJVKLV2tg0oYwHA1aDMqXvCf6iBmxhvyfLRwXavw=;
        b=SvP8c973PQJrjknfcHebzGrnN1MKpdde2omxbsrXX1T/j9PjR3JEDN+59gYi9sL2Pc
         oqX+9uDwJxiV4HefWZvCTrFN6KeFnQShPV1jMokJIvaVvjtBSRHX0/a8iYz7rdlO+a8T
         1Nmy6jfP3NHdA46M5nsPhKjavTCD6NU5HkmptOViGCpV9nDzqu6bidWE25Ur/Mad5Khg
         ChXw0Ol3mZJROi6Zs7KAG4DvFIl7ltCIoKoDTtJHGPZmbMoEIDaZL+Q3tC3DFUIptC7C
         qiQmK9qQ2vQUVgT2LZV88UKvUrHE7C4pbDcIFvT4udIa4boOcB5vDXFqDU70gtaXhvFS
         OPeg==
X-Gm-Message-State: AOJu0YzvdZAwmZm4IZ+PhLqIdtxYYCTNARofwS/zVudHi8bMgVnR7ZYr
        Z3ne4ux8Weog8RqWkMznlsdwFBZXxfppJmrUtHtMJQG9
X-Google-Smtp-Source: AGHT+IESPRqcz6Ns0gwS8HCvUyjT486543qBEs6B1TO8cWkvG2fI9kIbEduMhDw+NIQy2ucM9I98eE+VNiFv2AImZH4=
X-Received: by 2002:a9d:7e82:0:b0:6b9:67e4:eba7 with SMTP id
 m2-20020a9d7e82000000b006b967e4eba7mr2590930otp.23.1691671005560; Thu, 10 Aug
 2023 05:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230810123404.1222332-1-arnd@kernel.org>
In-Reply-To: <20230810123404.1222332-1-arnd@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 10 Aug 2023 05:36:34 -0700
Message-ID: <CAMo8Bf+QRMsSELvZndfDz+JNPNkYAsg2wSvtiyWyVKJQQ-tZOA@mail.gmail.com>
Subject: Re: [PATCH 1/3] irqchip: xtensa-pic: include header for xtensa_pic_init_legacy()
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org
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

On Thu, Aug 10, 2023 at 5:34=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The declaration for this function is not included, which leads to a harml=
ess warning:
>
> drivers/irqchip/irq-xtensa-pic.c:91:12: error: no previous prototype for =
'xtensa_pic_init_legacy' [-Werror=3Dmissing-prototypes]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/irqchip/irq-xtensa-pic.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
