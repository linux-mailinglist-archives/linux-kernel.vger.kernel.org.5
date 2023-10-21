Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5E87D1E36
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 18:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjJUQTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 12:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjJUQTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 12:19:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5093E1A8;
        Sat, 21 Oct 2023 09:19:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E495C433C7;
        Sat, 21 Oct 2023 16:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697905177;
        bh=KuG7HJuTbJpgl9cv4/FVqC+PNkm0XhOMATgkMOUl4+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mNcyvyWZ1y+3lWlA7lp2c2yrpbOrsJxyUssI6vntD6tzMvueT97Ecwpw9Ep0CRdLT
         3Kv/0KmeH34f1j5fQLN4Olq+GWEujWGMPpTM/usmLwM2d16FYJuKU3O6q9AhnioFRg
         jBtzOdK58g6bF8q1Sl6koDUQ1UuJfHaAQKu+Nhcc=
Date:   Sat, 21 Oct 2023 18:19:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cameron Williams <cang1@live.co.uk>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 01/11] tty: 8250: Fix IS-200 PCI ID comment
Message-ID: <2023102107-poser-recipient-3593@gregkh>
References: <BBPatchesV4>
 <20231020160412.118550-1-cang1@live.co.uk>
 <DU0PR02MB78993B6AD85F6550AF6590FBC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR02MB78993B6AD85F6550AF6590FBC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 05:03:07PM +0100, Cameron Williams wrote:
> Fix the PCI comment for the IS-200 card. The PCI ID for the IS-200
> is 0x0d80, and the definition used (PCI_DEVICE_ID_INTASHIELD_IS200)
> is indeed 0x0d80, clarify that by fixing the comment as its
> neighbouring cards are all at 0x0020 offsets.
> 
> Fixes: 737c17561fb2 ("[SERIAL] Support for Intashield 2 port PCI serial card")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cameron Williams <cang1@live.co.uk>
> ---
> I argue for fixing this rather than removing due to this patch series (and
> the code already in the kernel) referring to the rest of the cards in
> the manufacturer's product line by hex ID, makes sense to me to
> have the hex IDs all displayed correctly one way or another in the
> one driver as the IS-200 and 400 are the only cards to use a definition instead.

I'll take this, but it is obviously not for stable kernels to take, as
it has no code functional changes.

thanks,

greg k-h
