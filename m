Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D11D7F17AE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjKTPnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjKTPnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:43:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0109F;
        Mon, 20 Nov 2023 07:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700495027; x=1732031027;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XGhnO8smNp0othB3wvkbpbkTKAtJjU10Fm9acBLsyRc=;
  b=LgQFV4H6UtW7OLr2puIOkIEyWHMLkXv8OhJD6K+vd7MFoQNUq/x65+fg
   L2EglWH2gnysS3Rf6Ya+tvM2b9DhuSBBIzcSfMvJ7DWc6+Snm/d3MpD56
   eXQS4ZiBTPFTV77IANbtLlBKVyTI2Aq/jG8Jf7HjFHall310O+7tCrnDX
   EchkWFu625eDODiGOSD0Ijfj4nL6zeD4ikbF/msYXXKcJg0fiIyINlWiL
   tOPShsPS275oNI4IJY2Wh89RNkYUlfZ+YEAng193UZbfIu2TeAk7yeM9s
   PVjHXJRaD+XRBL1/bvecpioloDwr5o9vLrkynanWA3MpGEnt7aMqP77VU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="388780576"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="388780576"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 07:43:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="889963249"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="889963249"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 07:43:46 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 07:43:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 07:43:44 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 07:43:44 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 07:43:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtkapK93YnrTxrFd/qtkWcBsA9UwhHtK2OwkYoBMXRUKGI27I6LhXV1y9VnfGS3mhaIVLTfti935nio335pZpoNkVcwRFYiBnppiQIDtd0O5W4oe7LicV9kfUFNwRX2tzkwaxyIX3GOcHrp9Y6XOHPHsRROq/5ymjt5ZQQAThOXPN9C5QGCjDNAiRA7hNn4+Lr0qwtRFtkWauJaP+eibp9AM4Wyx1IElmjUUMdJKr9/eElwnat1GT4hIpOHwgEC9HoLXU32ATumjSlMe3A+B5rKbkNqchpl6F/ZLjzUnFMX0LpK0fRXICicboWy/8j+nzQMv5pCto8e3YH+gZls4Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BM8B2uQeNG3umbx07zrlOWQSrWxTZahNYOqnoZaEjCg=;
 b=OdVbI7KlYaZei9Vut9vMYE/CY2THyZsjjwrZYZUkowvB4FprT7u6ZZ5qWodr4nMUUVLw88nlzRKAklZJi0sV/ngzCO4ru093PCRYnjERm8HaPro0wtR2onQRZWdwc+9fUD9CV2N1eyD2ZekSjUHXCxbtHGmDa0V4Ieq/8zTuk9OqopS/MYvLXaaMeXUCioJRwYYlOlygCPNbKVGN7zXERccNUgkKV4HO8FPJC5vidSJXrgGa26Xl9kfq7MhHNOOW2F8DSwCBzj/+p14Wxc3jKreEqeZ9XgI9zMFXDh2JoWjclAg/w0y/bfui5gg74l7kzSU4K5Gqmg6XshqGhcbmJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA1PR11MB6942.namprd11.prod.outlook.com (2603:10b6:806:2bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 20 Nov
 2023 15:43:42 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 15:43:42 +0000
Message-ID: <962fa507-b9f5-4646-8090-cf63f737e84f@intel.com>
Date:   Mon, 20 Nov 2023 08:43:39 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 2/2] cxl/cdat: Fix header sum value in CDAT checksum
To:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Fan Ni <nifan.cxl@gmail.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231117-fix-cdat-cs-v1-0-ffc2b116ca6c@intel.com>
 <20231117-fix-cdat-cs-v1-2-ffc2b116ca6c@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231117-fix-cdat-cs-v1-2-ffc2b116ca6c@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::11) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA1PR11MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 50db605c-b104-47da-50e5-08dbe9df7948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZZsRE2QaM6hNJ/wV9VCcX4Fiu0UOhCWlefpgYxutHEmZM5IxdQ+xn48MakW5d2xOBgHLcBHNituvKGBr/+ZGUsFXUbFcHB6tsN0HZDQPwT1Alm5dWIdXJDA3yjNSSZ1ccbrjOad88rlV1RtQ3CcmvHBrWRWYsouHIlTBbzqta+EgRPhuCtr25d+vvpuf4dAL93Aohb0yySHM7QT0XSSDeCMqgy2AmrNug+ftOlPdRXm4UvsiJNwJnfmMIhsa43P5j7ROhmWL365y4Sf/vroqn7IDdHYgmSG0ac0XX/ArSbHqbym29FMS+xbkPOSBGIC2TyvzPnPJy6iTXTIGA8K/VGFA91BiqY9x26VOPUl2S5jN32eyzww6//otgGYnuhZHR6f/1J3Q2cUxdvouv/uHmwTqxLPuyRHWiLg1/BJKjLoQjatLZtrmwd/NrfTI73vDhdCUjNRDbEVOx4QT0SEwoRRXM9sc158TNjsz2xzXeOXLVqqlvWY7fn04xSoPkcKF1sJBqWqpnuvsJTyKY93xX1VYExqwpQ/4WhLM9ZepV0x8W9lyVHlJOmk+UYps74s32B2YqDO1yPKT1MAXR7HViCbeHBoVKbOXZEA1H3y9Hbo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(396003)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2616005)(2906002)(6512007)(26005)(8676002)(478600001)(6486002)(966005)(31696002)(8936002)(36756003)(66556008)(86362001)(41300700001)(5660300002)(66946007)(316002)(44832011)(66476007)(110136005)(82960400001)(4326008)(6666004)(31686004)(53546011)(6506007)(38100700002)(83380400001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2h1ZTVURkU3RzJmUXZlanAxcFVLSjIzMUo5alcvZVpzSVlacjMxdTlWNnZv?=
 =?utf-8?B?VS9DUG5oZUQzNmxPWXJMTDZhUngwQWkxWWM4M1FmSnFJM1dGQmQ3K1l6ekRa?=
 =?utf-8?B?Z1d6MjFkdEt2TDAzL0JTR1BDcmo4bmdaRlpyV0dlRXlSb3lWVXYvZjhuUUI0?=
 =?utf-8?B?eHpTKzgraUpDclF5YkhXVmU3WFJNbk13YS85M1Y3d0s0cy81Z1ZaQ0FPNUtt?=
 =?utf-8?B?enZ3UEw1OU9kVDBwRUtJVXQrUkhYams0ODYwM01iUTl4SHpvbVRWZXlFRTFE?=
 =?utf-8?B?Q2ZsdnFWZTFqV2g0clFWczFUMUdwdUhiNFdCZ3RuME11K3FGU2JmWmtKNHFn?=
 =?utf-8?B?WkY5QVd2c3dWcXh5NEVSTlNPQXc5UHpFN1o0M3pldE5raFJZUTNrS1pZSHM3?=
 =?utf-8?B?aHJ0VWRVZkVKb1BQVEEzblR5TlFqMHRsOTVwcWxOMW1MSVVvU1p0VmN6MEZL?=
 =?utf-8?B?WUVHOXZ4YXo5M014OEZGUlg3UGJiR2JTdGxKZ0R5NUFWTnlCUHhPYW5yLzZB?=
 =?utf-8?B?ZEQxakFHaW5BamdpMlhVZVNmSHNsQUMzcU1VOUQ1OTQ4VFlsSXpSZFh0NDRz?=
 =?utf-8?B?eFpSNGg1Wm4zU2RyUThuUlBTMkwxUy8yWVg5cmNjWjZhQ0RNTExQOEE1K055?=
 =?utf-8?B?RTVMU1RiakZxSndFS3BNbHI1aVZ2WjFwdFBzdDM3dkRqSVN0cUxZa05QOVRt?=
 =?utf-8?B?blpoQlkxWTlFWUtUS2cwbFByT0s4SlFXek13a0RyYk9vc2RHSXgxWE5Nc2Ni?=
 =?utf-8?B?cjZZK3dRejBtUVZCNUM3YXYzbWx4RUwra1UyTnJPWEw0cFdBQkZzeHB0Wlll?=
 =?utf-8?B?TWhDOEVRRmpJS3dIaFFyTlZNampsSWFTSTloeGYwaWhZWkhmbGQrUnVZZ3Fh?=
 =?utf-8?B?bHp2d2FRazV6YnhKRVgyMXd1WGZDaFdYNDlpNGdyRkVMRHMyNUF4K0JjNGZy?=
 =?utf-8?B?VFBzUzNZOHFIOHBUL0Y1MGgrSzdleklmMndTUWYzRUFtQmhKSDV3TXJyRTFm?=
 =?utf-8?B?TUpqcUZiaDNPRE9ma0h4RjFLREVSeUxNV3hjOEFwRHl5ZjVvL2h1aXVVeEhI?=
 =?utf-8?B?VlV1dk5POG51MVlIcjNtZ1dtcE5jVlBoalhNVy9RZ2haZTFlYk54M1hIOUJN?=
 =?utf-8?B?Y2NaTWhoTXRBMjFSdVdvMWEvWUthdUhMVFpIWnB3T3dETmk5dE5xcHdlUk9h?=
 =?utf-8?B?RnE2QnZRb2NqUHpLcXlkTFBqUVNGaUFGWlJpcFdaS2g4bzdBN29EUkVPNm9P?=
 =?utf-8?B?STU0Q2ttVm5rdEJQOEpVdHZ4VlQvdGQyRm1mU0loYjlTM2N2bU5TTTF0WlQy?=
 =?utf-8?B?RXhXTmpKelBmUk9NZTBpVlE0NUVFcUluekpOczE4WmpmR1QvbkFTdW9WRkxG?=
 =?utf-8?B?SGNoTG1FaHc4ejU3VXhUZHN0cUJObmdZQXVNK3pmZGlwVnl2NjlJT1M2Vm90?=
 =?utf-8?B?eTZPYWVGWVpXaGhCalFFWFJOdmdBakNIMThHOGhIVFMzSVlUaCs3b0RkSjFZ?=
 =?utf-8?B?RW9MZmkwc1czVy95YUN5TjNHV2VOeERHdHdqdkZMTmFTMkQwZ1dvQ0dkY3Ft?=
 =?utf-8?B?eHE2YytIbmduRG5jMExyMjI5alNyVEpTMG9qY1NBNzdxNEJxZDFSZlE4TXE3?=
 =?utf-8?B?SHMydmoydnZKZUE3RzdYajVHQ0JxMXFuaExoSUgxczRzM1RucHpmWEhOMXF0?=
 =?utf-8?B?TjFaREZjejVlUnRJZi96U2NtVm9hQ3VrQ0N2LytxaGhoNVBUNHBkUzY1OGRl?=
 =?utf-8?B?cmtqQmx5UXFYUDhYbExjUjdEVmE0ZzRVOTBRQXJKQVJuNVplbnNqUXBnR3F0?=
 =?utf-8?B?SzE2a2dFSVJNS1dZeWo5Q2VXdXdlakYrMEl3NGFKV0pWUGJZVTh5TlZ0c0Z0?=
 =?utf-8?B?VG1QdXFwcC9MN2o1bGVlY1d6T3lpQ3FISngzdXdWanNVWjI4OXVWMmEyVkxJ?=
 =?utf-8?B?TXRuWVNaYmFQUmZxNFMwV0NROEdnaXNQT00vVUwyMFJkb3VzT0diNlhUazk4?=
 =?utf-8?B?Mk43c0g2dTk5anVKVWw3dDQ5YTRDRy9pb0d0b3VIMkY1M1gwdGoxaW80ajdR?=
 =?utf-8?B?Rk5qMzd6Q0RkVDY5RHpVUnlpMVNoOWM2SFNhMGVvZ0VUK0hPeTNZMUdWeWVV?=
 =?utf-8?Q?xpsjcm5F97Ouc6btUwVXo66le?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50db605c-b104-47da-50e5-08dbe9df7948
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 15:43:42.6976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyGwbCv54farJV+Ka7zYcRTwbeqfL2X6JtXeHOvyZT1eqwpotIUo2MrlVE0rPITqbrMwzwPqHCHGMNJDmpGFHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6942
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



