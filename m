Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3007802FFC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjLDKUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLDKUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:20:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A8C85;
        Mon,  4 Dec 2023 02:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701685209; x=1733221209;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gKB5T9b0vzI/brXFkTTNPTdC3EvJjR8ByNrznFb2NfQ=;
  b=Zm6/kVawNgtV6IDw1JZs+gWZ3TTON9qfnKidcHhR+0TdvOeGVt8npBoM
   MXioGbjAmWThWVk7CwUy5nYiqJsD6d9G718g31JYM459o7etnkuTREeMZ
   OiOynKvA1oGcrwlpGjfeCL5tPIyqoZyJFW3kOLslFnAM11QW/XrlqolX5
   GqX2YTPjpMnE2VgGOFi4IZJ/n14ohUmIxxl6AA5ZhJBUJgBdc71vLOKAR
   WrJEqDZbRvP1JhYrzN0dMC/lyRNy+Tx7oVo6bd0kiiNoONZqCV5H/4h/1
   zd+SxtqJQNLZcpn7xoU1UaOn5I/4Md1mMOlrd6L1iR8AYvdFesussgsNL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="390871652"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="390871652"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 02:20:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="774211502"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="774211502"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 02:20:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 02:20:08 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 02:20:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 4 Dec 2023 02:20:07 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 02:20:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLQtKWvREB/sYuM5RPEz4ptZhj3aGSK0Hw3ppyuRfS1jMVmoeNXhGkc7Qph6s3ihidMbb6VGl+Enk1t3BLuuhgDy7PS6aKdJHu7pjNe5916R3QkA2VUqEMzQnFpky7JkHltMHZnvPzn42rNq11DYUlpDp3+OA5xrcS5H2PdAv0HgAbD91Et2Gl6RiWB9kWEY7UAYhyjYZb5s5I44B1N5V+LjgYO2qPxvP8kOtHTI7hb8AqZdeJDxSFKlAGDF2l5ihKYJChTwwV0mdc1C5C4Xb/8lHiSIKBBlLLPyyA3E6EgY10/wxeZM+Ujs0yX+25tcWp+R9zf34JUrUwR6gtcWtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYi893dj0YDa0EHLnoF74UN+h7gFoT7V4VOB77yivWk=;
 b=OY//DXwNMLGEm58FET66ijQ5hJgoeg879G85n5MZZF1HKZGfRtd+R9VKca5/38v05STdwrJl+YGH9d86P6hXI/cWxAj6ZtDFATf3pW+sK6oNbl9xnLDhvc2TAqvVuKHYbN/6v3b36wa32MIYvsReW5eQEwo4GXTEauzDcep0Q3S1ZM2CLWj8XpgM0wiI7Om1lUTKd8m6GmOCKRNS2sIjYy3wWDS41Ynjj3ATUVhhVLy3sb4opf83bbI+PdnndlPss++qxHLipJSq7QX272HcyWPSBTb7xnoleGQGBi+GVm7i9MO1Tbi2aCCVbGm8fs3o/8ZisUbbxbEAvsb471WCQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DS7PR11MB6222.namprd11.prod.outlook.com (2603:10b6:8:99::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 10:20:05 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 10:20:04 +0000
