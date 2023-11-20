Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FB97F1541
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjKTOFs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Nov 2023 09:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjKTOF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:05:29 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2057.outbound.protection.outlook.com [40.107.222.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C394010D0;
        Mon, 20 Nov 2023 06:05:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCjtRAJ+K4GMcJkHcX/hSIk4Ey4IM+Ew5qmcMIaUdfWWcYkGnXF6Ozf1QgGsDdH6nsccRDhNZ05RqWtoN4midqHy9VCTY0gZ705R+EeeLnGTVO1WClYEDIWXEGPCIiQ5z6OMdIfBwsWQp+XhKS1LJlNg9RcJ61U+4ZBkqQXzZlK+1UZ6IsSCRx2mjzgEgDjOsNTaj946LTztItOFCZieM4i6r+fsBkJzRi1lXgTXyDKDf/KJDZ79+VbVRkoFRDykHyLb8Oj+w/cS6Lls8dy0xvEh8rAh2EpfZYe8SQt/wsuhiw2JridfaGHc62CpunN1pV20QhXo68EP4QG66VBJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9O53FPsRH7vVM5KAECj1cuM9SKQ0JPXmveWlPdv6jM=;
 b=Iq78ZXQA70x8X3fvUjISS8mnz+bfvh4lFDKOkboN9W0aEvUDT57IL8Ep73naOGnUULoELLqsKeZo3Oj7CxrXvxcK1n8OOys0eJh44cxFlz7Mu46HKjsfqFefAVliMcdbKkrOW20RmRVeljnSoVBuXc82G0p/S4bt45o5spV9nOwmqmxeuVTK/4UHK9kGJkpVfUM1NlbDdLD5tSadE2eVwfjbWrfRvG99ZhHGUiOKe+uDH8kkLPKW34PF9GOEQaF+xmrqg+pBzvrdFxReaj+qKAICePeOSAleXdzqUAly1+xOc6rWevPNHDtqzqI/L0FvCUXeqVN325qFkAbOvAfJqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:8::12)
 by PN2PR01MB9864.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:153::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 14:05:07 +0000
Received: from MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1848:62aa:1da4:1924]) by MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1848:62aa:1da4:1924%3]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 14:05:07 +0000
From:   Hiten Chauhan <hiten.chauhan@siliconsignals.io>
To:     kernel test robot <lkp@intel.com>,
        "jmaneyrol@invensense.com" <jmaneyrol@invensense.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH v2 1/1] Added tilt interrupt support in inv_icm42600
Thread-Topic: [PATCH v2 1/1] Added tilt interrupt support in inv_icm42600
Thread-Index: AQHaGJM2NB60QFB4YkeQgZumYPYvxbCDQOaAgAAC2fg=
Date:   Mon, 20 Nov 2023 14:05:07 +0000
Message-ID: <MAXPR01MB41180FA9B8B59B63AB488753EAB4A@MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM>
References: <20231116134528.21467-1-hiten.chauhan@siliconsignals.io>
 <202311202146.D4gNcBnT-lkp@intel.com>
