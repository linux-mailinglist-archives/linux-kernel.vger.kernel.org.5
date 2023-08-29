Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A513578CB8E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbjH2RuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237985AbjH2RuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:50:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56628E9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:50:09 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37THioO5022989;
        Tue, 29 Aug 2023 17:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=hsrSGyBi+j6NzLoyhzUfhEf84+NDhALJ3gzHEoaTWKU=;
 b=pIXKlCuzHHUvV5q7Nfx8YhQKvkxqAGXQ+VleAb1F+ftcGTKT6KRnQ98yOzC3OIgsOiw7
 SJJJ8+wBQ8Kt4XZe62TwetcKPz+zIP07lxM7Y0n8HjZEGV8q277Ov3DoXVlx0to5kMZl
 HIf4b2akNGQtmHGT4OH1lppfS/vA438Bqy57DbXJLdw7JxhTW9iPTzNfIRYFo0Xk3FZs
 xEBFNDxbh1wG+YgRrHkrAIAlqAVUAj3j6t4HSQFi4vaeowj/Td/jfstg7r7Y8HN1ZrvH
 UBAFiRHLtLCjM7Ts/juabk4imni1soefkE/mm6vRXR2cytbdCsvOysmq0pyyu4/0piHS bw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9k65nnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 17:49:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37THBQ5F032843;
        Tue, 29 Aug 2023 17:49:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6hnem46-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 17:49:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bd1pmg+NPADiiQaWz8kSS3wDAdDp2ftQZra/tYPEU7bZ466yrzLFSG9j5SckJ+MXU/l2qET4jg2gDlf8zu0jZAHp2amyPWakxm5wwl/32/NxlVpwAr3xfyGEc73ScvoqU2TeQzJoHzd5LHs6RXgviUEkDT0g95FkhpeSiS9PZkZ+szFdqHJB0TU2mezWf42ObTB8dpHgAiBnK5hTfemTUBj5ncw/SsX61C1irkeGAcQwFqOZu7UrQMElh+gJBrjj+FuiwADSgch2ZS7XQJus0087dC3DNzuUkRNA1p1OgWkSZYVrLLbZTF5e3E7bhmH9uexIlJPi7O2h9cLmNraECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsrSGyBi+j6NzLoyhzUfhEf84+NDhALJ3gzHEoaTWKU=;
 b=AVGrPOFOVlWi0A86+VG8P70SQzr2l/zvfcvhure6aHuF9YE/BrPWm7QzhyYVS2zXEr2HP0YXwe4IsOLbQX70wnW1r0JtAOCXysrbiAeh4ki4IUIhd3p6Ju8SiPVpRfSpqmNSfNedgyu+N2ytwu/hFVp2OeCEG1mFPsAR7iGVlQB8vpi+j+qpMMqu5mZH36HsD+S7d0EK2KiNgQYfJZAt0VJy/rzxB5m18Er65MRBDW91tJlOqy6UMR99x+iggYaXA3UL+Ch3ozaLo5xgsKc6gniwl1OugLg6oGI1A+3xEeOlV8EYtNgsjNelAELB3j0NaTdEsqfW7vTIpL+J2C0+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsrSGyBi+j6NzLoyhzUfhEf84+NDhALJ3gzHEoaTWKU=;
 b=JIflFnDKSaYlhQDqQ+l3GByVj/6gIUsVTJrGxK9k3Tlz9iCcEC3hTKaLIxTVhXEJA1Hsk/P/39Z++SnXAMahdxEGPFWiM7XIo7xr8D7Q+g4qHiQEnjp+T/JZcR+t4AevP2xrewtJR2BoPzrVCV305bojzLL1HWboHuZJolQE1iM=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CY8PR10MB6588.namprd10.prod.outlook.com (2603:10b6:930:57::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 17:49:45 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 17:49:45 +0000
Message-ID: <edf10660-2e8a-4f5b-8eb5-16038f8adbcf@oracle.com>
Date:   Tue, 29 Aug 2023 12:49:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs : fix shift-out-of-bounds in dbUpdatePMap
Content-Language: en-US
To:     Manas Ghandat <ghandatmanas@gmail.com>, liushixin2@huawei.com
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+91ad2b52815a08caf4ea@syzkaller.appspotmail.com
References: <20230827050513.364567-1-ghandatmanas@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20230827050513.364567-1-ghandatmanas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:610:e5::11) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CY8PR10MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 07bbb62e-1e2f-4c07-bf0e-08dba8b854a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OqE2QXDFvCL+APtZR8ztDee7pVlQAJlY89MCtSn8WkGcwkvpPjp4vvYart39/k4yNELGg56pFLf8tQrYg8GpuEcsuEVS0Batp2GS/rUWe8e14Q1gsS9sPpbVRAbYzMT0EXoAAa01Gn/Mdb5QCp8eHl4jSGaeZHLk5fqKQz1H5SacIgPvjSj15F39AQ4sPs7O0X2ZChklYslLmNvmvRyUwoh+avCbSRB1QdWFV+9U4eLWTAlRiFnbY3ko4zDyirnovX77zDOH+zsmxjvVQO7zCqW89A0T8B58vZmyfG2Y7D5HR5GRBgM6WpV8UO235z+sgi0bJ1eB6+v1tL69P74KhNbgeIHAPkPNIxM02ePvAHMdZNB0ld2YEn4qNYHy3DQ9EyQNG/Qd5nqfLRCiZl/Yb1zrI/VBZsKIQ08kFTIk+U17Zw/vsl8HOjIiqeQzojRLuqSBdE008C2wcdLDAfhuKH7+t+Gc6y7KAMyqvOlLCiAnGoyeyFrjqzkdix96EmBoL4sQlU4NxdSUBdZRwJSAsMGIuDkadubwM8SCeSq1tu17FnXjJXlv631n/AkX3bmrEdVeNKiOJLRmSanJZjvea59ghqAbpm5ZRsWs/ar02SCjNUmq8NN4NuOzlg0E2Z9hy8b7tX+hLNxguqkSxHJIGijS/eroUTkJMT6ScDQp0ns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(1800799009)(186009)(451199024)(8936002)(6666004)(66946007)(31686004)(478600001)(6506007)(66476007)(66556008)(6486002)(966005)(316002)(38100700002)(41300700001)(6512007)(26005)(36756003)(8676002)(44832011)(5660300002)(31696002)(83380400001)(2906002)(86362001)(2616005)(4326008)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1pEeU5kb01GZXNnYWRuS1ZqeUUyVkJlcmhMNkN0V0x5dmRVaVV4MVRTZ3Iv?=
 =?utf-8?B?U1pLSDM0ZE03Q0V3c3VMWGtxUk9sSFNKd1Y0U0tmNGFCOTNqRklOMm9DeTJY?=
 =?utf-8?B?VE9Pc2psbGVDMURSVmtHc3ZaUWdNazNmdzkyMVh3cDR0cHg5VkJIMmgrYVpU?=
 =?utf-8?B?L0NuTnRQd0hkbWNycStsS3RycmpyVjExVU5DQmhKY21WMzBJTkdwa0l2RndY?=
 =?utf-8?B?QkFYWFhrc0lCaDk4NEdLR1VrdFZPWWRlZHlJLzVCMDlwUzYrZlNrMm5JaHZB?=
 =?utf-8?B?ekxacmR0Ung1QnhaMWx0dHZzUlNoa2pSTm9qN3lFTktLRk4zUXVDM2dzUFUr?=
 =?utf-8?B?ZzBXWkpKNEx2Sm5IeE5jUEo1b05YNzZ4KzB2R2loejdOZUl6K2dmaUN0Qy84?=
 =?utf-8?B?aDJ2eW1BdTRYNFhUcThyOXdHTk53bGJFVXIvbGoyeUZxL1BRQ0E1dVpZSk9t?=
 =?utf-8?B?R2ZLMnNibkRGWkFnL2N1ZWsxdlFidDk3Zm0rMmRmOU50WnFqNFZhS0VUVmV1?=
 =?utf-8?B?ekVqclEvQ3d0RGc2MzRtUE9CT2hobWcyRzhrTGYrZ2pSL2s4alpvbFYzOFM5?=
 =?utf-8?B?TGw2UmkrOXF5bEpQbFRQU0Zxa0RNNHJ6dlEwRFd4aXRManpuaC9MaTRVY0pS?=
 =?utf-8?B?U2xXMENVRmYrcnhPNytad1F3VGV0MEdIN3FaY0hJckY3TnFkc3o4Q0s1S0Yy?=
 =?utf-8?B?b2hkS3FWOUN3eEdVVk00ZExjWUhDQWoyVDNwMWxnTWcycis0V1l0RVpFMlRG?=
 =?utf-8?B?dlQ0NGxrV0pmZWVrZEd3MjBIMnVFWGxjVEszWXVEWmprVFp4Y3hzaThUbmpr?=
 =?utf-8?B?SUJHalFLdmwvTDJxdGNGbHY2STNzSXVDSnF4S2pLNFVuOXFiUDRSOHBiS2w1?=
 =?utf-8?B?WlpGTTdjZ1c2eHlHRkhXWlN4Tm1CWVY0YjlJNTZHb0xrbmRBeWliUUFpRlFM?=
 =?utf-8?B?bHJ0QWs0dDhsMTVnRzNxd09BcUszeXBLWUpoaWpwMG5veXk2emZSYUhKWFBi?=
 =?utf-8?B?bmF6TUtERUpEdWRONHFwTWkzN0pCRFMxY2h4Yy9va0J2YTUzajhwbnV6a216?=
 =?utf-8?B?RVFjZW1jVS8rSDdNTGJjcXlwWkJpN2Q3QTR4aDNUbGs0Kzd2VlJCVUZRMjZu?=
 =?utf-8?B?US9pVUZVaFluajE3SlFML1JheTFuSEhNT0NwZlBROXBxWmxwMk5qRzlCU1kv?=
 =?utf-8?B?TTdCVnplSnRYcjFCOU1GNFlNREZFOEhaWFZrTjdVclhKV3ZnNmVsUnI1aFIz?=
 =?utf-8?B?MXU5QU04dlhDQzZSSjg3UXN0d1pxVnBhT1kwT1lDQWRkbmtwTys5cTJBcDlz?=
 =?utf-8?B?eFdSckcraGQ4NG1nYW1oK2VVaytuWG0waU52ZkQwb0hROEdnMWI1UVdSZ3hF?=
 =?utf-8?B?RHBCcmlvSk1BU3EwQklMOHBJakxtdG1VVTZkeEpMT1RteFZna1ZSSzZpNWlT?=
 =?utf-8?B?OTlVUjJEeVFsK00wam1LNlFSQkpyVUNpSzVBaDFUbFhjRTJzRkN5WXV0WTNF?=
 =?utf-8?B?SjJUbmc5WDBaQklCdG04VlFPdkpqYmNtY3dkQWxpUGZxZm5wSklPZ0xYOUd3?=
 =?utf-8?B?RXdkTXZPSmQ5dXAzUm5jTnBWNll6NzUwcVJPanpqdjhUT0tsQUhBV1RRR2Fv?=
 =?utf-8?B?clhqYkFwNmgrRWlhVk9pTU9jZ0Z2djVHd3BHWm05c01nVndoSm9ROTg3c3ZG?=
 =?utf-8?B?b2p2RE9nSHJpN1Q2djBkclhGbkhpcXM4VitqNWxZRGdGOU51T2s4dWRGNzNy?=
 =?utf-8?B?c0tKN0xsUUM0M1k4aHE3N0thM3dlZmxyOHVXQ3RQYXRzQy9UVXhNVGVzYkZj?=
 =?utf-8?B?eUNnWEtneGIrZUtZK3RpckVUNlAway9nMmZ2RE4yOG42Z3kzTWwzdmZOSHVw?=
 =?utf-8?B?c3ZHSnhsZjlaUnk0TU1XS1dldFdWYzg5Wm1KTWpQNGo4NStLdStZSmU0cUgr?=
 =?utf-8?B?OTNUdkF3bXl5YnhGY09NbEdmSGpDbTlQTmpIWVgwbnYxMFhsVVlkYzI1SURK?=
 =?utf-8?B?eStIQmtJSEw2SkowNGxCYktxNzVEUmdpYTNEUElxZ0xyMHZ5V0U1ODZWanY3?=
 =?utf-8?B?RVdKWGMvVDQ2SVpIVHVjai9Ib0RXd0xOcmFkQjhBaXZHRFduejBpNjVaREZO?=
 =?utf-8?B?QTZkdnE3RnFhTjNGTWkyTEFwWVFkRW9JYzZ6ZGxpb0xMMzhMcDRTcHFDakNp?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TGFpWDdacmVSdGxCRDliTzNjY2xuR2IrTWJQYVVXaDdHaEJTZGtoRVY1R0M4?=
 =?utf-8?B?WlJZSUIzV3I2aXhaWm9rQVBlUTJlbDloUmhLbG1QTzQ3UWFwTVU2YklxYWFq?=
 =?utf-8?B?cmhtcndJY1BFNXRBNzJTZ0JaM3lCM3dmVkJrNTQwMWZJUFR4N1NnTWwvdkNm?=
 =?utf-8?B?dVR2amJocllPZ2VEOGRndjZtU2JtV0RzWnB2V1ByMlZlU2pjcTQwY3dZamFZ?=
 =?utf-8?B?UCtIMVlZNkdEUUh2RXNDaXVidFV0dFpObi8vOEM3U3d1a1JsbTVpS0I5OFZa?=
 =?utf-8?B?bDNJMnBPZTNtdWRFQlovM1FJTFVZRWZPQTBYT0tiWGRRS1kyRWkzUDJ6WW1h?=
 =?utf-8?B?RS9xVmgrZkMyUjJpNEtxZlFJTkZRU1NKSjNQMGNUMGE5RExuTk9yWU5odzMw?=
 =?utf-8?B?MSt6akM4MFFqYUVqK2NRN3lEMUxpc1RPa3hFcW9sdjhtbmVhekN3eG51a0FE?=
 =?utf-8?B?ZnhOUmZHU3RrMGx0Y2Z1dStCV25iYnJXWEdrVFJJZUw3MnlWUXB6MlJKUzU2?=
 =?utf-8?B?NzdBdzlPV3BNVkpEVE9EWFVUeGJrR1R1blhSa3JFWG9hK2VpL2U4SUd4Um1q?=
 =?utf-8?B?NFpjRFhVOEZsa2s5TWxtdlNXQVJUaUluUVRjZjFxREtsdCtub0owSUp3aUNq?=
 =?utf-8?B?eXFQSWYrUThleHlmbWpVYmNrOGQ1MUxMZUpCejUxTk9scjQ5QnQ5N1RBNnlY?=
 =?utf-8?B?QXJxUTRWZ0dCcUVpSVlSZjdxQ3NOcTdrVERkZWwzdGg0T3U0QXFYckxoaHow?=
 =?utf-8?B?SEZVcGVYcVBIYXlUNjNhQkhYbXg0MGVrYm4zcU5RUXhHbUgxN3FXTnFmR01m?=
 =?utf-8?B?cFpZVHdWSVdOTDNYcmlHV083UnpVS21HOVRyeUtwU2NPeHdUcVoxaWQ4aFVB?=
 =?utf-8?B?NFlUZEM1Y3pxUmhRQS9jemtnK2xoL2w1dnh0R3dOR3F6OGVzWWdJYWFQd0Jw?=
 =?utf-8?B?N1ZSUzZ6SnMvbmRUd2hxbWM1cXBsdE04a0tSMy9PVzBvNXQ3TEpYLzFEcFlv?=
 =?utf-8?B?dHhOaUVFNnVieWJheXpEbWFSM1FqWmdwUWg0M3V3QVJMVDRuUXQ2ZUZVSkhj?=
 =?utf-8?B?Y2xKcVk5OUNXR3kya3pRSlRhYzVxWSsvMVF4eC9hektYVU1XQUY2bytXNng1?=
 =?utf-8?B?WlByV09tR1JjemNGbEF2dSs2Vk1YZWYvQ3lHYU5CRUJvcGpVT08zRElEYmph?=
 =?utf-8?B?QlNaaitIOUxlTkNEYzZEcmpUMzBpTk45MXQwTG5PdFRUNms1V2pYR3NEdFFV?=
 =?utf-8?B?UkU3TUkyTVNKMmpsb2dhdUxCMVQ1RUxZbFFFc1RNaDZEdFd4dXYzdDlFQjZy?=
 =?utf-8?Q?W7awsouDT0vG2A3Z9PAjIg4ex3HJJsiCbc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bbb62e-1e2f-4c07-bf0e-08dba8b854a0
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 17:49:45.2489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sH5iZjtM051DWbNjbYWfOsAnr57zhENMBPRGLunPPpjrFPqtEubEcBDKiERduddUuD0JaD8c2/twwNyUvwEJIiCOEuUKKbGeuXlbN9A9FLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=918 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290154
X-Proofpoint-GUID: 9wU9e2PZ1zDYtNizIkopEuqXcvWGeduk
X-Proofpoint-ORIG-GUID: 9wU9e2PZ1zDYtNizIkopEuqXcvWGeduk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/23 12:05AM, Manas Ghandat wrote:
> Currently there is no bound check for number of logical blocks per
> page (bmp->db_l2nbperpage). Added the required bound check for the
> calculation of dmap.

This should already be fixed by 11509910c599 ("jfs: jfs_dmap: Validate 
db_l2nbperpage while mounting")

Can you please verify if this problem still exists in v6.5?

Shaggy

> 
> Reported-by: syzbot+91ad2b52815a08caf4ea@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=91ad2b52815a08caf4ea
> Fixes: 4d81715fc5df ("[PATCH] fs/jfs: Conversion to generic boolean")
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> ---
>   fs/jfs/jfs_dmap.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index a3eb1e826947..6a5df296fdc8 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -467,6 +467,10 @@ dbUpdatePMap(struct inode *ipbmap,
>   	lastlblkno = 0;
>   	for (rem = nblocks; rem > 0; rem -= nblks, blkno += nblks) {
>   		/* get the buffer for the current dmap. */
> +
> +		if (bmp->db_l2nbperpage > L2BPERDMAP)
> +			return -EIO;
> +
>   		lblkno = BLKTODMAP(blkno, bmp->db_l2nbperpage);
>   		if (lblkno != lastlblkno) {
>   			if (mp) {
