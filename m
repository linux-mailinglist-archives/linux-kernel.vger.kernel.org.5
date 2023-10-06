Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E917BBB04
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjJFO7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjJFO7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:59:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11533D6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:59:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E65C43215;
        Fri,  6 Oct 2023 14:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696604351;
        bh=jPD7LD0nZ0fW171kWWlLz2f5hqXrbFlaGKo9bdgLi7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WxXjRL2IJEL9IaVcm+SLzhrboLT09GWXXrcbWuGPGFW5AlZ954cKwuNyNwaoKKq18
         k7l0Ub8zrNbe+a5eUx9qCyl0kU5H25lzN89kEcQ5CmyOqEXyiwOh1UkLopOZvQYCei
         FdwLJOERhDDdho140LyZ0jxtVn+UiwTdHNhzVcCg=
Date:   Fri, 6 Oct 2023 16:59:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc:     s.hauer@pengutronix.de, jonathanh@nvidia.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_linyyuan@quicinc.com, paul@crapouillou.net,
        quic_eserrao@quicinc.com, erosca@de.adit-jv.com
Subject: Re: [PATCH v2] usb: gadget: u_ether: Replace netif_stop_queue with
 netif_device_detach
Message-ID: <2023100657-immovably-bungee-f3a6@gregkh>
References: <20231006141231.7220-1-hgajjar@de.adit-jv.com>
 <20231006145332.8739-1-hgajjar@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006145332.8739-1-hgajjar@de.adit-jv.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 04:53:32PM +0200, Hardik Gajjar wrote:
> This patch replaces the usage of netif_stop_queue with netif_device_detach
> in the u_ether driver. The netif_device_detach function not only stops all
> tx queues by calling netif_tx_stop_all_queues but also marks the device as
> removed by clearing the __LINK_STATE_PRESENT bit.
> 
> This change helps notify user space about the disconnection of the device
> more effectively, compared to netif_stop_queue, which only stops a single
> transmit queue.
> 
> Changes since version 1:
> 	- Correct Singed-off user name and e-mail

Nit, this goes below the --- line :(