On 11/17/23 18:14, Ira Weiny wrote:
> The addition of the DCD support for CXL type-3 devices extended the CDAT
> table large enough that the checksum being returned was incorrect.[1]
> 
> This was because the checksum value was using the header length field
> rather than each of the 4 bytes of the length field.  This was
> previously not seen because the length of the CDAT data was less than
> 256 thus resulting in an equivalent checksum value.
> 
> Properly calculate the checksum for the CDAT header.
> 
> [1] https://lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  hw/cxl/cxl-cdat.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
> index 24829cf2428d..d93e2e4e64f2 100644
> --- a/hw/cxl/cxl-cdat.c
> +++ b/hw/cxl/cxl-cdat.c
> @@ -95,8 +95,15 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
>      /* For now, no runtime updates */
>      cdat_header->sequence = 0;
>      cdat_header->length += sizeof(CDATTableHeader);
> -    sum += cdat_header->revision + cdat_header->sequence +
> -        cdat_header->length;
> +
> +    do {
> +        uint8_t *buf = (uint8_t *)cdat_header;
> +
> +        for (i = 0; i < sizeof(*cdat_header); i++) {
> +            sum += buf[i];
> +        }
> +    } while (0);

Why the empty do/while loop?

> +
>      /* Sum of all bytes including checksum must be 0 */
>      cdat_header->checksum = ~sum + 1;
>  
> 
