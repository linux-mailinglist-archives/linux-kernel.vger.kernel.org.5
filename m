Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71AC7C7AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 02:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjJMABv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 20:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJMABt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 20:01:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB016C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 17:01:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E53C433C7;
        Fri, 13 Oct 2023 00:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697155308;
        bh=Ha5S911H5ryYsiwYz0UJplTypjEmV4oV7kNBO0ZqmXA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iekErt/EtcnZMdtnt6ARmkStMpS+OHACro/dgSHLXxtVq+JUIJUwAgAZ2zxvaO8qa
         PAIuDp8eSG2pco4dZGwna6XKWb6aSOg0TdEUt6b9C4UcS1LRPuaY7riQxiQO61v6Nw
         VS41ScmoZNVfcNLlmlUCqthMumlGq4X7akbFujjJ7N3hmTSngD/xWMcM8X8BICJyUo
         /Ft8/Kmwq8HPPj2aKJdnTvscOSfWT6/Yg2eDTj0B4L5xPk+/PPop+IKh4SctkJHZHZ
         Ae9UeuSwwQ6Qc3FGPc29VULp1XC0PanRWcaKAuaaoM4KkDgwDgOwdNB4hvaJY1v14R
         2DqQgCDqCrSZg==
Date:   Thu, 12 Oct 2023 17:01:47 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <egallen@redhat.com>,
        <hgani@marvell.com>, <mschmidt@redhat.com>,
        <netdev@vger.kernel.org>, <sedara@marvell.com>,
        <vburru@marvell.com>, <vimleshk@marvell.com>
Subject: Re: [net PATCH v2] octeon_ep: update BQL sent bytes before ringing
 doorbell
Message-ID: <20231012170147.5c0e8148@kernel.org>
In-Reply-To: <20231012101706.2291551-1-srasheed@marvell.com>
References: <PH0PR18MB47342FEB8D57162EE5765E3CC7D3A@PH0PR18MB4734.namprd18.prod.outlook.com>
        <20231012101706.2291551-1-srasheed@marvell.com>
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

On Thu, 12 Oct 2023 03:17:06 -0700 Shinas Rasheed wrote:
> Sometimes Tx is completed immediately after doorbell is updated, which
> causes Tx completion routing to update completion bytes before the
> same packet bytes are updated in sent bytes in transmit function, hence
> hitting BUG_ON() in dql_completed(). To avoid this, update BQL
> sent bytes before ringing doorbell.

Please read this:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review

And also when you reply to people please use sane quoting.
This: >>>
is used to indicate three levels of quoting.
