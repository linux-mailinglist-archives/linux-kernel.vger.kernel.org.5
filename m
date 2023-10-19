Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8F37CEF32
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjJSFmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjJSFmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:42:08 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410931B5;
        Wed, 18 Oct 2023 22:41:31 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39J5fFtu048503;
        Thu, 19 Oct 2023 00:41:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697694075;
        bh=Vk+cRnHo6muGejtbpUC0xCLLcp+NHau3bYlkm4WogkI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=KAbuq3aOYa6iy4bTY7mQUxuZHSz5sctfiTPXo2F0dmB7KbJBpObOyMtun+QrF4Dt2
         DGLLoFkUgpv5LpNq1OLumrQe6giytJs6ApGxNwz7zUQjBEsYOPMywqNxjB/jbpaXUD
         AZa8iSrncuOoZun8+6RlhWEneCmMJPGPgrHhuFI8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39J5fFne118705
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Oct 2023 00:41:15 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Oct 2023 00:41:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Oct 2023 00:41:15 -0500
Received: from [172.24.227.83] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39J5f6SO041333;
        Thu, 19 Oct 2023 00:41:07 -0500
Message-ID: <4131fd06-0e46-5454-fbdb-85ccabc0e8b0@ti.com>
Date:   Thu, 19 Oct 2023 11:11:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_mdio: Fix the
 revision string for J721E
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, <kuba@kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <rogerq@ti.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <horms@kernel.org>, <linux-omap@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Thejasvi Konduru <t-konduru@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>
References: <20231018140009.1725-1-r-gunasekaran@ti.com>
 <20231018154448.vlunpwbw67xeh4rj@unfasten>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20231018154448.vlunpwbw67xeh4rj@unfasten>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth, Jakub,

On 10/18/23 9:14 PM, Nishanth Menon wrote:
> 
> We then have the following steps potentially
> 
> Drop the fixes and Maintain both SR2.0 and SR1.0 (add SR1.1) so that
> we can merge the socinfo fixes without breaking bisectability.

I will drop the fixes tag then and maintain SR1.0, SR1.1, SR2.0 for J721E
and mention in the commit msg that this is a preparatory patch to fix the
incorrect revision string generation. And in the next cycle, I will
send out a patch removing the invalid revision IDs.

Ideally I would prefer to do this for all the SoCs, but I would need some
time to compile the list. So for now, I will send a v2 targeting only J721E.

Please let me know your thoughts on this.

> 
> Also in the future, please CC me as the reporter and for Soc-fixes
> dependency issues (I am listed in the MAINTAINERS file).
> 
Sure.

-- 
Regards,
Ravi
