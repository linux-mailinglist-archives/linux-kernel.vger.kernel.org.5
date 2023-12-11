Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777CA80D2C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344888AbjLKQvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjLKQve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:51:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4DC8E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:51:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D840C433C8;
        Mon, 11 Dec 2023 16:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702313501;
        bh=jXrfnDnXSAdCkJtLjpJCKDrNg7DOIOOclITycj8SrBs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XvrINhKbpjF5SAY9B9Ur5XIGWUrWK005J4+6zhivTUVERjJN0CYBnXNG6sktJZBEa
         +TKtwkIzZVvPI/ygufXQWweLn+Mlqk6IeALZRk1vekCm+1e8XBBdoXTor6Yv7ivWhQ
         eL54cJKPGd8ozXq1KoU/98JRmzw28WQfqH+5QfPPpHimLkTDrn2qc37M5hhAd/CYgR
         LT1RJwRU6R4F1wu0CIRg9sztDfGXp0nQkO6lpE5eldTKmGpQmfO32z1+P/M7GeB6pF
         aL8ZWXSw25SVWwVnRbrBW4SgnRh5pKeQrIlqCEeUczOF1wijqzJZHLuNJgDRQirWa0
         gJHZU4dYAQ6pA==
Date:   Mon, 11 Dec 2023 08:51:39 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Patrick Williams <patrick@stwcx.xyz>
Cc:     Ivan Mikhaylov <fr0st61te@gmail.com>, davem@davemloft.net,
        edumazet@google.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, peter@pjd.dev,
        sam@mendozajonas.com
Subject: Re: [PATCH net-next v2 3/3] net/ncsi: Add NC-SI 1.2 Get MC MAC
 Address command
Message-ID: <20231211085139.011f650a@kernel.org>
In-Reply-To: <ZXZ5EOSJAekCiT44@heinlein.vulture-banana.ts.net>
References: <20231114160737.3209218-4-patrick@stwcx.xyz>
        <20231210215356.4154-1-fr0st61te@gmail.com>
        <ZXZ5EOSJAekCiT44@heinlein.vulture-banana.ts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2023 20:50:56 -0600 Patrick Williams wrote:
> Either you or I can send a "Fixes: " on this commit to improve the
> handling as you're proposing.  While the change is likely trivial, I
> have not had any chance to test it yet, so I've not sent it up myself.
> If you want to refactor the code to reduce duplication, I think that should
> be an entirely separate proposal.

Yes, incremental change is better.
