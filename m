Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7007B80979D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444184AbjLHAto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHAtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:49:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3B9128
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:49:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5458BC433C7;
        Fri,  8 Dec 2023 00:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701996589;
        bh=EHTPFrjAnUcFE5n/Ico6Xo6PnZAf3NpCXQrBkMkxcMk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kMEcxC3dD1bhKGVlnyXeOfTfo+bK1YjU002o2xhG1LsBfyb1ltPY/P6nwVmJQHkZU
         qEjCUyH/nF5AWxndYQ6P6YNFWakU2OGuilMxx3Qd3sNFI7vkTfKRgjNHRD8Ob01wE3
         tttm3p4HHJddq4BSUO5UowJcPEl1/CQqO/of4I9sUlQ0q1tpkl1+zikOSa7WEUZ6fB
         LuKbp8GZjunBpU12rwo5UDft4ffydgpyGvF4Pf0IyzJGNMVoNrhx1tbdvd9U6PUjVa
         PXyvIJAjZoaL1feVgcym8RghbASu2HyuCi+WuvjrATDJG2pvcw6jK8Rr9RnhcRfrJR
         FZgFEA6LbRvNQ==
Date:   Thu, 7 Dec 2023 16:49:47 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wen Gu <guwen@linux.alibaba.com>
Cc:     wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/9] net/smc: implement SMCv2.1 virtual ISM
 device support
Message-ID: <20231207164947.3b338de4@kernel.org>
In-Reply-To: <1701920994-73705-1-git-send-email-guwen@linux.alibaba.com>
References: <1701920994-73705-1-git-send-email-guwen@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Dec 2023 11:49:45 +0800 Wen Gu wrote:
> (Note that this patch set depends on an under-reviewing bugfix patch:
> Link: https://lore.kernel.org/netdev/1701882157-87956-1-git-send-email-guwen@linux.alibaba.com/)

Post as an RFC, please, until the dependencies have converged.
-- 
pw-bot: cr
