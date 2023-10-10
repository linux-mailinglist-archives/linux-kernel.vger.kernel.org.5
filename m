Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB297C044F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbjJJTUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjJJTU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:20:28 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1079C9E;
        Tue, 10 Oct 2023 12:20:26 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AI70QB016759;
        Tue, 10 Oct 2023 12:20:18 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3tkh7cj6c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 12:20:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7QpL9Xyf5VJ3cZ8ZS4x09kidsClTMYmnDpkUnuasP6tT28VbI3U+zWcyKCfKzdtWz1KeFAqpRrInbHUDU90uk23sHtMF0cI7r8U7LKsxoGoriHqj+Qk/rToo82ND2pWmX8Syd3D75Z+xS4dsx8MHfbkVaOxLyLXBJv21bhqQzYxXmCBRBoJJWsThdVCpUy68N8MjUl44Utbm8D+7G/Ueb6aOAlOCWzo4fEvVujsOLd/AlBpTAla9p1J2tP0l0xWyGkgYbKvqF1hrf0/ie1Fl5jx5omRjRVVrIiJBR+tdDk+XX7aEx0hJBY9GRWaKnIS/EYKOBHv2Bgv08rQg+T4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1ir6Ywcb0scrGdbwvFGF7RtA0S57idJM/F02//Nrj4=;
 b=bjGUIaUPSZJD6fGa0Gx+8Ecn/ID0NMRlKVOXOBfc/24PsEFi6amEoMnQvKIWe+4MnqDyU4OSXvLJTsy02MIhKyO+udZf740p+W3RFcrkhyFLtxCoWhBY3ZIFWnWzX07eghZ7dcnoM44e3ZEGPjMcgPtAXbadOqPsYTb5iwhsKGVkR6vFrsAKZHUj496gjJKPudvkDIcTLyRYrCRsK6JVxh1gHxT4TQDeU+tlBmJZyO6dxgm5HiTBb49KAGjg+1l2vM1VwdWRDFJXFVACprjOK6uydEwRwZH47PvCV/5S5sGf6PyAtXlak+0VzMC7+j+RFvULzNDYyIieBbMtCIYK/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1ir6Ywcb0scrGdbwvFGF7RtA0S57idJM/F02//Nrj4=;
 b=unZubZIn1EK1+9UFdYDP2YqNwRtYzpuUv9nl3WeWW0eh/lWm/P5ACcCjB8u3Nd5m/zM8B5GVxiq7Ch+rHNkHf1bUAedSzhcVYzfR3QjEsD6gnQOvrW10pvCnjwtD1y21k7BGBo4/Eg/+o50xwb4c9lxBghaDE6JRL/+SCGVeCAw=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by CH3PR18MB5487.namprd18.prod.outlook.com (2603:10b6:610:15f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 19:20:15 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::7652:bbbf:784a:bd40]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::7652:bbbf:784a:bd40%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 19:20:15 +0000
From:   Shinas Rasheed <srasheed@marvell.com>
To:     Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani <hgani@marvell.com>
CC:     "egallen@redhat.com" <egallen@redhat.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh B Edara <sedara@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [EXT] Re: [net-next PATCH] octeon_ep: pack hardware structures
Thread-Topic: [EXT] Re: [net-next PATCH] octeon_ep: pack hardware structures
Thread-Index: AQHZ+Ez+ajpmXIuxo0itHfu4xp2AQrBCx8UAgACkgGo=
Date:   Tue, 10 Oct 2023 19:20:15 +0000
Message-ID: <PH0PR18MB47341BB93B1CCC7E6E91AC53C7CDA@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20231006120225.2259533-1-srasheed@marvell.com>
 <39546eb7836e577b53a3b403a2bb20ec07010f25.camel@redhat.com>
