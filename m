Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45248763B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbjGZPo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjGZPoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:44:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22071BE3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:44:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80EBD61B8E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E63C433C7;
        Wed, 26 Jul 2023 15:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690386261;
        bh=JvjAqNzSw7RGl03zCiiOwwXJFn3DlYoUHXuh6xzWd/A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RpnOLYopyCZ49Ky3mG+aQnjQTsvSLTvOebr6AWgESRleqJjr2YDmT15izsvi7NN2k
         2JiLzaEaUretzBaAkWwQ09n/P/kyu1qyg6jQvkZYOsbqq9w31zB9qgSodlCmwk3ntv
         XOTwMfXCdayMBeFGyWGbJYYcTPhicnARanwRTlrXlvEV+rdB/ZdcpAZkYZyvXFnA6H
         pFQQq8ChSFzdT9BfgQKUUKSvBhOt0yVkiqfcjWRdY+AtewiXxs1uT0zzxlsmQCPy+a
         WNuo+mcEY3VR2dUZvzrXq538ky6g35z4ymRVa66yfsBbM+COr1BU5q+DcsXskykD3/
         FBZBIbeRprDSQ==
Date:   Wed, 26 Jul 2023 08:44:20 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Lin Ma" <linma@zju.edu.cn>
Cc:     "Nikolay Aleksandrov" <razor@blackwall.org>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, idosch@nvidia.com,
        lucien.xin@gmail.com, liuhangbin@gmail.com,
        edwin.peer@broadcom.com, jiri@resnulli.us,
        md.fahad.iqbal.polash@intel.com, anirudh.venkataramanan@intel.com,
        jeffrey.t.kirsher@intel.com, neerav.parikh@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtnetlink: let rtnl_bridge_setlink checks
 IFLA_BRIDGE_MODE length
Message-ID: <20230726084420.1bf95ef9@kernel.org>
In-Reply-To: <7670876b.ea0b8.189912c3a92.Coremail.linma@zju.edu.cn>
References: <20230725055706.498774-1-linma@zju.edu.cn>
        <6a177bb3-0ee4-f453-695b-d9bdd441aa2c@blackwall.org>
        <7670876b.ea0b8.189912c3a92.Coremail.linma@zju.edu.cn>
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

On Wed, 26 Jul 2023 15:49:02 +0800 (GMT+08:00) Lin Ma wrote:
> Cool, I agree with Hangbin that another patch which removes the redundant
> checks in driver is needed.
> 
> But I have a simple question. I will send this patch to net one and another
> to net-next one. How can I ensure the latter one depends on the former one?
> Or should I send a patch series to net-next that contains the former one :)
> (I currently choose the method 2 and please let me know if I do this wrong)

You'll need to wait for the patch to propagate before posting.
Our trees merge each Thursday, so if you post on Friday the fix
should be in net-next.
