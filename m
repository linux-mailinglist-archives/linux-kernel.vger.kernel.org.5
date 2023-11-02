Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB317DEDF5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345006AbjKBIPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjKBIPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:15:17 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785FD186
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 01:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1698912911; x=1730448911;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RCWQ4QseuyGHQ6Lpg/Ysl8Y1eT+pSTEiiNXSV6yqzaQ=;
  b=PzYNWFshLr32Vy2QO67P63tQ3MF6EMcCg+Ua2zv1NBNpVG+J33P4NAIR
   uhZeizJ3g4uGW11y3YyrH3EoAsUyP3LenYaAGCgrmxQw9S3iT/+WPo6JM
   w4FUUlyga1q+tB8v+yPzFr3AilmSOH0EpbLLV4aFQyi0BmYNz64TtI3LC
   ziMvpneSOsY9OAhJzT19Mk5HTqF9tHWHeBtGtEC8n4ngZM1+hXMDb0TbZ
   XZU67idzBEvhPcfIwj1c5KZ89tw5U+a+HC4l18VZfKt7u7uthPbq5Wa8U
   82Z15ukyEYla3OchP1ILMEDDGZlZ2y9sKLaEfaWTGav0Idh09Yij2x1tc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="101399117"
X-IronPort-AV: E=Sophos;i="6.03,270,1694703600"; 
   d="scan'208";a="101399117"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 17:15:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f24TFSKJn7eVESjajeYJikcSBxHRCgSq5h/QsoAbUEuFQe78NlNFnFQcvZEgSVz1r0EO2HqYIc+OHvInV0+da4bVznxQnCBzBVbspcmHY9FR7Ri+rA1ZI6If5922gudTVOF6VZyeRCKTJknuJSUpT43Yk+XAj7MZZvJ65ttt5pjg1+9/zHQ8tLd3TcjTNo9mfc/DUMWt3t86JkoJlq1YBsArfXwIv1bdpG2d0UAgyv2b21MJkgacD0ao6tggn4e2GuTtPtR7QYNBL0oRH2DdXz7Z9fwXZ1NYVSNVzdVj3jq/wyLwWks2uVUbYFk3vRJUWRRLH/ItL2JXuZPpeMBCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCWQ4QseuyGHQ6Lpg/Ysl8Y1eT+pSTEiiNXSV6yqzaQ=;
 b=JXUEnRJT3QvFOe0lx6xU2xvNQHYdu5Hee+X4G7nJunvIYZoJ3RVOmUZ3rQZ/+hdgsidB9FO7io6gbzY78AkCMZKG/3+FMmz1SpzU3leD5n1mQz5pdNv0A06c+vmbMrhiQyoCHEvWRPMlmYrWQJjjSV2Fd/LmMvICTtHIGNc/Yqq9MPkHjUX2JNzRGA7tLWslNGU7VOuELCOQXZaHApaj5yLylARh8wXJ5vJdjAJNkzPAHS+LDrrr+yRxa9A7jdiup5WygPjnN8NPlfQwQv8UZtdbaUoDVjwAnSdH1sw1SP7qo8x0oSgdpc67JC6rSzjnjTjXE9aWpMXrrZgRRVGWnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TY3PR01MB11986.jpnprd01.prod.outlook.com (2603:1096:400:409::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 08:15:03 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::51e9:b5fa:db90:6c2a]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::51e9:b5fa:db90:6c2a%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 08:15:03 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 4/4] drivers/base/node: add demote_src and demote_dst
 to numastat
Thread-Topic: [PATCH RFC 4/4] drivers/base/node: add demote_src and demote_dst
 to numastat
Thread-Index: AQHaDTg+TJ7uWucf+0SYF02V+631t7Bmg6gAgAArQgA=
Date:   Thu, 2 Nov 2023 08:15:03 +0000
Message-ID: <02d8fc61-80c4-4689-b2fc-822b546a9032@fujitsu.com>
References: <20231102025648.1285477-1-lizhijian@fujitsu.com>
 <20231102025648.1285477-5-lizhijian@fujitsu.com>
 <2023110230-lilly-mustang-9b57@gregkh>
