Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609F07FA5AB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjK0QHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbjK0QHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:07:44 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF2B19B;
        Mon, 27 Nov 2023 08:07:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W52d38ywteurVfRRqTZZiA2gKFLD1Gp8IsCvyzgqXiAVA+1Zm7AeWplsizSVmVDcBSqYlkOfv05EyJom3HexMhWiWl/lxKKYApOoVnJHal4f94cgn1hN06YWN26Q40tly5JIvjkQyPWCSia2poeyBihVJAltuMNiIWf1Jr1vqG9Fqjkj3GdQX1JwGYrk13BY08494IoPD1uweGqQrDOZ/FxvpAz+1mfPfgFiEDQI80vfCn2c/A2KnfpMuXxdah5C4mpDDiPjyMBJN0m2NrIrJnbzUDycSYzN/DuuYscvl2zHobDmnBURFwpgiKcypus4hrVK++5JbF4FlMuNNGoxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YB7mUddm3kygYJxzPjCTeVBdpadubMTNCzpPZZN+q8A=;
 b=jJNvwxeSVoe8RE1H6FRM8GKwQfbFM9vDaoa3Mdxoz+0+qhAGEl/1nqg5atMAR32y4caOh5DPF2/K8Ag8znHUvUxOlh3sciuN3bwwtGO89bSJ2DAX7eWR1VqonqNR3Sz8ggukdHJ1jxlI/3TxQX+pqGzTfgIQ1h1WDI+DHDbwZpcP8z9/1q6Hb9IMiMocyB2u8xEoyRbtf0CHsU0bHk/FXEHzO6oalZhBGiaV4/41xHFT3GlCTr/eg8Ynak9mGd2DfXcj1PR+rbEhQk6sZ46cEzrxJVcnywIgKYmr8gqDyiZ0RNQHMMTVoDLjpvcG6LwpHbc/TPWM7t1U8yFieNvdnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YB7mUddm3kygYJxzPjCTeVBdpadubMTNCzpPZZN+q8A=;
 b=cqxYeGgdZIHynsNOzM7n/QDBDmtqrLAlWmgpL89MI+shC0f7ptKSjbU0JRo3arkAqtgTdcuJi6NQ7fCxATBvggCrxFbOO/pWaLXYMrELnk2euBU9xB/oVdMWiaHmTSJ0BQZHmjsAMnZsaTOXnNxC0VdBtUYbV2aqvT3gooST1iY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by DBBPR04MB7628.eurprd04.prod.outlook.com (2603:10a6:10:204::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Mon, 27 Nov
 2023 16:07:48 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::6410:9a52:b833:5bc1]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::6410:9a52:b833:5bc1%4]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 16:07:48 +0000
Date:   Mon, 27 Nov 2023 11:07:40 -0500
From:   Frank Li <Frank.li@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Peter Chen <peter.chen@kernel.org>, imx@lists.linux.dev,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        "open list:CADENCE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] usb: cdns3: skip set TRB_IOC when usb_request:
 no_interrupt is true
Message-ID: <ZWS+zLhtleUXuBOH@lizhi-Precision-Tower-5810>
References: <20231027183919.664271-1-Frank.Li@nxp.com>
 <20231031084521.GA1948529@nchen-desktop>
 <ZWS1ucR7dXs153R1@lizhi-Precision-Tower-5810>
 <2023112748-coveted-enunciate-cf13@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112748-coveted-enunciate-cf13@gregkh>
