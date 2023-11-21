Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570967F37D0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjKUVEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKUVEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:04:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F7E1A2;
        Tue, 21 Nov 2023 13:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700600657; x=1732136657;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MIpWyzV+cYLlKLGRIwLslwp0aDQ9L4PO+dEzqakbsU0=;
  b=Yg7DgjpoqmA5UHjG12W+Ae7BXLiii4Ao3v0AgXQz2i6LWF8V0d17F+vd
   fFy10zX5qVGbxzM0OkqTAfC1aLKz8rZcsqVR+vIpcx2Hg31Px7Wt27XN1
   tp6xZnUMcJHe03N0J7Ta5a8DHkee0z6um9b0jRCRGr3tHNUO62oaFV1LH
   o3tnyTIg18FyChmBw8SKN2UHygohgv2eGNR9LQbjSXANbHdrUF82+NPbO
   kcOPmnnX53MQTLrsXeK3vruGOne5TrzwwNodSwy+GtnOBr6t8+HfMn6gC
   QpZZQTEGOOjd5hDWSckDqPdjlK4zDkziCudtt7J7/sNGznQsqqNNuEG2O
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="13476007"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="13476007"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 13:04:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="801675067"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="801675067"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 13:04:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 13:04:13 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 13:04:13 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 13:04:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TI77T7eOUAl2REYrazl2qjVoHZQDDpA9Qq4+/Rl+Z6s79AwkrXKBOfCyUpDWFhLWkrFYHpjgWLPpyT0/d7zMcqIFwBqkTwvnX/ZRDs0bAHf9mc14IHnk9GbTDHuxcIZKdb6UpoX9J4Dqe1A9yUmfXMBBNAqynyc674qsGB6csh+HWpWFYKEQ/Yr2v97FYb5fFffVVINlM9v57G+rzpg39AfQrcm0yt2dEvRbUsC/LZgDDLfQ1pBeN7x66MjhOdl3vSCMnA1e1xC1JQqDVbmVlYHDx3HzRvMxng0lFaS0AT+ArwqPXdQX3UZYYo/MfQLFwv7yVZRN2qYpnXO6Y8xawQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvrzKJDG6fTlJpbTQ67sYdqx7C93pNtD/6JBq8dg18U=;
 b=ZTuR7xM47ho6DuZ1l1P9l6/HG08X83pWfMJqIWIfHPuBANeZwYTKIkIm6tPzBI0CxvBcjAy3N10iDRrQsb9jNJeMNXmig0E30ZjfYMakYhu8M/pAQNXFOv51dFcs10Jk0ARd8AD7LOHATtzUYK8YBYEXm9B71fhkruSG8Y8v4CoJL0En9VciQ9hZl1bXrbPpvzGWkmyhHGS5XqK+dNESjjOLmQ1YoqYMO+4Uuv3Jo7B6bZo8fL5eb1IMefz4YVnc6JnNPEIREsV+AVg13UJqeLuaplcpst/KwGkr8UWMJOPw6RojE0C30cBmVhs/MkzG15bgzR0KxB5Vr/PxDyDXAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by CO1PR11MB4785.namprd11.prod.outlook.com (2603:10b6:303:6f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.30; Tue, 21 Nov
 2023 21:03:59 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::8e20:31f5:2a6e:9bdd]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::8e20:31f5:2a6e:9bdd%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 21:03:59 +0000
Message-ID: <69d4df6f-71ea-4a64-b968-956c69812504@intel.com>
Date:   Tue, 21 Nov 2023 13:03:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] octeon_ep: get max rx packet length from
 firmware
Content-Language: en-US
To:     Shinas Rasheed <srasheed@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Veerasenareddy Burru <vburru@marvell.com>,
        "Sathesh Edara" <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
References: <20231121191224.2489474-1-srasheed@marvell.com>
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
Autocrypt: addr=jesse.brandeburg@intel.com; keydata=
 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
 /fnLfll98Nhx
