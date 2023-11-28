Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07B57FB1ED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343643AbjK1GXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343644AbjK1GWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:22:55 -0500
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B4E1AE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:23:00 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VxJT9eY_1701152567;
Received: from 30.222.33.26(mailfrom:cruzzhao@linux.alibaba.com fp:SMTPD_---0VxJT9eY_1701152567)
          by smtp.aliyun-inc.com;
          Tue, 28 Nov 2023 14:22:58 +0800
Message-ID: <5ab76c0c-6333-4452-ae51-9193926c802c@linux.alibaba.com>
Date:   Tue, 28 Nov 2023 14:22:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: ignore exited thread when synthesize thread map
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        kprateek.nayak@amd.com, linux-kernel@vger.kernel.org
References: <20231122022154.12772-1-CruzZhao@linux.alibaba.com>
 <CAM9d7chVZRKUSmXmZS4OyokKfLKp4h8K8RLWehYRpAs5Z4jsbg@mail.gmail.com>
From:   cruzzhao <cruzzhao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <CAM9d7chVZRKUSmXmZS4OyokKfLKp4h8K8RLWehYRpAs5Z4jsbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/11/23 上午5:05, Namhyung Kim 写道:
> Hello,
> 
> On Tue, Nov 21, 2023 at 6:22 PM Cruz Zhao <CruzZhao@linux.alibaba.com> wrote:
>>
>> When synthesize thread map, some threads in thread map may have
>> already exited, so that __event__synthesize_thread() returns -1
>> and the synthesis breaks. However, It will not have any effect
>> if we just ignore the exited thread. So just ignore it and continue.
> 
> Looks ok.  But I guess you want to do the same for the leader
> thread below as well.
> 
> Thanks,
> Namhyung
> 

With my testcase, no error is returned even if we don't do the same for
the leader thread blow. Well, I'll check whether the logic is still
correct if we do so.

Many thanks for reviewing.

Best,
Cruz Zhao
