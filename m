Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CDF7B6BCD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbjJCOf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240085AbjJCOfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:35:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C2090;
        Tue,  3 Oct 2023 07:35:52 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393DvAxi015700;
        Tue, 3 Oct 2023 14:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=BCGSKUwP0D9DD6CBwdG/lFeu2dKol1Iexa8bLO78UZw=;
 b=KIWJt9xQnQ5A32Bo3kPtrLdbWzAFxNg9i7yULXhIdssZqZORHDg+gheQSDMQIXY6kzVY
 7jqHKg+E3yajfa3pWz2SxHdSaT58Umm0jO7sSKPCR8gKbcOdrJ8OVuuM7BEGTWlHH6tV
 InNNbPL3oiRBigA/gRjJwRUCXxeOgB+3hk07f0Mnk0eq/58z5oyElC/oUCjpbaU3EEdC
 ZyiIiduCBdGq18FZ0blmMvFBcn4f9TY1wOrLaD0D70e3+HfdQZJ2YbgTtx4K/5WJjLg/
 4xNSXTqfVFrNTQVsqLM4D/6FEd9ivZzpqbQ/uXjg4SPB1kBw8aRBwIc5jt3GLUSaH+4w og== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tg98rhh57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 14:35:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1Mgbfx8avMG4hXurgJe0BnY8l8iENyfjFOPTTeLhEpxfPf4R2hMLvBYts238z4DEeiZ5Z+P7+D5MH9jEq74Dsv6tBK9j7d//ndxdVZY2updj73LuzjX00NPPXMN4HmnwSza42Sb12ZiG9ice905hYRNNzw16fwkwtJhMvrT7W7sOdBny6w5gBtEx5RWqZ/byqUGymTeVqScvKi5ENViAt1flfnLyVhWn3POA/7fMVBEiCWou0ozBqANX00G9mAJiODBec1kBEi/0L5AiCvxTRfg8uN1ujO6Qo3ki85iiQgxZsBR5qUePYc6Fot6BXxQeA3aUqjnsX/bZPy8wDIoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCGSKUwP0D9DD6CBwdG/lFeu2dKol1Iexa8bLO78UZw=;
 b=dv/ZW3M6rVg/yjYRcKxRcwuPXI63dV5Cuzmf/iozY54Yr+VgZkoQti2v6OT7Fio0WEKvw788lSxtZct9O1mBOhZlq+PLNCDwvGscl48EmdjWwvAVmrd6dE54CGjiEJoXzvZwpQzVAiliPWZPrCqrkCbLiLE1aVUfyYXdsypj23vyRN89FGySnYATMYhmofw4z3OEk0BDecAy+QaS8eUakN41WAY9+UAoE1CCVmlcqm9pC1ePWbCRQUJet++A1fmbD0BorNb/p0K6C1C1vRIyd3bL8dGaWXqEER1lKb6eZNhAuII6ILYBHgiMKKuKlx4wQwCcqAehkoJJZNj81G5wug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH0PR02MB8073.namprd02.prod.outlook.com (2603:10b6:610:106::20)
 by CH0PR02MB7979.namprd02.prod.outlook.com (2603:10b6:610:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 14:35:39 +0000
Received: from CH0PR02MB8073.namprd02.prod.outlook.com
 ([fe80::47bf:9c43:4be5:fb47]) by CH0PR02MB8073.namprd02.prod.outlook.com
 ([fe80::47bf:9c43:4be5:fb47%4]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 14:35:39 +0000
From:   "Pawandeep Oza (QUIC)" <quic_poza@quicinc.com>
To:     'Sudeep Holla' <sudeep.holla@arm.com>,
        "Pawandeep Oza (QUIC)" <quic_poza@quicinc.com>
CC:     'Will Deacon' <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v8] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Thread-Topic: [PATCH v8] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Thread-Index: AQHZ6lSZigcTVLSCpESPLC2zOarwurAx9/eAgAT3tZSAAPhrgIAAUP0f
Date:   Tue, 3 Oct 2023 14:35:39 +0000
Message-ID: <CH0PR02MB8073E0B92F0755D586779788F6C4A@CH0PR02MB8073.namprd02.prod.outlook.com>
References: <20230918172140.2825357-1-quic_poza@quicinc.com>
 <20230929150459.GA30623@willie-the-truck>
 <CH0PR02MB8073FBB64A196EEEFED11BB7F6C5A@CH0PR02MB8073.namprd02.prod.outlook.com>
 <20231003094543.oinq2onehefxdrbw@bogus>
In-Reply-To: <20231003094543.oinq2onehefxdrbw@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8073:EE_|CH0PR02MB7979:EE_
x-ms-office365-filtering-correlation-id: c5ae1615-fe99-405b-a9dd-08dbc41e03ad
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fzg+nj3l/eHEsE1lYoMQBIETnWz1/A1L1yzMyVXjUA89U89nsOBR+pzjzBciurJix4+rLNBG6Np4B8uuwRMTRMv9Ii6Vm+j3YwkijTwGqH6kkx/dU5Z7tNrbIajPTYaq6DpnOifv6FJy83MgRWNpziy6VGVkcInzAxgrl2RPhFuqrt1Q9Q6BBhqau8YLG4Rc92EFY9xHko7Dj5Ss1ykzWroCWuTEvWoOddXWyoTVWezeQ72CoRpgmK0Rs2QVoSoEiHfGWVPHsnXK6UM7ameaI6+orVz6DczDoMNQFjXccU0X7G8Vv639k9hFLxxsNEhHhE6ZApvzWHYC80Ig32SxkChpgWWQ3G1NgqC2exYqaK3ps8dNOlvKpbLt5NlunG8+Q5TJv40bMVes7ltnhWHxucyUd9P/yIfIHSM5lXsXGOvkCaml4sRP4wBO/4lMf+CgL55rwpMZOq+BHCs/82l822bYwTPHugU6wUS9mTxoN5BobhfRVMSoYxlZZBwoke6NKhuejwnj3dJu85tC/1tFEnCpJlpE6FVXMby0htg2kNKRIY4AqA6eIuzALG2fa7TmJ1LuTPJYUW0XxnZYkdLS64DyxbPTKKOB/3LYWYBaMb5okN/OVIXuo9lZltXRtALN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8073.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(376002)(366004)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(41300700001)(110136005)(6506007)(7696005)(9686003)(66556008)(64756008)(316002)(76116006)(66946007)(66476007)(66446008)(54906003)(53546011)(8676002)(4326008)(8936002)(5660300002)(26005)(71200400001)(478600001)(52536014)(2906002)(83380400001)(122000001)(38100700002)(38070700005)(55016003)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SRh0RZtq+0iw7IKTW9qFamkAmn5AoClwYEWkgCqefpPRYJmqepfoFnnjPJDQ?=
 =?us-ascii?Q?sSbjMkqOJUHFD/xo7QFHnUKit1FCTCsUfraVYCugB8YOaozrj9Bahrhh/7y8?=
 =?us-ascii?Q?/PPh6xbs/pO2bNd7Y5cgTBVxqDJZmvnXW5TlXCDA/EfwWBDWu2V8NZt+anPJ?=
 =?us-ascii?Q?oykKhObBHXMK6SgExpZxhObNkd3rbOF4BPaHyDji20P9mxMDVLw3U2Hf8UCf?=
 =?us-ascii?Q?eDLbiWzSnjmSsTg8eArviinCm0XG8xBUrnknLSqwJziCkadQJe0vfD8yivIt?=
 =?us-ascii?Q?apJcycLSKcvJvlUvvqiLpHD1IZJsg7QvRTrUeYcHA5D8OCWN6Nd/E6PeqYFr?=
 =?us-ascii?Q?d6a3fb4Me1WJq4n7GymXCrnc4i9AB/+vX01Tqw6V0coStAj2O/2TRGvsejL+?=
 =?us-ascii?Q?OYx9uAEygvD0Ma24bPYsawybCP5IonFE1CAPYIvJ0WqsDxDCmcWtDhSreHfU?=
 =?us-ascii?Q?svi7e/fm+Nffl/x+rgzZ66/rIPt1hgsBZandBmZ1bLrtjyzWl8KMmnENt0ia?=
 =?us-ascii?Q?JWZy399B7X4JEbMwZaT3kZzhqiP5P5oNI+10nB6M5Nbj/2l0gi42wcmK85Zl?=
 =?us-ascii?Q?Hx+V+UTkB7w9NVcPX8YAENVJWkA/uEtUUWdvpPdG9kQ7XMbk1pV47QSnOYVw?=
 =?us-ascii?Q?PV5I14lfBygoStI5aJdvezy6+tSMjWWJnPpBoySRWjW13B9Qdqm/8U+kdmVQ?=
 =?us-ascii?Q?XSIvQkn9mq/777gpLhxvWK8jDt7kOLB6zZ2Lby9QX0HfyFC+IsMltyS8bQ4N?=
 =?us-ascii?Q?2q1Q3HJ3xECfRZGz4vBj1pyXybO6GgOrYArLKAdIFXvmCDa+lD2ZSEPN8gdP?=
 =?us-ascii?Q?+1GyxRpXAl8guPjMG1rOBMFL9we+g2uPUDQHZIjBRZUKQco68RXoY92C1mBO?=
 =?us-ascii?Q?jdfK9KM7FIMR9y7SYGRdI0JyVf6x2bZYuYWDxHlivR08A+ZfSVMPdUP0kZKd?=
 =?us-ascii?Q?ffQpno3d/wZmizGX/v8MatJo/outtdzVEhz/OODsQmR8CdtBd+4coxQqiVR4?=
 =?us-ascii?Q?iSdXW2mjxpK57rLLFh6euCO3E17az4moMfqSyo0uyYmRV30t5sUw2WasSn1Z?=
 =?us-ascii?Q?H9HiPPm7pAQptViQweLlC3389+LqvPgpkKw3mMVhiD1mBBJD5OyxxcoOg8rZ?=
 =?us-ascii?Q?RuaHE/u4q3dQuCan3Du04HSABi0pR9a/Y1nb9mElSs3GBmX05VHPdoRKtdEY?=
 =?us-ascii?Q?xbVPy7RhGhpIipvP43PLaaTORW9iE82/daPBQ+opsR66B3X7D1JxGUvxgecE?=
 =?us-ascii?Q?InZIPkofAuQQ4brYEn5NwekYFmQir6CzdCG4ntp1aiYUQXanSliMKxFfbwUI?=
 =?us-ascii?Q?OUdKJoPRR6k4QBayHQutyaE2uxoAo5/F6jvpBBGdVNpnyDw3FL63en+4RYYa?=
 =?us-ascii?Q?ujKsRPam1XgZDeO2aV/OU1NIns4bqFfutz3IHhA3jin9v8YvJN3reCnnCCkB?=
 =?us-ascii?Q?hMIriMgZTZOofzZFDeI/ebk53STIFOAI7yVkW+qZK+y3B5NRvpYHpBalbRBf?=
 =?us-ascii?Q?Kq1kY8LaOaJ7HdfPy/IIabuMVocR6UqhDAuC0dBG8oTPKlcq6LXPwdvicVok?=
 =?us-ascii?Q?iX9vf8RK7w7oDsdwOU+Mf5hqmXK7HPKIF3yRKNFI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SEpAlGEHMfGi4V2zQD4t24FULiUgU7OWdliQof1WiGQz/evpbIRgL+N2bAmHe6/O6seG5/FL7IETo/HxMYrqqv97U2JvkG0vyHZHYNbRBwQfg2rr8ti08U8XrEeAFXBqU7voNVz7VY5ac9mtsbHeNqO+h12yCYyIQio6AJAi/ZEw5fcwrIHduMomns2q/cq3ri+ZeIrT4iUVb7zbPa4AWGVjvxbbQ55hvirJsGCA111jco3rEpuNdX7D72adMASj0x5zZhivExarZ+Q2BbxMnBZeVvLeXzOG9073ma5y16BkHfCIBjK1fZuePAZ8CAgDWxRkmtP94ssThhPWHFmnEtTcIff91YHdkyonFdlFHNzHLtkPGNiEDyOjd4RoZkNPDgbyOAnPVeaK/tJb7pvjcO0CnISo5D++6DXgdjfBU9ZnFZKzGztXthG+T87W7BGbbF5sCJC7Q2l2/n1uGpDEj51/ci+FQgvNK20fXjkjpyiVCAW2pE5yoV/ey1o+Nmtq9Wsa0eftIcPKkbwcMfyfc7nWaXbomBSuLHsfZulfEzsWb9qtxjZI9LzY43f2u+YaB7hqYe6HdxM9MLJMrUL6v4xWkt2D7pyFriIypc0N3pRBcb60AglpDnxDmWp678YuMboAjCQXeyviBBGrfYd55hLJuxJloSUbLGOk5as10MbSivshCHOx7YM6frp18COcoKJ13Mm5QKSF5C1x586yh+1eejIIGGkFeHaO2TsmRKPgB0ex+OTP6SBIznnY28Am6yL4Rk3N2yvmdcugZBWnHl8fYFwbfmQLaBvNvGJqo5ODdOrUh0C2yOL46Lzgzsh8R3QPtMd5SFebEKv27B98K62IPwdWI1K3kG5USk8cMG4/xIaQWMIHslVueWWiGyoC
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8073.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ae1615-fe99-405b-a9dd-08dbc41e03ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 14:35:39.2430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jLxBx4ZKBw4oWM+LNDmtZLkt6nES7hUjeuZAo+2VBzINdf/B0A0H3BfN8hB6R4aHRv9PQ9uzYTC2o8HEID3q6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7979
X-Proofpoint-ORIG-GUID: 2Qks8w0Yqh3xGj3Wfe-RK1umrRZ6G8Bw
X-Proofpoint-GUID: 2Qks8w0Yqh3xGj3Wfe-RK1umrRZ6G8Bw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_12,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=3 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=3 mlxscore=3 malwarescore=0 phishscore=0
 mlxlogscore=151 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030108
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Sudeep Holla <sudeep.holla@arm.com>=20
Sent: Tuesday, October 3, 2023 2:46 AM
To: Pawandeep Oza (QUIC) <quic_poza@quicinc.com>
Cc: 'Will Deacon' <will@kernel.org>; Sudeep Holla <sudeep.holla@arm.com>; c=
atalin.marinas@arm.com; rafael@kernel.org; lenb@kernel.org; linux-arm-kerne=
l@lists.infradead.org; linux-kernel@vger.kernel.org; linux-acpi@vger.kernel=
.org
Subject: Re: [PATCH v8] cpuidle, ACPI: Evaluate LPI arch_flags for broadcas=
t timer

On Mon, Oct 02, 2023 at 07:22:57PM +0000, Pawandeep Oza (QUIC) wrote:
>
>
> -----Original Message-----
> From: Will Deacon <will@kernel.org>
> Sent: Friday, September 29, 2023 8:05 AM
> To: Pawandeep Oza (QUIC) <quic_poza@quicinc.com>
> Cc: sudeep.holla@arm.com; catalin.marinas@arm.com; rafael@kernel.org;=20
> lenb@kernel.org; linux-arm-kernel@lists.infradead.org;=20
> linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org
> Subject: Re: [PATCH v8] cpuidle, ACPI: Evaluate LPI arch_flags for=20
> broadcast timer
>
> On Mon, Sep 18, 2023 at 10:21:40AM -0700, Oza Pawandeep wrote:
> > Arm(r) Functional Fixed Hardware Specification defines LPI states,=20
> > which provide an architectural context loss flags field that can be=20
> > used to describe the context that might be lost when an LPI state is en=
tered.
> >
> > - Core context Lost
> >         - General purpose registers.
> >         - Floating point and SIMD registers.
> >         - System registers, include the System register based
> >         - generic timer for the core.
> >         - Debug register in the core power domain.
> >         - PMU registers in the core power domain.
> >         - Trace register in the core power domain.
> > - Trace context loss
> > - GICR
> > - GICD
> >
> > Qualcomm's custom CPUs preserves the architectural state, including=20
> > keeping the power domain for local timers active.
> > when core is power gated, the local timers are sufficient to wake=20
> > the core up without needing broadcast timer.
> >
> > The patch fixes the evaluation of cpuidle arch_flags, and moves only=20
> > to broadcast timer if core context lost is defined in ACPI LPI.
> >
> > Fixes: a36a7fecfe607 ("Add support for Low Power Idle(LPI) states")
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> > Signed-off-by: Oza Pawandeep <quic_poza@quicinc.com>
> > ---
> > diff --git a/drivers/acpi/processor_idle.c=20
> > b/drivers/acpi/processor_idle.c index dc615ef6550a..5c1d13eecdd1
> > 100644
> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -1217,8 +1217,7 @@ static int acpi_processor_setup_lpi_states(struct=
 acpi_processor *pr)
> >  		strscpy(state->desc, lpi->desc, CPUIDLE_DESC_LEN);
> >  		state->exit_latency =3D lpi->wake_latency;
> >  		state->target_residency =3D lpi->min_residency;
> > -		if (lpi->arch_flags)
> > -			state->flags |=3D CPUIDLE_FLAG_TIMER_STOP;
> > +		arch_update_idle_state_flags(lpi->arch_flags, &state->flags);
>
> Hmm, I know Rafael has Acked this, but I think this is pretending to=20
> be more generic than it really is. While passing in a pointer to the=20
> flags field allows the arch code to set and clear arbitrary flags,=20
> we're calling this before we've set CPUIDLE_FLAG_RCU_IDLE, so that cannot=
 be changed.
>
> Why not just name it like it is and return the arch flags directly:
>
> 	state->flags |=3D arch_get_idle_state_flags(lpi->arch_flags);
>
> Oza:
>
> ?

Not sure if this "?" is by mistake or you didn't follow Will's comment.

The point made was that it is cleaner for arch code to just provide the fla=
gs that needs to be set via some helper like 'arch_get_idle_state_flags()'
rather than set/update itself via 'arch_update_idle_state_flags()' like you=
 have in this patch.

I completely agree with Will as this is much cleaner and arch code just ret=
urns the requested flags and the core code is still in charge to update the=
 flags.

Oza: oh ! sorry about that, it was some mix-up with the reply to another co=
mment from will where I wanted to point out kernel test robot results. So n=
ot sure what happened there.
This comment is already taken care in the patch now. Changed to 'arch_get_i=
dle_state_flags'

--
Regards,
Sudeep
