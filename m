Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E816778C483
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjH2Mwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbjH2MwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:52:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858E79D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693313526; x=1724849526;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ux8MpomonyiwGN89ugSS6oXRI0MxBDxiAOdVJAO8HBY=;
  b=JMABc65p1mC+sfcZyl+r5LgQHRv/8jYRWH62XkI8Tjk3cQV2tSIy1Q7e
   bluVvScCfahoyF3AOQvlzzWrgOlKs0dTIxxFJP4Nfo321JMBos35WeL0j
   dzq0JCo5O2OdJoKxi+QPR2IW2Cc0g7OCRVEYDOK/CsKEWyjk6navkxo6f
   z7bKcGJfXYz6QYtgg6+WLdckh/kx3+2jaoE8q9rTsggznPFolX2GB3DmV
   5n9/tscghXRpBKRPEPa9XDRPbOstnzjsgluAmxEZpPuUgYdn9Kw3Lb+dL
   G0d+qbFfWY1Ie9leAxCqHRNyO2gz99MTFSbc9CU0k8u6Y6zPahxAo/LNe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461721141"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="461721141"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 05:51:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="738687194"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="738687194"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 29 Aug 2023 05:51:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 05:51:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 05:51:46 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 05:51:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7ENN/BaNmRK6n9XMt9FZeabj+2qOTRuPxF4BotXFSCIZvg6+ANlg5JLP0gruVS/E9RK6AhVN0D0FtUt48MmjWOSBhAHQMjCPVKEX5YTJiHq1x4udqkkLugCbbL1PphWCJXXQ4Ol1U7g5QT64MDivyGOujfMTJBjCR2G28GdiLEKSY2zhrUjSrs0qf2riLbr9li3dhFtwYy+tbBtO+WHH1zoE/DoDo5FLQAB99xJDJgDjh/Bf0QbYeLipBWNyAPRGqKLBlxrjjJqILRlGNv9Iq/NYip6gB0KVHMPLeEYr57VOZyfL86S3idJ1SG5B4rKPl0HiX+KuK/MunUBHcHYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vUSTJInx3aqRUYvq19D8o1BucLxI6dD28T7NyyfeZg=;
 b=DGD+czKzMwQKHgvY4XD5UD25wAwvVgubcpqGHJysZpqLp96wvJljzS1aNmxWtvM2rYQcwNZsNzFnQ59OH1x24m2T1k7WtxjSe3IXwBoDbmXDVACdCqDaKqd3edke6/m2LMGC/dxw8QoU0LGIn7952hBw8dg1KBO1NIkNO+jJXiKMzLDb2Vl9sP6c9OYZVe2pYdHjesjgJ1zMg1IHIAaBFIrdm+BPF77qzK0v33EEEIKTYA1d6xUAoKdagsSYHaLmhBq3qX6OFGQQ9cm5RsQscMnS4e7FtzDtd+AKNGkuJBa6jo778AfT1DVDALJpkyOuedITHT+eh69eVTpLBtrLtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by IA1PR11MB7678.namprd11.prod.outlook.com (2603:10b6:208:3f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 12:51:44 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9a8d:9d34:4af2:f2e5]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9a8d:9d34:4af2:f2e5%7]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 12:51:44 +0000
