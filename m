Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F167E834C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345516AbjKJT7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKJT67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:58:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF76A9;
        Fri, 10 Nov 2023 11:58:55 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAHiAXv023188;
        Fri, 10 Nov 2023 19:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=TvEz1gxme2d9BuCjZHTEiGON0GguJU28q1Z6FmDqbbs=;
 b=HedDjkuQoP7JkPFqei3Z5LJYhfYKfSki57YYOAPSmnP4BNpAZtSwA8Ne8IrzvDTBlkCq
 aiYKMUSSDad9ZpdWqGrNArpFjOkj7ZNbeTI+2zZuH213s1eFXQZy8mbtSoF1zCfMaVYK
 Yi2NsGiOkKpmA9dXzIk/kDUSe9zDvADi4qcpPFqfcw9mvASthm5PC6w3rz5dUwlM5mtA
 Mb06wH8+J02BeogGdEii0smg/m1PfTY2O6nisq3zo7hnPCkCs0k/+lofgaOeGyMGJirI
 N4zIpnEn1Mveaez+ht/YOieWJ+2fhWHz639+3vaxLzqfY1SPxmoNEnUOdqsB5b9oPzss BQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w216xys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 19:58:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAJoawm011008;
        Fri, 10 Nov 2023 19:58:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1y8tgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 19:58:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLxCsZ5ftOezGn4o+ZTFaRapYwVASgq4mefTpRjXQMmvZljyv8D8BQY6jAcqBoUsQntBfCsgRCVRtdA9SjV8j9UCQACxkrbzH3W7DLNzwxhdDif+PX4abbx/2gyPofytS5wf//NEX5tCVbsBJ5BvTgypipoZ/n2lHQw9/JDef9ZMONMeVqSko+T/zI6YYCYbteRb1bEMpdiMiqfyAeOaZ5NsFxiv7tRolFqMWOgZrRt3h22bpA44CVeI8/mAutysvFFS+CKv/8Zw1GIx+Zb6dDxDTD1N10ldHZml7ZAB0QkmsG9tapD0LxBjP+yuO0K5BVlOOHmx4omjt0YEQbE+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvEz1gxme2d9BuCjZHTEiGON0GguJU28q1Z6FmDqbbs=;
 b=Wi/J/G12FpGYKgnnlOy6ii64AOvVpHinihINWsEW0CZ4zc8nQ+DeawwPD8tlXOLwXENIwvEPllPwEpKoNHzOpU7quQNx04A636Fg/8Wdpz1vYEcJ3ByYLy0MPwJfdVv8n0QYsNOPaOz6wdsdXA208rNK0GU51vv6ojqy6f9p9gNAsSGxGmmRJShPvG29j0+J5GJyv0z3KM7plUdt2GyTAZrVcK7w8cEIBSrsdP98g32bStZnVNxzxJNCgS4Dj8PAo2jVRv35AJghUGvJrMNTBzJYungnUaWDtrD7+gXY+2fcqps8s/Cl9LwfghZy8ZH4QikOfG53rG2kqn5Ynp6jUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvEz1gxme2d9BuCjZHTEiGON0GguJU28q1Z6FmDqbbs=;
 b=AuwnLLYEBMamC6NwQvhuEDhpkPPFWf7aXdCfZubyEf606kFaVkKrcY8H6e5Zl6e2kPigVTsgZgtKOpmbSh9yi4kdLPzFdeaTqW2YqAa3rZCtgY9Lb/bBpEvg557xtOVoJLWKr/xFR9PCiktyIUM/nU7rx43nDEvYgTjuS7BWJDs=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DM3PR10MB7909.namprd10.prod.outlook.com (2603:10b6:0:45::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Fri, 10 Nov
 2023 19:58:35 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.6977.020; Fri, 10 Nov 2023
 19:58:35 +0000
Message-ID: <fb97e3ea-1bee-4d7d-a8d4-dd76107f75ef@oracle.com>
Date:   Sat, 11 Nov 2023 01:28:25 +0530
User-Agent: Mozilla Thunderbird
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH v2 4/4] platform/x86: hp-bioscfg: Fix error handling in
 hp_add_other_attributes()
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Jorge Lopez <jorge.lopez2@hp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com,
        vegard.nossum@oracle.com, darren.kenny@oracle.com,
        kernel test robot <lkp@intel.com>
