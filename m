Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711087B7DB3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242136AbjJDLDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjJDLDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:03:06 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D82BF;
        Wed,  4 Oct 2023 04:03:03 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3947JnBL006410;
        Wed, 4 Oct 2023 07:02:01 -0400
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3th3jg141b-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 07:02:01 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJAN9ESUUTFKHyN+s2S/89OsXCnHLfY7bmsz9RofHU+sgcHoRx90SdW1gC7AJZ6yOWBx4zM7JWoh1DYOGrW4I8Jj1wLzakHlk2G5zX4AgSW/DgPIZEfGeombjEkJygCHGxCcEYWv8g34j0XUU1mNwuA8P9KnBvo0cn0wiSoTzUeZTFQiLDtbLmUOl78ETRDnpHzGDMeRUe2UZBfBROLzRZ3j4d2n+ukYuzN8TgDNd2nppmF1XRtLUuKj08h+MgklvklC4XS9lL4Ny19bZ4Xiq+1NY7adn2+Ve+qnTpe6KyKyNeU905jIUy+h4mHyfEZDhBZ+Cds/MoqP7Wldt1SU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTJ9QgeEp4RCjMY8LckXqVd+qBhjzZSBtaKfHvJaIrU=;
 b=JUfZrruOkViEe+86U7rQp2JiVM123DKmrDZ0E+9VIi5Yf9+j5ULWn/dgImCKi+7kxIMEgxX+fdzZJ2tT8uWC1rVPfuqLIyVpL8FGGlVrfDuqWS5l+xRdq93P+Gme92TTLf1qT8RyO5JiNRpzamVKla9glw8CAhlGzYOGJrVO2vnY2Sz9D93eVnGTLtsrwiwUT5gUr4QIuX8B5ifN9U4kaPRdHmbEQtbhQdhavFyE659TeGoIuFdOUCLMtfsalHYzczTEPEjp0PV8KpLhHAtDB1tsPV4PebG0sUGm3J/n/fq0j5CA+VEaLDs/+FTA+hhV/fx0+KBgYfC0Vx/5JqSdGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTJ9QgeEp4RCjMY8LckXqVd+qBhjzZSBtaKfHvJaIrU=;
 b=MalFYWT4Wakd+QC95a6qGUNWmWpXQggWfZzTYKOJKbVnzHie5PAip/fKKyXUCaDTKHtzG2KryDLflSI2Xc/E9+1SJUfx6V+XULlJ0/xUsAxlmAm5twreqv6vfO6d6UiAEMxrCcpTHrRrnoESvraocRlMWvJPKM2UQV4BBpW6Kl4=
Received: from SN7PR03MB7132.namprd03.prod.outlook.com (2603:10b6:806:352::6)
 by BY5PR03MB5297.namprd03.prod.outlook.com (2603:10b6:a03:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Wed, 4 Oct
 2023 11:01:57 +0000
Received: from SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::b34d:a248:7b9a:c625]) by SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::b34d:a248:7b9a:c625%5]) with mapi id 15.20.6838.016; Wed, 4 Oct 2023
 11:01:57 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 22/27] staging: iio: resolver: ad2s1210: convert LOS
 threshold to event attr
Thread-Topic: [PATCH v3 22/27] staging: iio: resolver: ad2s1210: convert LOS
 threshold to event attr
Thread-Index: AQHZ8voK4kGP7RgaL0+1UUgTmxMToLAzgJiAgAX7huA=
Date:   Wed, 4 Oct 2023 11:01:56 +0000
Message-ID: <SN7PR03MB71329FB51185EAD7BE6C65A78ECBA@SN7PR03MB7132.namprd03.prod.outlook.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-22-fa4364281745@baylibre.com>
 <20230930163209.17ee0020@jic23-huawei>
