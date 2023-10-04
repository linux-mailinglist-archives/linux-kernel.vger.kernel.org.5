Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC507B8CA6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245263AbjJDTEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343960AbjJDTCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:02:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BE0172E;
        Wed,  4 Oct 2023 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696445854; x=1727981854;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SdGZ0Namt+Gm+Ezl4Vt8xPW25qWMrei4lnm+xmshKsc=;
  b=JRKmacYQ+GzDscY9FPLyhsDwmGdmMChZYIFX7VgvczkzZL5WjQnR/Jhm
   sgUjRnEPL+1j5vbf+5Ax3/T5DZMlqWgg8ExbDA/LudoidWYi7mQvmDwEZ
   YQVu+lWpffRverMDBmWscDwTc3Df+v7Oh+M3Njdc1VFrjhgHLJ5crdmBM
   uqUKuoLeLkiLzNbx5J0qVZ6rXfGyHVshpVKo/wuVpSA4Yc+9CguMCkGvc
   2AIF2zJXovz4FZWbJV9gD5q+Z89vivr8DiL5WEdN1DGT8wc+qG2mNP2Ne
   ey+z0oduyuXUig/R/lQHkEMB+vBVZfES0YugTxKkVYZhNZjk3QY8n48qv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="363545650"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="363545650"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:57:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="821805943"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="821805943"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 11:57:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 11:57:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 11:57:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 11:57:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 11:57:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKvY6GNbDpVGISzHdVC+N8Dz34IwQb1FAReSMvMLyXkEl5TFzzN9MaLniTo6iXG+UoBtqzI3sEaq3F87QkjGDNoBUjXP6Dh193kPQCbz2sfyimz6NgnzeU6KwnMKAdfwMoPCGZyc4NTVZLr+G2AFSN2AdsT4giq2YyiMuteJoZsl0mXVsYIBIulf8Av9O9HjkyTpz3A55mxlw+opmJQkZLeuOMScCh7RJ6C/Qbl9gVBg5U5w7uAn+0OVs5LMGRLEgmvlkTI3J03BUeA6m3z1GH6Z9r8BZz2CKlRxo4kwWGqpHQOe05IkT9Ydk8HezwTAKe2Sh/vGx29cSej/zQwjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSsHshvaNF9/W8ENSl9hfTOKQ1jJeQE8B5+TJGVzp3k=;
 b=iMeHRKwDnHW/zPaHsz6mcWYFSG9kJ0hTDCXdXFQDOLu2OTInNvwiWCrO44eAjLttqZPCYS+9smTc2orNkmHjv7hXaszVnhqzz6Szgf1FFh7T7K8qMOB7S/U2/OCHzCjY3EnlBSG1JGBFan2XEcJOqkZ5XVvjMOerFV1jh7y/EeXbODPtooZgB/vGuk41q6HGLzND9iefodVbqDFPXJzAFrE4OK6c/Y8NBAgLo7RqFLzO1UxVe67BitiKcCYT7ox02qOo2qFzuL2W1nSwKWO1dV2RjKCWahgZUiACiEDZaqOdJUDXq+LOuoSaSSjmWB163ha6Sa38nWXati7geBiTRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by DM4PR11MB5971.namprd11.prod.outlook.com (2603:10b6:8:5e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Wed, 4 Oct 2023 18:57:30 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::c438:45ad:1a1c:e168]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::c438:45ad:1a1c:e168%3]) with mapi id 15.20.6838.024; Wed, 4 Oct 2023
 18:57:29 +0000
Message-ID: <19a7d055-bb19-f3e3-1447-7238d14a2138@intel.com>
Date:   Wed, 4 Oct 2023 11:57:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 0/9] IFS support for GNR and SRF
Content-Language: en-US
To:     <hdegoede@redhat.com>, <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <rostedt@goodmis.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <pengfei.xu@intel.com>,
        <ilpo.jarvinen@linux.intel.com>
