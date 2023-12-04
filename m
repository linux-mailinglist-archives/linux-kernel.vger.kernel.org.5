Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEC780413E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjLDWBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjLDWBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:01:06 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877E8CE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:01:09 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-daf26d84100so3232282276.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 14:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701727268; x=1702332068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oc/GXcQ5TdH9uX6PH8oOx7GVdlrOYjtkMgUTSDiO3FY=;
        b=bBjynOBEBujNMLyEVwZY0WnSPAE9OZt8i2S3Zz8uMW4Ig1xwyqaOHOMLUVnbu7MiQx
         XFBg3dE29ce10FwivaBRDd5pAhD43WTLosuGjYL3+dTIaJeYaN2v9NsQRUwcOT7CHWM0
         c8WwEcJ9ZiegSWU4xkxpSqc2FrPKZVh2LRWymnWiDKsh/mRXAR8ECcVF/NvVkQHaASMx
         zbOYPzOkj7YebMwDmbybF+vKZ8xv/xHscQA89nXYvqFZ+Qjvilg28XGhDcSC30slNLWW
         1DwRVSUH3pRPSC+FvcAkQFuxk7UO0aVGeUNQ88yroCVn6R1JmYEw06XMIwLw2bbu/Ia0
         zQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701727268; x=1702332068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oc/GXcQ5TdH9uX6PH8oOx7GVdlrOYjtkMgUTSDiO3FY=;
        b=gtrmVb3gUZmoUW02f14rARKIUFl19Xl4SHXZ/JsqL6ddHg1w7fv7HT3LRUilRkJS1G
         FWWtOwS7XwpE0uwOOtPhGBr9nnfVF2TFcXnSU2PXwBGSotMAYQVr1e3IXBaWB/GiDqtf
         C9sGFLyvIIsYrtjChjtPb4l+Gu7T4AN1xYH64crV0p9KCSNcF4TYQgoQeKrOSCkXYKWR
         5w0ZwpKHwvllMTvSuW20CBBzGK4+/VGV04RqX1Ll7KtUAfkUIWbYx1eCBbu6Qlmn48oQ
         XP4s3w9X0Ydkz3nNVIzoOmk0fu43qkkWHXQxaBGnEO5f1y4yBboGuwyRQqlAN4peAUwa
         HChQ==
X-Gm-Message-State: AOJu0Yy6sS1yremGyiklPvxNZ1rroziz7YtpE8fZXKxpL/OscvVVqzts
        rM7iRyThTAJeyCDkd+JgFiM=
X-Google-Smtp-Source: AGHT+IE6jDhTFb4UNp3u5XLhqBlm+xyIgrDSLYxNTnd+2N7d8uajzC1jHy8Pog4zSHJrjfMI1EsFgA==
X-Received: by 2002:a25:a381:0:b0:db4:af02:6626 with SMTP id e1-20020a25a381000000b00db4af026626mr2889862ybi.29.1701727268561;
        Mon, 04 Dec 2023 14:01:08 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:23a3:8e55:76eb:c0ca])
        by smtp.gmail.com with ESMTPSA id x32-20020a25aca0000000b00d9a577d8434sm2610410ybi.53.2023.12.04.14.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:01:08 -0800 (PST)
Date:   Mon, 4 Dec 2023 14:01:07 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 0/4] lib/group_cpus: rework grp_spread_init_one() and
 make it O(1)
Message-ID: <ZW5MI3rKQueLM0Bz@yury-ThinkPad>
References: <20231101225820.51342-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101225820.51342-1-yury.norov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On Wed, Nov 01, 2023 at 03:58:16PM -0700, Yury Norov wrote:
> grp_spread_init_one() implementation is sub-optimal now because it
> traverses bitmaps from the beginning, instead of picking from the
> previous iteration.
> 
> Fix it and use find_bit API where appropriate.
> 
> Yury Norov (4):
>   cpumask: introduce for_each_cpu_and_from()
>   lib/group_cpus: relax atomicity requirement in grp_spread_init_one()
>   lib/group_cpus: optimize inner loop in grp_spread_init_one()
>   lib/group_cpus: optimize outer loop in grp_spread_init_one()
> 
>  include/linux/cpumask.h | 11 +++++++++++
>  include/linux/find.h    |  3 +++
>  lib/group_cpus.c        | 29 ++++++++++++-----------------
>  3 files changed, 26 insertions(+), 17 deletions(-)
> 
> -- 
> 2.39.2
