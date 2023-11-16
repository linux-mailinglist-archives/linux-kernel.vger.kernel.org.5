Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5B27EE487
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345203AbjKPPnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjKPPnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:43:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39A798
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:43:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6437DC433C8;
        Thu, 16 Nov 2023 15:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700149399;
        bh=6PvNxag/PtrEd6ZbP3D3MlKB6dZg474tgXDyiaR7m0o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hU6BdJg38E6/94aqQOlgURgF1ZdxXZ9nHFv7ozWjKi+NnHAhYyg2RVIRE1X4xKNWa
         hwwtDLUDb1Pb6UqSKkqjJP7+dhhoTdag1I5u069++1Cwpzf/iLwK4jEwiQNSF0s3tU
         6nscPU3gyeuZhg0IHdDJ7hwokCCh6/uJ+TZo1clQhD/99gcgn3ngvw/r7GSgGuRFo4
         D8NFfOpcBebRyzQDwNadwZ/DvNd1LZxC5vqJ2JsWhW4jBCOSFw02Eqft5MNKsko32x
         /u95RvNR+nsvHeDQh9ZOFE6zauov99hON4/CaZmSgdOFg5JCCPZpx0/GZFudBeONBQ
         pHxoQUUuM3M8A==
Message-ID: <03d5e283-3998-7db3-30ae-8a64685c17d1@kernel.org>
Date:   Thu, 16 Nov 2023 23:43:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] erofs: simplify erofs_read_inode()
Content-Language: en-US
To:     Ferry Meng <mengferry@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20231109111822.17944-1-mengferry@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231109111822.17944-1-mengferry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/9 19:18, Ferry Meng wrote:
> After commit 1c7f49a76773 ("erofs: tidy up EROFS on-disk naming"),
> there is a unique `union erofs_inode_i_u` so that we could parse
> the union directly.
> 
> Besides, it also replaces `inode->i_sb` with `sb` for simplicity.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
