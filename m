Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6597C814F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjJMJEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjJMJEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:04:23 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EB695;
        Fri, 13 Oct 2023 02:04:22 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CMthvx010073;
        Fri, 13 Oct 2023 02:04:10 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3tpt16hp86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 02:04:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DleMaNrVjF65h41LB/bYWlzMV8Dr+7DjFpYsXpgU/pBLOAK4DQk7NTrlWgaSu6FcRD/JCy5yRJE1/6MGaExvZLkKvXLs8gm+VW1Gj9KM4asvbVpy2l6+GO++cXmec7Eq5yKzxQgPJiFM+JUcPaRTSMjBXl6WXSKH9+Yu6V875G01yiTRffTQArGm4eWj3WjOzKQhyxtuKZ/6CdjpKlFdNkmYRuwoVJwpSX99GD6RsRQeBfFue5rwJTjAL8L4iV6nJkelqd4gASMAbVgh9pT+GRKb3kk2W7rbZmUvJj7OPP5pQjooWgO4y0LQYovQ5xI4not1yckKMehaOLdX/aMg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoRh2Rr+fN4p0c0f7AQpx+bPHiwc9vnpq/tZ4qRlXnQ=;
 b=dAhsVlX4DVeEAWeCcldmufUmfamejqnFIfOJzWeOaNk7vcqacLgIdOCaJdUJvl3PJmugPNDv6uHHdVl+A/duPRBTtDc5rizuxhgI6zUCgkLzc+FJ7AgLXsaeqpJhzTbHhXtWM0aSY/zd3Zs40MkU9k01c9VsngufOmbGbTaFcnhSTyCJx4Efx5qaRgkUNKkSzkHStdrR2LxdokaL8yPkBn4eC8x/YiUNWnZn3NbnAym64n609myR9ARfW+sHw3+GuYpbeL6Mx18iYYqcPWN1a17NYhks0cUCtmEaKyckYfzwscQRX4g/BPk+HEgj8XJ+riFX2XGVFPiXjG2l++C85w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoRh2Rr+fN4p0c0f7AQpx+bPHiwc9vnpq/tZ4qRlXnQ=;
 b=JYYA/6gclIadnmJLjT9u8fbQT6wj3D96RhyXEPCn7+BmiZ3yIk8Xjn1I664CAIQPuq+kGYiLlo0oa6BQ28ZuW5jxjUkBUuUpW82FNFxkfkLA5K9yXIJtODwxpkEtzk0m5nM+M876gdDnwOEMjrEV54/OOHryOLYckuipq0/HpAA=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by BL1PR18MB4215.namprd18.prod.outlook.com (2603:10b6:208:31b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 09:04:07 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::7652:bbbf:784a:bd40]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::7652:bbbf:784a:bd40%6]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 09:04:07 +0000
From:   Shinas Rasheed <srasheed@marvell.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        Haseeb Gani <hgani@marvell.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Sathesh B Edara <sedara@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>
Subject: Re: [EXT] Re: [net PATCH v2] octeon_ep: update BQL sent bytes before
 ringing doorbell
Thread-Topic: [EXT] Re: [net PATCH v2] octeon_ep: update BQL sent bytes before
 ringing doorbell
Thread-Index: AQHZ/PVHtVyZYXM5pEqs5xUcCNKPTbBG1v+AgACW1a0=
Date:   Fri, 13 Oct 2023 09:04:07 +0000
Message-ID: <PH0PR18MB473487DDE40F83927FEBDC8CC7D2A@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <PH0PR18MB47342FEB8D57162EE5765E3CC7D3A@PH0PR18MB4734.namprd18.prod.outlook.com>
        <20231012101706.2291551-1-srasheed@marvell.com>
 <20231012170147.5c0e8148@kernel.org>
