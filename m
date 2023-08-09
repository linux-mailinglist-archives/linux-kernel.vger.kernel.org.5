Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBA77754E2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 10:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjHIIP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 04:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjHIIP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:15:57 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2050.outbound.protection.outlook.com [40.107.9.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B6110F6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 01:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD4Sw6svRNQSiEfSU92c6OpE/FAEaivqMFFeJvhX0euQ8G3w3vwGLa3PrZJCHJycFcFdVMBVcmZnf+sHivu8vsuD24j/mCi4ydlibqJxrPekiIiJoHrByRn15tFdhjuIBkIG3NQqupqgawRrJeOQJXMmWwxrv3wX6XZS8PHl1uCHx1uBY67R0GRMQTxOpqZwYbYJlRyj+qkOkJbt+YiFVd12sA0o3XiyjljCNG4Req5VMj+Dp2ELEXSqTHKKC7M3+2xx1/xx/5Rj5gXSv1NzgUspN2L7AGoQWVQGrq/5MeNDUFtKu2wYTC1AkBdJDnyCM6BSdb71XjO1aKnOJ+jLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJv3uIGNvmIoyZG0mXbPU+O3HfbxrJ+QVixM7piNDKU=;
 b=C05//uAIpqr7jDTx3cQIlu81vIN2FdzJa8bALGM+9JoImHzSAKgyPY3cgVPV1ZklyiFpKgzJPNF3RuWsJzsm9xcbuVap/UOCaMAmc1ich+Q9PH3zaJpDJFHT6IvVzt6c07VC5GcFQ8kAvkVtON6PtivIfHLpiWZWvX4B+l2hXJCflOduX+z9nihxqazTN7APIBwLvfiEdgyoEzNgIML7hjsVP+zjyTTrTjken3eUBfBzne3H06Hu+GzKkvHNmDdADZptMXwuDd7HVISGmf9EvTbWwWWTvrj/UhGGW5HvmOlyph95xK45+eJTr2Q3iuwQYomB7rgsGF5f3vx7h0LYrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJv3uIGNvmIoyZG0mXbPU+O3HfbxrJ+QVixM7piNDKU=;
 b=Da1d0YOnpwJI2okc3F+VHlm7YiB3NvlfjRDlekHxaAj6vLjiEm3WFRFFj3lL/L3PkW8+vBhiJ+BE28AFiJ6u6VJpDU6DXwfa3GSDmbmv8MaHq6bUq8GsvRMcJM53X/l+EDFw6VCrz3nx7LQyCzs/BlENyxuEFkqnu30yNmLk5B9Tx4RZw036tWZqO4aq6BIY6gib/B2xzLhyqyrsWwfZvUgsXgqWWrJifzhA/oRx7hIfq/q7YtEi6KcvNdlaJgkR6ofYD7PKPvwAe0uZ5xyLmiPMrVNdWbIl1C6Gu77FO0rBz22GnyknZxS2pWAgc3bdN82Z1yhqI/XNxvIuGRNHoQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3403.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 08:15:53 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 08:15:53 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Kees Cook <keescook@chromium.org>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        kernel test robot <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rohan McLure <rmclure@linux.ibm.com>
Subject: Re: include/linux/seq_file.h:263:9: warning: 'strncpy' output may be
 truncated copying 4 bytes from a string of length 4
Thread-Topic: include/linux/seq_file.h:263:9: warning: 'strncpy' output may be
 truncated copying 4 bytes from a string of length 4
Thread-Index: AQHZvuq+WiMpYvcmJUupMXxaVx0y5K/htZYA
Date:   Wed, 9 Aug 2023 08:15:53 +0000
Message-ID: <24d66dd2-1ee8-bf2e-376c-61f7e6c1729e@csgroup.eu>
References: <202307251906.lXcLGKvG-lkp@intel.com>
In-Reply-To: <202307251906.lXcLGKvG-lkp@intel.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB3403:EE_
x-ms-office365-filtering-correlation-id: 20c55d19-08ed-47f3-7af5-08db98b0d970
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yXbGwpKADrmq1/t+H7h7fT8jO8miqaDL7W3PfePETpiI0PqVKkxkghgE3n46vhD57u26LiPywU+OffhQYVouK3pjevux6c2S6RZ/oWwRzNdjcXHGtd1/XXpVYtNbCToLsYhUCanJYt0xDqVh2G1NloUUE5cVyu6DdPE6GWJ0IOzdgj4YcUbwz+I9EETE3f4ECU+scUaDK35B47FBY+OUAEIkLCpHBXF0iT1ZuQ1G9NWQvnd9d9hFNGhSy7Z1TfJUz2R2sH0kGjjcPejwjg2WIzXOTRUgucZhZtytFCaRmxmDZ0UMIOxpPl89HiHl1LS0qGiF6lWz7vfXjZXeY2qZ9g2kYVuQBMb68/WptlG7MdSwTJrU7u2HB3CPSUHzPxgwP3WhSlY0Wk4S/CwUgkJD7gz6KlSsro/ThutGaQ5FxNmvt54qld6+jMev0IGTpXLYEtdAhNHUky4fWqIQqB8O3nPzEZzp0anfqAp5HYyKWVJ22HHpT3qTy+/SGTJDw1TlRB9T25iO6RBD7SFbRWvoZzwBeex8uvsk1eMOU3BAyREaXNIrGcTTi4q4aj97wil0v5MxeItly7z69IOXYcl7xc9iXkcffJGNX4GpKFanZPXSW86nmBG0aTgOW7mk7rwsKD7+oJQ2jmsKaPQHh2NWU3kv+shj6yuAV54z6sy3Bdc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(396003)(39850400004)(346002)(186006)(1800799006)(451199021)(31686004)(66574015)(83380400001)(478600001)(122000001)(2616005)(6512007)(966005)(26005)(6506007)(91956017)(64756008)(76116006)(66946007)(66556008)(66476007)(66446008)(41300700001)(8676002)(8936002)(316002)(31696002)(2906002)(4326008)(6916009)(6486002)(71200400001)(36756003)(54906003)(38100700002)(38070700005)(86362001)(5660300002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmlUMWRKVVl0bVFGSVUrdmt4elkrQmRnSTJ3TlFGdnU2cFZ0UUs1NHFKMmhv?=
 =?utf-8?B?MTZuOUNaNjlyVmF5OEhnUXRqV25KOW8zZmcwNEdPRnhwakxHZTlWdXBGMlZ4?=
 =?utf-8?B?dnF0UU9yREdJUXk5bE9qbUVYdkV1WDc5RktKcTJSN1Y5RmZNRXRieHJ5T3Yy?=
 =?utf-8?B?QnI5MVlGMTQwcDBwbGQ2a1poWUdFRWZ1RmxaNDZleVZkTm05Mi9HaE1tTHB0?=
 =?utf-8?B?Y1FsR2hTbHhSdHllYUZmUG1FRHpWWkpGU2plcVdETFJ3YmJXRWJhMXdid2lh?=
 =?utf-8?B?NHdLTGpyRjZTVnRtM29kaEQwazlqQm9yQkwrb1RuaGh4VWRMNXB2czdYTGxo?=
 =?utf-8?B?eEx3dTFzYXhKVEJFQXZpYnMyOVhKYUcwYlJqUWN5ZXoxbXZMNVRKSyt0dXFz?=
 =?utf-8?B?TjZablBLdUZGbDhBdEJTZmxQRXVYWEFaWnp3SkE2aENwUThtMHJJUDM2VTJD?=
 =?utf-8?B?dldNUldNczNoQitJRHcxUFFOVzE2Y241MTFoVmtHbktSSXdzbjRzQTY2blJO?=
 =?utf-8?B?VXQ0SHBtS29sbnNGOU5UVGd0TXNCQVZTTGpaRnpGNDVTTkl6NWtHY1JwZ3ZW?=
 =?utf-8?B?Wk0vbVJMQjg2c0lMWXEyakc3ZkQxTEQ1VWoyV2MrWEhKVGg4SFc4WnhMK1Y4?=
 =?utf-8?B?VG9sVUxnTUVENXhMUExnY1BML0RpT0xsaklLa2I1bmMyR1c3SjgzYUZia00x?=
 =?utf-8?B?TFcvTFhYdmZKV2dhdngzNkNTVXdCQnJPQkVkWnR6MW5pVWhrdXEyd1h0eExM?=
 =?utf-8?B?OGdsbGtrUjZkamJkVzV4S0d3TEpXRXNYYUdQNVZTZ2MvWDJZMSttR0d2Y1Vt?=
 =?utf-8?B?WXdiQUMvcjZqUnQ3WDNYbE1tQk9rY2krVEFYdHorV1p3TXVidjFKcm8vbm1C?=
 =?utf-8?B?cHFndExMR2MwYVRKWXpyYnJXejY2Y1JPcTQ5UmF2Mlhab2c2d250RkhyN2FW?=
 =?utf-8?B?R3RHY1c1S0k5bWRrR2VCdUJRYytPMmdMZnlMMVRJU0NIQURKSU9Zak5oaXlm?=
 =?utf-8?B?TkVUUWQ1RS91VmlOM0RtU2YzT1oyL0hYV3FpWVVWRm82REc4YTRlem01dHkv?=
 =?utf-8?B?aXo0SklYTEE4amJTYnJ2NENzRkxRazJRKzdZa0M1MjFZNkQvNDJSR1d1bFE4?=
 =?utf-8?B?RUZjZXRoVDhHK2lSNWdyb2tQV2hSelJ6ZjgxQTNGSVdxN1RySDhMVVdxcW5G?=
 =?utf-8?B?Zkp5bFJBWlhsMjJXc1hvWGNMK3dnN2ZFMEhjNU9FWXdyRXNRUTJab2JvVGxP?=
 =?utf-8?B?TE5HYUZrQVozRkptMEdmeFNPWkJJOC8wejQ3VEpqMnRVODIxTXZPRGZMdk4v?=
 =?utf-8?B?U1F3dDNpM01NNUlIZnQ5emtyUWowOUgxQXI5d2hqUS8vZTFqTEZMdWhvMFp3?=
 =?utf-8?B?bTNZWTR0bFhrSkRrSTJVNWxOVnlSbWw4YnoxQWJreGg5cmRSRWZ2VUhMbnFn?=
 =?utf-8?B?eEhzdmFlbTYyWm1FMGp1ekJlM0RvdEMxTFp1TDlVd1ZuRVlPZ2lvL2YzQmE3?=
 =?utf-8?B?R2xMM2ZXbWtydlhrdmx1V2Fxa1V5czVWU1JidzBPOHdZSExKN3hOdXJUMWZO?=
 =?utf-8?B?aC8wVW55K1NlbVZPQ2VGMjA2NnZDTVZ6Nmd4cTh3eGh2dUJ0cXpWaytEa1hj?=
 =?utf-8?B?TWRuN1hsNGE0NlIvd296T3ZtQ3djUmV0Njk1WmtBWUdkUXFSTTBHcmFJK1V1?=
 =?utf-8?B?cWFtNklXaHhSRU5tbCtnYmRBNWtMU3ZuM0paQVBhMXBIeDhQQjBHa0tOTmdj?=
 =?utf-8?B?U1RtVnk3N0xVU2hjUVRSMFdSRVVEN3FKelpMbnljUHFRT3UvcVM2c1lLVVNK?=
 =?utf-8?B?eFJab0RUM1p4b2hXNGRyY3haeUZXNGpUTlFQM2dQYzhpN3BSTHhYZmg0RVNq?=
 =?utf-8?B?S09Oald5clNkNEI5QjlVZ09nNHJmR3o1bE5QbCt4TlpkWDNhOERXN04vbThC?=
 =?utf-8?B?dmNVaENBUlo5OUhJMlZIOE56U1gvUWcyY1NlUHlPckxFOUJOQzBXMXFickZN?=
 =?utf-8?B?dDcvaVRWaVIxYStMdXppaEpnNTdpWWtVcW1EMlA1R3N1VkdFQjlaTi9HdTdM?=
 =?utf-8?B?Z3JwMUdTaGNOZCtQNlBibzRleGJhY0ZrVXFYRXBkUjVvYXVOMVk4SkNLR1NW?=
 =?utf-8?B?NVZQMEdZWGl1b3VrQzNWM25SWE5JZmd0aW5sT2s2RjBsdW9TZDNzcWNVTitQ?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5078BE1C881E894A967D841D3DF6AF03@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c55d19-08ed-47f3-7af5-08db98b0d970
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 08:15:53.2194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XJaBnDDNuwiwMjhGQEJE9bmbz9zrNajVMjY4QseHoKC79G8hR6YQC2X6P0itUYb8aPX1c7g2rfAYk+8wWoaASaUUz+Dsk51RKu1X6hRjvHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3403
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS2VlcywNCkxlIDI1LzA3LzIwMjMgw6AgMTM6MjQsIGtlcm5lbCB0ZXN0IHJvYm90IGEgw6lj
cml0wqA6DQoNCj4gSGkgUm9oYW4sDQo+IA0KPiBGWUksIHRoZSBlcnJvci93YXJuaW5nIHdhcyBi
aXNlY3RlZCB0byB0aGlzIGNvbW1pdCwgcGxlYXNlIGlnbm9yZSBpdCBpZiBpdCdzIGlycmVsZXZh
bnQuDQo+IA0KPiB0cmVlOiAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdCBtYXN0ZXINCj4gaGVhZDogICAwYjU1NDdjNTE4
MjdlMDUzY2M3NTRkYjQ3ZDNlYzNlNmMyYzQ1MWQyDQo+IGNvbW1pdDogOTU1NjdmNDZiNGQyMGMw
NDc3NTBhNWUzMDI5NDYxYWZjZGM2NzY5NyBwb3dlcnBjL3szMixib29rM2V9OiBrY3NhbjogRXh0
ZW5kIEtDU0FOIFN1cHBvcnQNCj4gZGF0ZTogICA3IHdlZWtzIGFnbw0KPiBjb25maWc6IHBvd2Vy
cGMtcmFuZGNvbmZpZy1yMDE1LTIwMjMwNzI1IChodHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5
LWNpL2FyY2hpdmUvMjAyMzA3MjUvMjAyMzA3MjUxOTA2LmxYY0xHS3ZHLWxrcEBpbnRlbC5jb20v
Y29uZmlnKQ0KPiBjb21waWxlcjogcG93ZXJwYy1saW51eC1nY2MgKEdDQykgMTIuMy4wDQo+IHJl
cHJvZHVjZTogKGh0dHBzOi8vZG93bmxvYWQuMDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDIzMDcy
NS8yMDIzMDcyNTE5MDYubFhjTEdLdkctbGtwQGludGVsLmNvbS9yZXByb2R1Y2UpDQo+IA0KPiBJ
ZiB5b3UgZml4IHRoZSBpc3N1ZSBpbiBhIHNlcGFyYXRlIHBhdGNoL2NvbW1pdCAoaS5lLiBub3Qg
anVzdCBhIG5ldyB2ZXJzaW9uIG9mDQo+IHRoZSBzYW1lIHBhdGNoL2NvbW1pdCksIGtpbmRseSBh
ZGQgZm9sbG93aW5nIHRhZ3MNCj4gfCBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxr
cEBpbnRlbC5jb20+DQo+IHwgQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVp
bGQtYWxsLzIwMjMwNzI1MTkwNi5sWGNMR0t2Ry1sa3BAaW50ZWwuY29tLw0KDQpOb3Qgc3VyZSB3
aGF0IHRoZSBwcm9ibGVtIGlzLCBJJ3ZlIGxvb2tlZCBhdCBpdCBhdCBldmVyeXRoaW5nIHNlZW1z
IGNvcnJlY3QuDQoNCllvdSB3cm90ZSBzZXFfc2hvd19vcHRpb25fbigpLCBhbnkgaWRlYSB3aGF0
IHRoZSBwcm9ibGVtIGlzID8NCg0KVGhhbmtzDQpDaHJpc3RvcGhlDQoNCg0KDQo+IA0KPiBBbGwg
d2FybmluZ3MgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KToNCj4gDQo+ICAgICBJbiBmaWxlIGlu
Y2x1ZGVkIGZyb20gaW5jbHVkZS9saW51eC9zZXFfZmlsZV9uZXQuaDo1LA0KPiAgICAgICAgICAg
ICAgICAgICAgICBmcm9tIGluY2x1ZGUvbmV0L25ldF9uYW1lc3BhY2UuaDoxOTMsDQo+ICAgICAg
ICAgICAgICAgICAgICAgIGZyb20gaW5jbHVkZS9saW51eC9pbmV0Lmg6NDIsDQo+ICAgICAgICAg
ICAgICAgICAgICAgIGZyb20gZnMvb2NmczIvc3VwZXIuYzoyMToNCj4gICAgIGZzL29jZnMyL3N1
cGVyLmM6IEluIGZ1bmN0aW9uICdvY2ZzMl9zaG93X29wdGlvbnMnOg0KPj4+IGluY2x1ZGUvbGlu
dXgvc2VxX2ZpbGUuaDoyNjM6OTogd2FybmluZzogJ3N0cm5jcHknIG91dHB1dCBtYXkgYmUgdHJ1
bmNhdGVkIGNvcHlpbmcgNCBieXRlcyBmcm9tIGEgc3RyaW5nIG9mIGxlbmd0aCA0IFstV3N0cmlu
Z29wLXRydW5jYXRpb25dDQo+ICAgICAgIDI2MyB8ICAgICAgICAgc3RybmNweSh2YWxfYnVmLCB2
YWx1ZSwgbGVuZ3RoKTsgICAgICAgICAgICAgICAgXA0KPiAgICAgICAgICAgfCAgICAgICAgIF5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gICAgIGZzL29jZnMyL3N1cGVyLmM6MTUx
ODoxNzogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICdzZXFfc2hvd19vcHRpb25fbicNCj4g
ICAgICAxNTE4IHwgICAgICAgICAgICAgICAgIHNlcV9zaG93X29wdGlvbl9uKHMsICJjbHVzdGVy
X3N0YWNrIiwgb3NiLT5vc2JfY2x1c3Rlcl9zdGFjaywNCj4gICAgICAgICAgIHwgICAgICAgICAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+DQo+IA0KPiANCj4gdmltICsvc3RybmNweSArMjYzIGlu
Y2x1ZGUvbGludXgvc2VxX2ZpbGUuaA0KPiANCj4gYTA2OGFjZjJlZTc3NjkgS2VlcyBDb29rIDIw
MTUtMDktMDQgIDI0OQ0KPiBhMDY4YWNmMmVlNzc2OSBLZWVzIENvb2sgMjAxNS0wOS0wNCAgMjUw
ICAvKioNCj4gYTA2OGFjZjJlZTc3NjkgS2VlcyBDb29rIDIwMTUtMDktMDQgIDI1MSAgICogc2Vx
X3Nob3dfb3B0aW9uX24gLSBkaXNwbGF5IG1vdW50IG9wdGlvbnMgd2l0aCBhcHByb3ByaWF0ZSBl
c2NhcGVzDQo+IGEwNjhhY2YyZWU3NzY5IEtlZXMgQ29vayAyMDE1LTA5LTA0ICAyNTIgICAqCQkg
ICAgICAgd2hlcmUgQHZhbHVlIG11c3QgYmUgYSBzcGVjaWZpYyBsZW5ndGguDQo+IGEwNjhhY2Yy
ZWU3NzY5IEtlZXMgQ29vayAyMDE1LTA5LTA0ICAyNTMgICAqIEBtOiB0aGUgc2VxX2ZpbGUgaGFu
ZGxlDQo+IGEwNjhhY2YyZWU3NzY5IEtlZXMgQ29vayAyMDE1LTA5LTA0ICAyNTQgICAqIEBuYW1l
OiB0aGUgbW91bnQgb3B0aW9uIG5hbWUNCj4gYTA2OGFjZjJlZTc3NjkgS2VlcyBDb29rIDIwMTUt
MDktMDQgIDI1NSAgICogQHZhbHVlOiB0aGUgbW91bnQgb3B0aW9uIG5hbWUncyB2YWx1ZSwgY2Fu
bm90IGJlIE5VTEwNCj4gYTA2OGFjZjJlZTc3NjkgS2VlcyBDb29rIDIwMTUtMDktMDQgIDI1NiAg
ICogQGxlbmd0aDogdGhlIGxlbmd0aCBvZiBAdmFsdWUgdG8gZGlzcGxheQ0KPiBhMDY4YWNmMmVl
Nzc2OSBLZWVzIENvb2sgMjAxNS0wOS0wNCAgMjU3ICAgKg0KPiBhMDY4YWNmMmVlNzc2OSBLZWVz
IENvb2sgMjAxNS0wOS0wNCAgMjU4ICAgKiBUaGlzIGlzIGEgbWFjcm8gc2luY2UgdGhpcyB1c2Vz
ICJsZW5ndGgiIHRvIGRlZmluZSB0aGUgc2l6ZSBvZiB0aGUNCj4gYTA2OGFjZjJlZTc3NjkgS2Vl
cyBDb29rIDIwMTUtMDktMDQgIDI1OSAgICogc3RhY2sgYnVmZmVyLg0KPiBhMDY4YWNmMmVlNzc2
OSBLZWVzIENvb2sgMjAxNS0wOS0wNCAgMjYwICAgKi8NCj4gYTA2OGFjZjJlZTc3NjkgS2VlcyBD
b29rIDIwMTUtMDktMDQgIDI2MSAgI2RlZmluZSBzZXFfc2hvd19vcHRpb25fbihtLCBuYW1lLCB2
YWx1ZSwgbGVuZ3RoKSB7CVwNCj4gYTA2OGFjZjJlZTc3NjkgS2VlcyBDb29rIDIwMTUtMDktMDQg
IDI2MiAgCWNoYXIgdmFsX2J1ZltsZW5ndGggKyAxXTsJCQlcDQo+IGEwNjhhY2YyZWU3NzY5IEtl
ZXMgQ29vayAyMDE1LTA5LTA0IEAyNjMgIAlzdHJuY3B5KHZhbF9idWYsIHZhbHVlLCBsZW5ndGgp
OwkJXA0KPiBhMDY4YWNmMmVlNzc2OSBLZWVzIENvb2sgMjAxNS0wOS0wNCAgMjY0ICAJdmFsX2J1
ZltsZW5ndGhdID0gJ1wwJzsJCQkJXA0KPiBhMDY4YWNmMmVlNzc2OSBLZWVzIENvb2sgMjAxNS0w
OS0wNCAgMjY1ICAJc2VxX3Nob3dfb3B0aW9uKG0sIG5hbWUsIHZhbF9idWYpOwkJXA0KPiBhMDY4
YWNmMmVlNzc2OSBLZWVzIENvb2sgMjAxNS0wOS0wNCAgMjY2ICB9DQo+IGEwNjhhY2YyZWU3NzY5
IEtlZXMgQ29vayAyMDE1LTA5LTA0ICAyNjcNCj4gDQo+IDo6Ojo6OiBUaGUgY29kZSBhdCBsaW5l
IDI2MyB3YXMgZmlyc3QgaW50cm9kdWNlZCBieSBjb21taXQNCj4gOjo6Ojo6IGEwNjhhY2YyZWU3
NzY5M2UwYmYzOWQ2ZTA3MTM5YmE3MDRmNDYxYzMgZnM6IGNyZWF0ZSBhbmQgdXNlIHNlcV9zaG93
X29wdGlvbiBmb3IgZXNjYXBpbmcNCj4gDQo+IDo6Ojo6OiBUTzogS2VlcyBDb29rIDxrZWVzY29v
a0BjaHJvbWl1bS5vcmc+DQo+IDo6Ojo6OiBDQzogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxp
bnV4LWZvdW5kYXRpb24ub3JnPg0KPiANCg==
