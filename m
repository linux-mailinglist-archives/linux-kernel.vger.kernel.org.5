Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954B877D18E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbjHOSNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238852AbjHOSNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:13:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4F910DA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692123201; x=1723659201;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=LG378rtZhcT+PZfjFiBLW4nr/7U6t9GCpenPsBKiAA8=;
  b=JNXucIH9+bf4CXSKakz3Y+cfN5tIirUm6hUL6oF/OLYRLEFnoK3ERbbM
   CUO9f/u0Iv+GYbAnfwm5dxwLATUjk6UpjrG3HwIZwd8qIvvoAtVDrlV7v
   jVCzfu0xJBV5K701qWxfYmtZCB3Fp59Fgu9VRFYcDAVGh7TqxFvmxri67
   z0xTtOkxLPXBuipg4CBeRwX9UJaQ2MEFAMzRFa0Ri111CuS0o94MZ5NgN
   YQEiYktlanmDxtQpIAuiypELC30mK/OTd+LGBWtr55Y0uHqP180ekAQQi
   1Fhb8M4sfBOeJLNGVK0KWLOf+noWXis43o58WFArDYQEvqdU9OqOFYxTS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372344665"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="372344665"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 11:13:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="907709563"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="907709563"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 15 Aug 2023 11:13:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 11:13:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 11:13:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 11:13:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 11:13:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3VSeCzxOFMS8i/zd29EXkI5qfBkPlv7EpOBmR7Zn8pB2dBapDsjyem0g2f0kbuDiT/4ScjQeLivTDDxvm7CsR/bL9EEp+tA2kvfwkz9vTT1RuCBDLf9YQHluEw5Ldc62TKGtMpLDPy9SFt81Aw1zP5RByxG8Z97duY2TXdEAcilbdFYeNOFm5HuKKJHpaPky2tetbfEgs/UY1wYsl+CpCuKSQfNQcLSJHxsRdtsoslcHw6RG6o7mvoOwKP3aVkH/J/8/P/PfRHMYDAZ7NcXjtEc+BHLBG1IUKCm5A6yWYblUBOOcmonOHpyYC1Iw1jboqe/L9xP+BNhd0mWm/pfXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WH5nZtlLMWtdIfR2/jtuirdzo+O8HV3xgu5/4k6Dds=;
 b=XFbkfDGfS2eaRfhr9xtIi3G+vogWJYfCTKDhypT4LUIxDOOJchMM+jEu99al6riRh4oFKjpMGyR/Qu+E+f5o8LX1O8EmwJyAktkGmEfaZlF1bDvpAXmb0z2L8Pd53Bs2OSS1B9hx7oyG+4XxbCeQtrG+ewPySbLyru5F6ZD3I/GP4vK6ZB4QnJjsEOCZ3IR7OyUUw+q2rq0ws7OLVT1P94OaQLJ1SxC1/s3NJKopAzkXEz5bHAKQm12oSuyOIGudadfT27auqgyVCjNS7HQz0cfEYwvZiXZjuO2B6B4kUQY6ej+3K6E227aS8KGYqHYt/URf7tKzri52qCxpEiBQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6188.namprd11.prod.outlook.com (2603:10b6:930:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 18:13:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 18:13:17 +0000
Date:   Tue, 15 Aug 2023 11:13:13 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Peter Gonda <pgonda@google.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        <linux-coco@lists.linux.dev>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "Dionna Amalie Glaze" <dionnaglaze@google.com>,
        Samuel Ortiz <sameo@rivosinc.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] tsm: Attestation Report ABI
