Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6A27A23EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbjIOQvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbjIOQvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:51:04 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F54118
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:51:00 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-564af0ac494so1751505a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694796659; x=1695401459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9N4U7m1ENfkMXf6AuPL4MT6Lni4JryuzWdzOGtlKI8=;
        b=MkevyBfJB5MBR3LKBsMzv8LqJ6MZNOhvM0Cx1VeEtxay0CLOnKeG1zjDl+uLQY4RVc
         f3NQcgAmjrb9H2aLXJkqdgBIiSJf2z5DUxvaiWkD/Bq/YS0e9YgtLrEsfItDKixwIEux
         dEAtfffVq1cguuzKKc7aY/OLS+8PSzP+wMOJWAGQKOhtrdpfKFdk10W7VV9UV5q6XolB
         jPXIMXUq5OZ1dSm0XOqSOFeQgFVz+weZVbaHSKFMMchnXMSP3ZshwMm5QMrI5iodQIu0
         W74vdMyjOv7CAZLGuUzdqua2r/J/k47l5EdnYTamnYpImugmx3Ut80FMEoGvou+kdiMk
         Y8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694796659; x=1695401459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9N4U7m1ENfkMXf6AuPL4MT6Lni4JryuzWdzOGtlKI8=;
        b=Y72f0nuVsuAbaqvGd5rSnQVYgG0IUOkmA2wXIh9VwXZ0GluzrlKvmYaaoxSxvezI6b
         5bFKy92kIKvFdkUgaZUkJTvqVvXONOjgiXiOjjw2EmM+Czuuov4EZO3k3avHsZwKYOic
         MIalM3DDK7Bvvyma1QC4SrqsXOMHDWOic8Gfdjd/PXYwh14BGDo1Nz9Fut+zCjheLexu
         E128i8vE099ylbXK5u6tOtQegBPd3UIM6yPtLnA/Bp3vk9mNFvBSHM4MwY1OWvHU57NV
         oUStlhg39Uu4dH/7oc6ELBfWO3RSMZiZ8+ARrQ918ZfFZdo7TMwrBcdLea3Vk2CKBoyE
         85+A==
X-Gm-Message-State: AOJu0YxdiHHEAnoSz7s8+9vjvHWVHOe+vug78SVbdpAPq7GJLuRbQ968
        huF5c8D2/pnc4ZUBr/jcJZWGbdbmQr6LwCoOHm0=
X-Google-Smtp-Source: AGHT+IGbqKZHfQYVZyeiRIfx3Rau8VcK1iGF77tUw+uQyQtNqnu5UagzuHOH8rpnQb8Ka+6MLiQbWH8tpwggqtgwVnk=
X-Received: by 2002:a17:90a:f312:b0:273:e42b:34c1 with SMTP id
 ca18-20020a17090af31200b00273e42b34c1mr1902942pjb.42.1694796659560; Fri, 15
 Sep 2023 09:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+fCnZePgv=V65t4FtJvcyKvhM6yA3amTbPnwc5Ft5YdzpeeRg@mail.gmail.com>
 <20230915024559.32806-1-haibo.li@mediatek.com>
In-Reply-To: <20230915024559.32806-1-haibo.li@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 15 Sep 2023 18:50:48 +0200
Message-ID: <CA+fCnZfuaovc4fk6Z+p1haLk7iemgtpF522sej3oWYARhBYYUQ@mail.gmail.com>
Subject: Re: [PATCH] kasan:fix access invalid shadow address when input is illegal
To:     Haibo Li <haibo.li@mediatek.com>, jannh@google.com
Cc:     akpm@linux-foundation.org, angelogioacchino.delregno@collabora.com,
        dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mm@kvack.org,
        mark.rutland@arm.com, matthias.bgg@gmail.com,
        ryabinin.a.a@gmail.com, vincenzo.frascino@arm.com,
        xiaoming.yu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 4:46=E2=80=AFAM 'Haibo Li' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> The patch checks each shadow address,so it introduces extra overhead.

Ack. Could still be fine, depends on the overhead.

But if the message printed by kasan_non_canonical_hook is good enough
for your use case, I would rather stick to that.

> Now kasan_non_canonical_hook only works for CONFIG_KASAN_INLINE.
>
> And CONFIG_KASAN_OUTLINE is set in my case.
>
> Is it possible to make kasan_non_canonical_hook works for both
> INLINE and OUTLINE by simply remove the "#ifdef CONFIG_KASAN_INLINE"?

Yes, it should just work if you remove the ifdefs in mm/kasan/report.c
and in include/linux/kasan.h.

Jann, do you have any objections to enabling kasan_non_canonical_hook
for the outline mode too?

> Since kasan_non_canonical_hook is only used after kernel fault,it
> is better if there is no limit.
