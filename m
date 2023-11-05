Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112957E1275
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 08:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjKEHeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 02:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEHeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 02:34:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDF7FB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 00:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699169654; x=1730705654;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=56Wsjt3oKTM3mOFKVfuQJ2wpgmZnct5DsmAAlKkZIdQ=;
  b=fwodlinuirZIyL0uEpv0rMYtEyrj84u/n5k2cNWpZ/C/zm668tWjS642
   +lHT0VOI29kHsHp12c3imBtlMOdR6Vsygz0PS1lVSc293X4xXlwfLTiPk
   Y3MwpHlezlYLd1o5WS4CLx3VOAQo+ok9fVvWrz1rJEU+7AEdLdZE3aN5z
   Z6uOAgLpkw9HQ1obug0UYgsBuqAXem6IXN/7hTyR/qsvZFXqAJfFhMslo
   iULSarW6bRezKwuVr4QvtJnMEinISZHPUbEsRHkSt/+JQPt5Q/NxTe9cL
   Xuy59W7RGVWZc64t+983N5jRX22f7V5ISnj5BbVspU7F6hbISCotW6nAh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="475365685"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="475365685"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 00:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="852681543"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="852681543"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2023 00:34:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 5 Nov 2023 00:34:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 5 Nov 2023 00:33:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 5 Nov 2023 00:33:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 5 Nov 2023 00:33:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bg0Y0+4iE6oOYo4w78TpFcJZyX/Bem6taPxUD0U0AsTJJl1OWCH+CTwZHavFRf5ncit/IU/RJIrrN6IStCC3MUU5wSh4p4LL/RBp2a+zNwqDIw9M3DmowsskN2Ai0e5ElY75jBfI0MJq3B3lhcDIaSXpalf6en8J8nOVHQeEwgpbWee7tWCsqlxSK9ueGXLVEAUdhItPbmJe3aH3XSGRlrWDtVPN99wtW0KyJenqUlk+UEMiYX6W0UNgw/1oEyOy0pa3O87KtJiVtZmrOlca4PF/+9bXUgI+w6GrDnV3nawrICbqjt4+iwaQSLmqVkoiH/PfztacuhrKGdbyUStjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/lT0RmoiE3mBpqz6iDboeChOSzCjc+d8eaqy2B0H5s=;
 b=dMJTicih0CIOW4dmYVth0KtG7v+6Pt5u7MOrbr7aaREjbWqTk4j/PNfsFpeIAKYsHpPKzCv3W89MQTZ+pw4rbsC/N/bEPXdMtJfuz4pFN3IQOk0q8LNDaRslTWibL+o3Liif8tG72u4pKUd/E66kJVCTqWKwyFjt3CwQy2jchxMsl3h65+rRQ2T/2C4bG6rRxyFOh9gI4K5IoKPs9KC8QbiqYxjZCjFcGAkwSiZ5+3eV0jWJ2+RIARCuq9pLK1j43IUYaBD+m6clGRdugRnX8sYlnajcAj0a9WtU1b0sukM1RVBNcrwcU904XW/IHHtObjH2mNrpj1SAkFRGLGY+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by BL1PR11MB6049.namprd11.prod.outlook.com (2603:10b6:208:391::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Sun, 5 Nov
 2023 07:33:30 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%4]) with mapi id 15.20.6954.027; Sun, 5 Nov 2023
 07:33:30 +0000
Date:   Sun, 5 Nov 2023 15:33:22 +0800
From:   Philip Li <philip.li@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: ERROR: start_text address is c000000000000900, should be
 c000000000000200
