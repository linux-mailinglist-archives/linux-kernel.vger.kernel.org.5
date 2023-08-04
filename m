Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7184B770BE6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjHDWYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjHDWYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:24:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEC71706;
        Fri,  4 Aug 2023 15:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691187873; x=1722723873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ywaRQqkZCkQHpJeYah7Zw7/F3VXozesvChf3Vs/YRYU=;
  b=C8ndm4TCsqio9xlmNtbFrTGGB8flzTaenIZYg67jUFxiciQtXYAQo1zs
   x5ruhARNx49ni75hkOHUDo1wL7aUmQfhWJwoF1efcX8ZNsYpwAQ3WuMsb
   bCqDUXMNmurrC+uK+qhKJI6givnYUrlpcK1qM+DVQ5nvwf3EJTiYIZOW2
   cqFkeS04+KgvDSdEDlTNkRkC1pfeTbglt0x+b/1X2jAwDk277alGWr2Fd
   MHy0ZpnYHiZ1bLAvATxiDgjsQ0zUOl5Rld+ArSG2OlDOyinGQs7lbBUZO
   K3xlGcWlYZte8KGOlRf/yUG7ExtoPWgBhp3p1chr5NRaxQWZThm535jCj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="434103972"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="434103972"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 15:24:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="976753720"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="976753720"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 04 Aug 2023 15:24:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 15:24:31 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 15:24:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 15:24:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 15:24:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfuKG8inEzaW4j/IuVecQhj7hVNRNj/cgCmwlsGKZTFeYsbnIhqf9DgmRzWsv52cn1WjQrqLmPhW1i/fxnUAM6DNSmijexavfyT87MZSc/4EPHJmZtILBIeW4G6NmBTHrwm+BFLrtpoEAwAt4l1Y4o1qGpiYqdTewP6njLwri1siw/q5b1KKy1xHmPgymUTR3wgcyyoC7KmSHjhkpfwdDoJlJnyOx47m5YTAyblt0ilLdn3MbKXdsH8FMfK6FDrZ4E5iwVn5wGHxwYLNv3lcIAHXriAz75OC053TaBytpgAkiTNPK8M02STEZtatagItnRckvYheUUoMe2N13Zyqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9m4qkvehEUFRlPrOxSeN3BULxuGvwzATugTdlJumMI=;
 b=TfB2Hzp7DQvetEgOyAovaLPLSt2WeH+7Sk6Bd2w4vbbXtc8wxhGH0gjNDradq+N1vBt9X4p0OFdSUGdI3onGNuA/rTI3pT7/3UNk7G4ZkLs7H8ybRtKzP3hfYok5Qs/7YBDrU3yqzTTwrKo3QXZAo8VrTHDhhOmC60jrACYL9G7EPuHSRLRxrfhGKQSF95PIdWfyAzsHYwviuJKIe1Q5Nsq2WOvX6v6gPK4zrJZIBSw3IlfkRMOghKOqFWkdDtpvEIW/H7GQD1GJ6ydW/csSsoF847eiVBlcFQsk0IhslwIwj7jcnZGH798v5kVQTiwDrUvOOWUry20c7wWDGXZNEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 22:24:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 22:24:27 +0000
Date:   Fri, 4 Aug 2023 15:24:24 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Peter Gonda <pgonda@google.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dhowells@redhat.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, <peterz@infradead.org>,
        <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] keys: Introduce tsm keys
Message-ID: <64cd7a98c68f8_2138e29496@dwillia2-xfh.jf.intel.com.notmuch>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com>
 <CAMkAt6ot9zyUL9Ub-qYq+d9v-6rTft4ea2mUxp3o1s3GVFq7nw@mail.gmail.com>
 <64c7f3df475d5_51ad02943f@dwillia2-xfh.jf.intel.com.notmuch>
 <CAMkAt6p9yEM7A5B9TyZsVTH=X=UQ3Z9wfYDg9etuc806mNdOiQ@mail.gmail.com>
 <64c80077d7144_51ad02941@dwillia2-xfh.jf.intel.com.notmuch>
 <CAMkAt6pPCJ0YsWaL692heDCUYjF9KCBq3PNiPK2LyBd=wD0+ig@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMkAt6pPCJ0YsWaL692heDCUYjF9KCBq3PNiPK2LyBd=wD0+ig@mail.gmail.com>
