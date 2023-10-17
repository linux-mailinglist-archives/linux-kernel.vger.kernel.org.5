Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D4E7CC732
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbjJQPOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbjJQPOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:14:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BC692
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:14:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998C4C433C7;
        Tue, 17 Oct 2023 15:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697555661;
        bh=07bS9mjKy4+gkFRB2bhOqp3nya+agZd4rUe4PVcLCoc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MGH3tU2bF16vI+HxyH3Oww2Ok3BYK7j15PslIN9/EcokOgotGNQTFS4GUB8AAMUjB
         m0nx9yTVZ7u0dbbYeACVxvOSXgpbCUicqUJXKX+AK+5xhUKELY+PuZPcN1kAHn+AuN
         g6JfFTl98ZXfTaVOUzuTubsSyZFVGS0syv+aPdRu+P3U/PYAozYoNLWs01qOQhUozE
         uX76FszfwhtrOhvv5LQtVbxM0jmYbX6MGUdgtolPCHZSh98mIcQSupl1swWH/rHIKe
         bFXg5nqobDByGUpTwC5Sx6wrIBrdsB0PsBY0Vcpnn+yJWvumOEgYM8wOTTpu8Btz3t
         25pL5AU2xxJJQ==
Date:   Tue, 17 Oct 2023 08:14:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH net-next v11 0/6] introduce page_pool_alloc() related
 API
Message-ID: <20231017081419.5e9d7247@kernel.org>
In-Reply-To: <20231017081303.769e4fbe@kernel.org>
References: <20231013064827.61135-1-linyunsheng@huawei.com>
        <20231016182725.6aa5544f@kernel.org>
        <2059ea42-f5cb-1366-804e-7036fb40cdaa@huawei.com>
        <20231017081303.769e4fbe@kernel.org>
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

On Tue, 17 Oct 2023 08:13:03 -0700 Jakub Kicinski wrote:
> I'd just throw a _va (for virtual address) at the end

To be clear I mean:
  page_pool_alloc_va()
  page_pool_dev_alloc_va()
  page_pool_free_va()
