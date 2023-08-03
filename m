Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8ED76F33D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjHCTHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjHCTHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:07:08 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B8F2D54;
        Thu,  3 Aug 2023 12:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691089627; x=1722625627;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QJxCi+TrQVyTXBpA5+xnFFuwENxX0Y/2aM4gDyDUosk=;
  b=Ld8+Nq/AsS0FrBx2Yhk7k8+arSOhXBvK4HMcQb+2CKNanQ4+XHirgA7t
   l/80sCI6oRVIdIEDMlFjmOxx9shURf6e8aquIitrWwrCVjqizTBPYa0XH
   tGJUyR32CTTyZfrQ54nkb9Gmkqg4cFov2LNSc9qinKWAIHSoVJ3MI8eV7
   7nhvS/2zweMYWYi98otYuwQhXeApeGuSnHxHHkr7i7oyTQfqbt7zDyl71
   QeGEx8Ufg6zXdfXdbiGuX5otwwU0LhcCpiA5tx2GhSvSfOY3f7PcnT36d
   LITkFxHk2H2k/PBkqNmRVSFxE1svqeVaFIWA1YxDn2cjBQi3qVscFtQb5
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,252,1684771200"; 
   d="scan'208";a="240398614"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 04 Aug 2023 03:07:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxPNVwOnwydhP5VAFuXFquRF0VazBO6He88wGbVJe/5HWpl9Qu8zamN3ezEQFGiWjiJCNhID9M95RMe5FCEeVCKdVblhcbP0drQlBxGfDPtqHsHHY5jNNMSuPEJ2uX3y0HtnS6UraFCooCxiHBcqtEo8xuJUlehC2UOLQar68yz2Dce5ROA8WiTWfN9RhyNF7/DjB4OrzKbCRnCU7ga+WQqYfsNRaqeKIQbR2LheXEzLvg56avfNj6mFGgyDHRBo7pRJzBxAAuhA4kpcj9K7P3J8gtKDrrnk98S7BFCpqtP3zlhHRqAsf6N0Tejv6OqUCeUBCJ1Ubns5mW+g89JkIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJxCi+TrQVyTXBpA5+xnFFuwENxX0Y/2aM4gDyDUosk=;
 b=blLvrXQuelmr9lSzsrm2fkPNBRNJHhefdebg1OMz8LeIpsGbvYFLMnmLpLBBeuXh7oUnOC0pkKDaKY3XtjsppJbJT0wllmV+DCgRUI9iqGLMXk7sSbiksQq2FURqjP2JYt12AytmQwNQQjgwx0LKcEW9lUJFiYtZudDxidXM6AmJO4YsqZSQwvO0cSNWjqurs7Hywv/v/HeyLfr0a3oqd1JzQce/mpj+sqPbALSu8n76l//GfpwEzEdCMQU+Zx4VwCvZ7WR5cMHos90h7ySOWxnCZhBf4L5OmJtldV+8zJV9+tPbdB0iI/+INETKjaZOFF04ufEAY3Jx8dxKYkvyug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJxCi+TrQVyTXBpA5+xnFFuwENxX0Y/2aM4gDyDUosk=;
 b=Cjz4xUgjwMtIyLzwqyftCzAIDTCLMkSKYwr5PwwNa7oUmL+kQxohYnhPlLQiROFxWDBH5vjxcj/3rGnGejY4KSUFHqDmibCtlQmVYiiG51Ipa2KGH0R2wOf3bItJnXMFqj4TJRa2vXt70je4dhfvjegalX4lydqSOP9BNTYRUDc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6998.namprd04.prod.outlook.com (2603:10b6:610:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 19:07:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 19:07:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>,
        Ming Lei <ming.lei@redhat.com>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 3/3] ublk: enable zoned storage support
Thread-Topic: [PATCH v10 3/3] ublk: enable zoned storage support
Thread-Index: AQHZxhQZ0nPbn3NeaUu3a8qa1gGuKq/Y7zeA
Date:   Thu, 3 Aug 2023 19:07:04 +0000
Message-ID: <f339913a-3f73-5fc3-27d1-73491a8028a7@wdc.com>
References: <20230803140701.18515-1-nmi@metaspace.dk>
 <20230803140701.18515-4-nmi@metaspace.dk>
