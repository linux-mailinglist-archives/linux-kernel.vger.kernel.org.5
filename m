Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E524075EA58
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 06:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjGXEIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 00:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGXEIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 00:08:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470BB107;
        Sun, 23 Jul 2023 21:08:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D20A560F1A;
        Mon, 24 Jul 2023 04:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5806C433C8;
        Mon, 24 Jul 2023 04:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690171696;
        bh=2wkaIMM82ma8TZrn0I9GwwvmLyWVR7TUPYDzyGLxe+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eAXdmNnb7I80svllUSyD68aZQdGrvUBBbA5ES+W+Hz4nweEpv+DNjmsTrhwrGhQMB
         OyBJ+oH/Y4f/X62q5W1jrk8ghLHvS1ShKOjEDNtRod9GvvOiE+jX5eOksctEt0uA/5
         j6C+zjMGqc/KjBIKU0MP+KZfD9+CbrExZt29DxFA=
Date:   Mon, 24 Jul 2023 06:08:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Pawel Laszczak <pawell@cadence.com>, balbi@kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.4 05/12] usb: cdns2: Device side header file
 for CDNS2 driver
Message-ID: <2023072451-candied-imbecile-d4a9@gregkh>
References: <20230724013426.2333833-1-sashal@kernel.org>
 <20230724013426.2333833-5-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724013426.2333833-5-sashal@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 09:34:18PM -0400, Sasha Levin wrote:
> From: Pawel Laszczak <pawell@cadence.com>
> 
> [ Upstream commit 0ca2026eea104adc1d0d356bca35915a1ab6e3e9 ]
> 
> Patch defines macros, registers and structures used by
> Device side driver.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> Message-ID: <20230602102644.77470-2-pawell@cadence.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/usb/gadget/udc/cdns2/cdns2-gadget.h | 707 ++++++++++++++++++++
>  1 file changed, 707 insertions(+)
>  create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-gadget.h

This just adds a .h file for a new driver that isn't being backported,
so no need to include it into any stable release.

thanks,

greg k-h
