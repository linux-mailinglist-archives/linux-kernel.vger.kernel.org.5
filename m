Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30F275DAD8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 09:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjGVHrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 03:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjGVHri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 03:47:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A5E3C0A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 00:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F301660C08
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 07:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6765CC433C7;
        Sat, 22 Jul 2023 07:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690012022;
        bh=cRWTHRZaqaPfdxrqhA4g57bPZB4lpgvXeXn+zZsP3lI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e1YWZfJyXRJb8wo6lED71EU2da5lJfws/jfuFW2IAK9pcwZiZWeS3iig5+A/mPrct
         WTHNTjk8T80bQEwy8zbnHuQtIlTOQmSOhSjxD8WDPh4YqyWsdD/KEpRRXweXB2nU3f
         LWElw1oThT9VT3jS360gyuC4nzSErJqDrtuufcUmpjW8kroiom8giYADvKm19l6uWK
         MlnyE+2cb2c3caxp9HKzHh4bKee7omkdMO+W+Uz3NJ8WbPMYsBYFv7Auuc0B51Zm2J
         D8laAlOjTzrFY/kzUKgarCN5ucsw3Y6utsol99gUj/hlf+H2lcKWsLbLnKQv3VTprL
         FgtNQDeiDRMBw==
Date:   Sat, 22 Jul 2023 15:46:56 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] erofs: boost negative xattr lookup with bloom
 filter
Message-ID: <ZLuJcKH3ymLEVQec@debian>
Mail-Followup-To: Jingbo Xu <jefflexu@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230721104923.20236-1-jefflexu@linux.alibaba.com>
 <20230721104923.20236-3-jefflexu@linux.alibaba.com>
 <ZLt/oJWa4MoE4F25@debian>
 <bf48239c-6850-d33d-e7f6-1a4a15400ae9@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf48239c-6850-d33d-e7f6-1a4a15400ae9@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 03:33:11PM +0800, Jingbo Xu wrote:

...

> >> +	uint32_t hashbit;
> > 
> > Why using `uint32_t` here rather than `unsigned int`? We don't use
> > `uint32_t` in the kernel codebase.
> > 
> 
> xxh32() returns uint32_t.

we never use (u)intxx_t in the native kernel code.

Thanks,
Gao Xiang
