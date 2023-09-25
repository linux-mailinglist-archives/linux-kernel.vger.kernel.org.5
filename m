Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA42E7ADD8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjIYRF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYRF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:05:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FD295;
        Mon, 25 Sep 2023 10:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695661550; x=1727197550;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tixi9Jsk2Ji/tUQY+wpZLkrnoAC9Lsc/k9tKRoWBZBw=;
  b=KMj37WMcbO6Gj1JO6Hc2sOjtzHS+RmqODc3sneRZoLeLE8rAn3kXU72q
   FioiqWA1g8rnqz3Ss5V4722VoQt4GinbM5LkUOquJooy1iJF/GXZSiQMf
   VRZv1T6pkTSWqe7cG4obVbgCfj1OKtdvfC8IKevLfAhMetMa3XBuuGda6
   39vYDTDHBjHLIHEFD0Mmn6FzxWNXlPDXwDlCyJmTNo7xtXoMMjVuE8NE2
   WjPEpClgHiN091nzZUhxGkJqfQtEp4L4fhlprx/cJvRdRDyhhXgB5/lhh
   8xpXKrcKNzWOC8sullNSLhK2RzxDZN1yJeJ8DpcJeh7exMNoxzoBT6phu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445415139"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="445415139"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 10:05:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="863989502"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="863989502"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 10:05:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 10:05:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 10:05:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 10:05:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gtd7s/vJZ2DFbfPNA4lHJEcyaF29AS7PwzxZud4/EiV11G/R1cy/V8Pon5yEnFxES67fxhAUzN37ZSLNU+HFPVXycrfv7ZNN1dwK73PzoBGYMJg7Z99sEuOfUY1QOGvZ5ijKL/gml95pOfxCiU46WBjIVUFTqzTFu9K5blSd7X9Ps6MVdV5lBhJIskfbvq3lNYEio07inoqgKUCRNK5ccCbJ6FF+Dxsx22lkzwzMt1xP8fSxsWyeSlRRZwxcoWdlTmeK9/pNb+WhtwEicr6BKfm6JKJzVCmJ+YjfLc7R7k8UBKE/s6PFq74QtXWOgHEVBLUIQ+zFvyIa0zXl6JoHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuIqRrDRJjo4PIMlgJfhp+racRXy2Vmz0AUFCZuER9k=;
 b=bbpH/H/raOGNaEF7nbPjUbwBpYyv+7WVbIRNLxFmYuT7I97Nb6TYeFk8xIez1N2T0217QQHHCJDqi07Zr+gFEJgBSVUJtiKhEKWE1+fH/BTBuUIms6n/bQ+1xs8a5SZSWKpF3rDWIq7EpHdcAGiGVP3P+1WRPvT2H+LlEmhS9RY7Lvy3S3t2iZ2skNKrM9oomipZ+4RZG7tQdEQe2eWInw9+XBIue0k6f08xGtOrSdrj0PjM8cbJS6JKQoq9kfX/qi0WLfh9XF4mfvkOdgh3+9CdIyS1vbVZKyShG5MHAxA5mM/cOJhArRU76YUmuF0ovA1/TKUoqTa6Lv3YkO6s2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by IA1PR11MB8152.namprd11.prod.outlook.com (2603:10b6:208:446::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Mon, 25 Sep
 2023 17:05:08 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::ed7a:2765:f0ce:35cf]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::ed7a:2765:f0ce:35cf%5]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 17:05:08 +0000
Message-ID: <1430f3d3-4e84-b0ec-acd9-8a51db178f73@intel.com>
Date:   Mon, 25 Sep 2023 10:05:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] idpf: fix building without IPv4
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        "Lobakin, Alexandr" <alexandr.lobakin@intel.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        Alan Brady <alan.brady@intel.com>,
        "Sridhar Samudrala" <sridhar.samudrala@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Phani Burra <phani.r.burra@intel.com>,
        Joshua Hay <joshua.a.hay@intel.com>,
        Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
        Madhu Chittim <madhu.chittim@intel.com>,
        <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230925155858.651425-1-arnd@kernel.org>
