Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A4180BA28
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 11:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjLJK2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 05:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjLJK2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 05:28:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFABFF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 02:28:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246A7C433C7;
        Sun, 10 Dec 2023 10:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702204092;
        bh=xna6/O6IZ9waJxH48kfJzUPY0hegji/Pnu2/quXKVrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hcLZQfHXxcsdvfsImUzif6GbNVRoqpIB+QE+HSVWl+LIIyHURc0hZOvOT6iQqbSDf
         CcKrXqkwFYwvNQYeVkhSRGXn3yF8tHbqDrleoF9VBXHSs5RaSLmbgwy4wtsUCHItDQ
         Tw6mr0EsedGg+s3upiifIo+SVaSFD1JT9TlTwNFI=
Date:   Sun, 10 Dec 2023 11:28:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vimal Kumar <vimal.kumar32@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        chinmoyghosh2001@gmail.com, badolevishal1116@gmail.com,
        mintupatel89@gmail.com
Subject: Re: [PATCH v2] PM / sleep: Mechanism to find source aborting kernel
 suspend transition
Message-ID: <2023121027-riptide-spiny-0be3@gregkh>
References: <20231210100303.491-1-vimal.kumar32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210100303.491-1-vimal.kumar32@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 03:33:01PM +0530, Vimal Kumar wrote:
> +/**
> + * abort_suspend_list_clear - Clear pm_abort_suspend_list.

Again, a horrible global symbol name, please fix all of these up.

thanks,

greg k-h
