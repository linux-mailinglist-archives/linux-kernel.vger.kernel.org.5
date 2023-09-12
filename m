Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776BF79DBE3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbjILW2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbjILW2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:28:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EEB10C8;
        Tue, 12 Sep 2023 15:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=8HUDCyTDk+/khqCF060Q0sN0T5AM39PQmswQmYF5Wg8=; b=t+qdWssTTp4SMLdYgRmkf82hZc
        hx/6H4XhsW4XtOuIMimfn4J3fC+YTVlVbBuGa9P7qDqzALpsYuk094kUYgMCsh1qgp1o2rHpFADo6
        egz7U2HGuf2kKrr8BQPaivPsgUhZyjnyZHcS4p5HZPJnXc7nHTG7Oug8T+3fAb23GSEJlcd0VrWsl
        w39uCmCUWde1oDsCY6GBLahNckBW5MNXwhUJcDJ0GRp64TFObK9LR24KDW9hCspKQNgvLg1qRlnW/
        I79XjeFW2vvq43KZ5rLgYHTQBpmkKK7XpZ9XdYdcBNZa5f+etpO2RvD21uWwuIr22c2jH0jr5z3UG
        3fUQBDyw==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgBry-004CLH-0m;
        Tue, 12 Sep 2023 22:28:30 +0000
Message-ID: <8b77219e-b59e-40f1-96f1-980a0b2debcf@infradead.org>
Date:   Tue, 12 Sep 2023 15:28:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Sep 12 (drivers/clk/imx/clk-imx8-acm.o)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, dl-linux-imx <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>
References: <20230912152645.0868a96a@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230912152645.0868a96a@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/23 22:26, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230911:
> 
> New tree: bcachefs
> 
> The bcachefs tree gained a semantic conflict against Linus' tree for
> which I applied a patch.
> 
> The wireless-next tree gaind a conflict against the wireless tree.
> 
> Non-merge commits (relative to Linus' tree): 4095
>  1552 files changed, 346893 insertions(+), 22945 deletions(-)
> 
> ----------------------------------------------------------------------------

on arm64:

aarch64-linux-ld: drivers/clk/imx/clk-imx8-acm.o: in function `imx8_acm_clk_probe':
clk-imx8-acm.c:(.text+0x3d0): undefined reference to `imx_check_clk_hws'

when
CONFIG_CLK_IMX8QXP=y
CONFIG_MXC_CLK=m

Should CLK_IMX8QXP select MXC_CLK?
I'll leave that patch up to the maintainers.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
-- 
~Randy
