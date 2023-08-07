Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C59773023
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjHGUJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjHGUJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:09:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F1C10C0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B797621D5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FF4C433C8;
        Mon,  7 Aug 2023 20:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691438988;
        bh=qYWsNM5r7KU6Cd8OsjqQh7cSxa56PwYXzSXeTpvD484=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lBIGk9Sgqtp2SLMYrLtIXYquMrq7NoVnRLTmtW60SpEdGz1Lq8fqFDjTmmMOJA3pd
         imgPShmiiwFa9g6FfQQFTgaa4L6u0Dun9rXEpXuxrJVYpZeFXYF2TzZC1S1uyqMIfk
         tx5N6SP7gQ2iR7YrnT5JHrYNw0Dyjl0eZPSyQ2VbPis4hKX9p7ok1JSFchlNsxWE7H
         iEN1AJ68ys3wNV9qxfYTf2riOcDKUpb55jYsoApqZEnLaXeB8Ks0EenpVo29SOn2uG
         EPD2diNQWNg4XEEyOjAwG3+QTpKCIxia6muqW7WTtuqGYrnOfgldAgbcAWMxZW/6s3
         DbHWrEvxGwY4w==
Date:   Mon, 7 Aug 2023 13:09:46 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/6] page_pool: split types and declarations
 from page_pool.h
Message-ID: <20230807130946.22da17b4@kernel.org>
In-Reply-To: <20230804180529.2483231-2-aleksander.lobakin@intel.com>
References: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
        <20230804180529.2483231-2-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Aug 2023 20:05:24 +0200 Alexander Lobakin wrote:
> Split types and pure function declarations from page_pool.h
> and add them in page_page/types.h, so that C sources can
> include page_pool.h and headers should generally only include
> page_pool/types.h as suggested by jakub.
> Rename page_pool.h to page_pool/helpers.h to have both in
> one place.

I had to touch this one up a little when merging to fix build 
for the merged-in-meantime mana driver and also update the
patch in Documentation.
