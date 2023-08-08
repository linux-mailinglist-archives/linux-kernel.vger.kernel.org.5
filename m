Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF13E77413D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjHHRRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjHHRQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:16:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C031D467;
        Tue,  8 Aug 2023 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510809; x=1723046809;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=goiF9E4Lu4oqBmFj/6fXNmdoB22cdSSvwENBMcCs8Es=;
  b=hDabsary8pCrx52diN51t5/Anfv2rRt5aYa5I4xHvKgZsGx0lBnjXx0B
   hmr3Jr1OylJ5l2Dt4bFuxF6zjjj3BPvi+St+ohMDCK9iDsDSz0SvTa0aG
   9/BO1/4/nCmRcjrJofh3fFrqx18srGlKctnK9+G9p6lXJyvfv+/Zug8Fz
   C7I8f6+0rGLq4+69j0QWELzqe8RogNKw4PbB/IqRrDdF5PVo+soSF4oEt
   V1zQIxtia+kKcacFMEQ47GuRaOMovb16BtF4NgHEmvBfv+M16udYl+Coc
   8Fgkq35r9ExOMmt2H5Ta0zoPO6GvyRWO4ZoXqCBxvr+aAf6k0gVp//xvf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="368318204"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="368318204"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 08:49:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="855131360"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="855131360"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 08 Aug 2023 08:49:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 08:48:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 08:48:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 08:48:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUIpYbjXRmXYSnRvGXSu7yENT1USC8yC8/6eaJvQG4sU8tnQocnWOInvU0e2mc/2HR9DhrRrvJMxKae/2QdxyvI/AU3oS4gU4SAnWy4MUYAgEsDHQgJzfrYodayBapq15R93hfzX+4slfhEiILkZ+AljLSKhuOQXyOHDXdkumQNyAPfNprZOcL+dT8OWWN/KPVgMJay1nwPjexhz51xsLJK8vRrwcYcl2sSnCkl0H/6sMbh/edl/k2HwTMPzrIuw32nWRx3Nlzchbj/1NPJ+lEpuUQ13sX4NOegGcd/EzCHa64dze86eju6Dzxlm7C+DlHMHYFo1/t/sOVzap4evuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WKBiPqPt7fRZ9jhEJGi4HOsXJdEsZXIagDZD0isaB4=;
 b=B7lo/qcDvpVF1PCRwy56EECdV44dULdo9XgBymKgMnemN5YQNb3GNFoThVLyb0kMgmMsUx+VzjOb83gIe1HWAaMEOA1x4kpEhB28JkyPgYSUNHAeaM8C9MJmwtmHdbowgi6au0azcA14NVjOzrxm9LwO2bhNOmLy4tgWfZvoMwQMyQCWVcUOdu8e4BN4KZUUEfXqqHBIpHptBoXy4ozawmRsZGDFDsgxRjh+rwX9BZL6MVUuSyPYHI4DFWK8zDLTou/gCRwxE8y0IG45AVGfDBurHVIdnY2IZ8mukxPGCwkPTh0/nJ+2WCrwOUTdzBGejUXaI9hk70aIBemoiUd/0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB5964.namprd11.prod.outlook.com (2603:10b6:208:373::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 15:48:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 15:48:55 +0000
Date:   Tue, 8 Aug 2023 08:48:52 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dan Williams <dan.j.williams@intel.com>, <dhowells@redhat.com>
CC:     Brijesh Singh <brijesh.singh@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Dionna Amalie Glaze" <dionnaglaze@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "Jarkko Sakkinen" <jarkko@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
Message-ID: <64d263e44e401_2138e29486@dwillia2-xfh.jf.intel.com.notmuch>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
 <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
 <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
 <64cdb5f25c56_2138e294f1@dwillia2-xfh.jf.intel.com.notmuch>
 <1180481830431165d49c5e64b92b81c396ebc9b1.camel@HansenPartnership.com>
 <64d17f5728fbc_5ea6e2943f@dwillia2-xfh.jf.intel.com.notmuch>
 <c7d6e953a4b36014ea0c7406531b24bb29d6127e.camel@HansenPartnership.com>
 <2425e00b-defb-c12b-03e5-c3d23b30be01@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2425e00b-defb-c12b-03e5-c3d23b30be01@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:303:8c::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: fa555741-0423-4bae-9115-08db9826f8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DgQsETZgys0LPf7U2vyURnycqek30yCMmKZzzc0WmtBkbloark9WR4IdsNwv4cShIpkyN14gY5OwxF1bPZ2pNtRFwp1PZuKknz6UpNeKZhHumDiOHzwrU66fIe9juaXpDUHCV3ss8z4XPC5nie0sOVqtDydZLYIo+cT+zYiK2gxXCSiTyADPXM420A3z5vCsvn+ubWt8Ir8c1dY3vF+DbkVZ3hZMfMRDUxKcostgczZOtFr2Tnnqcf6QY2lUaj7VqKijl28WRRfZWQORjfxViqxZ5nzQLWIDnY9fAcFrBG3O9oKdzFHnT6C2pBBtOx7Wp3gL6JfqV9uQ9NePCfa0oVecfYI0gBmC7saqwuc5UiWG3zYzbnDnOwHJzEmhvpOOit2okgKz2/BaDztek5JcgVFr407vqXRDgMk3Os/b1hsBFnGZ7eh7hHiRVsgV2/6DLVcqaxE48yduP7rls7+pcTzlpJetLBqDZqy+VVbsvIC6zGfJT+4AdIHDJQSegY3Gdk23/+dHTmSkNpeKks2hcoXN17joeeJ8pjY2U6J67+2JGrdZNiCBWO8mUHAOhrqZhOZo5zXx0D8dbljc4XHO2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(186006)(1800799003)(9686003)(86362001)(6486002)(966005)(6666004)(478600001)(6512007)(82960400001)(26005)(6506007)(53546011)(2906002)(41300700001)(8936002)(7416002)(8676002)(5660300002)(316002)(54906003)(4326008)(66556008)(66476007)(66946007)(110136005)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/hiVAKSZfK1dBw/TQRiCU8V304q71IZxPX/Lb0zjkrKMTRbYV6ucY8gG1s?=
 =?iso-8859-1?Q?Y6aixk5VllrcsaGTFQvQAtaK45Vixj2bM3XnL2IZhab5XFaTuIungUc7bh?=
 =?iso-8859-1?Q?uRI+FG/Cb/rbs+KBdmGK8fw1rqQ6mkodwGrOMMMXIZ42s3zF7vO3g63b+8?=
 =?iso-8859-1?Q?nw0xGl5Ml2u5rIVreCVU+QhLxpQmGjmCYR1mEKWVN3GwM5lFDrDjfEQDaf?=
 =?iso-8859-1?Q?0wx09doBc+09W9ca+C90JyfKCJs53KS+p89SNXEQBbzLsZNKfwEoHu/Fza?=
 =?iso-8859-1?Q?GrlUeJI/yARc8Zd5RiFfFsd6cj5rcmjxTpjCiqGaMcWJsShGWuCsEWyvOH?=
 =?iso-8859-1?Q?1t2qpxOiLeLqKPKhd+ZR/QwoBT8h35Ij/pJxcrvMXcNzgc3LxGNLR1VUAo?=
 =?iso-8859-1?Q?cbREP82KIog9qejXeL37Id0gjyEI5pvhG0MqC39AKV7l4oNnZ+J5tt9yr9?=
 =?iso-8859-1?Q?iTqOKjgG3DAGQEmyNRn8eTkNT9w400ec4Qxky5qEkwTExhtArdDr4rKUiD?=
 =?iso-8859-1?Q?TXNR0m3ooQnnxVAas5Yi4tF73NeWf80a2iWjmH1qhJIr1bwxIXSVC1afxy?=
 =?iso-8859-1?Q?Hus9lawtJK2PKMJe1vTejxK8SAHs4TMZBTw5L9htxE9rDfDwZl+UGzzoRf?=
 =?iso-8859-1?Q?QFzNGKXjWrnqxlsmLZg1LoaCCAGk38h3GiJFSsjiTq2gl9/kKIoukULT8l?=
 =?iso-8859-1?Q?k8dlo3U59xsARsO87BPPzXj1Nah5VFktswts4xy8ARDjLik5hmre/xbhvy?=
 =?iso-8859-1?Q?1sgNQJmJQqDQzxSWKjZbbw98jdKZY4qrpaKfQlh0UgpBMTDeTSaSl7K+Yp?=
 =?iso-8859-1?Q?0fa3Xa9mHeDEZk+RE0JsCyuL9ool++7XQ4HeovTyuHG0bXe/VgsYu97Rgh?=
 =?iso-8859-1?Q?ubVsUFMsCDOf9U330v6IHgJJyceRTL1GQddNc8LVJLORfUAjIQfXpsgjXa?=
 =?iso-8859-1?Q?wXmcvE75v8DL8fg4hJ+GC+lf0BgLH3hYnY5h2psLyiGB/R6wc9fV266qkW?=
 =?iso-8859-1?Q?B7AJ75/SoNoeA/Af6hKDQFLkd/sA+ZK4mxrrXJhPBU0oUp1UXX70JhT4Uq?=
 =?iso-8859-1?Q?loK0K2fGWreMuQ8PFL6TT3QDDpDb862BFmb31uWbbRD8P1tcN+HatH6zvf?=
 =?iso-8859-1?Q?o7KtCbdtmleh5FyCVXSm/ZxW0eU0thTVfqvqJ63TdLm0xucqAKCkyLtboQ?=
 =?iso-8859-1?Q?JzSrSFNMCAO9ruIajSRaFASqoTF1P0loYOhVDJ4ImYBew8BQ5lXdD+I1cC?=
 =?iso-8859-1?Q?EFsQz9GATUABg/PfrSCzyqT3InE0fIP9pTxkXPRoRPDBQB6A2HcMWzbrdH?=
 =?iso-8859-1?Q?hNnDAvnd2PbUr8Etk05say48vMRZy1SYoMgbODTQYGPbYy2sgraU/tgQOR?=
 =?iso-8859-1?Q?Gs5r7MU93SAUnhdrjKmqNlzvV8ehIt+6qKGFot0S8y5n+0yLq+YYHaCTh5?=
 =?iso-8859-1?Q?xqFO0xPKN+HBhbbldGqm6+auiJdeqhiK9PJmnWJ9tvovyClG0yY5fcjTCY?=
 =?iso-8859-1?Q?TbWZlFBhMfAJoMAone6uFQFmmqHjMF73RzA4FXu983n9EnE2tcCz5s3UqH?=
 =?iso-8859-1?Q?PyifFG5RKcbsj6giITeaZGZpYEGPRA5mniDvj+S3Z/irL4CyOa58ACEbHN?=
 =?iso-8859-1?Q?SP2FVpspr4e6nLje8l7MLs35BfzrvyWsKAGtos1CHpZNI1yHiNLDeYbg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa555741-0423-4bae-9115-08db9826f8e6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 15:48:55.6419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3a0ORe5cCgvEQlijtwbq26zCnfrWxtJZCLqgywW7UFUxmzJWaDakA/ZKHYsJ1FXClZTB18OJI97jHEs6Yt4eok1C+LnNxk7miCnWy3eg/xY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5964
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

Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 8/8/23 7:19 AM, James Bottomley wrote:
> > On Mon, 2023-08-07 at 16:33 -0700, Dan Williams wrote:
> >> James Bottomley wrote:
> >>> On Fri, 2023-08-04 at 19:37 -0700, Dan Williams wrote:
> >>>> James Bottomley wrote:
> >>>> [..]
> >>>>>> This report interface on the other hand just needs a single
> >>>>>> ABI to retrieve all these vendor formats (until industry
> >>>>>> standardization steps in) and it needs to be flexible (within
> >>>>>> reason) for all the TSM-specific options to be conveyed. I do
> >>>>>> not trust my ioctl ABI minefield avoidance skills to get that
> >>>>>> right. Key blob instantiation feels up to the task.
> >>>>>
> >>>>> To repeat: there's nothing keylike about it.
> >>>>
> >>>> From that perspective there's nothing keylike about user-keys
> >>>> either.
> >>>
> >>> Whataboutism may be popular in politics at the moment, but it
> >>> shouldn't be a justification for API abuse: Just because you might
> >>> be able to argue something else is an abuse of an API doesn't give
> >>> you the right to abuse it further.
> >>
> >> That appears to be the disagreement, that the "user" key type is an
> >> abuse of the keyctl subsystem. Is that the general consensus that it
> >> was added as a mistake that is not be repeated?
> > 
> > I didn't say anything about your assertion, just that you seemed to be
> > trying to argue it.  However, if you look at the properties of keys:
> > 
> > https://www.kernel.org/doc/html/v5.0/security/keys/core.html
> > 
> > You'll see that none of them really applies to the case you're trying
> > to add.
> > 
> >> Otherwise there is significant amount of thought that has gone into
> >> keyctl including quotas, permissions, and instantiation flows.
> >>
> >>
> >>>> Those are just blobs that userspace gets to define how they are
> >>>> used and the keyring is just a transport. I also think that this
> >>>> interface *is* key-like in that it is used in the flow of
> >>>> requesting other key material. The ability to set policy on who
> >>>> can request and instantiate these pre-requisite reports can be
> >>>> controlled by request-key policy.
> >>>
> >>> I thought we agreed back here:
> >>>
> >>> https://lore.kernel.org/linux-coco/64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch/
> >>>
> >>> That it ended up as "just a transport interface".  Has something
> >>> changed that?
> >>
> >> This feedback cast doubt on the assumption that attestation reports
> >> are infrequently generated:
> >>
> >> http://lore.kernel.org/r/CAAH4kHbsFbzL=0gn71qq1-1kL398jiS2rd3as1qUFnLTCB5mHQ@mail.gmail.com
> > 
> > Well, I just read attestation would be called more than once at boot. 
> > That doesn't necessarily require a concurrent interface.
> > 
> 
> Agree. Currently, both sev-guest and tdx-guest (Quote generation part) IOCTL
> drivers use a mutex to serialize the cmd requests. By design, TDX GET_QUOTE
> hypercall also does not support concurrent requests. Since the attestation
> request is expected to be less frequent and not time-critical, I  don't see a
> need to support concurrent interfaces.

At least that was not the level of concurrency I was worried about. The
sysfs approach makes it so that concurrency problem of option-writing vs
report-reading is pushed to userspace.

For example, take the following script:

$ cat -n get_report
     1	#!/bin/bash
     2	tsm=/sys/class/tsm/tsm0
     3	echo $1 > ${tsm}/privlevel
     4	echo $2 > ${tsm}/format
     5	echo "hex encoded attestation report for: $(cat ${tsm}/provider)"
     6	xxd -p -c 0 -r ${tsm}/report

The kernel handles the concurrency of line 6 where it synchronizes
against new writes to the options for the duration of emitting a
coherent report. However, if you do:

$ get_report 2 extended > reportA & get_report 0 default > reportB

...there is race between those invocations to set the options and read
the report.

So to solve that concurrency problem userspace needs to be well behaved
and only have one thread at a time configuring the options and reading
out the report before the next agent is allowed to proceed. There are
several ways to do that, but the kernel only guarantees that the state
of the options is snapshotted for the duration of 6.