References: <20231110142921.3398072-1-harshit.m.mogalapalli@oracle.com>
 <20231110142921.3398072-4-harshit.m.mogalapalli@oracle.com>
 <211e6c1e-9bfa-ac29-b6ba-e198c4f36688@linux.intel.com>
Content-Language: en-US
In-Reply-To: <211e6c1e-9bfa-ac29-b6ba-e198c4f36688@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::23) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DM3PR10MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e2a932-58d4-46c2-3b63-08dbe2276c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VoZgbiMCj2Ag9oKp9SlJo2UaBZ3AnGBn2oQCeANrwS7MU3pxXaIBgdAJm5pbA3wRpNIrz+9mmo4MEH+Gxlw0ICHCuW5pDALZcTUgk1suP6IR7QFD7iwnTRQW3YcuuAHFDk+5E7ocfGn5ceSHeUHPzfDazixggguOU8eFIjXZQEudFSiZKzis2KETE43mTst5Os1H8fbnAJWCkRuejUp4GSJq3LfLYTW1r332l062EKEjwM0tJ3TVtrtASGkBUTdhYwwZPyG5mCOZx0rIWrfxEie4V9s6hTrbPA89luYtBJY0ZV4rUd6Pte4NSjRdzdNgKdsdaWxwoibOdq7iKPxVjeIsJGNxvm2++e8UV24CPXj0EBOjgAj3CAEFvaGktzpIPG5jb6ujhT7jp6BAAnXr09dMWfg9mJwHeBmO81T0EsZDpa2gte1MrNMtQkwsqgVcxADy394CNe6PMw/LxWiJW1VjT/nvxVXx0g3RJWrxVitGs/Iu3TTmO8onuuBDuo0WSONOyNHlylLknwSRlUJQg26eVdqCdDbUovmKa/Hr+LA8E5d80sQmSbfOoT3/r8tyx3QBaV4KqNQp7Y+DSF0WAfhD3bGypfZMkylPWBayQi/gzu8HRA6Uw4XOKryYXH1JGWZVjwkQCSEbEqowt5XkZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66574015)(6512007)(2616005)(26005)(8676002)(41300700001)(478600001)(6506007)(5660300002)(6666004)(83380400001)(66476007)(7416002)(54906003)(66946007)(6486002)(4326008)(66556008)(316002)(6916009)(86362001)(36756003)(53546011)(8936002)(38100700002)(31696002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3VPOC9UL0tLUDVXa2tWR0kzbDdRdzI0R1pPZXdlbzJYZ3VSWUFlUldldVRS?=
 =?utf-8?B?SVBjczZBNVBCbmVscTRjR2o2Z0tWclpmNjZ6R0drMmhWSE5vTUVzSTlJeVg4?=
 =?utf-8?B?OS9XbnRiSVl2YkRrcUR5V3Y2c2t1UUsvVG8rVzNPMEdqUDhaTTA5dzJ6Tk5J?=
 =?utf-8?B?MkNUTm5WUDRJeFlNQjNLWWsreStxVDgrMFJGR0lURlkvMXdOMXh1ZDFUSjJq?=
 =?utf-8?B?UTUzVlNIU3MyZGFwK0dKUjJqYWlYb3E3WkR2OVUzbHJYVGFQd2lhQXpmU2Jz?=
 =?utf-8?B?emxqWi92dElqamE3VjF3N211QVR6ZlpmbjZ1R0tWQlkvUW9nMWtGVXQxQngw?=
 =?utf-8?B?czA2UVJVcmV1ME1VeTc3S1kzaUxyYmV0d3RiemFRdEtxZ0lWNXFBSXpPaWFK?=
 =?utf-8?B?bFowbE5JWFdTaTBaRlJtMEpoQlVURnlxa1F0dnNKSXZwZElFK2FpMWFOdzcz?=
 =?utf-8?B?eXFBTVl2bDRnU2FnTmZSaGl1UlhQa1JJNlBtdHF6TU90czg4R0RUYjQrYldh?=
 =?utf-8?B?a0NwNVFJQkRCc3FBZllOaWs1cWRRRlVQbk9JbW9KWTIyMjVTWVpxbzZhMDl3?=
 =?utf-8?B?MFpwWWdTVFAzTGNSWlVyT2ZXOG5uSlBUYms3Vll6UmdMR3l6bW5YVXN0M2VG?=
 =?utf-8?B?cVdOWVoveUYwOHNqOE84bkcwdnQzUnlHM29wZjhzeXNncVpQY1JyTC9FQkJD?=
 =?utf-8?B?cE00NUxoYlpJcnNSNndwRHRJdGFqM0l1SU9qTWd0Yzl2a0pXQk9JRHdPaUk2?=
 =?utf-8?B?L3Q5d1ZqVXI1TVkvMVJGMWRweXlGbGlXWUdnajkyS3cxTVZoRDB6SGU2QWxS?=
 =?utf-8?B?V3ZJbWwwNXFrUGhnQUZkSVVBempOUS9lbUkxcEg0bGdoOXUyNHVTQXBYby9B?=
 =?utf-8?B?UE1xNDc3M0NNSWZtaU5lbktBKy92Wm16QjRONStrZktrajNwdjZpZEp3OTZz?=
 =?utf-8?B?VXF2RHpWNjBLOU5iMDdmTUN2akJwU2Fhbk5HUnM2MG5QcXFYOHZ5V2FzVFBE?=
 =?utf-8?B?THdDbDN6K2w0V09jTHlreThCL2E4dnYyY25jOUk1MHVNZWRzUHk4N2dVMGpP?=
 =?utf-8?B?U0hMRXpUSmcwOWxRUkZaNGpPdzB1bVVOY3ZtZTl6SFZpZ1dmUGJTTlNkMTgz?=
 =?utf-8?B?R1BmUjZ6Y1FQRThxL0tyb1BnNXB1Qzd5QTVISXE0ZEFUL3c3NlB3RkgzcVhJ?=
 =?utf-8?B?NmpZZ0ZicEk4aFd5dkw5UTVFdThOQ0EwUXAvd2R6ZEpUZXFVaTkwR0xFV1lU?=
 =?utf-8?B?dmVqdXNFVVVqVkRESmdTU0FzMlZ4WXEyWmxROW1DWnJyWGFlYUxjTU5wa0Ji?=
 =?utf-8?B?aDdBS3RhcEdMV2pYbDRkVUx2UHh6QTU2bm9JMHRCVXV0L3lzZTBPaDcybHlq?=
 =?utf-8?B?RkdJbVdGYmsrbWY2L0M1dmxjSTgwRU9mS2t1UFNyOExPcDltMnJVNjRMbWhZ?=
 =?utf-8?B?U0ZjVEEzRVZZc0R1K1hIK0ZvdXEvWGtWQUJjMUQ0UGdXZXRvUStBdk9NV0R0?=
 =?utf-8?B?b0tzVnVhTkRqL2FqQWplWHRQNE9QMEh5NUFLYnhyVTMyMjVQQy9wR3lxOEhk?=
 =?utf-8?B?SERNUk9aR1FScFNMdHVtWjUxNVRxY1ZhY1MzUWZEU294NEMyWE9MQ05sa2I1?=
 =?utf-8?B?Q3d3bTdCRVBsZEloUXJzcnFLQ2txbWc3K1QwOCt1dDZLKy9oRUl4VzJWZTVJ?=
 =?utf-8?B?UHBzU2R1Nnd6b0tYdFVMVXRjdzlKd3F5SWVpYjd2d2VDTm1tZXNJcU4weWR1?=
 =?utf-8?B?b3BmZndPTlh4VUFKcTRKL0xlNVhxL0pBQmg2cGluV2RhU3N5TWtyVmhnR3lw?=
 =?utf-8?B?VUVNN1RMeGx0WlBOOHVlM0huT3ZNZk9MaTZ4K3NZS0FET3Q2ZXRIUDBCRTRw?=
 =?utf-8?B?Nm01UDZsengrT3ZadnNCclRwQlVTK2VXVURHUHhacWFoY2dJT0xvVW9PZU9T?=
 =?utf-8?B?SWtnS3hPbW9TVmNpTVZ4TkxNSjhzeHFlT3JVdjVYdW1hVkFCM3UxcXIxeHYx?=
 =?utf-8?B?a2xwTVh5Rk5BakFjWVJ0UW4xQmRHbi9JcU56eG4rU2l5alBERlBBMi9nTms2?=
 =?utf-8?B?T2gyQXNRR1A3MElHeHNYbG9UZlZndmJJdVlpV1pSbzVkV3k2em9VbHNibWV5?=
 =?utf-8?B?c2hHZXo1NGZCQldEeUpjcGwvUW90OGtUbTNtZHZkWktJcGY5bExaTzFVaHY5?=
 =?utf-8?Q?Jh4/+tuKeo2MyvrEhxMVW+Q=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SXdQdjlmR0JubWxQYzdRNkxkNW5PWnJBNUNGV2FSTEdzd1JXa0tPY29YYkxh?=
 =?utf-8?B?Szl0bmpGcjZqbk45Q2Z3YXdXSExqZU10eUZKODlBWHllMkJiMndweEtFcGQ2?=
 =?utf-8?B?ajVrSisrSGZUZzJFbTI1S1V4MDlCNUFOZXJKSnpmZWt2V1cvSjV0WmFSVkta?=
 =?utf-8?B?dmVaQk9COS9CdC9ZSi9nZE9vcUU3RVg4c3pKNFZXenlQYy82QU83blAzaEZV?=
 =?utf-8?B?SHNLMjR0dFF0VGdVWGhFU21PNnZrM08yNGpqcURwcXA3TlFDZENRWEQ5T2hC?=
 =?utf-8?B?aFU3TGdsYUpBM3FLZU1GUXFoNllrT1AxclRVNUdOdmRkUEptZnFURFVUWENz?=
 =?utf-8?B?OXdvUkZiejVzQzZDN2tKN1hJTGtWWEdpYTJOQnVWeEdsRm02SFowS3liQ3hW?=
 =?utf-8?B?Qzl1bXA5aksyTGo0YVZzTnYwd1pvMEpJcERJd3R0TGdzRHZOalVkSjVMUHBy?=
 =?utf-8?B?aWh4UVhINkJ3bm9BT0VYdGdLUWV4aGZMVzJSWHFlUVVNd1JJdCtLYUZGbHBX?=
 =?utf-8?B?T1NUVjROL3B0L1Q3bnRzbzZkVFArYzVNZ3lMKzc2aVk1aWRtOWhJQXpNbW9N?=
 =?utf-8?B?MVNmcU5FVUJveVRTZVd5K1NQUUMwdXlvV1NscElaREtqYk9BQnpueVhycmRs?=
 =?utf-8?B?NytaVzY2SVFEeU5HU1kzR3YxcGZDT0E3ZHBkaTk1V08vSjNqcFFGYXNqcUxt?=
 =?utf-8?B?Smo4WjYwNzl5RGVHekNtS1lLR0dpSFFFZHJwUTJaTlo5QkdDc3dXcnQxb0lv?=
 =?utf-8?B?TGJDRU42Tkh4Z0hWakU2SndoVVhGbFd4dW1aUmJMWWVleGZEemIwTFJOMklt?=
 =?utf-8?B?MklGVG8ra2ZXUkpSTkxMMWh4QUp3bnZOdklVdTRxT0pIbThVeVVMWTZYOTFM?=
 =?utf-8?B?eFovUHdGbGxNVzgrWGFYekNIcDNocW5yYkxDWXBHTEJLQ1FEcEZHUkg2Q0dU?=
 =?utf-8?B?c2hTUDBRbEhkV3Iza0lIQ0JBelpqSjlnSldFd3VMQVdMQk9pZUVvM293VklW?=
 =?utf-8?B?MU05aklwWm9lWVU2QS84TTU2akZkTE9lejhJMFpQWGhKaWk1SGw2SHE0Q3My?=
 =?utf-8?B?YWJrdHhBS0tHdjdQaWNaMnVDWFlXdXNhYURPNFV2d2o2QXlsSWxpa3cxcitt?=
 =?utf-8?B?cTY5eUhETzZDbFJsYnlsYzBTNDlTc2IydEN3U3BOc3BxRUZoNjlyMmdycHgw?=
 =?utf-8?B?SnpxU245SVhUMk15dHN4UUxpUm1SNWcrNVVKbW92N2duRWY1U3loSlVGQlZa?=
 =?utf-8?B?dDRDLzVjS2NnRFBmQU5CQkFsVldteVJ6VFVTVkdKRFBpandQb2pKVWJiNHRY?=
 =?utf-8?Q?MrWA10gV6/wJj22lpjX96jl2+s6yDVKGp3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e2a932-58d4-46c2-3b63-08dbe2276c08
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 19:58:35.0537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/62DMSP5BxKgvgyXR+R1VStJ55A9+StzjjKJLf4h5zc8L4xv0YkASQ+nW60Tpuuo65A7ULfFxfp2o/WpLBSnHN+euvHg5hUGlQjmAIlN8ZPpAUc4rMyJ8vWXjp6k+xy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_18,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100168
X-Proofpoint-GUID: 5-wSAU9jMcBQByqIkXvGp1DDMjKqfqN8
X-Proofpoint-ORIG-GUID: 5-wSAU9jMcBQByqIkXvGp1DDMjKqfqN8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilpo,

On 10/11/23 8:14 pm, Ilpo Järvinen wrote:
> On Fri, 10 Nov 2023, Harshit Mogalapalli wrote:
> 

Thanks for the review.

> This changelog needs to be rewritten, it contains multiple errors. I
> suppose even this patch could be split into two but I'll not be too picky
> here if you insist on fixing them in the same patch.
> 

Any thoughts on how to split this into two patches ?

I thought of fixing memory leak in separate patch, but that would add 
more code which should be removed when we move kobject_put() to the end.

>> We have two issues:
>> 1. Memory leak of 'attr_name_kobj' in the error handling path.
> 
> True, but not specific enough to be useful.
> 

Should I mention something like:

'attr_name_kobj' is allocated using kzalloc, but on all the error paths 
we don't free it, hence we have a memory leak.

>> 2. When kobject_init_and_add() fails on every subsequent error path call
>>     kobject_put() to cleanup.
> 
> This makes no sense. The only case when there old code had no issue is
> "when kobject_init_and_add() fails" but now your wording claims it to be
> source of problem. Please rephrase this.
> 

Does this look better:

kobject_put() must be called to cleanup memory associated with the 
object if kobject_init_and_add() returns an error , before this patch 
only the error path which is immediately next to kobject_init_and_add() 
has a kobject_put() not any other error paths after it. Fix this by 
moving the kobject_put() into a goto label "err_other_attr_init:" and 
use that for error paths after kobject_init_and_add().


>> Both of these issues will be fixed when we add kobject_put() in the goto
>> label, as kfree() is already part of kobject_put().
> 
> No, you're fixing a problem in the patch which is not covered by moving
> kobject_put()!
Sure, I will try to rephrase it to:

1. Add a new label "unlock_drv_mutex"
2. Add a kfree() in the default statement of switch before going to 
"unlock_drv_mutex" to free up the memory allocated with kzalloc.
2. Move kobject_put() to goto "err_other_attr_init:" and use this goto 
label in every error path after kobject_init_and_add().

Please let me know if you have any comments.

Thank you very much.

Regards,
Harshit
> 

