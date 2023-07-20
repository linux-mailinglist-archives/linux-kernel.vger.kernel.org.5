Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9282A75B084
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjGTNzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjGTNza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:55:30 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA57212C;
        Thu, 20 Jul 2023 06:55:27 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36KDt2rU031293;
        Thu, 20 Jul 2023 08:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689861302;
        bh=OlA7APl85CTRM4v1xEv5Mr7tHgBX2kPzkTIV6nm8RDk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=kAjy6SkecAFSXmgLBXOD3MZJkLmrPcEc9YpnW1Vd5g+Lvfv8ezSZyk+obcqiG2SiE
         YtzshLQ8t/VjtWxhC1DO7RHH69zT6Tg3unaBZfpk4NkTQ+7MvststKpt5LTpDQyLD5
         HjanjvU22uDS3TBsUOZpkcli7F0gZw4WCrIr0UA8=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36KDt2Cs010235
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Jul 2023 08:55:02 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 20
 Jul 2023 08:55:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 20 Jul 2023 08:55:01 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36KDt11M125270;
        Thu, 20 Jul 2023 08:55:01 -0500
Date:   Thu, 20 Jul 2023 08:55:01 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <sunran001@208suo.com>
CC:     <kristo@kernel.org>, <ssantosh@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH] clk: keystone: sci-clk: fix application of sizeof to
 pointer
Message-ID: <20230720135501.uxjb4oyn26ztmngv@bonelike>
References: <20230720074906.3373-1-xujianghui@cdjrlc.com>
 <3ad9c41575c274137001916c896bf2b6@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3ad9c41575c274137001916c896bf2b6@208suo.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:42-20230720, sunran001@208suo.com wrote:
> The coccinelle check report:
> ./drivers/scsi/csiostor/csio_mb.c:1554:46-52: ERROR: application of
> sizeof to pointer

-ECONFUSED -> the report does'nt match the file here. did I miss
something?
> 
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/clk/keystone/sci-clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
> index 6c1df4f11536..2c68c1e09d1f 100644
> --- a/drivers/clk/keystone/sci-clk.c
> +++ b/drivers/clk/keystone/sci-clk.c
> @@ -389,7 +389,7 @@ static struct clk_hw *sci_clk_get(struct of_phandle_args
> *clkspec, void *data)
>  	key.clk_id = clkspec->args[1];
> 
>  	clk = bsearch(&key, provider->clocks, provider->num_clocks,
> -		      sizeof(clk), _cmp_sci_clk);
> +		      sizeof(**clk), _cmp_sci_clk);
> 
>  	if (!clk)
>  		return ERR_PTR(-ENODEV);

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
