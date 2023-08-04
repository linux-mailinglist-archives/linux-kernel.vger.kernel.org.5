Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D45D76F8B9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 06:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjHDECN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 00:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHDECL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 00:02:11 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B66B2D69;
        Thu,  3 Aug 2023 21:02:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vp-rkA7_1691121723;
Received: from 30.221.100.251(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0Vp-rkA7_1691121723)
          by smtp.aliyun-inc.com;
          Fri, 04 Aug 2023 12:02:05 +0800
Message-ID: <4de725f9-6bc6-b150-c6cd-1bc185edc145@linux.alibaba.com>
Date:   Fri, 4 Aug 2023 12:02:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH net-next 2/6] net/smc: add vendor unique experimental
 options area in clc handshake
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
Cc:     wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230803132422.6280-1-guangguan.wang@linux.alibaba.com>
 <20230803132422.6280-3-guangguan.wang@linux.alibaba.com>
 <ZMvnvLOZgtmS2IqN@kernel.org>
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <ZMvnvLOZgtmS2IqN@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I will fix it in the next version.

Thanks, 
Guangguan Wang

On 2023/8/4 01:45, Simon Horman wrote:
> On Thu, Aug 03, 2023 at 09:24:18PM +0800, Guangguan Wang wrote:
> 
> ...
> 
> Hi Guangguan Wang,
> 
>> @@ -987,12 +991,12 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>>  {
>>  	struct smc_connection *conn = &smc->conn;
>>  	struct smc_clc_msg_accept_confirm *clc;
>> -	struct smc_clc_first_contact_ext fce;
>> +	struct smc_clc_first_contact_ext_v2x fce;
>>  	struct smc_clc_fce_gid_ext gle;
>>  	struct smc_clc_msg_trail trl;
>>  	struct kvec vec[5];
>>  	struct msghdr msg;
>> -	int i, len;
>> +	int i, len, fce_len;
> 
> Please preserve reverse xmas tree - longest line to shortest -
> for local variable declarations: this is Networking code.
> 
> https://github.com/ecree-solarflare/xmastree is your friend here.
> 
> ...