In-Reply-To: <39546eb7836e577b53a3b403a2bb20ec07010f25.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|CH3PR18MB5487:EE_
x-ms-office365-filtering-correlation-id: 299bd05f-b374-4900-23db-08dbc9c5ee9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k8dvOGogVoNJVKVXGwpPu/+KHsvqKBUKQYxsLDsK1RQETXH/K80Vha6sXBSu2gC4P7kzEHpah8mzwMNNtSaST5itDfud5+nFkknOldokzCrnzyyqu0hGvxiRN3Fo7EjdNYDuQy3WHlPvsDhZQ5XoBu95KA/PNo9FBNUfiNHom4h0Q1+cGs/3xqmoIKQ+VvhH+OUYck2/62yuv86Wm2wuF+v9qhw2ykVxqEv0v9a4Dui/ivSRKuedu1zr1RI4lQgRXBrGpG+/lYcaeu/URF0v1a1mS6W2MBtD85JYj2u4ckM+P4yrFMV9JYnnIxJCHgbWeDZBgjVrfFYIv9Im63SS3l+lKwiGZQsNrC8nsiMn3gCHHSRzbk7x7M+NCpfMadZtBeDYawy2HghP6HWAqxh3c4esgBuVAWyEtfVvUrwHl3z3fCx459L5mJq+H1vxNdb97Iyqixtni2sEGooqzjJGjbpngcBN+2t1poYVt869IkfjtxhjrWto+0fth/GPnbCILFOXBlWP0yZ21Wb5L989NpAhvNkH4uZ0jZrywQXY53SsYkvOvxoNNW21oJl8Dk895gM/iXMU5FUwa3ywY/arF9EUDC2kZMhSaGcbReLTFUYFEFRN8XoKUH2dAzYKfAwr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(55016003)(38100700002)(66556008)(66446008)(54906003)(91956017)(66476007)(64756008)(110136005)(66946007)(76116006)(316002)(52536014)(5660300002)(4326008)(8676002)(4744005)(6636002)(86362001)(83380400001)(71200400001)(478600001)(7696005)(38070700005)(6506007)(2906002)(8936002)(26005)(122000001)(41300700001)(33656002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uG1HHG2Bpnl2bkxfz9UlD/70hY5Q/3lCStcYxMY1A0j3cE0QetOV7fcA8G?=
 =?iso-8859-1?Q?GtgE1iic3cWtkjYkhyS2P4UhxoNAW0HyYb5Cfqn1utMrzrAMvOy6PX4lDI?=
 =?iso-8859-1?Q?srpcO7mGEteOsD1YfO6yq27HWc0JcmK4MfPz8RjHNpoZRA3CPx6FzfjUu9?=
 =?iso-8859-1?Q?hh0x9Ujb0qQkNueybsBA34zhqkeNyj+eORMeRE94D57WniJU4mwHOJmH8W?=
 =?iso-8859-1?Q?vIl1M42ndeD3cq5NwrctibByk1SkQMQqEvCMQR9HoE9T+Cx5aw/h1d/FBV?=
 =?iso-8859-1?Q?Slepdsw1YFbXg5omML9RJmylTmgQ5BgOAhyOXf3doEUsJsK1lXB2OUwYVA?=
 =?iso-8859-1?Q?/VVuJXwjQVzhENv1GQo6WJYDQaT3MuVVbCY2erxtuAh34/8SlkLsbQbxQV?=
 =?iso-8859-1?Q?AtzRMW0+GgnJ9Wycq8KmyPRArkjbCLXp/sg9/K+D/5vR5KjxAASAHGLKwc?=
 =?iso-8859-1?Q?dlITTon/4wQBi8n6el743ASeBL2OK6rOsnTGGPZP4ooZsYQSUVINPJ4yx0?=
 =?iso-8859-1?Q?hV70nsaP3ldsQo4noRotI0z79DT/eOz92BdrTxIG+jQZODU4Y9B0/hOcrM?=
 =?iso-8859-1?Q?X0zQb2bDbkh96CsjZOgOCjIapGDMNT9yV0rBRyc66AAmbbW7staZkDq5vH?=
 =?iso-8859-1?Q?O+VPaWVFQDSCU3+p0RTRauXIgo5JLb15JAVd0P68QJJKFFpEHIb0QIAtWv?=
 =?iso-8859-1?Q?Km2C8+uayjicDHs7nQ5thngGljvCOWzK4OHuS8q8BvbSKs5sAgDnUNrmfq?=
 =?iso-8859-1?Q?UldoTwIjDSjOLi9sajC5AEI3bah2U0UGM+tlsPrJ2/3hQylkZ0+fsF6VFu?=
 =?iso-8859-1?Q?c6G5FD5gqzCVfwGGz/rsqNVed12iZ6nirR6euALy4PwkybhSqy5C+6ny+U?=
 =?iso-8859-1?Q?DVjSmRxcCQUl/zamkEgJzhIUQlqSLtGzgt32X+ijksSzYAg8wF7Sg6W1dx?=
 =?iso-8859-1?Q?h2G3C/2SK70POjA2VSoxTMRrLZGRzTHmZUttAwZ8IkhTzFy0SzmsERlntv?=
 =?iso-8859-1?Q?9RVlHzu0VAvWFVI5W5svv/kWaYPuvZnpwRd4U+GemqIOsJVpJb2xThnMVl?=
 =?iso-8859-1?Q?A7S/IOs1ebAyPUgypAVZrjPkbdjQ5Xinahl6GH5rbnHjQoqt893eV34RoP?=
 =?iso-8859-1?Q?0PvugI8XAE5ZQe/n03QY971MOl3eI9iasN8kJMfYq2rDLFzrEoeXbAo7hn?=
 =?iso-8859-1?Q?rfm9ifrTFbjh6Oj02IjOKYR9ToTa6dQAZInZbd8KGD6eNGbYRiiOCFHlZ9?=
 =?iso-8859-1?Q?EFk7UQYr8MIJi7LdP+Q+VPbsDKynJ2sRVyGwVIA2UcY7E/ERGbl4i8gcXi?=
 =?iso-8859-1?Q?XjH3c0HAAOUbnqHJw0LwN90iNHM7luIUB9LzeBWxdNrn3Wkuh++oL3Dl6o?=
 =?iso-8859-1?Q?/zDKIWaChnNJ1k/HLeGNeVo9UlHIvKiKYl9857HXWhiQseZfNXj287Wiej?=
 =?iso-8859-1?Q?FiZsiFrXT7F5wtlebeFJJGDRWtoVBqbwirBh/OIPK4n4mN1YBR7LALQrOB?=
 =?iso-8859-1?Q?TT6g6SLYpoqOx2ayEUK4iClPf7dUELirkiecWK+jz3+INpeNXRQH4dxYJA?=
 =?iso-8859-1?Q?jQpLwIstXI2371KXwOgY4rL440oPYGNQCK0065o+js+M3lG3cp2INwdKdR?=
 =?iso-8859-1?Q?+vUPAWWXzHtz8VL4eQAjDmzAAQOIAQOJYh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4734.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299bd05f-b374-4900-23db-08dbc9c5ee9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 19:20:15.2097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nTOk0/uG419FzzB796uVZskjZrqgq8XBGF3Gr4IYD2V/rs3TOOzUK6Vw87qcDFF6RLvypmwnnsiTh+Mj117inQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5487
X-Proofpoint-GUID: C5ichmxwvqhuJWwjFOIsvh06M2Zm-3W9
X-Proofpoint-ORIG-GUID: C5ichmxwvqhuJWwjFOIsvh06M2Zm-3W9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_15,2023-10-10_01,2023-05-22_02
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,=0A=
=0A=
Could you please elaborate a bit more why this is needed? =0A=
>>> This is a necessary commit as these structures should be packed since t=
hey represent hardware data structures and padding is not allowed by hardwa=
re.=0A=
=0A=
Is this a bugfix? =0A=
>>> There are no issues observed due to this, but this should be updated an=
yway.=0A=
=0A=
Please update the changelog accordingly=0A=
>>>  I shall include more information in the changelog as well.=0A=
=0A=
Thanks!=0A=
=0A=
Paolo=0A=
