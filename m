Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8523D768B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjGaFY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGaFYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:24:54 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1A0E5B;
        Sun, 30 Jul 2023 22:24:53 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36V509Hp028733;
        Mon, 31 Jul 2023 01:24:52 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3s66dwg46w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 01:24:50 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAZB6lwKFjUGokIJ+qu5OrwfXuUz5uySYTWugyj+CBVaMoWFH01GTd7bY1jbBwKHLcMMCbkHPNQfWr870xxb813QA/t9Xuz0D3gf8h17n7IuoHHE84uWvAfl7mXRcb/oy9qUrptnpu3hI/dqc9vRD5m2HwTfoXhycL0/wqhQoP4WzoJW2PM44nEkwQS6XhE0ImEaiq/6WDiQDFkxsVcTIPZ6n6AwaINYHGAGBwEe+s4vL1ADQtpInRRA9nWpo5Ub6h6fb2857Wl9F3EmS9oZo9kcWiu6hdBkpt8/MkEnbJRcheP/4ka7sRDwzwJjRHyY+peO2kzGWeFGkU7kbLXdxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTM0DqsSC2LzUQddfMdPOLDQnFTpQsJfsJNtD7B5720=;
 b=bdaaGzkNUzDQWFrtj9rxV9FvQSGjpcD6BNvc7nkrnSLpg4cks1do5My8ZlcdLa0htFzBYROU0d/fLNk2/6kPnWn6RNuJ6SJ9LYyRZs92fKRkhSieg8zqlnwxgc9OnLgbcBRVq4NDKJTybmdebEb+350Iwv0ksbQRmNXJcbptO4S5PhfLoXZJuELi5z0jzzvwzi6mwQxWkeN92wmnMpfHrumZsojGG6+1460yCPMd0R36lfCs7TGGDao6AGeCBqsL1uE5vtGWo0736GSXbgLN+AEgY2ECx0xEwocgRHHWkRWuCl+nsxBpInRG8YydMiNN83HEU1DEdYQ/mVZXlJlg+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTM0DqsSC2LzUQddfMdPOLDQnFTpQsJfsJNtD7B5720=;
 b=OP33xQUpu0xjmonFztL+KS+LdlBf/ZivNvfMl4uagPzPaHUuhqAoYWX/5VxgOcZ7Rt210S1cUiZ15KGFg5//vNoVDExqq4MW17tUE/Ujzh7HF3leuOo9iCNmJFp37I/6G7NVIjar3yLaEHsl/eAU0TfRo3o4SvBcAYVxVgzEuZA=
Received: from SN7PR03MB7132.namprd03.prod.outlook.com (2603:10b6:806:352::6)
 by BN8PR03MB5027.namprd03.prod.outlook.com (2603:10b6:408:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 05:23:17 +0000
Received: from SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::4a36:f52e:cc42:6fa4]) by SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::4a36:f52e:cc42:6fa4%7]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 05:23:17 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 06/22] Input: ad7879 - use device core to create
 driver-specific device attributes
Thread-Topic: [PATCH 06/22] Input: ad7879 - use device core to create
 driver-specific device attributes
Thread-Index: AQHZwbbZbO2grsPsx0qjoFba3JQuBK/TWrmw
Date:   Mon, 31 Jul 2023 05:23:17 +0000
Message-ID: <SN7PR03MB713216EB5C7C4E74BCC2F4D08E05A@SN7PR03MB7132.namprd03.prod.outlook.com>
References: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
 <20230729005133.1095051-6-dmitry.torokhov@gmail.com>
