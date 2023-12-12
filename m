Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2E680EFF4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376657AbjLLPTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376651AbjLLPTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:19:08 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A57D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:19:14 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BCFJ8uH113351;
        Tue, 12 Dec 2023 09:19:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702394348;
        bh=yaLGJWGfWftZDx1uGZYMZ+WryggEg5xs+v0/XyGHDHk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=jFiDvYC1Uu/o9dQC6HyIfogspRcAJ7xElxnsIyN8oHDi1x852PgSD5MYX/0sE9R9K
         0ZA/ABmH+4tHNWBfGcVrCYVo2RvR8+Aj1ArjxY8SswcudI+i7ijlNWXbcf2jB8HREA
         zCqZd2FjpY5F7WYaUc67jp5+6wX23FlIntskk+sA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BCFJ8qb011548
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Dec 2023 09:19:08 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Dec 2023 09:19:08 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Dec 2023 09:19:08 -0600
Received: from [10.247.16.251] (ula0226330.dhcp.ti.com [10.247.16.251])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BCFJ7nn118671;
        Tue, 12 Dec 2023 09:19:08 -0600
Message-ID: <81f90d13-da10-4a68-a0e7-95212f40b3e8@ti.com>
Date:   Tue, 12 Dec 2023 09:19:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: ti: k3-socinfo: Add JTAG ID for J722S
Content-Language: en-US
To:     Vaishnav Achath <vaishnav.a@ti.com>, <nm@ti.com>,
        <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <vigneshr@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>
References: <20231211132600.25289-1-vaishnav.a@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20231211132600.25289-1-vaishnav.a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 7:26 AM, Vaishnav Achath wrote:
> Add JTAG ID info for the J722S SoC family to enable SoC detection.
> 
> More details about this SoC can be found in the TRM:
> 	https://www.ti.com/lit/zip/sprujb3
> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---

Simple enough,

Reviewed-by: Andrew Davis <afd@ti.com>

Although I do question our use of the J7x names. All of our parts here
also have a "Sitara AMxx" branding. For instance here we could call
this new device by its "AM67" name, then J784S4 renamed as AM69, etc.
Then we would have a consistent naming (internally we will have to deal
with the part name madness, but why expose that externally if we don't
have to).

Andrew

> 
> Bootlog with changes:
> https://gist.github.com/vaishnavachath/23d859925277df9ccd628190e7c23371
> 
>   drivers/soc/ti/k3-socinfo.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
> index 7517a9c8c8fa..59101bf7cf23 100644
> --- a/drivers/soc/ti/k3-socinfo.c
> +++ b/drivers/soc/ti/k3-socinfo.c
> @@ -42,6 +42,7 @@
>   #define JTAG_ID_PARTNO_J784S4		0xBB80
>   #define JTAG_ID_PARTNO_AM62AX		0xBB8D
>   #define JTAG_ID_PARTNO_AM62PX		0xBB9D
> +#define JTAG_ID_PARTNO_J722S		0xBBA0
>   
>   static const struct k3_soc_id {
>   	unsigned int id;
> @@ -56,6 +57,7 @@ static const struct k3_soc_id {
>   	{ JTAG_ID_PARTNO_J784S4, "J784S4" },
>   	{ JTAG_ID_PARTNO_AM62AX, "AM62AX" },
>   	{ JTAG_ID_PARTNO_AM62PX, "AM62PX" },
> +	{ JTAG_ID_PARTNO_J722S, "J722S" },
>   };
>   
>   static const char * const j721e_rev_string_map[] = {
