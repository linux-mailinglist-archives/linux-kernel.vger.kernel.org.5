Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C98785B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbjHWO6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbjHWO6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:58:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3E0E76
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:58:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C674461BFE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321C5C433C7;
        Wed, 23 Aug 2023 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692802694;
        bh=IFDY2WCMwGuW7nIrMMNoTRbgjk0aaNwEZ39jkkpVN30=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qoYVhH+gZQSkCpzLt83I9gdEUoSxw88C88tamhsmayNjDYnvwTJ5x4Z/HL/34nEi6
         hyR94y+S9xmHNBPe2rO1nXgzd+yoOb72P9jXlZiRccDBlGqQVu16iOFhcbmWRilwXk
         4QhdGHJ6lFMJRswVBp5bZMmHhUncYkQA1KeNUyu7AkA0GlFlh4oDyyIXU9knyIoeoO
         ROi8QJT3LOCuaDpcezcm0ZBeEp1atXDNiIwm6XRCG708uClpajGFIK2qLMTfj8SB/4
         Cs7pkiOYr5fRCvwa/zh/EDJOrAjmGMkxKWqnpl9f5dvhYkZjReJzd6QLB+Hky8rHTG
         tU8G887hazdag==
Message-ID: <38c0fb97-40a4-9c46-4b57-9f0f13928b0c@kernel.org>
Date:   Wed, 23 Aug 2023 22:58:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/8] erofs: avoid obsolete {collector,collection} terms
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
 <20230817082813.81180-2-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230817082813.81180-2-hsiangkao@linux.alibaba.com>
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
> {collector,collection} were once reserved in order to indicate different
> runtime logical extent instance of multi-reference pclusters.
> 
> However, de-duplicated decompression has been landed in a more flexable
> way, thus `struct z_erofs_collection` was formally removed in commit
> 87ca34a7065d ("erofs: get rid of `struct z_erofs_collection'").
> 
> Let's handle the remaining leftovers, for example:
>      `z_erofs_collector_begin` => `z_erofs_pcluster_begin`
>      `z_erofs_collector_end` => `z_erofs_pcluster_end`
> 
> as well as some comments.  No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
