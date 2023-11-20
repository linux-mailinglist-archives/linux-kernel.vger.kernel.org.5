Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931C87F1548
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjKTOHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjKTOHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:07:40 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A385AED
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:07:36 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-5842ea6f4d5so2874536eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700489256; x=1701094056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=92tZ6SZMCW6Rm9Jpds4d9aM0YVAWPI0Lxc7DBxrVWsM=;
        b=LKcOhOq/EOiAEkFRV9E1A8rWYh7/6zhn1WCR+jMrADZM6h2UAl6ewM/EA4CauJzAZC
         jMkeWhSbrs151nWyoGbzi+yZ7zHNwuEwZOCPt3DpPh43e8CBIKO6VGZoW6KZJSQrHdSQ
         HObxT3Bv24xN8EiY0DT6Oyp/RciAmFcQ/vhJBr80B9jHK9EVxj9bFF5LmG6W2e10zgeb
         v2lmX26GNZa2oFztkqWwrA+V44Bb/jXCiFqLx2TQf4RFcrehuyit25Db/qA7sFAsMbX5
         +tNiMpzHZt3jcN2KmScM23Xg8TFWjXi6zqMjbBlfnjPBWpaltOlrVBbN3MI1Vh+ycvdo
         l98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700489256; x=1701094056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92tZ6SZMCW6Rm9Jpds4d9aM0YVAWPI0Lxc7DBxrVWsM=;
        b=A8HU0Mu3IlI3btSPiZ5HPlTWFM/hZX11tLWFb7gk1+Qm2BCmRUWc3l+6/hTSof4cd3
         t4Myy7qFryLewrqt1Sl2jc8knlyApTqMpxJziY+8l4J4GGxc1IEl0WSOuoyE9a/sAY9n
         Em36PPjUPWJWKIoH4I9WIGa08Y+Ql7pFaz2jbL4/ePkHFuXM4Tmh56wolCAcapMQFjjZ
         SkC2fFVV1U8VMANFXvnWwmJ6piN34fuONTuFFtuaRfbDx02Jc5DIEvMgfThhwcQYKhIb
         Z4/FuL3Q4gwLEin94z6eL9zF21mEtcFJD/k+wxPI7euKBio6sUUxPrEosY6lGnczVr2G
         2SRw==
X-Gm-Message-State: AOJu0YzRxQQ2+wtatM3Ga43mYwXp/tp3/Yhpjld23Z8IUtlffDNHfNwL
        IZQM+cHKJtJlTyrdotP+Ft9BkQ==
X-Google-Smtp-Source: AGHT+IH6nCadtndcP8MoadqJOEI1uE2x4sdLOvyEq8pu1hVPGC0TaARjdXuTNslbQyHvhistT7ejrg==
X-Received: by 2002:a05:6820:81f:b0:589:f58f:8641 with SMTP id bg31-20020a056820081f00b00589f58f8641mr8070209oob.2.1700489255838;
        Mon, 20 Nov 2023 06:07:35 -0800 (PST)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id e189-20020a4a55c6000000b00586c4324f5dsm1460999oob.35.2023.11.20.06.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 06:07:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r54w2-000Hy2-EB;
        Mon, 20 Nov 2023 10:07:34 -0400
Date:   Mon, 20 Nov 2023 10:07:34 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, kunwu.chan@hotmail.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Set variable intel_dirty_ops to static
Message-ID: <20231120140734.GC10140@ziepe.ca>
References: <20231120101025.1103404-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120101025.1103404-1-chentao@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 06:10:25PM +0800, Kunwu Chan wrote:
> Fix the followng warning:
> drivers/iommu/intel/iommu.c:302:30: warning: symbol
>  'intel_dirty_ops' was not declared. Should it be static?
> 
> This variable is only used in its defining file, so it should be static.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/iommu/intel/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
