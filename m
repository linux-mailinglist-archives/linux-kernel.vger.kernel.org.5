Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F007D07B8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 07:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbjJTFm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 01:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbjJTFmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 01:42:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6271D1A4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 22:42:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79219C433C7;
        Fri, 20 Oct 2023 05:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697780541;
        bh=8k3PE1NFkxj9wPhoBUIveRHmdpO2uZTZ7oZXhJJ6Oz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F6ZQzqxAiich4MNbE8MgIacE8EJJRhs2C1AUg+gRv1RU28Yoksc5Z1JNxMgdlhWs0
         QjvqiuG/9Vy9yekRWZhcAvZ3wLV7uCLtgx+WizeyZdgLO85cmcbzla+j9dAvikhurb
         NcaF7Of6B1it3Ni9QmKTih1dqtbQLvnvKbPlS86o=
Date:   Fri, 20 Oct 2023 07:42:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jayant Chowdhary <jchowdhary@google.com>
Cc:     "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>, balbi@kernel.org,
        "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "arakesh@google.com" <arakesh@google.com>,
        "etalvala@google.com" <etalvala@google.com>
Subject: Re: [PATCH] usb:gadget:uvc: Add super speed plus descriptors
Message-ID: <2023102014-reference-diabetes-f859@gregkh>
References: <4ca94f99-fe07-49c2-adc7-84df519792f5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ca94f99-fe07-49c2-adc7-84df519792f5@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 03:39:44PM -0700, Jayant Chowdhary wrote:
> Currently the UVC gadget driver doesn't support super speed
> plus connections since it doesn't advertise super speed plus descriptors.
> This patch re-uses the super speed descriptors for super-speed plus.
> As a result, hosts can recognize gadget devices when using a super
> speed plus connection.
> 
> Signed-off-by: Jayant Chowdhary <jchowdhary@google.com>
> ---
>  drivers/usb/gadget/function/f_uvc.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

As this is obviously a copy of a previously posted patch, why did you
not credit the original author?

thanks,

greg k-h
