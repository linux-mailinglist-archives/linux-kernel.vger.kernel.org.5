Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5077B7AC2E1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjIWO40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjIWO4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:56:24 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2053.outbound.protection.outlook.com [40.92.74.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B7B180
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 07:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0VPcdKrSy7MwikW0nG1CbhasYbZ6VY1LhGqLhScmccOV93CuOv1LnbmbcxBpnlcXvdGM8ROtfmCCqMDv7WUfxgAFrs2ULTdZ+SeQs2OWVvFX1RESZpRs8cMUmXdYjmgcaEyJEC334VlKD90PQ+4XFCwcKvfvcWORfppGFJJY91+s4wdtj6e3zfRGFw8W6hQc+UcZh/M6IOJBOKuHJq/K15XmChrdx8hKkMAykxIVpaYf/d9buS0IxFFtBlGWVpIfe3AFWr9tfN5w0iYCHHZerwGAJ/AhGJ/IKuw3bD/Yuvsjq1Vuvd4CIS/vvHH2rWYMgNp1+9AWT2tTxFpM/bg5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FzCksFHti0LFvNOXzxdvUBDfglAVnLotQkFJrP0JSA=;
 b=SrXeyYrf6Vai85qLjow6BnU+KtUY2dlZmQbUwrzDwJeLiCDp9lxZPQU+xrACxHqDrAi1XNtEuabCNnreEequAZEI+nMhJcbWyEyT1vHwxd7WJuB2/SebqGmi2PG0BDPLj3UQQQeFu9cCzXcUbaNWFQRY7OLNuPBuu1AFkF3hy42QlGPQDNQQiJP0a5OkEHzLks2Yd4INWXmrCV7z7NDyGdh5ayL3qdIf2vBnpogMtVnqPrpPmc2hDVl0sZz2lnHZDZ5v7ugbU9Dwtc5dYEphngSjq5VaEcvzihA3QPM4OZLB5GOpy8heeZb4UVghX1ij2u+F6CQYiL7nCrNgKxzbCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by DU0PR02MB9821.eurprd02.prod.outlook.com (2603:10a6:10:44e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Sat, 23 Sep
 2023 14:56:16 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%6]) with mapi id 15.20.6792.026; Sat, 23 Sep 2023
 14:56:16 +0000
Date:   Sat, 23 Sep 2023 15:56:13 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     sudipm.mukherjee@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] parport_pc: Add support for Brainboxes parallel cards
Message-ID: <DU0PR02MB789916579ADB3C82B72340B6C4FEA@DU0PR02MB7899.eurprd02.prod.outlook.com>
References: <DU0PR02MB7899DE53DFC900EFB50E53F2C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR02MB7899DE53DFC900EFB50E53F2C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-TMN:  [FlbJyXkX+Vj7Ia4A3IJ+cUqc9VZ9idrT]
X-ClientProxiedBy: DU6P191CA0059.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::16) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZQ78jYlr60fGV-q0@CHIHIRO>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|DU0PR02MB9821:EE_
X-MS-Office365-Filtering-Correlation-Id: 78062cb1-856b-4bb9-e969-08dbbc453c7c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D6x4uT/8JD5s2BfMTnpA+2lliHZZHT1wt+ZqAYv/jXKCxS+ILsdYU9uZDbha/nAIJm+PjthJszNr1YChH/HIFpKu7bQscHHK47qIq4gBpbeXLc1y0kDhTzz5IXEOHzTntsO1b3Dp0Ki+wFZmre2g3cGBXwFQO5S6/kEydTEUtqtR7Yz9/FTvW0n5vDJ1kJpWbpwXFK9ZNHaChQwi2MYXJK5Y3pck5cH6uTXsMJmUgsidFdvbV+4brzqNOk0BD0+RrulYKEvcQ+BFDofAy/AKScVP3zW2RotxQa5v4vcMgFVERhGDgCWkXdR8GsNJ/9i3PUd/FCbaobIubuIaZD6VlS4ZzCSr+7bMYDLzrxUHEevJSwwa6cDYZkJVvHNVIeNGs9L0BJ0Dnhqwa4BuikWmLmQ2+ZaehRAPVlyulGjPSCibwOXsXwmex7HX5pLWszwaP4NjW8vcV6LqLJbiIoRXgpJ0EfuDXJO+jUrH9cqr6LQ7Pq4ZPzIhp02vVINODK7nsnwSIkZ20jli83cDXxkq/fdrlpCvnIKVfLGanMY0+cfNjYKoKaMxqtfbq6GBr1RQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XZml3uk/ga9NpMMlxJIgJ+qBiz6UhWChksgoAoG6OUa3Nxd7Gd426tRJupfK?=
 =?us-ascii?Q?7zhcRwmCMC8FYJsHp5DEsCeM8m4ZI5r7hPCIK0ag31FM3w6dewC+y5/lTayo?=
 =?us-ascii?Q?7cdlvZlr+4+uqj/N8efaOWDdVbpS7WJ5Szm9NXOOCOHKn7zQXuoC/HbB4tey?=
 =?us-ascii?Q?mkd0OcB4aq76ESQvhU8Py3joY/TswxE/QlP1q/HslnRwRlcwK+tY55UN740D?=
 =?us-ascii?Q?G0NZcdo3S5slqQYusF3evzGJZEb/c/5Llo/bTlCmYgp2Ma9FF5t4/QjyiO1P?=
 =?us-ascii?Q?7jNvOA6uk2ZUFjE15KnMBaV7ymoQEn0MELFCcVECPZCRV9HJAwgHR/0r4TGB?=
 =?us-ascii?Q?kapDiE6CVRrazQblGoYeef9+jkzuLfUhWmsXpmCJ/ZV0cHsUio8roC4s1aHj?=
 =?us-ascii?Q?2uieZyVd+qSK8zycTwL69qxcCiePt8x1+lNk4vMzNMbExuyEeExDbr0dMuqs?=
 =?us-ascii?Q?IEzap8Gr2Oe4TPEs5OZKk0MZ0Pdncdgf2oHDYYUwDRQTnN1vi8JzI+hZk7cc?=
 =?us-ascii?Q?b/YPb9OJpeNlfShm1BGVg0C4dnB0knUHZhzBclo/QgX+9Q0d4JjAfi8AUDts?=
 =?us-ascii?Q?crsJXAkqcT9Hu6WhWf2nQP4NpOAMM90fAZkPpAuLB2S82df6qaK/ikc4ba7F?=
 =?us-ascii?Q?DzCPL5RKMKls7hvFG3xuYc6ONTWdgFmIMOzEziqWALS+rhrH0clX6UZYitfE?=
 =?us-ascii?Q?HJl670TCBSCkskmbU7+Z/XP+D+KpM3JCAifwU78Z61eYPCS69aLKf1fl3d8H?=
 =?us-ascii?Q?Fu0VLzd7EE2fC4RvXYo+uSL6O20zDuf5VOJteYgPIdH0GyRNfxOi7R1pBFPg?=
 =?us-ascii?Q?BIbZ6uj3TGZrFZf+l7rg+COZAmJFLcV0gYkNWDsvTDV69SRn+TqMGHazkFIR?=
 =?us-ascii?Q?lOJU80/44Fh3KycijQSxcsrWWL33ObU8bIsGbeYc2scY7tQWl7Vcp86RsrPb?=
 =?us-ascii?Q?Ts7aXNPssY2kwi8li92E+ofjX0nUfdGISB0zgzFKS8ZdcNXaL1sv9Uf/okoR?=
 =?us-ascii?Q?CSNtesoQtVGjuYQ0qcYWX07wlO3twwzTMhrjSEhYAXfbk/cRkNjblRgFp+1V?=
 =?us-ascii?Q?a3UaY5ir9g7wJuxUrC4QA+pMR5tk27s19vU6zmhZGl9o36Zh+CCSbMYDD4GT?=
 =?us-ascii?Q?CYQwsbgPg0jqOPEFQcevMcP2/AYdi7yChqugJJZUbwm0qDXe1xyYxd05zrkT?=
 =?us-ascii?Q?SScJyCUmT7GrPb3irW2GChafCrzFsYiu877zIg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 78062cb1-856b-4bb9-e969-08dbbc453c7c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 14:56:16.1145
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

