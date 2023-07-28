Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97AA767442
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbjG1SJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbjG1SJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:09:35 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021E944B9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:09:24 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a412653352so1931128b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690567764; x=1691172564;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TICUNswaiy3hGzrdEHOhf450hXdu05dOSqoVSbTxlFE=;
        b=dlxe18JZ/R5T/cj1N4po5CDFM75FGKqR/keZ/dp1HTJBAD9IY775A5kPEXok7rd8Ml
         nsUt2+VbNcGo92PsVz46RSoT9ENiNEFVCCZh8jG4RPxGMF+ZiNNCrCNnV+UmSyqCR2Lh
         AoechusVVqfWu0eH5X3TF4o/zUEiwK4S68QxbWOgdF8Tu96nRHTagwaOpg4/0/rv9p6q
         puDKQ52Dd6fTd/6BZsMudZT2Dy3rLUYV5kJ1n/a470bCHsI0rQ0Y5TbzG4WoOqcAQclY
         6HF8uEmfoP/AV6q5otaksnjV+v4Pvzk+aymNO16Y3tczN3bqGCEcwuSRj6URwezS4jNE
         X8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690567764; x=1691172564;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TICUNswaiy3hGzrdEHOhf450hXdu05dOSqoVSbTxlFE=;
        b=aXUU2gMnSNZHJuXsy1sXFUGrAx7VHbEZOAYm64abixbK5vQ2QlxrF9dhkIuWLyEWtS
         tLdk+xp0ATwfZH0AQmeTzo33T8KrdROWmBOormxmuOpZMv3c0uYeNOugJ25SKdvPwVdD
         MY9RJRRlxieAtX0RBsQUh1h7nn6G3exjrPnVvYVPeSuLrSjS+D1WNSMlYyUznB6b45KR
         olg8dRnreP1LwhiaD6SvkYIzrINlbPyWSkoaYIbBWaKCa7AaSQdJzu1rs6x6bCJXEb4r
         NsnIE8CL9ZSMLPwJluEocPlzLbvB3wnIHT/QRBIqdmByqllEmujSLItgSUhjsR9v4yPb
         ZhIg==
X-Gm-Message-State: ABy/qLac1KS9CgcLh70g7V3EAl/5OrCjq6NTpHXMtJfTU5XNDZW+mjGx
        uU/C/03lrseiJVkCcqFMBv2HJ3xYQ9nMQWZMMw==
X-Google-Smtp-Source: APBJJlF737sAfy9uxAJq7mnhK6Pe6shkg35fxSrQSXzjf9O/X1EW+w/cyH0mee5HYQeKe7meePa4rQ==
X-Received: by 2002:a05:6808:19a6:b0:39a:bd0e:449 with SMTP id bj38-20020a05680819a600b0039abd0e0449mr4286448oib.26.1690567763731;
        Fri, 28 Jul 2023 11:09:23 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id r2-20020ac83b42000000b00403c1a19a2bsm1328529qtf.92.2023.07.28.11.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 11:09:23 -0700 (PDT)
Date:   Fri, 28 Jul 2023 14:09:22 -0400
Message-ID: <a0288beb97f4561804d930667c38c196.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selinux: move debug functions into debug configuration
References: <20230728151932.30160-1-cgzones@googlemail.com>
In-Reply-To: <20230728151932.30160-1-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 28, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> avtab_hash_eval() and hashtab_stat() are only used in policydb.c when
> the configuration SECURITY_SELINUX_DEBUG is enabled.
> 
> Move the function definitions under that configuration as well and
> provide empty definitions in case SECURITY_SELINUX_DEBUG is disabled, to
> avoid using #ifdef in the callers.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2:
>   - provide empty definitions for !SECURITY_SELINUX_DEBUG
>   - drop #ifdef in caller
> ---
>  security/selinux/ss/avtab.c    | 2 ++
>  security/selinux/ss/avtab.h    | 7 +++++++
>  security/selinux/ss/hashtab.c  | 3 ++-
>  security/selinux/ss/hashtab.h  | 6 ++++++
>  security/selinux/ss/policydb.c | 5 +++--
>  5 files changed, 20 insertions(+), 3 deletions(-)

Merged into selinux/next, thanks!

--
paul-moore.com
