Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F587B75FB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 02:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjJDAyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 20:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJDAyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 20:54:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9205BA9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 17:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696380855; x=1727916855;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=r5xsncod5QZg1MvIfoo3vI1a1nacjq70HTsgCMpKSSg=;
  b=Tvke970AFwiM67T+Ti2TyxjjQ717ispIqRoCiWIw1BdVUIG5irBTp1BN
   o8DCIk0qb2/PAj8fIsnvD5wrezXw9Trf4DiygDtrch8QE1h5MmCfKAe5u
   TdeMzZYVcS0EufpZYaGHdEpBf2aY8SupLOIDXyI8PZybe3gWrW+QY/gbz
   PqYUjdACzHwY3rnlpwVVk15eg4rCxZR8mQqXDjqHuHUVm5kJLCCZAfeFM
   2JXWFHGqSLygaqMvb6Eb10Eu5PF5+lohviLm3w6Om6XLsF1+dCVN8YRi5
   fwugWRMWnE8QHuxoMoaJFwQsq8dQSPOh1PLS2+ftyQX1PR6HgFIRxy3/r
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="373356221"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="373356221"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 17:54:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082246871"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="1082246871"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 17:54:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 17:54:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 17:54:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 17:54:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 17:54:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lo0EXqYmRE0mX1IpBRnJOa7d0Ar2r0HHk2q31i9j+88/FSMgGlJGImi/XWb3VDsnKk3SoAupG0tjQ/vIp5z1g5QvkIFFiyZYBQnMIncuA1L3uPZOPSVppFHWfMoZvpPN072Tvfeh9PV21lnCHtzjJduJ4L51+8w3vrtZNFFAJCHzuYXTfBMASB/iim0hWx+9vIx30kFJC0rAGAaBo005A3sVCLX56ZI7K0UScY9O4s8TrA3+EjOFuiJOfje82cnYdgn7a8wAjpl7xyhqWnGYPVEGNUydD+0RjYz7kgauQuGOzzTaeRy0ixBUZ0te/H5zTES5xR+GTu1v/nz+gKNxtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/CGLjljloiUXY2cCjikZsILOfK/SO6j3BB1lqJWD+I=;
 b=la8WeZ/fGZURG29Ir4U6OEMvmxmhycBhwBCCCIY79Hd24YdmkNbNmFlMQ3wHuOLNtQDFLwejkrWgbVuHAbNbwX19xIA+5LHR4tVIWO5UbHZIqgFf3qiOlxp8+SrA/Fjwxny/215MABeXx4y3H674WIR2lNJ6yNxES5TpegegAr/wJrUeRRaS5pwEldXtCDlsnSWEnvZfDF7e6Wy8D1Fmj4ZbJQD4yQkeF3UDfTL9KHy4tGqaYR810LdU28y/JAT5i7OotDndtwpzKi/a2QR2haXPDEf8UWirznCxynT54ZbawJGQ1+ntA8Qi/PTimT/RjnHKZJowzzNzj/mJ+IxLQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 00:54:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.024; Wed, 4 Oct 2023
 00:54:10 +0000
Date:   Tue, 3 Oct 2023 17:54:02 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Peter Gonda <pgonda@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <linux-coco@lists.linux.dev>, Erdem Aktas <erdemaktas@google.com>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 6/6] virt: tdx-guest: Add Quote generation support
 using TSM_REPORTS
