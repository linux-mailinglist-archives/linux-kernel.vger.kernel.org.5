Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09397CEBEB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344679AbjJRXW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJRXWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:22:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86699D7E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:21:50 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIp7dg019594;
        Wed, 18 Oct 2023 23:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=JylVy0ju0xtYIdDsaMCHYQFoLi+uWi/Cq9rQZsUlagg=;
 b=fsKsYvVO5uErCEkR6deqe74wRHIeeNQf6MSKlfLObK/LZtgEp/ytmRN+OSu7ZkiHB3rk
 qOpF2hLrqp6uA2xvXK4lpdrTqoMYOJLqHWqOesmdRpx64G9ZrAqswiyotVeYPRSExNAi
 q4YrHD8hFCkLQ385/8TtN229/pZR5Q9x9vW1Y7fMvCFYsPeLjr2dZhV9vPswa3EaQ7Pa
 XtTgJBCL9pgLqG3xcjJm36hcLUaCRIjmzWs0GQNyBMQ1/HYnPWboKvV5dsCC4ZwmK7h4
 DbNQ6qBXDhMwficmFZsPEo9LckrGt1bL4ovt8dNZ3UqqX1PHv7I4PFQfFRNvkgWXeInm Rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjy1gqeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 23:21:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IMY3h0015439;
        Wed, 18 Oct 2023 23:21:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg1h5par-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 23:21:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ie5L4gW/u+zod92MwtPr152ehQKm3CrXLz6SlTf49ev7SbFoGILXUaGhScDd/XK85fqlMhgB02vKlfH+kz7HeMvRu6RmQHExev3AUURUNZcZaERLjFgT/NoY9gph7Jx6maniSEgNMKPMdgng43S+ZW+2ML5maU+WvH8CA0UnJLBW2gaWVn6KFP0GWZjUmF38IIVe1mQkh9MNlUhXl0uSEQCynVRkr0IFT5MjxfpqraeE6e0pdr0G+V68ZzWsUFViCvPcHBHLv9Nxm84us3SZ3aNe3psJ3O9onk46mXBQ9RSax35TjQzlJ3cjXe3HI1ESUTW4jJR9Oe9AffqrusFO1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JylVy0ju0xtYIdDsaMCHYQFoLi+uWi/Cq9rQZsUlagg=;
 b=ihil3H7ySWVdMj5Eu/gNushPrvd/ktWeBSoUZoleQXNJ7EghA8e/2NW8W1lWs2l/rYTk8hxMciq+GUucJiFCf4Nw/OMihEeGks/NaWYqp8+MDx7IhvnyDHNO64yXTTY9wG1uxMeHJFtMwmJreO2ZGEgB4Fs9NgGKFneStrMW+tGFaWDR9ZtddJbnFqk3irpeFsaIAKeAl7I9F4GtkM2b87MgFfCOA5LfSAezVH3zocnMOtZuI9sNn+ivRPCdOo3w0Qt/L5Vo/36LizHnqDbAWqMpfQXSUv8Z9bGQrEjmppH05aO2fX5i0j1+c/9p58V9meMgcsK2PNTHwcEbI08XCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JylVy0ju0xtYIdDsaMCHYQFoLi+uWi/Cq9rQZsUlagg=;
 b=ipVRkf+QjmQ7yjmsflNeD9bJhmCpAnqKB8+93N1jJqjROCXaHNfYJsgF4dR9UbiOlGMOCXV1AenfxTsqIRiH/jEvF/t2uMg1gqhySl5eipsTuhNQsDABNqv28vaumm/I85U7xJZ6xkIkNAwhkLYqWdpfR7l5LCKrB6Vl/q5QfIw=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS7PR10MB7346.namprd10.prod.outlook.com (2603:10b6:8:eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 23:21:35 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 23:21:35 +0000
Message-ID: <35efd377-61f7-4cef-adf8-61e9269e4be9@oracle.com>
Date:   Wed, 18 Oct 2023 16:21:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
Content-Language: en-US
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com>
 <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
 <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
 <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com>
 <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
 <c9c819b9-4a63-4bb4-a977-881f6e653ed8@oracle.com>
 <CACGkMEuX8-T6BhbiqkTfF3NBoxS35zQ=k6Th=h0G5sDz4DV93Q@mail.gmail.com>
 <9c74b299-98ec-46b3-bf21-972f9883ca84@oracle.com>
 <CAJaqyWc01_YgkhLRs961a-K1P+Zj4P+6qGN1t=eOFFwGvQ001A@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWc01_YgkhLRs961a-K1P+Zj4P+6qGN1t=eOFFwGvQ001A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::11) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS7PR10MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: b86e8607-515a-49fa-be7f-08dbd030f8a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSJxFDoY9CqFw+Ourb5ICzp+XH7z64WoAenk2APUM0L2ZMuU7lc2u6K3iZMKiiMJMOJ4LYVbvuKY4tuZ7Egfo4yqJUoCtvyCE+OsaASSuQF3kdtJJNvUh0RyJU21HXj6s7gKgux2KjP3Gz356Tft5N8QgcUmW1CL/TEqE5X1o452Huhn4iyLqPG6H5MnsL1cZF0zZCfiA7La/tT++aq0FZRZW3A4LMIJPwx0gMpReWwnAAM2NGquWig1rq7bt7CFHtxt3mU2ewv1AEY7HpCA+unPsoyQvNX/tU6bS4WBNUnQ60NgcYNghfKBDWpgEdjYBnXyhsFiaTi1IkkXkYTDYA4XSSgl5XGrhZNAEGjTCCuUaDq/jpjMy1g1bPHEbOqfGvwjxMWLM8TPcKuWPYRXCLJatckc1FJIIC5yj7WuQQs1IT9j/HtrLkCxVcv5SYANfVYkQQnl+V7HHpX2UpTm56fFgQhhnVTBDX0fzPHPuTXRc+zTdgemd9lbafThsEO8Sd1bPl3X17bun95HwtDQqA2RHuqS2EpbD45TDrYTfU3O0ny2AYQ8wsty42jHaCwBAZEL0o8BAVe3clvFy8LfUYonpkKeaNsXsvMvPJRq6sgC3NhzsZBjd28vAwVfOsnATa7qMHKvZkBzshQg1+kOTHF5K4pT5R5fh4duYcS5Kl4ugGKIZkLSN+nNpYkn6P/8FmyxRYdlHnmT0vGIKyBgkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(38100700002)(66899024)(66476007)(36756003)(2616005)(26005)(6512007)(478600001)(41300700001)(8676002)(66556008)(316002)(4326008)(6916009)(8936002)(66946007)(2906002)(6486002)(6506007)(5660300002)(36916002)(86362001)(966005)(31696002)(6666004)(53546011)(30864003)(83380400001)(31686004)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cCtyWFRjWTlTOFJQVlZlOEtvYzNrZ0lDdFlScURZWDYvTkZHSUhCU3FMZHA3?=
 =?utf-8?B?aTNObnFJMUtrWjlPa053L3MwZ1M0bnA3VFhDR1k3REd2T0tUQ0t6VG0vMmhE?=
 =?utf-8?B?L2dNNlNkYVkyUEpsQ0ZzelhzaDR3aXlmYzZtQXNCN2NqanZ5UUI5OThMZUlr?=
 =?utf-8?B?ejFzQkQzSXd3TlE0Y2Ivc1pUb1Z5ZUFSamIxZmovQUZjOXBJMUZ6dW1UYVFu?=
 =?utf-8?B?RWNCdGFwMDdFOEpUR1V2QTl1Y2M5V0tRS2Q1cXFhVkU3eDREZSt3OXVHSVF3?=
 =?utf-8?B?RE5tQ01UNnhGZ2FJU1VkT1RUVzVpcG9SMU1QUndhVFdZVjdPcnVDN3pydnZC?=
 =?utf-8?B?bmhoUmtXeVNnYW5CMlNybUV5a3ZCN3drSmdiNWs4a3p5VG5TUURvdjE1dzhU?=
 =?utf-8?B?dHV5b3Z4aCtQMndUakVVeGdVQW96NzZWKytSRHIxWGdGNWl4WmZSbmZIM0Zx?=
 =?utf-8?B?VGlZaGh6M0Y0K29KbnJ0VTJBeCtMY2x3UGZjSENKUVNTN29rK3BWK0Rka1R6?=
 =?utf-8?B?MUNBbWZGN0hCT3FVTWlRdWlWMDZ6Mm51VkV1OU54aHgwVkk4cDdCdGFHQUVF?=
 =?utf-8?B?SDVXckluT0t1Z04zQy9HUjJ6YjYvODh2SExWQ3JySGNWOTdJOUp5eVpaa013?=
 =?utf-8?B?cGtoL0kvVHBBUHp2V3NUbEVjYlBIMG1EQlp4K1ErV0h6WmJMUlJubTZaQnJu?=
 =?utf-8?B?T3luL005WStmSDA0MGRPM2h0aFgvYjFITjVkTEpYUG1CYnI5enZkZUxMQi9v?=
 =?utf-8?B?UmpiT0VZOU04MXdkNDVtNUFZcVgwQlVrNzBRYTdqcGhCYkttUlZFYlQzUldK?=
 =?utf-8?B?WTlIbGFVTURoYUFtSnprSWpRR3VHcWpGTUUxM1NTSGQ4QUN2aU5IVkt4T0NL?=
 =?utf-8?B?QXlJcE02QVZlZ092Q3paNllOcHc2MGFNb3J5cit3WlJpVnVtb09IdFc3SFli?=
 =?utf-8?B?bUg1NmoyWVFWSTZ2MFErdGRONFA5S1hBS0R6c004UXhBRnhlVW50WCswR2xU?=
 =?utf-8?B?b0svakRYaFI4em80bWlFUTdjNWxWMWtXQ214ais1RkNUbVVHckVxWHBLazdR?=
 =?utf-8?B?ZDU5V2xiZWx1NEFyMmlJQit6RzdFQkFBY0tzTHVwbm9UYUlwUlN1TmdoU0o5?=
 =?utf-8?B?RjNvUUFRbTJObGpVR0RLTmtkclJPTDZGWWp6QlBuRHhHV0tPZm85aGovSEo0?=
 =?utf-8?B?QlR5S1FLdHg3Y2xHM3hTd0NhTVRQeDRTNksvZEdXbFJpYWtzbTJoK2NtOVBk?=
 =?utf-8?B?ZC9JOVVaV0tVSTg3RzlPSzRGU0dNeFFyQ3pkcjhCS2pVZ3V3MWxjNWV1RkI0?=
 =?utf-8?B?ZWt0TjM1Yjc3NnZOVjIzS1BFallBMHA1ZjBOdWdrQ0QvblEzTFRrZzRsZDBr?=
 =?utf-8?B?WjZUbldaSEZQNENSdzVyRDZBeGxaT0xCaUd0NjM0a0h1aEdPcDdyQWpNUFlW?=
 =?utf-8?B?dWpibVJMaTcxMUQveDY0MkdYcnRHYThManhBZS93UHBNWnFFNi9MZU42dGpH?=
 =?utf-8?B?RWtneDJYQVdKaHZxN3FiYVVkUW83TG9pZEllb2tsYjhNNlpQYkxiMzBXVmM0?=
 =?utf-8?B?MktwWjRLMlV1cFhxVDczSy9BUldGdTIzalZydFFOcmJWb3Erbnkxd01vZEht?=
 =?utf-8?B?RU40K1o0YVU4Njk4ZEZyQ25NZWNtS2p2VTF2SzlTOGxUTllKUnNFdzA0eHJw?=
 =?utf-8?B?WkNBak1rKzdLeWtjV3VDMDY5NTZEeHhuZmNraFc1ZE9hd0JySVdBZDRrSVQ0?=
 =?utf-8?B?T2s5VG5NQjBsdlQ5eDlLZ1ZqU0hmUVdRSTlldHA4WHYyazQ0T1ZDZS9wdEdq?=
 =?utf-8?B?ZmJ4R0JRaWxQMnliZThuZUU2TE5MbDRuM1Q0a0ZRZk03enpzMnZGY2l4c3JR?=
 =?utf-8?B?bHJCT2ZVeU02cWtzczNpc3lOVTh0c0h5NU9pK25qKzhaWDJoYVFrUTVCVzQ4?=
 =?utf-8?B?cUNnUWRjMlhOSzJWOGxMVWdrWDBCRVBtTXh1YnVLYytFcUNQcVlzQTZkT1JF?=
 =?utf-8?B?d1ZLQWxqMjlySytMWjZTeUJ2QWlLSlYxUWc0VVRNYmxJcFMxWEorNzV4NWh5?=
 =?utf-8?B?YmxpVHNrVXQ2ZnhKVThGYTY2NzJmYWR6YTdkcXlWK0hUb2xxenVKTC9ua1lL?=
 =?utf-8?Q?BoSMphQMqmBllKaNmY4x14bHS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dHNnbU5PNHdHNzkxY0VVVUFkZlFZMWZJTVpHMllNZHhwVFZOMXRWVVV4cldk?=
 =?utf-8?B?cmkySjgxNUtmWEp1dUNseExyQUhtSk5WUDU5REZlU2NJQmZrSFJlanAyQ09W?=
 =?utf-8?B?YkEzQnFkeW9nS3VOZ1hsYmlpdk1laWxyc3IxQmxiSmUwblRQRStMcFMyd1FD?=
 =?utf-8?B?dHA0OFBZazdUQUhtWkpCcEtRb2RGdTJhLzlmTnc5TVk1Uk1NeXJJMEkxelIz?=
 =?utf-8?B?eHNmdlhkb29peFpGT21sMzRPY1dJSEc4NGR0ak40QXRSQ1d0TUJRay9MQU52?=
 =?utf-8?B?eU5wdDd5bVAyaUhyZW44T1ZQYlhydXg0TW5BUFVHSDNxQXZKellVdEVBVUVk?=
 =?utf-8?B?NHVUUFdPUE9USDRIWjVxbXhVVEJ1WnJRbFQ5dUlSaHZaaW52TkFWZjJzV0xp?=
 =?utf-8?B?cmZBTi8yLy95SjVwK09Wa2tGQmZ2dnF6dW1VelRlUlFNeENqeWdmelN2cTdj?=
 =?utf-8?B?TTZGQWtWbitVcWNrWnltN1h3dFVzME5BM09OekU2ZlNDS0p5VVREVml5S253?=
 =?utf-8?B?MEdEV1pCdEpqb2ZpZnhCSlBaang4OVVVTURKVTh0STdLcTJ2b1djZjU1d2VK?=
 =?utf-8?B?SHNNVGIyK0JlVGtmWU1raXBLb1BwWTREd2JNMm5vVmt3REhTTVpRL1RmYTFu?=
 =?utf-8?B?MUlQd3g3VHNjbnRyTEphd3dlYnNQVE81ZjZIaXJXZUdER0hURW9zUGcrRkxE?=
 =?utf-8?B?NUlEaTFHcDhZTFE0bjcxanYrNy8rZnp3a0NXbjhDMUtYLytBYU91NHRaWFpR?=
 =?utf-8?B?YnJ0RGlmUUlLMzZYYnROWDZNc2J0eGFMVk1pV0ttSGRHdFhiL1I4Y2ZPTjBs?=
 =?utf-8?B?OGFwLzlxRWpXeDVqakZEb2VaWUY4TDdwRC9pR2VianRIZ2sxcWI3VkJNL2NF?=
 =?utf-8?B?ZGQ4SThmc3JET2J0Q3BURDMrMVUwMzhxak54eVptK3RnaWJlVXdhSVdSenFF?=
 =?utf-8?B?cTFaS1oyOTF2VklVNXhEd0Q0OXpyTncyVVZjMzdPSGpqR1dNbDVVTWNkN1Yy?=
 =?utf-8?B?VVFHdkp0R1VqclpUMUpiV0IvcFRWRERDQ2lLZW9NQVBnY3ZwcU4zbzBMTmV3?=
 =?utf-8?B?ZE1qREwvdkVYaDZ0NW9FTVZ2OFk5TUNwUDhPV2xEeXlIZ1hUTy9ZakZxQ21q?=
 =?utf-8?B?dFFCd1RVN043Y0pYTnJWYUdpTk5qWGpOV2t1UTB3ZjFaOUgzY2s2SmliWkFF?=
 =?utf-8?B?bk5RcnEyN2NDSGhNbGRjM01BVVNrTFAxSUNNZUFpUXZ4bDhFUVo4ZUxvWk9t?=
 =?utf-8?Q?tpDBha1OlnbQljE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86e8607-515a-49fa-be7f-08dbd030f8a5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 23:21:35.3644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOofEnzPiveT2iKDbnkYYh06bJNh6L6dxdx+N7NyaTSOVsM2t3tWU2mhhDYcsNqpsLvoN9he32lJYDP6yxj3og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7346
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180193
X-Proofpoint-GUID: iSGoRt3KMIGmKsBI-76KrknW7UpMblGf
X-Proofpoint-ORIG-GUID: iSGoRt3KMIGmKsBI-76KrknW7UpMblGf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/2023 4:14 AM, Eugenio Perez Martin wrote:
> On Wed, Oct 18, 2023 at 10:44 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 10/17/2023 10:27 PM, Jason Wang wrote:
>>> On Wed, Oct 18, 2023 at 12:36 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 10/16/2023 7:35 PM, Jason Wang wrote:
>>>>> On Tue, Oct 17, 2023 at 4:30 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>> On 10/16/2023 4:28 AM, Eugenio Perez Martin wrote:
>>>>>>> On Mon, Oct 16, 2023 at 8:33 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>> On Fri, Oct 13, 2023 at 3:36 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>>> On 10/12/2023 8:01 PM, Jason Wang wrote:
>>>>>>>>>> On Tue, Oct 10, 2023 at 5:05 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>>>>> Devices with on-chip IOMMU or vendor specific IOTLB implementation
>>>>>>>>>>> may need to restore iotlb mapping to the initial or default state
>>>>>>>>>>> using the .reset_map op, as it's desirable for some parent devices
>>>>>>>>>>> to solely manipulate mappings by its own, independent of virtio device
>>>>>>>>>>> state. For instance, device reset does not cause mapping go away on
>>>>>>>>>>> such IOTLB model in need of persistent mapping. Before vhost-vdpa
>>>>>>>>>>> is going away, give them a chance to reset iotlb back to the initial
>>>>>>>>>>> state in vhost_vdpa_cleanup().
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>>>>>>>> ---
>>>>>>>>>>>       drivers/vhost/vdpa.c | 16 ++++++++++++++++
>>>>>>>>>>>       1 file changed, 16 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>>>>>>>>>> index 851535f..a3f8160 100644
>>>>>>>>>>> --- a/drivers/vhost/vdpa.c
>>>>>>>>>>> +++ b/drivers/vhost/vdpa.c
>>>>>>>>>>> @@ -131,6 +131,15 @@ static struct vhost_vdpa_as *vhost_vdpa_find_alloc_as(struct vhost_vdpa *v,
>>>>>>>>>>>              return vhost_vdpa_alloc_as(v, asid);
>>>>>>>>>>>       }
>>>>>>>>>>>
>>>>>>>>>>> +static void vhost_vdpa_reset_map(struct vhost_vdpa *v, u32 asid)
>>>>>>>>>>> +{
>>>>>>>>>>> +       struct vdpa_device *vdpa = v->vdpa;
>>>>>>>>>>> +       const struct vdpa_config_ops *ops = vdpa->config;
>>>>>>>>>>> +
>>>>>>>>>>> +       if (ops->reset_map)
>>>>>>>>>>> +               ops->reset_map(vdpa, asid);
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>>       static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
>>>>>>>>>>>       {
>>>>>>>>>>>              struct vhost_vdpa_as *as = asid_to_as(v, asid);
>>>>>>>>>>> @@ -140,6 +149,13 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
>>>>>>>>>>>
>>>>>>>>>>>              hlist_del(&as->hash_link);
>>>>>>>>>>>              vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
>>>>>>>>>>> +       /*
>>>>>>>>>>> +        * Devices with vendor specific IOMMU may need to restore
>>>>>>>>>>> +        * iotlb to the initial or default state which is not done
>>>>>>>>>>> +        * through device reset, as the IOTLB mapping manipulation
>>>>>>>>>>> +        * could be decoupled from the virtio device life cycle.
>>>>>>>>>>> +        */
>>>>>>>>>> Should we do this according to whether IOTLB_PRESIST is set?
>>>>>>>>> Well, in theory this seems like so but it's unnecessary code change
>>>>>>>>> actually, as that is the way how vDPA parent behind platform IOMMU works
>>>>>>>>> today, and userspace doesn't break as of today. :)
>>>>>>>> Well, this is one question I've ever asked before. You have explained
>>>>>>>> that one of the reason that we don't break userspace is that they may
>>>>>>>> couple IOTLB reset with vDPA reset as well. One example is the Qemu.
>>>>>>>>
>>>>>>>>> As explained in previous threads [1][2], when IOTLB_PERSIST is not set
>>>>>>>>> it doesn't necessarily mean the iotlb will definitely be destroyed
>>>>>>>>> across reset (think about the platform IOMMU case), so userspace today
>>>>>>>>> is already tolerating enough with either good or bad IOMMU.
>>>>> I'm confused, how to define tolerating here?
>>>> Tolerating defined as QEMU has to proactively unmap before reset just to
>>>> workaround the driver bug (on-chip maps out of sync), unconditionally
>>>> for platform or on-chip. While we all know it doesn't have to do so for
>>>> platform IOMMU, though userspace has no means to distinguish. That said,
>>>> userspace is sacrificing reset time performance on platform IOMMU setup
>>>> just for working around buggy implementation in the other setup.
>>> Ok, so what you actually mean is that userspace can tolerate the "bug"
>>> with the performance penalty.
>> Right.
>>>
>>>>> For example, if it has tolerance, why bother?
>>>> I'm not sure I get the question. But I think userspace is compromising
>>>> because of buggy implementation in a few drivers doesn't mean we should
>>>> uniformly enforce such behavior for all set_map/dma_map implementations.
>>> This is not my point. I meant, we can fix we need a negotiation in
>>> order to let some "buggy" old user space to survive from the changes.
>> Userspace is no buggy today, how to define "buggy"? Userspace with
>> tolerance could survive just fine no matter if this negotiation or buggy
>> driver behavior emulation is around or not. If any userspace doesn't
>> tolerate, it can work still fine on good on-chip IOMMU or platform
>> IOMMU, no matter if the negotiation is around or not.
>>>>>>>> This code of
>>>>>>>>> not checking IOTLB_PERSIST being set is intentional, there's no point to
>>>>>>>>> emulate bad IOMMU behavior even for older userspace (with improper
>>>>>>>>> emulation to be done it would result in even worse performance).
>>>>> I can easily imagine a case:
>>>>>
>>>>> The old Qemu that works only with a setup like mlx5_vdpa.
>>>> Noted, seems to me there's no such case of a userspace implementation
>>>> that only works with mlx5_vdpa or its friends, but doesn't work with the
>>>> others e.g. platform IOMMU, or well behaving on-chip IOMMU
>>>> implementations.
>>> It's not hard to think of a case where:
>>>
>>> 1) the environment has mlx5_vdpa only
>>> 2) kernel doc can't have endless details, so when developing
>>> application, the author notice IOTLB is cleared during reset
>> I get it, but my question was that, even if the author had noticed IOTLB
>> is cleared during reset, does he care or not to make IOTLB back working
>> again? My point is that, if this old setup is supposed to "work" on
>> mlx5_vdpa, then the developer must come up with sort of "quirk" to
>> recover the IOTLB to make it back to working state again after the
>> reset. It will be more justified to come up with the proper fix for
>> compatibility/emulation only until we know what should be expected to
>> work and through which possible means to making it back to work, rather
>> than blindly emulate the buggy behavior solely based on a few driver's
>> own implementation. I'm pretty sure there are multiple ways to implement
>> the buggy reset behavior in the driver, does it mean we have to emulate
>> various corrupted mapping states in the individual on-chip iommu itself?
>> How is it able to help the developer user if we are able to replicate
>> the same corrupted mapping state in the on-chip iommu after reset, any
>> real-life user only cares about mapping being corrupted in the same way,
>> rather than cares more about the quirk sequence or work around to get
>> iotlb maps out of the broken state?
>>
>> Only if the userspace is like a test facility to expect some test case
>> to fail on mlx5_vdpa after reset -- I assume that is not real-life user
>> at all.
>>>> The Unmap+remap trick around vdpa reset works totally
>>>> fine for platform IOMMU, except with sub-optimal performance. Other than
>>>> this trick, I cannot easily think of other means or iotlb message
>>>> sequence for userspace to recover the bogus state and make iotlb back to
>>>> work again after reset.
>>> Yes for sure, but we can't audit every user space, no?
>> We don't have to, as userspace here has no bug at all. The bug exists in
>> the driver not in userspace. Real life userspace app only cares about
>> making things work not asserting something must be broken.
>>>> Are we talking about hypnosis that has no real
>>>> basis to exist in the real world?
>>> Instead of trying to answer these hard questions, I would go another
>>> way. That is, stick to the old behaviour when IOTLB_PRESISIT is not
>>> set by the backend. This is much easier.
>> Please be noted the old (broken) behavior can vary between different
>> parent driver implementations. It's driver's specific own problem, if
>> there are N ways to for driver to implement buggy .reset, do we have to
>> emulate N flavors of different vdpa reset behavior?
>>
>>>>>     If we do
>>>>> this without a negotiation, IOTLB will not be clear but the Qemu will
>>>>> try to re-program the IOTLB after reset. Which will break?
>>>>>
>>>>> 1) stick the exact old behaviour with just one line of check
>>>> It's not just one line of check here, the old behavior emulation has to
>>>> be done as Eugenio illustrated in the other email.
>>> For vhost-vDPA it's just
>>>
>>> if (IOTLB_PERSIST is acked by userspace)
>>>       reset_map()
>>>
>>> For parent, it's somehow similar:
>>>
>>> during .reset()
>>>
>>> if (IOTLB_PERSIST is not acked by userspace)
>>>           reset_vendor_mappings()
>>>
>>> Anything I missed here?
>> First, the ideal fix would be to leave this reset_vendor_mappings()
>> emulation code on the individual driver itself, which already has the
>> broken behavior. But today there's no backend feature negotiation
>> between vhost-vdpa and the parent driver. Do we want to send down the
>> acked_backend_features to parent drivers?
>>
> What if we add a module parameter to both mlx5 and vdpa_sim to keep
> the old behavior? Let's call it clean_iotlb_on_reset for now.
>
> In my opinion we can leave it off by default, so these userspace apps
> can get back to the previous behavior. It would be ideal if we set a
> deprecation date for it though.
>
> This way new backends, whether they implement .set_map or not, will
> have correct behavior.
>
> Would that work?
Great idea, this definitely will work! With this module parameter, 
individual driver still keeps the possibility to revert to previous 
buggy behavior were to unbreak old userspace, code can be obsoleted 
independently per each driver's specific use case and need, and we don't 
necessarily overload vdpa core with too much unwarranted compatibility 
code. Thank you so much for the great suggestion, I will post a v3.

