Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581AD7EC655
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344040AbjKOOwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjKOOwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:52:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAE88E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:52:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A45C433C8;
        Wed, 15 Nov 2023 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700059953;
        bh=7qrZK4ggcFRaOA/zhECZHHj8eddVbuixMF/Jksd0y/U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AgklWTk0BSaawUGJ+5SzMBVsrTYyhwM6e1+ts9tWmQvCLvEXSh2HFsPjE5dYX8i0r
         Q6KlXuzUI8kfx5pdPb+re0KxV9PXODsFlCksI9RbLQ5ZEb6MlbG3NTEzbeJWJvxbIB
         /s5zG0p9xOsPQ/mD5XWHzFrZaid6xV03Nk9/HX7O4HfcE2pu34dRALX2AHxH2Efiw2
         wMYHA6AzqtwyCL0Mbbl/tYvf3LnwRmyjPfm8+SXQVN0vCcXtHVOi1MSRGGJZaPBhgn
         YDmEM501u9WOF5HeqyDVn68PC6ALxTcUVm0MGJmxDpWTNsuf8fUVoWEXhpVG00uaS4
         ArKrLODnXZIjA==
Message-ID: <4dfab9ac-8d62-3a7e-04f1-219d496f97fe@kernel.org>
Date:   Wed, 15 Nov 2023 22:52:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: use total_node_count when creating
 a new node block in fsck
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20231027153043.1381438-1-daeho43@gmail.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231027153043.1381438-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/27 23:30, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We might allocate more node blocks than total_valid_node_count, when we
> recreate quota files.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
