Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023E17E1DCE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjKFKCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjKFKCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:02:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F0E107;
        Mon,  6 Nov 2023 02:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699264958; x=1730800958;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mWIb4f5Zvysu3nVAs7cSGhxCzsxWXtR6VjuFT7D6gzo=;
  b=Y634wtUDnWE9TJRn4AYj9mt8DyV4Vj2nRfjzKF5Ga3rx9pcQdFI/X7l0
   Xm6SlmzRnRIuipmA8CFK4EPO85ktOUNv+BslAfx1D06CvOJpqME5g206x
   y1+u/NHczK4KJpMYqNhAH2NRw3ZVUT3pLxP83ZhlEZEYtwKWl0UsCwSfj
   +GVXKYXWcf+sWubWBLM4ULXfnN757aXsWf2yqtRcGeC+DpF52MuMdshaX
   qPw+rXFFm1kkUCico/UoTQEvHUAry37oa7EyAbo9N3KE8dAITuPkbtzho
   TwyJJvWOiKzON+0JmAjYwz4dJ9y/WJ2IUrGwzXIQwua3nWMJ1EPzOCrgt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="7876889"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="7876889"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 02:02:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="10050669"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 02:02:36 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 02:02:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 02:02:35 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 02:02:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muL9yiXJMZ2ZDhg4gUhJ4guA0PQvPgnYgcOIWHUSvnGV44zgY6Ltemk55Blf78tMf+ZpLCCbEnpM8bbPMjO5sMECJB+Rg/N8djgAsiuRi1qhLyz6fKL8HlksZTr3LQn8d4rOryLym73/GUCIKKTx+OCUJnhHmaIQOI4o7z/TojbQd7pliDF1qKHTakCVy1il4zdvpdzA2UVbyKGBuKg9+Pb0B3dvDgFpeMMngjyEPy5QrHgb9X+6H+92TPmwTpPbdx3fJ/SJM3Zwqz7JdKoIsIXMOXbhYLGlgiQpr79jyuWXMyYJDPlQoc0mLiwk8zYihlDodKelW27Zrn0e38CMcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4ugjMdxhnqf+nmfNO2ZCHR7XfuZ+9bSawqJS6zacbk=;
 b=biNTUjfF6mrLbqkpQPKhqeqnO4j7z+ChVXLs73Fg7KkfYjKRFO4mdUz4+Pl7QdRp7C+JSeJddItlc0fcZJDgdxWTSMG9DncKGpnn+zsNkqqSP2WNhsTz1DQqvSkewSKGpbr//RAWvtUBXKJ0t1G1mho6qU9HK3hJGqb2KSIzbZ6iL41eap4JCeKcZOa5WKviPcBZ5a63pVPXYQjjp+AWszLcj6QG5XoUdA3QPz4zC8CAhx0EzXfZ/irCCuU9u9M+z/O+skBcWU8uPDBwGJpIbBslEDVIqEjp9xqgrTsEE0nDE3xsBVszDzx/wpMUMkpzkP1diQUJv5e91ztxLv8VCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by MW6PR11MB8440.namprd11.prod.outlook.com (2603:10b6:303:242::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 10:02:33 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::1b1e:8472:f24b:6693]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::1b1e:8472:f24b:6693%3]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 10:02:33 +0000
Message-ID: <83b0921a-5718-4dbf-b9bd-5662e47e3807@intel.com>
Date:   Mon, 6 Nov 2023 11:02:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bcmasp: Use common error handling code in
 bcmasp_probe()
Content-Language: en-US
To:     Markus Elfring <Markus.Elfring@web.de>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Justin Chen" <justin.chen@broadcom.com>,
        Paolo Abeni <pabeni@redhat.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <netdev@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
