Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BD87790A4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbjHKNTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjHKNTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:19:15 -0400
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87DB90
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1691759648;
        bh=Jz23wIj7LJartg6R7vEVxXMTonDtsKheJHnasbl5MoY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PMxxLmZSxiu6LT1CRMenLATTdqAKDEuw734rNrujHSZYZCCu6NPgJf18ejXt4otGq
         UbkeS5XJ+ZfevkJOFkNiFYsJTFlZLXCCqxltb9yM3dQAVG3APgPHlLugFR9+ijOrEz
         PX0QVc52xq063JRT5ja71aJcGlqoUTmkTUnlxJ+Q=
Received: from [172.25.21.182] ([175.152.51.41])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 2C18EFA; Fri, 11 Aug 2023 21:00:44 +0800
X-QQ-mid: xmsmtpt1691758844tyj05j6vq
Message-ID: <tencent_57C27F10612C62EDE4FEBAA942F8538BA305@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYS8nKPAQjoaqijo+6Wj/KEP4XsJHF3ZFU8sDB6f3Juoug+0qOxko
         lXKHkEP/jI959n2Rmc5nonvnD/nuTK/RjfdVRf08L+z5tUBqx/yQk16bNmbo8yE+TIfatMMYTBQw
         51tCP1iazhILN/spSzFb4dxJKyU1bcsfXGxvpVY1SeqGcoEzBnYhiobPAIfFDZ84MSd81CQOrdYp
         WsVx6VaXTxk6TwqYvHrwzFP1axr2CuDadfYoIJbxNRK0D0TlMoD6uQeLKExef+t42+5PQYuzkiee
         1UNSmsHMrEue8llDHUGJlN2XANnmoxkwZeTgNnd2GmPrkLsPmqsRjIdfOL+pvbkuN8i1JbFgdbUM
         j8kwjbtUqckndw1Ik99nROUE3Ztnks/ugBhImuCBO1maRLRcNKfASufAKRha9VGog23kffVpxFAj
         KRCF4AuwxziyvpjxIg5/s2vIrvLM55aWxLS4AXkdrsKr0tu0w2PmHr+8u47FfP3XgFgvZ6GEGNTp
         gel/ZXsZ4bK9RDe88MZ6yeAj7MASrxBxCFWj4ig/dqO9ktcPHabf7K9Kbx63w1RN43d5TDulL5k7
         RwjIZHG+AwM1mXMsPs/OueBiB5ptvjCFS/Dn6p2B82uSCPjozAQjeSs/mgQSu0mCYk1dCUTI705s
         8j3goc0daSrby+3dw9NZ6a52Xj9PydIorUol2fEUlGgnoitbgbD8rb9OsNt+RhAYl5S2TJOLHlF1
         Bbku4PXUpVJQOfzUYYatQ73jQKVZ54uvuDN8S6GJV+S8Noo1Z3cPpMG5t/IsFtnHQR/v4I1J0XRU
         fBHo7PsNzGZIfVAmcyocZdNqNUJf7gzFDJ52IObC8EvCRzjR3vDBPxpr5t7rLc2AfpIg1lEp1J/K
         ELVv3hiAzoLMwvCBK/x07BYbPP8t2mp309i9OmQ+Rmd2Wcrd9Ws/VRnWFAeHgdC+saeI+S+zsxBg
         Ll8gWJFPn8QBlQFabnaTEnt7nOu3fn2T66JqOs+yjhEL5A09xoKw==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
Subject: Re: [patch V3 33/40] x86/cpu: Use common topology code for HYGON
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.585648729@linutronix.de>
From:   Pu Wen <pu_wen@foxmail.com>
X-OQ-MSGID: <bb51258c-526b-0d24-3db1-f6f9089d218e@foxmail.com>
Date:   Fri, 11 Aug 2023 21:00:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20230802101934.585648729@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/2 18:21, Thomas Gleixner wrote:
> --- a/arch/x86/kernel/cpu/hygon.c
> +++ b/arch/x86/kernel/cpu/hygon.c
> @@ -20,12 +20,6 @@
>   
>   #define APICID_SOCKET_ID_BIT 6

The macro should be removed, since it's no needed any more.

-- 
Regards,
Pu Wen

