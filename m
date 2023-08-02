Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1F576CB8E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjHBLPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjHBLPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:15:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAF32114;
        Wed,  2 Aug 2023 04:15:39 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372Akvno002500;
        Wed, 2 Aug 2023 11:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=0Xi73GYhUgpJZ1DjBlZ3R7b53h0MP1uoSe7dHf7y2xY=;
 b=NRN8idjFSdCXOucKywW47YEuUvAn46PmoUeT5FQqZRU5EU6ALRabWFb0OsZcrB5dFHqh
 4vRXmZXZHynrKouznRuX+YpUJOljZkqUYwFAUH75NrCgdbLaoiGFFTcC4CVjsAWMHgnw
 KBaiKfyNmKp/fJtTq+DRubzg8CuKwfY1VprDulhU5D4u9rb+2b9lRbhNNWKA3pHqXuRx
 khqcicAjHIZkh9NlXToNHva6rEno1+oC+awS4nHCwkL1KzZy8yFUHu1/qo0yhVpl8nO+
 0RzMyJGB7njSsq06uZlcFuJGykbTPN7jPgu9YChneOsH0rnVcBt7LR7/uOjU+k24eY73 EQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s79vbs1su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 11:15:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3729TKjq025289;
        Wed, 2 Aug 2023 11:15:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7eb5fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 11:15:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxettSaBlfz1LqlmVvyq+1knm6W6iuOfBS97Zbks+BJzcIS8knCtIIKKen1+XV2lqfER2blGfazSjONiuciHikBj4PP8tyM5YkdE21S53Hr5eB/aC2edHUFiR6218uBqHDZpZ/Qo/m4iO8ZC9GRZQDVYrBPwgs8VLuHVkd8vMWbevmWcejec78GXhcsejVZ2MtmxG9dkvjcMWwnKokm5EnxuisgNq3j/p4RcW+Ph2JNlRnaGNJxdyPvLwDws0fBQogLASE+SqB/fhvyxL6QbYqdFxk5hX8Q/r5uLF0+niluvUQxsUKxSEdIBEBNLszihs5YbKOKwHQB3sEdVwF4rQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Xi73GYhUgpJZ1DjBlZ3R7b53h0MP1uoSe7dHf7y2xY=;
 b=X7ChGDY+d+/EivO9xsKfyU1fWL58C9RgP/C+BVbw+zFEV5dHzro/Dd6o9ipozQtwzpW7fKGxRJgK7lb1hmdyW/3goYN0PM1o8cx7oVCkKIlMSPlEXWkPA8odD+NjdIJpxaWHxko37MY1m2VgOzXDB3eCHGKw/s9bb8msGeJBZQGXo90mJZzK6b2kgRJ97tkTIBuVM3kOrDxgzZ1XEix3xcmfPN+JP1f2JYVcfYdOFChXI6NqoUETcZd+xyf4T+ryHpOv1fti8wBdjuzfCaO03mKZE2ZNnkFAkvUA4trafr743ocKsbdXjOYBPtBztCQoRAKoVjyqC5Ac1EIDId4+8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Xi73GYhUgpJZ1DjBlZ3R7b53h0MP1uoSe7dHf7y2xY=;
 b=prD6ZxLzzt8Syxf+KZrnEjhavvmNaSYO4pTWnw1jiqEBBA3uGQXcdmICxfYHSKn+GywScnykjV9LG5wXIH2y8mVgVGtFph0Hu4TdzfT0It6CT7PTNh+bBqOYUv3iR4OwAUiq6SVN65hTcY1AubSucthv1JAofB02EUoeUWY1zm0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5189.namprd10.prod.outlook.com (2603:10b6:408:117::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 11:15:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 11:15:17 +0000
Message-ID: <2ca49280-3c31-71b6-8efe-dd8e26f3dcc9@oracle.com>
Date:   Wed, 2 Aug 2023 12:15:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/3] perf list: Remove duplicate PMUs
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230711055859.1242497-1-irogers@google.com>
 <182675ca-0905-0ed2-de94-0f7d4a256082@oracle.com>
 <CAP-5=fXrOvkwrbEB0GGv6Xr5JOdrW7dzjOL=MkDdxX2McfnzYA@mail.gmail.com>
 <cd5814af-8ab0-6ab9-9b3c-b5081e54f199@oracle.com>
 <CAP-5=fU4c+kU0OYbPp0andZW33tHiewyoxkvXbrU36EyLKKZ2A@mail.gmail.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fU4c+kU0OYbPp0andZW33tHiewyoxkvXbrU36EyLKKZ2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5189:EE_
