Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5936D767276
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjG1QyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbjG1QxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:53:21 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529AD4C26
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690563126; x=1722099126;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DNdfoTgwyHvSlT+8mWsv2ShJMcongZH4WRE3s9spomM=;
  b=TurrqBeMt3eBc7l6/AKubIueOIPCV1rkRGl3WVE3XCTODMvbwfLUGgf4
   wPD91YsX8bmjFa7jnLcJoKM7mVxDRXEjJ0tbnY2q3Hcw0di12+7Y1q1g2
   AZ6/WV995yr7F8EMGEf8izneYX9N8W2R68EVsv/Xqbq9XrCn82AcGqKnd
   wF/Hvhsj22Yx6JknUunKRGi5LN2irX3k5TQi7ugZ1028QcXzh4x0spZle
   zSD2bGn2zbYACxkgrzF3igBzg/lyyPk5FjvypCQCqxGxHgDCdU1ga9dA3
   a6j5soDqbjYA5qFnIUts7lpt71f0TiNCO8a+S9nM3qbmP51Tau/eXPXA2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="353545933"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="353545933"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 09:51:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817571182"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="817571182"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jul 2023 09:51:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 09:51:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 09:51:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 09:51:15 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 09:51:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr9oYJkogs/xVb2QzzcedH+42uSXSqR2enz2Z9EKGENUcG/F8bhyuIcvzR7nIDX7KBAlhU6mp+5FA9026dq2C5uJJs92Nv1uN3D3p58CBk8CHg4y7G4nkeS9dndDLnaa1H/gVO0BIKiAhPFi8OAbE7URdZnQEQXoDTIO6KT/t1wvAtCv9WmqB9StrNDRz3uyU52ebX2ulyW/ow60Rt87HCPlCljGbVQ8ZKmuO0Cf7su+qzsqcSJbuu9YbAzlWJ1Rcfc4jT1ckCuYVu79mhsItKpeNNKTygBLaLO6c0YRqh4vq3L3gtDTRr1P600nmq9m9zAuH+9TgwWyPpA//iUmAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJGjlYXch5YJgw73HqZg9jzSuOaeoYqkfUO89mCSVp8=;
 b=ECsX16e2RnE1xFmEGKLlw3DHH8cY6NgBzG3WEQU1ajvBspckoiLaG0GFjPZ/8sZtU6BjvZN4+wzRLcMLyiNewCt1fUF19XGcz8+vdz2og/+7Yf5bPR3AmE0HV4PtglpzyGVuNPOI5AnQ3XZRUGN8zB3D58hmHgihra0c1/+79SEbF1tOqkhhMpoxQCdAI3G2v9PgJPU9NQFU0PseEovnlBmVFjCE0F+0k6cQByvads1HbRTdEHxbQMAsXL/OHQm8eHtIKr0/60B8GPEl8U637Uskzypl060gE9nQQU5o3g1zf2JZaFf3w4TR5cB+RJoYlMXfX7gTlKJq5GnTKEcZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CYYPR11MB8306.namprd11.prod.outlook.com (2603:10b6:930:c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 16:51:13 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2%2]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 16:51:13 +0000
