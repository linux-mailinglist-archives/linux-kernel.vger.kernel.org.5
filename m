Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0F87D19A0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 01:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjJTXZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 19:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjJTXZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 19:25:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E73ED46
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 16:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=VQkh2w6nxq59DQY/g+S1v8aqhDwhhMqbkpG1e+mFz0g=; b=xDgN/GaPtCbG4tCQe/gwcrXHCi
        A+BEAz4RAL0txshAhPmkudK0i3d87S0ra09jdjqzIF5+i7RXncrc6mFXPutBlrBgrjfaB+FSbbJQ7
        sWB2k/LbcOEx6dRdUy7DHKL+xhU7PiiWH/tRLYP2rNu3+KmnburhXjhoXlorxoRBh7gKitgP4ZrWM
        v87i0+O1cIC5u1gpOUVY61H0zyhGsrhAIX3W2ZSGoMrl3eKmDDFngSbaCoahr6bh2UZ9P+SDikLBn
        FqaNtPOJz/vKCymPKwh4pMagkIvCzJU65F8EOowgX+xaXezr94GO3WTX/hxtcJ303nQBUwp9TZPo1
        JGAr21Ag==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qtyry-003BKi-32;
        Fri, 20 Oct 2023 23:25:30 +0000
Message-ID: <23d2abee-97eb-4b3e-a956-373884a0c57a@infradead.org>
Date:   Fri, 20 Oct 2023 16:25:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Update: Fixing SSH Hardware Key Issue
Content-Language: en-US
To:     youngbludproductions <youngbludproductions@proton.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <TQT4YufaV3YuStoFkD5gAcplDIsO76FYEqGQqYzLxrWzgNJ2FwqI__DjgyBZlPSOV6BVJXE54Wf8zroK728hlDXV2Mn5wt9kw2iovRBGPuI=@proton.me>
 <tAhUQSc5uwwjQtY_kdRUe79bpsl4gT2YVxWd3n59lBqUkyhPfEh_rj5lGKxWhxCNYzKJTziLWTYS75zRm8hXJ9AvF46WCMePw-1OybIrxsE=@proton.me>
 <tB722WaV9r9HqtIuctwx4NML64gv3Q0eiOiC9q9BxdxIZvc4naV6StrrpzQ3GQOyUeG0aRQYAidrlwOdA9DadrTLUbQgB2dhpzUeCu8SKsA=@proton.me>
 <w_eCxU02z0Fy-VeYdtdKYq73wdUGL5VRWXz3dgjndfTYOrYQiSAGJglyNUS8Vv6kEFdFiaAUPJHEbg-MCogBelKpLxg7edTEfWMXudCAr-A=@proton.me>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <w_eCxU02z0Fy-VeYdtdKYq73wdUGL5VRWXz3dgjndfTYOrYQiSAGJglyNUS8Vv6kEFdFiaAUPJHEbg-MCogBelKpLxg7edTEfWMXudCAr-A=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/23 16:15, youngbludproductions wrote:
> Hello?

Hi,

Did you send a patch?
I can't see one at https://lore.kernel.org/lkml/w_eCxU02z0Fy-VeYdtdKYq73wdUGL5VRWXz3dgjndfTYOrYQiSAGJglyNUS8Vv6kEFdFiaAUPJHEbg-MCogBelKpLxg7edTEfWMXudCAr-A=@proton.me/T/#m23ab5c9e74b22b7245e288c1f8ed748b94aab483

Also, what is it that you are trying to patch?
There are no files in the Linux kernel with the name net/ssh.c.

Or is this just some kind of noise?

-- 
~Randy
