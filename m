Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CBC758812
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGRWC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjGRWBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:01:52 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C381FE7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:29 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76731802203so572463885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717688; x=1692309688;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7cvKLgtD/217BQRA+bkKMA4ANBUEIBaK9JXp5Tj1STM=;
        b=fgyUOy16nTE/+8D/AcsZWujerTOKHVFqSoHNpJaDj19SFZj5C4I4E2QX06T3BCyQIu
         cdSqre6IZm/RTrJrl8SYJqLAEBpyXW27DzRlWoNrQJnW4AvfGR6KGjqXZ+3yQQvQVlDB
         PF/nIVNQLYlrlyoC5vSkbb/4nJ7vGseCAS9yQ07WdK1H+4QWXkCc/40pYoWbTwGNRJAg
         yIYmb4bOMGdRWkOT2awOpeP8vZ8oE1Ke7VGwBcSumLrI5x3XCpxStxoBXWCow7F7G8i/
         lFdtsHzdB5t7bSVxAfCLw4NwWAulmjmuhp08/nVwzfbuXyJTyxglTYE1R3J8HYuspcrc
         R/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717688; x=1692309688;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7cvKLgtD/217BQRA+bkKMA4ANBUEIBaK9JXp5Tj1STM=;
        b=RzSkS0tmvqF5pXk6Ackhj9zafsXL4hhXhTrSb1t5JfdVzv2rzKrlWs4Sk6/LlEZogi
         U6XRjW5hAtCbLCXdbypRcY7ahfL8g21lOD2KT2W7QSnNi445MdVOj4L8/g/TQim9f6Vh
         wpAsz3EtfDHkxmw0+4J8eq9SXFvxKeDWrPjOyPt/+BecfawrXwRISITpXcuh8Wo7oaEF
         OgO3oLfzhS65b2+DrYhLd+3aFUD9Q5VZEWYeqI2YCKfrNk73LZjyzxkQ6Dx5mkCGTp3j
         BLp6vgUav21IVZVSpRAms1bHPXQOWabA6Jxe8ypUa93JURk//nc1JQc3nXWtCGmCg8R/
         Uz2g==
X-Gm-Message-State: ABy/qLazQSoNx5Yi5/WyHpzOOoy2gP3qCWyDPdVzHoxPIBHg6LW4OVd8
        yhnanO8YX+TWgDYDb31id7d3
X-Google-Smtp-Source: APBJJlFSuSd4IQ0+xazwsY3DF2Xz6ADU7iBtxV41Dt00hSAJsfnNtbJrSeoTSgHuMIWB00PWZWkQIw==
X-Received: by 2002:a05:620a:4105:b0:767:1b06:ba58 with SMTP id j5-20020a05620a410500b007671b06ba58mr18610646qko.29.1689717688372;
        Tue, 18 Jul 2023 15:01:28 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id l21-20020a37f515000000b00767d05117fesm894644qkk.36.2023.07.18.15.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:27 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:27 -0400
Message-ID: <336bba31975d43e1d2f4ad9c2b9fc170.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 17/20] selinux: services: implicit conversions
References: <20230706132337.15924-17-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-17-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use the type identical to the source for local variables.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/services.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

More loop iterators, see my previous comments.

--
paul-moore.com
