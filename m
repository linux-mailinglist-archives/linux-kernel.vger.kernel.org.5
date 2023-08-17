Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B98077FD01
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352635AbjHQR2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354034AbjHQR1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:27:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF69CD3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692293262; x=1723829262;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+rtLugvYLFmhmiW81NM/GeuhSs8PqMa0AzqBC3B2nag=;
  b=mlEW7JNi/EyNNJ2vad7X2ysLMZ0nescmKzmLAoKh+vlPT+rRE8EyCJHi
   n8Curf3/WJ8IYj3aJ6pkxbe5fcj6mJ17YYEnrBAfkdfTu1BMY/F9R+FWe
   kng4GoQOCvpfUVg79NcIV1EGMlr+IGDKe5S1t009g4e0QN9E8Jr4hI/72
   TA7FrHiPoeE3qX0x1XJ/ACjn7APW7OjYQXGlUtRFatjt/P5BWd0mxci23
   s9vhLh/MHnXEImoEKNCC17KnnwgaG9En+7nlMak0pH+IQ7n2oiXzhxTvY
   pWQprVd+2PKobgs2VFTT5hphUi6L64dQ8QdvqTXj3H6D51CvJKWd1hLy6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="459239981"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="459239981"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 10:27:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="858302147"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="858302147"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 17 Aug 2023 10:27:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 10:27:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 10:27:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 10:27:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H314Pdr6ZZzrnk8+jkn1D11ONh4FrpMHEUNhi9m7x0KkhVgAlVp/tV4pHBv3W9tqLsZdC4fv3zA0Gh2ss7dMCgorSqHP0TsWDcr4f1+Pf8sW1Nq25LW0NZtytHEXhYW8jApTtklj3el8D00PKWV6/hziljnhoCEo4Ek3yqxGgD+YFj85M6Z43xxf+jveuKJpYR65vEoCRdgvMES4E6e3cTKG8KAEy6d1qaLAhCNyg1yE/w2qyPax4Ro5hL94fBmqpU0sPCtadeDxk4tCLNUeO0xIGA5O0kQaWT68La+6G4WaY9BpDk5cEfDUXJDZ5zztK3kFBpi1yOj3wZq8mEp0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOcPBSG6Xp7yzESeXiDiChf2zA5Bu1/kbHlFgzxgsYY=;
 b=UYo2EO8VQaNDpZs/eOWWaQ3b+UtzQLasW3bRu/wWXT3PAPDMhjN6ceSQMojl9e9/8JmZr5bUzKIfaaMyHfnuZ0q91DuSg6hP6VmddUpGSGVygpHgFZhkylMsSS+D5V5LmkkBNtQ7NtIdAabSui/Wesw/3NVOkza5GE3OikUixP4GTDGebc4s4zNaSQKtDLj/RV5wKuYl20T0fDQG9lJzoUEH7Rf+LPum7NCqYNPA81kKwjaFeK/o3UNLcyUDGL3LEZY3dKsexTWnNO7WEbY+gPLj0XrG3dZmM6fGFC8t3aMxFMD4EZIHM2CHCkQIurQzOoqkNSGF19EFBw0e5e9aSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CO1PR11MB5185.namprd11.prod.outlook.com (2603:10b6:303:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 17:27:33 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 17:27:33 +0000
Message-ID: <944e7e64-509b-c916-5166-13e7bfe2161b@intel.com>
Date:   Thu, 17 Aug 2023 10:27:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [RFC 09/12] fs/resctrl: Extend schemata write for priority
 partition control
Content-Language: en-US
To:     Amit Singh Tomar <amitsinght@marvell.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
 <20230815152712.1760046-10-amitsinght@marvell.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230815152712.1760046-10-amitsinght@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::34) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CO1PR11MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: a72f6089-f90f-4ffc-5efc-08db9f473dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRHTeW0A97rkCPcRW6Lm/0FNFxJ4TPKxT4ssD4Mbl9O76lSS8mUauGrS/jc5A7gMZYa/ZBA7pN3AwVnVtCNnuC0pOg1hlDgG/dIpqUs3bgKqBFYBLCR1qZxy5yGt/2EyBflRZFiybNmzm+3KIZjKN7fcDX1++NDmpbyECeR6sXqFtNtwvtjaK12TbpA9UCzXeAMgoMXvtykHfIkieeV7WGvEi6xy8olqX744Y+hdDZHhrbY7xPCfb9wUowelTFkID19H/8Pq6qUD6WqYNmKeLcg79DTkbc8DArxv5EPVpkILcGPxNusw7eA8O4VOYNIw6bz4qF/BSH3FSbPPh/7XE+czN/Gt0dBFXtzbpjtAL0PQAQ8vmAagdcSFpJwcC6KjXtbHyv0dUeBMfGGaSCwVVdzv43DbEBLzXoVV2yuwqso04T/m/VuStvxm9CDIIYfzZma4NMnWLxpzuu4fZeNjKssjx4qXGSB0BA1LH+xF1hXbNaEuS747J0UyumBNWAvJWDeLr8dY5mDM+Uy0dXTe9WVd7yzRp2Jg27ILLtMJ4SUQ+kjd8C4XbyT87CF4P5TifKsfwc5vp3EY4+PH6YRaQ7YI0O8+kmFC9qcuosi3carh9RJseoGzonQ2mi7GFKFcqdol8PxBaW0WZitiVYE0tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199024)(1800799009)(186009)(31686004)(86362001)(31696002)(36756003)(82960400001)(38100700002)(2616005)(5660300002)(44832011)(66556008)(478600001)(6506007)(66946007)(66476007)(53546011)(6666004)(6486002)(316002)(26005)(6512007)(4326008)(8676002)(41300700001)(8936002)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0RVbEJKSlZMWUtJMDVNc045Y010bmJXd3lWbDBJbzNaSmllVWRkYUhYVlhm?=
 =?utf-8?B?cmk4QjZvampnaWJKU0FkWU40NlJuRTZkQWhJSVBla3Uva25vYlJjbEdmYVdp?=
 =?utf-8?B?MW0ySnZoK09RNHhEU29IUGh1QXFmdnhXNDhLN2RackR3N1hXNktDTkk3Ukx2?=
 =?utf-8?B?UStBNmxvOXo2YmdMSFQ3L2RrWHpRYlp3aGU5SHhaZi9BTVBOZ0pZQnpIZjlW?=
 =?utf-8?B?Zlh2T2dyVWYvMkJWejZHOGJEUGJUMURiQkx5YTE2bFMxRWg5TStHRGdvc1Y4?=
 =?utf-8?B?TlFGWDEwejdpU05aQnV2MEg3aDZmaFVnRmpYUUVaSlkwVVNrWlRveUtrSmo1?=
 =?utf-8?B?dGUxYjVQVDNSWXRnV2NRUHRWL1NQRlptNmpxMkl2aUQ4VXNkZjhZU1ZqTzJX?=
 =?utf-8?B?V25Idkg4MDE4VjJTZHk3NTRKc0ZZSit3Ri9Sd2xMT0tsVmQ4SFZWbGJlR0Rp?=
 =?utf-8?B?Rng3ODNBNVZNeGZIQXliRzFqTGc0RzYwVGpEbkZqOTMyZVpVUTcrZUNacXMv?=
 =?utf-8?B?TVFiWk1OMDJtL25MV3RtVHJxQ1hKL2ZXM29MSFVzNTBMUEFzeXZqRzFZeVpq?=
 =?utf-8?B?cGdHU0VPU0VFOUdaczZKT0EvVng1UUx1Y2YvcEM1NHBhQTd6VlFlZWlIUTRi?=
 =?utf-8?B?cDlzbmVGU0ZsZGQyMCs1ZGI5NUFkbytTK3YwMy8wM0x1eG9PUTdKYUM2WHp5?=
 =?utf-8?B?dXJpMFFrKzkzV3VpNTRWSHQ1QldpaitvVnJYbkFYcjJpYjdhSzdTRktKenc4?=
 =?utf-8?B?SGgvYW8vRnZJYldodThSMG1NRFJJT0QxdVZoT21WY0F0WHg4Nm9PSC9CbTVP?=
 =?utf-8?B?NkdOa1gvTzY3a1RMbTRpUmJiTkp3K2YwcytHTm9SNnk1c2NZeThwU3ltRkJ2?=
 =?utf-8?B?RC9UK0dqRUdqSk5BVzhleGh6N3hYZVF3OTE1czVsZnRwNStyc3A1SGRmQ2tM?=
 =?utf-8?B?d3VQOHZLOVpsQjRTWSt5aGVKcm16Uk05bVdOK3RxV1BaSG4xZE1SWWhDME9Z?=
 =?utf-8?B?NVdmSUd3K3BkaVFFTXBCTkdUUWJDVWN2ODNadS9PRkFmN3R2Q1dBaWNJa0E0?=
 =?utf-8?B?QjBXNnc0OW9WTXZVdUhUMWN0c1B6SCtZSTU2aHMwbC9IOFhka094N2JZd1FJ?=
 =?utf-8?B?R05YUTVBc0tETmpLYkE0T2RCcGcrQ2JSNkFRL0srL3F2NmN3QmtPZWFzcDQy?=
 =?utf-8?B?VnFmSEQzanBHYzNGbEdQeWFlWmtIeDUrU3hlK3ExQndPZ0tRSzJLcldyUlVD?=
 =?utf-8?B?cUh3N2U4cXVPSFAvVkFJZDM4b0VVN1ZzdkJ6Qjdic2lMVEhYUGUyU0drdlps?=
 =?utf-8?B?Z3ZuYVpXdGtvaTV6cUlBL3BwU0FGQVpaRDNOb25sYjRzZkU0anRYWWhFdStQ?=
 =?utf-8?B?TmdUMUpBZG1RSllGL0R2MkRIcW9PUWMrQVNyakhPa2FKRmF3aXNEV2dWblJr?=
 =?utf-8?B?eE1Ld0tnUnRWbDk5UnU4eExjS1l2VElUNml3MVM2eVYrMVpJN0Z1N1cvdEo1?=
 =?utf-8?B?NThiZittb2J1a3dIcEprZlBJamxBWHhwMU5lanlSVHhCRXpnNkZpN2MxLzJT?=
 =?utf-8?B?cW1sOHMyS20rejFsL2lUd1NXNEVOS3k4WTNadGZNdkYwMzRYcHRkOG9tWjd1?=
 =?utf-8?B?R1ZGT2pIZFF5YW9GekJSZjNEazZMSEdOZlFiNVVPM3VLcHBodW4vYTZ6aklK?=
 =?utf-8?B?bmlXc0w1dHF2Z3pMbjdRMmx3SXZ2TXV4MGNrUFcxekkxZHcvNk4xWEhRV0dW?=
 =?utf-8?B?SW9ZaHJiL0FhN0REUUl5RGptVEJZZnF6NUZTSUk3Zm5sTk8zNnFXVzVDTXly?=
 =?utf-8?B?TENtbjA2TTVDYmlHRy9jMmN6S2V3SWk4L0FFVjB4cWFIZEx3UmZEWTZBbXB4?=
 =?utf-8?B?OVlXOXg2bEJVVFIyTnBGcGUxdTJBYzNzRlI5UnNHcUV6ZXV1bThkSDU2eUhm?=
 =?utf-8?B?VzNVVSt4UFV4V1FyVk9sUVN0NVdOdlREazJJdTd3VklCTThheWtvWVc4OEFm?=
 =?utf-8?B?U1U3emk3Q1V3cXROa1g1cEVXUWRMWUxQdWY4WXZhbDkxS2ZkaStRZmEwWVJ3?=
 =?utf-8?B?M1l1TFRaYzNpMkp2eXNSYisvT0lpZkVNSlU5MGFxaXNGZ2h3NEdSdUJTdTEv?=
 =?utf-8?Q?CSDQfJf6Xi/oQMNCuevbEceyt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a72f6089-f90f-4ffc-5efc-08db9f473dd4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 17:27:33.4465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1+UAw9fQHt6p6ufkvrfVfj4Sk26/HLsCPyjky6wrvOt05Hmf8exveyWcuJjdKWYDIvB/W6Alm/Lu6TYqUWncg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5185
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Amit,

