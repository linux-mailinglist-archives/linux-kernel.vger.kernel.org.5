Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F3577CB22
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbjHOKZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236444AbjHOKZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:25:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB6C1987
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 03:25:20 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FA8oqA022080;
        Tue, 15 Aug 2023 10:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=WsiUNPdpASrH5ss2PW8W9+VVpuu/ddVm8aeEi6KfmNA=;
 b=e6NEou0j3FAWBa2y+STaHaEXVBC045JAtJXbp7xWHQQkd49IrnXd7/AT9rpvpE3okW5j
 zXhsTuWFNhlLHLTSsg7gctOXALQdbI0kAR0LQDTtnHMwDTsWBL8s2iB87FFPRDwxJGnZ
 /46i8hY3macuZZDmWnbFakJSe2Orv9OH6M3NyQwOm02CyPWWdjjWZCk7+XhZQI/Y6Kxy
 2TgnCbxX6XmJBP3OS+bsQFCjm4Ezu5EeXAxZ83zbso4I4h0GaIE0eD7moZUuyKV+I/vB
 MDy4WNRppZISnE7AkWvk/B6q6gJQVDw6WNTH4XrZ16Ebv0OXm6jZ3/Zlqxi3qG2mtSfU uw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se30svdr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 10:25:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37F9VaYY019924;
        Tue, 15 Aug 2023 10:25:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3v64d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 10:25:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEeLJqpFTyjNQ6HX3sCqd8GB1ulNretW8Pmwnvgi31cl1EIEwuPE0zDWvBegVcI3YA67suR/lSCB0moZn+ll2WrNeCqzDc1Mb+blkNc4cSpkugcxRk1l8A8q3R6MtF7s1bxOoAjCIYWbSpNezM4lyQvX2VoIhe5kRG8xRfsYBga+Oha4Pi5+p84WDXTIyAxr+sLVSQ+O4vVrp1rE+qLZVSAhR7sJPfFI261hiQHLbn2hjwB1qQPzr9+wOhFPaIwaVIcmf6xLvInrH2B5M20EaMnDs2eNdEf/A/CUQfWGo35aLDuIkzoD+3/XOZn4LZ5t/d6Q37aypVOv4qGLOWWjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsiUNPdpASrH5ss2PW8W9+VVpuu/ddVm8aeEi6KfmNA=;
 b=aJv40EBHeY1FRXcfJ0t6UCTV0lL3btm4HRNI4LypueaqJwC5QqcyN+ZPnk4Mw+4ZkdPm6dnj0P39J268/lPTmKS0QNTt7FA8UwZRM8rh9v/oTWK/vYrO24A6cyYnpu0EvWUdfJ67AjbFDk1LSUKi4EJibjQ/DwP2F8QXix+TdqnBlEgeYcxfOi86o39Wb4NdLtiSXX8heL6d7dN2GyT2o82W6GkjZuLwpwNjNLcA7cfHNYpMj0sBRTAH/Xuc1a5GNtkv/eg4kGuGiJCo9ThxWML7abI58CD1Q6VoB7cvhNxH1OMn/FWKUCAkGCx1h6k2FP6LWpdiAh0qyheH6reMNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsiUNPdpASrH5ss2PW8W9+VVpuu/ddVm8aeEi6KfmNA=;
 b=0LBKnqFO9Wi/45On0RtPy0R9pxv0z5PCuJdcwOKqU8AKCP8i9GHshps6qYH1AR8kzKNGVLYedrKpRqmrAbezeBzDRSHIkzx33VV5DfPd5BMZD2Zl+58w64jXkkLvkY0JDSrRLC3JBIRlSHU73B6yUmArQEzvQFKjCWZM7wF+ghs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5384.namprd10.prod.outlook.com (2603:10b6:408:12e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:24:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 10:24:58 +0000
Message-ID: <80fb865a-eb45-e783-277d-0d2e044c28f5@oracle.com>
Date:   Tue, 15 Aug 2023 11:24:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 0/2] iommu/iova: Make the rcache depot properly flexible
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, zhangzekun11@huawei.com
References: <cover.1692033783.git.robin.murphy@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <cover.1692033783.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0108.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5384:EE_
X-MS-Office365-Filtering-Correlation-Id: 253e92d5-0953-4ba4-8a78-08db9d79e005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kJGBE88M1qZGENEmXjliQaFipdCL3dObb5SYebUmA5vL9TnBNQ95wuqe5myw4iXoTRMJALi54j2MgP5mBYU3DAhv7dlWxgiBxgBVesVxZtdRquMMpnorOgtnyhLo9pKYlXG5fm/DLRVWJcD9rVgFZ0HgR2ajwVe6+PSMhGv4OILL0SlWTO0qpDII4hf5ZpQslX80o9WhuPNlZhY8XpNtBFwGlsNBkZusQRmotmWLiwlF4P4OhlTyGilNJoIeNZTQNsML8n2M7lhOOinZyyqLxyddsJf6woR+yEQpku7a+EHQGJMlspln/PaXDKn+30Poerw3gqjcRSxSr+nNTsV/X0b7TrNgg/5lmccbhHU9dY/pLbrdkZiS3hMZHVH4mujn8zvlO87ooZQalsuBQBMfnS7kPWs7u+GHbuqBRz+0rBD0BL+rCQ/xanZXMP/wkMb/IrzpLJG87XtTADvvByHKOHk++6r+jkRy7496KfTp3K+jDMeyGt3sX5ByZPLpClMVb99VQxQ3RT3KFNYd/Wid+wT1WCozvMk4Dv7vYAqjmT29BMxOO7EJgvKBHo9M2yeDY66FQ0PRiUbNL8/0T6GuPh9QdAHe71go3iE2S4+HB6+bqkV+Fr3zQxQ7MklCHSQ5dr4Yczb9RhnfYtGcwVECag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(1800799006)(186006)(38100700002)(36916002)(6486002)(478600001)(2906002)(5660300002)(36756003)(86362001)(31696002)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(316002)(8676002)(6666004)(53546011)(6506007)(26005)(83380400001)(31686004)(2616005)(6512007)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFROS1VmQUcxV21Td1lDb1pEdThPb2U1ZFBVaXZ1MWZXQXlMV1BkQ0JQN01S?=
 =?utf-8?B?dlNkdyswL0RWdmZtNGlCSXllRFBWMTk3d2V3T1poeC9XaXRpNGQySXFORmhw?=
 =?utf-8?B?b3hoNWZXblJ1dFNULzkyWFd3Wkc3VERsbW1seFFKczVzUndoVFN0L1k2N2pa?=
 =?utf-8?B?Y1lYL1JtSnFzaUtOSWhKNVRiNTVjOUZzZUZzZjdyYUp3TmFxVFhnd20vYUJZ?=
 =?utf-8?B?dVVrVlB1VnIxYVVxcG5SSDVIME1oMi94Y0VxekRQdU5sc1ozUlpIbXF1U1pT?=
 =?utf-8?B?RUNqS3M2T3F4Y0xjbGZDd0E1dHJjcHluNVpNc1poR3g5QUNUTWpST3JqZGRP?=
 =?utf-8?B?a0E2c1hyUG81VU02NEJMNWtPN1NPYk8vMTd3VUF3YmlzNnpnWHJPR3dUUDBX?=
 =?utf-8?B?WUNtZU4rOFltejVEODBobC9BNEVvT1RDMGVGSnhya1poenpjWlBGREV2dnVa?=
 =?utf-8?B?dTVudFZIMzA2aGRXclcxdVdtTnM4REpjN2VYN2hFaUpRMTlPeWZrd1VwMDFZ?=
 =?utf-8?B?MFNkSVVrZGxwTmxpYkZCMkxnQmJnL3JOZDE2T1Q5UEFZbXpEWFh1QXlMRWZV?=
 =?utf-8?B?TjNoVFZBSmErZHpPaW1mQkJ2dXB2V0FBd0xid0RrMU14bnFqVzBaNTlJN0pi?=
 =?utf-8?B?L2lOSjhuRGQ0bE9vclZOQkE1dE9LaktXdHcweklrZm0wWTFDS3JOYnVMWFRZ?=
 =?utf-8?B?Zm9pQ3dCOURKam5IemI5eVVBYkZTa2ExbXN4TDhQTTRtdHRXbGNMdEV1R0NQ?=
 =?utf-8?B?V3lFL1VCRXpRMlZFME41bFJ4R09vdmlta20weHV5MzlndEd4UElDVmR2cnRN?=
 =?utf-8?B?VXRuN2VnYzNYU3dyMVVBMDFaR3IvODNkSitVZlR6RkxLeUNxUE9YUmltcC9z?=
 =?utf-8?B?anpKelEvdU9hZDYwQ3paQ3RxYW0rT3ZaOUJ1ZU8yWDBVVU1WaEFaUmJzWE8z?=
 =?utf-8?B?QkxDMER0UkFOcU8vaHZKMVA1ZGZzR1hjb1g1TWtrNTQwYzNaZVI2TlczeVky?=
 =?utf-8?B?VEJvVXRUb3pnclBGajQ3bWNhelZ2aWRlcmJwSEd6SHU0cnhkOHhFa3YvTyta?=
 =?utf-8?B?dnJsUnhzRFhDMGRZUGlSb3ZMQU5vcHJvVUFmSFFqRC9HZFFUQ3dPUHdTa0Vx?=
 =?utf-8?B?amRYa1h1bXRCL2lFaFpCMFl3SmFmVmRoc0Z2WHowNUtHMFVKVlRGNUhnNDZn?=
 =?utf-8?B?cndDMnJ0b0t5YncyZ0pYSlFNYVhPaE1tZklZZmRxSWc5T3orWTJnV3ZwZjly?=
 =?utf-8?B?dHVBRWJwZ1h5WlVrcCtXeG9yYnMvNDBZM0VmS1VkOVF0K3V3eXFObTl2VGVX?=
 =?utf-8?B?Z1RPdVp6VnRTZUhVa2J6VmhpcEhmTVJ5cGRrT2Y4YUVIR3VMK01nOW41QTNG?=
 =?utf-8?B?TGRFL1NOQVNpanRDSkMzVDlnVzJnMFVDNnNoY1hTTXBSaWhaU0pkbFQwdHg2?=
 =?utf-8?B?SGFYcGVjanVDSVBrck8xZGxQWFk5UWd2UHhNQURGbkdueSs4RktQSzMvQms4?=
 =?utf-8?B?SHRib2RXRFJnbGNyN1lXYnphalBNVTlna2ZjRjA2YnhMNlhSTy9jSmxWNEd5?=
 =?utf-8?B?MTJ5eFZRVWVKTGZpUVE3c0dQQll6Wk9pMjhPU0tiUThYZWZIRDdiTkxlUFZS?=
 =?utf-8?B?MjBraWZkNVZWTFBSd0xUM1pPQ3A5bUtCV1oxb3EzMGd4Wi9QQVdWUTJWUU1w?=
 =?utf-8?B?SUpZWHcrYlA0ZmxBcWxuaUFldE05VE9iVytCNVBxemtyZGZscGZiM3lhb0sr?=
 =?utf-8?B?SGlYTlJzdWZ4UDVIdHZyRGQzcElxbzV1QXlJZVh0Q1pIWDcxYW9Jb1RGMXVU?=
 =?utf-8?B?VFBDVG9ZMEVvMXhPL3FNUDV2Q3pqdXRDOWNCQkZzK2tnaWlJYVpScWlnQ2I0?=
 =?utf-8?B?MVNQUkRSQ3FmcTNUZjZYdUxtSXhsUnVkOG50V1JOK3IzWkpvWFJSb0RWSVVp?=
 =?utf-8?B?Rlh0T1ljUXZZOGxqbjlzc244SkxTS3pvVUZrTjI0UGQxVHN3RlpQVDBwZzd6?=
 =?utf-8?B?YWhWRHZneTlQTTRxdXY1dUN1MHZ6eVo0OXRLbnhCbWpYY0RkTWxibVFlT0ND?=
 =?utf-8?B?cHIvWjVVUDI0RUx3djNMbTFNMy83U01wcHNUajhBZzFwaVhwRklsVUFuaUNN?=
 =?utf-8?B?R1ZDVXZ5Yld1aFZudUd4L0hlWTlDNWtOTU5mdVJrOEl2anlrYUhuem83My83?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aZ789JjkKs5M9GNt4lVSklfqjuIQanf64uT6Hdyi6A0RqkZ1aNO9D3ImGwC4NljbuErYKnYPRiOFcIq2RhOsCOIFKafavEVebtbb9c2Kl6dmvWn2NRV9TRedVhnb/F/kTVmwYpRzis5lUWvoSPEbr8r3vhkAuDyth9gom7TnrMtt3FRcqAFcPfqQJt2AtYK2lFNsQPbbATZdrWm+6qYEpV62Xn120Fj47jhg7CSMl5+Q6xsIOBivj+F7N8R/2Aaq6Q8TUvpimmzApVaXpbKZi7EfqRjL2IOtna23K5+3HrVpvvQ0gj969RzSS1yXiPUt+w/2qLrRWK+ROej4Whn6Bnm+fb1keDYyc/Y5+LZwOwl0PqUvVFFIsmF5DAqLLy3WQ+BG1mGE1k1y6plVlW5ZauPl21ZPl9rxiPOxKe/w9t3G5NGf9D0tQPu32K354ilc0vTZgbLnvEbQmYFpOuGnQ0jJo8yjbgZ7+lVcqnOg/IwOuf5wSyxR2U1iRwodHMdxNU4sUPY+2AEtuupcYrZCf4knNaKvfuNPXSWgaPQKzt7wxW5Mdbxdk/PPQLP0uZTzZz2kphGIjdQiLGFtdXrNH+PGtI+e9pcYK9FdsbhLvNf6sRzescP+WTd07b8VahnoBp7VMgFvIHE0FZKsDHbx3AbGmZRNG+HKJfgn0C4wya9cabC3bi0WUeJdwx4v9zRidYLZ+VH/X+8CuuwkXoJBCP903rNVXhMz9VlkFuNjrEeE2WBKAhT1DoSSBdSPZDWc62E/Uwg+yrdP4JL2VGst7B/ihGkyRUSkt2r9LkqO3+9KhI0M3NNgzQrBrmoQfBtRODdnX+sqJ7uCGdDFRYamLbV1LEJwCLnDrn0F3vBQYgz6b2ueaTN1blNmroR+kStB83R+SsQOAcxqk7nKpkMemi+sW+pfx7vVohnpbeWd20o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253e92d5-0953-4ba4-8a78-08db9d79e005
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:24:58.0399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LGY7ED5nDmjy9im2WzDNVy83scZoMM0sB6HtzkSMMhf00/89d3RFYQ/d2DqIIOIrXARq+1TCNRMp+IxJ6e7Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5384
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150092
X-Proofpoint-GUID: 5aFFCBRZi-NghrYQ3C5qHqFv1iniVunb
X-Proofpoint-ORIG-GUID: 5aFFCBRZi-NghrYQ3C5qHqFv1iniVunb
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 18:53, Robin Murphy wrote:
> Hi all,
> 