Message-ID: <ZUdFQrMPJSAkc5Om@rli9-mobl>
References: <202310070419.BcA2fDgk-lkp@intel.com>
 <f2863503-ee88-4e00-841f-0d4b428069ee@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f2863503-ee88-4e00-841f-0d4b428069ee@infradead.org>
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|BL1PR11MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e4d157-5e65-442d-acad-08dbddd18211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gQsChl+aQkiIemMxm0DuqTjlyDZ+YRT0mUck3m7ia5hhl9wcu60jXgTD5obErSWp8lo3SR2cr+sIUNkYG1VZDk+M0r/R19q9/bANcUG3e+7XNMzap+oBv2lxIp+wNwbvCEiC9cXEcu/6MYycK1FxGZeB0qTkcLbD2bLKJe9v7o/RFzKDDktUK58gdIqiEMwzuRK/UXXpiH1Vy4m3DkTSaqxOFKm3LrKJDv59FCPiNRJcNlAXF5rVGVqjQGM+LgDHG5UDfEGpICAov7JRd9Ps+TQLcenDu2V8aHKD+9+aNLBsrWAe/5BSGi1mWJkUPsR2wlpmKj3Fh6ErncvLo5Wu6Xtd3lDzEMocHUqtTmKAXKihV4xY2Zm4WyqGCWrHZ1ITpR+ywc+dqhh7FyxDQNH+zLvpZrjDgoMi4FIrv5m328sQpofZEj0KqWzZazgbvIiYRt3SMLMI+FYVKW4Ob5afSlgJQ1wN69jREr3gFtDsL/MAWDln+CXTWtFS3l62ck7NUnubYW9v0E/hGfP19meMB7DjGVYSEUII/QwO3AG5TCN0ZQZxBK8mSfucCm0CYq/uMYyY4R92w1xaNmOXvpLn3bkAORa0a/vSUmviGhtzPvsNWXTTYslh6wMyjdm8FzqDBF8TFYksVAl6M2SadXslWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(136003)(366004)(346002)(39860400002)(230173577357003)(230922051799003)(230273577357003)(1800799009)(64100799003)(186009)(451199024)(6486002)(966005)(478600001)(316002)(2906002)(5660300002)(66946007)(66476007)(66556008)(8936002)(6916009)(44832011)(4326008)(8676002)(54906003)(6666004)(9686003)(6512007)(53546011)(26005)(41300700001)(6506007)(83380400001)(33716001)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aXQtclGR+8bkYgGsfD9ZDJefFXbVzmsXOJ2qh7p/KySLsPxK7EBq8cpeX8zo?=
 =?us-ascii?Q?oO+I9oMz+WDYCqE1fHWL51X+lIvEfdRJaGICVZEDQX8tg17x8qneoqOJVpGZ?=
 =?us-ascii?Q?RSvKid2XbcBGXukE2cSfc3tTnFGJal5STH13vzRcqdB/F59oAhKz5BfkjKip?=
 =?us-ascii?Q?XQNZo29jPIt9SlU8mgXttMZpOqpmAy6TZlq47zvxCCFWCFychdVnxAg9pZnT?=
 =?us-ascii?Q?5rwoFhh3C7Ft6KZ6sgNw0y7F2oGQqHssqt+fCA1McAPR8TcuBlUQtl/4nY8u?=
 =?us-ascii?Q?7KvctrNfddsR9Pr2w1J6uSjJslD3CZjVPXd4R3ripKZXecJ1wUTWzzzbwTrg?=
 =?us-ascii?Q?IBPyrKm54IxIH6CFUP9XEqNb94SzSLVECdjkxHHkSJtpU1hmjnx45CVKZZZu?=
 =?us-ascii?Q?oeFvNbawQsGvZoEff9cB3409HmIIfFYAeAypvOf9sAWNngKm645+YrWrYRtj?=
 =?us-ascii?Q?QQXADp8B46bOLaoGwzikJMioJ08jZaOHQQDKHH6+SifOnamHP709B2hnish8?=
 =?us-ascii?Q?I+gLfbEBn3GMFRDr4AvUk3IXa9dI+Zvn9g21kQTE8TQV14STmqdTh70Z7qt8?=
 =?us-ascii?Q?hQ/yvuuHYyXYcoR1jpBrcZz5f4uSN+2Vnw1ZTgCUUOX38hZxxjWT1srocm4f?=
 =?us-ascii?Q?BdekrYPvVuoXV8qFowwjTYlpaLHaoVVL6IfCncxp+u+Dxa0i46xDGVD8wPOp?=
 =?us-ascii?Q?VUvmJC8CZkesoP5iMvEJ83Eq7eO9izOi/Oll3N9PD5uuao0CpzulHe6b+2gH?=
 =?us-ascii?Q?Cs7RNoH8N6CkPaVQL0xFcXg+ZPdvT7/g5GADSfIQvzoWrZU8pvFAdRhguj0v?=
 =?us-ascii?Q?4l7Lkfi2KlwVOtzFt0yn+tdLgPpSbroowNyYMGuhyu/cA+UmkDY1ZKM55XL/?=
 =?us-ascii?Q?7HuL/Z14nUVWJSzo6FyizhgO/SIgthS0p7TdqFHcPvzO3S5HM7TbeDqTxju9?=
 =?us-ascii?Q?RTrx3e6TdLgPqzk9AnC844pB5c28aiEKr7RW2nstbvUzGffXvaGGVKX32tTP?=
 =?us-ascii?Q?WQ4YIo4OdgPlg5sQ5Vpdp9zwlvfEUQ+J5BlEzZ43AWYg1/U2xlodeGY7ya2E?=
 =?us-ascii?Q?ComOnEiqE4KIERQQnpknRcID2jJ09Q2OZrWy7BKdQqJhqjWT+zO1sj0E3eZR?=
 =?us-ascii?Q?ILS1MG/+BONeFgngL5x2hhS3HBR8PSKIJhBkbV7qAEkb31k6+boHC0WeT1hW?=
 =?us-ascii?Q?7Nqy0ZzsXd+m8VvjXlmDYG5BUHv0eD943c8OeVPVBlOyc4ox6YqZbVaoyfEZ?=
 =?us-ascii?Q?MuXGHTVmquTZ8NY9y3yIa7ftBDl7y5XeBaPAAdhCS5w3tsZjem3oq1S/0bCj?=
 =?us-ascii?Q?5xCMyt9F3/fd0ACB0uYH1uOwnyLaekP3zv6/p7BV8DKhXmLekkAMOP2zJ+pa?=
 =?us-ascii?Q?lJCJFPAx1rWv+RR3emOgRAsZdtOfeFr0pX5pwXdl4/VwsnLVB5NwG/3wQo+p?=
 =?us-ascii?Q?+msw01xQVvOy6+3dlZgG4Q2qV7Tn1OWKMVMxbLwWg1JiwRNmUnmukyqm+0Z0?=
 =?us-ascii?Q?sjCfkn8FaY9rC4jMS/DXbdc56vrRUjFPDXDvrvzEW7DkOYUIGjZG+SELtt69?=
 =?us-ascii?Q?XzDf1YVWlBJvUlWZvt7rKmtWzOQI/W6Fqgv6BGlR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e4d157-5e65-442d-acad-08dbddd18211
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2023 07:33:30.6416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QETtDZTi4+3xtLWK18SHbIPdZiTby+X0Ca3Ck37vFRFcwT3RTk0aq962PbxKAOq74XaJ3ubAvezoY1+9a7zgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6049
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 10:04:55PM -0700, Randy Dunlap wrote:
> Hi robot,
> 
> On 10/6/23 13:41, kernel test robot wrote:
> > Hi Randy,
> > 
> > FYI, the error/warning still remains.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   af95dc6fdc25e616051d0234aad638e15c02ec8f
> > commit: 47c258d71ebfc832a760a1dc6540cf3c33968023 powerpc/head_check: use stdout for error messages
> > date:   2 years, 2 months ago
> > config: powerpc64-buildonly-randconfig-r003-20211118 (https://download.01.org/0day-ci/archive/20231007/202310070419.BcA2fDgk-lkp@intel.com/config)
> > compiler: powerpc64-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310070419.BcA2fDgk-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202310070419.BcA2fDgk-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >>> ERROR: start_text address is c000000000000900, should be c000000000000200
> >    ERROR: try to enable LD_HEAD_STUB_CATCH config option
> >    ERROR: see comments in arch/powerpc/tools/head_check.sh
> 
> This build error also happens when the referenced commit is reverted.
> I.e., that patch has nothing to do with this build problem -- only where
> it is reported.

Got it Randy, thanks for the information. We will take care of this to
avoid reporting the false positive against this commit. Sorry for the noise.

> 
> -- 
> ~Randy
> 
