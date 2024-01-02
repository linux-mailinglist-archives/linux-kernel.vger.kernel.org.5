Return-Path: <linux-kernel+bounces-14574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD22821F12
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472021F22ADF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A440414F70;
	Tue,  2 Jan 2024 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b="dGYQJqm+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316E514A98;
	Tue,  2 Jan 2024 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labundy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labundy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMbtEvKEDv3T+l4uEJZOhEt5y2bTZOAlvhYnPSGpf/2pg48vkZlZHU/vqxOZeAUXMz7UM2ahZbQI8T3TjfyQXpTx6dLvh1QZ6oz6PZwK+bRBNVVYy4mU7L+y6dtEoz+Fm7pTDo2zIVSPXqUCVSKCxS6P/1oSqqw9SsTINykqnSWlRpfF+6ZZZE2CWOaCnGcbhZPDVMEvF1jlGpGHK/VVPXC2izOqvbwjXJTpBVxtW+h+IuljzZw/QPMNIykPcuAxNwvvwrvKP9xIj8rjFF6TetW0w5N7RH1F+4upnCa8QYYJ2SwP8GwMoLfd2/29O6NkBAGaf70WrHH3UDCDpX1DSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jCWEF2qkIo0nLmeTv7/YOGzlcgDA+97SO5n6YwS5nQ=;
 b=IrAw6GL3FUFJVjP9rRXPDpLyX7vCRcdwX1g4aAurcSw3oDD0hd03pjiySqRQ+1Z0cbIKvaHdiHqm4XgHl5A3q6GFxvQX1+kGF5hxZ994fJwGJ7d8YOFRz4HLCWeLtZ2lOKAldpxeeVQy8qYPf+lESyheMpDi2a2dzLoVNyVKtFwj2SjzdkCOW3rJxWooubGwznJr5v+/EqncBXgn49Qhel8fCpRE6T/hZvM6pQ++DIXfZxgGeFdTW7zQ9/Nydr/kN27ZCxK80sC5hVacSFbhwB8Z4y2BzEFdDQuuKzHZuln41UKcoBN0reMEkw9rXkjjwKLhFZLONb0gMRJKxtH/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jCWEF2qkIo0nLmeTv7/YOGzlcgDA+97SO5n6YwS5nQ=;
 b=dGYQJqm+TlsQuSRyssVlOQmqQXoCU4rMxFTbFMJHELYEqIIVJ62FxAKnoNz/UquKC3QXfVEpUQfZG8ZMyKJ0RD6HTE1qVG01lmuUsggKnuM3MWNeS/vkM52u7wuLbd5OftH7+nzaVwrztPRYzHDXAovXocpb8EMMyhlMAEzd7kw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by LV3PR08MB9607.namprd08.prod.outlook.com
 (2603:10b6:408:21f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.12; Tue, 2 Jan
 2024 15:58:39 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da%4]) with mapi id 15.20.7159.010; Tue, 2 Jan 2024
 15:58:38 +0000
Date: Tue, 2 Jan 2024 09:58:35 -0600
From: Jeff LaBundy <jeff@labundy.com>
To: James Ogletree <jogletre@opensource.cirrus.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND 2/2] Documentation: Input: support pre-stored
 effects
Message-ID: <ZZQyq5kNwOk6JWvH@nixie71>
References: <20240102145614.127736-1-jogletre@opensource.cirrus.com>
 <20240102145614.127736-2-jogletre@opensource.cirrus.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102145614.127736-2-jogletre@opensource.cirrus.com>
