Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A33B79CFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjILL3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjILL2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:28:39 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DB81711;
        Tue, 12 Sep 2023 04:28:34 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38CBOcYp032093;
        Tue, 12 Sep 2023 07:28:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3t15ueps2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 07:28:16 -0400 (EDT)
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.22/8.17.1.22) with ESMTP id 38CBG5Js011010;
        Tue, 12 Sep 2023 07:28:15 -0400
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3t15ueps2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 07:28:15 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6cu6X936pWW4Qpbv4JYqIUctVzoMp79JRzHvxiFsaq05oDOdxCUk+LyIbM403e1MkUdnsoAboznZ0qgt4kYP8WnjwuGMgAyBPA9jm4h09III5r9eEcyfVikh54jfoOUGyS7pvAdOEzyoolzW36TZbV58Nku3WRir+U7fHIPV2pQl60HNEytm0mHgm4RzoY8861ZeH450nxKDdix7S6K2XyFp4MpmgrKj2EQGFNe64IZo9RDqTNdPAkY9WxTqWLzO/L5gbb49ZgkSubU83VDk6zL1Lv1PNvltI3fzF87C+IdavVzQQtj3u8l1eQdQ2IYS229hSqG+l1lYVK6jFaCAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2MIUQ8SC6BT2F8Es+2ga+riaPlDSwjuhl9FZyFhwMk=;
 b=ELiOU6M/FRWrKGQhNAo5o3J+bFt1otwO4V8M09qcEk7jXuKd0UEDn2WyeruBIEea4S064mN4L2yMDSy/rFqIsqKuSsQZ30sVqbK6ejbOKxVCTm9mLiSEwYa8kOKC3oy3nhSTnsr6ElE/FM6+OYKyTlrx4Pvn0M02mp66T85zLx4iZYwolbqmEKF3UlwLXrqSNLVTEm4zQLkB0yc7gbe19Sztz+P1OZjoGGb9FnUZ+LhgbMLhu81iyNmS7Jfmkl5dDawdPA6kRBCMz2p5I18wFBGslUma0XY8M7G/vrDkqU1Y/94X5FsfVZWco+CqWnD9ZwMQvkH3B1sAbZ106riVVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2MIUQ8SC6BT2F8Es+2ga+riaPlDSwjuhl9FZyFhwMk=;
 b=iCyIZVWU4HvApt+TZsTqctoh/nFIhp4j2KVV56Ni43bkAaymJRTFpX6veef8GSOdZnsc2yjkVChuYI2JvfdDrWkDFcffUvmlRT7zZTAwa6+vH5wUPuOnicreh0sMXfVT0Sm+joFL0FtTF3rXEbCaw+tp9tL0fNfoob/U1P0juRc=
Received: from SN7PR03MB7132.namprd03.prod.outlook.com (2603:10b6:806:352::6)
 by BY5PR03MB5233.namprd03.prod.outlook.com (2603:10b6:a03:22c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 11:28:13 +0000
Received: from SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::4a36:f52e:cc42:6fa4]) by SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::4a36:f52e:cc42:6fa4%7]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 11:28:13 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Conor Dooley <conor@kernel.org>,
        "Cusco, Ana-Maria" <Ana-Maria.Cusco@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] dt-bindings: iio: hmc425a: add entry for HMC540S
Thread-Topic: [PATCH 2/2] dt-bindings: iio: hmc425a: add entry for HMC540S
Thread-Index: AQHZ5UZWmtTs1TbX6Ua+FRSaw83kbrAW6SSAgAAkqlA=
Date:   Tue, 12 Sep 2023 11:28:13 +0000
Message-ID: <SN7PR03MB7132BD9C59A640EE4A5B0EA68EF1A@SN7PR03MB7132.namprd03.prod.outlook.com>
References: <20230816110906.144540-1-ana-maria.cusco@analog.com>
        <20230816110906.144540-2-ana-maria.cusco@analog.com>
        <20230816-stoop-exonerate-148c7bdc01c2@spud>
        <SN7PR03MB7132732C9DB517378897DADA8EF1A@SN7PR03MB7132.namprd03.prod.outlook.com>
        <06a007ad-ab6b-2ed0-8f70-6837680c8684@linaro.org>
 <20230912101643.00005cc8@Huawei.com>
In-Reply-To: <20230912101643.00005cc8@Huawei.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy03NDc0MDllNy01MTVmLTExZWUtYjgwYy1iY2Yx?=
 =?us-ascii?Q?NzFjNDc2MTlcYW1lLXRlc3RcNzQ3NDA5ZTktNTE1Zi0xMWVlLWI4MGMtYmNm?=
 =?us-ascii?Q?MTcxYzQ3NjE5Ym9keS50eHQiIHN6PSI1NTUyIiB0PSIxMzMzODk5MTY5MjI2?=
 =?us-ascii?Q?NDkwMjYiIGg9IjZ4NjBMQ2ExT3BXaTlUZkJMb3hMMkJLcUhWcz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?RENHY3MyYk9YWkFaSVdwWUhQQ0w4b2toYWxnYzhJdnlnREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBbEdUR1ZnQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR03MB7132:EE_|BY5PR03MB5233:EE_
