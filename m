Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285327756E8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjHIKLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjHIKLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:11:13 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5191FDF;
        Wed,  9 Aug 2023 03:11:12 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379AB3r4088696;
        Wed, 9 Aug 2023 05:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691575863;
        bh=YE4TUtWVU6h+x5owSlxhMP3LTchokS0hFcMMkG6Rf4E=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=KAbsoefyy3C6BroNHohJGttkDHKBT+qlt9Wj+Ul7NcvrBgSFOHOv15KX67ugVP/VU
         uxbLI0qxTmP3TjsMhKyzJ7+5cUVt8qnAS0OSaCqxJ4A7V+m2EbuJ7jDJal6rNNwqJy
         R3B7pmj1PZtJvA5MswBaC9KYB/FUmCrm6K+0y8WI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379AB3FZ076354
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 05:11:03 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 05:11:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 05:11:03 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379AB2WV055234;
        Wed, 9 Aug 2023 05:11:02 -0500
Date:   Wed, 9 Aug 2023 15:41:01 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     <linux-omap@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] bus: ti-sysc: Fix a build warning with W=1 for sysconfig
Message-ID: <20230809101101.7pbe7fhrlfcblcqk@dhruva>
References: <20230809095633.34025-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809095633.34025-1-tony@atomide.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 09, 2023 at 12:56:33 +0300, Tony Lindgren wrote:
> Dhruva reported a build warning with W=1 for "Function parameter or member
> 'sysconfig' not described in 'sysc'". Let's document sysconfig to fix this.
> 
> Reported-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Probably best to include a Fixes: commit no?

>  drivers/bus/ti-sysc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -109,6 +109,7 @@ static const char * const clock_names[SYSC_MAX_CLOCKS] = {
>   * @cookie: data used by legacy platform callbacks
>   * @name: name if available
>   * @revision: interconnect target module revision
> + * @sysconfig: saved sysconfig register value
>   * @reserved: target module is reserved and already in use
>   * @enabled: sysc runtime enabled status
>   * @needs_resume: runtime resume needed on resume from suspend
> -- 
> 2.41.0

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