Message-ID: <81d25f6b-5498-0996-650e-810f202a9d73@intel.com>
Date:   Fri, 28 Jul 2023 09:51:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] x86/APM: drop the duplicate APM_MINOR_DEV macro
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jiri Kosina <jikos@kernel.org>, <x86@kernel.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230728011120.759-1-rdunlap@infradead.org>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230728011120.759-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::14) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CYYPR11MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce8f9ab-3425-43a4-6ae8-08db8f8ada78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IDXR1tAzgzTCbm1YIgYANn2bO0XpJzYmA7f2lEFFMFDjTJcbOV3St/RYlA13fhnYRF/3OTsVLQ7Wl3la9Bssu8sCO/6nvG76BQLNmwRhGPDWDn12yUurSogApZZcDkEoWRQHMc+f9D5aXrGJEURNTNzooOTLZZScCQlKdkADe0v42N+1vbyKcdCPnlRR4L/cZRL2V+8v09DiXmUviLjNlON96TqrvfbHmNPLQCPEA0ZeBqbY/qnJ4wTTgEEdxdYo822X/S3mp3zpW/BcsgnXMTh1kIJUmJdHe73CFMHP1FXJEA3X5L9Nh1p6wJ1gmDXaSDrc1BxEnCFxWugtpRG0wVxxzxgtIz4VrJqGM/LpRPsyBTOukQqGz2e2j4FlHBsYwND9/DApHLEwjljJnEhTAlqzsFLfCVx+rpIvE4XSibC9Q81oCywYTXm1/IVRXZ0OrPiOWXkSssBaIiQkDMraJr5COYQ/2ve6mgVQuI6l/EsKZ/UYsSyLwiM7VOqHCGU/Ddg+I28dvzg/EgV4utYBPXiAMS1bwS0uXch/EexdOlWiSkevwAvMWHQRX9A6fmYdnNLyMbA9bBpRJrS928BPGtc/0Y335ei8cz+aWaXk+UYTEodWtBssRCX/2BX1wF+G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199021)(36756003)(2906002)(86362001)(31696002)(4744005)(2616005)(38100700002)(82960400001)(41300700001)(316002)(6512007)(966005)(4326008)(26005)(8936002)(8676002)(54906003)(31686004)(6486002)(66946007)(66556008)(66476007)(478600001)(44832011)(186003)(5660300002)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkRyaVljdDBYZUZlRmdkZ1R1SC9KMFFsb2ZVUDIvZitSL000SytEWkVsZGd4?=
 =?utf-8?B?RUF3dkYwQ1V6b3ZtR3ZlelhUYk16SGxIaDRRbU00UE5yUTVLR0pqWEhEUXhn?=
 =?utf-8?B?dHhpODArTm1FMzJkUlhmREc5YXlWaU96bGUvQ3lZSWRObWtNU1VUT3FCQkRF?=
 =?utf-8?B?aVZzU1QyMC9GcXlKMzRxazZxM2ZwbWliNnpjN0IrZ1FodEh1RjU5Tk5JMm1u?=
 =?utf-8?B?WEpnekE4S0s1eG4zZHdpSk1rNmEzbzYreEdjbjhCT3poVFdjaFhSMmFWV2pz?=
 =?utf-8?B?enFPYWM2ZDJheFQ2Y2I2T3pZU21pWVNydmZtdkdPbWFmNHZNSE04SllGdlFa?=
 =?utf-8?B?cW1rZ0IzUW1sNUFCUmx5MFE4aWw2bng2QnR5QkdVK3h3eVQ2eCs0OHFWaXhB?=
 =?utf-8?B?QWNtNTc0ZytUSFVSOFBsdzdRdXlSZUN4YUFBRFI3ZEtJMjE1TTVidW11VTlu?=
 =?utf-8?B?WlNKRFpWOHllSkRydk8rb0dFazV4b2xxT3dCUHVuK0hla1gzb2dYSy8wYVhT?=
 =?utf-8?B?K0pJdFN6clN5NTlyS1RBVmN5dllNemx2anRWay91OWI3N21tU3dlYXY0ekhG?=
 =?utf-8?B?MlhCdXoyQkJWSENiQVE1SWtOWmFCN2hwYnA0c3pWRCt2OTNyOTZVb2N4NXlF?=
 =?utf-8?B?QzI5bVRwVHNISmUxanRCTVR6Q2dRMWl1amQvS2pkYnlqdEo1dWJkVTV0MGVs?=
 =?utf-8?B?THhkYkt4bFlZTHpnd3htZVNCSzNEWnlZY1FpOU02djlkRUYwVEg5RjhzcDdB?=
 =?utf-8?B?cGsySVBKRG5UeGM2R2NMNGh5RE1tNURGcmJiUDFCU0h5RmZERVNsaldpK3lW?=
 =?utf-8?B?dC9zaU1reDJNbDZYZTdXOFlydHFYRGJDeHYvNm14U21MaHI0OVY0M0IySEZq?=
 =?utf-8?B?S3Z5SThuMDZVK3VYNVZoVmtlY3ZtVXlqbWNTaFYrR2t5KzFzWTYxZ1Z6WWho?=
 =?utf-8?B?VldQV20wU3Y4amh2bitkd1Q3QkV1NC9CZUNnbFlUcWdEejUvOXhMa0oyRXky?=
 =?utf-8?B?MXl6WnlLRTJBZ3RTQjRiNjdSaGdFbTRkTjh5emF0OGlTZ0ZSUU9TRVlaSERN?=
 =?utf-8?B?RDVhdGNJTkR0TE10YWE3MlRHbVBFMWdUSldnZzNZdFdHUk9qTUk3UVErOWsw?=
 =?utf-8?B?NWIrMy9mM2JvcHMvYWdtaUZhYVdmNEMyTGRLOFExTC80ZzVoc2E4eW96NVpk?=
 =?utf-8?B?cU1qaWlUd0c1cGZEbHh2N1lpNHphNjUzUG5PbkJrREkrSjlEWFlCMW0zZ1ds?=
 =?utf-8?B?UFBFUHFrMm9jL1hLUjdwbFV1VEo5b0NpSWZYNDQ3d3RtbjF1ZFRiRVVJdUFt?=
 =?utf-8?B?MnJhZVFZOGs3M0d0d3lWeWhMRHBzNlpQNG5KRGk1cnQzZnhwcmlRVVMvWDl1?=
 =?utf-8?B?R0NYWHQ2UExSWFQvTTB0UnJFY3FSQkpVUWhaeEExV0puclkvaUVCeVFhTmVC?=
 =?utf-8?B?OTlJMkhwejF3ZDZVZHd4NVNpR1h6SkpkS0p4aG5XOW53ekJBZWtaRHdvelF3?=
 =?utf-8?B?ZnIxbm5YaHlDdXlrTXI4RVdGRlByTkVBd1hxcnNYY1Fad1dXb0Exd0ZRU0Q2?=
 =?utf-8?B?dVFnTVNkQVQ0RFAwOW4rRkZmNjZlMERyWDlwZStqRnBsdUN3SVN1dGowOWlT?=
 =?utf-8?B?TWd3alNGRmRiV3pKOEdxMXRoYi9OMkUxMUFhV2VwUDk3bEcwVWgyTExWZFdC?=
 =?utf-8?B?TXpneURxc2QvZmVTOXlUb1R1RGRGMXBKay90V2xrbmw1TFk5Q1R2cUFPdnNa?=
 =?utf-8?B?V0duZ24weGhBaGxxRW1GN3JVQm9oSzUwUENRSWFyTVJZbmJKeEluTzQrWTA3?=
 =?utf-8?B?b2JybG5lcDdBZGkrM0ZCV2lVOCtMQmI2V05ocEhVMTl5cDEzSEZnK2wyT2xt?=
 =?utf-8?B?aWhnbVBHd3dHVVN2LzdOajd1bGJSTHo4U0VWU3pQTkpRN1Z0YTVTY3RyYmJh?=
 =?utf-8?B?QnJHaWp4YVNkWTBYNGxDUjYwUVNVa2ZuVklEdnhvSXJMZTk4UElKNzIrQm0r?=
 =?utf-8?B?Tm1KTmFrM1NMU3lZTkJQR3lRSis0bEJjcjczZDB2djFHblF6bHZrQTRjQjZT?=
 =?utf-8?B?RGJ1M1JBL2llcldqQnhuZS9xS1pqK2t5S2NRREVucXIzK3ZHdWlCV0IvUE9N?=
 =?utf-8?Q?/Y9c97T2xAZUyNmfArFfPdjPL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce8f9ab-3425-43a4-6ae8-08db8f8ada78
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 16:51:13.7997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9CZg3iIUGiw8j8zI62uo+2grYdojxmCo68fOEEf5PIywsAjJhiwBrhkFdkaj82q7nXpZgIZ1DxEGnCgD/nkiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8306
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a nit, the tip tree handbook says:

> "The condensed patch description in the subject line should start with
> a uppercase letter and ..."

https://docs.kernel.org/process/maintainer-tip.html?highlight=tip+maintainer#patch-subject

On 7/27/2023 6:11 PM, Randy Dunlap wrote:
> This source file already includes <linux/miscdevice.h>, which contains
> the same macro. It doesn't need to be defined here again.
> 
> Fixes: 874bcd00f520 ("apm-emulation: move APM_MINOR_DEV to include/linux/miscdevice.h")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
