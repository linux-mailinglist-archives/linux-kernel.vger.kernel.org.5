Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B57875FE9C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjGXR5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjGXR5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:57:16 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC65C2704;
        Mon, 24 Jul 2023 10:55:24 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36OHtFcl039167;
        Mon, 24 Jul 2023 12:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690221315;
        bh=EWXlEGe/iBz52K7yybNE49DXQXCV/FhW60XiUI5ZqBI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=hxMpBBstpBW4KxY/u3KdZirENgRYF7oWPjDoOo4smAKqu+8vXgkN4FiQo8qUCi8qY
         SsD1bxcjEPuAAdZvf96kuiSZz0V7+ibwxX5OedVt4JKoGpZNXL6MFrIzzwUDCZkb/q
         Wz1xZL1Q9q8dTKfkPkNRxD672flBmEA5Z3zKe5w8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36OHtFYu011384
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jul 2023 12:55:15 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jul 2023 12:55:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jul 2023 12:55:14 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36OHtEuR047107;
        Mon, 24 Jul 2023 12:55:14 -0500
Date:   Mon, 24 Jul 2023 12:55:14 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Bhavya Kapoor <b-kapoor@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH v5] arm64: dts: ti: k3-j721s2: Add support for CAN
 instances 3 and 5 in main domain
Message-ID: <20230724175514.lhkrag7fnsscnqhy@porridge>
References: <20230724111751.86422-1-b-kapoor@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230724111751.86422-1-b-kapoor@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:47-20230724, Bhavya Kapoor wrote:
> +	main_mcan3_pins_default: main-mcan3-pins-default {

Could you make sure that the node names matches up with the json-schema
conversion:
https://lore.kernel.org/all/169021456020.3622493.10284534202541859578.robh@kernel.org/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
