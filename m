Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2C6784D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 01:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjHVXW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 19:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjHVXW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 19:22:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CCDCF;
        Tue, 22 Aug 2023 16:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=6mZ9RXDzFOJDqX1dGFgGM4yG03A8DPir/bOKToNesP4=; b=JZkHWTtdpiFJYvW51gbwqVSJGD
        Nf1SquLrVPXh64z7iimnGMrfk4hHOJSp/J4OfScClMsvybbSuK9TI8j+BtJPJEQchUsYCmPCCtzL9
        LmDXjlLxXfnokQczKvXxJAyGUwUXoqtF2VLxRCcbX4z8P0mcfEM4ecDj1K8BaZ4hSgKtmW7ot5s+N
        yDRZ3wvRND+xm1ASDGcI9WGypWioOPd79gR02wBe1ozT1jaicRIBSh5IHAKH3CB45cAOPHZuVC80R
        6shT4Qp6uow1Z6AKjHjgE+3CDPHNWTS4ciATDzzPggvrhDBi6gBsWpYkdrW3pIlppgdfqu5QCymYm
        lvk0cwAA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qYai4-00Gw10-2v;
        Tue, 22 Aug 2023 23:22:52 +0000
Message-ID: <304308ed-6b6d-d9c8-42cc-102666fdfa17@infradead.org>
Date:   Tue, 22 Aug 2023 16:22:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: linux-next: Tree for Aug 21
 (drivers/power/supply/rt5033_charger.o)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20230821164605.7bac05f1@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230821164605.7bac05f1@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/23 23:46, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230818:
> 

on x86_64:
when CONFIG_CHARGER_RT5033=y
and CONFIG_EXTCON=m

ld: drivers/power/supply/rt5033_charger.o: in function `rt5033_charger_probe':
rt5033_charger.c:(.text+0x7cf): undefined reference to `extcon_find_edev_by_node'
ld: rt5033_charger.c:(.text+0x8a5): undefined reference to `devm_extcon_register_notifier_all'
ld: drivers/power/supply/rt5033_charger.o: in function `rt5033_charger_extcon_work':
rt5033_charger.c:(.text+0xc3a): undefined reference to `extcon_get_state'


-- 
~Randy
