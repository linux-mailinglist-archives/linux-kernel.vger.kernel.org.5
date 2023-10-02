Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CFF7B572A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbjJBQCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238370AbjJBQCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:02:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9206CC4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:01:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2886C433C8;
        Mon,  2 Oct 2023 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696262518;
        bh=ldGXFZRStL938jM9pWhLEbEq6UdmgPduxfAcfiYVm60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iUpCkJUylwNE7KQUQ1XMhAD13L8ZAwaYVTG+kmZQZtXzT+1DfWJTYaJ9ATNaj6sDr
         Pavp7JZ8XsprG7WuhkH9ezqw8/lj1csOOmGxyuaBmrrMEouzWDqw2U+pmNlKrWJzQ2
         +zyWAeGAHrMkaJGB4f6wRt02RckX9U0v9TFEN7lkwP8V7xov8KWdXnqdaQq3FVUTOX
         HNTBlrmmuVPBDOK3VZO8a/mMe6O6aoqIrp3OJjVodIkgN9hoXT5UATz+eKhymUjbHN
         zaSB44oscGFnrNWVb2oqCjjGvtzBAYqpSts5Adl+ElrcnMH+sP0bbWtJl7XuHS/Ha9
         JDUkeUpjc8G6w==
Date:   Mon, 2 Oct 2023 21:31:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        rdunlap@infradead.org
Subject: Re: [PATCH v2] soundwire: bus: Make IRQ handling conditionally built
Message-ID: <ZRrpcfKHY4/jJiCS@matsya>
References: <20230920160401.854052-1-ckeepax@opensource.cirrus.com>
 <169528907320.97239.11506619845267367958.b4-ty@kernel.org>
 <20231002085252.GM103419@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002085252.GM103419@ediswmail.ad.cirrus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-10-23, 08:52, Charles Keepax wrote:
> On Thu, Sep 21, 2023 at 11:37:53AM +0200, Vinod Koul wrote:
> > 
> > On Wed, 20 Sep 2023 17:04:01 +0100, Charles Keepax wrote:
> > > SoundWire has provisions for a simple callback for the IRQ handling so
> > > has no hard dependency on IRQ_DOMAIN, but the recent addition of IRQ
> > > handling was causing builds without IRQ_DOMAIN to fail. Resolve this by
> > > moving the IRQ handling into its own file and only add it to the build
> > > when IRQ_DOMAIN is included in the kernel.
> > > 
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/1] soundwire: bus: Make IRQ handling conditionally built
> >       commit: 3b6c4a11bf2b810f772f5c2c1ef6eef3fc268246
> > 
> 
> Did something go wrong here? I still don't see a commit with
> that SHA in your tree.

It was applied to fixes and I missed pushing that, it is pushed now

-- 
~Vinod
