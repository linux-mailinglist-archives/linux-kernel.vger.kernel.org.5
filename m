Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35148783182
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjHUTQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjHUTQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:16:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F45F123;
        Mon, 21 Aug 2023 12:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=aOe8TRbwUHqLH2imlDXxTfHuBc28ZV41Q1Bv8yKRLhQ=; b=T2ygd1owfiNS91ZAPCwdw/AEgt
        7LSsgKIS/MShAlKJo23fVXJaWeEfs1NGpQogXGTw5xB44WpALIfZDAKOfi5guPerKqZS0vpT3etPO
        YI4DfgHegMQnDbgO1vatajApMST4d6guMLpShzuGRclDFQmcu+ri1FXSLQSJSxcjOI5leJ7iaew/z
        RdRhppl5A0eI6u2Iem0WWcHStkCxfN0n8WbBadYuBmfgnWoVmJ+oXpcOcbRb6F9ys2C8h0x6Az8a4
        wR5pvTFvT0smD6DcUvDAvHBbxOdUfRWNBxZzlV8liVfQland4p3mypSwGHfxNX8W/gzEN0+01NZPa
        LOZoMjfQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qYAOG-00EZtD-2B;
        Mon, 21 Aug 2023 19:16:40 +0000
Message-ID: <5ebf04f8-0cf6-d2b4-fb73-f51fff421b3a@infradead.org>
Date:   Mon, 21 Aug 2023 12:16:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: linux-next: Tree for Aug 21 (riscv-64 asm)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
References: <20230821164605.7bac05f1@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230821164605.7bac05f1@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

../arch/riscv/kernel/traps.c: In function 'do_irq':
../arch/riscv/kernel/traps.c:384:1: error: s0 cannot be used in 'asm' here
  384 | }
      | ^
../arch/riscv/kernel/irq.c: In function 'do_softirq_own_stack':
../arch/riscv/kernel/irq.c:94:1: error: s0 cannot be used in 'asm' here
   94 | }
      | ^


2 out of 10 risc-v 64-bit builds failed with these errors.

Is this a toolchain problem or something else?

Thanks.

-- 
~Randy
