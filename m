Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75D07BC446
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343490AbjJGCxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjJGCxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:53:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1FBBD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 19:53:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869E4C433C8;
        Sat,  7 Oct 2023 02:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696647187;
        bh=givokbT2OdwtFmBNzjJjWzXCgdXE/WSNCW7e+2KIMQU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rvo704i/b/RrDeKrLlLDA+scaLJqCAubGm+KPKDWfEbOFEhxuNtKNlXag/R0uS/0q
         Neaw8cU571O9XUJAuDgtObxKPDT7DEBETSYQifFRnDu9O1UEBRzTaa2IYOXmEiwnjx
         qEZfm4m0YwgcKtOSvKvR5Ix/GuHhiIq4zhhvcPtXzeAVIhVN/mTrlFpNyX726/dEho
         PVLg+fSAxssew9kaQL8LM2yMY+a1BxNq3lKa+ClTro4XzpJzbWahV2cM/EishRP5Zn
         EoRl8uzmHFpKz8RtNIukVyeWQg2ySvVUHww4PJ27FJtXpG63dLX5Bev2T+ksbp7bFg
         bfGNSO5JtGE9A==
Message-ID: <b20de8c6-5b29-10cb-257e-fc0ec7698cc5@kernel.org>
Date:   Sat, 7 Oct 2023 10:53:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: do not support user-space cache
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20230928175113.3840888-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230928175113.3840888-1-daeho43@gmail.com>
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

On 2023/9/29 1:51, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We don't have lots of benefits from this, since block devices already
> have page caches in the kernel. Moreover, this feature has some
> stability issues corrupting metadata. So, we better make this deprecated.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
