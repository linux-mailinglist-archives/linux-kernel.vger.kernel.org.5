Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB70D7A1E87
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjIOMWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjIOMWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:22:07 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945CD2130
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:21:55 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38FCLpWs055642;
        Fri, 15 Sep 2023 07:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694780511;
        bh=IOAJDPT+N9VVQXgG1jJcdvhNb7KodbGCZ/WAu7dmHe4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ZmK6ndt1ombHsXGf0RB2mVoscpoO7xEP5kATJzWyXMB8PTjh5oP1sut9Cup7mxPQ7
         QqxC6pfJvrxu05xGIYDWj3owLOSkJtwfaatavbqSDG1S3pMHWCXjiNiUAdMTVKppyT
         NA95TwPWlPYrRzascTCEdEqvpOxmrg+sE6x+eJKE=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38FCLpSZ086625
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Sep 2023 07:21:51 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Sep 2023 07:21:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Sep 2023 07:21:50 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38FCLoWE028304;
        Fri, 15 Sep 2023 07:21:50 -0500
Date:   Fri, 15 Sep 2023 07:21:50 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Neha Malcom Francis <n-francis@ti.com>
CC:     <ssantosh@kernel.org>, <t-konduru@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH v2 2/2] soc: ti k3-socinfo: Fix typo
Message-ID: <20230915122150.wlwzk4uen63ytlcq@kissing>
References: <20230915064650.2287638-1-n-francis@ti.com>
 <20230915064650.2287638-3-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230915064650.2287638-3-n-francis@ti.com>
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

On 12:16-20230915, Neha Malcom Francis wrote:
> Fix typo in driver that comments out wrong bit.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  drivers/soc/ti/k3-socinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
> index 6de1e3531af9..417f3f33cd01 100644
> --- a/drivers/soc/ti/k3-socinfo.c
> +++ b/drivers/soc/ti/k3-socinfo.c
> @@ -20,7 +20,7 @@
>   *  31-28 VARIANT	Device variant
>   *  27-12 PARTNO	Part number
>   *  11-1  MFG		Indicates TI as manufacturer (0x17)
> - *  1			Always 1
> + *  0			Always 1
>   */
>  #define CTRLMMR_WKUP_JTAGID_VARIANT_SHIFT	(28)
>  #define CTRLMMR_WKUP_JTAGID_VARIANT_MASK	GENMASK(31, 28)
> -- 
> 2.34.1
> 

Always do basic cleanup early in your series. reverse the order of the
patches.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