X-ClientProxiedBy: SJ0PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:a03:338::32) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|DBBPR04MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: fd433e34-606c-4896-9385-08dbef62ff79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OlhaSyLOf+jzfkWhym9YiUIMlhWNvadk/mBnD3PR8SejvupxIgdNHATK6O/y3Th10xW7Rt9VQ9oahnJ1y+vh6vZetDKSVrGcOZ8wRmMafrSdJPNBj0xpHY3VYI/5SudDP38yRYtI1yJ+JU+vCS9Z4EQ7aQmAtPwSp5/JnHwls4DYwIywLsfqt331ZnA8HHnSZg+eup10CNto3lVmEFLilkBy4Nlf9CpqfFSYP98PzIBG7ygU7+fbVN9hc5SPM/bFwqa3BkxqOTgG3aAfNDXnUwWIVMl3Mz0K+h1/PYt6ZqkxfRpd/RY9kdvvSWSnA2DqjEU2D95B4OHkgn8a9246TSb5C+9hVZFUX6YNV1k0XXNA/NLn7gqlS5MEocTtv0WYSMrCkA7kG1WcjcJszhHrgBik0+TCBwKvFD4a8oqDWbEBMpHLK18DIGW3Sf8jXUOUH78dMFpwoFRo4DlYjm0Y+w/KpXLbtUmjPCZuLBHDRhwlhzv4JYNb3zkU2YFch/hIYZ9o+hLtV7nQIqECDhL9hysIWxXW1jRxEi0YbiO3snMIIJUiegAhyaS7zGQDJZVm3mJYfMItMny0ljqd3eoWRLtglEa2J8/0d+VzHuvYx1ct1euhapeDTGYBgAH8RzGYZoPC6b5J2Chy/zfS7tThdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(83380400001)(38100700002)(8936002)(4326008)(6506007)(8676002)(53546011)(9686003)(6512007)(6666004)(52116002)(66946007)(66556008)(66476007)(6916009)(54906003)(316002)(5660300002)(6486002)(86362001)(478600001)(4744005)(2906002)(41300700001)(38350700005)(33716001)(26005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?utXPmC5gNCDP5NBa7/pgu9Xw2Vxgy1asLs6BvMtcB4Dh3wd17/LT4SENGk3H?=
 =?us-ascii?Q?xSgl+EIIlkqW1pTrwQiJqJHYScHaRSHbYITwLFkNBVIj1yuwgblaZRrbN06H?=
 =?us-ascii?Q?V1Xi2O+27jveKFc0WSc/ruqiJiQF2LLVqYgmRnOit14e8LS6UDMaMmz5XyMw?=
 =?us-ascii?Q?tPXoUgWmYVTmueQmWJbY8LrYOuQrAU8LB9/5QavQ58eT41RCpC3p75Y1qmA/?=
 =?us-ascii?Q?ypl7KgTLSp/gHzKRlLLrFmRJl/sK2tRwXDQIhyWh99EfYH4S0uxrS33vuxOv?=
 =?us-ascii?Q?kgjTXwA62I0PWhMGOzH9Eg10/9Bo+t2mZCLWCpe6Tii3ikhVp77IvDRZiBmG?=
 =?us-ascii?Q?r0K4AtFUpafTWENKCutgt7nblKwlrMMx3i/UAmz3VltaidZOMELnxATXtwwN?=
 =?us-ascii?Q?ncJh2fR9JUGBQkbDp4iGRtgANGR23Xf8D3XqgfwoQl3TXWW+fgXPC45VRuwT?=
 =?us-ascii?Q?i52AVeSGYQpl4WsSAdKGzpaMzLP/XpTIzTI1tCipaibXPA2OSBqvBXAqknTi?=
 =?us-ascii?Q?cxmt9Z1EgS1wQyZlPGUHzq/JioLbsUSeUPcsuiuwpD3RoLCgK777ulXGDaoc?=
 =?us-ascii?Q?XMfY0a49Ulo2yWMTVmckoGZHYAtUGq7nchGwPAN+DWrKh+VoIkmdQ9cZij2+?=
 =?us-ascii?Q?Z3marGZLfIOxsiac77l9Ju/0WikKuNhY06auR8NfFFt708dxwOyuBEYfOUV9?=
 =?us-ascii?Q?2L0RNdPnlDGThPfbO5G7ZH6wB6MKTJ+D6aWzyTZMbKn3zx09g4Hglj5m5JhU?=
 =?us-ascii?Q?3HRxfAgB9QUagLB88pRGM1FiVjx89Cud3D4LtoslPDBth8G0v1P6wE/sDKrH?=
 =?us-ascii?Q?KJqvGohQrnG3dQuyv/CZH6O5aEdTQbI5b4FFV1DDFvbCRtNI2+v/a25sPegr?=
 =?us-ascii?Q?OLHWsJwYVgmmvteFH0sSmYux+g4A81a4AHH8Ml/jLCzeHsIerReq9xU2YjGX?=
 =?us-ascii?Q?BtVlg+nGy+svSkDSohOZzTcRLw/GMexmBi4ZU4yqe4LhK280yFdFzUa0ftMU?=
 =?us-ascii?Q?//b6m3fpD4cGJYCB+DKm32ddRa1oW1htEjSjssCgPOfec2UGVmd0+UjvDfMP?=
 =?us-ascii?Q?VY2rQ5ik47bZssixDZkEDmMn/PbF203rOMO0ZkdaQ/yxS4xq8afFCeQzaXm+?=
 =?us-ascii?Q?KcFtygQ3wbA1xTdO5O7MWhaDZMuk61qxy2Xuxnq9xRDCKBy5b2/dSTJKuDmK?=
 =?us-ascii?Q?FVdsZAm51zTBjZNJs5BvXBRVLAlsiLPZk4diJuAVVLjtI1hOHbEN3W4hGN9M?=
 =?us-ascii?Q?CNSq77E0qaal3nXQ+wsyb2TUt9f/IJi+vcITgGyVahWVax0xmm5fZYSeCATB?=
 =?us-ascii?Q?ZT78d+nGSZwJYgl9XWaqtu3r4Ven7b/0foXJRDoMLJhutQ+MPaplH1iPSGaP?=
 =?us-ascii?Q?T+M6kvc+9N0dYnfzb1wuqCm5cC0+fURFDGHcQ0/iyJ1ISVSs35g3yW7/UAaK?=
 =?us-ascii?Q?b2p62XmcDDo7gJ7cEoqjlREQaEhtajEtjGzRQTnIVe7gxDDxF+ZoYAIseNJm?=
 =?us-ascii?Q?HeIWJFr1QJRkkb8s4+yL2cRGoNu+9zGbyrm8+PW5UwTIdh92J5E7kYrnv22O?=
 =?us-ascii?Q?KAE3D3OsG+zn0s1/vnA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd433e34-606c-4896-9385-08dbef62ff79
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 16:07:48.1440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1plBgQo16GXtiF7FBFBO3z/8Bs9ZMO0IE8eNU84qZ0DDKGPk4YdWjCfA5tAV2ok53fWQetf3bK2aawpEJ27uEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7628
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:52:13PM +0000, Greg KH wrote:
> On Mon, Nov 27, 2023 at 10:28:57AM -0500, Frank Li wrote:
> > On Tue, Oct 31, 2023 at 04:45:21PM +0800, Peter Chen wrote:
> > > On 23-10-27 14:39:19, Frank Li wrote:
> > > > No completion irq is needed if no_interrupt is true. Needn't set TRB_IOC
> > > > at this case.
> > > > 
> > > > Check usb_request: no_interrupt and set/skip TRB_IOC in
> > > > cdns3_ep_run_transfer().
> > > > 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > 
> > > Acked-by: Peter Chen <peter.chen@kernel.org>
> > 
> > @Greg:
> > 	ping
> 
> What are you needing from me here?  Blind pings do not provide any
> context :(

Sorry, I just saw it is already in linux-next tree. Generally, I received a
"applied"'s email. So I have not check linux-next tree before send it.

Frank

> 
> thanks,
> 
> greg k-h
