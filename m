Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF937D7B06
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjJZCpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJZCpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:45:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F7612F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 19:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698288327; x=1729824327;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=qVeC7qcUIUI++c6oQ4SR0cDxXVbU0Lp/3XMV9+sgW40=;
  b=I2jIcdS2wQv0JYT8ICT2Qoie4QiNTxhHeBu0zrZbTVaJv1XKShwoWLLJ
   Kj+19IoXhAvS3N7UcbAE68fC2N80myJi5Mo77VIeS4PintO4E2N/uya/f
   56xcY+9bXWvx9sqTk8h2H8ORJb0W5nHR66iiqUCb0y5nZIwvAvU0nEkEq
   GUrUKfd4zXPBQP6S7L57frrKmCDuFaQ+N5QzHoyzVyiVLPUrOURBHJmx8
   m0/yjhWnryoyE/7ZH+KRtpoeErGUmhaVsJ5sh2c6i5mUXaHoA9YjDBwWM
   StTI89nleRFq01DGTvJMhi9Cg92q4+pJU3fFnNjDsQcJv47YBmKaABhUS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="473683024"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="473683024"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 19:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="1090445283"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="1090445283"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 19:44:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 19:44:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 19:44:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 19:44:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 19:44:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auxqTuPygpx0TNR90pJNf1yOArv41TPTy+3epY0SwNGhm5LLkQj6gdHyBiHvA7YHRPYhKxaJJDmHEyMbLJxU0A8DFOEHSP1aqle+R3ysLrZJ/A/uI6UeerOCGaTcNe2Wg+eejDgMk91JaI6VulwxrLgrDAF/5v0ZeQZL4dcHo+IQ18T4HIAFfpcXCT0U2yuMxD9OZ8xPBYEJAL0Bf/nvOJ0eT6+ZH+NOvNewWoNUn6+lxLz0s9PngWawJpGTcrQtdWejeeVLfGqvxxQb3OZ27fYEpfMMHpbTIZui/WgV/OWiIJcv86XcTaB8CupUjhFoClxpKR051nlMLh0RTzSYkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HGQFWOVBZdeP3Ya26ycvz7VrIpIErbuaGx6xq/NzZA=;
 b=EQeFGbDgwwjNzmxc3C3lsvACfrAnKGzMoulkW5eHigo64KjPsDg4aqqkglEz16Xf/4amVT0JKaVhriKhZ5ye6Nd6SdAicrMp3CqbPhknwLMmKfQdfSt5+6N/Jah5bZjjyYPNVAErXiUAEHQqG0+Xmvo7uqxkFZL0N4q5T3NlnVqI3n9g9EoiSE7toiywPk68J6dDgHMXW3o9ISaB8WLeQLkTaA07VaCPWQZlqg1RXdTlR1MWZ1hSRBz8vRMo//lpzka3rDheQXDlT0YwS9jO10OwFQjI3BZZRyy9hy0vD2Yp2T8DCOmzE6FbbAzmyD3P2fZP1o1WknOAP4rUE2+Z1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CO1PR11MB4945.namprd11.prod.outlook.com (2603:10b6:303:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 02:44:46 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 02:44:46 +0000
Date:   Thu, 26 Oct 2023 10:44:36 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Juergen Gross <jgross@suse.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>, <x86@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        "VMware PV-Drivers Reviewers" <pv-drivers@vmware.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH v3 4/5] x86/paravirt: switch mixed paravirt/alternative
 calls to alternative_2
