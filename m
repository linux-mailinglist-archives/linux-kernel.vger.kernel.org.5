Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B48791A0B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241708AbjIDOwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjIDOwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:52:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EDE1A5;
        Mon,  4 Sep 2023 07:52:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7D344CE0D92;
        Mon,  4 Sep 2023 14:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0E9C433C7;
        Mon,  4 Sep 2023 14:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693839155;
        bh=TSlMgpm/uNhrzTcMQQ9fFSzba/GKlp3xUmzXJFOo9ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yqOXqs9edBCS3GiLWO3OlKliit9yHokRd2TWxUyKuVeKIOA/I7YXHkF/g4DAWhXlr
         78oThFLg1oSos+GZa+IcfSK953+BSpnkNRyGt0huHm3M0skFFVpu/P8rI4Po5PwxL5
         aoR8FWafBgJga5Sc0Xpcodw1uFHHsDlmRe786/U0=
Date:   Mon, 4 Sep 2023 15:52:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomasz Rostanski <tomasz.rostanski@gmail.com>
Cc:     stable@vger.kernel.org, Balaji Prakash J <bjagadee@codeaurora.org>,
        Felipe Balbi <balbi@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] usb: dwc3: reference clock period configuration
Message-ID: <2023090417-silk-parting-36d8@gregkh>
References: <20230904071432.32309-1-tomasz.rostanski@thalesgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904071432.32309-1-tomasz.rostanski@thalesgroup.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 09:14:22AM +0200, Tomasz Rostanski wrote:
> From: Balaji Prakash J <bjagadee@codeaurora.org>
> 
> Set reference clock period when it differs from dwc3 default hardware
> set.
> 
> We could calculate clock period based on reference clock frequency. But
> this information is not always available. This is the case of PCI bus
> attached USB host. For that reason we use a custom property.
> 
> Tested (USB2 only) on IPQ6010 SoC based board with 24 MHz reference
> clock while hardware default is 19.2 MHz.
> 
> [ baruch: rewrite commit message; drop GFLADJ code; remove 'quirk-' from
>   property name; mention tested hardware ]
> 
> Acked-by: Felipe Balbi <balbi@kernel.org>
> Signed-off-by: Balaji Prakash J <bjagadee@codeaurora.org>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> Nacked-by: Rob Herring <robh@kernel.org>
> Link: https://lore.kernel.org/r/9f399bdf1ff752e31ab7497e3d5ce19bbb3ff247.1630389452.git.baruch@tkos.co.il
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/dwc3/core.c | 29 +++++++++++++++++++++++++++++
>  drivers/usb/dwc3/core.h |  6 ++++++
>  2 files changed, 35 insertions(+)

What is the git commit id of this change (and all the others in this
series?)

What stable tree(s) are you wanting this to be applied to?

And you forgot to sign off on the patches as well, that is required.

thanks,

greg k-h
