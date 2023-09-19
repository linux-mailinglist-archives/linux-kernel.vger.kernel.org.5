Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EFA7A6678
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjISOUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjISOUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:20:42 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB291DD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:20:34 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230919142033euoutp0128e3907c578b04e8f7dce47a4331baf1~GUrHZZNLp0038000380euoutp01O
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 14:20:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230919142033euoutp0128e3907c578b04e8f7dce47a4331baf1~GUrHZZNLp0038000380euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695133233;
        bh=fox//NaKusRVB+tQZiqLz6Yqq7c40QK0z6M/vS0w1GI=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=fheb7HhrvJYdkWjmHlrsUE4Mf0ro1rssOhUu1Pd8hIZDoo4C2pTNzAPwi3ZGocFzZ
         LfhVXa5J5iSLeADVpWgRGFF0e7XWDXXToRboJG1szhXk0bdX6cmwhmMsBlzqlbCeG7
         HyH8L7RLtdIGOVq/tVCI99YSxBezQb6UzLQXdBFA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230919142033eucas1p21635f09a23733c2c38017d7c578803d1~GUrHKccu71031210312eucas1p2z;
        Tue, 19 Sep 2023 14:20:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 29.A8.37758.13EA9056; Tue, 19
        Sep 2023 15:20:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230919142032eucas1p2393f74632ae27aa124c271ade2be3c6d~GUrGo2uz_0693306933eucas1p2d;
        Tue, 19 Sep 2023 14:20:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230919142032eusmtrp12c3850d79112013dc0df518a5b7c76b3~GUrGoPNct0981909819eusmtrp1w;
        Tue, 19 Sep 2023 14:20:32 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-4f-6509ae3120ef
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1F.6E.10549.03EA9056; Tue, 19
        Sep 2023 15:20:32 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230919142032eusmtip10111f2d57aedb98c205d8a66ba790ee8~GUrGI4bOQ2615826158eusmtip11;
        Tue, 19 Sep 2023 14:20:32 +0000 (GMT)