Message-ID: <64dbc039c08b0_28996294ce@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <57f3a05e-8fcd-4656-beea-56bb8365ae64@linux.microsoft.com>
 <64da606b171cc_2138e29484@dwillia2-xfh.jf.intel.com.notmuch>
 <CAMkAt6q1ZedWBQ+ZLmD5QRKc0jcz2nrdwEAw6g8R2fZ5e2ed_A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMkAt6q1ZedWBQ+ZLmD5QRKc0jcz2nrdwEAw6g8R2fZ5e2ed_A@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:303:83::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: 739806ce-3e33-470e-8f3c-08db9dbb4cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0/DOlVgEm/5S95L+Ictxr1rSkg71G2DglnqFaG/216wJpye062j3fKyRPQY8JGg8+TclfaFZDETL6MwHRffIHFTuvukHl4JqYEbj8tRp92QxJrwhOo69t7SPTgT43Ci3ddT/0GwnCfMQnw5Pa01XEJyh2CNMQ574vMbtf3u+My2HONS/6II+ZwH4XvK5wHvNfMh+R86HYLwUnwtl0O77K8SXpTfX4xpjsYeoVpDUuPfH0yINxs6aNB+g/UcAX/iAfGqLvpWPMojtwo2+m0jiRQ43thBvGLr91OcLBhbOz9gUoLAs+RX0IpsCZ2ESLUqQU74dS37gtu5/fLmH4fhy6eWV9B11LCbhEffxISEjxuSas+VYAkg/ZpS6QEz+uE5Yq4Fu5cf13GTJQl8cgOkljCdZzCdgdyFXlCVsiIBoGD6wIsnHfX59diuGl99j3p5uXsJu1GT5+3kIGvWZPwAxZ7Sn2SEPm6ZUjKN+F1Vo7GTj9dp9QHWl9AQpDKK4nLVF8QevpQ7nPlKdbYWbJ7GGwS6n0SXO5N4NgTOZ/PSGzFmBlQzZERQNtpBT7N1MRVN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199024)(1800799009)(186009)(4326008)(66476007)(86362001)(66556008)(66946007)(6486002)(7416002)(53546011)(316002)(8676002)(9686003)(6512007)(478600001)(26005)(6506007)(83380400001)(5660300002)(2906002)(38100700002)(54906003)(82960400001)(110136005)(41300700001)(8936002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2NiN1lvNnU4NnR0d2VJeVdFWXR3ZzFRWm5SMzh5cDMveW9pWUlzTGw0Z2h0?=
 =?utf-8?B?a0E4cnJ1Z0U0OVRybTZSVGtEazJSWHllY1FlMkNoMGdhdzZBSm56aHVpZUhT?=
 =?utf-8?B?dCtVYUlRVVZpOTdDcWQ2cFFtc3BTcE9VeWF4U0tQMnlPdklZYXoyWElTeDBt?=
 =?utf-8?B?ZDNXMWhJYUY1SW10a2E1dzlDR0lDOWxyc2J5OGc2dThiTytBSDVuUmR6NXVV?=
 =?utf-8?B?eUF0MUlWNytpT2hyRGQ0VEJJNFEvWDdOSjNrWUZVMVYvRjgxL0MxaHdWUUtF?=
 =?utf-8?B?TjdxQVFwNmFsQWFBbVJhNjZ6dm1oQnoxR2NqWEhuS1NPdU01RG5mMkVtelVV?=
 =?utf-8?B?ZEM4dDRTNWYrTVhDL2QyUVJzek43c0t1NmlmTExFV25PcjVPbjNSUUJVSU9t?=
 =?utf-8?B?aDVvcjRwbG5RQ2VEN0JhRGpHTGl1cVhobm0ycWhlRXRCcUpGTFVYL1pFUEJU?=
 =?utf-8?B?U1NOcHhpVFQxVkRhcXpuOWY1QVhEVFBoTk45OWFJMG5tVWJQbXBsdFpSekpm?=
 =?utf-8?B?L1dPODNUTEI5UTBTUkNYK2FuNTcrM2RaQUZrU1F1QTFKdnFPcEw1UW9qUHM3?=
 =?utf-8?B?NWx4dlQ0dmgxVndaVlc2L0FlTmk3ZFZsLzhTRzBZK2pTSU1RK3drS0lIVjBW?=
 =?utf-8?B?MFBJMjF6NHlOYmZyWlY1cmx4ZEJuT0dIdEdvcHFvZFlpMjVKaEd6L2lNL293?=
 =?utf-8?B?YUQwM3plZTkvcXJLTUMzaElxQUM1TmhaNVJCMit3NysrTnhUZStpdUVvSWNT?=
 =?utf-8?B?RnV3ekZqRFRscFZxaTZ4UGFhbWQzZnI5d1FXNTBsNW9UQ0o3Wm94VS9JM29I?=
 =?utf-8?B?bHNpd2IxRjVKa0xEeCtsWFhCVmNHYnRDUlpQUlArZU5PM0tmeG1nUHFpcTZq?=
 =?utf-8?B?eVdnZmRLRkppTlV0MlBYcElXeWs2SUs5N1R0YnpMMG14U3BUeUlhQXNFK0lT?=
 =?utf-8?B?ZWpPbFhXSUltalE2Y1N6dDZQaUI0aUgzYkMrb2xUb0lEMDF0bG5vbWUyMU43?=
 =?utf-8?B?MWd3MENxK0ZWQmViQkZFSXhWNzJydFJNUHVSRW1KdEsydGJDYys4L012bDd0?=
 =?utf-8?B?RG4rTEpvMHY3dk5Jb1RJQ3FKbkl1S2RwYUFsNHZkNGtmOUM2eDNyd1B5dVJI?=
 =?utf-8?B?aktRZnNQeEdrTzJpbzZnMEQ0RHkzeHo2Zk9YaWlrcURPVmdOaVNqdmR4WWla?=
 =?utf-8?B?eHlSTnZORWduS0F0VXpWRkdyeFBYMlhEcWVKNkpUa0VMejMyVUQ0NmZ1WnVK?=
 =?utf-8?B?TGRSdUcwMkNtd1huQjRET2tNQnBndUhpWkh0RXRnMXh0eHkyWmV1cmZIQVo4?=
 =?utf-8?B?VmlVQklubnVlUnJMelhkZUFSWjl2YVhNV1k1cjNMRVlBb3h2dXNmM0xHaGZ0?=
 =?utf-8?B?cG41cWtQM2MxeGc0by9MNDRhMlB6Mjd3cnFtTjN1bmZ0SERwLzdYejYvYTJP?=
 =?utf-8?B?R3p6L0xGRHc0c25mbTdIelRlakFqeTNPWWE1TTkxbUg3K3M4Z2VFUy9xbVRa?=
 =?utf-8?B?VUNWTkNINncvcC9XK1dxdEpJNWxyRmNCUEppQm92QnZXUFdPVS9aYThrOU5I?=
 =?utf-8?B?NCtYNWZwTnpEdFpsYUtRVTNTdjBPM2N6YjRpemxzMERBQ2l6emtmOFpJNzdv?=
 =?utf-8?B?dkVHMWVVNGJNUTNKeVhBVmJOenpiRnJ5ZXIxbVNvMFhpM0RMaXNCMXV1Njdl?=
 =?utf-8?B?bUJnbXgzR2pDakdVREQvc3pwelR3WHMrazVZUGJKOWZobEFLaGM4NzJFd1N1?=
 =?utf-8?B?a2NkOEdta21IOWtMQWRDV0ZndFd1Z0ZiY2U2K2duK2NDaUZkUVBpRUtqQWxX?=
 =?utf-8?B?YlJhMjhoUXZ2M041SU9nRGpOdk91dXJhQWIyTlNyQ3BhTStaR1pqOEZRVVlz?=
 =?utf-8?B?VDNRVXdTR2VOY1FrTXJOd1RzVHVKdVczbU5uK2FQTDEzVmRqeFhwWUVUQW0z?=
 =?utf-8?B?ZE45Q2hETm44d0NjUTJVOGZKaFNuclUza2pjZmxoWlRMLzE5a202akJKS0F0?=
 =?utf-8?B?bktUelFaVHNHbGNYeU81SlZ6b3VwUGhSMjhCU0NCTTBGcXFDWFNPY3BtdmM0?=
 =?utf-8?B?a281eFRrdDFHOU5ua3FsdFZ0NThMaGhYOU9abzdtaHB6YW9Pa3FNeW1zdzV5?=
 =?utf-8?B?UDhjU1RGM2MyM05peldLU2VRWCtBalh5b1JUYXBPSWhqY1krTkk0UjV6K2NP?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 739806ce-3e33-470e-8f3c-08db9dbb4cd3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 18:13:17.7779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEMxiPoSfgRNwcxFfaMi3wuxAp8KvmThVX1JebCvpAZnjBSNQH/WEOVW3WZU5stjhIGJIuITqq5P1elRL0BLKvOT4vwKvd6+dH7aJGnXv84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6188
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Gonda wrote:
> On Mon, Aug 14, 2023 at 11:12 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Jeremi Piotrowski wrote:
> > > On 8/14/2023 9:43 AM, Dan Williams wrote:
> > > > Changes since v1:
> > > > - Switch from Keyring to sysfs (James)
> > > >
> > > > An attestation report is signed evidence of how a Trusted Virtual
> > > > Machine (TVM) was launched and its current state. A verifying party uses
> > > > the report to make judgements of the confidentiality and integrity of
> > > > that execution environment. Upon successful attestation the verifying
> > > > party may, for example, proceed to deploy secrets to the TVM to carry
> > > > out a workload. Multiple confidential computing platforms share this
> > > > similar flow.
> > > >
> > > > The approach of adding adding new char devs and new ioctls, for what
> > > > amounts to the same logical functionality with minor formatting
> > > > differences across vendors [1], is untenable. Common concepts and the
> > > > community benefit from common infrastructure.
> > > >
> > > > Use sysfs for this facility for maintainability compared to ioctl(). The
> > > > expectation is that this interface is a boot time, configure once, get
> > > > report, and done flow. I.e. not something that receives ongoing
> > > > transactions at runtime. However, runtime retrieval is not precluded and
> > > > a mechanism to detect potential configuration conflicts from
> > > > multiple-threads using this interface is included.
> > > >
> > >
> > > I wanted to speak up to say that this does not align with the needs we have
> > > in the Confidential Containers project. We want to be able to perform attestation
> > > not just once during boot but during the lifecycle of the confidential VM. We
> > > may need to fetch a fresh attestation report from a trusted agent but also from
> > > arbitrary applications running in containers.
> > >
> > > The trusted agent might need attestation when launching a new container from an
> > > encrypted container image or when a new secret is being added to the VM - both
> > > of these events may happen at any time (also when containerized applications
> > > are already executing).
> > >
> > > Container applications have their own uses for attestation, such as when they need
> > > to fetch keys required to decrypt payloads. We also have things like performing
> > > attestation when establishing a TLS or ssh connection to provide an attested e2e
> > > encrypted communication channel.
> >
> > ...and you expect that the boot time attestation becomes invalidated
> > later at run time such that ongoing round trips to the TSM are needed? I
> > am looking at "Table 21. ATTESTATION_REPORT Structure" for example and
> > not seeing data there that changes from one request to the next. Runtime
> > validation likely looks more like the vTPM use case with PCRs. That will
> > leverage the existing / common TPM ABI.
> 
> I thought we were dropping the TSM acronym as requested by Jarkko?

I read that in the context of the key-type name. The key-type proposal
was dropped.

> Why do we need to be so prescriptive about "boot time" vs "runtime"
> attestations? A user may wish to attest to several requests as Jeremi
> notes. And why should users be forced into using a vTPM interface if
> their usecase doesn't require all the features and complexity of a
> vTPM?

When I said "like vTPM" I did not mean to infer "only vTPM". There are
three scenarios base attestation reports, attestation reports with
runtime measurement values, and vTPM. This patchset is only about the
first scenario.

RTMRs have similarities with PCRs, does that mean they need to be
intergrated behind the existing TPM ABI or deserve something new? That
is a question that the RTMR enabling effort will need to answer.

> Some users may prefer less overall code within their Trusted
> Computer Base (TCB) and a TPM emulate is a significant code base.

Yes.

> It seems like you are just reading the SNP spec,

Nope, fully aware of the TDX spec. This patchset is around wrapping the
existing sev-guest capability with a shared ABI for the TDX equivalen.

> if you read the TDX
> spec you'll see there are RTMRs which can be extended with new data.
> This leads to a different data in the attestation. Similar there are
> REMs in the ARM CCA spec.

Again, RTMRs are not part of this current proposal.
