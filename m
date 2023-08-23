Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EB5785B39
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbjHWO4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbjHWO4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:56:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40545E77
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:56:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB87E61DC1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1CEC433CA;
        Wed, 23 Aug 2023 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692802600;
        bh=6S+2S2otZqoFjmZl2ckQ6GZtxYGNl9rwq86awBfdKco=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jfSWOBIVGGcZc3GoOkreZDc5Lr1MOIz8Ci4Mn1anb7kBR41lP/xFXq8qjROBoex0U
         +BE3upw+vU4GlgQVYG3W0muBub0hW/uNhYxF2IsKTfRZJeJ6exZvjN76Dgq6RF7dou
         8zcRIsXc9yASEmlqkab8qWxvaoWn3uu2b7F5ItX9NROTKO1n8EdqkUmQYwyU/RUOZv
         dBkt4lqvL1C9kZrOgs/4K1GBYtDQgC5x3Mj//hfchG2Ie5E31TUQUhetLUUR5edFph
         NWJR6oGV+8kQir3gUpwAsh1kVbFhtvYPzyDgn5t8zIOjm6cGHljgeyhOajH2Fu2IkL
         POGm6kHb99CuQ==
Message-ID: <df3df9e2-73c7-4e9b-afbd-85078f24d235@kernel.org>
Date:   Wed, 23 Aug 2023 22:56:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/8] erofs: simplify z_erofs_read_fragment()
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
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
> A trivial cleanup to make the fragment handling logic more clear.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
