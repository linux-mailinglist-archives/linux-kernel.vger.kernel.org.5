Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE4A7CD584
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344470AbjJRHcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjJRHcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:32:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3699DB6;
        Wed, 18 Oct 2023 00:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697614348; x=1729150348;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4jSu6jrcpGK3APCkYhv0KPzFiklTZhIdt0DrNMu2+mE=;
  b=L55FekwznrmAHc5Uj8DTp/vTeB+TdfZxaHsbvktRFPlYihCXrQwA7X+4
   czLBOkC9MQGZVSm9QdeCzzMuSQdrDixuk771fcsLJbJ42ABGhqhtJ7Lvm
   P7NM/M6Z7S0tHCj786oMrffsVbH6BbXCh19Q0YN3/VNJN1M406XB6DdRU
   PQs2roxtDq0alGSKaYpJNsWERivGCbKXUzkuJTad9LHw9kiOoT+S9wRAP
   Zo7XTyByAESoz1XsyHjLbCN6y4EwwYYHusAqgMkfzE9s/xQnWpQ8KviOY
   0BQMj5dniYlHjNSM62F5ADPkpqwmp2Q2FHsYFNZs4kPgWl49CjYy7+Ezw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="417074603"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="417074603"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 00:32:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="826764041"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="826764041"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 00:32:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 00:32:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 00:32:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 00:32:25 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 00:32:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6FgRUNF/UCaUT63g+GMqAIL13icabtIhFz6+xEwXN3VO+6GGX49k0iEbwcaQho8s/kKOWx/itO/WBGxkwz2i80dsDv5LCJ8A479NS5Wl6G4BwXRAUt2gLOB1mHEcq5mmY/GWoQNlZ4Pe8ZX9sVs6xPVHwGRYtnbLkOymfMDFR4SkQEVsbqV7aGIVE59XpTk0tMz1lmqisS2kFqyie6YdOk4HY+F+1Jaw0PudwhIBbJHHqOOOfuJvN0PgNtNRMB8ZtxtRT1thno24NTSWKt99nBTE27G4RShC87OQeo++IBIFY7JhH7vmQvymMqRt8SYu1HYOuyfJZnxTDCI81f18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Zj50TLjUl4fBrQ9XLSi7veZPd807F6xFrPNen1469A=;
 b=H9hp36bgUaH502Pwzoff0XbIgcZfSOP6qpI13D0hyscfsSIUPdDveCHHnPr4BS4g0/iqzsOqNqZg3AF/JY2iLYjeHWtZ47A47opLaBVWUO2dRhN+c+DNt9JmVhQGPqVpreCrCcio02u85d1HUd+OyqOc0sDfBwPV/2Qdqi7uzr3bMgeMbP0Gh4ZDj0NATmHuWJjnkg4zeeY1zTq/rTrY4afP74OXXq+XQs3HGxUGkbJitB8awjDGycDyceA8tHpxzAEF0M3hbOZJjkff2eELVvRbZ6OB1qkhjXByonF48n5DVQqRPetpnaLnoUPzBRJaBXi3qyDj7BD9ck32n9074Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CH3PR11MB8466.namprd11.prod.outlook.com (2603:10b6:610:1ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Wed, 18 Oct
 2023 07:32:22 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17%5]) with mapi id 15.20.6863.046; Wed, 18 Oct 2023
 07:32:22 +0000
Date:   Wed, 18 Oct 2023 15:32:07 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Dmitry Safonov <dima@arista.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Salam Noureddine <noureddine@arista.com>,
        David Ahern <dsahern@kernel.org>, <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        "Dan Carpenter" <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        "Gaillardetz, Dominik" <dgaillar@ciena.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        "Nassiri, Mohammad" <mnassiri@ciena.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v14 net-next 08/23] net/tcp: Add AO sign to RST packets
