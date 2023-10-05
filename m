Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1637BA175
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239390AbjJEOrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbjJEOnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:43:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7ACD485
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:20:53 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395CHMFZ014481;
        Thu, 5 Oct 2023 14:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=yiYtNH6uT/LksCRDX94evQ92klCq0OnzVHRMU9xwv4s=;
 b=gjAI4137cBM2IzpPVsVW6M+cGENTy3NJDKOGXo+u/0A142sKkbIF/lstqXcyPf87bYdM
 KoFn6ClE2i7kDqVkyEaeNG9cVAXAzWA5+HC6I7CHEHdbYnzLsDMZhfq8vAtpHOUuWiKN
 goLjKZVVEFF9hoOqJxOw4B3wXlZP/Uf4Jwh4RI9NMQq1NH05P4mHhRtWfzBLXCX+LXQy
 KVKsD6smT91qiywzkoiMTP7+mA/Jkwb1KFNZ+2QRqU07v1pUPQAuPrd4baHhkyfUIxeo
 o7FIIID114AEnPBwIVhwtko1dwG483dd4x3/8KhYOgJYhAO8KRfXNtLejKi8NFjc/XPw bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea929p0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 14:20:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 395DTg6L033676;
        Thu, 5 Oct 2023 14:20:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49br9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 14:20:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7pZ71qs8OfozBD56J3LuMxtxGT1sq8CFbpCc78h8yCQxHvIO7AY6SeFsEfy+3Qa4EbKImBDYt/3O5KI0UlxdOPyG03rnih4GPc8tQ6+CbvBbnyVj+FY3vW509OWISGx6p2usW9/+HB+96PZdZCtAlRTBQXw9dweVSVGiaXnf82yLZ4T+Cgy6LFy2j03R+hY7x6qkar5N269NlXk+rQObtGBxUcdshjim3M9oC/bOmjwZXse9AhWmSDgCpc/rnx9avuLE2MUgSPcclFOcp2/EyKJEzc4n3RRx4hnFbBhUG8gKkGCcVDohTO5kPHp7DNcdlVC8aI2O7ZhEL2KIPyFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiYtNH6uT/LksCRDX94evQ92klCq0OnzVHRMU9xwv4s=;
 b=XDfnA7aGVaNapAehYaW3kZY1XqiodSyftiaF63UyJ6Qk+0frhuw5k79RE9MM/xKuyKSyh0YOybqiJ+NDcoY0AwTMkEZydLBK2O4EMHpFuUHtSs28g9zjOY96UnWwAPcXdCyOpcuBTeE/L28yH8zgfs3hu7ZtOtCzoMd4JZ4JqYAjFRpwHaVplAXy4QvEIKWYYsExDhYxbBnju8hK3LjnMeB8LbQEwYk0W0oL8pMhHsUgufKqz44UR2zVuTaHL0afQuM4vmBfkT+jkP7Bf6H4q1pvynpX3P6cD+gh6JrrTN4sLlJduz1MKMjGkwLM9twmxyWCWENht1v2wNDY9KSkFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiYtNH6uT/LksCRDX94evQ92klCq0OnzVHRMU9xwv4s=;
 b=avBaKQVBTTkv1nzfCDCoH9j+ulbJ6R2l3sq67veYkmS45u4Ld0/2XkxHPv2mjKJsrcW4+AWj6Z5WkuM3CGCk9gtAZtsYQNyYEnmIqeBitgFOmChM5gb363CKRnSiuub7t7bNSxwOpgso4G79xe28YYWBdm65vRSJIHTiUf6xkX4=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by DM6PR10MB4171.namprd10.prod.outlook.com (2603:10b6:5:21f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 5 Oct
 2023 14:20:24 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be%4]) with mapi id 15.20.6792.024; Thu, 5 Oct 2023
 14:20:24 +0000
