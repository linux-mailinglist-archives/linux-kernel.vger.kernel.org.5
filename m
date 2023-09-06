Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F827932DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 02:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjIFAXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 20:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjIFAXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 20:23:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4259A1B4;
        Tue,  5 Sep 2023 17:23:47 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385Ndajc006841;
        Wed, 6 Sep 2023 00:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=BCrirMwRd0JDtQL+z+MM0O+dhCiDNw0M8Zv5KCBAHgI=;
 b=NzsF3r/B4qQn+HHeBqTNyJH7zJ8Jb1hg5+auyoDD93eA5++6CEFIZQ0IaBIbHjC+utml
 H0jOqY+xUZWxVENqJXA0kvPJKxm7YVblN7IrxiLY/NSDtZxOmoYT+MCiwCo+Co2wmrHK
 7S5DRVSij/t14T90Wk6MLY928fzmG6jwknJwHDVqxakzcSGa9bSABVHL1c+YdPbX1/HP
 VICUApTmMD4xY1Zhfj9pRqoygcdy3kh+F0NaAgN3BGHc67e/QNggiekULNayizA7NpOx
 fdTAWq+nCIs0fso0roMP3C70m43sVYa9XqTW5RP996tQ3P3ACUOKM3UwplvwzRBYHBe/ rA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxe6s01us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 00:23:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385NfPZs006577;
        Wed, 6 Sep 2023 00:23:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug5yu4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 00:23:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+nXrJqv6h8FpozVWqsnb/1guTNrzuNYrSlUE1O/ylejVenHfkzXRATmD3cKL9Pm8oinMji8P/P7hKlhgnPEPeIpoL37eYuBE3kmv8GeWKVQegJrT9t/NRkrwXskeXXFlZ4ys8rUyVsR7w6ve40WBzZeXb1hjUw5SB5xyOfuc7rxx+ThjU8L/0fNSepUMAFcZUujNWo3btlaoBMji4NUcWTwG3cTrw+0Zm7WVqnvm9qVRP0aTvShV6AzP6/16nyI0VJHF52YH6aSRbxCkRZ73ycjWJxvSB/80l6fzF3r/fApMiYe9YhbH7nbUZVsKs/IIQ794MXMAU+NqpDx/oLHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCrirMwRd0JDtQL+z+MM0O+dhCiDNw0M8Zv5KCBAHgI=;
 b=faEPXSxq/iC402k2mllBymframG/oNlVPtLKem1zSJ5jKGqtRVokHiJcujSSEoiq5C+ibMc8tqHfH/Eyl6oz9BOsSjXu2QwDU99NeUz2QG45uuaZb+5QH5P01VcN8AK/w6RZ0LJFaUOnEpo4ALZdGrGclDlYKVDVsmgSQCV4Y07umHf8xyoZHqw9hkQVj6071epxir/o4WMBCj506VDeIZQFOkfmxZIeQ0tFxiOrHyRxi0HcDzRo9cbp/Z7kxu+n6yWS+ZrPCwCTkCfCzBZ3iW1Mpns4LD/LTxWUkBNIx/vIh057c72CQpfsz74/HNi3D7rWh/vk4bHYM3VDQT4ANg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCrirMwRd0JDtQL+z+MM0O+dhCiDNw0M8Zv5KCBAHgI=;
 b=y7u3V0R104d9jOyG8Zcc6iL/q+TqRoDC1iz+dtJq7uzsVbdKZh9hbDUk2S+upf0S0gBN52T9jPiaXg1kFqcfOLMAIabF+FZB8Qv+06wSgOoKjDbrfOcwwQ9C+zwm+jPKQY2xJ4DxIBlEshu+tLuI++tRgR5DeSua+OWSjmR26DE=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by DS7PR10MB4877.namprd10.prod.outlook.com (2603:10b6:5:3a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 00:23:10 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2a3e:cf81:52db:a66a]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2a3e:cf81:52db:a66a%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 00:23:10 +0000
