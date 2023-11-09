Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9F37E725D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjKITcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjKITcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:32:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E345D3ABC;
        Thu,  9 Nov 2023 11:32:20 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9IJh8N019160;
        Thu, 9 Nov 2023 19:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=0Z8zx64XbM6dgl8hdf+pT67lPPH/RbQ0p7r7U0/66zQ=;
 b=dtGiOvAC7PrqGUi6Xuc4NdD59y8WEFN4ovGLUgPjLqMMcOrAyWjjy5hs95iJFvkNfGtB
 qvo7AIGqfcPTQYC7TXIWVKLWq/qZF5Qse+kytQe2lvQtt4KMXeORCiT2erhRK9jxDL/Y
 BI48sZcZA6T280PJJ9bHJtB+phz4dNDJB5FUm625Io+juPdGcBIKkz8j0u3du2qks2VY
 uFETrvrBwu13CqQtXv2+qCUEB2lG0Jfu7WmIuPFYTpUjuS4yxIWLlMsQAuus75lrfPRk
 1+xxrcElFl+r0sZWW2RMHroafPfbPTNARQ9v7zHQNldTGSD9gdGAkKK5zR3IsLA0Hq3k UA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w234tq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Nov 2023 19:32:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9IDN7h017619;
        Thu, 9 Nov 2023 19:32:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u8c00uywj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Nov 2023 19:32:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hqv2MyKCTmMR3WQezGXONJ8GTiRjNkGCb46Cr5akK1V9R2LpkL9Hb0k328SMkD9HyEkRqHabADM4S1Yw2d0ryhruYPdTzWF7kTdBm4e3jX1S0E7BkdBu3k9M25zdmeihHttA+7MMfh3PHmz8JxYsfotrWenipF5dw81PqkTj9k44JpiUVVu0o28VD3y/AnjdK/ZZlBeb3U1etUH8Q12tiNqjAgrNR0C4f5mquQE+rOiU6ZGA2+2qX9tdUkQ0byTihPjIal4x45w0/kdXuGsy2M4s/lQ/AdQm1atWPCjwibEZSOfCu5CBGbqPLbjTT6MwekD3TbtaTQF556M8SPyhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Z8zx64XbM6dgl8hdf+pT67lPPH/RbQ0p7r7U0/66zQ=;
 b=lMpktZqUHEvBLj93kGKT9j6Y6BbXAxPOlo4zQzdJFoHfCmJt8Y4NMBx6q9Wsyj2G/40xXb+15Zxz5LGC5JfpniSJuHSHXKNTLk211K59VGxm2sPwIQH+nw++iBxuidkj/cHpR3iXijvzpQdRQjWAxQT0P1gtmVi/+u2ONndKWfQ6Es8qBvNxbbYsdVmUBQPYXL2/icZWNMtMAFAZO9hVnl22C1OqgUJxNrARXCHqs84RyqJ2mPQvteHRQCNixl3rmGcdWCB4mHYubyfZ7S3jDpzDWOFQpwt5FSjMcPwoSClsYjj7zzr2wR5fuNPj/iwIVTDc6z93gJCihCFGadx5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Z8zx64XbM6dgl8hdf+pT67lPPH/RbQ0p7r7U0/66zQ=;
 b=tKduHLQpMKtLC8spWQi/2VATptsUXrF9XksUZaQ6FVZ1ipt5uvJaYpiZxcurDdY17+jD59EmwEwucKJrDsJh8NXHrsfu1qGUxBtJr1CqAlfrFfJXYksS6FHi5Rio7TXqN5jjOD0mp8EnhmzTSvJnU4yOaZrVToKcGkHnZjV1X48=
