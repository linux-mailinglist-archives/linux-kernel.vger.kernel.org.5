Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15CD7840DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbjHVMe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjHVMe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:34:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6938196;
        Tue, 22 Aug 2023 05:34:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3435A655CF;
        Tue, 22 Aug 2023 12:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05945C433C8;
        Tue, 22 Aug 2023 12:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692707694;
        bh=L7ZkcHYPKB06I+bvuRPNUcWUy0ju4lLrEj6e99lnZIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8PHLdQrdAg76Q15Q35BjSuQeAX9xrnYLYFirbHbEcqEVxmc+Lp3W3z192/UgWdGj
         tU6pNs7+Oxdw6X8XGxt54fnvx3LsZ4oxwFqpeeMJX53HOQtZqODdzOysrBh27ySFA1
         M2wunafzAe2gSXVwcH46K6KswJ+ipy4BkYMQOaAQ=
Date:   Tue, 22 Aug 2023 14:34:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     chengdong zhou <zhouscd@gmail.com>
Cc:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de, john@keeping.me.uk,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: gadget: usb function sourcesink and loopback
 support usb configfs
Message-ID: <2023082229-gave-smuggler-f91c@gregkh>
References: <20230801104223.281275-1-zhouscd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801104223.281275-1-zhouscd@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 03:42:23AM -0700, chengdong zhou wrote:
> There are currently two issues that causes sourcesink and loopback to
> fail to export to usb configfs:
> 1. usb_function.name does not match usb_function_driver.name
> 2. usb configfs does not support function name with '/'
> 
> So, we adjusted usb_function.name to "sourcesink" and "loopback",
> and remove '/'

How has this ever worked?  What userspace tools / apis did you just
break or change to get this to work?

this feels odd.

thanks

greg k-h
