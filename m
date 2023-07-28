Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CB87670FE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbjG1Pur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbjG1Pum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:50:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4902F44A8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB47562186
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 15:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE92CC433C8;
        Fri, 28 Jul 2023 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690559425;
        bh=7DFCo6qeekzwuWPEKZAyczH1RGTzlysIXVLTrOCoYTo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ssPs83QcERvNqi05t+eltoSHZrWBX+5yll8ocUoJ5tvrPyVGdOXmXSQXX34MKYMAS
         LJiEvvM8hZ47UKOV98143/z8syV08krfaTGFRfL9VWmwP7UKoAyxSvn49lx0hZD+NO
         daHvXpoDM8PKR9rqNPoFHkdhRaiHZtE4fo26pkSRYONbtb8xKdZNzpffbZDPm6eqU0
         f8t/atlEuugkpwJg/iTYxvJUs2oyV/ixdPn52u01abGmUY7WgkBwrMS9enDx5Q2dSn
         uSPVpM/m1gNIhyrxexWWFlUZaHZVFt7CxkqSc+T5AAeADGk2BarQoeEbzdRiOzt9ZS
         KzO31UWDItj+A==
Date:   Fri, 28 Jul 2023 08:50:24 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/9] page_pool: don't use driver-set flags
 field directly
Message-ID: <20230728085024.684970ba@kernel.org>
In-Reply-To: <6f8147ec-b8ad-3905-5279-16817ed6f5ae@intel.com>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
        <20230727144336.1646454-6-aleksander.lobakin@intel.com>
        <a0be882e-558a-9b1d-7514-0aad0080e08c@huawei.com>
        <6f8147ec-b8ad-3905-5279-16817ed6f5ae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 16:03:53 +0200 Alexander Lobakin wrote:
> And it doesn't look really natural to me to pass both driver-set params
> and driver-set flags as separate function arguments.

+1
