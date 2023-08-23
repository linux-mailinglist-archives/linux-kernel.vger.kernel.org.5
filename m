Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD7C785BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbjHWPVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbjHWPVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:21:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A88101
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:21:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C54B865BE7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B698C433C9;
        Wed, 23 Aug 2023 15:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692803991;
        bh=uBDCkLnKfifcqL2Bn9zaiIl1ike83ejaqgx7O/VU6sk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MIF4DIvCZ2PUVz6JOKztBA3cNJ3uI8b9s3MnjQuFNMJjvUSVkJrk39vOTkzmOw5H3
         SIJD9w1KF9XJtW9eI3KJOHGBkgJxVMvBMQhxU77XfN04uIjcbpWH69UMCdZ4sXsFGL
         B8HDXu5I0iXGf7c1h0VbWjosL9MXXwuaeQDpU9bcWik+va9kCJiBQr/aZqNosOFVxF
         Hh0Xrg5+HZpwQPRFPKhn9JWR9weL5bJ1mjCrJ6nEDta/TdfDvv2P55k9mcmoeOcizY
         DOhMkWBxIY0AUL88qwa16JBTBoPTfOKXVMDM+I0nBh2MJVUsvoJzaj5iyxokCDhrCr
         w9J/W0IDqeNmg==
Message-ID: <cac0a547-7a90-aad4-8911-63f38883c966@kernel.org>
Date:   Wed, 23 Aug 2023 23:19:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/8] erofs: get rid of fe->backmost for cache
 decompression
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
 <20230817082813.81180-6-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230817082813.81180-6-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/17 16:28, Gao Xiang wrote:
> EROFS_MAP_FULL_MAPPED is more accurate to decide if caching the last
> incomplete pcluster for later read or not.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
