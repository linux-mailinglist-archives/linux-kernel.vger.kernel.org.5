Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3716877350C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 01:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjHGXd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 19:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHGXd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 19:33:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E13A1721;
        Mon,  7 Aug 2023 16:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691451234; x=1722987234;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Ba45wRJ8c2MOPaIaCQuo3tZrR82iFLfN1rJLL3E58Jc=;
  b=YN5ud/ImWsRRtFBm9lGq8+kUzF4S9bE2SHLyw+Z6LPz8mN3BkjxXx4rU
   0O7/nrbTUlU+kSsyiQxjiJWsqrLMCgajxOXbjr8ht+SK3e1xWVqoz4m0u
   w53EbV3Fdu3FeMLVVr2O1FX9ZKUUnlhoBm9ZOYELhE2AJvXY7orVkzVG7
   ifWhHaoXWBQW4qwSvOi3+728+slyjrYVFDQ/8WGxP/y1wQ8IwKSXvCLXA
   H9BrTAQtCklTBoJwH14v9t4wOnc4xo2IdqOIEuJ30Mgzdnco5qPe+apKD
   1jMyMdvFpBYoAPnAmKuL9naPABIwBYJbaqN0uSidgVfFA+5hCzXRLJrg4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="434521950"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="434521950"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 16:33:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="854872790"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="854872790"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 07 Aug 2023 16:33:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 16:33:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 16:33:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 16:33:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrDhK6WFZHOwXRNpujeW/6FpYzjXDKOVRLbXYTQaaWJFVhRTE3ss2aZn8ir3qtolKI5XiQset+cNXAdZsz4JeIKRg08Okqim7rbY6DLfdf7YRsZrIQT3JlXO5zGmQtPK6kB+324OUCd1Mb0ezvXTep1QC1qQcr62P8J7i0iKBKELnAF20UE96iIk2lVYvPx//Ngzn/Kef8SsgcUC3wqxxAqM0XPWSjB7omQv/rwffD1AxYQKKb3ub3YryaUv9y6RH+89/FrN/o8lnxEpZWgcRv64++63xzvelY9TVzKgMlDe+vLzq4vSuxcCaw+7hXdybov2WThHBO/CKAahUgqxMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBdQ9ff8qZQL4RaUdekwsUId4PwwL/hy8fkknuU3B9w=;
 b=aEjFGoFkJls35ApfqexHXVtz8A7uoXDvpQSFuEemLXkqISE4b9vOaqFBixxDAJGkuocUf43JPUTqYHvkaUr1KMnMJdSlzG728W4t/X2eJCjOn3QkHWLtC0bjNgNvowgHa4yuDhp3BSPeWubsZgbmkki3FVs28x+9nX5UEriCDDcUvQOBoGJRkPYJHdXc+MezJV7X1eBiVhqHZRXYmAblajjWJM4ra4zGZPJ9kl9L4y4M4IdkrXbMYRua18XDuPz++tZJ4uoBkIwsm8UMu3SKevSmP+7QprzjS409L+CjXC5rDSEreRrMBj4a2nSwRyANYQZG/YcoHCz7OI+w4Atsew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6988.namprd11.prod.outlook.com (2603:10b6:930:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Mon, 7 Aug
 2023 23:33:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 23:33:46 +0000
Date:   Mon, 7 Aug 2023 16:33:43 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dan Williams <dan.j.williams@intel.com>, <dhowells@redhat.com>
CC:     Brijesh Singh <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
Message-ID: <64d17f5728fbc_5ea6e2943f@dwillia2-xfh.jf.intel.com.notmuch>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
 <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
 <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
 <64cdb5f25c56_2138e294f1@dwillia2-xfh.jf.intel.com.notmuch>
 <1180481830431165d49c5e64b92b81c396ebc9b1.camel@HansenPartnership.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1180481830431165d49c5e64b92b81c396ebc9b1.camel@HansenPartnership.com>
X-ClientProxiedBy: MW4PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:303:b4::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 11740f52-5e7e-4db6-85c7-08db979ebe7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y8QC9rfF9yCYrPuI3wyNtPeU/WahkarmAlcCV5jokbam54LQ8X/G1LWKuQ2V8CDoGZcvzLA8BCNMTAEMKEbT0holdreinK7KqvlGdz6g1ZceI8q3Y0IBaROmnBPyZqKp9h2aZ9WtX/7br8qMDbFojbzrMQ1GHJPDIGhF6/zMm41VHaQAdA0lEZmp4Yxae5nFgX6EkEDTpbqNh3lullr5Y0pGchV4jL6d01PPBBDp9eOjvhfAAkKc4bNPErvYASwsTKG7JltXw11XHpFQCUly7vMeq/PrJpXf9a3yLrc5P+TYgxvmkK/advqVzN4Krti5B+5bLgtUhr2aemUUP/6ILJQPA0rHGiAzqypbsKlb0rsaCaH4wOBIu55ehL4zp7DyccM9POxe1VRGZ4MS7IGVNNqCfgKelYZwld08TRHY67I8lwg2D3k+twGCWtXWNauSR0Yo3Db8tH51thSFqrzzkJWhVGwvN6ewuXgiYzHRbvnxgJthRticos0EwQkpPpxIgGGyGOgS3kdh05eooVOSRaktEQC1wTlC8Fwe7qXFJjcAEqX0kFchuZ0A480K3sUTfjpbyP39aX1M3OWXtynpqIjrWCsqLvWLDc9NjH1r7NIzqaXfQVqBnJu0MDQnTvW9Qd5yISoWkqGvye55M6bdOwPjKT8FJav7DteuVPv3hIpmrrHRpdE97PIRLXxDPhix
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(346002)(136003)(376002)(1800799003)(90011799007)(90021799007)(451199021)(186006)(6512007)(6666004)(9686003)(966005)(6486002)(26005)(6506007)(83380400001)(38100700002)(86362001)(5660300002)(41300700001)(8676002)(8936002)(4326008)(66556008)(2906002)(316002)(110136005)(82960400001)(7416002)(478600001)(54906003)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Y5GTkzT5gUCDepi5mbd0GMVduS+v75JhZonmhOQEQcKRgHmIePnyZW+Wq3?=
 =?iso-8859-1?Q?UV9mNdYEVPSA2JoI6MUx9Xnnp/GYGckxp3NZgDjmOUhZ0Wbrge7ncU6aZh?=
 =?iso-8859-1?Q?wuWZizRmhQ3lJb6XyDHafLGqip8yYoZc5LjWiE+nXpP1NtUEit8GRik2e2?=
 =?iso-8859-1?Q?/ZNeK16G3c/Kn6wrkwMjN8I5ZKMGQ+hGR7fpMkkJlNmgzBAc2oOVXoD0qP?=
 =?iso-8859-1?Q?VWyaFsUce2LERRo+lReENgM2AAZtYsj/M76WDsi7/TLd/HiSi29+XPj3hr?=
 =?iso-8859-1?Q?p9kN8YmbTLix2QN+vv7tUDGsnBT8JRM7J8lsh74kAB8knWpXJlTtiPvK4h?=
 =?iso-8859-1?Q?XCKcxq3R81VGkiXdMmOecaKF6u4QjHFPkg+OuKM7nzzM5BKm/uRmSoTSHR?=
 =?iso-8859-1?Q?3halObttCWOpq8XBKmND5sa3g9nszucVYhqBGO+N1XfChxQHJSmEI5LuO6?=
 =?iso-8859-1?Q?j1JIYmd0uKHYDD/d/gq3m3wE3veezNi4KcamEyCRhw7+UIFQFJlqiGS/ex?=
 =?iso-8859-1?Q?HX1bKMrt9OXOoMIlLVW54ti3gU/lGg9GsreH/nUyBadzKi4R4KIzIxD+Zq?=
 =?iso-8859-1?Q?/ZGWcbDSqALrLLLgw5ppxCko7Cda6RfVsqjuXkGpTFCycrShVJGq1omtbz?=
 =?iso-8859-1?Q?tg5kEcOEgYLT6XNMeiO4UhNcHwq0bUa1ly9Ndb2wFkDaKOKJQgXpUxZurd?=
 =?iso-8859-1?Q?U0R4m2HbK8EYfO+d/DoP6NfJOxftOmmLBYnqURGR2kNZX+zhw3jUHAM9DS?=
 =?iso-8859-1?Q?an6eEwEZ6aPXQ/Mz387PMM6jLs6PNy00znQDQVvQsTN1fcYlIlEcpHyqiN?=
 =?iso-8859-1?Q?Ip0ZOTY8/L/rH+MJ28GKimMo6StwctKXPw/gydjtvvhvjhiPLTZebYUEme?=
 =?iso-8859-1?Q?3OqrJvxnFkhlqxfmwLdL94Xm1CfhC22jmcB1AQDvQf0XP/EmVE7CTQvNcC?=
 =?iso-8859-1?Q?NDoVY+2ZNPb8x9N24OiNWcfY1YNyNGS0wVRn+FZrV7X1hTwiOmMxBG2EeL?=
 =?iso-8859-1?Q?4p6e86/0SB9ZhP2+d9/3kvrLIMQXxpfOy+4PrlgdhsRhmBb6I412stWC+d?=
 =?iso-8859-1?Q?xdDmfw3SmriufNsEE6S/oNFBDqhdCp9nnDNVY4TI6HG+D1E7kJdgXcer/H?=
 =?iso-8859-1?Q?65EmESPG35Lqa1Xvn07CZSezdyC9ve3oMkKYtjEyT+1maNsiUskgQEXwF4?=
 =?iso-8859-1?Q?23xTrqz5E0rHolISji8p8UhAyB/iFRyiPYBGVy9+BPhQeyzXnlJHZPpBYq?=
 =?iso-8859-1?Q?epDHefwYiUCVfmvgFocHqWQktsklo01v75qizOOKODuSkMzAwpM/ewqRdG?=
 =?iso-8859-1?Q?oELfM7M66U5ItkdbDCDkMLz8XfNx+a77x9ewa8gxvB7ZuXQW6LsEZkYyli?=
 =?iso-8859-1?Q?HfI3ZA0+vb3tFE48jPmV1EIDwDzhUSbdR6vzEMarcfGh6eJ4WBb6OFxAgK?=
 =?iso-8859-1?Q?6FmgSVTXSOd2CazUGbjvdxs0tfRRK0qkp46OkI7zcPly2h7YYYWUKm2Ftu?=
 =?iso-8859-1?Q?btqhd2gMAwNAMSZckzYWyJhAicXL4+vrljwJlaFDUS6WK4ekHhDF3v8QqL?=
 =?iso-8859-1?Q?wSXBmRh2Xg2OJF7bwiLAQeizhy1wn9RAg+MdyDarK4NZgHGaZq6+FroI+A?=
 =?iso-8859-1?Q?V5fvJ+/4xE7p4u2NH+9dkE38OyBoXnCaQambyjL8E3UwyJNEjjL05lrg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11740f52-5e7e-4db6-85c7-08db979ebe7a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 23:33:46.1112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XODtjf3XbkyRye6vzJtP0YLZtVjkM/yu9lApwoEoKiPGh7gQnAyO2Dk3/UO7q3LQ+lbYr4lvcwxe3lF8y9nLK2ACFzn9OXmXjXMbYEC9KLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6988
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Fri, 2023-08-04 at 19:37 -0700, Dan Williams wrote:
> > James Bottomley wrote:
> > [..]
> > > > This report interface on the other hand just needs a single ABI
> > > > to retrieve all these vendor formats (until industry
> > > > standardization steps in) and it needs to be flexible (within
> > > > reason) for all the TSM-specific options to be conveyed. I do not
> > > > trust my ioctl ABI minefield avoidance skills to get that right.
> > > > Key blob instantiation feels up to the task.
> > > 
> > > To repeat: there's nothing keylike about it.
> > 
> > From that perspective there's nothing keylike about user-keys either.
> 
> Whataboutism may be popular in politics at the moment, but it shouldn't
> be a justification for API abuse: Just because you might be able to
> argue something else is an abuse of an API doesn't give you the right
> to abuse it further.

That appears to be the disagreement, that the "user" key type is an
abuse of the keyctl subsystem. Is that the general consensus that it was
added as a mistake that is not be repeated?

Otherwise there is significant amount of thought that has gone into
keyctl including quotas, permissions, and instantiation flows.


> > Those are just blobs that userspace gets to define how they are used
> > and the keyring is just a transport. I also think that this interface
> > *is* key-like in that it is used in the flow of requesting other key
> > material. The ability to set policy on who can request and
> > instantiate these pre-requisite reports can be controlled by request-
> > key policy.
> 
> I thought we agreed back here:
> 
> https://lore.kernel.org/linux-coco/64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch/
> 
> That it ended up as "just a transport interface".  Has something
> changed that?

This feedback cast doubt on the assumption that attestation reports are
infrequently generated:

http://lore.kernel.org/r/CAAH4kHbsFbzL=0gn71qq1-1kL398jiS2rd3as1qUFnLTCB5mHQ@mail.gmail.com

Now, the kernel is within its rights to weigh in on that question with
an ABI that is awkward for that use case, or it can decide up front that
sysfs is not built for transactions.

> [...]
> > > Sneaking it in as a one-off is the wrong way to proceed
> > > on something like this.
> > 
> > Where is the sneaking in cc'ing all the relevant maintainers of the
> > keyring subsystem and their mailing list? Yes, please add others to
> > the cc. 
> 
> I was thinking more using the term pubkey in the text about something
> that is more like a nonce:
> 
> https://lore.kernel.org/linux-coco/169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com/
> 
> That looked to me designed to convince the casual observer that keys
> were involved.

Ok, I see where you were going, at the same time I was trusting
keyrings@ community to ask about that detail and was unaware of any
advocacy against new key types.

> > The question for me at this point is whether a new:
> > 
> >         /dev/tsmX
> > 
> > ...ABI is worth inventing, or if a key-type is sufficient. To Peter's
> > concern, this key-type imposes no restrictions over what sevguest
> > already allows. New options are easy to add to the key instantiation
> > interface and I expect different vendors are likely to develop
> > workalike functionality to keep option proliferation to a minimum.
> > Unlike ioctl() there does not need to be as careful planning about
> > the binary format of the input payload for per vendor options. Just
> > add more tokens to the instantiation command-line.
> 
> I still think this is pretty much an arbitrary transport interface. 
> The question of how frequently it is used and how transactional it has
> to be depend on the use cases (which I think would bear further
> examination).  What you mostly want to do is create a transaction by
> adding parameters individually, kick it off and then read a set of
> results back.  Because the format of the inputs and outputs is highly
> specific to the architecture, the kernel shouldn't really be doing any
> inspection or modification.  For low volume single threaded use, this
> can easily be done by sysfs.  For high volume multi-threaded use,
> something like configfs or a generic keyctl like object transport
> interface would be more appropriate.  However, if you think the latter,
> it should still be proposed as a new generic kernel to userspace
> transactional transport mechanism.

Perhaps we can get more detail about the proposed high-volume use case:
Dionna, Peter?

I think the minimum bar for ABI success here is that options are not
added without touching a common file that everyone can agree what the
option is, no more drivers/virt/coco/$vendor ABI isolation. If concepts
like VMPL and RTMR are going to have cross-vendor workalike
functionality one day then the kernel community picks one name for
shared concepts. The other criteria for success is that the frontend
needs no change when standardization arrives, assuming all vendors get
their optionality into that spec definition.

keyring lessened my workload with how it can accept ascii token options
whereas ioctl() needs more upfront thought.