Message-ID: <ZS+J9yVm2ezCf6js@xsang-OptiPlex-9020>
References: <202310171606.30e15ebe-oliver.sang@intel.com>
 <bd0e29db-c8dd-4d1a-a898-69e0b8e6dc54@arista.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bd0e29db-c8dd-4d1a-a898-69e0b8e6dc54@arista.com>
X-ClientProxiedBy: KU1PR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:802:18::15) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CH3PR11MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ae2591-83cb-43fd-2835-08dbcfac5dbd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jL8AjcdNpD8ZxGEJTVDPlLlHxdBQhl5RUI2qJpWIDN7RyJc1dfXeHGut7l8uMqO1ugtOp1+gA4UKyzTmWJ0C9AOdiJOxJ+mhooNpqwa1wn3NgEK5LZgmCJ05eD1VekE2waAknxqmKKNoO1BrOFQLfSScjgwTNdIRhjVNYCxhbPL32xD2cWGO6ICZQZ08e40VckCna4/hwBqHQoaISBBbVk98hKF9gBcLm5f2BFaQ2s/4pkv/R5K8T3VipovZ0g1QMVMo6Qv2Q3brlODDqRwM5MCRPlwMbILepTxcDHGcMuQWoMULgroIEf3qnfpJl3pOH4RZuMx3uuWWPMND+AFZiQQduylr5SFyoqzzAm+EUEDIKFGcbRw8Vuu0JNAqTMCznJtdPAffwlgFH/MRNgwd2S5I2GG1knvert70opqifEG6Z17fyaf95TPhitiyJLZaUGZ+xD62kblyeZcwsBhs644iXHCCivlB572LeJkL5PQ3LWu7aKFMNiRf728hx2bsMYxFp3OryZmnBH5qs1APmzX8+mgxo/WKLLC4jOEbz4Q1nikgLVcLre4VdARKnNK02WasPw2YxVOdQMEbJqni9nKneZ6MsRTVda4VNAaQ4gKW6T7Sm1DA7AD9Oujf3mhJgvFQulxg+kFqWE/650tEuvLeYeavGxEVqf+m6H/JdLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6916009)(83380400001)(316002)(38100700002)(8676002)(33716001)(86362001)(8936002)(82960400001)(54906003)(4326008)(66946007)(66556008)(66476007)(45080400002)(44832011)(53546011)(30864003)(6506007)(2906002)(41300700001)(6666004)(107886003)(7416002)(6512007)(966005)(6486002)(9686003)(26005)(5660300002)(478600001)(67856001)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H8TXy4tEbZU9g5cvQYfFFD91TJF6oTNNWUBF7tMGHRmqvYThQ5iaxonY9n/B?=
 =?us-ascii?Q?mrRXVW0N0ACTLsDoa6Bk71o1lb7CT4coVjZRzlH7thHOBTivQ5THTXguTAnl?=
 =?us-ascii?Q?igJdTpkKAczSssRM3+oZ8KF8xnfl+AEsMreoQMc5pkcsYgBMmXI928Pl+C0V?=
 =?us-ascii?Q?sj+VtSIaYt5TD4Pk+CPo/JE1IzE5RpKNnUw1frQ+QAnuM6yYlOXm/KErUCzJ?=
 =?us-ascii?Q?Lb/DSaPM8mudZwlgfKYfpdDT/j1rxDFfL14szKeoICJQIkfAsIbQixkBIo8M?=
 =?us-ascii?Q?FX984qhtvWa9DEd65PCnH8ts26/O7W/YSfiwit29N0b+xBXGMwGyoEG3CV2c?=
 =?us-ascii?Q?ebnzhiSuSTFiM2wBkedyhe1KNbeRoQkbF0nsSGyTzRPvOSoBgRB2wZtZINST?=
 =?us-ascii?Q?DG8ReWsWgK9l+Huu5J5n0815eob8/Qz8qZWnW0GX7OE5+8lOFaIWD1SjD5ts?=
 =?us-ascii?Q?TTY2GuO1CB+TULAXq1ryWm41uwopVY7aKoPHEsCn4e2KlrRqHEaDhraXTbrk?=
 =?us-ascii?Q?6m3FIFzaaZiWqMxTwBtnHAhYlYdjfb2VZbU/WW+lJiz8+QGJhrfQNOuszdxT?=
 =?us-ascii?Q?cl48ejATMXAVWtKHxF7/ktZtv6fTV08sZfFvCSkm7c2GPPniLyua3mkvn8Fl?=
 =?us-ascii?Q?GaZi0+JoWM3MZGqQ6EgBf7CFXznMp+gn76e8aVArImZjeahcYypZvDkx/Lcj?=
 =?us-ascii?Q?Oe3uP5eFLGoNsAkk1GihNQAP5RcgQCeRc2DtOUPspyqlL8pzqk+siQTfp0Of?=
 =?us-ascii?Q?O4jr9RGtoADGHRRSmBfwH4nTcH6vQmQnhLB+J6PcZwFER4OfTavBqjj8FM/m?=
 =?us-ascii?Q?wtbkkl97R3+KLyOni60jaFadta9QrCCLqvXRywPDrQDS0TEQGgOueBWEfNG7?=
 =?us-ascii?Q?rsNyETimxTGPLUVDcgdOgRv+S+2ftdKqXZ0Pz+bhnAhEAhqjdhkguldmoF9g?=
 =?us-ascii?Q?1m5ruepponC4e1t5+nz22OQvacnhkQn0Hnnuw7lkica6W8+EqtLMHsNWyIRV?=
 =?us-ascii?Q?V5/rpy6oeyWtJA2pSvY0VpdhMN/s5w0rDGipT8v0qFEstWlyE8MWj9G7Ex08?=
 =?us-ascii?Q?t/1Sd93qWARkZLiy8kKsyz00pKI1Ny0YggbDE8rQ/DkC1eC+wj4Gdek9j4xy?=
 =?us-ascii?Q?KkiApMPjhMZUJ/Sb9hZRKuEA/uiHRpcZobqPU2tkA1h3jKnL5cQtCw0ww+8o?=
 =?us-ascii?Q?57YRPE2LyJZrFR+XmVA7RP9NoBQ5VodbAb6QOuFjVcplPRT8AXdfgLw9SmBC?=
 =?us-ascii?Q?W/w8jFpqkDrGB56XaF3rjxOk963hLncMJpeYPUuvedHA4HS+qPmNdvhAXWcj?=
 =?us-ascii?Q?kiFRGL6mdH/icAe6gcJ+elsSRWSt37JxEbtNK6XTpeGOEsi9uXbcLaADTeGD?=
 =?us-ascii?Q?ecmyStmLzW6US1byVzg1UaUrzUd4G0HlP7RtC4xnTBag054Aa6A94K3iSxPc?=
 =?us-ascii?Q?AIPW0HyXQo/fkflQErQAIRasc1z5ytxVIHvykmm5+g/3fAv42y6gXlOTyHlS?=
 =?us-ascii?Q?pcQsdawHVMTeQlPpDps3ge1BMUFr/8NgHEWKltcn0ntVcJZk9DQp64wuzCcy?=
 =?us-ascii?Q?Ctk4t+lATab5KmvDtgp+Zqt7I7FtWtjRZ1SdiwvwMeHoh9JGjF3JWavyzdHL?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ae2591-83cb-43fd-2835-08dbcfac5dbd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 07:32:22.0128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +W2HHBC9LsSvhoZcNMWlODggMfwylyT+lMTJ5feI4RSlP13D8sRY/lt02yaZf8nyDtk33EfGexbJrykjsAVsAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8466
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Dmitry Safonov,

