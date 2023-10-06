Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086517BB45B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjJFJi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjJFJi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:38:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4219F;
        Fri,  6 Oct 2023 02:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696585135; x=1728121135;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KDZzYJDlF1tjy9kEed1WOMPAgjiIxlC0srjk2wI/LzM=;
  b=QE8HkUK+wxoTUFd/PzTqjYISWQFVxGy18hxSm8/ObALXVha5Wd878E55
   rD2m5ziSXA/fuuXP/w1l2EMQazor/2ixJI/vdDeinIeoWpihmFQfUOr9E
   7AX45m35rJIVFuxgjMKJSGmIRnwGGotY9czAQ+fJBoQeReix3myKP1HAn
   6idv+SKDKijxoQHWEgKnnespqQ7QO0yGk2EjGLe4643I6Ws7K9K+96PXm
   2CRuH0k4S5956j2Adqm3DaBlI4nMGNBvnzlXnx4JZ0FQZm8Ky0AHEYCeb
   ZKofMPNP1Ox2YWexAdKIq90H3Fju6AKYTx4VdNrw4eS/tbqAc7Y4AEMCL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="469987496"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="469987496"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 02:38:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="822447021"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="822447021"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 02:38:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 02:38:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 02:38:52 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 02:38:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jF73cp86yAqc/lvZBaVmONpK3bbo5MsCxtUwGiJ5pL12qqjFk3bmuf/3FnzkX6aOSH1BjUyZOLT3kYi83mwWBn+PsysyTBgq5EyHDKff/ESFWCQc+Mr2Nr3ixP0QZvjJa6VmtMzh71RkGwIVcE5mGq2rT7afceFh/VUAte9UEUxmSMKK7qtWrN+QAAViiJRJHwOlsk7gAp5eXeb8Dn4IQlu1T21DGyFfw2etYnhILo+fZQZ72wk3KuaRlLA9VHYk5lAWlFlPWlRe/8cWsJp4BJ7498n43LAPQD4cZJHQNDvhNaLeu/V+D9bWX5H/nw3Aqfly2JVhJIVN6AACS/hVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sefaXW9mo0g6avM1v9SU964V67TH7RCJJcCWUz0uBZ0=;
 b=OXX1IpLP0uP02UjBeDtZHM/62QSG41jHAi383oq3p0Z2lRVEj8OcZ+xr4RQlw7uszQc4e4u5bf8AfqQ3uKLVN3gyZpj2xnAfJQICVdJE3p477a+telTau2nll2wvgJ5JTZEPe2DnXghwk7VIoKbr6xj8a0T7Qdj1y4Gw0bChd8PlkNsU6J2dJtoSuoeSerS6SOPed7/RpRC5GyHBnLM45o19cP90RrQeS8JGuiUZkyclP9I00VNRpB4hwCHSfjOppI3It/4HM+fstcrqP6gu52lOiWKrdlEfXSAWMIj3Lxd01w8OAWYMaxbaJIio3dZExBYJPt5pkaTyCBnNcJ9Hiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SN7PR11MB7705.namprd11.prod.outlook.com (2603:10b6:806:32f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Fri, 6 Oct
 2023 09:38:50 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Fri, 6 Oct 2023
 09:38:50 +0000
Message-ID: <2bd3fad0-a109-838e-a495-f0ac27286c04@intel.com>
Date:   Fri, 6 Oct 2023 11:37:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] net: dsa: lan9303: use ethtool_sprintf() for
 lan9303_get_strings()
