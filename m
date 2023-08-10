Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE903776DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 04:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjHJCLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 22:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHJCLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 22:11:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF58E1994;
        Wed,  9 Aug 2023 19:11:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4247564D60;
        Thu, 10 Aug 2023 02:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81A1C433C8;
        Thu, 10 Aug 2023 02:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691633469;
        bh=Xmj5Hw9bXbD+n2QxxETzLYYwbDpFqsj8ZEKO8m6cOyo=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=g03ZkIATKxsdf1zYiY27ZiSWENEdMSOm6PpoLf7GLme1TKb8BMBe4G2pXhzChD36d
         SqLZ3KDEBDrB77YnSyIynCpxdG7b0kWFEeC+8Wo1tplRkopz61Ak+aj6zsP1OsfFEm
         GeKCwLtXZFFqYWD0ZWGf2giUIvadSiAVCzQ+yPkVrf2Oi/MBAm/n1+ZwYx9ZDQNOwo
         1M972LO+gZT4UpVhd9ywxgAQW3rQOtpKW31w7P9Slspc4/yrciYuHCa2o+pSNTgjXQ
         ywiLDIcbneT9nPcUs+A1mlG70RSPhbn0Io+vwQcgX7COrKHm0MbZBdrlpuziCSCQ4v
         OjAfpbfrss85w==
Message-ID: <f5152ce4-8ee7-0e1c-cded-4c2d926d3d00@kernel.org>
Date:   Thu, 10 Aug 2023 10:11:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] scsi: support packing multi-segment in UNMAP command
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
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
 <067b15a6-1db2-719b-918d-286be4966f11@kernel.org>
In-Reply-To: <067b15a6-1db2-719b-918d-286be4966f11@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/8 22:12, Chao Yu wrote:
> On 2023/8/8 22:04, Martin K. Petersen wrote:
>> Been working on this series to address the reported regressions. Spent
>> quite a bit of time on it last week.
> 
> Martin, thanks for the help. :)
> 
> Could you please share the report? Maybe I can join to check it.

Oh, I may misunderstand it, the reported regression wasn't caused by
this patch, right?

Thanks,

> 
> Thanks,
