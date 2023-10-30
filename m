Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B9C7DB369
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjJ3Gfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjJ3GfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:35:19 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CACDC1;
        Sun, 29 Oct 2023 23:35:14 -0700 (PDT)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39TNQLp5025267;
        Sun, 29 Oct 2023 23:34:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
        from:to:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        proofpoint; bh=Gu0JQoNERRbp2wjLjA7EI1/FWIavHzFYLpndyh8dRck=; b=o
        2DId5VYBl7Irv0gJtawTr6sDZePEXzbHpXQ1tsaBdPr4b3RgJ7f9DFCgFG6oFN9U
        KW7tBkCIsacI0LQ42PHZWvhtY2tVZA2wcB6Z+zd+Ud/85qzQAgmgnmRpsFD1dbg3
        L+Ppj8Uj9TfjhT0MTlAgW5EnzpkTwbwdYsXYVHS8UT9BUt9kbCmd3flZkwbyZgtS
        Y9khSF1xEGYaWRwjBuqaiJ4FSH8cqpwv17qDuhwQu7c1L5alZBEnsOerIFqDUID9
        N6TpDMTuOLUDmkgb30n/z7Ux1OaoXd2jS9+x57ilk58D6XstOo5b5j7gdNphZgtK
        jAL46i0e1ErgHW0vMDbEg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3u0xusn9dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Oct 2023 23:34:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I43PjNxaDByib2OUFeHsmLeTpdy4s6s4sgNlsQ8LBtVujVbY/djXtyoFV5eAXrLtiAAhPtlXiZkCTtuhcLjQZJtd3xB4s6LNvMn8LyFOhdWPcuqpbkHfB6Rwcjy5BhgPIRZDHWkV32u+cuV4StRhee5yri3RXcvgvTXiAquu9RFY3EoOdb+EFlPeueXmxCUWu43htsxPHJlwZCoppksNjiIIK0Vy8uPhTandUyS7qOxtn5DuoSu+F1fLdPKvkfyzUMpIOROP5kch23RLdEAgmcEy+sv8Qh+paP+Ro5EhIQ4n27TiIcLfhykA4nFIcGY1h3b629icYmMR2dH49L0svQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gu0JQoNERRbp2wjLjA7EI1/FWIavHzFYLpndyh8dRck=;
 b=QHniITdCGNgileMiY3zcovEJcaWekzdKpy4B7GJ0G8Dx4E/DKS4dsf4eJ7nB6Q5itWxBGIGxzwXE6PhHeMVd9QOvzZQ8mKMIoTs8jaQvYqMEWNV/EbaE1UCwTpQkD86WVG8LJ9nBaBUrbqza3dRC3/2nSU3P+0iOVut8reMY3ZMjhe5iFPFwnQQ2AepcJaGHGKcvCuIqJplsgw8EurQXxru4MU5tEztlFkjlaswGN1fpIoO4CEsQ89ksbNaUYWDQgHpQ4xqxYHpwsxx0gvid3UqOWCVkMljv8uBHUI52oSznESEu7CHBKZXhvqinLoJs5BbHpGAbkn3nKGqkHCfEoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gu0JQoNERRbp2wjLjA7EI1/FWIavHzFYLpndyh8dRck=;
 b=2WhkmwigfWY5CuzuPIqJSoF4+1AXIZJZ1Quf57owHsgQf9+Ybx49A6qsm1vjeaOcbTA1kM72OWvKxAr8QWkUuKM4eG7DIC3izsAOaaUU8kGB6aLlS8tulsX+5piidQpdw/szEiS3eYbWo1Yj3IPYWFwjpwc9N0+3yGq/VOhlNaU=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by MW4PR07MB9638.namprd07.prod.outlook.com (2603:10b6:303:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 06:34:50 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::36f1:c501:add4:45d1]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::36f1:c501:add4:45d1%6]) with mapi id 15.20.6933.026; Mon, 30 Oct 2023
 06:34:49 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Frank Li <Frank.li@nxp.com>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: cdns3 uvc first ISO parkage lost problem
