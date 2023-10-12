Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CFB7C6C63
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378288AbjJLLcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347200AbjJLLcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:32:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3AF94;
        Thu, 12 Oct 2023 04:31:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C491CC433C7;
        Thu, 12 Oct 2023 11:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697110311;
        bh=JT88/pQMAEEHyd2DZ85PSl0cJFk5DkcNpVpfgfRhK5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RPhkM87d2z0iM6l84Fp9uQg/4dFOH+ZVrQaPHqsy+3yesC9q0THnSjqT4bWtFDprJ
         02JhZlyYH5tWQeRy1CBw55ONaaDX20/F3HdOMdsGQirtkzPdSM/SvZkhwKu8wCfii0
         WCHbjjUuu6kmmcQfYylqg54GJDofdT3pRvOoMmBexHVg0yDQn77xdpqwHj/5vf4Trh
         NuG3EP68Im1CGo902RlysA09rU3mYC+AuNLT1QAKjVwbpRJdn86Et7YGbyzWNW6isA
         64jHXVWKVOb6RNhhR5bXFWt9UBpzdS/o9dDSXVmNVPzGdXrO3L/Y34e0mpYNRL+yXL
         zpVlIxa/bdGxA==
Date:   Thu, 12 Oct 2023 12:31:46 +0100
From:   Will Deacon <will@kernel.org>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the arm-perf tree
Message-ID: <20231012113145.GA11708@willie-the-truck>
References: <20231011172250.5a6498e5@canb.auug.org.au>
 <e8ca559b-421e-c326-f33-6edc8bfade@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8ca559b-421e-c326-f33-6edc8bfade@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 01:19:41AM -0700, Ilkka Koskinen wrote:
> 
> On Wed, 11 Oct 2023, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the arm-perf tree, today's linux-next build (htmldocs)
> > produced this warning:
> > 
> > Documentation/admin-guide/perf/ampere_cspmu.rst: WARNING: document isn't included in any toctree
> > 
> > Introduced by commit
> > 
> >  53a810ad3c5c ("perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC PMU")
> 
> Thanks Stephen for catching another bug!
> 
> 
> 
> Will, it seems that I had made another stupid bug in the same patch. This
> time I hadn't added the ampere cspmu document to perf toctree. I submitted a
> fix for it:
> 
> 	https://lore.kernel.org/all/20231012074103.3772114-1-ilkka@os.amperecomputing.com/
> 
> 
> Could you apply the patch or merge it with the ampere cspmu patch, whichever
> you prefer?

Cheers, I'll pick that up today.

Will
