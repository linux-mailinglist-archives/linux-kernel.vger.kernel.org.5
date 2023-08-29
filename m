Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D0178BC7F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 03:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbjH2Bxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 21:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjH2BxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 21:53:25 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8AD188
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 18:53:23 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6beff322a97so1912936a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 18:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693274003; x=1693878803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aPqDB6HyxDpsGqhk8YL0aBdN9XVTidEKj/nzhsE+uQ0=;
        b=EJd1g1FQM/Ry00Yo+7uGfJhpmU4a7d/6VYtbbdh2L12GboKKLAU/9UeIL7tp39oMTO
         sTYU8z9lrcnk6jYkRjufRG5eDZ/1aZbskhbqdyDr/5/1ZHWmi3QQsV1exXGLRBu+zz1k
         8Te/KLVYciKWafD6kwcyZtVok8ynh0Wvku/uYWK0nHB8EOf7hd3NiC8Xqe2PQlQCc7Ld
         Gt3k7jB3swC9pNYkvMKMgIv0PohgXF2pHiLTAFOMr4ePh3igSKwzJluW6QhcJqTx+5HR
         Gm706quI9Tii2zoN/Axnu1IjMJW81hOl4/bGmvLypKL+4v/k98Dk7/9xueETxXz1z1Dv
         tlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693274003; x=1693878803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPqDB6HyxDpsGqhk8YL0aBdN9XVTidEKj/nzhsE+uQ0=;
        b=OpImHrntCvAViaWHYxHlDOilsSKJ9kIr4cyZ4pHov0l75xm0yMC/MrwitNG0v1qHvS
         pDCH8Y/hTOpgDpOVTvHvwP/b5zLj1X/efTgHBMvpqO4lylgMGHI8Zvdbi2huN6rk9pZn
         gOsSNTo0a4snbhOnbSQeaSDM5UTy73V7l0w/24Uc9ZwaoGj470rkmFpqfzWh+/XWcs3f
         DVotum9DDL644Zz1gvJtNV2bXP+xuX5KMTrEZ8SGg2aXAM7wJkuMu4kO0P2gohPoCz2C
         6YAoiVVLs1PQHsNwfPnyf6RMBL3WMD1qUqVq+2oBIzhufXDmYPFQgXBDNs0pr5IdyoUa
         +oWQ==
X-Gm-Message-State: AOJu0YxMaX2Q9HloxxkyoeiJMLnW1pfU4NH3048Wmb71TpJVxjxQdAsi
        qh+uOaoBIWqZsxJQxAoMGJt44wBQsGQ=
X-Google-Smtp-Source: AGHT+IH0HXmDcEVHKigtPVbrNQDUoooZViS/VGLOlaEPaPB/gkEmZt8hfXp/hYJFYqw5Jh1KDtiJng==
X-Received: by 2002:a05:6870:d109:b0:1be:f0b4:b9bc with SMTP id e9-20020a056870d10900b001bef0b4b9bcmr13096144oac.39.1693274002725;
        Mon, 28 Aug 2023 18:53:22 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:c222:580f:7592:7110])
        by smtp.gmail.com with ESMTPSA id z43-20020a056870c22b00b001cd04c355d8sm4636394oae.29.2023.08.28.18.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 18:53:22 -0700 (PDT)
Date:   Mon, 28 Aug 2023 18:53:21 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 7/8] bitmap: drop _reg_op() function
Message-ID: <ZO1OiVVxsXALqlGS@yury-ThinkPad>
References: <20230815233628.45016-1-yury.norov@gmail.com>
 <20230815233628.45016-8-yury.norov@gmail.com>
 <ZN3szFnWIBtFwg9K@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN3szFnWIBtFwg9K@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 12:47:56PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 15, 2023 at 04:36:27PM -0700, Yury Norov wrote:
> > Now that all _reg_op() users are switched to alternative functions,
> > _reg_op() machinery is not needed anymore.
> 
> ...
> 
> > - * Can set, verify and/or release a region of bits in a bitmap,
> > - * depending on which combination of REG_OP_* flag bits is set.
> > - *
> > - * A region of a bitmap is a sequence of bits in the bitmap, of
> > - * some size '1 << order' (a power of two), aligned to that same
> > - * '1 << order' power of two.
> 
> Just wondering if we have some equivalent to the above doc in the
> existing kernel doc of users of this.

This comment is not fully correct because the code doesn't enforce
alignment of the region. Let's drop this part just as well.
