Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3AE760F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjGYJpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjGYJpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:45:32 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADE5187;
        Tue, 25 Jul 2023 02:45:29 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36P9Z38T000693;
        Tue, 25 Jul 2023 02:45:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=9GZWGLlmoEiGYRXRnQB3LNjUpplywNpjccwLfDcOR/8=; b=
        KDwhCFe5mRBKIZo4KSzHg5mc5tzIZoMlhhGXyKBuKzvoSr2R0pRdkLiXJNnljWoB
        ZLMkp8SrdM/CEaHfZPT470lxyCOrl40GS5dDYSehL1WVIBLyAZbKuQEWXNn5+wfn
        WnwGgL4Yp/ouqmxOKG80w7UKTySFD2OXvnfQaq88B/56BOhXGZDWtWrU9p+2P5V4
        UAc9pWPajPMdR3UF7n57IkiH0f8jOUKUMEiz4YxHlRZEq0K9miwgjP4+If16U91A
        x2eKPFkTF+YMhvqqVT9tWW3T+JQHBsB8mqI1ZHNGI5VCHCMBitxov5L5N0WqclrD
        W3HvBacjI9ciNwcX49EJmA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s0emfj41r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 02:45:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDwZ/wER/x/OeJzJtCH1Q3RGx5aKAWnW7g5pwxSgJm0qkLFmb2jW3oFybANPSWV68SRev2zFOvMHyN2eK55zHRcYOGxnV0AlR441eZJ83AnRMvFCPDPp6aFELFs9Gx8sPIwdzfgKyOezCpQlrgR7H5by+uxIaMo0nqlB0tugG1GL9FbS5+UXeIhkysxk/GeBecdbRzlbuTpQ2vk0C0tl9xkdkof5FyEDaZRuSB5uLqg4900R3+5IfQtJ6+zxblensyUNZ2wvVRgVPBsOCnKAUu4/oyr/3LJ4WKEg8PL8dPmfMAJ6qVYY+WLfdPvJHILrE1UjNNPyRnFL+HfGpcX+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GZWGLlmoEiGYRXRnQB3LNjUpplywNpjccwLfDcOR/8=;
 b=AoOLBObeO0FYNFwBwAVl8NcBVKCF8bTkY7I9yjfjMKYpDPP6VpyebMcRNns06+b5z9Md2m4rpmjh5ThLNSkn0D6a0+pXYR+2dy7hskRw6gxEVC24hCGV+1ORNtYK33PI5cApUk+v7X65kXDl6ulCB7hm73GXIF2nKWPEiJ4BxfAQMWsr2bPP8ZSRSxy+pH+NHJkyLDhAYdIvsRUn7ZNopmHWA5nwjZBWX4MDbobGmq6L7lEcDCY5tGMwDmKgXJRo3r/6yhyf2K2pY5r1mdQnXIwXGua3BVC+Gwyp3FagCzMQ3GmRC/srnMxw87WTiXO+dYoKT+Gsigqr9o2diBhiAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5389.namprd11.prod.outlook.com (2603:10b6:5:394::17)
 by BY1PR11MB8079.namprd11.prod.outlook.com (2603:10b6:a03:52e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Tue, 25 Jul
 2023 09:45:03 +0000
Received: from DM4PR11MB5389.namprd11.prod.outlook.com
 ([fe80::f8ee:9c8d:51f:bade]) by DM4PR11MB5389.namprd11.prod.outlook.com
 ([fe80::f8ee:9c8d:51f:bade%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 09:45:03 +0000
From:   "Chai, Wenle" <Wenle.Chai@windriver.com>
To:     Udit Kumar <u-kumar1@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
        "nm@ti.com" <nm@ti.com>, "kristo@kernel.org" <kristo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] arm64: dts: ti: k3-j784s4-evm: Add Support for UFS
 peripheral
Thread-Topic: [PATCH 2/2] arm64: dts: ti: k3-j784s4-evm: Add Support for UFS
 peripheral
Thread-Index: AQHZvrpfwlh8Dh0iXkuWbd5I5BQzya/KNMXA
Date:   Tue, 25 Jul 2023 09:45:03 +0000
Message-ID: <DM4PR11MB538925F3CDEACD1C27334C468303A@DM4PR11MB5389.namprd11.prod.outlook.com>
References: <20230725053843.1721028-1-u-kumar1@ti.com>
 <20230725053843.1721028-3-u-kumar1@ti.com>
In-Reply-To: <20230725053843.1721028-3-u-kumar1@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5389:EE_|BY1PR11MB8079:EE_
x-ms-office365-filtering-correlation-id: 1cb77d79-60ca-492f-3b7b-08db8cf3d200
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wcmCjKeeZ0m6zF45cDT5JqZRn+i+tS6AZWbTbG9fFAUOVX019+RhJh+wkMl8SFZzlyYNO1x4GpFYs0xkFVDiG3UVBzyTD3SyXKY5ynyVu2gBT4GINjOxQV5VlWku7W8Ci/c6dgVRO5zsxHXRlBeeqbguvp/5ioq+XZaIdVH2FF4IWU0+c7IzkBCaBkQB3IVgAyp3NYCp40TO2BfOX9W7+XYZWF4zOBuLl0DUL+UYQa4KiZjw8WykNAIhwTepFe7uId1xH4pEn6b2wQKkNOIOFbTsMig6Ms8Ub+UoBRGBF+SjAcYYp8bYzc7kd+zo+fub/qyn51JsZBZ4IC1HBaIOy9Cie5feH01mVmPTBbKFPBLlCDMnwQzJflEX9m+BNxyTb4igf0QI828MLONVBbjOaCQxFPhhRiFg38TGau7ALCaVfrvu8pq6CyqrwbubnBTKLjHAvdBq1rhiNVNO8Me2LRN0EFwuNYHtu0Xim42fagBJLdZeiP7U7Yu43fO16jT7ZtwG571VSXZGSs21Te/HEc7x63JhGYP4XaLmgP0A4UbLfTVZ8T5x0CZmjTd2lJMEv00ItvxW8Tj5RzOOQhkWsemXtXMZsXdtmNOaN8C+heoE7SO9GqFyweXfsuKSv8Id
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5389.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(366004)(39850400004)(451199021)(26005)(6506007)(38070700005)(38100700002)(86362001)(186003)(122000001)(33656002)(921005)(55016003)(7416002)(8676002)(52536014)(8936002)(478600001)(110136005)(316002)(66556008)(66946007)(66476007)(5660300002)(66446008)(76116006)(4744005)(71200400001)(64756008)(2906002)(41300700001)(966005)(7696005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rnKGDNlko+6wQvtMExlEolwrU4YGjzDi7nZoJcMJKRqoVNHBLT5A2dQ6U7+f?=
 =?us-ascii?Q?qBAcYvRRZEytikrQgt6vWUWUT42EAA/n2G1d9h+WsvEfGBS/8pJ9g3wDh+/f?=
 =?us-ascii?Q?NVqYxvkh7/rC2ijIy3dvfe7h9pYmSG8YNMNrSRFttD+rajl/aYpwOHzljgT+?=
 =?us-ascii?Q?6LZlHe+6nC6W5pTp+ufhmdfCy4GdpvOFi+JjkIdFnlRHxe2+GHohGry1/+X5?=
 =?us-ascii?Q?umdMpXCzYnlZujA1t+ytmxuaWMz6fO5plhooWZAlXJQ0Y5EyCbYbRXX5Yj8r?=
 =?us-ascii?Q?hRGLtMPctXo6WUS5Iwpcd0NSN8zXBTW2kh3zpWYB2izwCVxDKKDHbeUzBSTl?=
 =?us-ascii?Q?vgh/xH/Ii9rtww63FhAfRXqR9MDHz1p68ZxDohM9h3nMWTXW8KaeVr33HQPr?=
 =?us-ascii?Q?ESAdedFQ7oNXCTjELbOTbJbR7DfA7fVhOAanPHgq5WdLy6bwG+tcfCnG262Q?=
 =?us-ascii?Q?40LcyjmKKNNsUBRzaLmSTJJmAE7FRS4I2aTqKK26c0S8IkBolngzvYycgPjP?=
 =?us-ascii?Q?vYYX9L+4a14WBnuy4X/DWvVu2OAt49tfYifQEsvhU6LZMFQcEDOQDdnGLAqN?=
 =?us-ascii?Q?nq1JERtJBf3iRFmQzwMH6Kr5ACU7xsV3RHse6eEENmI+vI0tHUno2oU6S7kF?=
 =?us-ascii?Q?dsIqOQ3oi6k2bJlSOiO2aAqff8IN1ozmBoXQX0E9l9ogWCFC1RsE1lVWjz/H?=
 =?us-ascii?Q?VkeHcC1PU0eslDGHM81OKsMe5iigpIzZmn8xy5NsXlxX3JOYeMxeO9WQsR6P?=
 =?us-ascii?Q?8ccMZ0rlsV5mLkVA+W5C1F0inkHL/H8kO1RzTYniQqJ8nRYEZ593srr//TFi?=
 =?us-ascii?Q?hpWvn4L3l/g3hCTwdWauqwHyQBjx066wVuL2QbNUrxq+fs3rYKVNUc21B3/W?=
 =?us-ascii?Q?ea1Yc4OtDRqilEE0sHYReXEWj4TPfcHgr/9UwGj/UIyFO8BsvoL+d0tXuceY?=
 =?us-ascii?Q?3fZjMzh+V9Fa7QJM/e1F9+t7b2GRhtfAwugpNiHMx61qwRX2MypGjfmiBVvV?=
 =?us-ascii?Q?LD5zgoOnS98UOHZxkGzdPD+MWlDHDBSRaWi1MFxnVQWXxMATLWPAvo1GcPxi?=
 =?us-ascii?Q?rTGrpZtEGZCw9X+4yLSMS3cQe7q9Ndqq08RCQBsCiU11zAR1JZ68lE+moXLf?=
 =?us-ascii?Q?Q+3ivVvUqVmqBukA9XoRrDcYb72txyw3GOz8KZWDnmlv6LDhyQxDBpIOqkS1?=
 =?us-ascii?Q?L9QAs1MGRZVABorEBlb1fqDuDewZ0rd5hc9Fe2Tkp2vnYhjLQgn6SXOgSPwo?=
 =?us-ascii?Q?KYbM5nnMnfZxvyaEFeg+CnfVImuNL3DshXB/kqoG5VoXzDNMWOe+eKItqnzH?=
 =?us-ascii?Q?SIHVnONHIIQuR7zIBJHkoEdBdeN/Yy+CKiCpNmFkJnsUtkMhQMGMS7X3P18t?=
 =?us-ascii?Q?l6sgaDWaZgt0HG5hpPu/42kdU+4yOpcTQUv/WpV6iSdI3GQ7cz4kOp5NHJaI?=
 =?us-ascii?Q?Qjt/9u3cTK37hZ7+7+Y2AW6XewZq14ks32JpNS7CmHjKqxM9RJMRcUr01nc4?=
 =?us-ascii?Q?uphx8Nn4vRWK4Sg8CknD+6QkDJW6I0ABz2aqGhBFHUqM+2Rbnl04hmRAwt22?=
 =?us-ascii?Q?0Syq/y3ylkvJjADkmKlWpq2fi+Xg+XqjNKa/QT6V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5389.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb77d79-60ca-492f-3b7b-08db8cf3d200
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 09:45:03.0663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nwhQdnxgU9RRh3uleZhqtvB3FSq7KGtCK9lCqJ0rme4L9MxIbqfGDVBQK29Sye7GtDljoIOofSm52CtiU2sFhrg2W6yT7FIpHpw7qzOU9Qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8079
X-Proofpoint-ORIG-GUID: vcdnJzcDHSgJ9N5y6eflj-7eFX8_nTU1
X-Proofpoint-GUID: vcdnJzcDHSgJ9N5y6eflj-7eFX8_nTU1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_05,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=836 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2306200000
 definitions=main-2307250084
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 at 11:08 Udit Kumar <u-kumar1@ti.com> wrote:

> J784S4 EVM board has 32GB Non-Volatile UFS Memory.
> So enabling UFS at board level.

> UFS flash details are documented in board data sheet[1] Section 1.2 Key F=
eatures and Interfaces.
>
> [1] https://www.ti.com/lit/pdf/spruj62
>
> Cc: Chai Wenle <Wenle.Chai@windriver.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/d=
ts/ti/k3-j784s4-evm.dts
> index 7ad152a1b90f..1e38a8f1bec5 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -430,6 +430,10 @@ &main_uart8 {
>         pinctrl-0 =3D <&main_uart8_pins_default>;  };
>
> +&ufs_wrapper {
> +       status =3D "okay";
> +};
> +
>  &fss {
>         status =3D "okay";
>  };
> --
> 2.34.1

Tested-by: Wenle Chai <Wenle.Chai@windriver.com>

Regards,
Wenle

