Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69397AA6E3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 04:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjIVCHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 22:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjIVCHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 22:07:42 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32D5FB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 19:07:31 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38L9Oeb1077614;
        Thu, 21 Sep 2023 04:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695288280;
        bh=MUwXDYz2cWzUkvwPbWERLahEL6Elz113MVEeHAmQcSY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=APhnjvlDfwJfYwXeOjfyvuaCAsH+TcmqXxNZ7OiAon9kS8AXhy0fpzTJJJWWxlE4f
         NxzUVEWw7Te4QRudySMQ6VUHIro9j9g/zkWTmiY7mBlCyNqz8fUcGEYo1gCeedV6+i
         UGLXD1LPAuLGD67dbQbOldDrqNXiTTsbgJ8FlYKE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38L9OeAG113069
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Sep 2023 04:24:40 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Sep 2023 04:24:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Sep 2023 04:24:39 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38L9OcBW028727;
        Thu, 21 Sep 2023 04:24:39 -0500
Date:   Thu, 21 Sep 2023 14:54:38 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u.kleine-koenig@pengutronix.de>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <vibhore@ti.com>
Subject: Re: [PATCH] firmware: ti_sci: Mark driver as non removable
Message-ID: <20230921092438.mnpvyjsa4qe7bkhk@dhruva>
References: <20230907171700.1922453-1-d-gole@ti.com>
 <20230920125904.omqvmzr2xlxqcouu@bonfire>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230920125904.omqvmzr2xlxqcouu@bonfire>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 20, 2023 at 07:59:04 -0500, Nishanth Menon wrote:
> On 22:47-20230907, Dhruva Gole wrote:
> > The TI-SCI message protocol provides a way to communicate between
> > various compute processors with a central system controller entity. It
> > provides the fundamental device management capability and clock control
> > in the SOCs that it's used in.
> > 
> > Ensure that the driver isn't unbound by suppressing its bind and unbind
> > sysfs attributes. As the driver is built-in there is no way to remove
> > device once bound.
> > 
> > We can also remove the ti_sci_remove call along with the
> > ti_sci_debugfs_destroy as there are no callers for it any longer.
> > 
> > Fixes: aa276781a64a ("firmware: Add basic support for TI System Control Interface (TI-SCI) protocol")
> > Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> 
> Add Reported-by and Closes tags
> 
> Also please address the comment from Uwe on improving the commit message

Sent V2 patch here:
https://lore.kernel.org/all/20230921091025.133130-1-d-gole@ti.com/T/#u

> 
> [...]
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
