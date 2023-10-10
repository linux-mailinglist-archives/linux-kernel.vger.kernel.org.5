Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3297BF171
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442023AbjJJD3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441968AbjJJD2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:28:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EC592;
        Mon,  9 Oct 2023 20:28:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E059C433D9;
        Tue, 10 Oct 2023 03:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696908528;
        bh=9bUg+YT/IF5JON4/jENIBUMkFKuPDwrjXwprsrzaXsA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=EbldYT9/znJCxBXHQtzBPJelf9KTfk5l254Hs3J9oTbiJ3gXAZtfVZoapsCbHgi8+
         pqx3vppC5mMnRZjN6t6cDJ24sZdyxFv3upftOakrAdhJgi9iddr/3zPEl2P5s7hZj0
         p26mMPfTxE7kXNzbWjoP8yZtl9JIkw5KAKnCjqtR8NsCLOjV2+++EAIouncn7ga9u6
         9stFJITFi1QHdn+JCt3S/1H7y56iRUK/unAxKn4aJLOgMyUEdRQ/J4PazOnqVXIRIV
         EhOoJkH5YJcSi6LlHVY+arERW28OflH6IqpIBY6WaQXPMQM0JgaiocVeWxClB4KKCv
         HdBfEtVbzpJ/A==
Message-ID: <4b02625b2739de551aa931c0244c5f2c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230929-clk-rbtree-cdce925-v1-1-a36b459002f7@kernel.org>
References: <20230929-clk-rbtree-cdce925-v1-1-a36b459002f7@kernel.org>
Subject: Re: [PATCH] clk: cdce925: Convert to use maple tree register cache
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 09 Oct 2023 20:28:45 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mark Brown (2023-09-29 05:03:43)
> The maple tree register cache is based on a much more modern data structu=
re
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Applied to clk-next
