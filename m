Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB717B5B96
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbjJBTtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJBTtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:49:02 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1843591;
        Mon,  2 Oct 2023 12:48:59 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 392Hl7pb006715;
        Mon, 2 Oct 2023 15:48:47 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tf0tf950e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 15:48:46 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEg38fccrw7CHrbQ49i3TwVf3iSXEw1lOkAE0gTAcPZKmYzzKMmu9anL6PAGa40UroLf6KbKfnNwx8LiOK3tOTly54scWPYHjPF7Umf7SLJkqWh46iB5JIJUmytv9MnYt7+sTJml2zNeJprnuECMWDRk+OYBnLej91q+SAYpKYRCQO+f5TS2cm2Il88pacYJHi4IhQuAcz4CGfaNInR+axPRUxUVGvcQ8bH/DfBfL8eMQys61E0bsgkQO2hanZ0mrnx1bzmetAtDUZBqaSV6XXbpvWm86qO84oL3YqTXWliNq1C2nQtGyeA3o29i16xwVQIdi1k5b5CuNwwu/dCm+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNkqWNXRR/mmBJLXkJhDVrQMlmFw6k6ReXE8P1TpMLE=;
 b=L/Wecb8Vwgof37z14H5Q56LgMRmjhj7TrCh2x9zaPxkrmpTRUG3/9cGLoul7oTyHB4ubjNUJdUNjb8IAmnzFrOB2SJaYacc/CJNVUvfoF+fnciTRMmLYYzHx5fh5oi/+oJD22kHbPslccUXbnRsCZwgsbBetgo/hInbLHIMfm96OJLfE+KutPyEg/O8YLZTz7FUn+3pVlEdAonwYA/RWGYvt+EwG25AHSvlVpDjRewGxDWEOyvGtWPb1Ji22VUT4AD9z0tf/YiAjgD7nbYcW0sAW8aiNOEm17uYie/l5WmJH3jHdazSLTvIIYJTA1rLHO1wXbKreXsQaMNptCztOmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNkqWNXRR/mmBJLXkJhDVrQMlmFw6k6ReXE8P1TpMLE=;
 b=GNRWAzVnYc0RxJGQRlQLLRgBfQmrx2RPiBdCTZ609IaN0ZC1B4LGaXsdjEhKw/bHri4WIRboJdce8CUrafaFX/rocgLdiU01QpyTh9ZmfYA/hAvkfuFDk5PObLuGjy/jb0uQYm1XhDQFA+juBXx67QCvhcFrHjMJQkndS99XFgs=
Received: from BN7PR03MB4545.namprd03.prod.outlook.com (2603:10b6:408:e::31)
 by PH0PR03MB6724.namprd03.prod.outlook.com (2603:10b6:510:117::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 2 Oct
 2023 19:48:43 +0000
Received: from BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e1d5:636a:bda7:1c81]) by BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e1d5:636a:bda7:1c81%2]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 19:48:42 +0000
From:   "Balas, Eliza" <Eliza.Balas@analog.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: misc: adi,axi-tdd: Add device-tree
 binding for TDD engine
Thread-Topic: [PATCH v2 1/2] dt-bindings: misc: adi,axi-tdd: Add device-tree
 binding for TDD engine
Thread-Index: AQHZ8e6/zUxp0vYDHECkHhwPalTB6rA2uEYAgAABCqCAAC37AIAAA+iA
Date:   Mon, 2 Oct 2023 19:48:42 +0000
Message-ID: <BN7PR03MB4545090CC2F859333E9C3AB297C5A@BN7PR03MB4545.namprd03.prod.outlook.com>
References: <20230928092804.22612-1-eliza.balas@analog.com>
 <20230928092804.22612-2-eliza.balas@analog.com>
 <20231002163244.GA1886905-robh@kernel.org>
 <BN7PR03MB454508AF350D2DC96FE1743A97C5A@BN7PR03MB4545.namprd03.prod.outlook.com>
 <20231002-aggregate-scanner-3ca2ae69cf0c@spud>
In-Reply-To: <20231002-aggregate-scanner-3ca2ae69cf0c@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZWJhbGFzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctYWRlZTZjY2ItNjE1Yy0xMWVlLThkYjMtNzQwNGYx?=
 =?us-ascii?Q?NTcwNWY3XGFtZS10ZXN0XGFkZWU2Y2NjLTYxNWMtMTFlZS04ZGIzLTc0MDRm?=
 =?us-ascii?Q?MTU3MDVmN2JvZHkudHh0IiBzej0iMTI3NjQiIHQ9IjEzMzQwNzQ5NzE5MTg0?=
 =?us-ascii?Q?MjQ2MCIgaD0iUytyaU0rMGNnR0lNQ0pPM0pKVWxGY0FRVDljPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9DQUFD?=
 =?us-ascii?Q?Y1luNXdhZlhaQWZucWZnT2psOGZ5K2VwK0E2T1h4L0lEQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFsR1RHVmdBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdRQWFR?=
 =?us-ascii?Q?QmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJ6QUY4?=
 =?us-ascii?Q?QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFC?=
 =?us-ascii?Q?eUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBREVB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFjZ0J2?=
 =?us-ascii?Q?QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwvbWV0?=
 =?us-ascii?Q?YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR03MB4545:EE_|PH0PR03MB6724:EE_
