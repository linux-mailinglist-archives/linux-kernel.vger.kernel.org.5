Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E5F7C6E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378548AbjJLMaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjJLMaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:30:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5A8B7;
        Thu, 12 Oct 2023 05:30:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705E7C433C7;
        Thu, 12 Oct 2023 12:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697113816;
        bh=yVocBoSmcdTl7F76wuVD4cWB0m01bOLi77HrEVQQ42s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JGIAjR1TNCCcb2qQDVGzA/52tDUcLwv/Fe26Tj9aZzjqVV9PX6gxVj5Xfez0Jk3RO
         sP15dGuTaLi8w05SzF63UzS7KFbgvNyzNeFZ8RHEAFlEM48pBxeP1OcIUWj19B4tFp
         ZntFuMEP4h9P62XqNL+Pf2LmJDdbxOJ67Erya3Z5KItu9QOuzaFP6OIMXr7ePp8B2Y
         gBkERdjIGO8GtiTktRA1gIgk4kvdZoanZqzXHWuukqH6UPeZ8hjA6MLLUENP+Wr4qN
         CNyAH1WPlVXnDgSRloK0bo97ycINo6/K15AvLD5bsTldRKMVvMb53nKKjqxecrHpad
         k9f7/SucMDqZA==
Date:   Thu, 12 Oct 2023 18:00:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the dmaengine tree
Message-ID: <ZSfm0wDCFD9cewrS@matsya>
References: <20231010145412.4a758f9d@canb.auug.org.au>
 <CAL_JsqJkEutiwWdNe336pWbcLsHK9tNxHNYVOAACt_ncaBdBXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJkEutiwWdNe336pWbcLsHK9tNxHNYVOAACt_ncaBdBXQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-10-23, 08:41, Rob Herring wrote:
> On Mon, Oct 9, 2023 at 10:54 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > After merging the dmaengine tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > drivers/dma/mmp_tdma.c: In function 'mmp_tdma_probe':
> > drivers/dma/mmp_tdma.c:638:36: error: unused variable 'of_id' [-Werror=unused-variable]
> >   638 |         const struct of_device_id *of_id;
> >       |                                    ^~~~~
> > cc1: all warnings being treated as errors
> >
> > Caused by commit
> >
> >   a67ba97dfb30 ("dmaengine: Use device_get_match_data()")
> 
> FWIW, my patch has the above line removed. Seems it got dropped when applying.

Looks like it got missed while applying the patch. The patch had a
conflict so I had to manually apply this one...

Sorry to have missed that

-- 
~Vinod
