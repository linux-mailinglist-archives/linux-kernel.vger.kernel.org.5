Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE437C480C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344905AbjJKC7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343612AbjJKC7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:59:21 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581F492;
        Tue, 10 Oct 2023 19:59:19 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39B2xE0G031018;
        Tue, 10 Oct 2023 21:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696993154;
        bh=EP1YvOVaGbO3RTerwTA6049JxbPAS+eZUO4pwPmaX8I=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=P+ay8nu6K2bSbQDPwDWpHtxqviEW4EIaDxmL8hb55xlkqqICftXNicQEDhL2QZIUv
         gwC4jNClxgNmu/I8RU075dFzRaY0KpWb/wdI3kLL5qxBMlr/dChOi4LAQBXJK7HAA0
         0NqOea95j1BHPOqUPhlMD0b0yK2+DVQTm4RFj1OE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39B2xEZf024974
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Oct 2023 21:59:14 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Oct 2023 21:59:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Oct 2023 21:59:14 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39B2xDM8123858;
        Tue, 10 Oct 2023 21:59:13 -0500
Date:   Wed, 11 Oct 2023 08:29:13 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Bryan Brattlof <bb@ti.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vibhore Vardhan <vibhore@ti.com>,
        ARM Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] cpufreq: ti-cpufreq: Enable AM62P5 CPUFreq
Message-ID: <20231011025913.aadng3zuq6mpwjel@dhruva>
References: <20231010175524.558577-4-bb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231010175524.558577-4-bb@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Oct 10, 2023 at 12:55:25 -0500, Bryan Brattlof wrote:
> Hello everyone!
> 
> This short series adds the am62p5 compatible to ti-cpufreq and
> cpufreq-dt-platdev for the new am62p family of TI SoCs. It uses the same
> A53s and efuse configuration as the rest of the am62xxx extended family
> so we're just using the same am625 data structure for the am62p5.
> 
> Thanks for reviewing
> ~Bryan
> 
> Bryan Brattlof (2):
>   cpufreq: dt-platdev: add am62p5 to blocklist
>   cpufreq: ti-cpufreq: Add opp support for am62p5 SoCs
> 
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  drivers/cpufreq/ti-cpufreq.c         | 1 +
>  2 files changed, 2 insertions(+)

For the series,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

> 
> 
> base-commit: c9727271cb239dce91add464364f10fb2b376456
> -- 
> 2.42.0
> 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
