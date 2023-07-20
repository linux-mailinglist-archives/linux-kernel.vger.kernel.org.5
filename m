Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B26B75B98A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 23:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjGTV3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 17:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGTV3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:29:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38C22712
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:29:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 466FB61BEF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 21:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D126C433C7;
        Thu, 20 Jul 2023 21:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689888543;
        bh=V5ySm114BTdbJAXRtme733hKEAZjL4JHuguIpZ1JfjI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IhSAZIQ20wX1TUDDAs36U/tQhHh7GAy3IUEsM+MVdJAkyzj0b2WgGusWbeRW47qR2
         t072ZCIbqzE0FnG36VYBeiv8JQtANeFREsgYJXwrm7V8NNM3v9nt6vR3juGhp3M/FD
         R6B2wlJg9VCZgNyc9HWCG8BQoeCBkjqUlDlwwJX+1bdYaKMSzNTKxlq979Da7RvMSP
         PwL3r/7rzyFBkLRr9z7T3j+PTglpvBoBec1veo803plDNWSv0gPuvIw7sjAYkOT+S1
         /epiBNFxNKcq9MiP7jSWFpmwtOwNyBPgyJxZCjWDgNRE+KUiyppUE+nj0ep1/8X8+T
         fzUjLbyQlojwg==
Message-ID: <51dce096-1e45-c78e-e0b3-fcffa2cea4ec@kernel.org>
Date:   Thu, 20 Jul 2023 16:29:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: socfpga: Explicitly include correct DT includes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230717225440.3211576-1-robh@kernel.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230717225440.3211576-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/23 17:54, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it was merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 

Applied!

Thanks,
Dinh
