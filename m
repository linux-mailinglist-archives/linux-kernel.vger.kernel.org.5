Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B227D5211
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343498AbjJXNnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjJXNnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:43:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7C793;
        Tue, 24 Oct 2023 06:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698155021; x=1729691021;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KRo+2AD2u8nWJgx+4MOYr+5TEkrKOatN/EKo2KUhHRE=;
  b=UwecES12rPk5MdcsmWM+ihtLUQ96vNPVEx1uZCmJDaxw8+iDlCT1GfHF
   eUkiEK9Ngw5iE/SMVlxpCKp6IamDSeEmArIMpYtwoE+I3gIqxPqLZekMN
   GlAPRcZr6kKXFQ4A22DEV07Lco3NkNApFlIv6b8t54Qca0vS+bM2Tpkrl
   qnxG0x333PeG4/75Gfh9WLx6aBtzLBaFvpEULBWIzb9XuGvGZVTPVdvvm
   1L9e7RvyPjEb2WY0sj1QaoHgQXSablOJMhDbZCn98jGn7OeixiBOAmKwI
   bhrN6bltylP4bYS0/313Q9pVfjn6d4zySOqFzgFrMTaoPWHaLzZvOOt1k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="366401150"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="366401150"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 06:43:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="793489938"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="793489938"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 06:43:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 06:43:39 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 06:43:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 06:43:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 06:43:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzWgaQDhceb0n3pa39YEMEWvLUdiBbEiDO/cW11tx/0Sg9RhGW30YBL9zLPnt5wJOITaMRNA9uY865Egxbly1oteRaXloyfPGd6vT8qNAJtdYaXjGrI2poqVU5jUTauDRePoWA2neI1JggY2Ulr/ckIj/no1ZA7HkoIvxjWQ4W3Z9PbqTMPpDD6kfIVwMrrgMFtWGgPbsuHOYGCtH0V0RK5PyfokzEyrLEbHK6h8FUcLbiOdA3LyAuiLZRpIBx3Ijk531f0q7COxYDPs+SlRn6izR0L10jpb1ihVBENrESgak+KiY+APqzZ44y7t0kr9lHJI59xNPIvrWK8MFONK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnYCz7BdskmPAla5Cf8eHHDfGqdq7ic1l9J6lUA2nyc=;
 b=GIfCnorEuQktw2llfgkiJXbNuuyAwNPwmy3zGiRIZlC51qakbxH4wXe7kR0tonHQBHtOS0wD00MTNyF6iHbNmQtzYkPJ9p/JAF8NREFehq36xjNVkvee//njdfxwuyh4tQ36wk9OzycGN1gVJzaFnQIjgCRT8zudMm4cv7BojZRSWpQeITxazmU+K4Et56P6DA27PtILKrORw4xm9ntUJQCQ0bUXYOYIbR9hm1Fgim6EghUdWu62nZzRRn86C9pvLT+4kn8WVwFWluBj1V5h67Ys/ccwvScgvjQOSmz87cKcZ57EQWDEb/M0jofvJ+pZH2Dv6BGqXSROoTNxuwLqYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by DS0PR11MB7803.namprd11.prod.outlook.com (2603:10b6:8:f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 13:43:35 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6907.021; Tue, 24 Oct 2023
 13:43:34 +0000
Message-ID: <a7bd7ebd-5669-4eb2-55f8-9beb4c1431cc@intel.com>
Date:   Tue, 24 Oct 2023 15:43:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next v3 08/11] net/mlx5: devlink health: use retained
 error fmsg API
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
CC:     Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "Cai Huoqing" <cai.huoqing@linux.dev>,
        George Cherian <george.cherian@marvell.com>,
        Danielle Ratson <danieller@nvidia.com>,
        "Moshe Shemesh" <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Coiby Xu <coiby.xu@gmail.com>, Simon Horman <horms@kernel.org>,
        Brett Creeley <brett.creeley@amd.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jiri Pirko <jiri@nvidia.com>
