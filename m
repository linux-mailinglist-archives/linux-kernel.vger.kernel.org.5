Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1144776594D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjG0Q5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjG0Q5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:57:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E73C2696
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:57:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28CE861ED5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 16:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A385C433C8;
        Thu, 27 Jul 2023 16:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690477022;
        bh=7X75SxdjqHoOpZIFkX3F8mKOcguqlT8jkL3KT0x8sMY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VpqQqZZHqplDzclVWRH/repXyX25IBpp2RIXeMIF4TnqRGFayLAvn2HO27M4XzzmC
         EYUxk8wH8MjMIg47jh9qigRPt1tzDLbtJCoNC5b12r/qWPvD/kEE7fbjotIx/WqZI5
         CZq0A+JijzvwnZ99yNq+pRAqRmFgSp52pGPXiYqw=
Date:   Thu, 27 Jul 2023 09:57:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <naoya.horiguchi@nec.com>, <willy@infradead.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] A few fixup patches for mm
Message-Id: <20230727095701.98b4dba128292d0128f44858@linux-foundation.org>
In-Reply-To: <20230727115643.639741-1-linmiaohe@huawei.com>
References: <20230727115643.639741-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 19:56:39 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> This series contains a few fixup patches to fix potential unexpected
> return value, fix wrong swap entry type for hwpoisoned swapcache page
> and so on. More details can be found in the respective changelogs.

I'm thinking that patches 1-3 should be backported into -stable kernels.
Thoughts on this?
