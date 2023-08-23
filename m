Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73E7785BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbjHWPYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjHWPYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:24:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078C9E7A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:24:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CF166603D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F65CC433C8;
        Wed, 23 Aug 2023 15:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692804239;
        bh=FapS3wxTKtk8VB1dsiMNlDFRQOB2IyU6ewfeF6w6B6I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Co+v6/M5I0B5OXkKM0hSprvDe17NV12AU2CkdZh9/BvVJpKAdAd5asMiXD17eTOvl
         MuZaGouttmNmW8WUwDYyZTowToULjDgftiAqqi6503rKdYyof4n72b233R7FEXR34u
         KyAMQCNxgscRGRvwvp0Hu2Kzj67z34wl4Jol4F8IpTw8ENipdmE7BBiJsLX5MoZ5f0
         oOk/dLB00KEU/X6V3QMFN88/U8iNsQrAJW6aTiZ5rbIqxCJ/5lTFvP+KSqTAooLcMG
         65id5zj9UufcS3GeI1D/E4Bq2syVWr+mO8DUUfKKsu9jo5yqoD86dMRe9EYo2Qy6K3
         uXjxPePQc3T8w==
Message-ID: <b8c8efb7-2d67-19a3-864d-e59f64ab55ed@kernel.org>
Date:   Wed, 23 Aug 2023 23:23:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 8/8] erofs: adapt folios for z_erofs_read_folio()
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
 <20230817082813.81180-8-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230817082813.81180-8-hsiangkao@linux.alibaba.com>
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
> It's a straight-forward conversion and no logic changes (except that
> it renames the corresponding tracepoint.)
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
