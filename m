Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EB57A4298
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbjIRHcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240252AbjIRHbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:31:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA03212C;
        Mon, 18 Sep 2023 00:31:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40472c3faadso40589055e9.2;
        Mon, 18 Sep 2023 00:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695022270; x=1695627070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/9MjO3R8I5ALb/BaTl3sTvaDPPou8ZUyKXxeS+MJr8=;
        b=GCIMc5HJKsgSczGIs+Zasp12t87vqfEq/uspPaNJvHSGSCuHnrHQYOaiMqfrQ7v2Kr
         CvsDU+IGUu3BLyKMMzY6r2jm0AqCZOFvmXX/QDMAoNLv6Jbb4cgzrqSUlwE6HNOumy4j
         6+N7+5zq9mgwIN8o13pdl5wvkzbAwrkQEjr3d3qAUtoHpzqYcBTHJ1tdBWR75J2Ozi1m
         j0DPpBKOlVKaDRV+UMPHXFldOUAmwZ/Rg360tVYLQl/HgmmsoEpMC9VaP+rK/ETatFwK
         u4tGyr5S+2Q5RGULOeapTtVKTHQb4zgOxaSoEGy3uGoNaEKG8+xbD7u6IUN+eQp5V0zF
         +ebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695022270; x=1695627070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/9MjO3R8I5ALb/BaTl3sTvaDPPou8ZUyKXxeS+MJr8=;
        b=HbNOJH2oSa6Y9UbfOUlxLqjaeDFvb4V5JnEASGnwMT+bXyRtjTIpZMV9XYdwC9kxtP
         Uf6jZ2uGHlEpqyytt1oSQGweUsMlXIbc2dpuQLsiaYGDTCEhhWEnMF9n9qh0Tr8/9jiS
         4XAmcJLW6IDaBqWgGNHyiKmPTfsWctG2M9r+qAk/Z+kcP7X+wpFeVSUZuaB4WmMJsMvW
         T5CMqfI28nR1ve6J6+ZMojOr3xGhrqKHG2+2HjAfkhIrWKvS5Slk1HKMvcR2xSXXgwAe
         bNfrb5VK44BQwDZ9HG//v5J0jBx0l4m+9TLdMxuYhd1b7JULqfB7J1N/3Zatg4z0mESz
         tqfw==
X-Gm-Message-State: AOJu0Yyo1dtKNYJD63YM5CbvwUWrHZ5UV2gF4pEHK6WXEYiizvAwrSsD
        PCRsU5lup2HG/xRfK+y2TTHwewck9O8=
X-Google-Smtp-Source: AGHT+IFunwts3zDprHoCiXSrDd6TYFaUZHQrgvp3PKpzYYBESQlbqLxbMv0Prg7W5pj5KnWX2o0xXQ==
X-Received: by 2002:a5d:6dcd:0:b0:313:e971:53af with SMTP id d13-20020a5d6dcd000000b00313e97153afmr5971377wrz.32.1695022269970;
        Mon, 18 Sep 2023 00:31:09 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id e25-20020a5d5959000000b003143c9beeaesm11861797wri.44.2023.09.18.00.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 00:31:09 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 18 Sep 2023 09:31:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: x86/asm] x86/percpu: Define
 {raw,this}_cpu_try_cmpxchg{64,128}
Message-ID: <ZQf8u327SUDag/zd@gmail.com>
References: <20230906185941.53527-1-ubizjak@gmail.com>
 <169477710252.27769.14094735545135203449.tip-bot2@tip-bot2>
 <CAHk-=wiOH-VK8XLUBU-=kzPij9X=m7HwnviXF-o8X54Z=Ey_xw@mail.gmail.com>
 <CAFULd4YLzRWmXG2DHeRHYY33FrX+wNOVfQFyms5Mki1mmn0VZA@mail.gmail.com>
 <CAFULd4baw7wC7hemfqcGirkFVHihcnG+_a9RRQGga+CatpEagA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4baw7wC7hemfqcGirkFVHihcnG+_a9RRQGga+CatpEagA@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Uros Bizjak <ubizjak@gmail.com> wrote:

> Now also with the patch attached.
> 
> Uros.

> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index a87db6140fe2..331a9d4dce82 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h

Assuming it boots & works, mind sending a fully changelogged patch with a 
SOB and a 'Suggested-by: Linus' tag or so? Looks like a nice v6.7 addition.

Thanks,

	Ingo