Message-ID: <202310261032.76a10bc0-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231019091520.14540-5-jgross@suse.com>
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CO1PR11MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: a950ba81-a231-4528-a178-08dbd5cd8421
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBP60EgGARt91knkkO51vuJyZDcjFOIK3qNa1geb+XQCeKWJ6/y4oyOqf+kiEitvU5J0ylu23UCPvBJFD4WCf36ZXBY15fpvXMoMGJGe2I8WmqUO6c4fPYJnpjn/gn+uqwi72ggVwdSF1MVBVWfXRijeAN4DUc1fUufeLFKHLq4pLxgX5YN3mQhXHqrsFU89KubKEfUUL4RYDoggifVYWW5fQ6W2Sea/Ne7EglE7SPPE3eb569k0DD7Th0sHKeLUKsFRC1jotwDixFhgzYwfiLgoc77qJYaL/IB/KK9Gr6lOE3YgKLi+W33Js/KOM35AjkL5YxQVZYXq09S5fBcNEwoXDQITCoKPjCswOnzMFIKBjxwL6pyi9hjKogcwCxu2wwOGkpuIRB3groGXZY89cnzy+haJEtLIkbanIaHZ736PYmjnu68Ekzj1XxwsHZtsnSF1++KrsjToVBenfONRJdmYLaYrvU5+K8YIhnsNNFukjDMb5ozLYzgDoTMRMnJ9L41lo8IxEvE4JFlq19Jh388LNjy19XXKzGrhwFOVAgXCnRkDilj6isV3uwTqHmzJQkMboe3JUDPzS9lXqbyhuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(83380400001)(4326008)(8936002)(2906002)(8676002)(7416002)(6486002)(966005)(82960400001)(45080400002)(5660300002)(41300700001)(6666004)(6512007)(6506007)(316002)(6916009)(478600001)(26005)(1076003)(86362001)(2616005)(36756003)(54906003)(66946007)(38100700002)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?amIAfiB0vfDtMP/d6fpOb3fYtxX0+zLIT8vy6d/EtksnRnJlT0yea9H44/vf?=
 =?us-ascii?Q?M+2Mp81qFuAZYENM0ATsbGev+hvoRl9XB/l1ECTYvZ1AGmrsACMrb9Et8bsc?=
 =?us-ascii?Q?CyxmSc0LI7z0kqfMM1JjQcGri617pyQ3GVGWxGpeuCaGGcvhYkzOIjbKYK5a?=
 =?us-ascii?Q?ObWFsoMygWj+T3nkB3OeM8dVY5kQWvUMixvcrw5+UD6lMZxsg6ho0NjgLA+W?=
 =?us-ascii?Q?XT3bPqV5Qpe+IMMdVfUUM6nP80YBP1LjFvoTatRPT56qDnUQhm4wvkxfPElS?=
 =?us-ascii?Q?ONDlKOy2WqwLL7OHLgCacGXg2x7ZiV7o8HDMGBGZlCPKFhgwvPWPyOScCKYp?=
 =?us-ascii?Q?F4v84v7L1a8ZqrN7FTeJsU1DzS2q9nZm2loF6apJlr49m7QjC7adL7o6QVnf?=
 =?us-ascii?Q?5p1e3sQXfTDWiFEed+GF7wkZlSASr0Zvafs4ZpLeADM/HEQBC2Dd+pZ0kUW6?=
 =?us-ascii?Q?olRpioyM5lChG8UJE/XUvGFgZUKZGvtlNqhOBBCkK8WaHgkV2cefa2OvTdOA?=
 =?us-ascii?Q?9iVC4GFnwxZhnDC0qlYx+tICgKNOE4Mg3T6mnDa435xua1rf5+cAQ+kaeL96?=
 =?us-ascii?Q?PeVgq/nayU1jS8LmkbCUWDxiKGDUr5IqbNfqA1r4BjfS3pUS4Y/MWKMVEKtd?=
 =?us-ascii?Q?vpGX3HKpOernyTqqWUyd3CJopfUr1QxMygPBuQ5X7WupNWz/PxIsty0NDMMU?=
 =?us-ascii?Q?44g6BexwVSGdNcVq+ibpQ/qR5shmyiObG8qqmlIbrdKQPCjgPS55PhtExJZf?=
 =?us-ascii?Q?OlVxgjUWuMewDS0zyNIBwhRTAwr90VAQ/Y28khTzhDx3S25P7XqdhnwPV+9E?=
 =?us-ascii?Q?ELb3/0+olgLDMlJ5KlsamPmet12y6Gin19WwgcnKArZljjMQ3PjtJGF/URp0?=
 =?us-ascii?Q?uVqTPT0BEOWW1UqsQv54fK/eMHtt+qV4tYHulFTafoIsEtxT0/SLwcVfDbjP?=
 =?us-ascii?Q?V9WcrCguAF85NS9vprBJGjbiG/eYkCPdun5AFBj7Hw07ieaC8xg9O2Z6dj1c?=
 =?us-ascii?Q?hZ3CqEgffCUOlxgS+KzuSDEL1w5uL6ocRDb8X/qE7l1uUtUAHr04Rb4jAb63?=
 =?us-ascii?Q?ZV0X9urPZ4EuZt8zXHOOmvsl+bPcxcYpyjMZU0E4RJ7i4lXrGaBf1RSFORkA?=
 =?us-ascii?Q?5EGaLcfC1DWnAWChu0L9+TDJj+w5PxtOpSfMT8KrMmxo9maDSf/OKhgzqHh0?=
 =?us-ascii?Q?33yeY7vrp02ItIKKU5bgeX5wmjupXGUQOAd87bBsfQEqSb2fpurW2HQFkTD8?=
 =?us-ascii?Q?w8jbvYx3K6TODk2io7PUoBT2sZU2SsWxtn3IfhDJXTbfeme4LEsX7MWheJSJ?=
 =?us-ascii?Q?rW6S/POGFXx+Tx1qXBi1bZ00WeM1OEGlQK94uMQw2mgdaw8aDUyvtIfQ1GLD?=
 =?us-ascii?Q?wKwE3YHT3uG19ONELg4NBVT8QWWzs7DUoiReqfMN0sOqkQwiidZ7tcH1/FZB?=
 =?us-ascii?Q?aDFVPQTmInFvjxUYQFHzEHlyshjLvZaDyFfHy8VpIBtS4oMqfAculA4/Eas8?=
 =?us-ascii?Q?C0CIQiEh0p15eLBBoIPTBLjSdAc67OIeGYEHHzrsJQbftIvRD0THCl7dDSBG?=
 =?us-ascii?Q?bCQxq713jG6MvzryzP3CYOr6okNFtxOdCHNMgcolQBUM9tsjn2+t+Ha4P5up?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a950ba81-a231-4528-a178-08dbd5cd8421
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 02:44:46.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfMFX+oc7ZrCUeywBxS6b1PftSskenbQbJkaf5rslTr7NUAxw4EDJPjMVOd61LF6QaSNCkiDHj1mPv710TLMbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4945
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



