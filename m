Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF337D2807
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 03:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjJWBeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 21:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjJWBe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 21:34:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C97126;
        Sun, 22 Oct 2023 18:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698024867; x=1729560867;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=NVwLl4P9N9Vie0my/3hLk5vZX8CEHhNpl6fIsSZEb4A=;
  b=Z8gMdVnW/nXz0442lC1IPj1j2iEQTTwklf/sayzPL7poHRYfu+efh4hj
   txlZSbm+7iI42T0BpNZNjERC85HOZCG8f/3cI561B8a8LsjOySNoLw9Wp
   NU9XrDTN7hnqcRTlyX5Z1MkImX4tKOLikfAV+lx46srjngEefboaQxuU/
   z41WisVNnY5DvDIrksjJ+lgFKay7KVhRu9vfpTl1p8uqLR0c+9zTusArb
   kOMnkS6vAa0sKIiYIugIFla9PGQKCszCR9Kdl+r8ndXa7axsqFj5Ckx4Q
   XtqhuKIiV4dh+0MH/nVh/N1X7hjc2pBP0c1MkibvsMoV11B9/tnW6FH1F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="417876142"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="417876142"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 18:34:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="848641546"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="848641546"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2023 18:34:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 22 Oct 2023 18:34:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 22 Oct 2023 18:34:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 22 Oct 2023 18:34:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 22 Oct 2023 18:34:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3CBV0Vbumq3pNV8CzgPLrbNjsZNyKsN26m6xMvLBabkBAor4/OwC0Yf4WmhUxX/e8Lj5oPCzm9KwZsepAQsfp0k6N8yD7tTcv3WWXbV/QVOTUyvhFl/ysIM9KVrqY82B+iZ/20cvdMGu+z87XYpVaOlfJh9MtfKOw/fMJz2mikLMgC0km7EnFJdqUHN4j4FIre3LfgItL5AtyWfpcCTkSektYbTWT/tdMvBNtYspUu72oeGyU9il1eZtw5Inc0rPF+r+2Yxlz5jO0zahnWRd/tVWFH5XuCU1+JgkvHxUKnVt0IC7I32G5mUqClB7/T7cd8Vy0LuZq27Q+fjgbywRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCi4uJskoCwEHZauL68Ec3NYgz9hrcFHkL4LrbC4UFo=;
 b=VexgDRemDfxESsuV30dK3PDNTS9eboZMp1t7bo2VVPnJkFUhKHzcs5VDGQqrbjKLS1KIcsM7/rRpMKCGbTGG4/iUIaduUgfDu4w7MrbqihP1bKY9lPxD//GlpUKgfAsWlctBo/H6y48m+i/1i8xLIe6k0It9iXJRzo/2V0D+4RoqL7ifrsKjA1anx00cx1o5hz7aopQAOBwATC0Z2iBO7/sUnQQVle1FW42PPhpF+CxFrzt6//ICTBMYJUC2EL/kzDHZLvy1aCnJAb9KDvGNA64XrHx0f+FNVUbsXeQht6bDfhcs8Ouw31sRTJjtsd3ddbcOX0jB8LKBlrJRvxVCug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DS7PR11MB7805.namprd11.prod.outlook.com (2603:10b6:8:ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Mon, 23 Oct
 2023 01:34:18 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::21f8:775f:a94d:e1c0]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::21f8:775f:a94d:e1c0%4]) with mapi id 15.20.6907.022; Mon, 23 Oct 2023
 01:34:18 +0000
Date:   Mon, 23 Oct 2023 09:29:26 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Frank Li <Frank.Li@nxp.com>, <miquel.raynal@bootlin.com>,
        <conor.culhane@silvaco.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>, <joe@perches.com>,
        <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <gregkh@linuxfoundation.org>,
        <imx@lists.linux.dev>, <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 3/5] i3c: slave: add svc slave controller support
