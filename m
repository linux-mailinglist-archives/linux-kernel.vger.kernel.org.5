Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12100779245
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbjHKOyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjHKOym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:54:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F12D30CF;
        Fri, 11 Aug 2023 07:54:41 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDH5Nr005336;
        Fri, 11 Aug 2023 14:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2Jm+PPVNoORZBuXFOmo6RQmoYr/XOU15qKJxudI7wUs=;
 b=lrPbwWn3/cc1aLbRDH0mP+E9qA5W40eWlg7s2jHzg1N8BwY1k7MCxGk4gySDV4LEXzmy
 Fj/aRrr62jmpp5IP/qMkvABdoHR0iAH1jl/PrNyd2ynUOwd9lIF7J9tN09/jtzahgQU5
 d+C8ho4bKxeIhpV7xtVCfL4H/7EYxHNY6UmBelxR9pt3NlUIxSjgintdyv+4207Y/PW/
 45gAqKvLMYSuffXiURKvHttMYT+kcHoh36ocJBUmI6YvVmiV7lDrjvf1/mK+8bF+kOma
 f/gmVcaUoZxSH5nD9czSMptZAlZ/9Wy2FQHLzhJJLCfi2O/67Wh3BJs3KQpfxf3k4X68 pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8y497dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 14:53:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BETK1o033480;
        Fri, 11 Aug 2023 14:53:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvaf5rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 14:53:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPVtr3vumG8HGwfxN9S7lXV3CjOBNxLGRnu5PGIRA1HkM5wao0BNbhtX9dzbfgzZS3gXaav9fZ2tsY9PmsmPVwavnb0wt2bN6Cp/dG384pTJQRkNbS4SJ5y917DtDg/ldz7dW0EDASi+vqza+3JxfRifvQDGZ0YZnSR2MehQKS4bMK2gYw8NWt4RN0TZDrvPItoJ4dbd3ICXlaLkEgAyNWEJihKiyLZEQte9kf0SXvIcxxytsp3xAkF+9hXYDJO528HElWtXz8hly0phztISN8u8tyR7888uCtfF9ylFSwyKiWjGxRQ+HWgmLNx/2HzeL3XSCydPqmxXj5OFu4x7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Jm+PPVNoORZBuXFOmo6RQmoYr/XOU15qKJxudI7wUs=;
 b=h+AG6CcdsIiSrOQ5eUeXLuKQYXNbSNYIvjFNALX0GfSKmOPpCbYwazAELcfvBVUaa1dBKZIRt1AkP6lYBDcHoFjV8F05YIQK9i+4W2agOn0yvXqC97Q+i8BHt5vMMKFUbvIA7HNunjpsAPYfLTaipLb9HqcOA3qQtNrt3NYyJh1F1hCY9M5703zBiTYkdvXLYhbaeo/TV1NA5DowQG8d3MlfSS3E9CG844l0pbqMzn4tl43wSGtPmbqdQV98nYGjCaq20yCSwU+n8z9A+m5T8bXffJoKNsw5GcxewCOrldSF/sKPg5jPQFRuQN1Zlm3fimkLr66x2RKpHBPdakko+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Jm+PPVNoORZBuXFOmo6RQmoYr/XOU15qKJxudI7wUs=;
 b=nV07OFjMyDgCp0LlxcDvYkTDpQOLun7ka5KqboIGu6LbDACeOV4/qMhSOraqIsoIuroiKfP9W5nlkT3/+27tzDoAmI/I4dmfZ+XhX+LYix+I7E4awGYrj8G1W1X/DITqr25NKaOHDw5Ht6U+2/vLNVMqtNRRlAHf6QurFyYli/M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB7256.namprd10.prod.outlook.com (2603:10b6:208:3df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 14:53:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 14:53:53 +0000
Message-ID: <3415f9ca-72bc-9200-04ac-3848bee09733@oracle.com>
Date:   Fri, 11 Aug 2023 15:53:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 4/6] perf vendor events arm64: Update scale units and
 descriptions of common topdown metrics
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com
Cc:     Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20230811144017.491628-1-james.clark@arm.com>
 <20230811144017.491628-5-james.clark@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230811144017.491628-5-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0395.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c3582c-8b44-403a-7a7e-08db9a7ac7f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0NqWir8h+brIGxreb5jiwnPoq1EKpyNXI5A4iqfE9OlnlUWe/REZ9T7pTEm7lZoJNDi31G2DBrPMs26UwwRpiRIsL4JkC88V3j8GMK+CUi2rfpWWoL82GirVf/AXb9ZlkAdE6v2q1bRp4ps7fxPD/ySAdWgzJTmUtV8XBzbTv8KKSkDpZOfHBxvdwfeJC9en5k9pJRW3Tv6BwR/Ltdzf0kkMa8+xNCmnmYX0t8zxRZaoKIZo7q64ya98lAjkGngBUzKm1dTOT1Z2dSOm3Lo+yf0IWG532Xe/GUBhcX3gK5lVlt3UQNy1Y7KlehbU0RNVtJHM1SIBoTrx1pmrceHEDvSLjc/SDpOPNZMn79XHIoVrTVpf+hR7mXc2YW2CJoVtXtjUNSaBtGpQJ+nvC53giMDS1t9kmjxhwdEPciX9wCIEk1APEYNH6J6Sl8dYM99lna0VUeZMqdjbZ575usxXu3OLHjLEjypSqXEmC5/w0GJG2Qm1C0LmYHlKMrNBoUHnawjGKj04cUN4IcZODpnhGf1HQLTJNp3YhIqUmFJ0f1L8hGZe38vlr/Cvo5waDn6mEjnEeb4WzZVnoOc3MlRW/Rq1Pss8ADlJ7auaebf2n2iY9WkVYxb0cU/SE1ovXwamxX+NUi/xQhxCzeh3PpT/4Iqaccvk2KMAISc8/uzuqZOnYDLqp3tbo19H4jkgg5Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199021)(1800799006)(186006)(316002)(478600001)(6512007)(7416002)(36916002)(31696002)(2616005)(6666004)(5660300002)(6486002)(66556008)(66946007)(86362001)(31686004)(41300700001)(8676002)(8936002)(15650500001)(66476007)(4326008)(4744005)(83380400001)(36756003)(2906002)(53546011)(6506007)(26005)(54906003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFlrVmZ5UnJlNzE1cjNPby9MOXlpYXczR0tGN1M1ekpackwrRE81bWljOXdH?=
 =?utf-8?B?UUR1UVNPYmZYRHlSU0tsK0xRUTA3L1YycmZmbi8xdUEwbEE0T2tSVHFDTmVr?=
 =?utf-8?B?OVNjakZOZFVqNUhxOFBVY0RsSlBKSUJCSjEvN0hNMlZTUFJhcVlwTlpvNE9o?=
 =?utf-8?B?aElwT3ExYWoyYVFoeTFzdklTWUx1VzJMbXB2U3Zra3g2U1VnY3h4QS93SkdE?=
 =?utf-8?B?YXdCM1NGNjZDb3Jpd1ZITU9aME1yOVk4L2EyQXNBcndkMTJKMnBFVUt0NFVa?=
 =?utf-8?B?MmtmaEo5VnpGRWxRcG5ZQkhsVXBNbElCSmVDQ2owOVNmQk00d1ZKTVpvMG85?=
 =?utf-8?B?eEFPYUhvY3hraUtIUTVmV3NZd3FVdy9YYzVNbXVYN3dBTWtXdWkxUlU1UnBy?=
 =?utf-8?B?VGRBdURlMThJci91ckh5enBlbWZUcXM3WGh2Mm16SW9JK0V6alM0aTNqVFJG?=
 =?utf-8?B?WDBxWlNnRENkS0E2MU9nWUNoc1JIamxES0YrRDRoTlk3MFNzRXVKb3NLVk5r?=
 =?utf-8?B?eHhVNDBOZUFBdkNQZ01DbWlTWUFXdlp0Z292dzkyWFZ2RktMSDN5Z04zNmJI?=
 =?utf-8?B?RGQ4TnBhbGkzcnFYZzBJZzB5VGRjMUZxMDY1R0pzbEZkdFE2K1lySjhzUEtv?=
 =?utf-8?B?ZjloVHdkWjNSSzZTakRtQjJrdEw4dGo0YzNVU2RVVTY3YzBhQ3RYVnBST1VV?=
 =?utf-8?B?c3FDbEk0dWxmakhGS0xZOWdJUkJjTVF2ckYydmJXUnpKZ25OY2JsWC80d3V5?=
 =?utf-8?B?MEhZcjFPU3pnVTkrYUJCajNodmRvRENjZDI5ZjdieGJZc2VJeElIdDlGeWxl?=
 =?utf-8?B?RGZnQnhqelVBWUxOTkZjcTB0cldIL0hkQVd2ZTYxMHNSbkpkTGE1dlg4TFU1?=
 =?utf-8?B?RUZ0YVNFbHBhblVRd2wrSmxDek04Y0gxdUFJd0dPYzhVbmhISzI5cWJreUh3?=
 =?utf-8?B?cVpRUVcwVTl2NWhDUDhkSGZkNUJTSVc2RXhGTUUxVmkvcDAzZGpiTm8rRSsw?=
 =?utf-8?B?TDNHaHI2VEt0bG5MZzMwVHdwc0ZKNHV5TWovNmo5K3diMnNFWW0xRHFESTNV?=
 =?utf-8?B?UDVweWx1VnVDSkxIcTlwRkE1NFMzWXpJNlpRbkV5UTlwNlM1empvUFFycXNR?=
 =?utf-8?B?M2lqUXlIQUtpODZ0V0VRajFCSGdTekhxVlMvWHc4UE1XRm93MHF4UGI5WkE5?=
 =?utf-8?B?OVBqcnNOQ0NIdnljb3kwY2lBbkhnbkErRE52cVhkNEczaEEzL21rN21Tei8r?=
 =?utf-8?B?dnVpQ0R5b280QzNGbWsvWjFoNkUvTmJaczcwa0w2elNaenhIZk5zL0FSbVN3?=
 =?utf-8?B?OXN6N2FkV0N6WkhlaTFYMng3RmtQMmk4MCtJSEdqN3NnN0Z6M1FkeWdseHU1?=
 =?utf-8?B?Mjg0cjUzalVxdmt1b3BocFY2RzdiUm9JUTYzK3FMc015NkEwZW1pUVhGUUd6?=
 =?utf-8?B?S1U2bER0K3RhVkxlRXNoWTluZHRzZmZNd1BIM2sxaE4wLy9wSHdSTm15NFQ2?=
 =?utf-8?B?bVh6dXZwNTAyVHEwaWwwNjhSZyt3eG5xblBwMmF0UlJKeS9VdFJxN1RETmpu?=
 =?utf-8?B?ckpFZjduTUNLNm1PQy9yWVZDUG1FZERuZXZodk1HaEpGZmpGT1pXUjY2MnhZ?=
 =?utf-8?B?OTBSNEpiQ3FpbjE3eEU4TDlCQWJzUTVaYVBMZjRhS3J2VG0xaU11SDZIbDZj?=
 =?utf-8?B?bi9EclhiWmZOb1BkWTJaTzRzM0dzeFpSQ1RZVENqczBsNVpuaUJIM25iaUwz?=
 =?utf-8?B?ZjVldndTU3JIdnZOL3RHQXZzSlIvQzdpM0lPTUhYNWprajc0ZDRvak9HNFRV?=
 =?utf-8?B?Q08yNTlJcXhMY01HV2plUkU4Z0pkUFgzTU1qNStKanpUYVNLOVZOaEdKbFJ4?=
 =?utf-8?B?OTlmZ0JhaExGTXA1dmRhVjNONzNMeDM0ZWsxM2R4dFlnQWpXSFlIQ1JwVGNY?=
 =?utf-8?B?RXJFNWlOMk5YN1ZLWTdqQUQ3RjNUZjhTaW1NQnpFTzB4R21yTTNtaXhCQTgy?=
 =?utf-8?B?b3hOSnRIMTl0WVRROEpjWWtpdWh0anFsVmxCQlByR29Yb2prSmZrT3ZwZ0My?=
 =?utf-8?B?T1Nia21PaUFobFE4L1pTMENrc0JOS0xlUVdzZlREUU92UGVJY3JrYldNWXQ5?=
 =?utf-8?Q?19r4cJaq9ZXh8nCe2Jmr+3tv5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UTZ1K1d6SjYvalZKcVFEZ281MmFteVE0YzdGcUdpK1lPK255clF2Znh1ckNs?=
 =?utf-8?B?S0hjRHBVUWJ4Q3VZVFlCTjJRTmZEQ0paWWZxT0piMVV5QjNpSnpiMjRRMjZm?=
 =?utf-8?B?WkF6cWVMcmlZN1k1SzYzS3hpT212bmoxWWk2OElrVGtodm5jS0RHSFo5OWdS?=
 =?utf-8?B?RnNUVGZtNFFwZVJmZy9MK1cyVnRmOHRVVlJveUllMXRWYWhxRmJBalExRWcy?=
 =?utf-8?B?UXY3aVFGNFBSYUwzSDRrUTJmTGlSbUtkeHozaW85dEFGbXZyc0d6MEt6QnBK?=
 =?utf-8?B?UHE4YTFBUE9OaVVYZnFUYThYek9kWWdqT1o0dTlYdis5dE1FdkZ1a2RCdVFh?=
 =?utf-8?B?ZTVQTXpvREswSkhTZWpIVEhFaTRDMHdDMmJxeFdXUWFNQUpRZmFOb1dkK2F3?=
 =?utf-8?B?dTJvT3AzS1M2ZHQ3RFVWN0R6c0Y5Z1BJZzBZdUEzZm5MZ0JGaTg4V3h6RkNJ?=
 =?utf-8?B?U0hxRnhPSlhLaFkyVkJQeU10dm1CUHVEa0JlZ2oxZEFzRHNtNndsRDcvcGdj?=
 =?utf-8?B?L3hQZEhPekpYRGhKdjRvai84K2ZjZVQ4cHlNTVJLUVJWbWNaYjJTMC9CRmhL?=
 =?utf-8?B?UDBGdUZrczRBeldHRVdNNkw5czMzdjlwVUlMMXFDYUtOWDBJU2lwMmlFVC82?=
 =?utf-8?B?WmJhZ2c3TW40QTY2MUdKUlRzaExoT1MrQjZHVHFQSm5RWWFjNVJqdWNkakhY?=
 =?utf-8?B?VEwycHlSemF0eUtET2xrQnd5K3FqTVI5akYzc1ZVOENNU0lONW80OTRPRXlp?=
 =?utf-8?B?NUVDR1BWbWhVSmhrMmhUSjEwa2c2dWhwVGtVMk01aTd3NkJGVWJoemxEMXZj?=
 =?utf-8?B?UlovMy93bVlaRkl5L0JtS0FoQWE1Sk9vVUVCdkl5R09tTS94VE9MQ1hjN0JC?=
 =?utf-8?B?cWlvQnhVazJBRGlweXV5NHlkRkJNRW1udW1lQWtSTlhTa3RqUjRkZ2gxTkh5?=
 =?utf-8?B?dkN5MVNvcHhNU3RDQUxjSlJrT2ZaeUJYN3FpcDNNVFJwOHJXUHNReCs2bUVn?=
 =?utf-8?B?K2Q2T0w1L2ZJYUxvVFlQRzVkdWhtdUMyQWhvejBmZk9Vd2QwQkl6K09tUXVD?=
 =?utf-8?B?MmY0WGw4VEdIdEZOaEpGbGZodDZRQzlNOWk4UHJqNjAzemtwcGE2RGRXNzZs?=
 =?utf-8?B?N1dNMVIyRW1aQ0E5dE9zOGt6Smx1YTBQQkV4U2R5SHdxZWtoa0V2QWlqSXhp?=
 =?utf-8?B?d2Q1YmxrdGJzcFU2RGxtMkN1ZDQ0R3FxK01Hc1E3cmpudDJOQXpVMzhqV2tC?=
 =?utf-8?B?RXJPM3pxaFVsVy9jRCtLeHVlSkMraGNiZDdURW9HUHZpa05yeWxHNUNKU3R0?=
 =?utf-8?B?VW82QWpSbTZQQnAwdUNmcTRnTk4zNG55ODVFYzVpVTRuVy94YW9FUmJPVER5?=
 =?utf-8?B?MGcrazhrYjR2c1ZiUlJsVDk1eXpkOUJ0Qi9PVFhreWt5QyszVGVBV3pRbUI3?=
 =?utf-8?B?OEdQcm1XNkl6QnV4Y2p4Q3ZwYmQveE5wTDc4TFpzUXYrTEV0d2EyMkJLVnls?=
 =?utf-8?B?ZzF4TFpHWVNGc2Jvck9xMEZ0UkY4cVViblZPSkpkYUZ5ajl6b0pYMkc5Rzgw?=
 =?utf-8?B?UVJiUFUvNnFpK2NoRkdPbWNmeGpMSE9lUUpkRkNyTCtWdWE2alMreTU0Y3Jk?=
 =?utf-8?B?anlvQUJLajgzYVphNndheEgvcHpHVFE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c3582c-8b44-403a-7a7e-08db9a7ac7f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 14:53:53.7216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wd4ic19pLkvgmuDwJnQXlqGBFlVL87WlYm/Kl8BnViPbe/H4vBY8kIJsBiGJONMtxvX5r/KSFaMpWMUt3zgqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7256
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_06,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110137
X-Proofpoint-GUID: FtCxSEuQ8gLYh1fj7tlF5CLfNOzmuorQ
X-Proofpoint-ORIG-GUID: FtCxSEuQ8gLYh1fj7tlF5CLfNOzmuorQ
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

On 11/08/2023 15:39, James Clark wrote:
> Metrics will be published here [1] going forwards, but they have
> slightly different scale units. To allow autogenerated metrics to be
> added more easily, update the scale units to match.
> 
> The more detailed descriptions have also been taken and added to the
> common file.
> 
> [1]:https://urldefense.com/v3/__https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/tree/main/data/pmu/cpu/__;!!ACWV5N9M2RV99hQ!P1pT5PYzk0os04MQETZD2-22Rp9SCpDzrGV4g-wWDSx0667S3YYkIMArEI9wYBa2SlzR6Jnu2GKRjYJqOHnGrg$  
> 
> Acked-by: Ian Rogers<irogers@google.com>
> Signed-off-by: James Clark<james.clark@arm.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>
