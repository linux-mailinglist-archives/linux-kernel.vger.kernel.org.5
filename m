Return-Path: <linux-kernel+bounces-23933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E680C82B415
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693C81F2444F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2695380A;
	Thu, 11 Jan 2024 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RSbD7mge"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97584537E5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjMLUqdvO3wcVb0Z7DW9QXTcZX+CCMILTJFa3Z2j5iupFETgTT30GaeD6ZWRzCsAF9TsxuhfeAbVwCkk8LL+/zInS3HarEz6UMHh5a/9YXZQNDSlydksUS/iPpO0cMumj4Rmsd42S7RpAro+ydlfSkQui5F3rWMeWaaYDCeNTWDJyQCEXyCM1Y+x/xXVd0D0njIWG0W8eD+67/PiUxYHkn3u1DevnavWUT5sdj5QDQM0i8/P/m8CHpIa/c9uab9SfsGD8g9XUAAG4bnR4E85CsCQcjoebDfzi3gZhoE02rWbroDcORyDcHNSAqPwPwK0LdsZmPD/ySAjXGtZWg8tog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyDqb6dIjKs/bSyVZNWkRJ6cyxo1vc7oLWtagoNkFz8=;
 b=IHAXd384GBTZUMxI+8sBrwA7T2hOik/8IYrUzmAoYaWRR52ng16Ja+wWS9itzOCkxZDm+FpR0tIHun37653ib0zXN5rVBg3tAlz2SYuhg91C0O7lWsMYWl9+z/e8cqI/oS6EdkSWrkLIHnaAPG8fW40o+ACHopPwcAb61aJFFtAUUT4jgDf1dUsnTMliRw24WYqXoyZpH6c0rpQmQf8RP25noaX2I3SwNFwQmqhvpFwqCV0phaL7L8k7+T9ImWyvEjgnFIgSf3qR3Q/ZvBqaXYBWwzAPZeMIY6yCPNFOLj/cgvfjpSSa2TzjtZEYx3ZCRoLditQ3WnGTTDhryH7ZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyDqb6dIjKs/bSyVZNWkRJ6cyxo1vc7oLWtagoNkFz8=;
 b=RSbD7mgeSRuJZtIVUvELkZif+py7mW5d8HVZrsq4E4OCaOMYa8yU1iRdgR5lTcqO+hEjLkuuDgFD2RTbF45VvhU1FdJHXGrSYTbrkeEbQfAJyXsa3q5KeXWbbe8/tjpQFEOqoj8qF1Yj9o/Q9RPRRmFg/zJlU6XLnE1BTKFohaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by VI1PR04MB7200.eurprd04.prod.outlook.com (2603:10a6:800:12d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 17:29:08 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 17:29:08 +0000
Date: Thu, 11 Jan 2024 12:29:00 -0500
From: Frank Li <Frank.li@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com, zbigniew.lukwinski@linux.intel.com
Subject: Re: [PATCH 1/1] i3c: master: svc: return error when read length
 bigger than 255
Message-ID: <ZaAlXJQuZbej5o+r@lizhi-Precision-Tower-5810>
References: <20240110222503.2381599-1-Frank.Li@nxp.com>
 <20240111001523f69f6a29@mail.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111001523f69f6a29@mail.local>
X-ClientProxiedBy: SJ0PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::18) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|VI1PR04MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cbb2574-713d-4148-ae17-08dc12cad157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4SRjBrsKYZk0jJWZHAgAaedpwDhGGY/79fO2rglejM2zjAxl8zXB5TB2R2bzuXFnmys4wi3YHd9qXnnP3RtEvkqufjIFbrexclgsVDakfbcFFZPePJMV+ITFabPTWeS6itLl1Mu1UmxNEQKVJaW38lM4AXY8YqOyq4qxezwx29peQ0rgFAulOaUZo3EJy/k9EUVj6ehCTVrGDVT/c2PQwuBQ1l4rg7HCp7KBJD5uu3k+Tsh88fF42OsbMKOeeST+0q6u6klSIUDBRc/zyv/jTkxDUkxJJa0IsQzf1WA1uzfwwSUYB1XHKqVhe4j2Nmy94V8JQggbV9WNl+efEuTmqA8yF2QxxFXCYPIKvBYmj4bdsAIO/W1yRjGZrkWgUdku0eH+GEFQjbAlCPpjmFN9HzxV1TV+qFI/CqYBX1qBcXWteCDxPZZbuKNczzSC4akFt5mJ75dtKbWGpMApwC4NjSwVp3pd3bswkUviBa5C05oLVw5SwhB5O9960eiQWj6fxeicXgcInKN8MVNA+DRSRjN/4JsgoAkncGzB57TWE400/0L8qKS0se6utbKvPY86kklFLfKomHJxnD5ZqpbpPeiK0yoOoFZAGlygFFnYLbb65YsUEGgdEK7pqOAX61aizZYPS27KmJ0m617n2VshCQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(396003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(966005)(38100700002)(6666004)(478600001)(83380400001)(6512007)(9686003)(26005)(6506007)(52116002)(8936002)(8676002)(316002)(4326008)(2906002)(5660300002)(6486002)(6916009)(38350700005)(66946007)(66556008)(66476007)(41300700001)(86362001)(33716001)(135533001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mutMHT5mGQi0TBVNxdCEwMJRATH7WJttnNni2O6/LSfn0VNQ2BOssY+S4ieC?=
 =?us-ascii?Q?gK2Ja2nYiEwHvo0z/xKkT5kpNeGxM5n/tikZEx62NYRvKohyRmadzuJOMbdN?=
 =?us-ascii?Q?Mrg8nbyX+pDxDfWOV7vCSnhLTtu2I68Nh8NMsXCFte0L/QG/4ZUdY2eLj2ss?=
 =?us-ascii?Q?8m86/WpTexbOrRN+5dgjoArfAIG/CycwQG73nymUbzUWFDFHKgm0djaOkRJb?=
 =?us-ascii?Q?A41o6v+oAXPtWPeeZZzsT9aaWN/vhziV3zbmpbBcyym9Fj1HCoS2KIId03bw?=
 =?us-ascii?Q?WWbFJUTbhP8wjMiWLyj5/sBwWWAmyFQK6cizv9gff+VGstg7aB8asu18aHzm?=
 =?us-ascii?Q?Azk7+J1jsrCA2o4M0FaFVRZr98e0+j+FGCuUKvWb3qdE7rnhso41dYyO2MIi?=
 =?us-ascii?Q?2AdH2dQ811B0i15Zk7rlqcjDv7jHi5U9ZtDX0+IBeN/E5IQIOaqV3mjEmbeo?=
 =?us-ascii?Q?dUtxFHEkeB52IDStAZ4m+dk+Hzy/+HOWdiIPe48CFgCCBLPnkss/8FqKoMC+?=
 =?us-ascii?Q?v9Hqnm8+HEDzQC9ew6P25QG5DJwyl/bH0ffQSt6NjQU33zyHTJJMGelcfthx?=
 =?us-ascii?Q?1PHFOpEBGwDGL1gptCkut6vwCSCvSGyjmYmCKdp9H3smLiGtGQEf8KJ+LH+P?=
 =?us-ascii?Q?9F+MLn8EWSb4267U02y3e/ZvfMafpoyHmS/OynOysEHf340AFfwvkQ3RxoPn?=
 =?us-ascii?Q?Wr6o7CfeL7XRPC+D/EhHKo6g7D2pW+x8YPks/HR2rjbdDgENZL0CssCA5hSB?=
 =?us-ascii?Q?10Lfrik5DnsAOvDniQPJntQbr8q2eJxU11EXAo2OxWHVoCroz3RNhm5x36Xy?=
 =?us-ascii?Q?kqNVhEyMqwuGna+jbfBnn8Wyb/esdTBx+kgtBrwEreOOZARoiYXzKQDNl5W2?=
 =?us-ascii?Q?VBqrFsHK0R5G/5Y6Il+K39oNPvIVgUnwfit0nDESms+gT4noQU84ySAJcqsB?=
 =?us-ascii?Q?aTjyMZ5Pw+TevkwsAa+3g8WeLX8Jq/VndPnxWDC5cjdJDDHY6lB9WAODtkL1?=
 =?us-ascii?Q?QGFax8gT7YfaHhQeCOmKJ4nXmNm+yS4R03UJ4S2TjtG9cO1DtQdCw7v08x9T?=
 =?us-ascii?Q?C6/Fl+68qcJFNSEr/f4roF7yPMJvQGAu6SuiCG1Jp8wXvZDPoGCYaiz7PRQz?=
 =?us-ascii?Q?RbKHDHzgbC0mpWSNAqmyFZfcqQDNR4hmOm+KBq1/6E0DAdCTa8eJ5P3OX/NH?=
 =?us-ascii?Q?nAMuY77zJkd1dtx3lPdHwqaOvPbjbzipgw6plg79m0N7NUoBLW8We+ojf6PS?=
 =?us-ascii?Q?WofUVLSo/NT9OCF5ylvqIozUWdUMDsKeDWcYf1PJ+Sj0DqPaYCo31jIrdH9/?=
 =?us-ascii?Q?pETAvQYML0MC4mjUIZkczdYlhkumSSwueK8cKFq1iglm1ulR0hCXBot+DoMK?=
 =?us-ascii?Q?1t6HEMSg6J0f0tVA6YKRZcxwy5JVh0b6Xkb8BbY1MlH7Ny01P5of/uMeWMHS?=
 =?us-ascii?Q?5dDzvUH/Rcs3D2oTaJUdPE4ySZSbE90lW9ON/MV8qNoDeZiq79j9zRpWBtm5?=
 =?us-ascii?Q?VLOabJOTTxhh6A6x2NJZyvthF6XquAmVOKqxxC7GjF9jlQ2R7WcdAGVLj6Em?=
 =?us-ascii?Q?IELdPGe+ilnd2n/d+A5whzP3ln9MVzmMgQsZ/8Wp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbb2574-713d-4148-ae17-08dc12cad157
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 17:29:08.6330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgVf2bbFq8p6CjEnJX7c5vC4dtD1KdqgzjdZjD06cYrS6ItHIXI1KWzN5caRS2SXeB1du0S1G5hwTCY5kUouXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7200

On Thu, Jan 11, 2024 at 01:15:23AM +0100, Alexandre Belloni wrote:
> On 10/01/2024 17:25:03-0500, Frank Li wrote:
> > RDTERM in MCTRL is 8 bits. Add a length check to prevent silent data errors
> > when the read length exceeds 255 bytes during each i3c_priv_xfer operation.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/i3c/master/svc-i3c-master.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> > index bd10bb698da0f..181b56953fb28 100644
> > --- a/drivers/i3c/master/svc-i3c-master.c
> > +++ b/drivers/i3c/master/svc-i3c-master.c
> > @@ -1375,6 +1375,11 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
> >  		cmd->len = xfers[i].len;
> >  		cmd->actual_len = xfers[i].rnw ? xfers[i].len : 0;
> >  		cmd->continued = (i + 1) < nxfers;
> > +
> > +		if (cmd->rnw && cmd->len > 255) {
> > +			dev_err(master->dev, "only support read less than 255 each xfer\n");
> 
> What would be the end user action upon seeing this message? Is it actually
> useful?

Hold on, I found an method. It may support > 255 transfer.

Frank Li

> 
> > +			return -EINVAL;
> > +		}
> >  	}
> >  
> >  	mutex_lock(&master->lock);
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

