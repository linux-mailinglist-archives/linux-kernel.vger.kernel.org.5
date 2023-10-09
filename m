Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3037BDA98
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346404AbjJIMCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346349AbjJIMCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:02:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BF194;
        Mon,  9 Oct 2023 05:02:33 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 398Ms9pk023461;
        Mon, 9 Oct 2023 12:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CSxam5t6EQ1xhcatdin/SWLqLU9gwIWH1vPsVFDQms4=;
 b=YYSBpNj9O739wYTCp0NpHMdLorT8uvKIfJu/jNrevEtLQ3va812esxbRP8HDowjj+x92
 h3TQcQ6kl8hybP8wERCM+nic/Qc1jlZPP5Ir9lNGnJBxwcB8nQE39XQJ6PEB6TOTPsCH
 dJJxZYLbWB8zsFqgMFzM/boiXBiRhRoE5FHKsO5jh0+EuIyOYPHSBNmMg3nigmPVOdCf
 rSbykTpYmc37Ty5YwOxK+i4IrdU1QZ0wDY74bR+g5WM5HvI5UP/PlkvukMGwufIAMe0g
 wxRiZB4NrAA1yGd4YU3HvAdAw8wIC6+Z+X0zpU8O9fVm2hCHiYVhjH7c0f75Y615j6Y4 iA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjycdjjcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 12:02:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 399A8afW015021;
        Mon, 9 Oct 2023 12:02:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws50dwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 12:02:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABnYySE/ZR3FhwsPGBCXeGlSf4Qounp1OBiMqhmsLYtu/4skixvZl8gjQZpIAqD5Iaj5RNcTr2rKkjSGgVi8MpealVBPe7Jz8NmOq7VpXU95IGfPRupu8I+IfpTRxoX26hJImQIBm7Qw8eU3YDe6iC0wADf+gb3f4L9RiXOq/CmRSWqyjyxc+kyxnWut0aZsvgTS7pSjrGBgZytln818TkEvkMYa5EoPi4Ffw4QilEfp/KrDo8DjXl8Q/vk0ii5MLCfliwQU8FhfSfKVvkVzWkOeAp3qRuRKNJl0R/0hbGcj8nqHPaHzkeDj5ZD5f8fw715sJ5FmDzisDB2MAH+sVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSxam5t6EQ1xhcatdin/SWLqLU9gwIWH1vPsVFDQms4=;
 b=eaCCmn14SVTQ0tnzbM/e3+I5QYuFe9ZF9GbrSrus0nidjhkZRcYH7Rvm9cVwqedWHPJ0Mtj0NB3h7BpE3RYY2QQtF3DZMrvlCNNiwfkytdAQw8ppzA+BGeQupTyk2DpcXW/7bCey/wU2Al9k/VG3qsbixwrMCliQHEBepoYDlCJ7keoS9YB+bQ4Zqk+qNMOb/+pHQNYvcfnXd60zhFMFHPY0zm73IxgD3JmHpXPrQmw5ka9zTHzXntqORXXm2KgJJnfVwqrZdptWANYxAMU4seRqNl65oShvnIL31QUQbbi+/OfaMElg7XtjApPJS6WpQvoyS7Ezy/N+phn7L/icMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSxam5t6EQ1xhcatdin/SWLqLU9gwIWH1vPsVFDQms4=;
 b=LxbtfGeGqwGrkzWmeXOn6g8ix/LcPMxC+OENBhzBjDZIZoqfG+1scHmovhnKi7uxDVR0nRYr2bf5os33OPgOhDaNzDgwFZ3jQ9I57vPcc4uXHPGjuptfQkRidNZ//q61JK3ekepkP0U0GlbYJI5rDBVHB2G9fYg5TApLCpZNiYs=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by BN0PR10MB4837.namprd10.prod.outlook.com (2603:10b6:408:116::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 12:02:23 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3%3]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 12:02:23 +0000
Message-ID: <7add9eef-0d17-6692-14f5-968a4d4778f0@oracle.com>
Date:   Mon, 9 Oct 2023 14:02:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4.14.y] drivers core: Use sysfs_emit and sysfs_emit_at for
 show(device *...) functions
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     stable@vger.kernel.org, joe@perches.com, blamoreaux@vmware.com,
        linux-kernel@vger.kernel.org
