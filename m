Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3B37BC512
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 08:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343595AbjJGGiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 02:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343561AbjJGGiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 02:38:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FD0DB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 23:37:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B88BC433C8;
        Sat,  7 Oct 2023 06:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696660678;
        bh=haeoZMfXVfuibJKXHZqwDbIGTXzIAr3k6IkAQRF6pGU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LYKw1oSSSpwkcD4fhCwHni6Ndss572NgxpTqVxC5jgsE7TlYs5RlDFU+9avG9S2cA
         noeCbcswqAJHHYBGO3AUMG6Vg3UPpv/ijWYL2J27VBFkbzJ5bDLlppgNxPt6b8GiBi
         ubhgW9omtxuu5SqZuooU1fBG2xlRQTrWxP5Pgtqh8TtwJu6gmCD4gBhvHclhGPva5o
         +CA8Q8KNQOt0ITHZbDpzDj7mGVmwIClECbKA9imkjRa9oonpRG0os2x9XW2PKVmVhU
         lW9JRXFD8rGPNDToPtMb0VOavsgimBSlNUgTT62qczTGD3XTVMAhamwgqHxpw7YyuB
         lJrstfDNVDK7Q==
Message-ID: <fa622c39-c02e-b143-0c40-99f85c9a8063@kernel.org>
Date:   Sat, 7 Oct 2023 14:37:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: make checked node progress correct
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20231003210754.275175-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231003210754.275175-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/4 5:07, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Let's say we have 100 nodes to be checked. With post-increment of
> checked_node_cnt, when we reach the last node, we cannot print out 100%
> progress. So, go with pre-increment.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
