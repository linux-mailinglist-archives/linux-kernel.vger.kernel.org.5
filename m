Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0887B9FEE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbjJEOba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbjJEO31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:29:27 -0400
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EBB199F;
        Thu,  5 Oct 2023 06:49:35 -0700 (PDT)
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 15AF0102396;
        Thu,  5 Oct 2023 15:32:09 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [176.16.4.50])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 0FFD1102395;
        Thu,  5 Oct 2023 15:31:24 +0300 (MSK)
Received: from [176.16.7.18] (gang [176.16.7.18])
        by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 395CVNlh030864;
        Thu, 5 Oct 2023 15:31:23 +0300
Message-ID: <fb9f1d68-77a4-0620-10fc-982b83660de8@mcst.ru>
Date:   Thu, 5 Oct 2023 15:31:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [lvc-project] [PATCH] wifi: mac80211: fix buffer overflow in
 ieee80211_rx_get_bigtk()
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20231004143740.40933-1-Igor.A.Artemiev@mcst.ru>
 <3ba8e3902ade7483a82bd305a35a236744ffba25.camel@sipsolutions.net>
From:   "Igor A. Artemiev" <Igor.A.Artemiev@mcst.ru>
In-Reply-To: <3ba8e3902ade7483a82bd305a35a236744ffba25.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
         bases: 20111107 #2745587, check: 20231005 notchecked
X-AV-Checked: ClamAV using ClamSMTP
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/4/23 17:58, Johannes Berg wrote:
> And ... how exactly do you propose that is going to happen?

'conf.keyidx', the value that is passed to the function, can be 0. But I 
missed checking the second argument of the ieee80211_rx_get_bigtk() 
function before calling it. Sorry to bother you.

Thanks,
Igor