On 8/15/23 08:27, Amit Singh Tomar wrote:
> Currently, Users can pass the configurations for CPBM, and MBA through
> schemata file. For instance, CPBM can be passed using:
> 
> echo L3:0=ffff > schemata
> 
> This change allows, users to pass a new configuration for downstream
> priority along with CPBM. For instance, dspri value of "0xa" can be
> passed as:
> 
> echo L3:0=ffff,a > schemata
> 
> Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
> ---
>   fs/resctrl/ctrlmondata.c | 92 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 92 insertions(+)
> 
> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> index ffeb68270968..b444adee2002 100644
> --- a/fs/resctrl/ctrlmondata.c
> +++ b/fs/resctrl/ctrlmondata.c
> @@ -30,6 +30,74 @@ typedef int (ctrlval_parser_t)(struct rdt_parse_data *data,
>   			       struct resctrl_schema *s,
>   			       struct rdt_domain *d);
>   
> +static bool dspri_validate(char *buf, unsigned long *data, struct rdt_resource *r)
> +{
> +
> +	char *dup_buf, *dspri_token;
> +	unsigned long dspri_val;
> +	bool success = true;
> +	int ret;
> +
> +	dup_buf = kstrdup(buf, GFP_KERNEL);
> +	if (!dup_buf) {
> +		rdt_last_cmd_printf("Failed to allocate buffer %s\n",
> +					__func__);
> +		success = false;
> +		goto out;
> +	}
> +
> +	strsep(&dup_buf, ",");
> +	if (!dup_buf) {
> +		rdt_last_cmd_printf("Unable to find priority value token %s\n",
> +					__func__);
> +		success = false;
> +		goto out;
> +	}
> +
> +	dspri_token = strsep(&dup_buf, ",");
> +	ret = kstrtoul(dspri_token, 16, &dspri_val);
> +	if (ret) {
> +		rdt_last_cmd_printf("Non-hex character in the mask %s\n", buf);
> +		success = false;
> +		goto out;
> +	}
> +
> +	if (dspri_val > r->dspri_default_ctrl) {
> +		rdt_last_cmd_printf("dspri value %ld out of range [%d-%d]\n", dspri_val,
> +					0, r->dspri_default_ctrl);
> +		success = false;
> +		goto out;
> +	}
> +
> +	*data = dspri_val;
> +
> +out:
> +	kfree(dup_buf);
> +	return success;
> +}
> +
> +static int parse_dspri(struct rdt_parse_data *data, struct resctrl_schema *s,
> +			struct rdt_domain *d)
> +{
> +	struct resctrl_staged_config *cfg;
> +	struct rdt_resource *r = s->res;
> +	unsigned long pri_val;
> +
> +	cfg = &d->staged_config[s->conf_type];
> +	if (cfg->have_new_ctrl) {
> +		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
> +		return -EINVAL;
> +	}
> +
> +	if (!dspri_validate(data->buf, &pri_val, r))
> +		return -EINVAL;
> +
> +	cfg->new_ctrl = pri_val;
> +	cfg->have_new_ctrl = true;
> +
> +	return 0;
> +}
> +
>   /*
>    * Check whether MBA bandwidth percentage value is correct. The value is
>    * checked against the minimum and max bandwidth values specified by the
> @@ -293,6 +361,8 @@ static int rdtgroup_parse_resource(char *resname, char *tok,
>   ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>   				char *buf, size_t nbytes, loff_t off)
>   {
> +	char *dup_buf = kstrdup(buf, GFP_KERNEL);
> +	struct rdt_parse_data data;
>   	struct resctrl_schema *s;
>   	struct rdtgroup *rdtgrp;
>   	struct rdt_domain *dom;
> @@ -354,10 +424,32 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>   		if (is_mba_sc(r))
>   			continue;
>   
> +		if (r->priority_cap)
> +			r->dspri_store = false;
> +
>   		if (!strcmp(resname, s->name)) {
>   			ret = resctrl_arch_update_domains(r, rdtgrp->closid);
>   			if (ret)
>   				goto out;
> +
> +			if (r->priority_cap) {
> +				r->dspri_store = true;
> +				list_for_each_entry(dom, &r->domains, list) {
> +					ctrlval_parser_t *parse_ctrlval = &parse_dspri;
> +					char *dom_data = NULL;
> +
> +					dom_data = strsep(&dup_buf, ";");
> +					dom_data = strim(dom_data);
> +					data.buf = dom_data;
> +					data.rdtgrp = rdtgrp;
> +					if (parse_ctrlval(&data, s, dom))

Can this parse be called within parse_line()? So parsing and validation 
are before real write. If any parsing error, no write. Otherwise, 
partial write or roll back may happen.

> +						return -EINVAL;
> +				}
> +
> +				ret = resctrl_arch_update_domains(r, rdtgrp->closid);
> +				if (ret)
> +					goto out;

r->dspri_store = false here?

> +			}
>   		}
>   	}
>   

Thanks.

-Fenghua
