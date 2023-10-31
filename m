Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2148C7DCA83
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343520AbjJaKQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbjJaKQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:16:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4EFA1;
        Tue, 31 Oct 2023 03:16:35 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UMwuH3011069;
        Tue, 31 Oct 2023 10:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=EzOvyFBH41P9stctkB+3wwjKdZDEyD3beSe+54IOd34=;
 b=bsXgtGvQ6Khtk7SizcIXVO9bOHciJvAUeu6V77pz/LmL47DYZRt/0yLtbi+zytPZ5sOc
 sNYo5zJbHWk76a8F6jJ8H+gqvPRKrXWGugTykvcZzrZhXFKISVrm3pM8LdLa5DVMQ2hM
 Gf+g/5dueNQ6zzp51Ml9minMSRMcvNIsZkahGHhI0bdQ67Q3jGbXNqXafu3rsLyHzDud
 h4G+AVc4KKN0dVb9uEYqwVdQM5VIATCZQjnsXBpF4zH1e5kXKJL8e7X/7p/1ieestIrb
 Wp7ReJn7bnUIKwsNOWJKyCg14uxCI+97Cx5PIZo7nvti7FT0co06V0uke5Xa5+AFy4e3 UA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tbdmndc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 10:16:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39V8HlnK001040;
        Tue, 31 Oct 2023 10:16:28 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr5tkb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 10:16:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5SoVsTFlvAV3UGWt2hym07tVXzZQOQjSMYHtq8KhqOg1z8EgTZEPHc+82En/P5pMdAu/CRYzkc2M2azVQXb+Fgw/pSzfn75RMDpDs9vUJFJ+HH/bOOIwa7sZslU04vWM7vNwmHXtPzWOgXneKwgznXDNuBgNxss+wLNcr0tBoe2EWHPhT/qkqtc3hu5nOhjKeiLHd8sACpY+Y6awsKwj0KIm8O3UAsi6p5bqtmdMLXj6uxd0Dzmud3BIavxTaaIKhExOUC5P6wbHCYIJDxAi0MR1T60DWvq0qMx39KY7Ik9lqMwf+zzGD0+uGLIafqSEJ12ehQKHqvFiX7gtKo0sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzOvyFBH41P9stctkB+3wwjKdZDEyD3beSe+54IOd34=;
 b=O51FnGobS8VfP2G2L/WUni1j22Sikq8VkpjiR7CXjwonzGBngmiHGtrrVmL3JFaTmt4IaBa/iqodmU/DeBXQiXLyymsTiUt506T8o50URUFSZ9BQxOS3O14QdTUbj8bjtsXo3Q3IDimu0/wictyZwRBu2BXQP5fwsiYtHVyDgcYwsP6g3og+9pRZ9ZgPSj8TgBcCjxlTxoSy1K3SW2iWc8HSfLs87AHPvocve5LzNEvMzFhrwiAqiS9E97QluF5TxXF3AyRovox4TLotT3RYh+yQGOi01cI4qa3FqyYJ826/byEd3X924HlET8wE0GpMAYaJpBbph/dCSaKdJrpk2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzOvyFBH41P9stctkB+3wwjKdZDEyD3beSe+54IOd34=;
 b=cGKjz1ZiEoayXo8q01K+eWzSPpTUsE/9ousv0AydpmN+RX+6tsMIivgQo+5BnWfsBu2g4LS1LyZDwObl7rAoDFUgzBllxmByuu5/OoZDn3tjUXNWuGgpZDY6lTfA9VAdQdl+dmSxjkpRIUAb+o0eYTb7w0yZGc/vH1JWQ77kDXE=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH7PR10MB5879.namprd10.prod.outlook.com (2603:10b6:510:130::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 31 Oct
 2023 10:16:26 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a39e:b72:a65a:a518]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a39e:b72:a65a:a518%4]) with mapi id 15.20.6933.024; Tue, 31 Oct 2023
 10:16:26 +0000
Message-ID: <0de17ec7-b692-4d1e-b059-c5f3f619e94a@oracle.com>
Date:   Tue, 31 Oct 2023 11:16:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Destage TEE subsystem documentation
Content-Language: en-US
To:     Sumit Garg <sumit.garg@linaro.org>, corbet@lwn.net,
        jens.wiklander@linaro.org
