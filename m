Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF2C7CE078
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344996AbjJRO4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjJRO4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:56:53 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C4694;
        Wed, 18 Oct 2023 07:56:51 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39IEuZk3084757;
        Wed, 18 Oct 2023 09:56:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697640995;
        bh=CaUGr/SqVLiuQktYdevT1SsMh913EJz5Ua6xquJgvYI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JSWhCqXWSgFhQqUVrr4zuDcnE3fR2/upXRmn7nmHK+9qb+KplUAAlDrvhjtGGedkQ
         lUHnCUMxjQAg+onHA/F1PlkxiDNwXSpd9jH3SFihnRVCp28rWT6jVmIQQlvZ/NcvJq
         IjmFFdR0cCNHBNZvRodl66kVo7aMmfTNVyhHA3wE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39IEuZtj077864
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Oct 2023 09:56:35 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 09:56:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 09:56:34 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39IEuTth012015;
        Wed, 18 Oct 2023 09:56:30 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jai Luthra <j-luthra@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devarsht@ti.com>, <a-bhatia1@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Julien Panis <jpanis@baylibre.com>,
        Esteban Blanc <eblanc@baylibre.com>
Subject: Re: (subset) [PATCH v3 0/6] arm64: ti: Enable audio on AM62A
Date:   Wed, 18 Oct 2023 20:26:05 +0530
Message-ID: <169764092458.296431.7774477701043594499.b4-ty@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003-mcasp_am62a-v3-0-2b631ff319ca@ti.com>
References: <20231003-mcasp_am62a-v3-0-2b631ff319ca@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jai Luthra,

On Tue, 03 Oct 2023 14:41:29 +0530, Jai Luthra wrote:
> This patch series adds support for audio via headphone jack on
> SK-AM62A-LP. The jack is wired to TLV320AIC3106 (codec), which is
> connected to McASP1 (serializer) on the SoC.
> 
> The TRRS 3.5mm jack can be used for simultaneous playback and recording.
> 
> 
> [...]

I have applied the following to branch ti-k3-config-next on [1].
Thank you!

[6/6] arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A
      commit: f9010eb938beb9a58c640b50d2fe65e4187c1fde

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh

