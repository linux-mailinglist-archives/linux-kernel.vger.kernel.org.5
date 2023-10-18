Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5957C7CE616
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjJRSQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjJRSQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:16:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A40FB8;
        Wed, 18 Oct 2023 11:16:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5926EC433C7;
        Wed, 18 Oct 2023 18:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697652968;
        bh=Ct9gR9nllChCdIfEvz/HYXItxKyJ157uTxTGorys+KY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nco4Zz3RCjMP2/4unO1zaVALBkrBBtB1bm2vkjdgz6OiCI5WdntbNLVDsSqfe3plb
         uG1uKJPFqRSFpgT6hOC9UwwqGMHcueSf++oMDMp9WtdG+wB1rDdodLD/d3MCSdxwin
         Up33Ui6lECUuOAntWYlX8uiTYeOJgycUZHJq2Lathd9OZiwFuELjedwOOQ5qaYf3pC
         y4TytzyvBPFer72dXF7koBEl/zob4cRbYXOHPUrHg9B4oWhLctzWMrhTAqHF8/Viiy
         fBXRquNpZsrGHLwOKuMHSAcdFh/HnUWlfcKkIAgIF+yu9tPgy9WbfPPJh1AMUR3s/R
         XJwcB4Fs259uQ==
Date:   Wed, 18 Oct 2023 11:16:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <rogerq@ti.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <horms@kernel.org>, <linux-omap@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Thejasvi Konduru <t-konduru@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_mdio: Fix the
 revision string for J721E
Message-ID: <20231018111606.4af0cdb3@kernel.org>
In-Reply-To: <20231018180035.saymfqwc2o3xpdf4@pretense>
References: <20231018140009.1725-1-r-gunasekaran@ti.com>
        <20231018154448.vlunpwbw67xeh4rj@unfasten>
        <20231018105236.347b2354@kernel.org>
        <20231018180035.saymfqwc2o3xpdf4@pretense>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 13:00:35 -0500 Nishanth Menon wrote:
> Thanks Jakub. SoC tree needs me to send based off rc1 for new features.
> I'd rather not mess with that.
> 
> Sure if we are doing an fixes pull, we can figure something out to
> sync. rc1 saves us the headache of conflict of me sending a PR merge
> while netdev maintainers aren't expecting it to be merged to master
> via soc tree.

Sounds good, I'll wait for Ravi to respond to you and once we have 
a green light we can plonk the patch on top of rc1.
