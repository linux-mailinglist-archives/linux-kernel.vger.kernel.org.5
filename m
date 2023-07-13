Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8731E7517F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbjGMFUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjGMFUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:20:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360F92115
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:20:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1AB861A0F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13CEC433C7;
        Thu, 13 Jul 2023 05:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689225631;
        bh=z6zuH7daBzbcGYtDcnZ439Wv5nCYbKqhRoUY8isgFv8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=quNv0cvF6oB6HahcBuOl/c7UiHvHpeZ4eM0E92Mu1dzFhEudhYIwrwM0mjFflc5+s
         h++O8z4z/cQy7iQh7IFld0SOyhp3I6Geu2mLfgwNXGmh1ru6GVgzoZeSsMkpOCp5xk
         M8bK2MqtVWf2K5CZDa0O5N50stSDmqck0p8ppzRfENTz4qDZbGboC2CjGE/eLYNpJN
         LREnVL6ioycpFeJh/RaFJEcyiUA3nhz4e7j36LFT+MfhQiOBVnHnu05nINUy5CcsDY
         rZ1NpymSDAepPyknMppha8MVAov0DyMG4+VFhKUaAfDBtJVnm9SkI1rLShkKU1cKqa
         EqHAzFV455gqw==
Date:   Wed, 12 Jul 2023 22:20:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [net PATCH 2/3] octeontx2-af: Fix hash extraction enable
 configuration
Message-ID: <20230712222029.6a918a58@kernel.org>
In-Reply-To: <20230712111604.2290974-3-sumang@marvell.com>
References: <20230712111604.2290974-1-sumang@marvell.com>
        <20230712111604.2290974-3-sumang@marvell.com>
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

On Wed, 12 Jul 2023 16:46:03 +0530 Suman Ghosh wrote:
> As of today, hash extraction was enabled by default for the default
> MKEX profile. This patch fixes that and enable the support based on
> customer specific MKEX profile.

I'm not sure what this means, can the commit message be readable for
people who don't know your HW, please?
