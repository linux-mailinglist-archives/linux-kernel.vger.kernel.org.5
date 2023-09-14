Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3657A0C48
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbjINSNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjINSN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:13:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD2F1FD0;
        Thu, 14 Sep 2023 11:13:25 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EI1awp027725;
        Thu, 14 Sep 2023 18:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=hNU2TGQKfSsJ+fVvSivNDHiCfV2N9TuWMluxDnd0T0w=;
 b=f7nES3qFjf9vEd3JEHmsvEx+jl1JTshp7edlxx6urb+nDxHl1TNW2W8iTpEud/ncPxgV
 PwfqvSDAYtfGrpTBIS2FxEuuJMWqZcsI0Xe/VBdPG1HgDj2z4G/uNIN5CROZ5zevNqbw
 3ZfvOgzgcCLi5edmEl0guKggHxU6Sacq+XettK8OnlS4K+9EfEo2lWdvFNHuSTlimT6D
 q4nv5WJ5GegufwQQ3xxhoBKXwJCePK2ldsHHRmjejM9qZSLAa0hV4O9D0N5g2DbrATNq
 9DRmDnpAKbXf4+Sr0IGcHahztT3UHZO5KIoo6QaKcdbzUoNXDPtm1bOtdiVCCZPps8qu pg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3re32fm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 18:13:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kf24jZk6POYtWWsKPdY18ZBgpfwwdFjlPrKQxe+7lRYlTxizkFjSoOyynwFvVGrQ3/f2ENCEud7BQNqaahKs97vtlfKdpbcVxR4xBTYWWuxLaR4YlzcIPIRHRBJMD64OBCM53VB0DdsHNPXfktG497VxCNTQ61KzZv44VHbOYkWCx9CQiX92aK/H1n3pKNebWZvN0CpBhi1MZXY0JnChUeYApzsSuXfec6we27kgsiE/vpig1WFD9zwiYGZQP6QH3TFekrAHGOb0Y2GzQdvujlu594Zs8OfGH9O5xXoMhvDATAob2q2lXhESCsvla4UZRyOBGd9Ft7LUz94bxmCuwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNU2TGQKfSsJ+fVvSivNDHiCfV2N9TuWMluxDnd0T0w=;
 b=mSur5zu8yLFqEED2D5TjoXEvpSx86xfg5FzawjkzJOaLJN4ZJX/mxciI9Hc9+ZQNu8HXhfYRkDHyDtYouM54fXXBmhLpjIMvGCx0JZtLVcIqvTp8jFaZtoILHKxNOhYMuDWdHK/pSziRqEZqjLD44sRhOza8t892QvDROjDvryIWnv9TE+CtSNOEDhX3/4+kvjkxfmp1dZbHKhbi5vSeh9h9SWiObc5e7ozEZld8phClxZY5huM7qUaHLqFCob1yIHQoGJPJQC7vqrfvOpwIAPWdiDER/xwHt7/XtBH05dwTbFBgCb6rsC7NdrTJKm2/8s7Vm9giz+zlwTisiQI33A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH0PR02MB8073.namprd02.prod.outlook.com (2603:10b6:610:106::20)
 by CH3PR02MB9090.namprd02.prod.outlook.com (2603:10b6:610:143::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 18:13:10 +0000
Received: from CH0PR02MB8073.namprd02.prod.outlook.com
 ([fe80::47bf:9c43:4be5:fb47]) by CH0PR02MB8073.namprd02.prod.outlook.com
 ([fe80::47bf:9c43:4be5:fb47%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 18:13:10 +0000
From:   "Pawandeep Oza (QUIC)" <quic_poza@quicinc.com>
To:     'Will Deacon' <will@kernel.org>,
        "Pawandeep Oza (QUIC)" <quic_poza@quicinc.com>
CC:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v5] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Thread-Topic: [PATCH v5] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Thread-Index: AQHZ5Z63HbSHXXa74EORJkLNdIy/MrAaUZkAgABRYa4=
Date:   Thu, 14 Sep 2023 18:13:10 +0000
Message-ID: <CH0PR02MB8073FDF02E252CDC265570FFF6F7A@CH0PR02MB8073.namprd02.prod.outlook.com>
References: <20230912172933.3561144-1-quic_poza@quicinc.com>
 <20230914132149.GA13461@willie-the-truck>
In-Reply-To: <20230914132149.GA13461@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8073:EE_|CH3PR02MB9090:EE_
x-ms-office365-filtering-correlation-id: b219a574-865a-4646-4dd2-08dbb54e40e2
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lGzgwmMnKKn5YKi3SPIeVCbeY3ez3f5DbY2izw6phRO9t9FMO82BRH0lHZLu/hA0wJq4+egliOgSNrn/OkuQADqID11YFciHVi8RPBmMx6KQxNMu9HI9eJHiQnzwY82ninlX1UM6GttOrwK+GkxI/aadQ6lqz4nk0XnZcNtGG/RKSXLumM0MjuwAoEmYkkE7cNwCxygjMDiPXaZ8Xd/3fdjBwb5qZZldxihGPAwlCtGQkfisrz9bS/eBINVKMvhPTogLYLmkzMiiH7Yc+Y1uhEtfeU3p4QjEZh6EscqGsGhA0q4n6B+eNzbdYrwEFi3LFlEf7RSwyFJ4hVi7LNebmJr1HhjiPobrT1PBNmuAucZK3IiLMjPRmEG6Pu7++vnXFsLrHhRGygSvhk9FGkL83LIHjBSrcZvrW9thYT0ciQSdQzYEpRpnMzj852PQJKQkJ9e4S+kGOjECAXoMrAfeNHPYhHKcAVHwacZt+930fml2SxbHcGQti4DvluSLDCoYnZoXFSBt/+uooAmyUx5q8VdN2sBqXFKftradD4bD77m8j1OraznaBquOD51Cse2pbHpnJQPh4hCCGBQoK22vpGdJ2IlS0XCbko1NUYLjDYqwVNz+9FWalHJuJNXuSwfO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8073.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(1800799009)(186009)(451199024)(55016003)(86362001)(5660300002)(52536014)(8936002)(8676002)(4326008)(2906002)(33656002)(9686003)(71200400001)(7696005)(53546011)(6506007)(26005)(38100700002)(38070700005)(478600001)(122000001)(83380400001)(110136005)(76116006)(66946007)(66556008)(41300700001)(66476007)(54906003)(64756008)(66446008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7zNfZUertBhs7x4TWBZbo71ynHidhxBSmsxERSWC7ihSvGsnOmFEVE1OorEk?=
 =?us-ascii?Q?8P04vu3FveOXCCJHSs1FlXy0zQgm+GpHXlh7f1SCyJv0iDQiLnBN62vzqyJc?=
 =?us-ascii?Q?UV5zhRB9dJoMdaFNyMAHH53CWbAXAoyTMLCehe2sExpT857Fq8eYqUOEqWkV?=
 =?us-ascii?Q?KMaIEXzknT/bTgpolk/hC3ZR05OveS+/KKDjbGm7lXjrUdqQZ20BXTEzWilU?=
 =?us-ascii?Q?jERR6WVQkBWKP7VzmZC2gC5TJT/u694zA1g7pVFsnk/rCad/Bbo1wCxYcDk+?=
 =?us-ascii?Q?bmGj0TNwOckyWadKiM9OSdwrh85JRjI7lZLKfb/IKJLES7x/XvFa8T8poEAW?=
 =?us-ascii?Q?fSAaZy0vVSni/vQ6/+2SUi53l9evr10OPbc0Sy3AwE8MJyM19/tKoPvtM7m/?=
 =?us-ascii?Q?7JuREm/q7Oup/BhLQ9h3hdTQhTMhd8CA4Jk7pkaniRm58S/5PueU6ice/Hxc?=
 =?us-ascii?Q?NyfP/A5CjA2hIpIynSSlKJdfTvriIGOKEgJZB0s4XvZ4nXaAM26la7wH3LBh?=
 =?us-ascii?Q?yMNJujrw41BxYkqZxXZH2Pi8HIi5awuM4Y409JPubKYt3/2huowuNfiWhFEE?=
 =?us-ascii?Q?tkESVBfKpDeKnHklCJrNH9xDGGYbh2InmPgZA2MJVNnJefZLyGQD/rD4wZ9+?=
 =?us-ascii?Q?cqBRSqIlZyXGUeIyA0hjxpYHxCUlSDyNfJmEaSEfY33yxfiHz/9vj3R3/Yl2?=
 =?us-ascii?Q?qe1/0XHD2vuhHhN5LdWPI9+g4gQJ3Axsa+fDBdJpXYfXsb2W6I4GypnUnTQX?=
 =?us-ascii?Q?ihyBDiFUz4ivF+QydTYnpb8ILhQ13DAq9ub5wrjQB/Iy0ifZ8C+i3PgBICQr?=
 =?us-ascii?Q?e6VVAp26POYuuTSMurcB2a8+Q847NG9omJ205uO8m6fuCz4QyLSpZR0WhSfR?=
 =?us-ascii?Q?eeVhBM8nulKLggys7liu/WxwWsfQoD7t0X7imdNzMVidDPOUZOFQJEH4cKwM?=
 =?us-ascii?Q?f3HgISbYxf2w5HlRi/XSz4dJv7Kjr/mCR1GfM/qpOHR6ltAyHf5kOG8ssvkH?=
 =?us-ascii?Q?WzmyXLVM/6XpGUkvDp74+WvaSdz4y7ZRojEcyNxwHwblaPSZ54VrHJVc3uP6?=
 =?us-ascii?Q?Ij+VpRPN76Nj79953ipJT0nmowKkRT8MmLp46waABk3XjomJR/uilOwfoNok?=
 =?us-ascii?Q?SXWvvrUlBb0S9s9v5FTzAImoLqGhmeUyBb30yxXpd5KepPn/6ObHxOuvGNXz?=
 =?us-ascii?Q?h8RMCJBYmzxTmDN/jOqIFJPyx4jWTZ015fb7WhvNIHJtIIUWESiLJWd8zrOB?=
 =?us-ascii?Q?d5S9xXasSVqKbOvfjSFV0xhhLpyQHrbTwdicPKqQSz2oqcmTebgza56CAs7b?=
 =?us-ascii?Q?VcnfbuHWGepXnSHmfANu91rdZRLDAJV2hP9Vsv7TYZxlcwsudj1sPf+p9Chs?=
 =?us-ascii?Q?LOeosSzKlUtGmpva6MPOZsVDyAUi2BOgxCxQcUAk273Mowe5Q3VrRMVZrD9K?=
 =?us-ascii?Q?i2M9xXcNRwmkexyLFN8FywlHR192Vms75MjKf65kHjZZ9WrAaseKtN70TwNl?=
 =?us-ascii?Q?vWSMiuMhzgICnDqwXhOv7GqS5HDAIPI7/V2dVZXKdrfsgjcxQtcJII5xwcSc?=
 =?us-ascii?Q?sDim3TUb8jqprWQf7EOR/X5fB1yt+iFkpVd974JN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7W7GF5GrH4L46laR33D8xe8GcoLRMfMwMOztC4pfPnDShmU331+DiqTb/sX06DhzH+GZv3JJTDq8ZA8y6r4pI1BGeg8bi/fRS73f8fw1ICKEqo+08Dshl5Tc4MQ2FyyYssQ1TBHXTd6vWuJhBYQNQkW/xS2IL+QBnbLwKDt5j+6zZSfNTpzr9QHw3K+tX2EeeMFgrkFL3yxLkRypERiqLMqboXQizmdWsSq+jIlwp3mGnp5rUhIOchtrPrZlUCRDYqO6Tr9SIqKGEehnxp8FDJ985Frx2yUdstj6EZMTQBY9grLRRZgmL+NxHYEsidcMdGFfgxUiclHCQmiyQ44tAU29bcA5dAHEsAy4JHjCKv0P5SVs5dAtWivP/UbtyoddeFkKBHpiaHlqisHDn/nODiRtD6mVuIbGdclsateK8ej6BVVo1V9GypLN9lEWPXopYNVSptT67XZKMUWrblT4JLlukLzuPkfnTNBq07zoPjnI4YSobolKAhTBNX/LDsn2XUJz2gPlsTBBIMs+TgHa//nwCYsCL3CuFWAtUBKiGfeBxEXcvbCjbY5+1QojlFfr58CN/6nK0ixiN3cKD73BurW3ARa74tp3xt/q4A1W/kGYLpTGSGWi+NSoAkA+M+th1jGQhRsK5wLRQ8NO6WZ5PXgOo99g+0fzAxMOjYoIhRU1FTmuemN/GaUHmL46mq2Y/Kzr8c6pn/xQdoZ0sgMwNUSBSKxztMKZ/tRkxyrRKXNj1kOafAvOrevEPNKc7/SRFFGVsbMzSPOtuHXesZWtgUm3Ni+tHm8oJhHLkNFV4RY0riRmox5RBrJtRJ8TdXnhAqWVcjFbFQeZKyIrkg8LLbpHO7GaLavZPA/gj8LiEHzjy4OencB4u4u+VyBpavts
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8073.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b219a574-865a-4646-4dd2-08dbb54e40e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 18:13:10.3383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: loV1Y3sdNmP3ghvFY/ubwwLC5uHheylJ8P9V6ZjzXLDpHkDZwjszqwlXPrUQ6GaEXwTYrkvoU/zVbgqgh57+/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9090
X-Proofpoint-GUID: lhuTlPXLwwgSmiTDbVkDOJfv8Dnroy7U
X-Proofpoint-ORIG-GUID: lhuTlPXLwwgSmiTDbVkDOJfv8Dnroy7U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_spam policy=outbound score=66 bulkscore=0 priorityscore=1501
 malwarescore=0 mlxscore=66 mlxlogscore=-28 lowpriorityscore=0 spamscore=66
 clxscore=1011 suspectscore=0 impostorscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140158
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Will Deacon <will@kernel.org>=20
Sent: Thursday, September 14, 2023 6:22 AM
To: Pawandeep Oza (QUIC) <quic_poza@quicinc.com>
Cc: sudeep.holla@arm.com; catalin.marinas@arm.com; rafael@kernel.org; lenb@=
kernel.org; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.=
org; linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5] cpuidle, ACPI: Evaluate LPI arch_flags for broadcas=
t timer

On Tue, Sep 12, 2023 at 10:29:33AM -0700, Oza Pawandeep wrote:
> Arm(r) Functional Fixed Hardware Specification defines LPI states, which=
=20
> provide an architectural context loss flags field that can be used to=20
> describe the context that might be lost when an LPI state is entered.
>=20
> - Core context Lost
>         - General purpose registers.
>         - Floating point and SIMD registers.
>         - System registers, include the System register based
>         - generic timer for the core.
>         - Debug register in the core power domain.
>         - PMU registers in the core power domain.
>         - Trace register in the core power domain.
> - Trace context loss
> - GICR
> - GICD
>=20
> Qualcomm's custom CPUs preserves the architectural state, including=20
> keeping the power domain for local timers active.
> when core is power gated, the local timers are sufficient to wake the=20
> core up without needing broadcast timer.
>=20
> The patch fixes the evaluation of cpuidle arch_flags, and moves only=20
> to broadcast timer if core context lost is defined in ACPI LPI.
>=20
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Oza Pawandeep <quic_poza@quicinc.com>
>=20
> diff --git a/arch/arm64/include/asm/acpi.h=20
> b/arch/arm64/include/asm/acpi.h index 4d537d56eb84..a30b6e16628d=20
> 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -9,6 +9,7 @@
>  #ifndef _ASM_ACPI_H
>  #define _ASM_ACPI_H
> =20
> +#include <linux/cpuidle.h>
>  #include <linux/efi.h>
>  #include <linux/memblock.h>
>  #include <linux/psci.h>
> @@ -44,6 +45,25 @@
> =20
>  #define ACPI_MADT_GICC_TRBE  (offsetof(struct acpi_madt_generic_interrup=
t, \
>  	trbe_interrupt) + sizeof(u16))
> +/*
> + * Arm(r) Functional Fixed Hardware Specification Version 1.2.
> + * Table 2: Arm Architecture context loss flags  */
> +#define CPUIDLE_CORE_CTXT		BIT(0) /* Core context Lost */
> +
> +#ifndef arch_update_idle_state_flags
> +static __always_inline void _arch_update_idle_state_flags(u32 arch_flags=
,
> +							unsigned int *sflags)
> +{
> +	if (arch_flags & CPUIDLE_CORE_CTXT)
> +		*sflags |=3D CPUIDLE_FLAG_TIMER_STOP; } #define=20
> +arch_update_idle_state_flags _arch_update_idle_state_flags #endif

Why do you need the #ifndef/endif guards here? I'd have thought you'd _alwa=
ys_ want this definition to be the one used, with the compiler complaining =
otherwise.

Oza: thanks, Will!, will remove it.

Will
