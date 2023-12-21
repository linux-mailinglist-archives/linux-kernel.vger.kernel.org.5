Return-Path: <linux-kernel+bounces-8795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A72B81BC68
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6733B239E1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C9859909;
	Thu, 21 Dec 2023 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H749NeiH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2079.outbound.protection.outlook.com [40.107.15.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8958221;
	Thu, 21 Dec 2023 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrTvU3oXGAcn2x61wl/Kng74v36/MG7l2Xc25OwEi1H2Gzo/iIjUzMXqofO5r3jrHzCatiT+ReO40fz4rYsub6Arl4sc8zyPEO9x1Ug3v4++ObeY/qkbp2tBDwCYGcZK8B28IBIu/wNSv2bb34ZvP6VtTYyXl1/ujcYAbhBAuzWXx4gcN/+ou4IISgtNWDHpbBv1AmHL1P66sCE+dN0ZIoe2AvLGe+VYaNVaOkdbIn9oIbFMv6cy9D+70khLL3alEH7G8r0YOieiYkmQ3eGi2MK0c5YmCc3JbFnBkxBXBw59HQDsk65twE2mBy7ahzZeW1z5wYG1xKIbBUjQRZRdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4VHwm+dMvO23ZXVNyp1M1Xxh2w7BTijeT2GcsYcVYc=;
 b=Cv7e6ZVFw2xdiRwLvfSNoWFQLLbXVehfsJqy8s3nuMv8bjAruLk9OcFSfn7aATTuS2pPM6Uvt0wo0a7tU9YgxF5xWjuN1wNhHVkf4VOLSxPu4xQWt3zlyRZBUhmAWeTZT9W0lJvIGnv9UHO8DvDEf4r+1FqazOgMZZ/9YQcUgW2+Reli3SUvoRmU9npXcWOGbeQHdAe6S8moDeffXjyzj8jvb1JsP7Mz/R/yF5xSOY3BV9uFGvTwmPM+Ojv+PJ+DH5ZCdW5PcFVst+KqOXkzp5T7LPnv0zRW1voUY6vLCNSe6mOdE8II3Krls3P69uHwC0QyCFBYDtjgzjlHKYcLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4VHwm+dMvO23ZXVNyp1M1Xxh2w7BTijeT2GcsYcVYc=;
 b=H749NeiHK4pFdOhof0RdItViDsQCi2A0fCrswRAQGSAzkoPDYXENUdKsxJeX9Rzmz4S98WNXeFeVpjChY0m0gm9c479j79Y20L0Rk2nUwDhZfouMbXSrI4/RHzTXbKtRNCoZAQuHG12BUeP5c9VkGnKxTi10T6C19DUXyg8FozM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7324.eurprd04.prod.outlook.com (2603:10a6:102:91::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 16:54:41 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 16:54:41 +0000
From: Frank Li <Frank.Li@nxp.com>
To: peter.chen@kernel.org,
	cugyly@163.com
Cc: Frank.Li@nxp.com,
	a-govindraju@ti.com,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pawell@cadence.com,
	rogerq@kernel.org
Subject: [PATCH 0/4] usb: cdns3: usb uvc iso transfer fix
Date: Thu, 21 Dec 2023 11:54:22 -0500
Message-Id: <20231221165426.1590866-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::21) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PR3PR04MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 8216cfa9-8bdd-4c73-2c9f-08dc024586a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KDXiLOj78EYLJTJ3nHNSBJWPDlHW4A59D7+bFhx+9fTfItFRdXuBH9VcpYSEM4TWjCPbr5OKLELh3aArXh58ajtB1DqNe6mPMCfMcfqnuG4ApeykZ49/r4WHKwBzmUKX0K9JrtdqQa523Rbij1big9VJsk2YLCs7F7AAY5Q04/nuVeoeSr9nyq8vCwYlqOsAbRRp2KDICmDdEG4rnhQPYG5+ragHdtZL/oocu12VmhXncPo1QdLVmqEzX6y8IPlLE9DxtZyWqkTdIt91Zg00AIaSWfFIxFJoDMwUjygQIV3S2CIKJFjfnDS+A87YuXJ9F99XA7ZpLiGbbpXRnrNjkesCYEuJ0reJp4DCVZNlVWbQ39g/8AQYiRBAVJSM16RLKob1DFUAb3p3bgiXUYsnNKOa6tuhJAuLgAqrMrohw6c+3zctTn8Obo7xn3dLTZnHfYd8U9njGF2egCGkXp7CNiC1ojMCB8OO7BQ0fWNYgxDgeffkOQUm5K+PLJiebgYHtAhNbj7p6SDwJqCxpiMudqB1bhByl4TC49yZmqpin4CPMTVx01dYPAIRpxzsjHsA0QEgGW/5B58zrYKdF6qbI0Cuy1hetTTGqxtlyS3PhRG1pWs+ZWKQzcd09ePuO1Ra
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2616005)(6512007)(6666004)(26005)(6506007)(1076003)(52116002)(83380400001)(4326008)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(5660300002)(66946007)(66476007)(66556008)(36756003)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y3srYbEIDcbjZh+HQ0Jb164wxOSz8syjMptGqMPbkKiq/OsyIrvITN5w0XaW?=
 =?us-ascii?Q?9N1fscbZkyNCnAYTubD6G9JFr1Lej2RByBOVpD+Ahw8zgid27Lo3v/dS58yy?=
 =?us-ascii?Q?nCzkOrNR1dzpakDSPJTWTrAClV41Bzt+aHLudyg9z9RQdu/1n2nn3U45miMr?=
 =?us-ascii?Q?K1Ol6xwGloGM+QEX9VOqhfPE9iKa1NK+cBRmGHsrVLr7ps7fZ01AIK7S9OIC?=
 =?us-ascii?Q?cuQgKjZT3pZjLezmplcXhGuA8CvVPzOuMGo0jYNi1KXOXkWK8Ye+fy1TKGG7?=
 =?us-ascii?Q?cEEVH/grgF7BAeAUD+JAGBRaYGaukkxEFvDvO8GHAWimooXIt5B02apMQ+/3?=
 =?us-ascii?Q?WOOkxjz7RGDm/BZtVMDikA9D5/uKjlJuHJFGBz7662MNGj9TuvjySdI+wFMI?=
 =?us-ascii?Q?1cSXhYBnUMOBAqwKqQaOWxPB0aRXqqBubKmLrBR4TLaMt6B8/hpcIhvpYUzo?=
 =?us-ascii?Q?luY++Xgz7RxrayJTDz/1zL9aPxXYDmPO4JfQwAQSZa6OZTra0mqqFm/QCYIH?=
 =?us-ascii?Q?xRzH7VqV3O10RFjrnXXUQZ2LAnLeolzAI5JUilryKYm4hdoFOPH2s6CgJyXk?=
 =?us-ascii?Q?QG2y97vU+klI+5Nehyb/r9g+0J09D7Vg+80zvoHlmv4RPSvwVg1+g+1EoVSo?=
 =?us-ascii?Q?Fqt3w5PcDpSDxSxtFkOyx/9n8H7zIgWCkh0BfIfSOgZYTiqg/OZf52j7D6xo?=
 =?us-ascii?Q?/rCCmO61/LIkdgQDjmbozqVQdngOGjvPn+VYl2CroNhEeINKk8FDBZ78Q5V2?=
 =?us-ascii?Q?GV+YdMAzygIE+Uz2PV7Pbza/ksLmimN51c+Ig9LIOmlXFOo1vLoNmsrGun6j?=
 =?us-ascii?Q?ZV2kkOJhaj4WBwAhUn0T5hw+9gGhCLiVslO/mD9ZAaHm6CgNPYxyZ2SwI0Zq?=
 =?us-ascii?Q?cYW1V9gjUBhknLBa5dB9uAiB9LLctbHYejKoWWeXrOM6bjRmGpmUX4O3ltPC?=
 =?us-ascii?Q?exegJOXgPEs+HJXgoPG95IvgGcpilDrDSslS8xhDmwrPnjvLzoDYXhbKN9zV?=
 =?us-ascii?Q?FowbfEF6UV9YFQqpPY/l0qm33n0Uk7Kz0xSLDter4VzKoenfEctoZoWCwDHN?=
 =?us-ascii?Q?YooTMs40M9HzEeCwHpiYeKDJfXOViJ0mAuJW0x6jfmJd4wb3+f+M1X+m+mMX?=
 =?us-ascii?Q?P1Eh9zO+8WfJyHbCmJwiwuBETtqMRb3oQRU68aygdl18wKlPIsCcaG7xKhi3?=
 =?us-ascii?Q?ofmsIPqKRERF19I94DFe9r2XdW0hy+KF4KTF0/pBIVmz120TSjEFomrTQ4eo?=
 =?us-ascii?Q?EIOOkV1igXTDjALZfoYfTH62fHL+raYGErnf4/V1DFjcaWA7y9kH17peDV/B?=
 =?us-ascii?Q?lpjnpDw7XqhC7U8CXK2cZ85Fqcntn+9G+AYS1+curo2vIprW+ZgvGorgJlDC?=
 =?us-ascii?Q?xmfKAO49/rlny+3pG8hbZUD46T7/WdBlm+mmtoHrJxh7YNifLWZpVhc/tH2E?=
 =?us-ascii?Q?swSwTKVZVxz5gQeYhGau9aH8TQ+CNd0crt/mB9+ZGjk53FwZIJBB59d1w0Pj?=
 =?us-ascii?Q?FQoztp5suGBe9OYpRDVY+/sw5SgokMqJ65tI1O7hzcZPAdCzAU4M/IS41pw9?=
 =?us-ascii?Q?tZii8u3S4/sBM/TNFVBn+i9BSizPbCjwUSOo8oMM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8216cfa9-8bdd-4c73-2c9f-08dc024586a1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 16:54:41.6011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irKTvLvBNeUux9i6t/MmXu00voeigqE3VuiiGQqCGRrbv8Xj0WID/wnJtFEy0J47ayPJo9Xxz5b1gr1GyzPtew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7324

