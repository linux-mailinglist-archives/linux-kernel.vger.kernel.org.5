Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17D17D0071
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346247AbjJSRYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346209AbjJSRYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:24:22 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5617C106;
        Thu, 19 Oct 2023 10:24:20 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39JHNosS111926;
        Thu, 19 Oct 2023 12:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697736230;
        bh=cnCHnIviGvR5LlFZrHE55hEYXebBD3jVoaFYztQJ+iw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=dTyUqNUE5KKIWmH92x7b0jdlT00mo2uehOZ+gXlzvHx07A7JU5/LSJCQiUcKsRgUu
         AY3V6V6gZ/rtCtwOWsG9G87CP71MckBjaXlw6PwAVuNTb+neZ6n51bzRdAxMzrBn/8
         VLO/ma3DL59zSzQyyvXLeVX7apBJKqt4MIcUAM9c=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39JHNo2l118711
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Oct 2023 12:23:50 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Oct 2023 12:23:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Oct 2023 12:23:49 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39JHNnhb043119;
        Thu, 19 Oct 2023 12:23:49 -0500
Date:   Thu, 19 Oct 2023 12:23:49 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <rogerq@ti.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <horms@kernel.org>,
        <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Thejasvi Konduru <t-konduru@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_mdio: Fix the
 revision string for J721E
Message-ID: <20231019172349.mwtxt5he222d6zrj@engraved>
References: <20231018140009.1725-1-r-gunasekaran@ti.com>
 <20231018154448.vlunpwbw67xeh4rj@unfasten>
 <4131fd06-0e46-5454-fbdb-85ccabc0e8b0@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4131fd06-0e46-5454-fbdb-85ccabc0e8b0@ti.com>
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

On 11:11-20231019, Ravi Gunasekaran wrote:
> Nishanth, Jakub,
> 
> On 10/18/23 9:14 PM, Nishanth Menon wrote:
> > 
> > We then have the following steps potentially
> > 
> > Drop the fixes and Maintain both SR2.0 and SR1.0 (add SR1.1) so that
> > we can merge the socinfo fixes without breaking bisectability.
> 
> I will drop the fixes tag then and maintain SR1.0, SR1.1, SR2.0 for J721E
> and mention in the commit msg that this is a preparatory patch to fix the
> incorrect revision string generation. And in the next cycle, I will
> send out a patch removing the invalid revision IDs.
> 
> Ideally I would prefer to do this for all the SoCs, but I would need some
> time to compile the list. So for now, I will send a v2 targeting only J721E.
> 
> Please let me know your thoughts on this.

just do the full list in one shot. it is easier that way than having to
repeat this sync over and over again.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
