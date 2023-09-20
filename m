Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FB37A82C0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbjITNFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbjITNFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:05:50 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3125E12B;
        Wed, 20 Sep 2023 06:05:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VsVIPo7_1695215133;
Received: from 30.221.128.235(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsVIPo7_1695215133)
          by smtp.aliyun-inc.com;
          Wed, 20 Sep 2023 21:05:34 +0800
Message-ID: <447f1d11-38de-e896-dead-6b27502e1886@linux.alibaba.com>
Date:   Wed, 20 Sep 2023 21:05:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 06/18] net/smc: extend GID to 128bits for virtual
 ISM device
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        kernel test robot <lkp@intel.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695134522-126655-7-git-send-email-guwen@linux.alibaba.com>
 <202309201408.95QRxHEl-lkp@intel.com>
 <50feb145-c658-b9a1-7261-b67bb82767dc@linux.alibaba.com>
 <09ef007793b27e2ba5cc75a33c99cf8ead62c7f3.camel@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <09ef007793b27e2ba5cc75a33c99cf8ead62c7f3.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/20 17:00, Niklas Schnelle wrote:

>>
>> I do not have a local compilation environment for s390 (IBM Z) architecture. But I think
>> it can be fixed by the following patch.
> 
> With these kernel test robot mails the bot provides
> instructions for reproducing with a cross toolchain from the 0day
> project. See the line starting with "reproduce (this is a W=1 build):"
> i.e. in this particular case it links the URL:
> https://download.01.org/0day-ci/archive/20230920/202309201408.95QRxHEl-lkp@intel.com/reproduce


Ah, I see. Thank you Niklas for the explanation. :)
