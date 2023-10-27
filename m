Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A957DA3C5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346679AbjJ0WzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbjJ0Wy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:54:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C365E1B5;
        Fri, 27 Oct 2023 15:54:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A47C433C8;
        Fri, 27 Oct 2023 22:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698447295;
        bh=yz8o/Vn+GEO1l0ZVtawgLFQOnZcMh+boTsEWUHQsCWQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CRhrfQWSpQiYGdhEFInBfosLrSiQFERwNkEmMei82ay8LDxixPPGJZ7kBEAguChWO
         MjR0Q2aASJAD8GfQAF0IWOXiOX+6Bnj3qnGeYuX8MQ5iVpf/4UC8cdOx/1p6Pid4xN
         M42vm2tEzaGTCwn4BDAHdDySZ3xnJGmOG0LO/AIj6+A+kvSySfjBndhbWUlKlAJB6J
         8PafzY1SuTgevbAgHjxyWXzc6zlC0p+wF959oO21xBvWROcyi1FNYbmSCSFccf1fFK
         7oTrdy4mblQ20Bh9i0dkYtzhtjtr1YEHOb/NIMzbRHJJBVYduDqGwKeW7EcRMDt2kD
         GZZETW3PIo00w==
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231027152403.386257-1-arnd@kernel.org>
References: <20231027152403.386257-1-arnd@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: amd: acp: add ACPI dependency
Message-Id: <169844729310.3013518.10123036359979403557.b4-ty@kernel.org>
Date:   Fri, 27 Oct 2023 23:54:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023 17:23:52 +0200, Arnd Bergmann wrote:
> A newly added function requires CONFIG_ACPI to avoid a build error:
> 
> sound/soc/amd/acp/acp-legacy-common.c: In function 'check_acp_pdm':
> sound/soc/amd/acp/acp-legacy-common.c:401:19: error: implicit declaration of function 'acpi_find_child_device'; did you mean 'acpi_match_device'? [-Werror=implicit-function-declaration]
>   401 |         pdm_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), pdm_addr, 0);
>       |                   ^~~~~~~~~~~~~~~~~~~~~~
>       |                   acpi_match_device
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: amd: acp: add ACPI dependency
      commit: 0b38362018c79bc6cf9d8ba4ee9a2a3827ba6328
[2/3] ASoC: codecs: aw88399: fix typo in Kconfig select
      commit: cf046ecbcd1cd0ef1d762b3365b9918175e121ab
[3/3] ASoC: amd: acp: select SND_SOC_AMD_ACP_LEGACY_COMMON for ACP63
      commit: a65cdffbef7bfdb9f55a3acb07ccf18d4f97b3a5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

