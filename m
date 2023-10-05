Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61F27BA12D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239624AbjJEOry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbjJEOo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:44:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6BB9D1B8;
        Thu,  5 Oct 2023 07:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696515725; x=1728051725;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c+zcE+0FYqOlw6R76ocftH1Fx5gcwsiDbDH7Pm4m8A8=;
  b=TNYbRCV0zdQMDd0CtdW0wBojc75diFZA9YAviA8SiCwn5YdRhO7BoDg3
   97lpb0MrXje8Jli70GTS6aDTr6FAQRsEY3GCv9Bi3K/pCWNqD6Ysgt/gg
   uxXHXJflWtHlDYYSGK227Keu/lQ2+MuYaF+hep0MoU07s8bTqrwroyEak
   1gwcqS1DKD6hSHwd3VwxrApO3UIw4zsfhws8JBguktvPw+hLhV6q5yN9E
   c44tJo1GP5QfZY5gPIvU4VRblIvVPgNuX83icNjzolzXUFnvD4vOgh9W3
   ZjyLzyP0LJaWSf4nmMbF2HENpFXbFn86+ecZAB8cjBkGu4AsHBeHmJ2hB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="363780369"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="363780369"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 06:33:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="867904166"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="867904166"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 06:33:18 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 06:33:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 06:33:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 06:33:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dK0LDFsKtU4tdK79SyqZGxtLZIxVz3S5Vfzer78KdJ/2/FjLyy++oqh2MPsF/waXoNjraYg9Kvqz/tYNd2i2XEFVvwn47VPQY/bOOwZJV8VHcadAIIMOy46b2Zu8LFVbR2gUAqmFpUuh2kun5txJAsZVu7TES8RApAsfsXTTjrWvt1qBE4hL44Wdmtrt7eelaOMaQvZuXxtKTVLxA6Cym7igQaaB8x0ggQUZYUUefp1QM4Vi6LJ1XOSvgylij+/f1mKACi16VlCe3BZvZjv36VmznA70WnGWdK2KxQPBRWvPkkjSrD6jm/bt/nEVv7C2d4Ll0MDTEW+RS9Zw0lZ3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PRN057hkPN889N7yOZyD9RsOZB7YzLHCGfQ6ktrBu8=;
 b=E97a7Ej3n7ZfDG4JsycY1RFsOFSo1mCBNREFqMWThC0ayzW6/zw4myK6VWyo5LiWLKWbP6MqxxKDDmmc2pVDqQABk0D3KHVB3p6LmB3id6maoDsx4nZ/gdfT6UhOaeJc0VxDTkFbGw7i7FuLzmZTJIeVEHP4RlYslbbuKi4G4MZfRj6ggJDDg8oJSgmyDd/SCyDq7iYTEY0q9MIGugrY0Zwsxa1rFRO1xNnN+riWtlju6LtfIXG4FH3xZxyIxi7uOxGmSnXHuYLjkD0Yhy/BUM0ELSbViHkJM5qOJpGqc3WBLBeHlp97KI4AP1JZQX/a41QEsudXxVuqW/FJ0nGUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SA2PR11MB5036.namprd11.prod.outlook.com (2603:10b6:806:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Thu, 5 Oct
 2023 13:33:16 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6838.028; Thu, 5 Oct 2023
 13:33:16 +0000
Message-ID: <75435ec6-f205-1ae1-94ba-9c41fd82a045@intel.com>
Date:   Thu, 5 Oct 2023 15:33:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net v2] devlink: Hold devlink lock on health reporter dump
 get
