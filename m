Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450B47D959B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbjJ0Kv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjJ0Kvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:51:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F101A6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:51:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370BFC433C7;
        Fri, 27 Oct 2023 10:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698403912;
        bh=C/0yFaoQyhngRIiLb9LDaAsApYXqKwf9DVx6WgurwqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0hYNtk9eMaMzOXQW1kBTl4GY0D0Yd4nnHCUvH07QbBpJ4wi+0HO99WynJZQCjQic
         H5HJw4BKOZ8IXGnY6C6Jv73FcrTIC8iOA/7CtUvDB9dAx0af2wek8EK5ySp83VVyuW
         glH0Dt4QJDyJX43q5Ae3LYm/EughG5jQ0VRovb6M=
Date:   Fri, 27 Oct 2023 12:51:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Avichal Rakesh <arakesh@google.com>
Cc:     etalvala@google.com, jchowdhary@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        m.grzeschik@pengutronix.de, dan.scally@ideasonboard.com,
        laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH v8 1/4] usb: gadget: uvc: prevent use of disabled endpoint
Message-ID: <2023102728-pluck-perish-e0a7@gregkh>
References: <20231019185319.2714000-1-arakesh@google.com>
 <20231024183605.908253-1-arakesh@google.com>
 <eeea887c-8fd5-45df-aed8-1046d8451a2e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeea887c-8fd5-45df-aed8-1046d8451a2e@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 01:23:44PM -0700, Avichal Rakesh wrote:
> Considering Laurent and Dan haven't responded, and Michael and I have 
> tested this change, would it be possible to merge this patch set
> if the changes look OK to you? I don't think there are any outstanding
> items to be done around these fixes.

I would like their review first please.

thanks,

greg k-h
