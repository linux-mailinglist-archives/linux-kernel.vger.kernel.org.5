Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83D4771349
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 04:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjHFCxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 22:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjHFCxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 22:53:09 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911AE130
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 19:53:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vp4sLaG_1691290378;
Received: from 30.121.9.24(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0Vp4sLaG_1691290378)
          by smtp.aliyun-inc.com;
          Sun, 06 Aug 2023 10:53:00 +0800
Message-ID: <bc4da863-dacb-66a7-133d-0e6e91e4477a@linux.alibaba.com>
Date:   Sun, 6 Aug 2023 10:52:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] watchdog/hardlockup: set watchdog_hardlockup_warned to
 true as early as possible
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     dianders@chromium.org, pmladek@suse.com,
        linux-kernel@vger.kernel.org
References: <20230805160144.121875-1-liusong@linux.alibaba.com>
 <20230805101705.3a38ce9aacc924f1c9f0842b@linux-foundation.org>
From:   Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <20230805101705.3a38ce9aacc924f1c9f0842b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/8/6 01:17, Andrew Morton 写道:
> When resending, please tell us some more about the effects of the
> change.  Presumably there are circumstances in which excess output is
> produced?  If so, describe these circumstances and the observed
> effects.

Hi,

I haven't found duplicate warnings in the real environment.

However, considering that when system occurs hard lockup is basically 
abnormal, it

seems more reasonable to set "watchdog_hardlockup_warned" to ture, 
rather than

waiting for all kinds of information to be printed.


Thanks