Received: from [192.168.8.209] (106.210.248.121) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 19 Sep 2023 15:20:27 +0100
Message-ID: <38845b84-4a5d-0ceb-f7fb-44b392f91129@samsung.com>
Date:   Tue, 19 Sep 2023 16:20:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.15.1
Subject: Re: [PATCH 0/5] Improve zram writeback performance
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
CC:     <minchan@kernel.org>, <linux-kernel@vger.kernel.org>,
        <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <gost.dev@samsung.com>, Pankaj Raghav <kernel@pankajraghav.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20230919003338.GA3748@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.121]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2zmenU02zqaxtwtFmkVG06XQSq2EjP3oYpEFSZdRBzN12o7L
        S0WrdVVTU6ptimlYeamkVZu3Ildp3p1CxSpNskwrRVRMxcx5Fvnveb/nwvu8fCQm1rssICNV
        8bRapYz2IPi4uXa8dbXsIY/2HX8qlJd+yiDkTX3DuPyZfZW8ozKXkN8dHeTKqx7dJjYRihyt
        DVd0NGsUppIrhKK5OFgxbFoc6rKPH3iEjo48Qat9NhziH83O/YDHvSAS+8u/uGiR0SUF8Uig
        /CF3yj6D+aSYKkJgbqpF7DCCoPVetpMZRqBNs+D/LH2XDU7iHoKygYr/qsLC286hCsGXoW/c
        FESSAmoDdLZ5Odw45QW/R7UcBxZQIqg39MymzqPCwXCjADmwGxUAJW90mANjlATsPbdm9e6U
        DKbTL3Ec+RhVhqC0yIIc+QTlDWevcB0aHuUD5X/ecVjvSrhgmeSyeAlYfuVibANPaLCMcVl8
        Ghqe2GczgZom4dw5nfMym+HiVLdT5Ab9dU+ceBE0Zqc5T3ESvr6fxFjzeQQZFWWEYyGYaZDe
        FM1qgmHq7C2MfRbC+18idh8hZJlvYpnIyzjnFMY5lY1zKhjnVMhHeAmS0BomJoJm/FR0gpRR
        xjAaVYT0cGyMCc18nsY/daPlqKh/SGpFHBJZEZCYh7vAICNoseCIMimZVsceVGuiacaKFpK4
        h0SwKqj+sJiKUMbTUTQdR6v/sRySt0DLWdo2ZgsatDI1NnX4zsv8JNPFV/pdm9d8/l6Scwz6
        wwJ2q/yJgeJgzcT0pr1Mr01/4cU7hEd12Ltax1s0gdtSxktTNW9f7hjr2S6p83R9nTmhHBEJ
        g85cFVPJex6EtSTdX7ZxXWVfgp/718nUvaHammpTfMqD7vWJQ+1SdK3yZL7BN0mkU5GVtv0F
        3oLY/EKfEOrj8Z/bUj3XWtejrQW1QbxEb7OoPW00tK25faS67kfB9byX1c/zdKsTEgOfmrNk
        flkHTn0axB7neBq2SCe43brOzxLFnc75peltY5GZppsDFb3LB+q78jBp1Qo9X+ca0tqrF74S
        Lg85XVhEZrzxwJmjSpk3pmaUfwEDx5FcqwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7oG6zhTDU4t0LJYfbefzeLMy88s
        FntvaVtc3jWHzWLZ1/fsFrs3LmJzYPOY3XCRxePy2VKPTas62TzOrnT0+LxJLoA1Ss+mKL+0
        JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j8pzbLAUH2Cpe
        7XjM2sA4i7WLkZNDQsBE4mXHTCCbi0NIYCmjxLerd1ggEjISG79chSoSlvhzrYsNougjo0RL
        70aojt2MEp+PL2LuYuTg4BWwk7h3QRWkgUVAVeLH1wYmEJtXQFDi5MwnLCAlogLREl0vjUHC
        wgLWEqtONDOD2MwC4hK3nswHKxcRMJT439fOBDKeWWA9o8TqFdsZIXa9YZQ4+28/G8ggNgEt
        icZOdpAGTgF9iR3/rjNBDNKUaN3+mx3ClpfY/nYOM8QDyhKntn9nh7BrJT7/fcY4gVF0FpLz
        ZiG5YxaSUbOQjFrAyLKKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMFq3Hfu5eQfjvFcf9Q4x
        MnEwHmKU4GBWEuGdaciWKsSbklhZlVqUH19UmpNafIjRFBhGE5mlRJPzgekiryTe0MzA1NDE
        zNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBifH0qrM8XOXens0e1j9M9n1dc7JY
        RNFv9dEtIrc/TD7WUFO5yoX/6aXeP0lLJz68EPL0SzGDVFdxzkz1T4tmF/79leBrZ8U5ccqZ
        6fd4m2L+nZp/lnu369VVBn5tHsuSv0Z/NYiKY54zwTP7bsaVQzHF1V3Z7XZtnz8c1NxRWPo9
        4JtF89HPaRPOf/6z7Gd6k/xFf0PN82lndQ+/uZ23PKOfZ+3D8wYr90X5f73IsVz09g8Bns3e
        pgsrXl6bfvSMJfcZ9kvfDvH6XFg0z/O4aWL4Q6Onazb6JH2Ncq80WVPVuMIwPctpE+9/y6sn
        esR+FqxarezTvvDmmp5PPCHfFuXULM08NeP0yu+HRX9J/VZTYinOSDTUYi4qTgQALpNs2l8D
        AAA=
X-CMS-MailID: 20230919142032eucas1p2393f74632ae27aa124c271ade2be3c6d
X-Msg-Generator: CA
X-RootMTR: 20230911133442eucas1p2f773a475e0a6dc1a448c63884d58c8d3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230911133442eucas1p2f773a475e0a6dc1a448c63884d58c8d3
References: <CGME20230911133442eucas1p2f773a475e0a6dc1a448c63884d58c8d3@eucas1p2.samsung.com>
        <20230911133430.1824564-1-kernel@pankajraghav.com>
        <ef88e8e4-c94d-9ad3-a130-8cd6b3f722c9@samsung.com>
        <20230919003338.GA3748@google.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-19 02:33, Sergey Senozhatsky wrote:
> On (23/09/18 15:53), Pankaj Raghav wrote:
>> Gentle ping Minchan and Sergey.
> 
> Hello,
> 
> zram writeback is currently under (heavy) rework, the series hasn't
> been published yet, but it's in the making for some time already.
> The biggest change is that zram will support compressed writeback,
> that is writeback of compressed objects, as opposed to current design
> when zram de-compresses pages before writeback.
> 
Got it. Thanks for the explanation. The compressed writeback also makes
sense as it will save space in the backing device.

> Minchan will have more details, but I guess we'll need to wait for
> that series to land.

This series might not be applicable with the new direction, but anyway I will
keep an eye on the new series from Minchan.