X-MS-Office365-Filtering-Correlation-Id: e41cea25-7fab-4e7d-6bf5-08db9349c00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X6+pRgELEr9gf8g3QfsbP37/C5tVzqmrXJ6CT8SykKP9lIAhL9xx6vVKfTVqqB5tPw2J2fq0ljyXhnbO3Bi8Ez5PUbrqakSFcQJdEVQ0MfI+aDTyiKNBnehygJPDKTOhadpcaVkRivZ7fNqldorYJuUuT49stN4DukRR0Qd4P/ID1OlnfRYHuodSB3KeCTbRtXSWWxsvhdCIYsZ06I4Dh5SJLL+HXLRqkVAeWiNqzTovOFQ8LaVP9+ucYulf0/aI24IkodRZtzbuDnswL0VxsXdwX3XR1ZlA2mCgYuE2pY59ghbV5MNOi4NvUxSrV2po/XUOemMDnneyJNVRrL9Vbr3YRJMAQXREQAnK5J20t7e/ph9b5+4N4udK6kF9FqD99dw7ncvQaDa6XV5xm74Lq4kkjLIT2L7xsk3ElQL7S9TsZYuBPdEmo0nhQn/MSxCvjrkBk8/rVQrOeqjeOcI2Qi0wvMKeT6ZKx30Sbu+EJyymVNZymICRBn9ZZp2ea62YqpOEWLPNReWfox9IY4Q9LTBZCxhHOccUDCa2xH3l5D9i9AdZWxN+kRycvKR8sy0kjG39RHUNBx4vblXmoneHgkiMkaaJR0VjA2ZKoDpojnRTNWQqi9A/8cWHncpnif05EywmjlpXxHPMwNabSbj3ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199021)(66556008)(4326008)(66476007)(6916009)(66946007)(2906002)(38100700002)(2616005)(53546011)(186003)(6506007)(26005)(7416002)(83380400001)(54906003)(86362001)(31696002)(478600001)(36756003)(6512007)(6666004)(36916002)(6486002)(41300700001)(8936002)(8676002)(5660300002)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkhCdHNOVERLdnc0OHRKTXM0ZkhobjV4OURGWmwwSUw3bFhwVG82Rm5OT0M5?=
 =?utf-8?B?UmF1MlRMZUxjMlR1VE9CTmgyMzQrbWd1T3ZPYmxaMGZnMmtkbm5YUy9xNTdl?=
 =?utf-8?B?bFFrdXRLbTlNZ3BqeUdMYkNpVnlpQjUwTW5VNkVCeDRQY0k1MzlEMXVsN2Nj?=
 =?utf-8?B?TWpzVHRHQy9aR0p4MkNuaUtGbkNvMWd1ckJvZ3lMN0p5SDdqKzJ4MldWUkxF?=
 =?utf-8?B?a0ViNDdYeG1hYW9iUCtBcWVmRG1hM0RMdHBESEdML25VVENZMzFwM0pjc1Vw?=
 =?utf-8?B?QzRZUU4xWmFZUTVrYWYxaVpuaGJjZkE5Sjlydlg5SU5YMXdOc3lxOGNYSXlk?=
 =?utf-8?B?V1JaVkRaU01SNWZRdis3RzE3clR5N0V1SExuWWI1QTR6dFNCaWJDUGM0TzNP?=
 =?utf-8?B?aEM1cXZWM1pMak4vVXd3eC84dVJoWDJya3JiZGYwaVlKWnhoanVzL3RrSnJ6?=
 =?utf-8?B?NWEwWHEySHVPd250MmlGN3BZSk1rM2tFdkp0anRwaVl5b0VFZDJaSHYydVRY?=
 =?utf-8?B?aG5DQTg3SW5ZUmFhRm9kODVrOVdQaHU5dlB4UUFmT0kyd0hQenFtdGUzQkNq?=
 =?utf-8?B?bDE1aVF2OXdOQkN1UW5id1d2SlNPU0Y4b0pVR3FaVjBRWGFjRHhCY3JIVFNh?=
 =?utf-8?B?bWJnNkM4Y0FCbEhSZ3U1RGdYZUtGWTh0YWZQcmQxSzZ6d3JvUVFMdEFxWWJI?=
 =?utf-8?B?QmlzZGwvUnV0ZVZyZnViK0xScTFWR0tMOHFEWVM3NjBSK0tBVnA0OGlsVGl1?=
 =?utf-8?B?akVwTHpJNXRZNTVsYXZxSVhmWVM5d2k0TDFpVTdTN1I0eWsxYjRZZ2dkb1Yw?=
 =?utf-8?B?SDJqcDVkSk9yMlFhaEo4eHdueEdJc2dYcEZhR1FDalpHTEhWcHpjWktMTGVn?=
 =?utf-8?B?SmtjYUhubnU3UU85Wk1yWXpPOW9YdUxNQ2hqWTIvVDh4N2VLbktsS09JRnBo?=
 =?utf-8?B?QnBFa3VobEg3cXNweTFiaEExeCtqUWdEOWFBZjYyK0pPQzVBT2E4YS9zVUFM?=
 =?utf-8?B?WHZPU1M4UGFzTUVyZU1lSit5bEpIanVtTGV0YnFJcDBBdGZGdGRxcWVyODg4?=
 =?utf-8?B?c0Y1VXQ3U2xaMitvRlgxbXNxb0VodnJTVzd0bG1JRzNzdVNMMjRVLzJGNXpt?=
 =?utf-8?B?Y3ZnSndETXg4VFFTM2M5ZVc2a01oWnlVWTZnaW9abkY4bVVBMmtUMWU0RFpu?=
 =?utf-8?B?eWptc1pleGJCc0NiM0NRUjV0bi9lQWpOUFRkZTdTOEFqOFUzQlI3SHhNMG1v?=
 =?utf-8?B?MWpzakl0RzhGMzRmcFhWcnprOEVrNmx2Rm9ZREFOVjY3aU5rV1MwdndPRFFM?=
 =?utf-8?B?bUVnSDFBMXYxOStwYkFYSmJlaUF3cmc3S01hZjczSFFZeE85ZDNwWjBwblp2?=
 =?utf-8?B?VHFQRE02U3g3aHBZb29zbFUwck4vaC8xMkluVlI2NktPK2NGZ3Y1d0hGbVVS?=
 =?utf-8?B?by95YXV6aXYzN1BpYnU3K1hidzFEVnJIZjhuT3FvSGE5L0hVV3RtY0xJVlFV?=
 =?utf-8?B?dVNMS3ZtSzVyUmt2czdwTE9oQUN4U1h6emkrTk1NWkNFVWtrdlNkVXE5b1BB?=
 =?utf-8?B?NDVjNUdoUjRhVldNejVhL1czNmpha1hEbFVWNWdRdE1GSm5UcFFkVWNlSWRz?=
 =?utf-8?B?V2pqcHVYQ29iN3VKb05qOWZpNXo5SFF4V3o3Tjcyb1dpT05wREtQUnY5TC8z?=
 =?utf-8?B?K0RZLzEzME9pbldDUTFzemNPUHFwU2NXMVVLa3VHamZTRllCY2hrWG43OHRz?=
 =?utf-8?B?Q1hqaUhUYUgwYXBMVkVPTWFBanU4VHlvdG5MZHNkdno1M3pzSTRhNU1EN25N?=
 =?utf-8?B?N01RZ1MxM1FFTW9OV1NrYkxMdFdsODR6dUxPUEhuSFoxVnl5a0lmSTIzdGRV?=
 =?utf-8?B?TXVsWmVxRWtDN0pjcTdUK2l2Y0Y1R2dpak84b0RXdHYxL3lTTzROVTNWYmp2?=
 =?utf-8?B?NXNrcVo1bUFRcmZUVGZSNTNvb2dKZHZRL2JodGFaSjFCRkh2TkdSL2pxZjRW?=
 =?utf-8?B?R21xWTRmMEZjcHNpYTRWRHh3MkxSRFpPbmZvcDJ0ajR1RmRzUCtXT2tCNTBG?=
 =?utf-8?B?bTJDWExlQkVMbndZKzJmT2RGMG00dUhtc0dGd0RObWptRnZMNHh3NkZZeEJH?=
 =?utf-8?B?aWRyMWlJWTN2UHd3OVVtTCszbkdCWmhJaHhCWThNOWhEV1VzNXk3YVRIODZr?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N0J6bGkwS2ZiSE9ndVpUd0FRVUcxL2tpQUpabE9qWjRRT3psVDh5Z0oxYU94?=
 =?utf-8?B?VDljMWJ4bzVkVUp4eU9ycFBZeXdzMEtEWm1OY245ZUNMQnF2RHRPT2hVd0Nv?=
 =?utf-8?B?Qys1UHJrT0dUREpKM2oxeUpOelpaNmtwTGt0VlhxV0hXUkRlckE1b1pPZnAx?=
 =?utf-8?B?bDdTYjlZdy9vMTVZUjRnRzJJeUxma1NxZTEyVlRZT2RJdGhJZGY0d1owRU5E?=
 =?utf-8?B?c2FSR3J6N2dBcm1JUk5FbzJOUW9laU1kZTBiREM0QkIxRkdGSkF4REN2c1hH?=
 =?utf-8?B?aUdmalpKMENaelEwSjNWbW1NRjZ6ZFM1V1ZpbnZRL2JYRndhWWxsd1N1RENj?=
 =?utf-8?B?LzQvWHB2THJJQzEwSzlaaW1CTURPMVRLSWwzb1MwNUF0SmhOenZMNnMzQmgx?=
 =?utf-8?B?QldoNlA5N0pOMmNsQk93RnhVNzRaWkMvMnRIMmRiYkpFQitjMndHUDJuQTd0?=
 =?utf-8?B?VFNOVVJMcC96Z0p1WlE4WlhhMXZwMUNzQzAxeFZDdFFvOFR2TzEwWHU4NlNy?=
 =?utf-8?B?dXBkeUU2bElhSjNuR0w5WDhTazVjSlpEVUxCMCs3aUxXUjZQSXgzMXlOdGkz?=
 =?utf-8?B?V2I3YWNVWmE3TXp0NnpaYVhRb2tGSG4walNzeFN4bjM3UDJNa3VpQlFXamFk?=
 =?utf-8?B?UzdnTXg2MVo4YkYyc1E0bTNHY0RiUkMrNGgwem1DcWEyQ3I0aDBBOTFweVJW?=
 =?utf-8?B?N0dKaWdSb2N6S1hrSUJMWC9ONjdLek1nUHc0WVVaZ0FZcmZxNTZxTnlBQUJN?=
 =?utf-8?B?OUErQllIMGpvdUc2RFRGZXNIcjIvcUlidkhFU2l0QWNISDNrdUxUd0xURXNx?=
 =?utf-8?B?UWJMaWFKcXd6VGQvZTJDVHNBcVdoQW9DY3FhdFRPQXNZREgxZWVHNWg4ZWsr?=
 =?utf-8?B?aUEvblIyUXJEVzhTeGpHcDh2dzVuQU5mN3dkeHRmSWpvb085L2tQMm8xS09H?=
 =?utf-8?B?a2ZkalY5R3d5TnhjTEkxWS93NVdja3hpbWdHSHRZWGlWQWVIbjhrYk9KSEkw?=
 =?utf-8?B?QmtZL1FTYnBqaDAvQjZ3YjVNTHhXdVJIL1I0dVYyTVVCd1FwSzNDQVV0T29o?=
 =?utf-8?B?WUpYZkxHOEJMb3ZYZWF2TGRZMVAxcW9KM1RYbW1IQ1JBWVo3WTBaa1ZReWpk?=
 =?utf-8?B?cWc5ME5pNU5FNWp4QjdqTHdlVjFUMFRyWFpHNXdyb0Z6VllJTGRldytGaDlZ?=
 =?utf-8?B?eWxDNUo5N295ZWJwZWxhSFFSWEVmaDRGMFo0MVFDUjNHZjlXa2lTdGVqNTAx?=
 =?utf-8?B?UHBRb1kzOCszZWp3aXBpVUxWeURsVzUvQ2xCNWphVW9xNm1iejcxdkpYeWRD?=
 =?utf-8?Q?nsmKzgloUNvj73GMxAIeS/zX5THmNVQpBy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41cea25-7fab-4e7d-6bf5-08db9349c00d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 11:15:17.0626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJlKPXph2OWNy3ndTZI7W2oA/76JLadeZdLXMJXhb1TpAaSMDy91YVYAhfqB3ri9Yb8uOXia3DCS450zn9sLmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_06,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020100
