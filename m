Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2765769FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjGaRsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGaRs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:48:29 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF19DC;
        Mon, 31 Jul 2023 10:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690825707; x=1722361707;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=S/Zq9x1YCmFs9svKikh/LlFhJJx6vIdxCIuNMf+W4Yw=;
  b=R6rgTWOYUTI5GXddStce8IdILD6QtokALHunGQklgJSOvttyNMbx+PHO
   80WPJuX2pmVt29LTYzZTdD8eY8O3TbCEKg/52GsxcpZKb8se9sZT0ByFI
   WkkXEjomX85d7wiqZSrXeoy27Bkk8VP8j0wy6XkwsFP1CWAX8M60QEBNt
   thm1BbDdTdOmGiL95DDzJ2ZeXu9PLTBso4IAWJq/UNiymYKuK4mkUifDf
   xMELfBMHTAuSeSmvIMvFmoBsMalL0GqGENtHUn1n2JyBZnfqw0A7flZFF
   zQw/VeMWugXmjUwDIuL9+7+Bm3FJMmTcqbkRfsqBtwiNBbQouKWGJkbW1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="369094589"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="369094589"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 10:48:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="763458942"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="763458942"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 31 Jul 2023 10:48:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 10:48:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 10:48:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 10:48:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIeDepaS5zw3jjF1M6coBlmGPnhoHCZ9qki3hpSzu+rE8fG1tMuKxYlga0WfsNl+GklbJuJ6p0HHz0ZZ9y20p7CVUgAcXyllBPt+wj+1WOggHjaRQ/tQq7KyW0ndGX4gc7HZOet+bbJWo++RRv9Pwhrbuywn1scf/bQ3sZ0ys8F7i9YNtb4ZCjp97SLt7vsgRtMq9+FCBl417d1DeIDsniL0e3bjU1lkRnBC5HY2Hq25+Gx/QovECK0Wgaa9kcJObPQzxhU+2eblXzVVw3BiTA7Sw5ag2e2MMUsR0fFYrIIZbZuvaupRw9TyCh4YvZg+dt/T5EEVl7BUngJTeK8sFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKkTa/P9NLcwkCAmBFNjfeif+mf65dIuDvAkOknLkI0=;
 b=CXvp2FuQrAbBkF63nR5Sj7CfarTIZPcxRZgO3kxecnxf7o9amKc69UAIfIDrmAHnwqLbzd+ZXCGcny9xn7oMJcaYBe2or9rUQm50RRUirAgUV6GpsGxRX1pbgNUaijgLyu2jgFC5C8JQw9Z3Aucn7ggiiUFs7eNwXP88SIe14gE9Rx+89Cj+rZRPVUXYhp+5dhAbMHGrYFUmM+K3pmDPtrRoBBnI8RPUQFhGQHrKXy/WFeUxP97T0G+c6Bux647EF6QGZ+vySD1GvGZDsJ6DqEhAr8k7MjrF3QmzHNW8xa3JZdqnaUlmy3TmIUBUV7s/5fJkuLWJWZX/VnJSZVYZBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6124.namprd11.prod.outlook.com (2603:10b6:208:3ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 17:48:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 17:48:18 +0000
Date:   Mon, 31 Jul 2023 10:48:15 -0700
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
Message-ID: <64c7f3df475d5_51ad02943f@dwillia2-xfh.jf.intel.com.notmuch>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com>
 <CAMkAt6ot9zyUL9Ub-qYq+d9v-6rTft4ea2mUxp3o1s3GVFq7nw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMkAt6ot9zyUL9Ub-qYq+d9v-6rTft4ea2mUxp3o1s3GVFq7nw@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0352.namprd04.prod.outlook.com
 (2603:10b6:303:8a::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: 7806bc81-23f0-4201-e680-08db91ee5300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RR9h6cNbcRdivnDQEeS5o5rzb6Skj3LHRDYGO3NscwCPQ9bonJYO0ATlj8Ti1l+sqY0yVXmJdvWJy5v4bghD2O6q5d40Y4qohcfNr9VweBnQvQDO2p8Epj63/ik3MyJDg9SDR7U3EtjG0PRT4K9pysIg7XnmqxLPAiXBuw4TTnxlI7Ex7O/QKgL3VNvhZV1j3wD61Vnqf1OkEehACmSoSaU8rv00jZddT8a+cs7gGrm+JXjyjCmhyh6bDu9m5EWmFv4kZ+QeVXWQ2ycA2w+98U5sj4rCDE9l6zheHTxi1HxYwZ1zd450c6ctC5zo1dwW2bCdI2Urrav/u0IByjMhfIIezBEvMd1S+yaBpt/ZgDrDnR5qUwa907LBj52HZ1alzFpFUqIyTkiBVDGvNGfXPjBJlxsmnypmCIT0sL4qfj+WndovC/dnbldnswSIRQCRnBj4QFGYyRS03vNLMieK5/EceELMZD18ZBO04rq/mbDrLvRNnr2tPjl3gyAXhEyzprFEBz0C14lyJLrlLTTEnPlKBSkwM9Q2RVFTjOFxzKRPY2Vb9lFaz4w0K7fVpXwazGkT5h7DsukTNnUzU1Ie7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199021)(478600001)(38100700002)(82960400001)(86362001)(6512007)(966005)(9686003)(6486002)(6666004)(53546011)(186003)(8676002)(26005)(8936002)(6506007)(7416002)(5660300002)(4326008)(2906002)(66476007)(66946007)(66556008)(54906003)(41300700001)(110136005)(316002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWswU0NvdjMxb0hkTlZRUEdRN1lxMzQwWXdJUGdaL0UrcnJNcjBteGR2dndE?=
 =?utf-8?B?QVFQdThHMW9PU2JTd1pkcFB6RFpmVGNnVkhGUDdRNi9RNHhrczZCakVRNHd2?=
 =?utf-8?B?ejByL2RiSnI0L0hrWW9ZeDVoZk15Q0J1ZS9CQUlML04wQVBTaVg2anJlR2hN?=
 =?utf-8?B?dWxDaHc1VGttVEJ4SDZrcEw1T0ZlVXhlVHg0TUY2VUYxdExGd0MrVng0Y3FR?=
 =?utf-8?B?c1lneURqMGh4L3p5V09WTkhndkNtTUNRc1JOakZNMjRhSzdmUWdDbEVRQ3M5?=
 =?utf-8?B?UmR2QU9ZYzlscjhOcTgybkxUeG9LN3B6bzVvdjFiRXhpMEJVL3JlSk9SVUF5?=
 =?utf-8?B?cDlQN0lhOU95NjF4Qkw5dlo5K3JDaFdzM0dwblFsNFBIdlRzVHRsMmZuQ2V1?=
 =?utf-8?B?WW92UktzMi9acnR0cmdFZ1pINEpEa215S2NiRWE3L0hjYUMvbDNjT1pia0ph?=
 =?utf-8?B?V0JSeFJ6bytPN2wzMHhxUWlYVC90ZHdjZ1FBb040ME5DSVJtNUk4aWhOTmxv?=
 =?utf-8?B?YmV5Wm96ZnNneVp2L2lYSE5vN3NXRjc4cjFsN1N4K2doREZDTHhmUG96SnYz?=
 =?utf-8?B?elZsTnhKYzBqVU1jeW1OeStrdWFFQjhvaTJQWWRubE02cS9hbHVKZEVIM0xF?=
 =?utf-8?B?TjVKa0VXbHpnczd6cUlRTVRja0lLSFpzdVNOYnRDdzNFbFN2VG9JbWdneTdh?=
 =?utf-8?B?YlRweG45aU83bmlaYmlpSlpZRjVucURPUElWR0VHZUcwY2lUckJhWWZuM3Ns?=
 =?utf-8?B?K3BBam1md3FQUnI5c3JwWEJKLzROTW9MZytpbHRScXZsQktCbE1vQnV5UkZs?=
 =?utf-8?B?ZkhvQmM0eUdWeEFRSmNhTU9wZnh6ZC9Hdlc3OVpEeHE5amdJSWxSclBzY3Az?=
 =?utf-8?B?L1o5M3A2ZXdyMWxBZmc2RllkdnlNalR0UEVTeGk3dGU5QkQvMVh1UzZ6ek0w?=
 =?utf-8?B?UE9uWDNHZHAyUUpNUHhaNExSUHROeG5KUlh1Z3ByRjdUbnY2T25KTGp3bGdP?=
 =?utf-8?B?ZGMyMFl0MG80SXh2ODNWS2g3L1ZjckI4Q0NFclhyV0JGbXVTeVZzdUpPQXl2?=
 =?utf-8?B?eVozR1RnVGp5SnNQUjdXUmlEYjFWT1VsK091b095MEJkbmtZUmVNcjhxeHZQ?=
 =?utf-8?B?Sm9iODdWdjEwMmU0b3lQUVE4Y0lyb2VrUEVHT01OZ011RXQzSTRwUmliOEht?=
 =?utf-8?B?czhQWndyY3RVc0dGVXQ5RTR6OC9RMklHNTQxMHVma0J0eDkvb01XUk8zNmJ2?=
 =?utf-8?B?V2tPaFkwaEl1K1FJWk5YVk10ZGpJbERCcmlpR0h1dTZhQjZyWHdlVGNTWlFx?=
 =?utf-8?B?R1FhUzNGcHRqTTgwbHkrc09yZUl6WEJveFJTZFBBdzd0WkpPZUEvUGk5OHNW?=
 =?utf-8?B?MUc2VlhleTA5a2UvR1VMbjNrVzU5UVVqZnBCK1RMZXBmaCt2RmprQjdGUjhq?=
 =?utf-8?B?cjByVXZpeEJiZmk3elpMUjdxUnRNdTZSODc4ajNadXhWeEkwTDRJRGVuckR6?=
 =?utf-8?B?UCtVZHNZOXcrZTFSZFJSZVJDZHJzVXRyRWVNei95eXdMa1RVbnRhYlVxdXRm?=
 =?utf-8?B?dGh4MmdpSXNoVXFXc1Ayc2RVd1B5SmZRQ3g3ZzVzeTVZdGVZbjJEU2ZpZTF2?=
 =?utf-8?B?UGJxY2NoQ3RvZFI2aTNmeXN0WU9WMDZUN0hCczBPOFVWN2xYWXJlVXM1MlAw?=
 =?utf-8?B?YitSL1ZFMXROZ0JMYmdCc2Jqb1hLZWsyZGdwWkxqU3JUWGlDNXJndFc5UlNl?=
 =?utf-8?B?L29KZUh6NTd6b1R3WE1zSUxyQVY2MEsra1VGdGJuS2xHNmczM1czVkJsZHV4?=
 =?utf-8?B?REtVL0RYbU9kaHJDMDhtWm1sWUdNYXZpUERFYlNGc01ZTk1zU3BGV09CaTQ2?=
 =?utf-8?B?L3ZPd1NnQzluUjlsK2dVQSsrODVhM0I4UVJnZ0hWRGFZNFlzZTMxaGdWTUFK?=
 =?utf-8?B?NUxvSisyMG1aeXNJZmorNnNRdlEyVUJwNWdhc1Q4b0lEQXVTT3JlZ1gyelFl?=
 =?utf-8?B?MDNKK200UWU0c0hVNGZXQVVMT1B4a215NUFxUWk1MGZIMlJaekloM251dThu?=
 =?utf-8?B?YWM0RWR0aUJLMjBIdStGV05zSGJQeHRPcGVBaVdVeVNZd1Q3V1Zsc0dkcFRM?=
 =?utf-8?B?bDhvY1VwN0NvOEJ5WkQvSHV1NTZvNHg3YU9XNnZrcEEzM203K1grK0R5bXJP?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7806bc81-23f0-4201-e680-08db91ee5300
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 17:48:18.5098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jK6ecCXrloYUWn6Vf0ivYxRKW2e+XKOuQfSSsO2Vbhych/yjqFuOOXrqzx5XTpejmwOVZpurP8YaJJF4SdWVGPehr8b1Wc7hjf+3e136K2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6124
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Gonda wrote:
> On Fri, Jul 28, 2023 at 1:31 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > One of the common operations of a TSM (Trusted Security Module) is to
> > provide a way for a TVM (confidential computing guest execution
> > environment) to take a measurement of its run state and use that with a
> > key-exchange protocol to establish a shared secret with a third-party /
> > remote attestation agent. The concept is common across TSMs, but the
> > implementations are unfortunately vendor specific. While the industry
> > grapples with a common definition of this attestation format [1], Linux
> > need not make this problem worse by defining a new ABI per TSM that
> > wants to perform a similar operation. The current momentum has been to
> > invent new ioctl-ABI per TSM per function which at best is an abdication
> > of the kernel's responsibility to make common infrastructure concepts
> > share common ABI.
> >
> > The proposal, targeted to conceptually work with TDX, SEV, COVE if not
> > more, is to define a new key type that produces a TSM common blob format
> > and moves the vendor specificity inside that envelope. The common Linux
> > definition is:
> >
> >     "<hex encoded pubkey> <blob descriptor> <hex encoded attestation blob>"
> >
> > This approach later allows for the standardization of the attestation
> > blob format without needing to change the Linux ABI. TSM specific
> > options are encoded in the frontend request format where the options
> > like SEV:vmpl (privilege level) can be specified and TSMs that do not
> > support them can decide to ignore them or fail if they are specified.
> > For now, "privlevel=" and "format=" are the only implemented options.
> >
> > Example of establishing a tsm key and dumping the provider-specific
> > report:
> >
> >     dd if=/dev/urandom of=pubkey bs=1 count=64
> >     keyctl add tsm tsm_test "auth $(xxd -p -c 0 < pubkey) privlevel=2" @u
> >     keyctl print 280877394 | awk '{ print $3 }' | xxd -p -c 0 -r | hexdump -C
> 
> What is the purpose of this report? What does it prove to whom? I'm a
> bit confused because it doesn't seem like there is an ability for a
> remote party to participate in a challenge and response to introduce
> any freshness into this protocol.
> 
> Also shouldn't the report have a little more context into the key we
> are signing? For instance what type of public key is this? And what is
> its purpose? In your example this isn't even a valid public key.
> 
> >
> > Now, this patch ends up being a fairly simple custom-key format because
> > most of the follow-on work that happens after publishing a TSM-wrapped
> > public-key is performed by userspace. The TSM key is just one step in
> > establishing a shared secret that can be used to unlock other keys. For
> > example a user-key could be populated with the resulting shared secret
> > and that could be used as a master-key for an encrypted-key
> > (security/keys/encrypted-keys/encrypted.c).
> >
> > While the discussion that led to this proposal hinted at a new
> > trusted-key (security/keys/trusted-keys/trusted_core.c) type rooted in
> > the TSM [2], more work is needed to fetch a secret from the TSM
> > directly. The trusted-key core expects a pre-established secure channel
> > to seal and unseal secrets locally. For that reason a "tsm" flavor
> > trusted-key is saved for follow on work. That will likely starting as a
> > wrapper around SNP_GET_DERIVED_KEY.
> >
> > Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
> > Link: http://lore.kernel.org/r/CAAH4kHYLETfPk-sMD-QSJd0fJ7Qnt04FBwFuEkpnehB5U7D_yw@mail.gmail.com [2]
> > Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Tested-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  include/keys/tsm.h     |   71 ++++++++++++
> >  security/keys/Kconfig  |   12 ++
> >  security/keys/Makefile |    1
> >  security/keys/tsm.c    |  282 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 366 insertions(+)
> >  create mode 100644 include/keys/tsm.h
> >  create mode 100644 security/keys/tsm.c
> >
> > diff --git a/include/keys/tsm.h b/include/keys/tsm.h
> > new file mode 100644
> > index 000000000000..61a81017d8f5
> > --- /dev/null
> > +++ b/include/keys/tsm.h
> > @@ -0,0 +1,71 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __TSM_H
> > +#define __TSM_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/module.h>
> > +
> > +/*
> > + * @TSM_DATA_MAX: a reasonable max with enough space for known attestation
> > + * report formats. This mirrors the trusted/encrypted key blob max size.
> > + */
> > +#define TSM_DATA_MAX 32767
> > +#define TSM_PUBKEY_MAX 64
> > +#define TSM_FORMAT_MAX 16
> > +
> > +/**
> > + * DOC: TSM Keys
> > + *
> > + * Trusted Security Module Keys are a common provider of blobs that
> > + * facilitate key-exchange between a TVM (confidential computing guest)
> > + * and an attestation service. A TSM key combines a user-defined blob
> 
> Are we limited to only doing key-exchanges between guests and
> attestation services? What if some user would like to handle the
> attestation verification without a service?

From the kernel perspective it does not matter, it is just marshalling
the quote data. I assume local attestation could be built around this,
but that's all user-space policy.

> 
> > + * (likely a public-key for a key-exchance protocol) with a signed
> 
> key-exchange

got it.

> 
> > + * attestation report. That combined blob is then used to obtain
> > + * secrets provided by an agent that can validate the attestation
> > + * report.
> > + *
> > + * A full implementation uses a tsm key to, for example, establish a
> 
> Should 'TSM' be capitalized everywhere? Or does it not matter?

Probably should be.

> > + * shared secret and then use that communication channel to instantiate
> > + * other keys. The expectation is that the requester of the tsm key
> > + * knows a priori the key-exchange protocol associated with the
> > + * 'pubkey'.
> 
> Can we instead be very specific about what protocols and cryptography
> are being used?

Again this is a contract to which the kernel is not a party. The
requester knows the significance of the user-data, and it knows where to
send the combined user-data plus quote to provision further secrets.

Not that I like that arrangement, but the kernel is not enabled by these
TSM implementations to know much more than "user-data in", "report out".

> 
> > + *
> > + * The attestation report format is TSM provider specific, when / if a
> 
> I'm confused about the TSM terminology and what a TSM provider is. Is
> TSM the confidential compute framework of the vendor? So for Intel
> this is TDX, and the TSM provider is the SEAM module?

Yes, I borrowed this term from the TDISP specification where the "Trusted
Security Module" is the overarching term for the confidential compute
infrastructure for the vendor. Yes, TDX + SEAM is a TSM and SEV-SNP +
PSP is a TSM.

> 
> > + * standard materializes it is only a change to the auth_blob_desc
> > + * member of 'struct tsm_key_payload', to convey that common format.
> > + */
> > +
> > +/**
> > + * struct tsm_key_payload - generic payload for vendor TSM blobs
> > + * @privlevel: optional privilege level to associate with @pubkey
> > + * @pubkey_len: how much of @pubkey is valid
> > + * @pubkey: the public key-exchange blob to include in the attestation report
> > + * @auth_blob_desc: base ascii descriptor of @auth_blob
> > + * @auth_blob_format: for TSMs with multiple formats, extend @auth_blob_desc
> > + * @auth_blob_len: TSM provider length of the array it publishes in @auth_blob
> > + * @auth_blob: TSM specific attestation report blob
> > + */
> > +struct tsm_key_payload {
> > +       int privlevel;
> > +       size_t pubkey_len;
> > +       u8 pubkey[TSM_PUBKEY_MAX];
> > +       const char *auth_blob_desc;
> > +       char auth_blob_format[TSM_FORMAT_MAX];
> > +       size_t auth_blob_len;
> > +       u8 *auth_blob;
> > +};
> 
> How is freshness incorporated into the key exchange protocol? Wouldn't
> we need to do a challenge response between each remote party that we
> need to attest the provenance of @pubkey too?

That's left to userspace.

> 
> > +
> > +/*
> > + * tsm_parse - parse the tsm request data
> > + *
> > + * input format: "auth <hex pubkey data> [options]"
> > + *
> > + * Checks for options and parses a hex blob of data to be wrapped by the
> > + * TSM attestation format.
> > + *
> > + * options:
> > + *     privlevel= integer for selecting the privelege level of the
> 
> privilege

got it.

> 
> > + *                request, if the platform TSM supports that concept. To
> > + *                date only SEV accepts this option. Default 0.
> 
> SEV-SNP or just SNP? Plain SEV or SEV-ES doesn't actually support this
> interface at all.

Yeah, I was using "SEV" as a shorthand for the AMD "TSM". So maybe just
"SNP" is appropriate?
