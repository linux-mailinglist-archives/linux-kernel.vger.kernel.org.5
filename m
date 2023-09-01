Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEF979012D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350387AbjIARIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346496AbjIARIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:08:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB79F10F2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 10:08:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381CAKxH027006;
        Fri, 1 Sep 2023 17:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vLwBu/q+CGkOj1CldXv+2QULzORTFLeMIvRh2aA8maw=;
 b=drJgpps8whklxC+9jeYUiL3Fd2ZBEHI2NFXhRMKqDeBKOeeRlNW+vGVSXvKGpdILAXaX
 xk0DwSdAUzR0plhhD8Wvh0x7+RVd1InVmF3x5mWsaO6shbsm19PfSj8ZNBP9CrQwxqnV
 FW4hbqIrQdGIrROYQ6B/07pthOeFzSlD5Mjsv9eEW9f7XTmZD/kI9pj2TGdbq15Yx7EQ
 TeNW8NtEKDOUUdMIXELBEeaw04FDJ7KPP+bLYfCiq8wIJ5/uQtVsCtY5ozXDsHrZXffk
 JDhQThe8QwaYuBHgm1x2iK/fYGfG30r5wqGamXjU6UuLJshjmpEbpgdPaH6auXvHMnW/ /Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9mcvduy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Sep 2023 17:08:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 381GhKH0032840;
        Fri, 1 Sep 2023 17:08:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dt303q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Sep 2023 17:08:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kH8Pzw5SvHPAsglY/LnjtxNFDCWe4tQZH/PSiY5xtTprFkOZcUQPbJR/T/2J+gDgcci6iRGiT5VyDX/yXZdJFQ4e3mMQ/Y4dbSKwIqxgaENwfON0Q9kvGC3IQseMifxQ/m2XwDSgWGueZ6S8s1lbtL9K0gAjtxzYg3WI+E9NofIbkvwHKcTSWb9r03xQvmw0hTpWErLRE/3fJoJC9yyCACFJHRDd0qCQY1tT7Q4R1faJINALAxyteph7sDWYXh773PGJZXlOs6/KOd/9X7SKcT1Z/2o+FioiGhirwoQ7zhp7yI3XgAa3DhXJF8ZJOJaNRMd830u10xF9qTELejzvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLwBu/q+CGkOj1CldXv+2QULzORTFLeMIvRh2aA8maw=;
 b=Bmma6Gd4YvYMZEc2ggvDn6ITSJ1TnbW/ndClHMWxziUIwkvbVn4xHG1rVrraIqBoT5Ht7Ay0rBh7jKsGhmqkj3qcwfur33gAv54El3elYr04y3Pi90TKMwvRCNG6cmzoYmHyhcv6UCuZ+bcjwOBMxHSuvU5IVSsG+3BdDLtL58BE6r1S0UCrFt5clYDu3oOGNDLn4bhZpQM1OjC0uhkwGHcjsOtCojTt8Q1xg6p6GEWsMVKEiUH4Aq443zdbd832AMwpbyyocfzAEwvDFpKaouKVVMhbQM/LP2KJ/Q7LlYfeB4E4i5OHcSo1FY+RFlzpDwc1PkRgD79hfYv3Ij0HIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLwBu/q+CGkOj1CldXv+2QULzORTFLeMIvRh2aA8maw=;
 b=IfP8zqdAkTyf5Yyo8N08YVaB60UhfwFYGvm+jV4U2nlYIrASbrcqobovvj1BqnOszdtRd3qKcgT6kDx5uGNYmZRALHUBdD0j5ulMQ/gBW/sOgOPo7ZZko9HtnqXPjXbuPwEt3eDCq0wxXzSKBIlzqUAWe0jwTgOtu5zYXwJknsw=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by MN2PR10MB4223.namprd10.prod.outlook.com (2603:10b6:208:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 17:08:12 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be%4]) with mapi id 15.20.6745.026; Fri, 1 Sep 2023
 17:08:12 +0000
