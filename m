Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BA8761F84
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjGYQuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjGYQur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:50:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0AB268B;
        Tue, 25 Jul 2023 09:50:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02EDB61804;
        Tue, 25 Jul 2023 16:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42710C433C9;
        Tue, 25 Jul 2023 16:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690303767;
        bh=wljKIvIhCAvwUWXLNlEVuBqrMB/ZTYdEiw5PLP21L/U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ozm3sP55zIQu83KNRdafniy85etyRac6KCEQaLPPixxVJe/WX7isfuj82y8iQJk2A
         0+EVS0F/i2i8GBP9vXAD8iVFIfn4OiDzV55X/84qZulOSuZ1/YwIQGEeIX7OzwBve+
         vuDbnGOZ1l6x5CLtyXXGCGMP3tqtKJPhQR7HdlHY3A9SrDT5v/CPZHiNxdoVgHlir3
         c7EyjNpQgeaNdjV9OhILjgCkh13iL/E5+DooJ+azc01KOiEM2COo3Rk3dF1J8eDeUV
         YEPX6Nisw7sBilygqtewjBOuyDwfiKqlhUa9MLkU6gzsIhygDi2fazWIV8G+fiGkSD
         Ov/pxCrrh5OIQ==
From:   Mark Brown <broonie@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1689062414-3654-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1689062414-3654-1-git-send-email-quic_rohiagar@quicinc.com>
Subject: Re: [PATCH v3 0/3] Add regulators support for PMX75
Message-Id: <169030376498.1478387.14075297959200519808.b4-ty@kernel.org>
Date:   Tue, 25 Jul 2023 17:49:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 13:30:11 +0530, Rohit Agarwal wrote:
> Changes in v3:
>  - Created a separate patch for updating the entry in pmx65 bindings.
>  - Changed the subject of patches [1/3] and [2/3] according to the convention.
> 
> Changes in v2:
>  - Addressed Krzysztof to update the if:then: in bindings patch.
>  - Breaking the original series [1] into smaller series.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: dt-bindings: qcom,rpmh: Update PMX65 entry
      commit: 4fdef8553df58953f572f1cb46d357c735c683a9
[2/3] regulator: dt-bindings: qcom,rpmh: Add PMX75 compatible
      commit: 0ef3d931632e3fce51ed5510935238937d644c97
[3/3] regulator: qcom-rpmh: Add regulators support for PMX75
      commit: 0b294ed669ead34a348d17d06b6d4d58712b14e2

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

