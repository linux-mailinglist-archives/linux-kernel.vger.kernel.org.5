Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938F3785B85
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbjHWPJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbjHWPJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:09:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D74DF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:09:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D90626641D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E490C433C7;
        Wed, 23 Aug 2023 15:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692803391;
        bh=m1uIUhk62EHgp639wb/FV7dBY6F3CJVxaBbL2F61sAw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qP7o5Wr87TC99xt5egwHtUTYmQPcjA/620EPbtCyIs0KVEWP898+Ps5dTvnxEAMus
         TceQVanFE/zlAYlhhdV1rEmqbwCT8iWpvTmlwc9fEhWOVLJq0oGsQww+nNxA7z32c8
         NSpyEE3aoPgtf4rY2tHcHAXrtGI8p3mwrN+VB+ekXCd/2hCmZlwoHg6aAz1k6/BJae
         MWWmExgLlXWF23AAerVhEmcfHuhYIdFwcYcVII9VtctjJmO1nmCLwfQXk6MnHOHLut
         TfG0yJr5KN9aPDHIfHDD2LSP5DLiFAsuf6yfoj52dZyWpTFzrPbzb3oiiN1XqGA5pG
         ENvb/xiGJfjSA==
Message-ID: <8b2d901f-543d-fe20-7764-b90d569781e0@kernel.org>
Date:   Wed, 23 Aug 2023 23:09:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/8] erofs: tidy up z_erofs_do_read_page()
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
 <20230817082813.81180-4-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230817082813.81180-4-hsiangkao@linux.alibaba.com>
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
>   - Fix a typo: spiltted => split;
> 
>   - Move !EROFS_MAP_MAPPED and EROFS_MAP_FRAGMENT upwards;
> 
>   - Increase `split` in advance to avoid unnecessary repeat.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