X-ClientProxiedBy: SA0PR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:806:d1::14) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|LV3PR08MB9607:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c0290c-4bf8-4f06-71c5-08dc0babaf2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xKftEwaYLf9ywLKn1bDx97xouU0MvgAMAMvlz4/TEK4Vcu0YufTAMi9Q2lTG9VWP1JWsAhFCCaHlaRUQbBBj9xFN6b5q9/tDYx1jUvmchhx+xS01kYmBz+0QNw220ESt7az2VVf6OdzDQVlKsGaCsH+MGYoKnLvEQu/yVnTCYmzCa63i8G21U+OWLct2OQrnhiPLjN7i+/e27PMTDkvwh/Fw3xXhAI2Tj82Q4Qx2KY/pmPTCfm71M8XwzzbLJUt6l4GioF5lT26TWtPaIDmU7b1gin9ceOmVKgNxZ1q2ZND3x1LfbD7LEjNo7hQ9QjU1+jvONVkzyFcJmcTg7pCi79/supXASxTcdh+u1Wlop+njMECf60VgUTnU/gT1tvZzq/hcP00CMjpqmqJN8U6R/bi/tn1CfPr48LW7RM4JavtdteU8ze5blG1y6gcHWa1DGtItzWr/kWSGfQ/L2Lf71v8cwVEJGbY2bcN56kCWAdZFd6YYB2YaVf/4E7t9b0KS7jTZyz0mHzJFv8IjNuCMp3ynXP+7zwPKJxHhVjFgg4QhkzgrYEwWquHIawEsmcqg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(39830400003)(346002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(6512007)(6506007)(66946007)(66476007)(9686003)(66556008)(86362001)(33716001)(6486002)(38100700002)(83380400001)(26005)(2906002)(5660300002)(4744005)(4326008)(478600001)(6666004)(6916009)(41300700001)(54906003)(8676002)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8a2nVicY5lPQqPuB1qAuj4s5xtzcbun4GD9gBvKliM120TiTWRZESlGS9aBg?=
 =?us-ascii?Q?wNgot5tu/igR2ykLC/m0LvUJAi9EsyhDKrJsYay+hRoXtWlyCTN06x1VlEhW?=
 =?us-ascii?Q?pSFcsjxGrZMtUJOVjEDgiVVBv5JK9VDBBKeJaGZ3x9LlLvFQUKq6ga2ZDEAB?=
 =?us-ascii?Q?ZDeHmhWe1rd62MQwjYjGX63XMNIG6/Y2hJaxknev7TPhuqc+/OYYc/fpt8dN?=
 =?us-ascii?Q?9qCs4KRocjCz66uQFlyT9OgUjUCeSvzmYhQf4hr7G9zZDkgw2RZsC3NDTox6?=
 =?us-ascii?Q?d7Z4yzO2KCQymUrK2EFM+kphe2T2Myrv/CNwI7z8M6wZPQWssJZNVwnYDbX0?=
 =?us-ascii?Q?0uDQmHUfqv8DYFQSNtHnwM7vj7xb9JCuvI9lzt5wBz8gJPbKMTmNZCFzcrNb?=
 =?us-ascii?Q?CB5RjjWdWho16Kg3c+Hj9stcfCRNv0HnZPG9D+e6s3vVc1BaKNERa7o4ylRy?=
 =?us-ascii?Q?jVnbjfd9/toytaR5WGAFjoqQU6OPluhujUBrVgmzLOR3rTT9ea6bDd17V6Nx?=
 =?us-ascii?Q?26O21munZTE47046JCUXDgq/+r7lXrJPYqQXr8d0Kc0BENIZwBo5XDSGmg0k?=
 =?us-ascii?Q?o8saAB2oTgkW9CmQtQO3MbGB9LWzaeNDHJGoYAIGJxV+SjXRhWcS8HBrWusu?=
 =?us-ascii?Q?kbwUppnfC1ge6OWmLfEJeociEHutvzf/EkDHNIO1Bs9bPddfttHvjzqgKBd8?=
 =?us-ascii?Q?4UlQWfOiqoLaORo5WHbOglNNa/b9nTG7R1fe1/8T2IDfOzMZ9StzsXxvzn6b?=
 =?us-ascii?Q?hA+fRoExrtdAld0no/3DupJ79xKNsYLDWPd06cyfAkr2MsnapKxqQcQB2xLa?=
 =?us-ascii?Q?5BPnNXCqa4Wjq4Pm4qP60PVoBNVVYUSk+zjqncKHJ6Lqk/+ieYRGWeC3utvh?=
 =?us-ascii?Q?OIOi1wE+8EK5q2iRWvzajio1p3JiQqXWquqHbYkxG7v82fBXrXr/cTgpNIJD?=
 =?us-ascii?Q?KQY9z75T1Qn5XGEWeoSCX4S7amo0EOEkTiy7IFQkRIE+KoAD5yntendEAa5Y?=
 =?us-ascii?Q?4IDfVp33fLYw/VqOXje+robQknaq8Eo+6LPG3GikU8vAnm+jcnr4/9N70iS+?=
 =?us-ascii?Q?wXsFT5U8VwOCKwEK9jkl7UUKK5yGQIhYyGaAiK4DoVp/cVOqPowuuCTT+3W2?=
 =?us-ascii?Q?VcwlJivEXgLEK0CvUNXavNRtT0cKuyA1PeNY3J6AlAfq/qyKtNUsgfP3WIWj?=
 =?us-ascii?Q?u4vCPh4kyGAMogl4W2FuqvJGYYpU7NedUfJGqoDGJMpzsXewyrI06PQhHMHG?=
 =?us-ascii?Q?VMZdYltUQniGPu+uwb0BOe7KLX+rC32RHU+b3dSl5+RS5TzLtd0AUPCh9vpj?=
 =?us-ascii?Q?YfOgpNylGXA3Yf91n2oU2Jfw4qIwWNEPq6uGElFd+HvIRTebgcHh2pTF2d47?=
 =?us-ascii?Q?uo9Zwe5hN9MEBqQ0S41ki89DON+t9R71zT//5XbqINmyZpM+BVx0HWvNbKze?=
 =?us-ascii?Q?tnUwPsPRafCvfC+CPhpglrhqFrlcyLkP/4Bth5EueQEV6XXtWu2BBc11oOeS?=
 =?us-ascii?Q?Z8CpYZDawBR2ABomUw4wFnavQQAVmp2TJQ9XV4MCd58eAeIIKlsGSBw13T3i?=
 =?us-ascii?Q?lioP9ekG6JvEW8QPgbRl77oIvuopGCehsj1dSr1X?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c0290c-4bf8-4f06-71c5-08dc0babaf2d
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 15:58:38.7662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /L0wG++uiL09aiZwrMWhfCDJ3kqcXrVYAWim+0nFBWyQ714WB9MaVD+hd2kaV4mTXFOAZbDsGkhuTw2fDpF0jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR08MB9607

On Tue, Jan 02, 2024 at 02:56:13PM +0000, James Ogletree wrote:
> Document FF_PRESTORED.
> 
> Signed-off-by: James Ogletree <jogletre@opensource.cirrus.com>

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

> ---
>  Documentation/input/ff.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/input/ff.rst b/Documentation/input/ff.rst
> index 5a1da42c33b3..1e0d00a42f25 100644
> --- a/Documentation/input/ff.rst
> +++ b/Documentation/input/ff.rst
> @@ -85,6 +85,7 @@ following bits:
>  - FF_FRICTION	can simulate friction
>  - FF_DAMPER	can simulate damper effects
>  - FF_RUMBLE	rumble effects
> +- FF_PRESTORED  pre-stored effects
>  - FF_INERTIA    can simulate inertia
>  - FF_GAIN	gain is adjustable
>  - FF_AUTOCENTER	autocenter is adjustable
> -- 
> 2.25.1
> 
> 