X-Proofpoint-GUID: 7eYbEBVwjkE4H_8BM_qZgn7fhZkAsyjq
X-Proofpoint-ORIG-GUID: 7eYbEBVwjkE4H_8BM_qZgn7fhZkAsyjq
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2023 18:39, Ian Rogers wrote:
>>> I didn't write this behavior, it has pre-existed my contributions. I'm
>>> hoping to change the perf list behavior as we're seeing large server
>>> systems with getting on toward 100 PMUs, the events are replicated for
>>> each one and the perf list and testing behaviors are somewhat
>>> exploding in size.
>> Sure, that is why I was advised PMU kernel drivers event names to be
>> unique per PMU, so that we can add an event alias in a JSON and then
>> kernel events are matched and removed from perf list.
>>
>> I suppose that your changes are an alternative to the problem of
>> mushrooming kernel event list.
> Thanks John, yep this is going after that problem. Could I get a
> reviewed/acked/tested-by for these changes?

I'll try to help.

So we have:

Before:
```
$ perf list
...
   uncore_imc_free_running_0/data_read/               [Kernel PMU event]
   uncore_imc_free_running_0/data_total/              [Kernel PMU event]
   uncore_imc_free_running_0/data_write/              [Kernel PMU event]
   uncore_imc_free_running_1/data_read/               [Kernel PMU event]
   uncore_imc_free_running_1/data_total/              [Kernel PMU event]
   uncore_imc_free_running_1/data_write/              [Kernel PMU event]
```

After:
```
$ perf list
...
   uncore_imc_free_running/data_read/                 [Kernel PMU event]
   uncore_imc_free_running/data_total/                [Kernel PMU event]
   uncore_imc_free_running/data_write/                [Kernel PMU event]
```
How about keep listing uncore_imc_free_running_0 and the rest for perf 
list -v? Or something like that.

I find that the perf tool has lots of veiled tricks in terms of usage 
and describing events available and how to use them.

Thanks,
John
