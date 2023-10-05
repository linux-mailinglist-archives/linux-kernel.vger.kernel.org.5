Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62CC7BA26E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjJEPgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjJEPfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:35:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0E5B0AF4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:52:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6666C433B6;
        Thu,  5 Oct 2023 06:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696487745;
        bh=ypr08pgY6c2eP9P2qYB2bJHbuVcnNmfSe66z44UoZvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s4ZW/3jfyG3xsagsVjX0ZESZ8I/QmLSI7NBZzFnORa9ftepVJZj4aSEHYvCKmaOSY
         TTNAM63zrluIweCFtqRQEXhKqjsQqPgBURoxJiU/Sk7GJEI0aYcur7/oZCI30qygKQ
         gHv3CckD5W2IYtQFH26Hrgn0kBLLENjaOvu+WEzzj5Ruvb0EcKr0830ZRPUnzg/yiW
         BPZ38UhButfb4UYY+mWJvDgn4tN7jvaFHgBQUAizjpAHw0KGIMRjn2Gn1Vei6c7QxD
         kyXVztyfFfGHZ/fZXOYfdvYhPOOkCIuqDp6p/O+3zWJIX5TKmmx0ndjEx1KaCkhgNi
         XxDnBa5Cfzfzw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qoHxp-0004D5-0s;
        Thu, 05 Oct 2023 08:36:01 +0200
Date:   Thu, 5 Oct 2023 08:36:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com
Subject: Re: [PATCH v12 0/3] Add multiport support for DWC3 controllers
Message-ID: <ZR5ZUaWcyRj5sZKx@hovoldconsulting.com>
References: <20231004165922.25642-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004165922.25642-1-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 10:29:19PM +0530, Krishna Kurapati wrote:
> This series is a set of picked up acks and split from larger series [1]
> The series is rebased on top of:
> Repo: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
> Branch: usb-testing
> commit 03cf2af41b37 ("Revert "phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY support"")
> 
> The patches present in series have been reviewed and acked by respective
> maintainers. They dont break any existing implementation and is just a
> subset of merge ready multiport code. The rest of the patches will be
> rebased on top of the usb branch once this series is merged.
>
> [1]: https://patchwork.kernel.org/project/linux-usb/cover/20230828133033.11988-1-quic_kriskura@quicinc.com/
> 
> Krishna Kurapati (3):
>   usb: dwc3: core: Access XHCI address space temporarily to read port
>     info
>   usb: dwc3: core: Skip setting event buffers for host only controllers
>   usb: dwc3: qcom: Add helper function to request threaded IRQ

NAK.

These patches make very little sense on their own and can't really be
evaluated without the context of the larger series.

Just work on getting the multiport series in shape and include any acks
you've received so far when submitting new revisions.

Johan
