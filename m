Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FD479EB57
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241395AbjIMOnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241412AbjIMOnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:43:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62945B2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:43:19 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DCf3o6000712;
        Wed, 13 Sep 2023 14:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=z97mb3OPwXvxl7gDab80QfPwgUyFO4OjpaQDVMjtHZM=;
 b=KAwG3jUnTqw4p7ZkSodtk0I8tvFdMLloOF1kEOwcmlOCz6ZbrUTpIhw37U7L9blj2zHa
 YQA4c5kKGYH4tlXNqTAiie7+/UqnM8/yhY1EdF7ov5hcfmO/GiMTeeDQiikMPuGNOgdg
 lRD/ckLrowxbwxcoesr+58LVQnU7RzxiBNvGGQASwbo4aFeZuCEkP3v262fMjBZIl7FZ
 Sl5EE3UpCOARjUh/mfGQ+LIz1EqDFpHm7fFuXSBKKw2oIMxV6JcBRoBvH5GyD1C8U+IV
 XtCIGlwY3M9DmiLirfYGZ516O8YFI7bFQJq2uJQpHrgJB0BYzlEzWJulpQ/Nzi6oYLWU Fg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7haasm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 14:43:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DDSNqB015247;
        Wed, 13 Sep 2023 14:43:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5dm7wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 14:43:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFM1fR9k/s3s8E85GPcJmsseCLQVmrhjgjLW2qhfy0DGPTP5VLJjbGltF/W22/bvMK6/Db4lDHaA1IjZiktjcr6faYq+xBmeIHZQ3Iaaf2H2nx7ttW3EtZsg+9/pzSXDI21evUgz+pWgeidTXUCjAsWBeRvKWI5UOEcjN/3X+JbBia5pCkkY9oL2yx+zNzf8qCR2OMV/RuDpXTOwQkwFGF2FWtiCodXnUcg99JDWaBPtXsebFU2NYNkECBtlerwGjTjKyXlXcO2E4D4Mj7uQKZnGfe46ndffOz/WNXcysmjl1S8r1RUmkB8zrxquOtozUH7oHDWmoOeLh/H6Frbrrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z97mb3OPwXvxl7gDab80QfPwgUyFO4OjpaQDVMjtHZM=;
 b=ntcQlC90DiAtCpWdAqaQC/0RRIWzBCxlTLNSaZjIFOQajCAZjCAki+pJGxHg0cflApS9ZlpMpIILzZuZkU2vRk7na8HEsqIOSA57JsDNRU3yoj4Vj6NAnu2EGa9D+yOfv8pgdzMOwDfFWHuWiXPZ5SzeRdog4F5rdhja/iBvlNjw3scl5K+PD2C58sIe9OeeKfUk1m4ch66CBT2s9F/kPPm/tB9al9svn6aBwXrFc7aAWhQ35496NQZvG6GQ33n45KtcXpRdxRUriY4Y6+2QcImjCrFm3ZkGpLkKzFqSFPDnjyYqcJne2DLRaReikXccA+pGYzqFJbxJ5fICHafwWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z97mb3OPwXvxl7gDab80QfPwgUyFO4OjpaQDVMjtHZM=;
 b=BOTIs67gFaQ+cHOX6p7WvgG7GzjFnHyqMl36WuNSDHHigJhsqBY1ptiMTwgAU+EhUcmaueKYnj4AwxlOsfaUQo7rQU59JpwK3Ex/hPPbvgYpIa1l4vL5kYxKbkdSJ9tCfnNQe71lvEJhw7agsUI+Cr5y+KXm3LG0Twqy/pJ4vro=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by BN0PR10MB5271.namprd10.prod.outlook.com (2603:10b6:408:12d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 14:42:59 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be%4]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 14:42:59 +0000
