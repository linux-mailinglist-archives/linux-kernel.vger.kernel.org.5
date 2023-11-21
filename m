Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB59F7F2333
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 02:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjKUBjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 20:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjKUBjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 20:39:43 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4492A2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 17:39:39 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6cd0a8bc6dcso3147380a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 17:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700530779; x=1701135579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fz4p3ZfFny6qJVN9sQ219rkze+bwswpB7VIcNz890As=;
        b=i5NR4lK3WQ8IHc0xKBtDOdlzAZ8HpI/FfUFh/ECrynvqlPR7/ED9SuTBlbIYmd+h+g
         VfV1ZViwopXVzSmfW/UUB3gA8z7CUDWHyfe2xcJ4AUfZybG5He9GV9ojAoHPQ0JqP7m+
         R1sgJhLRw3JNjO3U1HGfbLVKqb3s0b97574xcXjL+ZDecfJatlOIEnyNJv/pr6qkiulD
         S/limfo9VXpOljp2PxgA6n3R/Ky54CxBs9qe6Nuq4ghhRKJodcvt08airOtgMwI1JD9Z
         ps2p182h8/Akd/0eiT/eIXWSS52dGJ/+KdlmZHus4SxndJSO6ORnzK24jg8ak51hm9hU
         ixVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700530779; x=1701135579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fz4p3ZfFny6qJVN9sQ219rkze+bwswpB7VIcNz890As=;
        b=OxPSP0ViAdPtNwxb12PQA9r6K6wp8OofrSMncXaagFSUvcPpPE2cdHs/c/rH/2lbfr
         2mwzPFp1nt6m6+r/vjZi36czmdhKB1nP8bbwl6qbCr1yavZkGUz5f5GEoJCtDLcNgZNK
         uKsQNqtgLTh7g3pK3Ai2excMit6CtIVeO479/Y5Og8PW4zY2riDvx0vW1i+tWPpR0DWC
         DbBwlwDHlx3oSF7+S/CdeKQH5KrLonDnfa3jvWL0u5RmoiXC6mNfpjd9M8bZEgMUrrvW
         fxXaJzb2dI3vYItuGXGvY/3PMB6gdFdX6bKSeVl8DnRTfq9SQhohBM1KH+IiMSz74mU6
         XpvQ==
X-Gm-Message-State: AOJu0YzHvyC2HCx9r+eRK/j+iZtHlwx6xa/AkNJW6RVtgD7d6fI6C7wb
        nzSVjY7WbhIcTZdXNV/n2BJ4Lw==
X-Google-Smtp-Source: AGHT+IFpJxUvxxA1GysD6LVJ2r9vV1Nbcc/QLq4q22f/ResIN8lV5LRXcM9XYXXO7322vKdE/MGt8w==
X-Received: by 2002:a9d:69c5:0:b0:6d6:4f84:b5cb with SMTP id v5-20020a9d69c5000000b006d64f84b5cbmr9401174oto.38.1700530779180;
        Mon, 20 Nov 2023 17:39:39 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id cz23-20020a0568306a1700b006b8b55297b5sm1396727otb.42.2023.11.20.17.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 17:39:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r5Fjl-001AWJ-Cd;
        Mon, 20 Nov 2023 21:39:37 -0400
Date:   Mon, 20 Nov 2023 21:39:37 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommufd/selftest: Fix dirty_bitmap tests
Message-ID: <20231121013937.GH10140@ziepe.ca>
References: <90e083045243ef407dd592bb1deec89cd1f4ddf2.1700153535.git.robin.murphy@arm.com>
 <72f0e75b-6c91-4c17-beb2-3f198ed05cd0@oracle.com>
 <b541f87c-fa8e-4b09-bf1c-68829bc9e6c9@arm.com>
 <BN9PR11MB52768448A70C9B3CCB2CDE3D8CB7A@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52768448A70C9B3CCB2CDE3D8CB7A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 03:15:25AM +0000, Tian, Kevin wrote:
> > From: Robin Murphy <robin.murphy@arm.com>
> > Sent: Friday, November 17, 2023 1:44 AM
> > 
> > On 16/11/2023 5:28 pm, Joao Martins wrote:
> > > On 16/11/2023 16:52, Robin Murphy wrote:
> > >> The ASSERT_EQ() macro sneakily expands to two statements, so the loop
> > >> here needs braces to ensure it captures both and actually terminates the
> > >> test upon failure.
> > >
> > > Ugh
> > >
> > >> Where these tests are currently failing on my arm64
> > >> machine, this reduces the number of logged lines from a rather
> > >> unreasonable ~197,000 down to 10. While we're at it, we can also clean
> > >> up the tautologous "count" calculations whose assertions can never fail
> > >> unless mathematics and/or the C language become fundamentally broken.
> > >>
> > >> Fixes: a9af47e382a4 ("iommufd/selftest: Test
> > IOMMU_HWPT_GET_DIRTY_BITMAP")
> > >> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > >
> > > I was going to say that the second assert is useful, but we are already test
> > the
> > > number of bits we set against what the mock domain set after
> > > mock_domain_set_dirty(). So the second is redundantly testing the same,
> > and can
> > > be removed as you are doing. Thanks for fixing this.
> > 
> > Yeah, it's still effectively just counting half the number of loop
> > iterations executed, but since there's no control flow that could exit
> > the loop early and still reach the assertion, it must always be true
> > following the previous assertion that out_dirty == nr == nbits/2.
> > 
> > > I would suggest the subject to:
> > >
> > > 	iommufd/selftest: Fix _test_mock_dirty_bitmaps()
> > >
> > > Because dirty-bitmap tests seems to imply the whole fixture, which covers
> > more
> > > than the bitmaps.
> > 
> > Sure, that sounds reasonable. Jason, Kevin, would you want a v2 for that
> > or could it be fixed up when applying?
> > 
> 
> Jason can help fix it when applying.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Done

Thanks,
Jason
