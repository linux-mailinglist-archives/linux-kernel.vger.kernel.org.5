Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C6D772CB6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjHGRW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjHGRWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:22:25 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB941998;
        Mon,  7 Aug 2023 10:22:05 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377HLXSu075288;
        Mon, 7 Aug 2023 12:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691428893;
        bh=7g5ucWjAlicSpn6dGsJoOnWTxKuqa0qe20V4GTrhG3c=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=F8GMjV/qablgQbyn0Np3uOxnob0jnuBOHm9aLpCYSIp5zBZ/m9APdIPiaaiyfeuYn
         EY2QxbzM8wCWBCKUKiP7H8gcG1OmkEgx9WybZ489cNeyYB2AQO0NeTdBfzBIdGb5a/
         4TOSLRyCq87yimQG15DB/ek2wFMxd6cI2ttNweHc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377HLX1q039324
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 12:21:33 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 12:21:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 12:21:33 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377HLWnQ027250;
        Mon, 7 Aug 2023 12:21:32 -0500
Date:   Mon, 7 Aug 2023 12:21:32 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>
CC:     "Kumar, Udit" <u-kumar1@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-j784s4-mcu-wakeup: Add
 bootph-pre-ram property for SPL nodes
Message-ID: <20230807172132.7e4qux3f72zyfd33@mocker>
References: <20230806164838.18088-1-a-nandan@ti.com>
 <20230806164838.18088-3-a-nandan@ti.com>
 <3a2d1880-10aa-ac19-24e1-b2f697bc1a73@ti.com>
 <ef834d0b-b13a-5c3d-6c1d-088006fdfa32@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ef834d0b-b13a-5c3d-6c1d-088006fdfa32@ti.com>
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

On 22:43-20230807, Apurva Nandan wrote:
[..]

> > mcu_timer0: timer@40400000 should be part of your list.
> Maybe you are referring to mcu_timer1. mcu_timer1 will be a part of
> u-boot.dtsi as we need to edit
> the node for removing k3_clks and power-domains properties from it. So we
> should add bootph-pre-ram
> there itself in uboot.dtsi as the node will be already there.

a) you need the timer even before talking to anything - u-boot needs it
for basic delay - so add the pre-ram property.
b) what you are doing in u-boot currently a hack - am625 in u-boot got
it fixed the right way - follow the model then you dont need the hackery
with deleting clock and power-domains properties.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
