Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E292752A06
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjGMRty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjGMRtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:49:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614732736;
        Thu, 13 Jul 2023 10:49:49 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D9nGuF003196;
        Thu, 13 Jul 2023 17:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=sv4lLnqfXqOKayLDKOaqeb9bNzlFu4wZGmBxwvh4Pgw=;
 b=aUbDWY9UOV9HcTMKYiDRCWQsQlmCf+1FN63vIZweZAbBSuUrQBvaqu4A2Hr/G9gZ2d1L
 XSBqGUbbpPCDzBMkoGZNak12nFx1keDOv/G/DC0BD7Xrz8qmvPNVNq/DE7i3At6DzsuJ
 /7N4+feEmvnw7rJP0BSOuHUi90g3O08FtZ/365eWKgv09g8Y8RMb8edHbg9BHmUBSCEi
 /06dT8Xss7Eht5wgsH4V1n81K7mm33Fl5rW3JJpveqmjcnfXj0aFNSw78rpF8zRAqkzc
 nCP/ulznHlEvCMsduy0Gh4kSss3gXrimJIE1A8Ym3vECHbFWIzzu+FGBOip+izFzwUuo FA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rt3qfj7aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 17:49:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpkMp/8bIpXVd3J67Xuv0+VJ4dZ9M9Lf6Ez6zqtMKErBL5cn+S2NDynwX4IrC0aPPH3BXjObTqjxmT6F2ylNlb6emXVAEestDJ3OsjpWdFJxbTzS1ZH6+t3+8SkPOvQ6jHnWyilAKOvYAr3iOFYJCHu6iVFiDhBi6iFBLGtK2a6wvyubBJVbiKbZhl/4xjEdkePAGcbX9iljvKhyAINcUHF/LbvsqQzaFopo/KHoIobdVsfPFZn/q//SW3t1gkWVjQPoo2LDpgOwkXJqvukiQYLghtrLTW7CHF2jPi4xndXmlcjlubprV1kaJ1KeFUpBz5OBEQtuh7SBLEuGs4Uq5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sv4lLnqfXqOKayLDKOaqeb9bNzlFu4wZGmBxwvh4Pgw=;
 b=IV7ERpJg5hTqvMSxobzvBy124yLc+YSEjQ50B4kFBtWphSrQi9HXbhNTk1Wzln65r+6JC/Yidz5ru+UgV6g7CMSfWC+u8v6XiiW4Knzg2l7VlC2vMwL1g31ksVhi8jNAgq7BHMFX5GfhDcltMwGr/c4s0HMjv9XdegSHT8rZDsYqvv6JgOiX2/JwZ5wp5tSbA7r+uALXEZkbmyg9qvU8ec45KHn3sSLKNR4O8Ikt21gVHFKYK6VH3fNyEVfWv/FcwPvy7GClmuApoegTh6K1CFK2XqDbR46BUhGqJdK5JjAAmGrLAHCrMdeAeZiQlB2YTM7GW/8MPjufVLTPhkk1nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from BY5PR02MB6770.namprd02.prod.outlook.com (2603:10b6:a03:20c::17)
 by PH7PR02MB8905.namprd02.prod.outlook.com (2603:10b6:510:1ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.19; Thu, 13 Jul
 2023 17:49:42 +0000
Received: from BY5PR02MB6770.namprd02.prod.outlook.com
 ([fe80::35f5:e657:3d42:8d6e]) by BY5PR02MB6770.namprd02.prod.outlook.com
 ([fe80::35f5:e657:3d42:8d6e%4]) with mapi id 15.20.6609.011; Thu, 13 Jul 2023
 17:49:42 +0000
From:   Mukesh Savaliya <msavaliy@qti.qualcomm.com>
To:     "Praveen Talari (QUIC)" <quic_ptalari@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        "Visweswara Tanuku (QUIC)" <quic_vtanuku@quicinc.com>,
        "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>,
        "Aniket RANDIVE (QUIC)" <quic_arandive@quicinc.com>,
        Praveen Talari <ptalari@qti.qualcomm.com>
Subject: RE: [PATCH v6 2/2] spi: spi-geni-qcom: Add SPI Device mode support
 for GENI based QuPv3
Thread-Topic: [PATCH v6 2/2] spi: spi-geni-qcom: Add SPI Device mode support
 for GENI based QuPv3
Thread-Index: AQHZtYCTXTYSdfyxgUmSpYcRilxn/6+39o4w
Date:   Thu, 13 Jul 2023 17:49:42 +0000
Message-ID: <BY5PR02MB6770F63AF7918E906851E98EE637A@BY5PR02MB6770.namprd02.prod.outlook.com>
References: <20230713115145.16770-1-quic_ptalari@quicinc.com>
 <20230713115145.16770-3-quic_ptalari@quicinc.com>
In-Reply-To: <20230713115145.16770-3-quic_ptalari@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR02MB6770:EE_|PH7PR02MB8905:EE_
x-ms-office365-filtering-correlation-id: 64791f1a-a5aa-414c-f4d1-08db83c98976
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yYRaLi8ADNwi1v7026CGq/wGQLRqqM8zbUcIoG2lW+j434biIOn+yQ0ehIWIq9awD21L3yxwggjEQ8tiVl6pbmoQgF/3CqM+yC/4rIG6FfF9s+cHXf8R7M8sKHJ4GUbJiV6gdyHuEdKEAcwvR6tWaiwWCh4qwdFg7qZGKqvn/eOtp+V+UXDxGxjtAiP9L6pZS5vBU5n2eJ1/kfu3uucA1pd/qI6HZ+v1Ssygb7TKzZHM3RiVzhIuhh/RZoyDLmQpSl9VGkHxiXcmnGDQvy7F5Rwaf9HadEuqngHYxv9NUsOcKR6J84Nj8NbXRnBdsZf1vIDh2ulBtd3mxj36AW0LSRSYdvKNM13pFxRbG6RtJODftPEM9WbLDAGk77weQXaQeGZICmpYTuME+00HXHp6aNAfHjVCIMAKDBHgMZ5Xs9oWb5fwF6KVCv8yFocoRL7AZGg1gNKZBZPaSEcSOr4HpeA35EBoe6X2SHzHWJwJyN/DkG9DF1MQIiUNjwNgRkjQHFROpnbMOylYykZiBY0kIl8Zm++hTqfBug5SBTQhcO/m8KTkslxpay5vORct+79P5pByqa7rKWEpztKSB7gOXSIobFqOwKQ9Nb/7XTYF82UutkIOdPUfwCtKQfUYUpor
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6770.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(38070700005)(33656002)(86362001)(55016003)(38100700002)(478600001)(122000001)(71200400001)(8936002)(54906003)(7696005)(9686003)(8676002)(110136005)(5660300002)(52536014)(2906002)(4326008)(316002)(76116006)(66946007)(66476007)(64756008)(66556008)(66446008)(41300700001)(26005)(6506007)(107886003)(53546011)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cPHbyHRFGSoCQoVF9mC/aZNllsggCD/EFyz7X9ClX05bksNlx3Vu460sm8DX?=
 =?us-ascii?Q?IZlPsLouUA1r3lACT6MzEKQUybzHWXWO4D8paqOq87bAxSRAxRD5b9IY4rx3?=
 =?us-ascii?Q?MhVfHl7hRW4YIyOQLlSWZ3R8HfCg7fE05CE0Ue+n58FJ98TgycoK/4FsBWEh?=
 =?us-ascii?Q?2em+v0/wv1d4GoHaglC3onY3Z9oRX8BXMT4wrL6g5idvv96kDmqN1CslLSBm?=
 =?us-ascii?Q?0A8bPre4Q4TNyFXEM4a76B4uQIjjqBQ0xUrD+22JZw0jC1AKG1g7gB8kJKan?=
 =?us-ascii?Q?iNVpCxLXmWh/m+Pn2NoiUnLeSoev3SZgmq58CacUib8k82tpQTFkoSuWLg2p?=
 =?us-ascii?Q?Ea/GxYQiM+QR4mKbLDItxzB/xaCfEh5DGiOtK/sh4ek4Rqp25K7N0+YmNs9v?=
 =?us-ascii?Q?kHjEuiHuzbBBUQsmng2fOdMLoDXpRGyWYXrb/wZN2Yh2oE/P7s3Esbzficd8?=
 =?us-ascii?Q?OhPBGJt97Yjy64a+kg7cNuSi9f8n+0pX58AdGtHjfxDJ+HBKHfUW788UAKBx?=
 =?us-ascii?Q?l+3qtwm//gYTwhjS6i0DvbEcp3jojraN2eaFpoQA94QfbwisDZksEKnUH1Pb?=
 =?us-ascii?Q?6vqlZka9/VU8XQUfo7d8GvUGRXfHe6+vm9pyryFWj9aNtUzNEMeclB7v+cT2?=
 =?us-ascii?Q?YDNm33Mf5rpR6wuFyy6ar9MeuF8wp3A733RGkoEPBPG1pilgvqpgs8kHaWFX?=
 =?us-ascii?Q?ysobnXkTt8zKj24+HavLQ7jVY3fsJDeijdM8OP8erziQ/N5eYN/WvXJsKx1F?=
 =?us-ascii?Q?9hpqXdVaQWQ/DbQH7mt+mW0eL7sPxKxh2f5hsqvAMSF30SIHWyoFmocSvFEP?=
 =?us-ascii?Q?rNBBo1FNLerw3u2dgsgOHrbMCKxyBGOmaYlvFDFU8jDIbyWb/IC9bVPnHfeI?=
 =?us-ascii?Q?JqM0lfBb8e/qwIY0/Vt2SybOtq8BsxDdCKeb3sVGzBWRWENNUFKM+Gb9mm2p?=
 =?us-ascii?Q?2XdMWeBMonEDAjBuZDqBRjgdgpc/UC9dZojm4Yfj+syIkNyQAx9b852nnJHu?=
 =?us-ascii?Q?BM9m5yHLS/0L3OGNdz9XLweQ9NvIVnKD+BEQeYn+ZZOZHxxaFcU8UwChClzf?=
 =?us-ascii?Q?vYoxB/EmeygILq+A8bdscPjcrHnl3BztcAYZ0+VPZNvJwn9JVUU5jiiRxt8U?=
 =?us-ascii?Q?2Bq46yv/BAku6QZT6WFY6G4dWiImP8YSOdsxvYzLK9fHmyx0UPIQxXzFujkR?=
 =?us-ascii?Q?x1xBfhLNVUCzxiPGu+IU7w8ga47RwjG/YI2nvhMq9mt43w7SS08B+dTdQMDV?=
 =?us-ascii?Q?65MGXK+QjsMUzc5Yhh/HABWwj8a1plgbbf7URXrVUtE5532QB1yBkP02Od3P?=
 =?us-ascii?Q?tWmGeXiO4BpaEwb/Q07DTHQkP24sKGCj6fySVcrVnUXN7Iaawqj5T0MXnV2j?=
 =?us-ascii?Q?zSJCoONVp5zQwcrHLBW9PyfpgLc5PBFYD/vxGXf2o5v3e0M00STOgnbS6g5b?=
 =?us-ascii?Q?KeI2pOnWRgsvWlfESPfMjeeADXZ85LSwRO8GWQW9wyAkYmVQYdTdDtImGOV4?=
 =?us-ascii?Q?GhcUWuEM+ZIFiNOwOlu8hvWIA8lPnhWXnelvctyGOxRDD/c21MQgBH2YaJtF?=
 =?us-ascii?Q?283zz5Ob4gTRo6tIM17eC1diXeV8DSt6NjDlHd8x?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ctH2l6WpnZZ81Ou0LNcUbGX/0uRtHY4krBYRotLFIitpv+YmgMhZdRE2IXvs6Rt97R3dyLGLdNfQlOSN0vxB3m5DSa+EQtaGK84UVbtUSJ8m08UoSEFQ8bZBGMnMit/fT249oYY2BlGSPn1/imedKvnGF1CXy4gmPRb2fD6RAHwXgk+fO9mZbr03/hkftYRY5qBPoD8lZ50R/6srwLMfvzWk0AyIj32c8sOXKcraA321+BgYbuiq+pwke1v+mzKdtSQiM1KLAlFLH76Bzgneb58ANfKcx6AgbQT4BiS35APNq/WYdA7kLKRduA3WzXe80mUW/AtQkIpE75V0cKxsRC2Q5l9ppDqbZevYfYPHG3na0hVagEmcKpKwMUiyCT9EI7SIp1GZvt3DU5lhyg/O9kwit4Th7ZXeUtp8Kypy7Xxe5N35IzA4geOWfxbcMSpOPZfkn7p1nbhy49kZe3n04/MTGIvhZ4Ji8g4ASOd6Me4An0HoC+Je3uOuQFHpn79UxnIcZKS1k1J4PxD7Lr3MXKK/q4evHSvBdElbTg9ROxPH4CFAb2BfAhWtYxoTcgTH58jP9nYJVS2O582PyUfA3WzbIsqsJ/CaE+7oZxQu4AatDE2eV0bh0192WdKXywvnwb7TJH1+pjyPqtYsdZphL7qmwTb9JxDXwtL3n+ZydEHkCDQ5gCxVxMxO4M48ptIP2JCjfpNwdTOd82lw3e7ei4k72doHqefCaaKrucTZoxdlDQyh0v2C547wGhm5zUGVq3WKqq8C5zN8EBVpvmutfqHs3tVX+yGRU81z5A/p5tRSvikWvtPPp/hNqlhiIkv21VeqcwZI3Y4jApyZ48dqoA==
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6770.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64791f1a-a5aa-414c-f4d1-08db83c98976
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 17:49:42.0538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3znnSP+6EJFLoLdhz22K3K7qg9mb61qWgKud/ptOoHHN8BMKVVrHfz/Rv03CF2RA/gp0JxqvTMwPDyzwzN9DcALIAj4eAK3g222mkG7AUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8905
X-Proofpoint-ORIG-GUID: E6jU6W8TY_ce0xTTnkgdHmVBecqoICRX
X-Proofpoint-GUID: E6jU6W8TY_ce0xTTnkgdHmVBecqoICRX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307130158
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Praveen Talari (QUIC)
> Sent: Thursday, July 13, 2023 5:22 PM
> To: agross@kernel.org; andersson@kernel.org; konrad.dybcio@linaro.org;
> broonie@kernel.org; linux-arm-msm@vger.kernel.org; linux-
> spi@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Mukesh Savaliya (QUIC) <quic_msavaliy@quicinc.com>; Visweswara
> Tanuku (QUIC) <quic_vtanuku@quicinc.com>; Vijaya Krishna Nivarthi (Temp)
> (QUIC) <quic_vnivarth@quicinc.com>; Aniket RANDIVE (QUIC)
> <quic_arandive@quicinc.com>; Praveen Talari <ptalari@qti.qualcomm.com>
> Subject: [PATCH v6 2/2] spi: spi-geni-qcom: Add SPI Device mode support f=
or
> GENI based QuPv3
>=20
> From: Praveen Talari <ptalari@qti.qualcomm.com>
>=20
> Currently spi geni driver supports only master mode operation.
>=20
> Add spi device mode support to GENI based QuPv3.
>=20
> Signed-off-by: Praveen Talari <ptalari@qti.qualcomm.com>
> ---
> v4 -> v5:
> - added code comments
> - dropped get_spi_master api.
>=20
> v3 -> v4:
> - Used existing property spi-slave.
>=20
> v2 -> v3:
> - modified commit message to use device mode instead of slave mode
>=20
> v1 -> v2
> - modified the commit message
> - added the code changes for code comments
> ---
>  drivers/spi/spi-geni-qcom.c | 53 ++++++++++++++++++++++++++++++++--
> ---
>  1 file changed, 47 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c in=
dex
> 206cc04bb1ed..06b114f3f21a 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -12,6 +12,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>  #include <linux/soc/qcom/geni-se.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spinlock.h>
> @@ -52,6 +53,9 @@
>  #define SPI_CS_CLK_DELAY_MSK		GENMASK(19, 10)
>  #define SPI_CS_CLK_DELAY_SHFT		10
>=20
> +#define SE_SPI_SLAVE_EN				(0x2BC)
> +#define SPI_SLAVE_EN				BIT(0)
> +
>  /* M_CMD OP codes for SPI */
>  #define SPI_TX_ONLY		1
>  #define SPI_RX_ONLY		2
> @@ -99,6 +103,16 @@ struct spi_geni_master {
>  	int cur_xfer_mode;
>  };
>=20
> +static void spi_slv_setup(struct spi_geni_master *mas) {
> +	struct geni_se *se =3D &mas->se;
> +
> +	writel(SPI_SLAVE_EN, se->base + SE_SPI_SLAVE_EN);
> +	writel(GENI_IO_MUX_0_EN, se->base + GENI_OUTPUT_CTRL);
> +	writel(START_TRIGGER, se->base + SE_GENI_CFG_SEQ_START);
> +	dev_dbg(mas->dev, "spi slave setup done\n"); }
> +
>  static int get_spi_clk_cfg(unsigned int speed_hz,
>  			struct spi_geni_master *mas,
>  			unsigned int *clk_idx,
> @@ -140,12 +154,22 @@ static void handle_se_timeout(struct spi_master
> *spi,
>  	const struct spi_transfer *xfer;
>=20
>  	spin_lock_irq(&mas->lock);
> -	reinit_completion(&mas->cancel_done);
>  	if (mas->cur_xfer_mode =3D=3D GENI_SE_FIFO)
>  		writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
>=20
>  	xfer =3D mas->cur_xfer;
>  	mas->cur_xfer =3D NULL;
> +
> +	if (spi->slave) {
> +		/*
> +		 * skip CMD Cancel sequnece since spi slave
> +		 * doesn`t support CMD Cancel sequnece
> +		 */
> +		spin_unlock_irq(&mas->lock);
> +		goto unmap_if_dma;
> +	}
> +
> +	reinit_completion(&mas->cancel_done);
>  	geni_se_cancel_m_cmd(se);
>  	spin_unlock_irq(&mas->lock);
>=20
> @@ -542,6 +566,10 @@ static bool geni_can_dma(struct spi_controller *ctlr=
,
>  	if (mas->cur_xfer_mode =3D=3D GENI_GPI_DMA)
>  		return true;
>=20
> +	/* Set SE DMA mode for SPI slave. */
> +	if (ctlr->slave)
> +		return true;
> +
>  	len =3D get_xfer_len_in_words(xfer, mas);
>  	fifo_size =3D mas->tx_fifo_depth * mas->fifo_width_bits / mas-
> >cur_bits_per_word;
>=20
> @@ -619,6 +647,7 @@ static void spi_geni_release_dma_chan(struct
> spi_geni_master *mas)
>=20
>  static int spi_geni_init(struct spi_geni_master *mas)  {
> +	struct spi_master *spi =3D dev_get_drvdata(mas->dev);
>  	struct geni_se *se =3D &mas->se;
>  	unsigned int proto, major, minor, ver;
>  	u32 spi_tx_cfg, fifo_disable;
> @@ -627,7 +656,14 @@ static int spi_geni_init(struct spi_geni_master *mas=
)
>  	pm_runtime_get_sync(mas->dev);
>=20
>  	proto =3D geni_se_read_proto(se);
> -	if (proto !=3D GENI_SE_SPI) {
> +
> +	if (spi->slave) {
> +		if (proto !=3D GENI_SE_SPI_SLAVE) {
> +			dev_err(mas->dev, "Invalid proto %d\n", proto);
> +			goto out_pm;
> +		}
> +		spi_slv_setup(mas);
> +	} else if (proto !=3D GENI_SE_SPI) {
>  		dev_err(mas->dev, "Invalid proto %d\n", proto);
>  		goto out_pm;
>  	}
> @@ -677,9 +713,11 @@ static int spi_geni_init(struct spi_geni_master *mas=
)
>  	}
>=20
>  	/* We always control CS manually */
> -	spi_tx_cfg =3D readl(se->base + SE_SPI_TRANS_CFG);
> -	spi_tx_cfg &=3D ~CS_TOGGLE;
> -	writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
> +	if (!spi->slave) {
> +		spi_tx_cfg =3D readl(se->base + SE_SPI_TRANS_CFG);
> +		spi_tx_cfg &=3D ~CS_TOGGLE;
> +		writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
> +	}
>=20
>  out_pm:
>  	pm_runtime_put(mas->dev);
> @@ -1072,6 +1110,9 @@ static int spi_geni_probe(struct platform_device
> *pdev)
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, 250);
>  	pm_runtime_enable(dev);
>=20
> +	if (device_property_read_bool(&pdev->dev, "spi-slave"))
> +		spi->slave =3D true;
> +
>  	ret =3D geni_icc_get(&mas->se, NULL);
>  	if (ret)
>  		goto spi_geni_probe_runtime_disable;
> @@ -1092,7 +1133,7 @@ static int spi_geni_probe(struct platform_device
> *pdev)
>  	 * for dma (gsi) mode, the gsi will set cs based on params passed in
>  	 * TRE
>  	 */
> -	if (mas->cur_xfer_mode =3D=3D GENI_SE_FIFO)
We can add separate function for GSI mode for the set_cs ? that can set par=
ams in TRE.
> +	if (!spi->slave && mas->cur_xfer_mode =3D=3D GENI_SE_FIFO)
>  		spi->set_cs =3D spi_geni_set_cs;

>=20
>  	ret =3D request_irq(mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
> --
> 2.17.1