x-ms-office365-filtering-correlation-id: 217353f2-0c75-4483-09c2-08dbb3835a1e
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6sR8C+VSEze7Ifz9RrEvNGeoxnGFRJpCfLvqd1ofspSYOpPMo7U0H9scPeDD+YJES0Gh6sPOISPfIWGxArnWQ3p4lSp6X8hQEJZh+FFhN++8JiI6eIEFTuCVW60wb3yWehkg5sTkKs/MyMsri5w48YBLQsx9V2Vo9UO+eI/JVLbuyY4aViyX3Zh+3RK7PnuILUwxB/wdrZNPzM8DTH2LhoA7LJOlqbO4MpGnBEWUFYsgobkoiEzmtQ6hHMqNGG6t3+blrLbs0T3o3psKqzXsQoWXj03mqP2C+u8TnNGQdzfuOxeO7ICNBcg2avB+bBXZnq5v8defnDoZD+8Kho2MJjAbFFMQH+8mTAsPuXAl/2zFsk0guCWmuYF6flMWrVZ+YtWEjgP8YqcjxjkGgcLqQ3veR8vhCV0t+zLCHzW/WSXvCgiQ9kEemqYe0HDmgiYYUkZEZq8cPtk/0V58S4IE3VMUquMmOQXp/XeNPLXTs+SNMK1Ib2oelR3++R58maX/l/2np5gq6M3jdXLRFhwkpJTm4DJCXT0Uh9oC5MTJAtSiwFqRBxPXXy+/pmVMXfR7bKXUHAbXZSqoa/UUB1qbe1F6c7cw/HHHn17+A1mjhJY4L88F55zp8WyHqygt8oDJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR03MB7132.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(366004)(39860400002)(186009)(451199024)(1800799009)(52536014)(5660300002)(8676002)(8936002)(4326008)(83380400001)(71200400001)(9686003)(6506007)(7696005)(26005)(53546011)(55016003)(478600001)(122000001)(76116006)(66946007)(316002)(54906003)(110136005)(66476007)(41300700001)(66556008)(66446008)(64756008)(86362001)(2906002)(33656002)(38100700002)(38070700005)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?szIngYPxOkLZR4gr04txxRzbRsNog34DlMU91PSAVr6yOc62QGZrs9nnW0i0?=
 =?us-ascii?Q?frEKYEuh8riOnJ58ZgASYEC+gxtT9O8zmscEJkHl4uYzfcRVl4f0Wz87oJxG?=
 =?us-ascii?Q?AfzQYmZp05e+7HNoX3lLjVe3J0/3bYwmbUPl/gnScfwaKA2taDYyWtLIZfIn?=
 =?us-ascii?Q?ROr16ckr/Wuvabe2dCIEQbfFpqldhh3S0vqfuSR881u5DmTa3y5RnFzkMWkN?=
 =?us-ascii?Q?pdr3CD9GuZjua8ScsTFaG/BwpwELlu+H71JhFLzShVI6vVmB5vHOVeAZIPS+?=
 =?us-ascii?Q?b3hCUtQr+KADTqhFpjzf6Rwf9CxZXUFi2G4lPvajBeZ78zRDi2uKAbFfdngX?=
 =?us-ascii?Q?F8XJgwxmJl60tPD1yAWDAOjo4zLfpnMJdG3JALNvjuC0vE7KkuqHUnZPVm1i?=
 =?us-ascii?Q?SiPKZg03jfTt/vsMuPdJmNgOvFWbTDYj8eBqTgWc8em41fR7dqAqKAfimQUL?=
 =?us-ascii?Q?iT+NcDnQ+m4CWHhXlYYSo3FTxDVjXZ2M8vLtYKdFr+PNyhbs+rE98prX3ejx?=
 =?us-ascii?Q?i5oW1doxEmlqVN/7+CVDXF8ipfaLeRv6kbHBT4Xdiw9q5ohItft0AqEkivaF?=
 =?us-ascii?Q?u9gMO80XlOcfGay9j2aWjQhGRl6les/54Ntxp/xlCIjAOwo1Vi8plaag6npg?=
 =?us-ascii?Q?EwFOCLteTm+AfBgK1X5W+ljtVMfSqLKCX4KSnqqz7Xq5XJtplNFKO2jwxBZY?=
 =?us-ascii?Q?v/F1lmQ0qjXTQ+jXBdTJoGLD7VJQ9/tP9/57CDTm8VuhaJ8Hy3CPiOnI8H/y?=
 =?us-ascii?Q?ZypHWTcIVJBNCwNyZJnqfmX14O+Ecwl//XERA85HcKpyV3cA+hU2lqLNZDMN?=
 =?us-ascii?Q?9NWUESp3v/u1j7HRiAmtCZo7aam/4cRrWPjoSHZqJ++ukgnm/cbbMjE3HdQy?=
 =?us-ascii?Q?ppEtELA0k3AHkms1cp1GmxRQUsgZZNMMjp5GTcvV+7k+x6x39wJHjDJ3ZNaH?=
 =?us-ascii?Q?NR2datf6jvL8d8NXJ+yuR/TvU7+ulGFZwPggNTTD5zJZlerUM+TnFEnW/0Te?=
 =?us-ascii?Q?jFx0B9PAnsTJjxMO178WVJktFV8TTaHCpUIGr52AxP0jf03vXtC3Gju3Xjyh?=
 =?us-ascii?Q?+KG6nMHu8w9df5ggzzqBWit9PX3DvaTWfQ/LoRYk0KktfQXBhAzAqACE9hj/?=
 =?us-ascii?Q?FvKXD940d1McbYTWKWvQWvbSJUWKqusX0PhF0aNmfyS2yGNTFgfTfII+UrjG?=
 =?us-ascii?Q?rnKixslubgjhpu0XqhOpOqzvIusIHD+uoRw1UGUYO1WdTzX7GOzYWpDdneZm?=
 =?us-ascii?Q?kWefRtsgFhspuhF/epAogtY43+eaVfB3/NCJ8XZx2d/PawkKiacloeMMwwTM?=
 =?us-ascii?Q?jmVIfmMeE00d7Hpgy06LL3nPB9/IsUrZH7+anXXNxeHSh3t9PsVcUgGTyRmM?=
 =?us-ascii?Q?0mAZdxdlMKkmENPW6Ngyazmdu08raHK0DC5GKwE+f5eKrklrV0u3xE0+Gr/G?=
 =?us-ascii?Q?k3e1+0TeMIwz3HgnYcESCLo3eY0VQdDJ8mPXQ2agJsWiYbdVZBPb3/KCkj+U?=
 =?us-ascii?Q?0xbU0F9Pf/eMlD9KOdmPL9jn23JCnh5oh0vqQx03EsLERICnogvuBttjSuzs?=
 =?us-ascii?Q?I6FOESAxYS0omYQsvGvwZ8vm9WSJzDQUj3Pt/JZVKvthC4cEtABcwFuerhgk?=
 =?us-ascii?Q?mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR03MB7132.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217353f2-0c75-4483-09c2-08dbb3835a1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 11:28:13.7058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1uVjKIireiExSvbG0qpaR1k14RYUZMpR45LX0ohjxg6pbzHOn8kfKXv2hH96ObmfPrSjVvLJ7uKbImsLgDdfEOEtkXkHj5QmcOzHUhSSGUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5233