In-Reply-To: <20231012170147.5c0e8148@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|BL1PR18MB4215:EE_
x-ms-office365-filtering-correlation-id: 176138de-be36-442d-b9f0-08dbcbcb5b2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aPrslc7U90KmIzBHo8CljX1olSzSjv3jd14OCThOEQhRKdNhFe0aVyBI/Sl14NcIaT28wlrIUQPytohJF8Y8AJjg0C7FAwNz/t9pOeHwNogniTjyu3skxnmsjEtpvlX3vOaKs6PWu5xZBFL5AJKH3um2CaxdUxmumfg7nwXSjYCEAzELH92yzC+USzljenmzyjOtZLx/RsypcUl6sElt40SPtjYCRgcDCyef0bW+aZctmrqAqDf/wkYbKsONoY++1kJTyQJSYI5qDNV++UQ9GCiaNgOKU1sOQkGU0U709v8KfBBTQ1g4l6t5/SyZNLhG9OpIzvwxgw3MblkpOr3GsMwZcPv3SzkfkSGVXG693aIVZ3Isa3SNqsNJDC2H48MPlcItyGWzeq17mMOJeo3FMCqRpsjw5KSVR1S1WSSZk303Fgg34CM9aLoWier8ZIksWu4JvuatxAERDBAAlrcbcP2xUHecKg9McvnHKS8jX9dgUZAZo5gT5mbUK6waPz7nbq871Qzjdll5wT6X8WAm79PuB0UAC2zKOw86stsAwhFpNWIBVIVf2VfVKPO3atnAsaYx6kAzQ/+w08ifbw0naKHEP9YGtTKdTrLhKE+LffXxzwa8xXjGXph0SSsvNx0b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(107886003)(6506007)(71200400001)(7696005)(9686003)(478600001)(52536014)(5660300002)(4326008)(8676002)(2906002)(41300700001)(8936002)(66476007)(54906003)(66446008)(316002)(66556008)(6916009)(66946007)(64756008)(91956017)(122000001)(38100700002)(38070700005)(76116006)(558084003)(86362001)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SUNq7c1Ghi6vR7MQ5q1LUZDOfiTDwjdzf+Lx9liQcIsn6MHYhTTR8sXqx6?=
 =?iso-8859-1?Q?2ylR97KkangEcMmEdUQZu8omVltwAbX+GvOiejXbwdU+rSyjPYcdvN6ZIh?=
 =?iso-8859-1?Q?MOfV5ybaFYKQcC3sJTFo04lcMv5ULMTB3Gac7FHmNqjIITbc0jYPzSPrnx?=
 =?iso-8859-1?Q?mACQkaofow2USPTBtm9o/IjoGUCxxuF9K7zV7CtRascsTsh9wCIJDJ5Tk6?=
 =?iso-8859-1?Q?7meZYgSm2/LVVyg1ygGd6FPMAb1TS0WLy8NMq8+46qxl+CeTflHfdvn7J0?=
 =?iso-8859-1?Q?+ubyzxNQe91NSpBbroE58U1N12XlebdWo3A43CFXF+bKS1lMEJ45A+vUz3?=
 =?iso-8859-1?Q?uZYONIaQ2xz5xDfNydHGij0PsOyRc+Y42FmlIim/zq/Tn+c2zZPdxGzCLN?=
 =?iso-8859-1?Q?HpDNfyiPcx4Xb1TYnN0ObwGlvRumZoWCD+3ugBJF23jH1MKgBqBDwyADFi?=
 =?iso-8859-1?Q?zSq4k+qtkGf7hRxmzkD3kY/jqin6KFllTcgBazQ9Wg7lf1JQr8Wxwhioxl?=
 =?iso-8859-1?Q?iTk6WrlqmxpAyaOu+V+slahnmuzbbjKVTncx3Xj1SxnCp9kf9WX4O9BO9u?=
 =?iso-8859-1?Q?+J/KPGZIk7iAFPo0D8ZARrgGs+bHO30UmgBplAOYslyODCeLzXN+hXYgb5?=
 =?iso-8859-1?Q?DozMoC+seGZ1foh6l5wuZnRxIjxTJzCB5iAF6ApdqHWfoLQDPIVoYX+Z8m?=
 =?iso-8859-1?Q?lakJFSxDu4hqPWF9buFLCQKK6hGOfoUPN1J6K/wN0j53WpS8/EFtkYGwjh?=
 =?iso-8859-1?Q?99w7ZYrF3rYjC89xaooue/cQtIBOUaSWX863ynjrOVs/7ZyuuGbUB8wy+a?=
 =?iso-8859-1?Q?ho3wHRQPTsMH9wIrXDnW7lbRl2NUm04SDqCj+sOdmYCV9BpnvkUl/eZ+HG?=
 =?iso-8859-1?Q?cs/2B5ShChkuGmYFLx7uDSkV0Y28b7IWUj4TJcLElEy3WtvAi0hWKprt58?=
 =?iso-8859-1?Q?UjQEabTNOPuj8sh14xjJ2ATFZWdo/Xha804qKn7V/2mE9B3BChgWdk9QUB?=
 =?iso-8859-1?Q?oqbKFcgtmlJ5K0HTJDmvglHBPEQGutHxEiULZOHqMQ6yM+lw4H2BFaqgdy?=
 =?iso-8859-1?Q?zo0Hcj7b8msOKkTN8Ygb5Osu1ypfV27pvBVzjsj/N+hEuNtisFvZMZuUKm?=
 =?iso-8859-1?Q?CyMFAWE6lslXyo1mFSjJSWDW/P5KkGLIlrZn4fX9c1WQOFg2d2CJvc+hvF?=
 =?iso-8859-1?Q?hFNRNMtG0hApIbTJtimyV4W/C5wWb6J0aJLz3QGB8WxkFpROF3Hqd8Pwjd?=
 =?iso-8859-1?Q?DHbvMfL1NJ7SHBWkB0ZHTDCkl2GL+OEG09uaNeP+g3aCCct60Ud6baB7Db?=
 =?iso-8859-1?Q?zzrMWUDf7U5I3GijNwFMJD3tzBOsZ5AqVU9eBob6CCL69MqaaCedTkz0uy?=
 =?iso-8859-1?Q?Nl6r+V5lXqdQOR0oOE5JR7YbIO0ChE5GguUH/OMRhLfx1kc0mOz7O8vXcz?=
 =?iso-8859-1?Q?3D2CTiYolbjvCLFeThvPodJLrr7I4++Im4IRSpTiIB7ak9jG5lR5BDSeND?=
 =?iso-8859-1?Q?EZGqsFF0sQQrNpX8xGExk3Zc6lfuw/xQ4dI8aCjwGHl+XaQAqE2qbdU57U?=
 =?iso-8859-1?Q?f1eU9jfLAkB5fwBNucnQqdHB79hawEp31P+SVOe6CLMZMTn/q41ksbP461?=
 =?iso-8859-1?Q?0UYOeycDGt+1RripyFgjX9vQX56u7bMcYB?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4734.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176138de-be36-442d-b9f0-08dbcbcb5b2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 09:04:07.1277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kXIWKoJc18AozOoovceJctLafHBRVyHSD6M6TGFvtVwLaQmv1qK8eQ6s0NGAD+8LaxDMl/zzHNJ7aV86HWL0nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4215
X-Proofpoint-GUID: SLhuX1e1EQEP8x_OM27Xy10RUbXkLLei
X-Proofpoint-ORIG-GUID: SLhuX1e1EQEP8x_OM27Xy10RUbXkLLei
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
Hi Jakub,=0A=
=0A=
Apologizing for the format errors on my part. Should I send the v2 patch ag=
ain separately in a new thread, or will this be enough for now to avoid the=
 clutter?=
