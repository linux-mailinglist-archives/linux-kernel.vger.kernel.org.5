Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A07788302
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbjHYJHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244140AbjHYJGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:06:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAB926A9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 02:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692954381; x=1724490381;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=iZYFs9zAyX48VF30PaH95kx28sGb1w8fbVBj5OTZOtI=;
  b=EwtRBgcMzrtKToJkAbWomMY0Pzz7wmmugxoKgJ7ACGQdAUPhqEMRK37F
   kSrqox1auYV5EpKPwaLZQ2ynstt9rMEE8Wv0YO9yuu0l8TYbafnB9789k
   h7PE4yJGZLGeJny3xMlFaenWEC17RKf4umYr6Oy8s9vuVVt7Hp85IW5BP
   9bfwgYKVDMNIAIcvCe4E5NCAA8zPMgs9eM0oZpVUtpTN+cmGp/kq8HN1j
   Kp2lrbrsCRaOX510BO5PsY34w1YlF79/XiB1s7OYGNgxT9+f1T7Kftmx1
   MWjeFioiPfy6h5Fx9MJMfaRcRP/bcVwnv8zS6SnuXC/upYon4wmryLcU9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="438610149"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="438610149"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 02:05:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="737412104"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="737412104"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 25 Aug 2023 02:05:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 02:05:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 02:05:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 02:05:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3OLTv/X31jAwbjwU/t6JZHx7ceQYySMxmPZZNfOMA+pJB1RnqXQWe1FUgi2asmZTeBe4kUuQZR84t/9nkJWOeKGtDb1Rn4ccjHioqz3hDaw278KyWQTSqGlcxoCQXCuq/Fw2DKJGoXPzfQBrf+7YtPEqM8gwWxFZzL3eLQlFZK5GO9PAIfwRe68fLv6LmNhBabJDLRkdwzfHr58CbBcca/A4ylNCSJ3P31D7/sDjGXtBW5P+q2SGGO8LmyxoGo2esrMBZeZhcWty6cnUnBnwWsdIZfHb42utR4L2qgnaY8s3qJk47AcPyvQPabQ7e8r8V2CSFVtg10661N8Mx6Lbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjbXoOGXntDwAImnmRdK0nu5aE8Ded99Gug6TL2ijBE=;
 b=juPTeB//n0korrD/ycljqpeSrl1bTZRy6qhjCELth0we7FpozzevZ6VudD4IDV8P/dGud4APWzU0OKtPlJqtIlo00WDcdXcyaIsF7LUu5lhQJzNwqE3kyPE9tepoKOla+46Br7I0XQYq8zePT3GGRCcb5RNXVtAXHLzK1g4dSkYz3jf/bHVGq0k++bostFPErVsb273WG9kRoWC3apkhu0WhvMlb9iPiDMKvPb1rVSypsqctG0ayHT9R7nBPV4eNt3TrEeXWEwfOGnZqr2hFZ2TAvMwr1xYTa9KGWg/TTqwukOGVZZT4hg5WS9JPRH5NBYVoUn4Bz50BJDvq0NvPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH0PR11MB7165.namprd11.prod.outlook.com (2603:10b6:510:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 09:05:35 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 09:05:35 +0000
Date:   Fri, 25 Aug 2023 11:05:26 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        <fenghua.yu@intel.com>
Subject: Re: [PATCH 3/3] selftests: Add printf attribute to ksefltest prints
Message-ID: <nvkf4tyi4kmsnlzcpfcercvjsmsibol6wbfzrginmzioyflwux@ttbzh3hqqatx>
References: <cover.1692880423.git.maciej.wieczor-retman@intel.com>
 <9adfc58deb5c7df43f6a8701d4e15821f4c42dc7.1692880423.git.maciej.wieczor-retman@intel.com>
 <a93a4f17-73c7-cf6a-e44f-78ece1e25e93@linux.intel.com>
 <elcfjzpnxfeyum2t6w6nwu2mtfbgvnabypqmzw5p6f7g5rpr7p@74rg7ziipg7j>
 <0f5533a-92db-b462-f7bf-14a8d595baa1@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f5533a-92db-b462-f7bf-14a8d595baa1@linux.intel.com>
