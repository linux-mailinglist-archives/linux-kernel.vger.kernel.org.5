Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB307F5005
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344346AbjKVS5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbjKVS5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:57:34 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F193510C3;
        Wed, 22 Nov 2023 10:57:28 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 8C408120059;
        Wed, 22 Nov 2023 21:57:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8C408120059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1700679447;
        bh=5pEAGVMHc8CTrD7GrkHh/WKsgucxfvk3kjp7oHifpy8=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=Ps7gMGLYUda/9sTqLehU9RfZaHRhwpKP074r5tSVuqiqu5M3p5IygHC5alGBu98kM
         1UPJIXL6zr7Hjbw+Mi4UMM25mrRoIVf6OiumGiyk/6wAoxfjvvJUh+gUbmVTXsW7uh
         inw145BYrR7+QxUmOYJzPLt3kpVS3Zi6FjBRJBsrzGuXSE5fIENCODJ8jPj/T9R3/b
         MKJ1YJKZ0LHfGWQVMTMrb6qjhro3y5odZILgATUmslcgzs4TW/kH/JUoyovIwZOTXe
         WppijZA4S7wLB7Ed8AocJXmY+HEXOceK+odJhx8ScX5FspCF8l+pdh6yCsRBFTXZOx
         C6zzgmO2L9QBw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 22 Nov 2023 21:57:27 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 22 Nov
 2023 21:57:27 +0300
Date:   Wed, 22 Nov 2023 21:57:27 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     <rostedt@goodmis.org>, <mhiramat@kernel.org>, <hannes@cmpxchg.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        <muchun.song@linux.dev>, <akpm@linux-foundation.org>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] mm: memcg: introduce new event to trace
 shrink_memcg
Message-ID: <20231122185727.vcfg56d7sekdfhnm@CAB-WSD-L081021>
References: <20231122100156.6568-1-ddrokosov@salutedevices.com>
 <20231122100156.6568-3-ddrokosov@salutedevices.com>
 <ZV3WnIJMzxT-Zkt4@tiehlicka>
 <20231122105836.xhlgbwmwjdwd3g5v@CAB-WSD-L081021>
 <ZV4BK0wbUAZBIhmA@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZV4BK0wbUAZBIhmA@tiehlicka>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181545 [Nov 22 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 3 0.3.3 e5c6a18a9a9bff0226d530c5b790210c0bd117c8, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/22 11:24:00 #22501433
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 02:24:59PM +0100, Michal Hocko wrote:
> On Wed 22-11-23 13:58:36, Dmitry Rokosov wrote:
> > Hello Michal,
> > 
> > Thank you for the quick review!
> > 
> > On Wed, Nov 22, 2023 at 11:23:24AM +0100, Michal Hocko wrote:
> > > On Wed 22-11-23 13:01:56, Dmitry Rokosov wrote:
> > > > The shrink_memcg flow plays a crucial role in memcg reclamation.
> > > > Currently, it is not possible to trace this point from non-direct
> > > > reclaim paths.
> > > 
> > > Is this really true? AFAICS we have
> > > mm_vmscan_lru_isolate
> > > mm_vmscan_lru_shrink_active
> > > mm_vmscan_lru_shrink_inactive
> > > 
> > > which are in the vry core of the memory reclaim. Sure post processing
> > > those is some work.
> > 
> > Sure, you are absolutely right. In the usual scenario, the memcg
> > shrinker utilizes two sub-shrinkers: slab and LRU. We can enable the
> > tracepoints you mentioned and analyze them. However, there is one
> > potential issue. Enabling these tracepoints will trigger the reclaim
> > events show for all pages. Although we can filter them per pid, we
> > cannot filter them per cgroup. Nevertheless, there are times when it
> > would be extremely beneficial to comprehend the effectiveness of the
> > reclaim process within the relevant cgroup. For this reason, I am adding
> > the cgroup name to the memcg tracepoints and implementing a cumulative
> > tracepoint for memcg shrink (LRU + slab)."
> 
> I can see how printing memcg in mm_vmscan_memcg_reclaim_begin makes it
> easier to postprocess per memcg reclaim. But you could do that just by
> adding that to mm_vmscan_memcg_reclaim_{begin, end}, no? Why exactly
> does this matter for kswapd and other global reclaim contexts? 

From my point of view, kswapd and other non-direct reclaim paths are
important for memcg analysis because they also influence the memcg
reclaim statistics.

The tracepoint mm_vmscan_memcg_reclaim_{begin, end} is called from the
direct memcg reclaim flow, such as:
    - a direct write to the 'reclaim' node
    - changing 'max' and 'high' thresholds
    - raising the 'force_empty' mechanism
    - the charge path
    - etc.

However, it doesn't cover global reclaim contexts, so it doesn't provide
us with the full memcg reclaim statistics.

-- 
Thank you,
Dmitry