Message-ID: <c382dc51-3a3c-4c79-90c0-13e2e716d0a9@intel.com>
Date:   Mon, 4 Dec 2023 11:19:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 net 2/2] net: hns: fix fake link up on xge port
Content-Language: en-US
To:     Jijie Shao <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231204011051.4055031-1-shaojijie@huawei.com>
 <20231204011051.4055031-3-shaojijie@huawei.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231204011051.4055031-3-shaojijie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0012.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::27) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DS7PR11MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c8e81f-09a5-4598-36eb-08dbf4b2951c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ASieUdXiYC9Ffz6nZkhM1Kyhyaw4uK4EjY/qeyA6WQJH757u0mk81T4MgXyHMKy4XRMdo+ss6kTHCNc2yZScqyL4fIwQWrPYcIgIjWPzSLVExvCI6bcYAe6OMz59DqrE2ib5YEDEweaCu+u1Te3Uvq/MgulUeKf7QDBCQer3KGjrHfTZih/mIGWG2AhkKNC7py43SGcc3Jx3YrC8mkmH3IkFtb3QGafM0VHLTtFLNlnHC3pFr3z+IY1wJRq0nelgJLNurhtAcTWFRFuf48LH2vv+G4TSWELqXfZBl4a4eXvEhlOJAEX0rIPz7l0DZx2XIINAhU0TSrRf21foeo7J9D6rvIIuXXXKpwQgeZLH/XHx8ybaSPDe9R3+E+xwbeoELiDLw01ONyt3qV2TU+Cjy0db0HOkOKGXoxVza1ctoqENxfdD/zUTQub1vMtqiR+IJ+LwOzkPhmTid83Sf2G3BAZ0gyGS4aQdocEikxvzHwepQ20XTd3sfgS1d7fFjMhE6pQbVxzi5Q9hZUFvCk+WQBMOqxe8SHZNIZfTpITJBidgFqjmbYFg8b0CD2ah/iZJu2ieQ+Ini4n7+2QdxuCxSmHE2v80pwpRqQEz0MTr9KLPwGXgCD06kxCi5mMkOgXIg7hV2bvLuMj2SQWz3xOtTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(316002)(66556008)(31696002)(86362001)(4326008)(8936002)(8676002)(66946007)(66476007)(44832011)(478600001)(6486002)(41300700001)(36756003)(7416002)(5660300002)(2906002)(38100700002)(2616005)(26005)(6506007)(6666004)(53546011)(82960400001)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Umo2QklGeHVDK0dDalE5OE1TTkJPMG5NbHBLL0wxd2JzL1EzVG5aNWtnTyty?=
 =?utf-8?B?TXRsWnZMbHdPaUFoTGw0U3FXUXVsakJCb2hXQTdUU3FUZ1Y0ZGFvVndiZ2Vx?=
 =?utf-8?B?L0pQUnRlV0FWcUdQejg0eXZLQVFJZWdHbzNucVpQR0txZGFyTEEvRHpFMWpx?=
 =?utf-8?B?TVVUYm9JYmlNQUtjWE5OK05xRVFEUENtRGRGeVdXcVcxRVg3YkxiUkNLNkEy?=
 =?utf-8?B?cE43dHhvcjlTVzRWMkkyQWhjRGk2RWhhL0R1MU9oRlpwOG5mYjNJRWFFQlI0?=
 =?utf-8?B?NGwwZmpvRVErL05CeUNSMyszbDc5ZGk2eTR6Z29OTUEyN0VhNENuYWNJVUtZ?=
 =?utf-8?B?eThrQ0ZPNzZwNEx3UUM3blUzbDlyZHUrY1JKaER6NFZzekRuMG5zdGtPTmow?=
 =?utf-8?B?SWY2dEhYUi9MRThncmhTTHpnRVIyUjZTZG9WenIwc0N6eHlhcjZQWFN6ZWIr?=
 =?utf-8?B?bE9yTU9mRkRQWXZkRmt1a0RNd1llZWRBdThoSU5kTHkyWGozdW5DY2t6Zytm?=
 =?utf-8?B?bXBoMURQSHVsQTQwd1lpeVhlUVpTOTU0YUd2N3ltQk9oRVRBUHJVb2dPSW9l?=
 =?utf-8?B?ZEVkZVlZdTN0N1pONVFuMmgvOTArNC9HUEU0Q3hEMVNzUTlsdVF0NmlHUGNH?=
 =?utf-8?B?eWRoNnpyemcvc3N0emxZZkpyeVZwbDJxK04vVURCMWVxY3NMa09jU01ZYWdk?=
 =?utf-8?B?TlA2NUZackdLYjZBT2VyOENvdVJMZzUxYXhFTnc1T0xXcG1uaUtnR3RhOEdh?=
 =?utf-8?B?emd6U3djM3VFbXVjR0RPVm5qVHdPcVJsZHVpQkxTOG5UMG9zQm5LZVNBSmU4?=
 =?utf-8?B?MnNhUVFkTkZsQWNjSXJndlZhRkNneldTQUJwMXNzWXRXdE1COW5FbEVPUnpQ?=
 =?utf-8?B?YzdJWCtYTlVxUUQ1K3hRUDNlQmxTMVBWTk5xYlQyWDJOMURFOGRmK0ljeVNW?=
 =?utf-8?B?RHpCekR3L1pQNWJzdVVIV1V2V1JSbXlSaTNHZHlTaklYaDZmWmxLNkF5SG9C?=
 =?utf-8?B?YWM5YVFTc01ZbGcyZUU2NWQvaThpTWdGWGVrRkFIZVFINmJFejZ0MnM1QTZw?=
 =?utf-8?B?bW96djZXNFRiVWQzRGhkWlNWYld4MGFIeVpKZjBab0kyMXdQMlRoZzBpL2p6?=
 =?utf-8?B?ZUJnQUV0ZGdnZnR3RGFWK2wvQ2hrY3V2U3M4OUV4b2xSaHo1cTZVNi81MVVq?=
 =?utf-8?B?Mnl5OWoxT1VVNjZRYkFqbjZSNWF3MG5ReU44aURNeFdtb3ZEUDUycm43RUcv?=
 =?utf-8?B?ajNQSC9LWkhuaEY0VnpYRFM5L2psK2JXaTE2cm1zOFJRUHhnSUdzVmt1MFZF?=
 =?utf-8?B?N001enoxSnhzOTdMWXRwZDdTbG1jelJzcnNFZ3ZrVTlGVzNpbDZldGJIRlA2?=
 =?utf-8?B?RFoySE1VK0hQWmZNWkt5ZXgvSHRzbnlFR2ZRMThHV3d3QU5VVkc4bmJjYnpE?=
 =?utf-8?B?ejJlN3BmbVlTN3JqazFZYmV3a0R2ckI5cFN4RWg1cnhMU2I0QjU0dFdyMGcx?=
 =?utf-8?B?cWhOUFhXbjdpMk9yRHJzem9OeFlhbmMyc3R6bnJCeFBreEpwUWNXNGNrNUZU?=
 =?utf-8?B?WjVtWFRaVkpjSUJTM05SNTNMcDJLbWlFZktySGl5elJzbngyWWpZMWdZamNY?=
 =?utf-8?B?QjhQZ3hQTzVwVnd3UjdSZFQ5NFowVzUzVEg1aXgvZXJPOUxDQnQ1N0ZQSmtF?=
 =?utf-8?B?Uk5UMXhJV0VBdjQ0bUFHTGpBSVl2NmwvR0krM1A3ZTVvTFJFMG5kN0ZJR05p?=
 =?utf-8?B?MnlWQm04K1FPay93RUdYSGVTRWZuY1JnN1Y2ZWhMVUt1QVBVYTJ4SjBIZ210?=
 =?utf-8?B?Yzl3OEZKQ2JKdVV1ZVY0Yjk4YXZHMmQyTUFKVEl2c0FnYUpRVjAyYXY0a2Zv?=
 =?utf-8?B?OTZneHFtNTBWeGdwUVZ4NFN3QlZKekptNEIvSzk0aWZMbnAvVXJoTWhnRlJG?=
 =?utf-8?B?aGlUK0llbVovSEhoUGFoZlpiaUtOZ0YyMTFaL0lZNWdMaG52MEJvNm1IMTV1?=
 =?utf-8?B?R1Q2K1hqTnBmTU4vZnduRzRLSndYK0h1YzQxcmxON2c3cHljR2NkR2twRXhK?=
 =?utf-8?B?Mk5YYWhtNWxUcFh4RUFWZXlnckhhVGZUaWFFL1FZN2ppZGlOcXFCUmM1RjI0?=
 =?utf-8?B?bmZyOGRZcDBINXp3V295N3MycXRtcDhOY0tQMFhKcDlsSDlPeG92bEJmZlVs?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c8e81f-09a5-4598-36eb-08dbf4b2951c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 10:20:04.8721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65sScq61ZGdgLefgjCsGGS8FcUyXk6GuWLj0wZzW76bo6SJzqbFDwPw/fVWtktHBvMvZW3h8TMmVIY279YtkLtGknqTh+l8DUngCKL+FwLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6222
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.12.2023 02:10, Jijie Shao wrote:
> From: Yonglong Liu <liuyonglong@huawei.com>
> 
> If a xge port just connect with an optical module and no fiber,
> it may have a fake link up because there may be interference on
> the hardware. This patch adds an anti-shake to avoid the problem.
> And the time of anti-shake is base on tests.
> 
> Fixes: b917078c1c10 ("net: hns: Add ACPI support to check SFP present")
> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
> index 928d934cb21a..c3abb14edd51 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
> @@ -66,6 +66,27 @@ static enum mac_mode hns_get_enet_interface(const struct hns_mac_cb *mac_cb)
>  	}
>  }
>  
> +static void hns_mac_link_anti_shake(struct mac_driver *mac_ctrl_drv,
> +				    u32 *link_status)
> +{

It would be cleaner to return the link status than using output arg IMO

> +#define HNS_MAC_LINK_WAIT_TIME 5
> +#define HNS_MAC_LINK_WAIT_CNT 40
> +
> +	int i;
> +
> +	if (!mac_ctrl_drv->get_link_status) {
> +		*link_status = 0;
> +		return;
> +	}
> +
> +	for (i = 0; i < HNS_MAC_LINK_WAIT_CNT; i++) {
> +		msleep(HNS_MAC_LINK_WAIT_TIME);
> +		mac_ctrl_drv->get_link_status(mac_ctrl_drv, link_status);
> +		if (!*link_status)
> +			break;
> +	}
> +}
> +
>  void hns_mac_get_link_status(struct hns_mac_cb *mac_cb, u32 *link_status)
>  {
>  	struct mac_driver *mac_ctrl_drv;
> @@ -83,6 +104,14 @@ void hns_mac_get_link_status(struct hns_mac_cb *mac_cb, u32 *link_status)
>  							       &sfp_prsnt);
>  		if (!ret)
>  			*link_status = *link_status && sfp_prsnt;
> +
> +		/* for FIBER port, it may have a fake link up.
> +		 * when the link status changes from down to up, we need to do
> +		 * anti-shake. the anti-shake time is base on tests.
> +		 * only FIBER port need to do this.
> +		 */
> +		if (*link_status && !mac_cb->link)
> +			hns_mac_link_anti_shake(mac_ctrl_drv, link_status);
>  	}
>  
>  	mac_cb->link = *link_status;
