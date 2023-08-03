Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C291076DBFD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 02:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjHCAHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 20:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjHCAGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 20:06:45 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E784480
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 17:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691021178; x=1722557178;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YBvdbrZxrzUPoomqTz0MRQNu30YOJahpghOHFDIex6g=;
  b=m9X18JwjkLDAaH0P3OmCQEOJYNJhvg+S07iFHSb3U3D23ijX+qjGFVly
   vAxe9Vs4g9EnKpnRG+WsGzrOB052zE3HPQNh3/4ArmzgRKn3QbPhVZoj5
   HbP8+RVfSi/pHdXSwSVIxVug0mOQhazWV57nzHF9z9F54XHpxdIGhTBnc
   MxK3DtFCC5EnC9W+MJJkjSA7hqtdm9XYCQeheETFDa//+obyeRZWSS28+
   9qpOCX5P60Px7faS9Aa1vI2xphx13yTO5AOb/fpoW6SBPDXvN5fArr4oj
   SRWuDLU55CK5Ji9U9k9D3ahaToGeEwE6WAONXObnqJw72L8WSWOe+3P8g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="373366160"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="373366160"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 17:06:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="872713712"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2023 17:06:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 17:06:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 17:06:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 17:06:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEINiN8LmsLaQeAdfqgagAnh/Ig8jDAsuRSgoWuSHZvLipB5q3VnK1/yF++ZAiGLd/a9hlzuP9lKRJhaM/eFCuI/5UCkwg2iwVb+tReannBd4rbqgBmhg/3K5LrPvkhNFcjC8B8JRH4B2qX3mRX21Hn7X2v305+lP4grOErW5qFYXf6Aq5cLImX3P7CgTfLhDfkNPIgIIDxJmyUF/iMN0hzIb5g86P9S8gGXECD5/fj9LELgrKBCOYdxDLL03yPnISOwLBFP86khuoasmBWEPlOF7dZ9Nu1G7Di+6WokvBO/SxY9w3v+sb97np/nsKEe11x3wO9/wdR4x8XO7iQWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ol27+cRmtuRkpxqN2Pbsu7tHdpoqQGrmmllB9J17nCA=;
 b=VoeqZt5P/jj0OXC7tLiO1LVWBxrTX9ZMFwzUHHgD9MGgwaTHRd+Hr2mOMHtQ1MZn4OqOyECLDfezjoTbuVBQTsZjfyQJohpq5I47I2ZaPwbEyAhwoaqCElaFL20dBcGdF7AVCm601HGeQ0Bq+gnaeZIx9GXk+OYNOoPdpwg+xHNbPCcJDycJTiwwaI8F1eVL4sKNCMISaz3XxlEY/e+MW5p5BLbZB94umJ4+ic9Qi2rDa5wHYaXYUdRaNr6nhff05clb8tMA64kHmwItGR9Fmt3lqeBepZmetoJyBRt4nd9xHJddqzDss/RfA8zcBI28czAtbxS/DbFZpN8X9v1HWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SN7PR11MB7439.namprd11.prod.outlook.com (2603:10b6:806:343::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 00:05:56 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e96e:8ce2:abd9:c61c]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e96e:8ce2:abd9:c61c%4]) with mapi id 15.20.6652.019; Thu, 3 Aug 2023
 00:05:56 +0000
