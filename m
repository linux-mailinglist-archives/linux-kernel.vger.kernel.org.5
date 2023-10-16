Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1037CA1D8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjJPIkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjJPIkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:40:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63872101
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:40:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA246C433B8;
        Mon, 16 Oct 2023 08:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697445611;
        bh=xmJQUG3HEnAnIKRC1iULeYdniMDR7Vj4BsO/YcpW+eQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L7DJs/CT47ob+20Kqz7K/8gADwJoIo5v9bpEEZBVh8VVy7sYoo9RHNi608MvRPng4
         G+zuxWHI7x43So4LrOGtc79/rJ4/3QpoQKcmSNk/EIJyTlcbLiJIpebHCtWaFntZp7
         EtugbrKTG2m5WqU85OBlLI3K6HmMKrq+3hd4JR7ESnPLTgVBrpDtTdHUmho5Qt1kOb
         4qIEGCyeXMfPYpiiYiVdrT8cidNRlidVZq5eRXUobVqT2PJXDqPzG4lqllnJoVrilu
         dAxxZHB3zkYTrV5SseHpdcQ8YtoWWZJOg+oLp5scGc0MfmLvd3dH7hkfM+0+Bgp+N3
         ufJ19CPr9Wz+A==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qsJ8v-0003Ku-1s;
        Mon, 16 Oct 2023 10:40:06 +0200
Date:   Mon, 16 Oct 2023 10:40:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Puliang Lu(Puliang)" <puliang.lu@fibocom.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: option: add Fibocom to DELL custom modem
 FM101R-GL
Message-ID: <ZSz25Tm6pG1bgMTD@hovoldconsulting.com>
References: <TYZPR02MB5088B70C88A3751EC69819E289D7A@TYZPR02MB5088.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR02MB5088B70C88A3751EC69819E289D7A@TYZPR02MB5088.apcprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 08:36:30AM +0000, Puliang Lu(Puliang) wrote:

> > You did however not answer my question whether there could ever be more
> > vendor class interfaces (e.g. for adb) so that you should be using a
> > more specific match for the entries (i.e. USB_DEVICE_AND_INTERFACE_INFO())?
> 
> 0x8213 and 0x8215 have only one mbim and one tty, Thanks.

Ok, thanks for confirming.

I've now applied the patch.

Johan