Message-ID: <52616ab2-6f8a-4313-a687-91a8d1081c8b@oracle.com>
Date:   Thu, 5 Oct 2023 09:20:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs : fs array-index-out-of-bounds in txCommit
Content-Language: en-US
To:     Manas Ghandat <ghandatmanas@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+0558d19c373e44da3c18@syzkaller.appspotmail.com
References: <20230919155542.4354-1-ghandatmanas@gmail.com>
 <423182d1-3d75-4a73-9011-da24658a40cc@oracle.com>
 <3d4e0f62-35bb-4b18-a64c-191c88415032@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <3d4e0f62-35bb-4b18-a64c-191c88415032@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:610:4c::12) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|DM6PR10MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8f72e9-fad2-41d0-95de-08dbc5ae370c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8MuUGpG24gsqHmltdRc3a4lQy5EJApzFcbXh/dELwxaNSS400jzKXZmRW8PqJ4q8teMjpCbRk9VmSYc3jaVNJnwBZC4QzaafI2TREFpcTzwkqk6BQg6pdN2A7n2IWrcPe15DDzqN9BK4HpEWEv0uWurT2Uq+snmwJ4BW0kpJsdV2z2oXY/kGqKIjUBKV35xbXK/g21ie+us6q7vrGDLmrIDXTcxOHS7voA2PU8xTpaTQQl3O/7T41k2f1YqwbM9JyBofYa647Y1Pibs7jwUrAkgvGIxrq0dDnEZPFvnO7n/g3vlLjHiiR/ulYybkBGJLgRDLNMZY+/kp5dfas6sCZlWmEOPuqMJ4STe79s0YlwWXtxN6k4iJ+oaSE59kpOQBWgDB8k3M/LJeSKh8v4zTQTPvPtRa/qRFtQOOOQ4ERcaqZAUp/OfON/A5U83gk/+hRfHEhyYMjz1hNnrByLIsfT2tGgld/r11c90MAZm5gneNxUE1wyEfsCtd1Ne17/jiH+RirJsVRR75a/KUwK6VP3NwBVjQCXih2e7WEHbEKYTV4/j7n6llL9ORO9F3YHsVCwMJ4LLkA8abnM5XF6XD6207/YWCzMHqR18bnnDhcDjO7exnp/+3cwe6YfPko553EdIWWfSDq1oCHLqSGi5NZaJkgQjTdtYXIvxqHk7fB07jvKJq975ijGdJMqM6RTr+eJCKOvN0Zr+d4WY0q93fyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31686004)(86362001)(2616005)(6506007)(53546011)(6512007)(4326008)(36756003)(31696002)(38100700002)(26005)(2906002)(66556008)(6486002)(5660300002)(478600001)(83380400001)(8936002)(8676002)(6916009)(41300700001)(316002)(66946007)(44832011)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qys4TjdhV0tkWnFhWUtKQ20wNWlRTi9xd3VnZTNyb2RYTWxPbm9tSFNpbGht?=
 =?utf-8?B?QVAzU2Fqb2hMK1UvdmU2YzJrTHA1TmthcEE2Njlha2Z3ZTl4RHJtbkh0QnE3?=
 =?utf-8?B?ek14c2JidnVkeEFja3ZtV2JBeVhXbEhaN1RqMGlVWnF3QU1kWWl1RkN2T2RZ?=
 =?utf-8?B?U2IxQ0pjQjh0Z2Fta3M5M0l5VTFSWU1xL1V6TC9NdUw4OTFjZVdOVUZTV0FU?=
 =?utf-8?B?ZEcvNTI4WWQ0K1N6V1VDajNGUEgzM2tyL1I0cnRta1krblp4S1A5S0hldE5C?=
 =?utf-8?B?UFRoZldheFFOMldBdE5tNGlqbHV0NFhMazF1WGNnODJ1aTc1Wlh2RUhodnVH?=
 =?utf-8?B?Q0NtdFpLK0NEV21PVzZKTXgyOXlrQzRBTENTV3lHK2VJa3ljVm0rTHloYXBi?=
 =?utf-8?B?K1h1T1Qxc2xEVkpUNXE0N2ZialVYZlJmcVN4WWxKdDUySkZka1FwMXRrV3Ax?=
 =?utf-8?B?YUN6QU5BQnZtZDlUWDg4bUg0WUhybUd6bGhXSnMxbTVJNzdYa2NuaENKaDdj?=
 =?utf-8?B?WnBTU3NqVFBUZGQvS2JnYm1FcDcreWR0MWo1MHNQMzBGUkU4K2JuZDBmVVVu?=
 =?utf-8?B?WXZ1U2EzY3dzV0VFT1NoWnZqYUZRa0xyRnFpU1l0bEJxMjF2Q25MKzQ1UXEr?=
 =?utf-8?B?ZXBzNExZVUFOc29YcCtzdHRyczZJdEFxbm5kQWRGUGhQdXJWaUlpcmREVjNR?=
 =?utf-8?B?eDUrQkF3MEVTRlRmY1NkdDRQcFNVL2JVTHlCdlZkQ0JCUlpZODgzYW1IY0kx?=
 =?utf-8?B?OC84UGxhUW55QXNTYUNqa1JKZUk2aXJwdEJGaldsZmY0MGQ3VUpOWnZzTDRS?=
 =?utf-8?B?S3dOVnQ3SHNpaThOcTZVVytBT3FiSXlKb3BEdFE4UG1GanJWNzFGdmF0YlJh?=
 =?utf-8?B?Q0RIOFUya2FhVkM1V1o1ZU90dXZUc2plb0t4c1Z1RUFTVS8xWi9lS29qc1FF?=
 =?utf-8?B?NEJjbk82QjV2Z1V1RW9aT0ZvQy8rRHB4a3ZqbVpZTUFTWS83STRxYXE0NS81?=
 =?utf-8?B?RDdCakNhUjZmUTlheTFJZHBlWWVQRkdhdmdUTHhlcDNvUGxFSFAvREdZZ0x1?=
 =?utf-8?B?VklnVDZvd0oreFMrc1NYazJ2VXoyNGZtaXQrejdhV3VJSWRsN1R5OGxuUEV0?=
 =?utf-8?B?NDFhNGIvVWpjcW1qbVJHWkZMVmgrMnZESGliVUJhY2NSN2lvTGRQQlFadXh6?=
 =?utf-8?B?TEw4SGtqWE8xL1JMUXI2UGlJZ1NKMkVYbFc0TVltSjdUS3ZLcFZwRFZ2RU1n?=
 =?utf-8?B?VEUrUEZOUWRDVnlBMU1SeXJqWTVxRUVBNVFvVjhjL3NVcGpKMi9YMzVia3lF?=
 =?utf-8?B?dXVHNUFGSkh2V2E5VVFpWjJEVlJvK0EzSERSUFhXRmJCenVrRERTbU5qTVFq?=
 =?utf-8?B?cFpoeENOVnVmNXVXN09CZ1VJWWttcTlERFZxYmJXZVN3YXN2WHZHNGNHTXcy?=
 =?utf-8?B?eVRkY1NHL01TT3V4KzBlczJIS0p3eEJRVEllRUlNSWZqRFZrVENnc3FPMUdq?=
 =?utf-8?B?aTQwdVh6NzdUMnI4ZnRhVUNqWWEwZW1TS284WnNWUnlBOU5zVmhqQ0Y5Z3Fh?=
 =?utf-8?B?QmhrOGxDUVRQakp4TXE3S2tSeGpldlRnOGVIUm53aG9KU21xbGR6REZtNlJV?=
 =?utf-8?B?b0V4RW1acGVoRktQVzFFSXhjb2lkSmQxaGhJdUo1a1hoYjJVUjVYYlcyMTRI?=
 =?utf-8?B?Z3dJRnZNYkV2enE1d0h6UDg2Z05tRDJEK21uZmszSGZ3cTdDSzdpcW5JWFF3?=
 =?utf-8?B?UVNoME1jampkRS9oVXM0SmgrY0FZdkRQd2R0R29ndkhhcU5BWTlBN2FlaXRX?=
 =?utf-8?B?aE5rYmU2WDlwUHMzdGlyMGk0UkwyYzZBdUxaSkxEbzRKWEpUT2lrZE9OWTUz?=
 =?utf-8?B?MzRSVDhmZWxlTW5kREdVbjZjd09jT0xIN1gva3FFbDZnd0dST0ZEbDArYVh2?=
 =?utf-8?B?KzRiWTE3aWVlTXhnVzl5SkZtaUYyU1IzVWdkKy9HaGtQYnBJRFJaMUV0M2xa?=
 =?utf-8?B?OHJ5ZFJuUUNVRG41WUZQQ2VTeXl1dFg5M1JlTSt4L0RTTTlxd3pZdXV0bnNZ?=
 =?utf-8?B?b0VxY1dlOFNMSFVrcDZvVjlJc2RLamg0QytmM0xRNXBSWk44aEM3NVZKdXUz?=
 =?utf-8?B?RElrMWE0R096MWVmNDBBTnkzS3NKc0FKdGJhdk8zZnhydnRWaDd6ZzZTY0Jk?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bFZVbUhpYWtUUE9IaDJweHhESDVGRGk2S1Job1ZFMS9heEcySnZreVZUa0pM?=
 =?utf-8?B?QWRYaTlyU3VyWk5lOUdDUGNmZUFPMVNGblVCeTdYRS9oZDdtcTVad0pyNTU0?=
 =?utf-8?B?dkp0OU93UVRtMVFzMG9CYk1BY0ZPcVlyYk0vTnMzRlVrdHhMYXlYUXBLY09Z?=
 =?utf-8?B?NUtFL0wzRkh5bTJGWHZPUkp2MWRBcWlUNXc3ZlZ2SU9PdkdVMk9JQ1QybjhW?=
 =?utf-8?B?UFl3VnZLSVRObEovdklqbXR4WktrMjQvQ3dmNjUvc0V1RisvRUd0MFY0S2FD?=
 =?utf-8?B?UVhML2lLbVpzcWprdmpCdWV1OUhPUGVndWZtVGxhYVZLRjNWcTVYZ3JlR3Bn?=
 =?utf-8?B?cGV6aUVBeWd6Rjl1ZjRITVBuOGVFeEVzbVhJZXgvUVhkamlOZzY0anFud3dn?=
 =?utf-8?B?VzYxVlJ0N2lTNkZ3NjNSZjVhSFBEb3F5emhRK1ZLUldvb3ByMXVBblRTSjlM?=
 =?utf-8?B?SHM1N0tzT1FHK2lEUk9mYVJaMkxxZmhXRmhrTldKeHpwZXh5dlk2K2F3Wlpi?=
 =?utf-8?B?N2Vva3N2Z3dKZUhVTVZXM1JKQlA4ZnBIMWIxMkZLY3dtakM5VEtiU0tTdmlB?=
 =?utf-8?B?Q3JwcytPSm1mS3FlNXIyMTQrdkpyVzZQS1c4QmxwdEFycnZCWXFVMXZPbk9l?=
 =?utf-8?B?SGFJMmk1OXFkdHFQS1RpSXl6N0svZ1krYVlWQVNPcjZMZ0RwRE52dVkvd3Ny?=
 =?utf-8?B?d3YyRVNqOXdoTXpnTVRmTlluTENBSTYxMVViOXJnNGdEdzEyUFB0d0lQcDRO?=
 =?utf-8?B?K1dkUURCa0Vrdjc5U1p1c1hZSWQ1QTYxWlQ5eStVYXlySlcyZnE0MWRJKzBr?=
 =?utf-8?B?M3NVM2xxcU1ydUpvWEtLOE5qTENLQWxDTUJieHhWd3VKVUY4S0V5SEM1NWs3?=
 =?utf-8?B?QkNhS21uSjV5MlpWK2F2S3phQ21LSlRhWXNKazcvM01kenZCL0ZtbEcvendX?=
 =?utf-8?B?Mk1IU1FNQmpNWm5kbnRDaUNjUnhOaVUzcDdiYVdHYXVVemtHOEpSbkRyajZG?=
 =?utf-8?B?a01RRzg1WjhZbVROMzh3THRTVStudXJYRDlCZGVocEU0V0J6WlZPOSs1SnEy?=
 =?utf-8?B?VkNDK01PMkpoeWpmWkRDSkkxelVNWmZjbjNCKzRTZkJKRGFnQitZa2luNjRY?=
 =?utf-8?B?c2tmeFFUZVRzdUFwWXlVN0xvSG9hbUZaN04xVmF6STlPMGhKWDVIRWNlcVd3?=
 =?utf-8?B?NHhYZVdRREljeDZETUN5OXB1TTZpZzNpUTdsTi95YlpZcmJIOTRmTWVCMXdR?=
 =?utf-8?B?Vmt4NS9YOU5pYSt1TnlGMDRJbld1S2h6eTYxbi9IKzVVNTVhWHl4dmRreEpx?=
 =?utf-8?Q?vSjz74eSpax6Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8f72e9-fad2-41d0-95de-08dbc5ae370c
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 14:20:24.3623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHNhwn7aVNyOxIJN9SEi/vsI/UdshgE9/7JPHmfteu8756WsmrKXJMwgvhbtmMh2xNZYcGcU2hAkM3RIBaSJXW6rKj2uNjW31tEwuf6UCJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_08,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050111
X-Proofpoint-GUID: mVlcxz53IqYY4A4j7IjyFqmS1OkqXg4m
X-Proofpoint-ORIG-GUID: mVlcxz53IqYY4A4j7IjyFqmS1OkqXg4m
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 12:15AM, Manas Ghandat wrote:
> On 04/10/23 00:46, Dave Kleikamp wrote:
>> The size of the xad array can be either XTROOTMAXSLOT or XTPAGEMAXSLOT 
>> depending on whether it is the root, imbedded in the inode, or not. It 
>> is currently declared with the smaller value so we can use xtpage_t 
>> within the inode.
>>
>> I had promised to address this, but haven't gotten to it yet. I'll try 
>> to carve out some time to do that.
>>
>> Thanks,
>> Shaggy
> 
> Can you guide with the workflow of how things should be done. I can try 
> to work on it and resolve the issue.
>

I was able to cobble this together. It compiles cleanly, but I haven't
tested it yet.

In order to make array bounds checking sane, provide a separate
definition of the in-inode xtree root and the external xtree page.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
---
  fs/jfs/jfs_dinode.h |  2 +-
  fs/jfs/jfs_imap.c   |  6 +++---
  fs/jfs/jfs_incore.h |  2 +-
  fs/jfs/jfs_txnmgr.c |  4 ++--
  fs/jfs/jfs_xtree.c  |  4 ++--
  fs/jfs/jfs_xtree.h  | 37 +++++++++++++++++++++++--------------
  6 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/fs/jfs/jfs_dinode.h b/fs/jfs/jfs_dinode.h
index 6b231d0d0071..603aae17a693 100644
--- a/fs/jfs/jfs_dinode.h
+++ b/fs/jfs/jfs_dinode.h
@@ -96,7 +96,7 @@ struct dinode {
  #define di_gengen	u._file._u1._imap._gengen

  			union {
-				xtpage_t _xtroot;
+				xtroot_t _xtroot;
  				struct {
  					u8 unused[16];	/* 16: */
  					dxd_t _dxd;	/* 16: */
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 1b267eec3f36..394e0af0e5df 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -670,7 +670,7 @@ int diWrite(tid_t tid, struct inode *ip)
  		 * This is the special xtree inside the directory for storing
  		 * the directory table
  		 */
-		xtpage_t *p, *xp;
+		xtroot_t *p, *xp;
  		xad_t *xad;

  		jfs_ip->xtlid = 0;
@@ -684,7 +684,7 @@ int diWrite(tid_t tid, struct inode *ip)
  		 * copy xtree root from inode to dinode:
  		 */
  		p = &jfs_ip->i_xtroot;
-		xp = (xtpage_t *) &dp->di_dirtable;
+		xp = (xtroot_t *) &dp->di_dirtable;
  		lv = ilinelock->lv;
  		for (n = 0; n < ilinelock->index; n++, lv++) {
  			memcpy(&xp->xad[lv->offset], &p->xad[lv->offset],
@@ -713,7 +713,7 @@ int diWrite(tid_t tid, struct inode *ip)
  	 *	regular file: 16 byte (XAD slot) granularity
  	 */
  	if (type & tlckXTREE) {
-		xtpage_t *p, *xp;
+		xtroot_t *p, *xp;
  		xad_t *xad;

  		/*
diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index 721def69e732..dd4264aa9bed 100644
--- a/fs/jfs/jfs_incore.h
+++ b/fs/jfs/jfs_incore.h
@@ -66,7 +66,7 @@ struct jfs_inode_info {
  	lid_t	xtlid;		/* lid of xtree lock on directory */
  	union {
  		struct {
-			xtpage_t _xtroot;	/* 288: xtree root */
+			xtroot_t _xtroot;	/* 288: xtree root */
  			struct inomap *_imap;	/* 4: inode map header	*/
  		} file;
  		struct {
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index ce4b4760fcb1..dccc8b3f1045 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -783,7 +783,7 @@ struct tlock *txLock(tid_t tid, struct inode *ip, 
struct metapage * mp,
  			if (mp->xflag & COMMIT_PAGE)
  				p = (xtpage_t *) mp->data;
  			else
-				p = &jfs_ip->i_xtroot;
+				p = (xtpage_t *) &jfs_ip->i_xtroot;
  			xtlck->lwm.offset =
  			    le16_to_cpu(p->header.nextindex);
  		}
@@ -1676,7 +1676,7 @@ static void xtLog(struct jfs_log * log, struct 
tblock * tblk, struct lrd * lrd,

  	if (tlck->type & tlckBTROOT) {
  		lrd->log.redopage.type |= cpu_to_le16(LOG_BTROOT);
-		p = &JFS_IP(ip)->i_xtroot;
+		p = (xtpage_t *) &JFS_IP(ip)->i_xtroot;
  		if (S_ISDIR(ip->i_mode))
  			lrd->log.redopage.type |=
  			    cpu_to_le16(LOG_DIR_XTREE);
diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
index 2d304cee884c..5ee618d17e77 100644
--- a/fs/jfs/jfs_xtree.c
+++ b/fs/jfs/jfs_xtree.c
@@ -1213,7 +1213,7 @@ xtSplitRoot(tid_t tid,
  	struct xtlock *xtlck;
  	int rc;

-	sp = &JFS_IP(ip)->i_xtroot;
+	sp = (xtpage_t *) &JFS_IP(ip)->i_xtroot;

  	INCREMENT(xtStat.split);

@@ -2098,7 +2098,7 @@ int xtAppend(tid_t tid,		/* transaction id */
   */
  void xtInitRoot(tid_t tid, struct inode *ip)
  {
-	xtpage_t *p;
+	xtroot_t *p;

  	/*
  	 * acquire a transaction lock on the root
diff --git a/fs/jfs/jfs_xtree.h b/fs/jfs/jfs_xtree.h
index ad7592191d76..0f6cf5a1ce75 100644
--- a/fs/jfs/jfs_xtree.h
+++ b/fs/jfs/jfs_xtree.h
@@ -65,24 +65,33 @@ struct xadlist {
  #define XTPAGEMAXSLOT	256
  #define XTENTRYSTART	2

-/*
- *	xtree page:
- */
-typedef union {
-	struct xtheader {
-		__le64 next;	/* 8: */
-		__le64 prev;	/* 8: */
+struct xtheader {
+	__le64 next;	/* 8: */
+	__le64 prev;	/* 8: */

-		u8 flag;	/* 1: */
-		u8 rsrvd1;	/* 1: */
-		__le16 nextindex;	/* 2: next index = number of entries */
-		__le16 maxentry;	/* 2: max number of entries */
-		__le16 rsrvd2;	/* 2: */
+	u8 flag;	/* 1: */
+	u8 rsrvd1;	/* 1: */
+	__le16 nextindex;	/* 2: next index = number of entries */
+	__le16 maxentry;	/* 2: max number of entries */
+	__le16 rsrvd2;	/* 2: */

-		pxd_t self;	/* 8: self */
-	} header;		/* (32) */
+	pxd_t self;	/* 8: self */
+};

+/*
+ *	xtree root (in inode):
+ */
+typedef union {
+	struct xtheader header;
  	xad_t xad[XTROOTMAXSLOT];	/* 16 * maxentry: xad array */
+} xtroot_t;
+
+/*
+ *	xtree page:
+ */
+typedef union {
+	struct xtheader header;
+	xad_t xad[XTPAGEMAXSLOT];	/* 16 * maxentry: xad array */
  } xtpage_t;

  /*
-- 
2.42.0

