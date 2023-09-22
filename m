Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5387AAABE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjIVHt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjIVHtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:49:25 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1097180
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:49:18 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77410032cedso77725285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695368958; x=1695973758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUuGltXQmMiQtfNhApo3EnwtrJAemOB14iW5oMwn1Ng=;
        b=mOHJsfI9brsViLZsgbKHQ3sPZU2fNpDKlwI9ekZJYBa8ga2kSJOHT3WVc5xvjoGMr3
         JkbfIZfg6LxN5dGwOlACd+hNeYyUo4UL9rZb3+MDEhT/fHXJ8++pCoSuS52+C9Q0nN/U
         PiYbg86Wd+aH+mAP7PE74VuUQL1jWZ8iaWc39MR3ZeUlEeP//vcC8mhrqgCVBxfhlV/5
         Jzw4Yp+ZhxUcGyGEJRsUaiuPg+M0HG1fZYg/RdsBKztVngagmBTLOCi7cbbFnZknYbBP
         6YTAjdlqM3Zf0J2kQBp1GYka2IKg9kZW3Ke+ZqoiwHDoDDqAiloqmPxquqkC9WuFxQl4
         7t6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695368958; x=1695973758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUuGltXQmMiQtfNhApo3EnwtrJAemOB14iW5oMwn1Ng=;
        b=YM4S/Hw4hbgTVAn4W4X6DrhlSD43O8CJgreJ9aBrnhg4GQOorPTGqdV1NR09vXO4l2
         qf6MLDFtd0hrJSDjYSZ8fcSSZjFJw3LaUaTj9UOvUmS7IX5waEMBu22/99cSru5e6x0o
         OsDxwYHvdPqQ/8L/W44Rb8I18L02Rx7gETKXuvQWggyvHm8RJuCS/1Kdfvbz10vDoi0B
         gc6kSE2ZrCh3G4vXJy0Uo0GWzJZdW/dnXnnnhjJdjcaPzeGo6HdGyi29X4/xSJ63Xd5C
         jLQ3Wbwt9UB/vYbyhe5k3lQjf0F3JCemS5D/IyqLDxRwBOVZpjSBxj/rPKszSDfoOZxr
         Hq9g==
X-Gm-Message-State: AOJu0YzDhO24nY8V9JOWTTH+hdKFDPTi+v909d5N/WlgPxClvxr03Ej6
        YLEsRWBVEy1DldfculnZc2ABEzqF7UL4j1wj2IoTSw==
X-Google-Smtp-Source: AGHT+IH3o/E3AVABiTEsQRh9oCzwnF1Tp6uR/P9j++EHYyEuKgDdnGMdSSbmO98o+4UibQDwX4KpyUzYPvSZb/nYH90=
X-Received: by 2002:a0c:f8c9:0:b0:64f:539b:f52a with SMTP id
 h9-20020a0cf8c9000000b0064f539bf52amr7860375qvo.20.1695368957777; Fri, 22 Sep
 2023 00:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230720173956.3674987-1-glider@google.com> <20230720173956.3674987-2-glider@google.com>
 <ZLyI+0EL1VztnHLe@yury-ThinkPad> <ZL1JarpwxpsB3fhY@yury-ThinkPad>
In-Reply-To: <ZL1JarpwxpsB3fhY@yury-ThinkPad>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 22 Sep 2023 09:48:41 +0200
Message-ID: <CAG_fn=U0gcMpmTsfir27w4BwLS4Cp+kHa-CWqS5fX-9RjMCJcw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] lib/bitmap: add bitmap_{set,get}_value()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
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

> Either way, whatever we decide, let's stay clear with our intentions
> and mention explicitly that tail bits are either must be zero, or
> ignored.
>
> Alexander, can you add the snippet above to the comments for the
> bitmap_write() and bitmap_read(), as well as in the test? Also, if we
> decide to clear tail of the input value, would BITMAP_LAST_WORD_MASK()
> generate better code than GENMASK(nbits - 1, 0) does?

Added the snippet above to bitmap_write(). I think however it is
obvious that bitmap_read() reads only nbits?

> Commets are very appreciated.
>
> Thanks,
> Yury



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
