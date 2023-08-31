Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2894078E44B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345535AbjHaBY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240157AbjHaBY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:24:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137A01A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 18:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693445092; x=1724981092;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CgifBdJiGZTbPCR1soR1AkTqoqytvIeicxFznA0ChKE=;
  b=dyhPcqKqTdO9O9NiCV3qbwfcnI03AL18r+7YqHInz1F48Ulx7GdFxr0l
   4zqgD1J+FeBf+Sr3eAcYNhXYPhE5yvpkMIRaM6BqWUbno2vFLt/4sH6xD
   fC1+IUmroPrW5JO42aoAb1gggckxVFDgahOMgAuzS1HGlisErpUxm9a+H
   WBnHyp27UwZJybxgU8sMQsJVnSOgtC1QGXtgi1oMKyqsX+mjBItU2MaMn
   7cKBjFYbWoiYcqSVICu/CSDL0nCmzk9Z2R1ZfsW7t34uS3R8RUx5mczuC
   d42njJCiY6Dm+1NYQsx64jWv5NWspt1A1L4uH5x68DDpr/RbYls2AGFpO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="379537506"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="379537506"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 18:24:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="1070033524"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="1070033524"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2023 18:24:51 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 18:24:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 18:24:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 18:24:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UefJPJwrc4aJqC6K9sqMwfDsF6eDyMR0jkDmbiPYTSQUK50MSPielXknKOoHMDi+JOinO7iIkgY2yUB1dzgreSQYu09elLZZ6YB4oKQWU5aqf6TLe/1fsjEI5UmJT536wjYzXWCaNI3XxuRYXT1/zY684IR0JOtl4g3DIjboklgBiSEPDUGm9ZiVvG1hteL0aKx84yjDJ3S76X09BHUM199ZKO7GUjFdJNeuui0YY1xVUsjxK3V6qVNYXMc/gYrfX+ivovtRVRX+8921lDE/yprZISEVsbcv7HP8yub1ewzQDQqeNfOiuOp43WUQ2KguZDPXzJCFtXgdrFx38Ah+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNZgYS+ZuO6RczK/++V1B9FimXNaJ+AYutYKjh9UUjI=;
 b=h7RLqc0KEWEB9u9VFodsEHDMl7pV86XnRaqfgCjXPcxxp/jug6XEacw+zn3EvjnX1V30KtfJo5tuA7x0UDwXIIeO4bX8yEPDPhAqdegD3pS1M3mdHBTeu/5ViFJmwRJNU8+iOTDBY1QdWs3zNS/gltFPiXn5aa0vdcXM7SHTTYMh5ampp3x+hNOy0K1TkzCwNqKI5KjK8/eW6olWELxeXPXEoGLmVpwOSAam4fnUkHD4HqUHaNCYmH8KZOaPJKVjb03voG56WHiKVf0j2M0xLybn5DNJQiZ/Wxk4PLTSuPxY/saLl7uv0DhL9XVKPIki/nIrZX6TTPnPIfAFYx798Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Thu, 31 Aug
 2023 01:24:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 01:24:47 +0000
Date:   Wed, 30 Aug 2023 18:24:44 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-coco@lists.linux.dev>
CC:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
Subject: Re: [PATCH v3 2/5] configfs-tsm: Introduce a shared ABI for
 attestation reports
