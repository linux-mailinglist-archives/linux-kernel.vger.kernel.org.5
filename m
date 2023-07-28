Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864CA767775
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 23:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjG1VMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 17:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjG1VMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 17:12:30 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2369449E;
        Fri, 28 Jul 2023 14:12:28 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36SLCHgO040036;
        Fri, 28 Jul 2023 16:12:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690578737;
        bh=A4KSrBCg00/JTvtgrv/CyVR6maJap0Me7hc/x8KElwU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=JaXc6HJnz6ZrwqnmGtaiD4CXh27xv/DxmaV9/N6uFExV0QcpqvYhg88uzrh+JiOBo
         K/MNCkaRrMN/eEWkwFYIi+Nc/YRTns+79tQZxKdPFQblC6PRwULERHA3CgNwv3Od8B
         yI7RKvB6UewWgMJzukFW+x0m5rnNv5Gpj9lg15Bc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36SLCHNh031392
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Jul 2023 16:12:17 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jul 2023 16:12:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jul 2023 16:12:17 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36SLCHue067345;
        Fri, 28 Jul 2023 16:12:17 -0500
Date:   Fri, 28 Jul 2023 16:12:17 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jayesh Choudhary <j-choudhary@ti.com>
CC:     <vigneshr@ti.com>, <s-vadapalli@ti.com>, <afd@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>, <a-bhatia1@ti.com>, <r-ravikumar@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 0/4] Add peripherals for J784S4
Message-ID: <20230728211217.mipwoira57g7dcc6@moody>
References: <20230728050859.7370-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230728050859.7370-1-j-choudhary@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:38-20230728, Jayesh Choudhary wrote:
> This series adds support for:
> - SERDES, WIZ DT nodes, Serdes lane control mux
> - DSS and DisplayPort-0 nodes
> 
> This support DEPENDS upon another series which was introduced as part
> of discussion in v5. That series[1] moves the ti-serdes headers file
> from bindings to "arch/arm64/boot/dts/ti". (That series is merged in
> linux-next tree)
> 
> Changelog v6->v7:
> - change compatible for scm_conf to 'simple-bus'
> - drop main_cpsw node due to driver dependency on [2]
> 
> Changelog v5->v6:
> - Change header file according to [1].
> - Add idle-state property in serdes_ln_ctrl node.
> - Fix dtbs_check warning due to clock-frequency property in serdes_refclk
>   node by disabling the node in main.dtsi and enabling it in board file
>   when the clock-frequency node is actually added.
> 
> Changelog v4->v5:
> - rebased the patches on linux-next tip.
> 
> Changelog v3->v4:
> - add reg property to serdes_ln_ctrl and fix the node name again to
>   get rid of dtbs_check error.
> - reorder reg, reg-names and ranges property for main_cpsw1.
> - correct the order for clocks in serdes_wiz nodes to fix dtbs_check
>   warnings.
> - fix indentation in reg, reg-names and clock property for dss node.
> - add comments for the reg type in dss registers.
> 
> Changelog v3->v2:
> - fix dtc warnings for 'scm_conf' and 'serdes_ln_ctrl' nodes
>   (Checked all the changes of the series with W=12 option during build)
> - added clock-frequency for serdes_refclk along with other EVM changes
>   This refclk is being used by all the instances of serdes_wiz which
>   are disabled by default. So configuring refclk when the serdes nodes
>   are used for the first time is okay.
> 
> Changelog v1->v2:
> - Moved J784S4 EVM changes together to the last patch
>   (Suggested by Andrew)
> 
> v5 patch link:
> <https://lore.kernel.org/all/20230721132029.123881-1-j-choudhary@ti.com/>
> 
> [1]: <https://lore.kernel.org/all/20230721125732.122421-1-j-choudhary@ti.com/>
> [2]: <https://lore.kernel.org/all/20230605154153.24025-1-afd@ti.com/>
> 
> Rahul T R (2):
>   arm64: dts: ti: k3-j784s4-main: Add DSS and DP-bridge node
>   arm64: dts: ti: k3-j784s4-evm: Enable DisplayPort-0
> 

Could you enable AM69-SK as well? is there anything stopping it being part of the series?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
