Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A7B7BB927
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjJFNfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjJFNfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:35:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755CA9F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:35:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EACC433C7;
        Fri,  6 Oct 2023 13:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696599302;
        bh=WKO6RcQqAG8IX5IcPTGrGweYu9Qjx2yG0cnrvA8Gkd4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gj2NXk61K87JY0oX6au3+Ysj6IhCgw3YMqHreFXxuH3eq2QqFWc3/5/ZTKYgi/8a9
         hVfC5oJv63xCu5zYPoRcLJ23MMNVMESIgLmMBsSlFXuHS1R+mFIupWPvEplDjPZMiI
         a6gyqSCLjnJsfB0fhXVy9Ia8qWzXE+VN3/5du1rfUEEE+CIyaqDitasrFzQxC61lhe
         Z60QmQnIionHURo01fqBf47eVJEKImRVeX5Zhu3TFHPoSRc54xIyF2e2j/HRB2jhFa
         87qYVmtbjuehh1Une71VwddZIH/RaOq1f7Rj2W++MFvFJzpgB7h+EOi1gksX7zJwvk
         yBywdNK8XiLUA==
Date:   Fri, 6 Oct 2023 06:35:00 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Rohan G Thomas <rohan.g.thomas@intel.com>,
        alexandre.torgue@foss.st.com, andriy.shevchenko@linux.intel.com,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, joabreu@synopsys.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        pabeni@redhat.com
Subject: Re: [PATCH net-next 1/1] net: stmmac: xgmac: EST interrupts
 handling
Message-ID: <20231006063500.035f3604@kernel.org>
In-Reply-To: <cjgx6e3agc6gpvs75nhkf6wlztk73epmct6tcuooyqvk2nx2o2@vr5buyk637t3>
References: <20231005070538.0826bf9d@kernel.org>
        <20231006072319.22441-1-rohan.g.thomas@intel.com>
        <cjgx6e3agc6gpvs75nhkf6wlztk73epmct6tcuooyqvk2nx2o2@vr5buyk637t3>
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

On Fri, 6 Oct 2023 13:08:33 +0300 Serge Semin wrote:
> Jakub, what do you say if Rohan will just re-submit v2 with the
> addition cleanup patch and let him to decided whether the cleanup
> should be done first or after his XGMAC-EST IRQ update?

Sure thing, whatever is more readable for the reviewer.