Date:   Tue, 29 Aug 2023 20:51:34 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
Message-ID: <20230829125134.GA509331@ziqianlu-dell>
References: <20230829114816.GA508985@ziqianlu-dell>
 <ZO3hQ0rbr8QuUjVI@debian.me>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZO3hQ0rbr8QuUjVI@debian.me>
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|IA1PR11MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b3ae93-e975-42de-5a0c-08dba88eb295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sdPmFI0JL+MpZ8QMWOAa9bjh1mFbSiLE1RcxLkWz6oJjF2SuB0+sZPnHNrhMKU/v+wKEyt9QkNUazgP/0gj6hhRadR7fxxFtiTVrJyLlM5/UnCePpiN+EStBQsvkYNIX4npF3HUg3lZ+v+Wpm/Dtqttc+lieHgTWQIkk8U/IyNEfNnec0vAqQwLsNORFlR6ofX911rSsgOlRNz2jpdsCCAUKLDzOwRhKV/+rALZJ0VPf8VtHz58RKu9KehIGRdPw/y8B721HqPY0yAI17JbyxO0p5MN/tqG+udfCfHsifpGfTGLF4dOdopU9KbNobyN41l2+r2a7QZ5pcbciyqxIDOK2mTOuDdlWtACXzB9q1AT7ZKPZrRUppCAFTSb/XjMxmiEmt+x/pnTEBxe1z4tgQGAV/cr6tSavTwK4zJP1w087GSU/qY8YNEqTMmB22tPZDLixk0T49j10tCeOa6ImQ1R0ELrfFYroGGLMjfgKmMgCLAA1kmA/uQKXVk1KyBwvfvDt3BAWUnqHQawqkgheWyLbDUX0AoEjRtekGvDmbaTtM8GVn215zzLA8pNVNYso
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199024)(1800799009)(186009)(8676002)(8936002)(4326008)(6916009)(54906003)(66556008)(66946007)(33656002)(316002)(66476007)(5660300002)(2906002)(44832011)(41300700001)(6486002)(6506007)(26005)(1076003)(9686003)(6512007)(38100700002)(33716001)(478600001)(83380400001)(82960400001)(6666004)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SL0f4X3uMzZ8eG2KyPxGh5ndyE7yR+4LvOVV/iSMyFWdSsZsAenUK8WU7Njo?=
 =?us-ascii?Q?HalD1uzxr2aTr9ZzuCJHT6oQBVyycxlCNUlnG/GIYnR9B/gz4iK9r5yncVnn?=
 =?us-ascii?Q?xKUSV7c3FDIcuplY52RzXwF7bPkb4v0oXM56ltx9zQETvV86NTwihQnMbV67?=
 =?us-ascii?Q?Aq8uGAA4wzqBV/jNnuLA4u/cjMZbnml1WZHS3zXTHagTE4Z4CDNzbm+9dTHy?=
 =?us-ascii?Q?K6oHnZ97lRav9vsPo068ffMf+fUObaT5qKo9pHsDHLqzFWVgIIiKR7X5ynvl?=
 =?us-ascii?Q?oud4/q/Zsm1UPe2Msi7MZshQ8HNqzSHOFnzF9jeUPduWsq2IWQTqsdj+oWp5?=
 =?us-ascii?Q?RMK++K6qt6QzhAExZ7ypP5UxYgHolaXyh5BBugu2wfYsyGpqXdBYhDWqT1ZE?=
 =?us-ascii?Q?o0oqtELuQcL1fE4BQQFYzEEuBI2WtH4RAc7cAg165ybHXjxuxFfz4QrFj9nM?=
 =?us-ascii?Q?PH8tp2rLmM8DH/o+qoUh30tvUhld9vIrCPYwsM6QkhIVYPt43ALoVq/TPnCU?=
 =?us-ascii?Q?M5wRyit0aaXtmzFkY7y+ocuFLOCQduac2z8e08zmWCc/x9wuUjZToV+ISyBZ?=
 =?us-ascii?Q?FEPvw5b3om8EEBXe0qz6rKZXgYFkf+sXS8+tdldMp0XYPqxxbzRtRGWk6++V?=
 =?us-ascii?Q?pE5ssFC+vAcqa7IzDBQucAU+x7jJnSrf77qS2PS+VoQ6PsV9fLCagfXSNrGb?=
 =?us-ascii?Q?LsoPI8nKqpMZJuwWLwTj+neq/NSmHxK1lTr03bpOjBgDBPMEdgZpsYuMoy+B?=
 =?us-ascii?Q?UK2Ph+w77cTDLNV9gnRoTOEvpaohspTtuhDlCNQbZDbEAb+GCUYtvyXqRsHS?=
 =?us-ascii?Q?xwLtovtkNNai7BwJCvQkBBMS/ZfqZrfBK2BgJPv+SOw9oxj/XeMRLFkyim31?=
 =?us-ascii?Q?+dt7kiwKuoYgvGJfPDh42H2vh3TSwJMhvG8wrry0qNjiYcuGcZG2Ixv4KyTw?=
 =?us-ascii?Q?DjWoMcQy0v1N4tnhDsq3gcpmAZU4r3RxfzOD/Ggenf+0fAQFrDaCuKF9vbH2?=
 =?us-ascii?Q?Yuh3xjP15smjiHFAaNGCFA0YUSmnUDW5ap+X8NARO7QcctV2IEJTRUZSpxeU?=
 =?us-ascii?Q?JGxiUYKG90U6BvQwlm40+SKKPt87oPNvOPpdw8reMEC+AlgCrzHZ4DDYpD2v?=
 =?us-ascii?Q?L5XVOpPFCJIZa88nRSpRjuBBvM4pkbplJGRMEj2HEihIUwbmEzvhT5UYBWyF?=
 =?us-ascii?Q?nNGsNqxIEPp2smOfLGaC351ZI9mMylJ2vhfG6ArJ7z5AAmXGDLANF8LXc2rl?=
 =?us-ascii?Q?1HeWb2RhO6HVs2kRVfO5NMi+zdoiKhGyNK1Dn9vSWMq2yAqOrIX4fsiHNIxZ?=
 =?us-ascii?Q?EOHzfsggvb3OWP9/eJ63iyidakrAksAdAy6v8iJCcvzBOroBig0QpaRgkBJW?=
 =?us-ascii?Q?dh8kot3+Glpiv2xXBvXQj/P21bX7hL8ctfL0MMbnvPjBx+j7bfh5D9aiQnCP?=
 =?us-ascii?Q?VaUb7KhYfIy1bGAnnchsSlxCiZAoxwB/EkKuCFnVvl6j/JGyE9vQ8l6bLjPG?=
 =?us-ascii?Q?LC8Eg9dZEEkEbxFFiPedD7meeMfuvUD0wb+ZAr19kubWUojpTHuUR9GV5gaz?=
 =?us-ascii?Q?Vcu1aP7ukiNC8Mm7WnHTn2OXlI+O2eiR5v83rVss?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b3ae93-e975-42de-5a0c-08dba88eb295
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 12:51:43.9188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuFyJtIZtCZKqvjwXt4c2A7bO6XL8fW9KFLR5SUPP/4jWXfewxSULzDh0thNpAl2EMJQDm631fhdMVGYhmSRig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7678
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

