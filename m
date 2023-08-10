Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D51B777E51
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjHJQav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjHJQau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:30:50 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF63FC5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:30:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bc6535027aso9710745ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691685049; x=1692289849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BwRQL+AWUvKim0GQsGEOotK3a8TzoberHriHLEkkia4=;
        b=mzJNdH7j3KXWCdbERyami1eWUZrwE1hCaBSAo2i2Oto6L8ZP39PhBlRnCfAsbbulgv
         eWCxmIW+10HSi6CFKRHF3Zs2BZo7EHHSnVqypjjcyFCCaEyu64D9xJ8wpGX/uEH8Ma6O
         y8LsxBXxMvGK/y1/PHiUlqtc/WXJFgih0Q1E9W43g/xd5E51ZDLkuveYyZZNgVqpBL2t
         a4IJ/+dyfJkqZAiec1G/jo9wG4imwZCXdQn/yDJVlhdzVL83GMHz0pId5BEMkLS6qEEj
         ZeTFSEhHNiApWuGK31f60wQ3Fjjct7i8IniyRZOSpLnmyRyeQe9X5tZZtt6RYeJiWbZP
         +4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685049; x=1692289849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwRQL+AWUvKim0GQsGEOotK3a8TzoberHriHLEkkia4=;
        b=gPyWPaE+aRA8uERNuE/87tM20EMVfNlsoBMwFJoBjF/szDrvAuL9OAvWyxpttKTNFE
         1l++Q8GpLnWw4D/rLBDz75OXUwJwuFjmioPqbGlniqOSIfBTH1gWjynKzSNsLGjEE35R
         qwvVPgR91Uh3FtZZ180knA0QnNkgp6EXqIDIPgz5lSsyMKGQLyF+Hd9+cx+oTEMNbyoD
         fg5eTc4k3IGL/YyvQdZStIJ8+tm8IxNatNlrvSY4OOkSwZJe7M/8J7K+tyz5bsquzs2q
         BN9GKsDoDCfRFsspLq0EIfF0BRHhf+Pt20T5200UFvxb/6GzlUGg3MJ98MESARnvisdl
         4bxg==
X-Gm-Message-State: AOJu0YzkuOrbmArd8hjUq5TDRIsGbK8iEfc1X/iLFY72wH7ZKClR1zeH
        jrwYoKGN2Eq0EIC0G1oKgp8mE+f8TtYZdTew1eE=
X-Google-Smtp-Source: AGHT+IE+7nKHZqP6buWiqUSlddecY7m4E5CwyR8YNx0+cTrP4l5fwKqhcNkHnbRErSgUOFxWvM8zqg==
X-Received: by 2002:a17:903:32c8:b0:1bb:9b29:20d9 with SMTP id i8-20020a17090332c800b001bb9b2920d9mr3723397plr.20.1691685049135;
        Thu, 10 Aug 2023 09:30:49 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902788300b001bbd8cf6b57sm1980870pll.230.2023.08.10.09.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:30:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qU8Yh-005Gyn-01;
        Thu, 10 Aug 2023 13:30:47 -0300
Date:   Thu, 10 Aug 2023 13:30:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Zhang, Tina" <tina.zhang@intel.com>,
        Michael Shavit <mshavit@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] iommu: Call helper function to get assigned pasid
 value
Message-ID: <ZNUQtluLWek3PnEn@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-3-tina.zhang@intel.com>
 <f3d8692e-b13d-97ee-2288-c2be1858dcfa@linux.intel.com>
 <BN9PR11MB52767F29A6C11157659D375B8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c0e94e88-94b8-69de-69c8-ed132ae28951@linux.intel.com>
 <ZNOnOGTfpXzrrRTz@ziepe.ca>
 <84494c88-66eb-a731-fbf0-4a83fb9102f1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84494c88-66eb-a731-fbf0-4a83fb9102f1@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 09:37:09AM +0800, Baolu Lu wrote:

> > The core could put the mm_notifier in a common iommu_domain_sva struct
> > and it could stick in the driver's invalidate ops, that would be a
> > nice simplification (and discourage drivers from doing the crazy
> > things they are currently doing)
> 
> Yes. So the iommu driver can retrieve the sva domain from struct
> mmu_notifier. The callback implementation will still be domain centric.
> Hence, there will be no need to use mm.

Remember the driver always needs the mm as it has to extract the page
table address from it.

At the end of the day installing the notifier is a single call in the
SVA alloc op, so it may not be worth optimizing beyond allowing
drivers to do it in their SVA alloc op.

Jason