X-Proofpoint-ORIG-GUID: QPncvh0mXg-xAm9fnsYuzF3FbwipgJl_
X-Proofpoint-GUID: 058BQQ5Y1HY0ClthtY-X0uovVlj-NB4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_09,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxlogscore=827
 mlxscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309120094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Dienstag, 12. September 2023 11:17
> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Hennerich, Michael <Michael.Hennerich@analog.com>; Conor Dooley
> <conor@kernel.org>; Cusco, Ana-Maria <Ana-Maria.Cusco@analog.com>;
> Lars-Peter Clausen <lars@metafoo.de>; Jonathan Cameron
> <jic23@kernel.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] dt-bindings: iio: hmc425a: add entry for HMC540S
>=20
> [External]
>=20
> On Tue, 12 Sep 2023 08:56:56 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>=20
> > On 12/09/2023 08:36, Hennerich, Michael wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Conor Dooley <conor@kernel.org>
> > >> Sent: Mittwoch, 16. August 2023 16:37
> > >> To: Cusco, Ana-Maria <Ana-Maria.Cusco@analog.com>
> > >> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> > >> <Michael.Hennerich@analog.com>; Jonathan Cameron
> > >> <jic23@kernel.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> > >> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> > >> <conor+dt@kernel.org>; linux-iio@vger.kernel.org;
> > >> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > >> Subject: Re: [PATCH 2/2] dt-bindings: iio: hmc425a: add entry for
> > >> HMC540S
> > >>
> > >> [External]
> > >>
> > >> On Wed, Aug 16, 2023 at 02:09:06PM +0300, Ana-Maria Cusco wrote:
> > >>> Added support for HMC540SLP3E broadband 4-bit Silicon IC digital
> > >>> attenuator with a 15 dB control range and wide frequency coverage
> > >>> (0.1 to 8 GHz).
> > >>>
> > >>> Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> > >>
> > >> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > >
> > > Adding missing Signed-off-by tag
> > >
> > > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> >
> > Why it is missing? What is the purpose of this adding?
> >
> > Best regards,
> > Krzysztof
> >
> >
>=20
> Wrong patch.  This is supposed to be on patch 1 where Michael was the
> author (he confirmed intent in response to a linux-next missing sign-off =
mail).
> I've added it there, but if you can reply to that email Michael, it will =
make
> things nice and clear.
>=20
> Jonathan

Sorry - my fault.

The Signed-off-by tag should have been for patch "iio: amplifiers: hmc425a:=
 Add Support HMC540S 4-bit Attenuator"

Regards,
Michael