Received: from MWHPR1001MB2158.namprd10.prod.outlook.com
 (2603:10b6:301:2d::17) by CH3PR10MB7930.namprd10.prod.outlook.com
 (2603:10b6:610:1c5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 19:32:02 +0000
Received: from MWHPR1001MB2158.namprd10.prod.outlook.com
 ([fe80::8074:2335:1a61:6fc0]) by MWHPR1001MB2158.namprd10.prod.outlook.com
 ([fe80::8074:2335:1a61:6fc0%3]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 19:32:02 +0000
Message-ID: <24e46e1c-e9fa-4d44-97f2-068bda6e54b4@oracle.com>
Date:   Thu, 9 Nov 2023 11:31:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 09/10] unwind: Introduce SFrame user space unwinding
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org
References: <cover.1699487758.git.jpoimboe@kernel.org>
 <09460e60dd1c2f8ea1abb8d9188195db699ce76f.1699487758.git.jpoimboe@kernel.org>
From:   Indu Bhagat <indu.bhagat@oracle.com>
In-Reply-To: <09460e60dd1c2f8ea1abb8d9188195db699ce76f.1699487758.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0254.namprd04.prod.outlook.com
 (2603:10b6:303:88::19) To MWHPR1001MB2158.namprd10.prod.outlook.com
 (2603:10b6:301:2d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2158:EE_|CH3PR10MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a3ee2e5-3396-4147-6c73-08dbe15a8c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/a3Eq36uNk2a3+jzWj+IP4tFaHltA1hahvw6b2oQJsdRGxGrSGlOPhqWU3z1TCGTCbfHN3N2K++A7tnt5bOLI4ApsD+MpYcs/kfMdolbxjFvdiCexJ4MYoDjN1RfbGm8R2XRsDMTAm6Va93j8+UnhNxI9vuhkfdZktvBMAdhh89SKNxV+o4Q+WlUV4rbu4ci7/PDcW9YhS5Jyj7jwoOsAIhYcQyrix/nP/+V6x2dg4bl1iUwUiFNzNN0f0MtJUvslFxU1vCYwye0SseMWZBqW10l3em2XgYrffZM7vy+JboJ0e5/KV1EMJmUQ06dJvkBYl0Ao8J+RVrA5JEKC6A44i6OLe3XYsHQbReYyAZ20UcIh58OwbTIBJbUkl0v1S4MypgFWBRFCRbUWrGnkKKVa20L1N/hQjUqNeDQa5KTpfFzhH3cMoaOVU5mKru963bSai5PXkshHG7vKX7uDwARcP8kpaqXqlm+2PC+Y2TNfbs5giYM0+2oEIuCmDOBOXKLAe4ITUgjM7WCpdynrSxGuIZEyi3thn/uUn/SpUOdobaTR9DR9AlhLw1Tr0+9Si0O9WasJeSYoz9OnXFMQZ6jnZLjxsPTUoxaTRZ+Dj82xYA5Gw8+eLP0+mULZ6vMk8I9uITEF2hTZT3knNHFfYSj3LOvmT647BxV/IwyZxUs2DZh/EkKP9rqOj7/Htcbte9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2158.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(41300700001)(66476007)(31686004)(66899024)(478600001)(6486002)(6666004)(54906003)(966005)(83380400001)(36756003)(31696002)(86362001)(38100700002)(6512007)(2616005)(66946007)(66556008)(110136005)(2906002)(316002)(6506007)(7416002)(5660300002)(44832011)(4326008)(8936002)(53546011)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STM1NGtnb0NDVzQ0dkJQTWVic04ySTR3YjRwR0V5eFJRdXpoWXFwdUVTRDJT?=
 =?utf-8?B?TVlUMm1UbEFROTkvaVhiQ0hZLzdvYXk1YjNVQ3I0K1Z4bjhib2FkY3FBNHhi?=
 =?utf-8?B?K0NqcUhuWU9WNEdZczZSMWo1cktGOXlaeENNblAyb2h0YjAxejU5eWQxaEhK?=
 =?utf-8?B?MHprQlNQdkdSMmtTYzljUDNQbk10blRTUENRM0tRNFp2QXJTUkhTdUlCdFFy?=
 =?utf-8?B?dEtXci9FK1o0MERSb3JuVkoyRE45MWJVR0svNWpwUGt6RTBEdkVOOC9ZMU5U?=
 =?utf-8?B?czI3WVIyVHJEM1NsSDYycThjVVVnUWo4Z1ZZdElIQlpIVGxENzBRQjJmZEd0?=
 =?utf-8?B?ck16bjVqNWE5L0wzeWQ4Tk5BTXg4TXBZUmJaaHNleW1vV2dLRnVZSEllVDQ3?=
 =?utf-8?B?NnIycTg2MEtMTGF0QXVueHpFSVVqa09zN1VlK2ZLaDhxUExaeFZKOUlTeUlu?=
 =?utf-8?B?ZlJPWTFmLzQ5d0c4WEZ2b1BTbFZJSHZFblJ3MmxvWVJKaTFYcXpxZ0FIbnVR?=
 =?utf-8?B?anZ6UnZIZ3hZWUJ1Z2Z3NGJKbmE2WVkyTzViMjVyam9ZMjUrRGNYQ1pVdGlC?=
 =?utf-8?B?cGRZYlBBaVJsamthb3ZNdCtFTElHYVhad3dNbmdaUDBEand6bXVWY0pRSUFT?=
 =?utf-8?B?d1cxeURMWTZYS2I3WFEwZCtGdXFERVlRempHZUd6R1VCZC9sQzNXMFFDb0ZB?=
 =?utf-8?B?NFJBMVFoNytPSWFTOWpscXkxSWdlU0w3Y2t5RXdWRlh4T0FkZXlGdmJNQ2VM?=
 =?utf-8?B?OWM4NEwrdG1ZcVluZkxXL2N5UkMvU0NaMFZOU0tBQWZJSnpweDRPazJSUTlp?=
 =?utf-8?B?RTJtMXVxTkdienhXaEVseVBvcnlpQlVMdG80R3ZtMkpnQVJjUW16ZGVrTmc4?=
 =?utf-8?B?d2JNQVIwRi9GWkozR1Q0NnI3alRvWWNjUDcrdTJIa3FMY2hYVFBBVFlYMzVM?=
 =?utf-8?B?WHRRd3pKdEZ6TG9reFAwVndGTCtHSUxRSzI2OVltcllIYW9ERnp3M3ZUUHVL?=
 =?utf-8?B?S3JQU01xM1N5VnN6clJDVU5hSVdqYW9UbndFeWZEWXNjM0hHY0ppTU5WK2JK?=
 =?utf-8?B?WTIrU1FKN1VnRkw0OUVnRWJDNU80N1BsTlFmeHZaQ1FuMzR4cWE3KzlseTVS?=
 =?utf-8?B?VWhMTWxTZ1NmQjBCMFpnS0JYaUVVMUY0dUE1V3IwWW5QTjNhZ0Vrczc4Qk1V?=
 =?utf-8?B?UnNybFZMdXBKaGVCNUpWUk9QWE5XdWlhZzBualNDakc1ZmdwUnBMVkJXZUpt?=
 =?utf-8?B?TEUyMStJaHViNlhDTGxHUW9WbzNuVUlqZnFpYTF4Qll0OU1SWGpGYmhFR3RU?=
 =?utf-8?B?S2lhcllIdTUzR3RBdTFPL1NVTEJ3UXJqVDc4aTRkWXJVcWRLMGUzY1IwRWtW?=
 =?utf-8?B?OTJWQWpHKzN2Nlo5bzI3aER4WHhUTDdBRVpRZHE2OHV3TWdXemtIT01wWGJ0?=
 =?utf-8?B?MktaU3JGR2lscmJRdXFvaS9XT0hpTDRrQTVGRjVyNEplSWlLd1dxSzYzdTJT?=
 =?utf-8?B?bnlSODlWLzBiSlBUUUdHNGMzOGZZdmNCMnZOOXlzTzdPWG5Scy9jZXNzWUI3?=
 =?utf-8?B?UEdDNFB2bk15bDBwWGRKZXZYTmZ6dXB3anVQaUoyck9mcDFEKzN5MzMwSmp2?=
 =?utf-8?B?WXpETElTYUw4RUcvazNISFdoWm50Q0xiMkx1Z1NIVkVwck1aeEdsRUxmdjhZ?=
 =?utf-8?B?djdQaXdyL1lRbCtPUEpDVHhzbllXVzU3Ly9NNHg4ZGs0RmhVaGpBZEtqU3lk?=
 =?utf-8?B?MWxtTEhXSkhFdmtaNC9RQVkyWkVMKzVVTkFYem1tS2FHNnI4RHVFa1MxOCtF?=
 =?utf-8?B?dFk0MWRlNncwaitNLzg4R3ZuNWV0RG1PVStVak1ZU3pRMUlrQzgySXJrYllD?=
 =?utf-8?B?azJDR296ZWh3dCtEeDd6ZDdtdnQ0UWc5ZlM0OEFJak9lTGFPYytaK3FxQXVo?=
 =?utf-8?B?SytYM3VJajhQeWpWQzg2aTNMTHJrM05nTERLa05XQUZOVG0xZHNROU5ENVk2?=
 =?utf-8?B?ckRsbE5hejhiUVRqYjFUZXphNEJjN1diV1ZablFVYWFDQjY0T3lqU1FlUHBx?=
 =?utf-8?B?WWt0VnYvd1B5N3VRS25DQWtycGJmSXdRWVZSUFY4VW1DSjdQNHkxeGZVS2c3?=
 =?utf-8?B?aVJqaitlQnNxQkFER0hlMGxpaFFLQVFSZFRybWlvQVgrUytjNXhPYjltQUZH?=
 =?utf-8?Q?mycErCe/az5wggwJES8K81M=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cnV6MjNPYkpxVWNUYXRPVFF4NXpVM0w4WUloVktUbWZwRkJwdzNYTjFNcFlo?=
 =?utf-8?B?bVByYlN5S3ZKZEVIQ2tvUk16azRJK1N0Vis4aVZSSkpiN1hjS3gyRThXNU9z?=
 =?utf-8?B?bnFxaFhtM3NBbWlUTUZnbXJDcklHQlAxNkw5cnplY1Y1V1FvMmdmSlM2azhJ?=
 =?utf-8?B?VUJUZ1ZNdTdZbnZOSTFlMkY3WWVNbUdsZnJ2OUtGYkxIbVNWU24rZWJtaDhF?=
 =?utf-8?B?VnpKMDVLNXQvOUEwbmRsdFVOWHFZZUNla0s4VWhXTUI5SFFxV0xzeWN2ZUI1?=
 =?utf-8?B?RTdWVXF5aGpKVTZVS054TE80RVlpVFlhZUdiaVltOVVFK0VyN1M1VWd4WE4y?=
 =?utf-8?B?ZGNXVGhXNGdwb3E4WkJOVDBSaFg0MTVWUG9NMmQwMDRvWklZeWRESThxdTJo?=
 =?utf-8?B?NHVyM21qZGIrOVVrVGRMSkM4TnZXRmkyTlVJQk9zNyt6bkxZNFVJb3FNU2g0?=
 =?utf-8?B?QU9mdjAraUpqcncyQjNFNytTUmlseXZabllmT3BtMzE5NEptRmhTQThBWldE?=
 =?utf-8?B?VGRQeFZnNWo4TVFKSnhybERsSU5uNWxvOTYrNGl0ckNhVDE1eldKN2NwYUZ2?=
 =?utf-8?B?MWVVcE0xR01sZytqMkpJTDBQbU1kYm05Tk1GYm1DTDcyK2E0cjlHVXVzKzBZ?=
 =?utf-8?B?ZWZTZ1BnNjdTTFJYa2NhcVpkNVVvRWdwRjdkME94cHNHZzRRTjZqV1Q0MkFk?=
 =?utf-8?B?MW01UVFUK1VHeHk4N1NtY0xkYldwRVVRSTVxWC9DcTF6S25RYXEwbzFLamxL?=
 =?utf-8?B?Qy9YZTZlOEtGNVBWMlF4a2UrOEY1KzUvZDVwemtRd1hnRGpnQ1VaYXR0ZlJq?=
 =?utf-8?B?MzkyTnpIQjlCWk9uUVBoVUhTNGtPek1KODNGQ0lZOGdmUDNQbVcvZURjN0xG?=
 =?utf-8?B?T1pxWTdPMExSakxINjdUL2xnME5XZm4wR1UremtXc2UxZTdFQTJob0N4T0dC?=
 =?utf-8?B?MW9iSFpDNENFSDZwbjJVTFEzc0d1ai9iN0FFNk04L21PT05RMHdseVJNWVl5?=
 =?utf-8?B?Z1pnOEFybmRVcGJTOGRrQSsvNk1aT0kyaCt4dER2ZjZVYUc4WHR4NTIybW4r?=
 =?utf-8?B?M0NuWjN1MTFmWWt3NGJaYW11TWJLV0dndVUxaWpQQlVMbCtzU3NSTHpTTFd6?=
 =?utf-8?B?cGFaU1d0cm9jeWRRME1SeDh5UmNwWEVwODdWNG90Qmp4TTI2dkZUckdkem1y?=
 =?utf-8?B?Vm5CdmphOVRocGU2Y29oaWtFY3JjQUdHaUJGZ3F5Mk1CanRITS96ZmVxYVcr?=
 =?utf-8?B?WWk5MXF6Wk8wNW9SSWhIZmdQbzBXRjZldHdpeWxiNyt3cnB5SEpVVVo2Y1pH?=
 =?utf-8?Q?PL/QbN3NeV03s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3ee2e5-3396-4147-6c73-08dbe15a8c2b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2158.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 19:32:01.9444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17yjDFmCEMT/cM65+ejbsBl37aQ+DU4DvH9Ha+59+1v+XDciIUlWE1eqzg+Q0udpbhD41J2AK9Fzz8CuVM3Xyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090140
X-Proofpoint-GUID: u0sNOw7VLL6yprvsbH6a60n7PnYVE4HA
X-Proofpoint-ORIG-GUID: u0sNOw7VLL6yprvsbH6a60n7PnYVE4HA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 16:41, Josh Poimboeuf wrote:
> Some distros have started compiling frame pointers into all their
> packages to enable the kernel to do system-wide profiling of user space.
> Unfortunately that creates a runtime performance penalty across the
> entire system.  Using DWARF instead isn't feasible due to complexity and
> slowness.
> 
> For in-kernel unwinding we solved this problem with the creation of the
> ORC unwinder for x86_64.  Similarly, for user space the GNU assembler
> has created the SFrame format starting with binutils 2.40.  SFrame is a
> simpler version of .eh_frame which gets placed in the .sframe section.
> 
> Add support for unwinding user space using SFrame.
> 
> More information about SFrame can be found here:
> 
>    - https://lwn.net/Articles/932209/
>    - https://lwn.net/Articles/940686/
>    - https://sourceware.org/binutils/docs/sframe-spec.html
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   arch/Kconfig                |   3 +
>   arch/x86/include/asm/mmu.h  |   2 +-
>   fs/binfmt_elf.c             |  46 +++-
>   include/linux/mm_types.h    |   3 +
>   include/linux/sframe.h      |  46 ++++
>   include/linux/user_unwind.h |   1 +
>   include/uapi/linux/elf.h    |   1 +
>   include/uapi/linux/prctl.h  |   3 +
>   kernel/fork.c               |  10 +
>   kernel/sys.c                |  11 +
>   kernel/unwind/Makefile      |   1 +
>   kernel/unwind/sframe.c      | 414 ++++++++++++++++++++++++++++++++++++
>   kernel/unwind/sframe.h      | 217 +++++++++++++++++++
>   kernel/unwind/user.c        |  15 +-
>   mm/init-mm.c                |   2 +
>   15 files changed, 768 insertions(+), 7 deletions(-)
>   create mode 100644 include/linux/sframe.h
>   create mode 100644 kernel/unwind/sframe.c
>   create mode 100644 kernel/unwind/sframe.h
> 

Thanks for working on this.

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> new file mode 100644
> index 000000000000..b167c19497e5
> --- /dev/null
> +++ b/kernel/unwind/sframe.c
> @@ -0,0 +1,414 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/srcu.h>
> +#include <linux/uaccess.h>
> +#include <linux/mm.h>
> +#include <linux/sframe.h>
> +#include <linux/user_unwind.h>
> +
> +#include "sframe.h"
> +
> +#define SFRAME_FILENAME_LEN 32
> +
> +struct sframe_section {
> +	struct rcu_head rcu;
> +
> +	unsigned long sframe_addr;
> +	unsigned long text_addr;
> +
> +	unsigned long fdes_addr;
> +	unsigned long fres_addr;
> +	unsigned int  fdes_num;
> +	signed char ra_off, fp_off;
> +};
> +
> +DEFINE_STATIC_SRCU(sframe_srcu);
> +
> +#define __SFRAME_GET_USER(out, user_ptr, type)				\
> +({									\
> +	type __tmp;							\
> +	if (get_user(__tmp, (type *)user_ptr))				\
> +		return -EFAULT;						\
> +	user_ptr += sizeof(__tmp);					\
> +	out = __tmp;							\
> +})
> +
> +#define SFRAME_GET_USER_SIGNED(out, user_ptr, size)			\
> +({									\
> +	switch (size) {							\
> +	case 1:								\
> +		__SFRAME_GET_USER(out, user_ptr, s8);			\
> +		break;							\
> +	case 2:								\
> +		__SFRAME_GET_USER(out, user_ptr, s16);			\
> +		break;							\
> +	case 4:								\
> +		__SFRAME_GET_USER(out, user_ptr, s32);			\
> +		break;							\
> +	default:							\
> +		return -EINVAL;						\
> +	}								\
> +})
> +
> +#define SFRAME_GET_USER_UNSIGNED(out, user_ptr, size)			\
> +({									\
> +	switch (size) {							\
> +	case 1:								\
> +		__SFRAME_GET_USER(out, user_ptr, u8);			\
> +		break;							\
> +	case 2:								\
> +		__SFRAME_GET_USER(out, user_ptr, u16);			\
> +		break;							\
> +	case 4:								\
> +		__SFRAME_GET_USER(out, user_ptr, u32);			\
> +		break;							\
> +	default:							\
> +		return -EINVAL;						\
> +	}								\
> +})
> +
> +static unsigned char fre_type_to_size(unsigned char fre_type)
> +{
> +	if (fre_type > 2)
> +		return 0;
> +	return 1 << fre_type;
> +}
> +
> +static unsigned char offset_size_enum_to_size(unsigned char off_size)
> +{
> +	if (off_size > 2)
> +		return 0;
> +	return 1 << off_size;
> +}
> +
> +static int find_fde(struct sframe_section *sec, unsigned long ip,
> +		    struct sframe_fde *fde)
> +{
> +	s32 func_off, ip_off;
> +	struct sframe_fde __user *first, *last, *mid, *found;
> +
> +	ip_off = ip - sec->sframe_addr;
> +
> +	first = (void *)sec->fdes_addr;
> +	last = first + sec->fdes_num;
> +	while (first <= last) {
> +		mid = first + ((last - first) / 2);
> +		if (get_user(func_off, (s32 *)mid))
> +			return -EFAULT;
> +		if (ip_off >= func_off) {
> +			found = mid;
> +			first = mid + 1;
> +		} else
> +			last = mid - 1;
> +	}
> +
> +	if (!found)
> +		return -EINVAL;
> +
> +	if (copy_from_user(fde, found, sizeof(*fde)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int find_fre(struct sframe_section *sec, struct sframe_fde *fde,
> +		    unsigned long ip, struct user_unwind_frame *frame)
> +{
> +	unsigned char fde_type = SFRAME_FUNC_FDE_TYPE(fde->info);
> +	unsigned char fre_type = SFRAME_FUNC_FRE_TYPE(fde->info);
> +	s32 fre_ip_off, cfa_off, ra_off, fp_off, ip_off;
> +	unsigned char offset_count, offset_size;
> +	unsigned char addr_size;
> +	void __user *f, *last_f;
> +	u8 fre_info;
> +	int i;
> +
> +	addr_size = fre_type_to_size(fre_type);
> +	if (!addr_size)
> +		return -EINVAL;
> +
> +	ip_off = ip - sec->sframe_addr - fde->start_addr;
> +
> +	f = (void *)sec->fres_addr + fde->fres_off;
> +
> +	for (i = 0; i < fde->fres_num; i++) {
> +
> +		SFRAME_GET_USER_UNSIGNED(fre_ip_off, f, addr_size);
> +
> +		if (fde_type == SFRAME_FDE_TYPE_PCINC) {
> +			if (fre_ip_off > ip_off)
> +				break;
> +		} else {
> +			/* SFRAME_FDE_TYPE_PCMASK */
> +#if 0 /* sframe v2 */
> +			if (ip_off % fde->rep_size < fre_ip_off)
> +				break;
> +#endif
> +		}
> +
> +		SFRAME_GET_USER_UNSIGNED(fre_info, f, 1);
> +
> +		offset_count = SFRAME_FRE_OFFSET_COUNT(fre_info);
> +		offset_size  = offset_size_enum_to_size(SFRAME_FRE_OFFSET_SIZE(fre_info));
> +
> +		if (!offset_count || !offset_size)
> +			return -EINVAL;
> +
> +		last_f = f;
> +		f += offset_count * offset_size;
> +	}
> +
> +	if (!last_f)
> +		return -EINVAL;
> +
> +	f = last_f;
> +
> +	SFRAME_GET_USER_UNSIGNED(cfa_off, f, offset_size);
> +	offset_count--;
> +
> +	ra_off = sec->ra_off;
> +	if (!ra_off) {
> +		if (!offset_count--)
> +			return -EINVAL;
> +		SFRAME_GET_USER_SIGNED(ra_off, f, offset_size);
> +	}
> +
> +	fp_off = sec->fp_off;
> +	if (!fp_off && offset_count) {
> +		offset_count--;
> +		SFRAME_GET_USER_SIGNED(fp_off, f, offset_size);
> +	}
> +
> +	if (offset_count)
> +		return -EINVAL;
> +
> +	frame->cfa_off = cfa_off;
> +	frame->ra_off = ra_off;
> +	frame->fp_off = fp_off;
> +	frame->use_fp = SFRAME_FRE_CFA_BASE_REG_ID(fre_info) == SFRAME_BASE_REG_FP;
> +
> +	return 0;
> +}
> +
> +int sframe_find(unsigned long ip, struct user_unwind_frame *frame)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct sframe_section *sec;
> +	struct sframe_fde fde;
> +	int srcu_idx;
> +	int ret = -EINVAL;
> +
> +	srcu_idx = srcu_read_lock(&sframe_srcu);
> +
> +	sec = mtree_load(&mm->sframe_mt, ip);
> +	if (!sec) {
> +		srcu_read_unlock(&sframe_srcu, srcu_idx);
> +		return -EINVAL;
> +	}
> +
> +
> +	ret = find_fde(sec, ip, &fde);
> +	if (ret)
> +		goto err_unlock;
> +
> +	ret = find_fre(sec, &fde, ip, frame);
> +	if (ret)
> +		goto err_unlock;
> +
> +	srcu_read_unlock(&sframe_srcu, srcu_idx);
> +	return 0;
> +
> +err_unlock:
> +	srcu_read_unlock(&sframe_srcu, srcu_idx);
> +	return ret;
> +}
> +
> +static int get_sframe_file(unsigned long sframe_addr, struct sframe_file *file)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *sframe_vma, *text_vma, *vma;
> +	VMA_ITERATOR(vmi, mm, 0);
> +
> +	mmap_read_lock(mm);
> +
> +	sframe_vma = vma_lookup(mm, sframe_addr);
> +	if (!sframe_vma || !sframe_vma->vm_file)
> +		goto err_unlock;
> +
> +	text_vma = NULL;
> +
> +	for_each_vma(vmi, vma) {
> +		if (vma->vm_file != sframe_vma->vm_file)
> +			continue;
> +		if (vma->vm_flags & VM_EXEC) {
> +			if (text_vma) {
> +				/*
> +				 * Multiple EXEC segments in a single file
> +				 * aren't currently supported, is that a thing?
> +				 */
> +				WARN_ON_ONCE(1);
> +				goto err_unlock;
> +			}
> +			text_vma = vma;
> +		}
> +	}
> +
> +	file->sframe_addr	= sframe_addr;
> +	file->text_start	= text_vma->vm_start;
> +	file->text_end		= text_vma->vm_end;
> +
> +	mmap_read_unlock(mm);
> +	return 0;
> +
> +err_unlock:
> +	mmap_read_unlock(mm);
> +	return -EINVAL;
> +}
> +
> +static int validate_sframe_addrs(struct sframe_file *file)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *text_vma;
> +
> +	mmap_read_lock(mm);
> +
> +	if (!vma_lookup(mm, file->sframe_addr))
> +		goto err_unlock;
> +
> +	text_vma = vma_lookup(mm, file->text_start);
> +	if (!(text_vma->vm_flags & VM_EXEC))
> +		goto err_unlock;
> +
> +	if (vma_lookup(mm, file->text_end-1) != text_vma)
> +		goto err_unlock;
> +
> +	mmap_read_unlock(mm);
> +	return 0;
> +
> +err_unlock:
> +	mmap_read_unlock(mm);
> +	return -EINVAL;
> +}
> +
> +int __sframe_add_section(struct sframe_file *file)
> +{
> +	struct maple_tree *sframe_mt = &current->mm->sframe_mt;
> +	struct sframe_section *sec;
> +	struct sframe_header shdr;
> +	unsigned long header_end;
> +	int ret;
> +
> +	if (copy_from_user(&shdr, (void *)file->sframe_addr, sizeof(shdr)))
> +		return -EFAULT;
> +
> +	if (shdr.preamble.magic != SFRAME_MAGIC ||
> +	    shdr.preamble.version != SFRAME_VERSION_1 ||
> +	    (!shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
> +	    shdr.auxhdr_len || !shdr.num_fdes || !shdr.num_fres ||
> +	    shdr.fdes_off > shdr.fres_off) {
> +		return -EINVAL;
> +	}
> +

I would say that it will be ideal to start the support with 
SFRAME_VERSION_2 onwards, if we have a choice.

The structure SFrame FDE in SFRAME_VERSION_1 was unaligned on-disk.  We 
fixed that in SFRAME_VERSION_2 (Binutils 2.41) by adding some padding as 
you have already noted. For x86_64, its not an issue though, yes.

