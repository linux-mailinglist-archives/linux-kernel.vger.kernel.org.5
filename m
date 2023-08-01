Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0015D76A7F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 06:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjHAEpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 00:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHAEpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 00:45:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F6810C7;
        Mon, 31 Jul 2023 21:44:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EA676145E;
        Tue,  1 Aug 2023 04:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B829C433C7;
        Tue,  1 Aug 2023 04:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690865097;
        bh=/ZRKg72WZQ2HgIgZTCjn3liAVHyr+DTDPN/+J+kRxNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RuzRk5HooCrvyYi4wGYw2cYHFeVySqhPtLgCNrA6KxMOlb76+A+nLHA54aNnZkdUa
         5gwcrUDgvp9PQsEJ3ZIXrRDV/5gx0C4h7p1x+mQFFDRRE69E7qiUBnf/o5SHL0sH62
         4wAbhmROXD6cWZKQLEWp8dEF4J4tXnqwptA4YpsE=
Date:   Tue, 1 Aug 2023 06:44:55 +0200
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
Message-ID: <2023080139-treason-emboss-75be@gregkh>
References: <20230731023323.16046-1-surong.pang@unisoc.com>
 <20230801004923.mcmkgoliy2qlwtah@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801004923.mcmkgoliy2qlwtah@synopsys.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 12:49:24AM +0000, Thinh Nguyen wrote:
> Hi,
> 
> On Mon, Jul 31, 2023, Surong Pang wrote:
> > Pm_runtime_get is called when setting pending_events to true.
> > Pm_runtime_put is needed for pairing with pm_runtime_get.
> > 
> > Fixes: fc8bb91bc83ef ("usb: dwc3: implement runtime PM")
> 
> Please fix your Fixes tag. Run checkpatch.pl before submit.

I don't see what's wrong with it, one extra character is just fine.

thanks,

greg k-h
