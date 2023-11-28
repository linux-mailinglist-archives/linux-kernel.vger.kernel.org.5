Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071047FB0DA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 05:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343491AbjK1ENM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 23:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1ENK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 23:13:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23398E6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 20:13:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563E6C433C8;
        Tue, 28 Nov 2023 04:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701144796;
        bh=kAFkMvBuLfoHgFynFH6S+wAYd5BKHuLLlWYI0TgSnM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KsHK2C7QQNAZvE2TpT26qgP1ecn2xqUubax583ZQy5fNMPwpmu2nys/t5HsPExq+g
         wG+FFNol9mfsKnM+zqMiItVBu6YQ4psJBxsJXd9eWz7J8X/y41QYBUevA8jbCO3nhk
         Y5W2quyU6plh7doZG9VKUbYXwzIHeQIQEeaIiN9KeitQ1tXtLNgRdondYiZYicad7i
         BEtxWIUZxyjBe+cJ9aX1JPJtwPv6gGiYDpptmYPfB9/3I7WyRr4Ob2cD4RoRZ0duXx
         CiRknHcsC8zqx6J7XaRuvFva0sPGO0R7xHj4fbMufD6iN1eW2IGRKo4iNN7aW0Z+DS
         E4aRjGvVaEdkg==
Date:   Mon, 27 Nov 2023 20:13:14 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 12/13] RISC-V: crypto: add Zvksh accelerated SM3
 implementation
Message-ID: <20231128041314.GK1463@sol.localdomain>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-13-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127070703.1697-13-jerry.shih@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:07:02PM +0800, Jerry Shih wrote:
> +static int __init riscv64_riscv64_sm3_mod_init(void)

There's an extra "_riscv64" in this function name.

- Eric
