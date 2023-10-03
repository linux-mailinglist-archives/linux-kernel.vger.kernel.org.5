Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB067B6265
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjJCHR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjJCHR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:17:57 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2049.outbound.protection.outlook.com [40.107.215.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724F7A4;
        Tue,  3 Oct 2023 00:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pjw1GBNIYeg35gbbgzrP4j+m9njVwnbGJB0G7IzJu4QOy3Vl3gwQQcDY7gHnFxxSG3V3v1Z7bSbNdvnb3rQ+1fp8sK/TTNHzlbEETwjAQ8sH1FY2EnKDkCjrR4iEGPg4Ihct8k+5HEZIifA7cqRQ6cKVgDATK9vq8rmYKajjU4GDjQQp8N0Y65bob6a5e93N4KeADWqiS7necEYZmLQUYleQWap1efMnZELbYgvPlHm62dK3wbiSBPa81h0cosUFy01i957Sg6yteYnOftp06K/n6L/n70/Ed2V1gT4dv8MVI6MgR+mgC+E1/qMylmAxOxJTN+iQlvLDsCGoOWSDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Imku/5zekNnyYTt4iyoG25CKKMU1i4LmrFScT0c+0Q=;
 b=lNIFyRla4A7Ny0p1RtLO4L9A0hQsi3GiYIwvHCmfiZLDj+KSEG+H2QaR1X0nrdDIqaz4D97F4Vc51FHOH1z+uFaNgL5f1y3iJ+Al/SdyM+1+k3rMNbOhq+M1pRMZaAlq3E19Wji4Kno5hrrwGp7xh3aEWcHMnQ91RXdjpsyca9kh5wGZnInE/EWSOIJPVzj2nqfz4Me1hfWeBPrVkEapOSNMtsJwSrG+DxkcdNnWHSXabvXumJL+Z5rlhSHWiB5aE304cZ9xP6Or0GjuIRnF2My0vWbsxDCkn/C3kcfCz6pytZCtfCGMFc9VG3OQD9Wr9B++w1z2pFv0K9FOeEyPWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Imku/5zekNnyYTt4iyoG25CKKMU1i4LmrFScT0c+0Q=;
 b=Nj0TYj//fH1wMOzskBefbwyuspMNtEmmcxhX/RGLj/hP5x71UMB2l+FheWDnPuBTa2SaTAIzgJu8vR9f4EFUct7lnIoBjUVvIjhnx6/JXs4RUTr1poJiENpfNMNIQmgTY1dCyfROxayyX8ggDAeek5n27TH6gEsj3B8+5KB2qBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYSPR01MB5906.apcprd01.prod.exchangelabs.com
 (2603:1096:400:46b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.32; Tue, 3 Oct
 2023 07:17:51 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 07:17:50 +0000
Date:   Tue, 3 Oct 2023 15:17:47 +0800
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/4] tty: serial: 8250: Cleanup MOXA configurations in
 8250_pci.c
Message-ID: <ZRvAG5336KxuugVd@moxa-ThinkCentre-M90t>
References: <20231002015702.30509-1-crescentcy.hsieh@moxa.com>
 <20231002015702.30509-2-crescentcy.hsieh@moxa.com>
 <68d533d5-dbc8-4be3-a1fc-b3dd28b8f9df@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68d533d5-dbc8-4be3-a1fc-b3dd28b8f9df@kernel.org>
X-ClientProxiedBy: PS2PR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:300:5b::27) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYSPR01MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 18faab63-9cbd-4aca-564d-08dbc3e0da42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tw/3PVIF01IyyGX1zCn5/0bLgTjc5cPJ71VZs3pTVEujCw+HVpXHmthq5vEEAR5xcQ3poi3uKRXeIV9kUzafg1XKkYOSRn62m2qskE8JDm9vfPnj+95Hdf3sNmYD2WuFwjMJmtLoQb0mdZ7tT48HaYJX76dIQrEHdJDGaAIHdjFPlyYsO5QNh3OVdXFE/Nfv4aQg95LY0aAWznjPWtOOu8ztq06WhzwpVVrV9cSFByR4VHErm/DXsjbYhgcHNqPqhc8CDlGP7iW7d02pg7uGJyiaTmR9BNUX3SVnGKbnp+3sYItHTj9fXx3PCstdfVK1q6vY4eYJxMebcYIWOa2CB/Gu9kw2eQCb+c5xOO3d2ZqeC0GnHVSnqgKT4AavrWQKynrlidfAY0eQpeMjItL/K6wgzt2WdX/iCs3fV7k5dJLGfMPfipLq0Cti2x6OL4Bu6N39oKgJz0p4/75yalX9ls2R81V264FI2ZNeL7J1Je3m21XHY61Has7GWCpFdSQGzQWaz+UfYhbXJRL5Yx1QxvVCTAXCPH51ZsQLxcEBji/O1JQfktqG1wcJu1ROaP8klztkQ1coCrDtRtYPRjJKDaY3l6+pwnq/TVLgxEyLWqL8P6BVvDTbqBcyBY04slNW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6512007)(6666004)(6506007)(478600001)(52116002)(6486002)(38350700002)(38100700002)(2906002)(86362001)(4744005)(33716001)(26005)(9686003)(83380400001)(66556008)(5660300002)(316002)(41300700001)(66476007)(6916009)(66946007)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9zMdY0lVf+M9g2De+2ckoDKEY8mqFX5gaB3zyXqItPJEy8oi0Duykx/eoHVj?=
 =?us-ascii?Q?4JjKKrfn+l7AoHcimNTSrB/139vRMSG57p/EMcwsUBz68yQETEWYtCRLMJgF?=
 =?us-ascii?Q?6ZnXJdpxTfh1d4xtK649gxffZBFHWYh7K8uREr2SRd6huFMYH0WyVLgluY5M?=
 =?us-ascii?Q?5Fn9gbYJ0zFoUg3NdB5Cgy0MU22FXbj0A2K4hUTjcBf8CWpkEC85Ahs7LkXl?=
 =?us-ascii?Q?nI1hHC4pxZoXmsX5arKVPjUa4yMP9ar1H+FEss/jqumfrGWNZ/rZeUW/XtM9?=
 =?us-ascii?Q?SXXqRB6X5fEMWzNhNu93N0xUPIuz8g5OxbC3jz1ArBtotdiAVJfdClHAud1C?=
 =?us-ascii?Q?Bbi9+fFFsew8VdtqAuMVzL74XaAgykMLnFBEw4HIBmlcaWKCFQshF8HYl0RX?=
 =?us-ascii?Q?zThrUEQs80H/jCqDFtVxnWoUga16W67auTIRkoxR++eAffHAwpB6ZEndWb6L?=
 =?us-ascii?Q?EqNkryNpEA8RIF6w6ANKoBaxykOFuPUnUGamIYVKP1FGmM5Rg3SZ7+Lc+kRV?=
 =?us-ascii?Q?zKT2vcCu0YoCzCQyVJGNfCWMV4pzk3/OLzpIvQ7tN5fJw/iYTcLvzFzcGBU+?=
 =?us-ascii?Q?zexTs8SQYnKN92OURML1LWv1ZCoh/PzPN72DrTVK1+uDFtpT/qNMhHpeGSZQ?=
 =?us-ascii?Q?2TvuQ3mmIzxUHVVwYA6rkALKjflOvf8M9/KT4UronHhal7MS3eLHsIgoAQJM?=
 =?us-ascii?Q?7i33k4Vb2uAZWrubt/1cAqi/3w8mb9C5PNC3gLqzaZrjrQNs4ll6t5w7yqry?=
 =?us-ascii?Q?8nkjJevm3zD+9FDVInjbJHdMqc9Q6eDSTJ0q5X9RRMOWJ0ugHakzGDDnxTAt?=
 =?us-ascii?Q?PdGnVyHoMrfoh8693f1MCE6rt9EBc1RrfUPn7vkGPqWsdVsq+Z0wbOzDevVL?=
 =?us-ascii?Q?OhHuapl9wI3iZtU4G6wEmLdqyiEFrewO5tRYWqpL1JV5znP6SMJFIKmwq+d7?=
 =?us-ascii?Q?RmRJ/83GTBUU24fDstykNXSnBjy2pQ2PW+3+Lm8PeRW2sAAmhkhiCQm+hB5E?=
 =?us-ascii?Q?jkEcy7cCDREtui/oaGbaJKMfyPZDlB/wbBxCJg1OGdwnkjEkki88VjHotwcZ?=
 =?us-ascii?Q?ASn2NOioP/IQraG2TAqktJG7JOjiiHvM3vtLurv21qro4QqXnDYIru1jdLuL?=
 =?us-ascii?Q?8mrz3lSgR2LYLni1VezUYtJTZpQuphbf/sP1Vk25JFjrd6WE8bcvlfwuIbhs?=
 =?us-ascii?Q?qHp1mp1D5q1RwU9rQ/5oXS9UCWDI88sE/A+fmr70pOic4Q5QqpoKBDr8Ajpl?=
 =?us-ascii?Q?QAMiv1ryprc4SwXnyzytqzodeSgrTwtgrNNq7P77VCK0ouSS9RQYOkVhsCdw?=
 =?us-ascii?Q?uE2Dlb6F/ViklDSY9QFNhm2ELmzL6WsO++4PKNw6PIwDyTZKEB+4337VVNfx?=
 =?us-ascii?Q?Z/nttgtxyK1T+mt4fuhAqTgMzdd3eUzZEF/1tV+zmQTL/krTaeuRRDvlwGdy?=
 =?us-ascii?Q?KSZC7V4w3KnF5/dPZfNN4dK+ut4x4M/uI3S96xNf0jvgvxmT3jyE/A262d/3?=
 =?us-ascii?Q?/MvDB6WedyWw9CJCCrWc5Js+sam3mZvvoNsoRgrY3p9oPYRf/acDG3U1lshW?=
 =?us-ascii?Q?gXUofZ0Cd9XXeSDI9dkdvDPdYM/NA1Mz0dKQQ2N0qdpXkQcti9q6SzsS1Crv?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18faab63-9cbd-4aca-564d-08dbc3e0da42
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 07:17:50.6904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8geCx7C0kceCJdTcXk0syyhE3F5eZfy2ioC+w2dKCKEc3X67ExiQ0BPqgA0r+FQ/GFcNPs6qeBckQWBwSNATaJaUTQRy7aPO4BuppFFi8w8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR01MB5906
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 08:51:03AM +0200, Jiri Slaby wrote:
> On 02. 10. 23, 3:56, Crescent CY Hsieh wrote:
> > @@ -1958,6 +1958,9 @@ pci_moxa_setup(struct serial_private *priv,
> >   #define PCIE_DEVICE_ID_WCH_CH384_8S	0x3853
> >   #define PCIE_DEVICE_ID_WCH_CH382_2S	0x3253
> > +/* MOXA */
> > +#define PCI_VENDOR_ID_MOXA	0x1393
> 
> Isn't this a redefinition of the pci-ids.h one?

At first, I attempt to place DEVICE_ID macros into pci_ids.h to enable
their usage throughout 8250_pci.c and to establish centralized
management. However, I notice the comment in pci_ids.h which is:

'Do not add new entries to this file unless the definitions are shared
between multiple drivers'

So I add this VENDOR_ID just for the clarity, even though it results in
duplication.

Should I put these macros into pci_ids.h? If so, I am willing to help
relocate all other macros.

---
Sincerely,
Crescent CY Hsieh
