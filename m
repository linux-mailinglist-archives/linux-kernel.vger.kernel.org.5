Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BB5768F14
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjGaHkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjGaHkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:40:31 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B458194;
        Mon, 31 Jul 2023 00:40:26 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36V509wR028733;
        Mon, 31 Jul 2023 03:40:17 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3s66dwgtxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 03:40:17 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHF0zC4e6lpPltkIy4gT7NBlx9Sx9NasqOgAl4rJMoZ5ITz9vthHjIfPIIAI9lwg33qrVJ2W0ngixBMP8+4cf6aDq4ODCIPJMC2s/TGewb4MuX+6sA2pjDw5yExery3f2SjF0DSSo7cefW3k1XnXqAvrhajEVbx4TcNftLT03KpKEwblzS27Bxg3kyCJWtuhegKw8zohNbe5QKL9phg2oYG//GKug+BNdlKRcfDhKdpf1d/xt1KPaOdEiM/T9JCuEMzUXCca53Wg+0R79Z1LVnPSL1epaAaaIcDzgf9EC8aoaI2Er2SgTVys687ne6zocBZqTtdDz03+ZVF8OhO0cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHt6IduVnUxMRX74PXRANyqXz9tAf69E6mO9skR3WFQ=;
 b=ZJTBcPIw6QBjqL5UGSP0nMloHVowodpNu9jLazllJrNYpHEXST8f9u0Sx8Dijp7SwsdoZCbmUnmZ4pZ7ecnwwlKEyq/gCzdvSFTLrB1Dy1SzZrFMxgxhCcmLsgXvfqxkBZKgEG1MFEO0rxKzZ4sjzzxKAINf4ikySdenlOaRqsJ6kmaLvMX9zyjMULYJvioJTLAb1dQs//adomFX2OXvmPZmmZq4wH+zrqtl7oZcZHDbvYmmlnCOmoKBHK7kKMkMH7CWB3Y21Ocd0Mlz4yffF3bBM+ApdJjpsWKxyCnWOcVFUt+qo1LscpdVaisKCMxjWyeTGucu7elafQW3+lb3xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHt6IduVnUxMRX74PXRANyqXz9tAf69E6mO9skR3WFQ=;
 b=78GKzb8oLr6amBVrxJM+Z6kRcOahBIwRUJnW6tFrgXiQLYJtQWAEy8vmqytFJC9sGJmWOAUi8XOrTb8kfFo3kKkwRbdCQae53TnPTeK9sKP4kVCnCnVeeOeTTJO61gRTrB78PeoeZ4FpsR2CoqmGhsQPG1Nj8KtWjsPKcicrV5o=
