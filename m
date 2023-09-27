Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E357B0737
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjI0Oor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjI0Oop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:44:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B559FF9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695825879; x=1727361879;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GaiRfSpwFhWec6q46kNzREtW8tnFunqMljQRLppQkdA=;
  b=XF4AdLlYilQUxF6L6POZiK+zBmqPDTQELDZhmQnwp4ElCP2xAOCxSDMk
   NtzpGLXoRxK+xQ4CJ9PSSmZlMK3C4/5DLiV/glk2OpNTYJTN82dlJw71g
   oocAlDCUeKJLC3tEDjP/wfLPrEhzigNzNzmfrCsCfwi4sAPhvoqx1pd1J
   6e5BlLb1yz0aQpUbGQKTZtfy7CP2uZtfda9CPuGmjE1+nPraH49GoIrWx
   x9GIzIp2X7eDIQNKWp9OAkB6IFFKjGj47EsPZzmb3tLQf0zADrZa/SvO9
   65GV5BhCAsYPuD+M8JUAOsw9tRtf09CEfpuhz10bXAie3Caqgjv2JXLrX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="412751461"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="412751461"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 07:44:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="725831286"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="725831286"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 07:44:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 07:44:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 07:44:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 07:44:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 07:44:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDCFiAGQJ8awne2P9lQgxA5cTUWR6YO+xe4w66b+uh5myF8eo/nlO/QilzN3mPEzbN6GWrnRZij4EHzAYhfNlm5L3+qGGuEesE4AH5rjlqcvMFqa2DRxqQiMRieqkxDLd9ZdujwfZcQVyojaAKH+7+quk2XYK6Hq6uH1cXZAhxAT7VUGFN6pevKQnK3FddvFRec+Kf1ga8zcdsnDdJIGyHJ6yPAiySHetbVm5kIrimrLPUp3uWb3ZH3X7F15OM11qedQb/ER+DtKGsKggoj3bmbvVOtXVeEheMIR7+S5FqO1hn+5OXoc7kk1POwku6p9NRDNq6nZyaFdAMXFWnTHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/2ZYL0wWaDb+pWQJKq1bhTg2ynFd7tHMijainVG2SE=;
 b=kupnwOrmZEUZXaIwPv4oHUx+duEX3ispdMmOeYXoK9A/MJNu6dmk1kknDsRFbfyQ3vRv5pqHns4S21Vfw51n7P0gLU3kQEXT74FSa9MSDshY0aos6IiFolILEv+S0lpNyWBfw8+FIwp0LQQwPONf0nzBDqQjzPaSSYwCaOeMwhhfBfyDbUPHX8DQG4kcTw9723oDifYPLQUT43A0+J8AKvRPdPzRbQ96NgEOemMhPzaJ4G51/+Pm8Ud61WWqV28VVTMCoOLv2p26jqNVIzNnUAfCcgXrqQFIbicnHw02VtQQuwxPwyyQ/VQuUOmlQr3PgwyJMpIlTr/TNUZOvXkpwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3006.namprd11.prod.outlook.com (2603:10b6:805:d1::24)
 by CY5PR11MB6535.namprd11.prod.outlook.com (2603:10b6:930:41::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 27 Sep
 2023 14:44:34 +0000
Received: from SN6PR11MB3006.namprd11.prod.outlook.com
 ([fe80::b2f6:ff19:be0b:362d]) by SN6PR11MB3006.namprd11.prod.outlook.com
 ([fe80::b2f6:ff19:be0b:362d%7]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 14:44:34 +0000
Date:   Wed, 27 Sep 2023 22:44:22 +0800
From:   Philip Li <philip.li@intel.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
CC:     kernel test robot <lkp@intel.com>, Andrew Lunn <andrew@lunn.ch>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: drivers/leds/trigger/ledtrig-netdev.c:120:34: warning: array
 subscript 17 is above array bounds of 'char[16]'
Message-ID: <ZRQ/xt1FFJ5k0G8w@rli9-mobl>
References: <202309192035.GTJEEbem-lkp@intel.com>
 <6512163f.5d0a0220.e4212.8150@mx.google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6512163f.5d0a0220.e4212.8150@mx.google.com>
X-ClientProxiedBy: SG2PR04CA0162.apcprd04.prod.outlook.com (2603:1096:4::24)
 To SN6PR11MB3006.namprd11.prod.outlook.com (2603:10b6:805:d1::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3006:EE_|CY5PR11MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c55388-27d0-47a7-b3b8-08dbbf684411
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDqXOBu2CjU8gQ6+XXIuc4HCp/sXF8mDqFIyE19zE5NAmopwUxmbntFRzG+Y7l3EtqZR5o5p74Nv60/IvFUg2npDSKsNjm3opXa4QLHXG3i3oqtFmAWU9a0KHRsV+ucGtE0L2HpC5mcPBPP+gnzQ3Ior+399wpnUHD3unYO2FjP9b9ThZuyYUesb9jBnVhNDCb2RQ54P2mQnykldVUvamKIEkJsMyfUSonQqohOsA1yTaT+CwO2aG71Ss8yvYbuRywP96w/TmB5+q1h4Ee6hzBcWRXe1Zc67/lTi2MGnCHL/IqZTALlaUPCm31pHvTJyJJPePpwXr7QW8V4GQ7z30Tw3NV7UkD8zsiB6CvKjtSGZwwa+S+k+Sd9728rY3h4KDXK2+JeRrvFDw2QHYfYSdpZEaf5DHLMqJiu3z8qcpPkU/g9T9vuSrrJz+E4DLf9kM9+8bVZvWeSi/mXDJYp+bWo4Jaa/Wuy8Ex3hqG2FW7uqeJfGvxJ9geBer4sjHCGGQN+rUH1NqFPwKujDH9DqVoVC7SEuekkYGMaJeYjgXCG36yj+dCXq3hkxVzGlvFz+Q2SAvZnjb17pziwnd2enrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3006.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(366004)(136003)(396003)(376002)(230922051799003)(451199024)(1800799009)(186009)(8936002)(4326008)(8676002)(44832011)(5660300002)(41300700001)(83380400001)(6506007)(66556008)(26005)(6512007)(6916009)(54906003)(66946007)(9686003)(66476007)(316002)(6666004)(82960400001)(38100700002)(966005)(33716001)(6486002)(4001150100001)(478600001)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mMESMwuawJDtXiikWwQyUFNzNl9KOQvti4RU/+HMgLj816ke9GKsXaNnQQTB?=
 =?us-ascii?Q?cdrgNmmY/JRahox80mPcKlU7d7jwuM1Qs/178oCl3rUdSMdd1QMDpieF9w1G?=
 =?us-ascii?Q?g8k+XIpOE1p6jAuPWK7YBEXE05Mju/udE3gmVeBG9igr9g77//fFWeNvPogJ?=
 =?us-ascii?Q?H+AczvjFhj7Tmth9JG5MGUuTQ1PySL08WyRQ0YM7QT95Q2tUpr1ZqNhpAj9n?=
 =?us-ascii?Q?PII1gQbTpfObtJsXhAP6mcWo7SrZL/LeCIxcXVGVlvGOzAqBioDPWvRHDFfu?=
 =?us-ascii?Q?6mjS04dtrYeOpfaElSCx1BG/eOhAUhUN9YpRoHSMaj1x0REniXojvheZEUPK?=
 =?us-ascii?Q?rN0St3CyQqNIvtRgX6kI7s8hqwkiao8Q5a9v7xKsCqOEgVevzLFxp/vW+4fM?=
 =?us-ascii?Q?rcoD4uaFrdGWHJe9JHzVj8bH2d2acamPTyFyEx4gqkez/UZpKJwSNnaXE0NH?=
 =?us-ascii?Q?fgnh7Xr/H8PqO/r3za5/fg8VANI3stqKpJ2kD+BffuzQehRA93ksQRdNOqCY?=
 =?us-ascii?Q?YmZsxmo9Lhg+zbJGgig7xrCk973OQqyHy6VZooLDW49wAShKSnz0rhUyqIBM?=
 =?us-ascii?Q?/6UVq8kIu4vlGEIwaN3Ifruz7Dgf7vZ9yF4JxulNGbSTxAn3jjTIGaQwzR3o?=
 =?us-ascii?Q?Q7Biq1R6eDMMP2M+4c7rJHWNvv0bl8u/qSUWxZgBeay4NTOXI/mxdMs1L1XC?=
 =?us-ascii?Q?0uxzq+pC6MVg8mbJER/TjXjxJzdV+vD7Q7Zl274r1vwyjhPvAiyLNtexrphE?=
 =?us-ascii?Q?2A5voYefob2dcF02pe3MFefMp2JcARe41yJNUdHRD8zcCbW6E2amGL3dp0yw?=
 =?us-ascii?Q?eTb3CW9R2iATdzYLTU9cLtXa0hUAljPSxhaaoQ5T6hUatr2FLmX58N02jSQ0?=
 =?us-ascii?Q?hHdQyadqaBR2qgEgcppOqHWp4mcFZc31ppsgJ002yuFVddL2NjmnXJmeXnjD?=
 =?us-ascii?Q?+YJAiBZH9vqCTzevv17LwofEPoFOqHG2RPrMiuW5LAuqX03YMruuTAI/RXk2?=
 =?us-ascii?Q?wIYgwNXmSXC2XnmJiBqOvq5y1UQ3mud1uv8WLOvi0zNaGlqNP1+igHGj+t03?=
 =?us-ascii?Q?UrT5XpvgzwewszxLeH3S/E/lwotkSVJkFaAK5TAGcPPMG42iUG3ASpfInQ6F?=
 =?us-ascii?Q?Xcxt0qGU0AtW7XkMVMGoVrTjcFosKC1xnSqdiw3+/VfU0RYavql9QTfupmCP?=
 =?us-ascii?Q?amYA7H+cnhUsG4xbroHUyD31RlXQQA7Z/RxFCuCeB3pNJ2qB4vUBtKdwp5x2?=
 =?us-ascii?Q?zZbp+ClBtH0LdBHAae3iTY+j+XNNTCYLsEv6EOFrC+/Ms78mHd0mXNQmySok?=
 =?us-ascii?Q?GAnPKRFMat0RXp+9YNs4wpYgQNPkL/g/Wnte9jYbiMj1rj5cFoAHFQeo1PWV?=
 =?us-ascii?Q?U/9dJwb6527s1TGkq2RUlTlUd1QZrTo35Ean01TCu1tKEO3k5mncZpJmR3Cl?=
 =?us-ascii?Q?I73dN93xf9DBXU7ssc8GIQQDfjRvXpL95WNW4rASRHZeAGd4G4+eXonVQIJ1?=
 =?us-ascii?Q?mZDwcjAxOtTCFD9tnlc94/mFGpmGif9DNFPrIMfsALfblbtBx0k/Jomlj20C?=
 =?us-ascii?Q?4MYtRXnvrnnTVUXoGZfS6vFFK9flvjg1swlEWXdB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c55388-27d0-47a7-b3b8-08dbbf684411
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3006.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 14:44:34.6432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsPGW9mgrU58fy3ze1Fu7p6tThr1AFwmiDOkXdikMu3pchYblg8+RvIwYkGzoq84eWfZRQ9zLv7XTFouaVnywg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6535
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 01:22:35AM +0200, Christian Marangi wrote:
> On Tue, Sep 19, 2023 at 08:21:03PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   2cf0f715623872823a72e451243bbf555d10d032
> > commit: 28a6a2ef18ad840a390d519840c303b03040961c leds: trigger: netdev: refactor code setting device name
> > date:   4 months ago
> > config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20230919/202309192035.GTJEEbem-lkp@intel.com/config)
> > compiler: loongarch64-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309192035.GTJEEbem-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202309192035.GTJEEbem-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    drivers/leds/trigger/ledtrig-netdev.c: In function 'set_device_name':
> > >> drivers/leds/trigger/ledtrig-netdev.c:120:34: warning: array subscript 17 is above array bounds of 'char[16]' [-Warray-bounds=]
> >      120 |         trigger_data->device_name[size] = 0;
> >          |         ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> >    drivers/leds/trigger/ledtrig-netdev.c:48:14: note: while referencing 'device_name'
> >       48 |         char device_name[IFNAMSIZ];
> >          |              ^~~~~~~~~~~
> > >> drivers/leds/trigger/ledtrig-netdev.c:120:34: warning: array subscript 17 is above array bounds of 'char[16]' [-Warray-bounds=]
> >      120 |         trigger_data->device_name[size] = 0;
> >          |         ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> >    drivers/leds/trigger/ledtrig-netdev.c:48:14: note: while referencing 'device_name'
> >       48 |         char device_name[IFNAMSIZ];
> >          |              ^~~~~~~~~~~
> > 
> > 
> > vim +120 drivers/leds/trigger/ledtrig-netdev.c
> > 
> > 06f502f57d0d77 Ben Whitten       2017-12-10  106  
> > 28a6a2ef18ad84 Andrew Lunn       2023-05-29  107  static int set_device_name(struct led_netdev_data *trigger_data,
> > 28a6a2ef18ad84 Andrew Lunn       2023-05-29  108  			   const char *name, size_t size)
> > 06f502f57d0d77 Ben Whitten       2017-12-10  109  {
> > 06f502f57d0d77 Ben Whitten       2017-12-10  110  	cancel_delayed_work_sync(&trigger_data->work);
> > 06f502f57d0d77 Ben Whitten       2017-12-10  111  
> > d1b9e1391ab2dc Christian Marangi 2023-04-19  112  	mutex_lock(&trigger_data->lock);
> > 06f502f57d0d77 Ben Whitten       2017-12-10  113  
> > 06f502f57d0d77 Ben Whitten       2017-12-10  114  	if (trigger_data->net_dev) {
> > 06f502f57d0d77 Ben Whitten       2017-12-10  115  		dev_put(trigger_data->net_dev);
> > 06f502f57d0d77 Ben Whitten       2017-12-10  116  		trigger_data->net_dev = NULL;
> > 06f502f57d0d77 Ben Whitten       2017-12-10  117  	}
> > 06f502f57d0d77 Ben Whitten       2017-12-10  118  
> > 28a6a2ef18ad84 Andrew Lunn       2023-05-29  119  	memcpy(trigger_data->device_name, name, size);
> > 909346433064b8 Rasmus Villemoes  2019-03-14 @120  	trigger_data->device_name[size] = 0;
> > 06f502f57d0d77 Ben Whitten       2017-12-10  121  	if (size > 0 && trigger_data->device_name[size - 1] == '\n')
> > 06f502f57d0d77 Ben Whitten       2017-12-10  122  		trigger_data->device_name[size - 1] = 0;
> > 06f502f57d0d77 Ben Whitten       2017-12-10  123  
> > 06f502f57d0d77 Ben Whitten       2017-12-10  124  	if (trigger_data->device_name[0] != 0)
> > 06f502f57d0d77 Ben Whitten       2017-12-10  125  		trigger_data->net_dev =
> > 06f502f57d0d77 Ben Whitten       2017-12-10  126  		    dev_get_by_name(&init_net, trigger_data->device_name);
> > 06f502f57d0d77 Ben Whitten       2017-12-10  127  
> > e2f24cb1b5daf9 Christian Marangi 2023-04-19  128  	trigger_data->carrier_link_up = false;
> > 06f502f57d0d77 Ben Whitten       2017-12-10  129  	if (trigger_data->net_dev != NULL)
> > e2f24cb1b5daf9 Christian Marangi 2023-04-19  130  		trigger_data->carrier_link_up = netif_carrier_ok(trigger_data->net_dev);
> > 06f502f57d0d77 Ben Whitten       2017-12-10  131  
> > 06f502f57d0d77 Ben Whitten       2017-12-10  132  	trigger_data->last_activity = 0;
> > 06f502f57d0d77 Ben Whitten       2017-12-10  133  
> > 06f502f57d0d77 Ben Whitten       2017-12-10  134  	set_baseline_state(trigger_data);
> > d1b9e1391ab2dc Christian Marangi 2023-04-19  135  	mutex_unlock(&trigger_data->lock);
> > 06f502f57d0d77 Ben Whitten       2017-12-10  136  
> > 28a6a2ef18ad84 Andrew Lunn       2023-05-29  137  	return 0;
> > 28a6a2ef18ad84 Andrew Lunn       2023-05-29  138  }
> > 28a6a2ef18ad84 Andrew Lunn       2023-05-29  139  
> > 
> > :::::: The code at line 120 was first introduced by commit
> > :::::: 909346433064b8d840dc82af26161926b8d37558 leds: trigger: netdev: use memcpy in device_name_store
> > 
> > :::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > :::::: CC: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
> Can't repro so I guess this was a false-positive that got fixed? (I used
> the repro commands and doesn't print any error)

Hi Ansuel, the issue requires to build with -Warray-bounds flag. We will fix
the reproduce steps in earliest time. Sorry for the inconvenience.

> 
> -- 
> 	Ansuel
> 