X-ClientProxiedBy: FR3P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::13) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH0PR11MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 629a067c-9247-46a9-1b77-08dba54a7196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RfBY4iX4ANOgp7mpbTDTls/fXjXVr00SYJ9CHIurtageD1Z1S4bHr0Ur5x3+3SnEZTSj8dOuSpZ2XcGNemcPKo5lSbk3K99kUBe2VexL887b6lt6eFQIm4dmmJaHE5PEJsf1hk8PMkqekvQ20NABXXhroDAw7tn8u7oV8We41LU4rwUjAbmox771QpwS0UmWAnCkjOUGy0EfPH1QAB4kVP7SNb63+9TDjlEdiU/x+MfDs5nGVnWVuVHq4Ik5ih/5Cj+ZImNuNfpLCBAuvP2mw8piJl8GciKIGw+IJ95vN/hVzG6XIOFTbPEWF5yytMkfUOCfsrwVRw9w+e3ULH7cnPwR/89b9m8ARrVihXrmDme0+6I0FABDc7faCZ38uHEeUJsxnnFo5jIRxUKqYiRXAf1T8s9oNpIAzqrNhQLcO3ZEWZjwkt8vIW+/y8zm41MVeuITtrr7sbHKKXo+OSiQ5blZv3W6mcgL4lt0S2BdfdHgdBDEZN87VomebJeFL+erUXDWVGKodigzGRtNfQ2twTtpWjhyiEoglriMTnbL2/x2VI3GIqcrCMO6Lxyb6oKm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(39860400002)(346002)(136003)(366004)(1800799009)(186009)(451199024)(5660300002)(4326008)(8676002)(8936002)(66574015)(83380400001)(26005)(6666004)(38100700002)(82960400001)(66476007)(66556008)(54906003)(33716001)(66946007)(6916009)(316002)(478600001)(9686003)(53546011)(41300700001)(6512007)(2906002)(6506007)(86362001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?YnRTbv57p9L4QVPoF32SvRhOQ4yktIw/PXyxXxywNutOHCvjZgqC3F09O8?=
 =?iso-8859-1?Q?L0KSBqSsImCoHu7oObmNTb2juUDrHhSdWiCtnZr0NJKseizKmmUyTdEPes?=
 =?iso-8859-1?Q?k40AayNt08/Kr4mToodzzuR0MqUe5O0sSn9MZtz6bRA3915V00TCv6tdKZ?=
 =?iso-8859-1?Q?oSyR7w2rycZRJNfxmIdiBxeCxIm6FuUgexdINcDoA2eVnSbaw59+Y2Yk8V?=
 =?iso-8859-1?Q?etT/bNsfkDSVTxeviZvar4VZ2spyMkE1h3ZHBTEdVvj3iB4UyAtFd9nZB+?=
 =?iso-8859-1?Q?/lZZA0UfkI6814VEBrrkIgsJYBghGCiXLkgIH+7NqxtO/s46TpO5txvKu9?=
 =?iso-8859-1?Q?1gMafguD+YUJRSApl0DQfv9DRg43kcQDKT2N3um7PItCC64GG7wqfBMEI1?=
 =?iso-8859-1?Q?wm/VCKRoV1Yet+RWO9K/10z4PlhGdKhP2I4Sb/VlUkqxM45yFxZkw1ojj+?=
 =?iso-8859-1?Q?Br+6Mr8H3GDKd6z1/oEl2BceZeRE9p7VBXxk9jEWpL5XtsjVennkOfrR0g?=
 =?iso-8859-1?Q?0IklulG/HE8T8sYaxMJj5hZ0N3bPVg2w567yUKn+dmElvoVof6jKB00ZRl?=
 =?iso-8859-1?Q?9ZDvU3cmLQE8bitXapb5ytAniffBPHbAcM1PL82r9eWTNazqHQLdLjCw3Z?=
 =?iso-8859-1?Q?h4T+9n7qsIzIRJWvKdEmgLAWFyOsln5lQk3v/7gTPHWES+TDUa75aPbahJ?=
 =?iso-8859-1?Q?fNKRXw9Oi2GIwKPaUIX7TfIGYJtvrqPihEOdq91IlLS9/0o06koJCv/MRN?=
 =?iso-8859-1?Q?23vUtBxGvMWP/wMjnJJYjpOxGB6gxvXOQBh8k2fH6QMGc8Hxnu+iFFDm5a?=
 =?iso-8859-1?Q?w091WpjMHexL+CnDHfwDhM+Uqz5hj2J0PDa1Ac3qDkXEIjjlQCgL2QtPrD?=
 =?iso-8859-1?Q?kHJyxdzHXtyDvz6PBefoQlMZv7YCSAm5FjKPIOp/rjFZTQUVtrQNopLOr/?=
 =?iso-8859-1?Q?QkrZZ+U7dXzZ2paXt2s+hEv69vi2pdKua7Bk6/cR2/mXwrcLyXw4oznqpP?=
 =?iso-8859-1?Q?oaEPyus9eZ6mn4b6MPFwPDR14xXCOluH3Ahx5MOKoLSyqVYFzx1EnGi/40?=
 =?iso-8859-1?Q?Iq3GR6aww1zqe91aaUxoMcLXNyAbvxPqYXf+liPx9Xu9mPSxIHN3cFEjTY?=
 =?iso-8859-1?Q?U4iyYxDYhI9S8plHg2vTeSPfXoZZNS4yNxmm1Z8viJNVNjbYrmMXQZH48X?=
 =?iso-8859-1?Q?PzvQpmk3O8hyreIk/5JHbbVdqvZrCCyJDJDIxulhscxqVzNrQZA3qqC2ro?=
 =?iso-8859-1?Q?ufl6Ihi5akGBb+FpNi91M8NCDnVkj90kgB0Jf55Tfkb6Df8aY48lWqHY1t?=
 =?iso-8859-1?Q?mLlgtWf384NkYwNE6Oseg42rQ59UBWWzWSpJ1GSGsrLVzQs5JzcmnhCbKN?=
 =?iso-8859-1?Q?r/7W9Hsrh19ai/Cjxe7g+K27pGjgidY+OQZHO09KBZucbWbxp2g5f4aInK?=
 =?iso-8859-1?Q?96zvCJwSQg1XQizn+BdbQyfwJz8WoxLO3hzVzdp0sOA5niko6Xy11lobuJ?=
 =?iso-8859-1?Q?8VRVIJOnN7ddzLJN46+5JAFSLmm0O7AT95nuakBbC7WegfH7pkB7aX7RJj?=
 =?iso-8859-1?Q?HT2JUpHk28eLWpeU/arlbD+UoSg3JYG8zz3CPGZsmG5cRJxDQJkd2IiFWC?=
 =?iso-8859-1?Q?UT8CxWLSREj9nS4O1p6ziBVegInDhyFQ/a3f0wJ3OvPmv4jat8aOS7riyy?=
 =?iso-8859-1?Q?f3NMNNW4FcS6waRVYWE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 629a067c-9247-46a9-1b77-08dba54a7196
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 09:05:35.6133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7Eataw9JXTvDlHRZveWY2gYz/8Q3DDVjffVifqhx7/UqmnGmGaL1ikR4UYYXu2jRbxV9ruI21BXHgQ1ODoILIVxZ+hvrXUwbQiX4jUdB28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7165
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-25 at 11:28:17 +0300, Ilpo Järvinen wrote:
>On Fri, 25 Aug 2023, Maciej Wieczór-Retman wrote:
>> On 2023-08-24 at 16:10:12 +0300, Ilpo Järvinen wrote:
>> >On Thu, 24 Aug 2023, Wieczor-Retman, Maciej wrote:
>> >
>> >> Kselftest header defines multiple variadic function that use printf
>> >> along with other logic
>> >> 
>> >> There is no format checking for the variadic functions that use
>> >> printing inside kselftest.h. Because of this the compiler won't
>> >> be able to catch instances of mismatched print formats and debugging
>> >> tests might be more difficult
>> >> 
>> >> Add the common __printf attribute macro to kselftest.h
>> >> 
>> >> Add __printf attribute to every function using formatted printing with
>> >> variadic arguments
>> >
>> >Please add . to terminate the sentences.
>> 
>> Thanks, I'll fix it in the next version
>> 
>> >The patch looks fine:
>> >Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> >
>> >...However, there are formatting errors it found yet to fix.
>> 
>> I believe you mean cache.c#L297.
>> 
>> I think I saw you're preparing some patches that remove the line that
>> reports the formatting error so I chose to not correct here.
>> 
>> Please let me know if I still should change it or would that be
>> redundant.
>
>There are other selftests besides resctrl which had a few warnings.
>
>Making the selftests to rebuild though might be a bit tricky (you won't 
>see the warnings otherwise), I don't know the command needed to clean 
>selftests but I guess one can always force their timestamps to force 
>recompile with:
>  git ls-files tools/testing/selftests | xargs touch

Okay, I think I counted 13 more caused by the __printf().
I just ran:
	$ make -C tools/testing/selftests
and to rerun it later:
	$ make -C tools/testing/selftests clean

But do you think all these fixes fit into this series?
Is so, should I put them in a separate patch or just append to this one?

-- 
Kind regards
Maciej Wieczór-Retman