CC:     <cocci@inria.fr>, LKML <linux-kernel@vger.kernel.org>
References: <0b2972cb-03b2-40c7-a728-6ebe2512637f@web.de>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <0b2972cb-03b2-40c7-a728-6ebe2512637f@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::15) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|MW6PR11MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a1aead-76d8-42a4-1a26-08dbdeaf7ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7q2Us5E8x0WB29Zu4jMIiiR55aoxTSPA81twL93uQtsDfdN3J/LfgkK5pKKn8XYEybwoLxULGVUhUWRijVphvvPxAa/AL6LSueyPNmZD0udhbR+2FiKd2qxYf6w3nkF2/TA5SgBOpV3FWfD10Dat4SCb2wFXhLqcFlmsb4iQsTTdOFe1n7Ryt1Eb6gMlZniHgag5lQuWIn54lbpbOpMTYATX3268CFah4RMPceG36Hc+7tXxcfR+PmT0dqkrwV+Tijy3yFeI6xWnp5/sVwvyXVaVSm0pr3aasMlb1m0ZdKbZpiXUGHfhYw4y+/j15vLqK/Q5sM8Um0NrWKfoGGhqssV6AbsY5YmllodnD8suPQe532vvdvGS7M54B2e6KHDkDP9koE3yYOZ/v6LoTZ/q7WhJDg7hizTU93Rw69xRiv0NQd37pqRsVrPkSdLm0qUwMK+asYIsKO2bkxbIvsDir1hZNqcSO3piP0I9K5vOHYJk0Iikq/CHDPeW5rHyg38rNxrw3/KipPbWryj70ikbWu0KOe0/zQ6fHK8PizrBJJjFh8R07Tm/kfA2YJ61xgMu0OudDkkCZZleywsRpQIfoUsLJtvtKEyfG73Z0rswo9gucb1Q5TFfiO79EaUrx0wT4rqcPX4Yqg0k0Ttme6Yqrt+abZv4kFa7z1BvmJpA5ek=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(41300700001)(7416002)(44832011)(6506007)(53546011)(2616005)(6486002)(6512007)(6666004)(316002)(83380400001)(8936002)(8676002)(4326008)(5660300002)(26005)(110136005)(66476007)(66556008)(66946007)(38100700002)(2906002)(31686004)(31696002)(86362001)(82960400001)(921008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHovTXI0d1NnSDNhYUtGRzZRM2xKWVkza0hZZlhVQ0c2ZXhDZFE2SW9vVlNH?=
 =?utf-8?B?Ny9ESmdwWFhUZCtnb2pRMDdvZi9HNHBBVVJVMGJWUkJLK0x3OEswY1ltcXJi?=
 =?utf-8?B?eDFkRmFOSDhYZzBWMTRHeFhMd3lQMmxzamdsS0VrYng3ZXF3NVd5ekx1NXBi?=
 =?utf-8?B?cE11NU9NMUphNWF4Kzg0UnU5SG1INC8wcElkL3RZRlRCdHNHRTNUSkhDTmNQ?=
 =?utf-8?B?OExucVp6S2JQMjdyTDh1dGVxRXFKcUtuODNVYXQ5U3NtOGpUZllEeXBBVVcw?=
 =?utf-8?B?QWdWRThPUDE2R01oWUo1OWNyVW5CRURBWmtONC82WTNHcU9xTkRkbkpSVVVT?=
 =?utf-8?B?VDEzYlIwMUJEcTExVlo3Um01cTVsZGEraEgyVDFFMGdkNUVHUkpOMFRGUnE5?=
 =?utf-8?B?TzNhenBwNXM3YXJpVmJ5SUZzM3l4T2hVSEg4WEV2d2l4bVZtdzArRHR3UkF2?=
 =?utf-8?B?ajJQVmtDVnZqZHRNMkhVZzZxckxQZENVMnE4dFd5bXpEemw5Y3pvQnJobXFW?=
 =?utf-8?B?MHdVUUtpTWFXZDAvZ1B6VXRhQ0U2NWEwcWZLeC8ySGkxbzB5enFzbWFEcGxn?=
 =?utf-8?B?ejA5WEtQUG41UEZLN3RrOFZwY202NU5RanUwU3BSazNnR0JzZHBiRkVGQnd6?=
 =?utf-8?B?MkdNaEpiZFdiZmtqb21RNzh2YU1XN2tXTm9vVGM3T0w0a3VqR1hCcXhMaGR4?=
 =?utf-8?B?OVhhVjdKaFRwc09QaGZWMXg5djYyYTQ4Zko3K0VONkhOck9Ob2pSdHNzdGEy?=
 =?utf-8?B?enplSitQbmU4M3IrWDZPL2dtNGNXZlhXejlBclVzZ2VSN01JRFYxUExsb3Nk?=
 =?utf-8?B?VGFXQVJpTmpYUE4zd2xydnVURFFIdEEwYllHK1pmMk9ZeDlDME9lSTdwc2xS?=
 =?utf-8?B?L0Mzem5RTUgreFkyeUs1V3ROZU5idm9wSGVpMW4xNHNOZUh0dmwweWFkVmZE?=
 =?utf-8?B?MVNQMkVYRkF2a2h0L01jRml6bGpSZnZpRXgvWlI3UmRibVhUK2MvTGZBV0VN?=
 =?utf-8?B?OEt4bXBVZ1ZpUHk1MFdmQzZEYnh4VmFUcjJPYVR6S1EyTDdHTkxtRmRGa1RW?=
 =?utf-8?B?MVprdDcrK1ZyNXBQTlZhN2ZoTlZPZ3dkYjRBVmlrRXJqbE9zSHlBeUNTRml0?=
 =?utf-8?B?eWxmbWZlNVRuRS9Tc0ZkSzRVOXQxaFloSjQwdWlxb1NTQ0g3VGZTMFdPTHFW?=
 =?utf-8?B?a0I3Um01RmlwWU9hd0VjRk5tbFR6blZ3aGU1aEROOTg0a0dwSHo1RUs3bWQz?=
 =?utf-8?B?NDA1bjBjaS9ZQTV4dVdzdFdzWVoyWHJwSVdiaWE4WHJ4REs5M0d6RmpHZ1Yy?=
 =?utf-8?B?OVhEYmlQczcxMG9EZ0pSZ0xNUmJWL2tCUncrUXdpRCt5NzlOcDA3bDFkNzBw?=
 =?utf-8?B?TmJ3STF1MFZqbVJ3T3dadzA3bUNjbUFvbnMzL281U1kwNkJNbnc0TGhSRk1F?=
 =?utf-8?B?NE4xMXM4bHBuQmkveVJXcnlYQUdjOWRSUHplNUtvR05xUHIrajlqSGxPenZR?=
 =?utf-8?B?N3A3YjFmT0xub2M0bG5IS1c0OVJ3L1lwTmRUcDNVVkNXQVdnM3lDdEhEelRH?=
 =?utf-8?B?a1BpQjlvamNaZG1nd3Q1Ti9tWmRkRTRTSndZUGVTV243NlFHYkhkd1ZaQ0My?=
 =?utf-8?B?SjU1UkY5RmZtNWs1MHBSdVhmUlVNMFhEQ1hZaTY4dTJWZVhCSmRBdEJvR0pM?=
 =?utf-8?B?Rk92ck4zcEcrWDk4b01DSzZOekJlTkhNdDZvZC9BclpKQ3lOdW5pMXc2K3Uz?=
 =?utf-8?B?cTZUdG1iTDhtdEhpSnlJMzRzZXYvc0FKME4vVytNR3UxU01CekNFU0NuVDNq?=
 =?utf-8?B?Y2tlS0NLNFNOQjU1RngyTzdvY0tDSlZrQ2cvR2F2QzdBMlNTRnBIaUEzSFlT?=
 =?utf-8?B?ZldnSlo4UUc4TGZLRzVHTlRTTncxNVpoWE9McjNyNXRIT1ltNXlBSzJqYmhr?=
 =?utf-8?B?K1dtTmpwc3JOMWVnV3dDSXUwSmdMVVdtVlJsZTNzYklpdGw4SEhsSUppTW1J?=
 =?utf-8?B?RFVsTks5YkwzZVBtUmtsRVNiWjdTMTFpS1BPSFg5TmVtZTJOQloxTGdmNGRT?=
 =?utf-8?B?UjU2ZktmY0dxdkFBZ2M4WmxmbnUvaThEemZhTnN5U2FaZTVMeWYra1JRTita?=
 =?utf-8?B?TWJZYnZnUkVKRTVDZUFMRnNNV0NJSURhT1Z3WjRySVJOaVA1M25RK0hLNEhY?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a1aead-76d8-42a4-1a26-08dbdeaf7ec6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 10:02:33.3688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5e4UEej3Q46/+U+ZuvnadzJcSDHP9Go2S1ghuC+/eWs4Lcz2B+lS/QeOm+2Fu9KR3vJYQk29LlDRixLyZyAEQGtHDt/T9E02Z8NC0w8Fq78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8440
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



On 05.11.2023 17:33, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 5 Nov 2023 17:24:01 +0100
> 
> Add a jump target so that a bit of exception handling can be better
> reused at the end of this function.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> index 29b04a274d07..675437e44b94 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> @@ -1304,9 +1304,8 @@ static int bcmasp_probe(struct platform_device *pdev)
>  		intf = bcmasp_interface_create(priv, intf_node, i);
>  		if (!intf) {
>  			dev_err(dev, "Cannot create eth interface %d\n", i);
> -			bcmasp_remove_intfs(priv);
>  			of_node_put(intf_node);
> -			goto of_put_exit;
> +			goto remove_intfs;
>  		}
>  		list_add_tail(&intf->list, &priv->intfs);
>  		i++;
> @@ -1331,8 +1330,7 @@ static int bcmasp_probe(struct platform_device *pdev)
>  			netdev_err(intf->ndev,
>  				   "failed to register net_device: %d\n", ret);
>  			priv->destroy_wol(priv);
> -			bcmasp_remove_intfs(priv);
> -			goto of_put_exit;
> +			goto remove_intfs;
>  		}
>  		count++;
>  	}
> @@ -1342,6 +1340,10 @@ static int bcmasp_probe(struct platform_device *pdev)
>  of_put_exit:
>  	of_node_put(ports_node);
>  	return ret;
> +
> +remove_intfs:
> +	bcmasp_remove_intfs(priv);
> +	goto of_put_exit;

Why is it at the end of the function? Just move it above of_put_exit and it will naturally 
go to the of_node_put call. No need for "goto of_put_exit".

>  }
> 
>  static void bcmasp_remove(struct platform_device *pdev)
> --
> 2.42.0
> 
> 