x-ms-office365-filtering-correlation-id: 1f8d244f-5929-4360-caba-08dbc38094e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UEyFWisX4SVf2uCnyQI3D1whl5kUuG/0ViMLaE4li+xswvKF35/NuWPHf0NRKT+xFM+RZWTygUk8zXgrADjsctsoFeU5XHJzw3ukp1jS5i5nmaY2l365jpPmm5A76MnF5DntdAS3PA1YH6zE2wGSrbWz1sPdor+1VHRTGfooRXEC9I5wWXU85iOn+htzC682lo7rKoiFxjwJXl73Nh7ZHXRZSaNFHWPFJZX5qz394exrGMnhPjaZSZ0tRg5KMn9GC1yJTMvBOLKMptAHX7Jc2xvMx5Q1tefwemMvZasOlWvDLxtgVrFct6LP5daYPkT/4bZt9Wa6c2q9Q9BXMZvFBsGY59Klow1uOxo30dJtphw3xVI7PPHxxDcSDICls4fGJ0mAVctnAA2ED3YD09vzQt/5zflKADUX3+MnhQVJTAiT9vTxjIrSDlyZQ75EKKS74ZYBvBln/KY5uO31xK5IdIk84TQKiZ/uOqajS2Nmpuu3iUNnwSVlbjbfG74O/3EXq28CQSMYUPzRimZ31lJZEKXXIM4wVXTmDy7eyV31xHnDo7Dn1ySlnNACf6G23D8VTqlwIr/0PRL3kPpqmDlW3aLuUHK29WZaaY5FrPrdSAmk//u+pSJWvY6J2dF0XQPnJmO7Kb85hQ3KH5FNZ/KYjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4545.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39860400002)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38070700005)(8936002)(26005)(8676002)(4326008)(52536014)(5660300002)(83380400001)(55016003)(53546011)(7696005)(6506007)(41300700001)(71200400001)(478600001)(122000001)(54906003)(38100700002)(6916009)(66946007)(66556008)(66476007)(66446008)(86362001)(76116006)(64756008)(2906002)(9686003)(7416002)(966005)(316002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+j9OYit0V9FcRE3v/RgpmSHgzkkvcMX1tFe1BHtcQq9JmzSwvV8w/DibxSQc?=
 =?us-ascii?Q?VIcNaKSq4PzpciH73AIIu+qj0CkR3PMoPzzZ10tuu26XdHt4Rd9o6Ka6SFl8?=
 =?us-ascii?Q?9Cn7BB16zo9zjTEY7Fb7ZRoVoSjDI7zbX2k77xNwsJoiH0pp0rpmo6cNNswC?=
 =?us-ascii?Q?sBZwra6NF6ZvyJBfBXeHnbaxeZNEHiUSjrNyXvj+xv3v6kBYeGxBBIUv5D8x?=
 =?us-ascii?Q?K+ZiLfRiLg0BCwPO2h9AaiKZLaCWC/+UHaeJtXmHB9cnqp/tDgt5xFLWfYIt?=
 =?us-ascii?Q?g6IlgsRH8XgwG7HheroDPPZvthRv+BEifa/KjKNsV/DdEDhEO83hq7zmHUKn?=
 =?us-ascii?Q?Pqp1JiMkqwkvr0eQCqpcWMq8mwDUuBeO6Earnbjf8bo38/e73E8FOPSlBr+w?=
 =?us-ascii?Q?IpJoD6qOV4Do5GxlMBB6+5gs4XADRT4R4TVZZlkM3EaaAPIabQSlsmhOW3Ll?=
 =?us-ascii?Q?PIn9mGhooRwenmIv0qal50K1KIHqywbcnQg9V95NcuBAUY0k1Ympdu/OjY2p?=
 =?us-ascii?Q?APWGwj24KyIBJOL97kgmZkqKUMEflLCmyXWqqf66DnzNykwUMF10WlOfFd3L?=
 =?us-ascii?Q?wEZ20yrqxkbbra3ug2m4HU31pyqHvLhn3eDAPsJEFme/RjHN9CjRqhO3fDLi?=
 =?us-ascii?Q?vCJCEA0FMOkSLpWXa3aXXfqsnm2EINNUs8g0tRZ74l7rs2GtXTjeE9Rkp+9A?=
 =?us-ascii?Q?T3Tg6QA/ojYAmtDYavHxAKUMXjpwEznpwkXPRCzhF/o2P92geQNbOjd41hvH?=
 =?us-ascii?Q?RMLgQo058YvuHXlikox6nYby9Y0qI/Imyz2VvqM+OvlMNtU2Jf7fYDPKFt/E?=
 =?us-ascii?Q?+JtFn5og0GOPPdcAnXYYC12ECo7F9czI16ra4Z2iR6ImfUiAK6x7zfU1gQfD?=
 =?us-ascii?Q?l6zHeIlJTZZSQWnn4AiQpn+Jg2AKbZp4fl0pl9Ajlq1E7yi0VOFVhaxsojtL?=
 =?us-ascii?Q?kaV6ycPm1BGin54+mAdBPprkU9GrsVVqokEUGO9Aj5huMRkvVAtem36zm/WK?=
 =?us-ascii?Q?EGtTGdusxiphbq9kR4lXn3IJKFA6jgv5Kj5UFpGpdJ3i6ZuO2DrbDbmwz/0D?=
 =?us-ascii?Q?LpeRCx0lzTlo0l/udia6uQ/8sm0PFjsTaMNHdyJFajTgAsH2EiTCMQ0jqk1C?=
 =?us-ascii?Q?K71ytmtVDB7Y199GuADNhbloulQpnemMgat0gRJtjPxOcVaV0+HqZ+Ur9GTV?=
 =?us-ascii?Q?NEvYX4OWgCbD8O3zPxsBR9UUkeIoy0qWLU/10Q7YrCoripeBjZqqZC8L5sU8?=
 =?us-ascii?Q?T/cD2b+9eKwmBCCNZtkmdCAvuw/UU83ww2E3twMrR91d82jFWKtWU6+Fxsfr?=
 =?us-ascii?Q?9zAbeSTBv90f8MpjxQEwVvkCEfVZYlFxdI0mGVF5X18BN1h0HCkg5rqaHL8z?=
 =?us-ascii?Q?4XEOb4J4jYvZ2SdWhQI+m5DkkShNu/hkzGUH+1KpQARI7/UTAhBn7kYQjLzM?=
 =?us-ascii?Q?9kgs7hgNF1SDbjGxxn7qWFJ4ptZR5s5ftG8DYlQxbpjzrdj6JQWVZoXP+ZJS?=
 =?us-ascii?Q?qL+1RdHI+wOWqkDiZwO8xnbftZ8DyP8Di1oA2pMCcj0rp6pxWZghb3Ya5gf4?=
 =?us-ascii?Q?7KyKYk5haEnJKZknLQZbhrIDqW2CQ+zDbBiG8WXg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4545.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8d244f-5929-4360-caba-08dbc38094e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 19:48:42.4285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t0ASDV7OG8MSyVDbLxITx1ku9QS8O/8KxFAcf0yUTcGkZJEoQvL0LWwWBOq/AdKbNDwmvSniALFG3wtci8fF4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6724
