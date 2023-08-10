Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0527780CC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbjHJSxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbjHJSxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:53:09 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8BA26A6;
        Thu, 10 Aug 2023 11:53:08 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AIqxpF123498;
        Thu, 10 Aug 2023 13:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691693579;
        bh=PxIju7nqSYR1j3aXbnpOvUXf2jT/IXzCazfQ59vbJFQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=PUwUS1LCKgiyj2JwFmcHa/8n1oK0yg6H4vhopxGUtv7aUdznd8bccCAFsubAnSSIW
         Ultci9bGBu138enCwmreKQjXSc3x/HU3YFY+pZgJA/ryXOcf7RcYU4P2ITFwjwgVp1
         JefZURU9moQFLDzmaZ+yPPtQA68lyCNVkL34R/HM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AIqxl7061309
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 13:52:59 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 13:52:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 13:52:59 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AIqxls014760;
        Thu, 10 Aug 2023 13:52:59 -0500
Date:   Thu, 10 Aug 2023 13:52:59 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar <u-kumar1@ti.com>, Hari Nagalla <hnagalla@ti.com>,
        Dasnavis Sabiya <sabiya.d@mistralsolutions.com>
Subject: Re: [PATCH v3 0/3] arm64: dts: ti: k3-j784s4: Add bootph-all property
Message-ID: <20230810185259.fglq6co2wrnbl663@unworldly>
References: <20230810184302.3097829-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230810184302.3097829-1-a-nandan@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 00:12-20230811, Apurva Nandan wrote:
> bootph-all phase tag was added to dt-schema (dtschema/schemas/bootph.yaml)
> to overcome u-boot dts challenges.
> 
> Add bootph-all property for all the nodes that are used in the SPL stage
> along with later boot stages.
> 
> This series will be ported to the u-boot k3-j784s4 support patch series
> for syncing, and was requested in its review process:
> https://lore.kernel.org/u-boot/20230321155227.GV8135@bill-the-cat/
> 
> v3: Changelog:
> 1) Changed all the bootph-pre-ram to bootph-all, as only
>    secure_proxy_mcu and secure_proxy_sa3 are exclusively used by R5 SPL.
>    Rest of the nodes are also used by later boot stages.
> 2) Merged SoC dtsi changes in single patch.
> 3) Moved cbass_main and cbass_mcu_wkup bootph-all to k3-j784s4.dtsi
[...]

> Apurva Nandan (3):
>   arm64: dts: ti: k3-j784s4: Add bootph-all property
>   arm64: dts: ti: k3-j784s4-evm: Add bootph-all property
>   arm64: dts: ti: k3-am69-sk: Add bootph-all property


Follow https://lore.kernel.org/all/48b554aef75d11e6ad2ef7d21f22accb35432112.1683034376.git.michal.simek@amd.com/
for example of proper commit message and subject line.

The patch content actually is easy to read since it is adding
bootph-all property - but we do have a few exceptions. Commit message
should explain the rational of the choices made. For example, you
probably need to use secure_proxy_sa3 to talk with tifs in-order to
boot and that is a pre-ram property and so on..

So, nice refresh in the right direction, but a bit more work to do.
Thanks for handling am69-sk :)..

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