In-Reply-To: <20230803140701.18515-4-nmi@metaspace.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6998:EE_
x-ms-office365-filtering-correlation-id: 65aac540-6ac3-4ece-05af-08db9454d310
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HkXwl/CzL/pw28wAeEe9wHPbGKfs7KQQ/V0eyKTUpH4TAgr58X66/+RKmP8aiKpLxY1fyqIMW7DdSNcQOGutlzfEG+q42kD/G0O65bh2igIw0YdumWr329/FZh9ThFF3U+ig7f1J/KZf2TcKNwVIO0FEK7EJOYYvWV5Rek0B81Ptozo1pyIl4NVsX2oiXuP8A7Ftr5Xlg3OPOaTP5RcSRkKznhkFbX8ffPt826oQZ4OMtiVv2Adu+qFbJmgkrmAJjWEHO3GyZVQI2A1NbAjJIjShxs6IEK93qgN3025V91pAKrGKTAo5m7rtlGHz9f+TaogMFSO3ym764KksvlL+sm5hDXn0M/H6/S3OLOnJUjS/sWutv6Ij2JeFqrjCuho+pfRYN7xjtuLFKoucNZihyrckRrY0HOI3hLB0N0NCPQX8ozgZV8oLOdi+SVAcoqehv3pTIl2PaHpkK17msxqHh6VPz2c17amesf89DbO5WR5uwsSVSa9DcMVthgJk3IlHUdmUiavbXbEVqL/2ttm1HlDGMuj25c7fReyKL48jd5zJM2Ok+8syE+DM7xhymAwKk6h7SFA/xUf9H7Y5NBuCrV86LKUkmqsHkYxC3NBGIw1k1jzxfXcXsodvW0Fzwj7ts7IMijKLErMM3TcwBokKxGwTDtzp+YGak8AKK0HnoDV38ULWHq/6tv8QoMd5CgeW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199021)(38070700005)(36756003)(31696002)(86362001)(558084003)(31686004)(54906003)(478600001)(110136005)(38100700002)(122000001)(82960400001)(8676002)(2616005)(6506007)(186003)(53546011)(8936002)(41300700001)(7416002)(6486002)(6512007)(71200400001)(2906002)(66556008)(76116006)(316002)(91956017)(66476007)(66446008)(5660300002)(4326008)(64756008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVlmV2piM2NISnBRQkpvN1hyRm1DN0xESkFpNnppVjFNYW1XbzlsNkZtR2hn?=
 =?utf-8?B?V2M0bnhhU3BWcVUyTDlRNGx6STR0R1ZKVUpjSkhzNC9mR0p2OFJURnB4Q0wz?=
 =?utf-8?B?ZzI5V0JOZzdZWHNzdVdjQ0xxN3RuVFdSN3ZPQkZLRFdwdVE0Z3MwNEdpcUJZ?=
 =?utf-8?B?S2habHVKYlpweVZVK0tBZm1MbmhHazBlVFBMNENaZGNKYkMxNTFYQVBMUHRR?=
 =?utf-8?B?VkMwanJTcDRjekdNYzZUWk50Sis4RjlpVUlQRHZDeWdpWkoya2FPRUNzQVZC?=
 =?utf-8?B?bzNNdGN5SHRLSkxvUFBqcXVUUW9YTzczT0xXc09ranM4VEZEc1hUUHJnOW1n?=
 =?utf-8?B?TXhENEU5S3o0eFk5VlJFY0NEZndBcm93KyswNENzSDc5VHNrdWo0NEJpOExv?=
 =?utf-8?B?NzhGcUZ3RStNZVNpdWE4UVp3ck96MU5VZGtzYkhVb3NwYTlOSGN6alZJSlpN?=
 =?utf-8?B?bzV5WVRjSFpQa0NtWHlNN1pxMHJHZ2FxQm5jbGsvWHpUNFB2YjBrVUdjL201?=
 =?utf-8?B?TlRVdU1HT0hWSWt5K004RXQxd2ErR0UyOEErYmxLTEp3bTY3VnRPNkpzN01B?=
 =?utf-8?B?QlVYZ3NuaWdpS21hOCtBOUpzVVdheXBMbFZscHJoVlk1c2h2QXhhVEFWdzVh?=
 =?utf-8?B?ck5QdXJEVVNLaFd6cXlwSXh5Mm0vazRTMWZxWTNSZ3lvcHBxd1BTeHoxTFQ5?=
 =?utf-8?B?V0VpSGNZakU4N3JBb2l2MktLZHZ4Q0pxMVFuZHhJbGVad3JVVUNZSlpqSjds?=
 =?utf-8?B?QjhiSnI5Z1hqemw2VkZZcHQ1VnFSWDZkUmZVMTNzZjBoMmxIbDJGSHl6MHM4?=
 =?utf-8?B?WHIxQURZendMbncwK1VZWkhLWmxsTERJYkI0bkl0TmpKWk5DSS9iV2FTdXpU?=
 =?utf-8?B?RG5TWStOQTlTejBGWk5HRHBMT0RNRHdDTStpRkNDbXFFYytJQm9LNXdkbzYr?=
 =?utf-8?B?L2ZUaVYrbVRtTU5nOFRGc05wdnc5NjhCOHcra2JoNUxiYmtCR0xpcys5eE1i?=
 =?utf-8?B?SGk2SjVLMXBvRjJDWW1zbURQa1ZhaFhpOFE3empsa045QmpXZUpvZC91c2s0?=
 =?utf-8?B?ZDB5NGlpWmh3b0tHODJzajVBai9qa0lsRUtHaEw0RzJIdDNVUlJic00yRlZv?=
 =?utf-8?B?b0JITUZ1TmZPS2NYclVGalhXTlo5b0F2OGhwTm9GNE8yQ3hNRzhwVXJMaXlw?=
 =?utf-8?B?NVFReGVNMzIxTmlNajhHdVBzMjFrQ3FyQ2l1eDBPenIwS3hMUUtDQ012eklT?=
 =?utf-8?B?Lzl0a3RvWlY3OS96ZlpXanRuckgxOFBZYW1IWUdiSlF1a3k2ZkxubENzWi94?=
 =?utf-8?B?SHB5UjhnVVh4bTRNSFlWYm10N2RHMm4xQlZpVG53aDVqQkk4a0Y4T0ZvSW05?=
 =?utf-8?B?clFFWkdHdjRJSWVOQnoxZEtoaWRVV0lyWUtrdlV2UmY1YkRjK3ppYkRZeTBK?=
 =?utf-8?B?MVZuRGFGMkxvTm42YlpIM01NLysvdmxFajhLNDNLL2dmcy9SU1FmODkyZVFX?=
 =?utf-8?B?OEpUdG9WU3k0dnBoZ2ZkenBpTVBwMHZ4dC9jdGpUbUN4WHhSTEhSZEsvRE1S?=
 =?utf-8?B?RVZoUTNxWDZ2TjB6ZDI3a1M5SlcvY09KS1QrckRlSENjekRtQzZlbEdmWm9M?=
 =?utf-8?B?RTZCeHFwT3dBSnhkQmNIWFJKRWQwNXpET0ZmZ3lxcTg0ZUlHNm92b3E3cnVk?=
 =?utf-8?B?MUgwTktXZ2Jld1V3RmVUSW1ZUlJyMW9iUW9EZFhvVGx4dmZhRXRCRWRXbGxH?=
 =?utf-8?B?QVlTdUEvY3UxdDZQcWlWU0hOTE1lZEJKZzFNRTFmNnhwMGZKUzZFUkpIOWdL?=
 =?utf-8?B?RGNNVGVNcG1VL2trSTI3RXcxZDdqaXBvY3FjZXp2a3BJY01RTjY4cVVicHRn?=
 =?utf-8?B?a2M4KzU4NDFYaFRVU0lVdS93WVBnUHNjRGxpdlJycFZWR3ZHUjNWSHVpNVNJ?=
 =?utf-8?B?SWg1cTJ1V2N1UU1sVm5Sb2pSQkJLSTRJcTJ0YWZDSUF0SDRCYVN1YTF1Uzk2?=
 =?utf-8?B?V2R3dDl0RHp6NnI2RE10RDdUbnVWN2Z0a3RaemZGdGZ3cjgrNDFUMTV1M2I0?=
 =?utf-8?B?N0N5RERQYWk0Yks4azRjTXBMK1JwbnMzT2ppSmF2L3gvZEpHQlAxeXlqZkxF?=
 =?utf-8?B?NEJUVHMvaWp4L2F1TXhkKzFjSmxEVmxtd3Z2ci92T1pkSzFvZzFDMUloUmhZ?=
 =?utf-8?B?Q3o1aUZWeVYrUk1nc2pyMjJkYVdZTFo1RnpWdFVTTWk4Z05VM09WelREaUtG?=
 =?utf-8?B?N3Yyb3pNUmxuNDBCc0VPOGpuNFJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCEFEEC6C20E674DA04838E29986BFDC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UlpvUkNyM2lWT3lrRFBnSEZQQlpGQ1FWR3IrY3dLaTU2L2kxZDA4YklsOCsw?=
 =?utf-8?B?RlJZN3JERDRuWjd0Z3hzYlBZeXlBTGtRQUZsNC95WFVlM3YrVkl4WndZWlE5?=
 =?utf-8?B?bWtEeWNuYU91cUQ0L1Vhcm1SRGVESXhYaGtFMkcwa0xqY2ZvUjVWaytTUUdl?=
 =?utf-8?B?UVR4U0xseXBHUTBjR0p1andDQXVCTHhLNnJjcVlNczBsUVMrUWJtWE53UlJN?=
 =?utf-8?B?eVZCT1R0Y3F6elNZcVIwZzRoK0daS05BUVZVelZacTMyS01HbmdKcVphK1hq?=
 =?utf-8?B?ZnhJK1ZoUVVzcnFqTjhJV0wrY1kvQ2FZNFc5anZuQmhSN2JWNFhFVjlYWFZR?=
 =?utf-8?B?Ly81K2FneThkV1A5K0tvaGlmR1NhemthUWV3MVYyY053OW9xcmlRbmM1Z3BU?=
 =?utf-8?B?OXU2UTRDZ1dTZzRzbDlOejZFby9mMDZIejFrUUJxOEhZOFJoU2RTTVc5amhh?=
 =?utf-8?B?aWJKZnVqMlpJbHh4dk02ZVU4amthVkNlazh0NGloYUxDMEQyTzM5RzM3dnB5?=
 =?utf-8?B?Yk90QnVGL0k1Tm55VjA0U29FZ0dRVUhyWnBoeHk4WFUyNjVYWmNlY3JrUm52?=
 =?utf-8?B?WjFoQThWeW9DSitqSS9DMDBLbTVqRFVsUHZGUkcvMzBLWDZ6UFQ1S3ZTeDVL?=
 =?utf-8?B?ejRRc3BHSXphQVBvb0JNUUhMRGVBYXZHZXdBVnpMMUpvWDNkUjhEZnFrUndE?=
 =?utf-8?B?TFN6c1RjT2dEc3RNSEJDb01YbExaeUNiTDAzSGllc0oySnh0MUIxMHk0aTJ6?=
 =?utf-8?B?a3NFQ1NjMm1rTkZ0a2w4NXEzVlBVY2wwQjRyRGRRMUpBK3ZEMWxnQ3RZdUl5?=
 =?utf-8?B?V0ZUdE10ZnR6QkZJQlRoVlhSMmpGNVlxaUNTdTB0R2xrYmtrRUNQRWdsOGVG?=
 =?utf-8?B?dEtOL0YwVmRkTngxVjRnNkZiVWhuRjVWOVk0UHpsd0JtejY0N0hlcFdGYmJX?=
 =?utf-8?B?ejRuTm1QcUE4SWkyaWFBYnA2ZmJEcGh1MktScEtMYTAySDFOSlRJUHBnTzZF?=
 =?utf-8?B?cERzVWcxdklORUEySUhvZmU2Sk9iMklJT0YwemtSdFptdGxyK3U3M0lCdGNM?=
 =?utf-8?B?encybGgzTEFEaUU0WFpkZnA1QVVpcHl4UEkxeDNGSjByNHZ6Q1R5eUZ4VkNR?=
 =?utf-8?B?bGIra1phOG1vY3FCanJmVjBIRmJ0NmJHQWhOWlVnYmVRbVZzdU1RMkF6d0Vq?=
 =?utf-8?B?alB6Q3ZTQk9LTHRQdXMrYVBOSk8zeTlzYzBYTTZoSHBHL3dFTTRuakM5TWw4?=
 =?utf-8?B?MXNqQkxrZkgybzUxZVFYVTd3SitncnZoZTY5SC92aEZnNnhzT3lyUkVQRks0?=
 =?utf-8?Q?a5yst1fb2cjPfDXfdKp70w3+EiKbErQp4R?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65aac540-6ac3-4ece-05af-08db9454d310
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 19:07:04.1998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BO9vvIGvBNWuV8udpXiwfJKs4X8Y2tMXKLRr3Q+gP6vD1lTVgz9QIJ9gM3Wg/t10nTFev1xtmUkhtHSf+FydNF4cwgXnB2YR/EecmMDw8iY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6998
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDguMjMgMTY6MDksIEFuZHJlYXMgSGluZGJvcmcgKFNhbXN1bmcpIHdyb3RlOg0KPiAr
IGJ1ZiA9IF9fdm1hbGxvYyhidWZzaXplLCBHRlBfS0VSTkVMIHwgX19HRlBfTk9SRVRSWSk7DQoN
Ck1pc3NpbmcgI2luY2x1ZGUgPGxpbnV4L3ZtYWxsb2MuaD4gc28gdGhlIGJvdCBkb2Vzbid0IGNv
bXBsYWluLg0KQnV0IHdoaWxlIHdlJ3JlIGF0IGl0LCB3aHkgY2FuJ3QgeW91IGp1c3QgdXNlIGt2
bWFsbG9jKCkgaGVyZT8NCg==
