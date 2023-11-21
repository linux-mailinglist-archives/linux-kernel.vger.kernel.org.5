Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F377F37AD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjKUUpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKUUpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:45:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1284299
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:44:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546D0C433C8;
        Tue, 21 Nov 2023 20:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700599498;
        bh=WjnkBEROFr04ZeG+CGEk+pVBT3sw6f+qYCHdrQpEI2Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AioRE3DiHimygj7va4tGcJ+qWVFd8vwBeqoOeI+ZPKsl4bOTs2rJXG2YwZye/CwdE
         XwqKCqhcSECHJhO6OEQzad3438fEpPfcY9YNRukaFYIp4T8VXkBJTUIMxJwna512Kt
         bWsjE8AcMILOXMZuJh4Dl/iwflL4GgyO+WOYXiSQjyRZDl4lL+qCxf4cD/uoHYAURB
         xBPT9R1TAqysMgz+aYtkrxJ4tgQarH8nt5ZBE+lIQ11Djyjpu++c1+jJYb6iQYsU6R
         LD+yzIZurL13FUHZRxz+ReJk9Ob+pd95WCJCeJR3zDFw76OxR1NkMP+Iu9XGkDtbll
         HN9zEtrZA4AOw==
Date:   Tue, 21 Nov 2023 12:44:56 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
Message-ID: <20231121124456.7a6388c6@kernel.org>
In-Reply-To: <20231121070619.9836-6-saeed@kernel.org>
References: <20231121070619.9836-1-saeed@kernel.org>
        <20231121070619.9836-6-saeed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 23:06:19 -0800 Saeed Mahameed wrote:
> high frequency diagnostic counters

So is it a debug driver or not a debug driver?

Because I'm pretty sure some people want to have access to high freq
counters in production, across their fleet. What's worse David Ahern
has been pitching a way of exposing device counters which would be
common across netdev.

Definite nack on this patch.
