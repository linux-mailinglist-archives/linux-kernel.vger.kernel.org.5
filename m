Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209C97B6730
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjJCLGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239970AbjJCLCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:02:32 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F383A1;
        Tue,  3 Oct 2023 04:02:28 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 393B2GcH060400;
        Tue, 3 Oct 2023 06:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696330936;
        bh=raw3tCBPrnpOrsrWoBthnA8+3QJ0RP3wwMv7Rsz3LTQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fdH2aAt9Betc0dWEEjKcSDebRKcT+jDChiEjLl8u2gBDOxq4Fhyc7VZl8A3Zz4et9
         GKtj8EXiyp6eL5c9cIMT/thsxw39lY75lZnWWJduY+UoOOGsE1OyJi38QIDIJYVaCH
         WUIsUrC74xIt7W50WsacaxP1YclysqlYriGorWdk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 393B2GhQ001009
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Oct 2023 06:02:16 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 06:02:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 06:02:16 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 393B1Dvh129223;
        Tue, 3 Oct 2023 06:02:12 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        Marcel Ziswiler <marcel@ziswiler.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v1] arm64: dts: ti: verdin-am62: add iw416 based bluetooth
Date:   Tue, 3 Oct 2023 16:30:44 +0530
Message-ID: <169633065051.2221719.16912358644929011874.b4-ty@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230901133233.105546-1-marcel@ziswiler.com>
References: <20230901133233.105546-1-marcel@ziswiler.com>
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

Hi Marcel Ziswiler,

On Fri, 01 Sep 2023 15:32:32 +0200, Marcel Ziswiler wrote:
> Add NXP IW416 based u-blox MAYA-W1 Bluetooth (using btnxpuart) as used
> on the V1.1 SoMs. Wi-Fi is and was already using mwifiex.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: verdin-am62: add iw416 based bluetooth
      commit: 7c3bc1952dd2b02983c06632b2d342823e9d6b96

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

