Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3617C81356E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjLNP4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjLNP4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:56:39 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2201E8;
        Thu, 14 Dec 2023 07:56:44 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VyUiwjL_1702569400;
Received: from 30.39.135.226(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VyUiwjL_1702569400)
          by smtp.aliyun-inc.com;
          Thu, 14 Dec 2023 23:56:42 +0800
Message-ID: <3c1f3b68-f1fc-495c-5430-ba7bc7339619@linux.alibaba.com>
Date:   Thu, 14 Dec 2023 23:56:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC nf-next 1/2] netfilter: bpf: support prog update
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        coreteam@netfilter.org,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>
References: <1702467945-38866-1-git-send-email-alibuda@linux.alibaba.com>
 <1702467945-38866-2-git-send-email-alibuda@linux.alibaba.com>
 <20231213222415.GA13818@breakpoint.cc>
 <0e94149a-05f1-3f98-3f75-ca74f364a45b@linux.alibaba.com>
 <CAADnVQJx7j_kB6PVJN7cwGn5ETjcSs2Y0SuBS0+9qJRFpMNv-w@mail.gmail.com>
 <e6d9b59f-9c98-53a1-4947-720095e0c37e@linux.alibaba.com>
 <CAADnVQK5JP3D+BrugP61whZX1r1zHp7M_VLSkDmCKF9y96=79A@mail.gmail.com>
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <CAADnVQK5JP3D+BrugP61whZX1r1zHp7M_VLSkDmCKF9y96=79A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/23 9:37 PM, Alexei Starovoitov wrote:
> yes. it's and it's working as expected. Do you see an issue?

Hi Alexei,

I see the issue here is that bpf_nf_link has not yet implemented 
prog_update,
which just simply returned -EOPNOTSUPP right now.

Do you mean that it is already implemented in the latest tree or
the not-supported was expected?

Thanks,
D. Wythe
