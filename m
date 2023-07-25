Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DFE761A54
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjGYNpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjGYNpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:45:40 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDA31FF6;
        Tue, 25 Jul 2023 06:45:15 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P8HqKP007440;
        Tue, 25 Jul 2023 13:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=C87VqK4QnSFYVcmRWJ786Kmmsv2P/voFEnk7K9Yj6DY=;
 b=NfVz1Kr8I1n7f+g/IPDHUreey0UsGvwDusbehaa48TqymTEXxbDP6QcAi8ExPmnXo4B9
 LEhlQIBVTkDK5VNtX3HcS6UdWhlmxoSPRWYpDz+vAWPSD2ze2475Tr7e3pTA77dropV1
 Qlp4QmLAYqCxb4sq8OIdGS2S2x/gZlXVVKe/i/FECSPP7HNqCpR0CUKrheTb+/X4rEvM
 mObnxAQ9Vn0sMnQWF435VG/GM/kqOU5tYuh0XGXDOACkBCAiLljjdfeVpDAFn87ZsYNK
 NK66m800gtcMIK6lD/e5erGE73Qv0SXARIoY0CfqeCpHzOUwZA9L+59VY/4nUsW+ZxNe 8Q== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3s2arjan52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 13:44:56 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 49B28803706;
        Tue, 25 Jul 2023 13:44:55 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 25 Jul 2023 01:44:35 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Tue, 25 Jul 2023 01:44:35 -1200
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 25 Jul 2023 01:44:34 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0M0S1g46KzIPdNPBtAc1Xh45EEliPbCNQbEo/rYcQVQwoNpjMx8GTTCLZnD1us7W+ej0SbQYe2hoTpE+IoBhkXS9ImGT9RFSZ9YYZPUD7bPEKUzpTDSvTTv9qkrZmRy0syndKpTsY3kyMwmQeLvFcP+Yhl8PjCAdGCy7MCxEjAtWGu0iEHF40P6u7AFf8qorvtS2L5zyIqZ7jxdYyd065ug0m3Ng0/f9aVU6muEbw/2b7gy95yBqEJSrSb0oCIDf6FtNIkdyEWCDBIcbwN1vcnhkg/jEouzl8xZW4F77zy4WBSQeQIGTdUTutQU4aB/bR0GuJGSeDCQ3uAbM4VxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C87VqK4QnSFYVcmRWJ786Kmmsv2P/voFEnk7K9Yj6DY=;
 b=iXXPHDU3u8Y+2s/nBdPcvB5np1sN3Le2HZ452xlzeKT9xGhLnqVm4JK8FaqLb/Q9QUcVwi87h7nrcFTN3ki4eI6Yj93kP/qdU0UJC7NLkBc7p9gFU+ryKLvGL8uQQkj87vv1vp+cxo8f0tk7ndZr1FBVmKp+9BgWLqbgIPUXl+Oa2o9TagGpMf5sQhyNFhWHoM+FmTziVsNArj/2ZwcFT+a3F/WBKrWbaG/ew51IiEHB46K9g74qkL7wyV+kExiMgdfAZ+FyFzOmC6GM3PixXwVtCfi1e3h5CSAQ8TQtXdnSw2KHD90Z+6WJ4+ecQbG5KS1w0epS5bw6nDslwsXMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 MW4PR84MB1827.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Tue, 25 Jul 2023 13:44:30 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 13:44:30 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 3/5] dt-bindings: net: Add HPE GXP UMAC
Thread-Topic: [PATCH v1 3/5] dt-bindings: net: Add HPE GXP UMAC
Thread-Index: AQHZvBm+GooG93oDpUucD86cbiWeIa/ExaIAgAW2tLA=
Date:   Tue, 25 Jul 2023 13:44:30 +0000
Message-ID: <DM4PR84MB192785EC6F2B8A76FF9E5E3F8803A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230721212044.59666-1-nick.hawkins@hpe.com>
 <20230721212044.59666-4-nick.hawkins@hpe.com>
 <57d882ed-82e5-4584-8126-ca2007064126@lunn.ch>