X-Proofpoint-GUID: vPaTRbBBUfMosSbxXovyQ8VbJpFmXy3X
X-Proofpoint-ORIG-GUID: vPaTRbBBUfMosSbxXovyQ8VbJpFmXy3X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_14,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1011 adultscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2310020153
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Monday, October 2, 2023 22:21
> To: Balas, Eliza <Eliza.Balas@analog.com>
> Cc: Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzysztof.kozlows=
ki+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> Derek Kiernan <derek.kiernan@amd.com>; Dragan Cvetic <dragan.cvetic@amd.c=
om>; Arnd Bergmann <arnd@arndb.de>; Greg
> Kroah-Hartman <gregkh@linuxfoundation.org>; linux-kernel@vger.kernel.org;=
 devicetree@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] dt-bindings: misc: adi,axi-tdd: Add device-tr=
ee binding for TDD engine
>=20
> [External]
>=20
> On Mon, Oct 02, 2023 at 04:46:26PM +0000, Balas, Eliza wrote:
> > > -----Original Message-----
> > > From: Rob Herring <robh@kernel.org>
> > > Sent: Monday, October 2, 2023 19:33
> > > To: Balas, Eliza <Eliza.Balas@analog.com>
> > > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Do=
oley <conor+dt@kernel.org>; Derek Kiernan
> > > <derek.kiernan@amd.com>; Dragan Cvetic <dragan.cvetic@amd.com>; Arnd =
Bergmann <arnd@arndb.de>; Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org>; linux-kernel@vger.kernel.org; devicetre=
e@vger.kernel.org
> > > Subject: Re: [PATCH v2 1/2] dt-bindings: misc: adi,axi-tdd: Add devic=
e-tree binding for TDD engine
> > >
> > > [External]
> > >
> > > On Thu, Sep 28, 2023 at 12:28:03PM +0300, Eliza Balas wrote:
> > > > Add device tree documentation for the AXI TDD Core.
> > > > The generic TDD controller is in essence a waveform generator
> > > > capable of addressing RF applications which require Time Division
> > > > Duplexing, as well as controlling other modules of general
> > > > applications through its dedicated 32 channel outputs.
> > > >
> > > > The reason of creating the generic TDD controller was to reduce
> > > > the naming confusion around the existing repurposed TDD core
> > > > built for AD9361, as well as expanding its number of output
> > > > channels for systems which require more than six controlling signal=
s.
> > > >
> > > > Signed-off-by: Eliza Balas <eliza.balas@analog.com>
> > > > ---
> > > >  .../devicetree/bindings/misc/adi,axi-tdd.yaml | 65 +++++++++++++++=
++++
> > > >  MAINTAINERS                                   |  7 ++
> > > >  2 files changed, 72 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/misc/adi,axi-=
tdd.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/misc/adi,axi-tdd.yam=
l b/Documentation/devicetree/bindings/misc/adi,axi-
> tdd.yaml
> > > > new file mode 100644
> > > > index 000000000000..8938da801b95
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
> > > > @@ -0,0 +1,65 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +# Copyright 2023 Analog Devices Inc.
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: https://urldefense.com/v3/__http://devicetree.org/schemas/mis=
c/adi,axi-
> > > tdd.yaml*__;Iw!!A3Ni8CS0y2Y!5Cxus2huppjhkiJZLWTpJEgA0IXdLZx4t0fS9J1yt=
0xgjp9g3Y1N5PbZ7pAcIkKU4WPbS_TR9yjTKw$
> > > > +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-
> > >
> schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!5Cxus2huppjhkiJZLWTpJEgA0IXdLZx4t0fS=
9J1yt0xgjp9g3Y1N5PbZ7pAcIkKU4WPbS_RK8aQ9xw$
> > > > +
> > > > +title: Analog Devices AXI TDD Core
> > > > +
> > > > +maintainers:
> > > > +  - Eliza Balas <eliza.balas@analog.com>
> > > > +
> > > > +description: |
> > > > +  The TDD controller is a waveform generator capable of addressing=
 RF
