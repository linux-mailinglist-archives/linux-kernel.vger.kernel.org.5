Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECFC7CDB4D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjJRMIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjJRMIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:08:00 -0400
X-Greylist: delayed 1665 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Oct 2023 05:07:58 PDT
Received: from outbound-ip141b.ess.barracuda.com (outbound-ip141b.ess.barracuda.com [209.222.82.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B32511C;
        Wed, 18 Oct 2023 05:07:58 -0700 (PDT)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101]) by mx-outbound18-184.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 18 Oct 2023 12:07:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCXWJoas/pvOGGZNEQf1+Kvo5vx41R9VoiLuRi3Y4sumTO6TCWtIPh55VcsLltMVaWQsdQhq5YP2IyfYGBb+ejr+cpl80p8yCkmAD6FmFLhcHF+c+rmgVTL1MXK77bz3gC8KEOfn2ooM9sRBJ9jDjVKBJCOtaZ+/7avInl4QJD0Z63tYFwqoIBNAqb8+qUgM3xaUz8EbdCtjt7/VOlUsvd6CzfFzVIzVCzJJjhQrfJ561WCg/HHsoagQ9PgDkWdMLxFEqFYVGvCM1yVNwkafd7xiRMNdxf69ksCOV00Blos/t1mOyMKncYpZ/XqQC3JDffA7wlckPk0wn4zQCBMvLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9i7L/ClSwV71Z/t0nhI7KWN4/9ELCqHGIeK8HObTNQ=;
 b=JYuZ4aN9Muno11D7jKM+FBZCEwUE5LIOEPFoYoyNbnTKu2fLI10h0k1/EHxOrTpWC4fOyz7NvmU56TtE0vThocSIggKhNgmT8cKkrQ9JMuGq3AAL6Cb9VLg4ADmePv4tKra/ZE8hXH+KgmhgLaUwPKYztPLBBjLc9C8HrXnwcKZnX7ZenGwoQXWpWmUhU0Dc7W1+ocQjcibRe2bf2Edg5NHJYFPxhO8cOZzk6ZCePttYWSKsnALng110bbUMbLByMj8sC5X/tWorXjX5kaXWpFkbb4d844/+e1K0wKOWs3Ko5YMJTxrolFYIq80uD3lkTFkCI3gXqAIQbXkOwSDGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9i7L/ClSwV71Z/t0nhI7KWN4/9ELCqHGIeK8HObTNQ=;
 b=US9wpuBC+0UQbN3NqHVimDbVUewc4yHHTNkZObR6kmjEPfmtRk0E9QA5NT5BEckMNq6LUX7TiYea8GtG8wKtcFedw91VBx+H4mfOoyHfGuU51q0embfn1LMhC4jvg399I3T2VYQEdUq9AHhV/j1/KNQhNka3YyHtw9+KSKoYEGk=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by MN2PR19MB3840.namprd19.prod.outlook.com (2603:10b6:208:1e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 18 Oct
 2023 11:52:03 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::b051:b4e4:8a2:33a2]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::b051:b4e4:8a2:33a2%5]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 11:52:03 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     =?utf-8?B?QW5kcsOpIERyYXN6aWs=?= <andre.draszik@linaro.org>
CC:     Miklos Szeredi <mszeredi@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set the
 FUSE_INIT_EXT"
Thread-Topic: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set
 the FUSE_INIT_EXT"
Thread-Index: AQHaAbRpOYa+0Y8j+kCP04IX3OA3s7BPbDcAgAABw4CAAAGgAA==
Date:   Wed, 18 Oct 2023 11:52:03 +0000
Message-ID: <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com>
References: <20230904133321.104584-1-git@andred.net>
 <20231018111508.3913860-1-git@andred.net>
 <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com>
 <4b0b46f29955956916765d8d615f96849c8ce3f7.camel@linaro.org>