In-Reply-To: <2023110230-lilly-mustang-9b57@gregkh>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TY3PR01MB11986:EE_
x-ms-office365-filtering-correlation-id: 072fdf13-cdba-4994-833c-08dbdb7bd0ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MPcvvX6jsmcJnb0+ryN1chq6HwQWGqNthaiRKNNG00o2feFdhdilSmzJzx+0zlyEJXLOHi25zbAOgZ2T/gVmOukv1o0IXkrWeX0F9X4+lkIpM8lgWm5j/7CYnm9k2Hx3EjDuQle7EW02Hxdr5i+B4MfkhCV576UGLMzxEKkRxwfrXUtjx2GTqGHgFOW+8mAv3UDtlkCvNKw5+/j8Iig//Ev8H9++nosRmh3+iOYtaXEwtWcbFa+Fky/ekAM2XY2ahqu3AfBaph+HeOmG9uv0l5Ii7zblxNQlPIP3UGTWXOggIg5a0eLbCdTgKl/PZ3yGjINuNgVCFzAh1+U3FbDfrBHZAptVFFSTj/WjtuxHd0E8pTcX9/YE+uSgfvPsF+IIZmUXFHp956Q7Mbg3OWzU3iEKB6DHNpBN2QoII3Gn6HW4i1FXD97WNMdAq8Iv4eI5lBPtslfCTISZ7kXPjG2zARXFOlNVHl1KZeJq9RlCgoB7Qor3phM8euBS6QmEMfZqM/TNgNEXaDkVyDd7tLSW3VayCzUl4pUdWgmieJKto+9l0+WHBuKO2fsPjcNnm6IP5t9BseUA3UiXHV8On+15CEDAdDLzpeBgusY/dtWQ3YuDsYGjwBqhcr/XfoYM2lMVL98rrAyDLTvFVp7wral/ADLAeKhti+LlQ8I/9CFOuZpGz+K1WOS5XHhOXNSz58siCT+tW9tyOXo9lt/dM5Qz3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(366004)(346002)(230922051799003)(1590799021)(1800799009)(186009)(64100799003)(451199024)(8936002)(91956017)(66446008)(66946007)(66556008)(76116006)(66476007)(8676002)(4326008)(6916009)(64756008)(31686004)(54906003)(316002)(5660300002)(2906002)(82960400001)(122000001)(478600001)(6486002)(41300700001)(86362001)(71200400001)(26005)(53546011)(31696002)(2616005)(85182001)(36756003)(6506007)(1580799018)(6512007)(38100700002)(38070700009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eklhUGZTemNMSkJVeFhxQWZoTVVPemNZZnVyWGJDSmRMZWppWmxuZklCOVUv?=
 =?utf-8?B?Q3Q3YXVmdTltb09DOEV0REc0MGxzTi9PakIvc3RTbnN4djhIVHNjY1hJYWJS?=
 =?utf-8?B?cCtQMnJ3cHpNTGI4ZS9ZVFQ5UHBydkxNQmxWZzE0S1RxZG00Q1IwZmhrMHRo?=
 =?utf-8?B?S3FUSlY4UWNMYmczQlZ1L1VBMWZvTU12RHF3aGFuN1ZWQjBHaW43RkxBK0c2?=
 =?utf-8?B?WnR6OE9jQ2tWVEJOVVk5eGZtMVkrbHM5MzRpelRnVE9vU0dzbndReFN0cyto?=
 =?utf-8?B?TXNVdUNDNnBsdkxvQmNjRmRjcldvNkRmWlFheDZ2NVFZa3pXTFF4ci8yOFRj?=
 =?utf-8?B?N3JzdFV2bUI0MjlMQjgyZk1IWWRCUVF0eFNENklqZTRBTExWV1FZUHQ3U3o3?=
 =?utf-8?B?bXMzeW40ZjV4YmtSZkxONUJ6S1NUSGpIMCtTNDl0VmZjUEhSKy9KZkUrYlcw?=
 =?utf-8?B?UjZod2tCVm9qVjZPMWtTK3pXY0txRGpUZm9aNG9DS2FPOU1Lbm5jZGR5Y2JN?=
 =?utf-8?B?UjZBc2I2a0hQMThVWGVYV2o2OForQkxhZXcxNGpwSFVGN0JWTW4zMHhoV0R2?=
 =?utf-8?B?YUJRZ09RdG5lUllMbGFVc3diWmdIVVJJZHI2cVBueFNEalVFV0J5bnI3VVEx?=
 =?utf-8?B?M2c4b1R3SG01c2JqbTU3Lzc0WmdBcVhMQkZOS3czVi9tYjcrVjEyZkw1MTV2?=
 =?utf-8?B?NzJzTGR1L29Ed2NvbEliTyt3djdrb3o1RUNBSFB5VEtncjFDbDZHZzBBMysr?=
 =?utf-8?B?SnM3RE9jbGpydWRhRFlROGFLUHF2dk5iN1cySTVFckdYcEx4YW15ckJRMHNv?=
 =?utf-8?B?ZFVIdnhzeUVheklRc1RudXMzU3V1bTdvaklkWmc4cFFIb3diVU1saCtOcUxU?=
 =?utf-8?B?K2gvck5PN0ViQlZoUEwwbWh1NC9LMWV6SkMxZlQvcUJkK1ZFclE1R1J1ZzRo?=
 =?utf-8?B?aDdYckVmSUpNd0o3UUtORUFkNk4zU2FNM3Awb2dFM1ZENEExK29tazNtTnhQ?=
 =?utf-8?B?bWxyVFJPWHFYL3RaMS83c20vUnhpZk1mZWlaL3pwR0FFakpPd1J4ZEdkVmR2?=
 =?utf-8?B?Nk9GZWtHYy9nc1o3aVhRMTArQzExRmNoMG1yYnNYZmx3cisxQ2NZQ01Zek4r?=
 =?utf-8?B?c3kwaWpGTGFOT1lKWCtuZXBmYVNYTkh4R1NGczFoYm5MUE9vemlYcGlRVnhE?=
 =?utf-8?B?eHlVaVNjK0pQTVkySUprNTBKVVd4a21uS1FYSUxOVzBGaFk4SG5jaUNLQXZn?=
 =?utf-8?B?MDIwK1Fpcm9LMGhvTlpremZ5QW92dUdRZjhySG0yUE04UndJY282cWxUS2lY?=
 =?utf-8?B?aDNHeXd2VGdsQkhITFZ0ZXVhZVhEZzRWK3pqNlpMWnIxQkMyZkRUVGhrL29m?=
 =?utf-8?B?Q2xzTUhpZTdzNmd2RnoxN3BOYis2TE8zdU1uZVVEVzUzTXFUZ0tSdzFJUVpI?=
 =?utf-8?B?QW1RZGJxRE1SLzh4UEdKdkFOQTRsYzhsRVE2M2FkRHlSOEk0enZiUW55dFlr?=
 =?utf-8?B?SzVIZjNRYXhXQ0tTV0FrNEJjYmJ2YzZadTM3bTdMZXNhNGF0dDgwOVg0MWZl?=
 =?utf-8?B?NHV5VmZxRGpoOHNwV2NPRzBXUGR4bzRwK3BEMzRFTXY3Zm1ZejlNRTQveTl5?=
 =?utf-8?B?aXFuN2U2MmVQTGw4Rk1lcG5ZdjI2Wm5Wbm1zSkhEam1vblIrNzM3SkU4WDNL?=
 =?utf-8?B?UzBhMVFjSXp5eThJWHNpcmdXV0VKNzNodG8rbHlwODBzQktBdEx2WCtzQ0pO?=
 =?utf-8?B?aVlCd1E3M1dwbmlzeW1KQ0tzeG0razdpbGd1MXVFbmZhUm8zbUphUkpGM1VN?=
 =?utf-8?B?dmM0Q0Mvd3JmTmVxUlk2b1ZuYlRpdTIvM0xWYk4vRW9LZGcrT09Mc2tEUTRO?=
 =?utf-8?B?azVOeElHYi91YkxJUHYyRjhKTlg4WStVQ2VkeDRtTkhFK29qWW8wUzd1RmNJ?=
 =?utf-8?B?Z2pRcDRSVmpTd1NOc2RTWkZXaWt6cnRNejRIU1lueDU2VytWRXJkdGVtNldt?=
 =?utf-8?B?dmkySjFlVFVvVUhIZEpUWjN4SDZjekdSaHJnQzZwdDZFYms5allvbWZwWU9p?=
 =?utf-8?B?akxnMmhUcGpMMTB2N3QvYmpwNlFLb3hQVDRFTjdoTk52SEFGWVNsL3JlbGxk?=
 =?utf-8?B?cnhNU3BiUEpjQkJYTVhCUDhkRGlubW1lQklhM3VLaFllL1ZjV0RzYW9EYWxS?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7559D9FEEC8AE46B6EA6A44DA34E9BC@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YWNyNU93alppTjVDSFkzTXgrazUzRlpjNmNNbHVWcURxRVdVMFEwNzl6RjdL?=
 =?utf-8?B?cmdTcjdURjRsQnV2WkwydkowZ3ZLTjBRc3N5QWtLaDl3TEppaTdHY1NaRity?=
 =?utf-8?B?UXFxK254Qk9oSVpJUmpDY2lmNWNON2JHWWc1ZnhxYmpuN3FYUFhHYnZwa3g4?=
 =?utf-8?B?U0JYdktPcjA5M1NFZDhzWlh4RGxKUEs3NDgxVk5zT21VajgzdTlETklBQVYr?=
 =?utf-8?B?eWtZUUlUcXNDeHZsMVI1M1RBNy9kTlNyaGNETDJwZG5IU25HRUNrMjd1VURK?=
 =?utf-8?B?ck1wMTc2VGhuNWZKeVZocWEvV3ZBTkQzN1piMjFEVmhVMVNUM045M0haelp3?=
 =?utf-8?B?Qi8vMFFWNXg0MTZ4c1lBSWFHbStkV2I3RmJpZTRmTGIrWi80MVF2WUpjdU9z?=
 =?utf-8?B?RXU5Ky9wVHU5eklIalMvZG9XbU1jcm10SkNEdDBZRzljS2FweCtaSkN1T0w4?=
 =?utf-8?B?ckJqV3F3MGdqSFlrUWhLN2gzK1ZpQ3hodXRmeXVkS3lVL0JKQVhaMlBERzcr?=
 =?utf-8?B?K1FzY0VqODNpd2QvRmxWNDVTMDQvVDNEdVpCT2hNTit0VHBONDBUT1lqb3h5?=
 =?utf-8?B?V1Z4dVpRMEYvYklnQ21uMmJ5MDF2cGZHZGlwQWM3MnBlWnI0cUE1SEVvMUls?=
 =?utf-8?B?cmdxYUhjOHNPeFJNcUk5QmhnNGJPMjcrRzBrTlA3dVJ4M3pOS1JqYzgzQzFl?=
 =?utf-8?B?RW01c2JGcW51ZlF3OWhCSTNnZVpKS1M1M0RlMUlJWm1nOGZYbW9uTGRpcFFX?=
 =?utf-8?B?cVJJZjRxOWYxMG1Sekxmb3RSS2ZDMzVFV2x3TDRqaGpxcUxBZ2xwbFFaMW9q?=
 =?utf-8?B?SkhsWmhlcXk1SDd4aTV4bFlRemxabE1wQitRY0NIdzFkbzVIWjlZYTIvSkE5?=
 =?utf-8?B?UDFEdTdpamNaUDlHUnR1Nng3MGEydkczTTBEbVN3V3V3OERhZUVDSDhka2lH?=
 =?utf-8?B?RVpuRURwdll3anRiaDQyOTlPZW0yV3hGL2dFRDI2bTZBVjRYaUsyWG54Ylho?=
 =?utf-8?B?elpDYlF3TGRQMWsrY3ptWWpEN3ZiUWxjVDhsSXkzVC9PZXRNUVNNR2E5OEQw?=
 =?utf-8?B?a2JjTFNDODErYnBBNzNjaUcvbkRMU1ZKVmdkMWtNRDQzcDBDeFRVSGMvSmZQ?=
 =?utf-8?B?dFNYbzJ4Tm1HciswOFhuazFpR0JNNHIwT1ZZcUJzSzExWE9HMTIzdGljNEpX?=
 =?utf-8?B?QUFnOVdiS0NRdWJPUCtoRXVFQWJLcjMwWlFsMDVscVczalZUQXNDTUlqTThB?=
 =?utf-8?B?NENkczk3dC8xZGJjNGlzcUZSaVJrVHplRUZlWUFWQ1oyb0VjZz09?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072fdf13-cdba-4994-833c-08dbdb7bd0ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 08:15:03.1413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CzLP9rtdqYRtDj3Frcz1PUdN2PuZn8t6Cj7LRUq0lKL6gOuUxPk5CTeE02WfgEd5g/IcEmYV2XUVylR5IyoGqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11986
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAyLzExLzIwMjMgMTM6NDAsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4+IGlu
ZGV4IDI3ZTg1MDI1NDhhNy4uZDNmYzcwNTk5YjZhIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9i
YXNlL25vZGUuYw0KPj4gKysrIGIvZHJpdmVycy9iYXNlL25vZGUuYw0KPj4gQEAgLTQ5NiwyMCAr
NDk2LDMyIEBAIHN0YXRpYyBERVZJQ0VfQVRUUihtZW1pbmZvLCAwNDQ0LCBub2RlX3JlYWRfbWVt
aW5mbywgTlVMTCk7DQo+PiAgIHN0YXRpYyBzc2l6ZV90IG5vZGVfcmVhZF9udW1hc3RhdChzdHJ1
Y3QgZGV2aWNlICpkZXYsDQo+PiAgIAkJCQkgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRy
LCBjaGFyICpidWYpDQo+PiAgIHsNCj4+ICsJc3RydWN0IHBnbGlzdF9kYXRhICpwZ2RhdCA9IE5P
REVfREFUQShkZXYtPmlkKTsNCj4+ICsJdW5zaWduZWQgbG9uZyBkZW1vdGVfc3JjLCBkZW1vdGVf
ZHN0Ow0KPj4gKw0KPj4gICAJZm9sZF92bV9udW1hX2V2ZW50cygpOw0KPj4gKwlkZW1vdGVfc3Jj
ID0gbm9kZV9wYWdlX3N0YXRlX3BhZ2VzKHBnZGF0LCBQR0RFTU9URV9TUkNfS1NXQVBEKSArDQo+
PiArCQkgICAgIG5vZGVfcGFnZV9zdGF0ZV9wYWdlcyhwZ2RhdCwgUEdERU1PVEVfU1JDX0RJUkVD
VCkgKw0KPj4gKwkJICAgICBub2RlX3BhZ2Vfc3RhdGVfcGFnZXMocGdkYXQsIFBHREVNT1RFX1NS
Q19LSFVHRVBBR0VEKTsNCj4+ICsJZGVtb3RlX2RzdCA9IG5vZGVfcGFnZV9zdGF0ZV9wYWdlcyhw
Z2RhdCwgUEdERU1PVEVfRFNUX0tTV0FQRCkgKw0KPj4gKwkJICAgICBub2RlX3BhZ2Vfc3RhdGVf
cGFnZXMocGdkYXQsIFBHREVNT1RFX0RTVF9ESVJFQ1QpICsNCj4+ICsJCSAgICAgbm9kZV9wYWdl
X3N0YXRlX3BhZ2VzKHBnZGF0LCBQR0RFTU9URV9EU1RfS0hVR0VQQUdFRCk7DQo+PiAgIAlyZXR1
cm4gc3lzZnNfZW1pdChidWYsDQo+PiAgIAkJCSAgIm51bWFfaGl0ICVsdVxuIg0KPj4gICAJCQkg
ICJudW1hX21pc3MgJWx1XG4iDQo+PiAgIAkJCSAgIm51bWFfZm9yZWlnbiAlbHVcbiINCj4+ICAg
CQkJICAiaW50ZXJsZWF2ZV9oaXQgJWx1XG4iDQo+PiAgIAkJCSAgImxvY2FsX25vZGUgJWx1XG4i
DQo+PiAtCQkJICAib3RoZXJfbm9kZSAlbHVcbiIsDQo+PiArCQkJICAib3RoZXJfbm9kZSAlbHVc
biINCj4+ICsJCQkgICJkZW1vdGVfc3JjICVsdVxuIg0KPj4gKwkJCSAgImRlbW90ZV9kc3QgJWx1
XG4iLA0KPiBUaGlzIHN5c2ZzIGZpbGUgaXMgYWxyZWFkeSBhIHRvdGFsIGFidXNlIG9mIHN5c2Zz
IHNvIHBsZWFzZSwgZG8gTk9UIG1ha2UNCj4gaXQgd29yc2UgYnkgYWRkaW5nIG1vcmUgZmllbGRz
LCB0aGF0J3MganVzdCB3cm9uZyBhbmQgc29tZXRoaW5nIEkgY2FuDQo+IG5vdCB0YWtlIGF0IGFs
bCBmb3Igb2J2aW91cyByZWFzb25zLg0KPiANCg0KQWxyaWdodCwgdGhhbmsgeW91IGZvciB5b3Vy
IGZlZWRiYWNrLiBXZSB3aWxsIHJlY29uc2lkZXIgb3RoZXIgb3B0aW9ucyBpZiBuZWNlc3Nhcnku
DQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWg=