Fix UVC ISO transfer since enable sg.

The basic there are 4 major problems.

Problem 1:
	Previous code have not conside sg enable case at all for ISO transfer.
A typcial UVC package is
	UVC Header: 8bytes
	UVC DATA: P(1K,2K... 3K) - 8
     So need prepare two TRB for this TD transfer.
	CHAIN TRB
	DATA TRB.

	Hardware will fetch it when get every SOF regardless IN token. So
driver have to dupicate it to interval.
	for example, if interval is 4.  driver need duplcate 4 times

        [CHIAN TRB] [DATA TRB]
	[CHIAN TRB] [DATA TRB]
	[CHIAN TRB] [DATA TRB]
	[CHIAN TRB] [DATA TRB]

	Hardware have limitation,  LINK have to be first one when
ISO transfer.  another words, the below pattern is *invalidate*
	[CHIAN TRB] [LINK TRB] [DATA TRB]

	So need insert some DUMMY LINK TRB when close to end of TRB list.

Problem 2:
	When mult and wMaxburst is not zero, EP hardware config need match
EP descriptor, otherwise some data will be lost. for example: if mult is 2
at EP descipor, but hardware EP_CFG is 0, only 1 package will be transfer.
If 2k data lost every 3k data.

Problem 3:
	Look like hardware have not fixed cross 4k bound problem at 8QXP
for ISO transfer. If dma buffer + length cross 4k bound,  DMA will fetch
wrong data

Problem 4:
	Latest f_uvc.c pass full speed descriptor, so missed mult and
wMaxBurst information, so cdns3 check_config() have not reserve enough
internal FIFO memory to ISO endponit.

Please more detail for each patches.

Frank Li (4):
  usb: cdns3: fix uvc failure work since sg support enabled
  usb: cdns3: fix iso transfer error when mult is not zero
  usb: cdns3: Fix uvc fail when DMA cross 4k boundery since sg  enabled
  Revert "usb: gadget: f_uvc: change endpoint allocation in
    uvc_function_bind()"

 drivers/usb/cdns3/cdns3-gadget.c    | 142 +++++++++++++++++++++-------
 drivers/usb/cdns3/cdns3-gadget.h    |   3 +
 drivers/usb/gadget/function/f_uvc.c |  10 +-
 3 files changed, 119 insertions(+), 36 deletions(-)

-- 
2.34.1


