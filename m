Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4134476965D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjGaMbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjGaMbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:31:41 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81639E66;
        Mon, 31 Jul 2023 05:31:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vogfr9A_1690806695;
Received: from 30.221.150.94(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vogfr9A_1690806695)
          by smtp.aliyun-inc.com;
          Mon, 31 Jul 2023 20:31:36 +0800
Message-ID: <6581496b-57e8-d5bf-ae3e-fb466ed5dff9@linux.alibaba.com>
Date:   Mon, 31 Jul 2023 20:31:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v5 4/5] perf jevents: Add support for Arm CMN PMU aliasing
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1690525040-77423-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1690525040-77423-5-git-send-email-renyu.zj@linux.alibaba.com>
 <01f793eb-6373-e6c0-a712-9e08ee3c91c8@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <01f793eb-6373-e6c0-a712-9e08ee3c91c8@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/28 下午4:17, John Garry 写道:
> On 28/07/2023 07:17, Jing Zhang wrote:
>> Currently just add aliases for part of Arm CMN PMU events which are
>> general and compatible for any SoC and CMN-ANY.
>>
>> "Compat" value "434*;436*;43c*;43a*" means it is compatible with all
> 
> As mentioned in patch 1/5, a comma-separated list seems a better delimiter to me
> 
>> CMN600/CMN650/CMN700/Ci700.
> 
> It would be good if you could provide a link to where you got these events. I think that it is the publicly available CMN TRM document.
> 

Ok, will do.

Thanks,
Jing

>>
>> Signed-off-by: Jing Zhang<renyu.zj@linux.alibaba.com>
> 
> Apart from comments, above:
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
