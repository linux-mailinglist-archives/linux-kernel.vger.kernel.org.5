Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04257A1C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjIOKkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjIOKkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:40:23 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A384B1AD;
        Fri, 15 Sep 2023 03:40:14 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bf57366ccdso22520345ad.1;
        Fri, 15 Sep 2023 03:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694774414; x=1695379214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=buBIVholknHiWUJctiiDrt74bolRbOHTJ1nmcGC/y4c=;
        b=ZyWMmAOTeNAi30Ls5H2RBheiDyTpZzj4qN+4HSQ98n1jDHU5vrawaR/Gcvhx5Axdwp
         EKQkbjEtONTpPFKd8/34SYiBSuDiXH76nwJlStr+hepgjp/05zGr3h5o3/AIhMgZp6ck
         VpxggaB5zNGWY0FiVVOtRPU7WlW33g5eArlNKt8pzvbwH3pTR57yHizogd1gFLfiVAUr
         O7Hu1JOub+H58AM9R/1sVbLVf61OzJkNvGVVE0OSDJES3whaBnzN4+lRwU5P7BNTeePB
         8kJhn33TdIayIUi8UWuHkIYj2h3GZB4DqpqHmpjPZ30SayidnTm/TajLyCFytM6v3kN/
         BX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774414; x=1695379214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buBIVholknHiWUJctiiDrt74bolRbOHTJ1nmcGC/y4c=;
        b=eX5MU32+bveTJwjEOPqJ+GyNtLkPLgvvwkK9oZtVZM+Zy1skYU5E3/hl9RbBR4Y7QF
         lVXkIHutKpiMyWx/5lptfgGPHkgNjvKl7K5nTmAMWvAnw/sEsn/FzXJmgngVJPl0pVq3
         Q9+Z+knazguC85Io+KFj7qBJdtW5efempMf5c64dD7twjsCaXhtudsxFSzQi84LkelA9
         q4pMk00jVSDp2+tO4hRZgtQELYEnsH/CZFqDHO7ayeCSNkJ5gi6kUe1VaTW0ji7FCkBn
         7JAPkc96JhsSNq0KotrMLDx94LSjt89aK6vcwsJGK6e98IxWEIyBhGR1RSGbwkaxKscN
         mD/w==
X-Gm-Message-State: AOJu0YyEA+vKFk4S7kSCkbZ+V+hv0khDda8wB6Eq/7v4XQV5rh0CYyVk
        twjNz47HGJMRBJD+QMJ3enI=
X-Google-Smtp-Source: AGHT+IFCl8rJP+X5voFkMbpPc9mRMG0z9bYpbf/GMuWMKGwebJdeUijsk3q0w79tJBi4GxS4r6o4EA==
X-Received: by 2002:a17:902:f7d4:b0:1c4:314a:d045 with SMTP id h20-20020a170902f7d400b001c4314ad045mr1496684plw.14.1694774413981;
        Fri, 15 Sep 2023 03:40:13 -0700 (PDT)
Received: from gondor.apana.org.au ([2404:c804:1b2a:5507:c00a:8aff:fe00:b003])
        by smtp.gmail.com with ESMTPSA id iz19-20020a170902ef9300b001c3bc7b8816sm3183808plb.284.2023.09.15.03.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 03:40:13 -0700 (PDT)
Sender: Herbert Xu <herbertx@gmail.com>
Date:   Fri, 15 Sep 2023 18:40:13 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     thomas.lendacky@amd.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Fixes for dynamic boost control for 6.6
Message-ID: <ZQQ0jdhE2jPz3A8i@gondor.apana.org.au>
References: <20230829150759.156126-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829150759.156126-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 10:07:54AM -0500, Mario Limonciello wrote:
> Testing the code that is submitted for kernel 6.6 found some occasional
> problems with memory allocation and with the test suite and sample
> application as merged.
> 
> This series fixes all problems found. Ideally all patches should
> be submitted for a future 6.6-rc, but, the most important is
> "crypto: ccp: Get a free page to use while fetching initial nonce"
> if the rest must be pushed to 6.7.
> 
> This series merges together the two previous submissions, re-orders them
> and fixes one more problem found with unfused tests.
> Link: https://lore.kernel.org/linux-crypto/20230828190200.1598-1-mario.limonciello@amd.com/T/#m5f336a50707d2426c2a0d47d751f06d233e5c816
> Link: https://lore.kernel.org/linux-crypto/20230824221932.2807-1-mario.limonciello@amd.com/#t
> 
> Mario Limonciello (5):
>   crypto: ccp: Get a free page to use while fetching initial nonce
>   crypto: ccp: Fix ioctl unit tests
>   crypto: ccp: Fix DBC sample application error handling
>   crypto: ccp: Fix sample application signature passing
>   crypto: ccp: Fix some unfused tests
> 
>  drivers/crypto/ccp/dbc.c     |  2 +-
>  tools/crypto/ccp/dbc.c       | 17 +++++++-------
>  tools/crypto/ccp/dbc.py      |  8 +++----
>  tools/crypto/ccp/test_dbc.py | 45 +++++++++++++++++++++---------------
>  4 files changed, 41 insertions(+), 31 deletions(-)
> 
> 
> base-commit: 85b9bf9a514d991fcecb118d0a8a35e754ff9265
> -- 
> 2.34.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
