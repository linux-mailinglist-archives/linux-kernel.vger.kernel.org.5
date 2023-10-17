Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848A57CC603
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343923AbjJQOiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjJQOiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:38:09 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2059.outbound.protection.outlook.com [40.107.241.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5AF92
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuUrv/kqt5Z4JPEwM9YwMKJgGtgL+8MClv8UtsPBHSeN6+H9r6GMM7jH0uHPzZBGOBkS8aswqAcrqZ4YctnYJdcmiGSBYt4H8QQvqsGMQI4cfLnYc26EIoj7PrtOeFls7TnvpsY6MhbIas5ix1bKobvgMC5E2BvlX4Ghoe2ReXBPSuGd/JZIMvo8yCBvMNsjqaTLew5iqHuclomIwJeR8RjjCH8m3uGkGiGosl9U/3J0WUci5uWY+WYBqc5eLWRfOWIB/DF9E1TJSy7syxltlDFrDa+i/rsNoUM9AcoLs1U/GeXwAm1L+x3Ziu1D5myb1qCR2dZzWfK9aYzlWT/cbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zBrtrT3QgwtsGRCbCwn1YABI5uDfPVyujNzuAIm8wU=;
 b=ez0I7/ac37+KyzYtdZdpZPVma7cR64G5OOR8Pd8Z8BYChUiTt5xN7t/J3Uq7Bu09+jfAzzztWeyNsP4YP8br1VBJyVuMpJz//rD/ysFmXRspXmMobIsS3+WipGhptCecnxApugmhhbR8BblfXc3ZAyas8LpKN0HV6j14XT9jQ3bY1NQ2Vw+8hy671erRszp8lmyD3n0avhUtxloSu/21HYWSaYMUFUEZAvu1/Il6OaFHvXso0+dRg936XOKJvWn37BFVK+8k3+IeY43OAloD3ZuLhT3PB+OwC/JANDijvmCe2SWWeezcE48OYQ92X4Mco/+6ZLjoMk+Og1YHtNIEhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zBrtrT3QgwtsGRCbCwn1YABI5uDfPVyujNzuAIm8wU=;
 b=nesZTo+L0saq5QC0IfHxQcnlGoZju6JhAI0Em5RE9RkfJMe6M85JaTGWbabsOvs/974c8pI6OHFBbc3RTPpBNACFqOn0lmwoEDQPIkdgjyAxxWoHMqjOy069AXwpkwFwLsb1/hsWWYjO+ZUmWnU7MOnKDflq3pFE+vthlTAx7dI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9570.eurprd04.prod.outlook.com (2603:10a6:102:24d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 14:38:05 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 14:38:05 +0000
Date:   Tue, 17 Oct 2023 10:37:57 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/6] i3c: master: svc: fix race condition in ibi work
 thread
Message-ID: <ZS6cRULPrwWjCL02@lizhi-Precision-Tower-5810>
References: <20231016153232.2851095-1-Frank.Li@nxp.com>
 <20231016153232.2851095-2-Frank.Li@nxp.com>
 <20231017161658.2de6d9f3@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017161658.2de6d9f3@xps-13>
X-ClientProxiedBy: BY3PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:217::6) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9570:EE_
X-MS-Office365-Filtering-Correlation-Id: b18988c3-a3a4-4525-b1d6-08dbcf1eac66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wZNlkfnZPQpt46i6nRbebuh/rkn/wGTXOECeTCu/rQmZIJdITwhojYPQ+4rkrOXbd+qgAP4/n8z8hgtYchuAx3V4IbF0niA/0DuxeGyXxfhBpweMIBToPYcX/NPZUwawqgbh/AF6UmgsNybfzj2C8HqiwbIE+FOL2sRT4sIbf7SeVlrscyNSotZKsTdGbtX8Qn9CyTK+n5pbHTb0l7zsZpsiClMKncTop3xKVTGroDZ1hx6xA2RdHGkd2xiHfI+nqTuF+8Z71KAGr4lPa1NaLGwFEmZqRFOZbILIq21APAJQ+AnTwAaPGtM2yQBHPLAx1+I1Z+jQBGphn0SzoNKjprUGsY6ivcOm8GPeHKREE4Q8jK9FunVyHk38//X6RWrQN+jyh7pffMVaXwYOGtwQ/cB+oJKBb9Hw45t1RECjEY42pVI8DvXZUznkLr7kq/qYxeChR9EMlNHFKy5PJk8D8U9vWVhxbS1lduOUeeAXXeanN9oU34fjQrFT/vIrh6qGRzSgC8NFbxKIFIKY5h9g6VFUYU5qoW1FWthWMSVdO/9AuNMPI9QbNbSNuErn2jjJr/vwghvK3cuD4bfs0oUJ5ZA0Hp5WqGCc7898eAUWCWIoplRnmM/IaL6gy1cStqkQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6486002)(478600001)(6916009)(66476007)(316002)(66946007)(66556008)(52116002)(26005)(6506007)(2906002)(6512007)(9686003)(8936002)(33716001)(4326008)(8676002)(5660300002)(4744005)(41300700001)(86362001)(38350700005)(38100700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?z1A51H2M/8I9l8aHTbVbW3ESf9+CmHeeeNVIUCF/DUq7AGtoCkMEk6eRef?=
 =?iso-8859-1?Q?ZIR1TRbasbKGiUCKr3HbrsKfZ1KQtPag9nhBYMKa+xs0DHSn1xwbfDNH+W?=
 =?iso-8859-1?Q?tXVmJvAGhZNeThbOnzraLrw028GceMpW9QgKa3l/ICpxuMXE8tlLPsiAML?=
 =?iso-8859-1?Q?94C0Q7L8bGDO2F40/YbrJqSmpOWQqTC9eODYiCJ/RSsf7cD8lenlvVyhNZ?=
 =?iso-8859-1?Q?ExAdBXyKSt+QU9sikF2SIs9ei+FE+w4tuMw8rCluoamBrIRIiRdGWBftLA?=
 =?iso-8859-1?Q?js96BGTyU/0qm/BFtQmkuS4zLMsRGM4qpU+d1YCdVyNaIXbL9VGsJxJmMU?=
 =?iso-8859-1?Q?I8nElJa198i/f8Y3E9+GVUbGs+gFyocN88ZVqz3exTQjNVs/Kf1WF/6/2O?=
 =?iso-8859-1?Q?5CyHaEnCUhC6Sn/3qSjJmN06WtAc228UWy/RQOsTXEDJFv6CqfUSw+ACT/?=
 =?iso-8859-1?Q?A/Hrogv26oqXbOH5f4kElUHOXcw5sIj0Z4aAUDnsLgdm8HyqJOMtgz4dyQ?=
 =?iso-8859-1?Q?Z8a7nph4dR9x7RLOeRuY+34gNEhpN4LCQxcpFzcJIP3HMz8Cyn/FSNynok?=
 =?iso-8859-1?Q?DXTQFr7nRYOv86gtoyWXuu+Xo7x+r2Ui8Qz9b+MRi6dZzz76ze2Fz/aHTl?=
 =?iso-8859-1?Q?vd7uTPn8EX75G8Pn5EgUVc3wTgb6YCZMK9ytDUoTgwhLV1IqdHmGs6395i?=
 =?iso-8859-1?Q?nlynBsoDarVzn3Q6aQxLh7e3BugldVbhYtXO6xrQ+lYTzYxdLhfp0pvwms?=
 =?iso-8859-1?Q?Gs7TAPR/L9JCmt4jXFJDcaWFX300zOiQVD6Yy7YEMuLKAAaVDXzcLp0lRK?=
 =?iso-8859-1?Q?3Z9G5L/CtFPawFdiKXv9Ic7UxzMp05+Qgxtr9c28ZpfMplBTV3URyjZNAK?=
 =?iso-8859-1?Q?27dtLtATcJxeOWU4WGnbMhN4mmPfI1HsZsj1qLBq8S1zAuvNO+9O36k6RJ?=
 =?iso-8859-1?Q?rI9hc1yJDqMpugekrioxkSjpNhDGoXjsexRub8YPKgBSA7dF0gv8BdUumU?=
 =?iso-8859-1?Q?f/0DFxjbmsItP3TiFpAk1xsbW5tyQio1Wc/J9knBfNLRr3Na0QvEIHlQqR?=
 =?iso-8859-1?Q?LsQiGt01YaTSEqXMjIqPD2yx/wWAM/aJTIso7v+MNuz7dO+q3+HnWQr9/x?=
 =?iso-8859-1?Q?Vz4bL8ZfHg2eO7K0jxhqxHIT2Y2wgb2cfQ+hWR85GSEvVq8GExNctqckxN?=
 =?iso-8859-1?Q?YsPKv0BCScUKluwPnFYTDavy23cCaHy0YG9y7mwn3K9atKSyfcpo6Y9BH1?=
 =?iso-8859-1?Q?OYHgqkn5fy5qFBek9/cHGwx+6iOeO7Y46xYVQ0ZN1caxQBTGneI3DTlCtw?=
 =?iso-8859-1?Q?wbKv8xdvRXHq5toB5SHWVaAtPUoLg27DJZTh+jGnBYMQIGcqDtala11PYz?=
 =?iso-8859-1?Q?RujHgovsX+xaVvCYY1iiylCObD5APH0+fhF/JVPJoTKAYoDa+0/F2jNuF7?=
 =?iso-8859-1?Q?ejg4zV+Fyn/fqv2DE2GK89dJ+bUU8/AiDCbola5WAFm1/Joag+kneS4PJv?=
 =?iso-8859-1?Q?U//1PazDUzM+n8bVPWZ/fadxa2kx2HPZe9eqQXzRPmOX9bUNwUshydWa18?=
 =?iso-8859-1?Q?oi0mNpO3xQd607BnC0dYasXeSVmHrgUpuQhZVaZDgmRiFdLNrHOMIEx0oq?=
 =?iso-8859-1?Q?sba2b/Xtx4qaI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18988c3-a3a4-4525-b1d6-08dbcf1eac66
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 14:38:05.3305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyN7YUgsDyA8mk/bDQxVaQ4J5eury57bhzAqoS/zo+uv7C2cijxdAU8LX0gDM2pQM2dUMF8IsIX4lvZBERSTiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9570
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 04:16:58PM +0200, Miquel Raynal wrote:
> Hi Frank,
> 
> Frank.Li@nxp.com wrote on Mon, 16 Oct 2023 11:32:27 -0400:
> 
> > The ibi work thread operates asynchronously with other transfers, such as
> > svc_i3c_master_priv_xfers(). Introduces mutex protection to ensure the
> 
> Introduce
> 
> > completion of the entire i3c/i2c transaction.
> 
> Did you experience faulty conditions or was it reported thanks to
> static analysis?

Yes, I met. But it needs my slave part patches, which will be ready sent
out review soon.

Frank

> 
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> > 
> > Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> 
> Thanks,
> Miquèl
