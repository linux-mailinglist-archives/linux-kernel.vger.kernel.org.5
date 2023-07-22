Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11A175DE7F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 22:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjGVUY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 16:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGVUYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 16:24:25 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2121.outbound.protection.outlook.com [40.107.100.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BEFE53;
        Sat, 22 Jul 2023 13:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rs0DxD4ZhD/DAx+9N9a/0iN2s50sTFunGzrA+monZEiMM/AxCArxOrN3E421li1z0So0Ofsud90/ItYmA6ljP3Tv6hn4ZIoRk9F5gXQD+0rVO8oYGGSCgJQwLHkLy+mcHFoA45s+/po2ANcI1m2r3819wMHRgYAj95gjehpYv0idcjBMshtYx6/DosnLHLsb+BnVjtMr4zOkuotubOLf9A7gdGrEfYHOVE9JFhoi/kYLDqL3l28m3FWBNeKg6YPN3w7N5iHK0Lbep8nA+UgawKQAVH9iup2fMRd/tqh+cdPV9y7NmOVgLVRo+cRHhWZWTbjsIdkDc5EjcfwolCxFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdnXSPKymYJBSOaixCa9Qcfv71Z2eZMoQGKPdomLNp0=;
 b=IbIfhXJeRxJRt3xy0F/714HfYMdXFj0GbCpBYGxI9bc4UHP3P7srmqLVaqraRDdakRsFMA7MPJMEnCzZn487elva5IFffcjJwr5NsmxQ4d8IQkYANdb7dEXGiZw+Qzh7HQv/Ovcextm1WAvEMlL2pwes23PuI6BxvLfMMYHwZ/a6L4++5HrSjE33XL2vjeEgTnscWME+aatU1C58QrGfr9Jk6qzz9xR6egu5z/Fzc6aIjdy6fzgfkvcRtp1AJgXIa/5tOwDL7kVcetBO+R6VmLgRbcPPRv6IKF36cNYNrHW67tGUxIyqNk5yXujJe5qhuas+KORdyv9RM5D13JybZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdnXSPKymYJBSOaixCa9Qcfv71Z2eZMoQGKPdomLNp0=;
 b=L+20JhwLHQlhR0c9lFbIx2QIW2EFT9aFNqw7+HqqcRwxBr83WQzNzy+L8KNcq7vHizZaHO9hESTjeEnSn+1fW3Z/teIZv8mjs+m2o/Z4Rph3LUYVRHPyAynfC8N5gKbGRNTrMH2UXDYQSQ/5ec+9Q0cn+QXWYclv3udsLpXP53U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY5PR13MB3730.namprd13.prod.outlook.com (2603:10b6:a03:225::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sat, 22 Jul
 2023 20:24:20 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.029; Sat, 22 Jul 2023
 20:24:20 +0000
Date:   Sat, 22 Jul 2023 21:24:13 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, bryan.whitehead@microchip.com,
        andrew@lunn.ch, linux@armlinux.org.uk, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 1/7] net: lan743x: Create separate PCS power
 reset function
Message-ID: <ZLw67dun2790l+9D@corigine.com>
References: <20230721060019.2737-1-Raju.Lakkaraju@microchip.com>
 <20230721060019.2737-2-Raju.Lakkaraju@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721060019.2737-2-Raju.Lakkaraju@microchip.com>
X-ClientProxiedBy: LO4P123CA0619.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::19) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY5PR13MB3730:EE_
X-MS-Office365-Filtering-Correlation-Id: 9200fa93-c6eb-433c-f533-08db8af1a16a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uhQf/s99tiBUSOclvkI2/nelJxbHFlUYXNVbH864Cl5RrwVMxncmaCdDnAOm7OXFHZucNVQK1Oiogy6s5gfWNZM7fcRqfcNP3IRpK5NFUWAsb5lr1qTkIUyrqc8+5XNhkeCzvhFHEg1/Z/1XuyjrE9FAii+dyjTePg6uaYQqzEGOC/bcox7jCYWR//oW4c9UK01lhsbfppwr7FHx28rwFjeNfobT2QAlcQTjXpNL7zg+AJE+AyFbFNZJiVufyyocwBcJeloHbdTbxHNfbgN/cBiVVlKKRKP63y0DoFJioekAqd9K4NIJNU6UlDAf2sDWAig3vUDJUFSbmRyg5xqIS6R+55IPe5i7owU3qJ0xgrv/w2ww7e09AJwbYQhO6t+KT1D1MhHD1F35br2h1POcSJED9Kv5pY7XkS0MmRuDC3ORGcvpg5YZY7PaX8VCVFsGzs3PQR7oFMG8rUl09zN7GSgSDh37+9b9KRMsdG6EmwpOdeCzbxCdKfLwyFN8ZXDCO5yqN5TRx9ERFLje1JOdnL704t6XmmNojqCWhDzJ/oDLGYSwBozoYEbCqojNddCw4keD/QYJJwaxkkYThAT0g+uROcdhySogW51m3m0ma8yyEt/anv8oJnScgaV9C/ko4NDq9QX1GE+PBO108VfFEkbEBEoiOEn/vBKZW8dSD0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39830400003)(396003)(376002)(346002)(136003)(366004)(451199021)(6666004)(6486002)(6512007)(478600001)(55236004)(186003)(2616005)(6506007)(26005)(2906002)(44832011)(316002)(41300700001)(66946007)(66556008)(66476007)(6916009)(4326008)(5660300002)(8676002)(8936002)(38100700002)(36756003)(86362001)(83380400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DwJc0U7O/9qukU5oGOZngzKTMJCFUl1lR1M+rI7uvi2gI7y6hxK7nrGdr5hX?=
 =?us-ascii?Q?Hlg5RF8lVzkgTXZ9Vrka/i695OVA8h6wBrbu1E94AK9m5BhLxWk98VpDP3G3?=
 =?us-ascii?Q?9WGNfh6xXaiyt0HC8CT9KVETEjet9nd2Myx36XacCbtrXsl11kFHCJ4bDDGb?=
 =?us-ascii?Q?Tkx0M25e0WNHvLNdoiyXSJYPWtlpWQwFUgLbfFj11F6hdDxYeQP2JCcnHYmI?=
 =?us-ascii?Q?/wZe6nYEv9H05ouIWLwIpJMHkeiPpOjpxptGdi7ewRodvOTwtGeoTxEr4rLi?=
 =?us-ascii?Q?mzgLTiIECMXJ0pifAFrZDdGYSTUL8d1rMI7hzi4oMLfUkkObmKDKOKRmbZRK?=
 =?us-ascii?Q?FvGe8sYNOk/LoTw1fTPj+Cd6AqmGM0sFOQN8xnQiDci0lWg4rsVW0xBECAv6?=
 =?us-ascii?Q?9YMHKFxaWpqegH+P/v/HQYSjq5ZGny70hUFHUNjPc3obDwJFSVBOS43VpkRU?=
 =?us-ascii?Q?Ry1eyT157KaRwSGF5hQ2MbTxMYmiPq2CnRKFr24sPFXunrUeqUXnAJMOWd6A?=
 =?us-ascii?Q?G1FqP4Kx9syAEM+l0qLcuDHSWNApXCl2U5KBmyQqU2ZkHuvfpSvgvp5pA+Xw?=
 =?us-ascii?Q?9q8CPSAvAH87JlCdpdqv7oLWyoKOH6VFpACt+6ZKDaUKydnCIQEm0r4p79qW?=
 =?us-ascii?Q?wcP9ANBpF30OpJ2C3qAlyrxpR3x1DMRIAZa+YXe80ErS3EIN49AKOUgkwpbg?=
 =?us-ascii?Q?cigFo+TvELl7VrWvRLnVTk6cAHQAiJaHOofsOb+GJPpufIGNbVZqUar0lOI0?=
 =?us-ascii?Q?D4yWMFgde1lbV04zk+7cJeYCDYlbJQrzotiU6OmxGnaQ2JxI32Hh9IJcSNoA?=
 =?us-ascii?Q?Kr/YhnD8MVDOodgEgDIdI5DvGHSTgzUnT9SavtUB7xlEoQOVAG+wBtXUqVjs?=
 =?us-ascii?Q?r6uVy3U4LaC39eVEEdbaURnf87MtZVABMiqBdSqXL//GFfszoHEd608dayAa?=
 =?us-ascii?Q?J96sxMifZ/5sOPSsd0vG0uncWNAQDDVdcrb1sAD8ni42DX/HDNblOosnINLn?=
 =?us-ascii?Q?mW6KX2+RC/Kh8WYnhLEUlPlY4Vnk5zelzaaC9QkE6kJo8nYSv8Xa+TcFkZJM?=
 =?us-ascii?Q?Ug+80pJZC59JBGcycwyM8wPlQhdTVLd+qxmlYt+jwqsLlZuT9DZpmOiUDlNe?=
 =?us-ascii?Q?ve1b/IeBFsuO1n8BCcakuJvVkMsqdF9KJPmJjHSJWnJ0XAf0kTFbtBmm1uNX?=
 =?us-ascii?Q?SOFTm6iCLH5PIDBcvpG9W4O6r360YSfGa2vwxykx5UyUAtzNaDbSmkXx3nNv?=
 =?us-ascii?Q?9UIYt9vrajpJOnDNthhR9La1n8lhQEZzNpNBGgC57b/guyjp5L70aQRShw93?=
 =?us-ascii?Q?r0sZDrVYJJF0l1ZYmw6cF/tcrY2muDfHEIIkCm+OxBoCYLeloqKVqZdM3AZ4?=
 =?us-ascii?Q?7tGdzEZUPrNDT0TswLky9yTXOmlmC0bSPqaN5IKXI0RG9yWHN4G3QpJbBFOi?=
 =?us-ascii?Q?BDW8ECBdeBfOjokewh9b+59ALTKGK+XH5tHxzz8j0W55ptmjYw58/LVq5HKj?=
 =?us-ascii?Q?BGpX7BD1EzsfuPxMed4Q5kEd2rnGuN0/slzU8HX1nVoTpy1CrjhnhD56EsjP?=
 =?us-ascii?Q?QUU+AgCQktZGau9llq28VrCwkNHmeVOkUA0lONZ+8ZIAnu7Z/8caqk6Ltd0I?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9200fa93-c6eb-433c-f533-08db8af1a16a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 20:24:20.5319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnwReROnbqZ/uX58EEoAUnGxs+HavYeFrg6f/vs6h2n2sMy7fT7svS6TgsGamQGTBgrteaI6XckHRXOpwI9x+tQasc5sS3JazZ3Vh/8LAoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3730
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 11:30:13AM +0530, Raju Lakkaraju wrote:
> Create separate PCS power reset function from lan743x_sgmii_config () to use
> as subroutine.
> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 54 ++++++++++---------
>  1 file changed, 29 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index a36f6369f132..dba5576a933b 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c

