Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41F37AC2E3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjIWO6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjIWO6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:58:05 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2081.outbound.protection.outlook.com [40.92.75.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFEB180
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 07:57:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMuciOf56/gw1tEnCtyUJw3ubc0bfYDh861Ujz19X1jsefRINOexsHbT5yvIHrqOeg8ZnAZRm3dUA1yHr2nt+6meA0BM7gIJlNsbi4f817CiebHpXUTqsiI98D2uP6TgxjV4QckzjuT81FUI9fJxxpwVmZw3oWovjmiFBq8toFc2qibaIKtT6peOZnAsl5Bt1CzscvaMfzGDKXzU5o0CE5NZm8H7uL2mWLJxzRzEzQ8syj9r0sCjVSwFPaKWWxYF3iJsw7qLbAfzCOiJ9k55I84nzeB20BvLVcA9fF+EGXqeuWluu64oELUU3SuEPzI88lcY18S0P/Mw4Pwl4sGv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Xzg2qlYRX48ZIXFZoFf3yVEOI78awMUJg0ddSCu2MA=;
 b=JL09TMMVRfxVRQfWrq1dFf5UZXVVkIETPxMzozYmutPBeAMfxt3pQOSadbDeQiGyIxsPyKWM3FSdB+XB/Ac5opX5+SBR0XkXSy3GQgDDcZSMqrZArrMLezVJshuKOQch94uaveevaJMHv7IJmdag+Mf3Dn+aojVTcEhokdxtT7LnwiY6bZVjSPykIQ5vLaoimrqC2F0AkbvBBAgtsDg1YemlmrcDU/2Afb7rWTqBqRYAM/3rW9KUSnNkVzKQvuRut05Iv3dPUewnr+ycHX03VHDcT4UlZR+XJ+7H7soeJqGVoQsJv8lnVZjtRk5zII/tmgVzBhLWeeNe6LcblPLkVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by DU0PR02MB9821.eurprd02.prod.outlook.com (2603:10a6:10:44e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Sat, 23 Sep
 2023 14:57:57 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%6]) with mapi id 15.20.6792.026; Sat, 23 Sep 2023
 14:57:57 +0000
Date:   Sat, 23 Sep 2023 15:57:54 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     sudipm.mukherjee@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] parport: parport_serial: Add more support for
 Brainboxes cards