On Wed, Oct 18, 2023 at 12:19:56AM +0100, Dmitry Safonov wrote:
> On 10/17/23 09:37, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_net/core/sock.c" on:
> > 
> > commit: df13d11e6a2a3cc5f973aca36f68f880fa42d55f ("[PATCH v14 net-next 08/23] net/tcp: Add AO sign to RST packets")
> > url: https://github.com/intel-lab-lkp/linux/commits/Dmitry-Safonov/net-tcp-Prepare-tcp_md5sig_pool-for-TCP-AO/20231010-071412
> > patch link: https://lore.kernel.org/all/20231009230722.76268-9-dima@arista.com/
> > patch subject: [PATCH v14 net-next 08/23] net/tcp: Add AO sign to RST packets
> > 
> > in testcase: trinity
> > version: trinity-i386-abe9de86-1_20230429
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	group: group-02
> > 	nr_groups: 5
> > 
> > test-description: Trinity is a linux system call fuzz tester.
> > test-url: http://codemonkey.org.uk/projects/trinity/
> > 
> > 
> > compiler: gcc-12
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202310171606.30e15ebe-oliver.sang@intel.com
> > 
> > 
> > [  221.348247][ T7133] BUG: sleeping function called from invalid context at net/core/sock.c:2978
> > [  221.349875][ T7133] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 7133, name: trinity-c4
> > [  221.351666][ T7133] preempt_count: 0, expected: 0
> > [  221.352614][ T7133] RCU nest depth: 1, expected: 0
> > [  221.353518][ T7133] 2 locks held by trinity-c4/7133:
> > [ 221.354530][ T7133] #0: ed8b5660 (sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_sendmsg (net/ipv4/tcp.c:1336) 
> > [ 221.374314][ T7133] #1: c27dbb18 (rcu_read_lock){....}-{1:2}, at: inet6_csk_xmit (include/linux/rcupdate.h:747 net/ipv6/inet6_connection_sock.c:129) 
> > [  221.375906][ T7133] CPU: 1 PID: 7133 Comm: trinity-c4 Tainted: G        W       TN 6.6.0-rc4-01105-gdf13d11e6a2a #1
> 
> Quite puzzling. It doesn't seem that it can happen to inet6_csk_xmit():
> 
> :	rcu_read_lock();
> :	skb_dst_set_noref(skb, dst);
> :
> :	/* Restore final destination back after routing done */
> :	fl6.daddr = sk->sk_v6_daddr;
> :
> :	res = ip6_xmit(sk, skb, &fl6, sk->sk_mark, rcu_dereference(np->opt),
> :		       np->tclass,  sk->sk_priority);
> :	rcu_read_unlock();
> 
> So, I presumed the calltrace was for nested rcu_read_lock() case.
> Then I've looked at all return/goto cases, I couldn't find any
> unbalanced rcu_read_{,un}lock().
> 
> Is this reproducible by any chance?