In-Reply-To: <20231121191224.2489474-1-srasheed@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::12) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|CO1PR11MB4785:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5ca9c4-830a-4acf-41da-08dbead561b4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2gYR88FaBf5k9JTOQWPpf7nk73OtfJe069HeGzqb9CQx8u0MLXyfvxBcbf4KGzWN7jmB6PVOu6jjZbAJZNmujYBFeITjb6/d773twhTJERI2CXDHJ1X4glHGN9MFOln02j6IZPY6Z/VRSWmTwViW1ltB/18RrD+SvT0MT4iDz+WiV15/K91d9zih4vb/K8cCNSEi3HSP8f3XRLk2FwKxDysPFfvz2kprS0w25msIZkSf/76A14Plci2Khu1tr1sUR8AAAvEsJhsG/o9ZsucXmTayWCiGs5tqA9yy2GZvVwUqkg8PTv0XYxdEuAB729KYpJwAizIhNhm/HuoSkhMJi7w9K9d7E+A0pyAK9eK4BMOYTTWwr5iw7V/cvozD+1UJvkTEFG2dyPH7XnBn3bbpJtHCEg/yVCaA0mhoX+TydtVSae1B0Om8rKfZ64tR4kbh/ng6mnL7DeLMp92BQTYWj+FPwJKdXZC7xVdQ4bzcZet6Sm6w/aJ6R75lGuKjkrPHv7oHEhM3Ita1WbWdFpwn9P2MNNgLavOA+hy8wSZwjmp+fvD2vpnGBNcgWU8lrFgBuIk2DdpB9bn8mY8vMhidEvGk4zXntNdOVu0OgwLTjQyHTl5Cxyxh9sUuZeDcaKaaSBZFW7mx9ckXq72MFVz5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(38100700002)(31696002)(5660300002)(86362001)(2906002)(83380400001)(31686004)(7416002)(66556008)(66476007)(66946007)(44832011)(54906003)(316002)(4326008)(8676002)(8936002)(36756003)(6506007)(53546011)(82960400001)(6512007)(6486002)(2616005)(26005)(41300700001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alI0Mk90Y0ltQU5zWTRGTXh1Nko2RUp1YWtJSVIyYlRKVTUxejdsQ2hKalZQ?=
 =?utf-8?B?QXU1VVJKRjkrd2t3SmoybE80Q05DNXJYMEFaK3N3R25McjNicU5DZTJRYW82?=
 =?utf-8?B?Q1JNV0tsVUhKN05tQkJIelRTNGYxQTBIUG10V0ZrdjBoTlNjTXJURGRNdlVz?=
 =?utf-8?B?ckZhdDE0Uk5Gak10U2NFcXhsUXhoRDZGMjBuT0tzOENFL3Izdi8yRDd1czB1?=
 =?utf-8?B?eEF4WUZhejV1MEJmSnZTWndNNjMzbjBWbHE0L3hDTTRtRXFPZlFnQTBubDZ3?=
 =?utf-8?B?OFpubVNhRGVxY3cybkNUYjlVRnhTY0R2dmdZYTd5YitaWFpQVUp4c3o2UXgz?=
 =?utf-8?B?WnlScThWdEphZkRyK0ZUVUlpTXpDRGVGdzlhbXdhZWJBM1lRNTdQN1BTY0pu?=
 =?utf-8?B?VjNOQ2pDN1p0cXBzVms1b0RHM0s2akc4QzA5ci8yc2oxY1h4WTRWaWhoZHdD?=
 =?utf-8?B?UStFNUp4UDhyQkJZWTRNNDhPdXBhTXdMK0FIaW13Q1FCcUlNL2gyMXFFdGJ3?=
 =?utf-8?B?UVNYcGZOaUF3RDNFZmRzbVNHOGp3dVZkckRZSlhFUks3b2hDU0xXN2xqeDJu?=
 =?utf-8?B?bXV6QnFaUjVNeGg5d0w2UGJiUjhxSWUxYktvL3MrcWwyUmNMT2R4K1RPREtY?=
 =?utf-8?B?NlpuNnk2S0g3T2JkOEw2dlJxbE9sNGRIbFFBd2l3RWpNSG1FVXlXaDlvL2lI?=
 =?utf-8?B?bGJQQmFQbkVHUjRvVXJRbFBwN0JKeTdBUHB5UUlzejNLbkg1MThqSUt4WEZD?=
 =?utf-8?B?dVVnVDY3czJjaXdoUURUMHZXY1NMQzlFUy8xZ2JYMEhxbGRsRElqMEFEdWQv?=
 =?utf-8?B?Vk02L2lueXJKVnVhR1RVNEd4aWhIRlZXekkvMnEyZ1VBMHBVdzlyT1JWaGdK?=
 =?utf-8?B?UTB0NjloQ1JHaU9OMnJEQWJnT2NiYi8wZ0t4aXVwQzFTMm5TaTJKbXBmYWcw?=
 =?utf-8?B?UzZMbjFGcXpxeDZUeGZ5TUlRcWFPSnBIK0o5UldpZEJlbzgwU04vTkRWNllp?=
 =?utf-8?B?c0tQUVhDWkZlMnhIenZmTFc2WktrSUFCRXlSclpoN1UzNW0vUHZYTzFLemcx?=
 =?utf-8?B?WDVOdXF5SXVvOVpiMWN0OGppTVYwajVYemEzZ3U1YnhhR0hCZ2dlR2FYRWhp?=
 =?utf-8?B?MmJTYUg2MUtxSk5SSzYrK0d5U0pxWVdyc0tyU016dTNWVEVKaWgwS2QzamtK?=
 =?utf-8?B?anlOS2t0Vm9yRGVJQXlqZE4vbk9uZDl1cE8xaEVDWEl6QVpvaVBXQkhyV2F4?=
 =?utf-8?B?ajZ1N0NkWjl2cmYvWlJkd3ZTVkJkQlk2cVpBWUNTL2EvMjB3NVNSNy92MFlX?=
 =?utf-8?B?K285dmFaNUlYaUpOano0SEZRSE1aRVI5ZElmZ2c4dFkwbE5PQ1BXTVNBSFZU?=
 =?utf-8?B?SkhxSjdDbzMyQzVRa2pnNG4xZCt0bmNyZ2YxNzRQazh5elpNNFovZkxNTFRo?=
 =?utf-8?B?NmtJNnpGa3pvbURiS0tSS2UrOU5XbDZ4SllkZkpabEI3eGp1Ky9rajZraGZu?=
 =?utf-8?B?QUpaNkFRKzNQYUZFK0Y0dDlHVTNqK1lCYlZlQ1NtNmlsM0hRSVpJV2d5MUpi?=
 =?utf-8?B?eS9BT28rQ0sveXkzKysxMG9SMHJsUnlQblppYzMvWkVWV0JCektNUXlZRGQ5?=
 =?utf-8?B?cUVxOW4wVExPZzBBTGQvamZrdE1jNFp0WS9zOHhxWmFmVWNIbWpITnVOS0Zk?=
 =?utf-8?B?TnFkRFpoc213eVM2QWx0TU9kYjIxdnp6RlB3OWk3SDV1dHhaakpJR2hIZ0k4?=
 =?utf-8?B?STM3QkFRdlNYZHlqNkxXUWpzdEVOVTFmMENQTE9sZWRCNWR3ZTYySE03YkIx?=
 =?utf-8?B?ZGwwR3h3aEdzTTlzM0VtSitwMzJHL3hWdy84ZEpDU3J1UzAxWDl2Qm1RUlR5?=
 =?utf-8?B?bDZkaW5FTEhad3FlV000OVh1Um9ORVYzWTRPajdTUHBCTkttYk40RTdKa0pp?=
 =?utf-8?B?eitqUU9xMVdQSzI1d05ZZGJWaFg3c3ZtZERkOVFLMHlrUStYZWJQaWJSTHRw?=
 =?utf-8?B?bUpxaXQrbUpIVFpTQUt1M3puT3l5TEloS2haNDg3UFdxRVJFSEtWVkpHYnFC?=
 =?utf-8?B?eTEyb1BORDI4cVBrNDRsbDlZaEs0SzRPL2xmYzVLTVN3SGhkUGxFZDlkTURm?=
 =?utf-8?B?bEZNdi9SU2xpYkRyOTZYZjRSNWpKbWorbUdDSllHR0J0M0RVZGRMSVNHdDYw?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5ca9c4-830a-4acf-41da-08dbead561b4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 21:03:59.2289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: un8nhb0EAi4VfMlHjwLKT3nZfn04kWZZn/qVgw0YEbn2gaqFuh6ypiZYrMS07PwodveXXsVpUBNR75ZkBBoaTpI1BRrmu0+FOT05dCm9W2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4785
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/2023 11:12 AM, Shinas Rasheed wrote:
> Fill max rx packet length value from firmware.

Hi Shinas, thanks for the patch.

Please provide why, and make sure you're talking to the linux kernel
developer audience who don't know anything about your hardware. We're
interested to know why this patch is useful to the kernel and why it
might need to be applied.


> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
>  .../marvell/octeon_ep/octep_ctrl_net.c         | 18 ++++++++++++++++++
>  .../marvell/octeon_ep/octep_ctrl_net.h         |  9 +++++++++
>  .../ethernet/marvell/octeon_ep/octep_main.c    | 10 +++++++++-
>  3 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
> index 6dd3d03c1c0f..c9fcebb9bd9b 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
> @@ -198,6 +198,24 @@ int octep_ctrl_net_set_mac_addr(struct octep_device *oct, int vfid, u8 *addr,
>  	return octep_send_mbox_req(oct, &d, wait_for_response);
>  }
>  
> +int octep_ctrl_net_get_mtu(struct octep_device *oct, int vfid)
> +{
> +	struct octep_ctrl_net_wait_data d = {0};

I think preferred style is now d = { }; since that doesn't mess up if
the first member of the struct is an enum.

> +	struct octep_ctrl_net_h2f_req *req;
> +	int err;
> +
> +	req = &d.data.req;
> +	init_send_req(&d.msg, req, mtu_sz, vfid);
> +	req->hdr.s.cmd = OCTEP_CTRL_NET_H2F_CMD_MTU;
> +	req->mtu.cmd = OCTEP_CTRL_NET_CMD_GET;
> +
> +	err = octep_send_mbox_req(oct, &d, true);
> +	if (err < 0)
> +		return err;
> +
> +	return d.data.resp.mtu.val;
> +}
> +
>  int octep_ctrl_net_set_mtu(struct octep_device *oct, int vfid, int mtu,
>  			   bool wait_for_response)
>  {
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
> index 4bb97ad1f1c6..46ddaa5c64d1 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
> @@ -282,6 +282,15 @@ int octep_ctrl_net_get_mac_addr(struct octep_device *oct, int vfid, u8 *addr);
>  int octep_ctrl_net_set_mac_addr(struct octep_device *oct, int vfid, u8 *addr,
>  				bool wait_for_response);
>  
> +/** Get max MTU from firmware.
> + *
> + * @param oct: non-null pointer to struct octep_device.
> + * @param vfid: Index of virtual function.
> + *
> + * return value: mtu on success, -errno on failure.
> + */

The above block is definitely not correctly formatted kdoc (if that's
what you wanted), and you can probably get feedback about it from
scripts/kernel-doc -v
drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h

I see you have some correctly formatted doc in octep_tx.c


> +int octep_ctrl_net_get_mtu(struct octep_device *oct, int vfid);
> +
>  /** Set mtu in firmware.
>   *
>   * @param oct: non-null pointer to struct octep_device.
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> index 3cee69b3ac38..f9c539178114 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -1276,6 +1276,7 @@ static int octep_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	struct octep_device *octep_dev = NULL;
>  	struct net_device *netdev;
> +	int max_rx_pktlen;
>  	int err;
>  
>  	err = pci_enable_device(pdev);
> @@ -1346,8 +1347,15 @@ static int octep_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	netdev->hw_features = NETIF_F_SG;
>  	netdev->features |= netdev->hw_features;
> +
> +	max_rx_pktlen = octep_ctrl_net_get_mtu(octep_dev, OCTEP_CTRL_NET_INVALID_VFID);
> +	if (max_rx_pktlen < 0) {
> +		dev_err(&octep_dev->pdev->dev,
> +			"Failed to get max receive packet size; err = %d\n", max_rx_pktlen);
> +		goto register_dev_err;
> +	}
>  	netdev->min_mtu = OCTEP_MIN_MTU;
> -	netdev->max_mtu = OCTEP_MAX_MTU;
> +	netdev->max_mtu = max_rx_pktlen - (ETH_HLEN + ETH_FCS_LEN);
>  	netdev->mtu = OCTEP_DEFAULT_MTU;

Not part of this patch, but was there a point to setting the mtu here
without telling the netdev? most of the time it seems sufficient to just
set max and min since the kernel default is already 1500 (which your
internal define also duplicates)

Mostly the code seems fine.