Message-ID: <7022a951-cea7-7905-f8be-3a3ae65e9438@intel.com>
Date:   Wed, 2 Aug 2023 17:05:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch V3 00/60] x86/apic: Decrapification and static calls
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Peter Keresztes Schmidt" <peter@keresztesschmidt.de>
References: <20230801103042.936020332@linutronix.de>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230801103042.936020332@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0041.namprd02.prod.outlook.com
 (2603:10b6:a03:54::18) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SN7PR11MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 439af88b-2e82-4422-2216-08db93b568ad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zaxA3imqM5j2htMWbdiNTVK5WXtV1af0l74XsQ99o+ywdJ/ccAAiZe6o9gRdL2LW8gUyZjntY1tsraEuHgw7j9UcD7KtPtSKYd40gQNDmy8NWn9suELCt7WWxzKzRT+R6VlMvxez2fsjRCadtLWObLq9zJLz3ab2lF+v+R7jwrfadu5oBQDjJ3fczLQQraeT5u9Icdms7/FKak+j0Z5nB8VIhOL13UGr8M4qo5sJs+UaROXrNndc8NXhdDFt7QPnVbwNQzENBR592efAsLdb3fgxspanlUAtVjT1AO6f1bcQX56OyKtee3ZG3oiZYpoBwBVR3YUavn0Ef1PvD8D8yK8QGNm0WkP4YSpOp5DuSHZ4bc8nxLlt/FsouRGLr/jZmw5BP7Q8MeG0yysOQXzFMsYpY5novUqMtyi5tTSx4WBWh+rVqlo6XW9DpbZJ57F6ccUg1NPifcEp+qJxYgmZ32yRJp8WNfAvoX5L8DCWxraDA9klxrjbyWwIU4gQfyV83vLqJ4hVKJLuTeySFAydAzZv63kjb069iUtGvZKC0Iy9Qa3c7i2SY2WfaAShX3fjfLO6C550xhHVaBDrvEEO1ckMXqPrKjZLDnaWboOYmwYukNx7t6Au/bvN40IkBCy+ovqfy4pk+Dcu7j9gPSmwrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(66556008)(44832011)(66476007)(4326008)(66946007)(2906002)(38100700002)(2616005)(186003)(82960400001)(53546011)(6506007)(26005)(7416002)(54906003)(110136005)(86362001)(31696002)(558084003)(478600001)(36756003)(6666004)(6512007)(6486002)(41300700001)(8936002)(8676002)(31686004)(5660300002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDBrME15L3FpU2NLZDZXMk9HY1NSMWJLNERRWWlkOVhPcit1aU9hc1lMOWtH?=
 =?utf-8?B?b1doZGNGWDQ0V0FxZlhtR1lycWtYR0ZZdWhBU0NRVkNNei8rczRVVG04YTlp?=
 =?utf-8?B?YXB2YU9QVEhJdnZ6bXVweFJCWi9Hd1J0UGtKMTRremRiMDVOMzVzYzhLOTVF?=
 =?utf-8?B?WUlETXlyTkl4KzdpVDVQeUZyN1dqTkNGOEUvMEFJWnYwaXQ5RUMyTUpWdW8v?=
 =?utf-8?B?bS93MllTZzllUFBtdERmeXZBRHpLaFFMcmhmaXBuNHZ5cWREZ3BrVWRrSWJr?=
 =?utf-8?B?ME9QcmpIeW1WN2JuM2k4NFgrUmJWaFBkdU9NQndWZmNVMys0RnZpcFM2ZHdo?=
 =?utf-8?B?VjdOK3VINXo1djZHdDdNT25XRzU5aXI2WTZxMGVyWEJJTU5YYndwNmlhQXRs?=
 =?utf-8?B?TFlTYUZQcXpYMWlXdGtpL2dFZm9kSGxPZlJDUmI0TnB6WHlsZEF1YTBpb3pl?=
 =?utf-8?B?UzVFQzZ2dEtEK09vNUliYkl4UHhZOHBjTm5rc2N0RG9FZVhRejNmWjV5SGhO?=
 =?utf-8?B?bFNZRjdnQjFkNHlkZXcrWUphQTl5c09HN0JsMU95SGlmZnFmZEJkU1NYWnJN?=
 =?utf-8?B?cUdoemkzVTJwUGQ4blp0U2dLM0w1ZUhxcFlJYjNnYlBoajNtMGpKQnJuckl0?=
 =?utf-8?B?ZGRzSjl5VHI5UHVmb2QwY1hONWxXZWN6V3pvYVdXZTZMRXF2c09MZEloSHg3?=
 =?utf-8?B?RUFXdndlblUrRTc3NC85MzJBRzZHTzMyTDZyVE1BZkQwbk5lYUx0NEduc0Fn?=
 =?utf-8?B?cjJ0dkRrU0owWlloNzdDcDRWVWZqclZrR1VLdWZBNTUrQWhwNUkrdHdYbDlM?=
 =?utf-8?B?cGR0NVZERlAvQTFJaWs4c3lJU3dOdE9ySjY1RjNEb0tTdGZ2aUlNRVcrb1dD?=
 =?utf-8?B?Y1NTUTJDOEVoR1pUNlRsMGNkMzc0L0ZGK2g1VEp5SWxZaDZKb2g1cGlvLy9z?=
 =?utf-8?B?eXEvQ0hUclRRYnYreDVhdjFRUUJrd0pXMzNkMXE4a2RqcE0wSW42SCs4bG1q?=
 =?utf-8?B?aGc0czZNL0xqNkR2YXNCWVZlNTJVVVp2SEdaSlNkQ1JOZGhWRmRjbXpiNTFM?=
 =?utf-8?B?QjNJemlzQmhKL0wrMzVWMmh6aUZPblgxemhwSmRoNGUwRlY1WVdhcC9BdGlx?=
 =?utf-8?B?dk5xejdSQkVpODJqZ0xFTmRNYVFiampCTFpka2MvNXJKQzVBRzdaMjJVZTlH?=
 =?utf-8?B?dk9TdUNrWC81L2FqVFFYVE1lWUNWWVdxdFMvM2UyWVVZaEJTcDhQYWlDeWZ6?=
 =?utf-8?B?REk5cERXZ3BtMjk2dTBqN3VLajhoZVdYMWwwaGdEUGtBb0pOMmxxcThQeTZR?=
 =?utf-8?B?RnBzcDVqQmVyOU1xcEx2RnZCR2lBVDB2RSsweUVkTFBCWjRSTVVwbGNmTjFZ?=
 =?utf-8?B?V0o5SEUvVXd1VWhGSWVtNzlqTm9pc0VUcTBkejNtOFhsQ25QL3ZQbS9VNTVD?=
 =?utf-8?B?NjVCR004RytyV1U3Yys2bGkwVFpFMjh0aEtiU2tJQUd3THhmakpiaC9VMXNs?=
 =?utf-8?B?cWFGaVlRZHZhTlh4bXUyckJUMzJQc2NZUmN5M2lQR1lvdTA0MWxNNWp5cWZo?=
 =?utf-8?B?OXVjaTdvSmlOWDZOdjNlVHNmRHU0RkxndjVyb1ZScUs2azVvUnRrS05yVy8x?=
 =?utf-8?B?djVvSEVJYXRmZitIZ2N5M2ZBeWlncnFlZXNkd2h4dGlSM2FQN2wvL2VpZW9B?=
 =?utf-8?B?dHdwZ2M3UE54MzB0QW5rTXAzcEJTTnVTWGoyb3pFeGtqZGdhNUFlTFk0U29v?=
 =?utf-8?B?RkJHVVdJVzNQdEVsamZTbVdHYlRtcFpkM1dKNnlrOG0yQUNld2ZpbDI2Slli?=
 =?utf-8?B?N01MR2hsUmtWd0cvM2ZwSFl6cmE1U0JEcXVVbmNmTHhOT0IzOElodjJ2MVJ0?=
 =?utf-8?B?SG5WWEVidU1KME5rMFFkSUowOFI1Zy9zUGlPTVNZYTg1ZDlqWHA2TFJsUXNt?=
 =?utf-8?B?NE5NVHhpc2FtcWRWc2JxU2VaNXhDenRpbTAzWFFPZTBaOFlhNlMvR0l3aXdu?=
 =?utf-8?B?RGhNSmRKWTBzeG5oQmxkaUxjWUxwMlhxb3lZUkFUKytUNDgvOVpGc3c4VTln?=
 =?utf-8?B?QWNSL25xSFdLRHcwZDJ4b3RJaDlycXRSNnpaOEdLT0RRQzhFWWNrNklhaWR4?=
 =?utf-8?Q?vTDh+JVvoAecbLDd15JSyhEue?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 439af88b-2e82-4422-2216-08db93b568ad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 00:05:55.9912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBxUxYrjUUOnO7paB81kQA1iErf9wcaQq+HkQnQTzrGlz90axhmlf13xIQqHPctXbab6KFp16Z6UNm2TYPlJfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7439
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/2023 3:46 AM, Thomas Gleixner wrote:

> The series is also available from git:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git apic-static-call-v3
> 

Tested-by: Sohil Mehta <sohil.mehta@intel.com>
