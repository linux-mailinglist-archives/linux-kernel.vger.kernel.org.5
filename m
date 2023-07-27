Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8C0765EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjG0WFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjG0WFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:05:32 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7876711B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690495529; x=1722031529;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y01L/Zl7NrdIlRx0JShEjkJuZFpjM3oduP2GwAmOF7E=;
  b=fGzi3sW56wEYNvayrR0nU32Xsb+Nze81Lw+qdxZyjEg0sIfG4UGuHs6e
   UqveDr8j/BBbLz2b0Bhey3d43YgSAz4eHsO6sCjHVTt9NuPMkDp2eg7vg
   D3xK+HTGYGP/l17aKyXZDsohT1lRcKKS2WdYFHTWG9psUW1nz1aiL2NY0
   7z+bC9uHxmat21vmBGKn4Ru+h1uzVyTQ+U/EgB7BGgxsUWmmcUdn9cZ9Z
   WVrK8Hp7r33P1MFmI65bF3Nk1aXT65bwd5wBuNWZaTdhWOlZqzVT9+pp1
   itnY0joJpRFa3U04lgTvgZXSLGbCDrf7Iyt0H92AlgiXrvWzHgnVjMdAJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="368460744"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="368460744"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 15:05:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="900996931"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="900996931"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 27 Jul 2023 15:05:28 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 15:05:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 15:05:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 15:05:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+H3gXlbpDyy5mqCxCC+Zfk1dchDx4friQVnHvFGpaKBa5Ukz95IzDM7dDwhO4g4JzfrbA1E6bJ/HNh0KBDqW6VdnIybNWX9SotRRc24kPUB1fih6RoB/lFQTfUYME/r/FswBSWgC3/F4KMyt3tC6hbWwniA+6hsdwbJGK8UVHdBExA7/l/FYVqV2YfGKQ9/T/PU0A1f9MwVc8N7c0GWvy9Ecv4H9/Gh9Bt5aFmCpL6ZGRn+wMr9SZFy1QxFB7ovPxrE8do9YfGkX4tDqk2/K+mbWdGj8xWo8f72rCPDTkiAm+w2E20B3zPNirD314I8r+TYbhR0OnXAv3bIMYnzqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eqrn3+LRpB0K6940ZGS46V9ahf6xkHraqeG/6reHMdU=;
 b=kdAFH+qpltoGYp8VC+oX4qtB3IVhQVll2iTtjHUzCTFfOmkENvWqse9ecTxdQY2/D6Zt/FPu64YYiQezOfdiZGcgP6QFy4zafopqRxqW7eSrLvZSBEa+UFzi2QtqqeXy8F0w2FukgOeWpJ6BjufyWKFlZPa5JdcvCfNeDGByTDNii4r0BFpYQoZDWGglWUCVUhh8p+IGe9IiY4YK1HL2PQhoJ0oDoQh01GAGsE6ELxCAQsVnWfXyCT4fvQVTfGk4+UC0WR9xvHN4TndxwqTSK+rhcHu5q1Xlf0fMTn6DMre04RpAe6Lz3Ld5GNcKOVHOmCzpaNn7CIpGh2XCvD+tVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by IA0PR11MB7694.namprd11.prod.outlook.com (2603:10b6:208:409::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 22:05:21 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2%2]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 22:05:21 +0000
