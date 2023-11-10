Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF7A7E8691
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjKJXR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjKJXRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:17:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5142699
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:17:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E505C433C8;
        Fri, 10 Nov 2023 23:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699658240;
        bh=FcD/HWbd4EsU6HwpXVqt2njpk4bjOQ41rYghofjuGtU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R181imvsgeKraRpbX9LkEIoxIiXfD6RhL6ZMTrJ5qPQ4EWf2gQhl/rnePu/vqnEmq
         rF+PDNN0NgZelMtS+uZyDu3jn8OSEtb9Ob03BXtf7JZO9682gNg+jtzHkdXfTpt/Sh
         qPTLdIvKuBRcahsXUkYUepEY1uC36Y6RYoTBR3YzcsPgJNjjrCpyqAfEyqeLwUoJ//
         7coMFzfantRo2Zk4eHk5iun30IzxMou3p8lYb0H0R0SRsUIo+RyaysSGcRXCP4i517
         cpABJ1jfppUbUcxAFgOhCJKHTHlelNaMdEuDf3mqDkMfYtUKuGF+bQdRcTiljdUJBF
         4j7erT8zDOuKw==
Date:   Fri, 10 Nov 2023 15:17:18 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Christian =?UTF-8?B?S8O2bmln?=" <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [RFC PATCH v3 12/12] selftests: add ncdevmem, netcat for devmem
 TCP
Message-ID: <20231110151718.3460e59e@kernel.org>
In-Reply-To: <20231106024413.2801438-13-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
        <20231106024413.2801438-13-almasrymina@google.com>
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

On Sun,  5 Nov 2023 18:44:11 -0800 Mina Almasry wrote:
> +	if (ynl_subscribe(*ys, "mgmt"))
> +		goto err_close;

Why? :)