Message-ID: <DU0PR02MB78991280469B2EA237903D24C4FEA@DU0PR02MB7899.eurprd02.prod.outlook.com>
References: <DU0PR02MB7899033E7E81EAF3694BC20AC4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR02MB7899033E7E81EAF3694BC20AC4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-TMN:  [SN2pOL8+pGp1/bOzRx87AZMQ56rBU7nj]
X-ClientProxiedBy: DU2PR04CA0025.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::30) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZQ788nH1VaAA8M9A@CHIHIRO>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|DU0PR02MB9821:EE_
X-MS-Office365-Filtering-Correlation-Id: a45ec8cd-20d2-4aa8-bb58-08dbbc4578bb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3RCtQb7x1cmpW5c9FSAnUJUfrcM+LTv9KlW/LEcsN7We6NMN/r+rNrEK+9QkASEky6XY/wOAFGmhbQdlXHhsXE8iPfRHqpPHvW7+UMQvxyra1qfcj7yGSnD7F8gKlukwpDziuGAp7Ro3YetGUIMQfCUdfuJ6f3xEmn9brzNNJikA0AZT2ELxaCpUQ5tRK7d0cQcRUlEcd7jhyYIo9dbr7qVSwOi0YUMsPs/ZrZAeDmqV8lLx7D6qT1wiUWEYAAdHIStplWIlSXNrXGvh64qDqbRnrH3T/KsFSJ30lJsShNbIcyf8DZ/h8/zeaBoFmE72ZDrdpuFNPdL/JOIUU5aaR/QMyOHL7H8Nz+F1yv1+BQw8P0wPBLHOlc4VAFoLw4kyfQ8BI56eqkVKb1BGGzkt1kakvTwzfBnbc9ox0jmtBgwyV9eMCwosqCgl7ClG2zur+ceY95aS06DYBKR2a+MUrdy2MeqK6KNfZPysfFmvy9qvPim7fypnrZxGLmCDhRMuadCqFBUksf5grTUzM/6SuBCoBiqIEBqgMurgNHW+KDlSVUo9irnmPzChWTuWzyXJ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5+cKp9G96x/3a6UGukLdh40QKwWwLSVJ5WQCEOnElg7vSR4w1JYmtZaQoneN?=
 =?us-ascii?Q?cqLeLT4R0X2Ir/DqNqkP16wc1cb3sWkwhE8elyymj/T6WIlw7nsk2N/xZWGz?=
 =?us-ascii?Q?taGf4jMmw1ZdZJf3eQjz7//8F0hxSNHMu2h4+CcUoLXo+gqu/k6nviaTZa81?=
 =?us-ascii?Q?HibZHWt++IpHgbgaGw450D/59oHDYPKaqIKo6ysV9xcCx9W0pUqQe9O6RqCi?=
 =?us-ascii?Q?6L+1smlzTtGF2Tia42f5/yCMB1XKQtgO7zwOCEVhysk5ZZ7x0X8zN6PQdlQF?=
 =?us-ascii?Q?7iszyS0gAS7olDsqwKLVADREVyM+17J9jNos2ea6cngOfq4/KUwlmqymQEPm?=
 =?us-ascii?Q?PVMRI27POfJcAVslGEHfrMBA86dQmntnRQPjeLfXcPSL6A4UE7DEqbtovXWo?=
 =?us-ascii?Q?OpXHuePhSks2HR5kVu9UGtOdzLCsaJJXsobyvJQe62yhjAhXCY06sgJ09YVj?=
 =?us-ascii?Q?y3g45S93t0rZYJSWYaQ2Imgd39L9AYdbPnNhYfplHeneMY+KmFh2p2hvv4N8?=
 =?us-ascii?Q?78IY8dGe592w9wJZoiOFPc9XbVHZ70p6sNwYN7/P7WVKzq6LHqoPeH9vjzgR?=
 =?us-ascii?Q?efVE9gf8DT8cW05D95bvsw3DObxu0WbfnVxmEvFVZbBe3484lLFZfCnHKAgp?=
 =?us-ascii?Q?lJeccx0SjFOIJoIIGXyHSnvereyyFx71K+v+g1tplPUL1njIY16wEdshNYYS?=
 =?us-ascii?Q?/bPN7aUQwJqlYDL9KdrdK9apEXPNIWmuBSRYbux2uc8QFPc1IWq49ZZu5O/F?=
 =?us-ascii?Q?71lcjNdkAPBTJXbIp2gMuBg6NbscQzD00gUixb+9m0gKaTeRxkt4pxeyzP+M?=
 =?us-ascii?Q?NOLsVgfFKlNAXsA0PawSSUMExIl9f8TfTRZ8OyQcGnic2TM9rjBklFOFMlmH?=
 =?us-ascii?Q?k/4WA0+x2JPYwC0oan3Pv7lTj+PVhBB0Yqqn++gA3IfSawKRr/W3LRzYRMq+?=
 =?us-ascii?Q?PDv7WqF9NKAwAwPCpkrA6mOMFdY/Gf9zBMhyE4gXScsL/GTTxI1BBt9fAwPK?=
 =?us-ascii?Q?dEzZd4IhxmElSBBmcu/Q7fysEBfAcLgR1Rty3jXlR5GBKb8DiIDu7+xtwfmf?=
 =?us-ascii?Q?nSCNPQBz8f246GuUQH3P6f70L8xkVRemRjXwmpfYYXrAhREN/uXLXlrinNtX?=
 =?us-ascii?Q?pKbx44hS3/zhqM3t349p8YNHLcPNP0VvtGIsCcVMh8E9HmaedShiAwEq/TsX?=
 =?us-ascii?Q?iy8dc8OSYyZJeKPqrThPBT/NbK3x+ICBnEihAw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a45ec8cd-20d2-4aa8-bb58-08dbbc4578bb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 14:57:56.9935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9821
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please disregard this patch. It will be re-sent using raw hexadecimal IDs
for the device IDs.

