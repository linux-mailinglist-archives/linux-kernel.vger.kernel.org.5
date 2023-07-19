Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798D375A052
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGSVFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjGSVFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2851BF0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 14:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689800655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5UtvnYzoD0hTrn0V/d7YsuJa3bzzNU2UnBUdhkM6arg=;
        b=Uz/awoxPhL1t3OFoT5zTHu93cHmhaWe/mU49W9+AzgN+bc6iX2bmGimnq36I1XQvDBfwcU
        FBA/4tn2CvebxZ0+Mt1YsFmXi2qwCWA7VW3hE2k4JooGIw2q0b+ab22N8PfOL5UxbFMyAq
        FrEEYdD4vV7RJ9ZOXPWMxi5nIAg54+0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-p0IyRmwLOqmI_yMJv92Acw-1; Wed, 19 Jul 2023 17:04:14 -0400
X-MC-Unique: p0IyRmwLOqmI_yMJv92Acw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fa8db49267so388205e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 14:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689800653; x=1690405453;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5UtvnYzoD0hTrn0V/d7YsuJa3bzzNU2UnBUdhkM6arg=;
        b=fSdNlR5ECzuorsYEvuZUN/Svjr7ha5+cb8cTgJsm64Qf/4k36kDhE0/n34Fr4ZGKX7
         Sxtzcdb6MIxyas+vqgWUAO2KR3S7145iaUagSEDfvg9IqOJp1uZ+Ll5KBt/r1znal5Cz
         4Ku+wBM1pB38VVbx67jvFeAVGFk9a6PGoOfcAPx0nnQwJIkjWXPNlSD2gE7QDMrc5bP5
         bq8wJ9fWmP654B+IQloXZOv9jqEk/eReEDw5w0T6avpZO84NT+SroNCAE4Fi7UimwSR+
         1R5LNoos+UgwAjUdI8slKWpcbwAJcqfTstHitrBd5yFHaoQ++5e2uRu4NyskvLS5JXyO
         lILg==
X-Gm-Message-State: ABy/qLZwZMMI43uF4zoqmLsCp7UkA4j0TvkMhw27MzrEUd4Iz5ALtVzu
        39c6p4zo6ZYnNUAyYv5/taivB9taQ9qHwuCSp0zEF6ndcjduAX1gR3BzaDNUiibFuZGdnKQvW/H
        pmmCBBBKgqSLmjgYPSLaMqE/9
X-Received: by 2002:a7b:c417:0:b0:3fc:a49:4c05 with SMTP id k23-20020a7bc417000000b003fc0a494c05mr2605693wmi.40.1689800652863;
        Wed, 19 Jul 2023 14:04:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGFMEBZUtWgLIXmLJGFgFBrBgcH+QPCPcyjvXHCOqZ4qj3Y2EJEdDf0aE7BHfrJp9fobuCGmw==
X-Received: by 2002:a7b:c417:0:b0:3fc:a49:4c05 with SMTP id k23-20020a7bc417000000b003fc0a494c05mr2605683wmi.40.1689800652592;
        Wed, 19 Jul 2023 14:04:12 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q22-20020a7bce96000000b003fbca05faa9sm2462505wmj.24.2023.07.19.14.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 14:04:12 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        emma@anholt.net, eric@anholt.net, tom.cooksey@arm.com
Cc:     error27@gmail.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] drm/pl111: Fix missing unwind goto in pl111_amba_probe()
In-Reply-To: <20230329171824.1159104-1-harshit.m.mogalapalli@oracle.com>
References: <20230329171824.1159104-1-harshit.m.mogalapalli@oracle.com>
Date:   Wed, 19 Jul 2023 23:04:11 +0200
Message-ID: <87y1jbipf8.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> writes:

> Smatch reports:
> 	drivers/gpu/drm/pl111/pl111_drv.c:300
> 	pl111_amba_probe() warn: missing unwind goto?
>
> When devm_request_irq() returns non-zero value, we need to drop the
> reference for drm device and also release reserved memory which is
> done in "dev_put" label. So instead of directly returning, goto dev_put
> to fix this bug.
>
> Fixes: bed41005e617 ("drm/pl111: Initial drm/kms driver for pl111")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on static analysis, Only Compile tested.
> ---
>  drivers/gpu/drm/pl111/pl111_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The patch looks correct to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