From:   Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20230925155858.651425-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:303:8c::8) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|IA1PR11MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a43968-b55a-4e82-da98-08dbbde99254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNJR/ZLaGjS808z/6iuIzvtookqeEt1IMaCFB3jLUWdVvWMyQ1V99/IMP175t4dnkaozOKtT9hcB6yDrh/lVEYWSMsEYvap75kVglRIvwAWkMi7NE5bo44LowJbfRCpas9WaWE1N/U8Vwdywzmob2MCRCMEaoEORmAT/Ha7Eq1OkPruWJ+YNvRDu9JR75/CJoqimEY3fEgNA8/6e1HSMMaF8/jD6FLM0W85XFhNE2ujcUDHlSjMU29FnvIgGGu7N2ppMtLoWoXChXaf7hOtS4LdRO5KG6xovxyPQBdmRNpAxlwAPv78BIn9qua1ZQYo3Gelz7e5Ufg1WGi5o5w7x1VNSQ6HftEvAZ/u+U7WQtW+HDPjvoZXSiRFWf+/9q3DnAF4T26hJLoYUzf8hpNdHIf8TS3HWglIS+XfF6tMVQvR0mHH1MHhHmCdmKwx+j+VGGuTZdULJvn25fBz3NfdN0MVxR0QMfQTlqGorqWR7/4gERELXH8LgGx3V+/VmgVJwKSkCgiNGLPXyYTitTBEiPgFlEstl8Ol8VDG7AAL6f5wl6Fz5mSv7E3PmcHgMEq8gYqhrS3YFPJxRnLFw513Ta8NLfVI6/ZpdFUO8UEoxzU1Yz04Sk3m8oieaFUuI9O4tX0vzuMUewfVmxteKl3Xy7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(86362001)(6636002)(6512007)(6506007)(316002)(53546011)(38100700002)(66946007)(110136005)(2616005)(478600001)(26005)(6666004)(966005)(66476007)(66556008)(8936002)(82960400001)(8676002)(2906002)(4326008)(5660300002)(36756003)(41300700001)(31696002)(54906003)(6486002)(7416002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0NSRHpzZTJ6ekZBUEUxZWdIUXA2alhtUFlCTXp4bmxERkdEOEZGdUx1OHpC?=
 =?utf-8?B?aEFUNWR3MmNqWmtxdkp3ekFwczYvY2NVZ2ROL0pzVnZMbFYzalRFZEE3czI2?=
 =?utf-8?B?MFh2U1ZnWkYzT0ZpTitxM1RDVGI2NkZUN0VnbUtJMXRBNE4yT25GSXUvZW1q?=
 =?utf-8?B?Sm9OR2s0VXExYU52VFUvQStGWCtqK2xTcVorVnlrcTlmVGFHcWoyRHdPeFdV?=
 =?utf-8?B?a0pBU1VkT1g4WGE4NGcxK25JLzZETlNNRmRHdS9BWU9qcHJkN09rQ0wxMTkv?=
 =?utf-8?B?K1gvMWhncU1LUkNZVGJvWkpOUmptTm9lL1pnWVJOVnN1Y2FweFdkaDZuVGNx?=
 =?utf-8?B?RXhWYnJXdVU3U0FHbitZcDZ4cUZkODJwRlN1dlZYcVN4RkZJcDZMdjIxSHdU?=
 =?utf-8?B?QndUVmF3djB1ajBTdEhBK25pQ2RkMlpCTFZza2d2ZGF6anliNEV2cVpyMjJH?=
 =?utf-8?B?ejg1SFVqMEdWK0F6Rms5RXBKTmI4Z3JhTnVHd0NBSzdGeGtxdEYwOGp6QWpQ?=
 =?utf-8?B?blVQVERWOS9abFJITWlXaWFxQlo1VjFvTTRyeFR3YmdBNFNVY0xYZXU1N3Jy?=
 =?utf-8?B?MnpHVk5DY0RZRVprWU1qZTF6NFRzVGt1ckd4a1VPeGtNZm02aGVjU09LdVl5?=
 =?utf-8?B?UGVRVkVCRlFqVU5IREwxcFYwdGhkZSt6Mnp0bEg5U3ltOUg4b25PTG5FZ0Rx?=
 =?utf-8?B?NEVpa2t2b0RNdko4RGFxbkRsUjArNjU4cU81bkJ1VnlUMmpyMytyQUpkV0Ey?=
 =?utf-8?B?Z0p6cFB4ZU00N2Nobm12cW1wN3Z3MEJoK3Yvbk9zbTNiL3VmTFAwYzdjZnRt?=
 =?utf-8?B?T1Ztc2JBUHlqczYvTk83UkRVb0pqam9oZXhyMmNZOHhBMkZZVG4xK3A4NWE4?=
 =?utf-8?B?QXBvcDdFanZuOEtzOU0zbGhGQUZQS2hQNi9lMERhbFQ5Y1ExbHhJWVlWOFFq?=
 =?utf-8?B?RmE0cUp3aVBRS09JcTI1MitYTnc2cUJoMmJZZWIyK3ZCYXRpeUovRlpzUGl0?=
 =?utf-8?B?cjFBdjgzVHBNaHZBY2xjUW9lVWx2RUhmazc3Sk9uWHNlWForOHZISUhtMXFJ?=
 =?utf-8?B?QU5WbkljVU4xVHMxempRdkRZd3NyRlFqbzgrQTJTcEE4dFBRTGZ0U052SlJl?=
 =?utf-8?B?ZFNBT1FmSjM2L2U1T0ZKU0Nua21waTJ0anRzMS9jNzJUVjJqZlh3bkFQVHZC?=
 =?utf-8?B?b2VoV2RXL0lsMFh1K29FMk50eVVpZWE4emdVd3V1Um1INzRPUUFKUVdrcjc5?=
 =?utf-8?B?SEo3RERDUjFrNnRTWnh0U2Q5cXBsRENlRXpQWWdkOGJEZ1huNXkxeGdIbFpE?=
 =?utf-8?B?a2RoSW1wWHZROUlqdSsxLzFxM1NtVnhVY2d6ZjFhNFpKWUV1QlBBeWtFVUF4?=
 =?utf-8?B?WHF4UEZwVG5rdkszeVVFSE9vM3N4Qy9pN1RtM2lNWENxY1J1dnRHTXZqRURu?=
 =?utf-8?B?bUNXakR1M0hYczIrV3N1ZWluaFhVaTV5ODQySkMraFNwd0FiVmlkZHBLRWNt?=
 =?utf-8?B?SG5QRkd6cHZmRm1IdlpFZEtGdDlEY2lYMjRvb2JXSUZtTE44bE51SktkNlI1?=
 =?utf-8?B?aDd6ZGpSUjlzcDlzWTBaMEZyQzVoWFpObHBnbVdrT2Q2RHFWdDByN2tHT0tz?=
 =?utf-8?B?QTQ1SHNDc3ZvSFhWcnBxbHh6am85VmpRUjBUbElwZEJXRHAwWCtZMU9qSkxB?=
 =?utf-8?B?S0F6LzJaVEU1UFQxUGozMzIzM2FEQWhxQUpmRU1yaEZDSTd6RGxna3lYL2xv?=
 =?utf-8?B?MGlWdzZrcjFpMFlBcGRXRDJ1N2NkSTNYOG02WEU3dzdwMklyS1g5M2lVZ29G?=
 =?utf-8?B?OXhsRExMUHFMbmxTQW1sdDRkREhNSkloTUtMSkd1Q1EwOVhIcE9HbFZBUlpK?=
 =?utf-8?B?TnpnR1BYQUNNa25DZGJyR2NlWnBZMlNiOE10MEtwZ2t3MVZGYUU0RnVxbmFK?=
 =?utf-8?B?UnN5SzlocS9TYnBnY3JQbWs2MndSVTVrTkFQdUdWSUdqcUE0eE4vZU16Sy9x?=
 =?utf-8?B?dzBFeGhyTE91aThaWmtmMnZNVk5oVVlwbDlpb2tjcUEwNkdFVjNEanRKVmJo?=
 =?utf-8?B?dE1HRmhaV1pPbHpSVjZoaWdHUjMrdGNNc2o5OEJObGMvRlBpdG0rd0JRTS9a?=
 =?utf-8?B?RHVwdzVhYTNqdVhWSHBaRi9Bd3BzYjVMbW80WWpjb3diUHhPUHFaYmpaTnJJ?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a43968-b55a-4e82-da98-08dbbde99254
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 17:05:08.5358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ueF12Kg73/jBYjuvUcv9xsTGiCcDDEMHn3+cuOecrbUiANs00vt9kAkzxc11cU0Pvo4ZYqXVqfY44G2Q14g664HR9aQJUGg1k8CZ5HY89o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8152
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/25/2023 8:58 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added offload code fails to link when IPv4 networking is disabled:
> 
> arm-linux-gnueabi-ld: drivers/net/ethernet/intel/idpf/idpf_txrx.o: in function `idpf_vport_splitq_napi_poll':
> idpf_txrx.c:(.text+0x7a20): undefined reference to `tcp_gro_complete'
> 
> Add complile-time checks for both CONFIG_INET (ipv4) and CONFIG_IPV6
> in order to drop the corresponding code when the features are unavailable.
> This should also help produce slightly better output for IPv4-only
> kernel builds, if anyone still uses those.

Hi Arnd,

Also, a pending patch for this [1], however, this does look a bit more 
efficient. Adding Olek as he's author on the other patch.

netdev maintainers,

If this is the version that does get picked up, did you want to take it 
directly to close out the compile issues?

Acked-by: Tony Nguyen <anthony.l.nguyen@intel.com>

> Fixes: 3a8845af66edb ("idpf: add RX splitq napi poll support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 6fa79898c42c5..140c1ad3e0679 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -2770,8 +2770,10 @@ static void idpf_rx_csum(struct idpf_queue *rxq, struct sk_buff *skb,
>   	if (!(csum_bits->l3l4p))
>   		return;
>   
> -	ipv4 = IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV4);
> -	ipv6 = IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV6);
> +	ipv4 = IS_ENABLED(CONFIG_INET) &&
> +	       IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV4);
> +	ipv6 = IS_ENABLED(CONFIG_IPV6) &&
> +	       IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV6);
>   
>   	if (ipv4 && (csum_bits->ipe || csum_bits->eipe))
>   		goto checksum_fail;
> @@ -2870,8 +2872,10 @@ static int idpf_rx_rsc(struct idpf_queue *rxq, struct sk_buff *skb,
>   	if (unlikely(!rsc_seg_len))
>   		return -EINVAL;
>   
> -	ipv4 = IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV4);
> -	ipv6 = IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV6);
> +	ipv4 = IS_ENABLED(CONFIG_INET) &&
> +	       IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV4);
> +	ipv6 = IS_ENABLED(CONFIG_IPV6) &&
> +	       IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV6);
>   
>   	if (unlikely(!(ipv4 ^ ipv6)))
>   		return -EINVAL;

[1] 
https://lore.kernel.org/netdev/20230921125936.1621191-1-aleksander.lobakin@intel.com/
