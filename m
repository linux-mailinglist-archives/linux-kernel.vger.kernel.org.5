Return-Path: <linux-kernel+bounces-7986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA03F81B026
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D901C231BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6AD168A2;
	Thu, 21 Dec 2023 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VVKnrgD1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2078.outbound.protection.outlook.com [40.107.7.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B9115ADF;
	Thu, 21 Dec 2023 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGyZueoK8+s7hk+NUbeMAz/KwxMl8P0HdLBn9u9+1lS5j+7v8d+Bnl5CjO4pqYjlv/615Z+P3Ikz/vREhnmFFq6d9Pi3yHJL/yUtwhP1lRiWsPr6ThDsmsFdKkQiMIeIOLvp4LPFkef9PdpeyZHjU8U5dIJsaUDy/we/TYbjoRqX6/c/7fIpvtju28Yrm7KTy+T+KQllp12ozDKhZkjuRW4FSt5oKIohRMN3b1pn8A9PtyNXdEGK1v187/zXY5A0LZSDdLLtI69KeCBHW3IwSQ+GXrp/ukelXtqPVFNhh2P9g8aCmOegay9vu3HdcAdUvyUFt+4IrCgtaYGMqejoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tg2S3wLN8Z+wikB+lVEAgB53/GX/ZMq4OIPexO5J+4=;
 b=UcM2nK+opPWrXym68tNj1uhw3YvRWWnX0hLj8QdPuz2+evzp1uiYoDtVewO4gAATX5OOdNXOOs14cfaKx0eXe23+wpcA1Q+OC83TJ7RaaLD7sx3JNJgOfL/5GghVzKnexoK+PGEnYJxtJW4Bi6x1SJE5tnw3dRq0XRcYpKCWdSEy1/6rH9hJHKE1v53M5Grs4KCZq4AQoR1HjBx5m58gwDDLN/BQ8qy2lraQypVCIsJeXLKUgjw8ZUQwl5fMI4k3At5dDTMFdkuWwzP8nD+b6ste95xkk/nBxeFgD90/VnslKRgEtyAjzpp3GpZ0MvI0/EltDjY3Y4EHxnUpfOBbgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tg2S3wLN8Z+wikB+lVEAgB53/GX/ZMq4OIPexO5J+4=;
 b=VVKnrgD1RMjxk6TJmWMHrxsisixrNTg3QRAFrg9Wa6zfLwoir/ROFRVPQmZdELRFnWIlwCv5E8Of57NRSL1yfVqRqOUSfydku0r5hp2V6xaXbOFMGQFdOhJdnNfrI8MVkkh6qdKPnzIRA9vh4cY3lpSUTkg/Jh1w6eww+gf0NPA=
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by AM7PR04MB7077.eurprd04.prod.outlook.com (2603:10a6:20b:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 08:18:00 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::1f29:340e:75ac:d14a]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::1f29:340e:75ac:d14a%7]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 08:18:00 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, kernel test robot
	<lkp@intel.com>, Dan Carpenter <error27@gmail.com>
Subject: RE: [EXT] Re: [PATCH v2] wifi: mwifiex: fix uninitialized
 firmware_stat
Thread-Topic: [EXT] Re: [PATCH v2] wifi: mwifiex: fix uninitialized
 firmware_stat
Thread-Index: AQHaM7DR3u/SShwFuUa/fn/L/erKDbCzBjeAgABedOA=
Date: Thu, 21 Dec 2023 08:18:00 +0000
Message-ID:
 <DU0PR04MB963666CEFB54464D135DEC08D195A@DU0PR04MB9636.eurprd04.prod.outlook.com>
References: <20231221015511.1032128-1-yu-hao.lin@nxp.com>
 <ZYOlLanvv6DTGSw1@google.com>
