Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F937BC6AB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 12:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343786AbjJGKNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 06:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjJGKNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 06:13:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26D692;
        Sat,  7 Oct 2023 03:13:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D573C433C8;
        Sat,  7 Oct 2023 10:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696673584;
        bh=TcALwCWaWLYZlDiKumVC2gfmtJ9T07W/GvdNt5U2KyA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T7hfTrU4H1juHzNZFz/CWpkXvoNKR4ClQeaDw1eGuv66m6uCiiiXVCKLd/Yf+uG86
         B604QMYHOW1nvt+qjjkwEYOkQht3+Rr4gLXZEkfQVTUl9RQfzZiMIXMv5ytnv6H2fD
         fsFHvoYdLlL8t79lJsEmptPCFWQ5WurZNMcSHmPPJ663cVNXedajsxP7mRAEA+MXiv
         80jn0ZkX3FLQpuQNFa8CALjMvPTItJXHwww1NNs0s4VKYxUWfDgkp/T6YN1mCQYKqI
         0/8NYNxr60h+OV7nyY6NOeZj8kNrII4YdzobptcGLaQB/QYHnNbPTKiIP3vVq0On1k
         +MKxxMeH40OGg==
Message-ID: <e6eb5949-fb48-7210-8162-3630a08761d5@kernel.org>
Date:   Sat, 7 Oct 2023 18:13:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5] scsi: support packing multi-segment in UNMAP command
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230310123604.1820231-1-chao@kernel.org>
 <b53321ab-679d-e007-6407-6bd00149948e@kernel.org>
 <yq17ct0nijm.fsf@ca-mkp.ca.oracle.com>
 <f93949dd-e90f-a9bf-33b3-4f31c4328c7d@kernel.org>
 <yq1sfabni01.fsf@ca-mkp.ca.oracle.com>
 <d3c1c2cb-9076-523b-da81-a1b632b4b0f5@kernel.org>
 <yq1h6p9k4vk.fsf@ca-mkp.ca.oracle.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <yq1h6p9k4vk.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Is it possible to commit this patch only to catch up 6.7-rc1, w/o other
changes in 5.20/discovery? I don't feel there is any strong correlation
between them, or am I missing something?

Thanks,

On 2023/8/8 22:04, Martin K. Petersen wrote:
> 
> Chao,
> 
>>>> Any progress on this patch?
>>> I'll resubmit this series for 6.6.
> 
> Been working on this series to address the reported regressions. Spent
> quite a bit of time on it last week.
> 
