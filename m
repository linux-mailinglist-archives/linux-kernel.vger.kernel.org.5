Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3F77C855C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjJMMHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJMMHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:07:30 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219A0BF;
        Fri, 13 Oct 2023 05:07:28 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39DC7F37120006;
        Fri, 13 Oct 2023 07:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697198835;
        bh=H8IpGNSbHI4Wz1uykOIC0c3nTSxdr45koKX3rZZk10o=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=c1tJB0jOjtEXJ310KzB5oK5pccN9VF0P7E6NSoU5v4uMmFW3ON0rQ7SDbQ5kWDHcR
         ye+5dKE+E2Dhwu7+nBx6rsIoAsxxKH5YMLqV5aiKOlc1/JgCRD2UQg1oxOYWLf9evQ
         hHcimY6qUNaoi3T5uYGTbF/MRsGWvUf6e2tQq5eU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39DC7FMS011193
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Oct 2023 07:07:15 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Oct 2023 07:07:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Oct 2023 07:07:15 -0500
Received: from [10.249.130.150] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39DC793w072061;
        Fri, 13 Oct 2023 07:07:10 -0500
Message-ID: <895a550c-92be-0718-66cd-18e4c61d9a48@ti.com>
Date:   Fri, 13 Oct 2023 17:37:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix r30 CMDs bitmasks
To:     MD Danish Anwar <danishanwar@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <horms@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20231013111758.213769-1-danishanwar@ti.com>
Content-Language: en-US
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20231013111758.213769-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2023 4:47 PM, MD Danish Anwar wrote:
> The bitmask for EMAC_PORT_DISABLE and EMAC_PORT_FORWARD has been changed
> in the latest ICSSG firmware.

Please mention the version/tag of the ICSSG firmware.

>
> The current bitmasks are wrong and as a result EMAC_PORT_DISABLE and
> EMAC_PORT_FORWARD commands do not work.
> Update r30 commands to use the same bitmask as used by the latest ICSSG
> firmware.
>
> Fixes: e9b4ece7d74b ("net: ti: icssg-prueth: Add Firmware config and classification APIs.")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_config.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
> index 933b84666574..b272361e378f 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
> @@ -379,9 +379,9 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
>  
>  /* Bitmask for ICSSG r30 commands */
>  static const struct icssg_r30_cmd emac_r32_bitmask[] = {
> -	{{0xffff0004, 0xffff0100, 0xffff0100, EMAC_NONE}},	/* EMAC_PORT_DISABLE */
> +	{{0xffff0004, 0xffff0100, 0xffff0004, EMAC_NONE}},	/* EMAC_PORT_DISABLE */
>  	{{0xfffb0040, 0xfeff0200, 0xfeff0200, EMAC_NONE}},	/* EMAC_PORT_BLOCK */
> -	{{0xffbb0000, 0xfcff0000, 0xdcff0000, EMAC_NONE}},	/* EMAC_PORT_FORWARD */
> +	{{0xffbb0000, 0xfcff0000, 0xdcfb0000, EMAC_NONE}},	/* EMAC_PORT_FORWARD */
>  	{{0xffbb0000, 0xfcff0000, 0xfcff2000, EMAC_NONE}},	/* EMAC_PORT_FORWARD_WO_LEARNING */
>  	{{0xffff0001, EMAC_NONE,  EMAC_NONE, EMAC_NONE}},	/* ACCEPT ALL */
>  	{{0xfffe0002, EMAC_NONE,  EMAC_NONE, EMAC_NONE}},	/* ACCEPT TAGGED */

