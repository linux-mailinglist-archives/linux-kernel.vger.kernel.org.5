Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D120B80F160
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377142AbjLLPmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377023AbjLLPmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:42:43 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B669399
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:42:48 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BCFgcRw067464;
        Tue, 12 Dec 2023 09:42:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702395758;
        bh=oiaGrJT/8zfeb0gqR7XnThtks9GFZc2BdQCzsJ3Wr7I=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=UHCEy22plw5/YJbYehV6UwxE/rWsdkG/XMmsJ9EFR0RANk3j0QOvfMt/yN33N7eoZ
         fF1bSm/BRm991U7jMln4ymfhkpOA+L46N7cp0gaIhJ46PiaIpS5sDjK0yiIQZEfM8x
         tYH9GXKZJmZXZq40ZGoMOTxauFUZqF8hL67VrV6s=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BCFgc0w128942
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Dec 2023 09:42:38 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Dec 2023 09:42:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Dec 2023 09:42:38 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
        by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BCFgc2B069091;
        Tue, 12 Dec 2023 09:42:38 -0600
Date:   Tue, 12 Dec 2023 09:42:38 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Vaishnav Achath <vaishnav.a@ti.com>, <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <u-kumar1@ti.com>, <j-choudhary@ti.com>
Subject: Re: [PATCH] soc: ti: k3-socinfo: Add JTAG ID for J722S
Message-ID: <20231212154238.3sn5fxpestaqacrc@defog>
References: <20231211132600.25289-1-vaishnav.a@ti.com>
 <81f90d13-da10-4a68-a0e7-95212f40b3e8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <81f90d13-da10-4a68-a0e7-95212f40b3e8@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:19-20231212, Andrew Davis wrote:
> On 12/11/23 7:26 AM, Vaishnav Achath wrote:
> > Add JTAG ID info for the J722S SoC family to enable SoC detection.
> > 
> > More details about this SoC can be found in the TRM:
> > 	https://www.ti.com/lit/zip/sprujb3
> > 
> > Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> > ---
> 
> Simple enough,
> 
> Reviewed-by: Andrew Davis <afd@ti.com>
> 
> Although I do question our use of the J7x names. All of our parts here
> also have a "Sitara AMxx" branding. For instance here we could call
> this new device by its "AM67" name, then J784S4 renamed as AM69, etc.
> Then we would have a consistent naming (internally we will have to deal
> with the part name madness, but why expose that externally if we don't
> have to).

J722S is a new die and the core part, what rebranding/spins happens to it is
subject to mktg group, not going to hold this series with that.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