On Thu, Sep 21, 2023 at 10:10:07PM +0100, Cameron Williams wrote:
> Add support for the Intashield IX-500/IX550
> Brainboxes UC-146/UC-157, PX-146/PX-157, PX-203
> and PX-475
> 
> Signed-off-by: Cameron Williams <cang1@live.co.uk>
> ---
>  drivers/parport/parport_pc.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
> index 1f236aaf7867..95bb5134696f 100644
> --- a/drivers/parport/parport_pc.c
> +++ b/drivers/parport/parport_pc.c
> @@ -2658,6 +2658,8 @@ enum parport_pc_pci_cards {
>  	asix_ax99100,
>  	quatech_sppxp100,
>  	wch_ch382l,
> +	brainboxes_uc146,
> +	brainboxes_px203,
>  };
>  
>  
> @@ -2737,6 +2739,8 @@ static struct parport_pc_pci {
>  	/* asix_ax99100 */		{ 1, { { 0, 1 }, } },
>  	/* quatech_sppxp100 */		{ 1, { { 0, 1 }, } },
>  	/* wch_ch382l */		{ 1, { { 2, -1 }, } },
> +	/* brainboxes_uc146 */	{ 1, { { 3, -1 }, } },
> +	/* brainboxes_px203 */	{ 1, { { 0, -1 }, } },
>  };
>  
>  static const struct pci_device_id parport_pc_pci_tbl[] = {
> @@ -2833,6 +2837,23 @@ static const struct pci_device_id parport_pc_pci_tbl[] = {
>  	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, quatech_sppxp100 },
>  	/* WCH CH382L PCI-E single parallel port card */
>  	{ 0x1c00, 0x3050, 0x1c00, 0x3050, 0, 0, wch_ch382l },
> +	/* Brainboxes IX-500/550 */
> +	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IX500,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
> +	/* Brainboxes UC-146/UC-157 */
> +	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC146,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc146 },
> +	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC146R3,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc146 },
> +	/* Brainboxes PX-146/PX-157 */
> +	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX146,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
> +	/* Brainboxes PX-203 */
> +	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX257LPT,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_px203 },
> +	/* Brainboxes PX-475 */
> +	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX475LPT,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
>  	{ 0, } /* terminate list */
>  };
>  MODULE_DEVICE_TABLE(pci, parport_pc_pci_tbl);
> -- 
> 2.42.0
> 
