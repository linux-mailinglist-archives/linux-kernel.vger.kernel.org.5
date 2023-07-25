Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94FF7617E6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjGYMBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjGYMBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:01:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D65E4D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W4+IDhlcrDbUmP2vgXqSK60uiq6DZVNSM07T9xTo0tw=; b=MI8sFFH978ZOaQcAVIcrDmvus5
        J/LUazhV/YTLnIasr8XIF0SEMT8IGY+Zp3etNe78zTDdcag3W0dWzaLfxESsm7lqncUyqLJaH+QmE
        ej7bgFo4mTlG2C41RuJHSFNiSn9L9uOCJZ9l4W6vZtR39AxTJ+PAJ6yV6FMUIjwViTQ/P1flEgh81
        Iei0jULb38te5EXZXEX/JBvAjtnume8n/C6iF5vFLEix+NgMiM1ZHo+qUknTd47RgazOUpKyUwCG0
        JYi/dpjpceQ7nJ+/t2pUjpRpmBFJYNEOY+eKetaYLEdLBKDy3/7NedNGnBJUhegev5V2ILkMmCINb
        4/YMRiDg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOGj2-0047VX-2k;
        Tue, 25 Jul 2023 12:01:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D974C300155;
        Tue, 25 Jul 2023 14:01:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C6B092612ABE5; Tue, 25 Jul 2023 14:01:10 +0200 (CEST)
Date:   Tue, 25 Jul 2023 14:01:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v1 0/6] Add objtool and orc support for LoongArch
Message-ID: <20230725120110.GF3765278@hirez.programming.kicks-ass.net>
References: <1690272910-11869-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690272910-11869-1-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 04:15:04PM +0800, Tiezhu Yang wrote:

> To be honest, there still exist some objtool warnings, I will try my best
> to fix them in the later versions or the other separate patches.

Please give us some examples of what's still going wrong. Are you
running into jump-tables? IIRC I've not seen code for those yet.
