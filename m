Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4418B7653B2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjG0MYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjG0MXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:23:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE5D30FB;
        Thu, 27 Jul 2023 05:23:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60AE561E61;
        Thu, 27 Jul 2023 12:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6F3C433C8;
        Thu, 27 Jul 2023 12:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690460582;
        bh=aBgrpdn2C/ogY6Z8opCycuHSOFI29w3XA6CeMb63NLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kjeMMoSMJlEKvvONBbiwnALXHp+zkTwWQibQZ5Kz2LqtYsmQCLIIArdpB2wFfyYaz
         Q8qW2GAufCGIGaMvxkxaP6MFaVIvy2qc5jjEvb2AQ/C94NPZe1Zi751oIPsAzAhp1C
         HWKnfpUNNvHKgPTCRByn6945mbMlQD+V7G9oealDDfQWZ2CfzaL7DNWTa2sdtzzarc
         s0EKSZ2s1m4+mIWCrRU1h/YiqUg0j9fT7nN/248gO/YANO/jq+uRjz03k4q3nGe23P
         4DvqM//cpWbxE4L6E0tQ5CVBut4slDY6zUQCtcZAzn3ckrXKLDzxvJ/xJ9lnOTWN0X
         dIiYS87MlA5+w==
From:   Will Deacon <will@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: errata: Group all Cortex-A510 errata together
Date:   Thu, 27 Jul 2023 13:22:34 +0100
Message-Id: <169045187546.2092077.1260688948809023815.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230706203030.276437-1-robh@kernel.org>
References: <20230706203030.276437-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2023 14:30:31 -0600, Rob Herring wrote:
> There are 2 sections of Cortex-A510 errata. As the ordering within
> vendors is in order by CPU/IP name, move the 2nd section up to the 1st
> section of A510 errata.
> 
> 

Applied to arm64 (for-next/errata), thanks!

[1/1] arm64: errata: Group all Cortex-A510 errata together
      https://git.kernel.org/arm64/c/cce8365fc47b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
