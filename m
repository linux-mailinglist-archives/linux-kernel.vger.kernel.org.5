Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122A776A287
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjGaVQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjGaVQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:16:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7110410E3;
        Mon, 31 Jul 2023 14:16:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06357612DF;
        Mon, 31 Jul 2023 21:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43556C433C9;
        Mon, 31 Jul 2023 21:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690838203;
        bh=ZhzilWM4KSpruPmDJoWaxhNsUNlrrPvwlDCR8BGNxsA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=m0ci16QSVOyeUpbVw9uZ9xvIcAtMe+DK79wn+r9J2UgCyjFi55xA+X7URIJw6XVdO
         kEDEHG8EnXHyMIUL6MOfreJxVJo3zz7M65Li5clDTK4hVgWURBf0Jf0YI3WvQtehqp
         wGUOpemnQM7KeeBEzGbrlZTnr/ngMLz61ZJ6WaqcBaCgWqrtGfyOyAMG39cvH7laQS
         1wVB+XgN1DLqfnJVJzUer1ZZ289cGomtNAD97HcMWO6MO81BINvhNE/1GkJT9yDhl+
         BlYa4LBnHap1LJBxWstNqAt6j+uhfe161B9uc++puf+a4yiok44Rz4gLakE6vTNcrX
         inXmT/N/rW2TQ==
From:   Mark Brown <broonie@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Praveen Talari <quic_ptalari@quicinc.com>
Cc:     quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_vnivarth@quicinc.com, quic_arandive@quicinc.com
In-Reply-To: <20230714042203.14251-1-quic_ptalari@quicinc.com>
References: <20230714042203.14251-1-quic_ptalari@quicinc.com>
Subject: Re: [PATCH v7 0/2] spi-geni-qcom: Add SPI device mode support for
 GENI based QuPv3
Message-Id: <169083820097.564817.14087328403536590412.b4-ty@kernel.org>
Date:   Mon, 31 Jul 2023 22:16:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 09:52:01 +0530, Praveen Talari wrote:
> This series adds spi device mode functionality to geni based Qupv3.
> The common header file contains spi slave related registers and masks.
> 
> Praveen Talari (2):
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] soc: qcom: geni-se: Add SPI Device mode support for GENI based QuPv3
      commit: 59bbe86bb212b618ec2b50434f54bb4cfc704f44
[2/2] spi: spi-geni-qcom: Add SPI Device mode support for GENI based QuPv3
      commit: d7f74cc31a89a45d4c7deaa5f759661a07a183d6

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

