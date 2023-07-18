Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547FE7587F1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjGRWBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjGRWBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:01:16 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10CD19B3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:13 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7659c6cae2cso421805285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717673; x=1692309673;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z0/uf5AvHD3Ad9NS83FZnzRuH3oiKZoLYaLQ80T3/84=;
        b=Be6zVOCErHmcczCO6fqOr11lh9Xyzw7rJ7oPkz/UXLYHG4MTP+IhvLNL26Q0V4eMH6
         OLG2EBrwnWD5iYXvs0uuxaUJFT3E1Fc3O78lusGJF2KBKgaYeeSkKDyzmCrAfyiJGP0S
         dv76BfQ2bFT+DjoV1+4LJL9WFyolS4/2Pxz9NC4RHsLIWCb7dl9on8XIYOF6yS4IVF+9
         BKeokHt3R78is4+UjwIerhOpSQKhlLO7cOhwmWHD8ijMP+GuDCr+uFdw14BAYnHbHPDi
         /oLO1EfP6nHwbX3dfFWcAHCsXO2XTQGkg5zWgXCZLAOqURbBPJWFe861glRe1Xp1/GIB
         TpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717673; x=1692309673;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0/uf5AvHD3Ad9NS83FZnzRuH3oiKZoLYaLQ80T3/84=;
        b=LKggEDTzmoPkyNxw6VxqYY1USs9ygRNAxulv4nlUogfDM5Ux+YqphQNeQDokiAmjU4
         f5cv0USwGQFJpSNcyZQa/qXvW8/tNdM6ENC3swilZlhqTRjSmKvuAmKzNx3iVDsi7mLk
         b5lQTRwREj1z0/zFKcSEdwj37SOrROGu//yktZYZUauv6oUhkzrLOab0xOvIsS00M911
         VyqTTUkD0T6hAhpF5R88U8UFNTzIKCRbkH6JJzSTUp6NR7WaeV1nTlv7c+eacNXpmd8o
         r4Lc0VKRax29DV5ZmM+1g+DNgBxCkDkkqwszBoWzz0LmQP21FfwAnH6gCiAq7z5M0Ozq
         iYdQ==
X-Gm-Message-State: ABy/qLZ3/4FDaW4+wAexjkdBpB/UVG23Ar6R6s+PjSiQryjnOfc20/cl
        zDiHjCnLPwYPgmuJuYmxEVty
X-Google-Smtp-Source: APBJJlHFnLy5PH2r2LCdf+C6Xe1C4n2YBqesF57TOIq56DDmQRQbh04seW3hlYl3u+MrP4i9FEQdeQ==
X-Received: by 2002:a05:620a:1a84:b0:767:e57f:6fe with SMTP id bl4-20020a05620a1a8400b00767e57f06femr1115499qkb.61.1689717673041;
        Tue, 18 Jul 2023 15:01:13 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id i2-20020a05620a074200b00767fbfea21dsm877906qki.69.2023.07.18.15.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:12 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:12 -0400
Message-ID: <6fcffe16a17c4e1b28daa23f3c6ca49f.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Gong Ruiqi <gongruiqi1@huawei.com>,
        =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>
Subject: Re: [PATCH RFC 1/20] selinux: check for multiplication overflow in  put_entry()
References: <20230706132337.15924-1-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-1-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  6, 2023 Gong Ruiqi <gongruiqi1@huawei.com> wrote:
> 
> The function is always inlined and most of the time both relevant
> arguments are compile time constants, allowing compilers to elide the
> check.  Also the function is part of outputting the policy, which is not
> performance critical.
> 
> Also convert the type of the third parameter into a size_t, since it
> should always be a non-negative number of elements.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/policydb.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
