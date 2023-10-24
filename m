Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570027D43BB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjJXALb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjJXAL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:11:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07E110D;
        Mon, 23 Oct 2023 17:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698106286; x=1729642286;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6GlB9D5sKJVGIJL6r5sXJKxPvg5YDn4gpPOJCG9srwI=;
  b=Btb5NQ8qPnmE8ZUUdu5/2Vdv4pJ484navClbRV6xUPycrCZ0JBWJLW6o
   tK4z/ZMrE5pYUqrGNn0YBvj8UyJVZWkrPAg112OWpJApGcTs3ktm48ByD
   SihpTGwgSUa64hd8PkwKK9di/Guieujz1o3+bvBr1troV76ACYkic1UGK
   pZmqv7TogCQ2yRXlBFNuEdA23dSNnhkni7VHiBNOvvWwCjPk2Kzstn3h3
   6CCdK/XXB7RTVp9hSl57fc7CEJWT5w68fy4q9csQ5Y9MoeYu2rFMP6tuB
   POpA3CFHg8zKs0tB4xrrdHLG8aM1cynvgiuaLVwdBzXqrJeueQrpQ3M8R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="385849537"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="385849537"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 17:11:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="824118795"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="824118795"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 17:11:25 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 17:11:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 17:11:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 17:11:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jm79jzMDioOi5KLBQwJWBKGA0FBRO5cMtnyItz3jGdryTPvlqczLKCHuHNkhCXUgSYanM+T2Bag1GHUUi7Pyq5tzhjbsRSbIBDEx0XpsOnhomBGQJSa1wwrfVelAFjzP1JrzPg5B45/yXqnc7VmMkcPJKU8INCxnn71WIcDSwC1JtdKZ0Eb+C+6WC2UvUxNIl6fpu7RVEw1OUdw5fcaB9Msv8NTiRa9YM6rcyJM22JKz1fsshbpOU5sMoiozzHKizdQ8ko8rRcIBW7/La0Kf4dbyOoya80VZi8i21vasy8tIrfLc+WRU+DQvm0ui9O3OY4PWwptadNrFuY+Gfi+Uiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFrJyN8d5/Moz1nrRyUsGLJVWgeycc9Cxx5Q7ROlYW8=;
 b=Pp0ZL7OcfZNtXl4y2w18aECQI0zSMAqzylgDWPKzhIEVR/IHmMSgmTMKYLaDU1AGQbf7FjAS06lwOWx9cFKn0/KXZTmWQp9F2pVuOEVh5b7lmXevyc2KsYMwn0/+wkeE+QA1O1CKYsET6+vA2hfUyP6yK411AHgoTuiRVGYUvFleP76bX35cUGZ0As9H3eQtMgyNxuX2aVhrHWs197ZvYEvMuDfY3s8iJBgYx961vzTU3EU8Hb45NjkmpvTR3cPyZtxtWFSeDzF+TUbjf1QgGNHwNsknGdLUKulzC1rrTFzahXX2e+D3LNPSHGnHm+Hn1oqb1Y0Zd6GthmzoVNWr1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV8PR11MB8487.namprd11.prod.outlook.com (2603:10b6:408:1ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 00:11:22 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 00:11:22 +0000
Message-ID: <aae23a4f-bf57-4164-b8c1-cd5d13aebddd@intel.com>
Date:   Mon, 23 Oct 2023 17:11:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ti: icssg-prueth: Add phys_port_name support
Content-Language: en-US
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
References: <895ae9c1-b6dd-4a97-be14-6f2b73c7b2b5@siemens.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <895ae9c1-b6dd-4a97-be14-6f2b73c7b2b5@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0023.namprd21.prod.outlook.com
 (2603:10b6:302:1::36) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV8PR11MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb2a341-4eab-4476-6fb4-08dbd425c102
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KFw5LActV+uN+hD8jRH91RFTGhJWQI4W9ReoeIsVLB2Sgo2AqUU0bneWIehK4EpElP4QBr9dFojVYY1voV3E5RzbEIqL0z/ae0iWVpRhqg/C7k7rue7qg3iA4sFFm2F4EOue0tGFYgqA35D9xMEbijiNFAM3p7+NRNTouExzconLeP21z/Msp1Y36YM9nhJSdwa+9qmcPhuzJPXUGU/eioC2yxy+Cvw2P/FRlW3T9ZfJD6m1xeEhnkMOMMFXGeFRDpIgHG6Wxh7m+kKQP7i6UUjABMJ8myTmhs4+G1C+xZ8tg251+jtytrHbL0R0IuDLFg1V52s8SvtH3anwzEyPg/53EVdOYOiZmvkg5h2zUmbGsGOFaTIO9ChS/jJ+D2BwW/2x/ALIe2zwtYbH3gu4XuVAeunTOSSgQhab97+RKUAcY0zmO+dTVilr2NJHfMs+L4PZUsWVcKgmndYYS5/iGjsosYZF0TLw2nghbf/yIKuKizex6scKsFyn2FyqNg8AwQsksP37pyXZTJt2v9u7Pg9BcvT85seskPZmCMvTGq81Z65eXCKNk6CtQLRAlG6ZbzPD9DzEwEzCMUdbTTO43o/CTe2DtM9qtBdGLSzqoFrKhXeYuX6Ai2W5+NLAX53VoBFdUpDFy54nxkCDzZ3wWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6486002)(53546011)(478600001)(66476007)(66946007)(54906003)(110136005)(66556008)(26005)(316002)(6506007)(31686004)(6666004)(6512007)(2616005)(4326008)(41300700001)(38100700002)(31696002)(86362001)(2906002)(36756003)(7416002)(4744005)(5660300002)(8936002)(8676002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEc5T2NHN2pvZGV3ZGhRRmNYQ0k2NmxGNmdKanVjd1hRbHJCVXZXKy9FVmhR?=
 =?utf-8?B?Rll1WWt1aGsyaVYwTjFtdUFVcHhCbGxONCtFUzhETzMrRUZPQmJ1Zk13R1pX?=
 =?utf-8?B?VWRtdHJ5RUw3VndMUTZQQ0ZkR2hxcjJpM0s5L0x6R3pkZEY1OGt4S1dXWDRP?=
 =?utf-8?B?Y0lnVGNOK1NsaGh4UTZLekQ0Q1dwWGZNQTUzT3VXcEF5WEdiWTh0WEhPQlBn?=
 =?utf-8?B?NHlCVlpUWlhZK016a291Qm9IOHF4dWlTVFV4QzBXUE9QN1owM3l1ZXVseURD?=
 =?utf-8?B?enFIRFR3TzJGV05vUWdqdVA3RzdLNUlCaXNBeVpqMnVpcVZGRjExMHAyZXFL?=
 =?utf-8?B?MzR2Z3JjY2Mxd2NpUGcvcTUvOWV6cWFsTzRVVE9HWElxZFdQb2pUVDNWWjdx?=
 =?utf-8?B?N0hRT3M0SXBrR1l3U1VpOXIxU3hySVREZ1R1SEh2alcxM25MZUxneU9Bd0xT?=
 =?utf-8?B?RVI2N05OU0o1N1BYNjZ6RlhCSnB0V1VDUHNrKzlMb1Nvc1NCTmNNVitab0Js?=
 =?utf-8?B?MnA2U2ZyOUdweDBod3JKWnBCZnNIdmUrQVRtYWZXNXRwSWpxQXR6b1VhTjBQ?=
 =?utf-8?B?VXpvMDdzbSs1cDQzRFhRT1g5TzJJcDk1Y052cEtUTFYzblE3U0k1M1ZscW84?=
 =?utf-8?B?WmJTa3lqeHJqb1FHYldUdk9hSEpwaUF0blNKNC9mREtXeDFTVFVheVhWRWQ4?=
 =?utf-8?B?cUp0SG83NmxmdXhuMStIVDBjSUFEUHdPTURXeTd5anErUWN4THVFajA5b29y?=
 =?utf-8?B?WjdZMDVnUVQ5cmxkZUhScDlpelBiaTlwWE9ZSElOY2ZzbG5zZUY2Q09KNDR1?=
 =?utf-8?B?RFAzQ0FWRVN1Y1c5OC8za0U5YkRwVnhJNGdXenZMSkQrVmgrMHNPVGt1SmdX?=
 =?utf-8?B?Zlhvamlnd0FQMGc5Y04xRkRSb25sOU5CUTlwM3F5eGd0eXlhRENkZkhBSG1y?=
 =?utf-8?B?anhMYmd3SmQzeGN5WlEwM2xxMDZXYTdBaUYvZFc3NTVQRjd4RCsxZERPNFIz?=
 =?utf-8?B?emh1UDhqUUNvRzU2ZURrMmJBQmJpU3FPUjZaSjc3MGpTV3RiM3BrSVd1anBn?=
 =?utf-8?B?RkVMNWFyN0UrTXVLUVJjQUlFeHZma3VtVHBRSGtBVHBST3JGTE8xNzllSjhH?=
 =?utf-8?B?a0ROcmlocDRhTmk5RFlyUHdMMzVIUUlzMCtVTmxWSGdHWktxK1pDWFVkNEFS?=
 =?utf-8?B?M2tBSnByMy81aUt1dmtTRVZKcGhheDRUTG8xT0RzTDc0L0NUcmVaZ3JUa2Vj?=
 =?utf-8?B?a0RxWms5S0dGNmpqUDkxTUo3dGlMbVFjZEp3Y2s1TU5ielFhOG1RYlUvb3BH?=
 =?utf-8?B?eXc2UTA1elNzcENCdXU3NkExWlcyd2hwd3g4SnNNV1MwY0JsanRVNFpPV0k4?=
 =?utf-8?B?REFjekxRMGU0OWU0K2Z4YzdkK3A1NkRldmpDNlZUSjhBSVRSOWZsbFlVV3Nr?=
 =?utf-8?B?YW9GY3FiNmlLMjFCMzFZU1F4dUxFVThOL2pYN0l5cUIvcElXWjF3ZHNONmxS?=
 =?utf-8?B?Zml5ZTlZNUZMT2NqT3FnYU1sZVpQY0JMR0h3QWNQRGRLVng0emt3U2N5MS81?=
 =?utf-8?B?dERPNk5TQU10UnRiOGd4MURFMTg2YkRKUkNPM25GZ3ZRSXYrZ1d3SDlQb0Zz?=
 =?utf-8?B?em1DVklNMktMR0xiQUFDSkJLSnp2S2Y2MXMxMlZpTXVBRFFHZ1dZT2dtS0lx?=
 =?utf-8?B?UU0xNWg1a1daZnNjTFJjSDVMYnFLVjBCSXFMMEZRUnN4NXVCUzlxZDA2dGJZ?=
 =?utf-8?B?cy9jYVVUSkRnYWZKc3lORHJlWVRMVUR2ajlzamJ3OTE3ZmdlbnFTODF4TmhT?=
 =?utf-8?B?YWdxd1NZbk5qajJyenF6TndYY3lScHo2MDlFNlJxdS8wVyttVldpa3FnWXhF?=
 =?utf-8?B?bzljaER0NGVDRFZXZkkyVTFvcnB5NlZ5dEZHb0hQb2NLOTEwd0w1ZGxZczY3?=
 =?utf-8?B?ckxhWWVDTlVrbVd2eEE2NVMwMDE4QUxWS3BZYzg2MWdRaUlOOEpYV09MV1Zu?=
 =?utf-8?B?WnkvcnI2UzNIRlNqQ2dSaDI5TFZuTFozUC8zQnJZb2swa092TysrQTh4QU5L?=
 =?utf-8?B?b0RqNHRsYUtuSDlSdndXSXpQbUkreXEvcDdHUmc0eVQvWE5tWmhtVXlscnE4?=
 =?utf-8?B?cStPbkszTEpJQ1I0UFNhcUhXV1Y2eTYvQ292NEJzZjUwaTVtZkQzL21jS3Rl?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb2a341-4eab-4476-6fb4-08dbd425c102
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 00:11:22.1182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4O+7oYv1HznCs8OE49z4WXxIiNbTdcyQw+rxvchktx7spPMDrKTxZt3iHDjIY2grnCEmI+X+5yZ+MgtObBpSU1Izw0gGqvsADs58v5JW/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8487
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



On 10/22/2023 1:56 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Helps identifying the ports in udev rules e.g.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Seems such logic was lost during the upstream rewrite of the SDK 
> version.
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
