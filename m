Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC0A79C2A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbjILCUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbjILCUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:20:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6F5143B40
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=wmp0mGEWHJXg3E6yu84mR6YhMlPNWonmnl8TLlhPUKk=; b=OEEAhBFAApw6acWA7yfjsl38Up
        UTP/31X7NH1mQ5FwmuhSYrwd0ExzFb5PTObBaiWbVVDnf0uVNZdrYUsY4t5zDg2Zjgfpe6p1uqYGh
        QeYrKN+fQbfCXb9xEUq4N976e3up8o689ClljYkDK2fnYTyzPbhzrnfC5PgFsiVz62PIdr7gRrEyW
        R5/MZAyJRSXXlL1j3KXuDIhBToqSeQnuAPvyHlRfWrWDq2LLLYUbKKciCN3mX3sLHYwhcXgbYRBpa
        ODt4gwx/3QDHVotpYfVLmGxPWAWT+aeEjA4XH2s87H48NYau4xk2uT/K8uXG0RdSqPsZrxc221hnh
        ajAETYPw==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qfq1J-001aXk-1h;
        Mon, 11 Sep 2023 23:08:41 +0000
Message-ID: <8b5d0d32-4413-4c70-4ecb-ee44542f4dd5@infradead.org>
Date:   Mon, 11 Sep 2023 16:08:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: Build regressions/improvements in v6.6-rc1
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
References: <CAHk-=wgfL1rwyvELk2VwJTtiLNpwxTFeFtStLeAQ-2rTRd34eQ@mail.gmail.com>
 <20230911083848.1027669-1-geert@linux-m68k.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230911083848.1027669-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 9/11/23 01:38, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v6.6-rc1[1] compared to v6.5[2].
> 
> Summarized:
>   - build errors: +4/-13
>   - build warnings: +4/-1453
> 
> Note that there may be false regressions, as some logs are incomplete.
> Still, they're build errors/warnings.
> 
> Happy fixing! ;-)
> 
> Thanks to the linux-next team for providing the build service.
> 
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0bb80ecc33a8fb5a682236443c1e740d5c917d1d/ (all 237 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/2dde18cd1d8fac735875f2e4987f11817cc0bc2c/ (234 out of 237 configs)
> 
> 
> *** WARNINGS ***
> 
> 4 warning regressions:
[]
>   + modpost: WARNING: modpost: vmlinux: section mismatch in reference: ioremap_prot+0x88 (section: .text) -> ioremap_fixed (section: .init.text):  => N/A

I would consider trying to fix this one but I can't fathom trying to search thru 237 build logs with a web browser
to find which arch/config it is.

I did start on that but I'm giving up.

If possible, please add the arch/config info to the Build regressions/improvements reports
in the future.

thanks.
-- 
~Randy
