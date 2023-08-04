Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5AD770058
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjHDMil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjHDMij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:38:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307E846A8;
        Fri,  4 Aug 2023 05:38:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB53061FCA;
        Fri,  4 Aug 2023 12:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C738FC433C8;
        Fri,  4 Aug 2023 12:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691152718;
        bh=wH4ssiceiRHm9OZ86jMKYyZLGUY4iWTnsjvf763CjCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pV25pyF7iSfkd22ShjzHVNBTD4t6cDIUaGRompY6+LF5lr0kptB6L02mYKUmRwdPC
         Izghke7sBa1/ueDizdBBZR8bchGhb7JOt9JSbDoXKHXWqLFbM+pTisyBi9infY5T2U
         TXyVv0n+iWcMtkZDwDHb6zRZpNka/zGhyvvD4k+Q=
Date:   Fri, 4 Aug 2023 14:38:35 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Surong Pang <surong.pang@unisoc.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Orson.Zhai@unisoc.com" <Orson.Zhai@unisoc.com>,
        "Chunyan.Zhang@unisoc.com" <Chunyan.Zhang@unisoc.com>,
        "Zhiyong.liu@unisoc.com" <Zhiyong.liu@unisoc.com>,
        "Surong.Pang@gmail.com" <Surong.Pang@gmail.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Let pm runtime get/put paired
Message-ID: <2023080419-fog-charger-abf6@gregkh>
References: <20230731023323.16046-1-surong.pang@unisoc.com>
 <20230801004923.mcmkgoliy2qlwtah@synopsys.com>
 <2023080139-treason-emboss-75be@gregkh>
 <20230801235616.i2k4rq4xroesuwbf@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801235616.i2k4rq4xroesuwbf@synopsys.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 11:56:26PM +0000, Thinh Nguyen wrote:
> On Tue, Aug 01, 2023, gregkh@linuxfoundation.org wrote:
> > On Tue, Aug 01, 2023 at 12:49:24AM +0000, Thinh Nguyen wrote:
> > > Hi,
> > > 
> > > On Mon, Jul 31, 2023, Surong Pang wrote:
> > > > Pm_runtime_get is called when setting pending_events to true.
> > > > Pm_runtime_put is needed for pairing with pm_runtime_get.
> > > > 
> > > > Fixes: fc8bb91bc83ef ("usb: dwc3: implement runtime PM")
> > > 
> > > Please fix your Fixes tag. Run checkpatch.pl before submit.
> > 
> > I don't see what's wrong with it, one extra character is just fine.
> > 
> 
> This inconsistency bugs me a bit. :)
> 
> It's noted in the kernel documentation that it should be tagged with the
> first 12 char of the commit id, and the checkpatch also complaints when
> it's not.

Fair enough, consistency is good.

greg k-h
