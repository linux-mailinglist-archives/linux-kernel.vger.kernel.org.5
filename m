Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5F57CB6D7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjJPXDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjJPXDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:03:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D266795;
        Mon, 16 Oct 2023 16:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697497399; x=1729033399;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6KNJDMzfhi1Tpljz9ZKPR/SIDauzAfj5AlHqi0krMqk=;
  b=UM5Yz5FLneDrt8FgZD7jU/ya69ChTv9Qy8rIyuxKvJCQgEchJLfWywAI
   J72M1oG/FR6xAkXCCaXOHQUCwPPh2lcUcHraD3eQfVBUFF+YKZveSUCDQ
   yRnk8WXIHI2+dN6+WsVRuAdyZYRCYG0u7RONGGl99qa6QJaloC6Xk2h1j
   CnTsEQ+UUSVZJ886/x9ZbXwKsULfKMqLGsbxIrygmPSrJI5P0KthTFwln
   rlgVh0ossGCOgQNmQIjyv7mm0zOc9eoWkVWLz0IAKPsUTXYRLwOPT4CRG
   OTOAVdMSjx7Uma+J+CciJvVCyHkHldhlnEI1A1zL8W1JO5dBUL8Luuu05
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="471877644"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="471877644"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 16:03:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="749449163"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="749449163"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 16:03:18 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 16:03:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 16:03:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 16:03:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AClep56Gue3jSovStCRsjGWveXtjq6QgRY/iumikLAlfcNuHUwEJknKU1r4Kn4BrPkj3hQ5UpNRQ+vLVY70Nd95sgTNoM0uwbMVmXzOYGtvtlO5KNBzddVLk9EiORKmUnBids2iC4IoyZgWLUlAZHS2WXTzdhxTP9TNR01C/WPsIZ88bHenXpXyz8IUcr+HNOX0RM1q4VYfAN7WA/6wkhCfZDlt6b2nt6SLVGQT5Aq8SOW3v+9AWJ16YLfXlgoQXklo3Pk/KaN+yvAlq3vWuUbuwrwMlE6tq0RyY4KSAziUTbgGDWghSXgc6SvFpAEvHoF1zVXTw/+dPSzz5u6Rtug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbLzs7SgPALjSsC+KDXcLe2bAd34T0CPK3/pCgAJ0Gw=;
 b=nuEh2mDotcEkaxyOquHqm8VIK09OIU2C4Q7p8KWwvCgoA8RSDzWVj7ZPiHc2sJiLMoSbCs2GwIIjhGwgTIZGqPuBjHzWwasKD7taD85HghS5DyACX6Gl3PHUtILDIEp7iLMPi1cm+xIskf2OKsQw67ai7BKL3rNn7+2e6WmSe3TT+zsV7u/LdKR0t9d1AgmiQJ9WFwFSVdEpNcAIE32/63/yWUix4/pA3ACq4l0O+sQVMRXYsVejGOJ94QeORIk0teXeGMB2QsSHCKPuyPRmkXXV+yMdewGUi6R1M96KhaJ5R6CGIV8JwfikQhj1Ib58RYimIbmh/9GbnKgpYGyeDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6560.namprd11.prod.outlook.com (2603:10b6:806:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 23:03:16 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4%4]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 23:03:16 +0000