References: <20230922232606.1928026-1-jithu.joseph@intel.com>
 <20230929202436.2850388-1-jithu.joseph@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <20230929202436.2850388-1-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0153.namprd03.prod.outlook.com
 (2603:10b6:303:8d::8) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|DM4PR11MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 869717c9-e717-4769-0339-08dbc50bc21c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iIzUfexmsWIOHlSOmXcsumVQbd+zSV6DDokcTrLQKweAKQaqvweA1bmS8JzxvuoowE/PyXPxmryWpMX+kbyc7mvKkWt1XOmyYEfhGtzaPJ2NydbxaUdXt2+UmRPMryud2Pxw/i4gzIUE3ADAIVlGfI8PheWEoMZeL9xuxFtSx195RrEaqm67e0iUr793L7TZCSi8gPRwdBAHMLu0fBDZ2WIX/thF+UwQiIqUcmtb3EmPOoE+me7Wvw4ylC1pFop/nUcD/0lrPr9INYXdbsB1wgbCbdLIl6sRtYkU38vPiHt6+zh78HSw/gTfyiKcuhdq7fpijD4lm6pgB3CBO2dj6e+vYyHPDrQvUvYJZLskIp1TNCjdWmjLdoRmaGKnrcr4SfL4oiy1eR/deSixmx90VYBJAbXDo7Gsx69cvPDv+8eIRKdPHjNLXam+NFcMBIozxcgJLWJTo8b2I6H4i1FRDL/moT2l1uITwXQqXxRgXETkCAxwjHmEH2/TvTXjMDr06+RKKiANv2vs8v9+aEKELXnbl140zEvQy5hbyeWBVrqUrthHAKlQzG1rgDk/wp1tx31pGbZOjz9AqCsBw8uVy7EJg619RPGVFj284xh91Um2/r0UPhe+2vLrOlmXsFskmpMw6WTkh580V9zggUsN6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(41300700001)(6486002)(2616005)(53546011)(6506007)(316002)(6512007)(66556008)(66946007)(66476007)(8676002)(4326008)(8936002)(5660300002)(26005)(6666004)(478600001)(31686004)(7416002)(4744005)(2906002)(83380400001)(36756003)(82960400001)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzRobWwrdGdXZGpUU2poYXJPVmdjTVJUZTBKSiszR0VRU2N6VHBLNFJCcUNG?=
 =?utf-8?B?RGNCTjVld0NDT1Jod2dING1zNnNPZnRhek1OaUdScHZtbE5LNDBHeW10bHk0?=
 =?utf-8?B?RE5TOWhnenFXNU9WK1VXS1g4RkJNQitGNzIrK1ZqSmlaaXNVcE5CRHYwVlM3?=
 =?utf-8?B?L0gxR0FZTUFHY2NWYnk1RzNlZ2w1Q2lTN2NVbjNKNkxrMitFQ0FHTnRhdkNq?=
 =?utf-8?B?RFErMEdTUGtSdXpXemFaUzRKck4wVUlyYU51R1E3Vnk2MmpNME9zZDJIVUJi?=
 =?utf-8?B?cFVjWElpVTBaSjY3ZWdhL1A3SVptYUFHQW5tclRjTWlNVVRrTG85WkZFUVdG?=
 =?utf-8?B?K2loR3IzMHAyU01EN3VBYy94Z1pVdkFDQUJGSmJTOE50Y0JQd3hvbnRXUUtQ?=
 =?utf-8?B?cndvTHRINFlaMkxPYnFZWVdtaTBRSGVYVFNHQXdmSVhWSXhiLzVVQlY2bkhX?=
 =?utf-8?B?NnZIZHNXeXNPaGNQdEpQK3RnWlVoMStWZHR0QjkwaHZBamZPbWhvSE9IUEhi?=
 =?utf-8?B?UmpvU3c3V0VsZnZLS1phZ1RnSWNZUmJhTDF6MVRQUWNIeENhT3dpNWpqMnJP?=
 =?utf-8?B?TUtwSkdFK253N0tYQ2NUay9SelBDa3dEcVc3UHdHaHRhZVFhdkZST2ovQVd2?=
 =?utf-8?B?WHprT2NZYTFiVzZOQmpRSGg2MlUrc01HU3RYZ2VsY3JNdFJlK0xNK1E2d1Q4?=
 =?utf-8?B?MjZxQTliUWtEWVJkRDRVM0t4QmE1SXNXazE1NzF2b290QSsxd1BiWllIRmVr?=
 =?utf-8?B?YS83djFDMFp2aVgrZzdLUHk2bllNZ2F6TVdTTzNRZG1GNTFPRGxySUhpQ291?=
 =?utf-8?B?Y1p3WWZQalgrKzdkTnNyYTc4RjhlRUd1RUxCM1V2YkRranpXT1plS1NZdi9j?=
 =?utf-8?B?NGVvSCtLQ0QvekhyR1dnVThvQjN1UDI1OEhlUFA0dDQxckxKMjJWWmFyRno1?=
 =?utf-8?B?VUJYd01ZL2NGUnh3dzY0eGdzeE1yOGtoUFNWNDhlL0FCeXVubThQU0t5RC9Y?=
 =?utf-8?B?R29ZOFZnWFErcUd1Nm1RRkRDU3NOVlVZTUJmeTl2T2lDUGhidExmcXZCQ09w?=
 =?utf-8?B?QzBiV0VpMFNjeDZjTnozSlpnRnVSYndtOVRjaExUdVdqWU9aNmpiOURZL3pZ?=
 =?utf-8?B?S3gydzhjL2wzRm1uSnZSZmRObHpJZW9UUFBhSHpXdi84ZEpWNThKSFo0aFN5?=
 =?utf-8?B?Q1Jqd1JWdktmRjcyUTFWWkcwNTVjdHkxTHVDQ3hLamJySEgxU2RyZ0JBd2FN?=
 =?utf-8?B?M2Rmd0xiMnd0SUw3LzFjNVIvSkZ6VkFnM3NvMWVQOVFHQnR5U01WZnM3T2x5?=
 =?utf-8?B?MnRoVWcrTlVFbDhyK0ZkMDBJUjExY2dCN2JqVk5mTGZvcllTLzZHQml0UUFP?=
 =?utf-8?B?aVlEMkY0Um93ZFVuZEVFK3BuQ1dFb3NoZDI2RmJOTDlZU3JpZjBhYnMyY1JG?=
 =?utf-8?B?eVR1NmE5MXNJSU9VN2dyclpqRHQ3NC9JWDdHUG02Q3BjZXpVQ1pobFVNNTZT?=
 =?utf-8?B?c1l2OVpCK0FDdFVvNHJlNy9LL3pLdVJVNU56YVlsYjFydmRnS3lMWEowemhC?=
 =?utf-8?B?N1hkSzdJdTgyYVA3emQ5L2hWNmpkRlpkTktmdnBOY09rOVgranVjMEFIMXZ0?=
 =?utf-8?B?aUUrMS8raHBIbUQ3eFRpdUJNVis2TmhjSkpMTkJscUNYYU5uMldMSWR4OFhF?=
 =?utf-8?B?UXp3N1hEcFZxZGd2YVVieE9MSGQxa3p5NkxBYzVPRVZ0Sm5vcGFVNWVDa0NU?=
 =?utf-8?B?UEdtR05aOXFMWWFsYUxVREdlR2c3S2N4L1l4MGFqdjFPeEJoMVc5TTVZRjF3?=
 =?utf-8?B?cE9vU2Q0WHUrcFdHWStUSEozSUxYVmVYdk5Vc3N6amtYL0ZETmZmaHhncU5o?=
 =?utf-8?B?TllaNTN2WjE3Ynl5VkgyK2o2WUdBSW91bnBnb1pkZzJzUHpmZnRHenFCMTk2?=
 =?utf-8?B?dXdrTlJReWhBOTBEOUlNNlV2bXpFbGZMMEJsWktIYmRhd3dNeUV5blowemRy?=
 =?utf-8?B?ZFpacjk0aWZ2OGFrRzgrc045Q2RkL1RsbGl4NVBMRDRFZytMSnZpSENKejU2?=
 =?utf-8?B?QmVNa1ZsQVpWM2ZFdmdtTzZVdlUrQWR2emFiS1BzNXJSSGVGaElwUU1WcFdL?=
 =?utf-8?B?UUw3QVdHKzI4cjFnZms2azJ6U0J4SjNTbFMvQ2ljVW90VTM3eTBacHZMeFlx?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 869717c9-e717-4769-0339-08dbc50bc21c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 18:57:29.7014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xCRtcCx0D356y8NnXSHTs7PcJLY1uE3CMVM0znSdyiOy2V4v8dcV3zAuZlGQza8vGXgcYqb6+hJXS4NUHKGRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5971
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/2023 1:24 PM, Jithu Joseph wrote:
> Changes in v3
>    Ilpo Jarvinen
>     - Added Reviewed-by tags wherever provided
>     - In function validate_ifs_metadata() (patch 6)
>         - Add != 0 to next line for clarity
>     - In function ifs_load_firmware() (patch 5)
>         - return -EINVAL instead of -BADFD
>     - In function ifs_test_core() (patch 4)
>         - initialize activate.gen0.rsvd = 0
>         - use if instead of conditional operator
>     - alignment change in ifs_scan_hashes_status_gen2 (patch 3)
> 

Since the suggested changes from v3 are minimal, I am sending just the 3 modified patches
in this v3 thread itself.

Hans let me know if you want me to send a v4.

Jithu
