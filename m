Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F211783BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjHVIj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbjHVIjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:39:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0F8CC6;
        Tue, 22 Aug 2023 01:38:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 195DE64957;
        Tue, 22 Aug 2023 08:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A002C433C8;
        Tue, 22 Aug 2023 08:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692693528;
        bh=sn4m7YkDMQaL1Fzx+5HXs0EihyifG6TZ8aE0/npZBEo=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=AiIrfUoNHVzmhSemHTGLjs0etiu1VgpU1rxUiSlehmWv5SD1/NWDecpUgsE+cLEiW
         H5rxibNAiHh6Z54EGLjj3cJNY2fnKtuhU0tKTzepxZm5XM2Z2q3Q7c8n3UvKedrnZ5
         ngsKzLs4XACDeaVvecbuMSWjLISJyZKA8Q8X9PGvIIZsIxAJBiv56mJp4tBmjEvPCc
         pz1LanYUwDOmk7iTD4y1VHDYLRDasYvxSu1ztXDJGdZj29CHpUl4YczbQvkr0GHlUG
         CyolG3Q1LE095Mm9QuOJWOzX7lsBkPQRwUGb9lKhbk8uJf3EB2rnMKsSlNBA0nfw2g
         Wcr9bSez0efqA==
Message-ID: <1c351e69-a187-e37a-3075-e5a4ecdc6ddd@kernel.org>
Date:   Tue, 22 Aug 2023 16:38:44 +0800
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
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

It looks we will miss another merge window again... :(

Not sure I understand it correctly...
If this patch caused regression, could you please share the report w/ me?

Thanks,

> 
> Thanks,
