Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F66A751800
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbjGMFVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbjGMFVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:21:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528BE2116
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:21:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEB32618CF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6ED5C433C9;
        Thu, 13 Jul 2023 05:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689225699;
        bh=3lUl6XQkY1VlNWjhof7PyxxMgzH+ocQU21QLbaafvq8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=euIL5EzlXfRfn/FGUKw0SLJMclUku4PWXH8xCJms8Hoa4ikPVGFrIFEZyGx/SChwM
         nMDD3CMJVmNgRZ0Q8JR6klU2fx4mwyXzXUFaNOS9c7WodJ3UG0qODUlRQVUA0iF3Uj
         ipzKml5V3uTGQbSFhY4fVKgtZMYdbLKsSdjF7Sj2MzWUUPgjdv4fiydC/DfbfgEGNc
         t9LWbeha3nBLKYIDaCqwIHj4euGAOucqSBUgf8ybv4KpVHMAJz4Ydc5KZxx3x8+QMT
         SU1ZWBjfixPtwpGhBdbG+3XUpZgpnX/TDklaeXcfX6TL+MDzCDQU0HHeQYvIkpnoAK
         UwqSUhyu87CwA==
Date:   Wed, 12 Jul 2023 22:21:37 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [net PATCH 0/3] octeontx2-af: Fix issues with NPC field hash
 extract
Message-ID: <20230712222137.5f59c92c@kernel.org>
In-Reply-To: <20230712111604.2290974-1-sumang@marvell.com>
References: <20230712111604.2290974-1-sumang@marvell.com>
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

On Wed, 12 Jul 2023 16:46:01 +0530 Suman Ghosh wrote:
> This patchset fixes the issues with NPC field hash extract. This feature is
> supported only for CN10KB variant of CN10K series of silicons.

All patches look like features / extension.

Please describe in the cover letter how user of upstream Linux kernel
can take advantage of those features.
-- 
pw-bot: cr