Message-ID: <c90525c4-ad01-4807-b627-fdf8bf5f8e2e@oracle.com>
Date:   Wed, 13 Sep 2023 09:42:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Jfs-discussion] UBSAN: shift-out-of-bounds in extAlloc
Content-Language: en-US
To:     Sanan Hasanov <Sanan.Hasanov@ucf.edu>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
References: <BL0PR11MB3106CA1E8C251C8B564106E4E1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <BL0PR11MB3106CA1E8C251C8B564106E4E1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:610:53::29) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|BN0PR10MB5271:EE_
X-MS-Office365-Filtering-Correlation-Id: 16da3da7-9103-4ced-2dc6-08dbb467b9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FxCKSzy1S3QCvodRDFud/5sZ40XZrSdZLkVgnoAnfv7Nvd/CKgjDX57pVw7oCAruy/VezN4jUqUvsE5m8+olErk8bLFJa+sMwKcEXHi3XYj0jZGsQSSkW5V9dHccB9JtgThAimv3naMnWY/ZVWpLYzhN2mWCMhCngZX+QNCHfC1mu/jcOlE/FNv+t/3rJcSqJflw/DEeFYnNQi8X5HvFg6NoNILiGtuiCSKySBUUtx8tEZe0luEBpE/CTYITGFig0s34SqX7cVpSR98d2J+zzfLAmKLXrg/hYhq0045O3niWqWRwqX/YKi8+5w0vMNGY4G9JPsgjvzF3U664xkikntUYpPtMDSsKA+ALMvT50OlhnGw2E6MIrS2Mk9fmlVbb/Ds/1Cvt6xOW1DZ9BAidTQlMBkffecmJ1grGpVj2vk0sMPAwunUuIKJj8XeZtBhrrv83CLZ5ic7/9uZjlGcMJSx0slq5Ska+/SvrffwNR+LUv7CshCGS6iXdIvbw0xi0hQmOS8DR5NkDRKXJMTGt/4Jirx0eAD+NSVlUc1xoMWw9ZBgK7jYIbOK9bH7TGJR6yS+DTBETac90ZDQ7T73oMPYGE0Hq0HuwnXfIIGij4xLj5i2SFVxT4fqnwP2Hv7kjLb6oGl7Aje83Edd53KYEmqLDUr8aFN1kAR5XGOQIqYOXa5Ee8WL94W+y5zYNkAKNduav9ozYlIs9Q/VRz21wOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(1800799009)(186009)(451199024)(6486002)(6506007)(6512007)(966005)(478600001)(83380400001)(26005)(2616005)(2906002)(44832011)(66476007)(54906003)(66556008)(66946007)(316002)(5660300002)(4326008)(110136005)(41300700001)(8676002)(8936002)(86362001)(31696002)(36756003)(38100700002)(31686004)(5930299018)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1BDenJvaVJEVlZCY0MybjMzL1htMTZLdDZhUDBsM1Rja01jZHM2ZVlnbTBO?=
 =?utf-8?B?Ym9oQ3BpNDFQdm5peGxiR1Bhd09rLzhJbXpYTGNseWJtV3E3ZytKcWtzeFFN?=
 =?utf-8?B?YkxQYXQybmFyU1ZDTUg0OFhNcmZ5bE5pcTJiMmpScHhyaXBkMnNnakdocjls?=
 =?utf-8?B?R0dkOElRNEtpa2ZFeURKSFRtek9scXVFakpEZTRpcHQxU0NMdVMrUmx6VGVQ?=
 =?utf-8?B?SE9tSGY0UjBhRTFuSTFta2tOZ2E0WXZJWmEvNG1Sdkx1Z0NMdjByVVBiUEl2?=
 =?utf-8?B?L1JMMjUwdXBUdGdhUjBZWkdEUFlKcFVyVmMzWWJINTRtVlNkTVExaGZQN2VX?=
 =?utf-8?B?Z0NydFBja2ZTdnZ3Z2tId2NrV1JyT2FZblhNUVNtbUdsandzM1I2YVZQZDdG?=
 =?utf-8?B?OWY1dmV3SjljRDdMdmpzWHB5akNKMSs5QktnNlRYUUhZZDJGVjYwdjdmVWUv?=
 =?utf-8?B?d1ZlYVZQYWFtRlJTYUtCeDBlYWRTVEJTamk5VnAyZXBmbnRZWW5RRFNDNTNR?=
 =?utf-8?B?RkpEdEgya3hsOE5WVHU5bVJYUHd1SDVVUGE4NDJsVHZnNlNJUUF2OE92dTJV?=
 =?utf-8?B?ckRiSmdzSmZrdGU5MXBDOGFRU0RrclUvSk5vS2lDbnpjRWpBdjNyOW1mMnR4?=
 =?utf-8?B?MmZnTWtyUWRSOTFqVFZxLzhpdHFaeGZONUM2QTRJbG5ZcjBzN3RnNnB3cjR4?=
 =?utf-8?B?M0t0L2tuTDhYZVU1Ym5xMytleG04TytvZ0h1ZTF1N0RmeGRHcE02SUJsVDhG?=
 =?utf-8?B?OVp2QzQ4YVNZbjl1UEs3YWlpWTVMemlwcTUrZWQ5OWtSdHFQa2ZaemtyanZa?=
 =?utf-8?B?YVNKVFE2NDJGZkdpeWp4TFY2WjRtZ0hvSlIwSG84ak5NdSt1WUxJVmhGa0ZU?=
 =?utf-8?B?VVo3UDl6NmFRYWVIbXNEV0dRTVBKVUpJaTVZTzdYQ1lWZ0RhMkFaZUJtMjV3?=
 =?utf-8?B?cTVBK095VzU5d3NLNWpaUnk1UkZ3eXF5N1hJcE9HdlRxb201YXR1cjl0dmJw?=
 =?utf-8?B?OEFVaXNoU3BHNlNoSGZXdWp3U2JIc1JLRTVOeXVCdWJDRmZtTVVMOGNTM29O?=
 =?utf-8?B?cFprYjI5NHc1YmNOelFteUVLRURYSmN1Vm0vSndsdS80cmMvWHRGVmZqN1dn?=
 =?utf-8?B?ZlVzTzdaMkxHcXU2aGhQYzV0UGIzQlRET2hmNjFwZmJWd3RScC84aTV1dXVh?=
 =?utf-8?B?dExFSFFSd2I2aE9EUDZGb2FQRml3b0R1K3gyKzd6bnA3U2g3YU0wWXBPb3Fz?=
 =?utf-8?B?Y2RobWRkVHVDUkVXRXNpTmZsemp2RFRJZHAxRXJvQkJrYmVsVlJrT0t5NnRa?=
 =?utf-8?B?NG83eEdWd3BURXlUOHZUQjlkcmpZYmhIYnhnWWx6TnFFT2ZDTXN2bXVqQkN4?=
 =?utf-8?B?U0xKTmhOWFFDWVBUWGxvblBSWFhWQ1dMWmh5U3N3dU5MOVh3MllmRFRpUk55?=
 =?utf-8?B?aE0rNnRTc2FNVVhvU3pHVHQvSVZmTkFmRW45NGdwTFRqdjFjRTFCQ1l5S0RN?=
 =?utf-8?B?RHE3OExYbVErbXpEZ3FtNHI1cnJSckdVUFdCa0NDNzAxNmFSVXNWemdWK1ZC?=
 =?utf-8?B?RGVJMWl6SlBhZlZOaktaSWd2ZzFwY3ZmRDQ1eWEySG9UYjBPODFqR1ZSNGw5?=
 =?utf-8?B?bEJROUFFUkhWQXNqb00vTEtLaWFHVDk3dHpxUWtwQkw1Q3RrQmkyak10ZzRX?=
 =?utf-8?B?OFI4VExBVjl0NklMaENBY2N0T1ZnUTYzN1RvTnVTbjlBM0NTZkEzV0Jpa2tt?=
 =?utf-8?B?eUN3a1FRQm9Na1EvcTRqQ2dMbHhyN2RncnhoeW1wU2hhenhEYTYvR1EvNWxQ?=
 =?utf-8?B?OTJzSU5IQkdFNjBHb2NrVUtFN3prcmlFV3JMVTliRTJJcDdHVW1sODgyR2Z3?=
 =?utf-8?B?MGo4d0paQ2hLbnlJanpmeC9GdGFOMXp5SFNIVkwxdTQxMk5EajFhdE82WDd5?=
 =?utf-8?B?QXJmSkRlckZoUlBNMjZlUUJnZkZUOXUvcExIbnRDemprSkhUcWNiQXpIbkJL?=
 =?utf-8?B?SDhSTnZ1eTdYVnJ6OGZJQUNlNUkyTk90VG9pdDlBdVh4Q1NPb1grRVB1MWoy?=
 =?utf-8?B?TTcvTGE3NW84VEdybWRWRU5vaytFNkhXY1UwUnhTYlFWOVNMR3NsQTlwVG5v?=
 =?utf-8?B?NEN0THU0VklCOVZWQ25aUU1acHY4ajJCZ0U4V3kvcThJTHlFUlREMlk3aTcz?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: S+sPBOkvOD/98pK/rJxq1vq5XtMMevEcpq4OYZ6mVsIeh1XMfNmYCoRn5B3b70PENSWApqZHPapAou9/PfN5VVCgR6ob90aLzJq/Uf4GTbta159HKGg6VnGl25S7lbtogMYnNyeVXz+gH/yPkv+Zpw7PAdC9nSuaCExdKEtaRXcwx7QN9YXkpxX/Si6uMbiTVg+hFmHBAh2u3lgmRWmcPcs+8/d0xKcLgaO1ZAEMzceMey5OXauO/5M+6uNGNmeGcOGtjA65qnPV6o+JJXgUdmtkMqajuvk9r7eVCMX1hoqPVk6ATbkjHa29Zi3zx9W5gwAh9MAeaf7NkAqfJzU9xBGD/CQG90HXsNYg5WA59HF9y8gW12slVj3yUNVG3Hq/9h2KJ5knk3JBRWS2ChIRXLKIaDc+UqxpgvoRKK72wr55r4MEjrvosu11xOh9fYCNpD+VP2F5/SI4wrew3rES7S0SVDWo+HZKi6L53H9cJgf1pQeFgegkbsIsd6NcxwgEyRF/9pg9PbZHFz85OEt3cx8qerKX1SNY7L4/eC/4Pd/2ZmR9jQhjsdu5aPbBLcjuz9KnBeGW+VuPqnp9tl5xwB5At52zHg1myXZJeq8dPtLwcvIKBtpeuxNIUjgH6TVRgtzYgoIGZiS4rvcil9RGzrYaajGR/rWHKsxifphaxLFh9Oatzxb6FtL31bPRMKXxmgfUPS/LuUwjEOL8h6ubHc7lmGq1Ww3405obP6NtbTrAqrMxj1dfXfyUk9Ruh3zL07qnl+DMF4b7y5wYcT/lLVgSyUHWS/zYMTsWr2CpJjWOeXfckl/8Lioq9RhUO+/EDYI4IcaSmLj1ykvr4vjH07m+6oVhZynAnxLYe+VE5i2TzEk8x8kZdPrek/GUekSYtTmHCcbTl9VrcCUxENrut4emtZ4i+7sCVJh+lupzj0g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16da3da7-9103-4ced-2dc6-08dbb467b9ce
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 14:42:59.6442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DpNgJ6nW+1v23TUJS/Zr9mU1fHI6I8+r3MlHYDW+b4w9Q52VqFnMD6d7SPbh3tsfNzT9f8a6HL7o1BChXLgVThTy4jxMeNNXPCT11vjvKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_08,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130120
X-Proofpoint-ORIG-GUID: aZpQ4MsafvL7lYEwCzR6W0P3-ncC7Jha
X-Proofpoint-GUID: aZpQ4MsafvL7lYEwCzR6W0P3-ncC7Jha
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 6:03PM, Sanan Hasanov via Jfs-discussion wrote:
> Good day, dear maintainers,
> 
> We found a bug using a modified kernel configuration file used by syzbot.
> 
> We enhanced the coverage of the configuration file using our tool, klocalizer.
> 
> Kernel Branch: 6.3.0-next-20230426
> Kernel Config: https://drive.google.com/file/d/1v6xpOJVgzbn78LEAq5eX9bZiPJPqhfZf/view?usp=sharing
> Reproducer: https://drive.google.com/file/d/1-HrYhFL6t4xZ-fRhqo9yswIFG3Sk1FoV/view?usp=sharing
> Thank you!