do you mean how often it could be reproduced?

we run the tests upon this commit and parent both up to 15 times.
from below, parent shows quite clean, but there are various issues while
running tests upon this patch.

8468a6f4f3143 net/tcp: Add tcp_parse_auth_options()
df13d11e6a2a3 net/tcp: Add AO sign to RST packets

8468a6f4f3143ba2 df13d11e6a2a3cc5f973aca36f6
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :15          87%          13:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_arch/x86/entry/common.c
           :15          33%           5:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_fs/dcache.c
           :15          13%           2:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_include/linux/percpu-rwsem.h
           :15          60%           9:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h
           :15           7%           1:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c
           :15           7%           1:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/rwsem.c
           :15           7%           1:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_kernel/sched/completion.c
           :15          40%           6:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_kernel/task_work.c
           :15          33%           5:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_lib/iov_iter.c
           :15          33%           5:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_lib/strncpy_from_user.c
           :15          20%           3:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_lib/usercopy.c
           :15          13%           2:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_mm/vmscan.c
           :15         100%          15:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_net/core/sock.c
           :15         100%          15:15    dmesg.EIP:rcu_note_context_switch
           :15         100%          15:15    dmesg.WARNING:at_kernel/rcu/tree_plugin.h:#rcu_note_context_switch
           :15         100%          15:15    dmesg.WARNING:lock_held_when_returning_to_user_space
           :15         100%          15:15    dmesg.is_leaving_the_kernel_with_locks_still_held


