Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4603C7BC7D3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343932AbjJGMvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343882AbjJGMvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:51:08 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49236B9;
        Sat,  7 Oct 2023 05:51:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8EF3A42617;
        Sat,  7 Oct 2023 12:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1696683062; bh=iMMy30V2RH8HcFAxtufW8zJaG9pqEhOMkEXIgIHkq3w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=NT94CZh0cDdfJkYzwtrEiGKhibKhm24cN9CWUZKfKgZeSV/MiEj79eaefgp8L8/e2
         EYLkGQ/azhx2fp0nwbBpEqNoF9jhCJPMbDvF6Pjhu6GyTR6ItH2ezD7v0UNBZeGp6L
         ANzPrfjfpLt0629j9mNVucxqwVEq2KERadWPmRlTbjyUS9+QMFDaLPXf+G9+ZXfAfi
         zElfJmGxuVXT7VIKcL+lbyf224yf8jWdQr2VtZz8TcK0+cyyfbwiZsbescfeVWPjmd
         pQb8mWRVCEVdM+4AsXZCRP7SPcKarphtPdRrUGUfjDeRMfjkgEjj0W2U3s5fUjLWwt
         BfEbAqK1z0n2g==
Message-ID: <e470902a-35eb-9bb4-7a9e-167f985c98bb@marcan.st>
Date:   Sat, 7 Oct 2023 21:50:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: On brcm80211 maintenance and support
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        SHA-cyfmac-dev-list@infineon.com,
        brcm80211-dev-list.pdl@broadcom.com,
        Asahi Linux <asahi@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
References: <6f78e624-62ee-3ae5-1db4-a0411566def8@yandex.ru>
 <CAGRGNgU7aySyUny9aG_+wXiKJ7j1weosa-rZDY4_WAXbq-3ABg@mail.gmail.com>
 <87ttr454bh.fsf@kernel.org> <3c5a3e7a-b332-4a77-51ba-bed3cad1e79f@marcan.st>
 <e1ee4d76-f717-a67c-8099-7b91192ba1ca@yandex.ru>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <e1ee4d76-f717-a67c-8099-7b91192ba1ca@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2023 00.48, Dmitry Antipov wrote:
> On 10/6/23 18:34, Hector Martin wrote:
> 
>> For better or worse, if nobody else does, I'm willing to sign up to
>> maintain the chips shipping on Apple ARM64 machines (i.e. BCM4378,
>> BCM4387, BCM4388 - that last one I have bringup for downstream, just got
>> it done this week) and partially BCM4377 as a bonus (since I have access
>> to an older Intel Mac with that one, and already did bringup for it,
>> though my access is sporadic). I'm already playing part time maintainer
>> anyway (other folks have already sent us patches I'll have to upstream),
>> and we need this driver to keep working and continue to support new chips.
> 
> Good news. Would you capable to consider some generic (not hooked to any
> particular hardware) things like [1] ?
> 
> [1] https://lore.kernel.org/linux-wireless/20230703162458.155942-1-dmantipov@yandex.ru/
> 

Sure, I've done cleanup type stuff myself too.

- Hector