On Thu, Sep 21, 2023 at 10:11:29PM +0100, Cameron Williams wrote:
> Add support for the Intashield IS-300/IS-500, Brainboxes UC-203, UC-257,
> UC-414, UC-475 and PX-263/295 parallel/serial cards.
> 
> Signed-off-by: Cameron Williams <cang1@live.co.uk>
> ---
>  drivers/parport/parport_serial.c | 64 ++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
> index 9f5d784cd95d..c6fbee528493 100644
> --- a/drivers/parport/parport_serial.c
> +++ b/drivers/parport/parport_serial.c
> @@ -65,6 +65,10 @@ enum parport_pc_pci_cards {
>  	sunix_5069a,
>  	sunix_5079a,
>  	sunix_5099a,
> +	brainboxes_uc257,
> +	brainboxes_is300,
> +	brainboxes_uc414,
> +	brainboxes_px263,
>  };
>  
>  /* each element directly indexed from enum list, above */
> @@ -158,6 +162,10 @@ static struct parport_pc_pci cards[] = {
>  	/* sunix_5069a */		{ 1, { { 1, 2 }, } },
>  	/* sunix_5079a */		{ 1, { { 1, 2 }, } },
>  	/* sunix_5099a */		{ 1, { { 1, 2 }, } },
> +	/* brainboxes_uc257 */	{ 1, { { 3, -1 }, } },
> +	/* brainboxes_is300 */	{ 1, { { 3, -1 }, } },
> +	/* brainboxes_uc414 */  { 1, { { 3, -1 }, } },
> +	/* brainboxes_px263 */	{ 1, { { 3, -1 }, } },
>  };
>  
>  static struct pci_device_id parport_serial_pci_tbl[] = {
> @@ -276,6 +284,38 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
>  	  0x0102, 0, 0, sunix_5079a },
>  	{ PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999, PCI_VENDOR_ID_SUNIX,
>  	  0x0104, 0, 0, sunix_5099a },
> +
> +	/* Brainboxes UC-203 */
> +	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC203,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
> +	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC203R3,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
> +
> +	/* Brainboxes UC-257 */
> +	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC257,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
> +	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC257R3,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
> +	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC257R4,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
> +
> +	/* Brainboxes UC-414 */
> +	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC414,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc414 },
> +
> +	/* Brainboxes UC-475 */
> +	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC475,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
> +	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC475R3,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
> +
> +	/* Brainboxes IS-300/IS-500 */
> +	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS300,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_is300 },
> +
> +	/* Brainboxes PX-263/PX-295 */
> +	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX263,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_px263 },
>  
>  	{ 0, } /* terminate list */
>  };
> @@ -542,6 +582,30 @@ static struct pciserial_board pci_parport_serial_boards[] = {
>  		.base_baud      = 921600,
>  		.uart_offset	= 0x8,
>  	},
> +	[brainboxes_uc257] = {
> +		.flags		= FL_BASE2,
> +		.num_ports	= 2,
> +		.base_baud	= 115200,
> +		.uart_offset	=	8,
> +	},
> +	[brainboxes_is300] = {
> +		.flags		= FL_BASE2,
> +		.num_ports	= 1,
> +		.base_baud	= 115200,
> +		.uart_offset	= 8,
> +	},
> +	[brainboxes_uc414] = {
> +		.flags		= FL_BASE2,
> +		.num_ports	= 4,
> +		.base_baud	= 115200,
> +		.uart_offset	= 8,
> +	},
> +	[brainboxes_px263] = {
> +		.flags		= FL_BASE2,
> +		.num_ports	= 4,
> +		.base_baud	= 921600,
> +		.uart_offset	= 8,
> +	},
>  };
>  
>  struct parport_serial_private {
> -- 
> 2.42.0
> 