In-Reply-To: <20230729005133.1095051-6-dmitry.torokhov@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy01OTdiM2Q5MS0yZjYyLTExZWUtYjdmNy1iY2Yx?=
 =?us-ascii?Q?NzFjNDc2MTZcYW1lLXRlc3RcNTk3YjNkOTMtMmY2Mi0xMWVlLWI3ZjctYmNm?=
 =?us-ascii?Q?MTcxYzQ3NjE2Ym9keS50eHQiIHN6PSI4MDcyIiB0PSIxMzMzNTI1NDU5NTk4?=
 =?us-ascii?Q?MDUwMTIiIGg9IjhXOUZodXN1WUZCTWZtK2hwZGtWVnlsOWd1RT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QlVBTlFiYjhQWkFRYW03UmZWd2JFUUJxYnRGOVhCc1JBREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBdmRoa3hnQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
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
x-ms-traffictypediagnostic: SN7PR03MB7132:EE_|BN8PR03MB5027:EE_
x-ms-office365-filtering-correlation-id: 85b8ce34-482b-4c11-a90b-08db91863f26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pm70nZi2rJiSo+mYBV2u3rp/ciHMb8ViQ/Ru553u7UUb6DnFphvJfYEZX6h8O5+WzYLn4gAeMmjuNewJeRPPCHcdeCxDYUrSK9SYX1NcbQP7Tz9RZ93lXh0IlQfcR5kep7QQCwgQOdSWdtzazekLC1ptrrwIvrRAkJtCx/yh6htkdaK6AWmQe8HOr+H4M+1WD95kPi4uGQV2hreTu9/fS2q81L0TtjUHVewjJ7ZP8Be3kKR8hLgdt/I7gxwrc526GGoKYpbdi2voGo1EcqltIvqXgowznf69Bj7kKd4CLBGCNzT4MHCn3Gw4NGZsNvVM8BmDLgTocXbFLcGJ/eyjnj2AoiAXZldPmYqflNTEIzqcFqy4pMZhLcxuRL+I/NskKWLlFE3PHpmpZ83kCW/q2+OQ47putSoqUFsqh1LJh5MlPwl8OxHdN1KJq5kPFSpsJ09f5o4ZBnjnAy9x1RMGPqji3qIFZ0gmCi15R4xA9E4tHqyjGGJC/H2cnxcGCm8dKif+Wgkprf0+2++t7X5xbGi3Y7yN5IjTgm1ISVc6B8OyRmdYhF8TjOOM+KOXK07Ua1kVi6CjJ8hy0RAXrp7+Hhr5nX97aj+XhAySxTnlLIcZBcmQS6VkrCIceUgqM9Kt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR03MB7132.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39850400004)(376002)(346002)(396003)(136003)(451199021)(9686003)(7696005)(55016003)(53546011)(6506007)(26005)(83380400001)(186003)(33656002)(76116006)(66946007)(52536014)(66556008)(38070700005)(122000001)(54906003)(110136005)(41300700001)(86362001)(66476007)(316002)(66446008)(64756008)(4326008)(5660300002)(8936002)(8676002)(38100700002)(2906002)(71200400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?esLvDyvd3HPN6f29zpIyzDTg7v06B3XveGSTuwjyUONKRd4cngRYiAduCgcR?=
 =?us-ascii?Q?oTAMcwLUMNsnRupFKT8YVzZdhO5eVqzMSLmBBHVuGsZRB1SxuNjONGej9QsS?=
 =?us-ascii?Q?ExNj6TOfydzWuJQADEYeHgZGBZ+l42bFGPw1E9mr5sT4HzNLEwACZXJNIZ1s?=
 =?us-ascii?Q?41Id0Ko8xF0Cp5l4ysaJ7cbS8T6qIIPA+cN8/sjXt/x8GYt847QifxAwWPJs?=
 =?us-ascii?Q?swyH7NgbiABOM0e6p3+9pPDHQlWph4FMrsQhTDyiVYdvQBShqJkaijx1H4Ye?=
 =?us-ascii?Q?icm4K464eq8LXSVj730suc+J0m6es4cXq6qnQKEupCaheA7LPKEgzaBrDLbl?=
 =?us-ascii?Q?tZYDgic3U/qT3eW3ZAKD+Wx9STw3x63VdsmrEBUvLOVibMP3+Q2quYvHpRac?=
 =?us-ascii?Q?9ixN0lgcH5alJNAGu0KxM2KVvkhggS5sCXxsr8d3nNGiJAE8muULFL2A2ngA?=
 =?us-ascii?Q?S7jBEORhYDLUAgHTs6YQ1SX62DIir6LiJRxS6qaoMHi/v2kPs0OJjK48Seji?=
 =?us-ascii?Q?i3TjK8dGq2M93Y+7mVOUGy0OGoQESAs9RawzIXsfAQY1u8AK9+giMmsfzARs?=
 =?us-ascii?Q?xKLjhXhq3krnToSR9SImiJBiN0wQnIdT5K/yGS4z8F4naiPE/omOOWsMUxqJ?=
 =?us-ascii?Q?kS3/C6Y7pjhrkJOPrghahUYwkhRfrUfSf8CwEVOzEXz0SNJmHgz7elx4OGDM?=
 =?us-ascii?Q?5cfz40Lizm/OoknuPQTU3Sh/voWZBQ23bIoDKlD8Msugz5PcH1emoDJ2sR1y?=
 =?us-ascii?Q?KUHCkIPrwG8TKbP3BH6drRdYp4YWZovP6iZ5S2gyCp4O6OHhLCj1TNZ0FfTI?=
 =?us-ascii?Q?JTEziK8B2GuqeTtepcE3VaU3haXszq3xzwTXD3ssFUpYlPOWz35XB0+g9hDp?=
 =?us-ascii?Q?D708KDQLlmYRCXnkQH6YDPZBxQJH+VwYrTT9h8uuwxsFktF+w51jynXJCzOZ?=
 =?us-ascii?Q?sDADFE+jad9frWrR8x8KcIOtM1o8+yOMqcwO6GC8hhg6xwHf0ZUrDldneacA?=
 =?us-ascii?Q?rcO3vHnok4JaP04gVZPY5A1cbZN+hRZLIi9sSULoN9/PC1qot3AZ+Rdj+mU1?=
 =?us-ascii?Q?V+xdHhuIAZ83P82jnxJHUpu1mMz5hSkwsc379t7c9IkmAByI/AudvrAI75z1?=
 =?us-ascii?Q?j2t5St6KA54hgyIPzoaECOKl5jHW2doaGznoZP+BxAm2KsPgYkz1FQo2tmYE?=
 =?us-ascii?Q?7ic8dtXQ9vGABQNOl3VlhzIXAGcyEzupfgRDqgsmNMJS4khuOxmh6BrJd8Ao?=
 =?us-ascii?Q?WI/XQxFTD3r49rv67dA6UEJe141h0RBcXY4sDzSBdEeC4sVU4gJfPsmuxJkx?=
 =?us-ascii?Q?YP3b2owqFl4xxHYmXba55H1xLqUjn/9C41NHLHkqwyIMiRUOiibJsHtUEGA8?=
 =?us-ascii?Q?uzaUT8sUCnVD2+82XCNmTg5jcEXHUtUrga0ScqeQBU6ToWLpDGP6OpaIhxEK?=
 =?us-ascii?Q?UnzXZ7EJtOdqRPir9ZYUgytfla/TyvKp6v37SMQ7iQiqnTASf4hnJfKf/Jp5?=
 =?us-ascii?Q?qpsRTLMkGeZoMfnIY7nbPyJedODPvIPylRuHqVBDtEkXZ5HfSvuyHgXF5Jn6?=
 =?us-ascii?Q?YGlygIMFBZqcSRpR9HVvzFj0HjQS4XhU6iNscrND+ppVmLrMiRYlykkvnwiK?=
 =?us-ascii?Q?ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR03MB7132.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b8ce34-482b-4c11-a90b-08db91863f26
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 05:23:17.3969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixZqQclWjykZujfFwAxsbFBFAxz8geHnpJXyLhbLKhLowvT+YtXoK22ITJy9jbURrPI3gI3G4wuRrZUZYqeVyP7y8coTR3dZwPmEKRf5pj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5027
X-Proofpoint-ORIG-GUID: yqOTIpgLfnWIXdo0pJYEIKPOiVhFaQ_V
X-Proofpoint-GUID: yqOTIpgLfnWIXdo0pJYEIKPOiVhFaQ_V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2306200000
 definitions=main-2307310048
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Sent: Samstag, 29. Juli 2023 02:51
> To: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Hennerich, Michael
> <Michael.Hennerich@analog.com>
> Subject: [PATCH 06/22] Input: ad7879 - use device core to create driver-
> specific device attributes
>=20
> Instead of creating driver-specific device attributes with
> devm_device_add_group() have device core do this by setting up dev_groups
> pointer in the driver structure.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/input/touchscreen/ad7879-i2c.c |  7 ++++---
> drivers/input/touchscreen/ad7879-spi.c |  7 ++++---
>  drivers/input/touchscreen/ad7879.c     | 10 ++++++----
>  drivers/input/touchscreen/ad7879.h     |  3 +++
>  4 files changed, 17 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/ad7879-i2c.c
> b/drivers/input/touchscreen/ad7879-i2c.c
> index feaa6f8b01ed..5c094ab74698 100644
> --- a/drivers/input/touchscreen/ad7879-i2c.c
> +++ b/drivers/input/touchscreen/ad7879-i2c.c
> @@ -58,9 +58,10 @@ MODULE_DEVICE_TABLE(of, ad7879_i2c_dt_ids);
>=20
>  static struct i2c_driver ad7879_i2c_driver =3D {
>  	.driver =3D {
> -		.name	=3D "ad7879",
> -		.pm	=3D &ad7879_pm_ops,
> -		.of_match_table =3D of_match_ptr(ad7879_i2c_dt_ids),
> +		.name		=3D "ad7879",
> +		.dev_groups	=3D ad7879_groups,
> +		.pm		=3D &ad7879_pm_ops,
> +		.of_match_table	=3D of_match_ptr(ad7879_i2c_dt_ids),
>  	},
>  	.probe		=3D ad7879_i2c_probe,
>  	.id_table	=3D ad7879_id,
> diff --git a/drivers/input/touchscreen/ad7879-spi.c
> b/drivers/input/touchscreen/ad7879-spi.c
> index 50e889846800..064968fe57cf 100644
> --- a/drivers/input/touchscreen/ad7879-spi.c
> +++ b/drivers/input/touchscreen/ad7879-spi.c
> @@ -56,9 +56,10 @@ MODULE_DEVICE_TABLE(of, ad7879_spi_dt_ids);
>=20
>  static struct spi_driver ad7879_spi_driver =3D {
>  	.driver =3D {
> -		.name	=3D "ad7879",
> -		.pm	=3D &ad7879_pm_ops,
> -		.of_match_table =3D of_match_ptr(ad7879_spi_dt_ids),
> +		.name		=3D "ad7879",
> +		.dev_groups	=3D ad7879_groups,
> +		.pm		=3D &ad7879_pm_ops,
> +		.of_match_table	=3D of_match_ptr(ad7879_spi_dt_ids),
>  	},
>  	.probe		=3D ad7879_spi_probe,
>  };
> diff --git a/drivers/input/touchscreen/ad7879.c
> b/drivers/input/touchscreen/ad7879.c
> index e850853328f1..e5d69bf2276e 100644
> --- a/drivers/input/touchscreen/ad7879.c
> +++ b/drivers/input/touchscreen/ad7879.c
> @@ -391,6 +391,12 @@ static const struct attribute_group
> ad7879_attr_group =3D {
>  	.attrs =3D ad7879_attributes,
>  };
>=20
> +const struct attribute_group *ad7879_groups[] =3D {
> +	&ad7879_attr_group,
> +	NULL
> +};
> +EXPORT_SYMBOL_GPL(ad7879_groups);
> +
>  #ifdef CONFIG_GPIOLIB
>  static int ad7879_gpio_direction_input(struct gpio_chip *chip,
>  					unsigned gpio)
> @@ -612,10 +618,6 @@ int ad7879_probe(struct device *dev, struct regmap
> *regmap,
>=20
>  	__ad7879_disable(ts);
>=20
> -	err =3D devm_device_add_group(dev, &ad7879_attr_group);
> -	if (err)
> -		return err;
> -
>  	err =3D ad7879_gpio_add(ts);
>  	if (err)
>  		return err;
> diff --git a/drivers/input/touchscreen/ad7879.h
> b/drivers/input/touchscreen/ad7879.h
> index ae8aa1428e56..d71a8e787290 100644
> --- a/drivers/input/touchscreen/ad7879.h
> +++ b/drivers/input/touchscreen/ad7879.h
> @@ -8,11 +8,14 @@
>  #ifndef _AD7879_H_
>  #define _AD7879_H_
>=20
> +#include <linux/pm.h>
>  #include <linux/types.h>
>=20
> +struct attribute_group;
>  struct device;
>  struct regmap;
>=20
> +extern const struct attribute_group *ad7879_groups[];
>  extern const struct dev_pm_ops ad7879_pm_ops;
>=20
>  int ad7879_probe(struct device *dev, struct regmap *regmap,
> --
> 2.41.0.487.g6d72f3e995-goog