References: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
 <20231018202647.44769-9-przemyslaw.kitszel@intel.com>
 <8bd30131-c9f2-4075-a575-7fa2793a1760@moroto.mountain>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <8bd30131-c9f2-4075-a575-7fa2793a1760@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0284.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::8) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|DS0PR11MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c20840-2cd7-4626-7d53-08dbd49737b6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dcwgQ1mr6RHRcSUjfp4NwKWrK+HsVcLH14IJz/Mag90N0Ptbs81KcJJV7vGP2CNrSBHGXrUy3L4kOAOjgYLQpXl1Vh+sWgyOfczd1hFq8FpIpPAriMCqHD7iyYVFJ1VR3b+29ZSIZxm8q9o5n97D8+slDzuoy34tGAd9Y7kx79Px7ScgXnUQVEv2134LCWhwAyYTJK1LGfu9aiep+lOOQgFpAqty6rme5CaQM2G2isEvljVLD0FK4mJO/sfMeTwCvuZroOtY48Pw/aBY0wt6A+P8mDzD27Wq9Lc8X1W7HcBxF6SzgpurC40oAN2pshWoNVNV1j8ij0O8sFwm2ti/F2JQXHsg5+WMGfInN8mQiz/KsGCRxhecMS6L26hNV3Ne/Ou5hI6k5I5aGRrhJSzEah3Tg2b8S1b2kmbElUy9dmaHLxxcIzuSAijBHFbJEw3/jiUnpidP+t6lkSHFDBS/41VpCB6zZ6rPPzNB0upD8z6vrY1E6LrYl/FeZehAtVDWGKF8SHCc6eZKujFuf7zLdMHD9iLbKfVxsYUZsgJxnpWQGj0LJjDM3hXvsfPF3HucQqJF7OSSUYUiVy915y02kfH72Ybqb3UitaIKXixfF4hqvN9lTv606ESUf5ia+PovBE1Rw62lEtXt9gZjgKjQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(26005)(31686004)(38100700002)(2906002)(86362001)(31696002)(36756003)(7406005)(7416002)(5660300002)(4326008)(8936002)(8676002)(478600001)(6506007)(2616005)(66476007)(41300700001)(54906003)(6666004)(6916009)(66556008)(66946007)(316002)(82960400001)(6486002)(6512007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlJaZWt4QnFXN1NmRzNlRmNFVkpPZGlmZUgvcE1ienJKb2ZNdXgxeHFQMTE2?=
 =?utf-8?B?MzZlbklEcmVVMHdSbHFuTzJ6Y0FNVVhVb0llb2thdHRsWk85cmZFeE9UaWg4?=
 =?utf-8?B?eW9tdzJHUE0yMnhRLzNFdEJOSm51azl0ZW5XeHZJK0xRUDkvaHlHeEZENFlm?=
 =?utf-8?B?Nnp0WTdhM01OZ0k2cm5PYmhRMHdDZFFYMzFFbDJQaFJYMWUxUG16TVhWTk1y?=
 =?utf-8?B?dHFDTWptL3czMHV0WDlDWXBsZjdFa3FrbGcrYklCS1RPSVgxZXhRS3BSTzVw?=
 =?utf-8?B?T3BsTDFJUkhSVmVPNFhXazJRVEZpZmM5RlUxV2xOZXNBU1Y0N2t2VGpqMlJr?=
 =?utf-8?B?QjEvbzhLaVdYVDdkcHArV2hLMUNNU2N0ODBNL2NSQTFoNVhqTG5heGpzYlM0?=
 =?utf-8?B?K0U5RzN0ZkpMcDNWZzlpSkoyM2pLTG11STY0YWZ5MWpEVW1FOUZlUTdKb0Zy?=
 =?utf-8?B?Y3VuTHQ3ekY5RS8zUWljZG5DYU1pU1A1a3R3a25MOVVuRWhidlFqSmdFejJq?=
 =?utf-8?B?eTV4eUZnaFU3cWNaVHdOaHBQZ1hWNkpZcU1BUzVOOTJROS9ibForb0ZYc3pB?=
 =?utf-8?B?cm03SzA1SnJqTlM5dGtMYVI2Z3dqWjBVQjZaZWh0RHRMUm1lUU1Pa2tHWU81?=
 =?utf-8?B?a3RCQU1uQkFsMjZ2dEo2ekFYY1Q1OU9tUVBHN2FzQS84ek1MZGNqa3FoSklz?=
 =?utf-8?B?anBXTC9oYWd0VzUwTVZaLzMrVjRRR21FcXhFajhBcDdTSkNvbUxBTnBOOWlo?=
 =?utf-8?B?RVZvRTRZZnBqWklFaXZOOGFPOGR3ZDduQlBMcHdWLy9yQllLeUN4TWc1Sk5L?=
 =?utf-8?B?M3ZEWi9yZnNEaVREZXBETnF5YXlaQlFUdVFRdHE3TE1XNDhlZmpKcDRFY3V4?=
 =?utf-8?B?ODFFY3F2WUt3RmhQSVZRSjl1TXJIcXFEa3FydXFRZ1J6M0JtdjZtM01TZTEv?=
 =?utf-8?B?d3JWMngxVjZPWm5xM3o3RDBsc0ZYUnExVUV2NU5yOXZvcFFib1RnVGswV1Yw?=
 =?utf-8?B?NUQ0TGxSWGtjYWtKclhLL2V3cE5tZXlnZ3oyNFRYSHJoNUtGbjRZU2tnaHRT?=
 =?utf-8?B?RFcwZUdHc3MvZDNYSDNSeG5YYXRiTHEzN2pGQUxhbnc0eUdpemZuMDl0RHM4?=
 =?utf-8?B?RWlPMXdvNGNJTTRrcmoxYWFMdkltUVBxTEUwYWhSUTZWL2llVmREZ3FtemhN?=
 =?utf-8?B?ekYvQ2J3N1RFWTlHV0U4QitESE12S1Rka3FSbFo0VzRPMFpRLzdWeW1LQUZi?=
 =?utf-8?B?cFoxWFAvL01rMkZ1Sm9DYzA3RlFVcVBGbWVvaVhUWXNuaVlBVWQwYkhZKy9k?=
 =?utf-8?B?Um4ybTc3d0diSWg2VVpCY2pVdko3aytudk0zZGhSZVdVZ1NlcThpR2hEZ2RO?=
 =?utf-8?B?eWRuS1liK280SmRxVUhLV05Hd08xNkQyWUNaczE2dGZ0VlFNK0JraDdweXlD?=
 =?utf-8?B?UUxzRWNJNVh0RHRnVzhkR25kTldTNnZ6M0lWNkx6OE9RQ09yRkk5bzQxZnJh?=
 =?utf-8?B?Z0JyMlRvdGlPK09pYmZ4VUJPYmVOWjUzN1lmZ3cxbHlkdlU1cjl3NExkd3cw?=
 =?utf-8?B?aC9LaURvcGUxMUpxUzZDUklTd1ZSK2kvUkhqdXR5QlpZbFVwUmlGTmd6dlhT?=
 =?utf-8?B?Z0hZanRUZVdub3IwU01UMXJZTXMzSnY4SUFwaHdQY3ROREdKeldJRlhGaG1k?=
 =?utf-8?B?d1dielYrTFhsemtMeWIyQVZqTUlDTnZFcjRac2I3Z1l3dGhEY29wbThzb2Iz?=
 =?utf-8?B?R1BlQmFPQXdLVVZtazR2YWdrOWlZeEl1Z0xlU0RTaGZlQy9GZStqelloOGNn?=
 =?utf-8?B?Vk1rZWJLVWI4L0dNT21PNk9kc1dwT2xWNnd4WFVMRk55K1UvdXVmZEVoL3VR?=
 =?utf-8?B?bFVTa2JKOENlRmd3bGo0Mk5Wb3BNOVN2UkxIcjRKR3RKUmp1ZmFMZnpzZllM?=
 =?utf-8?B?dDQvVFp3RDI0VUxOa3BwSzRZWmg3bHgydFJ4MDZxMzBUWWFoUkkzR05KbDRL?=
 =?utf-8?B?WXF1c2twa2EzdFVqK3BEZ0hwblFkcjBiQUFuNVdZWUo5Rit4NEtHQlJZQlRW?=
 =?utf-8?B?NStrMi9oanZMOVJlNDNJYlVOM3NCVnowemlwT1BQVzRTVmZrSnNCYnExMnlR?=
 =?utf-8?B?N0d3TGgzbjc1LzAvb0srTE9vS2o5M1JmTG8zRUtEQ1p2dUhtV2hBc0Z3MldB?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c20840-2cd7-4626-7d53-08dbd49737b6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 13:43:34.6555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fz8L9JuBZg23AThlMDrRc2Y5PR+j+3uGxDD6SJQHYRJ2V+RkWMJ/ehAmFuxqxDCTtouELlqoIkM5Smtm+hG4z97Dudki6JutSIemyd5u7rU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7803
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/23 11:50, Dan Carpenter wrote:
> On Wed, Oct 18, 2023 at 10:26:44PM +0200, Przemek Kitszel wrote:
>>   	if (rq->icosq) {
>>   		struct mlx5e_icosq *icosq = rq->icosq;
>>   		u8 icosq_hw_state;
>>   
>> -		err = mlx5_core_query_sq_state(rq->mdev, icosq->sqn, &icosq_hw_state);
>> -		if (err)
>> -			return err;
>> -
>> -		err = mlx5e_reporter_icosq_diagnose(icosq, icosq_hw_state, fmsg);
>> -		if (err)
>> -			return err;
>> +		mlx5_core_query_sq_state(rq->mdev, icosq->sqn, &icosq_hw_state);
> 
> When we remove the error checking then Smatch correctly complains that
> icosq_hw_state is used uninitialized.
> 
>      drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c:268 mlx5e_rx_reporter_build_diagnose_output_rq_common()
>      error: uninitialized symbol 'icosq_hw_state'.
> 
>> +		mlx5e_reporter_icosq_diagnose(icosq, icosq_hw_state, fmsg);
>>   	}
>>   
>>   	return 0;
>>   }
> 
> See also:
>      drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:229 mlx5e_tx_reporter_build_diagnose_output_sq_common()
>      error: uninitialized symbol 'state'.
> 
> regards,
> dan carpenter

thank you for the report, I will post a fix soon
