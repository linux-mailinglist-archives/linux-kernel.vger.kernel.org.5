Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CAA790754
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 12:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351982AbjIBKdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 06:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjIBKdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 06:33:02 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CBF10FA
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 03:32:57 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7928dc54896so101612539f.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 03:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693650777; x=1694255577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5OnI434n9NeNnDKmiNIVPrhxOf7YFyuDkJUxLVMdSiA=;
        b=KyfeOA8BW5Mn6qXxYuChfcI/W8wu1rHN9EFiP4WMjI69swMXpFhVI1N32FYrtZKNjf
         ur/eWqfW+j+vG5cI/tUXjGeDpXJavfIjz1/Bts+NeW9hWy7BSvn5KIL7pRz4GvenQL2K
         o5yUBPM+Tyvmgy5leIZN8O6S9zMPUQ/bga8hwnnB514drqokgmpwCEBwXCc0ovy/X2lB
         Y7QKmmlU2ES1vraFYUxOrrpE57FiguQIJsh2pW5e9VW+e87I1Sc0z/QsAj+Q00G7w93I
         aEoyA3AWsnCxcnH9JyUrdjlpDCEhbXKKVmylQXMnNuNuLhIlysXN4KyNuPssgWzlLCYA
         gHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693650777; x=1694255577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5OnI434n9NeNnDKmiNIVPrhxOf7YFyuDkJUxLVMdSiA=;
        b=W4H5wYpXCh2rsfxH3K5k4rof9S6vgxie0f8JCnnjucsH+bJOS0traEzZJk2FcNnM1t
         cWJEWJVHtQodfIHuw/SIE+buFr1W6hxbnZhnuzbhCBlz9iXRQfYlAd/72sykY2P23qS9
         Zuv003U7TZioLYwaA7zmGi5XszHf9gVLvZ4GTPCf4subhVc4foYawu+Sh4ilMkODhb85
         3YHM8qlHgZO+sOojf0sdj5zYzte5i63/1noELUzguyI7m1n9ggP+ZcCVHLKRGDciHXRI
         TRMrmHRfaJ2L3QakC7TVg2fUp96Z3wVkrAiQzbc2/oRWx1wE8WPdR/agRyrzB2dqEh0B
         RQwQ==
X-Gm-Message-State: AOJu0YyYKrAfGA1KjT56Vywjvzi2sTi1DRfmRFAQ89KHD3T5Fuu7L8ob
        1f8cdBUldN4nhZ8U9CPM1sYNhaHMKEsleCCI+m4=
X-Google-Smtp-Source: AGHT+IH4PP5dWsT0jG0ti38U73JafvHzDWIElKwhl5OhOObG91+aQOEOROQHRtidpsNLL6+FiaYmWkl/VyHq61KoV5I=
X-Received: by 2002:a92:cb0e:0:b0:34c:e6e6:80d5 with SMTP id
 s14-20020a92cb0e000000b0034ce6e680d5mr6122660ilo.26.1693650777195; Sat, 02
 Sep 2023 03:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230901133641.60817-1-dii@itb.spb.ru>
In-Reply-To: <20230901133641.60817-1-dii@itb.spb.ru>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Sat, 2 Sep 2023 12:32:45 +0200
Message-ID: <CAOiHx==_azyuNzVEvYrGQmDxb2TYPW=2bFjyRjGoxWX-pGb7OA@mail.gmail.com>
Subject: Re: [PATCH] mtd: tests: remove useless checks
To:     Dembskiy Igor <dii@itb.spb.ru>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 1 Sept 2023 at 15:39, Dembskiy Igor <dii@itb.spb.ru> wrote:
>
> Return value of mtdtest_scan_for_bad_() is always 0. So it causes senseless

Your function name got cut off.

> checks in some functions such as mtd_subpagetest_init().

Then maybe it should return void?

> Fixes: 084db4b020c7 ("mtd: tests: introduce helper functions")
> Signed-off-by: Dembskiy Igor <dii@itb.spb.ru>
> ---
>  drivers/mtd/tests/oobtest.c     | 2 --
>  drivers/mtd/tests/pagetest.c    | 2 --
>  drivers/mtd/tests/readtest.c    | 2 --
>  drivers/mtd/tests/speedtest.c   | 3 +--
>  drivers/mtd/tests/stresstest.c  | 2 --
>  drivers/mtd/tests/subpagetest.c | 2 --
>  drivers/mtd/tests/torturetest.c | 2 --
>  7 files changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/drivers/mtd/tests/oobtest.c b/drivers/mtd/tests/oobtest.c
> index 13fed398937e..976f40a5656e 100644
> --- a/drivers/mtd/tests/oobtest.c
> +++ b/drivers/mtd/tests/oobtest.c
> @@ -399,8 +399,6 @@ static int __init mtd_oobtest_init(void)
>         pr_info("test 1 of 5\n");
>
>         err = mtdtest_erase_good_eraseblocks(mtd, bbt, 0, ebcnt);
> -       if (err)
> -               goto out;

That's not mtdtest_scan_for_bad_eraseblocks().

Regards,
Jonas
