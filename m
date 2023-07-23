Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B5875DFD4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 06:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjGWEED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 00:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGWEEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 00:04:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAC81998
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 21:03:57 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36N40jqA026369;
        Sun, 23 Jul 2023 04:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kSRkSnzGrRwaE2HoHoleaOOzqGFGbWp2D3MaLKPoHD0=;
 b=XtXvu4QsJ5pzfyQTPjVB8kR4+qehFeM4hcTkJzYZapA6V0KDqbf8q8ATWa6VNMEO85Wk
 /dHJoe4y5TyLfXB4mhO7KgwWUA86pDFjO1UFEHjTYjOIA+FerXZ4iNHrBkeqW0V90QUA
 Hsgtc9EXr3LTzdUIKUDu/uFpR8ar/T/DmvyyTXpX5NHICtbIr7w4MG3nFmO5hIKJUYb0
 hhPB/BSYEp6b+yoZ/060+cnrCr3mq5Q4j2ZL5TCSn0TVirqYprjhpuWp+0kLPh3w7ZkJ
 iybNalebOSLZBBvWDQx9V0L7PZi+XvH1ctly4gTCLzlo0ELBYBP3XbZV3L0PD+888hnP ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05w3gwmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 04:03:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36N0JeQd040910;
        Sun, 23 Jul 2023 04:03:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j2rdam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 04:03:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccBnFZSyTwE7QD9xAs6ZPbONRg5XvTB3rlWL6b8IzJukuXtbTFHgnpLXqpklIe4YGrWL1/U4xTwcA23VkyFBMXiBph4Ppa3S4z0zYljjPDnwwcb7JUbSHI8ca55FTPBm7qS+TS/qS7QeVD0hRmb9ssEzlHy5ZCmtv0aU8TmK2qc3iNLtIgIH696yLRyWBZBHQ6dKLIuG6ld5NrL+XEny2vg5cXjJ+MIr/1jVqAujoMbecmdYXu4LohAEMpcrLO1Bjx0l8iRDsXxYNL9LJDeyss9EWUkuUPdLuWTXHxeZq4WYBrK25j/8o5AdHrAJhCRzITgliZn24YKNwMjGPBoZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSRkSnzGrRwaE2HoHoleaOOzqGFGbWp2D3MaLKPoHD0=;
 b=V9+xbvTHkSf5MEghkiEYahM+DVaeMJTXIBulMyloDaXz4Z4UcVCFJLLQA0G5X1Kh0coajzTZUrF/jIPXjaBpjNimxJlI3RGtPHF+TyPtwvNwLgq+BOsPpJwjDyqcY06tqnrkNVY8nK+nuqkdUsApDv5w14/ZD55i/rB4+x9rzi/nrlj1B9mpFuKktF9SGtFr3LCJvTkvJgklWH7K1A11YanIzo+NOi0E8+wWz2u7FWouOR99HysvWer/uMh/QZBxiQBUTqiuY37vOCJ8wQkumtvWEJyf0eyky+d7+42RxJpV0dY8taruXsSEQ/cviXU6RZNmn5u2l9lX86QfpdPB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSRkSnzGrRwaE2HoHoleaOOzqGFGbWp2D3MaLKPoHD0=;
 b=WRCi4pZ6YsGdvgv+QWHI2tS97t9CFM9dmvV4BsnRdNYGGH7Jzg5SvqlmqnI+wOHfO8lQz5XSBlO27OH79305HN86i5FU0pFC/ZKZ0/daVXMFkf6RfOPRKwVKcncWe7mTzQ3MvaL86iDPhPzHDAwfzL+HQK0Wr6BjFvcg2kk4YTg=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH0PR10MB4860.namprd10.prod.outlook.com (2603:10b6:610:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 04:03:32 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6588.031; Sun, 23 Jul 2023
 04:03:32 +0000
Message-ID: <dcd74064-7617-c895-4f78-cb46ef1d582b@oracle.com>
Date:   Sat, 22 Jul 2023 23:03:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
From:   michael.christie@oracle.com
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        brauner@kernel.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <20230720090415-mutt-send-email-mst@kernel.org>
Content-Language: en-US
In-Reply-To: <20230720090415-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR21CA0004.namprd21.prod.outlook.com
 (2603:10b6:5:174::14) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH0PR10MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c63620c-8280-4d5a-45da-08db8b31c771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+XXtrjxU3fn/zH9JPyI40nyAKDz2bDw4vy2wNs6GsaVbzyocq6m+PSTtw0K18i8yvD2HGOdRHF3Qm2VwnZ4p7+vf4Xi8mGq9wPTVAMQ4T7ty4SbbiTDRnZyMF8faa8Y9yqkj8YzrG9XiwwRTV8Xn48ePwDBCU70rEp+mfKVJfoLYLk+G9JsSwb+N1aqmjUgVUt3q9OO5UtiHy0biYpIi+CteS+2s2o2fh73A//badY6RWdFqMek6WxxlwuN9koPXBhZQd4/lsqGLcyHn6zK7nZhIB8fjrt8ajaRcDVbl/2PDdike3JUILsfYV6E5bIR+AvcDpuz0fOyx1F/WIlcTm4x4+AXVdttksFp39RJ+BfUNNz+hOvnB2OskHtaj9yFrqczh/vwT/IKLDTBYdT+nB3oydN/D9OZGPe+IVyDaO8oCQ2SjI8qPLdJ66jZdO8OJp5nC8O9V3WeWSV5yYr8w2gy6Ykzn7E2lemsHvtVmRlzzcNWVOuheEhxY7MoJllOhVOHjMEOMXOL3n3qpNTNOrSuKmxqenY5Slq1EujEKIr8ZB/NyejAXkHIH1LAJOKRjyK5LFZhKxTx4UZFPV5BNagItiJVqejFjd8zTMj5rF0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(2906002)(38100700002)(6512007)(966005)(9686003)(83380400001)(186003)(2616005)(26005)(6506007)(53546011)(5660300002)(86362001)(31696002)(8936002)(8676002)(7416002)(36756003)(6666004)(478600001)(6486002)(4326008)(6916009)(66476007)(66556008)(66946007)(41300700001)(316002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V21iY0oyNnNMcEFsekpPVW4zNFdsWUlXUzBQYlZPbXROazlXUStsSW9xdUpS?=
 =?utf-8?B?QXdBR1NuQ2NmdmFOZ29taVZTYnpDM0p5bWpFUDJpOGJ6clIyaFpSbU5RNjB6?=
 =?utf-8?B?MDQ1SDgzWVJkM2lmVFFKYXRVMkFxS3h0YVpSV25HSzFhSEdJcHBlWUk2Sk9D?=
 =?utf-8?B?VW5tNi9UbHJqNEE3eVY3eW1HZU5sa3BKbTd5UHFDRmdGb0ZVWUFCVWxESngw?=
 =?utf-8?B?U3hhbzhCOHozcHZnRDdSTVdUaEkyUHZOWWhKcFp2bktGLzJPTTJTN0JlN3I4?=
 =?utf-8?B?a0RhUVBKQnpKTUZrQTllc2pTM2FGbWdhY1lEVTZSU2g0c2E3SEk2QnA3ZFpC?=
 =?utf-8?B?eVpxQitFdXc2OWdOZ29UVWFTOU1LeW1aVGZwZ1l0cDJZQVkxU1d3WWpsejRv?=
 =?utf-8?B?aCszQU5wNlhWVjNxTkg1Y1JjMGdVOTNoelhURyt0ZTllYVFFQWgrUUVpSm83?=
 =?utf-8?B?OWtvZE9YV3hJc2xHNEZGU2QvYk0wUTlTOS9UL1Z2SHZPWFFTVmJ5bUMrdnZu?=
 =?utf-8?B?U1U5OU0yWitHeVMrOS8rNGc2OVJqMXlVRzZnSnlPdWQ4TnZQdTB6ek90RmhB?=
 =?utf-8?B?VW5USnpEOTdlNTdRYUc1eGs4dzMzTFphYlY4Y1U0dGNWWFQzT0svTisycTlj?=
 =?utf-8?B?SmYrQm5zSjlEeUFPZ2owYjR3QnMwTkRYcXZxQ2JpR1NFTlozbGo3cnZrRTNk?=
 =?utf-8?B?dU4yeU03TUhObXo2eEkra0RiYTdWNlZlZVhFSi9jYlVLdzkxcDJlS0tOcS9n?=
 =?utf-8?B?aHdwZHc5elh1Y1FYVFhWRmFmd1Z0UFRyaGNuQzRmVGUvRy9YZXBJamZlRG1l?=
 =?utf-8?B?a25lMCszTnJ3cEZSUEpodDM1eEoxOGpKdEs3Nnc0L3RKL2R5UnIwaTdYMVZK?=
 =?utf-8?B?SGRSSmJaYVhOWDJVRWtUbVJLM2Z6eFoxWmIvY2JjUlNUYWE5WEh5djNOaCtq?=
 =?utf-8?B?T211TDBFMXQ4WFlUMlJNdlBQeUtUOU1RL2p1enBaRzZiTzRtaHF5OU9RNUxR?=
 =?utf-8?B?dExXQjY5TFhuSE9wZ1Fhd1h2ODMrUWVOYTVtbytaaTR1c3VWVmZabkxPdHBs?=
 =?utf-8?B?dVNKa083dHMxMSszRVVNMXBqTFlmeElML3ozdDVaUkl0dFQ0VWZodnYwbDhp?=
 =?utf-8?B?OGI1c3pLSzlRT0loYXdoSk12RjRtUWpKS1k5MWo4VWEzU0JrNGNnRDhZbnhC?=
 =?utf-8?B?K1BORXlMWHNzaU53NWNKQjRsVGRqSk9LeC9vc1cxUlpoSEYwOEl3MWdDczZi?=
 =?utf-8?B?UkYvbURMenlOaFJTQ09tSmNJVE91YjdFTHZxRzRxVGR1ekFyRitlYmNINzlC?=
 =?utf-8?B?Y0JhcGNxTzRMQ2txK00yNUJZbFRxcUp5UTJDaGQ0VWhnM0V4UE5NOXR5TjZC?=
 =?utf-8?B?eTVNRGcxR3BpV2VYZkpCWSs4U2ZjbXI1OEkzdlIycHIvODlodnY3TnFFOUcv?=
 =?utf-8?B?YnJHOXozODBGd2ltblEva0FEalJITU8wTmlQaXBqUlFZSUpBaGphOE9pdFBz?=
 =?utf-8?B?Q1JWNnloSHVBcStmZ3Q1RDFRbnlDMDU5ZlRYQVJZODh5UW9OMkNZbjlYVXpK?=
 =?utf-8?B?ZStqR2FCSHAyelpGcTZ0aFBLejRKM1pDOU5MSkVwMzJ2aDY3QWJvRmxTRGFu?=
 =?utf-8?B?SW5VSzlJbER6Z3dsdlpuNmliQ1VQMGNlN1NJa3U4bHZtcnh1Z3BQUUp5Q3BQ?=
 =?utf-8?B?aW1mbVFKRTVneFJjSmtiZzJoTnU4NEZwUVhFTTgxTUVpK3pkWXUxckFkNmhU?=
 =?utf-8?B?dDhJUHpSWlpzY0U4Q0txcXRoSHBtTThUOUs2SG1FNzR2YXRpcmZOY1owVlNh?=
 =?utf-8?B?NUthMVBmU3NPb2s4SXNIdnI2QzNQQytWWEptcE9NcklRdmtBMWhBM2ducldq?=
 =?utf-8?B?OVdNQWRVQ2xtYW5hVEhCNURsRjdIQnFUeWZMQ0JSSnRtQ0J1SDJLMWYzQzBI?=
 =?utf-8?B?N0RicGliQTZPajFWclBnbjBHeGVzdEdmQ3l3ZDd3WXZ3a20zVXBNVjNIcTZx?=
 =?utf-8?B?dkZRdEpOUFlZbUEwVW5Td3NIYVN4dWhmelRJU0I1WitHV2o0UXZueGhuaXJS?=
 =?utf-8?B?NkI0RkdSQmk3VExPTEVQMFF2bFhsZlp6NEVQOFBDREgzTi9EcldWakNHTitZ?=
 =?utf-8?B?em8zS1BTemhONmpYR2xwb2ZuZ2wxakJDWEFYMFIzNVVUZUg2NmpUVUMvQXA2?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d0hzaWNveG51cXcySGdLOWQ5bm1Jbnd5UlZDdmlYNWpsYWxoVkRDdm1jemIy?=
 =?utf-8?B?K0lMcUtHd3pNdVIwa0s2TUdxckJIZ2lFRlhSSGhJaTNmSlY5WVhNcWRCZ0VI?=
 =?utf-8?B?UHJscEFtM0NXNGorMStaY29lVjl3a1dWM2UrbHhNTW9lV09iOGNEdGlMOVY5?=
 =?utf-8?B?Q1VkSjZEZUlOdnpUdmQxNjl5OW5rME1zK084U09YK1FSeExjKzVDYlYxQjFo?=
 =?utf-8?B?bHBCSnhIbGJVTE9rdGprd3VkVlljcUVTV2pWNzUzSzNPWlUrUEl3NmF6NGZm?=
 =?utf-8?B?VzlEcmlhTERHeUhYc1VweXJYVm9iK1hsMGwyeE4ya2lkRGIvVDdYU1o5dllK?=
 =?utf-8?B?RWZTbUQ3ZFVtUS9jeVBXMGU4dTdFaCtpUlExYkNYd1RiclYySnNTMGxJMkhO?=
 =?utf-8?B?VTVFaC96MVAxMlZHeVFTNnhpTXNDT3llYWQ2QzR4cTV4MDB0YlU4VUVXaTVV?=
 =?utf-8?B?Z2JzcTZOUWhPcHYvMnV4V2hkZ2doQWhzb081ZHJySUxXNFVJSHFFRlNQN1BT?=
 =?utf-8?B?M1RyT0dIUnhZS1QrcXp3Z3JoaXgxYVFkQWlaMzVKTWI0QzNGWWhiYnpmaG1L?=
 =?utf-8?B?ejVudkYzbTZ6UkpyV2Q2QzJjQjZMZ2liU1pZQThBQ05tK20rdkhZMUZkdmp2?=
 =?utf-8?B?bEhwelpUWHY5ODh6bktDQXpOVXBIUmU3OC9WYzN1Q3dDOGl0K3hsc0NvSEt4?=
 =?utf-8?B?UlpObk9VRXBYNW9ubTdFZGMySUgxRmU3dFRVUUkyYk1hS2l3VjdIdytxdTlz?=
 =?utf-8?B?R1d2OWNsY1crb1NWdEJJeEU5cTUvYlk5NFdCK2VIdDZkM1gySEl5aGxieDdp?=
 =?utf-8?B?dFVTL05MTkVrb2RrYkdVYmt2dmpXS0xNUWlzVnY2S0FFQUhwZ3h3NThGanVN?=
 =?utf-8?B?dXVOOTlqSStvT3R3K3dhckRncFI4RG5zaW4rUFYwaVRFU1BsZUJEYzdHT1ZG?=
 =?utf-8?B?dXN2TU5pZE9EUDU5TkZtZU4ydmdoeEpXTHdBeThsRGdSQzNTWWRVcFdJK0dH?=
 =?utf-8?B?MXpXcVRjc3lGSU44dkFJaFdWdXRYVTJsRjI5dUp0ZFF6VHU5ZXZERWxXTGo1?=
 =?utf-8?B?VkNibDZNazRWOExnRjlNYUk3NWgxYkQ3QTUvb3dYWEZIRGNCdGJ5ZlBPbE82?=
 =?utf-8?B?S2JvcWlUUUIzM3hSQTRMOEhSRXRqYzBFK1VoRUU5QzVhY2NORktzMkN3Mjk1?=
 =?utf-8?B?SlB3dVpXNDhNbXR3N29UbUNGS0J1Ylh1ZEEyUjRHNVB4UU5pRUNNSzlxZkNT?=
 =?utf-8?B?ZmlueGpOUUJ5T2RqOHl4bnVuMHdMbG84aU5aMUhSWWdGMHFjbUh0c3MzdG43?=
 =?utf-8?B?andKeVBnQ0NGVmdObEo0NWNYSUg1UTVGVGlIMDVRMmV1YitRVVhmTG9kSXZJ?=
 =?utf-8?B?WmYxZklhUWxCMVE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c63620c-8280-4d5a-45da-08db8b31c771
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 04:03:32.1099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzaG6Hpvl4oJhkhBdL8rPpDP9DxFUFHXbp7Ez1fWIrcSTAZUOzKPvjFcID0OaAGHkJFt93expjB9l/p3L4xMqQ5htRvpEz02y2aC7uhReM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_01,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307230037
X-Proofpoint-GUID: V99dD3xj_14zZWO3gEwgeyl2g417nY65
X-Proofpoint-ORIG-GUID: V99dD3xj_14zZWO3gEwgeyl2g417nY65
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 8:06 AM, Michael S. Tsirkin wrote:
> On Thu, Feb 02, 2023 at 05:25:17PM -0600, Mike Christie wrote:
>> For vhost workers we use the kthread API which inherit's its values from
>> and checks against the kthreadd thread. This results in the wrong RLIMITs
>> being checked, so while tools like libvirt try to control the number of
>> threads based on the nproc rlimit setting we can end up creating more
>> threads than the user wanted.
>>
>> This patch has us use the vhost_task helpers which will inherit its
>> values/checks from the thread that owns the device similar to if we did
>> a clone in userspace. The vhost threads will now be counted in the nproc
>> rlimits. And we get features like cgroups and mm sharing automatically,
>> so we can remove those calls.
>>
>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 
> Hi Mike,
> So this seems to have caused a measureable regression in networking
> performance (about 30%). Take a look here, and there's a zip file
> with detailed measuraments attached:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=2222603
> 
> 
> Could you take a look please?
> You can also ask reporter questions there assuming you
> have or can create a (free) account.
> 

Sorry for the late reply. I just got home from vacation.

The account creation link seems to be down. I keep getting a
"unable to establish SMTP connection to bz-exim-prod port 25 " error.

Can you give me Quan's email?

I think I can replicate the problem. I just need some extra info from Quan:

1. Just double check that they are using RHEL 9 on the host running the VMs.
2. The kernel config
3. Any tuning that was done. Is tuned running in guest and/or host running the
VMs and what profile is being used in each.
4. Number of vCPUs and virtqueues being used.
5. Can they dump the contents of:

/sys/kernel/debug/sched

and

sysctl  -a

on the host running the VMs.

6. With the 6.4 kernel, can they also run a quick test and tell me if they set
the scheduler to batch:

ps -T -o comm,pid,tid $QEMU_THREAD

then for each vhost thread do:

chrt -b -p 0 $VHOST_THREAD

Does that end up increasing perf? When I do this I see throughput go up by
around 50% vs 6.3 when sessions was 16 or more (16 was the number of vCPUs
and virtqueues per net device in the VM). Note that I'm not saying that is a fix.
It's just a difference I noticed when running some other tests.