In-Reply-To: <ZYOlLanvv6DTGSw1@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9636:EE_|AM7PR04MB7077:EE_
x-ms-office365-filtering-correlation-id: 217f23cd-6434-463a-908d-08dc01fd58c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +UUH2FRDB38cQjWFakY/a/LsJt+MHVag/5DgO1uUw/t2yE3mkbsmFXcl8YmQaK+CgHgt0TooBJibc7zcozb7E3OAYk5xmvq8F5rQ00pNreN3zYTPZk2+ttx79K4J8pqhtnUYmIdzaXt6nVCNHG0i8TH0Vq2u5mTktoAQ9Xp/6J3++6k3aDTDfm1DyvClyVMu5UfAdrThXIP60VV17jzQjz2ttMiYXLNZCSvbaFm7VWFKhwlZdGQ7hzKK60DNS25XIrWUT9ebab3wVmIhxFwTd7nnuln6CFiVcu3WiaordvY3rYNEcdLS+QMXo0SAw2zXf5di56K/Xe/UiOEgNY/jxPAtNI5MUzxT/KEj+4eoQ4gv9bSVG9hyeyxksKmHe7tkNm+W99UHB3kCi6DZKZ8Vjr9ik9OwjMFNicjcAL8nOP7TXqxbDif9Gm/OZGMCwQw//IoR1roadAa5CDzx8CXZ2eU580UV+VGChuelRu+8JNdUGKrOk+MFr/WYf9jd5qyuS80u7KUY9C460kqNJlJUKo0xqAdRhKfduvnJ/SXLtgF0mU3UbJC7yWNnPVjCzWvfdhglmUR6/AjwoDcyegwzjG3PDydvXsZm+MSp98Wpp9o+JpzXZe2REjGaMSgIgpjqRdxbP0SoIs5yjQFBDMwyMg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9636.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(186009)(1800799012)(26005)(9686003)(71200400001)(6506007)(7696005)(53546011)(45080400002)(122000001)(83380400001)(4326008)(52536014)(8676002)(8936002)(41300700001)(2906002)(966005)(478600001)(316002)(6916009)(5660300002)(76116006)(66946007)(54906003)(64756008)(66446008)(66476007)(66556008)(86362001)(33656002)(38100700002)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qM1BjZwl53RKW1Ey0Nt0xu4ZZbdFV21S62QGtdBQkIFgLaR75jumfqmPfbdk?=
 =?us-ascii?Q?8/9V/Uy1tI8eMUBXqhmIpDmtvGuPEQaW+OU7ehw6BY+KAw/lWfNxjAyJciRz?=
 =?us-ascii?Q?Xi4URcaXyMBPnXoJFvF+RkuofrzRWnzgnW7is3DoYnCEzOT+ocsDlkMeFAQx?=
 =?us-ascii?Q?W5+TFn6sQfdy4EVRPa5RAxy3x7e54sgzmn9FDMyF4GL2H7Z4ckHF6pidjukl?=
 =?us-ascii?Q?Bd6/99X8PjRSdzenlGN0OUhB5Q9KmyL1VUXUb5UX5V94N/0pa5yalYJu0SUb?=
 =?us-ascii?Q?1zqS9LoznaAdx/7/91WIDnA+5nsTOnV3mDsTOeZbPO05s/Xk0FDz3rD7o/87?=
 =?us-ascii?Q?Xsx22JcgJulqEyvYEnjolgIkQ8Q8B7td7TFrn76gp+Zp85ZuX4nioxxB9uIH?=
 =?us-ascii?Q?vc1gsMKFCMSD7kTv2sCjc426sby8iDBK4IHnB2duzMz2u5hqi7PKEQ5RwgOH?=
 =?us-ascii?Q?hfyOUywvNlb4PC02OrB+MVWgpFXAYMkAK0a81q+UZKiRjUxjGNlS2z6Ast/y?=
 =?us-ascii?Q?+y+/720MiXr9sgW6NdUuEHBuMWZPcBeiHBBJA6q4lzMHwbW8vjGjXPdP6vWI?=
 =?us-ascii?Q?R4eLIKJ14+4XMseTXony7qQ4LLq3ZCZH7+K9AQZcu0sgA55iNTRFVHc/fXv/?=
 =?us-ascii?Q?xOnxVWvWG3Mss/4awG1Sxn/VZiHKn/DRiUvRueIrLX3hlzzcFfzSnfVrps/u?=
 =?us-ascii?Q?Iyz7uo9G86qrj5b9qVouQizwfT6FBU7WtZKTl8mq1GsV2zq8hbJk1AjfjAnn?=
 =?us-ascii?Q?jyZX4yynT8F79xcPk+/lxraCGGZAqMhRDQKGIBwjtOwRCeUqJYojJNXv7wy5?=
 =?us-ascii?Q?fdmxKp9bcizx9npE+K0F0sM5Mzl+lRI3C4/eP+RilO1yiC61u7+fTZ47gl6F?=
 =?us-ascii?Q?QAP38lP4h3YIku+mDLgAOiLJUF0+HbzLUWnT0FRFAmrDgi5/qt+dl3AbiJMo?=
 =?us-ascii?Q?R6wvFHZ6hKL3BpXFooc2+FP3yPuG33LJJB9efZQc4Zi5q5sgzWhGtEShtrSX?=
 =?us-ascii?Q?GMcZ2wsQILlZYmY9ais6LEwwGDaCBhh0PbhUgSnTNWsIS+g9IZ2dZuN95qtZ?=
 =?us-ascii?Q?a/4eRGB5tfvn1uBZiP758tjE5KksX9owjy8W1TKXwrHX1m/zmRDolSVqHjlu?=
 =?us-ascii?Q?g1ntJCAy0TAGgmPwSRaWOabxEJETovgaJc5XYKCbGJJRTDEMd8wYwMQw+Xqc?=
 =?us-ascii?Q?MfR7BlwZ7oZAysl0Ev4Nf9t0e4K6BJDOPYm1JASYQNWbyKQ2lSyePyczIG3J?=
 =?us-ascii?Q?CNfQJjdstigwPDd2wZM3fW124G1c2IpykF/sKw6rODq5AkF750QvJn/6shS+?=
 =?us-ascii?Q?Hjr7SgwTuQ7ABNdK6cAHCtJEvnP7rHpODwJWOQRY81bUex66lr7OxtfUTQI9?=
 =?us-ascii?Q?Pnco8Xj4lcs13SZ8TV3x97Qn+F1dXxpPAKtcefx1c4eFBLiZ9ExcO5686rzW?=
 =?us-ascii?Q?RuVJP6CE0oz7ATQymn9sGsi4pqP3JBa99MIRSc0kVFjg9SXm5OUIYPH/+oiE?=
 =?us-ascii?Q?M0rMlYkesupOW/uqDMQI5NAkMHgfS2TptOIRwgEv4r04ha8vtoI8pfDV/b+V?=
 =?us-ascii?Q?WJTf2XH0ldR/iUFggPqOnoAuTNGYO0Ov7E6sQsJ4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217f23cd-6434-463a-908d-08dc01fd58c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 08:18:00.7205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Ds5jtxkHCdlttdIP7X+BQ9A0f55fy33K08oRd2iUsmjWWb5mCPizET23BsXI0WyvbF+LRmn6s5yAna2l3Aemg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7077

> From: Brian Norris <briannorris@chromium.org>
> Sent: Thursday, December 21, 2023 10:39 AM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; stable@vger.kernel.org; kernel test robot
> <lkp@intel.com>; Dan Carpenter <error27@gmail.com>
> Subject: [EXT] Re: [PATCH v2] wifi: mwifiex: fix uninitialized firmware_s=
tat
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On Thu, Dec 21, 2023 at 09:55:11AM +0800, David Lin wrote:
> > Variable firmware_stat is possible to be used without initialization.
> >
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > Fixes: 1c5d463c0770 ("wifi: mwifiex: add extra delay for firmware ready=
")
> > Cc: stable@vger.kernel.org
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Closes:
> https://lore.kern/
> el.org%2Fr%2F202312192236.ZflaWYCw-lkp%40intel.com%2F&data=3D05%7C02
> %7Cyu-hao.lin%40nxp.com%7C813d1bc65e8b41e8349808dc01cdf23f%7C686e
> a1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638387231239605883%7CUnk
> nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1
> haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DmGQ3tVhTOnyO9wXiE
> qI%2Bsym7LqLP5B6bEMofhhsXBzg%3D&reserved=3D0
>
> Repeating:
>
> Acked-by: Brian Norris <briannorris@chromium.org>

Sorry. I sent out v2 then I found you acked v1. That is the reason I won't =
add "Acked-by" to v2.

