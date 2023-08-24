Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073A97879A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243599AbjHXUwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243613AbjHXUwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:52:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F5E1989
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:52:08 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-26d4e1ba2dbso152066a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692910328; x=1693515128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WkgAkzmNzUul7+4VgInIuDX0DKPGv7dGSQvEsL/Tlso=;
        b=Ts3iXctWYE/25qlkNAS9UaQol0lI2gmph9BUtF5lYFzOvUS9wExVj6Ha68dD/GUIN/
         qHDJz5zyZbYySARDheNK66yH0bpWF1+Ro0dtHyLvsLdhIbKr52/NRPK3oCpUES2Etvqv
         Y0qsbafjgkkMejKctuSMSOMt2jXLxSAapMk+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692910328; x=1693515128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkgAkzmNzUul7+4VgInIuDX0DKPGv7dGSQvEsL/Tlso=;
        b=iUNOvc1EXFVNRyoE3dvxZmAynBhxZMr5y06Ku15UfkHXrCHgjwx41WC5A/TAz8kc+V
         Ehhrzr53piXtgkYLldx4FGZ9fZIzedumkNeTLgGC1A2JM2YEVKjvdvExQyqIPKZn2Sf6
         P8GELOJjzxVPaF+CZgm7D4vgYK/FdhLRM31HtEF03ciC7CLkjsCBQcJfl5NYIXfkexYs
         oEnTEY//BATDpyLk7XEpvyjuYbJ/vX0MncL1uUaleOqViltub6CSB8NEeY2QpOMM6flT
         xF3rpQUvPpzFjRKLXq98mUfKYd4VQO/LFTWlKO9aF2ABHC7Fg6uKE/Ui9yyhftoyLLad
         7OsQ==
X-Gm-Message-State: AOJu0Yx/6LBjs3YJyQlFsTXMPuDZrU4EGd3Q966pdxwQm71DU0R/Va5s
        A56+5V4HIPzM1kgg+wUcb+7P7g==
X-Google-Smtp-Source: AGHT+IEjtBiHPtNVLZT2gtMXvB9U83RhiwJfuikZH5BTPX+/cK58qVsSMrLFEnwlOTZelEg/vyUwqA==
X-Received: by 2002:a17:90a:a615:b0:263:4305:4e82 with SMTP id c21-20020a17090aa61500b0026343054e82mr12727466pjq.6.1692910327753;
        Thu, 24 Aug 2023 13:52:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a01d700b0026fb228fafasm2156603pjd.18.2023.08.24.13.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 13:52:07 -0700 (PDT)
Date:   Thu, 24 Aug 2023 13:52:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yonghong Song <yhs@meta.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Song Liu <song@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [linus:master] [kallsyms]  8cc32a9bbf:
 Kernel_panic-not_syncing:stack-protector:Kernel_stack_is_corrupted_in:test_entry
Message-ID: <202308241351.E3467F14@keescook>
References: <202308232200.1c932a90-oliver.sang@intel.com>
 <202308241323.ABBE0B09B@keescook>
 <SN6PR1501MB2064F8313A3AD64E6F69C2D5CA1DA@SN6PR1501MB2064.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR1501MB2064F8313A3AD64E6F69C2D5CA1DA@SN6PR1501MB2064.namprd15.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 08:41:03PM +0000, Yonghong Song wrote:
> Debugging now. I already made some progress. Should be able to send a patch soon.

Great; thanks!

-Kees

-- 
Kees Cook
