Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A5577D6C0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240691AbjHOXm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240686AbjHOXms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:42:48 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5682EEE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:42:47 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bc6535027aso50618835ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692142967; x=1692747767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9HYr1Aa4PHzAugaKMGkSYZ3gAM2S9a9C7k1A47R0zUU=;
        b=d6NGrT25Uh5WOXqmt/k3/T4Z0t3JfIp1PJ62+ygIXCN5ci1rJ+A8XifHuGgRU+Iinj
         Qr9iZ9hqVtbpl2cVoQGppUtqUZov0jxiWsP94hmHue3Lc2P1CbT2fG1dfNRU3e1ckeYJ
         PBkGMadvlxy8iENmndgEj3sybuR7NMWy7B8kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692142967; x=1692747767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HYr1Aa4PHzAugaKMGkSYZ3gAM2S9a9C7k1A47R0zUU=;
        b=OFjL1R2EoFyD+ApH2+vOcTnJMV3q2/PD1qxl50rWmzq0b5ecF6J2knrCaRCJtM+iyS
         TnF52QNVa3pI+JIjXO2a1D7ZNv4n1NUUCXpcIobvx9XaWiudQmYpJ1WwXLQUa5wXWOFt
         wS8c3thaLTa6KKrclnB74P/OZ7wrRZtTooTzFs5eS1izjKEdedlfl8yUULj6qQPLFmHT
         7uv42b35fILhGyHmpjGV3cOJaNNtgvt9/VEdeP/qWYi7ifu6psB9734V2AYwmyLl0acc
         h0KOaQA3ORz6Kluykxu+36MxXlN34LujwvLiMKnU9ImjX7cg+RZ0BUR7YNn1SPH5Hr9t
         kwKg==
X-Gm-Message-State: AOJu0YwX9+UdykSomIJhl93N0ZAhZD0eTc6WhEiXGOhnnq18jQ/JwlwB
        hrj9n3l6UykI00pcjP0Gpymoyg==
X-Google-Smtp-Source: AGHT+IFAOQvRUU8M3Rpb0rD1ZLegHuxAb9k+mwWRNryWePOb5xy8WMyHkXB0HFCAlm3zWl3xYrtXpA==
X-Received: by 2002:a17:902:e80f:b0:1b8:e41:f43f with SMTP id u15-20020a170902e80f00b001b80e41f43fmr386294plg.27.1692142966793;
        Tue, 15 Aug 2023 16:42:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x20-20020a170902ea9400b001b9de67285dsm11656216plb.156.2023.08.15.16.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 16:42:46 -0700 (PDT)
Date:   Tue, 15 Aug 2023 16:42:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/mlx4: Copy union directly
Message-ID: <202308151642.794EB1B64@keescook>
References: <ZNvimeRAPkJ24zRG@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNvimeRAPkJ24zRG@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 02:39:53PM -0600, Gustavo A. R. Silva wrote:
> Copy union directly instead of using memcpy().
> 
> Note that in this case, a direct assignment is more readable and
> consistent with the subsequent assignments.
> 
> This addresses the following -Wstringop-overflow warning seen in s390
> with defconfig:
> drivers/infiniband/hw/mlx4/main.c:296:33: warning: writing 16 bytes into a region of size 0 [-Wstringop-overflow=]
>   296 |                                 memcpy(&port_gid_table->gids[free].gid,
>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   297 |                                        &attr->gid, sizeof(attr->gid));
>       |                                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Hm, why did it think the union had a size of 0?

Regardless, it's a nice fix:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