In-Reply-To: <4b0b46f29955956916765d8d615f96849c8ce3f7.camel@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|MN2PR19MB3840:EE_
x-ms-office365-filtering-correlation-id: f23816bd-7aa6-4c0f-7204-08dbcfd0a50f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uAyTCh6kxNGQAOl7aey2cqY4qlrKxd0ftJDbBcILt/6H/6Nxj/QXwD6vDfayAqv9FCfuNeMj0/adWSNrr8iOgJxoxyH3ovWylFSFWALFCOBsAJaFuaz/qjhK75+WgXwzdSXxehvQXpJFvzq0njIOwxh5uQ4fSMAxYeHGX5zl+spZ4dr7XXpGtU/PaJEAbj15Nxxmfp9ukW8kHHp3MIORfbontfnCH0VhHleMxzF7vh9RxgYoieehVedbsvOwK1mOiOrTrwgYR82H5H3dNx+V0CfOi8Eh+x7/tZybsu394+GMR3hm45Ubd0px+GyH4ACt+EyRnCtD0ZKh6ZeWptFS2nPss5bMp0EqBwpCnUYlD+tid3rF24wUNe46xg6gWXqvh69n9eBXe6GynYcw9NGDraiVk1jh9cy/ZqDKURldfo0HNIHfUsDAC5K16PucO0uAMVy4hSaXJVzkihPAwa5yNjMXkrUlbsIeqqUG7reBwPeU4wtPWTCfiJp8xwTWpR27kanVC6M1skbuVk8hIVpBT4nHhwrbK/m5RIOW4m8uyNBbqWExLTYHpXgTVR4OGDdU6ABlWCTe25dCFQbYRScL/0CchDQCmQxsuq/i5YXN/zgBIpZKmGqadapHLrT1XJDTZjg/8SPZCdF0C72oreH2H8J4QbX79ndGYdejhzQEQ6PPJ5YycDRVpVrcrlzxYE22
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39850400004)(376002)(136003)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(76116006)(31696002)(6486002)(54906003)(91956017)(66946007)(64756008)(66446008)(66476007)(66556008)(41300700001)(6916009)(86362001)(316002)(53546011)(6512007)(6506007)(478600001)(36756003)(5660300002)(8936002)(8676002)(4326008)(4001150100001)(2906002)(38100700002)(122000001)(2616005)(71200400001)(38070700005)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rm1sMHpkV04vbk5ETStuaExPWXNwY0poWFV1dmhaVi9mbWh2bVZPdzl5ZGNi?=
 =?utf-8?B?b1lyZzRvVmJYZzI0T1VQTW9uTThiS0Q4UG54ZHRsZ2dBd2JDRkxxWWpqcFI4?=
 =?utf-8?B?N0c1V0d3M1VQL3NqQVFoK21rMWg2YXBiaFk0c3MxUnJHRmxNc25LY1Q2WTAy?=
 =?utf-8?B?QzBjTXhjei9vWmhoZGs5bmlZMzZESGhHcWRUT2FoczZuODd4SGZtZnUrTHhz?=
 =?utf-8?B?bnA0a1dTbDVYbjhVVDlxYTZaQjU5akpnMEZ3MDFQRmp6UW9lSnFJTHk4NEMw?=
 =?utf-8?B?Ni9RS2RkbDFwLytKZ1lPZzNBVTNBRXBoZkNiTDltTTFXak1ORERnSTlxS1Ni?=
 =?utf-8?B?alV5Q29QMFQra0N5ZnQ3aTA1Z1FnOFFKV0U5bnJYMUg2ejhlS0lWSS9id2NV?=
 =?utf-8?B?Qk1jaHUzYXNTM1Z6L2VvT0IyNXZsL25GMFJnenNNcCtseTBFZFFyMGZTTEFn?=
 =?utf-8?B?WkxBdFVBVU90WUlFNFpJQ2g2ZFdrbExYT2VPQzB0alhKcGs4VlQwaDJiYTFu?=
 =?utf-8?B?RXhvbHd1eThuenhJaHcxR0ErV0lhTlZ5VHpkeVp5NTVSdFB0S3diTHhxYXhH?=
 =?utf-8?B?SmtTakMyMmZYNkZkdks2bFM3VUd5VkxxaTBOSUEwRWhScVI2NW15SXg2VDdW?=
 =?utf-8?B?Z3k0YkZybUthRkxkV0sxamlKQWc5L1FOTW1lTG1ING5YOVVCWXVVOXMvVFBC?=
 =?utf-8?B?YmMxSHpQZWRSUXFIZ0lkYVJmNVAzWTNGaFR0SUcvODErM1dyeUYyUWZLNGI4?=
 =?utf-8?B?OGdkR3JEaDA2cFR0YXh6VWZGeHl3Z2FCalhudm1vZ0pRMWdnZUE0QkZiaVRQ?=
 =?utf-8?B?QUF4Sm9obVZ5emtvdjY5U2FONVI1RWthUmdnekVNWWJZQU94WVprNVFCa1Fs?=
 =?utf-8?B?aWRHS2FvQzhZYzlZTGtONlVUdU1NN1F4U0xsQ2dSMDhsNGVZRzFYUVg1VTlz?=
 =?utf-8?B?QWdtV1NtWW04eWxFNFRvenBTR1JyME1DOXhsLzNERXlTYkxxTXAycVhCb2VL?=
 =?utf-8?B?OGI3MG9SRUtmMElxSi93RVc5c3BWeTU5eWxyUU12N0h0R0F6MEFZdTlKTHgw?=
 =?utf-8?B?dFNUaXpqTy9RcmJ1c3lKMTdvVEdLU2ZUTUJlZHUxa2lPU0wyckp2MU9JUk54?=
 =?utf-8?B?Qzd6SUVmVC82NHlQL012YURxaGhHR1FzVW12bkRJQ0xHd2F0NXdYTEpJNmRV?=
 =?utf-8?B?RTR3dXpUMFlTVE05c010RUl0Rzd5TG1keVo2cUtybHRjNUZadHArY0duYTBG?=
 =?utf-8?B?cE8yRmppc0VEQWZ6MUttNFJQZnRWR1NZaCs5c3dYQW5SNnJXZEluWEM1UGRl?=
 =?utf-8?B?ZWhNNWo4b2xiejNQNGNnbGllZDk2d3hJUUljTWZYL3pwZnR2c2VMekQ4bXRQ?=
 =?utf-8?B?NVYybXgzL0I2TXpKdFoxb0szN2xjKzRESjB5ejFjcy9NL3NrL3FOUVZHYkp5?=
 =?utf-8?B?TytQbjBQcXduSXc5Ym9ZRnM2dWVpMnpVWVNwM2x1N29MSnhIVmpyY1Z1ZHI0?=
 =?utf-8?B?YXJSY09yenI2MWFnSFpzTU02ZVhrR2dlazR2VGZnaktnZTdEUnlaYmZTbWFv?=
 =?utf-8?B?aCtxOW1kbUJjaVdLcmp4WDl3R2V4a29tUE5iZkR5OTZ1RHJsVExxQThQZ0VC?=
 =?utf-8?B?ZUFBODkxMjUxcXA0VHBrT3EvTjk1dW9sZFA4RkY2c3pBUE12V0UrN01EYXdy?=
 =?utf-8?B?aXFGQkFNT25IcGhuNXl3RkFGTmNCeWJqRzZ6dTJwbFFPWUdkaXFvY1IxUk1s?=
 =?utf-8?B?a1JyZ0hGYjg2OWtBZFJnekt0OVVWZmFQcUpvUnBYV2NUeGphYmNIMnEzLzNh?=
 =?utf-8?B?Y00zTEFLRTVjVnBFdlUyMkJabHJtVXc2N1R5ZEMzOUxQK29HUmVkWGJvWi9j?=
 =?utf-8?B?SmxDZ2FHRmtVSTg5VlY4bVdlQUxIRDJTbUhxcFhLYWphM0dMOW45RXY2bXBn?=
 =?utf-8?B?Q2Q3a2pMMDZKaVlJLzIrYlRlZStyTWdsdllaYU1hRGcrUGlqTVh2TFhoMVU0?=
 =?utf-8?B?d0RKdHJzV2Q4M0V3M1RPKzVZOVNuUzNWTnBwVDdKNWZpdGNSTURTak1CNnBp?=
 =?utf-8?B?V084ZCs5MjdjQVdmbUp1blpsTVVqY0VTaWZnOVdlQ0tqNHl0Z3RyeHViYlpG?=
 =?utf-8?B?aVhiNk9EZ1kzVVVoR2hqbzRoclJibS9tK0tLbkhEclFzeWI1K0h3eWlRMUht?=
 =?utf-8?Q?JeHUljpn9/4hxcT7DfHbroQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E828F25128F5B04F910E09A3BDE2F9C3@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lYl39kDAhECu126RXuuobUE2PK+dc7Zeu6ANs5qqlnWnujf8KmvFrIif+ZLYU7AoZYlRcY73ogu1dJRbRhbNd+XfNK8v8e2kcIFbLhyoakPpL78w85Qc7v9sYvYQdMD26h6ZSDo7Shb2Gf1NLpL8hrRb7CdqTQD5shQwUewLRnjs0dE5dir4fpeDq689haiafFjlfk3M1p2WrMz7V/7NBNpqnPOzLBduDkb0DwJJUIVIAlop2LCckYS4SRQBYObdDOxLFmNvbMw5UtBOu8MxCXVyiFCbzMlMUeCLexBdimrmplW+ojLS2W08hc3ZXhgW6OrAdN23fT1KAZI/6idrAeuEx0aS1ajBY1Wxh0/VG+/Gu62iiBwNKbxo35astlWFKrfYtGcQt02EitlydXRsyp7T99FcWo1eVTMGjRWI6NoQXxo6hqGCGXw0ROKHXEiQlbfNs9MhNluVp9Hz+uIDcTyyPn1XpB74E9DLXeoIJCKJo3NoE2SGmODt/OGv3orgKeQrfPahbP1QupWsNivSSVO+TmffkLfR7GHnY7WXEAg+krR0xU0CXaPPZatvMcUcQ7yfBLstW3EG+sb1IbdRyMme0AaBN3zOo4cnHHx/6Ta5CupIUZVqHr48mI5mbftt5rD3wNs6jyEfBmgzLsU1MPQzAyLq26A/P847bcZ8hQx3JdAk+GKQJmoTAzNc65AFE5Le8JlOKOTA0wd4hKLNuiE8/zpRw8IIjBnLXQs0UtEX4tH/apaDnPA6NKRF/6r23HKs0mWfV2wNnXpO3u7CfHj0yim2NqTfhboP1AyE16nyJrJlVReJ0+udLzfzX2XjNFVuFU9nkXWRZW97Tr/2+avV0tmhx6hTiMTY+OD6/fAPGq/AOXI5CrUt+/hx3WLLgrMXp8j79si4bGV847xQT6oMC6+f7F3GKFdCUW3o0dA=
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23816bd-7aa6-4c0f-7204-08dbcfd0a50f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 11:52:03.2143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GIIRZWfwGzAOfnaCS8XWBUlQ8XyVUVp690/HU6Z9SdUT1zJPXWx6AbnYxy1zez6/2w7cQNmqamsUa/wYNJscpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3840
X-OriginatorOrg: ddn.com
X-BESS-ID: 1697630877-104792-12372-520-1
X-BESS-VER: 2019.1_20231013.1615
X-BESS-Apparent-Source-IP: 104.47.70.101
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGlqZAVgZQMMnCKMU40SQlMS
        3NJNHY0iAx2dzc0sQ80cIsxcDcwNRcqTYWAPAsNg5BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251524 [from 
        cloudscan18-189.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTgvMjMgMTM6NDYsIEFuZHLDqSBEcmFzemlrIHdyb3RlOg0KPiBPbiBXZWQsIDIwMjMt
MTAtMTggYXQgMTE6MzkgKzAwMDAsIEJlcm5kIFNjaHViZXJ0IHdyb3RlOg0KPj4gT24gMTAvMTgv
MjMgMTM6MTUsIEFuZHLDqSBEcmFzemlrIHdyb3RlOg0KPj4+IEZyb206IEFuZHLDqSBEcmFzemlr
IDxhbmRyZS5kcmFzemlrQGxpbmFyby5vcmc+DQo+Pj4NCj4+PiBUaGlzIHJldmVydHMgY29tbWl0
IDMwNjZmZjkzNDc2YzM1Njc5Y2IwN2E5N2NjZTM3ZDliYjA3NjMyZmYuDQo+Pj4NCj4+PiBUaGlz
IHBhdGNoIGJyZWFrcyBhbGwgZXhpc3RpbmcgdXNlcnNwYWNlIGJ5IHJlcXVpcmluZyB1cGRhdGVz
IGFzDQo+Pj4gbWVudGlvbmVkIGluIHRoZSBjb21taXQgbWVzc2FnZSwgd2hpY2ggaXMgbm90IGFs
bG93ZWQuDQo+Pj4NCj4+PiBSZXZlcnQgdG8gcmVzdG9yZSBjb21wYXRpYmlsaXR5IHdpdGggZXhp
c3RpbmcgdXNlcnNwYWNlDQo+Pj4gaW1wbGVtZW50YXRpb25zLg0KPj4NCj4+IFdoaWNoIGZ1c2Ug
ZmlsZSBzeXN0ZW0gZG9lcyBpdCBleGFjdGx5IGJyZWFrPyBJbiBmYWN0IHRoZXJlIGhhdmVuJ3QN
Cj4+IGJlZW4NCj4+IGFkZGVkIHRvbyBtYW55IGZsYWdzIGFmdGVyIC0gd2hhdCBleGFjdGx5IGlz
IGJyb2tlbj8NCj4gDQo+IFRoZSBvcmlnaW5hbCBwYXRjaCBicm9rZSB0aGUgZXhpc3Rpbmcga2Vy
bmVsIDwtPiB1c2VyIEFCSSBieSBub3cNCj4gcmVxdWlyaW5nIHVzZXIgc3BhY2UgYXBwbGljYXRp
b25zIHRvIHBhc3MgaW4gYW4gZXh0cmEgZmxhZy4NCj4gVGhlcmUgYXJlIHZhcmlvdXMgc2lkZS1l
ZmZlY3RzIG9mIHRoaXMsIGxpa2UgdW5ib290YWJsZSBzeXN0ZW1zLCBqdXN0DQo+IGJlY2F1c2Ug
dGhlIGtlcm5lbCB3YXMgdXBkYXRlZC4NCj4gQnJlYWtpbmcgdGhlIEFCSSBpcyB0aGUgb25lIHRo
aW5nIHRoYXQgaXMgbm90IGFsbG93ZWQuIFRoaXMgaXMgbm90DQo+IHNwZWNpZmljIHRvIGFueSBw
YXJ0aWN1bGFyIGZ1c2UgZmlsZSBzeXN0ZW0uDQoNCkhvdyBleGFjdGx5IGRpZCBpdCBicmVhayBp
dD8gVGhlc2UgYXJlIGZlYXR1cmUgZmxhZ3MgLSBpcyB0aGVyZSByZWFsbHkgYSANCmZpbGUgc3lz
dGVtIHRoYXQgcmVsaWVzIG9uIHRoZXNlIGZsYWcgdG8gdGhlIGV4dGVuZCB0aGF0IGl0IGRvZXMg
bm90IA0Kd29yayBhbnltb3JlPw0KDQpBbHNvLCByZXZlcnRpbmcgdGhpcyBwYXRjaCBoYXMgdGhl
IHNpZGUgZWZmZWN0IHRoYXQgeW91IGNhbiBhc2sgdGhlIA0Ka2VybmVsIHRvIHVzZSBpbml0aWFs
aXplZCBiaXRzIC0gd2hpY2ggb2J2aW91c2x5IGhhcyBvdGhlciBzaWRlIGVmZmVjdHMuDQoNCg0K
DQpUaGFua3MsDQpCZXJuZA0KDQo=
