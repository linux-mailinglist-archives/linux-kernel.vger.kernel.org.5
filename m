Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2B07BBC16
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjJFPqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjJFPqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:46:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAF7DE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:46:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F15CC433C8;
        Fri,  6 Oct 2023 15:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696607207;
        bh=ksSYkcdw/6cmeqtqG2iMHN+7nIEblCybrVsjoCbBp8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IrQlPwGvGxCPQz4wOxg+XyD4dDq3MEvesVTQy6DxQgeM1nte2Qxop0OPxRfxOtK6l
         q8HC00ubJ6o2p43TooGK/qsFKzR/EHiDi/6vpZKOwR3xhuZNDOYLPsqQXedyUuBgZe
         LFIpcEhhgPIOaVV56PsmfX/bNblUjELgDHE4ZAkZbeuNTpjibXmuuVlICzwSrpS055
         vncR/zjhGbfTwjUso5u3P4z6ioGrWVvSj5NuG8ziUNJdA+foBai9dfk57F3KstNqSJ
         aEL8ecNdGnj3zNSzII2W5IuvMCXJWOgN13Xc0sKni+uChidHEzUhQFfZCgyQHAO8yl
         KVmiRm7SG4jzw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qon2f-0006BE-36;
        Fri, 06 Oct 2023 17:47:06 +0200
Date:   Fri, 6 Oct 2023 17:47:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com
Subject: Re: [PATCH v12 0/3] Add multiport support for DWC3 controllers
Message-ID: <ZSAr-SSaZcsIoC2P@hovoldconsulting.com>
References: <20231004165922.25642-1-quic_kriskura@quicinc.com>
 <ZR5ZUaWcyRj5sZKx@hovoldconsulting.com>
 <d6974352-e157-421b-aa2d-e4a6c791ca2b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6974352-e157-421b-aa2d-e4a6c791ca2b@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 02:32:54PM +0530, Krishna Kurapati PSSNV wrote:
> On 10/5/2023 12:06 PM, Johan Hovold wrote:
> > On Wed, Oct 04, 2023 at 10:29:19PM +0530, Krishna Kurapati wrote:

> >> Krishna Kurapati (3):
> >>    usb: dwc3: core: Access XHCI address space temporarily to read port
> >>      info
> >>    usb: dwc3: core: Skip setting event buffers for host only controllers
> >>    usb: dwc3: qcom: Add helper function to request threaded IRQ
> > 
> > NAK.
> > 
> > These patches make very little sense on their own and can't really be
> > evaluated without the context of the larger series.
> > 
> > Just work on getting the multiport series in shape and include any acks
> > you've received so far when submitting new revisions.

>   This may be partially true for first patch of this series, (where we 
> read num_ports), but the other two patches are self explanatory and are 
> applicable for non-mp controllers as well. Intention was to ensure we 
> make the next rebase easy.

No, just send the whole series at once.
 
>   Will try to address all comments and send v12 again as a whole series 
> this week. I am actually blocked on [1]. Not able to repro the compile 
> error on my end. That's what stopped me from sending all at once.

Looks like your buffer is too small for a u8 index. Should be easy to
fix.

Johan
 
> [1]: https://lore.kernel.org/all/202309200156.CxQ3yaLY-lkp@intel.com/
