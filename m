Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C877D3814
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjJWNai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjJWNad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:30:33 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9F9E5;
        Mon, 23 Oct 2023 06:30:31 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39NBUgKh018146;
        Mon, 23 Oct 2023 09:30:23 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tvuseyv3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 09:30:23 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6j30BCNO6GdD2B/03oGFGiaDSWoDGLXBPPgNJIKag3eXlX1jaJC3puijvO7hdmyeWJt1SM5zMf8n/yEXwTD4y9ZkRYAjP7AJsZnXrumPbn6OhW75QlWGTMj7rXtFxyqxZfPwdqP2mojifwu2GXeiOzPQ6FUSyS16+s4woubBnjPK4/+juIJ6Ro2lGsGpA1CezvwJaWFoSJ99awKmH3lVUK6gRn7l2BSvg+KDAKV+fj2yTYNRvUdGLJp84kcMrY6KgXwctVthr2nhWdIESed/UPUAy6YXcfUYD1dd69PR2mwKBfCBc1mQe/GptjNsRUBZJ5N2y+gEboX1fdRNPbqnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Omq5cgscLayQJS6duR4r/Lj8BeFhNvjY3TohrwC9y2Y=;
 b=I/ZX6MUa0oML9RI8hOqll1s9/lG67rMOm5xYLwlqC5yYvtAuiU594CxT7E7TN8u67jG8+3pkQrRC2P+JssQfR1ENlMB5d9GpXBUJrXoMLfTmrj/7BuI2pkOLtQM3lBBUwzfTlFRnR1F5JCs7reVdvud+XzeZf9nrzV6CAEtL/Do+WnHkSFG3WDcF3LZnOn1ewUlwDgSbhU7PbGhGojw9I21n9lZYkvPdVeELDN1u3UycqtdOADi+/Bv0JW/haPwjTxY25rfFwZfe7ssSToC+AMCIhL9gVp3a5LWbQSiPCRxGNYME3zPsvY0tbxbVVYyUb6/0+kCiYc3htT2bXQwThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Omq5cgscLayQJS6duR4r/Lj8BeFhNvjY3TohrwC9y2Y=;
 b=EMow/M0pW8GavZ0RZJ/wY4EcNpklrOdItJdoZlKe2zYwQ4uCLmnWU+AwmB7XNAQpnYQOG49DedH65YRWiEzHjAOmFp3bsAKjq4pLg3uy93fZedozEIoMqOv7+xqD++qz+0GvoRYO7Bkoby4XFC+HfWSiH6E5qcUZK7Mbrh2kZag=
Received: from BN7PR03MB4545.namprd03.prod.outlook.com (2603:10b6:408:e::31)
 by SA3PR03MB7304.namprd03.prod.outlook.com (2603:10b6:806:2fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Mon, 23 Oct
 2023 13:30:21 +0000
Received: from BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e2c3:4dcc:c87e:bbca]) by BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e2c3:4dcc:c87e:bbca%5]) with mapi id 15.20.6886.034; Mon, 23 Oct 2023
 13:30:21 +0000
From:   "Balas, Eliza" <Eliza.Balas@analog.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Thread-Topic: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Thread-Index: AQHaAow+3kwQRklh0USw0Mt3uyHh0rBRZjoAgAEeXwCAADqhAIAEjRKQgAAQXYCAAANoYA==
Date:   Mon, 23 Oct 2023 13:30:21 +0000
Message-ID: <BN7PR03MB4545DA4A9404F349170CBA1097D8A@BN7PR03MB4545.namprd03.prod.outlook.com>
References: <20231019125646.14236-1-eliza.balas@analog.com>
 <20231019125646.14236-3-eliza.balas@analog.com>
 <2023101917-cork-numeric-dab8@gregkh>
 <BN7PR03MB4545E7EAB2D72B9098C30C6797DBA@BN7PR03MB4545.namprd03.prod.outlook.com>
 <2023102030-resort-glance-57ef@gregkh>
 <BN7PR03MB4545FF54B96514EC9F41887E97D8A@BN7PR03MB4545.namprd03.prod.outlook.com>
 <2023102339-outcast-scone-5a63@gregkh>
