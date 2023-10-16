Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD347CAE43
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjJPPyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPPyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:54:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D86BAD;
        Mon, 16 Oct 2023 08:54:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GCcjJ7021600;
        Mon, 16 Oct 2023 15:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nUt+LqbOsTZ9xRC9u+wuCCizpxmQAbn6thkpZH7OZcY=;
 b=s3ZMITUroKp5WhOzey5z9QQf22JYVErKg5gbzKYZKWEuwlHDDWTmyyiWmXDCS0ubSBiz
 TMN2gU4UPkEVABE/Yq7021ypIwQoW09PkAPSyIor8LyvZ8+lkEEIvJvGJ3lUvP7zWC4F
 Tfq+qfi9Z6SyNvpk4icVH4s130Ur6QpQk6YM05QFJ8z90H7w+XhzwX+B9/jUgnU+d7TP
 FKS7Xxca+yBSgTL+2nqOrLMmnDN9lf5RMMm0pjrqy7xizhH5juaPNMnpWXM0rwwlet1m
 2CPA4MPejfNXnZkKajJRUNdcVfcmhynM7sXk6P66YJxve1z2eqiW/pG1bOwEjJEmlidU +A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjynb472-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 15:53:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39GF4UAG027187;
        Mon, 16 Oct 2023 15:53:50 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg52m5wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 15:53:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7Ee9qTNH6PK+dnJNmpqwXRbgPvpjVgemZccwRaeNMuXdatR/0gMQ57eaSRuSW8EIYXm2vp6aNkR7MGbdm209f7S4V4b3I9OnI749+TktPh7m9bWxNycByfi17Oxq/Y4S8zDVBxMBtcLJY7VVcUvSRP6TrUntsx+tAkUcJP/1se8PkDqsSOiptAbx525/3BV8a9d7lQU77dBWP9EAiFay1MWUX+AYrrDRaGMG5mFQuaMOhQA1v9yo79WnGDw3UCEHo4Kq96GWg3s0zmBWPyOT1+pq5PF33JtAPURvXo6gufYVEn/PV8M9pINj8VrezWTopEqKfh6ZLb3xNzFLMD6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUt+LqbOsTZ9xRC9u+wuCCizpxmQAbn6thkpZH7OZcY=;
 b=A3MVm+XdTY//FI6QowItRSJKDcRUFLSI+vYjxr/K6Siha8nepf4lsOo+StSFuITvW6/h7dndTBuIqF/nQxKP6/xBazCzb63K18mk4+GMv+ZiJnUKOy2XVkAlqLrW/jDWTGPCncxMkSp4w1xo23UademSvltL6zZpg3IkPVTlXrDEOF4wzE3ZK6yEvHYoVJuKPAwtW9NmXrozvJFRozrYE+OGxqaeIuLLNE4Yjo7WVNNnhXWU1ZKrM9FOse73sTuxC9VyEPsC53YjCwrxqiQkcA2uDIAYH8dg7nCiYGB1XrLEV0p0dM3lpY/GkFSc2CkkAJmYjovPpkJXNCW27DWLhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUt+LqbOsTZ9xRC9u+wuCCizpxmQAbn6thkpZH7OZcY=;
 b=BH2eFHeYCEkWQaH6Q4hvUW2Y1pmifdCD82D6SuIn/M3t6ZExteL9CkJXXv43+tVhxUFTZAi0+5IryNBlvMo5Gc42RAbI+wFpsjo81yWP7++TsudlD+aV2DfnfVA63k2uTAt+yDkcd08Xja5uW5jy2V410vkDJytMfeaJtUMyxgk=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA3PR10MB7023.namprd10.prod.outlook.com (2603:10b6:806:313::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 15:53:48 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 15:53:48 +0000
Message-ID: <43ad9708-47d4-4113-ab05-6012cb7c4d6c@oracle.com>
Date:   Mon, 16 Oct 2023 21:23:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/102] 5.15.136-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20231016083953.689300946@linuxfoundation.org>
 <a01256b5-6082-4d17-bf4d-310e7b4f7a47@oracle.com>
 <2023101641-resource-scalding-3e1d@gregkh>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2023101641-resource-scalding-3e1d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA3PR10MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: e356fea2-95b8-4057-4704-08dbce601584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvkwK+gQi23c3p6iMR7hVFBDcwNmRmk79qaFL+eWADxHroAZHtxmed++7zqf5pJRCoYR3W71kT/f0DJSCVfFonWdTzcQHCSK+2FUpsZBzAQec6c7fDTlMMNMhFLGQoyVptYf+XrjTh/29KRxnvjmb+6rQNSfZUz0a4HXg8uJUoZjacyT8yTpyP4hB0mVCZuqLbIEqEjWMNb4gw/wnf0YvImjhQacdJhr/L+Q+Yh68wXd+GvgkmWCobAUqV8gVYQNqO/Y2F+Nd7y+Z7tW+JzMSoMqx6+Ej/WlrkengWeJfLdXjTePoPV5l+gNNfHoRA3sZjTw0PvEZcQp26EKoM+7yn8q2f/vXFN4+73lBJ/p6CQ9NTYkVH8pgWiSikzUDpp0qE6pGbgI3CMcgQVwieDLzdtHgfN5KgfLlbtwi6QC9uTxmaiFFZPAXMbzmk6jvEalKa+y584dbX46jN7EymC0eRGCKkG57HEN018TlLM/CVNtsRbTzgJs4JXuFfgZwe+a3gSnamfb12FpqR+tkNJb+mQC/UX1zUjF8Q8NZoYhLEUR6thmVDULq5McpZ0TjOvA93qjkCQnogonFbayMU6I1Xh/yK93nIm0fse3S+PDyHbvZhmL1ma/sLxCVcOQVi++FNFGnODUhqyTUGtAIrS6UaPXISt/Qq2wcnK8bocVtiDHGRY08s4bKgm9zYGH6HOV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31686004)(6486002)(966005)(36756003)(38100700002)(83380400001)(6512007)(6666004)(26005)(6506007)(6916009)(66946007)(66556008)(66476007)(2616005)(316002)(478600001)(54906003)(53546011)(7416002)(86362001)(31696002)(2906002)(41300700001)(4326008)(5660300002)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnpOQWxGaVp1SUNpemdpNS81UDBRbUlESkVrZHJJVnd3SUpFNXJsbi9WUCt5?=
 =?utf-8?B?c1VNeVM1T3JQd3pYd1FWd3pBanNOQVhYVlNmdVJDVnI3L2w3bnNzT3dnUGdy?=
 =?utf-8?B?YnMzbFg0SDY1VFVmVFJpd1d1YzhsazRDeDd1MW0yMkQ2YTRWdnREOFduODJF?=
 =?utf-8?B?Qk5DYnF4YTRBemtQN1QwYjBXT3h4K2lOWmh2V0ZzZ0ZvemszRlQ1NlVUcWUv?=
 =?utf-8?B?NzFKOFBVVjdMbE8rWWVBUjEzZTYxSitDcHpzUDBJck5ydWVLVk9zS0YwbjR3?=
 =?utf-8?B?SWUvLzlFc3psSlJ3dFpUN0VXQTZWOVljMkFDRldCV3FRK2dXSllBcVpTdnpU?=
 =?utf-8?B?Rnpkd2hLd1pnRnFpdHEyTXErbzJUZlhxdVN0S1U3bWFBZ0sxcmhBNGIyWFEv?=
 =?utf-8?B?WG56SnZQTlhuUmd4VnBkQW9rcFptVUJ0ZlJRRnZRaFZpTCtNYmJ3L21LMnp0?=
 =?utf-8?B?N2FLdk5mZGhHRlhHQzYweUc1UVpST1dDMitrWjZndXNaeEUwbkFpTm8zMGVK?=
 =?utf-8?B?Mk1aK1QrNFhudjhwLzdQdFdTOS81K1JOVTlYOHMwOG9WMzQvOEVpOEZFOEtz?=
 =?utf-8?B?RjVJY1FEMk15d0RaWVoyTUx4WjZPOUY4eUR5NWUvOVp4SzZ4a1JENWVxSW4v?=
 =?utf-8?B?bXBucnRBL29jYWZXL0xWbHpTa2U2VUt3OG41SjZlbzV0STUrOW1KT2dCZ3VX?=
 =?utf-8?B?Wkgydnd1UnFWUTg1ZHN1UXZSN1hIVEticnZQQlpPU1R3bFlWZmdqTy9heGxZ?=
 =?utf-8?B?bkNMbnZQVTRlUDFkUWttMXlZc1lET2pTMGY4ZWUwTlpSbVVGM1I5T0pZOXFO?=
 =?utf-8?B?bCtEUWtmVEI1YmVzWmw1VndQcmxHZlpSMTJFRGZlb2VuZ3ZBelErOHhDS3hW?=
 =?utf-8?B?NmhjQ2dNaVUvTVI2bjBjU2dHc0lNOHZmeVZJS3RDUGNKVm5xSG9lbUM4UTBt?=
 =?utf-8?B?Q2RQck4xaWtKSGg5czQzYk1nMUNnWHJVOFBGUlpRM0c5SUhMR1ZOZHpzd1Yv?=
 =?utf-8?B?b2NuSzlUVS9HZGNzUjEvRzFNdExSVytwdHFLYWszY2Z6VUZ2Z0dFL0ZOUDlE?=
 =?utf-8?B?T2FzcnhaTEU2WnhuM2JyUnlyQThLZ3dKeEh5anFmRElmb0w3cjhkNDRDRjlj?=
 =?utf-8?B?YzJCV0hMcysxZlFxUjUyaGYyMnQ2TjBFU1JrVWhVUzJxdjRqLzE5eGl5QnU3?=
 =?utf-8?B?RU5YN2M4UktQd2FkNEdpSUJid0pyTWU1WXhqMWF4UnpLTWJORDdiSzNmT2Vu?=
 =?utf-8?B?dFJZczZ1SnJhZm4wMHFhSUF1a1hDTlVBS2E0RlAzM2xoN2d6Q2h0dkxvck5o?=
 =?utf-8?B?bXAvWFRLbEpCQnk5eWFTcjY3bTZkaG9HWTBUd0VNY3c4akcrOEJkWnd4R3NR?=
 =?utf-8?B?VkFhZ3Fwb3JVK1pmM3VMS1pFVW1GSUptcm13WFl0a2FCWXVEM1VOaE9iOUJ2?=
 =?utf-8?B?ekJCL0wveFFyZnAzMk9iSHpQYWlVL3lBcXprM0F3UmhlL0VCWVF0Z1dVanJu?=
 =?utf-8?B?Y0dINjFEOTRoTFNoQjFYUGJHaG45OUZJUC92eU0xbEpTN0ZOcG5vSFMzZlBq?=
 =?utf-8?B?dGNYT3JrR3FzVkFjcXVHeHd6THB3WXRrZ2NjaVZhSFMwdFpJRVhjT2lscnlQ?=
 =?utf-8?B?dUFjWk9PbkhHNmVVTmgrMHIvakVPdWxJYXQvSWpqcEl0SnRiaFVyaERnY3FI?=
 =?utf-8?B?U1U2cmlQRGQ0V3dTazV3WmJsVWV5UXY0NHBLNzBsMW1ib283OXBRak1iMm9r?=
 =?utf-8?B?UEtUU1hySzFaYTA1dDZtd0w3VlptTWxmMEk0NHJJMUxNekIreXk0Z3d1MXc1?=
 =?utf-8?B?cml1Q0RleVZLZ3hmay9wVFROYkxqSUovZUlIalNNeFNBRGdRbzh3eXRObUZF?=
 =?utf-8?B?SEY2ZDRWZm1lSGRnNnBXck5LNFJtb09XUURGWnUweDNuWmQyVWx1WXhSSDVl?=
 =?utf-8?B?ay9kS0VXY1JYZ3MwQm9MeklaYTFqMUUxVDNrclkyOENRS1FNTDk2cnBKZmNX?=
 =?utf-8?B?TFQ4ZGJCN21INGkrV2ZZVWM0U2g3c3dTV3JLTXpsaDlSdmRaYTJaSnJqMlps?=
 =?utf-8?B?NmVDNEU0eC9SQ2xXblJrREYwOWFCWlRQWDNDdDBPWS9JQ3lPZ0J0UU5PZVhD?=
 =?utf-8?B?UzZyZDU2QnYvazJ6b2JQc0tWR01qRjhwMngwYWhnRmtmdWRWTGhsYUp1UHJS?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QWIvUEdBMTlMa3BYQU9qbmV6K0pwQ1pwY296UGFqRklvUHZ6Ynp5TU1GVGRD?=
 =?utf-8?B?Z2pvVmFlemVlQnJvSTJzU0x6bXlmSXpiTXgvMS9INVd1cURjMUs5RjJockJI?=
 =?utf-8?B?bTVtZEREcVppOFdncnJhVDZlOUxvOEh6enFVQWNmM0orZzcrSHRBMW9HKzg0?=
 =?utf-8?B?TEdMU2kwb3ZYdG9NaktKM3R3RVF1Vi9BTWNJdVU0WW9waDErWWhmTVRlWHdG?=
 =?utf-8?B?ZCtrZDl0Q3pyYkNDYWxzL3dYWmNFbU9KK0xvdS9tVFFZYmZtWHV2UWxxWlpY?=
 =?utf-8?B?VGNBQjVKYzZYS2pkcm5DbmRHams1ZmZ5TVUrKzc0RFl0U3A4T0N1Yi9pQmNF?=
 =?utf-8?B?RzNLZkRSNnZSNk43QXdyMlZ3Y2U0emxHRnJPSzQrRlRXZHpneXRWZXdJWGZQ?=
 =?utf-8?B?ZUtVMUQ4UjRJbXpscFlGM1o3SGhUMGFseDNISFFEaTdzVDVVd3ErMXdLU1k4?=
 =?utf-8?B?SXZuZ0M5WDFiRldVWFMwbkx5T3htR3N2V1p6citqNEFlV1pVNnR3Vkw0SkNY?=
 =?utf-8?B?akdub2xGamdaZCtvOG1tTGJtWGFIa3U1bElRLzBEVVlZbnJxMHg4TW85TFFB?=
 =?utf-8?B?cE1CWXlmaldETDFteUJHRVVwa3JaSWR1ZzU4Y3g1RElJRVhoV2lIOEJUQWtC?=
 =?utf-8?B?ZlpFNHdNTGxmVHdJWWxFaXlCUmZkZFJBQzFKR2dEVHhRcVNsTmtjNWJXNUhV?=
 =?utf-8?B?VFlJcURZV0grQUgrRkpTRmEzSS9pVkZWM2VZUVdjem9hampZanM3bXFONGVP?=
 =?utf-8?B?SXlyQklzdldyRmlvL09vUnFYampFK2ZZZy9rMkRPMjA0aHJTTWs0MnFQcGNJ?=
 =?utf-8?B?VVhwN3l5aldXTVZ6bkg4aVhKSmJOQXloeG1LOXEzK0RvWUpER1RWcmY0UlRC?=
 =?utf-8?B?VVBVcEx6bkk2TkJKaVJ0K2E4d1l5VWlScEkrSFI1YXA2RyswMlJ5dDkycnJS?=
 =?utf-8?B?cHNhdHdxNUVLQkhuUXk4RGJQNGVDaG9SUlJONEtLT2xJeEp2Z0xFNjRtU2RK?=
 =?utf-8?B?Wmp3OUhPckFDR3pycU5HQmdjWUFNaHAvQjhTeUFWVXlkZnBMSXlUMjJjOVRQ?=
 =?utf-8?B?Z0hwc2NGcVkvUzQrZjIwaks3OVY5QVNrbSt5WWYzbDF5ZWRCNzh5a01CUm1x?=
 =?utf-8?B?RzF2aUE2cVZFeExvUmsvYTlueFlGNnJXRmRuM3ZuQ2hIQkM3dmxmRzdRQ1Iw?=
 =?utf-8?B?QjVJdW44N0l3Z2ErZnJGbnNOZEM2WjRDUGZ6N0dzY09CYWlJTTdDT2ZmelZO?=
 =?utf-8?B?YnpaakpzSzNLOGdDaFJHSHlwUjZrcE5QZktteUV4TFJvdWU1cFBRYkk3U1JT?=
 =?utf-8?B?cVZtZ0VTakpzRitMbkswcUNlUFlMa0ZtTkJSVHFBSXhQWXlBZ1BKRktyZGNK?=
 =?utf-8?B?VG41UGF0Q3VOSVdPQThEVU9iYzZ0UE9QMjFOcnB0NmNuck93WFRXc0Uwa3NB?=
 =?utf-8?B?K0VSd1NkNVp3dDU2V3Zobi8waGZFUENPSDYzdXhrS0l6ZWNFK3pEdHR1RWJx?=
 =?utf-8?B?UnpYNzYyNXMyZEcwdVhHNTRrSEg0WU1SMzFwU3hwblc2Q1o4UFoyOUFpcmxJ?=
 =?utf-8?Q?elSuzm7+rL63czyu5j//cnez+V70Pix6rGLEv7NB3KmZYp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e356fea2-95b8-4057-4704-08dbce601584
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:53:47.9333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDtr7IGoNUYgI1LWRE5QiVU+dO1rOgn/wezzJrdkzrl0GBgDKEzo1ZCvvi03/Hx6y/2BmsCazMp8h5rNojR8CVkkO+q2dqpLitj98TNUdjaYUtCOPJ2UXryABFLh+nX+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7023
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310160138
X-Proofpoint-GUID: SSjdwXoKQ1UsW8HBHAn0bz3UKDZ0Ktwn
X-Proofpoint-ORIG-GUID: SSjdwXoKQ1UsW8HBHAn0bz3UKDZ0Ktwn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 16/10/23 8:44 pm, Greg Kroah-Hartman wrote:
> On Mon, Oct 16, 2023 at 07:06:20PM +0530, Harshit Mogalapalli wrote:
>> Hi Greg,
>>
>> On 16/10/23 2:09 pm, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 5.15.136 release.
>>> There are 102 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Wed, 18 Oct 2023 08:39:38 +0000.
>>> Anything received after that time might be too late.
>>>
>>
>> I am seeing a build failure while compiling tools/perf/
>>
>> In file included from tests/genelf.c:14:
>> tests/../util/genelf.h:5:10: fatal error: linux/math.h: No such file or
>> directory
>>   5 | #include <linux/math.h>
>>   | ^~~~~~~~~~~~~~
>> compilation terminated.
>>
>> Patch 43 in this series is causing this.
> 

Sorry for the confusion.

> What is patch 43?

It is patch 42/102 in this series

https://lore.kernel.org/stable/2023101641-resource-scalding-3e1d@gregkh/T/#m70a2a03b6204085af187184af911570681e744f5

Commit: e2bf685d7e311 ("perf inject: Fix GEN_ELF_TEXT_OFFSET for jit")


> 
>> Why is this not reproducible upstream ?
>>
>> Vegard bisected the commit which makes it not reproducible upstream and this
>> commit is missing in 5.15.y:
>> Commit: d6e6a27d960f ("tools: Fix math.h breakage")
>>
>> Backport request for this was made here:
>> https://lore.kernel.org/all/CAMVNhxS-6qNfxy8jHrY5EtZASTL9gAvZi=BdTkUA5_5CSQ2Cmg@mail.gmail.com/
> 
> And that commit is in this patch series, so are you sure that was
> correct?
> 

Cause for this build issue:
Commit: e2bf685d7e311 ("perf inject: Fix GEN_ELF_TEXT_OFFSET for jit")

And this issue is not in upstream due to presence of commit d6e6a27d960f 
("tools: Fix math.h breakage") in upstream but not in 5.15.y

Thanks,
Harshit

> thanks,
> 
> greg k-h