This is likely fixed with the recent commit:
0225e10972fa ("jfs: validate max amount of blocks before allocation.")
This is first present in v6.6-rc1

Shaggy

> 
> Best regards,
> Sanan Hasanov
> 
> ================================================================================
> UBSAN: shift-out-of-bounds in fs/jfs/jfs_extent.c:314:16
> shift exponent -1 is negative
> CPU: 2 PID: 23961 Comm: syz-executor.1 Not tainted 6.3.0-next-20230426 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
>   ubsan_epilogue lib/ubsan.c:217 [inline]
>   __ubsan_handle_shift_out_of_bounds+0x21f/0x5a0 lib/ubsan.c:387
>   extBalloc fs/jfs/jfs_extent.c:314 [inline]
>   extAlloc.cold+0x8d/0x92 fs/jfs/jfs_extent.c:122
>   jfs_get_block+0x662/0xa90 fs/jfs/inode.c:248
>   __block_write_begin_int+0x3bd/0x14b0 fs/buffer.c:2064
>   __block_write_begin fs/buffer.c:2114 [inline]
>   block_write_begin+0xb9/0x4d0 fs/buffer.c:2175
>   jfs_write_begin+0x31/0xd0 fs/jfs/inode.c:299
>   generic_perform_write+0x259/0x580 mm/filemap.c:3923
>   __generic_file_write_iter+0x2ae/0x500 mm/filemap.c:4051
>   generic_file_write_iter+0xe3/0x350 mm/filemap.c:4083
>   __kernel_write_iter+0x262/0x7a0 fs/read_write.c:517
>   dump_emit_page fs/coredump.c:886 [inline]
>   dump_user_range+0x23c/0x710 fs/coredump.c:913
>   elf_core_dump+0x2786/0x36e0 fs/binfmt_elf.c:2142
>   do_coredump+0x2ed8/0x3fd0 fs/coredump.c:762
>   get_signal+0x1c11/0x25c0 kernel/signal.c:2860
>   arch_do_signal_or_restart+0x79/0x5a0 arch/x86/kernel/signal.c:307
>   exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
>   exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
>   irqentry_exit_to_user_mode+0x9/0x40 kernel/entry/common.c:310
>   exc_page_fault+0xc4/0x180 arch/x86/mm/fault.c:1615
>   asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
> RIP: 0033:0x9800
> Code: Unable to access opcode bytes at 0x97d6.
> RSP: 002b:0000000020000248 EFLAGS: 00010217
> RAX: 0000000000000000 RBX: 00007f7356dbbf80 RCX: 00007f7356c8edcd
> RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000000
> RBP: 00007f7356cfc59c R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fffbb79ec8f R14: 00007fffbb79ee30 R15: 00007f7357ecbd80
>   </TASK>
> ================================================================================
> 
> 
> _______________________________________________
> Jfs-discussion mailing list
> Jfs-discussion@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/jfs-discussion
