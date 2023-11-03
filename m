Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FC07DFE8F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 05:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjKCEbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 00:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKCEbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 00:31:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2405E1A8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 21:31:33 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2NOHV0007300;
        Fri, 3 Nov 2023 04:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=nGloLzmFrb/QVrfKz/deW610MoURXAGq/qn5wXpPXtk=;
 b=bvu/vPTLIWfX0Ven2zLV5I7SAvnw4ZlQw/+4wI/KMZj3a71qnoCAjbNIHlcFqVxUsTnd
 romaHdOIdNGFVAQWUU/lmAuB7B9iJmqvqeGuBxRvp1CnW4Vv54hY3zAHVDvxu/v9Di5P
 OeISu8IA651OwLjGoE+BeautW/hgqdkXnLtwcrSV1jLGJ/AQZPIDMZWP8+k4ixuVzXau
 TynoOkxixf1bW7p0uNY9FQCzwHfiNr42ziFUtglRNmTlPX+79FhNRjcVRBPedPsJDg1t
 jagzYoaKSt+KhzQgOmmI875gtOy5+CrR0fHVC6oj3AnVene43lkzSyaJwF2IBO4b30c2 5g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tbdu9u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Nov 2023 04:31:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A33Rui6009214;
        Fri, 3 Nov 2023 04:31:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u14x9d7e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Nov 2023 04:31:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThAahPBTRBmSdtLzTJ03epCzkclhcN3L+NRppDa2JrRB+N7jxmATbmfHGkrmi9oxFRgI6psDHo2Yk1DZ6TSTrdKM3pcQFa3Qdrw09x5wG//jiPcwsUhRtN+UX0cbJmAueH1/e4OGG6N53JBTw+qTFDc5HjO9yMEpKRdvmtoSkYcHoML1TVMWrOXmhgu9jhuGFl7TqIDp6suEzxkc8t9urowdmrlgSDvp3POCHsX94viE5BpaPsNpe0VYET8o1EpdzqYpP95PrRCUa/F4jR/hzp8jt3nr1GyU9v5Si+3TXkDYS1Uukpa2kDEr63Tb8x+KsOYFHbsrp0CmlaQNS+HVow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHBZk9rsCmdQ8hcTpL/FQg3+UtkOSDgmLJMxYRhFIW8=;
 b=kADgxP2e/w0dZ9PkkG402BeyKwdS3sBfXJ7mMiJsh3Jbu1aAn0cwrOPy7PkoBrWc4bcLBYyZjwZORYYBmILhcC4z4BGLN2NLrxg1anf2yyikWWZgF3Lq9GZ801TsvKW0Dh3E3iZiP6HEJTfdeE+rgNwAx1SdWSK6VC6SgSBZ9mCLtFqGrxdt9/Lsi8GQgJfFiIGM/6eDPUQRjAwha6byE6utVeDXSP4T8ISStqIBFqT0pylbk5O4uP87rtSFF+79el0YjSQJ05A3fNxiU4WrtRu0zexuaP12WIMxXQ0Y2A5inn7MsXvuab6DwFCF6A7Zwu5qhLATNM1Bhffy5GdBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHBZk9rsCmdQ8hcTpL/FQg3+UtkOSDgmLJMxYRhFIW8=;
 b=nz0XeKFoEa/zW0TC3sHWpPlkrRhRnEidVKgD7UJcwVSHRXx2hPvv/zW5X9xR882ImbU3TBAiYKefYf8hNw9wEEKQnabq72VCaZvri64lBA8X+A4qu3a83SNo1x71YKP9eRHZh32/zGeTT12LO8y1rq89OlB3NYicn1IJmfL0Nqo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA1PR10MB6518.namprd10.prod.outlook.com (2603:10b6:806:2b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 04:31:07 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0%6]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 04:31:07 +0000
Date:   Thu, 2 Nov 2023 21:31:04 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Edward Adam Davis <eadavis@qq.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, muchun.song@linux.dev, nathan@kernel.org,
        ndesaulniers@google.com,
        syzbot+6ada951e7c0f7bc8a71e@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [PATCH] mm/hugetlb: fix null ptr defer in hugetlb_vma_lock_write
