Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DA97CC1DE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343571AbjJQLf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjJQLfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:35:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC689F;
        Tue, 17 Oct 2023 04:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697542523; x=1729078523;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=medNMmmFZi1s9uj24TdnjzUDx1DZyVQbs3vKbCZdsd4=;
  b=fj6CaGfZP3Hz7ZzLFhV0rmL2fnKeexOgZkaiEFTwNCClbIwTg0B4HJPG
   R9Fgbf2ZJoHvPlkO9fQRBFXgUjgTeUq/69KgGSPNJsLsQsNuFnrg+r4lk
   /hZa60BIq1rfAtEfOg5P8rI07VB7rS2lIvO/pmglteuuWFJQPgsCA6u5n
   RfbtZ/KRDyD+oVwD7SbjeBQfZBqGeMtZKLEs2zdGKuRYWcWXKSDApp0LK
   PoBZTA/qi4zipF9Myvmb6//UCarH6tLJI4f+tAwh3fVMnIv2oJ+Zhfmie
   2UmIu2PZY+yAaQxBqp5fY9pz8OrnXdmRtia6qAs5axMNNVLrQ/+qbwv9/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="449979547"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="449979547"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 04:35:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="929762573"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="929762573"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 04:35:22 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 04:35:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 04:35:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 04:35:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Om1N2M/v86da6SGENCWBNRn9usZcrD5eGkWIIs6INHrcK+XlhF+Mvt3zum52XGZnJkWSVmoYFV6I4tzhZQ30O6dFMZlPn9z9M7yPlI2pKictP+FAp8FCdeblfCVM+joww0TrTMYJFgM5aPV5EsMfkbzaUkLCB/biHIgmx1EdJfmn6sR6SkZgfbaAytAbB94dpqyRlazFeMrbMSjsoPWt2+JI/OQzOamPRbILjYTpcyf98eWtVJ/ISCrg788tneBxYMshXeGt+0hrl9jtRsqjV4DtjHkaepLoTx+As/2DQstSkKwA/QxIx28xrJpOzUpJsL1J1pXmhGnJMYpjoZ5VJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szvQ/5UUX6Bz9vCGikj4j6ECdr2Gz9EpZAK+1Zlix+8=;
 b=KN2oqxe/p9jMg6dihUD7qyVX/L+lVUFtzpZ911Aej5RAHPrdHm3T1GQHSZoDxvX3YYBrMkE0l6Y7HSSppz29TIr8BbYZxSTdM9cZpEnGkRnS3/E0RIbPocCt94sEfs8dUj0TbVzq/GGxUlA5oxiz1kepAqBahs05xNiiOQWB0ydEnVbP47tyf2LvNgZwDHbU58ZwLOW6wftHXo34fUw3NQl7I+X8dW5wj+WadLcCsjdFzKqged+PnuZLezVVNDBmSFYKs/hLmFhJQRCAoHGUO612H4CwiCXCOFRo5imzqOoPf1qU9k3SPGzaZuCF14+KAfx7pJA4quF3ieFx817QwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by PH7PR11MB6606.namprd11.prod.outlook.com (2603:10b6:510:1b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Tue, 17 Oct
 2023 11:35:19 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 11:35:19 +0000
Message-ID: <9fcf96ac-e480-fa22-7357-04760ed1e47d@intel.com>
Date:   Tue, 17 Oct 2023 13:35:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next v2 03/11] pds_core: devlink health: use retained
 error fmsg API
