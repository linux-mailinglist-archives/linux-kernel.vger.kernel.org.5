Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F998776CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 01:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbjHIXH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 19:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjHIXHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 19:07:48 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEF9D1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 16:07:48 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40ff82320a7so1552951cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 16:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691622467; x=1692227267;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VQfbTJjCmWtBg4hUJgylVyeXYXRezvNJemGqAd+CqWA=;
        b=LMBAsoT/usMLBrWGd02ra/MOtXialMrN58l9fgwcVGEWTd4cRsEpdtUJLGx9K8Fcb/
         92kkrp+3o+tnecU0QQHnRbqBRXq2ZwUplhkMcVc8Iuod/mEITE5u4HAvNLMr0JAXnVZJ
         0OQon0Xq/Vi7bsyuHunaKBQoRSy7Y7rDX0v7epanJJ+t3pR7H82ToQgNdFJ3pAgsYXib
         OUJ5UqaMvCASGyERRDEcNkLN+iFe0Eu5t7LgW2Wz2aO5I7B/Xp+voVM3iS1U6Y7Ezu/6
         Pg+RQg43AC6kOUEKcWazfMujy5MrU8Y9uB2ReHyDTER9BipTIz8gZinH+xMC05gsP2+6
         /JqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691622467; x=1692227267;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQfbTJjCmWtBg4hUJgylVyeXYXRezvNJemGqAd+CqWA=;
        b=Lo0lVaZZjYYKDI67/bsw8PBoOTZkuLITitlvZkppguclmltl0zCs0mzq/G1pDONjf7
         OBIIEtx5D1TsU2mKxgKg/spgY3ySxBJLLfDO4mg1cfbFbPpogXBghPxM1Dt3Ug/yjjAq
         ACmfbHvQQ1FEEuHx3RM+W7j6jK//jvTaMPzbt0ErbAQ9srs1eOQgc2xj8DHV9egHTxBj
         NV9n8g2fhWJOsDbP/iETIyI5K4J3ifXLRP1P+pSqabVQ8ZDzjhzBWQorByFbSMFV0otn
         FlovffBtDRIWyrKLlkb5F5yj6IpZp24PWLSus8Wr9Lf0hFAZKEBd56OEX5i2FgYZW8q2
         nefg==
X-Gm-Message-State: AOJu0YxajBD8Yf5HolFEtVJpHsFAN7iN0D6tHalMzYp78F9Ok2DCGLLk
        8tw7nwTdAPItSkSzbzGmGqQ8
X-Google-Smtp-Source: AGHT+IGta8kX3NP9TyOIqpPKp9v3hFUKdqezlZIgikd2k0YOZxLAd2CgfO8A59oDRwxstSV1zkclOg==
X-Received: by 2002:a05:622a:5:b0:40f:c886:ef33 with SMTP id x5-20020a05622a000500b0040fc886ef33mr969279qtw.16.1691622467232;
        Wed, 09 Aug 2023 16:07:47 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id iv10-20020a05622a6f0a00b00405502aaf76sm70448qtb.57.2023.08.09.16.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 16:07:46 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:07:46 -0400
Message-ID: <3ad619ce17895bb49eb02853da5a2f85.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] selinux: use unsigned iterator in nlmsgtab code
References: <20230807171143.208481-6-cgzones@googlemail.com>
In-Reply-To: <20230807171143.208481-6-cgzones@googlemail.com>
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
> Use an unsigned type as loop iterator.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v3: use unsigned int instead of u32 since the loop bound is known at
>     compile time and small (<100)
> v2: avoid declarations in init-clauses of for loops
> ---
>  security/selinux/nlmsgtab.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Merged into selinux/next, thanks.

--
paul-moore.com
