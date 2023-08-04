Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D76376F88D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 05:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjHDDyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 23:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHDDx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 23:53:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3076F2D45;
        Thu,  3 Aug 2023 20:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691121237; x=1722657237;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=9ns+1C5VLaHkHezkrN1boeMkYxKECerzRrxgn/LByik=;
  b=QQEbZfmNcp8E5emaSWu/QFZPSgOvWlp+FFWj1CR47Hf2FqjSxOcNtwuE
   moXMvgLHOKteGGAebMbNFnZbupSVhuP9y/urRRCcZ4YLSp/B7IToWwCR4
   u7JVidtgD4/un8cYxo09f9j1JNcC4iOjqIy+e8t/UhoB+niVjINtgnYY8
   +F36XD5KpQAHyaw82CkIFiZr7lUs4vTcmlNSMyNGHRaeysJxxrF8frbQ6
   3epR4Eb5ilqrYOcQP8KLaRUe34zp3YwBMXTw+jaK7zCswXLO9UrVo7aAW
   yaT0kvzXyzMgG5/qrEQR1eXqjTkUbaHmZrvRsk5/KI+GVkhTQVsPgUa/l
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="436382710"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="436382710"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 20:53:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="903715350"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="903715350"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 03 Aug 2023 20:53:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 20:53:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 20:53:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 20:53:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 20:53:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdeWWJXI8zqotjLzjEw/iOBQXBYa5sqWEnAEiYmbrEWjCTxU4hICN3aiujhjkhs8S0QXGI3TEH75uimt9EVuJWLK1ZlE870DbCECAYtZSJcK+IzSm7/af/UoyhWh50lt6ryNvko+FJo/3lf/eI3gFAOqAOFbL/vH21peJ62ouE2A7baYBeefMxDnhWuTbEdnWETA0OOvLU6NUcE6vM+nDcaQ+jrkcB7fCx8T4cSVl6axbEkx6vQxsjCx+m4TFaqCJbLPVUoCS5HH4GzUngdTafsBQvmJV6AnvDJNI6utTGBqZJJDyl1szVyn6U5yFrpGM0sXEx5cntI8U1xZNTJcSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkflHG9A9h18ha2FgewvKfPNBwUSZeOUNLGj0U8sLwo=;
 b=Pj8eEuNgjfy6k3fBmOgDiROMy3pHuUBhVrzf3tRtQwLfnd0vvTBno4iHO9fRo460+bDZc8trXeKi4/l33FaLjDbVaDN3Qw6BD7ize1wauUtkYWXit0Yv+V6X9XIvLIiEKK2yVffokX2HS4sQgihj0Jp/fIXsyw2bBBD9bLqe+Mn0N7TNx31bqyBy3VoYZ3IRMZC6vEiJa1G+rawwOUOj04r9JYFDY1RbJWUhF03RJf1roadbIewY4Nt0DdSBqMonpRcU2FU2tjGZGBoi706h1AAMzcxFJVWNWOIIKhUkYx5us+6jOBzOQ1/AEkXV614WmoFPWIa/riyQol8ZZOiC4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7626.namprd11.prod.outlook.com (2603:10b6:806:307::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 03:53:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 03:53:47 +0000
Date:   Thu, 3 Aug 2023 20:53:44 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
Message-ID: <64cc764848504_782a329438@dwillia2-xfh.jf.intel.com.notmuch>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
 <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
 <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
 <6dec442c64faf2fecd21bcc77e4a6350e88948b9.camel@intel.com>
 <55cec220f20c497925f46074fc70eeccccff61c9.camel@HansenPartnership.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55cec220f20c497925f46074fc70eeccccff61c9.camel@HansenPartnership.com>
X-ClientProxiedBy: MW4PR04CA0070.namprd04.prod.outlook.com
 (2603:10b6:303:6b::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 11180427-b3ec-46b7-e92d-08db949e67fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sdp1/DNYfv/YDBo7vda2OBegltgWHREFEDAXqn3FCaKpVHT2sViXt7nQk5d7XC1MAeSrJ8BhRY/5NJDKuE51Q06GUeXjHK4UCGhXvVs3OGWhMYltZv8w3epOdAMjuR7C8t2B4ITmcOYmI9+pgb94ApoOuDZ1NUJJoHo5ILYjVvbTTE78KeaD9gZXlsg2QP6SFNL1aI1s05Tqx1kFAvYUJ/m7dnLK/zdKdLX+ETNx8xA/j8VClheFQvsb5u5jO9mWa0uWnzk9Zo6m4xxUcnnhUVSICY+Hqd0rLUNdmbozCQ/1YxiiF3xrsQBHFkqi7oySwuokcHuVktSk4vaqF/FQs10Jvre7/CQZaYJFgeYJnIb6It4tM/w1aRVnCG3L6QM4HkfaSZce7aw3DTw2to1JTFDMkGQoKefGO8Lz5j03cvLFRtUFALC2EJTU2BMeHnm+amULo7HrDYGITUF7TuwdPZmPLoRRgW2Ar7RBDBX+4oYQDiLI1rOebLRGHMWIbOkVRRS1KBmQN44Aj0yJUVkVD/dutWSCcn1WFdCgQ6lUcxf2EtxachOMeaQXAP0YmTsg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199021)(1800799003)(186006)(8676002)(26005)(6506007)(83380400001)(66476007)(2906002)(316002)(4326008)(66946007)(5660300002)(66556008)(8936002)(7416002)(41300700001)(6666004)(6486002)(9686003)(6512007)(110136005)(478600001)(54906003)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?S+N3EGxFAh/6gg4nnyRrZzDSxaPwMFsELnWQWFkvcwzXJ3aPl0sWfHSR7h?=
 =?iso-8859-1?Q?WCvPwNiYDNtv23gAUj2JKA3Ixc42cQlocpWMtahm4N4aoYugcN1KS2v3DR?=
 =?iso-8859-1?Q?RWrDCp9jLEQA5WP75vS+4YdV8fEnmeheoWaOsyR70GXwrnavvvZUstadLe?=
 =?iso-8859-1?Q?4aM5f/hAv/MvnbRwe15k4zMZaZLxD94JMn0szdBlS90sRy7q/SPYUAGzHx?=
 =?iso-8859-1?Q?YJke5JtKkbIp6keV1mw0D5gsHKVBz+rMJntq8CYrgGcEL4VJK4haXh00dg?=
 =?iso-8859-1?Q?RJARPBylcNz326+uovc94BE2G2ae/ZBabBX2fLgdCpePgwIxJkLkdfkFi0?=
 =?iso-8859-1?Q?ts07sF0Mk9eBXCDmot3wELuScbEU0NbJ2Ro13EEXE+r8sU8WJiF4mv18eV?=
 =?iso-8859-1?Q?xuPsT67aHub6GA4ShrOMVYOr62Ets5J4hYfctw/q87Th8Gg1ytahsDTuLc?=
 =?iso-8859-1?Q?P7s/N6rFKrPe6EtepyN31PEAaXxMOHgehjoQOdmz5/g+lTs0HGrgGEdfBK?=
 =?iso-8859-1?Q?iI0zjtMhLgUV8umgyEpV+q8tjpks5D3DpYYe8/hLGPWud1I29X03iF+AwZ?=
 =?iso-8859-1?Q?fFR+MLFUIZN/XfA8mMhFy2/rQv6kWMfA9JslkoDORLZPAOWUBDClCwFXwy?=
 =?iso-8859-1?Q?tmS2oH8kITZ3h+rP6TU4NOoG5GfMOhtneqLhH11yw2mLErvAZ1/OJYf1b/?=
 =?iso-8859-1?Q?b0cSX0m0e++uWcLU5yJ1xBLoRZR4F98CIJ9ga9YhgZdU3B0pMoqhxRpqBu?=
 =?iso-8859-1?Q?qIxX4HaL0iDa8q8IXq5H/Vl1auUawg2ZPcUoJkzPslqs7T9R7H1tHSGLvC?=
 =?iso-8859-1?Q?xkoYtRRTo+EWcrHK8mr2s1/Y7hX0h7Ud6QwphdTBbfeNx3JGq+kns5qILM?=
 =?iso-8859-1?Q?+NxLOhPNtxhMBC/h+07amXDUfn24jcMzafZKPet0QurCiT4ZtHOUkOwYQ1?=
 =?iso-8859-1?Q?r2ygOdtthuaRO50of6udIdoxbBvxYukyA2xBN3v5U57+wp/sOgGFZaKPNO?=
 =?iso-8859-1?Q?0Mq1qI1HY1VeukgPkF6d6K7BySwlSLyXsQwc/ZxtBj0kc27lzdk50uyk+O?=
 =?iso-8859-1?Q?sO3rD4U9y7/pPinDe9dsa5hlAUYlQwjXbiH4JROK83POiTt/+S25jP2t3H?=
 =?iso-8859-1?Q?OxBpBjWZvfCrnCLCOSP91x/8IFMG8vmN9LPq7+jHIoJ56nf1We8p6UXQT0?=
 =?iso-8859-1?Q?mars4gsJPk7ilLgD2HBCgl5nvYC5sYMqrbvUls+KHiXZ7GvQJbHMl8VseE?=
 =?iso-8859-1?Q?E9Zraixvyij3Jc3ZIEBHXZbKB1DJHFbmvegMwy8tavxbpX0N/0RVvF6hXA?=
 =?iso-8859-1?Q?+5+sbcQ2tLmHgWu4ANK6J5aSiLNwFzEDU2HsTNKihsH8x4Xj+Yjt7uPxDK?=
 =?iso-8859-1?Q?XJ0j3DqGLYl3A6gPO+j0Hkb9tXrF7jfF0vEI4U9vHX7EWod4cslIC/Xdci?=
 =?iso-8859-1?Q?FN623p6TV9uzhxlmE4CpEGkm3r+wC8g/XIlavpLLGXl+ItjSfuNc3XGBrI?=
 =?iso-8859-1?Q?g8N4YGfu2GwUZyLOqEUmbKWiVexb7aCU7os0iRtFRRhhXEz62IY8LXOQnf?=
 =?iso-8859-1?Q?Ghey+UqfFtrq9EEE8pLY+mQwas6T652XrxeOiI5PzPdJm7dT9z197qNA5K?=
 =?iso-8859-1?Q?0eqToYZ0xBdtHfb9tXw6iclgWgPTbkAu4J3JwnZqwxrPIp8id9vk62kQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11180427-b3ec-46b7-e92d-08db949e67fc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 03:53:47.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0WP1SI6n3B5kJQcg+o8GofvB3IPX6U2DrUAxYmTETGuJRVSctkcVCKyJwGq2cT74d1eVEXLmYmCIaG/jUPOWBKMlxHr4Co1cCVbyvoxYMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7626
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Tue, 2023-08-01 at 11:45 +0000, Huang, Kai wrote:
> [...]
> > 
> > Sorry perhaps a dumb question to ask:
> > 
> > As it has been adequately put, the remote verifiable report normally
> > contains a nonce.  For instance, it can be a per-session or per-
> > request nonce from the remote verification service to the
> > confidential VM.  
> > 
> > IIUC, exposing attestation report via /sysfs means many processes (in
> > the confidential VM) can potentially see the report and the nonce. 
> > My question is whether such nonce should be considered as a secret
> > thus should be only visible to the process which is responsible for
> > talking to the remote verification service?  Using IOCTL seems can
> > avoid such exposure.
> 
> OK, so the nonce seems to be a considerably misunderstood piece of this
> (and not just by you), so I'll try to go over carefully what it is and
> why.  The problem we have in pretty much any signature based
> attestation evidence scheme is when I, the attesting party, present the
> signed evidence to you, the relying part, how do you know I got it
> today from the system in question not five days ago when I happen to
> have engineered the correct conditions?  The solution to this currency
> problem is to incorporate a challenge supplied by the relying party
> (called a nonce) into the signature.  The nonce must be unpredictable
> enough that the attesting party can't guess it beforehand and it must
> be unique so that the attesting party can't go through its records and
> find an attestation signature with the same nonce and supply that
> instead.
> 
> This property of unpredictability and uniqueness is usually satisfied
> simply by sending a random number.  However, as you can also see, since
> the nonce is supplied by the relying party to the attesting party, it
> eventually gets known to both, so can't be a secret to one or the
> other.  Because of the unpredictability requirement, it's generally
> frowned on to have nonces based on anything other than random numbers,
> because that might lead to predictability.

The kernel could enforce that a nonce be provided by some convention,
perhaps a user-type key of the same name as the tsm-type key.

That enforces that the payload is always combined with a nonce to
discourage insecure practice building a system that just conveys a raw
pub-key.