Content-Language: en-US
To:     Jiri Pirko <jiri@resnulli.us>
CC:     <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        "George Cherian" <george.cherian@marvell.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        "Ariel Elior" <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        "Igor Russkikh" <irusskikh@marvell.com>,
        Coiby Xu <coiby.xu@gmail.com>,
        "Brett Creeley" <brett.creeley@amd.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        "Linu Cherian" <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Jerin Jacob" <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        "Subbaraya Sundeep" <sbhatta@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
 <20231017105341.415466-4-przemyslaw.kitszel@intel.com>
 <ZS5qztBDc3ebxypI@nanopsycho> <ZS5s7QE07YkO55O7@nanopsycho>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <ZS5s7QE07YkO55O7@nanopsycho>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::12) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|PH7PR11MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 757018d1-92cb-4ecd-8365-08dbcf052408
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dN7iYCiqiN1NEq6Dt38EB8dEaY89TLHbJzOiXoeSyTRINMKAHRJ+GNx4LBB4ON7fIUIzTPAiDlMTanpQQtPhXe+v9+ZrLVKFbAoLXEr8xXG2DunlJShmll1Zs//XiHuOPNTJKkytZZfzuM5MLyK+hIFrLPyTxeaR80afSHFZKh5o68tjfjWwkkqbXhw78jNxMBghDt+d5s6kfRu0aqQ24kwsq6W66Nfy+lyQOn6ZKErzdfM5ppSY9w1tGAtKJ6RrBHr+j6NrgFMH0Hj7Gk/QwLT29TTlYgvKEmilhGC2O1vbexZdbcXbr/C00Z7gWrjibOjx1+h2jPQbo7l8GF5/4bDNbcqXKO8dwKWEjl2IV3fURlSmVFMviqmXYWPvsNGp/ubKRBSJMKkfvlzkKd8ZOwT84NCXFyc7tLxsGJzhBrbRGBaYIIlFBgehSb9tVHzH8qeJpscoZgpRAqJoRl3gWeSxALEdMOHz0x64cq1SX9NwF7DTAvyXBV9cmHdK76ZA6lm/GZ+Z+RMlRHJ2O0Ld7/J/igrn4pRYZ+KqZZYoU9TujlRpMPb/nYzaHAj9g6pkxBL1L+560s/nQ0yhdpy0izJ294JaBGb0FHapvQ/WEjoPUn3c6D57ddDhdtfZKqKPAgBzxCXW35xaXN8SPbSog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(316002)(66556008)(66476007)(54906003)(6916009)(31686004)(4326008)(8936002)(66946007)(41300700001)(8676002)(5660300002)(82960400001)(7406005)(7416002)(6512007)(38100700002)(2906002)(2616005)(6486002)(26005)(478600001)(36756003)(6666004)(6506007)(83380400001)(53546011)(107886003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXByTW8xREJyVXhYdE5NQVhzclFlbE9haEovU085YlllWjQ1WkdFclpSWlJm?=
 =?utf-8?B?TFBNU3M5akgrcmp0OHF0WWNKaXhMcEYzbWE5SlFjNVZ1cW5GOGw3L3MxOUVP?=
 =?utf-8?B?NE1abHpDU045ajJWblRGd2VuSzhCeWh5Um0vQTY0Y2xCZ0dmbzlHSFp3Sjlw?=
 =?utf-8?B?MC9UR3NRZlFXejJFdUttL2t6ckhOd3Bwa0owZ2hVUEN2UkdzeDVwbzJzeGRk?=
 =?utf-8?B?a2p6K1E0Q29SNENvY2E2Y1pFZ0RWNkJKWngrS2xIRmxQV1FicVlKWmNuNWp6?=
 =?utf-8?B?OGZNZWtZVlg4NGZiamdlazR1NDBMSzJtM2F3TFdkV2RvOEFNd2FRdWg3TzdG?=
 =?utf-8?B?RFFsVENwT3RYYlFKbkpaQ05IaEk0QkFZbGhhYzNBNG5FbFZ6UkRrNHZjL3lC?=
 =?utf-8?B?MlpQWnd5TER3ZnhaMDRvaG8xSzZSU2NpTDJsdnE0S1dDQmVkWi9Nc2dicitN?=
 =?utf-8?B?bzFQV1p3NXFSWUQ4cTYyNFZNZjdSRjVQUmlrd21leHE1V1hIVDYxNUkzRk1K?=
 =?utf-8?B?eDVWLzF1ckZpUm1sbjZMTFZsSDFQdmx4b1d3SVV2M1dva2Mzd004Y09JMFV2?=
 =?utf-8?B?K2psSEYvUzVxS3BXTVBtWndoL1JSTmUrWENDKzVoRUYwVWVUY2pLdnVFSmF4?=
 =?utf-8?B?RVNndmdpd05UL1YzTlN1QTQyc2M2bUVXOWloeE14VVVPN2x6SzJTdk9wdWN1?=
 =?utf-8?B?TE9SMWNzZjRJN0NjOVJ2Ty9MSHBmelQwRWs2NVhteUsvbVN0a0IrZmZiOE5W?=
 =?utf-8?B?WDFpY2NzeTcvQkV2VTA5RTZLUHVKTFFLQ3VoUmJoN1FtNlozN29uVVJyYmdn?=
 =?utf-8?B?MDNhZVJjaHhHbnY2TzJXbWZCTVJMblBuN0pGZWJRSUtzaWNWd095eU9SLzNa?=
 =?utf-8?B?Z1JxaTU1VEpDZjRWdklDQTBjSWtBdUtaRmNVVGp4cWtOQW5CNVVoL1g2dysw?=
 =?utf-8?B?MWdGN0RWbkRabWwzQTdGRzcxUXM3VDVZMEIzY2VJTFRBVTMveVBRWHlXSmJG?=
 =?utf-8?B?WFF5Ty9PYW1BUVB6dWlmbFI1L3c5NExoRG5YL3Y1c2htSGx2ZmJXVVVuMEZi?=
 =?utf-8?B?UDM0YWg3Uk5MRGFlN0FVQ00vOUlzT0Vwc3J6NmZqQ0s3dE5KNzhGdlkyWVlM?=
 =?utf-8?B?T3dPM2U5Z0lWUGIwV1BMUlRWT0ZydGdIWXJwVTlYeFNzL0VoR1dsV3llaTFK?=
 =?utf-8?B?eW5kdXBRR1VXR0N3ZXBEQy85UkJvcTF0Y3BiclFuaHRIcXlRNG1mYlhid2lY?=
 =?utf-8?B?OFg0T0pONFdOb1N0ZGsyUHZnZG9Kd1ZYS1JVS09vdjF6M1puSWFuVlNtbEEw?=
 =?utf-8?B?ZGRsUXdmSlAxWk54a3IvQnBDQUFLUURHaGNrWTZVdHdjZ2orSk9jaWFiN2I4?=
 =?utf-8?B?bVJNM08yQkxLMHNBdUVXWEc0d0ZaL3hMb2t5UjNZMkp4dFNDWEVSemNVSVhD?=
 =?utf-8?B?dzFqL0s4eXdGUFNKSlNaeHNuWjNMNitnYkVFcEJoVmJydi9lUGR0M1Z3Qkpw?=
 =?utf-8?B?c1k2OGxzeElFY2NNRDh4ZXZoRm1uVUxPaFYvSzV4SjdUM3hhMGNmek8wRlc1?=
 =?utf-8?B?cGFTTUtUUW5oVWZWN2htN3MrSWFYQ2dUTmgwSjBtQ3ZZbDhPcHlHdmVhSTQr?=
 =?utf-8?B?MDdIRlcydkUrTW14dGQ4dXpFZXRVMnU3SDhYMzJWTmFvQlIzcitYTlFLWm1o?=
 =?utf-8?B?ejVEY3k4Y3BUWGxmb2VpaHMxM2tnajMxam1XbndMSFA0cTVWMGoxUHdwZy9Q?=
 =?utf-8?B?SENtcHZDcVE2d1RLV1N1WWk1Z2tONGJBOVRiWTlSWHc3Q3lkaTZBSXI4dEZT?=
 =?utf-8?B?dWlKWm1xSHp1R2tmUHhUa2hidTl6VGRuclQxQ3JvR043RGMwYXFROHZkYk94?=
 =?utf-8?B?ZStZQ3crV1FNa3R6MjdLUmNVSmg1UG00NysyU2dEODJsdzBOYVhZeXVGeEc3?=
 =?utf-8?B?aUpTeDQ1MmpzYnMraHhvcEp4VFpYaVc1NGtEbTA5YTlkN2NnVEV3MFQxaWZj?=
 =?utf-8?B?R3Y5dHlPWGVLOGR2SXorMHFBNXVjNXAwREJEcE1yU2ZQdXNxMHVBMFo0UTNj?=
 =?utf-8?B?cXZ5Q3BRclU0c3hEV3p5Y1NoMS9Edmx2M2VtcERjcWlRUnpVK0Q1N2ZCQTNz?=
 =?utf-8?B?NWFvUmc3dm1nZG5OVFZJNGVqc0lzbGRhYU5TQVRmVDJzVG41QXdteDBpRzY1?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 757018d1-92cb-4ecd-8365-08dbcf052408
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 11:35:19.1716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aB1SF6pp+5BpxZsiz7BTieCG1dAvQoVovJheJBpMfszF+zKKeTxiGdAqDA7P/aO05nGlWw6mqtpAJ+0jGVAYp1+Obucu8q5RLbAiSq8cG+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6606
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