On Tue, Aug 29, 2023 at 07:14:59PM +0700, Bagas Sanjaya wrote:
> On Tue, Aug 29, 2023 at 07:48:16PM +0800, Aaron Lu wrote:
> > Hi Kirill,
> > 
> > Ever since v6.5-rc1, I found that I can not use kexec to reboot an Intel
> > SPR test machine. With git bisect, the first bad commit is 75d090fd167ac
> > ("x86/tdx: Add unaccepted memory support").
> > 
> > I have no idea why a tdx change would affect it, I'm not doing anything
> > related to tdx.
> > 
> > Any ideas?
> > 
> > The kernel config is attached, let me know if you need any other info.
> 
> Can you provide system logs (e.g. journalctl output) when attempting to
> reboot?

... ...
Aug 29 19:15:59 be3af2b6059f systemd-shutdown[1]: Syncing filesystems and block devices.
Aug 29 19:15:59 be3af2b6059f systemd-shutdown[1]: Sending SIGTERM to remaining processes...
Aug 29 19:16:00 be3af2b6059f systemd-journald[2629]: Journal stopped
-- Boot 7e5173842b8b4be581886ff25ad0c02f --
Aug 29 19:24:27 be3af2b6059f kernel: microcode: updated early: 0x2b000161 -> 0x2b000461, date = 2023-03-13
Aug 29 19:24:27 be3af2b6059f kernel: Linux version 6.3.8-100.fc37.x86_64 (mockbuild@bkernel02.iad2.fedoraproject.org)
Aug 29 19:24:27 be3af2b6059f kernel: Command line: BOOT_IMAGE=/boot/vmlinuz-6.3.8-100.fc37.x86_64 root=UUID=4381321e-e0>

First 3 lines are from the first kernel, then I attmpted to kexec reboot
to 6.4.0-rc5-00009-g75d090fd167a and remote console hanged with the
reboot message of the first kernel. After a while, I know kexec failed
so I power cycled the machine to boot into a distro kernel, that is the
last 3 lines. There is no trace of the failed boot.

I guess the kexeced kernel failed to start early in the boot process
so the log is probably only available in serial, if any. Unfortunately,
there is no serial support for this machine.

Thanks,
Aaron

> Anyway, thanks for the regression report. I'm adding it to regzbot:
> 
> #regzbot ^introduced: 75d090fd167aca
> #regzbot title: unable to reboot with kexec due to TDX unaccepted memory support
> 
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara


