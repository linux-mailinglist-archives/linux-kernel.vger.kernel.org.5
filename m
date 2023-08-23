Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A8D785B00
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbjHWOqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbjHWOqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:46:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99852E69
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:46:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BCCA611D0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5137BC433C8;
        Wed, 23 Aug 2023 14:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692801961;
        bh=bBXsUp0X1R7nK3RLb32WT1JFGUjXY8/gRLSJsyg+0xw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uM30tP6cvNodqN4Xb678hssReK+ew5y/CQFjIFqVB+A+RnAliFjohQGSJfQdYgaeW
         dumqpLoziUs7mBspR9t6smRTZk7WDq1AqKHs2IjOVnV41rOH8BY3vvsfz7ES5QUvWE
         2++wZbRUr7haRXT3gtQhlDAxdbsiS5kre1XqFjzYSpjq5iqkBg7o1tTlz/gGuWT15E
         herRVFYTYw8hFDOKdd5qa+DIARxvvNJSSjHWI4Tpvp/l6SMHdWs2CHZqy9P5HDYzn1
         y7EmJYQLf5XclEOm9Tns1C/ZXcNNDFXqHTb1jICzAY3S/6h247A4pJE0JAXDNCIFyx
         fIL7RSv8E/rbw==
Message-ID: <d3d35593-3359-3a96-c0b9-531455b288ef@kernel.org>
Date:   Wed, 23 Aug 2023 22:45:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] erofs: add necessary kmem_cache_create flags for
 erofs inode cache
Content-Language: en-US
To:     Ferry Meng <mengferry@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230815094849.53249-1-mengferry@linux.alibaba.com>
 <20230815094849.53249-2-mengferry@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230815094849.53249-2-mengferry@linux.alibaba.com>
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

On 2023/8/15 17:48, Ferry Meng wrote:
> To improve memory access efficiency and enable statistics functionality,
> add SLAB_MEM_SPREAD and SLAB_ACCOUNT flag during erofs_icachep's allocation
> time.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
