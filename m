Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F007677F8BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241310AbjHQOXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351675AbjHQOW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:22:29 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3CD2D78
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:22:27 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-76d8598d023so10542985a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692282147; x=1692886947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTKJUUXOGyIJAU+qtBiufGP3U/3Kch3ieMrfhSVgec0=;
        b=EfNT3+vt+iIsTZniixXS9HICQ3ETlydByp4X881EphJBqGj5obEWHd1x64/2BnGTxJ
         isHZYSCt0aCKo7xnafx1RPput0UOVW/dmIt3ZFOW6wVwQecL8FHnyv6tyAJpgmAG8yaL
         w1lCQiPaavAAZepvAcvqBDIKcNjF623xc/WNz3sj20rwfDGXlf3Pn/1AX2Ub7lsSCvOW
         IcKyzzeB9W+C1V7TMmgwTP7ZtxmQXksEo36I3BmzuLNkDNy/WiXCSHWPO3otI28plWfw
         Zi0UrgvApJ06wZv10w78boGHi+KciT5LcJxnZwfB2wqj90/Nt8PGplFFkJjh+Jcdorz8
         5uIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692282147; x=1692886947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTKJUUXOGyIJAU+qtBiufGP3U/3Kch3ieMrfhSVgec0=;
        b=AL//iiOLiqnbObcXuaahdoLSOlDn37L1gqs/q05D0Nfp3aaFbMh6smCNA9eEqFHnEU
         xqrlZy3N7svvK7vmm28XQcbsHz6w6aoQFa8ircP3SoUr6NjCb5jpSSHEyN4ZZncygKtx
         wk9dBEsQg1oiEzFVTTGrmrTntcJoUmi2Te1vzT9++YHJjmHVL5gJjLJGsbz2Cd7NOcfB
         2hcQ1EzIMDznrm3pKpmmX/D5lpzimGEJgdIcsnPex2Vom2xxJw6zGE6Unp/R4C0iDomA
         lnfXHegRcZUss9s5HNNOYgK8o2s0Og4cWBq3O5t+ry7hK30qPdLoN5Ws3lsR6sOvIUiN
         QvSw==
X-Gm-Message-State: AOJu0YzQvGpa6w+ZL9NkAW4Zqm2hvSW/QcP15a4BGAl4jH6kkSQRlLto
        VJ1lLQBOBEF8FqOd3UC5H+o=
X-Google-Smtp-Source: AGHT+IFocFIbRPfWFQMMde3ZYxUkNFLkWGo0GdfP/e2GZfJkVu8lxW3yNv+BqqqtwgxmbTgrgke2EA==
X-Received: by 2002:a05:620a:4ce:b0:76c:a187:13be with SMTP id 14-20020a05620a04ce00b0076ca18713bemr4949856qks.33.1692282146798;
        Thu, 17 Aug 2023 07:22:26 -0700 (PDT)
Received: from localhost (72-0-147-214.static.firstlight.net. [72.0.147.214])
        by smtp.gmail.com with ESMTPSA id pj23-20020a05620a1d9700b0076cb1eff83csm5179918qkn.5.2023.08.17.07.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:22:26 -0700 (PDT)
Date:   Thu, 17 Aug 2023 07:22:25 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 1/8] bitmap: align __reg_op() wrappers with modern
 coding style
Message-ID: <ZN4tIS/aYYPUr6qv@yury-ThinkPad>
References: <20230815233628.45016-1-yury.norov@gmail.com>
 <20230815233628.45016-2-yury.norov@gmail.com>
 <ZN3q5bWbnKM9+gwg@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN3q5bWbnKM9+gwg@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 12:39:49PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 15, 2023 at 04:36:21PM -0700, Yury Norov wrote:
> > Fix comments so that scripts/kernel-doc doesn't warn, and fix for-loop
> > style in bitmap_find_free_region().
> 
> Suggested-by?

Can you send a full tag?

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