References: <20230922121454.2735355-1-harshit.m.mogalapalli@oracle.com>
 <2023100737-enchilada-angriness-2a42@gregkh>
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <2023100737-enchilada-angriness-2a42@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0020.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::25) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|BN0PR10MB4837:EE_
X-MS-Office365-Filtering-Correlation-Id: 627c44d8-3c16-42c3-5cab-08dbc8bf98dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7LxMi0MpBNHY4uAc7VfoOnWOgL6dMrpLTLa/8yEj5NkiKK5gMCJU1vNSSC5/pOB6aCikYKLuLT69QT9algDefJnSy5Tn3fi7w5U6Xn9VYrjFG2bc+ZGtaCGWlR2REWWv4mGdvM7Y+5mmomQUI2UnP4yzpzT/jxhZNXqsgkGCVNmBBsk6hIWLx61u8ZQ00/Hfe22b3DpxhatGU/7dt9qQxFAPjH8fOnu5c0I/OMJvyQwZBObZgfSVcCxtPAh4/d45nEtWFJ8m24dfL7JeP8DT/vZMsh4uVXclv39n03586QRDCE8zIWmKEMOI9ThK7tbreqo04QOoGYEBhYAiq1ciLIGJNzi56naKkWTHZjOsGWbtKtZRMeb/IVxuUhiSr+NMGi7S1C0YsDta+LOy4Vb00R4JijEFSc5WD2TE/qd+TulzNptFok7N8Hde5FpdeC0hO+px0IEMIOmoKHfbGcltemBBgPz1iDZUcd6y7MrVTwhsF2IOdFgs4FpnBRSBailt1UAW0+DY44Wt+VlV6ysLyx/cCqIxEaygMzizctW/6z2MX1JJWpC2IJHm7aVj9oJ06BfjZAqslmhOk4KeDv2qniuNPDNOm+yy7EvedPT3J6rriKbydA09JEDpjd2/rzKKT4GYWjhDlHW8kMr/9yhrjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6512007)(83380400001)(2616005)(26005)(66946007)(6636002)(66476007)(66556008)(110136005)(316002)(53546011)(8936002)(8676002)(4326008)(44832011)(41300700001)(5660300002)(6506007)(6666004)(2906002)(6486002)(966005)(478600001)(36756003)(38100700002)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzZMbEovWlk2RFBnbG9WVW51a0k2WHF5Z3F3UGVqaUJGeEZNcEkrYW51ZHd6?=
 =?utf-8?B?L1krZnJRdVVPMUxYVDZoVHpzSmh2cmlTeC9KZGY3ZVBQbkFTQWRlYlpQaEdx?=
 =?utf-8?B?TlJURWNzK21SWUhBT3o3S0Z1RmxyRkxmTkx3ZUQzdTNnMHdIeXluMEwxRlRC?=
 =?utf-8?B?VVRxdk52ajhtMm5vWWJGTWxYRTBFdUl2THFoR3hGQ29ZczhPY3dXRjcvK0lO?=
 =?utf-8?B?MWlVU3d3d2dVVDVWdXpZcG1kcXN5blk5VE1ZSG5UZDVDdndLb1BsSXk0TE9i?=
 =?utf-8?B?MWVpUHc1QnBoWmQvQnNweDlENmptQldJTzBwemQxL2k4VG1sNUh0RjJETmIz?=
 =?utf-8?B?VEpUaUtsWEo4alNlQmtMeXVQcDBDKy8zWWJ2eHNabERXa3NBYnlqYWpIc0Zp?=
 =?utf-8?B?OHd6dGpYWE9WWHFPSnVLQUZiTEc0dUNPY3RYUFlYRnlhSmhoN1B3YUFCOEtz?=
 =?utf-8?B?YnVaTTZJcS9aZktrVGJkT2ZnMXRXU2FncVk2YnVuaE5oOXlPRkM4ZmtsRFht?=
 =?utf-8?B?aEtFbGZ4Z1FKRTZ1UmlrMUZWNGpuTWFFR2ZhdXVnNkh1eUY2Q2VLaWFsMUNW?=
 =?utf-8?B?SGFhb1ozY1o5R21KMFZ3bFFCVzBvQUZKa0xoVnJYR1NWNjFocXhPYkZyTURm?=
 =?utf-8?B?cm5Mem1nQ0ZOMko5amkvYmtCT0YxWjIzV01ocFRqVHE0TGZuRFBkNU5EUjZo?=
 =?utf-8?B?U0laMEZPMnhrTXFnbkRoRnV2OE91YzVuRmUydGd1VzFVRG8wemRNWTlpYTNq?=
 =?utf-8?B?MEh3cWJud3EyNUY2MGpFbkllYTRsN3ZQdHRRSFhKR3R4RXlSVWRaT214cTRQ?=
 =?utf-8?B?NXF4UWRkUGE0TUY1Q1hLVlgrUDNiT1hLYW9CeStLbUpxSUpHMGh4RG5tQ1hD?=
 =?utf-8?B?T0NSZ2oxRm00OUg3RU9WaGJnK3NlUVpuazJreUYxNHludklCYy91MEc5YUVU?=
 =?utf-8?B?TkxKb3c0YmRBRlVVSkxaWEV6OUJXQUdsSHBQSGZOVW1CNVY0WFErcGFzT0hI?=
 =?utf-8?B?NXNTY0VJY3JoMFQ2RFpPWHpXaVFGbjYvQURkQUhYY3ZNM1FSRDZRS05sWURF?=
 =?utf-8?B?em9ZVGJvVm5RMUZoNTNwK2FUQ2p1bHpjc1gzOHpnWmFBQTQzVnJOSXBiblJv?=
 =?utf-8?B?bCtCSTZXZ1RKcEZaWXUrQjFlOGVPb0lTVFhZUnhsdThNRityLzV1MWhLaC9D?=
 =?utf-8?B?aTBYcGlqNVNRdzk2dHNaMFZJSnYxRXBDSkF3MXpOR1Nxcmh3bkhHN1d6L0Yz?=
 =?utf-8?B?WDZEQlVGbVlWMkw1VEEvWDN0MFJOcjNPODhDcEs5czVlSXNXSU85NXRRbnF0?=
 =?utf-8?B?WDUvZlNNUGFtUmNiRkVvTDJjRG5FYzIyYWZ0R1ZRbkNFczlJT2NvMHpRZFg3?=
 =?utf-8?B?ZFl1cFlabDVBbUdCcHlmYUlncjFIaWR3V1oxanB1SWhkdGxHaHhtV2g3OWp4?=
 =?utf-8?B?Z2FjMkRNVWtSR3ZkalVORUFJMXRKaldybkFpSjZMeUVqNVdWYWVsWWVhR0Fj?=
 =?utf-8?B?NGJBcFdLV0VIUE5YYzVEbzF4Zk9uQTJPOXYra1VhWVhHREhZaVE0V2xDNkJL?=
 =?utf-8?B?Z1l1MmFvd1RJUGxyU0ZWUVJsTTVtL0s1RlQxbjIwa25kcko1NFpadWhDeVZJ?=
 =?utf-8?B?WWcxU0dZL0NnS1JPdndocGJlVVZGNmZmRDhzd29BNHRWQUdWZ0NxR1ZjYjFT?=
 =?utf-8?B?SVl1N1g5UVNLb1lPVjM4N0dKR0VRZmo4bkZNL0dSeE9aTWhFTXNCWnRwSk5R?=
 =?utf-8?B?Q0J1OVhUbHpuaE5LakQrN21RbkJqbWF3Vko4eFFqb2gvVGJsN2VPWndxSStl?=
 =?utf-8?B?b3NuU2pmWmh2bXRpbUQzc1JQQzBpQUZsdHpBNDYzYXhiZUx0KzFPZ05CdkNN?=
 =?utf-8?B?NTJzM25Cc1RZcVZtakRnV1pSY3JRcmlFM1B2dWlMc09EbS9JNzFIQnU2bThB?=
 =?utf-8?B?cDFISGxUZ09MeTBtZDJkR1lJeTM3bjk1djU4OUpGYWhGRWFKZUhHVExLWld1?=
 =?utf-8?B?ZjRCaWhyWlBrNGRXRVhGK0trUUJ3ZWFmWms2eXFmYzB6V3hOMTRDM0xkSzdl?=
 =?utf-8?B?dWNzRWRqaUdWSXVoTjIweHl2cUJhN0g4QmxKazRyMDNTYStkeUkzN1dDZVo3?=
 =?utf-8?Q?adUDO46iHo9v6OTSpPKs/idsC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iP62MLSfuEJA2dijeN0DY0r1cBRf9iGAIJP33ILWwQZqass3l3JvlG6UbAHQaSVdXUUQNh8TiP9uyRrhGawvDIZV+Wo1ZPurKdfnMN7pvx0txcMNOxGXVHKILJ4ontSWleO7qJplKtCVf0VovoNHQt8A1+1WYIU++51wAYto311epl+JS/9wdV1YSJoz1YXg+b+5GBTlv+LPZ+mYwe0KHo6JAMJtqOS7v+H0GefCot9hPJqj+EiQuyr/54Bgm7AI0t30jf4omWXzBnU8Hi/TsmSDIyOLXTHIm2YbFcV/FfJ0ikzeqVFODe8ZkQIVRHiX3leZXTCscE2RrcxtxjFIWtQFFKHHX+3c/zZ86WXOP1abFZKo3BKjDaWGgV4NygM/bc0p7bAfZgv0ldGbDcVPhxyQ5PMwkdhEpLFrtkRmQ52sFjRTTzrvULI78DebotmCWjQUK303PelEnbP2HeTNuCeRe9vjnWAzBbxFc3CfSb+HfJ5r8W/dnuXNItK1gdG2nltAld7/Unw68T7s1+lB+vn6NC9C5N8h2q2HhkBaMXxMjz7nGSwoERV1XuxyPoKEJU6WR7WXv9Hi7gsbuNI3EFu5ZNq3eD9DLFvDwM/pfdgkooU7RDt33UBrbpG+26jcOwecH6v36KhHk/IIM2aTAk61aCoc1VLjaJUQJd4/FSb/XKNsBC3ejWoSlmerHg/gn8xJop3p7x/d4E3FSyJ+uzRkWZR/vgOGeaslsb+IX6mBSfDUB59WqnpW4fmE0VCByynTyQ9i98JxHzyfEQq2MO0IN789ItD46g119ynuJsb87bC+W4oBvCS9u2ZwHIS0PfPsuk6dWmfqYywcUcvCmZQtV/qxOAHe9athIQosVhcyMS7VNepSCsI3jbFXSfp6
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627c44d8-3c16-42c3-5cab-08dbc8bf98dd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 12:02:23.5821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzwkuZrFu3KqJ7OBfefN0PAfBRfhkF6JdqT850oPFBv1sKAMOqrsFQTdGIBz3KcUCSFaiynI1ShOOEc0i0Fdl0z4w1SJ32yl3gPKyQ6U9Yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_11,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=949 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310090097
X-Proofpoint-ORIG-GUID: D21vfgEny8gFfCoFe8NwFAz4Ced-sDN_
X-Proofpoint-GUID: D21vfgEny8gFfCoFe8NwFAz4Ced-sDN_
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/10/2023 13:21, Greg KH wrote:
> On Fri, Sep 22, 2023 at 05:14:54AM -0700, Harshit Mogalapalli wrote:
>> Signed-off-by: Joe Perches <joe@perches.com>
>> Link: https://lore.kernel.org/r/3d033c33056d88bbe34d4ddb62afd05ee166ab9a.1600285923.git.joe@perches.com
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> [Harshit: backport to 4.14.y -- regenerated the diff with the help of
>> coccinelle script in driver/base/ directory.]
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> ---
>> Only compile tested. This fixes CVE-2022-20166.
>> It is not clear whether the CVE was assigned for a demonstrated issue
>> or just a theoretical one. In any case it's a good defensive measure
>> against future patches that may introduce a real issue if they assume
>> this patch is already there.
> 
> This is not needed in this kernel tree, so why are you attempting to add
> it?
> 
> And if you have questions about a CVE, as the entity that gave the cve
> out, they are responsible for it, not us!

We weren't sure where exactly the issue was, but figured the more
cautious approach would be to apply the patch regardless -- it does look
correct to me at a glance (doesn't suffer from the issues that Ben
pointed out with another submission, AFAICT).

But point taken, this falls under the "no theoretical issues" stable
submission rule.

Thanks,


Vegard
