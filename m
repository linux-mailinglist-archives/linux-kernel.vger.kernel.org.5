Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00AD7B627D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjJCHaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjJCHaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:30:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A14D90;
        Tue,  3 Oct 2023 00:30:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9373FC433C8;
        Tue,  3 Oct 2023 07:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696318211;
        bh=3YMOJFi4Wh0Z3PqMMREN4+4tfDFlDgz/TAo+hoXUfGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+7C2NGNc+zgIOhsthS/hKHtZqgiuBsySjrKGVWZn1nkdV4UbhsnPiHZe7AqySjzM
         vUmPVciYAzAC+Pp3TAuw1bLC72kkDALk5cbEKjPSaWBpo5u5gNpBrqLh/2LeMe8bdB
         ht6Qoi1n2PBJ94VT38YAHSg9xABWgBknisQqetbU=
Date:   Tue, 3 Oct 2023 09:30:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/4] tty: serial: 8250: Cleanup MOXA configurations in
 8250_pci.c
Message-ID: <2023100305-gentleman-surging-a65c@gregkh>
References: <20231002015702.30509-1-crescentcy.hsieh@moxa.com>
 <20231002015702.30509-2-crescentcy.hsieh@moxa.com>
 <68d533d5-dbc8-4be3-a1fc-b3dd28b8f9df@kernel.org>
 <ZRvAG5336KxuugVd@moxa-ThinkCentre-M90t>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRvAG5336KxuugVd@moxa-ThinkCentre-M90t>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 03:17:47PM +0800, Crescent CY Hsieh wrote:
> On Mon, Oct 02, 2023 at 08:51:03AM +0200, Jiri Slaby wrote:
> > On 02. 10. 23, 3:56, Crescent CY Hsieh wrote:
> > > @@ -1958,6 +1958,9 @@ pci_moxa_setup(struct serial_private *priv,
> > >   #define PCIE_DEVICE_ID_WCH_CH384_8S	0x3853
> > >   #define PCIE_DEVICE_ID_WCH_CH382_2S	0x3253
> > > +/* MOXA */
> > > +#define PCI_VENDOR_ID_MOXA	0x1393
> > 
> > Isn't this a redefinition of the pci-ids.h one?
> 
> At first, I attempt to place DEVICE_ID macros into pci_ids.h to enable
> their usage throughout 8250_pci.c and to establish centralized
> management. However, I notice the comment in pci_ids.h which is:
> 
> 'Do not add new entries to this file unless the definitions are shared
> between multiple drivers'
> 
> So I add this VENDOR_ID just for the clarity, even though it results in
> duplication.
> 
> Should I put these macros into pci_ids.h? If so, I am willing to help
> relocate all other macros.

Please do not add new defines to pci_ids.h unless they are needed in
multiple files.

thanks,

greg k-h