Message-ID: <6ba4a23c-3b4b-eb7f-0ecb-3b7bf5c4406e@intel.com>
Date:   Thu, 27 Jul 2023 15:05:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] x86/APM: drop the duplicate APM_MINOR_DEV macro
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jiri Kosina <jikos@kernel.org>, <x86@kernel.org>
References: <20230726234910.14775-1-rdunlap@infradead.org>
 <c4410ce3-e38d-a935-0e5f-6773cdbfe11b@intel.com>
 <772ac95d-9eab-2090-245e-fcc40bd7a5da@infradead.org>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <772ac95d-9eab-2090-245e-fcc40bd7a5da@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::26) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|IA0PR11MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e6a137-32b7-4dc3-6d08-08db8eed9249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ACmBM8HNypJRS8cWJsM0qSpjVCqUr/gXn++mWAt4Y8l9dAaGqX92vE+tNJWht4WItOdDZa04tHxb64DVVPnWeLVDn9fMV7gQjJi4D7FqpAGwuCdtKK+Eup1KIzridbHa0mNdhq5Ql3fx6iJa/q55AsH8KOnkd8xCSbalvVzDzLnb1VjD4CrVFpWaUa/wj0S5xDyqvKP7mCgnPXgRlh/1Qx5ztAN35V/af2W+r4A4pwMKLpS7IcGJVzarBbVdayCbWS+dAFd3hIz8Lv2YMuI3bWnwU1U2yreoAfydB6eQQGl/pOc6nvlWiPLirJiWID8NfW/qfZN0TX/NMMXDDCaFnpjERw0ahQb6x3IZl8aGsIIOar2mwJFb9GAmntFn7XlTSuT8bE13JbomUO9MC3OtoXNthzI3rGUeCRIswLxMXrWLjDEVj4imuHjkjuB5/qPjEX+/GnCscRHLj7BFvNptcC1azES9uuw8+7+md0pWNjvTISIHcl2tHgXJTiYnNjC9W3c4VoeLyEKRxcr83U1zAk+fQmGCccybw7jEwKj+TD9JhkqH7VxcNVYLKzJd1OGxvpqcjVbTZd+zPO2/ikcdBid8LZyf8gij27IDTSFqkofpwUfxtNZrWN6NxxAzMNZiX5Jr7e9KaWRHPiGPB/Au1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199021)(31686004)(6486002)(6512007)(478600001)(31696002)(86362001)(36756003)(44832011)(26005)(316002)(2906002)(4744005)(53546011)(2616005)(6506007)(186003)(38100700002)(82960400001)(41300700001)(66946007)(4326008)(5660300002)(8936002)(8676002)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVF1MjZNNnBBdy9YSFB4ZkFXTHZWWFE5Ry83RUZ4L3MwaXRBcjhBdnZQa240?=
 =?utf-8?B?SWpFbDdocUlmRHBUaWxhS0x3N0hHWnJ5STdwQVhLSGhkZkIrdUNIZU8vQ1V4?=
 =?utf-8?B?eWdIVVk3R3BGQk0zL3JtSlFkVUVIMk5FcVp1VTdCM25KVXNJaHRVV3YycFM0?=
 =?utf-8?B?YUt1aHo5R2xmN0syWGFBZEZxMkZYNWV4MGJrNWlBVEwrMXlpOXJ2VGs4b2RB?=
 =?utf-8?B?ME9XclN0QTZBa2YyZ1FMVE5vcHFRZnpuMDBVNmNjUWlGd0FmeTlGeFJndmpE?=
 =?utf-8?B?dlJCNkZOUERHd0tuamJpSjZYRW05NG9FR3ovZjFCeFdqYTFmZmlSMTkwb21G?=
 =?utf-8?B?VnY5Y1JHbEZFWVc5bEoyRVRHLzZnYUltT3lYeVc0dVQzdmhGbEx0M2dBWS9j?=
 =?utf-8?B?c21Db3FGcUx5SVdLRG1JK0hDYXkzdjVCNzJ3RTNmY1BLWXE4SVIzdHdGR3Zu?=
 =?utf-8?B?WTFVQ3cxa0ZSanRzS2RhVkJRL3RDUVB2QkR4SWEvejR5cGExbG9FQXNOUU9k?=
 =?utf-8?B?L05QbjczdlFsakRKUHVwbWVqTmppVkVucTYxWEs5dEV1NGYrM2JqQWd1eHl4?=
 =?utf-8?B?Wk5nMXRPeXJPRlR6QU1DVU5Mdm5GZWV1UUZiWWZ5UGxRL1BVZ1lOd29OS1du?=
 =?utf-8?B?WjFMN1QzTHVnM1lXcktEY0FiVmxwVXVRMmdhSDg4QlozQWFFN1NNdFhUZFh2?=
 =?utf-8?B?UnNpaUhvRnVZdXhDRk5jVkg2NHZqdy9EekNLNENIMW9sNXJMNTRJT2dkTnRD?=
 =?utf-8?B?ekVpYmI0Y0c0bG9SdEozMm5lZW1pMVByMnNDV0grK3R4T3RyU0NoZndQVkov?=
 =?utf-8?B?RDBpSlJMTFYrWENXZ2FXR0VuVVBLSTdTcmxmRmN4V2I3cEtMckxKRUlSYXl6?=
 =?utf-8?B?QmFjZmwzSUhaNXdRSjVmb3FhNUw0cDY1VHBMQm9QNlZpeXA0QVVIUFRtWCs2?=
 =?utf-8?B?aDBtRTN4Q3puMGtVTUFmQzBQZ2hqc01qVVd3TE9xUXRNd3VwT1JtZmpzZ1V1?=
 =?utf-8?B?MWZzSGJkUG5ESzdVWUxMTVNzdUtoS0sxR2V4WDdYTG1NYUhUUzlLZFNiSVVY?=
 =?utf-8?B?ZFliNUJyRXkyY3doUmNhQ0k2ck5IWHREbGpwL2ppK1FxS0pSS0hqTGhwRWpL?=
 =?utf-8?B?QUhsM0xIcyszS1lZZkdqUS81TkxLdGhNbS92Z29abllZcUFTMkJRMWc5dlFX?=
 =?utf-8?B?eHpJSXdTV2dtTzJqYzJCYzVFVzkwVGVjLzM4S3pSaVRGY0ZHTDNYMDgrUkZx?=
 =?utf-8?B?ZDl2SVY4ZGtnM1A2VEd4aFc0d05seVQ3dVdvWWltd2Jrcng4SUN2dk1DR1RG?=
 =?utf-8?B?bDdkdmRSNzY1Z0MvaUVtRWRMQ1FRS05MTUtQVHhEY21IeEs5K0FxQTFzdU00?=
 =?utf-8?B?aWZSNzFkY2tvVXdFY0I5VkllZUlERGZPT1J6OXc3anU4RXJvT0tiNG01RnFV?=
 =?utf-8?B?Nnl6ckNBQzB1Z1JxRjJGUGJMNnNFWUpJUmV1NTlpZHBvVkNxcGNkRFE4a1pG?=
 =?utf-8?B?NnJjbVZNYXFRTTVGQndRbERjdGdTZkxoaFppSVRDL0FhemJBL3dIU1F0ZGoz?=
 =?utf-8?B?dkkwejMvSGpnU3hXRitMNDdNNjNKK2xyNUgzODQvczZxaERsVSt3MGlLSUhB?=
 =?utf-8?B?dUFJZ0lQblNaK0xmQnZFV1BDcjVvdEtzSHNvWEozMmdGcDF0bGNYa04vNHor?=
 =?utf-8?B?aXZ4TlNWazkxR2JHN2gvT1kwU1VaeHBYZ29tM09iQWNDYk1JamVWaDYzR0RY?=
 =?utf-8?B?RHExMjJnZklyakZzeU1hZWRvTS9kamJmakljZzRUTm1PdlYrQ0hHQkVJTFNt?=
 =?utf-8?B?ZXpkeXZKL09vYUMzQlB6MEJiNXlDbmRtTnpZUUtRMUxHUkRaNFpXR1RSVlVJ?=
 =?utf-8?B?RndLcHE5bUNETDE1YUtndWdjVUZRZkswVllFbVk4aGFKT3ZmQXk5Mk92aHBB?=
 =?utf-8?B?djZSMzhQMzVLcUNZRE41REk3Q0tSUmZiZXhNc09IUlBURnd6YnFGMjZzVm43?=
 =?utf-8?B?YmNuUDRxR2NJQXBqUmszcU1ybkZRSXR0Tmc5aE5HUWQrc1JwWUdwYUNjcW5a?=
 =?utf-8?B?WTNXMnpsc0xBcm9hejZ5SjlXbXErRmtlTWpYMW1NN3NKUDQybm9IVlFYemdo?=
 =?utf-8?Q?LIEDRIBe+j1Z4MRlBbYjajQpD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e6a137-32b7-4dc3-6d08-08db8eed9249
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 22:05:21.6742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1OhlHVllvFV6lJ4O4ZS4MK3ad7XhVclChs9mlvXmCFSOZWX4yXJgcdA+XRf8vUg7/elqLRO2mDplKCzDSdUBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7694
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/2023 2:21 PM, Randy Dunlap wrote:
> On 7/27/23 13:06, Sohil Mehta wrote:
>> I am not sure if a Fixes tag is really needed for a redundant macro
>> definition. If at all, shouldn't it be 874bcd00f520c ("apm-emulation:
>> move APM_MINOR_DEV to include/linux/miscdevice.h") ?
> 
> I don't see any need for this patch to be backported.
> 
> Should it be commit 874bcd00f520c?  Maybe. That one certainly
> missed moving this macro.
> 

Also, applying this patch anytime before 874bcd00f520c will cause a
compilation issue unless 874bcd00f520c is applied as well.

-Sohil

