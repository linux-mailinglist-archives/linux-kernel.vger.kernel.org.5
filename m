Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5757F398A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbjKUWw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbjKUWwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:52:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF0319E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:52:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA010C433C7;
        Tue, 21 Nov 2023 22:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700607162;
        bh=lcd1kaNfal9twfdUVMZrLx4fsueilicX3t4phDi7yXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GDBbps2gtwzo6uL2nHWSrvpUo/BPqGgOMVM9oxt5jgW+G2Qcd+pQKefBFTQvW+veP
         kC2oD5UgdrFjr4mm17/LNIuliKGnsUTLjnTjz1lA/x77iKCd1e1HwcHf6iPo/T1kdA
         5YxfP6jjau6jvJV5ZA/112PrdEznjBA9U+HLsWAjzBf4KN9QT6gmjLK2fZD5egQnOh
         XRnLinwvWwtRAmuhDHYk/S9ZVAINmmGD/+6g8XSsS6mjAlbfJd4EfSJRzkjJsGY563
         nelLqBx4EDHvEl4OqH0joxKK0f2/KTwI0sZhfGLJA2LzKwHKr5cK3IWk+oNKRU6sMh
         JtfOwxZr3R/KQ==
Date:   Tue, 21 Nov 2023 14:52:42 -0800
From:   Saeed Mahameed <saeed@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Saeed Mahameed <saeedm@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH V3 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
Message-ID: <ZV00ushZBMpkUb02@x130>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-6-saeed@kernel.org>
 <20231121124456.7a6388c6@kernel.org>
 <ZV0bRpnhu/zWieTT@x130>
 <20231121141053.6133e069@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231121141053.6133e069@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Nov 14:10, Jakub Kicinski wrote:
>On Tue, 21 Nov 2023 13:04:06 -0800 Saeed Mahameed wrote:
>> On 21 Nov 12:44, Jakub Kicinski wrote:
>>> On Mon, 20 Nov 2023 23:06:19 -0800 Saeed Mahameed wrote:
>>>> high frequency diagnostic counters
>>>
>>> So is it a debug driver or not a debug driver?
>>
>> High frequency _diagnostic_ counters are a very useful tool for
>> debugging a high performance chip. So yes this is for diagnostics/debug.
>
>You keep saying debugging but if it's expected to run on all servers in
>the fleet _monitoring_ performance, then it's a very different thing.
>To me it certainly moves this driver from "debug thing loaded when
>things fail" to the "always loaded in production" category.

Exactly, only when things fails or the user want to debug something.
  
For your example, you can monitor network performance via standard netdev
tools, once you start experiencing hiccups, you can use this driver and
the corresponding tools to quickly grab HW debug information, useful to
further root cause and analyze the network hiccups. 

Again this is only one use-case, the driver is intended to provide any
debug information, not only diagnostic counters or monitoring tools.
The goal of this driver is not the one use case you have in mind.

