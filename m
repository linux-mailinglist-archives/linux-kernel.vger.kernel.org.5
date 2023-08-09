Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D77776C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 01:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjHIXHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 19:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjHIXHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 19:07:44 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E4D10DE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 16:07:44 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-768054797f7so23247685a.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 16:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691622463; x=1692227263;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sHK61T6EgbxK/w/h+u2OTZ46eXlV1WaAOWJmOQveL60=;
        b=gkjR2QtHz2DQFihjTgiuc1uY2qjpu9zys8jz6KgXSN7FqLZyqquHE0eJh4SGK6i83D
         rD218t5MopuA/4TP7POzZPoRawzonPU1L90DzSeIBG73sjbKALkHZN1sJShUCWOUHksz
         NEPcjLefA71RDAw7VBoHj75GENR3Ev2yYKKcvNItFB8cE0RRiQWuEOZjQngcw6XxSmHq
         qhhyGKX5pnigORXmHjSUErufD8ppeqnv9P8cNPRJAquWvWIAhrlFf7eDeAuxWMKAlEmF
         79UKT0OSXc/hdvMy4EAvC4iawkeUKRuMH7C7ZgQgYwPi8GiVJNlg3HOWcAS7OT9IXccZ
         mjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691622463; x=1692227263;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHK61T6EgbxK/w/h+u2OTZ46eXlV1WaAOWJmOQveL60=;
        b=kWMA2jzY+L73Zmicz4zDmvU7DX1+hkNStuouD60F5jjJghk7ZVNLWHwCfZ/cgcwNk5
         XkEExKc6/yAu0qDUU8pUCm+BD4LfcXHXuNflhLcd7xGB+vIFfEu4qf8/BxckY9szAAmj
         hpsKwGe7+uFc9MtWOiH00u/WdZ4OuGykj2SIW4aUCV+V5emtcef96S+yUg72k198fjHp
         a/xqJh1bp5pXaQP64/zN2OiG2YQ78yEJx3sVjdnxiPea0aQutxGS3zsbeLXerdOt5u9x
         IDtMcSN5a2Ute93EVPCA0g1vWCiHgi7YTs8cLWQbAE4AgRiLzSVKylOnXM/TRs/OeGFr
         QB3Q==
X-Gm-Message-State: AOJu0YwzwV0Ngt3Q+/FO9NUlw7y00NhYhPzxRkrdY2YevgmukNmP5EYM
        OuRtKLt366ciTa4hshNHzvUC2rr9c2c2UfBtRZLK
X-Google-Smtp-Source: AGHT+IG4zDPfU/zDa5sG1B+ZHVEFI1O2Ivcjs1oMRzZkRBurX+fNIrzdu5EPrQpKRZq0kCYmj1ohXw==
X-Received: by 2002:a05:620a:90a:b0:768:13b6:e9e7 with SMTP id v10-20020a05620a090a00b0076813b6e9e7mr427080qkv.63.1691622463415;
        Wed, 09 Aug 2023 16:07:43 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id s29-20020a05620a031d00b00767e62bcf0csm49515qkm.65.2023.08.09.16.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 16:07:43 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:07:42 -0400
Message-ID: <bc30edc4e609babadee9acb39c8bff4e.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] selinux: update type for number of class  permissions in services code
References: <20230807171143.208481-2-cgzones@googlemail.com>
In-Reply-To: <20230807171143.208481-2-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug  7, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Security classes have only up to 32 permissions, hence using an u16 is
> sufficient (while improving padding in struct selinux_mapping).
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v3:
>   - drop type change of arithmetic variable; it might effect performance
>     as suggested by David.
>   - split bogus and corrected cast into separate patch
> v2:
>    update commit description:
>      - mention struct selinux_mapping  in the padding argument
>        (currently between the first and second member there are 2 bytes
>         padding)
>      - mention overflow in the cast argument and the result of setting
>        no bits due to it
> ---
>  security/selinux/ss/services.c | 2 +-
>  security/selinux/ss/services.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