To:     Justin Stitt <justinstitt@google.com>
CC:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
Content-Language: en-US
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::13) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SN7PR11MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: a53b8202-1ae6-42f1-868f-08dbc6500ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 249xHO8KCa+5hiArOyHsWuDwOL9sWVdqhaGNziGdTlxBVcVMPJGRQa4T6YtonRX/YbJrLz3kUcXZpDVzgcOYZpNYjTP0cmft3BSzUCazWT+gJIDpN9skVqjGOZwxhFwJErswUMJwUfcn+NtG44bFXR9AlV/IL6tuBft0wfH/cpEBaU5/RhUy5V89My3pX9BeFTJZhK43YwhivorqHoPlMOFt1exkWcTcVwxXmgvjpvldY/zjpSC80ZoBEIsTimR4qc/1PuDepm5ePH4Qe0nxTvyUywtoGf/6xFc3pXB8PgvFphHZWfCARPDZMJo2Q+D7qLGuGP7B0U5ZdbSdc6573osR+yg+aP+EJFI3/BbfsU2ZXxzOPK++m7RKX8SSV7x7vYIMRAxn/Y+f7LoZTVyCW5f/BrnA8WmCPI0+UvLWsAXgskjG9QFIDVMOz/GPYmmV9Mcj+eDQDnZOJ738++TMDQcWvQ+mFQR7QjdQzAZrCDsamwmi4PAlhngpOcxBHnTTsDNiWBKWHDYdhZ99uaKbvI/S0fLidvysGR9hMHfS63qYeTxK2SslhAWZ6Rqe05Tasdbf5MENCnaQAemT8I3C99aFxkeM6gESIEmIkZ+3yfS5St5q6kUApsfAR+C7CfI9kLhpSRI9TyQTN1ByI51D7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(6506007)(6486002)(478600001)(6666004)(6512007)(86362001)(38100700002)(82960400001)(31696002)(2906002)(26005)(2616005)(7416002)(36756003)(66946007)(8936002)(66476007)(4326008)(66556008)(6916009)(54906003)(5660300002)(316002)(41300700001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEloNVZBNVl6UjArZThaQ3RoMDBZOFhpdHpkb3FmU1F5WFpKMlBOM0RwdWNk?=
 =?utf-8?B?M203YVgvb3MzakFNTjZldis2SFowOWxsd0VQS0pockNwamVSbTdqR2MrZXA1?=
 =?utf-8?B?N2ZXMGhCSE45ZTY4TldYbU03VWs4QWsveEdRL2h3bU0wQTNUSW5odWtWL2pE?=
 =?utf-8?B?TlFGQndUZTRlVndwUHpqeFRZbWhYOGlRRlY5WnFjTmxlaW1WU1hsczdnKzJa?=
 =?utf-8?B?R2p3aFQ5R2FaQkRCaHdQaWVHOGVxcTdybkFhbElxNlRJZ0IxdTF0MWVIWG1W?=
 =?utf-8?B?L1hBMkJaMDJRc2lrZXFsNlB1MzJabXVNcGQxQUhDSWllTThRWEMzMlNIOFRV?=
 =?utf-8?B?bmYzVDljZ2FBSkMvdENwL0dYeEwzdUVteGFMQUJlV3ZobFIwSkRyS1F5bGtG?=
 =?utf-8?B?ZlFvamdnUy9JWmEvaTZISytENmdLV0ovakpYYk1kUUFvMWFvR084TjFVSEoz?=
 =?utf-8?B?b2ZBamlIbUc2ZjJ0TndLcVdQL2c5aDRaZDEvbGM4UTRTemFENzVWcUU2MDBa?=
 =?utf-8?B?U0RQb05CbzVGU3FJNnBnb3lKbkZtOGNYRDR4dTZvMWdHeUxXT3FKNzZSUnBi?=
 =?utf-8?B?ZmdncDhkZEVqSUdGWklVTEIrbWFsWlk3SnRvd3YyQkhhb1BXVGloOFNRbXYy?=
 =?utf-8?B?ZUh5KzNkanN3eUZMSXJXUmpGa3k4WHhKUnRLYXRIb2d3NHJLRE8vZlFKaEVu?=
 =?utf-8?B?c1N6MzJpZm5Pc0dKV2pzMmcwSFlrcTV0MUU5aC92WDZxTGQwb1lZYWxaYWRC?=
 =?utf-8?B?RnNRQ20xL0l0OU9RWStkeGRzVkhTam5pd3hPclVULyswOXRwdWNLcW1PMzdU?=
 =?utf-8?B?Z1ZsdDc4dTAvWUxadkJHZTVOVWtyd1BVTEhEVnVsRzMzZk1PQ2pjMjFjaUFk?=
 =?utf-8?B?NDQvYUV2ZEtRUHRkb1RjNVJkMEdxNE5TZDZwWXMzQmZTd3E0NTNzek5vR00y?=
 =?utf-8?B?a2lES1JJU0FRdGNNQWZzVDZwWk9zUjRiWWJUUXVHdHl3d1ZBWmxDakczenMw?=
 =?utf-8?B?WThzUloycCtWa2lqeWxjdUtQR0ZVdlJEekJWMzQrNXJwbjl0WStsYVdVNnQv?=
 =?utf-8?B?UFNZVVRzTjJqTFAzRUhpK0JlaHJmNVBKQmRrTVNiY3hDRmNzWGdGWml2ZC8v?=
 =?utf-8?B?Q2JjMFZWaXhjdE91R1F6UzNQeDlCTktzbjRlYnFmUXpLZXhUVVg1VUR5Qmg4?=
 =?utf-8?B?NVlmRW5hemRjTHRzNk5ocmhmYTBxME1FS2FEZnB0S2ZJNytqRWtmdUlzM2pN?=
 =?utf-8?B?MldEblJPQUJKK0gzMERYUE0zK1lqa2FPT1FjaDcwRHREaUM2TXgybUc3TjZV?=
 =?utf-8?B?Y2Rmbm9MVjBRVklBUjdhUVFEekNycitUb1pXQ0lEZFVURzVWYm1LK0hGRXBn?=
 =?utf-8?B?V0NxUENxWHdkVmk2Y2ZPZU5oSnFIbFlNWUNDQjdHWllXbStmd29JWTc1S0VU?=
 =?utf-8?B?bjJTbkc5YXhqT1RDem4weXpsVDhjYzMxbllVRi9XUHRkYzI4OHpLelo5R3lR?=
 =?utf-8?B?ZHJXN0NDSThhODFZSTFNdEJSUWFLb2VhNFZsa3BXV0NPemVlT2UyWFkveG9Y?=
 =?utf-8?B?UGsyU2thQ1NhWGJ4RFExOU1nQS9DZnpxelo1eEo5YW1PN0tLamtFVExtOVVu?=
 =?utf-8?B?eUdBZFdDdjExblJlM045b1lwNzNNU3o5WWI2dGkyWFBpQm9WcmpCcHZ0NURH?=
 =?utf-8?B?S0N0NkdCYlBtT2dmcXFYaGVFMytVSDU5YmxDaEI4SkdXZkZXS0NHL1BoZEFi?=
 =?utf-8?B?NG1nNnNtMWpXQndRUUh1Tzl4SWFneW9hVmw3UXlsSVNBR00wc2hLZmlXVFl5?=
 =?utf-8?B?TENxdjRONUZxL2F4QjlPVmh5Q2s0YWFDRnRBL2FjM1QrSmRKQ3FtalozZ1VM?=
 =?utf-8?B?ak9QZ2hFVndYOW1XL1FPK2JodjZRdDhKTlYyNm1MUXZPZ3VEeExITkg5S0s4?=
 =?utf-8?B?cFY4ektYVnZNNnpQZGxnWEQwYlgwZWcyVEg5aFJCeFQ5Z2V5VFpnaTF0bHFq?=
 =?utf-8?B?RkJYbUprVFhGMmU1MCtlZlY0eUd5SWxjUXpvdFgxVmp2aWVrSHJoUVVWV3Vu?=
 =?utf-8?B?RHgrV1JmYUU3dFF3QTAxVnM2bWJicFg2dzB1QVN4OGw1UG9xdE5wVmM4dmFu?=
 =?utf-8?B?ZGx1L1Qwd2R5TmpQeEc3RmlUU1lQSVZsbGd5UzZiMExoNFptTDEzQjFoSGpq?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a53b8202-1ae6-42f1-868f-08dbc6500ab6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 09:38:48.6892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfQECaMuZpwEm7nx0hogHSM86np/jxOLK7HEt3pnIxXO44r8aDdkJMrdlJNS1HWL8wHR1Q1u9Wf9hXX/iDHnOpyYH1B98zcvzyMxYoYbBKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7705
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Stitt <justinstitt@google.com>
Date: Thu, 05 Oct 2023 18:56:50 +0000

> This pattern of strncpy with some pointer arithmetic setting fixed-sized
> intervals with string literal data is a bit weird so let's use
> ethtool_sprintf() as this has more obvious behavior and is less-error
> prone.

[...]

> diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
> index ee67adeb2cdb..95a8e5168c2a 100644
> --- a/drivers/net/dsa/lan9303-core.c
> +++ b/drivers/net/dsa/lan9303-core.c
> @@ -1007,14 +1007,14 @@ static const struct lan9303_mib_desc lan9303_mib[] = {
>  static void lan9303_get_strings(struct dsa_switch *ds, int port,
>  				u32 stringset, uint8_t *data)
>  {
> +	u8 *buf = data;

Is it needed here? I thought you could pass @data directly to
ethtool_sprintf(), if it doesn't mind.

>  	unsigned int u;
>  
>  	if (stringset != ETH_SS_STATS)
>  		return;
>  
>  	for (u = 0; u < ARRAY_SIZE(lan9303_mib); u++) {
> -		strncpy(data + u * ETH_GSTRING_LEN, lan9303_mib[u].name,
> -			ETH_GSTRING_LEN);
> +		ethtool_sprintf(&buf, "%s", lan9303_mib[u].name);
>  	}
>  }

Either way, this was a nitpick, so

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

>  
> 
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231005-strncpy-drivers-net-dsa-lan9303-core-c-6386858e5c22
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

Thanks,
Olek