Received: from BN6PR03MB3395.namprd03.prod.outlook.com (2603:10b6:405:3f::23)
 by PH0PR03MB6233.namprd03.prod.outlook.com (2603:10b6:510:d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 07:40:15 +0000
Received: from BN6PR03MB3395.namprd03.prod.outlook.com
 ([fe80::728d:be5a:be21:90cf]) by BN6PR03MB3395.namprd03.prod.outlook.com
 ([fe80::728d:be5a:be21:90cf%7]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 07:40:14 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: iio: admv1014: make all regs required
Thread-Topic: [PATCH] dt-bindings: iio: admv1014: make all regs required
Thread-Index: AQHZwH4RV2JH17iyYkyP+nPY8DJsEq/NfymAgAABKCCAAyXGAIAC23WQ
Date:   Mon, 31 Jul 2023 07:40:14 +0000
Message-ID: <BN6PR03MB339557689BCCF795B18C68319B05A@BN6PR03MB3395.namprd03.prod.outlook.com>
References: <20230727113136.98037-1-antoniu.miclaus@analog.com>
        <7f7d1c90-9969-66bd-fd71-defffe0e05d6@linaro.org>
        <BN6PR03MB3395F9139A225AA97A100B829B01A@BN6PR03MB3395.namprd03.prod.outlook.com>
 <20230729125516.68a29852@jic23-huawei>
In-Reply-To: <20230729125516.68a29852@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdXNc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy03YWMwNzQxNi0yZjc1LTExZWUtYWUyZC1kNDgx?=
 =?us-ascii?Q?ZDc1MDZkZGVcYW1lLXRlc3RcN2FjMDc0MTctMmY3NS0xMWVlLWFlMmQtZDQ4?=
 =?us-ascii?Q?MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSIyOTM2IiB0PSIxMzMzNTI2MjgxMjUz?=
 =?us-ascii?Q?MjU0NjQiIGg9IkRIU0VOdU5rY2xBVG5LL1pTY0ZPTjg4K1RWOD0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?Q1lXRVk5Z3NQWkFWYXpqaFgxQ1VJZVZyT09GZlVKUWg0REFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBcWV4MVZRQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
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
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR03MB3395:EE_|PH0PR03MB6233:EE_
x-ms-office365-filtering-correlation-id: 0d8d798f-9d69-409b-6060-08db9199610d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vqx0Owd0Gkt5tQm06dvEhYhWW/S/QycCLdJHM0mqqNgFLLhDEXHd4fAD0VrPFAsqJ01onPQzqiNyIRb73VqHaK2NbLlezUgpJo/r2jnqZy1O1zDyrIhKO4JQHdEVrR5LyDklB7047yrC3V1AGCCSaiZ9oBT06c4ROB9+PXpDM5GqDK9gstE2KapoVmt0Wu/9W4tsIDryHyDIrM2I2MBeDfy5u0wlLIxzKo5Kc6jsgYyYFLV/2JLQu6d46EZbMMu3NtlFw7kfHXBZNUVPH4c7P3MfeeUOU0UVVDgmdi8PmzGJn3CxgVsthe3ZgOMEIPkd1+e63EDW/KkE7aI/pdtOoGFUJr8ZI7PNeqc95KWvfDoPSqDf45ZRDFXQGwBaPlDX5ZnMs8Q8wQx5OTtiRUt44aQyuAQsm7imTqAWEO51j/AJM6feoCP0H51++fXPU/APRp3l9W38nnhl2PImfAXC3kVS+usitNQgYp+sSMxpyCJHA0HrMtZ3S6zYlsWzwAUKZHhHoAyeNyRI83/o3P7gOtQZpvFz4kZb7XI31FE9BJabx3e0HXH4wfjiOqT0obtWKo32610uue31sKhTY6q2cKK4tuJQFr+/xtAL2beKxkE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3395.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199021)(38100700002)(122000001)(55016003)(86362001)(38070700005)(33656002)(9686003)(966005)(478600001)(71200400001)(7696005)(53546011)(186003)(6506007)(26005)(8676002)(8936002)(52536014)(5660300002)(76116006)(4326008)(6916009)(64756008)(66446008)(2906002)(66476007)(66556008)(66946007)(54906003)(41300700001)(316002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tFL0aorLMToyxjWvbHqB//p8AOFZWru/LF+8kpsNy128A2uxHiF7Ll3k5f9K?=
 =?us-ascii?Q?xEwOtIF0117fGxZYSijP/58Ue5qBfEdVvte6XegZbFe9GCxKc7n5Wk8O7isU?=
 =?us-ascii?Q?jj9XAElz4vaVFTEvb1MxOTS7xP/LLlSmJ8HB6lY/bKMQFm/PJMhRkO/53XwT?=
 =?us-ascii?Q?J+PmV4TkeRm6tS4gL2d9AOKGgv6yhSzPEtpSkdjwQ0+/T4ZGJ0rzE2Mzzk7V?=
 =?us-ascii?Q?MmnaEgznmHaIa924PxXDLJIFBSZOOOxKxO0j9YfEHS9c2Vvq/8sVsgBACCis?=
 =?us-ascii?Q?Xt8QHmZMJUwv2b/0rR0F5/3pBVV7TuqdBtJrdXvWAgXetoO01RSYl193Oo1G?=
 =?us-ascii?Q?bFhVo9+7/a435ZIm8NEHnfE6IwdLLObho/5hZYs6U/R70ZVyquPqluiQbE6o?=
 =?us-ascii?Q?GEDf89EDCdOphwhCYwXiWG8uY/kJ/VGuiWGzTtqF1NFT0waY+97W5KYqI+Zt?=
 =?us-ascii?Q?BQdcrC5Z+OCtNubPay6a1awBCr98GEHiI2ddX2sRS8S0WIOVM/8ATKh/71xa?=
 =?us-ascii?Q?FUfAHG0g3Y85I6ceAVBUwyidc0LYgQhpFl3vQ3auPSjP9sk5bttuwkstKDGz?=
 =?us-ascii?Q?ZRHr3C3Fuh8wtVJHASIX2/tu9xoEHndUnqO8E8Vo7UJ26QI2jQBNPskxo3oE?=
 =?us-ascii?Q?Z9ukee6Oen0ADohrux0g+tN3+ogpuwIclN9hsV0ZSHPeqJBlzBS0yh5rGf5i?=
 =?us-ascii?Q?+FRXJJ0lOgjHFqzBnq8aV8tSdYi2mu69+VBLjQUt01MGy7n43L1kW9SMvPpP?=
 =?us-ascii?Q?TKMU+ktIbiRz2AsXcfbJaAJ3ZngGlZVuAS8CIYNWK4d4h5WZrKsSJJZuXAnA?=
 =?us-ascii?Q?M04xxBaPAtZPYB6lE/w8gy95g2rKkaR/e1zcWJIGfmWtUpa5DS5vd39lnWFo?=
 =?us-ascii?Q?W3nT+5Tt3+6lsG68/7hr9frdLFVIxpPjge63OmuNt9dc19amDFxQXQ/4Fco3?=
 =?us-ascii?Q?bWCvu2/2krSiUK2HJ9rqpRnC9aDezrtvHSoJep0NfvOldjVewhCKjj+iR3dm?=
 =?us-ascii?Q?CJs+NTyYtDCUttoeOhLQSLVEs84OPB/bqhwzcSYWN2ojXsIJ4PvTBs5ydPgA?=
 =?us-ascii?Q?Ws492+kVbmym3O0aKFN9jMamD0QCqfdraftA3XlslVytzV5R37gVQ3/qV0hB?=
 =?us-ascii?Q?jyvc8xqFUxZoyJsD8v9UK0FhymPg/fp7wXof+I/ansU9x2AHHZy5Iv+Zn28u?=
 =?us-ascii?Q?uC4xh/0dywqw+m4v2FtUGHMhdnZ5PSmKe720JoT73TPSTSgQOlULyBL2jIw/?=
 =?us-ascii?Q?+ILthDDFuHtEYryx9aN2pTRq+Sje7KAWDnk4ja58sjQDZc95qlc9C/PoSVF4?=
 =?us-ascii?Q?nMYlmNYTem0K2xN/jRNw1MNN8ORErgLk3tYr0FvuPU52y5jFew0ddSV7J+jQ?=
 =?us-ascii?Q?yUK2yyq9O5WCgBrS8n4UxUa02we0CXwoR0n6j93RgyWI7gNR2JD+rMZ4+exg?=
 =?us-ascii?Q?ApZJBb1gOoKQQGoB5hPKyTFd1X/MSaFVng81ZxknuDLPV41+QDmMZC6hrgSp?=
 =?us-ascii?Q?Sz3cptEXceS+YYPMV7LRFvQ9YUZPBjMB0fr6mhfTGCz6wBe37RoLy/Xk80K0?=
 =?us-ascii?Q?lDZIZ+GNBVOvf0mfYc41iEvcPtpD+6UeE/eQ4Hf36S+vFBYO1AOYGyaBEf2N?=
 =?us-ascii?Q?0A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR03MB3395.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8d798f-9d69-409b-6060-08db9199610d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 07:40:14.7131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8venFcLJ7PPTg3Z4fl9JL19g64W8S9+FBcWOmIxczT0BvYMluEE4nnQHRx9E9q1jVDhFNL+Uf4/NvZXDKFFXPoM++N6TmiSpvukxG+12hi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6233
X-Proofpoint-ORIG-GUID: oyLP5V8SWqAcPzbcEBHAyp3s1hE7TG-0
X-Proofpoint-GUID: oyLP5V8SWqAcPzbcEBHAyp3s1hE7TG-0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 mlxlogscore=650 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2306200000
 definitions=main-2307310068
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, July 29, 2023 2:55 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] dt-bindings: iio: admv1014: make all regs required
>=20
> [External]
>=20
> On Thu, 27 Jul 2023 12:02:04 +0000
> "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Sent: Thursday, July 27, 2023 2:47 PM
> > > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>; jic23@kernel.org;
> > > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > conor+dt@kernel.org; linux-iio@vger.kernel.org;
> > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH] dt-bindings: iio: admv1014: make all regs requir=
ed
> > >
> > > [External]
> > >
> > > On 27/07/2023 13:31, Antoniu Miclaus wrote:
> > > > Since the regulators are required in the driver implementation, mak=
e
> > > > them required also in the bindings.
>=20
> This bit is probably not strictly true.  Try no providing them and you wi=
ll
> probably find stub regulators created on assumption they are fixed regs
> that we aren't interested in controlling.
>=20
> > > >
> > >
> > > The true reason should be whether the hardware requires them.
> Because if
> > > hardware does not need some, the driver should be fixed.
> > The datasheet is not very explicit on this topic, but all the specifica=
tions of
> the
> > part are built around these pins being supplied.
> > Moreover, the evaluation board or the part comes with all VCC pins
> connected
> > to fixed supplies.
>=20
> Agreed - these should be required in the binding.
>=20
Hello Jonathan,

Not sure if I fully understand. Should I drop this patch?=20
And also drop the "required" of the regulators in the admv1013 patch?
https://patchwork.kernel.org/project/linux-iio/patch/20230727110121.93546-1=
-antoniu.miclaus@analog.com/

Thanks,
> There was an old disagreement on this in which it they were not marked
> required in some bindings because the regulator subsystem would assume
> they
> were fixed supplies that were just missing in the DT and so provides stub
> regulators.
> My understanding at least has changed and now we mark the required even
> if
> the driver works fine on some boards without them being supplied.
>=20
> Note though that this means the whole of trivial-devices.yaml is garbage
> as very few devices actually work without any power :)
>=20
> Jonathan
>=20
>=20
>=20
> > > Best regards,
> > > Krzysztof
> >

