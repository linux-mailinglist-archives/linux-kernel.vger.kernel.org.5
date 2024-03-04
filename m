Return-Path: <linux-kernel+bounces-90003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBD986F8CE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C77AD1C20B12
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65B64C85;
	Mon,  4 Mar 2024 03:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b="IBTH8ntC"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2095.outbound.protection.outlook.com [40.107.93.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46144409;
	Mon,  4 Mar 2024 03:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709521943; cv=fail; b=hd3eX+RLhF/0W0fWyqe5f+9k+bxve+JaKwCnsVsR5C4SHEBhsx5ow1RQvQrLzGgq5usqqg4OXJ3osUbbSMvD/jvdfVylV50XJpaIBEWWI3na3mj2nOJHPEd9vl5upZI6fiNHHd+ZSGWI7d02I4PtNUCvq2P3Y5F9rc+09sMSWk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709521943; c=relaxed/simple;
	bh=70O5LcAUjCcScCSB/AUOjnRkjW4rSGZHKRVpuYN3qK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sUpEJbQxz2/o6f8qv2zjvsjS+nkV1gOcx2LMOh0yWPk1Mz4xndXCbSl8ZWXvLOYgvcMiZ/TyyzpjSVbzfzUe6yk5y+lYU9j0YY20uFOp5bNkdis0Y1PxWkpaOs+ogu8sNZbrP9Psd6mMG0i2xu7dWYIa6blbqCCfgfJWpW95K20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labundy.com; spf=pass smtp.mailfrom=labundy.com; dkim=pass (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b=IBTH8ntC; arc=fail smtp.client-ip=40.107.93.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labundy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labundy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMMrIvHlJFaBsl/oAAs/XT/E/gUxtxs5bqLlG+S1JQA0IgC0hbVjX4hhEMgdjxBG+MSkaUMTj/5mcKnYvl12CKcuLnivfmVhlLGkIOfGKLzl93ofxGWEInsp8tXF6i11F/TlmjFdrGkOoOOJOIlFtAx2tGpi46bsobT+l8Y7pgVhKgmqbb6rrqaHtIIrQD1USIAurqhQEBpuuuZvYWEG7E3Sdx0PZ8E3lBhI4/d2vJ0OInjsmJeita4v9qfAZJQq7u7xzMx6W+ZU4xhHIjSoVCzmxtEkUI2aXaUOeC07Pr0Mz4jbRkgnb0A0j8JdFwE6K39KowNZZjju3gH4yOE7Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWzNmacgIfxOS7h/zNF6ne/BeuEnCnvx0e6ALDYcEUE=;
 b=MkSIPDnM4zvMzeyj45481lKom0tBqN0BhlGi4k7kCYZU70q6Djp1Ir2UsQLOTw6B9uv4OycSAlbrI7nzt6QgjrOfH6CP6ky2Ji1pR7I0h2zBxA6Kr3xunyaFYmjp2ZVjDDqEUq08iwZNoYtnzT6y/bL79seLTmavIWh/WzcLU3V2Fi4siveH2IAquDL90PW3qJwVnBYv9YGd1jhbjX7PACDr4jETmKqu0A4vyZ8y+fKonKwqPrF4QZyiIoY5xdLxjjvmTd88MR9PNyCDPgVPLPJ6qwkcvmgCotmY0b47eXEsuNcAZ3A1P9KievgAqGB2fsrpAWSjBAjp7yp4vgXUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWzNmacgIfxOS7h/zNF6ne/BeuEnCnvx0e6ALDYcEUE=;
 b=IBTH8ntCCvuk7lI/sqxRyykAaavTr6WtwvQ5u388LKTxNl6PI1Sast5wCpTNbwpKTlt2ilAkOmg69iKlq4HaU8DVEVwPoNyfITQ6XE0oe8JRAKDd6jlFrMErs9kq19B7SOVQmHwg+O1XjeS8QSdoyzjfQKJB0HqdJWSDN1WSJr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CYXPR08MB9561.namprd08.prod.outlook.com
 (2603:10b6:930:e1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 03:12:19 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::bea5:3186:8a9f:52a]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::bea5:3186:8a9f:52a%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 03:12:19 +0000
Date: Sun, 3 Mar 2024 21:12:16 -0600
From: Jeff LaBundy <jeff@labundy.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: iqs626a - Use common error handling code in
 iqs626_parse_events()
Message-ID: <ZeU8ENmnPj3sKxAv@nixie71>
References: <8a7607f8-d634-415e-8269-e26dcc0f9fdc@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a7607f8-d634-415e-8269-e26dcc0f9fdc@web.de>
X-ClientProxiedBy: SA0PR11CA0032.namprd11.prod.outlook.com
 (2603:10b6:806:d0::7) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CYXPR08MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: 113ff79b-b73a-4b84-73b9-08dc3bf8e6fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0rSJKm5O6DS61VOzVrqz1Z9D4MHmB7v15MVb4bul0IHmH0woB9FF837pyUzlumUXTC3fw2Gz7iM2dO5mlWgFxp+Vi3Daj8WYAQsnOSsNoqE/5XqTi67zUWJsFysNonf4W+a0H0HfS90a06FkxADoxNMANT2ELkpbFwSgMXBh2FhNsNzBBWy/fFfGdxtjC29SLgEOQ5VdvaRcNrO6SajH5/Oh51iqcpE9CDMUTptSWgrlxup5pSPRmi6wwLgOsjOFOWbTlSDb+hGe42krgMPX7wOXHYiadre6bCg+2sunl1LNemsewKVQPHEFhZhp5als0M5utepxx3oTuMxu/8fV6ON7J9zP9SyBk8cI0jL3x2O3VVSHQpJcOWZ4BvU8VXX4WemwQ8thmVELZO339YSDabFeTmcXTHa+t1MFoJFct6sALrOzFu4W262EhQI+iCft+RB2dCS6R5TeoOjYs/S8mPvYSD6NP+5Zbf78cx/Jyr2tI3A6oZiSoUeyYQ9slmTJz92Zwv9o8cbFatljsbzd1Sf/m6SlAHBsiiH7bFGeZG9B50q6rIsy7b49YevdF77d+TOxSgxDHYzXyswVNUzBAJ2NqujDiz9TYvqGMoW/8t5VNbnIn//HsCgF5X+szl009Wvuf4U3lK06xYN4F0lyX08MlumHWMEQQ02NSewhtIw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a2lHmfglIKKJurNBZTSC2zX+lPshmFMXJYVWz7NvWhymjufqx2ZkYOAwOvhG?=
 =?us-ascii?Q?sj+E1OBMw+u+Wx2QLvgeCR432NhY3742s4TOX/ziwipFiYK3GTNuXsmNHWHJ?=
 =?us-ascii?Q?LfkQAwYbif0kCfWfGeARz+fa6WWOxlCfx7g4YAMmZbNep17YDme2ES4pnVZQ?=
 =?us-ascii?Q?s6nKUsubICGoLxF4OLA+HTEw+iD5kynY0VVYxuq96Q6iBMpLK/GyeOpAtoQF?=
 =?us-ascii?Q?ljKk8aTHrhXfHMIikt7/M9lZiKY7bMx5X7nwI3oLAQAv3y4FH+4zyJOObFUO?=
 =?us-ascii?Q?jIvn5z2ph3/zi8JRm3Kwpif8npJj8RnK0lbd8QdN5rAB6S1ufGxcM6rA4xRG?=
 =?us-ascii?Q?gxEeuAEBeJUdIqw1dM3Q+uLMOqiuv/vSTSC7FRvpSDGSlsR3KVK0pdOo3HNF?=
 =?us-ascii?Q?4OSa1mBjmYvHEiR7JHfYtiwdiJO4lFyOLfyFkd5Ase06R/v/tdyhrklbs2vD?=
 =?us-ascii?Q?mGcnKACV5DniUWLUDEyFrZMEGuzhcscim8uupiXJdRZ6cVokRyM6k8WU6o+2?=
 =?us-ascii?Q?C5j9eXoXpbugYA2A6q6fYzoz3XvdxOog4OwABPKv76GhKKgd+N3hKkdzE3A2?=
 =?us-ascii?Q?WTs/Mgqu97E2tO2nYhkMwCH+cbEgUOGIDW77k09X8mp3Yf+ojcgDgP6g3XS6?=
 =?us-ascii?Q?mx5qWIu6V5mH7fcG8e2H/rpXxyytaoRWuio6iwQM1LOMk0I2hrW8sl3IRZ/a?=
 =?us-ascii?Q?p0NJw4a2fhWtvJqleDCJY52jC9mAbNqgWY6TXQGDuY3/cYKB/7W9SXe0s9dQ?=
 =?us-ascii?Q?0iZWxsFI52Mbk/MFctTO/flMNBRuQT8WnvYskiS698aPzaK07SRu+C4mokmI?=
 =?us-ascii?Q?wf3RG3SHmE1NTW0pwFZpXOzUXPB3KI6KZOBX8yUNLuVkC1s8vGnOyJVwWnj6?=
 =?us-ascii?Q?IsnKeNLPd4vtZICWb4ELYhCjaD+yIZiuUG4afI83NGljew0XswCyrU8bhgRT?=
 =?us-ascii?Q?SXPI8DZsRFGZVpfsLWAmZGPbo1PEIsvouIZAefLjTHILS2QCNnLvuDWPOX2B?=
 =?us-ascii?Q?vU/1fmshSuhE/nT1RFvzyvAMKP2y5Tql1wOjOAhFzOMi5IFWMjXskuE5F3bD?=
 =?us-ascii?Q?wIv2l2AdxHduf53P11k6X3qAiwKcHLnkXABaRpw5V2Yc2phQl96lSlHAFI+k?=
 =?us-ascii?Q?EFZ0Ff599SSlDsdB30cmQ6uo+ry8hM9tHI30sIh86cxehBHnKwP81qqroJOu?=
 =?us-ascii?Q?f3V5IlANCjWACa0W8T6ybWi6h1sy6xY4gqW88GH+EVjbc5NMe4xo7ZGcWUgv?=
 =?us-ascii?Q?X/DzaJbRG/dvfH30JatfQnpTQqCXfNtXPuelb4dHAkPE02U4UDfR0KHAlxBp?=
 =?us-ascii?Q?GeH5idCSWvT1reqyhLrco7UvXjhyK2SM6ZwQOZtTPGm7Ou/8ZlHk3HyfRCny?=
 =?us-ascii?Q?uwf/j+YO4PwEQilkZbFRvNtAz0NerZpVROLfxII8bY+kJ/sb/qnHrkE8IfbC?=
 =?us-ascii?Q?YxZgNLCsBO0INj1KmQpfTzOa/SGTMqCcO1zd7ZR5bNlRRvrBBA/CBSD/A8oH?=
 =?us-ascii?Q?nFSPZNqmoLcuwMeeNENzbZ2sQt7yXpGs/AX6Uh/pLWR7MxDLo3lgL+f9uDUC?=
 =?us-ascii?Q?S2hAbFeYTbnczL0WKRc3BywCuQI9wBK5R1tBcfZi?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113ff79b-b73a-4b84-73b9-08dc3bf8e6fa
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 03:12:19.4148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIuZtRLuZVyK9IkMA7NkI3It38LqbyVHzmojwajTcvB7eJXONkHHXqj0TafACofuVQtrfbKTYIsw/sW3fxzPAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR08MB9561

Hi Markus,

On Sat, Mar 02, 2024 at 12:42:08PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 2 Mar 2024 11:44:17 +0100
> 
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function implementation.
> 
> This issue was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/input/misc/iqs626a.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/misc/iqs626a.c b/drivers/input/misc/iqs626a.c
> index 0dab54d3a060..fa9570755f7b 100644
> --- a/drivers/input/misc/iqs626a.c
> +++ b/drivers/input/misc/iqs626a.c
> @@ -530,8 +530,7 @@ iqs626_parse_events(struct iqs626_private *iqs626,
>  					dev_err(&client->dev,
>  						"Invalid input type: %u\n",
>  						val);
> -					fwnode_handle_put(ev_node);
> -					return -EINVAL;
> +					goto put_fwnode;
>  				}
> 
>  				iqs626->kp_type[ch_id][i] = val;
> @@ -545,8 +544,7 @@ iqs626_parse_events(struct iqs626_private *iqs626,
>  				dev_err(&client->dev,
>  					"Invalid %s channel hysteresis: %u\n",
>  					fwnode_get_name(ch_node), val);
> -				fwnode_handle_put(ev_node);
> -				return -EINVAL;
> +				goto put_fwnode;
>  			}
> 
>  			if (i == IQS626_EVENT_DEEP_DN ||
> @@ -566,8 +564,7 @@ iqs626_parse_events(struct iqs626_private *iqs626,
>  				dev_err(&client->dev,
>  					"Invalid %s channel threshold: %u\n",
>  					fwnode_get_name(ch_node), val);
> -				fwnode_handle_put(ev_node);
> -				return -EINVAL;
> +				goto put_fwnode;
>  			}
> 
>  			if (ch_id == IQS626_CH_HALL)
> @@ -580,6 +577,10 @@ iqs626_parse_events(struct iqs626_private *iqs626,
>  	}
> 
>  	return 0;
> +
> +put_fwnode:
> +	fwnode_handle_put(ev_node);
> +	return -EINVAL;
>  }
> 
>  static noinline_for_stack int
> --
> 2.44.0
> 

Thank you for this patch, but it seems like a NAK to me. I think this is
a matter of personal preference, and according to mine, it is much more
confusing to insert a goto label after a function's primary return path
than to have 2-3 calls to fwnode_handle_put().

If you feel strongly otherwise, then I would suggest a helper function as
recommended by Dmitry in another thread. However, maybe that helper should
live in the driver core, as I suspect this driver is not the only place we
can avoid calling fwnode_handle_put() in an error path that returns an int.

Kind regards,
Jeff LaBundy

