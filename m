Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF304786A59
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240271AbjHXIme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbjHXImN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:42:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834FF1727;
        Thu, 24 Aug 2023 01:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692866531; x=1724402531;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xGPR1z1c1cC/hflgfKGbZ1RoyC9wVazgLbQ1hTLBOds=;
  b=G3i9qt0LDddWRvO7zWXPcaaOQZ0nwH9mBMhCgr/K/8rn0WJqfz9fdRgU
   Yk6ceuvJYAXGhdrZ17OiJMkgKfFQ/j+CMoeqmZkh6Fg9BvhEQyvSRAM3s
   oC1Y3d/pIwbyRYwZ026/FtUK/PJlzB1tKT26Q1h2Z401yWJLJgpPd4lOt
   cm82SysdHTj2S/xCA/2iWtxeLE5IBO1nixlFgu1QWo27KiJWYJAb5jkN3
   MVKQpfF/F7tww7KCPRt1zRE3dT7sXbsAS14ZxoEFGvHH2GRJ0epk88WWN
   Qq0vZfu+WknRtfN58WdG7+FkT47BZ3iIs6XXeVeoghMZZMk+dmQuD3WZU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="378135856"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="378135856"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 01:42:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="730527748"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="730527748"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 24 Aug 2023 01:42:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 01:42:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 01:42:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 01:42:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+QxNrs4JxYbSZAvNblZcezlHLhSXQj95rgec7NxqpnTsLMZv6seHE4HRoUj4yaDSAFFUk2mfBnjThtvTc3kBcQuLSrCSqMC2FPNC/h3HzRmHkRrspArfjH+Ygca+cEyGJTRut1pCkUFCaZjwfnMH/cFFX9AsxNwOXGNdlukQzHEinY90Ib2+vJ5PJPJ8kgVCnoUIYITqEJdzN8ePLN/17WJncy6bfcLDkDhrsQdVHs9xZaIK3fZBLXjRxD5Od0siT+2SZRW1gjLjv6VI+IMbZLp8+5j8EmFJKXaiwZHLhzy9dbE/KTyztLvUvwj2oOgqo749HxCOnvwP+gNy3YKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUCVhMAgAbDupSOpUhb+ZvZw7De+r7w7pIypXpXojTI=;
 b=NxeBBU8jTe/xlindAcz74GTN2E+NlgCcds+jn3f/bwVrJaq+EzF6a04EXJX06lBKVEBpg+ZdAbvgXJowX3/yyd0h+20SNnVAVD8PU6t9YmNmok4fSEkRcEhYL2YF3dcaL3tyiLo0KPYRg/1fIRJFdbH4rWWiIpmDhqw331B/dQHA2Ay4hbgjUZ0VTL+aveXrsVV+MfhgTr7BWR/msqh7/5s6ZAXhCcem+OCaWTBhwcLziBlLDTGhQALRwQgnH5k4pSjhqKDjwk4na0FN9I5t6oKxJuAX0a8zRZjO7WgVKl5IOK4wBvXoDp6ULR3IkvTiCi23ZOiv4Dzybk/Lt+OGDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB6792.namprd11.prod.outlook.com (2603:10b6:a03:485::22)
 by MW4PR11MB5934.namprd11.prod.outlook.com (2603:10b6:303:189::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 08:42:09 +0000
Received: from SJ0PR11MB6792.namprd11.prod.outlook.com
 ([fe80::55ae:a9d8:12e6:d0c7]) by SJ0PR11MB6792.namprd11.prod.outlook.com
 ([fe80::55ae:a9d8:12e6:d0c7%7]) with mapi id 15.20.6699.025; Thu, 24 Aug 2023
 08:42:08 +0000
Date:   Thu, 24 Aug 2023 16:41:59 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Frank Rowand <frowand.list@gmail.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        <devicetree@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [of]  74df14cd30:
 WARNING:at_lib/refcount.c:#refcount_warn_saturate
Message-ID: <202308241628.feb8dbbf-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To SJ0PR11MB6792.namprd11.prod.outlook.com
 (2603:10b6:a03:485::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6792:EE_|MW4PR11MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e0e822-1d7a-4109-dcd9-08dba47e006e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5mLqMx2YQu28c9ljWB3ZaoMzO0l0c8zYipDcpUdJUGJMuDwIH3mDDhv7Xomfbc8dyiiwceotUWGZeWWxf9JWcwTMNB+HNNd0Vbjf3ybWamDyu1EqP5s8Nk6Eope1/+uEULR0Hb0wxGSedsgRvoPRzxyzG1MU7osqMRn0tgJSpxCYu0gj5gPttXk/C2mlFwr8VlCA5zunK7PSP265IateR4TLC+886PVm6nh4XZKo5HpQ7Qy1Htux3YmUdjeZSTZralb4+7gloDMcVJz5gFJFC0aEPm8lBRYDrqRxtLAwuubpT9Sy+YaszQER+NC1ncYAERsS5l5rxo1XpGHevGuICIEC1c0ahDCmcMXiwy7rToyPw4cFOdptSsEZETgd2qbP6fCpGd4L71G1dT4shKb73lmw3xdKWIeBOqokiPMSDCfTE9buRtdvN5YGq6Ixvynhxiq29pRuDrxwjQikJtSU2U76lZfMS4vnM/4QkBTwF2NLp9iORZ6N6LECexsD+v+D6DyP2nylP8E50iexVBLoX2CrDaaJAZdyyGKRQU9G1l9d0ixQzsKbd0W/7/h/cGzHGqrVl8dQYErJO3/QjZv9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6792.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(39860400002)(376002)(186009)(1800799009)(451199024)(2616005)(8936002)(4326008)(8676002)(83380400001)(5660300002)(107886003)(1076003)(36756003)(26005)(6666004)(38100700002)(82960400001)(66946007)(66556008)(66476007)(6916009)(316002)(478600001)(966005)(45080400002)(41300700001)(6512007)(2906002)(6486002)(86362001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FEPxRbbXRAMxZAH2upSYZ3Se806AT8XQmeQXQ2YK4SdsWSDdzy9otbDvHqu7?=
 =?us-ascii?Q?bqNlImIe5jDp6wlg3xQfzdIxvt2VycECxb3fHJXt6DEcSLNuUdUzrFZBiyl3?=
 =?us-ascii?Q?QRaXQ9J2hBuGj9e25SJ6gvvrk8hre0JdhrXiCwKy5pcwd5dbVREylT2GMWzz?=
 =?us-ascii?Q?Xmx0R3XYxwvw0BsoMtywTRutiKKxUUwUxCuqU73FqBrgAxi5QHvlacvHOgK3?=
 =?us-ascii?Q?yyQ/HcFmq3bXZK+AHg3MzRoNhwFFHA3cJgGmCuyJOlXvzfIgaSUtxFOOtxZt?=
 =?us-ascii?Q?saVDxvZ/CNvT5B3iLwsZHrF5Tu4CP4xZdYXLSEeQeI/iBWSDuldaH2EzK/YR?=
 =?us-ascii?Q?tddKWSALBeWShco07B0NjH4H0kAs4CzkQ03m9TMhErPBEgdUadRcXDRgV0Pj?=
 =?us-ascii?Q?/ugBEGTVPVZnCJl9m/nGkNZgAW7QkTwjmYRALlm62ALzCcXDZCTPCdYclu63?=
 =?us-ascii?Q?jxPtoKgom7psbJqgHZ9aMYm0JU/YUwyaDKxekPfHlX5EdJ9YUUccgJ6BKd+T?=
 =?us-ascii?Q?XIX+N42mEwXxTEW/FpogAhSdTT9UWw5Er5MGegOcKddj1g6m7W6CF1diXRt1?=
 =?us-ascii?Q?3iuXvJx8DxhhfzoigSnHAz+BA/lC218iLCrerVooCqzOn+ay+Qc3Q17cfpN0?=
 =?us-ascii?Q?GLgrRT7OZNCHp0CeR+gWrJXyXcpAjO7EDidVt/xTm/71C854rOVnWOlsSQ3g?=
 =?us-ascii?Q?CpACecm7ps3sOTT0wsGyTh4SP5J79061i6O2OBixL30M2txbxEx4jqccQjjX?=
 =?us-ascii?Q?ShXyZYq6HaSICzTbrHCPBKj64LktEqLYfU8dLiTgYUBmu4hzWmiivgLiOVVN?=
 =?us-ascii?Q?Hk/ZqAO/xHWVYmHUJEDashOlSDYo1Qi9qeffcofWeEKrNI1QaOTALbighQAo?=
 =?us-ascii?Q?oep1IOaUTNru3SZOeJzrBJeakll1HREnoutIXMi/lKNG2maplyuhobmMpSCV?=
 =?us-ascii?Q?WPIQqqw464Mb+l/+4FR9zvvMa9HnU3LhAfprfc1CNVZcEBXG5H+kyfXZKWob?=
 =?us-ascii?Q?KpNAAlnjU3wrddpfU+9o8U8O3vPopvn/gKUObNXtuB+Am3YibT2GiQ3U0kan?=
 =?us-ascii?Q?qSZMmmRTKvUumTrXq28+Hl3w1kelnOaE2/oOb0AWfs75lbKBLIlgk2l7ohhK?=
 =?us-ascii?Q?sDWP0JLDh+rnM87Ix7stWV/DkneOGkNJMeHPHzBA/w9uS92js1bOuwlvhWek?=
 =?us-ascii?Q?z+46Vz886mVBaD4b3nztAes+xiD6aENvHz/9HYIWeSy1C740Ddl7sR79KTUH?=
 =?us-ascii?Q?j/dAQ+IoMqPimgflONW2m3/PHokZqB672sIfWlu6auupzmNMwGQ0GrL6vDj1?=
 =?us-ascii?Q?0L+Ox9qSXgijK1RtL+P7rAf0vzpe/qEJstVfKTeXTghJn81ALCslLhpa2kCe?=
 =?us-ascii?Q?1DlSf9BOkCkc2vRgC1oMzoxXpIs2oeDZgFRlEhI7P2052uNDx65cTQQMk481?=
 =?us-ascii?Q?OsGDzgU2TDIbrnYn1VA18+XzrxyWdAcAGOFw2NKuPn10C8iDyjKJyOGHeWbD?=
 =?us-ascii?Q?ut/nyGBMNrJ+tQiRlib2JoYKatTfOWjh8uTiPDFHXz95nW7miCPMT0SgIwVC?=
 =?us-ascii?Q?gMneywD5aGBEB7GvY8eX3kpCRSL1oRcDHMEYBBL17jseKqPu3mbjKFbaGLjI?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e0e822-1d7a-4109-dcd9-08dba47e006e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 08:42:08.5954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ReNXLwltBb99pi9YDW6syMTS8fMqfMFtIfk65+qtvLCsUYO9HPhM5I50C/1CbKc42yprkQ0sF0fnoFtMPitiHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5934
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



Hello,

kernel test robot noticed "WARNING:at_lib/refcount.c:#refcount_warn_saturate" on:

commit: 74df14cd301a1433947077e79ce2c610654a32e7 ("of: unittest: add node lifecycle tests")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master e3f80d3eae76c3557b3c9b5938ad01c0e6cf25ec]

in testcase: boot

compiler: gcc-7
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308241628.feb8dbbf-oliver.sang@intel.com


[   70.442557][    T1] ------------[ cut here ]------------
[   70.443874][    T1] refcount_t: addition on 0; use-after-free.
[ 70.445250][ T1] WARNING: CPU: 1 PID: 1 at lib/refcount.c:25 refcount_warn_saturate (lib/refcount.c:25 (discriminator 3)) 
[   70.447754][    T1] Modules linked in:
[   70.448750][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G                TN 6.2.0-rc1-00057-g74df14cd301a #1 fcca16d7341229f468256f53411c1bbb3612d6fc
[   70.451836][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 70.454292][ T1] EIP: refcount_warn_saturate (lib/refcount.c:25 (discriminator 3)) 
[ 70.455655][ T1] Code: c6 05 3e 40 ed c3 01 e8 5d 62 97 ff 0f 0b eb 76 80 3d 3d 40 ed c3 00 75 6e 68 f0 5a 54 c3 c6 05 3d 40 ed c3 01 e8 3f 62 97 ff <0f> 0b eb 58 80 3d 3c 40 ed c3 00 75 50 68 1c 5b 54 c3 c6 05 3c 40
All code
========
   0:	c6 05 3e 40 ed c3 01 	movb   $0x1,-0x3c12bfc2(%rip)        # 0xffffffffc3ed4045
   7:	e8 5d 62 97 ff       	callq  0xffffffffff976269
   c:	0f 0b                	ud2    
   e:	eb 76                	jmp    0x86
  10:	80 3d 3d 40 ed c3 00 	cmpb   $0x0,-0x3c12bfc3(%rip)        # 0xffffffffc3ed4054
  17:	75 6e                	jne    0x87
  19:	68 f0 5a 54 c3       	pushq  $0xffffffffc3545af0
  1e:	c6 05 3d 40 ed c3 01 	movb   $0x1,-0x3c12bfc3(%rip)        # 0xffffffffc3ed4062
  25:	e8 3f 62 97 ff       	callq  0xffffffffff976269
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	eb 58                	jmp    0x86
  2e:	80 3d 3c 40 ed c3 00 	cmpb   $0x0,-0x3c12bfc4(%rip)        # 0xffffffffc3ed4071
  35:	75 50                	jne    0x87
  37:	68 1c 5b 54 c3       	pushq  $0xffffffffc3545b1c
  3c:	c6                   	.byte 0xc6
  3d:	05                   	.byte 0x5
  3e:	3c 40                	cmp    $0x40,%al

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	eb 58                	jmp    0x5c
   4:	80 3d 3c 40 ed c3 00 	cmpb   $0x0,-0x3c12bfc4(%rip)        # 0xffffffffc3ed4047
   b:	75 50                	jne    0x5d
   d:	68 1c 5b 54 c3       	pushq  $0xffffffffc3545b1c
  12:	c6                   	.byte 0xc6
  13:	05                   	.byte 0x5
  14:	3c 40                	cmp    $0x40,%al
[   70.460090][    T1] EAX: 0000002a EBX: edf25dfc ECX: 00000000 EDX: 00000001
[   70.461715][    T1] ESI: ffffffff EDI: edf20140 EBP: c5803c98 ESP: c5803c94
[   70.463395][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010082
[   70.465280][    T1] CR0: 80050033 CR2: 00000000 CR3: 04312000 CR4: 000406f0
[   70.466949][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   70.468627][    T1] DR6: fffe0ff0 DR7: 00000400
[   70.469791][    T1] Call Trace:
[ 70.470624][ T1] kobject_get (lib/kobject.c:630) 
[ 70.471657][ T1] of_node_get (drivers/of/dynamic.c:37) 
[ 70.472723][ T1] of_fwnode_get (drivers/of/property.c:866 (discriminator 4)) 
[ 70.473833][ T1] fwnode_handle_get (drivers/base/property.c:822) 
[ 70.475019][ T1] fwnode_get_nth_parent (drivers/base/property.c:686) 
[ 70.476273][ T1] fwnode_full_name_string (lib/vsprintf.c:2091 (discriminator 3)) 
[ 70.477560][ T1] device_node_string (lib/vsprintf.c:2143) 
[ 70.478752][ T1] ? sched_clock_cpu (kernel/sched/clock.c:364) 
[ 70.479932][ T1] ? __lock_acquire (kernel/locking/lockdep.c:3746 kernel/locking/lockdep.c:3799 kernel/locking/lockdep.c:5055) 
[ 70.481114][ T1] pointer (lib/vsprintf.c:2452) 
[ 70.482112][ T1] vsnprintf (lib/vsprintf.c:2800) 
[ 70.483212][ T1] vprintk_store (kernel/printk/printk.c:2241) 
[ 70.484369][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 70.485663][ T1] ? sched_clock (arch/x86/kernel/tsc.c:254) 
[ 70.486742][ T1] vprintk_emit (kernel/printk/printk.c:2338) 
[ 70.487814][ T1] vprintk_default (kernel/printk/printk.c:2369) 
[ 70.488983][ T1] vprintk (kernel/printk/printk_safe.c:51) 
[ 70.489980][ T1] _printk (kernel/printk/printk.c:2382) 
[ 70.490957][ T1] of_node_release (drivers/of/dynamic.c:343) 
[ 70.492067][ T1] kobject_release (lib/kobject.c:677 lib/kobject.c:704) 
[ 70.493179][ T1] kobject_put (include/linux/kref.h:65 lib/kobject.c:721) 
[ 70.494272][ T1] of_node_put (drivers/of/dynamic.c:49) 
[ 70.495302][ T1] of_unittest (drivers/of/unittest.c:3060 drivers/of/unittest.c:3650) 
[ 70.496497][ T1] ? of_unittest_changeset (drivers/of/unittest.c:3605) 
[ 70.497818][ T1] do_one_initcall (init/main.c:1306) 
[ 70.498945][ T1] ? rcu_read_lock_sched_held (kernel/rcu/update.c:125) 
[ 70.500257][ T1] ? trace_initcall_level (include/trace/events/initcall.h:10) 
[ 70.501552][ T1] ? kernel_init_freeable (init/main.c:1378 init/main.c:1395 init/main.c:1414 init/main.c:1634) 
[ 70.502817][ T1] kernel_init_freeable (init/main.c:1378 init/main.c:1395 init/main.c:1414 init/main.c:1634) 
[ 70.504101][ T1] ? rest_init (init/main.c:1514) 
[ 70.505225][ T1] kernel_init (init/main.c:1524) 
[ 70.506294][ T1] ret_from_fork (arch/x86/entry/entry_32.S:770) 
[   70.507381][    T1] irq event stamp: 2968680
[ 70.508481][ T1] hardirqs last enabled at (2968679): kmem_cache_free (arch/x86/include/asm/irqflags.h:29 arch/x86/include/asm/irqflags.h:70 arch/x86/include/asm/irqflags.h:130 mm/slab.c:3581 mm/slab.c:3605) 
[ 70.510605][ T1] hardirqs last disabled at (2968680): vprintk_store (arch/x86/include/asm/preempt.h:27 (discriminator 3) kernel/printk/printk.c:2061 (discriminator 3) kernel/printk/printk.c:2221 (discriminator 3)) 
[ 70.512664][ T1] softirqs last enabled at (2968660): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:415 kernel/softirq.c:600) 
[ 70.514774][ T1] softirqs last disabled at (2968651): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[   70.516984][    T1] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230824/202308241628.feb8dbbf-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