...

>  static int lan743x_sgmii_config(struct lan743x_adapter *adapter)
>  {
>  	struct net_device *netdev = adapter->netdev;
> @@ -1207,31 +1235,7 @@ static int lan743x_sgmii_config(struct lan743x_adapter *adapter)
>  		netif_dbg(adapter, drv, adapter->netdev,
>  			  "SGMII 1G mode enable\n");
>  
> -	/* SGMII/1000/2500BASE-X PCS power down */
> -	mii_ctl = lan743x_sgmii_read(adapter, MDIO_MMD_VEND2, MII_BMCR);
> -	if (mii_ctl < 0)
> -		return mii_ctl;
> -
> -	mii_ctl |= BMCR_PDOWN;
> -	ret = lan743x_sgmii_write(adapter, MDIO_MMD_VEND2, MII_BMCR, mii_ctl);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = lan743x_pcs_seq_state(adapter, PCS_POWER_STATE_DOWN);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* SGMII/1000/2500BASE-X PCS power up */
> -	mii_ctl &= ~BMCR_PDOWN;
> -	ret = lan743x_sgmii_write(adapter, MDIO_MMD_VEND2, MII_BMCR, mii_ctl);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = lan743x_pcs_seq_state(adapter, PCS_POWER_STATE_UP);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> +	return lan743x_pcs_power_reset(adapter);

Hi Raju,

It appears that the local variable mii_ctl is now unused
in lan743x_sgmii_config() and can be removed.

>  }
>  
>  static void lan743x_mac_set_address(struct lan743x_adapter *adapter,
> -- 
> 2.25.1
> 
> 