Message-ID: <20231103043104.GA245368@monkey>
References: <3382634358afa9b95dc4f6db8a53a136d4b9e9cb.camel@surriel.com>
 <tencent_164A247533766D667C3D873798968236C409@qq.com>
 <20231103022426.GA3531@monkey>
 <20231103023737.GC3531@monkey>
 <48ec0dd17f048541dd83f7ed7cb29dac91d8c607.camel@surriel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48ec0dd17f048541dd83f7ed7cb29dac91d8c607.camel@surriel.com>
X-ClientProxiedBy: MW4PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:303:8d::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA1PR10MB6518:EE_
X-MS-Office365-Filtering-Correlation-Id: e4674855-6834-4ebe-bf24-08dbdc25b237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TrRNNKdo02o8wGUkwyPG73XSVU/hhAA5myjIJ3ybw9+HRjzU8xQnTpre9caoePSZhbM8moj/iYy1oL0ys1HEgI18c7ywtH/3JkNTZLi2ejxeTNagoIWwTuYr9VHcjhnZoG9fMyWWJ2JbU9bhViukBQr/VlKVHsj5QXKsUNahOoH3FEFvYitP6RU6c6t2jlY2p1CXgtnyvRLF64BRAEs8miD8xODO5ZM5AFuzAUMeHlQs8is6P5Gq3SGwRbcXpWnEihqbhNYwhLJSulC05mHzLERscsIPm3KDnEVUTEQCbxWV/gTQyWq6MVu3G4S4CDMCNO84liuYti9R2Nu0pLiFizvFy09KyVFycN9tC69c6SImQD5TId0UfM7ajlYRu+5NHdorsA8o3pe0BUYWm7TO6IJm4JzvlqW7X0KU7yY/OuHnYINxUl5tXz7AGyZGdVjKw8eF9lNdI/zx8u7bI8LRoNjgC9yPDuGxqgImcaXeN18lCRuNs95Y+7WCB7IoQMnGFZdz6ySaz9H9DpTcfvpR1UCnGXU1ZUOFPHiqI9euZoDbDk9tSJGfxtUx+3+lYIiy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(376002)(136003)(346002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(86362001)(33716001)(33656002)(53546011)(6512007)(6506007)(9686003)(44832011)(1076003)(66476007)(66556008)(6666004)(6916009)(316002)(83380400001)(41300700001)(26005)(7416002)(5660300002)(66946007)(6486002)(478600001)(2906002)(38100700002)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nF9zQIsk0fosl8eIwDsX9q5OMpTAxc3YDCOigBq+YWfLxnREAu8SYi8DYi?=
 =?iso-8859-1?Q?BO/Igohqy72D1hTO6YRdkJ10wi3TwfzAxUGeKIr3/A3FHlQlhk3s6ahMQ4?=
 =?iso-8859-1?Q?iKFHNBzXjmuDbd4aJLVQjQ8Be5+e34BqZS6W55zrrsJQvf+7uD182OyYGI?=
 =?iso-8859-1?Q?Nan2H1gfFUi5pZkmFnQfHyH6XfFTh9pXm3GkwDEy+FuUap1SFF35eCvT8U?=
 =?iso-8859-1?Q?7lHad5ARmSJWQbYnCQ8xbwf0G7Te7Z3qtqs2p+LJfRPFIxCoN4BltbsjZU?=
 =?iso-8859-1?Q?xUgebWAqac+mJr7/ZYcmTmEBxHWQji+T01tsf9gPMJbXDRzqBRy+jW51MN?=
 =?iso-8859-1?Q?5pF0v6AMTeHylkal8sm/sTbhHlsRF8StFZxHJ4HAce5GcgX6q0S/tMMGK2?=
 =?iso-8859-1?Q?obIKL3gOqY7+IAXjCYdEKgyXlqbACN3jDQ5aEGfsNjsYIDpAPRr3GJ2gvz?=
 =?iso-8859-1?Q?jKjgL+TVxFDjgKh02pWG2QHy7P+T7D+dBbBaSzuWFdUr8xfmyOLZOWKXXw?=
 =?iso-8859-1?Q?rueF/eRC7I7q2DQxf3d2wnT53B0li+gUCwn4GPl79eaSWBnMsYMDpmuPe3?=
 =?iso-8859-1?Q?eUqTPAvsGd9ew8LQCLUuujt1LrMAy3WItBpS00qPvI+qhIZkpTQVFvnq9y?=
 =?iso-8859-1?Q?aDWSB2LSwTjGQITP5G/XXb9VCJlWDxjnJZbe4cRYbe5iBOkGASCKrk/InW?=
 =?iso-8859-1?Q?K/hT3VI37DoXW9BeE508iLOQaq8wxUf+CRIQXxsVn3xyPoGg/lHl6JcAgV?=
 =?iso-8859-1?Q?+nFN6oarV4jO22yS7tPjKq5ibd0Lx1kZGALgtgVnJq8DV1iICI7nwvFRuL?=
 =?iso-8859-1?Q?XNtcAtY5xzjhZ03LoEFLnIy9rjW/py6EU5gv+VqzXQQoYYtafuBjCIAQgm?=
 =?iso-8859-1?Q?lNNB8xguHCyYNEiqhxzrCr7M+hvtEkjqVJOs0MZpAxaScQSjFpoCaI9HkB?=
 =?iso-8859-1?Q?OOcoHkfpg09s9odzrmffa+EZbJjyx1Pd95+ewMVLeVg7XnQwFWWpCum72n?=
 =?iso-8859-1?Q?oWh0AzZghccyvkPz2ZWHJNiablPcL0zZFywcqUEhwqfW8upBVNYoSSC1T8?=
 =?iso-8859-1?Q?0ovAEI/29K3iixoKlBgaOkQU0xnNxuJt954s0of0fR5IFi9Nu5UbGxcgbd?=
 =?iso-8859-1?Q?TkWIiqx91PYSzkGmsVE/sf5fbhOC7E/X9AIaw+bK9IZdvC/de52GIWiwJm?=
 =?iso-8859-1?Q?ckSN7A7wb0X62osrUgcZ9pI/MSSEHHDAvRT3XhvqcEEu6taR2CL33JCBIR?=
 =?iso-8859-1?Q?Efxty53UDmN1WAwXBr6vcWV+jiaaDzXLCYqzTfycPzt/wlLwQm8I18Jc2l?=
 =?iso-8859-1?Q?rWET+WLYMpI+/E5KI3+w8EWrr9woOhSiQOnOEicBNaE5fEBudc6s2sHeKw?=
 =?iso-8859-1?Q?KF0uQ9rT5fUrckMsw6/JEMR5dVFq7kn3XXL3PP8WyEk6pRQWzTcjoAiEKA?=
 =?iso-8859-1?Q?SD4GXglicG8OMrAZ7TblWmzH9M78ARHUszYa41DjkX3KSurPNED7AoHoYA?=
 =?iso-8859-1?Q?3fIOyAs51HbRdvPRuR/uO4wOLDxs9sH//P4RCI5GoyyTypaOnbYU4MLWgL?=
 =?iso-8859-1?Q?/WwT/t77VxePga4CcokKXN/sK8YC36qrJWnuPWLtnWyXb3DhvNaylbm9d+?=
 =?iso-8859-1?Q?6TYBN3YWszt0C7l9A1zscd5rgxX8HHJcTO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?NgTz9/gF+PasL8B6q8TJoFbF3t3v/46LDbegMxaZZl8QuTpp7JJ1XMuc40?=
 =?iso-8859-1?Q?G5Y3xDNVYZb6YhbDpLghUjbsilTmGaF00+yI+MQ9O5WlKQq3+wK/MZNZpS?=
 =?iso-8859-1?Q?DrxKiiInFkaBqH2h6xoG9QGz0RuhIlHVtQwdlTnDulZdsP9mBHzloh3upW?=
 =?iso-8859-1?Q?2AsTlhCRS5z3PxpQmZUZwh++VYX+5q8z3EuqUMXE03hJL4+rbUOlxcmiOo?=
 =?iso-8859-1?Q?kDqgT1y1yvSHRPy30/e6kw3A4hEAGSkWZ7doa4QbgNLf445CAukK/kFQgL?=
 =?iso-8859-1?Q?VxjW3iBHN8I2r4w3K1NK1DAQTT70nR0yDEINj7TDw80BER7vCQYOdguLwi?=
 =?iso-8859-1?Q?NxG6S2yLBU0kzcBCwK1luU+O52El8IcWPFo/RlE+Y+h/xNW+xXpY91u098?=
 =?iso-8859-1?Q?u0QPbSAk/qmiIWjnlUMNn48JMAVgtJunL9GMOvnqg/7H9YbWLb57gq2IX6?=
 =?iso-8859-1?Q?k1tKpJWQeeKOpXk7RemmWvFUh8YUYGmtlnmovO1UbG0tBbNt2MlqsOJ94j?=
 =?iso-8859-1?Q?761qINzI+Z/lNNrNXgu+BUOf7Tfm6tExGpy6tt7I/QMRAGBqAsh/Dsw8Ae?=
 =?iso-8859-1?Q?aYorBmegZZl8KhFcOTSuujkmXSp7KnzfnuuDPJz5hoRR9OHUZInt1tfFww?=
 =?iso-8859-1?Q?c/laqH9v5Z8tFJqaGv4FWpoG/51r8Hih4ItS0sctCQ8MMoT95bSAoKpRKK?=
 =?iso-8859-1?Q?2n2GOPbH2/nL/VMIz3NhafJOOpZtp8C+6HTmq2294Td/RxYwTE8VCRD0VE?=
 =?iso-8859-1?Q?30byd/7U/kK0PE6gLFZXLaemOHyN1n9B1cv6vz31MceW7T6sibDB3C067f?=
 =?iso-8859-1?Q?SPZ6qv8VFaocK5UO/wM7CMocF5uSDbf1Icqj1cPDI9m7SUd2fz6yUFJ5eR?=
 =?iso-8859-1?Q?/fvk0uAOI1R/Hv54Aor9yk9Vl5+jWYvNG6XauBgRoTTqvsjUfEMa+7/+af?=
 =?iso-8859-1?Q?B2ShlIk7KKMBGeFVSMcPXaQIeHCASJrL+8WGIC4KbLLkocBLKlPqwza7+b?=
 =?iso-8859-1?Q?nLU+JUSFVsI0ozzTFZBXkpfjss8Doj5oGGrLVcIcbd1xArNU+IKyAUWs3w?=
 =?iso-8859-1?Q?IoYBhJdMwxwp8a7Zn+x5IR+ne8pAewfi3+SaPEmkfyh8oIWy8wzLYeIasD?=
 =?iso-8859-1?Q?lPVbt15toLGwzHpbTD2O45uafLQOb6sKcG4jirsuIBYICp53S1ghelZr9y?=
 =?iso-8859-1?Q?G896x39b6fcp6bmBlaAq7kuJPMsXedZVVI0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4674855-6834-4ebe-bf24-08dbdc25b237
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 04:31:06.6086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ep6h8fAl51Xlgk+j1+EZKCxiyz6BJFKHDQU9EJaQOMdmfGY3fe0kdK3RaNmvm0GyTqXBtrD9Hvh8yK8mEh4DLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_03,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=860 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311030036
X-Proofpoint-GUID: Qa8la11WekuoMo1nkJVRVd8wb6vCj_Uf
X-Proofpoint-ORIG-GUID: Qa8la11WekuoMo1nkJVRVd8wb6vCj_Uf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/23 23:15, Rik van Riel wrote:
> On Thu, 2023-11-02 at 19:37 -0700, Mike Kravetz wrote:
> > On 11/02/23 19:24, Mike Kravetz wrote:
> > That qualification '(with resv_map)' caught my attention originally,
> > and
> > I thought about it again while looking into this.  We now cover the
> > common
> > cases, but there are still quite a few cases where resv_map is NULL
> > for
> > private mappings.  In such cases, the race between MADV_DONTNEED and
> > page
> > fault still exists.  Is that a concern?
> 
> Honestly, I'm not sure. In hugetlb_dup_vma_private, which is
> called at fork time, we have this comment:
> 
>          * - For MAP_PRIVATE mappings, this is the reserve map which
> does
>          *   not apply to children.  Faults generated by the children
> are
>          *   not guaranteed to succeed, even if read-only.
> 
> That suggests we already have no guarantee of faults
> succeeding after fork.

Right!

> 
> > 
> > With a bit more work we 'could' make sure every hugetlb vma has a
> > lock
> > to participate in this scheme.
> > 
> > Any thhoughts?
> 
> We can certainly close the race between MADV_DONTNEED
> and page faults for MAP_PRIVATE mappings in child processes,
> but that does not guarantee that we actually have hugetlb
> pages for those processes.
> 
> In short, I'm not sure :)

I sort of remember something Dave Hansen added years ago to help a customer
allocating LOTs of hugetlb pages dynamically.  I seem to recall that this
was to get better numa locality.  As a result, they did not use reservations.

I guess it sticks with me because it was/is a real example of a customer
choosing NOT to use reservations.  

I don't have any evidence that this is common.  My thought is to leave
it as is until someone complains.
-- 
Mike Kravetz
