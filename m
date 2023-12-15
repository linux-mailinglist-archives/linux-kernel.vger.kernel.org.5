Return-Path: <linux-kernel+bounces-1121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F32814ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF17C28601C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7472A35F03;
	Fri, 15 Dec 2023 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ak0fHNng"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2079.outbound.protection.outlook.com [40.107.13.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95CF35F16;
	Fri, 15 Dec 2023 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpDRwc3fEzRuXhBCGJGAAX2Xkm9blHh0bT75u4/ck6K1YnlmHNa0Q6PiW1U79jD9mGVV5qVBaYBmZfQ5cveg6cUgJqaqltlz6kooEdrfF8DbRuoDeU8xUu1kP7bzAvOcu494lUZ0oQaFP5BmGnNjQswHcaNuKSzdvM9+dd9jv2i66U8D0bU0ooe7Tx1p527jkJXyskVectNuiKBBbAHGOqsufhsPvHGeFTx2Ipqr1XpbOPm4P1rzq2hQtSpNRlbokbp9jPydP9TdRml0RjCMocYHLGOKdbAW1e59hQQ6cdrJZO6wTe+JbD5crizNU476hSPyJv4pi8CCEDvajzU+2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eD6RuvGeNJe+jHtabFaGc7x8ce1KiEadzfPQ3nJYjzc=;
 b=E1SieX9UNR2+v+zNqgc0YisL4AznFtyZ8uitmCfA92SCYYV28eBwylaHbh0atqsh3pG4srX4Fj+Bsy9UgjY+vimtCL/NgJguATDz71NzJ1M4QSAsH/lfcU6mdJNDc/yoOk4KD5HU3nlZE2m48TopoywRNZQM+Qsanx9oG+krw8+fRswdw8asuAkS3PD338XTM7PUBz7At54R9VtHuIkTULiICDw8peUUHDjodBnhKv1wm4+cOfrMpkw+aE+XYtR6vxmSrPqtL4k6L6vPIIih8IZC9HZP+a5bS2llzN+K0159EU51ENut8vC0oRlvtbccS6Cp0ORueSFKVAn4yv3Ihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eD6RuvGeNJe+jHtabFaGc7x8ce1KiEadzfPQ3nJYjzc=;
 b=ak0fHNngjlr+MUmrwKOYWvWqQ9WBADkAsN8JoTOf/aZqQA8aQm4UrgXUsh6kN+nA6uwM335NHYw4Rf4BRxKTAZ2VUpqr2Zy331uEbjGnydjxL0suwVr4C1W1f6oDdgK59ICXUCBs7G2XoQxUNeSMBOYw3SF5xdqLfRMBtknaFS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM8PR04MB7361.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.30; Fri, 15 Dec
 2023 14:40:40 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 14:40:39 +0000
Date: Fri, 15 Dec 2023 16:40:36 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: yang.guang5@zte.com.cn
Cc: davem@davemloft.net, jiang.xuexin@zte.com.cn, chen.haonan2@zte.com.cn, 
	cgel.zte@gmail.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	sd@queasysnail.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] mlxsw: spectrum: use netif_is_macsec()
 instead of open code
