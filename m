Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7C97DBC42
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjJ3PCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjJ3PB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:01:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A47F7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:01:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E26EC433C9;
        Mon, 30 Oct 2023 15:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698678117;
        bh=92Q/lSc3g35CgKz+O/OyvcRiuLvIU5Y/apcn+mfhqQ8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JNCp0Re0ZeD+k26H6TgV+j6Unr0JuNIY/D8vYxtywvmP3VjCn1E/eThekiACYZpds
         cq4uECfOjMasN3tWzQoB5IhRVEuBUipCtvDC6gdV9UsJ9O3o74jhkSGJPR8z14ofVu
         qSixbTSNk522ZNUAeAQ4STqohuoTHD6f91vwjYezR0a3C0BIMP5voesimcoTyzc6Yb
         CFcw01IOu8bz8IPrq+RsJepOm/VIRVyetYQC1Q0Hcoma/sLa/bMauvvLSByGYUK4HI
         JfKfOTwhUxaSwkzhvsywLdpxCeJ4h3DbCjp92CMrAil3rAZ0BHE7uAqiqksHQxvPzB
         RjE9ey3gWLd1w==
Message-ID: <73c052d2-2283-3bf9-2717-cc199cbd8c0f@kernel.org>
Date:   Mon, 30 Oct 2023 23:01:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] erofs: simplify compression configuration parser
Content-Language: en-US
To:     Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231021020109.1646299-1-hsiangkao@linux.alibaba.com>
 <20231022130957.11398-1-xiang@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231022130957.11398-1-xiang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/22 21:09, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Move erofs_load_compr_cfgs() into decompressor.c as well as introduce
> a callback instead of a hard-coded switch for each algorithm for
> simplicity.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