Hi Robin,

> Prompted by [1], which reminded me I started this a while ago, I've now
> finished off my own attempt at sorting out the horrid lack of rcache
> scalability. It's become quite clear that given the vast range of system
> sizes and workloads there is no right size for a fixed depot array, so I
> reckon we're better off not having one at all.
> 
> Note that the reclaim threshold and rate are chosen fairly arbitrarily -

This threshold is the number of online CPUs, right?

> it's enough of a challenge to get my 4-core dev board with spinning disk
> and gigabit ethernet to push anything into a depot at all :)
> 

I have to admit that I was hoping to also see a more aggressive reclaim 
strategy, where we also trim the per-CPU rcaches when not in use. 
Leizhen proposed something like this a long time ago.

Thanks,
John

> Thanks,
> Robin.
> 
> [1] https://urldefense.com/v3/__https://lore.kernel.org/linux-iommu/20230811130246.42719-1-zhangzekun11@huawei.com__;!!ACWV5N9M2RV99hQ!Oj-N3yDamuhrlNTcuL5MA2LQRVf1EwFxQU21BMXSFBR1Fb3z4H_on1uiFG0EOoYpNc-FKGeoKvw9wzEV_1TRcr4$
> 
> 
> Robin Murphy (2):
>    iommu/iova: Make the rcache depot scale better
>    iommu/iova: Manage the depot list size
> 
>   drivers/iommu/iova.c | 94 ++++++++++++++++++++++++++++++--------------
>   1 file changed, 65 insertions(+), 29 deletions(-)
> 

