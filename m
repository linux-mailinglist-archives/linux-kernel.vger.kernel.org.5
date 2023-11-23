Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09F07F68F1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 23:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjKWWUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 17:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWWUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 17:20:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762E2D7D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:20:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F3AC433C7;
        Thu, 23 Nov 2023 22:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700778019;
        bh=7fbNeoSMHGpALMDdzLxM+bodY1JGWwrIvuAaw9hIlVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NKMxBFRSCbc1AhzJCTfyxCJGH9spH6AU5XXJT/6hmCckYdBHdNEQFIm9yeYjY6T4R
         xSqnbMlvgV98aEbiEWOxVf88Ma50ve43eOWjuafrNDaK5nx5f+AEPaVJdOhvgbFwic
         JEyDNn1gYA0qVPxCAee08U/D/pA/yExlMNVnoAxED6qsOQjeKFDkGcOQR862sR+W4F
         EMuwqkzFrl7+3SfTn3cMAylMFPWj+QwZvyETBSYpCiXNguDN6Lgr0YcvXGEzNmnhQ9
         KR132/cjSFM9rdXqUid9d59MzYdmyP7w2+wlLRNGFa7GVv9lERIf+XKs/5A0b1AAsz
         mXPAe2zOnCSZA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 73F1B40094; Thu, 23 Nov 2023 19:20:16 -0300 (-03)
Date:   Thu, 23 Nov 2023 19:20:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the perf tree
Message-ID: <ZV/QIFsBVmn8BXKJ@kernel.org>
References: <20231124091458.535a0437@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124091458.535a0437@canb.auug.org.au>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 24, 2023 at 09:14:58AM +1100, Stephen Rothwell escreveu:
> Hi all,
> 
> The following commit is also in the perf-current tree as a different
> commit (but the same patch):
> 
>   a399ee6773d6 ("tools: Disable __packed attribute compiler warning due to -Werror=attributes")
> 
> This is commit
> 
>   57686a72da08 ("tools: Disable __packed attribute compiler warning due to -Werror=attributes")
> 
> in the perf-current tree.

Yeah, We're in the first phases of versioned co-maintainership and when
I tried to test perf-tools, now being maintained by Namhyung, I noticed
a problem that had been fixed on perf-tools-next, that I'm maintaining,
so I asked Namhyung to cherry-pick something slated for 6.8 to the 6.7
tree.

- Arnaldo
