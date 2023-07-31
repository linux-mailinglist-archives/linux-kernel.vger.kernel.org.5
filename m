Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4133769BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjGaP7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjGaP7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:59:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2C8197;
        Mon, 31 Jul 2023 08:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9C62611AE;
        Mon, 31 Jul 2023 15:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CDDC433C7;
        Mon, 31 Jul 2023 15:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690819157;
        bh=bARmeZQNZ2oW/i/ATn/SsjymAS/u/4AFuLf3YB2kxTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qLnX78qtX4ZGXwo70VXa/VBNBF6PZ5WWYwiygEpUyECVc3c4+qKCd/SxSJHJEut4B
         fhlQp2l2Du0UyZGJw5sUqfOmJKUXBB2GDztsPIN5/buAxj+OrTtnFam3EladqLNjv3
         bSig1vbZPHU86g2pAFWZwrsDKs2nTdFC8QxVlFX0=
Date:   Mon, 31 Jul 2023 17:59:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Subject: Re: [PATCH v9 08/10] serial: sc16is7xx: add call to get rs485 DT
 flags and properties
Message-ID: <2023073146-gauntlet-lake-0b77@gregkh>
References: <20230725142343.1724130-1-hugo@hugovil.com>
 <20230725142343.1724130-9-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725142343.1724130-9-hugo@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 10:23:40AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add call to uart_get_rs485_mode() to probe for RS485 flags and
> properties from device tree.

Again, you are saying what you are doing, but not why.  I have no hint
as to if this is a bugfix, or a new features, or something else?

thanks,

greg k-h
