Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC04877236B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjHGMHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjHGMHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:07:41 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9438106;
        Mon,  7 Aug 2023 05:07:40 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377C7LQc068043;
        Mon, 7 Aug 2023 07:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691410041;
        bh=WEyFU/jxpVUNwOc97gBnubORBV+Y0SIaGA1ypBvIFPE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=UQ2ak3c+wON0sLYo6MO8CGiUx+hFqgio87Maea7bcN9RmEGxEzxokSJAlNV7kAJ68
         ZyeJyRpJ6I8+qjyOtvOVpP3hUy4yEKkzC7PBpnAcnYc9kEgGIp6Y/ABQ37NDRfW5B+
         6po1WBbMcCphMUi3m4O48+fDiWIfb3qAu0vrf5uo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377C7LSe123866
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 07:07:21 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 07:07:20 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 07:07:20 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377C7Kef020948;
        Mon, 7 Aug 2023 07:07:20 -0500
Date:   Mon, 7 Aug 2023 07:07:20 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     Devarsh Thakkar <devarsht@ti.com>, <afd@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <a-bhatia1@ti.com>, <j-luthra@ti.com>, <praneeth@ti.com>,
        <j-choudhary@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62x-sk-common: Reserve 128MiB of
 global CMA
Message-ID: <20230807120720.ibqxqoqifndafls6@judge>
References: <20230803111455.811339-1-devarsht@ti.com>
 <20230805193355.o657pwbq2w3tciui@vehicular>
 <ZNCNi9k2bKwbXh81@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZNCNi9k2bKwbXh81@francesco-nb.int.toradex.com>
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

On 08:46-20230807, Francesco Dolcini wrote:
> On Sat, Aug 05, 2023 at 02:33:55PM -0500, Nishanth Menon wrote:
> > I am esp concerned since there are platforms based on am62x and just
> > 256MB DDR.
> 
> On that regard, currently you have reserved memory areas just before
> 512MB DDR limit. Any plan to move those?

Nope. Common min configuration we have seen is 512MB (why TI evms use
that definition). There are exceptional cases of 256MB boards, but in
such cases, the board dts should describe it.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
