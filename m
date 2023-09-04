Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04C9791F9F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 00:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbjIDWuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 18:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240487AbjIDWur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 18:50:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD27E5B;
        Mon,  4 Sep 2023 15:50:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AA40CCE0F12;
        Mon,  4 Sep 2023 22:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00A8FC433CB;
        Mon,  4 Sep 2023 22:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693867827;
        bh=iaEOPWihMAOVses/F4GOxQvV7G14u6w/w/k4+yTjKXw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nGiVILP9BHMxgu8czR8umgjdOaF8rmx47yyuKbPyl7gxWjRC5NzhvW4LTnZlnS7rF
         O8fkVXGKATUbIkiv+L5NUmoKAv3XXPsiFWROSbnyZIoufhUIq8Eu5HMuv49B0E/lCt
         BlxXrCW4RUG/RtUlD6dCsKVNOuA4WpizEnNZokL+SlDFjqCGUzxN04OltUgKiJWp0I
         vIz8wuCYmJZ00vr47DjLSbH50Mmo6CFe0cva6mzBpRsmL3I0Mkif6WFe6ANGhGwpc3
         Q0lRRWBw1iBFHWnRXB7ctca41vH0LGW+XIrbtLL9FufakE50M7nxHKgHEAe/YT9x33
         bs5pYj8/pJdtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8814C0C3FD;
        Mon,  4 Sep 2023 22:50:26 +0000 (UTC)
Subject: Re: [GIT PULL] remoteproc updates for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230904161621.2954993-1-andersson@kernel.org>
References: <20230904161621.2954993-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230904161621.2954993-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.6
X-PR-Tracked-Commit-Id: 18cf4fcd7bdc1864e75127f4fd15abc0bc76ec7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a3a850ed008dba2cb9707c65c5726efcfc72449
Message-Id: <169386782688.10061.17092840147185976662.pr-tracker-bot@kernel.org>
Date:   Mon, 04 Sep 2023 22:50:26 +0000
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dylan Van Assche <me@dylanvanassche.be>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Ye Xingchen <ye.xingchen@zte.com.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Tero Kristo <t-kristo@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  4 Sep 2023 09:16:19 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a3a850ed008dba2cb9707c65c5726efcfc72449

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