Message-ID: <64efebdc97b9f_29e220294e6@dwillia2-xfh.jf.intel.com.notmuch>
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
 <169342400469.3934343.12316161608372095860.stgit@dwillia2-xfh.jf.intel.com>
 <7333e392-a557-49e4-a457-067f18d12139@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7333e392-a557-49e4-a457-067f18d12139@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:303:87::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a86b62-fe04-4941-4a0a-08dba9c11084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZC7or9KdtNuGfUWKphiBNUeEbGo47W2UqlEmzDVOnLOm4t402SmN4DrdQ5qF3Hd2aPEYrmhgQDgza/neXcf9/IigxjIVhOqTLHyT6XElGeQrbSsiKvtdEKR7UqBZ2Zl/ixTsZf5VNqLzZ+K7ornt/QzKqp/X4RUVhs9N61ZR0bf3cWv4RItIAH5fJKUyL704auC7qqPPNrA0EU6vtjHcKdmjTKp7hOPjqT562RrxTMGnkr1YUWamedOzJQIDoI3cVp3FhNe3DbeQMHpYppavjf+TGrRz9I8Ier2jOX0af+Lcoxw85DUX2BJvMzopklvtNW28BmXkQdtxnRdchgk64rw5/HkCeWQpDAB5EV8gxXfzShXn0VwU4YI6+kQNWJwPNO3tjWsXTeFXPwdKGb49vezdo0chzCS+fq5hiV7AdINAIS7+3pNMXmfH6lI7ASRLRfob3YVeh6V6O++HeqJVL0fmOK6VMg3rh4jpRkdgpFqoY8/ZW1xJUhxCBllVRgO14LaEFylFopFzzep8miId1ZPPnDd+Y+k47hkg+llU1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(186009)(1800799009)(451199024)(478600001)(966005)(83380400001)(26005)(6486002)(6512007)(6506007)(110136005)(9686003)(6666004)(82960400001)(4744005)(66556008)(7416002)(8676002)(38100700002)(316002)(2906002)(8936002)(4326008)(54906003)(86362001)(5660300002)(41300700001)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yTzQ/bCEGr1uOdSYtLqGa1HmSC/HC/1MXnanBlQp5rkqACyQmwnbFHEysWRc?=
 =?us-ascii?Q?PVmCV4gSNqwIpNayckhYJ66tiSd804wqtCF+srR9KBmEk/Ri8j1nRTWiXa1W?=
 =?us-ascii?Q?ArBIsuco5sIpNk3X2ghrKixDQ5GrTWNJ3b4YlI72I12I0Lr59LZYmo3hj6Qb?=
 =?us-ascii?Q?RkqI5IQd8F1GYfjrPxlJbew4LFmAgFzxPY0R19HgaHq1Wa9p8BZccT0KElWw?=
 =?us-ascii?Q?Qw3zawhiot4xkBMw3kwwBar6jKjLdXVKinU/L9mLvzICVGZ0vru5oi1v9FVy?=
 =?us-ascii?Q?arNgbbocb9aPoZEqGSNBYBUTA0FCtc+B+XiPx7IYohlp2pKa2EKXN0/IDwH+?=
 =?us-ascii?Q?9/nw8Xs6+hySXo5MxxsSZDH7xJi2K8opaQUnZMruBYDckXWh+etIohdpN4re?=
 =?us-ascii?Q?LAqtVMMioCamjo2wg0vABwyw8xoAQ6WvCicDRH/tu5evR1DTIYJ6fCDS6X9G?=
 =?us-ascii?Q?yyXZuZ8RC1EY1X5PvqgHjqbXO/0H0JsSzBfdk4hYVH03U6D7Z1GK3QMB+6X0?=
 =?us-ascii?Q?pSVnX+pp53VFmUzG+znPfObSC9En2e6PM0MopGBzx5utRDSPGFwTy5lmH0MJ?=
 =?us-ascii?Q?gbts5EliUeqy0U51NbrbpknZnMKNa6oDVEsVs1Ib4lwurdcDCMOttIUPSc0u?=
 =?us-ascii?Q?HpKrkFLbRUZBaD+B2H6HSMoDngp7u0+niTcTz8L9/wPD+KmJ7MpFqvgfaWnv?=
 =?us-ascii?Q?gaBAkI7q9N9ksinNBX2HXyv2NWa53lj0JVt8sYRI7bssQt1EccqyRp0yCvCi?=
 =?us-ascii?Q?N+up5C2BpAAuqWMK1MxlmROJOIKfIO2oypH1IV4PGd6rgK1FhQ6mF+RA/MXW?=
 =?us-ascii?Q?KLMMNjqXkrFJBKLOVoIWteV453YazIXOp6N/IeJwGxLN7V6fp+WKsd1j8FPR?=
 =?us-ascii?Q?kM2XAVEzX1JGakspM10yhz/D2KkMBgdNxh5Vp9ufV6GCr0YTZfI2PITRIvH/?=
 =?us-ascii?Q?NtaV+8v4Fp2zHY/xsCfldXLM7/VioLabgIy/7fkidKxjRZP7aLKxnxdTFQNm?=
 =?us-ascii?Q?hHnrVLgxgTAW8o+ryXx6y9oyVSd44HY6nvshc7ho/o2ZRg5paiUVi3pYhhd+?=
 =?us-ascii?Q?bSZRKCc3aq9B9xLUInMzJ7ianG7dc+WtWAa/ZrAo97oqKRrb0DyaA+vA/wRx?=
 =?us-ascii?Q?tpT81jxmiRT2oYr5qJbGWUA5RuSOAEDJHtUOtDg2GMl4fzV5V6dBGaqZueY3?=
 =?us-ascii?Q?YUHi8QloK046YHwC8DAfnC+IzZCtWTmbj3Hb2Ii0PQy1ff2lRktbyqju3Wyq?=
 =?us-ascii?Q?XF8pYFiMSm8O0wypW8Ss8xNvtulgh2oqMZRbIGuuQv5F42BF8Bn1B5bd+s3Z?=
 =?us-ascii?Q?43AyzQW3sDGzCkhrTU00XQX9EmoFz7E0brquDPsmEdektukdx4b+oFxzrFGZ?=
 =?us-ascii?Q?naFPp8vu6EzewPvpP3wKVozGkHaAGUGodQtg+gvv7kfbasHJnu9s7rEatWOK?=
 =?us-ascii?Q?4SLKhI7upiW8PdSjZQP+hh+3C8QjgssB9jruDCb8SS4obzt9GztBM0WFCT6+?=
 =?us-ascii?Q?DmVhUJnCDrtIvHtDStFDo1WqQiMo1SdRUrs+TdAH3dBjOl0zPEpcfdj/yfCQ?=
 =?us-ascii?Q?B8YBCr4MVTF6Vyy4Ck3kpYVbKmFPcSR3WURLWrfxz+JzJkyy7Tk46FM5Hfnk?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a86b62-fe04-4941-4a0a-08dba9c11084
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 01:24:47.5106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33JaoD7kreppGftV7gcDqnp9ON1m68p3ReV1MS/uS4jgix6wl0kyNuO/mM5QVXAQHqDgq5XgUR1Bc1WTrs+WyiVRez0yGhpf+GeqR86ZFb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6776
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

Kuppuswamy Sathyanarayanan wrote:
[..]
> > diff --git a/drivers/virt/coco/tdx-guest/Kconfig b/drivers/virt/coco/tdx-guest/Kconfig
> > index 14246fc2fb02..22dd59e19431 100644
> > --- a/drivers/virt/coco/tdx-guest/Kconfig
> > +++ b/drivers/virt/coco/tdx-guest/Kconfig
> > @@ -1,6 +1,7 @@
> >  config TDX_GUEST_DRIVER
> >  	tristate "TDX Guest driver"
> >  	depends on INTEL_TDX_GUEST
> > +	select TSM_REPORTS
> 
> I think it is more appropriate to let TDX support patch add it. Agree?

Oh definitely, I think this was a leftover from some local debug.

I have fixed that up along with Greg's feedback and pushed an updated
set here:

https://git.kernel.org/pub/scm/linux/kernel/git/djbw/linux.git/log/?h=for-6.7/coco

...will keep that up to date as review feedback arrives.
