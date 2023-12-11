Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE8280DBA0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345018AbjLKU1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345014AbjLKU1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:27:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE68A98
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 12:27:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE81DC433CB;
        Mon, 11 Dec 2023 20:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702326467;
        bh=jnLDKDObyODrW4yUrf2GM7i1XjdC3e8rJg72m1Tdr7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kBLNCfzvYJYRFpXpFHfkENqbdH5VwClbg0FEVqhK2k77qqCLGe4hcR0LVoyptVhKb
         ClBEgSoItksIlWWs4//e+gJntjm0K6/Itq2ewvl6pN2FgqqozgpEFfEwWaWmgo6KIL
         RkZEDR2Yx/XsgeHFrshsD4lnKf26WmjxGj+AUB8DHc20Ax0DsDu5rI6ARaNWsUEdN2
         IAlQwQpKjxBM39qKUSKO3ywheqH6dW4bSvyd2yQdNBlspcOCFi0YzkGsuemjTukKdM
         0orZFg9DQGJm5SZkxUMfnWSv7w7NsJ98f8wovP9Ozz/Oc8WczYDnsUS+1tl5f3L4FQ
         1Uzf122VTthEg==
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Log SVCR when the SME tests barf
Date:   Mon, 11 Dec 2023 20:27:30 +0000
Message-Id: <170229612040.43237.5946498917108951815.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231205-arm64-kselftest-log-svcr-v1-1-b77abd9ee7f3@kernel.org>
References: <20231205-arm64-kselftest-log-svcr-v1-1-b77abd9ee7f3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2023 14:24:44 +0000, Mark Brown wrote:
> On failure we log the actual and expected value of the register we detect
> a mismatch in. For SME one obvious potential source of corruption would be
> if we had corrupted SVCR since changes in streaming mode will reset the
> register values, log the value to aid in understanding issues.
> 
> 

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: Log SVCR when the SME tests barf
      https://git.kernel.org/arm64/c/48f7ab21f731

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
