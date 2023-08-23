Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FC9785B02
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbjHWOq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbjHWOqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:46:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8CDE6D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:46:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5275D611D0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD94C433C8;
        Wed, 23 Aug 2023 14:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692801982;
        bh=y9nMdjkiUGfR7L0YnkBfUfdbrk+TevW/ibXcHHXrrRE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ccJoZZaxN+nHZRJdo3o7Wh9es+CIwVmKEQZVDVdFuefleucWEZZzKcjYqEnov8Sie
         BGbHRePqPtxHRR2kwrTbmaKOea4JdPUSLeIaJoDQUgVolDJFlnLb6sVr9dxXBfhUFv
         wEZJc9phZhGTBnWX1qE2YlFIxCHUhpreVFQfCHkUvJ+JNZvhQ+rp83oVRzLaXRrJsU
         P4iL0mymdBnwdDsNTR1CxP1jhA8nrn2VocE7IYw+fYvMTG6tBGZ+BYgVRSvJXxj+e+
         iFoGGpm5ppcyiOV0uRiSmytdpL2xuTf3CJEreFQ7hU7EgkzLEB8RJRJvYBCw5p9Vzw
         uXbkt0pL+ebjg==
Message-ID: <b00ad8a5-c6ab-06af-5678-13ff915aed9c@kernel.org>
Date:   Wed, 23 Aug 2023 22:46:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] erofs: remove redundant erofs_fs_type declaration in
 super.c
Content-Language: en-US
To:     Ferry Meng <mengferry@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230815094849.53249-1-mengferry@linux.alibaba.com>
 <20230815094849.53249-3-mengferry@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230815094849.53249-3-mengferry@linux.alibaba.com>
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
> As erofs_fs_type has been declared in internal.h, there is no use to
> declare repeatedly in super.c.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