> > > > +  applications which require Time Division Duplexing, as well as c=
ontrolling
> > > > +  other modules of general applications through its dedicated 32 c=
hannel
> > > > +  outputs. It solves the synchronization issue when transmitting a=
nd receiving
> > > > +  multiple frames of data through multiple buffers.
> > > > +  The TDD IP core is part of the Analog Devices hdl reference desi=
gns and has
> > > > +  the following features:
> > > > +    * Up to 32 independent output channels
> > > > +    * Start/stop time values per channel
> > > > +    * Enable and polarity bit values per channel
> > > > +    * 32 bit-max internal reference counter
> > > > +    * Initial startup delay before waveform generation
> > > > +    * Configurable frame length and number of frames per burst
> > > > +    * 3 sources of synchronization: external, internal and softwar=
e generated
> > > > +  For more information see the wiki:
> > > > +  https://wiki.analog.com/resources/fpga/docs/axi_tdd
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - adi,axi-tdd-2.00.a
> > >
> > > Where does this version number come from? I looked at the above link =
and
> > > see versions such as '2021_R2', '2019_r2', etc. I didn't dig deeper
> > > whether there's some per IP version.
> > >
> > > If you want to use version numbers, please document the versioning
> > > scheme. For example, see
> > > Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.=
txt.
> > >
> > > Rob
> >
> > The version refers to the IP version. The version of the IP is also
> > specified in its VERSION register (there is a drop down to expand the
> > register map on the wiki page) which is verified by the driver during
> > probe. "2021_R2" refers to the compatible tool version used for
> > creating the FPGAIP Core.
>=20
> If you have version registers in these IPs, what benefit does version
> numbers in the compatible string bring?
> Rather than using the version numbers to validate what the DT gave you,
> which not the kernel's job IMO, why not just use the information from
> the register to determine the version?
>=20
> Cheers,
> Conor.

As the description of this patch says, we want to resolve the naming confus=
ion around the existing repurposed TDD core (https://wiki.analog.com/resour=
ces/eval/user-guides/ad-pzsdr2400tdd-eb/reference_hdl#tdd_controller)
built for AD9361 and this TDD Engine IP core (https://wiki.analog.com/resou=
rces/fpga/docs/axi_tdd) which is a similar core, with more output channels =
and some extra features. The version numbers in the compatible string are u=
sed to differentiate between the two IPs.

Best regards,
Eliza
