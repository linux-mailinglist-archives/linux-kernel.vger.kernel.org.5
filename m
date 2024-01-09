Return-Path: <linux-kernel+bounces-20255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25683827C7D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6041C22A36
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA871844;
	Tue,  9 Jan 2024 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P8Vqe5dP"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9100139D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 01:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNOtVCdvZH/JqKneUCS7RB10S6IsxR1ve9YuFXbydmWFz6ex9xqSwAAXC6I9iI7nnoVgGT9Ktpu+xv8xC4KR5zf2xHkCZtGSNuxvj1R+qghVDuO4ag/H0FpA1Jb8G4Xv/3DvgJNHcHt648Jbv3yDoJh/1n2fyJY/dA10S+sV7BPW+XUzxThBItnG+wXB5qg9VzTjO/3SN5rnQ9DBK3QZNaYhIqMc5hEP5meO4ftvhe326ZiHuZ8qFzfUzIUUpNNGNoUaLoObjwwiIQg53A6vbXWppon1aFC9SAfUBFgNddb0UFNWI+eJtL79yCB8pDygtY4JZElRrKggPiZiRWtfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iACVS5WH3GRolIzoz9lhuvnGGRZ8Pa6PTZF0GC5bYjE=;
 b=gXzzJ9YGaumdsHVmTVvhEIs4YYC0KUeeex+EBGNNSuke6Z+jzPlclKekCvrUtFDSMsdP/GRKx06PjJfbxa5ZnSjsAkVYB1RqnYOZykq/l4YErgo9+tSeH6A/BucAR3Bk0rsNLhZLrHwALNfName3DE1kBTUEeZpw7Op5zkprmsi3MK8QOa6m8SOqQvN9tpkQOuHXbqqBTZQ7K/NWqlh2VRtxa+XDICHdGVrw+W3AJy7/aO8EAHagWLLxujkNzfcq4UASzazgB6Bu2F4yYdpoC7IKffG6+HKtt1pPqtGRGsvl0V+CP1jS945KiDHl/L9Fkw7BAaGauuhHp+R6G6XNRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iACVS5WH3GRolIzoz9lhuvnGGRZ8Pa6PTZF0GC5bYjE=;
 b=P8Vqe5dPDcs50UeyEuP2w3sJOW08HVU9C+ukRbxwrDdFiDeYEbCzJufg/yrcVpLjx4C1IAQT7kDr91jy1Yj+ANolZkfDpIlP0S9dEaRT1gbVBvZzAcBD9ojlhDQ1sr+6zq1daxsWftELGPmUz9k9sBoA9bAO3ED4H9J/UzaXq7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by DUZPR04MB9899.eurprd04.prod.outlook.com (2603:10a6:10:4de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 01:19:51 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 01:19:51 +0000
Date: Mon, 8 Jan 2024 20:19:43 -0500
From: Frank Li <Frank.li@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
	imx@lists.linux.dev, joe@perches.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, zbigniew.lukwinski@linux.intel.com
Subject: Re: (subset) [v5 resend 0/6] i3c: master: some improvment for i3c
 master
Message-ID: <ZZyfL/wWSW1oMOec@lizhi-Precision-Tower-5810>
References: <20231201222532.2431484-1-Frank.Li@nxp.com>
 <170467220283.558820.13886846242749418731.b4-ty@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170467220283.558820.13886846242749418731.b4-ty@bootlin.com>
X-ClientProxiedBy: BY3PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:217::27) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|DUZPR04MB9899:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e63829-e725-46a5-8ca5-08dc10b1144d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	POo/zlZuGwrafYBC3vy/Oczrskzntfr4ad3W/563UDgr0ePwgNHxVQ0l0eQ4hWe7xtW3E7eH8qAT7wL2DhDqrtEETCiMpoCW+cwJg6VCgkxcb1qJ3WZcuQw0VVf07f4C7MdfQPY8cBWvHf/mKARceXCb+HmJYk24sz8gpj6QRACKoCrTDTOjCMQgfoPTCjlrORcMrtWYIRDkcCNJSH1LRbrPyi7mFEuo1MqD/x7UArumCOQrgwh0jv6imJpXYOV8JRrqG2wIC3pX7Ppk78Gao8cCGVIICJ0328FiCOE25h0yJoYBePshR8cCRuLj5fSnCWkC5OVlpRNFzZtOvu9CHdQGZnFALcocub4UnP8GtalUVVrNfpvTYnh3VszfQm4oTI1r/XHKgEoOyg4Wb6utv+1PviwQsaKvrHRbHvPeFX13x4daVxGf1pW1UIcbUw9sT8AUH6gPwwXGu0ATy2rc/6KHjIudIl7AjPDqhzt/Zc+YsMOceGdqjMhB7PnEHQfiP5iMeueDgiPhOAIjLeXZq7HE0HAx0bMs3xjXxzROvqfjNoyIX6PPEbSSsEXfypu64hnV8P+6xoUihqxwARXfKhDMNIGycs7t3EdpgBdWeG6Jme3shgZMvxQ695OUgpAs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(396003)(346002)(366004)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(4326008)(41300700001)(38100700002)(8676002)(8936002)(66556008)(66476007)(6916009)(33716001)(316002)(26005)(9686003)(52116002)(6512007)(66946007)(2906002)(6506007)(6666004)(966005)(478600001)(6486002)(5660300002)(38350700005)(86362001)(42413004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WbEQMX1KMfxEK4w+iPil+hh5b1/BT4lcI5ZUtTK5DBBqumSr5koG7NRqsAoh?=
 =?us-ascii?Q?Uoi1t/OtZ0Hb8B7FSb0ib4UGTY7QINnF2f6zzy3gxEoIx3cEvwrnOnKRPqv6?=
 =?us-ascii?Q?mreohji5NZYxPXyDOgn+QV87pNGGCxsFG+c6SwsQqIUl90eElzVQFXQU3lHq?=
 =?us-ascii?Q?PwnjkWAFpESqRyESWj5D5WYFlsGpjur7N2dm7Cfxz9QF2s3LMd4XmT8iW4mZ?=
 =?us-ascii?Q?k3adyJuImR+/n25zRxyMeycCzjDx/V4e2SaAYNXO6ckUIttYbjbr3N+pK0bf?=
 =?us-ascii?Q?UmarTiuXIe+MFatisNA3nDS6AJfFFCmOFtBWXy18Z6GBl9AmnUpuOQgBVAuq?=
 =?us-ascii?Q?gJ2yRjV+QwXqdmmwCIjEK5/KUkXxYqzk3V5a8KwznLEOQkxXn4YKL9voJLNM?=
 =?us-ascii?Q?Pe+DjgekUiA/jmyMISPhAPUe41XEjRonADV1UGH8+E2hbGurxVMYWIOwC0/i?=
 =?us-ascii?Q?sefdKb4t7LjBinrkufGHwXqsFcgJBVxRNRDO2Hp8uYzIQL+EX7qxKAUld2al?=
 =?us-ascii?Q?HykKX9qW4xXAm2PGQy0JRWWwF1O4ftSwNQovi0gcA8WVXWy598QXuu9ECTNS?=
 =?us-ascii?Q?Q5dQRVfiIYIgm1uFzAy0ppn+OKEmyn2h4LxN7Jlzj9NwdAeMUFCaVDyLHxVr?=
 =?us-ascii?Q?p7L4CZvctvazKkwF9LcKUEMHNDvrHKG78In8Q9ir59RCUDgPbsQkwRB5O4ar?=
 =?us-ascii?Q?OMuE7bYe3tIhgmpGLY1vVBkBvidhrJpiEg50o0kJIEp+eyQoHO6RgCbnIrE7?=
 =?us-ascii?Q?YVb13k4ADAotTBRpk5bwgYirfgWuB22G+Ebjmrpk/+zTr7BK9ERe7p/OHkhT?=
 =?us-ascii?Q?QUUoYus1uzwE0EOwLYqRsbEEZ4kws68cPeVP7QSfGzFirEi8FvFrCztUZ2gM?=
 =?us-ascii?Q?2Fq32w7XNHfvRH/3uuEl5szLA4yA69c+NwSUjlEMHR7dlArroe7efcg503mq?=
 =?us-ascii?Q?JlsDkjkhvx9oJeIvt1yuxzEpJcTnWbWFX4RE9ffAhoHAWRx7bVOaHG8CAwSs?=
 =?us-ascii?Q?yJ3trKIvIop48CfwA93nSKqttb9SfF84LJRKIoEclcwoH/SJBj+/lsuFUyU4?=
 =?us-ascii?Q?UaxYCuD72ky8GiM6vEPhCH1B2sTLtUWHAOR1N1FWWbfDJBzIFDddlIqDk4pE?=
 =?us-ascii?Q?sI61qqoGExRmFV+nX9N9LNQ5iujmC18FH3T9uDnFfEg8GO9ogVs6lWgp8Pbw?=
 =?us-ascii?Q?ma24VCu5sOI/SqCsvcPj+bCHj5kNsBkotbMgO0xFcbFyK1GRmwgMUH3I+KE0?=
 =?us-ascii?Q?QslM1X5hbKT9bBf00VA7ZEZdl8VtaY514MDdqn+MwWv2xlkRePSYiOJHWhsc?=
 =?us-ascii?Q?395dWwZjy9+y0uKmTiOiMCsPzrtIFZuW1JsJRTS74KMVnTRmg0+CL5vpgQvH?=
 =?us-ascii?Q?BYc7SdMexgRqRaKlwzyUwmj7LiEQY6q1LwpVufM7Zxv52PwSz1CCh7PGvb8X?=
 =?us-ascii?Q?z5kQTKnX+IX1FjS0Xt2oEuPiGfHSdD+P5geGkpAwsFsA63kfiDbcb6AINqgY?=
 =?us-ascii?Q?dfOzfjJq3fvcjA5skcUhNh6NrwyAFSeZ6ZbnIiUi8p5eVn5VBmPpsBBjdX5u?=
 =?us-ascii?Q?KIN5YVOiRsRqUG8h/za7t1UYPi8IYdIpgeHVSMFR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e63829-e725-46a5-8ca5-08dc10b1144d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 01:19:51.7222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJARsOdlvjKNG8vNEjj886HJdr+P28J8mzBF++AQz9igzzedxy6qXQXefSx7NXtBcbqOLpMNlpOg10sE9ZS1RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9899

On Mon, Jan 08, 2024 at 01:03:50AM +0100, Alexandre Belloni wrote:
> 
> On Fri, 01 Dec 2023 17:25:26 -0500, Frank Li wrote:
> > There are three major improvement
> > 
> > 1. Add actual size in i3c_transfer because i3c allow target early termiate
> > transfer.
> > 2. Add API for i3c_dev_gettstatus_format1 for i3c comand GET_STATUS.
> > 3. svc master support hotjoin
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/6] i3c: master: add enable(disable) hot join in sys entry
>       commit: 317bacf960a4879af22d12175f47d284930b3273
> [2/6] i3c: master: svc: add hot join support
>       commit: 05b26c31a4859af9e75b7de77458e99358364fe1
> [3/6] i3c: add actual_len in i3c_priv_xfer
>       commit: e5e3df06ac98d15cfb10bb5c12356709365e91b2
> [4/6] i3c: master: svc: rename read_len as actual_len
>       commit: 6fb61734a74eaa307a5b6a0bee770e736d8acf89
> [5/6] i3c: master: svc: return actual transfer data len
>       commit: 6d1a19d34e2cc07ca9cdad8892da94e716e9d15f

Why not pckup 6/6: 
 i3c: add API i3c_dev_gettstatus_format1() to get target device status

Frank

> 
> Best regards,
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