Message-ID: <202310201945.nRKjcul0-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231018215809.3477437-4-Frank.Li@nxp.com>
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DS7PR11MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 16deefdc-cebb-4f7a-f96b-08dbd3682c74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yo0zMC+shISa8b4YN5N7/ppgKBlXD9q29rk52o+7eRS1SN84hrm/iS2gMFOeBpGyrFrv9j0szzMFDc4ZJrNZibzUGPj2wlUO/fZWt4NqThOaJvg3+XjEOrBfNBBnkqIzHBdQVm87URE4oucnNh1jEZi9bKkTFiLygQS0T6kVuRMUP4wazV5sTO6u93NAm/X5K1lOiMfF+tRo3xzww6Ki+rTeIggQu2QlT4WpmM5WZSqUJLdy0sM1ZMnOjRlkIy5n7A55dXVaZDq6E9cpPTZ6QgMq4PDY/ZD5aeC8rkmhrhAdB9vPHDipC8jnDVONLOceZ28p9oS2/7jAUh3d2YgtxBC5S3Kdbx937/NzaoW9x2f6oJ1yhxjtRgYALC4vJFnNWafoahoRxvacoPCE93PKrpjWbVPPeqTX7TteBrZo9V4AciC1fEmNDJbIA96qELcZbp6CEQ+ijbhbLhgLcSb+c+xf9gc1Ezv5oyox5Evc6G32WxHGCKG7rmxVJjJo8fh4d1/9fF4oHQtAmIaF0bTysSw/FXKn380M8sL1e9eug8+etTwLNg6i5G/T9LrTozsjepe3pNrltbXamBT32S8nB+9VdzVeFUeEbWeMsB4g1hJUU4tyLKwcWldz8PunXkiK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(921008)(4001150100001)(2906002)(5660300002)(7416002)(8676002)(8936002)(4326008)(36756003)(6512007)(316002)(86362001)(41300700001)(66476007)(66556008)(478600001)(6486002)(66946007)(966005)(6666004)(6506007)(1076003)(2616005)(26005)(82960400001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DW35FsB8v6AZut3VAsxNXVlAUh74JhGZy6F3LO908j7q9AvRMn8E5rf+DJxh?=
 =?us-ascii?Q?fb+AESZDD2Reg0hbEkO2vecaprVMPd8pcYr1y58MTMJdpdcjcz7aANMypk20?=
 =?us-ascii?Q?l3kPpZOuO4OpwHJaszSSbCbdWuqpisO/rx1G/r5zaqJY/9JWCvZezPZHx7S4?=
 =?us-ascii?Q?wkyykFMo9kqFEizVDoGuMWzV8ecv7NOqBCCgQDHPYJPGFxa0BD87B9sW8GuS?=
 =?us-ascii?Q?ZJRXutFXflX+gA85nHmMrTKBEOVQlWsXCvvZam04K6k0s/vNxTBeMcOgesTD?=
 =?us-ascii?Q?Tt07LVDhlEPsg0ugmRxwqIgp3OJQ+w6/IGPEwRSGEDPhFNg3JGbwECjSI8DH?=
 =?us-ascii?Q?AwOY/c9ZNcxamiTn9Ov8AWiC+OnClTLYDt0eFfHcHRks9T0LQVC9Fb+TBad2?=
 =?us-ascii?Q?RVY7NOCwUZiXXZdYrbefVrv69zF6/Y4BqsXtinYZOJQkbebD/7e8mdbYzdRB?=
 =?us-ascii?Q?WsHoXD7QR+ffdNyifV6+IgFdc8p05Zlk0wd7y1LmvWYxBkmnICPFrDsJVk6y?=
 =?us-ascii?Q?OqgMRN9NX1msNUhtr0MU66LggA1z3iofxUEfHI2hlOEKgHF4L075q1/7eXfl?=
 =?us-ascii?Q?wNRfrcCc/gSxEdxaa3D1IKVU2vZXtWUbmiq3gyI9LAjVqutMLie9pvnXAlWB?=
 =?us-ascii?Q?VeTzPjcOxnyrso7aE1d8/vhpAqnAGZ5rRMaj396Rk9Nv6kxkKFEqXzFTzIko?=
 =?us-ascii?Q?zac+89vY0s8N4pLo9N877hBHrvmKkA0MSFK5RnFCfxcGTRHGHnhQ+33HsSun?=
 =?us-ascii?Q?BdwZNqxMRbFzqxkO/BQQjUjFYBsqKDQ1BbKXKOsHOjogXUSljO+urf0DLO6z?=
 =?us-ascii?Q?H5jpYO6qh3jbbQKxvaYgZTHliXLLYcNvrFjhakFAHp3uNz9szbsJARQLqa4D?=
 =?us-ascii?Q?pAVu3kX1FoCfAWAnRp2Rkf4asiz1Cxowgk+OEoZsDWWq2NzoPngkXQy2L/Qq?=
 =?us-ascii?Q?aOcv/Ah+nFP/c3QF8XXBQQpT0W3ohfi/eRWjfBFy/s0AK4k1USdXBJqAv/ot?=
 =?us-ascii?Q?oSQS3hFWMyMFjbim8Y76o8d5vR+LTGue+zmhCKsoX9zNpNIrfSdUo0GM0etZ?=
 =?us-ascii?Q?hW4ywnuGd6oML8AJJ0u6CretV0Op4Olm8dPZ56GYotEhal164K0D7KQuAhSt?=
 =?us-ascii?Q?EEaTmLPYd1TvcC0a8R70qGQW67IEv3xhmQF34aZ6cvzP+InnJAX9rHdHz/9G?=
 =?us-ascii?Q?+YWRZv8uEDkYqnIBQIj2W6TJhN0H868vy+dZDvvSJPo8HRDOFI787d5boM5O?=
 =?us-ascii?Q?1b1lEI73WrB/MpE3m1DCf7MF1Pf7ALPr4trwLFPg5nKb2z7L1EHllKTsoCSI?=
 =?us-ascii?Q?/tXbN1guU4wWYudAW90yaXernPcUBDsXQAoO/TB7Wooojq24B7J4hrZA9vgu?=
 =?us-ascii?Q?a8CoRbGzgzHmiuACy+izp2ipIUEWYGB3SwMfTlSj2M3rTHD4qABbvX6AkZGM?=
 =?us-ascii?Q?hZIP2UT1jgTDHyBit7NfGzDTYUxKv1eovgHe4LI+B1P+geppyYdget/ZkrQJ?=
 =?us-ascii?Q?0k3wUorep5Ubbcejwk6YR89rYOv3+/nhSE6ZKSM71/AMTpNSdOcUEtw+2zo8?=
 =?us-ascii?Q?lVuvlgQjkQM9Zvo3DNvt44vQwzvMPjoz0mwc/s/c?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16deefdc-cebb-4f7a-f96b-08dbd3682c74
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 01:34:18.0036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LX687OVKIZxEBaS6G43c7Mr7K+/13EXkZB1swotmGMCxVFs/KzUuZqh2A9oGEktfjZdKgFecN4+2yg4D48HXpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7805
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

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.6-rc6 next-20231020]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/i3c-add-slave-mode-support/20231019-055940
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231018215809.3477437-4-Frank.Li%40nxp.com
patch subject: [PATCH 3/5] i3c: slave: add svc slave controller support
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20231020/202310201945.nRKjcul0-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231020/202310201945.nRKjcul0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202310201945.nRKjcul0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/i3c/slave/svc-i3c-slave.c:211:39: warning: no previous prototype for 'svc_i3c_get_features' [-Wmissing-prototypes]
     211 | const struct i3c_slave_ctrl_features *svc_i3c_get_features(struct i3c_slave_ctrl *ctrl)
         |                                       ^~~~~~~~~~~~~~~~~~~~
