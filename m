Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24FE7F0754
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 17:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjKSQKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 11:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 11:10:53 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27100115;
        Sun, 19 Nov 2023 08:10:50 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ce2ea3a944so2393844a34.1;
        Sun, 19 Nov 2023 08:10:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700410249; x=1701015049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMPok4D9/QSUfFfjq6BiCPnsEb+f1dMGbNfAYEACL7I=;
        b=etXaWBEpGONNYt9viNh5nXE1t8rHKNGio5LCJ61asYB/NoljpiD7Ztc7kznKFG7TCm
         fxmKO3xv6gp4gUlNN0yDFrjYb0Xhx3e66wVgbJgTbFqT5W9Jf7Bk0lfjll0gxDvS1pc8
         Tzkv1JSrf4xZfI8Amc1/femSqC1vqUzaGXm6JQnjsKBKSWpT8+SpEoHCJdL4XI2jBgB9
         YJ+WnYO5+eLkLnP5C3tTIIv0+N+sjJOaoeMVy5fNdO+Oyky/d30nELShPEFVVznkYrYi
         3vbCJQdQhcpnS91Lms2Ivaubvm1BzFE08sE/+H+hpJk6d5FTK07pmcroBaJbmtBonY9h
         X/1g==
X-Gm-Message-State: AOJu0Yw7FeazQwWWYZrwUxfqh8z1b58DedWosZ86eoHtViIo4LyGgTXn
        zSdkeQcEKNoqjADY4Cgqv1dmgBFWQQ==
X-Google-Smtp-Source: AGHT+IEOThGIDSgSK9nz9zWYj/SN2RcrArceBS6o4Op4+EPrEkWYEhzzxGaP4hWr2ugRIjkhlgg6lQ==
X-Received: by 2002:a05:6830:1659:b0:6bb:1c30:6f3c with SMTP id h25-20020a056830165900b006bb1c306f3cmr5763754otr.0.1700410249458;
        Sun, 19 Nov 2023 08:10:49 -0800 (PST)
Received: from herring.priv ([2607:fb90:45e3:889f:15b4:1348:6d64:224b])
        by smtp.gmail.com with ESMTPSA id d9-20020a9d5e09000000b006ce29a19dcesm909733oti.26.2023.11.19.08.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 08:10:48 -0800 (PST)
Received: (nullmailer pid 274769 invoked by uid 1000);
        Sun, 19 Nov 2023 16:10:45 -0000
Date:   Sun, 19 Nov 2023 10:10:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] of: fix recursion typo in kernel doc
Message-ID: <170041022905.274386.8341020207978607741.robh@kernel.org>
References: <20231117171628.20139-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117171628.20139-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Nov 2023 18:16:28 +0100, Johan Hovold wrote:
> Fix a typo in the kernel doc for the of_platform_depopulate() functions,
> which remove children "recursively".
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/of/platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!

