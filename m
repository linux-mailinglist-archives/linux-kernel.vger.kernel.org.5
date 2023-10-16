Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926BF7CB6E5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjJPXN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjJPXN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:13:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E34AAC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:13:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C04C433C7;
        Mon, 16 Oct 2023 23:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697498034;
        bh=3R5dUBn2483stJZw4ASF6hREmPIo9l5rKKo6lGtoAgg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YYcuvI1g/SeSLUmhrYbWCqJSDUbl6GSyzl3TJL2eYq2GJBf/9fg5zSnl/YOsQo7Ky
         Er08FyYRfGeVzA2x2lCbd7ecBigQDfG8rka3peAzM5fEY8dO9JVZoj9GQKE8ZcNuyD
         Y0sziQcyZwtqNCSduNcFXBe/2LTrIQLaEO3NOK1cVSUAlmij3xdE+WvHNyy7KZfhRY
         H6tjqkFKiG7yPIynnmuzRA/rTlxN0XDpI+d5ehvonzoxBCYEpJGgSYNhHZBAjZ0cHU
         12bsb2YAyvUusFiLD5wu+2poZlheBocmgH1N8k5rx03gXilIOAvGSlFmQcy4XHD1he
         f1li2eMtKW4ig==
Date:   Mon, 16 Oct 2023 16:13:53 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: cpmac: replace deprecated strncpy with strscpy
Message-ID: <20231016161353.48af3ed7@kernel.org>
In-Reply-To: <20231012-strncpy-drivers-net-ethernet-ti-cpmac-c-v1-1-f0d430c9949f@google.com>
References: <20231012-strncpy-drivers-net-ethernet-ti-cpmac-c-v1-1-f0d430c9949f@google.com>
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

On Thu, 12 Oct 2023 20:53:30 +0000 Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.

This driver no longer exists. Praise be.
-- 
pw-bot: reject
