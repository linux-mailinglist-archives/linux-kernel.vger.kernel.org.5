Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C12804D49
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjLEJLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjLEJLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:11:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117AA11F;
        Tue,  5 Dec 2023 01:11:40 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B58HWlh022730;
        Tue, 5 Dec 2023 09:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Tckna6nGe2YxX6KQVKTSdhnYcbpB3tSQV9RGkHGuylY=;
 b=ZwpHsMQD4PAI2ZwsKN9L+DpzY5rYXR28knjMid13kO9w2KRglNdGCgiX9NulFkhe9xZK
 Fm0FMlPJkFJWL4kxKgLg/6MuvH9oDzswDoktns81Gxe9UtcunPkRQHzSDg8ik8t9qsls
 fYt33w2ggcEnZQSa9fJ2G7Og+hQf/Xm4pJDNQ3nc3ugmOPtf+N9yjmQLb5HZMrExLHKO
 bIFQlEcKLMQLbHtRFyHu5Sdw7+nir6jOY6fXeVdIW0qLt9E4ZOqfTsAVxCyTlf6Mr5Wm
 p8iQpppcCKW9DBw1MOjw9GkdQkUfF3MPkUvWRGWsjlQb7BTwNUCn8X5hwDgZMSi7WhbE 5w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usyher5qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Dec 2023 09:11:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B57V4mh028665;
        Tue, 5 Dec 2023 09:11:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu1dkx67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Dec 2023 09:11:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUi9x2Z4yLuOSl/hb0lKMBaXmgUj7RMG3cV4TANQdo4TChrK44+dzz/M/cpCYrpa32x9lTGTL5dk8adZ5hhGEzRmxIey38yJwTNsWlbAbsNpSBCgpFWUBmCBXDXqb1hgNEZ83RdfDzIRgwz1j4eBSwrIS5pCMNRIecOrBifvPrm/3FaDzskYjs3gWBpQVsOvCLniDIqRbDhd8QNTlvGW0lwDxnYflOEhLBfb7rhK+f7EnGUt/mQWH9d6k4Adzeoi2ZOUAv6KS5WpXp9h0wKsDRNXgdhs+U2E2B/x7BY6N45j+0rzUIubGslszAye2Xs9hAkSD1LdLE54RaTdqy2sOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tckna6nGe2YxX6KQVKTSdhnYcbpB3tSQV9RGkHGuylY=;
 b=O16X1ydp+FFgnpDW7M4Pw5LEpVlFqS6upmkxiUS65JIaCmxWEpsywQC3B2wTni0ERP9PRuCUIpr7W/eZRDbxzmF/u3iq0iu/k/p/DZt5ELyjwxYFL0kQ0x7wwv+jKf56wpcGxnH2wY7XetpCz/waMepyKn1qYIRslZPW3HhwtJ9HGpHy35hFsiY/PeD279yCJDKuys+HGgV1jOjwS9CJP9KbZIN5MzPaYLblFYgtcN2rCJt2h5Sy6XPFFQKpIhIqQAtGwQAvQJx8EY62Nec4Rn9Zjh/mKlCLX5F8pPM03hVnjWBGO5WbJCxHv+l5Cb2WPkwRshzF8No/lvJJJfBv0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tckna6nGe2YxX6KQVKTSdhnYcbpB3tSQV9RGkHGuylY=;
 b=Nm3nfgr7OJ+it9EqoXVd/t8mybSPHhddb2zgKXoVCS0ELZbQDx2sjZidSyNmsSp+fapICNOICtUFI6pSGf5Oie3QkamU5dIWnAi4ya1rKXTbTePAzWXEjyY0hZ4zMfM8GJTUl6r92FU/sZcl3T8g/oTHSBPsfp3Q8hmbJ+VrWBE=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BLAPR10MB5284.namprd10.prod.outlook.com (2603:10b6:208:333::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 09:11:02 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 09:11:02 +0000
Message-ID: <59a21c79-1719-4135-b7bb-324a9a348bed@oracle.com>
Date:   Tue, 5 Dec 2023 14:40:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.14 00/30] 4.14.332-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231205031511.476698159@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231205031511.476698159@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0158.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::9) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BLAPR10MB5284:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c1262b-1b98-49a5-ff4f-08dbf5721a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yu1iDD/hfdXbnQb47EevbBMEMeC104rqKx1j/J+srB77yNl9ulERN5sCH8Ztiq0zivQc90uwyyAEUlDdipqsUlBc7tGB6q4N9lUEHMA9eXOq4GhDBZLZ3dUd1dpxb11JnTP9OpiH5xmtYme26sGlM04DdH0j/3HCN0vcS9tX0v9ILYn5HEgSZxKZo2h6pLnQ9YtDS358vE6rs5AeWu+2Nd+RXMb9T289gZyKyMcMQ39uzJaguOr1/Lrpw8CV3ALULUtFMRQf8Xnzg6A++eE8fv6GHFETGxQ83eA6e+UEIAYWUZI2WpAVpCTRHwYuBLI2sxsS9NCQst34wf/gbQ/Z3VREHF4WdweKBOZ0opkK6Q0TlCP7sH9tSgjtNhYt9tXugJPL1FV2oh4MXoXrY9CSP9AhODQq+876qUyBsj5jDHmaAtTbHeNcSa7x46RRcmDVWtgLN3AOViAuXCkVB+wqDPga73G1Bp9ghFaRWzTAywSdQ6Tz2iAUD89uFpcFrYwDegHziYletA0KXr7/ChwQrBsqotzztqCL8cGba578yqvkdZuSZgEksGnvZGS/Cqzglj1ZIoaAyVkA13TuxJhDoBPkyNHE8YfFfzwYRNrZgBcp8b+oIIhGD8oWKIJ0Yv7ecix8v0ktPDNI/MFXxDdgxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(53546011)(6666004)(6506007)(6512007)(478600001)(107886003)(26005)(2616005)(31686004)(6486002)(966005)(66476007)(66946007)(316002)(66556008)(54906003)(86362001)(5660300002)(31696002)(41300700001)(36756003)(8676002)(8936002)(4326008)(38100700002)(4744005)(7416002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWRqczM4Yk9WSk5NVFBaRUhhTHR5L3lITGw2VXl5amFITWpHV1drc1cvWnVC?=
 =?utf-8?B?L1YwM1FJeXgyVnl1czQ2VDN6cllWL3RPNmNuaDgxYlFDSlB4RFNnVER1dUpY?=
 =?utf-8?B?WUZTdzdlY1RtSnBYMUF6blZCRStENWRNd2llYWJSYnRBN2FPSDZMd3pGTnp2?=
 =?utf-8?B?VXAzMlVvOWpmWjBicFFlQ0MrY3BIUUl2aldUNkZ1amVTVWkwQTlXSi9CeGFH?=
 =?utf-8?B?VnUyelN4Rnd6STJvdHpTV1FTQU02N21GcDdiMlRmbDJlWGlUbG9hVTBnTnZj?=
 =?utf-8?B?OFZwWitlODNGbURzWEtsZU90TmFEYVQwczFOQjlLdzlTQlF3VDZ6ZXBpVFl6?=
 =?utf-8?B?akJNL0wyYU14ZEFYUHlVL2NHUm1HbHpGbkxuS0hHQ1ZuR05JQjByQytWMG9W?=
 =?utf-8?B?UzNXQi9oK1RBWUFNTTZPU2RaSFJ6OXM5MjFZamhzNExQSytrTTgvZjlsaEla?=
 =?utf-8?B?eDFxMExYUXJNaGJhekJaREsvSC9QWXJ3UlJ0T2hub1k1MmFDVlBVWXpOcTFq?=
 =?utf-8?B?WEtla3JKbHNBMEVSL3crZk9xTzVBYVJ1SGV1Z3Q3STVwYVExdVB1clBmaTZN?=
 =?utf-8?B?MWpJOHVFaWVxczQya3A3M3dkUm5GYUsvaTNGTW4rVkRuTFk1YWUyWmJnUS9O?=
 =?utf-8?B?NnRFOWZsZXpkMXhHK05jQldzKzBmRXF2RVJyUmR2bEQvRFBJeW5YT0FTOTJu?=
 =?utf-8?B?TEE2VHRVT25IUmF6dUl3MXVxMGVIN2hSUnROaEhQeGdKeHFRTnFLQ212S1V0?=
 =?utf-8?B?SFZ1Q2trdnp6MEZxN2JCL0o0akFBOGxGdUFwZFRta2lMa1VwbDJMUHNac0xu?=
 =?utf-8?B?Wkw5OEl6Y0Qwc2RmbGJuZHZRcnVpTzlwZGtPeWxrR1ZGK3I4QXNYY1lNMXNo?=
 =?utf-8?B?Z2tUelc1NDlWdHV1czR4ZGgwV3Rwb0twcVNhY1hUaVd1UGFQSEcwUW5nOW1V?=
 =?utf-8?B?bzE3WThNSll3K2lZQzRxKy9hWGM4K0p4S1NCRFVjNnZFUGh6Z1poNFVuWDNW?=
 =?utf-8?B?QndzVkdKczJ4YlpJVkNDZFRReXRkc2FLVWhtSUJ5SGVQQ2s1RTU1TWdRaTJP?=
 =?utf-8?B?WnlkZTRJYzdzZmdDSmhlenlicHNtWVpqcnVJZTYvb2owT2Z4dGFCUDh6WG14?=
 =?utf-8?B?Q1pGRHFqaW5NSTFkOHpkaGhDbDhXN0RTSEZ2S2JPZ1UrWG1nUERWLzdxUUYw?=
 =?utf-8?B?UTMybENQNncyTFlQMFhTdnp2K2NXdzJGd0ordkhyWHgzeVA5Nnc5UzhWV05t?=
 =?utf-8?B?WG1EWkNNelZZSmtPcWRrWXpaS3I1WUpnYk1mUllnUUpMdEpHcVZZR0l1QWFP?=
 =?utf-8?B?bmp2YktBVHVUZisweWxKZVhHZ254dUZXKzhDZE9qTHkxYUg1dkNZa1Vqamtr?=
 =?utf-8?B?TzhUbG9Wa2RoeTBZZ0RjdWc4eWU1VHZHSmh3cC9TazYrZ3BJb0tPRnpjNDJQ?=
 =?utf-8?B?Q2RaZDhPclZpNEZNaFpKdDB0ZW1jNHU2bWMyUlJVVzFDSmVuRkw2bGNMbk52?=
 =?utf-8?B?Q1NzSEhEQlNJVStMUENWcnJqRGNqUTNOcmw4emxsMUVaZDdiQUJjQTN5RWNB?=
 =?utf-8?B?Q3UyNHJ5bWtzZm5Hd2FxZlh5cHpIeVBoVndrU1VzWFhYVURzNHl4V1J1dE8v?=
 =?utf-8?B?UDBoZnhHMVFTWkp1akhaQUtKc2g3QndwNkhhbCtPcWo3WmdvTHNSNkdJMjNQ?=
 =?utf-8?B?K1lsbHo2Y1hVaTh1bUhnVXpMMXlKemtsYnNBYXBHbzl5ZXJxS0VLZFY2N0ZO?=
 =?utf-8?B?ZHMxMFZ3OFNhVGtXTkdNMVRwTkNUcWNCNzYrTzA4R281YWFDR0orWUoyTzA2?=
 =?utf-8?B?Q1BRRUhkK0I3VUNCUEVHOFJ2RDJkWjgzTm9qSEtQM3BMaFBPRnlmeTgwMFVl?=
 =?utf-8?B?clc2bGltcDNoNEZqZmtIN2puTEJkOU0zUE8yck1hdEQrMWZHL0RTNERpYUkx?=
 =?utf-8?B?d3RzY1AvQkJpREsycmpOb2hyVXZNVzhzdU9KU2lhZVFzelgxQkpkOGRGUU5Z?=
 =?utf-8?B?Y1NNSU9vVFN5cjZkK2xPNmRzVUM0WmptUUIyMUJsbmRyejIwVDdwS1p0VFlw?=
 =?utf-8?B?SlI2VWpTdURzRUJnVjVyN0FKenpFSzhQTjZuVlpiM0ZDQW8vd1JqeDRnUExF?=
 =?utf-8?B?a2JYWEtYV3dMcWZGMGRMOFcvUS9YUktVUUpYcTkrTTFPcnVpVnlxK1E0eW9M?=
 =?utf-8?Q?GheGDzOBUJ2zgtxSdFpSG7k=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eFJUREp4ek1lems2UGNqQ05iQzZQMDl1UjI0U2VvbEZCQXZldnBmVEs2OVZj?=
 =?utf-8?B?ZkxURWIrUkkwMEpGWEFscEplM3FhVndESXpSc3FBZ0VnaDBIWTRCQnJ6YUpS?=
 =?utf-8?B?WGRIVVRNa1RxUnZJa2w1VXljbHp0YlUwSDJyeitiTkIvNE9tL0krYTgvMTVQ?=
 =?utf-8?B?LzVSa1FUSExmcXNWMDEreDNQOXFWbkgwcTJmSmxPZW1BUENmTWNTbElvV3ZY?=
 =?utf-8?B?RGxnQ0YrQ3BuNmlJMW8vTzBGNndvWlg5bUYrNWhXcXNYSGZORHNCeEE1R1lr?=
 =?utf-8?B?b3c4eTZwRzFlNkx5VEdScGwzNW1sV1QrWExDNzVvVUJ3aDB3dGN5QTM2dVk4?=
 =?utf-8?B?Z2VhRHZJKy9BTGJ1SEJVN002WWh3bmtBaHlSV20zS2hzbWF1NjNhekJRbkwy?=
 =?utf-8?B?OVRuUFErdnJzZWRKekdPRUE0ZGNGdldYMFFUQWpEVWRSZE56QVpUTHovbHA1?=
 =?utf-8?B?azR1Qmt6UUxiWXZ0Vk9LeWJ1SGgzYjFHZlErTk1YZHkyOEoyZVZzNHdKbUx2?=
 =?utf-8?B?OXM5NXpwWGZVbUVtRnRoSnBsQ3pzREJEd3hCS2xFQ2NqcGEvd1A2ZXlxOUhO?=
 =?utf-8?B?MGlHblU0aURjTlNKMFZ3L3Y4WENrNHpuMnVpM1psTUpKYm9DcXg2K2xiNEFL?=
 =?utf-8?B?ejRHdGwwRWI5ZnpqMEJHb2JrZ0lxNC9jK3ZlRENuVHJVRCswenpFWFo2bUJi?=
 =?utf-8?B?ZElBamt2dVNkVDh3Nm1KUDV3Y2Foc1NnbUhyd2NMT202TjRCQU8vR00wOTRz?=
 =?utf-8?B?dUQxZ3hjOG5uemkrOEwrc3BTa0JSYXZQSGY2ZVJZMjdHbDRtUm5YRWozQ2JJ?=
 =?utf-8?B?T3I5RThvd09OZFpHenVES2tDVXJGajZ4aUk4YktBUHFDc3VFVGplTGhaekwy?=
 =?utf-8?B?eXNlZGhjR3kxckEyK3BDR2k2S1U4TlBaRlI4a01FUjBxQUdHcHJ5K3kvcWZC?=
 =?utf-8?B?N0doajhuTFlFcEIrWllZVUNRRzZKcG00eUsrbGtxL2V0ckhqSXZQMzBNZDlE?=
 =?utf-8?B?ZXlndzVZSHZhNjlVT0Y5QzlpbjlxV250aUpjWUtsMnllZkZCRW1JRCtqTXFX?=
 =?utf-8?B?dlBadmx4R01qOXU3NDJKa1RQRSs0c0RHTVliQW5YSEpadWFwYXVjeXd4TFVN?=
 =?utf-8?B?NFpXMVBYbVlLYXJvb1dOUVkydlIxSCtFdHhpUHhxUEp0UndwbXhHWUpWT1Nn?=
 =?utf-8?B?VXdvRkV3d0xPalVVdS81UDJkMmJmVTRkU3hKdnRjMmVKL2tiSjNHblY4QW5i?=
 =?utf-8?B?N2xmdGdvNXlvVW1wS1REbU0za1luVGpLVC95ZUd5akEzY1BzT3JQdUVQSmVF?=
 =?utf-8?B?dVdWalNpU05xdk9kUFc1Y0huOWp1ejlFQVVKUUhCN0xMcEd1ZzJxZFhsbUd1?=
 =?utf-8?B?VzJDZWF5ZVhkUG9YZGxVd1dJZVc1aU1YTVhqMEcvWHZDNEcreWV6YWc0RXF4?=
 =?utf-8?B?T2RyRDlXKzVOaHVIem5DZEZNMitpa0NpcW5zMkgwOTR2a2xqQnVXeE5vNWxW?=
 =?utf-8?B?Y3AzTFM4RzVTRjZ6dEhaeStvRGV0U0trSSs2bHR0LzZHRVZVLzU0T0ZqWVpU?=
 =?utf-8?Q?+5k3QPo5+UZn75lh8Zy1/9Bs0Xs/TB1JiJNIFr9S2qv0Gj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c1262b-1b98-49a5-ff4f-08dbf5721a06
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 09:11:02.0921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwphP+l84jax7oq6qUh6YvWneylIIIh5hzJHf/GsM4vhYcO0a6aseK6ZdijcjW0CtCTq5w6htYzrqyRLZNyARjuAAScGK6GYcWvEISIHerGE7EnpPGJ8ic3cTaAZgm6R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5284
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_03,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050074
X-Proofpoint-ORIG-GUID: hH4iMPon_ezwy0jKp_jqqTGXT9nskHTe
X-Proofpoint-GUID: hH4iMPon_ezwy0jKp_jqqTGXT9nskHTe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,


On 05/12/23 8:46 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.332 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.332-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