In-Reply-To: <57d882ed-82e5-4584-8126-ca2007064126@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|MW4PR84MB1827:EE_
x-ms-office365-filtering-correlation-id: 5c97b448-2ac5-4d73-2cf7-08db8d1545a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tf9qrVqoQssteBFdKdbawesaKfwitK1oFveTJRBKY0HskWMejDtVO/ll/W8oiN93AAUm0q2z6nAz0FkPfzUNUfI5klSb46o01WVKVAoC9lz49WKdYKe8rYIX2Etkn58l0tL5nxVBwQs7HuJ2jjm352ujDI7Cffh1g4IBn5Z8tjWHwG0ZjIgGfbn5DI7tfPl97zGiqtR8RJbn86W+6TB+DuyLPe/qgtr/8aSGNWswN7wnPczT59hWFrFzD7SldixKiXbeO3X2jEdVIF5iMgd7oYAwPT+ntBlX7or+KUBN7Oh05DupcRBUOmqXCKItL8BUZ9qlQhFGsXj9zRBSYdtz/zGWRFK8uyl/X6oUgzhOLN7A6YH0gySPXvZ9ewPCYYd/sN2UrFrvQjZHOaZdgtlEul2zpbKOPAloMP4Wsudy6FhkwLmreOGa8Fc0fGvpRa6rr28cju6wARl4UqIU5sqUJ3C3stF427xusePKUo+5DCz9BQ6w3zjVFlKzuiiYk4QoiwaXpOQ9JSKsGLCu3HhmbmLADyTtNcu49bHd/VYGVAG/PyvsNQqxOxnXV0jXw7JCodB+LjJidKY4veUc3t5NpB2UhlFiufvzExE/VhIlpf4Q6Jl6YTyRzhl8lszP6Nxr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199021)(26005)(6506007)(55016003)(186003)(83380400001)(478600001)(82960400001)(71200400001)(122000001)(54906003)(86362001)(33656002)(7696005)(76116006)(316002)(41300700001)(38070700005)(66476007)(66446008)(64756008)(4326008)(66556008)(6916009)(66946007)(38100700002)(8676002)(8936002)(2906002)(5660300002)(52536014)(7416002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LBQVSU7Gg8uYLE7qGRY945XJLo4F4Srqa6o+DMMXbi+K9bz1z3ieD+KNRejD?=
 =?us-ascii?Q?97msFiiNyqMKzwPMQUSLzyLW2DJ2la0h3uUfCwh6AHbsxybcPn2xXLFfKCTB?=
 =?us-ascii?Q?/tH0vUriH0j2h16yMRmdTP8pTq8o8MvJbl8saZkWQ6XqisNY0+qPZ2SKK96J?=
 =?us-ascii?Q?2jSUJU1mEYABECpTqMH4GYg0OFBNlCzK6aU6J0/VV1K5ecjEPQrycZZygyzH?=
 =?us-ascii?Q?zmi6kZAyfCiRrO8IwnKv4fD80d2u6I69GY/VAKte+KcA3uUMPopdlGMnAnBq?=
 =?us-ascii?Q?dFR6HTG6xNDX0zTxLpYWCn8QaqhrOHpqt80mITMzvWGZc0QMwfSpELlP7xkP?=
 =?us-ascii?Q?ARS1ukgcw9/2gTy3cBG97RXvWmbGtxmaagSRWQcwUmm6vpenah+Gtuotgurf?=
 =?us-ascii?Q?5aJ+D+y+er9EfU6o14MYQnsWxGUzpz2np6gMmS4WsIiTuQDpiRaiNlVLLRva?=
 =?us-ascii?Q?BmvP1QdyvMvG/qlsb7Cixl4QQbn1dIXpjCprTsC4laZ8NY/VNBLYGNgELQAB?=
 =?us-ascii?Q?9AOrETgsJ7Y6MJGf4spNFNAQfNHZoRUKz71sTYGinllNDcor5+pxXQ/D1c8+?=
 =?us-ascii?Q?AdPU0+5ZtCXvFcAnszk2doPNY1NRuGP1+sV2FWnwAiwe6HiZJUqBebexgR7j?=
 =?us-ascii?Q?0N2icCGYMppKJnv6+QhOb7NcE1lxRaXfSlgChJOUuFpYa0QNWwZ/8bwze87G?=
 =?us-ascii?Q?cDbnjTr2dxZkEV9YquacqRk13dd89vH7JOP8CMkLBKs1b9yHuJN+9EXOQNB/?=
 =?us-ascii?Q?2xU1aZO39uGNuzfbPLl0rdhrrNPtOBEbydLaOjFGhIyPBTed9n/tfg0EX23O?=
 =?us-ascii?Q?p9ItSFF8aCX66Wnzp/Hs4ZZMeXlQ9u0PS7G/Gz25fs8RXnvBKmqFJewmAPXz?=
 =?us-ascii?Q?kMN/NWuiMMIAR8bYWJbQVzYYyRBRaHA1ul8cD7/EjBpPghZi9xxuZP3XJOL6?=
 =?us-ascii?Q?miGdoySjTDLHtIChrxZuH+GjtMmkd5n9so6HB9iJagYxnV0eegumFSgVKC+s?=
 =?us-ascii?Q?NeKXBLJ+lanA9ijwxKoPbMzc987mK/SXeL76feqCQuKoainmMyjY705Y+2Ek?=
 =?us-ascii?Q?eaPcEfA+mcYQE+ujHlfTWi0hXqB/fw5faic73NU4ee9ygMOWcLr+zu9300Ir?=
 =?us-ascii?Q?G2PCIL1kojdnO7aqKMXosmdxkeuzQEZF5YPVkN2peAcRSORuX6qZ95q5/2Qz?=
 =?us-ascii?Q?zYjEYBCo0C0uVX+QL57rS4+v+sa6BphWiwXkKYC2QxNQCjyw9wCfPh3ufJU/?=
 =?us-ascii?Q?tgIR71gbfLLzhs5pqhNTck6i5uddOtDFuBgjYqsvnS0me143xvM2g/8Agw3Q?=
 =?us-ascii?Q?u1WLJ0/cI/dAvEV9JQpStBvpIvURJ8M5EUWm7FgmAvLy3nMpkIG1GMreFdGr?=
 =?us-ascii?Q?HFblUi0wO3UfOawayceAAObuva2KTv+3rcNZBiQn6hE8MtmKByLEsUjuFkHh?=
 =?us-ascii?Q?Qsb61hjGFtR/fbTi2ta+YU9IK1TJed0XjR9rItHebxaSO6oH2soQC6GtN2/G?=
 =?us-ascii?Q?NVfZel2BLfVveTBme08pDX+vfvCPg0/IOGEMFqBOlxAt29OdBwyrfIijMfOU?=
 =?us-ascii?Q?7SmpMyl1r83tKGAhaL+fo2ZmwPvyThqg/OsCOxX3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c97b448-2ac5-4d73-2cf7-08db8d1545a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 13:44:30.5190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ikLZC7ni6ueLXQyz8n//KruwiZywcuAKzywT40pE+e8yeOuPkT6VEkeFseg5GGqYG/rfJHxOihnRWC9ZtZoFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1827
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: k2txWNcS4dvbmfhkB1tTgD7c22wHDlXM
X-Proofpoint-GUID: k2txWNcS4dvbmfhkB1tTgD7c22wHDlXM
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_08,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxlogscore=371 phishscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250121
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thank you for the feedback.

> > +examples:
> > +  - |
> > +    ethernet@4000 {
> > +      compatible =3D "hpe,gxp-umac";
> > +      reg =3D <0x4000 0x80>;
> > +      interrupts =3D <22>;
> > +      mac-address =3D [00 00 00 00 00 00]; /* Filled in by U-Boot */

> Do both ports get the sane MAC address?

No they do not. The first one will get the MAC address, the second
will be an external phy we are managing via the MDIO path.

> > +      ethernet-ports {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        port@0 {
> > +          reg =3D <0>;
> > +          phy-handle =3D <&eth_phy0>;
> > +        };
> > +
> > +        port@1 {
> > +          reg =3D <1>;
> > +          phy-handle =3D <&eth_phy1>;
> > +        };
> > +      };
> > +
> > +      mdio {

> This seems to be wrong. You have a standalone MDIO bus driver, not
> part of the MAC address space?

I based this from other yaml examples I found. Is there a better way to
represent it?

Here is what I plan on having the dts/dtsi
look like:

mdio0: mdio@4080 {
	compatible =3D "hpe,gxp-umac-mdio";
	reg =3D <0x4080 0x10>;
	#address-cells =3D <1>;
	#size-cells =3D <0>;
	ext_phy0: ethernt-phy@0 {
		compatible =3D "marvell,88e1415","ethernet-phy-ieee802.3-c22";
		phy-mode =3D "sgmii";
		reg =3D <0>;
	};
};

mdio1: mdio@5080 {
	compatible =3D "hpe,gxp-umac-mdio";
	reg =3D <0x5080 0x10>;
	#address-cells =3D <1>;
	#size-cells =3D <0>;
	int_phy0: ethernt-phy@0 {
		compatible =3D "ethernet-phy-ieee802.3-c22";
		phy-mode =3D "gmii";
                             reg =3D <0>;
	};

	int_phy1: ethernt-phy@1 {
		compatible =3D "ethernet-phy-ieee802.3-c22";
		phy-mode =3D "gmii";
		reg =3D <1>;
	};
};

umac0: ethernet@4000 {
	compatible =3D "hpe,gxp-umac";
	reg =3D <0x4000 0x80>;
	interrupts =3D <10>;
	interrupt-parent =3D <&vic0>;
	mac-address =3D [00 00 00 00 00 00];
	ethernet-ports {
		#address-cells =3D <1>;
		#size-cells =3D <0>;
		port@0 {
			reg =3D <0>;
			phy-handle =3D <&int_phy0>;
		};
		port@1 {
			reg =3D <1>;
			phy-handle =3D <&ext_phy0>;
		};
	};
};

Thank you for the help and assistance.

-Nick Hawkins
