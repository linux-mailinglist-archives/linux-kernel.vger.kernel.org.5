Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2CA7583E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjGRRy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGRRyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:54:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE2EA1;
        Tue, 18 Jul 2023 10:54:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B57C1616A0;
        Tue, 18 Jul 2023 17:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5910C433C7;
        Tue, 18 Jul 2023 17:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689702892;
        bh=BY7s5SRsfMBO293SrAJEHEM0sa9oyX3nibPf15Qj2mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wXYTVvFxkKKwqqnW4m98b2qCu0q65rB7rv+A1LcV+t5Gk2yePH0i3njC+pC1CRbZh
         450vgCJ/ySzpRrNeCyvBiYy67fUH8e8C16Xl4RbFjVDXMdNd35LGrZwLyeYxAzruym
         ZmqOPViBe8WFrF6XoF34scrsx9nQik032/vHLiFc=
Date:   Tue, 18 Jul 2023 19:54:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
Subject: Re: ANNOUNCE: thunderbolt-utils-v0.1-rc1
Message-ID: <2023071834-audibly-proton-6a3a@gregkh>
References: <2dab15ba-efd0-97cb-dfde-fa6f9d05f5fb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dab15ba-efd0-97cb-dfde-fa6f9d05f5fb@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:02:57PM +0530, Rajat Khandelwal wrote:
> Hi,
> 
> This is an official announcement that 'thunderbolt-utils', a collection of
> user-space utilities for the TBT/USB4 subsystem is now made public for its first
> release candidate.
> 
> # What is it?
> 
> The utilities comprise 'lstbt', similar in lines with 'lspci' and 'lsusb',
> which polls the TBT/USB4 subsystem's information including enumerated
> retimers.
> 
> The secondary component of the utilities is the goal towards providing
> a collection of available wrappers to provide the abstraction of configuring
> the subsystem in user-space. This is made possible via porting the DMA layer
> from kernel-space to user-space for the subsystem in an IOMMU-protected
> environment.

Cool, but it doesn't build as a normal user:

/usr/bin/ld: cannot open output file /usr/bin/lstbt: Permission denied

Why aren't you using autotools to properly be able to integrate into
everyone's build systems?

Also, you are shelling out to bash a lot, and as root, in this program,
are you sure that's ok?

And finally, why not add some of the USB4 stuff to usbutils?  Wouldn't
that be a bit more relevant for people who use those tools already?

thanks,

greg k-h
