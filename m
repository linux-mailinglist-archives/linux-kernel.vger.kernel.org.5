Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EF578FBE2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbjIAKsU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Sep 2023 06:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjIAKsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:48:19 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B84E7E;
        Fri,  1 Sep 2023 03:48:16 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 7074F1865E55;
        Fri,  1 Sep 2023 13:48:12 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Zwt2zFeoCraw; Fri,  1 Sep 2023 13:48:12 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 1997618661F0;
        Fri,  1 Sep 2023 13:48:12 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Degb1gD8dMne; Fri,  1 Sep 2023 13:48:12 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.103])
        by mail.astralinux.ru (Postfix) with ESMTPS id 020881865797;
        Fri,  1 Sep 2023 13:48:10 +0300 (MSK)
Received: from [10.177.232.93] (unknown [10.177.232.93])
        by new-mail.astralinux.ru (Postfix) with ESMTPA id 4RcZWG2WbbzgYRv;
        Fri,  1 Sep 2023 13:48:10 +0300 (MSK)
Message-ID: <977826f0-3289-53bd-b3f6-90977a4e0ca0@astralinux.ru>
Date:   Fri, 1 Sep 2023 13:48:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v3] fsl_ucc_hdlc: process the result of hold_open()
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>, Zhao Qiang <qiang.zhao@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
References: <896acfac-fadb-016b-20ff-a06e18edb4d9@csgroup.eu>
 <20230828121235.13953-1-adiupina@astralinux.ru>
 <20230828123849.69466f0a@kernel.org>
From:   =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGA0LAg0JTRjtC/0LjQvdCw?= 
        <adiupina@astralinux.ru>
In-Reply-To: <20230828123849.69466f0a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review!

28.08.2023 22:38, Jakub Kicinski пишет:
> Don't you have to undo all the things done prior to hdlc_open()?
Yes, it looks like I really need to undo everything that was done before 
hdlc_open().
But the question arose - would it be enough to call the uhdlc_close(dev) 
function?
In addition, it seems to me and my colleagues that a call to 
hdlc_close(dev) should be added to the uhdlc_close() function, similar 
to the following functions:
1. drivers/net/wan/n2.c (n2_close function)
2. drivers/net/wan/pc300too.c (pc300_close function)
3. drivers/net/wan/pci200syn.c (pci200_close function)
4. drivers/net/wan/wanxl.c (wanxl_close function)
Tell me, please, are we wrong?