Message-ID: <f9475918-2186-49b8-b801-6f0f9e75f4fa@oracle.com>
Date:   Fri, 1 Sep 2023 12:08:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: fix array-index-out-of-bounds in dbFindLeaf
Content-Language: en-US
To:     Manas Ghandat <ghandatmanas@gmail.com>, shaggy@kernel.org,
        liushixin2@huawei.com
Cc:     linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com
References: <20230829165244.460154-1-ghandatmanas@gmail.com>
 <e62dbf53-9d74-45e5-b44e-53140672b8b5@oracle.com>
 <ae6ce935-96eb-3d40-f252-54fff7eb0ea9@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <ae6ce935-96eb-3d40-f252-54fff7eb0ea9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR18CA0032.namprd18.prod.outlook.com
 (2603:10b6:5:15b::45) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|MN2PR10MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e53318-0528-46ae-fa48-08dbab0e05fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ATYc+NALQ7frWtxi+t9mvKeGNsxfuq39GX6fU37RrkNnDBkb7p7dGvjqCeHfyqxjw7yyw0FgOgTyA91/A+sbhJkkrlBWR6+N36yNbio9mT9J4DHFdD+CjYpLG3F5fCuyZxZxhAIDOSUHoRPu5VYmISpJ28O37BqnGBbgXDd/pMc8K6c++bhjwVfL06XbFfjT1Xe4riRNjTPUPcCaz+nXr3kBUXQerxeR82/hFQ7Mp2QzKvob7S4zUqG8gc5WqqpRwjgBgxxh+TYOAg4hVv+sJq3FnpuurAe1vFbD9UeSojHJHMM6dIc41jPowiJbEn3tr9XglAun2PPn1a175vA+NkmNTeVwLkt+UUQKQXEMiwwWKa5sGk8KWBwR1xskHM6n2qZLUK8KengZVgNhxKepTRo4raDVRE/bqb/EpCgY7B3kLs5/r0zwH6qrlTkCj8jaWTVYwlSfMaG9qjrMz8xG9vaqNqob3qd7c0IV1bsFJMyWhZVGokVBcUMHky+U9GC/XjAPYbwUY+/GT+HK1XH+FR1MpIyMqti/2/8iXFGEx9O20WYxEUuPoTUNoV279bd4X4fS0hWl72myXXL6bI7bEW1eXYuh+7VcCEXt8VEJR14Ni0wBHIubjimVZDhz6COUcLAawLsbhkvxLGqynUelExFViNJAYy61IVBAO7Tm+dc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(376002)(366004)(1800799009)(186009)(451199024)(6506007)(6486002)(53546011)(6512007)(6666004)(83380400001)(86362001)(31696002)(38100700002)(36756003)(26005)(2616005)(31686004)(2906002)(41300700001)(66946007)(66556008)(66476007)(8936002)(8676002)(4326008)(316002)(44832011)(966005)(478600001)(5660300002)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTZqK1N6UFlhV2NyUlEvVlhrSFI4QmlXTlhzdDVhY0pLbHVkSXdYekh4UnBx?=
 =?utf-8?B?Vk0rcGZyTDNJZy80N1FXNnJaNmZOWTNWNXVQOGpLRkNwRjN0NXJ1S3hJT1Qv?=
 =?utf-8?B?MVJSakx6bWdzVVB5blZlWmVQSkxudzd5UlkvNFArN1FCcW9iS0ZoY2k1UlIy?=
 =?utf-8?B?cGZka3g0UFFMbWpFWnB1WUJ1R2E3MTJCOXZsektOT2ViTm1DT1NoNUowZXJH?=
 =?utf-8?B?M1ZIMmNhVDRvNDlIUnZaSlpHNGNkQjYvMnlqN3JFUVBONnJ0dEFsUThzNkJC?=
 =?utf-8?B?VVNlcUw1ZVlSOFBORGEzSWR0Q3RBSUZPd0ludE1BOU15Tzl0L1ZueHQ2c2Fh?=
 =?utf-8?B?QnJWSkI4M0Q4ZDdNV3l6cXNDeDNSNGRhUC83M1BJTWE3cnlPdWhrUnFQL011?=
 =?utf-8?B?SEZFTzFxTW1VZnBWTUcxWlJySnlQNlJGN3dKRm9VL2w5V2FKVHo1bWNXUDZQ?=
 =?utf-8?B?a1BPWk5Ob3BZU1NBRmZpSTIyRHRXS1BjaDZZWlFvNUtsVllKa2J2Z1UxTlFP?=
 =?utf-8?B?ck9saE9IS3dRNEFCL0lRU1B2Y2xYY3JwZWJQbXBMVTFCcXNRSU5tdk50TkR0?=
 =?utf-8?B?ejFldFBQRWlmcEt4Nms0amlocGpCalhsZENUNTNLb3ZuV241SzBFM2tBMDI4?=
 =?utf-8?B?SE9UcjRhMzRINWtBVi8yL0pWbmR0UVdTcjhzdERvbi92SGhnSEJKMXNCc2FR?=
 =?utf-8?B?QVRRSWF3cmJNMHgzalJlRmpGWGxhUm5LSTlPOEcvak9PQno4OFpkZ0F4Mjk5?=
 =?utf-8?B?R0dYQmhLUnlzUkw1Mm92SSs0ZXk1MU1GVkpxSStZYkthK1FudTU5dGZKYXpu?=
 =?utf-8?B?YVZhUjBGWmhzNUgxeFBqZHRrd1BWTEIwQVFiWFhqMFZWNlhzUXlqbVVFb0p0?=
 =?utf-8?B?a3dvOThpY3psUU5pNUNpRUErdW5sdEdqWDRXNDNlR2RuaUQ5aGUrUktXMnMz?=
 =?utf-8?B?L1lVREpoQzVCR0JZVUt5NDFKMWcvdm5OWmM0SVJoT3VKOUVsVXQwS0JHRm1P?=
 =?utf-8?B?U2NyeXgyQ3NNT0xFVFhSdjJyMlZDZEJ5MzlpNkFMYzByWEFxM2plZHhxUWJN?=
 =?utf-8?B?SzJaY09pQXhVSlFWUWdUSC9SZ09VU3UzYlNNN1I5eDU2azMyR3RMcDBNSXlw?=
 =?utf-8?B?ZUJQcFQyaEtMZHQvTjVBdTVOMng2Z294cE5OWXM5T2xkdjRpdUhxM25sRnc0?=
 =?utf-8?B?c3RmRm9rcjZtMzFIbkpMK0UxWEliZFIwTGlqWktkOUtDRUNLbk1Lb3lpSk82?=
 =?utf-8?B?alFkTFJjTTJhSWxLZzNaV3A2OTV5d0hFRUdEY0Ztb2RmcGRrdTRWRWNqa2FI?=
 =?utf-8?B?V25uSzVya09yTUNnQjZKbnNYa3AxWjVuRGNITmVYeS9VU0dtMFNmSnBDVTh6?=
 =?utf-8?B?OExoVnczeUlrWitPMVNYbDQ5aU1WNHg0OHFWT3VxdW51ZnIxR1pLNFRGaVdm?=
 =?utf-8?B?VEVZcDZQeHozbEZZUW16cXJZKzFBQnM3dkV5VDVSc0FRRWlWVEhrYUFOdFFv?=
 =?utf-8?B?VEhyTDBjY1hyQVlOQU55blc5ZDR0WUp2amdDaFpHams0NE9OTUhUVFE4bkho?=
 =?utf-8?B?MTZSM1FnaVdGeERtOFNzVjlYTEFxK2c3S0tDSTR6K200U3VrYSsxNlBLanN6?=
 =?utf-8?B?d2graDdlUUtuOFZQeS9kM2lWbHVGczZOZTE4M2hlQjdLOHhCY2g0UCtvOW5y?=
 =?utf-8?B?MFFxa0xUakpiZ3M2U3cvNzhRUmVnNG5NTHJWbkp3aUY4VDRpWE8vUTI1emgv?=
 =?utf-8?B?UjdwSk1LaEcvOGtaVDBSeVZPN2FTeksxMXBhRVRYbnVuNGhYcFAxUS9kMWlK?=
 =?utf-8?B?b3BPa09IOVBMdDA4bkl3eTFYV1czK1lNTUtrYVZFOFNyQ3owbGd2OG1oKzhN?=
 =?utf-8?B?ZUNVSUdPVHZ0N3Eza1FlRW0xV1hIVlM4c2E3VXBJaVQyZUJPYmlmalNoUHJY?=
 =?utf-8?B?TEQwS2dwS1EyNnVRNm9nR0p6VEg1bEZ4MDVzZjBKWHpRS1F1VmZBbTdTc3dh?=
 =?utf-8?B?V09MUUZmZWJXQ3lSbjZDa3FUd2F2YmZWQ3F1Q25jQ1ZJN2Iwa2Rpb2JwUGdp?=
 =?utf-8?B?cWV0VFRzeW4ySXVkL2QvWUl6dkFYYm9RQ0cvcmxWY25leVBxZWh2dEtxbXFp?=
 =?utf-8?B?a1ZhdWsyNXprcnA2NEdacWx0ZTZCSC9FK09vNGpjZmF0QlVBYUY0U3NLamMv?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UTA5N2x6ZXFiYWZ1OFJyMjRNWWJQck9meDlSZXBOM04rZ3YyWWlVNVlOM1A3?=
 =?utf-8?B?NEQ2NFVVMndZL2JnOGFyWmVkWmF6dktpb2pZSlFyc2RCVG9NY0drUTFXR0tP?=
 =?utf-8?B?cnFhTmVGa1JnNklIbVdCNW9LanNCQWlxMjdGT1R1YWk2bXkrSGZBWU5jM2NB?=
 =?utf-8?B?eGljSWNaVHg3N29Ic05pREdTWVFxbFV2ZWhuMlhnc3RDaHVRZDlFelRVeEtT?=
 =?utf-8?B?Q05WdnIyUkxYa3RhWStkOElVZXpOYVB3cWxjaU1CbFVFLzZQeWtiR0JKUUU3?=
 =?utf-8?B?UitxUTdSVktyTndPR0ZwWmlGR0hDcjRaSkxDTFo3RWRnSTZ6WmU5aDRNS2Y3?=
 =?utf-8?B?NDlCeXc4ODlZOGVVcldyOGw1OVJNTnVrb3ZRdnc3VWJjSWxoNk90RjVKa1dz?=
 =?utf-8?B?NTJzK2o5cTZjSVA4RVVzc21XY1piQjdIOUgzNldtaVpqWmcrQ2tndXFOTDd5?=
 =?utf-8?B?am4vTjJIRkNqMHRnaEd0a2ZvdDNmTlNid3VLZWFDWCt3c1lWOS84NzNxNDRU?=
 =?utf-8?B?b1pwdXQyKyt3UGJYWDdacW1jTHAvKzQvMHVObFplUk5Zd1RyRVNFN0NRSnpF?=
 =?utf-8?B?RkFLNi9EMXpESGZGQ2JLd0Y2UTNsZFhGRlJtWm1HQ3lZMTExOCtpM21qSHhi?=
 =?utf-8?B?eHlDdFprZXlLYzN1VERyN0p0WnR5aDZFMTlpdXJRdGVyQ0pTajh3Q2RWRVNa?=
 =?utf-8?B?eFBiUTVmRE92TWJQblV2bU00OUZNNmNqaWxhb1IvWCtHbjRXNlBnM3p6a1BG?=
 =?utf-8?B?RFdBZ0x5RXVFcW1PTHBwYS9XN3ZSbEVzTTFQTVdEQnd5K3MxV3RXUEU5ZW8w?=
 =?utf-8?B?b0dRLzJtQzVQazAwbWhYcmlRVEVqa2FBU3djSTFwVEdkTytHV2NEekQrcUZ5?=
 =?utf-8?B?K1RoTjhTSllheUZOSVRkVHZzbm5MK1l5RmpkVHhQYmsrZ2lrWmVhZnpmcDQ0?=
 =?utf-8?B?K3orYnhkMEdBQm5PL1c5dUV1Z096RnhaMDZlZ25ZTlB0RmIycmFyTDhZQXJi?=
 =?utf-8?B?L2RpMktPL1YxR0JxeCsyQUljUm84WkNDVk5lOXp1N1RtZjFERHFqRnR0Q1pi?=
 =?utf-8?B?YjQ5TG4yVnA5OE5uWEFmbHVuWTNsb2JSRWtLK09hRkQvVCs4eWtaRExoR25n?=
 =?utf-8?B?ZzhNc1Rhcml6UklodVprUVJ6SjZRaDUxSjNxRDdzNkhZdzlVWFQ5V0c5WlVF?=
 =?utf-8?B?cllwMEluNUlrUFRJWnBkZ0NjMTF2OE5aOWtIaXZNdnorRFVMYWoxMVFhSlFn?=
 =?utf-8?B?MDEyZExVR01LVFg3K052bU90TUQwbmdibXBha2N2ZzJsWUpQWElkb1pqRVJQ?=
 =?utf-8?B?Zmw0K3NMUk9mbGtQd2JxVlJWQ09RUWY2Wmt0RHFpQklaUVpBQkZYUTRMSDNB?=
 =?utf-8?Q?ZMk8zUXd044kywrv0w4ghzvnmkhFqYAc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e53318-0528-46ae-fa48-08dbab0e05fb
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 17:08:12.3654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nqfTZ87sVLS/JL84MXDcJCquWs/TNKQ4A9DjKvZMdsldTK1z2MtPbI0V7ZDQHkjecxWri1skU19ga8zqH73bCWv3Q8XrXWj06ld8nqS7NI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_14,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010160
X-Proofpoint-ORIG-GUID: Vow9V1Yj9pXvj7rv_MSYPYzKjmJk1aEz
X-Proofpoint-GUID: Vow9V1Yj9pXvj7rv_MSYPYzKjmJk1aEz
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 10:19AM, Manas Ghandat wrote:
> I was wondering if we could implement a get_tree_size macro wherein  we 
> could find the tree size so that we can do the comparison. SInce the 
> tp->dmt_stree is an array we can get its size and fix the out of bounds. 
> Would this thing work?