X-ClientProxiedBy: MW4P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e59b276-3a2a-44fc-cf19-08db953990aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bcunDUfr3hYIktet3CvH39GVcz6YrS7++tbmjxwvHkS0Stq6BW6FqtsWWwUMVELYuDYuHR2xiaZZ6JY1899QOfV9WZDNQZ/1QIanRMUd/gRvqOeWcEfAucWpOx/ryeZLUx3vmM85+wpRJcJDL65MdY1TrLDn4nW5PHlyTaCZcasN3sjjvF4Kyrw0ig9wcP7yQeD+bqT8DJC7UDEdvS3S6xGBJ6QAcB1tiCy9Mf5HVJGakG0nh2spvsx6moRsx9l9dwSPz/DBUSxXp0sni5UflS01VCO/WPHMxd758KbCHCFNHpZXLucl7VREVWX7riIyeOELG76NPApSRWwDuJruLb1G6fIFOsEpibMP/OHqwzGRZIYEz5CC2MS75wzlZVGHOzpRfWb+dYpgQjF0qsMt4Wwrl42PHofFtS/+S5HGVq+nV2VpXqB/EDKAxSW/2aMEXgu+nQuLix4eWatEuAhIjNoHUIP5KswpSoFUU/jAbsF4JBEpeLPtykNf0piQKPeqPeus+KysmrGyap5EslW3dneZmiQHxpgJz/+r0dyx3jpaL2Z9Sp4U7SLV0nzS+54Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(346002)(376002)(39860400002)(1800799003)(451199021)(186006)(83380400001)(26005)(6506007)(8676002)(66476007)(2906002)(4326008)(316002)(66946007)(5660300002)(66556008)(8936002)(7416002)(41300700001)(6666004)(9686003)(6486002)(6512007)(478600001)(110136005)(54906003)(38100700002)(82960400001)(86362001)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ojJn4JAyC5nB8JCI6QigOKhdx7r1qO7vcQxNL5Gs7MAptg6qGJO8pm5QCd4Y?=
 =?us-ascii?Q?qJxjtfDLcII4WwsfuW0vTf4juoEEZgrgfDwU1iTFkVIu8ipoUJiC1HeoijNE?=
 =?us-ascii?Q?3x8MtfOyG6RV9AFjSkk+dCvG6T/Te0ZkatNhGnlguxGo6IeM6xy/GSOvehSa?=
 =?us-ascii?Q?Y5JyIQr9Uvrf5sRsA5Kw1+7cJ9eNp7XPrwNNxRmDE+qdQiENnYAZ8lyg+0gM?=
 =?us-ascii?Q?WqJz9pFldpVc6fMpIwJqSv9rkVDPXJzT1hSVASMpvwH6e4jyf2EZ0K6HIIPk?=
 =?us-ascii?Q?ITUpLr4z0D1Yr+JBMPIObgjZWEpDRtHJbsA5OuRx6z225qZt8lGmT3wy4B1T?=
 =?us-ascii?Q?qpH5A/IH3OvZazLkC69KiDhUaYckEHB8GC6iEWroBjxugvYMaPu9BkVUipul?=
 =?us-ascii?Q?bMSlCOHuDfxWV70nwGFj43xXZIljiyo73JnMnD/PVA7CPIl6LYhBMJ7YIRZJ?=
 =?us-ascii?Q?e2MPDV78wDaIOPa+kRRFKFjzxKpq6wa83putrzWyRRZpY/074oFZRF+I84tz?=
 =?us-ascii?Q?7a1rCZXIGK2eaRQo8e9EZcMYZBCJuOBNBadjT1Wyeq0qzDICIwpbctEIe1/9?=
 =?us-ascii?Q?iUBARHqSg4Q1n5vRz/FRhu1A8mwMSsREKre6QRkChOeNQRyMWIxOqdED/XT3?=
 =?us-ascii?Q?7OBdZ3n9e6CcxNnPy98IDvkaszBV6O2+efXJo5zb9P7Zw69TmZLBLe1Y6PCR?=
 =?us-ascii?Q?3nMerfbvxIVl3QeKY1ciB5NNgUmzPMVMg9Xq0vADSnB1pyWngvFnaXTENP2C?=
 =?us-ascii?Q?DTliZoyQsrcXVyb+UyUvQq2C0fjB1cY1dPuZ3K121mACTeRsiFep4cEQH2Uo?=
 =?us-ascii?Q?AbCc6wWmHzBI3gygsf/O1jbLoY0DIf5sPvo+whJnBePiz/3OocqM8Qwcn1rE?=
 =?us-ascii?Q?+BuZDHyJF1m3v08ehAGJmd9og5TRsIt23KXU525Z3PsqS13waWK8h9ij8tod?=
 =?us-ascii?Q?4u8kkorKVR6FCfla+jV6dqz4AjzM3fKje9fr+yQv/Sj4XBffkaBW/KXu7lGA?=
 =?us-ascii?Q?Bl/dUPLfslWH1lQY2lEzECVuE7WehsAlMs7wxhmaq23qivQ+3fGzvduv++Mj?=
 =?us-ascii?Q?mDpCSnswjZqwDinMWtrZNeSF8yw9fmR9TjZQZmSs4HsF7utXKjci3oc8s0Vb?=
 =?us-ascii?Q?ML1ZM9P+qrucdO+17t07slm1R8IQeGltFynn6498k40QO3/lus/LRtT6f1Gi?=
 =?us-ascii?Q?kYUwDdsVsxJGqxPMWYn309G/ugU3qqIVco/PetN7cpPeD+gHd6PmD4XyaK8j?=
 =?us-ascii?Q?AQAKTFD7xSVy/Fton3CzVFiHSkH2QclPAy7xg4YRlsBUBTmXSrL7QlvN+Pij?=
 =?us-ascii?Q?aA5MHed4k8a45ndMa0fQdCyJ8Oh+lD/xxRrg5UcRTUCIXW3LfvzYxh7W4P1p?=
 =?us-ascii?Q?+dNaNzGUAHvAGj/DHK1AShxlQTofBXEEJlgPX7HkUBzNMA8FDQwDEYPjBJ22?=
 =?us-ascii?Q?3ldjvOt9L7x6mWCDTQCEmXi66xX+cbKVh9I442WuG/G9JbrN5NROf1nTNgTj?=
 =?us-ascii?Q?TZoV6Uk0Se6JzFQ+R7KLy62JHJ7EoR2lT7TeelIcefQLHohBHonvsjUwrbHC?=
 =?us-ascii?Q?sPg809zcT2usA8E8xPaJA2tDJUlAQQIWdagBAMyLh68+IIJv7LECQaK+WhQf?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e59b276-3a2a-44fc-cf19-08db953990aa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 22:24:27.7233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qAO7BL2NhI6RRTuuB+AQ1j/Fq3soMFymnnFyHBS0EbIWBdxdBUw5fVAdNvtMildgTTbz3it5l5biQV/t186H+xkT0xDSqwg3Geb/mhB1dI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5963
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Gonda wrote:
> > > >
> > > > > > + * shared secret and then use that communication channel to instantiate
> > > > > > + * other keys. The expectation is that the requester of the tsm key
> > > > > > + * knows a priori the key-exchange protocol associated with the
> > > > > > + * 'pubkey'.
> > > > >
> > > > > Can we instead be very specific about what protocols and cryptography
> > > > > are being used?
> > > >
> > > > Again this is a contract to which the kernel is not a party. The
> > > > requester knows the significance of the user-data, and it knows where to
> > > > send the combined user-data plus quote to provision further secrets.
> > > >
> > > > Not that I like that arrangement, but the kernel is not enabled by these
> > > > TSM implementations to know much more than "user-data in", "report out".
> > >
> > > Can you explain why using this key API is better than the ioctl
> > > version? Is there an overhead to adding keys?
> >
> > Setting aside that folks that have been involved in the Keyring
> > subsystem a lot longer than I are not keen on this usage [1], I expect
> > the overhead is negligible. Keys are already used in RPC scenarios and
> > can be destroyed immediately after being instantiated and read.
> 
> OK the overhead is negligible. But why is this any better?
> 
> To me this seems strictly worse to me as a user since I have much less
> input into the hardware attestation which is one of the primary
> benefits of confidential compute. I don't want the kernel limiting
> what cryptographic algorithm I use, or limiting attestation reports to
> signing pubkeys.

The current proposal on the table is not to have the kernel enforce
anything with respect to the format of the "pubkey" payload. The only
feedback so far I have seen about improving the semantics here is
enforce a nonce which the ioctl() interface just has to trust userspace
is handling and the Keyring approach can enforce a callout for that
input.

> I understand having a proliferation of similar drivers may not be
> ideal but given the hardware lift required to make confidential
> compute happen will we really see too many?

From my perspective this discussion has already been worth it as some
people were unaware that security relevant development had started under
drivers/virt/coco/. The details of the kernel/user contract are coming
into focus.

In general, the point at which to have these types of discussions is at
the 1 -> 2 implementation transition, to my knowledge we are already up
to 5 of these things (AMD, Intel, RISC-V, ARM, S390).