> 
> 
> > [  221.377820][ T7133] Call Trace:
> > [ 221.378447][ T7133] dump_stack_lvl (lib/dump_stack.c:107) 
> > [ 221.379373][ T7133] dump_stack (lib/dump_stack.c:114) 
> > [ 221.380186][ T7133] __might_resched (kernel/sched/core.c:10188) 
> > [ 221.381100][ T7133] __release_sock (include/linux/sched.h:2097 net/core/sock.c:2978) 
> > [ 221.381960][ T7133] release_sock (net/core/sock.c:3520) 
> > [ 221.382784][ T7133] inet_wait_for_connect (net/ipv4/af_inet.c:609) 
> > [ 221.383763][ T7133] ? autoremove_wake_function (kernel/sched/wait.c:479) 
> > [ 221.384757][ T7133] __inet_stream_connect (net/ipv4/af_inet.c:701 (discriminator 1)) 
> > [ 221.385741][ T7133] ? kmalloc_node_trace (mm/slab_common.c:1133) 
> > [ 221.386702][ T7133] tcp_sendmsg_fastopen (net/ipv4/tcp.c:1026) 
> > [ 221.387685][ T7133] tcp_sendmsg_locked (net/ipv4/tcp.c:1073) 
> > [ 221.388642][ T7133] ? find_held_lock (kernel/locking/lockdep.c:5243) 
> > [ 221.389536][ T7133] ? mark_held_locks (kernel/locking/lockdep.c:4273) 
> > [ 221.390437][ T7133] ? lock_sock_nested (net/core/sock.c:3511) 
> > [ 221.391359][ T7133] ? lock_sock_nested (net/core/sock.c:3511) 
> > [ 221.392335][ T7133] tcp_sendmsg (net/ipv4/tcp.c:1336) 
> > [ 221.393153][ T7133] inet6_sendmsg (net/ipv6/af_inet6.c:658 (discriminator 2)) 
> > [ 221.394010][ T7133] ____sys_sendmsg (net/socket.c:730 net/socket.c:745 net/socket.c:2558) 
> > [ 221.394927][ T7133] ___sys_sendmsg (net/socket.c:2612) 
> > [ 221.395844][ T7133] __sys_sendmsg (net/socket.c:2641) 
> > [ 221.396671][ T7133] __ia32_sys_sendmsg (net/socket.c:2648) 
> > [ 221.397562][ T7133] __do_fast_syscall_32 (arch/x86/entry/common.c:112 arch/x86/entry/common.c:178) 
> > [ 221.398485][ T7133] do_fast_syscall_32 (arch/x86/entry/common.c:203) 
> > [ 221.399401][ T7133] do_SYSENTER_32 (arch/x86/entry/common.c:247) 
> > [ 221.404363][ T7133] entry_SYSENTER_32 (arch/x86/entry/entry_32.S:840) 
> > [  221.405255][ T7133] EIP: 0xb7f59579
> > [ 221.405931][ T7133] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> > All code
> > ========
> >    0:	b8 01 10 06 03       	mov    $0x3061001,%eax
> >    5:	74 b4                	je     0xffffffffffffffbb
> >    7:	01 10                	add    %edx,(%rax)
> >    9:	07                   	(bad)
> >    a:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
> >    e:	10 08                	adc    %cl,(%rax)
> >   10:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
> > 	...
> >   20:	00 51 52             	add    %dl,0x52(%rcx)
> >   23:	55                   	push   %rbp
> >   24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
> >   26:	0f 34                	sysenter
> >   28:	cd 80                	int    $0x80
> >   2a:	5d                   	pop    %rbp
> >   2b:	5a                   	pop    %rdx
> >   2c:	59                   	pop    %rcx
> >   2d:	c3                   	ret
> >   2e:	90                   	nop
> >   2f:	90                   	nop
> >   30:	90                   	nop
> >   31:	90                   	nop
> >   32:	8d 76 00             	lea    0x0(%rsi),%esi
> >   35:	58                   	pop    %rax
> >   36:	b8 77 00 00 00       	mov    $0x77,%eax
> >   3b:	cd 80                	int    $0x80
> >   3d:	90                   	nop
> >   3e:	8d                   	.byte 0x8d
> >   3f:	76                   	.byte 0x76
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	5d                   	pop    %rbp
> >    1:	5a                   	pop    %rdx
> >    2:	59                   	pop    %rcx
> >    3:	c3                   	ret
> >    4:	90                   	nop
> >    5:	90                   	nop
> >    6:	90                   	nop
> >    7:	90                   	nop
> >    8:	8d 76 00             	lea    0x0(%rsi),%esi
> >    b:	58                   	pop    %rax
> >    c:	b8 77 00 00 00       	mov    $0x77,%eax
> >   11:	cd 80                	int    $0x80
> >   13:	90                   	nop
> >   14:	8d                   	.byte 0x8d
> >   15:	76                   	.byte 0x76
> > [  221.409527][ T7133] EAX: ffffffda EBX: 00000137 ECX: 01ce1580 EDX: 240449b4
> > [  221.410805][ T7133] ESI: 000000b1 EDI: 8b8b8b8b EBP: 08080808 ESP: bfc205fc
> > [  221.412147][ T7133] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
> > [  221.481648][ T7133]
> > [  221.482194][ T7133] ================================================
> > [  221.483377][ T7133] WARNING: lock held when returning to user space!
> > [  221.484574][ T7133] 6.6.0-rc4-01105-gdf13d11e6a2a #1 Tainted: G        W       TN
> > [  221.485904][ T7133] ------------------------------------------------
> > [  221.487044][ T7133] trinity-c4/7133 is leaving the kernel with locks still held!
> > [  221.488448][ T7133] 1 lock held by trinity-c4/7133:
> > [ 221.489401][ T7133] #0: c27dbb18 (rcu_read_lock){....}-{1:2}, at: inet6_csk_xmit (include/linux/rcupdate.h:747 net/ipv6/inet6_connection_sock.c:129) 
> > [  221.491125][ T7133] ------------[ cut here ]------------
> > [  221.501170][ T7133] Voluntary context switch within RCU read-side critical section!
> > [ 221.501214][ T7133] WARNING: CPU: 1 PID: 7133 at kernel/rcu/tree_plugin.h:320 rcu_note_context_switch (kernel/rcu/tree_plugin.h:320 (discriminator 11)) 
> > [  221.504458][ T7133] Modules linked in: ipmi_msghandler uio_pdrv_genirq uio rtc_cmos processor fuse drm drm_panel_orientation_quirks configfs
> > [  221.506701][ T7133] CPU: 1 PID: 7133 Comm: trinity-c4 Tainted: G        W       TN 6.6.0-rc4-01105-gdf13d11e6a2a #1
> > [ 221.508634][ T7133] EIP: rcu_note_context_switch (kernel/rcu/tree_plugin.h:320 (discriminator 11)) 
> > [ 221.509684][ T7133] Code: e9 87 fe ff ff 8d 74 26 00 8b 41 2c 89 45 ec e9 16 ff ff ff 8d 74 26 00 90 c6 05 09 88 94 c2 01 68 04 84 32 c2 e8 47 14 f5 ff <0f> 0b 5a e9 b0 fd ff ff 8d b4 26 00 00 00 00 81 e2 ff ff ff 7f 0f
> > All code
> > ========
> >    0:	e9 87 fe ff ff       	jmp    0xfffffffffffffe8c
> >    5:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
> >    9:	8b 41 2c             	mov    0x2c(%rcx),%eax
> >    c:	89 45 ec             	mov    %eax,-0x14(%rbp)
> >    f:	e9 16 ff ff ff       	jmp    0xffffffffffffff2a
> >   14:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
> >   18:	90                   	nop
> >   19:	c6 05 09 88 94 c2 01 	movb   $0x1,-0x3d6b77f7(%rip)        # 0xffffffffc2948829
> >   20:	68 04 84 32 c2       	push   $0xffffffffc2328404
> >   25:	e8 47 14 f5 ff       	call   0xfffffffffff51471
> >   2a:*	0f 0b                	ud2		<-- trapping instruction
> >   2c:	5a                   	pop    %rdx
> >   2d:	e9 b0 fd ff ff       	jmp    0xfffffffffffffde2
> >   32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
> >   39:	81 e2 ff ff ff 7f    	and    $0x7fffffff,%edx
> >   3f:	0f                   	.byte 0xf
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	0f 0b                	ud2
> >    2:	5a                   	pop    %rdx
> >    3:	e9 b0 fd ff ff       	jmp    0xfffffffffffffdb8
> >    8:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
> >    f:	81 e2 ff ff ff 7f    	and    $0x7fffffff,%edx
> >   15:	0f                   	.byte 0xf
> > [  221.513148][ T7133] EAX: 00000000 EBX: e52d7c40 ECX: 00000000 EDX: 00000000
> > [  221.514443][ T7133] ESI: 00000000 EDI: eadb5640 EBP: ead7df28 ESP: ead7df10
> > [  221.515747][ T7133] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010046
> > [  221.517184][ T7133] CR0: 80050033 CR2: 01ce68cc CR3: 2ae6f000 CR4: 00000690
> > [  221.518449][ T7133] Call Trace:
> > [ 221.519074][ T7133] ? show_regs (arch/x86/kernel/dumpstack.c:478) 
> > [ 221.519826][ T7133] ? rcu_note_context_switch (kernel/rcu/tree_plugin.h:320 (discriminator 11)) 
> > [ 221.520887][ T7133] ? __warn (kernel/panic.c:673) 
> > [ 221.521663][ T7133] ? rcu_note_context_switch (kernel/rcu/tree_plugin.h:320 (discriminator 11)) 
> > [ 221.522722][ T7133] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
> > [ 221.523615][ T7133] ? exc_overflow (arch/x86/kernel/traps.c:250) 
> > [ 221.524517][ T7133] ? handle_bug (arch/x86/kernel/traps.c:216) 
> > [ 221.525240][ T7133] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
> > [ 221.526115][ T7133] ? handle_exception (arch/x86/entry/entry_32.S:1056) 
> > [ 221.527035][ T7133] ? exc_overflow (arch/x86/kernel/traps.c:250) 
> > [ 221.527882][ T7133] ? rcu_note_context_switch (kernel/rcu/tree_plugin.h:320 (discriminator 11)) 
> > [ 221.528945][ T7133] ? exc_overflow (arch/x86/kernel/traps.c:250) 
> > [ 221.529743][ T7133] ? rcu_note_context_switch (kernel/rcu/tree_plugin.h:320 (discriminator 11)) 
> > [ 221.530784][ T7133] __schedule (arch/x86/include/asm/preempt.h:80 (discriminator 3) kernel/sched/core.c:556 (discriminator 3) kernel/sched/sched.h:1372 (discriminator 3) kernel/sched/sched.h:1681 (discriminator 3) kernel/sched/core.c:6612 (discriminator 3)) 
> > [ 221.531573][ T7133] ? exit_to_user_mode_prepare (kernel/entry/common.c:158 kernel/entry/common.c:204) 
> > [ 221.532627][ T7133] schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6772 (discriminator 1)) 
> > [ 221.533358][ T7133] exit_to_user_mode_prepare (kernel/entry/common.c:161 kernel/entry/common.c:204) 
> > [ 221.534382][ T7133] ? sysvec_reboot (arch/x86/kernel/smp.c:269) 
> > [ 221.535255][ T7133] irqentry_exit_to_user_mode (kernel/entry/common.c:130 kernel/entry/common.c:311) 
> > [ 221.536302][ T7133] irqentry_exit (kernel/entry/common.c:445) 
> > [ 221.537101][ T7133] sysvec_reschedule_ipi (arch/x86/kernel/smp.c:269) 
> > [ 221.538079][ T7133] handle_exception (arch/x86/entry/entry_32.S:1056) 
> > [  221.538990][ T7133] EIP: 0xb7f59579
> > [ 221.539674][ T7133] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> > All code
> > ========
> >    0:	b8 01 10 06 03       	mov    $0x3061001,%eax
> >    5:	74 b4                	je     0xffffffffffffffbb
> >    7:	01 10                	add    %edx,(%rax)
> >    9:	07                   	(bad)
> >    a:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
> >    e:	10 08                	adc    %cl,(%rax)
> >   10:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
> > 	...
> >   20:	00 51 52             	add    %dl,0x52(%rcx)
> >   23:	55                   	push   %rbp
> >   24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
> >   26:	0f 34                	sysenter
> >   28:	cd 80                	int    $0x80
> >   2a:	5d                   	pop    %rbp
> >   2b:	5a                   	pop    %rdx
> >   2c:	59                   	pop    %rcx
> >   2d:	c3                   	ret
> >   2e:	90                   	nop
> >   2f:	90                   	nop
> >   30:	90                   	nop
> >   31:	90                   	nop
> >   32:	8d 76 00             	lea    0x0(%rsi),%esi
> >   35:	58                   	pop    %rax
> >   36:	b8 77 00 00 00       	mov    $0x77,%eax
> >   3b:	cd 80                	int    $0x80
> >   3d:	90                   	nop
> >   3e:	8d                   	.byte 0x8d
> >   3f:	76                   	.byte 0x76
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	5d                   	pop    %rbp
> >    1:	5a                   	pop    %rdx
> >    2:	59                   	pop    %rcx
> >    3:	c3                   	ret
> >    4:	90                   	nop
> >    5:	90                   	nop
> >    6:	90                   	nop
> >    7:	90                   	nop
> >    8:	8d 76 00             	lea    0x0(%rsi),%esi
> >    b:	58                   	pop    %rax
> >    c:	b8 77 00 00 00       	mov    $0x77,%eax
> >   11:	cd 80                	int    $0x80
> >   13:	90                   	nop
> >   14:	8d                   	.byte 0x8d
> >   15:	76                   	.byte 0x76
> > [  221.543249][ T7133] EAX: ffffff91 EBX: 00000137 ECX: bfc205fc EDX: b7f59579
> > [  221.544585][ T7133] ESI: 000000b1 EDI: 8b8b8b8b EBP: 08080808 ESP: bfc205fc
> > [  221.545872][ T7133] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
> > [ 221.547230][ T7133] ? sysvec_reboot (arch/x86/kernel/smp.c:269) 
> > [  221.548133][ T7133] irq event stamp: 10576
> > [ 221.548909][ T7133] hardirqs last enabled at (10575): _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
> > [ 221.550576][ T7133] hardirqs last disabled at (10576): exit_to_user_mode_prepare (include/linux/entry-common.h:191 kernel/entry/common.c:181 kernel/entry/common.c:204) 
> > [ 221.552434][ T7133] softirqs last enabled at (10570): release_sock (net/core/sock.c:3528) 
> > [ 221.553958][ T7133] softirqs last disabled at (10568): release_sock (net/core/sock.c:3517) 
> > [  221.555538][ T7133] ---[ end trace 0000000000000000 ]---
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20231017/202310171606.30e15ebe-oliver.sang@intel.com
> > 
> > 
> > 
> 
> Thanks,
>              Dmitry
> 
