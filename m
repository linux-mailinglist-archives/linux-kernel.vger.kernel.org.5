Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE34C80E795
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjLLJ25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjLLJ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:28:53 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84CCD5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:28:58 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1f653e3c3dso547321866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702373337; x=1702978137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKYfbzXvsGiIbL9qJvWj9hTGg+l4DhDjhcdJ8y4v1Ig=;
        b=OS9TZQ6kGk2UktQhN6DPCxP7vZPulo/jwmBJV6ZOHX6UTGwypSq1Ra1YC3tQF7o4a1
         4qXbDNWrNrFyZWHxq/02F6Nz9ZkoFbaej7LVUbBNDJXnExQiSF61GYPviZDkqVEokPeM
         WITsrvjsYP0KYjnAlyOHj4NdlKCpudRFALhwKCwFsd2hQGEnHC/YaKWZjoAdArFvE0S0
         lBA0TF0Zk0pm0cCSy2LFj5aJ+o8u2ChC680stcfqT1+wKlj0tSfSYnRJk8J4XJQtMFbR
         9b57FJHt2bSaPi8MyHOpOeTFtBxJ02TlkaEs3C7e8P9SPFtTpZWmCX9HJUndDkK7wuWt
         7HgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702373337; x=1702978137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKYfbzXvsGiIbL9qJvWj9hTGg+l4DhDjhcdJ8y4v1Ig=;
        b=O+7dTtpXAYUpOW2I05JpNrcd1ZPX52JEPnnVqOoGeZdhhZGk0T3vR/eT81eRijXsLC
         AiEtDt2iFccfct0gaH+TLTZ8nLWqc6TdfeQsoBftggKV8wSmw177Zt/T+ORckz5KxJ40
         XmWpv+DXqsIDETG7n5S+f5N+G//Gtmp31oiqBrVyZbIeOg/ThQK19tNQoH+CeDeug2gt
         6oXqQGbMvMZcWlt/rjYuc1/JyPL6Gr0aytyTI9JuxE1QIL3hfnefDC/h/19ORr/boPh/
         NVqEI/slHE+p4bAyOTi+02RAaXtI+d8YIRSifJPlinvFgxvtFh7CLCMCgFlfnu418SJo
         Y/Mg==
X-Gm-Message-State: AOJu0YzJuLFs06UFRg3W7kXINX+5XVcSDKt1Dewi4o/fSQGBXWRy+L1b
        Eyp+sOcb+nzMt6gSoR2RNdd7YPAyi/eu0ufPzTQcNQ==
X-Google-Smtp-Source: AGHT+IElj6uAARa1VhxPpt1aC7/JAi9b0TrKriiDa11dI+XgV5IVc8hDp+tZ/d2/FnhieF3uoumzFg==
X-Received: by 2002:a17:906:1054:b0:a19:d40a:d260 with SMTP id j20-20020a170906105400b00a19d40ad260mr1687357ejj.300.1702373337115;
        Tue, 12 Dec 2023 01:28:57 -0800 (PST)
Received: from localhost (h1f2c.n1.ips.mtn.co.ug. [41.210.159.44])
        by smtp.gmail.com with ESMTPSA id tm8-20020a170907c38800b00a1e30528af3sm5903254ejc.47.2023.12.12.01.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:28:56 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:28:51 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Philip Li <philip.li@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Luca Abeni <luca.abeni@santannapisa.it>
Subject: Re: drivers/video/fbdev/amifb.c:3375:32: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <3d090a79-7566-4e52-a875-76eec7b794b1@suswa.mountain>
References: <202312051741.BVXr9CRP-lkp@intel.com>
 <b139b275-ee57-4026-83d3-7d49ae04ef49@suswa.mountain>
 <ZXexaBTvLH9Espqn@rli9-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXexaBTvLH9Espqn@rli9-mobl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 09:03:36AM +0800, Philip Li wrote:
> On Tue, Dec 05, 2023 at 01:06:45PM +0300, Dan Carpenter wrote:
> > Something went wrong with this git bisect.  The Sparse warning predates
> > git.  The file was renamed at some point so I would have thought the
> > bisect would point to that.
> 
> Got it, Dan, we will investigate why several reports are bisected to this commit.
> Sorry about the false reports.
> 

Not a big deal.  It's been a while since I've seen a wrong bisect.

regards,
dan carpenter