dmtree_t is a union of two nearly identical structures that both contain 
an stree. The only real difference in the structures is the size of the 
stree, so dbFindLeaf doesn't really know which is being used by the caller.

> 
> On 30/08/23 00:08, Dave Kleikamp wrote:
>> This won't work. dbFindLeaf() can be called from dbFindCtl() with 
>> struct dmapctl whose stree index can be as high as CTLTREESIZE which 
>> is larger than TREESIZE. A check against CTLTREESIZE might be better 
>> than nothing at all but won't necessarily detect an overflow. 
>> Currently, dbFindLeaf doesn't have anything to tell it which tree it 
>> is working on.
>>
>> We could pass in the treesize as an argument to dbFindCtl() if we 
>> can't come up with something simpler.
>>
>> Shaggy
>>
>>>
>>> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
>>> Reported-by: syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=aea1ad91e854d0a83e04
>>> ---
>>>   fs/jfs/jfs_dmap.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
>>> index a14a0f18a4c4..5af17b2287be 100644
>>> --- a/fs/jfs/jfs_dmap.c
>>> +++ b/fs/jfs/jfs_dmap.c
>>> @@ -2948,6 +2948,10 @@ static int dbFindLeaf(dmtree_t * tp, int l2nb, 
>>> int *leafidx)
>>>               /* sufficient free space found.  move to the next
>>>                * level (or quit if this is the last level).
>>>                */
>>> +
>>> +            if (x + n > TREESIZE)
>>> +                return -ENOSPC;
>>> +
>>>               if (l2nb <= tp->dmt_stree[x + n])
>>>                   break;
>>>           }
