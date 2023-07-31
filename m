Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FE376A014
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjGaSLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGaSLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED6F172E;
        Mon, 31 Jul 2023 11:11:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1DFA6126E;
        Mon, 31 Jul 2023 18:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E65C433C8;
        Mon, 31 Jul 2023 18:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690827101;
        bh=cDFN1vkB0ZVLYUOK6O311UnGeZg6NUNHfqUlOQZ/kMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pCi/haN3XCVahqgyxo0Hwl1jJ8SS0UyvL7SLRzW5+Ivk52fbJRix4Rz3LRTy7KLv2
         b4GZ55nnyH7K1I+wg64daYkDhcKEaYmaRRiHs182gJ0mMx8d9kLs3mUBsXmCLYqd2I
         9n0ArLli+1PYHvaEJea1atA1WDbDEWE9s94j+3nI7iYax1SxXdiX9rLFAw1q/ZtZQN
         u0mwc1ABqwtyhv8sU3Hgxyn1lZXIzSsQcvJxQiqylGaRRfMcWfTs86ltMhQo/J59mu
         2rZaiXj5ZESpDHTCdWBAz6POpHRwGmOr452Y0zzYVsb+iQ2Nf0oSJkAtHeT6LSN5PG
         QWyT2Vs/iD6zw==
Date:   Mon, 31 Jul 2023 20:11:36 +0200
From:   Simon Horman <horms@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH 5/5] modules: only allow symbol_get of EXPORT_SYMBOL_GPL
 modules
Message-ID: <ZMf5WN/2BGC4vYoy@kernel.org>
References: <20230731083806.453036-1-hch@lst.de>
 <20230731083806.453036-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731083806.453036-6-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 10:38:06AM +0200, Christoph Hellwig wrote:
> It has recently come to my attention that nvidia is circumventing the
> protection added in 262e6ae7081d ("modules: inherit
> TAINT_PROPRIETARY_MODULE") by importing exports from their propriertary
> modules into an allegedly GPL licensed module and then rexporting them.
> 
> Given that symbol_get was only ever inteded for tightly cooperating

nit: inteded -> intended

...
