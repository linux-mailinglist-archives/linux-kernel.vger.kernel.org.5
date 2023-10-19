Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367407CFBC7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345869AbjJSN4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345848AbjJSN4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:56:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42B4131
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:56:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BBDC433CA;
        Thu, 19 Oct 2023 13:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697723768;
        bh=yZ/ARB3p2Ke8tobvsFJ9flTddNYrmRG++q6KJRo0w3Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tc74ML9w33RHuzPXDk4Y/0aY9YgCu4WG2S+FQ6bNMA5UdG3O8Mb3PgIAQ7Tc+a3Q/
         0ZL5nTecGbR8+xaaPo4O/FiCJVYmgI27BJ2lgquzmTQQR8JgyS6Ymj2IdCbyK9IBPa
         81/sPnuoj7QsXhkHW822S2PbJMLzH+gRvjtTwQVioEcS8HoIf3/WRbPUSwffmZoMJK
         LOonxjQLVsqd2n+87kEzJst2h5dF/St27OteDkkSqAhF0cccL+nCBW9uWW9aVyLH/f
         tP04RxZbcGQo0ecHgE6XeIWOsl0kPN+3eczB7zs8or/sOJU2U098PDuONOzIaHv81/
         v9ZzTgUYDBw9Q==
Date:   Thu, 19 Oct 2023 06:56:06 -0700
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
Message-ID: <20231019065606.525309a6@kernel.org>
In-Reply-To: <fd8a3e6d-579f-666d-7674-67732e250978@huawei.com>
References: <20231013064827.61135-1-linyunsheng@huawei.com>
        <20231016182725.6aa5544f@kernel.org>
        <2059ea42-f5cb-1366-804e-7036fb40cdaa@huawei.com>
        <20231017081303.769e4fbe@kernel.org>
        <67f2af29-59b8-a9e2-1c31-c9a625e4c4b3@huawei.com>
        <20231018083516.60f64c1a@kernel.org>
        <fd8a3e6d-579f-666d-7674-67732e250978@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 21:22:07 +0800 Yunsheng Lin wrote:
> > Sounds good. Warning wrapped in #if CONFIG_DEBUG_NET perhaps?  
> 
> How about something like __get_free_pages() does with gfp flags?
> https://elixir.free-electrons.com/linux/v6.4-rc6/source/mm/page_alloc.c#L4818

Fine by me!