In-Reply-To: <20230930163209.17ee0020@jic23-huawei>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy02YzNiYTlkZC02MmE1LTExZWUtYjgxZS1iY2Yx?=
 =?us-ascii?Q?NzFjNDc2MTZcYW1lLXRlc3RcNmMzYmE5ZGYtNjJhNS0xMWVlLWI4MWUtYmNm?=
 =?us-ascii?Q?MTcxYzQ3NjE2Ym9keS50eHQiIHN6PSI1MjMyIiB0PSIxMzM0MDg5MDkxNDQ5?=
 =?us-ascii?Q?NTQ1MDgiIGg9Iml5RHo3VG5nYlJkM2F5NlVzTnhjaXJSanNVND0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?Q01GblV2c3ZiWkFSS3lYdEp0d1FOOEVySmUwbTNCQTN3REFBQUFBQUFBQUFB?=
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
x-ms-traffictypediagnostic: SN7PR03MB7132:EE_|BY5PR03MB5297:EE_
x-ms-office365-filtering-correlation-id: cbc3b264-0684-4b60-d1b7-08dbc4c9536e
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1TDHS9jmgdNwJhHPxRHcR1fKVo5SrwHWLb26BoeiyxarFsI6ZN1yrv4AtS7Q+feJq22mOicn6baKEjAyr9jOzNxVYKehcXiwQmq0heRsUmcs0QEIXduAtV++qMb8fnhROsV80V1+2naU6tOGuZVpjwF2aaX5ePKDOqjEuwiW7ez8kRHPtoGS5ooxsDb0gqlN/p0/i3sP83jlr4Nz3O3tPKTVkD6knUyI21uGgwGf3LoiOBpTHVvfwFjoPJI5lf0OhedZOJhD8Ef0cztadN+Zb16F50SE+WFg8o0XnYTtiBvrad9rbmnOM9xRd50/EhrCcxe83QdtPLLvHy4/yRod/Pcr7eNopVeAbAYKI5aN76o92Soxvj4/pXfw3OwLLhyIBhN90x2eZRFlZCelGWNwLTTRf1Y4ROaMlqVGqNQRrQ64EuP+InMYHJ9Ni0snoOrbriUrk/1/FOCGL2NXk8bOk30ipavUUJMSIDx1r0m2K6eIoWWlkOrKTTxqrIn9QuDxP7PcJulJWa9FOfRxWJLol1FnLBT257cSR7mUWL4szZKEY47gRWWUgIFpDOoB3p7F/Faew+uMd5i+C0F6+OMtqlbcu2yZPhui1yCpx0pWkMDS8JlOH1fFY7yCVGtIV5+A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR03MB7132.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(26005)(9686003)(66899024)(83380400001)(86362001)(122000001)(38070700005)(33656002)(55016003)(38100700002)(66446008)(66556008)(66476007)(76116006)(478600001)(7416002)(316002)(64756008)(54906003)(52536014)(66946007)(5660300002)(41300700001)(8936002)(110136005)(4326008)(7696005)(6506007)(8676002)(53546011)(2906002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D/84odI/64ykLw2JnbPtXTawNPtAAIxqyniXmVv8a2JloAf3A+VaiS8buVO/?=
 =?us-ascii?Q?dOEw+qN1B01KPGHavbDZDQX/AJhzNYByXkJ4j6qks0I9RU3gyCr/fZ8cFrxM?=
 =?us-ascii?Q?RUmJvAbwdP+qU0XIYObRyI5ehNVbJL/NkXS2Pxsx//NYn1uXa7v4YdQtavAZ?=
 =?us-ascii?Q?DTIvogy6KBQbXq+nXbmKpfjUABeMYmWh0KoEm1TiFLJRbV/Lelnw4mdXVonH?=
 =?us-ascii?Q?RXbp0f0lLo8voKCSkWZs2elkvgRr3hET+67xybjLOULvpbNq/hdnxza3Wc2E?=
 =?us-ascii?Q?dVXpYeEyhTK6Q1Fzn6ZqQQcS5rWlTMeIeGKDxJTvpoHr3/ntRqWxNpkLH/Le?=
 =?us-ascii?Q?8vZoXZsmDC6YSFcrbQGQEO/TT5g9/jLIZAenQYLRoJyrMbaBeXegLPWP0fIs?=
 =?us-ascii?Q?LYTdk3k5gNhDLbvDqR/lyRzy+9p5I3I1mdz6zaQi3RtX+zlBsXA0M0CWLUhY?=
 =?us-ascii?Q?cPae9+4cSJnZ+mLuwhv+jxx3F6HB4tkJnEEFXMK6GxIxq3Bd2+/KosXUsFD+?=
 =?us-ascii?Q?tEwvkJcL8lVTd3Fcdxqk2NcDVmkNLpA8kaUP08/X47bqTzuZQBATEA7+wPuZ?=
 =?us-ascii?Q?W21Xk8cRFb7IsNDkrZUhlow+8SQ6M/87O8jVFYjmopsZznU+R1PGchqWoQsI?=
 =?us-ascii?Q?3JkiYxG+mkpEaeDdkiJ7BnUJKhEegooFcB0o6IsW2O4XDgrIeb39ujHZp13i?=
 =?us-ascii?Q?Vo/iJSd7zd5vyJotj4UNsipK0zzwMvJlo9GINdvRicH7bu3J5aRLMucMgHAE?=
 =?us-ascii?Q?4hmiIX2Xo1H3iM88TM00k7jYCcotyNHgfr5Oab1WCRpvYzWaf2tYkJ4HZ+Sx?=
 =?us-ascii?Q?1pFBID/TzHGdORdvqZg4HHgfd+5WwjVSlorI66kWu2/brHkfK3TSFdU5OIOg?=
 =?us-ascii?Q?N2gIGuxBWk8cReyjePKt+YqQZYqX5g8LG8v0OtVq6b7UgLHQZ4+XrNu22hdA?=
 =?us-ascii?Q?r2sRccHzJ1C9dP6/WYwBjuGZduXrZcF22EFmumLcSNIcBixN40SlImaWG8+J?=
 =?us-ascii?Q?lFpTw0GZtC8H4YGNpUAq4W6h/50TKOk9bD/lrhNg/FgMCILDw01Lk6bK4Bq3?=
 =?us-ascii?Q?GnwPakki5FQ84h4eSjJ8eO5EgccevtnMG31vDz3O6gSYNUXwPJlIUJf7F8cw?=
 =?us-ascii?Q?ElWiAUWTz+Sd1/MakvkfsT0avVAfbuWYu5Xp/RuvSmB1J1ti1/buAocvhhYK?=
 =?us-ascii?Q?haIXJ5dsW9bWC98uWmVZJHAPbRnyeswTKqOfGYGrwlG72+wUQvu2k1FzzkSb?=
 =?us-ascii?Q?1dDvKq5Ctkx/sDr0EtZD7jy6/i4BxZPzaXzHZztpr2a1/aqvHIAowoZO7J7v?=
 =?us-ascii?Q?2LA6uuS6iaPrLYCCQ7JQSzO6usgiGezcDc2Lx2n1k1cu4kTRcM8bHGByh7ZD?=
 =?us-ascii?Q?QQhl3VFhJlzThXZ0KJlPwjWFXSC0y+OWlYP9+PtD5ZiDL9KH3kiY98JPkcHd?=
 =?us-ascii?Q?VAQEczSyo8RbfWoraCYDt4QG3pO7HGYAiKxKgmHAaqj7tLSebTxgGgXmMMYL?=
 =?us-ascii?Q?qZeAgGFtT4m7loeWQVRj9gGYWyc+QqoXRUGh0bPDIRB0Z0J6/VipfPmQFOwD?=
 =?us-ascii?Q?LlvQoYHDMSmvPtoSe975h5lRTayt4aqujaswGDXmR4zcvDdAQmBB87aawW/B?=
 =?us-ascii?Q?pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR03MB7132.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc3b264-0684-4b60-d1b7-08dbc4c9536e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 11:01:56.9805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbbVJ0FVtJttSLC9LBvCc/36o42wkwTyfh9u0PaP1JfN35GanC6off/EalQgWlv9HaJORGS4dljhtDzbZ027ySYqFJCBPF8G72zICG/pFmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5297
X-Proofpoint-ORIG-GUID: ATNzkWjhXjf-mxwMYmgsY_cMgr8P3fMZ
X-Proofpoint-GUID: ATNzkWjhXjf-mxwMYmgsY_cMgr8P3fMZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_02,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2310040080
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Samstag, 30. September 2023 17:32
> To: David Lechner <dlechner@baylibre.com>
> Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> staging@lists.linux.dev; David Lechner <david@lechnology.com>; Rob Herrin=
g
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> Hennerich, Michael <Michael.Hennerich@analog.com>; Sa, Nuno
> <Nuno.Sa@analog.com>; Axel Haslam <ahaslam@baylibre.com>; Philip Molloy
> <pmolloy@baylibre.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3 22/27] staging: iio: resolver: ad2s1210: convert L=
OS
> threshold to event attr
>=20
>=20
> On Fri, 29 Sep 2023 12:23:27 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > From: David Lechner <david@lechnology.com>
> >
> > From: David Lechner <dlechner@baylibre.com>
> >
> > The AD2S1210 has a programmable threshold for the loss of signal (LOS)
> > fault. This fault is triggered when either the sine or cosine input
> > falls below the threshold voltage.
> >
> > This patch converts the custom device LOS threshold attribute to an
> > event falling edge threshold attribute on a new monitor signal channel.
> > The monitor signal is an internal signal that combines the amplitudes
> > of the sine and cosine inputs as well as the current angle and
> > position output. This signal is used to detect faults in the input sign=
als.
> >
> > The attribute now uses millivolts instead of the raw register value in
> > accordance with the IIO ABI.
> >
> > Emitting the event will be implemented in a later patch.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
>=20
> I think I'm fine with treating these internal signals like this, but I wo=
uld ideally
> like someone from Analog devices to take a look at how these are being do=
ne
> and make sure our interpretations of the signals make sense to them.  We =
are
> pushing the boundaries a little here (though we have done similar before =
for
> fault events I think.)

Hi Jonathan,
David and I we also had some internal discussion related to this.
I'm sure these fault events and thresholds are understood correctly.
Doing it this or the other way, it needs to be properly documented in order=
 to make sense.
So from my perspective whatever makes the most sense from a IIO ABI
perspective, is the way to forward.

-Michael

>=20
> Jonathan