In-Reply-To: <202311202146.D4gNcBnT-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAXPR01MB4118:EE_|PN2PR01MB9864:EE_
x-ms-office365-filtering-correlation-id: 2257a4d5-13f5-4e00-9707-08dbe9d1b39f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IuQggEFmFVSPGAohrN1a0I70+r2X00cKfOSSeJrDYBV2L1L7fnuAOo75owJ8CqWY3lXxA1e2+lXTBzbXVki0emQuQmA3fCnDDMNI1AtlIT0n9ZIgohn6R6vtSmEKEcnjZnm92q/Rjfe83fvDkgM3ZlRfIwx/U7FpyNn8vcY99BKQOrpRcAR+g8TzIfj6LDdIprYO18NBoNDkclhkEU0LRueqyZ67/HbToIi4foO59k6D601EWSomWsQ7sZ4SiLoe21dKz+L/Dxv1ZpEZHbl6U4KA1Um2zYenjbUe+ETIqWmO+qOPRl83I7ZYk8FvRiXZa6j+4owDnJevyBaRNjlOLYZ2RPNQNbAllSuPLno5AU/lc2BLb3+AYwHFKrGRXD8U5/RcthPtbfrWV3wRElFA/a1v7v5K/S5vO9wSdxoJE4ZliPdux7rP3eHXvnAKxEDTyYFXgozoJEtiiBOGzrteOKGsneZDWq23MCaDvVY8YipmOHP8zz6IdXx6yJqy3kaKSNZk0xfTdLF3dBWGiqzeOOmr9JPE5G8rnY6bxOSNTXcSeDLiD8jvzqpDEwC9X43UguXA3yQkgosMpydPrj7KLIewQDddPs4+zr/MtKLRyDgcp6Ph1KgdwL3u54TBrNev
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39830400003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(7696005)(6506007)(9686003)(53546011)(26005)(122000001)(110136005)(66446008)(66946007)(76116006)(91956017)(66556008)(316002)(4326008)(8676002)(8936002)(64756008)(66476007)(966005)(478600001)(55016003)(83380400001)(38100700002)(71200400001)(5660300002)(41300700001)(33656002)(2906002)(86362001)(44832011)(52536014)(38070700009)(3613699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kVLSJNl1E4DrugeZ+CAit4AeZUMkwQtGH8n38vDCq30ahKTYB4PwzPBYjH?=
 =?iso-8859-1?Q?dAqa+ySlPCtsMhRvOYLtCXKeDnUzzdzbTGk5kpdl1pI2zkPVbbqAK449Yh?=
 =?iso-8859-1?Q?hDEDAiBul5wtHzJh+yu+dJQ8tp2eievOUhfOoVvsV8alwIIkLCzHvJ6qXP?=
 =?iso-8859-1?Q?Rh+GPpplVYDmUdHmzCg0EE9FLFdjDoSoeLHB3PrvT4hWLwHYQwse5J8WVQ?=
 =?iso-8859-1?Q?f89ueJvlOgRVOCjAtPzrKx0/YjvKPpoaTxkweedwxBbuOh8UDOwIdQ7Ylh?=
 =?iso-8859-1?Q?tgmS+aUYznRcS/zGHjbdbN8c4aE2hzkAGmZnw2E2IWlvJnOP3zd0/E0DuL?=
 =?iso-8859-1?Q?9ve9JnLeYHUoscyMT8wNNpZF16HFJr/ZYgoyxbgOKcLI5z6pvG6811mw11?=
 =?iso-8859-1?Q?R+Ebm6cBsKhgBr+58srW3H5cCBSsFfOoCyaE2/mLqXszt2ID+la5oGrGsx?=
 =?iso-8859-1?Q?v0um8IaEk1yRKEnFgdpVYOBUPEv5A/UjCnKm9X/oOnGxyiCRTJOfjmBK2w?=
 =?iso-8859-1?Q?/CyL51GHsvYlNLWkqsHJkzQo13g3hnwv9Vupyp9JhmOj+u+eM1Vtzk0E34?=
 =?iso-8859-1?Q?l1D3EkmikjJ0rBZruWykAndZEYmARjTkqw75dkfCyxsx6Cy4GSt+l6hDAv?=
 =?iso-8859-1?Q?9eOFL7f6TKlM6lxWAD81NlIhDpakOhWN7qLlELl/0STouyQlfm0cpDo1u9?=
 =?iso-8859-1?Q?wEHYal0rfQCOn/4zUA2Fw7DKMNLCd8kCaYhz/V1Yk9u1RYTzz0SKhvu+hM?=
 =?iso-8859-1?Q?HHnqpeuztfjE6jAtKrfOriQ/1Njazf7RDrELYsqDZLbqqhSbRdDan+pboc?=
 =?iso-8859-1?Q?rcosNV6O9mLyKmuHOZ/+Xs1awv5+mJx925gInySIesxJLYAjiKjA9Uv7tK?=
 =?iso-8859-1?Q?CARp2gLOb73MTrq9xIVhvRxHlMk+0C+1+JW3x0HOqiilkr94FBuLn54yQs?=
 =?iso-8859-1?Q?yB6zCIZwGWCkPPVT3cOMm6TOupY9yTKeAeGI2JinUSPEdQDiU48CX027yK?=
 =?iso-8859-1?Q?xSRv3eb6r7IeAuNCs6wLjwWUYlAI5s8+tQMwwQpW8OJOvy0Ok40RwreeuM?=
 =?iso-8859-1?Q?PZkVouzgL39rwnBuJbvfdzZjZo/BGDkq6CmgY3oar1lTwvJrxH0Zikml1D?=
 =?iso-8859-1?Q?8/MPBnC9cpsLJMKrCSIRBcqTyaCvS06qnO/+8nSk66urK2N2grUNj2mdba?=
 =?iso-8859-1?Q?FzooBo3E/NRTcdwaXBrhZoWa2O300Z2HxXxexxF4HMPMYNIg6f8CM9h2Hg?=
 =?iso-8859-1?Q?cmx+UBCO92WL2pK55w5O56qZsn8lwWWWUZ1iC1SqQckVGwCTyOleQaPfLD?=
 =?iso-8859-1?Q?sDnM/XVglMQpnPusdFNiZtaCwgQZRNcX2UP0cO6okmOGxCrB0Nvz8HnBz/?=
 =?iso-8859-1?Q?GMhzyshfqxc26gDOgVow0dszW9luS/8v/yahnbaIj3qftTSeguekXRigup?=
 =?iso-8859-1?Q?0TKAUkRQs1XbJFn9ehFClzRgyH9THJG1VxRjxZF2ESSF8t5tFhGP7vkbpk?=
 =?iso-8859-1?Q?9GfBss3fL6NMekz5X21UinjCe92K9KGPfheg7YyCAZefbdiU/PYLy8L+2i?=
 =?iso-8859-1?Q?kEercCj21N6JaV01ZNdyKNMc7P4mWa4vOOhLSYC+z628AZTvK8eJqXSLn0?=
 =?iso-8859-1?Q?NV/NsSLa5K9mN5a3Uyi5FEvLuEhANZnxGFe1xxCcs0k1Y2gYVQTD1m5A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2257a4d5-13f5-4e00-9707-08dbe9d1b39f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 14:05:07.3916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZLKTpLwd/vIin/8RGlH4CvTast3R9VqKQ2azse3jDw8XPnouRQSuKJwG7TYnknOO4Ig7vQftuigYizf9FQEkZZBvAt7jlP1EAjgriEwwRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9864
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi @kernel test robot

I have already updated suggestions in my patch v3   "[PATCH v3] Added tilt interrupt support in inv_icm42600"


From: kernel test robot <lkp@intel.com>
Sent: Monday, November 20, 2023 7:24 PM
To: Hiten Chauhan <hiten.chauhan@siliconsignals.io>; jmaneyrol@invensense.com <jmaneyrol@invensense.com>; jic23@kernel.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev <oe-kbuild-all@lists.linux.dev>; Hiten Chauhan <hiten.chauhan@siliconsignals.io>
Subject: Re: [PATCH v2 1/1] Added tilt interrupt support in inv_icm42600 
 
Hi Hiten,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.7-rc2 next-20231120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hiten-Chauhan/Added-tilt-interrupt-support-in-inv_icm42600/20231116-214808
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20231116134528.21467-1-hiten.chauhan%40siliconsignals.io
patch subject: [PATCH v2 1/1] Added tilt interrupt support in inv_icm42600
config: i386-randconfig-062-20231120 (https://download.01.org/0day-ci/archive/20231120/202311202146.D4gNcBnT-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231120/202311202146.D4gNcBnT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311202146.D4gNcBnT-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c:116:39: error: too many arguments provided to function-like macro invocation
   static DEVICE_ATTR_RW(tilt_interrupt, 0644,
                                         ^
   include/linux/device.h:179:9: note: macro 'DEVICE_ATTR_RW' defined here
   #define DEVICE_ATTR_RW(_name) \
           ^
>> drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c:116:8: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   static DEVICE_ATTR_RW(tilt_interrupt, 0644,
   ~~~~~~ ^
   int
>> drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c:120:3: error: use of undeclared identifier 'dev_attr_tilt_interrupt'
           &dev_attr_tilt_interrupt.attr,
            ^
   3 errors generated.


vim +116 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c

   115  
 > 116   static DEVICE_ATTR_RW(tilt_interrupt, 0644,
   117                     tilt_interrupt_show, tilt_interrupt_store);
   118  
   119  static struct attribute *icm42605_attrs[] = {
 > 120           &dev_attr_tilt_interrupt.attr,
   121          NULL,
   122  };
   123  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
