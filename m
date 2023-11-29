Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1367FCC26
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 02:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjK2BGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 20:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjK2BGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 20:06:05 -0500
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FD91727
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 17:06:11 -0800 (PST)
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
        by cmsmtp with ESMTPS
        id 86JArzhIYgpyE891mrUJP3; Wed, 29 Nov 2023 01:06:10 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 891lr0Ji4RQmi891lrj45g; Wed, 29 Nov 2023 01:06:09 +0000
X-Authority-Analysis: v=2.4 cv=CdcbWZnl c=1 sm=1 tr=0 ts=65668e81
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=7m0pAUNwt3ppyxJkgzeoew==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10
 a=baS5nS6MRrMoxbYeFxYA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=C/YiKZxhNMFFaE6XGPApsU1lijWfxX0VGsY6O+BLkM4=; b=XJ5PlnrM6kR1l1gH+7qJlyyh2f
        a5JD20rrWDqIpkBIOWumTlDNMoYLtNdjgHAE5Gu7/Kb/OIVUpHWb2q4xFTEssZeyoUaD4SB+BS7VA
        qwFWyYvqJvXBDYSpotAsFnroDEO+iSHZOBZKfwy3lAetH3X7GOANiPTP/lX2pIog5JqkD/8HhiYLx
        ZralkC8fT5PFsGpbGQItMoJZhvElNhSHI6+n7JShHDwf2vFyfIm7j4NQ1+BIaBuHC/dkrj4Q2AEH4
        aAq6Cv+cyyxeJF/a/nicAkoRX3TKHOuSH4ivEGIKXBMdpJuGvQD4JA6nZVSClm4iHf1A5owPtqhlB
        KOkFPYMg==;
Received: from 187.184.156.122.cable.dyn.cableonline.com.mx ([187.184.156.122]:48879 helo=[192.168.0.9])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r891k-0028aN-1Q;
        Tue, 28 Nov 2023 19:06:08 -0600
Message-ID: <f0662715-928d-4685-8f88-f2129eddab3c@embeddedor.com>
Date:   Tue, 28 Nov 2023 19:06:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Nouveau] [PATCH][next] nouveau/gsp: replace zero-length array
 with flex-array member and use __counted_by
Content-Language: en-US
To:     Danilo Krummrich <dakr@redhat.com>, Timur Tabi <ttabi@nvidia.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>
Cc:     "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ZVZbX7C5suLMiBf+@work> <ZVZxXiXYIzEwUE3N@pollux>
 <6517a6a41eb72d16596c913dc56467e0390287a3.camel@nvidia.com>
 <4b10068c-4285-41df-b4bb-4c61ac70a30b@redhat.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <4b10068c-4285-41df-b4bb-4c61ac70a30b@redhat.com>
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
X-Exim-ID: 1r891k-0028aN-1Q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.156.122.cable.dyn.cableonline.com.mx ([192.168.0.9]) [187.184.156.122]:48879
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFJ7zQyXA74sZNGt1tKWzocc2wTeBya+3lCYlqbHoAfsbfkKFA3SkFHtkILuvu9NGYd8a3tB3NUNaJGLz0HfvZr1bLQZDyLDx29z7wfHFkkDgKy3WlP1
 M5NeF3GfesHrX6Dio9CqJrlpZrNkefGK8yL+JdgUVqRchwPSlGgbgww5xYBmKJA5tN+BqFDWY3oi01mo9FJmn4Ggx7lU7NaokQ/5JD36W9STmLtRtLU7LGz9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/23 19:01, Danilo Krummrich wrote:
> On 11/16/23 20:55, Timur Tabi wrote:
>> On Thu, 2023-11-16 at 20:45 +0100, Danilo Krummrich wrote:
>>> As I already mentioned for Timur's patch [2], I'd prefer to get a fix
>>> upstream
>>> (meaning [1] in this case). Of course, that's probably more up to Timur to
>>> tell
>>> if this will work out.
>>
>> Don't count on it.
> 
> I see. Well, I think it's fine. Once we implement a decent abstraction we likely
> don't need those header files in the kernel anymore.
> 
> @Gustavo, if you agree I will discard the indentation change when applying the
> patch to keep the diff as small as possible.

No problem.

Thanks
--
Gustavo