Message-ID: <b8350de1-6ac8-4d5f-aaa7-7b03e2f7aa93@oracle.com>
Date:   Tue, 5 Sep 2023 19:22:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/18] scsi: scsi_error: Introduce new error handle
 mechanism
Content-Language: en-US
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        louhongxiang@huawei.com, lixiaokeng@huawei.com
References: <20230901094127.2010873-1-haowenchao2@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230901094127.2010873-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0103.namprd07.prod.outlook.com
 (2603:10b6:5:330::35) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|DS7PR10MB4877:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbea299-0018-4a50-b6c2-08dbae6f7358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZM8D5yfm8tw0MqPHgQPxBcFoOpl60a4ZtTD5wxEUk7F+GnmWmcN+/pHT5uR2Md92GENIsQMFDjDHjeYHO5k+nu4QfmcmssxZvGMztTmKceHYXHHcbFvJR/a0SJj2Xpazf+rRVpqDgxDga1A8EEWjRMlZBZQtwPQrInvS91wxoEmtyGcIc3JR49EXpFwtmgaeHMSXbBMTCOxcOrPJyO//fy9r3vbF848hlXF9fLwyeV6VDL820VHDSwUp1J98bmEPq553W0hqzjO9CtojI74UMZSOQCvK6m/OxHYeEHgUhPnhAza2FR3Y8X8H9Ur630v6ofc9ZEvb+9L2i9H5kGc3Uixl3Xuodcll+9byEEqcQud5tDkAJpZsaTz+73f+FeP3n1fhay5UBHKK/L5qlVOfzLSihMjzXwdc0agPS52RiNJRvEHIxuodT/ydSgzfWEE1+lo27RE29iDqj/jyXSGyGFcL8ORMjJZHms57kga8jLjAgocIlCJOjn9xdKhhZe3SMt59BB+ACNEw3S+125FKzc5louTJpDvTEWiwFi0YCGQy2Egzsy8a3QMY15uOlOmfbXRfZuPIPBDK9MF3CKI2ow2UYAhKqTJQQdM+NYoUhwuYd3U4/IS7D0hFPIIaXa5988X1fawf4vuqGx0W1/tGbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(1800799009)(451199024)(186009)(6512007)(6506007)(6486002)(38100700002)(31696002)(53546011)(2616005)(6666004)(110136005)(86362001)(478600001)(83380400001)(26005)(66556008)(66476007)(5660300002)(8936002)(4326008)(8676002)(36756003)(316002)(66946007)(41300700001)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVRaRlVnbXFqWkV2dlBHaHVaMFZ6TnRkem1kdTgrdjVBdG5uc2ZlblFBa0pH?=
 =?utf-8?B?NW8zRDN5RkJObjdzWlJObkNhejQ0ekNzdldoaGczY3VMeXZyRCtuamtLelk1?=
 =?utf-8?B?bGpVVm9NOUpIZThvOVBCTW81RUFLem1URjdVU2FRZmZaR2FSMENxR1lBbTZn?=
 =?utf-8?B?OEZqQWVsUDVzR3EvVGpac09ud09MelhIKzhGaDNrVXFKUllvdVNWVEx6eWxL?=
 =?utf-8?B?V2lTSThGWHEyWFlsNkt5TGxiWXZXaGZkYVBKWHBKaTlhS1J5TUsxcXNQYTJn?=
 =?utf-8?B?REdIZUE4aXlkUy96STJnMUdYeFM1YjM4VDhJSk85Wm5WZVV1a0hvZ0g3WGZY?=
 =?utf-8?B?OTlzL0MybTY5dTU2WGtxclZUeVlzRDQzNGJsWmFIWkpmMWw1Lzd5UklocWR4?=
 =?utf-8?B?WGxVRkZGa1N5WnJ6Z1hxVUFpMXIzVFpaVDJOeGtpVm5iMmQ5dzhaaTlacDZy?=
 =?utf-8?B?d1owWDA0c21sNFdVanUxTFZzNTcvNjZaOWxnOWVQMlVOdVVMRzM0NCtUQVR0?=
 =?utf-8?B?ZlFyRFNOTVE4cmFua0VqNnVIb3cxc3NOSjErem5ySXduV3RnTWVrL0J2UE5Y?=
 =?utf-8?B?UmRVMXJRVjUwR3hHOVRWNWNQY083OHdVRlVtRnNxRktjVnFDcTdKa1A4L2xy?=
 =?utf-8?B?SVJFWGNMZnh3Z3BaL3hIUzRQeXM3MlFjdjVhR1pzNHNlSHJyZTJONTdzeHVR?=
 =?utf-8?B?NitpRmxtTjVHb0RKa0RvcjRnVllTZzU1S2NsL29EVVVMcWJyRWJzWjRKTlds?=
 =?utf-8?B?cUtOZVNzN21UeFd2b1hQaUJGcnNOSXJ2cENjaVdnRnFtSThSb0o5NnBYcnJQ?=
 =?utf-8?B?akJ6blUrN0xwbnpQajRHUUNWT0RaeUlsVU94b05nQzJvRnJDVkF3YW5vQ2Vz?=
 =?utf-8?B?RE9Lb1BnUmtxMWJFejc5OUpsdzhhb2pFNG5maWg4VEFReExWdGZaRWhidVh3?=
 =?utf-8?B?bTZMZjJqUU9GQjVFN3hFN21BdXpJUWkwSE5Ib3h6ZXVjb1ErcVFWc3N0SkFq?=
 =?utf-8?B?QWFIOEowajF4SWlNOEVYM09nT0poWW4vbTRsVFVodndHWFBBampIeGF2YVlm?=
 =?utf-8?B?SUx2MWpSclR1ZGtSVW1ublRaN1ZIWURlTHcrRnArelFXYjhXQTIwQ2ErUUpM?=
 =?utf-8?B?Q1dCQjVGSUxNVlEzZk5DWUplQkZYRVJDNllxRko3dk9WNGdldk04dDJXTVov?=
 =?utf-8?B?YUltK2VYcnI2MURpbUZGZ0pPMmM1T2llRGJiNUlWZlgwNXdGQzNGQmszcEZH?=
 =?utf-8?B?eGJnWWd0dm1FZnh2ZXcxMFpFdjd6c0E5dnFBcjk4L3FrcGZpVDZFeS84RkEr?=
 =?utf-8?B?MVBJMVZRQTRjTXBWUkRYdVBicEJocVkrRk51S3dLL2xTYnJocEgwYmFzMVYy?=
 =?utf-8?B?bGtDUWlNNG5wY3I5ai80KzE0bkpjY1lJaGdKUGE1bk8rN0JJNDFRNjhOWENS?=
 =?utf-8?B?Z1ZteDQ5VHNXS05HbW4rTjU1eG5IUjlyMUhCZ1FNM0hLME1nWVR0bzFhb28z?=
 =?utf-8?B?L0tGOGlWTW1NcHRnRFFacGFEWHg4b0RwOUYzZDI1SnV4cE56L0hkV3lKNy9v?=
 =?utf-8?B?RlJPMzZMOS9YRFNqNWxSd0NjQ0xUTmREcVlsQVg0SUc0eTJRTk01bzhjcVd3?=
 =?utf-8?B?U2p1QXpFWkdjTTF0ZVhVMGZ0WlJxRkR6VGY2ZnRXSjZGWFZmNGlpaGkraE8v?=
 =?utf-8?B?TkM3TGN0MnJtNlRkNmhReUIyYjdIb05vbDU3WUovQURlem1kcnNNRUF3MUox?=
 =?utf-8?B?dlFyQ0RQQjE0dW1FU2Z0OExMSTMwWCtBMERmN1hlZE5OODYyTWdIcXFORGFT?=
 =?utf-8?B?ek1pR0dSR0s4c3cvTi9wcnlyMEpvM0tqd3UwN1ZGV0NXQjlvVUd5WjNDLzgy?=
 =?utf-8?B?ck11anFHUFk0OVBvVG9QNGNWOUVxZytNMCtpSldlWk1QWE8rWmIyOEQzSWpT?=
 =?utf-8?B?RDBPMDd2Mlp4L1NzNGJvdXJLdGgzWkk2TEd1NWdnWjFyWU1BV2UrR0gzZnY0?=
 =?utf-8?B?cVNkdXJDV2FidENxOWg4NmtTcVpsRllNWDEwbGtIRmxjWTF5UFdiS0FXQ1k3?=
 =?utf-8?B?L2l2Z1JycTlFam1oajAwNjhpd2FoUlY0a0o5QnJPNWhoRFE3VFljQWc2U0pT?=
 =?utf-8?B?TG9MczJ6VDhMVHpvS2NhOER1SVpmN1lqdlFoZ0pJcVkrTG1GTEJ4MFFwN2x2?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t+hhvJsOjiGlJ//+/JYS2uhwatpjgGsUpxFabM5YnVc7Ii0oLU/00Nah3ETLzUaeKSuXN+4NwVMgLXRYEaIEjkOcEeJCxYvYPlkT7iCTrwZ8QpqBXFYfUeBaqsdJg23OnWohPRlE+lkdwYwCezSqUgZPY60JQVpCIaaIGLGQCumC/d84AC+E/sAIe5yk+jmtMEQiaJzF3A6m8/Yjgjwfh7MGd3qRDwxL3q7VsNmjLPxaDVzfBbFz2WJ2chrwiEYZIuJSY38XXmGNvF/Na/02NYPporcUfZLlOgcfC481eC72gmidYDhVrsUxEmFipErS687nDc55+Ts2ViYGGkrof49noslPP02IkH1aAa54xoSG9cKZL1xtod5Haauzjln5HGm3gz2hq7dR+lhmUn+fczPytcILyQNsiqvqrCRfjAnfBKjvPdJGU83zqWvle01DQa+4cjo1b9Fr8YmyZOU1fei3ziI48HMultnN7SKvzcc3N3QmxN9AFTm6UndAgyR0eQCRgh64T7Gfqs4wEISynO/2cJeIhUQzzMUjgJjWnT9jqE+tUW7bYsAq6ICNCnB3BcKpaDKg0QmfNAWjsixbC3ErM8yeK4FOAlmGSQ/ADYylZWHThVYypq0IO3KC+WYK9CfZwpBqMnlN/vp2t+fGz9L8ojJ1QDpJDE8RRUV+RLBm8s9PakfQH4/kL5hIlVwXE6kSwDnek+D3xdAJKYU/GGuSuvy/67azgNOoX7eJ+xPM8gBWAF2+3B9nxxaqNwrEK9GHjxGBKcjj+Vx8RHqar0n8nu4GuYM3qY6J2ODDKz0mX3LsWg8pkcrMPdrL9YrEsL19HxxtJkQxzQoss/QPFlN8VHQmbZrSF08ffIIjCMI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbea299-0018-4a50-b6c2-08dbae6f7358
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 00:23:10.4191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VxZ0HaQTBHiCmDrq4yLQtRyKbIDm9QnrUKySEDSxQqLA9es5CxSN3P/jVcoYvs86hbza14I6IP49G8d6PsD50SDi/w8O3obTolj/JwE6Ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4877
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060002
X-Proofpoint-ORIG-GUID: O56_PZ4q8YnZHkuTwfQwj6KQRIa5Z79_
X-Proofpoint-GUID: O56_PZ4q8YnZHkuTwfQwj6KQRIa5Z79_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/23 4:41 AM, Wenchao Hao wrote:
> It's unbearable for systems with large scale scsi devices share HBAs to
> block all devices' IOs when handle error commands, we need a new error
> handle mechanism to address this issue.
> 
> I consulted about this issue a year ago, the discuss link can be found in
> refenence. Hannes replied about why we have to block the SCSI host
> then perform error recovery kindly. I think it's unnecessary to block
> SCSI host for all drivers and can try a small level recovery(LUN based for
> example) first to avoid block the SCSI host.
> 
> The new error handle mechanism introduced in this patchset has been
> developed and tested with out self developed hardware since one year
> ago, now we want this mechanism can be used by more drivers.
> 
> Drivers can decide if using the new error handle mechanism and how to
> handle error commands when scsi_device are scanned,the new mechanism
> makes SCSI error handle more flexible.
> 
> SCSI error recovery strategy after blocking host's IO is mainly
> following steps:
> 
> - LUN reset
> - Target reset
> - Bus reset
> - Host reset
> 
> Some drivers did not implement callbacks for host reset, it's unnecessary
> to block host's IO for these drivers. For example, smartpqi only registered
> device reset, if device reset failed, it's meaningless to fallback to target
> reset, bus reset or host reset any more, because these steps would also
> failed.
> 
> Here are some drivers we concerned:(there are too many kinds of drivers
> to figure out, so here I just list some drivers I am familiar with)
> 
> +-------------+--------------+--------------+-----------+------------+
> |  drivers    | device_reset | target_reset | bus_reset | host_reset |
> +-------------+--------------+--------------+-----------+------------+
> | mpt3sas     |     Y        |     Y        |    N      |    Y       |
> +-------------+--------------+--------------+-----------+------------+
> | smartpqi    |     Y        |     N        |    N      |    N       |
> +-------------+--------------+--------------+-----------+------------+
> | megaraidsas |     N        |     Y        |    N      |    Y       |
> +-------------+--------------+--------------+-----------+------------+
> | virtioscsi  |     Y        |     N        |    N      |    N       |
> +-------------+--------------+--------------+-----------+------------+
> | iscsi_tcp   |     Y        |     Y        |    N      |    N       |
> +-------------+--------------+--------------+-----------+------------+
> | hisisas     |     Y        |     Y        |    N      |    N       |
> +-------------+--------------+--------------+-----------+------------+
> 
> For LUN based error handle, when scsi command is classified as error,
> we would block the scsi device's IO and try to recover this scsi
> device, if still can not recover all error commands, it might
> fallback to target or host level recovery.
> 
> It's same for target based error handle, but target based error handle
> would block the scsi target's IO then try to recover the error commands
> of this target.
> 
> The first patch defines basic framework to support LUN/target based error
> handle mechanism, three key operations are abstracted which are:
>  - add error command
>  - wake up error handle
>  - block IOs when error command is added and recoverying.
> 
> Drivers can implement these three function callbacks and setup to SCSI
> middle level; I also add a general LUN/target based error handle strategy
> which can be called directly from drivers to implement LUN/tartget based
> error handle.
> 
> The changes of SCSI middle level's error handle are tested with scsi_debug
> which support single LUN error injection, the scsi_debug patches can be
> found in reference, following scenarios are tested.
> 
> Scenario1: LUN based error handle is enabled:
> +-----------+---------+-------------------------------------------------------+
> | lun reset | TUR     | Desired result                                        |
> + --------- + ------- + ------------------------------------------------------+
> | success   | success | retry or finish with  EIO(may offline disk)           |
> + --------- + ------- + ------------------------------------------------------+
> | success   | fail    | fallback to host  recovery, retry or finish with      |
> |           |         | EIO(may offline disk)                                 |


I didn't get this part about when we offline the disk now. For this LUN case, is
it if the driver has called scsi_device_setup_eh with the fallback arg with false?
If so why doesn't it just try target reset -> bus reset -> host reset like before?


From a high level I have the following questions/comments:

1. The modparam and drivers calling scsi_device_setup_eh/scsi_device_clear_eh
seem uneeded.

If the driver supports performing multiple TMFs/resets in parallel then why
not always enable it?

2. You probably need to work more closely for some of the drivers. For the iscsi
patch, we would want to allocate a tmf per device and per target, or if a cmd
timesout on a second lun, that will always fail since the iscsi host has only
one tmf preallocated and it would be in use by the first reset.

For the other drivers, did you review what they support? If so, how many drivers
can you just turn this on for? Or what drivers did you test so far?