Thanks,
-Siwei

>
> Thanks!
>
>> Second, IOTLB_PERSIST is needed but not sufficient. Due to lack of
>> backend feature negotiation in parent driver, if vhost-vdpa has to
>> provide the old-behaviour emulation for compatibility on driver's
>> behalf, it needs to be done per-driver basis. There could be good
>> on-chip or vendor IOMMU implementation which doesn't clear the IOTLB in
>> .reset, and vendor specific IOMMU doesn't have to provide .reset_map, we
>> should allow these good driver implementations rather than
>> unconditionally stick to some specific problematic behavior for every
>> other good driver. Then we need a set of device flags (backend_features
>> bit again?) to indicate the specific driver needs upper layer's help on
>> old-behaviour emulation.
>>
>> Last but not least, I'm not sure how to properly emulate
>> reset_vendor_mappings() from vhost-vdpa layer. If a vendor driver has no
>> .reset_map op implemented, or if .reset_map has a slightly different
>> implementation than what it used to reset the iotlb in the .reset op,
>> then this either becomes effectively dead code if no one ends up using,
>> or the vhost-vdpa emulation is helpless and limited in scope, unable to
>> cover all the cases.
>>
>>
>>>> In addition, the
>>>> emulation has to limit to those buggy drivers as I don't feel this
>>>> emulation should apply uniformly to all future set_map/dma_map
>>>> implementations.
>>> Unfortunately, it's a must to stick to ABI.
>> How come this brokenness in mlx5_vdpa becomes ABI in any sort for future
>> on-chip IOMMU drivers? They might not even exist yet. Even if it's
>> concerning ABI it's limited to mlx5_vdpa and the existing drivers, right?
>>
>>>    I agree it's a mess but we don't have a better choice.
>> Well, it's your call, I can implement as you wish but the unwarranted
>> code has to be maintained forever. Particularly without knowing if
>> there's really such a use case in real life, and no one in future might
>> dare to remove the code without knowing what it can be used for.
>>
>>> Or we can fail the probe if userspace
>>> doesn't ack this feature.
>> Fail probing is even worse choice that is introducing intrusive breakage
>> to the userspace.
>>>>> 2) audit all the possible cases to avoid a one line of code
>>>>>
>>>>> 1) seems much easier than 2)
>>>> You see it's more than just one line of code, and I'm uncertain if the
>>>> additional complexity is warranted or necessary, particularly if added
>>>> this piece of compatibility code will linger for quite a long time.
>>> This is a must as long as it can be noticed by userspace. Doing
>>> something conservative makes more sense to me.
>>>
>>>> Instead of adding hypothetical code change for no specific good reason
>>>> and no real use case,
>>> It's not adding something new or new behaviours, it's just making the
>>> IOTLB reset conditional based on vDPA reset.
>>>
>>>> I'd like to add the code when we find out a
>>>> specific use case that may get impacted or already being affected,
>>> It doesn't conflict with what you proposed here. Old behaviours have
>>> their users, no?
>> We don't know the use case how to make thing work instead of make thing
>> break, that is the problem. We have no way to test if old-behaviour
>> preserving code really works as expected. If there's no such user in
>> practice, it ends up with dead code no one dares to remove.
>>>> then
>>>> we will have good understanding how to code up the fix and emulate
>>>> properly for compatibility, while not affecting other good implementations.
>>> The issue is, even if we can't find a userspace now. It doesn't mean
>>> we can't have one in the future. Then it might be too late or too
>>> tricky to fix them. We had a lot of lessons in the past.
>> I am not sure the same situation "too late to fix" or "too tricky to
>> fix" applies here. Usually this means there's some well established
>> pattern for e.g. API, ABI or long standing de-factor behavior that can't
>> be broken or adjust if trying to fix something up. But here we're
>> guarded by a flag (IOTLB_PERSIST) and without it the behavior is totally
>> ruled by implementation.
>>
>> Regards,
>> -Siwei
>>
>>> Thanks
>>>
>>>> Thanks,
>>>> -Siwe/i/
>>>>
>>>>>>>> For two reasons:
>>>>>>>>
>>>>>>>> 1) backend features need acked by userspace this is by design
>>>>>>>> 2) keep the odd behaviour seems to be more safe as we can't audit
>>>>>>>> every userspace program
>>>>>>>>
>>>>>>> The old behavior (without flag ack) cannot be trusted already, as:
>>>>> Possibly but the point is to unbreak userspace no matter how weird the
>>>>> behaviour we've ever had.
>>>>>
>>>>>>> * Devices using platform IOMMU (in other words, not implementing
>>>>>>> neither .set_map nor .dma_map) does not unmap memory at virtio reset.
>>>>>>> * Devices that implement .set_map or .dma_map (vdpa_sim, mlx5) do
>>>>>>> reset IOTLB, but in their parent ops (vdpasim_do_reset, prune_iotlb
>>>>>>> called from mlx5_vdpa_reset). With vdpa_sim patch removing the reset,
>>>>>>> now all backends work the same as far as I know., which was (and is)
>>>>>>> the way devices using the platform IOMMU works.
>>>>>>>
>>>>>>> The difference in behavior did not matter as QEMU unmaps all the
>>>>>>> memory unregistering the memory listener at vhost_vdpa_dev_start(...,
>>>>>>> started = false),
>>>>>> Exactly. It's not just QEMU, but any (older) userspace manipulates
>>>>>> mappings through the vhost-vdpa iotlb interface has to unmap all
>>>>>> mappings to workaround the vdpa parent driver bug.
>>>>> Just to clarify, from userspace, it's the (odd) behaviour of the current uAPI.
>>>>>
>>>>>> If they don't do
>>>>>> explicit unmap, it would cause state inconsistency between vhost-vdpa
>>>>>> and parent driver, then old mappings can't be restored, and new mapping
>>>>>> can be added to iotlb after vDPA reset. There's no point to preserve
>>>>>> this broken and inconsistent behavior between vhost-vdpa and parent
>>>>>> driver, as userspace doesn't care at all!
>>>>> It's a userspace notice change so we can't fix it silently:
>>>>>
>>>>> https://lkml.org/lkml/2012/12/23/75
>>>>>
>>>>> Another example which is related to vhost-vDPA:
>>>>>
>>>>> https://lore.kernel.org/netdev/20230927140544.205088-1-eric.auger@redhat.com/T/
>>>>>
>>>>> Thanks
>>>>>
>>>>>>> but the backend acknowledging this feature flag
>>>>>>> allows QEMU to make sure it is safe to skip this unmap & map in the
>>>>>>> case of vhost stop & start cycle.
>>>>>>>
>>>>>>> In that sense, this feature flag is actually a signal for userspace to
>>>>>>> know that the bug has been solved.
>>>>>> Right, I couldn't say it better than you do, thanks! The feature flag is
>>>>>> more of an unusual means to indicating kernel bug having been fixed,
>>>>>> rather than introduce a new feature or new kernel behavior ending up in
>>>>>> change of userspace's expectation.
>>>>>>
>>>>>>> Not offering it indicates that
>>>>>>> userspace cannot trust the kernel will retain the maps.
>>>>>>>
>>>>>>> Si-Wei or Dragos, please correct me if I've missed something. Feel
>>>>>>> free to use the text in case you find more clear in doc or patch log.
>>>>>> Sure, will do, thank you! Will post v2 adding these to the log.
>>>>>>
>>>>>> Thanks,
>>>>>> -Siwei
>>>>>>
>>>>>>
>>>>>>
>>>>>>> Thanks!
>>>>>>>
>>>>>>>> Thanks
>>>>>>>>
>>>>>>>>> I think
>>>>>>>>> the purpose of the IOTLB_PERSIST flag is just to give userspace 100%
>>>>>>>>> certainty of persistent iotlb mapping not getting lost across vdpa reset.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> -Siwei
>>>>>>>>>
>>>>>>>>> [1]
>>>>>>>>> https://lore.kernel.org/virtualization/9f118fc9-4f6f-dd67-a291-be78152e47fd@oracle.com/
>>>>>>>>> [2]
>>>>>>>>> https://lore.kernel.org/virtualization/3364adfd-1eb7-8bce-41f9-bfe5473f1f2e@oracle.com/
>>>>>>>>>>       Otherwise
>>>>>>>>>> we may break old userspace.
>>>>>>>>>>
>>>>>>>>>> Thanks
>>>>>>>>>>
>>>>>>>>>>> +       vhost_vdpa_reset_map(v, asid);
>>>>>>>>>>>              kfree(as);
>>>>>>>>>>>
>>>>>>>>>>>              return 0;
>>>>>>>>>>> --
>>>>>>>>>>> 1.8.3.1
>>>>>>>>>>>