Message-ID: <zkadwo3imhhatvmkhuvxnoql4qmrgpkz77mugifckredfv5hxo@pbjp3ffoxvba>
References: <202312152145312776210@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312152145312776210@zte.com.cn>
X-ClientProxiedBy: AS4P191CA0037.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::16) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM8PR04MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3b03bd-ce1c-4d6a-147e-08dbfd7bcef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uxsY0WP8cW0LWioBVJO5RjJdwSe9h7kddLITd7lgOgUk5aJictAB6xKwWGyETlclxFNmeIUQUDpV0JQ7C2FSA37p6hCH7sNK8vL1Mw5DrOt/ENNkueFRA/x1AuvzVSUX79KKH7XW2aHqX5J+lqnx7kjtzE5e8OG76RrFNhafbQaYEDEK7bePmDOZQDl7BPmABGW8zWzqxtbx8MmQ/H6QXLdzsmpEb5Ly+3veWy7ASaBFurRk2iEJI0ysxVVRfJ2eB5MIPrXsddKDwgt3Mly8aHVwJxEfjnvxcOwo3yfr5ZR4PRK7dsY1yszH3DvX1oZMZwHbvBO+w3URy4FHPe1ansvUOth/9sZ0/mKgfTDxNIS8RfEkqZ+25Xk9AMn2V5fu00iMxh9gOV1RM1FO7fEBg75bZwVMwGzqVQHfSaR4Vy1QCSNZymMI1EOOQqqiSrc6p9lfy6qY1Tlo34MhxQFUPsHPMQDyxxZcTTuNuymkuEYrkFuLyk2mkj3rknYB1t3XYMDiwlWY/n8n3662poW0ZKMJBTfkEahSQ0/FkvjXsV4wySvceoCJpELQ98vO66JI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(26005)(38100700002)(86362001)(83380400001)(44832011)(5660300002)(9686003)(6512007)(6506007)(6666004)(8936002)(8676002)(4326008)(66556008)(66946007)(6486002)(316002)(66476007)(6916009)(41300700001)(2906002)(4744005)(7416002)(33716001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7LWWK8FvodzncHzctR2ql3Jx7dK8KMSb4LHP4MzV3T3/a8Ggq3Ri4ZBaw0Ku?=
 =?us-ascii?Q?Dn7AdaHFgwzRPoUQkS8uzMYq7cJhfVt3TvLJPZfax43t7CWeMJPtxeisiklm?=
 =?us-ascii?Q?pwJzIwDfxP4hUmAuwERmY9fHrzPbxKo1TghC4/e8XxPDhAUMa+4msLXytixT?=
 =?us-ascii?Q?9Ha0bzIH7Dl/f7/Wbqnp+CoxQp8QpWCJb73K3qjKqbAP0oUh8KpCW0zUqPv4?=
 =?us-ascii?Q?dO4B+y+aG4mLf1Cr7zY/WgNOOT5OBNM4YY7Kv3U+aA2TbJexQ4grJK88E0mn?=
 =?us-ascii?Q?x29WXVba05I3wqN2Hi/u7l0PEgFNyaGXI37olsgFBi5uVUt6xoCnPulAJwhd?=
 =?us-ascii?Q?BR4qn+v3Oq8Np/0z8ww3T9lEMTWhuOryX8vaBoZGnpSHSQZAV7vBsNCqkOIf?=
 =?us-ascii?Q?bacrk+qs/w32i4/vNeT47j18Qh9Z2QiYQ9faFs6j2ZpzwC+EMW0Ex0p8pptJ?=
 =?us-ascii?Q?S3OW6RVXBaEEydIpYtFoz6V2yHDcOP60ont+ppv6TTsHJyWES0LFggkTZeFi?=
 =?us-ascii?Q?QecmYozc1/jUOLVeyKMMIh5b+c3aGHxwP95OzTLenEGo8wMM7ti1v/cogDYs?=
 =?us-ascii?Q?EW97EbucYPNxIIMP1/LiBCw9vupb/jBHWtweqbwAUxHjg9CX9zIWIS9GwsW6?=
 =?us-ascii?Q?XBU3qpGOCAg9yDSYUve0euai/5BQxTidXT9xslrfMyB3N2Knfk7sc2Om2KGo?=
 =?us-ascii?Q?b32TgCPadp1CuJZfWuZTWqCrr7nuarlq396PEYuAlXAmuedUorEzevwxR/ij?=
 =?us-ascii?Q?rDoQBZPfiQvmzkSnWDlU2+SL0BYO9Ng/S8q4yLPXSRFFtYglBRRH43k79JZ6?=
 =?us-ascii?Q?9kSlv0frlJOnvdiGn05hcx7LdbH2cGyZNqii9VH7wu71b/mM6nBIS0YiZQFh?=
 =?us-ascii?Q?xd3m7ck+a8YFW89OgTJ4I7cJ5cEldTul5LlL3Eb7FTUKFLZTmEEoKFvA5WVH?=
 =?us-ascii?Q?c69aUGgbm7XZh2gRoRXC/CD7mMwZUI+QKjp8OMhUlRPraIj1ok2zFcJbInuT?=
 =?us-ascii?Q?n+7o2rQyTTfCAqFsvblm8tetE2wOiDFTMKsYpziVO+vInXOn1HCRk5K0Wnuj?=
 =?us-ascii?Q?rEQVHqWvw0RRF3aGfZEZuruMcwM8zhqGB+U+xdjDCZLeMNRwXQ5CV/aCXn5O?=
 =?us-ascii?Q?T0QrXgp8qaRqOOvjgAigqyD/4ra89x9Y28MDkXBCD1UKzCkSO1KL6LLcnQTQ?=
 =?us-ascii?Q?m1HN7ZVklWxmFem1RwOXu1w8OpN5fYxL9g87ATZnALxQSP/vlWYaEmA3QTex?=
 =?us-ascii?Q?Pnw0x49Ni3Z5ycwvoAez+P+bpOGHCeYQfrsjLCnLS6IEIZp/V4l7kseC3ujn?=
 =?us-ascii?Q?LFHgxyxKQBMW9KelH6XxmK+SO0Q7Q3SJAesb/oy4WTR29Xm/hyVazMwVQhnB?=
 =?us-ascii?Q?Mia+n7E4KSTUhl/vYQYFrGshGXGiZ0btvnbRdJmAkRJt6PWMRoDBKmZuohG2?=
 =?us-ascii?Q?omUZ7DMEKRXhI8wzVXm/+gJRqjN1bd9Ub+xHujDTNCDmdZtS4Fp+qUeSf3+e?=
 =?us-ascii?Q?VHbWnVn94xnyyfO5W+2whvSnua34cQI208hp4LRcLsaq0SWaWh4drbtB0V4b?=
 =?us-ascii?Q?vHJBQupEKrSiOfHRKK4Ues3chbKTm43zKOBdvtTF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3b03bd-ce1c-4d6a-147e-08dbfd7bcef6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 14:40:39.9292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlPqqDLyo/JEuLjh+g7sjZjCA9aqSa1hZnzS9+clwc5eCDml5LjBRM1sjjmDNur9cJnHgsHNnlJuAvUvpDeMuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7361

On Fri, Dec 15, 2023 at 09:45:31PM +0800, yang.guang5@zte.com.cn wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> Open code which is dev->priv_flags & IFF_MACSEC has already defined as
> netif_is_macsec(). So use netif_is_macsec() instead of open code.
> No functional changed.
> 
> Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
> ---
>  include/linux/netdevice.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 1b935ee341b4..1f2b23d854c9 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -5103,7 +5103,7 @@ void netif_inherit_tso_max(struct net_device *to,
> 
>  static inline bool netif_is_macsec(const struct net_device *dev)
>  {
> -	return dev->priv_flags & IFF_MACSEC;
> +	return netif_is_macsec(dev);
>  }

So you are replacing the actual implementation of the netif_is_macsec()
function with a call to the same netif_is_macsec().

How does this work?

