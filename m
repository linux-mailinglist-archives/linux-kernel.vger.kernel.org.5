Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B36768563
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 15:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjG3NEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 09:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjG3NEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:04:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CD6C7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 06:04:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7ACF60B96
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 13:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9CBC433C8;
        Sun, 30 Jul 2023 13:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690722283;
        bh=LbTRsMIn2pfq69jUpFsw8eMAQoJ9qEQbZDQQkb/RwlY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IrIK0NzXbn3PEbZ04Zdv2z/rXX/H//DWmr1onoJVB8EvqzRyEUv1sRISRe31mhy0J
         cnaHdB8BD/gh15pogDZ/10W0mErx1Ji9YHv/tp7QsFswspDooYYZ5wD5czNcX/b3Mk
         HScG6o3jD4DjOq8PQejoDyNYw9tlmLbMjkLD1cr88NXy49CxmLBo85a0GHr4cWpxk3
         kbEUOdzCD85LeeLG64DmoasJ5+KirImUyLez1ibyZGRcwtcX6Um34z02HLNfyXZeI3
         M8zgxagwSVXrkZuy/vl5Se36OHRZrKNrSPcmiedLs53KWqeER3oe3AYMGbCBsQcVaA
         h/SQS9+/WKePg==
Message-ID: <ed18eaf6-e5c9-2de8-d6b3-a5f121e4c61e@kernel.org>
Date:   Sun, 30 Jul 2023 21:04:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] erofs: deprecate superblock checksum feature
Content-Language: en-US
To:     Jingbo Xu <jefflexu@linux.alibaba.com>,
        hsiangkao@linux.alibaba.com, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230717112703.60130-1-jefflexu@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230717112703.60130-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/17 19:27, Jingbo Xu wrote:
> Later we're going to try the self-contained image verification.
> The current superblock checksum feature has quite limited
> functionality, instead, merkle trees can provide better protection
> for image integrity.
> 
> xxhash is also used in the following xattr name filter feature.  It is
> redundant for one filesystem to rely on two hashing algorithms at the
> same time.
> 
> Since the superblock checksum is a compatible feature, just deprecate
> it now.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
