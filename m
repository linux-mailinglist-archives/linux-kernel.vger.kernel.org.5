Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141217CFAE7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345932AbjJSNYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345908AbjJSNYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:24:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA19E11B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:23:59 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JCZ9Rs026891;
        Thu, 19 Oct 2023 13:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ZLVG6tgy31DD78IrcQs0l+MqF8Me8dayNK8ChlUOif0=;
 b=n2YJ3Z3LCoiJuiE68DGdIcbV0UxWilda6utD/NYKb+7pf8OlareS2W3fAHw8IfzFlEAj
 RqTkCoZKwYjMbMxvrcPdEtlVSNfDhviCys9O4Xh6LCNw2kaF2N/3HLrBRJOxxmrgu2NM
 w7DhKYePz32nbvhClkGvANdfMwdlNW6v6Ym5pguTBD/tLXDBJ4vTEYf7vGmeJ3+x/dld
 YhSkKyX4icDSQqMHPxOYuBVjgK4rD+Yx9ssZrrMrKorRwsY9Ura29QSx23HTZhctTIAh
 tNdk37xztMoY11ayMavjYHVaCPDRg+BoNUgK0+lf2TmAhppIFojQ3nuICM+lD+7krA6K aA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk3jtqts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 13:23:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39JCJtL8015319;
        Thu, 19 Oct 2023 13:23:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg1hy1wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 13:23:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kw67ulhwOKl5ls2ipaS9mRok6hgrokf8okAara91PwVYbMuVFa+8YfJ28MulrwDfGrsFNg/TKNIFesywzmZ7NWdEfKbLIyMJwRvKRAQe6BFNoyzJHDmWgbQacVQiZ6coFW7xsDvY4zNlGEYlK2Odzdo0sFSm9RcKzDhIv9NUC9yh8Ko6xo8jaVK7F1/cIDArssdpA2683m3rC8Zfbh892+fHh3a/UJKQxlpzXlybjhV259UYOhfUyEJJEqGn7jftBjhfVNE/tyeAIRUCC9pqLEe/yAFvz5q38ejSDK/UMXWIhGaeHmKdVFfcNDRmt6EMbt4mecrlVLdbYWzzdyhM1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLVG6tgy31DD78IrcQs0l+MqF8Me8dayNK8ChlUOif0=;
 b=fjPl/k0avq0dFZzrjNj1+m3GI41bVp7Fuwv3YFA0RIlMVLNrlMhrpZCqgzcf67f43S9W92oBN/5Y6yKlrD0R+CO1a34+iXSEuIAzlx6d1FpBQ3pGEYdZuaagJHfgoQWV+pvnJlocq8yiYG1x2gMt2YJT9d6UNHqWFrQ4f3FlEJD9cQ+XPq7n7HzA2nUCWFOEVPJ2g6rAazV/AaK5pXFvoTx1ABbhjzLhsKLlllxS0Qlj0+uebR3pIgLOVp29mjRkN+sqIevXI45LyFQODTNII2+6Sq6wbONBuaytrqnn+sMXrQqypScs0pTksZeCHBsf8Z6JKQ178cVHi/jXHhbchA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLVG6tgy31DD78IrcQs0l+MqF8Me8dayNK8ChlUOif0=;
 b=dFi7rEKo+kzvsJXBNl/+CotB/ts6lyeaU8qA8uZRQdBdcnOCMoTRxXFRO8ziR2ur67sk2M/F0Ky/jhfAmD+BC+W/+a3SBpoQZTjBBDInUwqxr991pCo4vhoAQlBR7GBpqdapezLYpB+ptOlYoRpei/mMGjms+US5sr3/abwglxA=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 13:23:09 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3%3]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 13:23:09 +0000
From:   Miguel Luis <miguel.luis@oracle.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jing Zhang <jingzhangos@google.com>,
        Eric Auger <eric.auger@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>
