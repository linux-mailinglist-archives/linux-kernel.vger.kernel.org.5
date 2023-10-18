Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E047CE5C7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjJRSBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJRSA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:00:56 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA63A1B9;
        Wed, 18 Oct 2023 11:00:53 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39II0aU5127006;
        Wed, 18 Oct 2023 13:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697652036;
        bh=YH8IQA8Foqx4OXaUGpFSL2kL5Irsm59+S3kAk/xw1sU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YLTf2AmIaWAUeT2W0+o/As3KJ08JO7HjSvwipEIAPr8f7oK/lyZctHMUrbhSOi9LY
         er2REnO9I4aMfkXfU2eE6i38r/hWCWy3qkuR3AwoXdRqplhAuZqGnTlNG9c+jZwPBi
         7ZdRlkfsifayyCYBA4g7PIdWv6YpE+baLO7dp1yA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39II0aNt089180
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Oct 2023 13:00:36 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 13:00:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 13:00:35 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39II0ZXL008590;
        Wed, 18 Oct 2023 13:00:35 -0500
Date:   Wed, 18 Oct 2023 13:00:35 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <rogerq@ti.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <horms@kernel.org>, <linux-omap@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Thejasvi Konduru <t-konduru@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_mdio: Fix the
 revision string for J721E
Message-ID: <20231018180035.saymfqwc2o3xpdf4@pretense>
References: <20231018140009.1725-1-r-gunasekaran@ti.com>
 <20231018154448.vlunpwbw67xeh4rj@unfasten>
 <20231018105236.347b2354@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231018105236.347b2354@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:52-20231018, Jakub Kicinski wrote:
> On Wed, 18 Oct 2023 10:44:48 -0500 Nishanth Menon wrote:
> > A) netdev maintainers could provide me an rc1 based immutable tag
> 
> FWIW that shouldn't be a problem, assuming my script to do so didn't
> bit rot :)
> 
> Does it really have to be rc1 or something more recent would work?

Thanks Jakub. SoC tree needs me to send based off rc1 for new features.
I'd rather not mess with that.

Sure if we are doing an fixes pull, we can figure something out to
sync. rc1 saves us the headache of conflict of me sending a PR merge
while netdev maintainers aren't expecting it to be merged to master
via soc tree.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
