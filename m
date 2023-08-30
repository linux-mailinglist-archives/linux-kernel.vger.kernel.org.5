Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9495178D12C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 02:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjH3Afc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 20:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241429AbjH3Ae6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 20:34:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D38C107;
        Tue, 29 Aug 2023 17:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693355694; x=1724891694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9bhNLpyRpWW6nj5JmzgmPMh0B+Dv3pl8LNS+1SL5FtM=;
  b=baJwk+WI0nIpCQcb/azf7BcxtROtp2QcvWdbFMgImNwLyuBfNNKhiSMO
   3ovnFcELztk3+ZnMXbQPtMW4HIN7itqs6Clq67ecu0pgFYirgzw3+UBYq
   vQYVdIxAGV/o7dODDYSU71yWi1xdhZ0jgTAPivk/M3NHPRlkp2twH/wYT
   37+oqk+x146arR6Md/5+Gvd/8RPffN8YQm9NPKIHdOJ/01uFoumo0Ldzc
   6FfXK2WyJiG/qqnRrVN/6G6aII961gn7xcnk+wrNVoPWWkcHMfdW9q0RN
   hLyFjllX4/JmLIKN0ioIeuDgHmxC52EYAZFvAtONPt3fIFIdybq96igRl
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="2020500"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2023 17:34:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 29 Aug 2023 17:34:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 29 Aug 2023 17:34:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMiqeLx0yntCV/E2FmfJIzJNb1VKtJjiNaAIwYJrgjAwo9Z6Og2e7arFBPVOFdYAS3IojYMdGqisEFqlq1vpvtnPFr6L/TFshcCV4v6aomNqBN+0ScxsGqAefRVYOo3aXO2lWnaGhy3aI2WtDC45/LC2qwJFzgcocd8+eB5kDuU6HOCokgk8AIMRqn8p3e3Y/1FV1c6SbndngDEsPBlqUdTaUBelU4U9QQ1ChEe0f3E1rUTBXncmutqxwVmH7RqSXktT9IsgGVcoinHzS8UMGLk8C34bH+MlldChI+/bO4ObS9D8hXteGb0d0YkLeuIq1yRQ0iiSM2G28jYsUpK4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bhNLpyRpWW6nj5JmzgmPMh0B+Dv3pl8LNS+1SL5FtM=;
 b=R7eaqkYTL4UAMuyikE1gEUt2bk9+NCbXyHe/ydAEp6ehMskWsFbgBsgtL/bOyIjug/kMqNayxg0AvDR9nwDzPXdYa2UEVQ71EZlNlCPrV9KM9EgPr8AD1Xsucbp5zRcrbgmRZwnoyIfGhrDTMoJ8oc6nGp2yiGG8VKi6qRJCOwaG9a1HYcBXya2U1RzCLNDJPT6Qavnb4rIwy2nzFf/oGjhm31DTyIz6ds8jVPBsXfQwk+PDCgyA+uzlNnGztzgsqeUOk3gHihRELOieTwdkzzfyGVgMX5a0NsdeDISPm0sa/vj2nxS/JFPhl7huug9b6BFpsyr0s4pEvKm92EE7xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bhNLpyRpWW6nj5JmzgmPMh0B+Dv3pl8LNS+1SL5FtM=;
 b=s4Eq5stJCa/XYrSu9I/afE0l7q8Cj6vAPvNc1Ay3UX3+B3jhpMvYxJrGCDE14OuFBQfffnQwjbhPlu7OBS3Bx/KYGbhYxlI0A2ZkxPGg0aDIuAanZgT4tVoo79kPQ7xWbkp5LfAi/Pr7i6kk/wcKyewzpIzmZkHIRKHGxcqAQ2M=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by IA1PR11MB6322.namprd11.prod.outlook.com (2603:10b6:208:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 00:34:24 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::360d:b35b:51e7:f5af]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::360d:b35b:51e7:f5af%3]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 00:34:24 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <kvalo@kernel.org>, <lkp@intel.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>
Subject: Re: drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42:
 sparse: sparse: incorrect type in assignment (different base types)
Thread-Topic: drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42:
 sparse: sparse: incorrect type in assignment (different base types)
Thread-Index: AQHZ2gMQNOMgJor5MkmGejQxkqg1X7AAypeDgAAnkKOAAQ1DAA==
Date:   Wed, 30 Aug 2023 00:34:23 +0000
Message-ID: <cf141543-fff5-635c-ff51-22f1d9120e09@microchip.com>
References: <202308290615.lUTIgqUl-lkp@intel.com> <877cpev0pn.fsf@kernel.org>
 <87a5uatfl1.fsf@kernel.org>