Subject: Re: [PATCH v4 2/3] arm64: Add missing _EL2 encodings
Thread-Topic: [PATCH v4 2/3] arm64: Add missing _EL2 encodings
Thread-Index: AQHaACJuFh446OF1ik66gL8ScAAqGLBRAYiAgAAc8oA=
Date:   Thu, 19 Oct 2023 13:23:09 +0000
Message-ID: <21F82E44-6D93-4F4C-8991-F14948673F54@oracle.com>
References: <20231016111743.30331-1-miguel.luis@oracle.com>
 <20231016111743.30331-3-miguel.luis@oracle.com>
 <86jzrin8nq.wl-maz@kernel.org>
In-Reply-To: <86jzrin8nq.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|DM4PR10MB7505:EE_
x-ms-office365-filtering-correlation-id: 3f14c298-15ca-4efe-a4ad-08dbd0a689cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pVXPdOE6WNHfSJtZiDn6tfDkjxAiXPcRJrkPJ5kLXLOEF9TV5dWgrQuy6qK4Tvdf2MrXNHeJLHXDhwb3EL+2gHLAZ6ixm5XU9RUuteanHPby1zp6vO74nJlWZWpCg8khodCOmz2MJTg2GznOAB1TCvHIq/wXC/sXSY8VVkwmOKFbvKJd6+xaVI42RojuqQpym+k7m/KIe+kt+TUfk72Tz1pzgjHi+U4VGxBAz/JVX+GKyjiCgAcCmTL5224b6zEzcG526JOR/+AeO9aI42KppIXy6IFSV52K8g2Bda2req4nV4jb1duKqzWMt3AWvxhPXgDibQpl9zcyeITgomuJeg39xKVBWFL5jF7IjBHMNwBOojKM2WKdKEI4CTHjsQbaPRjfBcOqSKyiRiLoJ0NnTTvtK27bYD9ZHW5OvEMb5NM5jz7FGT0syFAvunegHZcGy3hJ6f4Ske06jnMEZzXaoP0aOTmCtxRIYESOjPMFCRV+eiew2WTwghhQnpJ4GswWpjpONUbETt+JHfGiNcRok2oPfAq0ZAyhaQR3JFgvYR1TFp6cDVWQjqrcwPxgYcrhVJxV8K/kCuuTRqhkkyzSdozRpWOGBBoeN/JT2bETjzVt8oV6S7tE5iqDy3OwNlWF8yp9HVpov342JHD9qzC0eQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(64756008)(122000001)(6512007)(6506007)(2616005)(91956017)(53546011)(83380400001)(41300700001)(8676002)(2906002)(8936002)(4326008)(7416002)(44832011)(5660300002)(478600001)(66946007)(66476007)(66556008)(316002)(6486002)(6916009)(38100700002)(54906003)(66446008)(76116006)(71200400001)(36756003)(33656002)(38070700005)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHNFUTBaVTJ6Y1ZNaUhkT21NU0VraTgra25aR3VuSmVpYldQRFBnQTRlQTkr?=
 =?utf-8?B?ZGRNalI4elpQVFVVclg0anhid2k5NytpMlIvb1lHK2tibEVWK3dyd2U0d0Ex?=
 =?utf-8?B?TDlZczNxNjkzdllFdUhteWRIb2h1QnpXMDM5d2huNGxPQ1orVlpiOVBBcktv?=
 =?utf-8?B?VXR2NDBVZkJ0aE0zWEVrenRlRUkyRG9jdHYydFIvOGx6aGtHZjg0WkpkaE9X?=
 =?utf-8?B?UFJxa0dGZzN6K1gwS082ci9EOWRheTM4eExoOUlkWC9GV1I3elpBY29jT043?=
 =?utf-8?B?QmtXdnVzYUZzOVBsbFNOSmx2RFpZZFk2NmNJQ0xZb25Xd3FZTlZxQWhLMlh6?=
 =?utf-8?B?cFg4bGh1bHNvbFk4dHZzMGk5Zi9rMllseTM3QlMxcE9ndWt3L0VuaGo3ZERx?=
 =?utf-8?B?MEtlU1dpUlFXajBBb3ExN3JtenpUVDcxQTlQOHBzU1pqOWFnRm9IV0JORkhz?=
 =?utf-8?B?cC9HbjBjWllGQ0tLaEVqSkNmbGxvMStmVDlFTGtGc0JVMVNOR1FzQXZZeSs1?=
 =?utf-8?B?QlZWZ2RPUk5WcWN6eUs1STNrekl2dnowTHhzeGs4Y01NdHB4ZXd0emppYjUr?=
 =?utf-8?B?YnJ3Y3ZPWmU2MWNVV29QdEdVUmVmajJIeWR5TkJDeHJjYmZIcys1U0dvOEdX?=
 =?utf-8?B?d0dNaW1zVERKTGxETlV3SHlRdjBBcVBGNElybkFCNXcyWGwzdTVIcUd3S1hm?=
 =?utf-8?B?R1ZSLzFua2twTDhadkJIWlVQQWF4UkdVMzBpUGhuSGE0VVVoNVBYZ2gwQVZV?=
 =?utf-8?B?akxDVjUzTXNPZ1A4Sm1HV0dnQ1JaUVdEclRxZlhzd01sZk1BNTczeDZraU1p?=
 =?utf-8?B?SFZkUkxDTXJFNTZ1QUtVYzZGSXJWQWdFN1l5bG4vSXpCYlRXTW5UWHRFRWZP?=
 =?utf-8?B?eU95ZUpHbzkxbmtsaWc0SUh1R3lBRG9SUmMzMWdJdjNGR3VmOGZ4a3ZRTGVv?=
 =?utf-8?B?UW9HRXcvbmYwSnJuRk5xS01NZWhOaHFZRk9xMTY1WXZTQVBPejBQMmRpWnZM?=
 =?utf-8?B?T0p2M1ViOFNZS1pkN2xncmRSSmh0WFREQlRxTXNwTXI3bXRkV2tDRm1xa2lU?=
 =?utf-8?B?TjZkSmxmbVlqTUM0ZEphdFhjQ0F4N0ZHK0xUeGNPbGRUdXpLdFhYaWdxUFZF?=
 =?utf-8?B?U1BDZ2hUQnMzSHo4YzZMV2dQcmVsNC9xQThXUzJjdWZzdndmY05jZzZOQ1cy?=
 =?utf-8?B?YTYyeG1BaUxpWit3RmxHZW43aTBxMnU2NU84NW5pVFM1VWI2VTM5ajBkbTdj?=
 =?utf-8?B?Z21YMnlNWjNDbWx3K1RGMmtkMVMzenlWMlBEdnVOZmJrZ0YycmFpZmhOcjNs?=
 =?utf-8?B?WkZ3dll3aml5dkZNNGhta1lObWF0cUxyZGk1VEt5VldIbmVXTUU4R0FBeG5Y?=
 =?utf-8?B?UGFQbDg3T2ROS1V5QzZHdjJ0aTFiYzd3VGUvWXB4bWNoUGlsN1FEUTJNR2pE?=
 =?utf-8?B?ZG9uVlFkS1RBMnZqZkoxdkhJWVZBUEZpQUYyRWFjc09oSGFRU25hTi8vWW1H?=
 =?utf-8?B?aXp6ZXdXYU9sRXQrNi9WcHNOUElwTXc2aWsxc3JxNGZ4QlFYRXdabEthb08x?=
 =?utf-8?B?c2tJVmRxVGZIOWxBaURKN2o4KzZaRlhidmwxN0pCNDdzbWNtR1pEVXFpNXp2?=
 =?utf-8?B?UjB4MmpzWVJ5RGNDYnd5U2tNYWJ6aXZRSCt2MGlEUFJ5ZFY1SzNXbGZMNXN4?=
 =?utf-8?B?b0prdWR5bGhlNkMxckhDUWJGRHIrcW8xblFCMko4cjJVT3o0ZVdoU09nZG5E?=
 =?utf-8?B?eE5qNHlDZ2J1SWtPQWNONnRDWXhPVXppaDdHNndWTEJiVmtVV25SaHIrdEJ0?=
 =?utf-8?B?WXJPYXYwWm51Tis4OU1FQmYwSy9NcnF4amltYTVFeWVkVXNuZUdJWHd4WkdR?=
 =?utf-8?B?dmFyT3FTQ0hMcDZlUFV6WkRURHRmK2ZTTzJCTmhNWlpDOTNORWhmVDlmQUVH?=
 =?utf-8?B?N1EwS3V2WWNmd2pmeTU5Wks1c0p6cGhQS0Rya1VFOURsQjRMN0hkSHNGMHlX?=
 =?utf-8?B?UXhBeGppZmU4V1BMZmROZnlvaVEycDZQdzAzcy9FSW1FQ0R5emQxSi9GWUxO?=
 =?utf-8?B?Q2tQTGJidlFkQzdsS2xqcndISDBPY3Z1R3RFRDJwY0ZHeEpVSm9QVngwcE4z?=
 =?utf-8?B?QmdYUzJHaVBBSHhOWDhvZzN4ZmJuR2RXVm5VcDNtSGJXQUtQcDF4NHNwYVJM?=
 =?utf-8?Q?NfgrfUVPBp9b5eD4/bZBmDA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6ADCC213A76884CB034F89EB1BC23CD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WXhwT0RnN0FYbUVwakNRWkZMQzFMd2NDWUwwdDZ4aFJPOEpPV3Z2Z1crMU54?=
 =?utf-8?B?WTdMVVE5T3ppNFhwaEF1NExUTDNQT2dBOHhncmY2bklYZkZLaEJDTjJ0SHpJ?=
 =?utf-8?B?b1RSUHpKRURPSlkzczlBdk11bjIxVmtRNk1hM1NZYzB1eWlnOFhBUmZmbHpC?=
 =?utf-8?B?eFZ0MEJvT1lLMDl4TUVhVjdMamlKR2tCOExkekhhY3ppY0szcnRMdWpqNUVo?=
 =?utf-8?B?a0ZwRWFWT0txcHAyU1I5MnBDRnpKNjd1eW5idDc5NjE4RkhLay9sSFRPZkN3?=
 =?utf-8?B?dmsvK25Fc2NFYVlSTE1aUUpjbXVqeXNOSlBFeC9DeTI4WVJNRWdSMEU0azhs?=
 =?utf-8?B?S1FsS2E5TTlGMnJpNFRXZXBGSkFoOU10RWIrQS8vbllBeDR3ajhDY0FQelJj?=
 =?utf-8?B?byt3WmlVTTNmdnh6RHhJKzdlQmF3OUcxK1hxcGxBVUFnc1VONStPWHpCdjFS?=
 =?utf-8?B?VGJhT3ZFY1NRZmtPaG5EZit2SWtINTE5K0tFcyt0WEhWSWUzQzdYUmI5QS9z?=
 =?utf-8?B?SmtsUHFKeXVwUGR3d3NyVDBORHZKNFQxYlRGbmZSalJFZEthUThvQlJGeWpW?=
 =?utf-8?B?bVN0KzJzYUhOUEpzN2ZMdEJ6UFp1dHg0YU83ZHV4OFgyT3Jab0FBWEFaUDgz?=
 =?utf-8?B?V0J5UnJ1bDRiSS9mT0t5K3YwUEFiQUdvQ2ZPVXgrbC8wVmpGTTd5aFpvRlor?=
 =?utf-8?B?R1p2ZG9vU2l5aHlpY2k2bVNNdlhpejJORXlkSXBZbnorTWFxK1lscHhZMTVo?=
 =?utf-8?B?a1phdDJwQnFSR1N4NUFRZ1dBTlgvOU5BYWZuZ0Fyd012NSsyRDA1bE1JYTdK?=
 =?utf-8?B?V0h2WE91SWZwbTN1TGZ5NWNvZlIySXFIZzdrMmF2M2RLSytaS0puUnVXbWVI?=
 =?utf-8?B?cVFWUFB6Y25PdHZUU2NmRXdoR0VDb0M5ZEtkK0MyQWJBUVVGWTlzRTVUN011?=
 =?utf-8?B?c0plbjh6MFpuNHhoZFBjSEdtQUMzRWJGQndBZnhZUTZSZFJNdjAxRWxMeGFD?=
 =?utf-8?B?d0dRZTM3NFc2d01abmJnbG5FekVNU2Q4Y0lVTmpUaDdaUE0yeHBsZ01jKzRW?=
 =?utf-8?B?dmpwK0JZTkhiLzJJWTdRRG02RVNuMGUrM0t2NXUrdU9WU3lSTmJ1WFkrWWdL?=
 =?utf-8?B?dmVFb050d0loQ2ZMaVJLTlVZL0NibGhqSkk4WStCM1FwWHIyT0pCTDhONWNR?=
 =?utf-8?B?SkR3NFFGYjFtenV2Z0RlMVBRNE9wdG9IYUFoaDFtaXRUdmlpaTZOTjk4ZzhC?=
 =?utf-8?B?VWlKSmVZRnBmWkNJQWxid3NrcVhmV3UrbGVSVkdNbWRDc3pLa0ZjUHloSVVh?=
 =?utf-8?B?R3ZlOVhzaGJXMUlHa3FveW1ERVA1NHlrTmRSM3BINTVvZEZtcnBqNURmZStE?=
 =?utf-8?B?RHROcytXVjZ0NGc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f14c298-15ca-4efe-a4ad-08dbd0a689cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 13:23:09.7642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bPIAJU73oeY9llZ1rtryQQq0MhARvBdda9RkIsTLnY+vO7jmA0SUAwyrVix0Z4SfghhGYEQPfEt5EVL5sXp3VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7505
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_12,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190115
X-Proofpoint-GUID: zyrt1jUCo-D4OLr1uu6-2Rl2Hilmia2N
X-Proofpoint-ORIG-GUID: zyrt1jUCo-D4OLr1uu6-2Rl2Hilmia2N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYywNCg0KPiBPbiAxOSBPY3QgMjAyMywgYXQgMTE6MzksIE1hcmMgWnluZ2llciA8bWF6
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCAxNiBPY3QgMjAyMyAxMjoxNzo0MSAr
MDEwMCwNCj4gTWlndWVsIEx1aXMgPG1pZ3VlbC5sdWlzQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4g
DQo+PiBTb21lIF9FTDIgZW5jb2RpbmdzIGFyZSBtaXNzaW5nLiBBZGQgdGhlbS4NCj4+IA0KPj4g
U2lnbmVkLW9mZi1ieTogTWlndWVsIEx1aXMgPG1pZ3VlbC5sdWlzQG9yYWNsZS5jb20+DQo+PiAt
LS0NCj4+IGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vc3lzcmVnLmggfCAzOSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4+IDEgZmlsZSBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCsp
DQo+PiANCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL3N5c3JlZy5oIGIv
YXJjaC9hcm02NC9pbmNsdWRlL2FzbS9zeXNyZWcuaA0KPj4gaW5kZXggYmE1ZGI1MGVmZmVjLi44
NjUzZmI2N2EzMzkgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL3N5c3Jl
Zy5oDQo+PiArKysgYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL3N5c3JlZy5oDQo+IA0KPiBbLi4u
XQ0KPiANCj4+ICsjZGVmaW5lIFNZU19TREVSMzJfRUwyIHN5c19yZWcoMywgNCwgMSwgMywgMSkN
Cj4gDQo+IFsuLi5dDQo+IA0KPj4gKyNkZWZpbmUgU1lTX1ZTVFRCUl9FTDIgc3lzX3JlZygzLCA0
LCAyLCA2LCAwKQ0KPj4gKyNkZWZpbmUgU1lTX1ZTVENSX0VMMiBzeXNfcmVnKDMsIDQsIDIsIDYs
IDIpDQo+IA0KPiBbLi4uXQ0KPiANCj4+ICsjZGVmaW5lIFNZU19DTlRIVlNfVFZBTF9FTDIgc3lz
X3JlZygzLCA0LCAxNCwgNCwgMCkNCj4+ICsjZGVmaW5lIFNZU19DTlRIVlNfQ1RMX0VMMiBzeXNf
cmVnKDMsIDQsIDE0LCA0LCAxKQ0KPj4gKyNkZWZpbmUgU1lTX0NOVEhWU19DVkFMX0VMMiBzeXNf
cmVnKDMsIDQsIDE0LCA0LCAyKQ0KPj4gKyNkZWZpbmUgU1lTX0NOVEhQU19UVkFMX0VMMiBzeXNf
cmVnKDMsIDQsIDE0LCA1LCAwKQ0KPj4gKyNkZWZpbmUgU1lTX0NOVEhQU19DVExfRUwyIHN5c19y
ZWcoMywgNCwgMTQsIDUsIDEpDQo+PiArI2RlZmluZSBTWVNfQ05USFBTX0NWQUxfRUwyIHN5c19y
ZWcoMywgNCwgMTQsIDUsIDIpDQo+IA0KPiBXaGlsZSB0aGUgc2VjdXJlIGRlZmluaXRpb25zIHNl
ZW0gY29ycmVjdCwgd2hhdCBpcyB0aGUgcmF0aW9uYWxlDQo+IGJlaGluZCB0aGVpciBwcmVzZW5j
ZSBoZXJlPyBUaGV5IGNhbm5vdCBiZSB0cmFwcGVkIGZyb20gbm9uLXNlY3VyZSwNCj4gYW5kIHRo
ZSBwc2V1ZG9jb2RlIGlzIHByZXR0eSBleHBsaWNpdDoNCj4gDQo+IGlmICFJc0N1cnJlbnRTZWN1
cml0eVN0YXRlKFNTX1NlY3VyZSkgdGhlbg0KPiBVTkRFRklORUQ7DQo+IA0KPiBHaXZlbiB0aGF0
LCB0aGV5IGNhbm5vdCBiZSB0cmFwcGVkLCBoYW5kbGVkIG9yIGFjY2Vzc2VkIGZyb20gYSBLVk0N
Cj4gZ3Vlc3QsIGFzIExpbnV4IG9uIGFybTY0ICphbHdheXMqIHJ1bnMgbm9uLXNlY3VyZS4NCj4g
DQoNClRoYW5rIHlvdSBmb3IgY2xhcmlmeWluZy4NCg0KVGhvc2UgZGVmaW5pdGlvbnMgd2VyZSBu
ZWVkZWQgZm9yIHRoZSByZWZpbmVtZW50IG9uIHBhdGNoIDMgd2hpY2ggY2xlYXJseQ0KZGlkbuKA
mXQgY29uc2lkZXJlZCB0aGF0IHN0YXRlbWVudCBiZWZvcmVoYW5kLg0KDQpZZXQsIHNob3VsZCB3
ZSBrZWVwIHRoZW0gaGVyZSBzbyB0aGV5IGNvdWxkIGJlIHVzZWQ/DQoNClRoYW5rIHlvdQ0KTWln
dWVsDQoNCj4gTS4NCj4gDQo+IC0tIA0KPiBXaXRob3V0IGRldmlhdGlvbiBmcm9tIHRoZSBub3Jt
LCBwcm9ncmVzcyBpcyBub3QgcG9zc2libGUuDQoNCg0K