Message-ID: <bae82fe3-56da-49df-94b6-1e2998f86503@intel.com>
Date:   Mon, 16 Oct 2023 16:03:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 08/16] net: ethtool: Add a command to expose
 current time stamping layer
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>
CC:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        <UNGLinuxDriver@microchip.com>,
        "Broadcom internal kernel review list" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "Heiner Kallweit" <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
 <20231009155138.86458-9-kory.maincent@bootlin.com>
 <2fbde275-e60b-473d-8488-8f0aa637c294@broadcom.com>
 <20231010102343.3529e4a7@kmaincent-XPS-13-7390>
 <20231013090020.34e9f125@kernel.org>
 <6ef6418d-6e63-49bd-bcc1-cdc6eb0da2d5@lunn.ch>
 <20231016124134.6b271f07@kmaincent-XPS-13-7390>
 <20231016072204.1cb41eab@kernel.org>
 <20231016170027.42806cb7@kmaincent-XPS-13-7390>
 <20231016084346.10764b4a@kernel.org>
 <20231016182307.18c5dcf1@kmaincent-XPS-13-7390>
 <20231016100313.36d4eab9@kernel.org>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231016100313.36d4eab9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0148.namprd04.prod.outlook.com
 (2603:10b6:303:84::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 410052f6-12dd-4826-2701-08dbce9c14f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qd+zbg91vdI1HpupCk8CtJ530VbWr1ry4gLwspV9G8ueSQlE/cJ3z0z7oQ2MuvQNA2ejXWxt75c1JqKnzncgrDtSnw8Pi+WoGUBD4O0jfGh84Rh5SW5etqXNYy1U8uMdDdFtlWEgim4oCDcx376TWOqaGgjujvDXIEPaCeijAf8bi4J0tKeycrlmEkhXTd5ST0ITSXDA0z3IVdOEpFxfPVqmP1K3x4M/zFC33iZliNwoIzlf8nM+OEw0P940I4L56rOgNT+GP+LoHx40esuRQlTm8UqXx6XBOgaw3zHkkpHsVKNXNbUjj7oamBnVK8hUd/drfzTzjqlBC2T68SlhnBOHYxuXj30Sc6fP39FuxWGUAdQzcAKTqLoBJro37DszRXp7Q4AdQLG8e6jqBswpZL2WxrC8HP1qB+KPoDc7iO2e/pPWhBqRivEks+S1nPW37R/QKmqr7NTfzn5Oj3QqPnb42kvO6SM+XQiPd2Hx3otFcclT6i3WxMuQgGZyQzOPlo4SYpum+izK/8Q4CSJANoj7e2UgHNyCGCS4GHe3pzpDEmF2CgHQYQICflpOF8AcVAciGxdmNxof7PysTPB/NrJyFBvC5PRsjHhCVdArN0FgRlX2Q/81Zh2dN1U2a6mPwMuMQmGViufBebRP9Bhnug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(7416002)(31686004)(5660300002)(41300700001)(8936002)(8676002)(4326008)(66946007)(316002)(110136005)(478600001)(6486002)(966005)(6506007)(6666004)(66476007)(53546011)(36756003)(83380400001)(54906003)(66556008)(26005)(86362001)(31696002)(2616005)(82960400001)(38100700002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFExejNUaW1RbDZHVGpwR1pkVktYK0o2ZlVkcXhkRGk2U1ozZ25xRzhacUps?=
 =?utf-8?B?SzV3UkdOMzlERGxUZTRHbDl5WnhBelpObDdpQis2cHZGWlVqR2pOTUk5Tm9s?=
 =?utf-8?B?enhqWUFjR2ZOLzFQNWtKWElWbUV4WFd6ZlJINStZR0V6ZXArOUJmNlYxakJX?=
 =?utf-8?B?MzlxWjRpOGRrOXliNjRFTnBydHAxeHR3eWI0VWxGN2UxYkx4c1dIbzdObHVI?=
 =?utf-8?B?UTNWb0hLY054d0E5YnZ5Y2NhY1hCYXQ4bmVUWmZJdVJaakxKN2FhWWdXSTVu?=
 =?utf-8?B?dnNWZEJNVGw5a2d6R0JQeUUySUN3YjRpQ0dGcWpzR3Jab0lrWVYxbzg3R3ls?=
 =?utf-8?B?b3VLanNoLzc3NWJLK055UjZKNERxUnQ0RFd6UG52RktKdHl6R1FjWlZGUUt5?=
 =?utf-8?B?Z3dWQ2hoOFgxdEhyQUdERmM1Y3liZi90TVpEaS9Pc0QydGt0bHR4WkZ0OEg2?=
 =?utf-8?B?alhqbkVqNm5IT0JMd0xkWTZsQXVCZnRYT21NRkNVMzA1eWpMYTZrMmNFai96?=
 =?utf-8?B?bDZ3QnFZWUZyTUZQKzAwZENncDNVY3NmcWlLUm9tWjRMMmVOUG5oS0FtdFRN?=
 =?utf-8?B?aXUvMi9GTS9YS1JMaXhmcWhxR1JtaW16cDdua1VnWkhCYitkOGttK3dkdURw?=
 =?utf-8?B?UjJVOHIvdXlpY0xYeStjMVVDaXVSSE93UmJ1NDh3QzdndEdoVHUvQXRZWGxJ?=
 =?utf-8?B?MnVRUXBvYlAzenVqOHFyTm02U28yOE5jN0EwU1VGMHcvdFBGOGpicStnL0p2?=
 =?utf-8?B?NGlVcWRjbUR5am55cXB0RCtxOGhPNEpXVjRtVjlyVWRuY3RPa2RCeW1PcGpi?=
 =?utf-8?B?MStkNHdpTzU1NVUwN0JTN1RYSktyVmhHZmd3K3JuMHQzNC9jKzFMTzh6QTlL?=
 =?utf-8?B?d2pJOXBaSnh5dFhYOHJHVVFZZnpOc1p2cjNpYkJNUlVjek94Rk0vWWlqdU5p?=
 =?utf-8?B?czExcUNOY3VVcDNYSFZhckRzKzg0YUtaVi9SK01GdUYzVmo4UCs4VWNvVUZj?=
 =?utf-8?B?QW5QOEF4cHRubzlyRVlGNTFaTElidjlpZnpoUmRGM2t1bVAvWFVGcHU1NkxF?=
 =?utf-8?B?WlQ2U2Z3akpmUlp1cFJQV3JTNElzdXROVWJMeWtaQjRSVUdpYlN4aG9XYlFv?=
 =?utf-8?B?Y2EzWWxVUVpWNkhXdk9USnBDa292bC95MDArVkNBT2NNTHdrdkZQTnoyM2Ju?=
 =?utf-8?B?QWxNSUgyVEZZMDNrRUtickRIME1kZXF5a2ZSWHpGMDQxUW9ySUg0QisvWHI1?=
 =?utf-8?B?NUExZUVOdzFmSkhjeXJYSXc2YnZZeklUV01EVHgzUFJNd1pIUjBxWGZIZ3lR?=
 =?utf-8?B?Qm9qM2NFS3RCdUdMdWRzdTZVV1FaY2JjcEpaeHoxREN5ZWpsMHVvbDNpZFF0?=
 =?utf-8?B?cDZuUzMvQm9nczZieVJTQ0dJNmFEK04yUXJKRllOTWx3ekoyUjRyblRwTGQ0?=
 =?utf-8?B?MFBPdlNEZDBmSzE1Y24ycXVHV2tjVDl0aENCRGM1UWlqeDFjTlYyc1U4T0Fx?=
 =?utf-8?B?eFJYQzRHYS9OellGdnBLbC94dUYyTENaeEV4TktaSFIzWmliVDJSK3ZCUDZa?=
 =?utf-8?B?RmhMMmZKMUxGUm94M0ZhZFNPaG9UUEoxWXR1SEttZTdKYzcyOWFKem02eWRJ?=
 =?utf-8?B?c3VlaHMwbytOdEsyZWRxWWxDcThoL3hVdDlQYnFxbjdHS0NnWStPc0lpTVFp?=
 =?utf-8?B?L0xham5QWmhCZ0JuOHVVVllwcUlYZkNoQU84NkFYbGpEM3drQ2JDVGdhNzRE?=
 =?utf-8?B?bTQweVRtK0FTZ0I3S3drM3F2SFRWa1cyWUJNRnhBSDV1RUNOL2ZyamhlbXg2?=
 =?utf-8?B?dndIVkM2K2l2cVhKelJZMzcrTVYrYVRyUE1yNG9nV2Y0TXdzaU5CZ2VlYVFV?=
 =?utf-8?B?NFVPcnhkdjUzejN2OVM4RFZMMENFMW0vVWtERG93a0hsbUZ6RFJHY3VCeWc4?=
 =?utf-8?B?bTBYZEpyVmNkaklaeVR1V0p4K0V2MTY2WmhhQWlHenhqV3pOZ3JwdnM2WEIr?=
 =?utf-8?B?SzJFTTlZazVvSTNjMll0MHB6LzRiR2piRlhmRWo3VVpRbm42b1ZqdzBMZHUw?=
 =?utf-8?B?NHQ1QmlQeElGTzBIL2N3Z3JsYkYySUdEdlhvUUpEbndjbVlJZmZPbG1jTUhx?=
 =?utf-8?B?dXZ5eWVwZUEwU0NPdktObUlHanYwcVhjK1NUV2JTSkNIV1ZHbnFUL1ZOTDJI?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 410052f6-12dd-4826-2701-08dbce9c14f7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 23:03:16.5881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9E7X6zR+Yh0lqx0P671PrqnqzcN89ZOovFffCnIobYTlr/yJrqoHrNn8YmDzP3mKaQwkNKJCoTMJXHJwBMvbSoWNOxBnQN9TAsZGWDHTbT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6560
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



On 10/16/2023 10:03 AM, Jakub Kicinski wrote:
> On Mon, 16 Oct 2023 18:23:07 +0200 Köry Maincent wrote:
>>> What's the reason for timestamp precision differences?
>>> My understanding so far was the the differences come from:
>>>  1. different stamping device (i.e. separate "piece of silicon",
>>>     accessed over a different bus, with different PHC etc.)
>>>  2. different stamping point (MAC vs DMA)
>>>
>>> I don't think any "integrated" device would support stamps which
>>> differ under category 1.  
>>
>> It was a case reported by Maxime on v3:
>> https://lore.kernel.org/netdev/20230324112541.0b3dd38a@pc-7.home/ 
> 
> IMHO this talks about how clock control/disciplining works which
> is a somewhat independent topic of timestamping.

The thread in question mentions that the device has two modes, one which
has higher precision for the timestamps, and one which has better
precision on frequency adjustments. I don't know the details for why the
hardware has this behavior, but being able to switch between the two
timestamp modes has value as described by the thread.

I'm not sure how to represent that in such an API because both modes
seem to capture the timestamp at the MAC.
