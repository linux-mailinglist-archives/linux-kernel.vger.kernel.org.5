Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA96480E2AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345832AbjLLDR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLLDRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:17:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553BABA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:18:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4DDC433C8;
        Tue, 12 Dec 2023 03:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702351080;
        bh=duVtBYF9/uEhtteq5lUjxhQBMmTnPleG8zmcnq1CCxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WT11GvhoK9rwieQoiDZI3rGVQKEHcQkthKU4+grqOG6ygOej/EE5+ycmUdj+Xp/Wl
         ftDXugi8mrCyiQy6Tq74fJsryOZtDnwLreEd4LV/DF5CC2Yy4vGiBD2TufgJU2YzIv
         g0r1yffPh61kYI99RVUcRG+WvHa4O6DxO5CvkKE53uBuZ+un7QvJWPExEVjeLeTn4b
         NoffrD6Tvt4PRx+Lnt5KN0i9YD/JeF2u9DUKrPGNmxktNm573spvyQjt1fFSsL0+fK
         2ffRHS93QFdBR4+CIPi3ytSeqo7TGMye6/euxAE0a6WuU+88ePUFhxtef+zvswJPdF
         1hQFLkJk8o6Kg==
Date:   Mon, 11 Dec 2023 19:17:59 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/6] net: hns3: add support for
 page_pool_get_stats
Message-ID: <20231211191759.61764363@kernel.org>
In-Reply-To: <20231211020816.69434-2-shaojijie@huawei.com>
References: <20231211020816.69434-1-shaojijie@huawei.com>
        <20231211020816.69434-2-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 10:08:11 +0800 Jijie Shao wrote:
> Add support for page_pool_get_stats, then the hns3 driver
> can get page pool statistics by ethtool.

Sorry, you're late to the party :( We have now added the ability to
read page pool stats via netlink. The support was merged as
a379972973a80924b1d03443e20f113ff76a94c7.

If you use the page pools in your driver in a normal way (each page
pool only used by one NAPI instance and one netdev) you should use
that instead of dumping the stats into ethtool -S.
-- 
pw-bot: cr