Hello,

kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:

commit: b0b8b06548f7984351b503ec5f5c13fa80bae6a2 ("[PATCH v3 4/5] x86/paravirt: switch mixed paravirt/alternative calls to alternative_2")
url: https://github.com/intel-lab-lkp/linux/commits/Juergen-Gross/x86-paravirt-move-some-functions-and-defines-to-alternative/20231019-171709
base: https://git.kernel.org/cgit/virt/kvm/kvm.git queue
patch link: https://lore.kernel.org/all/20231019091520.14540-5-jgross@suse.com/
patch subject: [PATCH v3 4/5] x86/paravirt: switch mixed paravirt/alternative calls to alternative_2

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | efa1a70f0b | b0b8b06548 |
+---------------------------------------------+------------+------------+
| BUG:unable_to_handle_page_fault_for_address | 0          | 14         |
| Oops:#[##]                                  | 0          | 14         |
| EIP:apply_alternatives                      | 0          | 14         |
| Kernel_panic-not_syncing:Fatal_exception    | 0          | 14         |
+---------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310261032.76a10bc0-oliver.sang@intel.com


[    1.382500][    T0] BUG: unable to handle page fault for address: 84864e91
[    1.383633][    T0] #PF: supervisor read access in kernel mode
[    1.384579][    T0] #PF: error_code(0x0000) - not-present page
[    1.384579][    T0] *pde = 00000000
[    1.384579][    T0] Oops: 0000 [#1] PREEMPT SMP
[    1.384579][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.6.0-rc5-00101-gb0b8b06548f7 #1 7cb7f016c05986cc453a3ae4b37cd3712c62c0c0
[    1.384579][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 1.384579][ T0] EIP: apply_alternatives (arch/x86/kernel/alternative.c:419 arch/x86/kernel/alternative.c:489) 
[ 1.384579][ T0] Code: 3c 06 0f 85 4e 02 00 00 8b 85 ec fe ff ff 80 38 ff 0f 85 3f 02 00 00 80 78 01 15 0f 85 35 02 00 00 8b 8d ec fe ff ff 8b 41 02 <8b> 44 01 06 85 c0 74 17 89 c2 81 ea 60 18 7c c2 01 95 f3 fe ff ff
All code
========
   0:	3c 06                	cmp    $0x6,%al
   2:	0f 85 4e 02 00 00    	jne    0x256
   8:	8b 85 ec fe ff ff    	mov    -0x114(%rbp),%eax
   e:	80 38 ff             	cmpb   $0xff,(%rax)
  11:	0f 85 3f 02 00 00    	jne    0x256
  17:	80 78 01 15          	cmpb   $0x15,0x1(%rax)
  1b:	0f 85 35 02 00 00    	jne    0x256
  21:	8b 8d ec fe ff ff    	mov    -0x114(%rbp),%ecx
  27:	8b 41 02             	mov    0x2(%rcx),%eax
  2a:*	8b 44 01 06          	mov    0x6(%rcx,%rax,1),%eax		<-- trapping instruction
  2e:	85 c0                	test   %eax,%eax
  30:	74 17                	je     0x49
  32:	89 c2                	mov    %eax,%edx
  34:	81 ea 60 18 7c c2    	sub    $0xc27c1860,%edx
  3a:	01 95 f3 fe ff ff    	add    %edx,-0x10d(%rbp)

Code starting with the faulting instruction
===========================================
   0:	8b 44 01 06          	mov    0x6(%rcx,%rax,1),%eax
   4:	85 c0                	test   %eax,%eax
   6:	74 17                	je     0x1f
   8:	89 c2                	mov    %eax,%edx
   a:	81 ea 60 18 7c c2    	sub    $0xc27c1860,%edx
  10:	01 95 f3 fe ff ff    	add    %edx,-0x10d(%rbp)
[    1.384579][    T0] EAX: c37e7374 EBX: c37b7e3a ECX: c107db17 EDX: 00000005
[    1.384579][    T0] ESI: c3ffc70a EDI: 00000000 EBP: c37b7f48 ESP: c37b7e00
[    1.384579][    T0] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00210246
[    1.384579][    T0] CR0: 80050033 CR2: 84864e91 CR3: 04037000 CR4: 000406d0
[    1.384579][    T0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    1.384579][    T0] DR6: fffe0ff0 DR7: 00000400
[    1.384579][    T0] Call Trace:
[ 1.384579][ T0] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 1.384579][ T0] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[ 1.384579][ T0] ? oops_enter (kernel/panic.c:627) 
[ 1.384579][ T0] ? page_fault_oops (arch/x86/mm/fault.c:707) 
[ 1.384579][ T0] ? kernelmode_fixup_or_oops+0x9c/0xf4 
[ 1.384579][ T0] ? __bad_area_nosemaphore+0x13f/0x260 
[ 1.384579][ T0] ? insn_get_opcode (arch/x86/lib/insn.c:299) 
[ 1.384579][ T0] ? insn_get_modrm (arch/x86/lib/insn.c:344) 
[ 1.384579][ T0] ? insn_get_sib (arch/x86/lib/insn.c:422) 
[ 1.384579][ T0] ? bad_area_nosemaphore (arch/x86/mm/fault.c:867) 
[ 1.384579][ T0] ? do_user_addr_fault (arch/x86/mm/fault.c:1476) 
[ 1.384579][ T0] ? optimize_nops (arch/x86/kernel/alternative.c:246) 
[ 1.384579][ T0] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561) 
[ 1.384579][ T0] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1518) 
[ 1.384579][ T0] ? handle_exception (arch/x86/entry/entry_32.S:1049) 
[ 1.384579][ T0] ? ___pte_free_tlb (arch/x86/include/asm/paravirt.h:92 arch/x86/mm/pgtable.c:57) 
[ 1.384579][ T0] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1518) 
[ 1.384579][ T0] ? apply_alternatives (arch/x86/kernel/alternative.c:419 arch/x86/kernel/alternative.c:489) 
[ 1.384579][ T0] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1518) 
[ 1.384579][ T0] ? apply_alternatives (arch/x86/kernel/alternative.c:419 arch/x86/kernel/alternative.c:489) 
[ 1.384579][ T0] ? lock_acquire (kernel/locking/lockdep.c:5670 kernel/locking/lockdep.c:5744) 
[ 1.384579][ T0] ? ___pte_free_tlb (arch/x86/include/asm/paravirt.h:92 arch/x86/mm/pgtable.c:57) 
[ 1.384579][ T0] alternative_instructions (arch/x86/kernel/alternative.c:1677) 
[ 1.384579][ T0] ? fpu__init_cpu (arch/x86/kernel/fpu/init.c:54) 
[ 1.384579][ T0] arch_cpu_finalize_init (arch/x86/kernel/cpu/common.c:2407) 
[ 1.384579][ T0] start_kernel (init/main.c:1035) 
[ 1.384579][ T0] ? set_init_arg (init/main.c:530) 
[ 1.384579][ T0] i386_start_kernel (arch/x86/kernel/head32.c:74) 
[ 1.384579][ T0] startup_32_smp (arch/x86/kernel/head_32.S:305) 
[    1.384579][    T0] Modules linked in:
[    1.384579][    T0] CR2: 0000000084864e91
[    1.384579][    T0] ---[ end trace 0000000000000000 ]---
[ 1.384579][ T0] EIP: apply_alternatives (arch/x86/kernel/alternative.c:419 arch/x86/kernel/alternative.c:489) 
[ 1.384579][ T0] Code: 3c 06 0f 85 4e 02 00 00 8b 85 ec fe ff ff 80 38 ff 0f 85 3f 02 00 00 80 78 01 15 0f 85 35 02 00 00 8b 8d ec fe ff ff 8b 41 02 <8b> 44 01 06 85 c0 74 17 89 c2 81 ea 60 18 7c c2 01 95 f3 fe ff ff
All code
========
   0:	3c 06                	cmp    $0x6,%al
   2:	0f 85 4e 02 00 00    	jne    0x256
   8:	8b 85 ec fe ff ff    	mov    -0x114(%rbp),%eax
   e:	80 38 ff             	cmpb   $0xff,(%rax)
  11:	0f 85 3f 02 00 00    	jne    0x256
  17:	80 78 01 15          	cmpb   $0x15,0x1(%rax)
  1b:	0f 85 35 02 00 00    	jne    0x256
  21:	8b 8d ec fe ff ff    	mov    -0x114(%rbp),%ecx
  27:	8b 41 02             	mov    0x2(%rcx),%eax
  2a:*	8b 44 01 06          	mov    0x6(%rcx,%rax,1),%eax		<-- trapping instruction
  2e:	85 c0                	test   %eax,%eax
  30:	74 17                	je     0x49
  32:	89 c2                	mov    %eax,%edx
  34:	81 ea 60 18 7c c2    	sub    $0xc27c1860,%edx
  3a:	01 95 f3 fe ff ff    	add    %edx,-0x10d(%rbp)

Code starting with the faulting instruction
===========================================
   0:	8b 44 01 06          	mov    0x6(%rcx,%rax,1),%eax
   4:	85 c0                	test   %eax,%eax
   6:	74 17                	je     0x1f
   8:	89 c2                	mov    %eax,%edx
   a:	81 ea 60 18 7c c2    	sub    $0xc27c1860,%edx
  10:	01 95 f3 fe ff ff    	add    %edx,-0x10d(%rbp)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231026/202310261032.76a10bc0-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