Thread-Topic: cdns3 uvc first ISO parkage lost problem
Thread-Index: AQHaCPA13WAOp4MeAkqlygNsWSmHvrBh2GoQ
Date:   Mon, 30 Oct 2023 06:34:48 +0000
Message-ID: <BYAPR07MB5381F7224612F0C0793B6B29DDA1A@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <ZTvhEl+JcnhJXcrl@lizhi-Precision-Tower-5810>
In-Reply-To: <ZTvhEl+JcnhJXcrl@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNjlmODM1NzgtNzZlZS0xMWVlLWE4ODQtMDBiZTQzMTQxNTFlXGFtZS10ZXN0XDY5ZjgzNTdhLTc2ZWUtMTFlZS1hODg0LTAwYmU0MzE0MTUxZWJvZHkudHh0IiBzej0iODIyOCIgdD0iMTMzNDMxMjEyODU3MzUyMzI2IiBoPSJhSVh6Wm9PM2kra0dNbit4QXRlcEtESlFoTE09IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR07MB5381:EE_|MW4PR07MB9638:EE_
x-ms-office365-filtering-correlation-id: 9a67c2ce-227d-4301-b215-08dbd9125066
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WRIx+oe0PdTAb4N1lwxI+GEj5+Y3o4kUp7Kq9cVpKEAmHs1sfiWAwbLKqdI4WtRJtU7ewv1Nui07Q28Du/EA7cgirEiXRj21T3bbCHmBcZZTfQhLklkQaQN1dVmcQQiRhcukVGE0k3AiZP2C3OLz7HarBQn6DSpaDqbbH3wrDW7fHlgPV+GnetobdqFHkk7qDeCgRfqbUB0+qBUwyUz3nEME3DdFjA/+5L28UotMTfe0iTbDnVUz86lGDvNicepvan4xcrAyads2vVy+ZWN/BxVtvsssWuGUqQSd5mn+VylkW7vMnP+8E7QacmRudCZ5miYFZVGTznzUUT94iHDuBvKFStClOc+6LZxAQXpJ5j1Ho3AlxiIG/fdrGe1SpoPEWUbg/8R6+Yp0hxHNurGjxdyyYgCgjhb7cAmnFNM3uBpILb0E5pDZJvC2hg6l2d3WGi0kvtNnhkZwbv5vTDbMq0Ri5qiDIuwCBxKGIjX2yJreTWOJc1W+3nMAdd6IfcNqVeyKkvmHEljMtXITLSR0gyXYdT7xTH4wmoHPaUIchQiq5Qwd2rm6Pby6IyRZh+zi9gbjq/t25RMarxUJrtKNY6ql0mLtFK1ftrpCoy/L1OLrF77u/MTPb4nSUs6rdPAIKUwc29kriF+N2fYJ/XoP9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(136003)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(55016003)(66556008)(66476007)(66446008)(64756008)(122000001)(316002)(38100700002)(71200400001)(7696005)(9686003)(966005)(478600001)(110136005)(83380400001)(76116006)(66946007)(6506007)(26005)(5660300002)(41300700001)(2906002)(8676002)(8936002)(86362001)(33656002)(52536014)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aLzu7n0jCAETyQlAKXTGgWUEePYA8g0c9gja0PPQ5u8Pl2LJ3jhpGIXdNclp?=
 =?us-ascii?Q?Z65r5j60TevCl2DaVSZLIk2s6I9Lhq6mFcIfZadf0uzeVyWUoEiCdicyPalQ?=
 =?us-ascii?Q?m7CWj4W/PtF3ge5R/lThBTgDRDw/tTImV8lz8/gy7yQ/mCpARk/iSqkgzd8b?=
 =?us-ascii?Q?V8G8fXT1aljUYHg2UI0ut9VclK5f3wcjTyOtvEGaxAXPPwkWLt6bDDpoRAPd?=
 =?us-ascii?Q?GeLlqKe5gFqaBtzMlxqRouVpOdZdZPmdExsat8G95BVUCYnKxoMrjMydW0E6?=
 =?us-ascii?Q?IwFLWnzuRGtK2OMxW2eg18ndnJnp3s0CQoeQtRYKsOBJ81b7PpTYjcHyqH2r?=
 =?us-ascii?Q?mHFUpaOeg2lcR2YVHwd4qhMhXEW2qotwEwAxIgTPhTwCEXNNoftkDZ7Zpn1C?=
 =?us-ascii?Q?CbaWB5zlGp1HFbzjmNU5frBz7ssC5dXYhe/1vEvuXmI/Gt6ReNYvOua3nOLD?=
 =?us-ascii?Q?8o4Ix+oB7st3hCcOWc4hb8DD2rcsDaH//ffd2m0sUL0gArnIe9VUSIZ21lgi?=
 =?us-ascii?Q?OvAcmQYHfvTD2gqm4OgPpZS2IUPnNR+isQt6dk2+tB/pULW2++lJ7rlSL6ZF?=
 =?us-ascii?Q?f+HfHdsdym+ZhXm1aVtOGpRuMbIhSof9YkfdgS1LeAvRkJiagOJsnrP48aNO?=
 =?us-ascii?Q?XGESKHOpYYj5bV/3i/p6YhqPrIrene2a9h4MfnYqS+9sEb5SmP5BIY+niBsm?=
 =?us-ascii?Q?HM0TqjL8fgaSRTfOJj9E+e/FwK38qUihOLudcEzBq53dk5oeyq5cSrVv0xO4?=
 =?us-ascii?Q?KvbZFT79Ti/avJnqPkPNM7khu9zTD7OCxdS3YHT9EDvO08CLwvlGPvIzn1t+?=
 =?us-ascii?Q?dE4zJLOT4zZbTsXtqf0zh5laIj+SCnRZiLrqLdFr+pnLMvkaQ1u0jgueIdQh?=
 =?us-ascii?Q?/4N38QQ6a8+lWcHboXTJ07kDByW8E414sQTRAyfdukmzFik+JD/5FcnziW+e?=
 =?us-ascii?Q?FF33nfGUotEQUgVaYmmyq2HgEpSJpwMVJNDJvwtSYxHSBGedkt7J8oUh0a1X?=
 =?us-ascii?Q?qbau7kRDG6oMtqhSwKHPA/jKpofmygMPvv40sJhESPwO4UBq8Hy0p42DamwY?=
 =?us-ascii?Q?5cKWYzSFPNcSzAnnFScLc0FaEo0eEDatEpaVmwB8I8Up2cMWXvHhVLiIvZjd?=
 =?us-ascii?Q?9ANlxpCrZUgecfCshuhY3ey/TNlCQxoqZXutsGumyJlOGTCOhDj4fo0KBPqk?=
 =?us-ascii?Q?JX+Ai3DUWtbCdjdUqH3748ytdia9ckfgkenRwfg4jvXjkzRyvltjxzTzireA?=
 =?us-ascii?Q?jJnYaY7vGwfcdcfrkAF2WMoql177LC21MwFu06e3GvoHXw8XKlY3DCTTl123?=
 =?us-ascii?Q?MelWS1ZUi1CHWj5jFVNn1Fonwymh39Sc2D2i43gMKEbVY9uXq/6ZXas+83hi?=
 =?us-ascii?Q?jW8NFU8A6m/iKmcZ87Cld2OQQ17vjdc7zd/y7vwK6Tyxwrdjj9gOlWngPkDr?=
 =?us-ascii?Q?fH3wK8ezoNgZ040VbhK/q3087rvs+5VzGS3DNB+DLSVv6zjw1tz9kO873USd?=
 =?us-ascii?Q?WTmXLCkNQjQjnN21QABld+LfT/r7IS70ViSdVTVDgPzj17SB6k3FrDvVPTR3?=
 =?us-ascii?Q?SBg/deLHEtK0CBuQIydjtQ7Xb/EBRch741WpNCN1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a67c2ce-227d-4301-b215-08dbd9125066
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 06:34:48.4093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ke764k1xtysxzUWnVVuyX5zkLIFZMh1OTleY238tLfqIeFUK9QMj/wwk3um+BkPU4olA6kESFEyQzJjfHnMcoQ8IPxDLZT/SzJTl6rnV2Tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR07MB9638
X-Proofpoint-GUID: Y_-8z6jeGl8qi8UKRADJnbgaoeheyi7g
X-Proofpoint-ORIG-GUID: Y_-8z6jeGl8qi8UKRADJnbgaoeheyi7g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_04,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxlogscore=464
 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2310240000 definitions=main-2310300048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>
>hi Pawel Laszczak
>
>Recently, I met the problem when use uvc. UVC report jpg header error.
>
>Basic reproduce steps.
>Gadget side:
>1 -
>	https://urldefense.com/v3/__https://gist.github.com/kbingham/c39c
>4cc7c20882a104c08df5206e2f9f?permalink_comment_id=3D3270713__;!!EHscm
>S1ygiU1lA!H1h8GlLnbS6vqklXm_2qGyinP638O62Kk2eLB9zeMkjAGXUAPYyPXDL
>FasSqYt16xq0RGT0Ff-cP4A$
>	uvc-gadget.sh start
>2 -
>	https://urldefense.com/v3/__https://git.ideasonboard.org/uvc-
>gadget.git__;!!EHscmS1ygiU1lA!H1h8GlLnbS6vqklXm_2qGyinP638O62Kk2eLB9z
>eMkjAGXUAPYyPXDLFasSqYt16xq0RGT1ogOdRQA$
>	uvc-gadget -i test.jpg
>
>
>Host side:
>	https://urldefense.com/v3/__https://github.com/thekvs/uvccapture2
>__;!!EHscmS1ygiU1lA!H1h8GlLnbS6vqklXm_2qGyinP638O62Kk2eLB9zeMkjAGX
>UAPYyPXDLFasSqYt16xq0RGT1MNlKiXA$
>	uvccapture2 --device /dev/video0  --resolution 640x360 --count 1 --
>result 8qxp.jpeg
>
>	It will report jpeg header error.
>
>
>After debugs, I found two problem.
>
>Problem 1, sg is enabled. so uvc driver will use sg. each package include =
two
>trb,  trb0 is 8bytes header, trb1 is 1016bytes. total 1024.
>
>num_trb here is wrong.
>it should be
>	num_trb =3D priv_ep->interval * request->num_mapped_sgs.
>
>because priv_ep->interval is 1, I just simple set to request->num_mapped_s=
g
>as below patch. USB analyer show one whole 1024 ISO package sent out as
>expectation although document said only support one TD when use ISO
>(Maybe my doc is too old).

Support for sg  in uvc has been added after upstreaming this driver, so the=
 driver
needs some improvement.=20

Calculating of num_trb probably will more complicated change.

You can see how it is implemented in=20
https://elixir.bootlin.com/linux/latest/source/drivers/usb/gadget/udc/cdns2=
/cdns2-gadget.c#L412.

CDNS2 is different controller and support only HS but has borrowed the DMA =
part from CDNS3.
It was upsteamed after adding sg to UVC.

Regarding TD, it is true that controller can support only one TD per  SOF b=
ut this TD can contain many TRBs

>
>diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-
>gadget.c
>index 69a44bd7e5d02..8cc99a885883f 100644
>--- a/drivers/usb/cdns3/cdns3-gadget.c
>+++ b/drivers/usb/cdns3/cdns3-gadget.c
>@@ -1125,10 +1125,7 @@ static int cdns3_ep_run_transfer(struct
>cdns3_endpoint *priv_ep,
>        struct scatterlist *s =3D NULL;
>        bool sg_supported =3D !!(request->num_mapped_sgs);
>
>-       if (priv_ep->type =3D=3D USB_ENDPOINT_XFER_ISOC)
>-               num_trb =3D priv_ep->interval;
>-       else
>-               num_trb =3D sg_supported ? request->num_mapped_sgs : 1;
>+       num_trb =3D sg_supported ? request->num_mapped_sgs : 1;
>
>        if (num_trb > priv_ep->free_trbs) {
>                priv_ep->flags |=3D EP_RING_FULL;
>
>
>*** Problem 2 ***
>
>According to doc and my observation, looks like hardware fetch data into F=
IFO
>when get SOF, then transfer data when get IN token. Each SOF will increase
>TRB regardless it is ready or not.

Yes, but this fetched data will be sent in next  ITP.=20

>
>When gadget complete equeue ISO data, so SOF will increase TRB regardless =
if
>there are IN token.
>
>   SOF       SOF       SOF     SOF  IN    SOF ....
>      TRB0      TRB1      TRB2      TRB3  ...
>
>
>Host may start get data at some time after gadget queue data.
>
>So TRB0..2 data will be lost.
>
>If it is audio data, it should be okay. But for uvc, it is jpeg header, so=
 host side
>report error.
>
>I checked dwc gadget driver, which start equeue ISO data only get NYET.
>
>I check cdns spec, there are ISOERR. But it is never happen. According to
>document, ISOERR should issue when IN token and FIFO no data.
>

Current CDNS3 driver has disabled ISOERR. Did you enable it?

>I tried below method
>	1.  Delay queue TRB, but no ISOERR.
>	2.  queue a lenght 0 TRB,but no ISOERR
>
>My question is how to delay queue TRB to ISO IN token really happen to avo=
id
>lost JPEG header.
>
>Frank
>
>
>
>
>

