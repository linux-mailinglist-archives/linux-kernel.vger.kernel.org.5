Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADADF7E4EF5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbjKHCdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjKHCdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:33:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81B6181
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 18:32:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E7DC433C8;
        Wed,  8 Nov 2023 02:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699410778;
        bh=oxdPRn1arWKno+F4Ag4BitwCnKv4pNyK5vr88aO4zBE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sAS+6wurvdk5DVWAx4sIYBr1J8yvuysqIW9qVadwv/hAIBX5k9wdQuWNvhOfg41LN
         XmRgZNvcm/rg1M4DiPiRkTH4O0AbTX3i5+6ZijZbq80vT41bU15qIOFhhtQFosrJng
         YlXv6HHXQ3womyyI2n7pw3gPZua2khbYJVtdO1hjcIIyvdisXMw+2bOSqhcD1B5IWm
         /nLVrmYwCXqcEy2FZ3QgHVaAtxwDzcfWLrYuzps/xZR/74z7U+C2t53PlabHW3CmDC
         hZNHnl7I9LTEOm/FRkvnBU8P6fLqwiADQCjNZccv5s0JulfmTUq1opqJnFaG0Uv00z
         +mj8QJD+7hNgw==
Date:   Tue, 7 Nov 2023 18:32:56 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        MD Danish Anwar <danishanwar@ti.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Add missing icss_iep_put
 to error path
Message-ID: <20231107183256.2d19981b@kernel.org>
In-Reply-To: <b2857e2c-cacf-4077-8e15-308dce8ccb0b@siemens.com>
References: <b2857e2c-cacf-4077-8e15-308dce8ccb0b@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2023 12:47:42 +0100 Jan Kiszka wrote:
> Analogously to prueth_remove, just also taking care for NULL'ing the
> iep pointers.
> 
> Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
> Fixes: 443a2367ba3c ("net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support")

Is there a reason you're not CCing authors of these changes?
Please make sure you run get_maintainer on the patch, and CC
folks appropriately.
-- 
pw-bot: cr
pv-bot: cc
