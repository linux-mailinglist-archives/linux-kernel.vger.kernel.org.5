Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626A47587FD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjGRWBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjGRWBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:01:24 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAB01BC1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:20 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-403b6b7c0f7so44436821cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717680; x=1692309680;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OvXAgibfz88Twe5DWtMIjMHTvNVQ0cptuu2/ShBaOKI=;
        b=RCy1kHFz1HpIt7I3hzeQODGal8NT1mvWLYncvmcQ1OUfSIZoSKY7hbwKr53DRYCGXQ
         ICuba3XLSFEFRUAxcvR3npblEEDAWGMRcNyFpebi+Z5V98PBKZbl5C/bxUoDhlRsKR0/
         zU1SpZFlOZ4uDpcuhLGerIwtgkeO9YD1WPwQgpuqzDEuZIHf+quegRXu6pP6eNHNmO4o
         kLRDT0KmUprRi4THUxuPfgYWQ2TZzQ+rjRJFWkDo29btXidYj2qceeDutj0xezXJWd11
         AQzauI+Rsnyb5SWe1gpOc+nNtfziidmqdQfmo7Ebq/2n6X5ogZ4OilyAlOHpU63WgJlP
         3Rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717680; x=1692309680;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvXAgibfz88Twe5DWtMIjMHTvNVQ0cptuu2/ShBaOKI=;
        b=a54j1v6j+8Q7W1C3wpXO59js7eoGlKrq5j3ocnESVQJfjDsjTwGVtmKNP/Rewzz6w6
         AqF0QxockTGIPIuFgLbx+TxAOQbuypJDc/aES0khEa4G9LMUi34zYLNl5jg7fDDYIPyW
         uYyTPrF/KTApR6YAT4uF65MR+amoNzBelbfqQJoIBlSZijSH/cLgpVgEvhbyBytWUVjg
         okEUmkcEZGCPsLowgA02VTlYZ3wFZSbZI6Dp3ZNexcGFW9Li3BJZ9npj+0QjGbE+A9ft
         pgRHkMzPO7bYlwkPlef6G38L2PWpPL7nJX4gu9P7isZORk3PLUyvH8423L4Mg3ktRiGN
         TIzg==
X-Gm-Message-State: ABy/qLYU54cxGrHYNIBeJFiPP6dEHh5zHYwlXs1GPJitWxlyX7h82GFR
        sEPFc8MuBSdH2nCJg2U11bi6
X-Google-Smtp-Source: APBJJlEszandnHR1XyofohFdDXATQUDj1sibeWyzqvd4qTxdjOsBAfRtdarqouKU8XiKZ9en2sldQA==
X-Received: by 2002:ac8:7f07:0:b0:403:b395:33e3 with SMTP id f7-20020ac87f07000000b00403b39533e3mr22252178qtk.52.1689717679905;
        Tue, 18 Jul 2023 15:01:19 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id z7-20020ac87107000000b003e3918f350dsm922896qto.25.2023.07.18.15.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:19 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:18 -0400
Message-ID: <1111b348800451acbf5f5c13db05abef.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xiu Jianfeng <xiujianfeng@huaweicloud.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 8/20] selinux: services: avoid implicit conversions
References: <20230706132337.15924-8-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-8-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use u32 as the output parameter type in security_get_classes() and
> security_get_permissions(), based on the type of the symtab nprim
> member.
> 
> Declare the read-only class string parameter of
> security_get_permissions() const.
> 
> Avoid several implicit conversions by using the identical type for the
> destination.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/security.h |  4 ++--
>  security/selinux/selinuxfs.c        |  7 ++++---
>  security/selinux/ss/services.c      | 22 +++++++++-------------
>  3 files changed, 15 insertions(+), 18 deletions(-)

More loop iterators ...

--
paul-moore.com