In-Reply-To: <2023102339-outcast-scone-5a63@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZWJhbGFzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctNGU2ZDY2ZmItNzFhOC0xMWVlLThkYjgtNzQwNGYx?=
 =?us-ascii?Q?NTcwNWY3XGFtZS10ZXN0XDRlNmQ2NmZjLTcxYTgtMTFlZS04ZGI4LTc0MDRm?=
 =?us-ascii?Q?MTU3MDVmN2JvZHkudHh0IiBzej0iNzk4NiIgdD0iMTMzNDI1NDE0MTkwOTUw?=
 =?us-ascii?Q?OTIzIiBoPSJ5STFzMEFUN2NRamVqRUphY0VmcjBzZUk2TEU9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NBQUFM?=
 =?us-ascii?Q?YXR3UXRRWGFBUlc1c09jaXNWL1VGYm13NXlLeFg5UURBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQWxHVEdWZ0FBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBYVFC?=
 =?us-ascii?Q?ZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpBRjhB?=
 =?us-ascii?Q?WmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5?=
 =?us-ascii?Q?QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZB?=
 =?us-ascii?Q?R29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRh?=
 =?us-ascii?Q?Pg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR03MB4545:EE_|SA3PR03MB7304:EE_
x-ms-office365-filtering-correlation-id: 3365af04-3256-4f56-121f-08dbd3cc3494
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F3Lfd7Zl6Cz3yA7dMiWuO6HwHg4Jk0lNXxlpA1FrNj4y8cnIfpZ0RrqKo0Qf5xyAM07Pkwhd1gQ9DmmfpRXg1aAiMWpO6qKmAqazjjndVE2dgnEDbk1+dXGzXLG1nKoELObyJKJtPwyKmitqaUKdaZWL2HAajIzkzzggQkMHMTBrgaU3GUhLYtresY0EztrK2ZRT2M0/DOQ/D/+KDrpGWwwBy2UpWlcDHb830TYJPp/bsaRzeb+8Up8Pohes1lTBZrNEUVs3/pPBqLrXzRfoX5TCgxtHIIXTMJFSzvavw7bUaeMsawzER5nW8WC6yhD4v5Z1WxVXqw+/FTOqRrBvgaO7twvAzP3wg2Y9ly5X4k8HTivSiye4lYPEY9yRcQ8Ra4vKZfvtIELOTfXPjHNXagYGBmcioHMp+xTF7/+YXgWytY6RYannUmKfb1ZUNMDnffaylnvpL1zv/Dr37P5zsvgKLgvZ/5dzLfIvL7dPa1+5fRKB7yJ2GUHpE+IzU8V5hftfQDNyPn4qJN5RAt3gmf20S4qCCIILdbaJGNQ9FC63GNFpuhRAVVAVXJLBHlQkZyCuauT24ZkgaRHnmy/Wb+m6AqGJXH8cc3dtiEDwOP8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4545.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(33656002)(55016003)(54906003)(6916009)(38070700009)(66556008)(66446008)(316002)(64756008)(66476007)(66946007)(86362001)(38100700002)(122000001)(76116006)(53546011)(83380400001)(26005)(71200400001)(6506007)(7696005)(9686003)(8936002)(2906002)(966005)(478600001)(5660300002)(8676002)(41300700001)(4326008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6VBBJ+wjIFwX1a2WVkOUN6cocqmK0Ymw1mM6mH9mtA897XRZyZycfgqvZbt2?=
 =?us-ascii?Q?5HDJy3Cuw6s3ijjqbd7cgvlDHr5m/BcwrDA8cVKW/aoRHyQkI7tMIwDH8TzX?=
 =?us-ascii?Q?DcJyZsLS0R/IGn+V7mgr5+lxeO+pgbCynmZM+fDSyn0zyXjgL5mrROAZFBrs?=
 =?us-ascii?Q?LbsQ4MEQ9/nw308iUf46JdqMBDQk6NHf1pM7XHlUIO4GJ6rRzKJ6hXri6gPe?=
 =?us-ascii?Q?YsbBG2zpIwrRTw5glQIhpja6DgIRGOXZo5+KOoquM1+Et+74cIwUGo4PhWHW?=
 =?us-ascii?Q?Z0E/dgAGD/AAd/psATUzTbZDplpL/y4jRAi4ANzdQhmRpFbz1nxqqkgoO44S?=
 =?us-ascii?Q?aohzSYvwjKG6vzPafiJG9yVdNMi0gVnBrNqZjtuvhaXA0E/6M0O7W2gMaAqM?=
 =?us-ascii?Q?7ZE5VTQ6I+TESLo0kjK2kmlm1irsqw8S44WJvsLwK8/vBPYdHodj/RZ/iT3o?=
 =?us-ascii?Q?Aj40u7BD8sQdOa4rHrxjGCxEHOtOXdjlbcRZoRg7ESseZARRjt3jEFeBAAAV?=
 =?us-ascii?Q?R7Bn7BK8fmpM4IF5Wngxe1TpENQLsNvxNzJz+t2Vb5iBbBXjVP7FJ3iExmAp?=
 =?us-ascii?Q?27WRVY1mPljupUkHwX/HMmbVlZMtykUFkXOMkv4VAnvBt7Qz6naF/oU60dY8?=
 =?us-ascii?Q?fg/QlogmZFX14EOvJPv3aUIg0f1Vci+F6wwhUy5Rg54dVL4IMKMwOPzTapHc?=
 =?us-ascii?Q?EWDMotK5BPYrj/ZtLvkgeV+TYbNB8pxi+TucdnxomRQZUgBN6yoVYOrdlVOG?=
 =?us-ascii?Q?G/BVMxP2s5lGFgC2ShwOOmT5d6kCs5+K9zFLSWzriwu09pfZ+tJJvPV8AbMV?=
 =?us-ascii?Q?DPqGuztnRjcHbS0f/83bBCW08k1GtBka34ZgwJX8/4HXiAAGFRR32veirP8h?=
 =?us-ascii?Q?lq62YT3dtLiC0dF4L1oK2/58Llj2rLmiiGEIueRD5iGKmCwdXxa3tw91FLRJ?=
 =?us-ascii?Q?TX0c9Cc0DdhP877C4xilKtvix0I8xU4wHABr41wyLKq2Ko/vDnqP9otS9CIz?=
 =?us-ascii?Q?1ARNhxsjI6MAA+wTUxuzsAl87QnktVPTNiwHrvi45g8qfN/TgZU9/bjN+gaI?=
 =?us-ascii?Q?vNfRav7pDE0/2q6RQ7NtQ4PhIpQuHawWIk2+gDLkx/YcQUmzMCfO5A2a88/z?=
 =?us-ascii?Q?0ZkwA1IcUIxMOZkAtZi5yof4T+zCrIC/PUnbjyOpbHZ+eDjcXKtYqNHPXt8Z?=
 =?us-ascii?Q?6apoJnMhSP/Cn+3qx/N0kNuhikd/5nrhk2GWN0OSGqYntEM3G2d/ocbKwCdu?=
 =?us-ascii?Q?+B3NcxJmAbFhQvHf0QFC4IWfqtBwty/QsSjf3AAk8xqBEsomwCBczpONEdHY?=
 =?us-ascii?Q?XNG9ivO6U0cVos3U7mqvjNWjMHfnZYjvYbsi1rxtfa+//P3my3Mg/a/bd2Pu?=
 =?us-ascii?Q?k+mFr1lMbZv5TiuZGw/pOU66aFlM5wFOriSWw7UZs1V5gsO3oeA3T4htFs5e?=
 =?us-ascii?Q?x8Zxb2o9/pP4lLGIvCuwT3MvFgroCBUEQ1oztEz4+sKM13YhckNKebKPfzWx?=
 =?us-ascii?Q?q6MCXzp8mX12qsL3cXvaZW7PusOXrTeTDSwMxFIiF4BJIq+aYRLNoL89JciT?=
 =?us-ascii?Q?VbdhohAjLD+9dBiyY6ScBY3YxGtonxwAmtBDZu/F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4545.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3365af04-3256-4f56-121f-08dbd3cc3494
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 13:30:21.1909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: quuTOogVtxsfGn1YvRqjYmNsUFtH7tbNmbSipzC6PdaeJJVbKwEo7JGlnJukB1IhP2dNkc2YSanlG6YUcRR7HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7304
X-Proofpoint-GUID: hMM0PKdpOuFWsBf1gdCSX91OpZKjshSY
X-Proofpoint-ORIG-GUID: hMM0PKdpOuFWsBf1gdCSX91OpZKjshSY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_12,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2310170000
 definitions=main-2310230118
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Monday, October 23, 2023 16:00
> To: Balas, Eliza <Eliza.Balas@analog.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Rob Herring=
 <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>; =
Derek Kiernan <derek.kiernan@amd.com>; Dragan
> Cvetic <dragan.cvetic@amd.com>; Arnd Bergmann <arnd@arndb.de>
> Subject: Re: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
>=20
> [External]
>=20
> On Mon, Oct 23, 2023 at 12:54:15PM +0000, Balas, Eliza wrote:
> > > -----Original Message-----
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Sent: Friday, October 20, 2023 17:32
> > > To: Balas, Eliza <Eliza.Balas@analog.com>
> > > Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Rob Her=
ring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > > <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.or=
g>; Derek Kiernan <derek.kiernan@amd.com>; Dragan
> > > Cvetic <dragan.cvetic@amd.com>; Arnd Bergmann <arnd@arndb.de>
> > > Subject: Re: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD engin=
e
> > >
> > > [External]
> > >
> > > On Fri, Oct 20, 2023 at 11:18:44AM +0000, Balas, Eliza wrote:
> > > > > > +static int adi_axi_tdd_parse_ms(struct adi_axi_tdd_state *st,
> > > > > > +				const char *buf,
> > > > > > +				u64 *res)
> > > > > > +{
> > > > > > +	u64 clk_rate =3D READ_ONCE(st->clk.rate);
> > > > > > +	char *orig_str, *modf_str, *int_part, frac_part[7];
> > > > > > +	long ival, frac;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	orig_str =3D kstrdup(buf, GFP_KERNEL);
> > > > > > +	int_part =3D strsep(&orig_str, ".");
> > > > >
> > > > > Why are we parsing floating point in the kernel?  Please just kee=
p the
> > > > > api simple so that we don't have to try to do any type of parsing=
 other
> > > > > than turning a single text number into a value.
> > > > >
> > > >
> > > > The adi_axi_tdd_parse_ms function does almost the same thing as the
> > > > iio_str_to_fixpoint() function which already exists in kernel.
> > >
> > > That does not mean that this is a valid api for your device as you ar=
e
> > > not an iio driver (why aren't you an iio driver?)
> > >
> > > > It parses a fixed-point number from a string.
> > >
> > > And as such, you shouldn't duplicate existing logic.
> > >
> > > > The __iio_str_to_fixpoint is used in a similar way, as I intend to =
use adi_axi_tdd_parse_ms.
> > > > It writes to a channel the corresponding scale (micro,nano) for a v=
alue.
> > >
> > > Why not just have the api accept values in nanoseconds and then no
> > > parsing is needed?
> >
> > I thought this would be easier for the user, to work with smaller value=
s,
> > than using a lot of zeros for nanoseconds. I will make the changes
> > to accept values in nanoseconds..
>=20
> Make the kernel simpler, it's easier to make more complex userspace,
> right?
>=20
> > > > Since the device is not an iio device, using an iio function would =
be confusing.
> > >
> > > Why isn't this an iio device?
> >
> > The device is not registered into the IIO device tree,
> > and does not rely on IIO kernel APIs.
> > Even though there are a few attributes that resemble the
> > ones from iio, and the sysfs structure is similar,
> > this is not an IIO device.
> > In the previous patch versions 1 and 2 we concluded
> > that this device fits better in the misc subsystem.
>=20
> Ok, can you point to that in the changelog where the IIO maintainer
> agreed that this doesn't fit into that subsystem?
>=20
This was one of the discussions from previous v2 : https://lore.kernel.org/=
all/5b6318f16799e6e2575fe541e83e42e0afebe6cf.camel@gmail.com/

I will add it to the changelog the next time I submit the patches.

Thank you,
Eliza