Message-ID: <651cb7aa2ea48_ae7e7294a7@dwillia2-xfh.jf.intel.com.notmuch>
References: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
 <169570185411.596431.3153227201984845022.stgit@dwillia2-xfh.jf.intel.com>
 <CAMkAt6r2VPPMZ__SQfJse8qWsUyYW3AgYbOUVM0S_Vtk=KvkxQ@mail.gmail.com>
 <651602dc4c6e3_91c1e2947f@dwillia2-xfh.jf.intel.com.notmuch>
 <CAMkAt6rrzS85ZT9T7r6iwQHoVyEPwaxQ3Xayp_6XMbU+RJzS4w@mail.gmail.com>
 <CAMkAt6rwSwES_hEac=_7Gg8wcGosHMPXA3J2g_BGC_c+NbVp1w@mail.gmail.com>
 <9eee8abb-a1ba-46af-8317-0bc1c78179b3@linux.intel.com>
 <CAMkAt6odZAoQxNQ=HogTRB6dkmnK3t1Nr3+4SWpmAP-mqfqOiw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMkAt6odZAoQxNQ=HogTRB6dkmnK3t1Nr3+4SWpmAP-mqfqOiw@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0315.namprd04.prod.outlook.com
 (2603:10b6:303:82::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 543fa357-7ca2-48af-d3fa-08dbc4746bb0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cU4IGWAZqT9FE1dOF9eNgzKBPpJn6eWeWPpOgvvjgw+7XIDf1ddMwoEm/kwekiQ0ToF+8X8mi/zEL9Fy5w/uTx4ObvGhEGsLNnl4UJbDG9rOzSKV3EPfGVlFlEx6RKKgq2CWd39M+dbmh4zIKDtHkAvG9k9YELyKF1akAMmjsmu2TSRRBKHE2QoUxtXeN1u47yv3n8nUr7mUwg74MlNnFzgjzyHWvN106kxb67+YzuVALaFZygM6wKiWMfPJz8+zSgTSfaBO1/7AHh1tGeC9We+msfZZH5lmi/f68PsmDyETI5EmmJaoZ3mmTE8xfOpPIgRB+sLG8M/SS7xz1Fn0VEbFllUqwMyX2JafNp3dO7JQS0Zr1IWpxYsVzJLDUoLtwOhosx2ti8+jXbxLzgusR7YS0S02xnK99kENp39zL1a7G4558xLhFBYknrxzTZ0l81lfmIXvXeGUOESSX+quO663l+syRcd4Kh6txTUeaFr4QbUh1gpZ+grP1VfTsj6AACrAQ9oGhN0M78QyflWj7ZwA+t7d/nnjN28EvsDUbWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2906002)(8676002)(41300700001)(8936002)(4326008)(5660300002)(66476007)(316002)(110136005)(54906003)(86362001)(478600001)(6666004)(6506007)(53546011)(6512007)(9686003)(38100700002)(6486002)(66946007)(82960400001)(26005)(66556008)(83380400001)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTVZanM1MTdNUFFqVEhVcTNBYW9MVjAwTlVyZlR0MUorS2FpK1VJcjBOdVZw?=
 =?utf-8?B?ZnU0bkZDZVQvZU1hTFY0dkh2RnpoaG95dWtuMlZvMm1MeHQyZ3RlUWVXbFo2?=
 =?utf-8?B?eGxlQlFmRU5hcEU1ekFFRzdLdVB4MEpSRDZwbkZGVFVBQUU0YkVaTmxkZlZi?=
 =?utf-8?B?MEl1Y1Y1NXcxandLQThPcWMwYnVXalpEWXlHNTRWU3A2NWM0WFZad05HU2Mv?=
 =?utf-8?B?NUNlOWQ0M2VvYk9rUE5hNFdEcGkwRStVOGZVUjlRdTJNdDdycGJ3NGVkZ1N1?=
 =?utf-8?B?STV1QVkxVWp4b1RiVGthUnVPTVdqUVJCS1lGbTJLd3lBc1d2Nkd4bUpiMERK?=
 =?utf-8?B?VE9PUlBGeGQ0bEcrZkZoZmtrWjVSQkMrR0tEakd3cXJEU2NYeVczbjdjYUdl?=
 =?utf-8?B?N2Vyd2lTOWZXSTRlblMvRlhWYWN3cVlzY2R5aTZqUzFuM1IvMlplZ0JLdVRU?=
 =?utf-8?B?cWFBcFViZ2czU0Z4NVRmOEdQbXJjWEVnR3BXVHZ1M3o4YjJLczA5dVdPTkxi?=
 =?utf-8?B?bTdyM3ZGMVpqdDQ5NjBua0MrY3VPTmNVeU1SMlY1K3ZSYWk3NndRSjdVQmlp?=
 =?utf-8?B?cUZ1TWtYMW9hNmw1cmxYWVNVVmJiQmc2M3FoblUzZGRzVU81eGtqVmg3L09O?=
 =?utf-8?B?TlYwL2JXazRhcUwvSmtzbFVYd3c2Y005bStxSHBjK09OM0twYXY4YmJYaU9p?=
 =?utf-8?B?bmZWdysxdmZCdWhmRGhqYkYzR1hzUjhTa1ArQ3dLWVVwN1VWTjhrbDR6Kzh1?=
 =?utf-8?B?enp5aFEzSnY2WUtoOEJUQkxSZDUyVG44Rk1UQkNybVdRTHZESElwaW1DR1Nr?=
 =?utf-8?B?eGd1emtFN2NTL3lZeUhONHBXZkY5dTRIYkgxV3NlejNWd0VOTWJPVzEybHRC?=
 =?utf-8?B?a1F1bndsd201azAvU251RjNyRVNrR0JHck85WC9uampPSHdPQTFLbFVjUkhJ?=
 =?utf-8?B?a3pNU2dRdWFvSGdZTTdsclJkallLa3lFMWk5eG5jQ2gzMVN2UTd1MnNDVVJC?=
 =?utf-8?B?R1dSeGttcGxSM3hqTWkzN09YMWZBL05mYTlXeERUNjdpSERkVFhoTk9obzJJ?=
 =?utf-8?B?clpPaGxvRzN2WHI4cEZBQmlZcWtSRmJ3YUIvcnJFTGRGQ0hlOWc3cFpaUWFq?=
 =?utf-8?B?OHlQR3pHRGJzWEdFOUpzTmI3RTRYL2VpQUMwVEcvZUdtdGZaTEVJRU1iV3JS?=
 =?utf-8?B?TnpsZnZaS3FFZmZvSlpUKzRpL0pOT1ZrNGxIN1N3TmFSSXNacmE0dWd6U3RH?=
 =?utf-8?B?N1dKWDJFbEtlMVJXN0s0eVZpVG1Tam9KcDF2bk85cGRNckxPeDk4MCtvbEhy?=
 =?utf-8?B?dTlpTnhrK0dhcllEeXBUeTUyRTJFZWVYUHJLTy9mNFJaQzNlSS9XMm9vbVdn?=
 =?utf-8?B?U0s5L0ZlR0dEYXZrcEhyN3UzY0pqcUZmUDFXTlBPdjBRTkNROGs3emN5L1hZ?=
 =?utf-8?B?VlN2ejBvVHZseEJhZzZIUkl5MGhtbFNqNWZJUkVNYThQSWYzNnVVMjZhVnFR?=
 =?utf-8?B?OHpkd2lvQ2NzUjVXMlh1ck9CTXRVRnk3Z2dVc3NwZ2NRa2hRSEhiTDA0ZW9X?=
 =?utf-8?B?WkpFVXZwK0JWZHB6U2VlcGsvVDhCMjQvZG1jNWV6Z0VSVlU0NjJENjI5SjVi?=
 =?utf-8?B?ODhmRk1MU08rT3FXd2pReDBqYW1udVVzaDljVFRjUTUzQkExUFRFbkhab3Rv?=
 =?utf-8?B?bGhHdkFoUG1uR1h6K080YkFDdkNEakxtYmc4ZVlCeGl4K2xta0FHOXNXNzVQ?=
 =?utf-8?B?YkQ3cmYydDVuRWk3b1FoMFRiZnNxNGdoWXBHNVlidFc3YWZpQS9EaisycmZ5?=
 =?utf-8?B?OVR1SkxLbUNxUUNXdnJZb1JpamhQMTlNbzU3eTkvRmV2QThObHowV2Fsb2hO?=
 =?utf-8?B?Wnc0bU1pd3Y5OVZ3aTlGYTVrdmk0eGxJeGVVVlY3YUFGZGx6NkVVV29YZmk2?=
 =?utf-8?B?Q2pTcm1LWWRlKzF2SWM4OXF3K1N3WjB3VlYzc21xNU5Xb3BmNE1JTUVDZkRX?=
 =?utf-8?B?aWhiYmxvc2N6V2N3N1VZMEtOQWZmVzFTcG9GOHJBRk52Y243bUE1eWFVenI3?=
 =?utf-8?B?dEl0cnNJQU52Z21hVVlBMlA5aUEvTzEzT3ZKYlNFRVRTOGhZeVN0dkpGNUpt?=
 =?utf-8?B?a1lRaEN2eklmdE5pRG45OGR6NSswdHRJc2kvd1Z1Q1drdFk5MnEwaWF6WkhP?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 543fa357-7ca2-48af-d3fa-08dbc4746bb0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 00:54:10.9025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSVjKrReSbi9k6DdP3goGJqzo0XgjN/8cFklGO9dOUaRDKHpIhXcRf+NQWkfQnXap0Ch5eAHfEwf4kkKsmtSaBDaBXgUuXOAWKgiwUyCyXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7846
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Gonda wrote:
> On Tue, Oct 3, 2023 at 1:29 PM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >
> > Hi,
> >
> > On 10/3/2023 11:37 AM, Peter Gonda wrote:
> > > On Fri, Sep 29, 2023 at 11:26 AM Peter Gonda <pgonda@google.com> wrote:
> > >>
> > >> On Thu, Sep 28, 2023 at 4:49 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > >>>
> > >>> Peter Gonda wrote:
> > >>>> On Mon, Sep 25, 2023 at 10:17 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > >>>>>
> > >>>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > >>>>>
> > >>>>> In TDX guest, the attestation process is used to verify the TDX guest
> > >>>>> trustworthiness to other entities before provisioning secrets to the
> > >>>>> guest. The first step in the attestation process is TDREPORT
> > >>>>> generation, which involves getting the guest measurement data in the
> > >>>>> format of TDREPORT, which is further used to validate the authenticity
> > >>>>> of the TDX guest. TDREPORT by design is integrity-protected and can
> > >>>>> only be verified on the local machine.
> > >>>>>
> > >>>>> To support remote verification of the TDREPORT in a SGX-based
> > >>>>> attestation, the TDREPORT needs to be sent to the SGX Quoting Enclave
> > >>>>> (QE) to convert it to a remotely verifiable Quote. SGX QE by design can
> > >>>>> only run outside of the TDX guest (i.e. in a host process or in a
> > >>>>> normal VM) and guest can use communication channels like vsock or
> > >>>>> TCP/IP to send the TDREPORT to the QE. But for security concerns, the
> > >>>>> TDX guest may not support these communication channels. To handle such
> > >>>>> cases, TDX defines a GetQuote hypercall which can be used by the guest
> > >>>>> to request the host VMM to communicate with the SGX QE. More details
> > >>>>> about GetQuote hypercall can be found in TDX Guest-Host Communication
> > >>>>> Interface (GHCI) for Intel TDX 1.0, section titled
> > >>>>> "TDG.VP.VMCALL<GetQuote>".
> > >>>>>
> > >>>>> Trusted Security Module (TSM) [1] exposes a common ABI for Confidential
> > >>>>> Computing Guest platforms to get the measurement data via ConfigFS.
> > >>>>> Extend the TSM framework and add support to allow an attestation agent
> > >>>>> to get the TDX Quote data (included usage example below).
> > >>>>>
> > >>>>>   report=/sys/kernel/config/tsm/report/report0
> > >>>>>   mkdir $report
> > >>>>>   dd if=/dev/urandom bs=64 count=1 > $report/inblob
> > >>>>>   hexdump -C $report/outblob
> > >>>>>   rmdir $report
> > >>>>>
> > >>>>> GetQuote TDVMCALL requires TD guest pass a 4K aligned shared buffer
> > >>>>> with TDREPORT data as input, which is further used by the VMM to copy
> > >>>>> the TD Quote result after successful Quote generation. To create the
> > >>>>> shared buffer, allocate a large enough memory and mark it shared using
> > >>>>> set_memory_decrypted() in tdx_guest_init(). This buffer will be re-used
> > >>>>> for GetQuote requests in the TDX TSM handler.
> > >>>>>
> > >>>>> Although this method reserves a fixed chunk of memory for GetQuote
> > >>>>> requests, such one time allocation can help avoid memory fragmentation
> > >>>>> related allocation failures later in the uptime of the guest.
> > >>>>>
> > >>>>> Since the Quote generation process is not time-critical or frequently
> > >>>>> used, the current version uses a polling model for Quote requests and
> > >>>>> it also does not support parallel GetQuote requests.
> > >>>>>
> > >>>>> Link: https://lore.kernel.org/lkml/169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com/ [1]
> > >>>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > >>>>> Reviewed-by: Erdem Aktas <erdemaktas@google.com>
> > >>>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > >>>>
> > >>>> Hey Dan,
> > >>>>
> > >>>> I tried running your test commands on an SNP enabled guest. To build
> > >>>> the kernel I just checked out linus/master and applied your series. I
> > >>>> haven't done any debugging yet, so I will update with what I find.
> > >>>>
> > >>>> root@Ubuntu2004:~#   hexdump -C $report/outblob
> > >>>> [  219.871875] ------------[ cut here ]------------
> > >>>> [  219.876642] kernel BUG at include/linux/scatterlist.h:187!
> > >>>
> > >>> Ok, it does not like virtual address of one of the buffers, but my
> > >>> changes "should" not have affected that as get_ext_report() internally
> > >>> uses snp_dev->certs_data and snp_dev->response for bounce buffering the
> > >>> actual request / response memory. First test I want to try once I can
> > >>> get on an SNP system is compare this to the ioctl path just make sure
> > >>> that succeeds.
> > >>
> > >
> > > I think there may be an issue with CONFIG_DEBUG_SG. That was the
> > > warning we were getting in my above stack trace:
> > >
> > >> [  219.876642] kernel BUG at include/linux/scatterlist.h:187!
> > >
> > > This was for this line in enc_dec_message():
> > >
> > >         sg_set_buf(&src[1], src_buf, hdr->msg_sz);
> > >
> > > I am not sure why in sg_set_buf() virt_addr_valid() returns false for
> > > the address given in the sev_report_new() which is from the variable
> > > 'ext_req' which is stack allocated?
> > >
> > > static inline void sg_set_buf(struct scatterlist *sg, const void *buf,
> > >      unsigned int buflen)
> > > {
> > > #ifdef CONFIG_DEBUG_SG
> > >     BUG_ON(!virt_addr_valid(buf));
> > > #endif
> > >     sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
> > > }
> > >
> > > When I disable CONFIG_DEBUG_SG in my config. Your patch seems to work,
> > > well at least it doesn't crash the guest. I haven't checked if the
> > > report is valid yet.
> > >
> >
> > Dan, do you think it is related to not allocating direct mapped memory (using
> > kvalloc)?
> 
> But I think the issue is the stack allocated variable 'ext_req' here:
> 
> sev_report_new()
> +       void *buf __free(kvfree) = kvzalloc(size, GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       guard(mutex)(&snp_cmd_mutex);
> +       certs_address = buf + report_size;
> +       struct snp_ext_report_req ext_req = {
> +               .data = { .vmpl = desc->privlevel },
> +               .certs_address = (__u64)certs_address,
> +               .certs_len = ext_size,
> +       };
> +       memcpy(&ext_req.data.user_data, desc->inblob, desc->inblob_len);

If the failure is coming from:

	sg_set_buf(&src[1], src_buf, hdr->msg_sz);

...then that is always coming from the stack as get_ext_report()
internally copies either from the user ioctl() address or the kernel
stack into the local stack copy in both cases:

get_ext_report(...)
	...
	struct snp_ext_report_req req;
	...
        if (copy_from_sockptr(&req, io->req_data, sizeof(req)))
                return -EFAULT;
	...
        ret = handle_guest_request(..., &req.data, ...);

...where that "&req.data" always becomes the @src_buf argument to
enc_dec_message(). So while I do understand why sg_set_buf() is
complaining, I don't understand why it is not *always* complaining,
regardless of configfs-tsm or ioctl() with CONFIG_DEBUG_SG=y builds.

I will be able to dig deeper once I can test on hardware, but I am
thinking that the entire scheme to pass the source buffer on the kernel
stack is broken and is only happening to work because there are no
crypto-accelerators attached that require that the virtual addresses be
virt_addr_valid() for a later dma_map_sg() event.

...or my eyes are overlooking how the ioctl() path is succeeding.
