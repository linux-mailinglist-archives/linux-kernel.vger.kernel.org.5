Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932CA7DA669
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 12:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjJ1Kbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 06:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjJ1Kbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 06:31:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A168ED
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 03:31:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F0DC433C7;
        Sat, 28 Oct 2023 10:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698489089;
        bh=DLYTQpYu8yL88OLQO/D4DceJpOvPWTl4um1X4nFwKS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xNv+sOq0/GmDJm+KZxMLh7Xk16HfEogFhS1Zkie3XunKSGmJwUtRQCOMnCE3iERKS
         txvbPfyqZd835I4rQlmaRmb/GeTxKIv3mbduqD4T6c787Jiu+23E9MrfX252i/lBAh
         V025nEy3EMdpIPACCCJ3/NrNVTplZJRjHnNdAO4k=
Date:   Sat, 28 Oct 2023 12:31:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Avichal Rakesh <arakesh@google.com>
Cc:     dan.scally@ideasonboard.com, etalvala@google.com,
        jchowdhary@google.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        m.grzeschik@pengutronix.de
Subject: Re: [PATCH v9 2/4] usb: gadget: uvc: Allocate uvc_requests one at a
 time
Message-ID: <2023102824-pegboard-sadness-29da@gregkh>
References: <73309396-3856-43a2-9a6f-81a40ed594db@google.com>
 <20231027201959.1869181-1-arakesh@google.com>
 <20231027201959.1869181-2-arakesh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027201959.1869181-2-arakesh@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 01:19:57PM -0700, Avichal Rakesh wrote:
>  	BUG_ON(video->req_size);
> +	BUG_ON(!list_empty(&video->ureqs));

Again, please do not add new BUG_ON() lines, the existing ones need to
be removed as well, but you can do that in later changes.  I can't take
changes that add new ones, sorry.

thanks,

greg k-h
