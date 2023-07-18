Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1EF75743E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjGRGcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjGRGcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FE4134
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689661879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CDkrHbofKwAd8b00fKCLemfZdn7j2GQInSPsQWH1ROw=;
        b=NBUAW/u2tDOZ8z4/uZBn+FU7Cm9cAgfc4MbgvENPNie93aIZH+/TNo5d33NbDHLM8kr33W
        Wm8YdICUSDA/Yr4aCEOmFHJDOBWRLMD9Pu8uIQ6YbkxJ1QCspE8TnhYCG6Sg5FOPmL2t0X
        v9yHtJ6u7lCMj0l+l5gKt/rbnYeJ3N0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-Gtky2FkRMW6p0mk-e2-4ig-1; Tue, 18 Jul 2023 02:31:18 -0400
X-MC-Unique: Gtky2FkRMW6p0mk-e2-4ig-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbe4cecd66so29954415e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689661877; x=1692253877;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CDkrHbofKwAd8b00fKCLemfZdn7j2GQInSPsQWH1ROw=;
        b=kzOOYV5sbtYS2hUStIBIAcKpWzrkOV/7hYcV62BIn5/tzVzucEY0KFUGI/3KUDB6kr
         HXiYdd9gfk+zC8VE1qJzXbVqS9bVStl8+AO7I4FtEyD8GpC80G04zTSOpUHf/OG0npQQ
         I8racYuFFmJdUSnQtyePVPlwqKe55Gz2tKxKdFXwL7N6RPs0F3sSXzxKwP47BUgozjHj
         cEjwx/AuFMDHYpKzGuwE7P3n4EcM1DesANEmU5tyFDGXIMcDrzimtsm3GoBGf537UhmJ
         65U8OFXabA+A2pPr4IOwFp3wFMx2OAuAinQe3/aF0+ylV0PeVkZpDvfrsZAJItH3gVKN
         aXdg==
X-Gm-Message-State: ABy/qLY455uQjyBexlmuZ/ZmgDYOJTjq/0IwUMCx6ZDN0woh38RFLdCq
        gPdupqMP/bVSTMxfvUEmFY8UuIdShjdBhpIQ59dBHFelTQthB4pCKcvPxI0+ffjbSALFHbjrwR9
        4KgJdhVuCCu1k6mGXmryvZEGGSXpc/Mbo
X-Received: by 2002:a7b:c3d8:0:b0:3fb:c217:722e with SMTP id t24-20020a7bc3d8000000b003fbc217722emr961086wmj.33.1689661877035;
        Mon, 17 Jul 2023 23:31:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEjVTbThWaHJ0AL2EjhwdxtedgirhcRj0CAt0l11VQ2c/8MbMR421n1++XMnzzZ0vYVkr8pwA==
X-Received: by 2002:a7b:c3d8:0:b0:3fb:c217:722e with SMTP id t24-20020a7bc3d8000000b003fbc217722emr961075wmj.33.1689661876771;
        Mon, 17 Jul 2023 23:31:16 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l6-20020a1ced06000000b003fbacc853ccsm1329128wmh.18.2023.07.17.23.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 23:31:16 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Hui Min Mina Chou <minachou@andestech.com>,
        hirofumi@mail.parknet.co.jp, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        tim609@andestech.com, dylan@andestech.com, az70021@gmail.com,
        minachou@andestech.com
Subject: Re: [PATCH] selftests/filesystems: Add six consecutive 'x'
 characters to mktemp
In-Reply-To: <20230718034351.1373857-1-minachou@andestech.com>
References: <20230718034351.1373857-1-minachou@andestech.com>
Date:   Tue, 18 Jul 2023 08:31:15 +0200
Message-ID: <87351lk9xo.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hui Min Mina Chou <minachou@andestech.com> writes:

> In busybox, the mktemp requires that the generated filename be
> suffixed with at least six consecutive 'X' characters. Otherwise,
> it will return an "Invalid argument" error.
>
> Signed-off-by: Hui Min Mina Chou <minachou@andestech.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

