Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58067812463
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 02:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbjLNBRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 20:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbjLNBRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 20:17:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA435E8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:17:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435CAC433C7;
        Thu, 14 Dec 2023 01:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702516677;
        bh=zsaG1Z/V6aX7d8f9bjRUYAcyyvlRqu+OVBtKr82ilo8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ASB0owDzSZAjwNqEaZNw5l/tG4f5H9NX+k9wIaQk8aZXmjNXWFA3xs3z4915D3ydm
         7Ny7vU+2Z7vaKSVVG1qq8axAQ/MCShUSGffVW9XOEwhE7c/wF53+YRFmoEGCRaSXJV
         xxx5jmq9TTDBawDFV+xQEVsShfQCo7hbn0fdbEXDcJggTLF+nKeQ0DUI/UxbZMIsOO
         5BjG5ifdnXPja4ZIyPRc+ST7CoXQVV+Yuqp2Ss/x8LSXqj0MPfatQDbKpgwNw8T3UN
         XTW5ymxEA+Otu6nrG7yjCGi17kV/e48xzniquq3SrjsO19LqX8qx2v133Y2t3Q722V
         y4VWpmNMV+zfA==
Date:   Wed, 13 Dec 2023 17:17:55 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Christian =?UTF-8?B?S8O2bmln?=" <christian.koenig@amd.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Harshitha Ramamurthy <hramamurthy@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [net-next v1 05/16] net: netdev netlink api to bind dma-buf to
 a net device
Message-ID: <20231213171755.5965e1ec@kernel.org>
In-Reply-To: <20231208005250.2910004-6-almasrymina@google.com>
References: <20231208005250.2910004-1-almasrymina@google.com>
        <20231208005250.2910004-6-almasrymina@google.com>
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

On Thu,  7 Dec 2023 16:52:36 -0800 Mina Almasry wrote:
> +        name: type
> +        doc: rx or tx queue
> +        type: u8
> +        enum: queue-type

nit: the queue/napi GET was applied to net-next, would be good to stick
to the same types (s/u8/u32)