To:     Moshe Shemesh <moshe@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>
CC:     Jiri Pirko <jiri@nvidia.com>, <linux-kernel@vger.kernel.org>
References: <1696510216-189379-1-git-send-email-moshe@nvidia.com>
Content-Language: en-US
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <1696510216-189379-1-git-send-email-moshe@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::7) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SA2PR11MB5036:EE_
X-MS-Office365-Filtering-Correlation-Id: 9214c2ca-0291-455f-4c5d-08dbc5a7a16f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zPA96K3yIyiLgfph8siVEWcpX7a/TWN0M4D68rGaZJ12DRlr9Gac7XAxE0/5L8cFVp4pqLsvmUXXeyaEmy6QGmsZjcgdMim675/Va1BV0vJ3M3iZnXM7mHIOgqjJJy2cjZmZMqOuhj8/B/yVq20zcukFNxBFzY/IPvTVtPZrsFWsPhvwhxOEh513JFaMGZ93C5HesR2lO/jXiSKymLTon7/vHlcIhvd0t/McNvS5OARZLig4FIVf0rAQU2G1pCH0PAAQMkApSaFtjaON5IWkKBRn4bBO3mkGPmGdKHH3OuAYd0v2k5dXeramZFRjiS529R1NPhS4Z9IIwD7szaHB3D0w759wLPlGNfKEIZg9irGGRRqlZOnwlcifSBXb1SuxZyavtGhayy+tbfYAr4L8/f1iOUvZG65ukqNWcjc+Xlr6+qMv6+GBfUolWuUzRaHXR5NjX0Jn9yHGKWuv+WSl5UBu8xU1yfnM2yWsQkzEc+XM8z4+FHy8ergr44PH15YdzekPgZx1p5eLDhVqQJJzoPMV8Vy7YrYPhSHPDbsjp9J35PHE/IlSTfFO7QaWpXRIrIt22JFv+5oEcFlextUMTD5DGMCJRVWa/EVrZCDPG4USJL5YVHjI4Dlt6VQ2co8y3kK3H8zVl9RZ4SW3GHVqAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6512007)(53546011)(110136005)(86362001)(66946007)(66476007)(66556008)(36756003)(4326008)(2906002)(26005)(41300700001)(38100700002)(8936002)(8676002)(5660300002)(82960400001)(31696002)(316002)(83380400001)(2616005)(31686004)(6486002)(6506007)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzRmL1lwS2NqQTZUbzdHUVFQQUI2WE8ydVNrVG9BaTFiM0I1UHA2MGxKTytp?=
 =?utf-8?B?Um5QNnNIZWZoRDFPdXlwNnpRMXhlb3NDUnNOemhndU9BVFF4VmdzOEloZWpK?=
 =?utf-8?B?U0N5NkJMMW5lMFMvcFc2Rlp3YVRra1BPQTU0QnhxaEpVazJyMkNBS3R0UkQ4?=
 =?utf-8?B?SVl0N1A2SXpjQ29jYUJKUkN1S3JsUndCdTJDcy9pQXJMblNqV0pWVlJIS1hl?=
 =?utf-8?B?am1xd095ekRZZ2Y3NUtWSHh2eElsYnFLN2gzTEpQdTNWaU5QN0ZPZkFrQkNG?=
 =?utf-8?B?cTRPOFd4K2RqM1BOb2tBbnBCN1hReFE1SnFucCsxL3U4R2dBZWMwYmRtRGxn?=
 =?utf-8?B?NFgvYW9JZkFEeUNOUDg0WDdOM1BqemxkVzdxZWFTT1BhUlJ6azFoVmZZRGZj?=
 =?utf-8?B?KzA0QWZBWmw3SHk3d3R2MDJNSFg3RXRLUXpWYmZyMVgyclp6eWYzRnl5UWRT?=
 =?utf-8?B?WS8xRUpIU0x1SVc0R09LamxxVWViYlhUdWE5QzdoRXo4R0lmV3F5OW5nZWhn?=
 =?utf-8?B?WmJ4a2k4QkpkbkswOC9qNlFPdm9JcUF2a0QxZUk4c2VqdlZMVWloSGhMRW8y?=
 =?utf-8?B?cUlCWHdqYnNTQjhJOW0zYzdlY3dlbzFlV2puQXNLY2EzSkNqNjNmbWhLRGQx?=
 =?utf-8?B?Qjh1ck9xaG9EdHU4Qm9BcHMxOWYrYVFSQjBFUEM5T2dqbXlrbjc3SEV1ZXJ5?=
 =?utf-8?B?T3BsTGZWVFpGcXl2U0QyOHNOUEdtRURTQzEzSFhMK3lLVTE5eE5qRjBZQ09i?=
 =?utf-8?B?M2YxdEs0SzZMZkJldytib1VXYU1CN3poVUc5SCtLcmVVOGhhSW9GdWt1a2k3?=
 =?utf-8?B?ZXBZaWNqQ21wWjA1TlA4SVR6U1JEb3krQzNNNCtLUXVadGNIc29lSkFjeWZ3?=
 =?utf-8?B?ZEdlVkVjQTc5YnlSbm81R0NSaFA3cEpkU241OUtDNWc3U01GelJzYzVZN2I1?=
 =?utf-8?B?SXhrVWJkZEYydG1FeENhSFJGVjA5MlZHRG9MZ0pjbDRKMHp3dm9RaHJNZU90?=
 =?utf-8?B?a1ozSy9MNEhxWE9jc1BqeXE1d2ZPOEg3N0kwMWdRcE9tbVFPNEFoUEdWY1Uy?=
 =?utf-8?B?VDFrYTZadnl4ZXdCRWlqaWxLSXlTSnkwL0RlQm54NmFlWFNCNlN2c0RJckF6?=
 =?utf-8?B?Qm5uYXp0ZzNUSnEvcW1JRmhwWlBibmE0OFBHK1d4NEcvbjdEWE9sK2ZOczBy?=
 =?utf-8?B?dk9TRDd5RCtWVnhPdklTRFdOTlZIRlBkVjVkNFpqZWE0YnFaSjlzWEFUZUtN?=
 =?utf-8?B?ZW5hbXZpc1QwaUF4K1JqMmVxSlA4MldocndVZTY0YTRYL29wOEMxcFBwTWk0?=
 =?utf-8?B?T2VmWVJYNzNHamZyK09uMGpMUGhtVjM1d2ZCdkxmRGtXTjRQUGNuMXJNSVpX?=
 =?utf-8?B?RkpXS1dUdjJRMklMSXlremJtdytoR3Z6OHhLZ05PVy8wSjdnS0xsQzNWQTlr?=
 =?utf-8?B?c1BUd1ZFRmYxOFlnQUhGa0NXYjZIWUNXWE92emxPK3RqYlJsbkR6N3RETTNj?=
 =?utf-8?B?ekxRaExadzdKd3hFTFNYMTM5a0NKZ3d4c2hmMElGbnNQcTVYVkRUeS8wckwy?=
 =?utf-8?B?eXJveGQ5NzVyRktwaUhDY01Iem55N0RYUC9zVTBCVmtDdm1pbWt1K3lnVzRw?=
 =?utf-8?B?U21zbnAxbzJNS3ZSU0xsT3JRNFVGVUY1TW9XMTB1eklGeHE5bHVFNHZWbDkw?=
 =?utf-8?B?dWpNekR0NXRqK2g5TGs3YWM0WElpVXRxRjV2N1YyY2Vyb1VyVzU1c3NjQUFs?=
 =?utf-8?B?SnBRWDkxZnpOMkkxUWdQeitCOERNYy8rQ1cvSGtsN25HRThsdkdDbzQ1NlZv?=
 =?utf-8?B?TnczUXd5YjlieG9wKytaOEkvaUpOV1l4Yld5WTlkWUN6dUVuSklRQzRmQmp6?=
 =?utf-8?B?NTNkQmt4Um5peXRrQVhXNjlBWUVtQ2MrZG5FV0duQ2YrMzVMa3FNdExKaEwv?=
 =?utf-8?B?OGlqc1VweWpHSStTenNLcnl4cWU1VVdQQ1FVcEw1UHRJQTE2TDFobTh1NXBw?=
 =?utf-8?B?SkRxQkl5d2w2RThuaHlBTEdMUkJuOTh4SFZXRnIrOFZTSTVNY3k2bHpvUzdj?=
 =?utf-8?B?Z2MzYUYxUHhjMC96ZXBscS9CVkV6UEl3Y2NBOE5DZXJwWVdQUEkrNE9ZSFFh?=
 =?utf-8?B?WkJRWHZrV0dPVXJSU1BNRWZTWnUySzNGaEgvbkpQcUw3QWpsdHMzYW5yZFA3?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9214c2ca-0291-455f-4c5d-08dbc5a7a16f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 13:33:16.4537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjM/7o1lHxh696Qel4BCAiTSauAZDiwKsbtXFN+a5SBd1tZz4bZY4489QrSPAUy3CmnXjZHkjPjUym3ccB/bPRpDaPytOAMAeEsBPH9e71w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5036
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 14:50, Moshe Shemesh wrote:
> Devlink health dump get callback should take devlink lock as any other
> devlink callback. Otherwise, since devlink_mutex was removed, this
> callback is not protected from a race of the reporter being destroyed
> while handling the callback.
> 
> Add devlink lock to the callback and to any call for
> devlink_health_do_dump(). This should be safe as non of the drivers dump
> callback implementation takes devlink lock.
> 
> As devlink lock is added to any callback of dump, the reporter dump_lock
> is now redundant and can be removed.
> 
> Fixes: d3efc2a6a6d8 ("net: devlink: remove devlink_mutex")
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v1->v2:
> - Commit message, added why this fix is necessary and why its safe to do.
> ---
>   net/devlink/health.c | 30 ++++++++++++++++--------------
>   1 file changed, 16 insertions(+), 14 deletions(-)
> 

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>


