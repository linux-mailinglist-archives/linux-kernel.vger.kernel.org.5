Return-Path: <linux-kernel+bounces-7427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2F181A7CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0FF283509
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F005495EB;
	Wed, 20 Dec 2023 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wx3ZWVgD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FC1495D7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 20:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rib03Pw8Go9JUBIckA/VCOuavgMsAJxCs3LueeuFVeqZojsLvli9aKnBMwB1DryqbIOcEyu/vvYGOjjdfNjToe221MPVM5CHrdGxDR16Kx5yhz5MelBRBadJ34hrRxa74JEiN1R3rgyG/WVqdbwgNko/y2Nw0jv4vNkzU37H2qHZaIgiEI5LpLCJkR48UPCw1RLWRSCYu2ZAxNcm0GNMBJEtYWcCB6mfir2yvMvrTeskHcAQcNb5k1xcCjPYWiVIEzcjVmFsmgPmOApZrsjVlZdmuc6HD9LD0rB6mkRSrJspOvnLxw/IRWMw2jPwetkhpfLE/uO5/w5YaHwZ/3pcpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMmqdNqWeBI/k9PJ5woNz6J3+/zQQRQaw3Bwp4YM1l8=;
 b=YZVU1PhVOEDyvXm58AjwTpRImHIjdytLzzdvL8sE1Tos2S64xIIDZsS0oEXyaeLyN7x9aHmlu+d/r1YLFxOO+kyvmCL2VO7UWOyV1SbAw7QEr6KL87FScc1oLiDiW24izxtJ9vMYo8Qx8UYJQYGKyoKqi00GrBzDpnkERv/b1gXchQSf082nJrMaTFzQZmEkyQcXLW30n1neygCtDOIKz5b3AI6GiiGGqbyB9bWXzrL/Zx/VG44UmHWeYBfWyjw07mVzIUyBllsoPL9a0FDWd9GdoCTazQQQGfAAk296dX0uL6O7Vs5HvsFAM9rLE7IKnPS6KZ8oOEsKfzDIDJkZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMmqdNqWeBI/k9PJ5woNz6J3+/zQQRQaw3Bwp4YM1l8=;
 b=Wx3ZWVgDyC3Ex0OwIaOCzSiorQYe4j2n/Szsa951/Q5gofpgRnMPth0+Gu9xERuZMdc9fKempk0OgAgd8l7wCXzOP2rcFW88fA9O3YrrROlhb577yKa7kq+Ql7vmsRqNlYtKhMX2yv+SFPEhnp133KCf2/eIQPfs/NMPFJWuIPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7729.eurprd04.prod.outlook.com (2603:10a6:20b:24c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 20:56:06 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Wed, 20 Dec 2023
 20:56:06 +0000
Date: Wed, 20 Dec 2023 15:55:59 -0500
From: Frank Li <Frank.li@nxp.com>
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	zbigniew.lukwinski@linux.intel.com
Subject: Re: [v5 resend 3/6] i3c: add actual_len in i3c_priv_xfer
Message-ID: <ZYNU36BoLwMVyHPv@lizhi-Precision-Tower-5810>
References: <20231201222532.2431484-1-Frank.Li@nxp.com>
 <20231201222532.2431484-4-Frank.Li@nxp.com>
 <2cfc670f-56ad-4453-82f3-d72dcfd05840@starfivetech.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cfc670f-56ad-4453-82f3-d72dcfd05840@starfivetech.com>
X-ClientProxiedBy: PH8PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 5342cd92-5a57-46d6-42ca-08dc019e15cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pduo9ZDSdBA0FwFy3dbX3hLPyVPf/4kDrj2PUXwotG+lFuF3y4goOgPkUOF+CvFuhMM39rLTmY7Bc34mBGPIXAOyGIYUUmK285cWSU1SAaR51Lr/evqZklM22DAVyWwapIh3Lqk1AAaq5T0eWunKhd9d700A72Ci4pbaAhjqaTZDQJ0i503J9//l2sDxWW/hKPnRiCYDupHPmpR7C1Apy9NYAunqQjK3uY9NNKIkW//B0v2qVkpXlNqJ/Fj3QiAqj6NhLh5/pmwlHoWCt2G6HwavoqDvJCiCDZ2+crhsYQwxb1QYqH9JUmmiQu2Hn+P76rOzKWMofAUWJ7fFFq9A7tK0svA8B8uMYAcNPWZtbUjF7kc/vOTuKFGJAiIBtQ3WAkQZVJKZ1Lggs32jzaUxHUfLtypAigLAEzO8U7G8oF4mhMz3BC7OqyqERd6dCM2QL0MEMvJctKVxmqJ4XcBRaVRkFj5bJ1uALVUmA/75leRimYcazPzbjJZI26moXTeZ2UFOCOVxQUH68A+KE3YI66OJgXfAeZs8smGUwt1cCMrg4buZVzgAdMjRRcMi9ag6o2jC3IHoFBsqP+Q0IziEWj5U7gLeLv5NA5n8MnOB0XAfBDz8jbPR5MC54JbOJ8BN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(39860400002)(136003)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(33716001)(38100700002)(38350700005)(5660300002)(4326008)(8676002)(8936002)(2906002)(26005)(6486002)(53546011)(52116002)(9686003)(66556008)(66476007)(6916009)(316002)(66946007)(6506007)(6666004)(478600001)(41300700001)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDNQQ2lLL0NiUUtIQkJrZGhRTUNvbTE1NlJmbmNqa3U1MldHWndJMXRtV04y?=
 =?utf-8?B?TG9tbmVhOUx6MmEzUnBYRlJUN1NMbU0vY0I0blBROFQ3NWpCWUhLNVlWekF1?=
 =?utf-8?B?TW0wbVYvdzcySmQzRWlJdEVTejkrZmVkRi9Ca0swbW4xN01pVjAyUUdtVURJ?=
 =?utf-8?B?VDlzbXNkUDNuUG5YK0ovRE54MCs2ZmgyanhjMG9sdld0R0RPWE1Bb08vTndH?=
 =?utf-8?B?aDB4N3plWTl5K1puQnM5OTdGMWdpTmFWY1RzL1J5TElYd1VjNFBCcWJ4RVpp?=
 =?utf-8?B?Rm81MW9jb3I1eU1wUndpY25kVkppS2JUWWtuaXZiSzhJWENjRFdwRzJ4ekFS?=
 =?utf-8?B?MVB5cHZkcFVTamt0Ymh5d3JZZEZRQ0hCVVNLZHlja3FWWGEybW9WL3pZQUdF?=
 =?utf-8?B?VjRWSGsva1R6dnFGZlJTdW5iSTVmRFdyZHY5NmxUVzgvQVZzTW0yR252OEFa?=
 =?utf-8?B?eGxvUTg5TkJDRFVHYndNdVRYbnZ4WEFEWldwN2ZTbUFhVVBSL1B3eVZ5TjRP?=
 =?utf-8?B?NWgwN2RCcGhhMkdLbzN1WXBVeFpoSkRNdTd4a3FKci9lVTdjVWo5RWFTcDAw?=
 =?utf-8?B?MTczQzE1UVRVSVV5TGZIZ0toZ3FnWmJhWTJ5aVNVVkhJVWUvYXB2OEJtaHNr?=
 =?utf-8?B?TURLUmF3dkE2aHVBUTcwbkY4SnV2Q05lSnBIWmdyb1RuRndXNURHSjkvV0Y0?=
 =?utf-8?B?eENSYWIrMzR3ZGZRZ21zWXV0UGoyN2pPeVFvZG51UlRVOTBjZGVJQWlIcStC?=
 =?utf-8?B?dE05NE80K1NtM0RUanFHaEFGR1IrdmlvYnBUNEh4elhpb0FHcDcyblh6OE9B?=
 =?utf-8?B?aTgzUndjMFlkbGRYQnFQYkFoOUlHQ2loWnN1UmlSQTNrNlZFcG1aMjVvUUFy?=
 =?utf-8?B?d0lJbGlGOFM2VDFKUVJreUNGTFoxblVMdUU0bGplN3pleVo4cmpSZ2VVZjRN?=
 =?utf-8?B?SEpLQ0wrVG9vbTgxbE04OWMzNjJxd0VUbFN1Vk9COGFFUXl1enNaQmY2cTJu?=
 =?utf-8?B?VWJWUmEyS3FlMVpMaXRZb1JvUGlPMFpVREtkUEJYL21KNzRINVMyRERIdHBH?=
 =?utf-8?B?UVhTNk02V01ORGxBV1E2aTltNmsxV2hFL2U1blNaY3pzMlE5TFpURjE2U3hB?=
 =?utf-8?B?TjcwbVBvb0NydnluTC94S1g4TEhkZFRrWFd4ZVB1UG5obWp0cS9uc2ZHSnE0?=
 =?utf-8?B?TTVPVmZkSnVoTm5xSUIxeHNLSGZqWXIwSjdvQ0NvTHZ4SmJHSHcyQ1JXVElw?=
 =?utf-8?B?Z0hjd2hwVHhpSkVwZzlyQXNQUTBrUU9VUllDU1NWTzF2QXAxZGdIbjI5Tkdn?=
 =?utf-8?B?NDM4K2xvUWJwS2NHT2htT3RLQ2x6YWRCQXRaWUtoTnk1RlN3TlE1ZmMwcVNW?=
 =?utf-8?B?YmhHMnZXSGVFVFFPdy95RjVRZ01IbGxEUEFudDhENDlmckpjcTNZbnhsT1VQ?=
 =?utf-8?B?ajdXaTFCMG53YUo5VmlrTTMrQi9GZWhoaUxWTWVIZGhndWhlbG00QWdKck9k?=
 =?utf-8?B?Q2UyS2JDZmpIbXBjNHFsL3h2eC8xS1Ezb09Eb3RPNTlnaytLSUhUZ29JSmhh?=
 =?utf-8?B?M3dSdkZqZEV3WFA4T0dqTXE0ajBBelFpeXFGWHk0QWRqT2FaKzR2ek94N1k4?=
 =?utf-8?B?dys0YTRKQS9OR3RuekpUT2VwdUwwZGxCaTlVS3dkMmtNaVM4UXF2bUsvQ0RN?=
 =?utf-8?B?dWt0WGtSM0R3dk9UWTVXeTNMME82MEFOUUdranhRTUhBU3pZd3ROdXB2Zngx?=
 =?utf-8?B?ekFrckFqOVNhRExrWEdIQjNBY2tnamUzYlpac3dKb0J5cm4yZ28rOVJhdFBS?=
 =?utf-8?B?dXBubTRpcC9zUWZiOUJ3TERUbThWZEdGaVRQbkxkdndCZDYzRUJ6dkN0Q1Rz?=
 =?utf-8?B?QmNtK0ZPTlQ1U2huOXVkRG5Zc2ZMUmYrOGxEQWlBamEzMmx4NCt5dGZ2dFJj?=
 =?utf-8?B?ZU9IT3V4Q3ppT2JGdVBjU0tXczlSSFVKakdOeXROenhQaHpJQlZhcEx2aUlS?=
 =?utf-8?B?NE1ZMTBudHh0ZHVPdEszK00wZ09YY29qTXpzb25JSC80R2dZY1ptYlhlcFRB?=
 =?utf-8?B?RVJHc1J6NEJZNmg4SW53b1RoOHFnalpyckIvY2NURmE1ZGo3T0h2OGdGWnF3?=
 =?utf-8?Q?YU8FgF5vCYF4oFLC0pLH50zvv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5342cd92-5a57-46d6-42ca-08dc019e15cf
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 20:56:06.4288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrgdk7YiyW9srCIs8qj8ScKDULQYSBYztKC49sjj2XbGecDCdPXmW8jlz/rJcimwVERnT1T/fo7GbkovdNkm3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7729

On Wed, Dec 20, 2023 at 09:55:26AM +0800, Joshua Yeong wrote:
> 
> On 02/12/2023 6:25 AM, Frank Li wrote:
> > In MIPI I3C Specification:
> > 
> > "Ninth Bit of SDR Target Returned (Read) Data as End-of-Data: In I2C, the
> > ninth Data bit from Target to Controller is an ACK by the Controller. By
> > contrast, in I3C this bit allows the Target to end a Read, and allows the
> > Controller to Abort a Read. In SDR terms, the ninth bit of Read data is
> > referred to as the T-Bit (for ‘Transition’)"
> > 
> > I3C allow devices early terminate data transfer. So need "actual_len" field
> > to indicate how much get by i3c_priv_xfer.
> > 
> > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >      change from v4 to v5
> >      - Add Miquel review tag
> > 
> >   include/linux/i3c/device.h | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
> > index 90fa83464f003..ef6217da8253b 100644
> > --- a/include/linux/i3c/device.h
> > +++ b/include/linux/i3c/device.h
> > @@ -54,6 +54,7 @@ enum i3c_hdr_mode {
> >    * struct i3c_priv_xfer - I3C SDR private transfer
> >    * @rnw: encodes the transfer direction. true for a read, false for a write
> >    * @len: transfer length in bytes of the transfer
> > + * @actual_len: actual length in bytes are transferred by the controller
> >    * @data: input/output buffer
> >    * @data.in: input buffer. Must point to a DMA-able buffer
> >    * @data.out: output buffer. Must point to a DMA-able buffer
> > @@ -62,6 +63,7 @@ enum i3c_hdr_mode {
> >   struct i3c_priv_xfer {
> >   	u8 rnw;
> >   	u16 len;
> What happens if I3C device does not terminate the T-Bit because it expects
> extra length from master?

If devices don't terminate T, there are two cases.

1. Master send STOP, then START new transfer. I3C Devices can decide start
new transfer, or continue transfer left data, which is totally up to how
I3C device and devices' driver implementation.

2. Master continue toggle SCL to get extra data. Just like a low frequency
at short period.

Frank

> > +	u16 actual_len;
> >   	union {
> >   		void *in;
> >   		const void *out;