On 10/17/23 13:15, Jiri Pirko wrote:
> Tue, Oct 17, 2023 at 01:06:54PM CEST, jiri@resnulli.us wrote:
>> Tue, Oct 17, 2023 at 12:53:33PM CEST, przemyslaw.kitszel@intel.com wrote:
>>> Drop unneeded error checking.
>>>
>>> devlink_fmsg_*() family of functions is now retaining errors,
>>> so there is no need to check for them after each call.
>>>
>>> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>> ---
>>> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-57 (-57)
>>> ---
>>> drivers/net/ethernet/amd/pds_core/devlink.c | 29 ++++++---------------
>>> 1 file changed, 8 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
>>> index d9607033bbf2..8b2b9e0d59f3 100644
>>> --- a/drivers/net/ethernet/amd/pds_core/devlink.c
>>> +++ b/drivers/net/ethernet/amd/pds_core/devlink.c
>>> @@ -154,33 +154,20 @@ int pdsc_fw_reporter_diagnose(struct devlink_health_reporter *reporter,
>>> 			      struct netlink_ext_ack *extack)
>>> {
>>> 	struct pdsc *pdsc = devlink_health_reporter_priv(reporter);
>>> -	int err;
>>>
>>> 	mutex_lock(&pdsc->config_lock);
>>> -
>>> 	if (test_bit(PDSC_S_FW_DEAD, &pdsc->state))
>>> -		err = devlink_fmsg_string_pair_put(fmsg, "Status", "dead");
>>> +		devlink_fmsg_string_pair_put(fmsg, "Status", "dead");
>>> 	else if (!pdsc_is_fw_good(pdsc))
>>> -		err = devlink_fmsg_string_pair_put(fmsg, "Status", "unhealthy");
>>> +		devlink_fmsg_string_pair_put(fmsg, "Status", "unhealthy");
>>> 	else
>>> -		err = devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
>>> -
>>> +		devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
>>> 	mutex_unlock(&pdsc->config_lock);
>>>
>>> -	if (err)
>>> -		return err;
>>> -
>>> -	err = devlink_fmsg_u32_pair_put(fmsg, "State",
>>> -					pdsc->fw_status &
>>> -						~PDS_CORE_FW_STS_F_GENERATION);
>>> -	if (err)
>>> -		return err;
>>> -
>>> -	err = devlink_fmsg_u32_pair_put(fmsg, "Generation",
>>> -					pdsc->fw_generation >> 4);
>>> -	if (err)
>>> -		return err;
>>> +	devlink_fmsg_u32_pair_put(fmsg, "State",
>>> +				  pdsc->fw_status & ~PDS_CORE_FW_STS_F_GENERATION);
>>> +	devlink_fmsg_u32_pair_put(fmsg, "Generation", pdsc->fw_generation >> 4);
>>> +	devlink_fmsg_u32_pair_put(fmsg, "Recoveries", pdsc->fw_recoveries);
>>>
>>> -	return devlink_fmsg_u32_pair_put(fmsg, "Recoveries",
>>> -					 pdsc->fw_recoveries);
>>> +	return 0;
>>
>> Could you please covert the function to return void? Please make sure
>> to do this in the rest of the patchset as well.
>>
>> Thanks!
> 
> Sorry, I messed up, this is a cb. Looks fine.

Thanks :)

I was also tempted to convert, but there are other possibilities of
error to report from callbacks :)
There are still some places in mlx5 that seems as possible candidates,
but this series is big enough to draw the line here.

> 
> pw-bot: under-review
> 
>>
>> pw-bot: cr
>>
>>
>>> }
>>> -- 
>>> 2.40.1
>>>