>> drivers/i3c/slave/svc-i3c-slave.c:666:5: warning: no previous prototype for 'svc_i3c_fifo_status' [-Wmissing-prototypes]
     666 | int svc_i3c_fifo_status(struct i3c_slave_ctrl *ctrl, bool tx)
         |     ^~~~~~~~~~~~~~~~~~~


vim +/svc_i3c_get_features +211 drivers/i3c/slave/svc-i3c-slave.c

10d1fc84a07d32 Frank Li 2023-10-18  210  
10d1fc84a07d32 Frank Li 2023-10-18 @211  const struct i3c_slave_ctrl_features *svc_i3c_get_features(struct i3c_slave_ctrl *ctrl)
10d1fc84a07d32 Frank Li 2023-10-18  212  {
10d1fc84a07d32 Frank Li 2023-10-18  213  	struct svc_i3c_slave *svc;
10d1fc84a07d32 Frank Li 2023-10-18  214  
10d1fc84a07d32 Frank Li 2023-10-18  215  	svc = dev_get_drvdata(&ctrl->dev);
10d1fc84a07d32 Frank Li 2023-10-18  216  
10d1fc84a07d32 Frank Li 2023-10-18  217  	if (!svc)
10d1fc84a07d32 Frank Li 2023-10-18  218  		return NULL;
10d1fc84a07d32 Frank Li 2023-10-18  219  
10d1fc84a07d32 Frank Li 2023-10-18  220  	return &svc->features;
10d1fc84a07d32 Frank Li 2023-10-18  221  }
10d1fc84a07d32 Frank Li 2023-10-18  222  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

