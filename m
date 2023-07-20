Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7D275A644
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjGTGZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGTGZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:25:18 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B437128
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:25:17 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so493546a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689834316; x=1690439116;
        h=cc:to:subject:message-id:date:from:sender:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JNL4l5GRlHwxV4ntRBz/satLVd2URGo3WiWHTSW6eE4=;
        b=QSIEs6AVNYFv9z7/VkvFN6axf4NcXNTrxvEwfbAuZA0WcfDW38zoK9JiXytigKHeC5
         DYrGbL81QYKlCI3xxV2RkC77wi61QADL6LviFW9H11F/dPugFW7xEmVX+QjEXU1feoVD
         r/iGgnqx5NWyBUmW3RjUTvFEQdxnxtgYgIylX3zuVgOSCcn3FbbI6ZrikCDtfGGw0SzM
         GlA76rMc2dAxDSVfmtfttYx25yhlC3DcZSusFga55N33uy9Dghfn6kFirVqYwJHUS1G5
         rHe56vsX6IiWWtJR/I0a6iP9g4YPMWImyJ81ITLfzqgoHcJ60W4jLbJbry35YY68TR/O
         6BQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689834316; x=1690439116;
        h=cc:to:subject:message-id:date:from:sender:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNL4l5GRlHwxV4ntRBz/satLVd2URGo3WiWHTSW6eE4=;
        b=j8Rl2Pa6EECdut3+zzldJs/2YaZHCnqM+2sgvurVNDa9uvh2h5FUmRgZ2VgZMP9h1S
         /ZXkNVPs5XpRhgDLXE/o5VHREX0Vqb6gYFF4tPPkowPkAXyUW2wsHjuEzBv2LhIBovdd
         Wz/rW+fV3jvTAvslrE3J3NLuefzBSyHfhHZvzM0iGle3YQ5EaqE5lwIQhygejidSBrzl
         GaFofUR2AwNxvVnQi8OEmYnGJPQlKuTtXurkj2kYWq/MOHPBUT/cRVsifxYW+94YpsR6
         0bUaVLYxiTwDp8qQfmNnMvcR9xXgyjFbwOd+sfDt2+0hDzC7kmJrtUyWxZfImkoRwOBi
         6jMw==
X-Gm-Message-State: ABy/qLa6j0Qd//ps0Ghl58jEXJpxg7q3QTdeR1oYPn8OJvj5h5TQC+es
        HWaT4Lexr9DTwOf0Zcvi71mUA5QcncMPK/HtqoHdTI6OQ9E=
X-Google-Smtp-Source: APBJJlEAekAGm8b9heA5DHCrx/MiGSEyvtwHTkQ52PeIUjOZOspIHL6dE4HhuM/FqIfVA4Wld5gYo5iknBjb+B6hYbg=
X-Received: by 2002:aa7:c38a:0:b0:51e:36b8:34fa with SMTP id
 k10-20020aa7c38a000000b0051e36b834famr3973631edq.4.1689834315425; Wed, 19 Jul
 2023 23:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_8D245D1A87D17619EA8475E8F005A151000A@qq.com>
 <65f4c60a-9534-56dc-099f-ee7a96e0ccaf@redhat.com> <20230712235813.GE6354@monkey>
 <CAKdjhyD4RVHFVLrcfcuEnvwrjjxAk_GL=kjcm1iw3WTrmmFb9Q@mail.gmail.com>
 <6c3191e1-23fd-4f9e-9b5e-321c51599897@moroto.mountain> <20230719232248.GC3240@monkey>
In-Reply-To: <20230719232248.GC3240@monkey>
Sender: cl1ntlov3@gmail.com
X-Google-Sender-Delegation: cl1ntlov3@gmail.com
From:   linke li <lilinke99@gmail.com>
Date:   Thu, 20 Jul 2023 14:25:03 +0800
X-Google-Sender-Auth: vNNFw5NqUWJumSZdCdnOBZIRxbk
Message-ID: <CAKdjhyA68LEs07UQA9my66ue4V=o_2EEHxsWC_ZKxdnc+uZqKA@mail.gmail.com>
Subject: Re: [PATCH] hugetlbfs: Fix integer overflow check in hugetlbfs_file_mmap()
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Linke Li <lilinke99@foxmail.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        trix@redhat.com, ndesaulniers@google.com, nathan@kernel.org,
        muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > What about using the check_add_overflow() macro?
>
> I like the macro.  It seems to have plenty of users.
>
> Linke Li, what do you think?  If you like, please send another path
> using the macro as suggested by Dan.

Thanks for Dan's advice. I have tested this macro in gcc-9 and clang-14, it
can work well in both compilers and regardless of whether "-fno-strict-overflow"
 is added or not.

I will send a new patch.

Best Regards