In-Reply-To: <87a5uatfl1.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|IA1PR11MB6322:EE_
x-ms-office365-filtering-correlation-id: 44cf80dc-2e7c-4615-9789-08dba8f0dbea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /okjczVHslGnjQwLxI+6QC+ewWEyo8RrlhzkP+Vyje7mmstMYkp36/igyDcaAp0AUHqsO2jxQWntdmM9AxOEZA5yP5Z3aUU6ifFUydamG/xFFPqTaQxiR8+qe4wodx+4L4DRvH61umuJjZSZ4EtbQF0ic7H3BDa49lx5pgZxQGt0xvqghsquL5cLHtz84/+FFaHQ0jxIiCEyIgT7KxCMJpV5wsOcmPH/crTGlkd5MnO3Uy/wDB39gvwHKMzuTrswJ7M+dpspufik4gLXvSeI4veTWyybVHeq9IF/vGq0hKv7fmLwvTxTomIGAMXL8O0R1PgZPOZM/Q7eGzvHmt3DRH/Ou+HMUn8QVM1MCtExeVBd/6XcFaKZP0P9dcS1teBWaQiC2HXwBLcNzmQgJRmBH1IFEYavXgBZTslrFruV7Ju3Or/fdrBjiBOetL1VlCOppfzVv2cVSe9jlInD4McI2LciCftySD1F8W32i6FpfRbQO3pgGuBSvZUKgeKClHjDc9XFLtGxQMrp03tEf6jmDLg15dywT7xCEIKSnRpomYP12g+cpj7bJ2ERR4oHEkasXOJ9u+dOq46XS6gs2uzlpMqGsT2z07XuZ77MWMyTjoQw44wowjpHMB6tEtlhk6JtJreigN/2a/eo0IINxpcKc22Gex4rM78pyS9BUFeqqDo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(186009)(451199024)(1800799009)(31696002)(71200400001)(6512007)(53546011)(110136005)(6506007)(2616005)(6486002)(66556008)(2906002)(5660300002)(316002)(54906003)(36756003)(38070700005)(86362001)(8936002)(4326008)(66446008)(66946007)(76116006)(41300700001)(64756008)(66476007)(38100700002)(8676002)(122000001)(83380400001)(478600001)(966005)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUNEdkdMN0NlaUhVeDVRbk1ORVVJamFqbHZrS3dZZFQxSjQ5ckJnWENFNlRr?=
 =?utf-8?B?bXo3REhkNDNPVUZDNTduOWFnLyt5KzUwZi8xMTNKUEFJenVsY3ZWQlN3bm4w?=
 =?utf-8?B?Z21YMmh2Yi9tUW5CQUN5YW5IaW95WkxjNWQ0L2tjeVphMW1xbm81SHg4bEpC?=
 =?utf-8?B?U0M0TnU0SC9NS0RHb0xXSFBYMlBBRFFuaGEyVTJEblhYby83T3QwYnZUbjJy?=
 =?utf-8?B?UFVWbWJySGlxVHc0WDVvL2xic2J6L1R0bCszdVlxMmFNWXpNek9FNFQ2NEV5?=
 =?utf-8?B?NWU1dmNZazh0QW1RWEh0dzFoZEVqN3JhR01wZGNqQWh2a3lnalBTUmtHd2hE?=
 =?utf-8?B?QUhzUW43MDJodkF6cFE0WkhiUE5aSnd5cHdpVkE0d204a3hNTUZHREY1bFpY?=
 =?utf-8?B?WmZTVlo4OWNLeHhFaEtyd2s0WXN3anVFOVYrMXJ6N1ZhVjhVVElJNE9ZRmdi?=
 =?utf-8?B?RVkwRGp5MEhIUzBmdGdYdzhMdkVRQldlVkxsU3FDcWo1cFo0RW1QN2RMSW1i?=
 =?utf-8?B?aVlJTkhFbEhSRnZmRmxvaENzYmJnUHBmM1BxUjVzV0tuTndJS1FrNlZkRnpF?=
 =?utf-8?B?cC9RYTlHY1h3bFRDS2FlaGJOeXBHVUJDZGZ4VWNpOG9XRWJuS2tQQndVL293?=
 =?utf-8?B?VnBCNWZEQnN2N1d4Q1c2UVZxK1J2NmNYSFE3bHlHSmQ5dkZRcXBqZWhYYnVl?=
 =?utf-8?B?cVF0Mlg5ZHJua01mN29McnJmZVhNQ3dRZ2ZhbW8xVXdrT3RDb2MvbzZUQ2Jv?=
 =?utf-8?B?YTg0ZXRnNUlQd0FjTlRxM29qQjdNaGRveURXV2VJRFYwTkR2bVMyZjk0T1pM?=
 =?utf-8?B?YWtHc0dSK28yeElRTk1oVWxIS1p0TlZuN0k4QXBvRzA1R1NxVmJOamVYWmRv?=
 =?utf-8?B?aEFoZnZ0QllJM2lZdHc5SjhHWjFiUituTkVscVZhVGNTRzc0QTVoNytpSEVG?=
 =?utf-8?B?RFlIUUlDTmlOYXFFRWdET3FIUDI3TlNDL0lseFdBMGU4Y2ppbk9EWE5KZ21h?=
 =?utf-8?B?dGt2WDVhSFpFZjBYdUlqTnVyeUUrNTBBLzFwSkdNREFXOVZHR0ZSYUF6MGx2?=
 =?utf-8?B?L0tuOERoWFphSUM1RFJvdEN4b1Q1UTloWHdjU3orNEV0V2lqSUNJa0FIZzM0?=
 =?utf-8?B?aTBEY05qMTBJYXRsaFFWWDcrTmxDa0djbjVhVDBYbnArbTM2eXBzcTYwVWM2?=
 =?utf-8?B?NnlTT0crK1A2eWUxYzBBZEVjczhPRWsrdjJ6Ym5BV2daYUZ3NWJHTjRqeldy?=
 =?utf-8?B?TDJWZkdETm1oWSs4c1cvL3IyZ3JIVFZhSU8wTWZHd1RlSW5CVC9BbFJqODd6?=
 =?utf-8?B?VDZRTG5WdUxQejRJMXpmR2xzRmVHQklNaXBlYm94YUpHejNsWjRuU3VLRFhL?=
 =?utf-8?B?SFoyMGc3dGtKbncvckhEb0RhWGpwQzJia2FxUzFFQnROZHFHdXk2UnRGRTdK?=
 =?utf-8?B?NUtQRVY4K2h1d1FNQjUxNVBSR05wOTlzcFBzVjhZU3YrT09aZXY4OXEvRGhm?=
 =?utf-8?B?blRzUGxmbzcxTlpJR09kQkJ6alZoTFExY2lRWTZEa21DUmZpVElQV3NLMm9U?=
 =?utf-8?B?cnZpclNHdHlnNkJtZDJXTXdveUhCa0xQVHlhTEp6VFl5L2hrM1oxWjB5WjZJ?=
 =?utf-8?B?RVo0eEdWY3k4THo5N0lyaWdyZ0svRFhiaUhUQkV1WklRMXpuN2dyUUJ1L21S?=
 =?utf-8?B?cGxOZ01naE41S2dOTmd1aTVnQ0NqcnZZSGZ2YmYvMmdHSHFHbll0WmZsUlMz?=
 =?utf-8?B?WkkvdHhYVVR4Tm1iQ1gyWHI5KzlNaExhQTdVb3hoZ253OXJaRVpqRFdiYnNY?=
 =?utf-8?B?ZCtER0JTZ2xMRDRUMzMvdGNOc1N5bmJLcUF3Y29XOFdSbms0T3hxMkdXeHpM?=
 =?utf-8?B?Y0JGZFlmbjZwSFhvdC9mUmhadnJPcUhBcm9LcEZwV3NlaXFoTmFjazVlaVd0?=
 =?utf-8?B?blc1ejlvd0hESng1OWVxQ01SUm1BZ2NkZExnVEh6c3dvMGYxZTNSUU13NGZm?=
 =?utf-8?B?ejNGV2RYanhIN2wxYkRoekF6c2c3c1pJUDVDeEFwS2REM2VDQ0pHWW5PZWMr?=
 =?utf-8?B?bE9LSmZvYTJaaGMvNWxSYlAxdWkxSWpMRkR5TUdYZzU2eGVOZmhtVk1ZU1lP?=
 =?utf-8?Q?lvfCTWAEybHHxJiASZjGzRSId?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9828DE0DBA8FE4984A386900F034F91@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cf80dc-2e7c-4615-9789-08dba8f0dbea
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 00:34:23.7907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/qrIWBi/UUzUn0BwszA0noI9WG1362Uv6gaPGt/6Y6UyGZkEmuk7lET73zpHS5Uf0m6tVBP47JQZwajGeTBkmjuQ25SfIHicR8+2HKw0Po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6322
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS2FsbGUsDQoNCk9uIDgvMjkvMjMgMDE6MzEsIEthbGxlIFZhbG8gd3JvdGU6DQo+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gS2FsbGUgVmFsbyA8a3ZhbG9Aa2Vy
bmVsLm9yZz4gd3JpdGVzOg0KPiANCj4+IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29t
PiB3cml0ZXM6DQo+Pg0KPj4+IHRyZWU6ICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0IG1hc3Rlcg0KPj4+IGhlYWQ6ICAg
NzI3ZGJkYTE2YjgzNjAwMzc5MDYxYzRjYTgyNzBlZjNlMmY1MTkyMg0KPj4+IGNvbW1pdDogYzVi
MzMxZDRmNTUwZmI3OGJmMWE1NTNiMjUxNzYxNmE1ZWE5MTNkNiB3aWZpOiB3aWxjMTAwMDogYWRk
IFdQQTMgU0FFIHN1cHBvcnQNCj4+PiBkYXRlOiAgIDEgeWVhciwgMyBtb250aHMgYWdvDQo+Pj4g
Y29uZmlnOiBpMzg2LXJhbmRjb25maWctMDYzLTIwMjMwODI5IChodHRwczovL2Rvd25sb2FkLjAx
Lm9yZy8wZGF5LWNpL2FyY2hpdmUvMjAyMzA4MjkvMjAyMzA4MjkwNjE1LmxVVElncVVsLWxrcEBp
bnRlbC5jb20vY29uZmlnKQ0KPj4+IGNvbXBpbGVyOiBnY2MtMTIgKERlYmlhbiAxMi4yLjAtMTQp
IDEyLjIuMA0KPj4+IHJlcHJvZHVjZSAodGhpcyBpcyBhIFc9MSBidWlsZCk6IChodHRwczovL2Rv
d25sb2FkLjAxLm9yZy8wZGF5LWNpL2FyY2hpdmUvMjAyMzA4MjkvMjAyMzA4MjkwNjE1LmxVVEln
cVVsLWxrcEBpbnRlbC5jb20vcmVwcm9kdWNlKQ0KPj4+DQo+Pj4gSWYgeW91IGZpeCB0aGUgaXNz
dWUgaW4gYSBzZXBhcmF0ZSBwYXRjaC9jb21taXQgKGkuZS4gbm90IGp1c3QgYSBuZXcgdmVyc2lv
biBvZg0KPj4+IHRoZSBzYW1lIHBhdGNoL2NvbW1pdCksIGtpbmRseSBhZGQgZm9sbG93aW5nIHRh
Z3MNCj4+PiB8IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4N
Cj4+PiB8IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2Uta2J1aWxkLWFsbC8yMDIz
MDgyOTA2MTUubFVUSWdxVWwtbGtwQGludGVsLmNvbS8NCj4+Pg0KPj4+IHNwYXJzZSB3YXJuaW5n
czogKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KQ0KPj4+Pj4gZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWljcm9jaGlwL3dpbGMxMDAwL2NmZzgwMjExLmM6MzYxOjQyOiBzcGFyc2U6IHNwYXJzZTogaW5j
b3JyZWN0IHR5cGUgaW4gYXNzaWdubWVudCAoZGlmZmVyZW50IGJhc2UgdHlwZXMpIEBAICAgICBl
eHBlY3RlZCB1bnNpZ25lZCBpbnQga2V5X21nbXRfc3VpdGUgQEAgICAgIGdvdCByZXN0cmljdGVk
IF9fYmUzMiBbdXNlcnR5cGVdIEBADQo+Pj4gICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9j
aGlwL3dpbGMxMDAwL2NmZzgwMjExLmM6MzYxOjQyOiBzcGFyc2U6ICAgICBleHBlY3RlZCB1bnNp
Z25lZCBpbnQga2V5X21nbXRfc3VpdGUNCj4+PiAgICBkcml2ZXJzL25ldC93aXJlbGVzcy9taWNy
b2NoaXAvd2lsYzEwMDAvY2ZnODAyMTEuYzozNjE6NDI6IHNwYXJzZTogICAgIGdvdCByZXN0cmlj
dGVkIF9fYmUzMiBbdXNlcnR5cGVdDQo+Pg0KPj4gWWVhaCwgdGhpcyBpcyBhbiBvbGQgaXNzdWUg
YnV0IHdlIHJlYWxseSBzaG91bGQgdHJ5IHRvIGZpeCB0aGlzLA0KPj4gZXNwZWNpYWxseSBzbyBh
cyBJIHdvdWxkIGxpa2UgdG8gbWFrZSB3aXJlbGVzcyBjb2RlIHNwYXJzZSB3YXJuaW5nIGZyZWUN
Cj4+IGluIHRoZSBuZWFyIGZ1dHVyZS4gSUlSQyB0aGVyZSB3ZXJlIHNvbWUgcHJvYmxlbXMgd2l0
aCBubDgwMjExIGludGVyZmFjZQ0KPj4gYXMgd2VsbCBzbyB0aGlzIG1pZ2h0IG5vdCBiZSBzaW1w
bGUgZml4IHN0aWxsLg0KPiANCj4gRm9yIHJlZmVyZW5jZSBoZXJlJ3MgdGhlIG9sZCBkaXNjdXNz
aW9uOg0KPiANCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXdp
cmVsZXNzL3BhdGNoLzIwMjIwNzIwMTYwMzAyLjIzMTUxNi0xLWFqYXkua2F0aGF0QG1pY3JvY2hp
cC5jb20vDQo+IA0KPiBBbnkgdm9sdW50ZWVycyB0byBoZWxwIGZpeCB0aGlzPyBJIHdvdWxkIHBy
ZWZlcnMgZml4ZXMgZm9yIGlzc3VlcyBsaWtlDQo+IHRoaXMgY29tcGFyZWQgdG8gcXVlc3Rpb25h
YmxlIHJhbmRvbSBjbGVhbnVwcyB3ZSBhbHdheXMgZ2V0Lg0KPiANCj4gTWF5YmUgd2Ugc2hvdWxk
IGNvbWUgdXAgd2l0aCBhIHRvZG8gbGlzdCBzb21ld2hlcmUgYW5kIGFkdm9jYXRlIHRoZQ0KPiAi
Y2xlYW5lcnMiIHRvIHdvcmsgb24gdGhvc2UgaXRlbXMgaW5zdGVhZD8NCj4gDQoNCkl0IHNlZW1z
LCB0aGUgd3BhX3MgaXMgbW9kaWZpZWQgdG8gaGFuZGxlIHRoZSBieXRlIG9yZGVyIGZvcg0KJ2tl
eV9tZ210X3N1aXRlJyB2YWx1ZS4gVGhlIGNoYW5nZXMgYXJlIGNvbW1pdHRlZCBpbiBbMV0gYW5k
IGl0IHNob3VsZA0Kd29yayBmb3IgYW55IGJ5dGUgb3JkZXIuDQoNCk5vdywgdGhlIGFib3ZlIHNw
YXJzZSB3YXJuaW5nIGNhbiBiZSBmaXhlZCBieSBqdXN0IHJlbW92aW5nIHRoZSBieXRlDQpjb252
ZXJzaW9uIGJlZm9yZSBwYXNzaW5nIHRvIHdwYV9zLg0KDQp2aWYtPmF1dGgua2V5X21nbXRfc3Vp
dGUgPSBjcHVfdG9fYmUzMihzbWUtPmNyeXB0by5ha21fc3VpdGVzWzBdKTsNCg0KdG8NCg0Kdmlm
LT5hdXRoLmtleV9tZ210X3N1aXRlID0gc21lLT5jcnlwdG8uYWttX3N1aXRlc1swXTsNCg0KSSBj
YW4gcHVzaCBhIHBhdGNoIHRvIGZpeCB0aGUgc3BhcnNlIHdhcm5pbmcuIEhvd2V2ZXIgdGhlIHBh
dGNoIHdpbGwNCndvcmsgd2l0aCB1cGRhdGVkIHdwYV9zLg0KDQoNCjEuDQpodHRwczovL3cxLmZp
L2NnaXQvaG9zdGFwL2NvbW1pdC8/aWQ9ODM5MmVhOWU3NWVhY2YzMGNiMDk2NzFlNDYzZDlhMzdj
M2VhZGQ2YQ0K
