Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5538792633
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348617AbjIEQSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354870AbjIEPOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 11:14:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B592191;
        Tue,  5 Sep 2023 08:14:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E1AEECE10C2;
        Tue,  5 Sep 2023 15:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9375EC433C7;
        Tue,  5 Sep 2023 15:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693926881;
        bh=MZxTQDzJvL3TKBJNWbi9qEr79IBFR2kYRZ8zfG3sVtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ooglhayVbYjqTRt3Zcgr4L3EZ6hQTlB2Y2JzzB9M5z9u9B0ZS0l/WDjCZLnwIGTrl
         7U8cMIqE/QLjvdRdDDZiUMCbauATB8gi7x/ZoqSP52J2uAbC9Fmn4yLiUvldPicDuK
         S8GqMDYxrKLlPyXwAcpNn3ycBD/fILkFqrPp+ULMoACZcUUKa0VFSZmQ283b5PEuv2
         JaKCllNqV3SgauysH/VIYuMG284xPSXjY0X5ycfGiNHqX7mtpgNlb0Y/1NanrgMLRq
         91Owc/PaAwDW5oqeBXdoA6xvSYOhnucprNoVIn2WwiUntTlMfrjrU/huLhaIMLjeP3
         MWD1kviohfq9g==
Date:   Tue, 5 Sep 2023 09:14:38 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Claudio Sampaio <patola@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Linux Stable <stable@vger.kernel.org>
Subject: Re: Fwd: Lexar NM790 SSDs are not recognized anymore after 6.1.50 LTS
Message-ID: <ZPdF3uqbJNSZADzv@kbusch-mbp>
References: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>
 <faa245bf-e925-45b0-9827-b0c9c117e06c@leemhuis.info>
 <ZPc8v9-lHF4jAcxL@kbusch-mbp>
 <2a379b3a-6ff3-444b-bbad-0fba0bc3a28b@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a379b3a-6ff3-444b-bbad-0fba0bc3a28b@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 04:49:11PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> But what can Claudio do to find the root cause? Check hardware
> (especially the connectors), update firmware, ...? And if that doesn't
> lead to anything, bisect the issue?

Try the current 6.5.1 as-is where the failure was previously seen and
verify if this observation is indeed 100% reproducible with the "device
not ready" kernel message. Full system power cycle between tests, too.

If this is truly a regression, my only guess is some platform power
setting that a newer kernel changed. I am currently suspicious of that
right now since 6.5.1 was reported to fail but succeed with a "quirk"
that doesn't accomplish anything. I'm more leaning toward my "device is
not reliable" theory.
