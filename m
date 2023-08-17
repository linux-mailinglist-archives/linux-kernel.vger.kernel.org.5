Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35E577F4C9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350177AbjHQLKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350234AbjHQLJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:09:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2FD30C6;
        Thu, 17 Aug 2023 04:09:46 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HAO0C3032492;
        Thu, 17 Aug 2023 11:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Xd2xKHxnKsesWJTUrt92XDaw6G7+WuIudJz4u0KY/nw=;
 b=tL6rNP0VuLRHj2WRGYXLpjMlWdNJ0P6kvWVBLUxsLvjiDkdfaUqmLR4XUsxcv4fAYK2p
 QKdOw9QWR+B371PRQWIPmrU88KhS5jHST5n281jCs4fZwFhVSCiq5SCoKAELrt1AynMJ
 afr5+ScILeBXqEAG+h0rGIre8s/6Ig4NBo6XdtppupqAiUlx+dDNxy5XA8VbrVrOBBnc
 42NADJ/maXrZLetD8vVavNd0HrFFbdoaAn3/8H7JMYYc/mfvqWaEiyihdX1Dt0YvC+zj
 vP+ATyfsg7DvSFWtxYVXDuOkJcbfZ6eisZ4sfwg76vCfZmpo3dFU2U0sTiGvwMV8T8HA Jw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se349h8xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 11:09:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37HAweFG027399;
        Thu, 17 Aug 2023 11:09:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1up655-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 11:09:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZQD+9ZVaaHkxFicKBFF/nz54Y5rSYk+P4hD6XOYFAQIhLUygxtCvi1OWyvWV2qdOxx+jZ937H6hHzkZg6kZ37Q4roMYeyZy1jJubKH6ZVmFqD2B0TjlEcqTqzzjDDmdq5mpB6KqT80MvYGINHwonkszQ0w7UZy2ht3SphXExQJZlnNT3DtcOCLbCh+4jEoacStFwdI5CprJu0pXj/k9lBteMwpd3wUpIGD1jDGliDgPSUTbgIg+Cbhki9o2WXGCGeo3PcYij5eFoJ8UbXJw1kt9QZBVFvd+69TadmfCVw6YTm1A2a6EqR6HV0IHFqcG2I927ehYWdjAj5PiuQh7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xd2xKHxnKsesWJTUrt92XDaw6G7+WuIudJz4u0KY/nw=;
 b=Km2tVcyiSMKQ7F+jE0C5dylYbt0I7zol05/cguY5vF1k2dQreZ2ZirGCReXBpfueJLibKEr+8tUWWJqIUr2f/KKslEAFAxV8Qh9Rdpr94T6WbSLM5IppM06noOcwhCKc0y15KUYlXNSwqHCXDHN+vRZVVropYhvQGHueTJy2QPzlKBIbt853FEZQjJBT+LyGENW0yNLJRW8YY1l6tOP5Pxhkyvmh35cvauRBtdApyKZiXmITXF1fxeUYZQqmnUA3omeN2+WqZoKKG5iihamWgj0dIMw+sGsiC3grdd0iFBQItV0Azyzyy0Md0bJIuHdZjLO1j4gJBtMbf2s2/kZ3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xd2xKHxnKsesWJTUrt92XDaw6G7+WuIudJz4u0KY/nw=;
 b=d+QwU0B3nGtqLaZY5LqDq9biyvo2LP9FIhYa4vgIm5cAKPZ1KNZGabwhGlTVrQMZAm8uSoP059o0gGpyd/XaUzn6ewV9D1QsN5eggcsgD8Jf6nM3W4+14msHVVPz1Zgwax+qB7wrqh7s5aQnDAOfozumXV6EI10Shi15uoBKC1w=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6787.namprd10.prod.outlook.com (2603:10b6:610:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 11:09:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 11:09:21 +0000
Message-ID: <81e404fb-0eae-e4b8-299a-54ac860fd1dd@oracle.com>
Date:   Thu, 17 Aug 2023 12:09:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 6/6] perf vendor events arm64: Update N2 and V2 metrics
 and events using Arm telemetry repo
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com, acme@kernel.org
Cc:     Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230816114841.1679234-1-james.clark@arm.com>
 <20230816114841.1679234-7-james.clark@arm.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230816114841.1679234-7-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0276.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 48940055-e23b-414a-2e5d-08db9f12683b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VO99vWU9EDTZ25prk10snL8ZeYIdKKRBDXqiwk0n3pK1p+OnLR97vtyQbhiJ0STh67OoE40+m4JHlU+cy5MqdxhiglEfSonnrZ0mzy/scFJ6pj3eCu+svyTcwBEeW0IrWhTonaLbxplZ0lPsG3Hl7XVU+n3z9UHBsJBIH1KfsJugi4KuUgxRpAQNXe3AfCmwKLcJBtE2Q+ZOh+XdvHYyQBhUBd892ledYjrhv1vw/VCoT+8lM0+BRWOlbiz0TR91LgGUjhnsrBpv0SEL7qbq2ArWBa1awj8YGL7QK3vYO0k9C3YQtDSHiyp88AN3Xo8wD7Ly+iffRnuVxIeAT+6tDxWwv3kruodINyqJ+8iAoBP7xZ99P/0S3yIULn78XSVq9xNuw/2NzntlKChNEOBq0e4/iBnAkNS1rnVzkeh8SsjHvw/Np29BrqBLsjLN28HmPYwl5dxz8YpjkQtLV7jbvh4jR5auzaKAbFfVL1sgHCKhMTW5bFKyMdf5jBqIQBImK3Aup3Ojl8iNc3W5AZ4IFC92dmZEKD2g3eBXQ1YYvNB9iVSgbR9cKLvgsvbpZ5qTJgZ9Yet8q0TGBns5NxUDpgTKxob/wWAZeZ/JNj0o7oixwY/b7uh5cnetdBQb+jP6wxPsQUecRy6a7Zbn40cjpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(1800799009)(451199024)(186009)(316002)(54906003)(66946007)(66476007)(66556008)(31686004)(5660300002)(41300700001)(38100700002)(4326008)(8936002)(8676002)(26005)(2906002)(15650500001)(31696002)(83380400001)(478600001)(7416002)(86362001)(53546011)(6512007)(6486002)(6506007)(36756003)(6666004)(2616005)(36916002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0ZFS3k3dkVyRWQvdmtJYnNvaGZ4UGd6bmx4dUliNnlSKy9vTWpYNC95emZS?=
 =?utf-8?B?TmhiODBTbUdFbW95TFBQdTdsRHgxTTdnV3VRbW5UcWZSYVJuSERKMkRYakJq?=
 =?utf-8?B?dHBhOEJTYnB5S3RrU1FkbXJMYkkxalFoMnNyWFdZdGxuT3JtM0Y5YUhvK3RH?=
 =?utf-8?B?ZE5iNDJmMXFocFhvRTlrOVUyTU5zNFlNelV5ZnpqTjV4cmplR096L056dCsr?=
 =?utf-8?B?aCs5Q2h3TFRlOVJFdGJFMnhuN1dCRVZzTnNnc0NScW41N3JFOEJqa0lZblNs?=
 =?utf-8?B?WGlJejllWDN0Q2hySlN5Q0tkMHMvTXNpaS9CcWx1SzNPL2JkOGtjYTZmMlE5?=
 =?utf-8?B?N0R1UlJUbFVvSlpZRzBWOU1XaG5EbXQrWjM3WnBZMGxxOFd0NFIrbkVtRUhx?=
 =?utf-8?B?K3BoL3AybTZkbS9GeXpRNVVsZnVWTko3cUYyTkg1RksvUWxyalFHVGFJVzJt?=
 =?utf-8?B?VGVYY1NHMUpJRFJpTGF0MFJ5RlZDWGRaeE5Uc0FQLzN6MEVhdmp5K1I2VHpU?=
 =?utf-8?B?dFVDUEE5MTlLcjNqVkp6K2FRUWpKRzlMYmJ5UUsxYldSVFRybEVDbEpXa2ti?=
 =?utf-8?B?WDhHcHhFQmVHU3o4SmYzbE8ybjArbVRkMGJsTkZSa0lDUkpndGJ1S0hUbEl1?=
 =?utf-8?B?Y1d3MXp6RVAxOGJmM2swZ1dKTVR3a0YzaUpPRkJsdzA5akNGRldCRTlaSzZH?=
 =?utf-8?B?SE1CRlJkbFkvVnh6aGJpOUZHaWNZOUNtdGtDdEV6VHYxUVJPaUQ4a093enJn?=
 =?utf-8?B?YXNhQUVLN0xGbUlPSld1STdLT3dpd1JkQS9LTEFLWVBZMWhJNUN0TE5MMmpL?=
 =?utf-8?B?enN3S2lPN0xDTTU2WFdLT0ZnZkxDbGozSlJqdWd2RS9JbmM4NkhxQU5kUFNv?=
 =?utf-8?B?aGJyTFhMWFJ3WkpsU3NubzlmVVRYVEpFM2l1ajVZeHJFWGwzRkh1cU9EQUJq?=
 =?utf-8?B?U1MvMlNveVdNdzFWT3Vlbklyckw5OUhhMTUzZkRlcUN0WUV6RDlySk5nRm84?=
 =?utf-8?B?RDhrUzBHeUh5TS9CRDlwdUNzb1NhTmpQNEZKNkQ1VUJ0cEordlVsT2JiUmVI?=
 =?utf-8?B?RXYraVNaMGdvVlFheDd1UUVGMTdhYlN3eXNTcGsxaVNlOXBKWXhKRHdUbmd6?=
 =?utf-8?B?L281amNSNXZNd3A4UnhvUFErZGZpNTVMT2FHOWlhMFZHNEUvSElObGo1Sk45?=
 =?utf-8?B?NTl5U2tLcVJnZmhhZUszSTJad2pMYkFVVDdieUxzbk5VQ2Q4Q2l3RE1XNC9n?=
 =?utf-8?B?OGRnYkU1UzQ3d09VTE54V2p3eWtUR2pkaDJJYkFiRElFVURTbnEwY3V5Ympt?=
 =?utf-8?B?bmtaY2paNTJpUVVMaXZXcjlrR0pLSGtSNHpUL29BK3lqMzJ1ZjJBUjI1VHho?=
 =?utf-8?B?Rm9UaElMTkhub2ovLzdXZ2xqNWQ4SU5Fbi9jZFlVVnNBelJRSlFEUVQ0ZUpv?=
 =?utf-8?B?ZDkvRUZFNlo2OW13aWtHMTZKditOU1lQbGZRYncvQUdaTFZ5T1pFUnBTZWNr?=
 =?utf-8?B?aGRzUWlPTjlqK0dGZkhGeXp5aTgwaFdtcXc1aHFwOGc1VGM0bzJZbGU5WlVC?=
 =?utf-8?B?UzJjY0plL1hWaHp4UU5NeXM0TzI4SkR5WmxkYnl1VkFzb1cwZHZpSTQ1aTJJ?=
 =?utf-8?B?MGZZTDFyUW9tQ3NxUENsZ0hrWDhNaFZ5a1NHL3RITmczTXVlUkFxMzRnOFp3?=
 =?utf-8?B?QytCc0xjMjRtNDA2ZUYvWmtYMC9wT3RwZkVUdzVweTBYY0QvOGV1bEd0cHk4?=
 =?utf-8?B?aDdnVm5jRFNiampraGxPRGJ6ck9qUTV1Z3d1NzdKTEpGbDhjNVBVM3l5YjNM?=
 =?utf-8?B?QWJKVEE4TVU1TXBYbk9QandLdDllSWh3aUdpTEk5VEFFRlYyNm42Tm5GOFNR?=
 =?utf-8?B?QmRzVWV4S1NLTGxLeGtkaVE5U0xCeFBVUEZkbFFqZ2htWmMyR212WG5TdERN?=
 =?utf-8?B?UWc3MEJaUEtYOW9hY3pyTzR5MFB5Z1R3VGZ4VU5EZks2OXdQUG1tNmxyOGxM?=
 =?utf-8?B?NWdrbXFCOGYyTHlzL0prL0hTdWhmVnduZWZjUWJIOURlMmhiZG5UZTJicnZt?=
 =?utf-8?B?T1E3c3E0RlJMeDNFcEV3K05zdDczWW5NN2tBbEJVbkFXNW1TMTlYRysrMnVG?=
 =?utf-8?Q?94QavfqgnUyJYybUYGBJxswC+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dTlNbmt0LzFocWt3WDRNMzRnYVdhYjJzQmE3T2J3amh4MURqY2tRUG1sNFNS?=
 =?utf-8?B?dVlXd0RqVkt2dERsNXU0cExUdy9SWTNqbVYvbVVxVEZSaExGL2RERjUzSzBt?=
 =?utf-8?B?L1lLc3BUQnNhRkpxTm5nTlhmVWF4SDhBS2JpbHo3NXNnZ1pQc29qRTJqZldK?=
 =?utf-8?B?eXlhaUF3Vzl2ZzBldy8yQkQ5b1VaR3pMZ2k2STBoMEtLdXl2R08wRUtUUTJE?=
 =?utf-8?B?ek9mb2R3bk1UMzNCMU9Bc214MHFwWE1MSzZxS1lsZlFaaGN0SGw5TXpXTXRW?=
 =?utf-8?B?WnhmNGE0MHhJWm9HMVhPd0I1RWYzR3pZYjNFWk1rL2JiUVdoOUNoU3ZucHpG?=
 =?utf-8?B?L0s3bGgxSFBKVjc4NnlyS3JxRzU3ZDJXTVUwUVQvYm1ncitmWTZsL3ZsR1Q1?=
 =?utf-8?B?UExkbEE0bHFaeUoySzVvOE5pTEVYNGdOUDIrRXYxbENQckduUDI5TWdvY2ZP?=
 =?utf-8?B?Mkp1czNabWZ6SzdQeTV0SFcvNWVvY1VHNy9rRmdSMkN0SUZOZWZZMmczaHJB?=
 =?utf-8?B?NlJWWVE3ekp0MDJJaytqczhoSTVyN2ZZNDVmTFVLdjFWdG9US3NEdlFKQ2Zh?=
 =?utf-8?B?YWlweEg0MU4zREw4OEdoRFpPdWpRdEtlbWlMYVRlTE9aU2l6UGVKb21RQ3lY?=
 =?utf-8?B?aFhVb3l1QXlOOEIxTjM3bFU5STFXLzhrTjBBbzFwVkt2ZTZ5cDNqZEhhajBk?=
 =?utf-8?B?YmxkazdPOFJlelpqSGVJS0ZCNFU2M2d5Z2ppc3cyalUra2gxNm8rMkROcEFL?=
 =?utf-8?B?VDN3Q3ZOWVdQVG5BTDZsQ3phaFFsUm1MY281eUIzUmF6SHZ1MzMzSnd0a2JN?=
 =?utf-8?B?SkMzYmgzSjQzT0ptWU1aVWVWRXROSllXS2NTQnN1c0tORGJLeDYrM3Frck1r?=
 =?utf-8?B?ajFueWtYOEw1T04vT0RPVVQrNEpucUxoSndMclRNSUVwaldROUxtMUpaSzQw?=
 =?utf-8?B?ZlZFYzhlVmwyUmJpaXhScHpQQktHNzRFVHg4enBHL0tRNjQrRUhYbGdzek4z?=
 =?utf-8?B?QlJiL0w3RUo3dXp2TXA0ZHJPTG5DRVRZeUlRdldOUjZoV3hYUmlHUmVUR0tt?=
 =?utf-8?B?WDlxYlZ5YVhTamxkSmdjajJJaE5STjl2emNjKy9wVVVHenA2MnU1RDRDWHdD?=
 =?utf-8?B?Rk5ma3lHSFdlK3JBUkw5b1diSXZJOUwxd0ZLQ2hFb1VMK051U0tzUGFxaE1D?=
 =?utf-8?B?VEhhWGpucHdtVUk2bDZjWnM0RHdEVUNVMUFJY2ZOeTVPOG5BMGRGN3hWNFBR?=
 =?utf-8?B?UVExL0s5UXdEWjRWd3pEenBmdUZFNzJLVUlHTi9VcVJzeWFGMlJiU3NzTUFy?=
 =?utf-8?B?Yk1oV1dZSlFodE1FKytKT1IycUU0c3hxaFpDNHdGWllLb0ZCWHB6RXpraUIv?=
 =?utf-8?B?ZHkyVWFLWjNNVXI5QWw0MTRmQTFrR0xLc2tybGtjbHkxcTQ4UXA1Y3ZRTVVW?=
 =?utf-8?B?em9HZ0l5MGwrSjRQcldOakxiKzhSQXJFZXRWTUE4NDZoWmNoK054Q3NYcmE2?=
 =?utf-8?B?K0ZMUnF2YTNMN3ZnMkxqOUlNZTNaTUJMNTF6NW82c1A2eFdFNnRETy8vMW9i?=
 =?utf-8?Q?c4UWTnARi8SxOaTbWnsk2IjJ0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48940055-e23b-414a-2e5d-08db9f12683b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 11:09:21.2322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQo3coVKTsw0FBD7kWL4nrmB0J9Eg6QK2wG/9LN2T8eSy449kKs/o8oZllUEo+lBP2/sdEI7uK3y3nreZaqVOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308170101
X-Proofpoint-GUID: sWXwZmKjrJ0LC9kxAHrCRKID0ICAuKJy
X-Proofpoint-ORIG-GUID: sWXwZmKjrJ0LC9kxAHrCRKID0ICAuKJy
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 12:47, James Clark wrote:
> Apart from some slight naming and grouping differences, the new metrics
> are functionally the same as the existing ones. Any missing metrics were
> manually appended to the end of the auto generated file.
> 
> For the events, the new data includes descriptions that may have product
> specific details and new groupings that will be consistent with other
> products.
> 
> After generating the metrics from the telemetry repo [1], the following
> manual steps were performed:
> 
>   * Change the topdown expressions to compare on CPUID and use
>     #slots so that the same data can be shared between N2 and V2. Apart
>     from these modifications, the expressions now match more closely with
>     the Arm telemetry data which will hopefully make future updates
>     easier.
> 
>   * Append some metrics from the old N2/V2 data that aren't present in
>     the telemetry data. These will possibly be added to the
>     telemetry-solution repo at a later time:
> 
>      l3d_cache_mpki, l3d_cache_miss_rate, branch_pki, ipc_rate, spec_ipc,
>      retired_rate, wasted_rate, branch_immed_spec_rate,
>      branch_return_spec_rate, branch_indirect_spec_rate
> 
> [1]:https://urldefense.com/v3/__https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/blob/main/data/pmu/cpu/neoverse/neoverse-n2.json__;!!ACWV5N9M2RV99hQ!NW7DYe7T69u8RFn9WLyiCcoHm-8BtlxNK3PRw19udocwlwv0vQpjcSDT5XqGbWzvPQyFrG-eRkuu_VZt7cO8-Q$  
> 
> Signed-off-by: James Clark<james.clark@arm.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>
