Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF99C77BD7A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjHNPxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjHNPxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:53:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680C8E9;
        Mon, 14 Aug 2023 08:53:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0D2862123;
        Mon, 14 Aug 2023 15:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1742C433C8;
        Mon, 14 Aug 2023 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692028400;
        bh=VYn89773/Fan3jTs9Lj+W9soq0OKz68en037iNXyJcI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G8+fGV9msZ6gV+netW5s77h+LqsYFQEk2OgkyIUTXENvsBz+e8KWcYAu81iLHbyb1
         X0T7bIRS51XBtfLwJJqOiO9yuHC7jubMafxk+Z7K7Xc5EXRhM4W0hLBJK0cp5/dmBg
         teaibNl1QNdC0Yi+Zbwov9A7CdgcBHgpGkCn5zrGadp0RohumKn9qUG1OWSyA4lS84
         gaJHRsS4r7W3Donl8USTDrsaEvTtecp/ZykFR/cgY114B36+7b+ps+7VJTTEZnV2Lh
         DZhyCgmxFyklVfKxRdPUaSjaV9N/ZFQCtyZO15vecZkOuNjrTl6nOhzZE1Dk89kXxu
         /rPWuQBb0XuFA==
Date:   Mon, 14 Aug 2023 08:53:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Lin Ma" <linma@zju.edu.cn>
Cc:     corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, rdunlap@infradead.org, void@manifault.com,
        jani.nikula@intel.com, horms@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3] docs: net: add netlink attrs best practices
Message-ID: <20230814085318.090c832d@kernel.org>
In-Reply-To: <54e9d6f6.106b1a.189e798f8ae.Coremail.linma@zju.edu.cn>
References: <20230811031549.2011622-1-linma@zju.edu.cn>
        <20230811152634.271608c5@kernel.org>
        <54e9d6f6.106b1a.189e798f8ae.Coremail.linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2023 10:35:09 +0800 (GMT+08:00) Lin Ma wrote:
> Moving forward, I suggest we consider the following options:
> 
> 1. Update the document to address the confusion and make it more relevant
>    to the current state of Netlink development. Maybe the newly added
>    section seems not enough for that. I would greatly appreciate any
>    specific guidance.

Unless we have docs for kernel side of modern genetlink any sort of
indication that this doc is only a guide for looking at old code will
fall on deaf ears.

So you'd need to write a sample family and docs for modern stuff.

> 2. If the document is deemed too outdated for being kernel documentation,
>    maybe I should publish it somewhere else. Do you have any
>    recommendations on where it could be better suited?

GitHub comes to mind for publishing ReST docs, in the meantime?
