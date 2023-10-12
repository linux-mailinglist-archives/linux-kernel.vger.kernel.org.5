Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EFE7C65B0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377241AbjJLGfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347070AbjJLGfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:35:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7573BE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:35:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06001C433C7;
        Thu, 12 Oct 2023 06:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697092546;
        bh=WKqW/qfFXpEtKhsfFnturnGNaQf5Dhj6r+Pg8s1o4tU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bAjMzBEz0U6dTeu5nT/idd6XkTDbOUnJx0Ey+Z0TmygNTBmHHGRu+2sNLuSQ8t7mL
         3KtHsHzUpqaJ++RF2b20taBM8sVNFUAh9lPJd4IB/4z5tBnhTDEhJ4YDbOj5cH6FP+
         K1tYkBvfB5Qshg4Dh9MR6stsK/fJOEqpkrhb/3fM=
Date:   Thu, 12 Oct 2023 08:35:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] staging: rtl8192u: Fix two crashing bugs
Message-ID: <2023101244-unaudited-sadly-d9d6@gregkh>
References: <cover.1697089416.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697089416.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 08:02:58AM +0200, Philipp Hortmann wrote:
> Question: Fix or remove rtl8192u?

We should remove it if it's obviously broken and no one has reported it
in a very long time.

> I found a USB WLAN Stick with a rtl8192u. I got it last Saturday and 
> found out that the firmware is missing in my ubuntu 20.04. I found it on 
> the web and fixed it. When I started the driver my computer crashed. The 
> missing part was: priv->priv_wq = alloc_workqueue("priv_wq", 0, 0); 
> Fixing this the next error was a network = kzalloc(sizeof(*network), 
> GFP_KERNEL); in wrong context which leads to a crash of my computer. 
> Fixing this the next error is more depending on what I do with the stick.
> 
> When lucky the connection is build up and I can surf and download at maximum speed (12,5MB/s) several gigabytes.

Do you want to keep it here so that you can maintain it and keep it
working?

thanks,

greg k-h