Cc:     Rijo-john.Thomas@amd.com, balint.dobszay@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
References: <20231031100742.98859-1-sumit.garg@linaro.org>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <20231031100742.98859-1-sumit.garg@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0187.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34d::16) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|PH7PR10MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 35cbd8d6-c7d5-4c99-367b-08dbd9fa70fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LZ6WKfj1HiqX85x55LLTZlaz4gTDQRX6Tg7btSll0Gj0BnfgqFZkwAccG5G68z4d/Qk5/3LPpFWw7U6oT7T4WL2j8hqesRLxAoacOj+5f9NyB2vCXPdURRsSHMwxCt9p8GE6Dt6p4PG/a1hZmUcK5FOk34EEV/ClKEtqgVcMqX2OWo321CscK7C2hEpw1C9WN5dYlZ0b4+958Cfj3Tf9eCBu+joy7Cy0xzPSQLTZUdNa52TG98VHH2MVj5FOkRHaOMaAdLxzKWrc9kLp0d+pYtVkm7PT0hT3rQ43LrHTQusVIO8h3cVJK3CVpdg0ssjbwinZF67JISuLK/Fcczt3GZdaobjOAcY/gA5simRjJ+HqbwGPIkJwrbNpm6C+89RS9aWfAcYvN+3ANMM8nG8Xqw2p4eaYnfIUSFL/5Tz23o6PdYJXEDPh8c4v8GoGmzul9JllPKq/dwney/+3sZ4dYpOAdy6kuuFkdIhm6iMUToCyA0TXdSvCwVdxcA1gKlFMW7bmRTaSWnpSzoCMoAuctfIQ9IPXOtGTqQKFo+N7AYN84aRdNThbPBoHNPovePjHr9baASyWeZXsY8hVsskx5FG1jZGyZhuedd8MIFdK4SfDXTtwdEoGF+idtt2O7DNg37pOXbX2tKUpNIsxY6Mn8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(41300700001)(36756003)(66556008)(44832011)(8676002)(6512007)(53546011)(478600001)(8936002)(86362001)(5660300002)(2906002)(4326008)(83380400001)(6506007)(38100700002)(316002)(6666004)(31696002)(6486002)(66899024)(26005)(66476007)(66946007)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXMzQS95M3BHZ2pOVWx1aUJJQjg5dkRuT3BRc2NQdVB3R1lPOFFvNlZsUVFl?=
 =?utf-8?B?a3k5OUNlOTlMcWZieGNyUkEvMFRIeVRGeW9GZzUvVHZjZ3c2aEVpSi9CVkRI?=
 =?utf-8?B?dU9GK09rdnE0NkR5VEtuUzJvK2hxMjdmdHQydGoxQ0IwL0ttSzlFOFM3NHhR?=
 =?utf-8?B?SHQ2UUVRVSs5UmVZMlprMXFYdmNQSXJ0UG9qT2szRi9SNHJ3NEExSExMZUFY?=
 =?utf-8?B?NGo2NUV5ekxBcUlxemhmc0VHSW1tdko5eThXYThZTFg2V0I3VDAyN1l3N1lR?=
 =?utf-8?B?bHQ2VzdFZExwUlVJUlFNTGhCREhid1dzZnRMcjROcmtrc1VUTGVhTGQ1cmJ3?=
 =?utf-8?B?TDdNUUlIMzZ6ZEhOOTdYY2hNeWJVVzJPQlIzRHYyMys2NXNrU1c0b1VDYkJa?=
 =?utf-8?B?RGVhQXJaR3JFQVF1dG9QWXVSSHRLeS9qa2pNOFltOVVDdjFyV3M0bzMyUmtF?=
 =?utf-8?B?SFBVRXI0d2xYTTBnN0tITXJpVDhFVzgwMnJNek9vUGVnWUxVQTFwOXliMHZB?=
 =?utf-8?B?QlFDbXVaRzRtelhjOG5sRFZhcytLREVzbGhEVkh2TGZ1Sm5RVFNJR1VuOU9C?=
 =?utf-8?B?SkNJN0ZLRWpRMlp6aVRwZGxjT3FVczFPRWFiZTVuQ3lIaEhLV2JOaUtYQThu?=
 =?utf-8?B?alZ4RmZhUklFQTZYU2hLTkdjK21SOVROamQ1RCs0bHNxZFY1T3RoTlA1d0Rt?=
 =?utf-8?B?Y2hnWnpibzJOL0YvbnZ2d3F4aHJkQXRNblUyS1J1K3J6YlpYN0V2WW95L3Nh?=
 =?utf-8?B?YklHNDEzM2VHNmk0NnlNaUMrVDVOYldlWWZPbmlDc2g0SzZlQjFqM3dZQlRt?=
 =?utf-8?B?VnNmSkF1WVJDbFIrc2dZYWtvdzdZK0hKNWIyaVFOai9JclRFVU9YdXV3RXBh?=
 =?utf-8?B?SjdjNUJ2bUp5d21OUUtvU2pMcmd0c1RQYWVpTzVkbjNtYVNuMjF0YjlYaHNK?=
 =?utf-8?B?eGFYNGpwYS96cHZDRjdmRDJmZTBOZWI5eVlrZFV5emdGa243dEV0bVNmd0Rp?=
 =?utf-8?B?TjlKLzJtNSswS0lxYW05RWJWcWRHdWUyeCtRai9uM2tlNUw3VUl1YnhqbDNy?=
 =?utf-8?B?VWFUNC9MT00raDd6QVZINTlLN3dkOEdkMzlZOWczdFgwNVVxdnIxM3cyVXkz?=
 =?utf-8?B?RDAxdkxySjFIaXhReHg1RE5QQUZHYXVkdlBaQjVEZXRiMGpkazZTZGVEYkNa?=
 =?utf-8?B?RlhYOG5PUzR4RVdnSFRuUXdHekpyNE5VY0VOMC9TdUJ1dExsblNOb21xRStS?=
 =?utf-8?B?UnlsZ0FIWFlLY3Q5M2x6VUhtN1B5UlkzTms2NkZTNHp0bTVBcGxMSEcxUzFo?=
 =?utf-8?B?WUU1WUYyU0k4TE5NcElLYnJFdnZOQXhZMGJ2YnBFb2xpc3c2dy9qZDRPZXRn?=
 =?utf-8?B?dzd2eVM5YXRxTnpMMmNzb3BBN1p4Ky9Ocm9sRXhBMzRFS2ppaElmZ0RQaEh5?=
 =?utf-8?B?R3YvSmtTV0FjemRBV3VrUG9BenRYanVVc1Y2S01QVEczeEU2RjhnTFVDbnVE?=
 =?utf-8?B?RENvVVpiVmh3aU1LVHZjUDN3a3BJdFd0NHI2TlBEaGV4VzhMRXpGbTFsWng2?=
 =?utf-8?B?d0c2VGJPVEJrSDVCa2ZteXhoWEhEMGN4T3R1ckw4TEhacEgwZ0w4NkFEdUxl?=
 =?utf-8?B?TmFNWTJoK1VNTy9kU3hWT2x6b2owUGRPbjNmYnVNTUFrQ0ZpS0xYcW9VaW5U?=
 =?utf-8?B?bHErQlZVb2E1cVJSM3BtSDZBSk5WN2dDVXo0Nm1sS2lvUVJxczUweTBkS0xT?=
 =?utf-8?B?Q2Vja1BpaVY5Y0lGeGc1U052dS96WmtlR1huYk9YSFhqa0lPdk9JWnBGWVhY?=
 =?utf-8?B?K1p6M0dIcjRuOXg2SG5Yek5HK3ErdjYyUEdXRzVmc0N4MWJOb2tLMTlPRnlP?=
 =?utf-8?B?MHlrMFM4dkQ5WFJxVkRWeENJcktEVTNicXQ4R3UvRE9FUHlvWlNRZE5YRFkz?=
 =?utf-8?B?cEJsUjNrMjM1cmIvcGxXV3p2ays3bWQ3cUJobWlUL0EybVJycGNYZFZrdWtz?=
 =?utf-8?B?UGhYSEVVbEZJOEFMVHBuVkRuaXVLNUtUcys2S3dUTjl0Tk94bG1SdlJNdnpx?=
 =?utf-8?B?alRYRmljRDNhWWFSUFI4bXVrRmtRbzR5dUo5eFB4Vm9GTFFNMkFFWmEzM3B0?=
 =?utf-8?Q?2b17DLgK7iJc97vN2mZRS+qOs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s8LVQxZQwGic/2ItzzrqyYAYRFAdZv1V64Erg/CbgxKnJ0qYfMvsHflaxCSQORvzeLJBWSkRI3YTTbXbWHq1N5pQ1Kk4NzU/pbIvE00eP1hXUnyXoq2tayEO368DFSkbTn/v67Drxb9/X+lilscVYPAsZpQGwwxu0T1NB7rlGXNgCcC8A9EpL0AFNP9NDiTMgqlO1Db8mI8DhARv8GG4WbH+antyZANlIO/nAD0gBdBl3EGvc68ekhwdRfH9LR1sS2WOJBKXnX5dJbd2FAfyhEIcrRyExw7n7w0DV5kTZnTfBBkTRn9ts3xeGfTeRImksYOch48Kl7c4zHUo2NfB5yyVFIwDbbOzTQt9946zInAFjAnyaDYxGMr8Zeb4G18ROFt1iB+/MrkOS2+eiWAQyEP7FE5yJd87qkvqFBLXcakLy/Ue0GnScBG5AYuymwawCsUssGlt/s6CWuItFMPLOwKjsy/RL4oR1y9F46yb3AFxmtGW2d9Fssx3dmBPDfwK2E2bmxTRblatKBEmvywz+CMax8jPuzs9kjUEPwJSpFtXGOc2CZmy8GJNysf7yoPjkDcOMH10/Rm0sz29xV9HTf/Yy5qrqvhYp6MtSYGFOZ9AOvj/LjPmHFwVYyUXXx7K88uAGHRGWM7burfcQgR3PflIMEoekziQKEiKo10RGYENnu6MlUrPuE1EGzf4uOaOhd9NRJBsDu9nBp7rE8roJN7xaq6A/SWhPsnyqxlNH5gb/8lJMV4uVEaD1ozkZY9V6v9dxYCS39mq2kDadz6sc9qcjgLR+qKIxzwjlfRwUvZttipdWQQILeVmvnR1x/oLiuqQaBjuUmmlJN7bVrcDcv8WKinZqwl15QWQXMk/IbHi4xn8wfbkvgoHzULok376aftFE99ttCezWYqON7iVCYeqGnjOdYqKJSv9ru8mlY0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cbd8d6-c7d5-4c99-367b-08dbd9fa70fe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 10:16:26.5088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhHDZZweFZMHsrqI3BCV+w+Q0vN9icMtFzHkjh7xIBogltqai3GtnteU6ii/ob62szq+0qaZd9ypmWsRAhLLLLXov0dWf4+kY8dyzh1O3RM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5879
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=900 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310080
X-Proofpoint-GUID: 4s7xu6RuOtucOlYLgvV-FEWmyVjU5Lb1
X-Proofpoint-ORIG-GUID: 4s7xu6RuOtucOlYLgvV-FEWmyVjU5Lb1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/10/2023 11:07, Sumit Garg wrote:
> Add a separate documentation directory for TEE subsystem since it is a
> standalone subsystem which already offers devices consumed by multiple
> different subsystem drivers.
> 
> Split overall TEE subsystem documentation modularly where the first
> module covers the overview of TEE subsystem itself along with generic
> features. Then the further modules are dedicated to different TEE
> implementations like:
> - OP-TEE
> - AMD-TEE
> - and so on for future TEE implementation support.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>   Documentation/staging/index.rst  |   1 -
>   Documentation/staging/tee.rst    | 364 -------------------------------
>   Documentation/subsystem-apis.rst |   1 +
>   Documentation/tee/amd-tee.rst    |  90 ++++++++
>   Documentation/tee/index.rst      |  19 ++
>   Documentation/tee/op-tee.rst     | 166 ++++++++++++++
>   Documentation/tee/tee.rst        | 122 +++++++++++
>   MAINTAINERS                      |   2 +-
>   8 files changed, 399 insertions(+), 366 deletions(-)
>   delete mode 100644 Documentation/staging/tee.rst
>   create mode 100644 Documentation/tee/amd-tee.rst
>   create mode 100644 Documentation/tee/index.rst
>   create mode 100644 Documentation/tee/op-tee.rst
>   create mode 100644 Documentation/tee/tee.rst

A comment from the peanut gallery:

The old tee.rst starts out describing the userspace API (include/uapi/,
/dev/tee, etc.). Maybe this part should go into
Documentation/userspace-api/.

The rest of the document describes the internal kernel API (how to write
a TEE driver). And maybe this part should go into Documentation/driver-api/.

At least I think that kind of split is what the documentation is going
for in the long term, so if you're moving these files around anyway it
might make sense to do it right away.


Vegard
