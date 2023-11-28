Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026367FC83B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346892AbjK1VST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346879AbjK1VSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:18:03 -0500
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0781BC1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:11:39 -0800 (PST)
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
        by cmsmtp with ESMTPS
        id 83sKrWDNJ6nOZ85MorBM29; Tue, 28 Nov 2023 21:11:38 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 85Mnr4QyzRGmS85Mnr4Mwn; Tue, 28 Nov 2023 21:11:37 +0000
X-Authority-Analysis: v=2.4 cv=efcuwpIH c=1 sm=1 tr=0 ts=65665789
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=7m0pAUNwt3ppyxJkgzeoew==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10 a=zd2uoN0lAAAA:8
 a=9zuar6N38og71xDKz2QA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TiP/2V3RC/zKLbrrfqT8GJnX8XnNxPZk+5RBTrP/V9g=; b=KD5go6n4Le1krDwyf5jeGC8zSu
        Qw/3YLFf/p+C22i+MOSJLnd9nze0xXzvlA1S5uBXbKaXJD1RE3MIpGxnINEKteLY3csjClrNIc0Vz
        O5yUWRfxEgqomVRie2QZtb9tsCI00dI+/qqYlss5aa/ECT8XBHASTE6kcgXk+6eZwpvekCcYwOZtX
        FctGxBVNIT58kNyOlP+wx/p74CrhNrEWbzFSY4DNUXG8kgfCfOKOZJJ5fpecBzXX7Prr6+5Yu3NZ2
        l5/y0OjF7qrRxidQQGauBPvcICw2YtuyA2dVL7eTQzNFUHx39oWkMAnESjVMvJKEj5QuRKY+NCc49
        qb6w6SeA==;
Received: from 187.184.156.122.cable.dyn.cableonline.com.mx ([187.184.156.122]:31312 helo=[192.168.0.9])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r85Mm-003FhB-2a;
        Tue, 28 Nov 2023 15:11:36 -0600
Message-ID: <001021e0-2262-49c8-89d0-c0d0720ca313@embeddedor.com>
Date:   Tue, 28 Nov 2023 15:11:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warnings after merge of the kspp-gustavo tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Aithal, Srikanth" <sraithal@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231122144814.649823ac@canb.auug.org.au>
 <813f3aa2-3449-7264-fa54-eaafd9981add@amd.com>
 <20231128091351.2bfb38dd@canb.auug.org.au>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231128091351.2bfb38dd@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.156.122
X-Source-L: No
X-Exim-ID: 1r85Mm-003FhB-2a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.156.122.cable.dyn.cableonline.com.mx ([192.168.0.9]) [187.184.156.122]:31312
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLJow5y7hpYAhYTwCX5RuUJsAgAqiPti15joqkVuIMpv9049l/UIUu8NdgvqkcuTXUUMK55QMLVeLLQPFj7O+ZKU4M/40MN3T9WFZDre0Jxjh4kZ7frW
 klyNcz8OSSAg3OsYrnSJVoct7vXufMxXdUCupIoYm3vzEkrigypeeJygJ/X+9Luh/+VGDYU1g2WRY1YiI5jmyavB79BFqbCiVkcMoGpfi5yV9ZcTyRwCfbdp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 11/27/23 16:13, Stephen Rothwell wrote:
> Hi Gustavo,
> 
> On Wed, 22 Nov 2023 10:21:27 +0530 "Aithal, Srikanth" <sraithal@amd.com> wrote:
>>
>> @Gustavo I see you have mentioned it as gcc issue. I was not hitting this until yesterdays linux-next build. I am on latest gcc which RHEL 9.x provides,
>> gcc --version
>> gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2)
> 
> Given that gcc 11 is a provided compiler on RHEL 9, can you not add
> -Wstringop-overflow for that compiler, please.


Sure thing. Working on that. :)

--
Gustavo

