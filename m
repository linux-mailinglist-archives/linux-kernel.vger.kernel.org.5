Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB6B76C3A7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 05:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjHBDnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 23:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjHBDnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 23:43:43 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFFE19B9;
        Tue,  1 Aug 2023 20:43:42 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3723hQm3013639;
        Tue, 1 Aug 2023 22:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690947806;
        bh=PClbH2WvUQlq5UCADbo8NSKX+N+t8MTTyl77I2SqKIg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=TeEVgYkkkR84FLQzz7kdRYhQP9eKx+ADV4R3DffNcGaBg2b+gXWw/jYou/SuTUh0q
         FjwDkMyLm6bidys8fc9jY+sRTuV4SdCeoDhDdBIk6oh6RiJ4XlZiD0jIBVlq84JLf/
         0deqKyI1StiGzLhvjox+Z3jV00oOqyU5t4Tyarj0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3723hPs5087009
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Aug 2023 22:43:25 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Aug 2023 22:43:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Aug 2023 22:43:25 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3723hPD8048327;
        Tue, 1 Aug 2023 22:43:25 -0500
Date:   Tue, 1 Aug 2023 22:43:25 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hiago De Franco <hiago.franco@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 2/2] arm64: dts: ti: k3-am625-verdin: enable CAN_2
Message-ID: <20230802034325.puqhry4xocaceldl@clothes>
References: <20230724133612.37366-1-francesco@dolcini.it>
 <20230724133612.37366-3-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230724133612.37366-3-francesco@dolcini.it>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:36-20230724, Francesco Dolcini wrote:
[...]

> +	/* Verdin CAN_2 */
> +	pinctrl_mcu_mcan0: mcu-mcan0-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_MCU_IOPAD(0x0038, PIN_INPUT,  0) /* (B3) MCU_MCAN0_RX */ /* SODIMM 26 */
> +			AM62X_MCU_IOPAD(0x0034, PIN_OUTPUT, 0) /* (D6) MCU_MCAN0_TX */ /* SODIMM 24 */

This is minor - I realize we already accepted this, but:
/* (B3) MCU_MCAN0_RX */ /* SODIMM 26 */
Vs
/* (B3) MCU_MCAN0_RX - SODIMM 26 */

I wonder if you'd like the second style.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
