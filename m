Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6EC7CE03E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjJROk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjJROk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:40:26 -0400
Received: from outbound-ip160b.ess.barracuda.com (outbound-ip160b.ess.barracuda.com [209.222.82.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C9B94;
        Wed, 18 Oct 2023 07:40:21 -0700 (PDT)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101]) by mx-outbound16-38.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 18 Oct 2023 14:40:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irzaLHNr04rsW/xJ/q1WdoQbZbkdYm+g55OauV9B0wEfxXTCP52QPeXkNEYs0BRPKl8tuqVWnnBlBV/SY2Yde2FmcoGRlPDYmoLaXn1IOc9SwLHmsUeGuTkMPuW+fPpY5m3aISn6i+hplvleF8wMxC0NJLGCvrcKCNab2R6zyJ3NjHz4PXuRSj662KO0tJIA5pRxcHFOQOO+F+ed8G9XrgK1AeElHz2aviwJc0ihIdDv9OGYNrlLmm9hzq1JC4Qv9GXay/8kGRE0xL17UoK/7apfjemGeEFXJYM/KRMh9dU5Cyyt1aT9uLBf60Mm5bo7JYUTesuG6qqNGeQSq54u+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Oa4W10xZZD6q4EkOEY+KksJzOrNXeKKqKEtLKtYBaE=;
 b=izXdSvnL/bMdSNiA1L+9VCJg/yoj/gisZvDF4T6asbCJGnQ0r7xglihEDx92rVpCPteOO5hw3thWuV8WqbPInByCyrl7yqAdzzY5FaQb6K4VBTOiMziEILUXP6Q4SVp1mgafp+/gOcClhPMBL4KgnDP6bsrXkd5ArU/gKnaTcDlES+6PnzhNyH+Wq27dJqMecb35VH0WHEtJZC7BePP4mZuMi8h6havKYUP4bVpxR2dkEH4znUfmOTv09nvm1GjTK72W95Gye+nuHnS2BTiM+6p4qxVFyEfMIWVxHLTmuUiIEWfEeXTzqY0MGnvUzhbMiOW6ewo4khqu2GfKX/B5AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Oa4W10xZZD6q4EkOEY+KksJzOrNXeKKqKEtLKtYBaE=;
 b=vsVp3Q0G8P5gEOR2Hx6qMdqiKWkMYp2OBxq2CkmEDopuXxJtTz9ojtwLaN+cV7rAZQjLmT74mYndA4q/ijdwLKtlLh+As2dEQyewiycm2KgdM5/xXdYEwCBPlc+HKYNf3f4Dv0DYJTtPDavAh5jPf/d3WAzxngdTRjPHSHloKx8=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by CY8PR19MB7249.namprd19.prod.outlook.com (2603:10b6:930:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 14:40:14 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::b051:b4e4:8a2:33a2]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::b051:b4e4:8a2:33a2%5]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 14:40:14 +0000
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
Thread-Index: AQHaAbRpOYa+0Y8j+kCP04IX3OA3s7BPbDcAgAABw4CAAAGgAIAAKwaAgAAD9wA=
Date:   Wed, 18 Oct 2023 14:40:13 +0000
Message-ID: <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com>
References: <20230904133321.104584-1-git@andred.net>
 <20231018111508.3913860-1-git@andred.net>
 <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com>
 <4b0b46f29955956916765d8d615f96849c8ce3f7.camel@linaro.org>
 <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com>
 <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
In-Reply-To: <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|CY8PR19MB7249:EE_
x-ms-office365-filtering-correlation-id: 77b3784e-3cb5-4748-c583-08dbcfe82353
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Mll6t4HkktRdG3kudVQBBLQlaS6UDsCZSWOUuGwMc8Qec/bTnnYW19iyfwPVUQUREFTsf2mcgklZgy3UxO5t0LhJcXw2LlmhvuP7bGKZxb1DwGp7B/Bpg1mDdGeZf/IvP7v7F0lznFNsywCSDYo3MHiPHappXByM8Gy6rMVQVorD+BmcvQ3VzVYC/YSNmQnGhXnjAgH/q8JuJwx8METIiJtRijGczabBhHZQ3v7BkiNBjKrJTwD31tmC3fPoE5K8jkI9hNoO5RggIciO1BYEP6OgtUi9/XrQa2QHdAub2ot4fn/4a3drPjLPyu/UK+SIBiAki1s6JaixZfyRNpPZAzuaKWu2vNXJyw4i/Ud6bIs3d9zKFz6p7T3/gwg57xEpNHzui1wCh9QlAdd3+K7tUeu0CDhXy+YFmx9JevCN2XhiprG8eH5RiLilouAojmN9O6N1b2sOT/d+aZYuduPvuY0exQMC+x3jMrYMFAxULXJeD3bJhtSJlmP11Bli2d0stwpYWQQvFtDt0llcwHmVnII5nx8FLMhVTDnxCdGOwVpekNGWFHoEGbiazXMq7URy5fmW9c3WqGUPA5dM7on41/MNNYyJ7IEuGftz6lQEc2OqWAy3ix/sQ2muLaIePaK9qEzsPelsF9mJCgnPHNTR3oJp31o7z5Yam+VzJnnjw/55XgtoT9jAGUgVGKt45OjoMIGGJjdB1ZDeV6U/Lx+QA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39850400004)(136003)(376002)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(31686004)(83380400001)(316002)(31696002)(86362001)(36756003)(4326008)(38070700005)(5660300002)(122000001)(4001150100001)(41300700001)(2906002)(6506007)(966005)(66556008)(91956017)(8936002)(8676002)(71200400001)(38100700002)(6486002)(66946007)(53546011)(76116006)(64756008)(66476007)(6512007)(66446008)(54906003)(6916009)(2616005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVRWSlZ2ck05R3RTbVNXVUcyNFBLQml6dytMeVNNRHpqbFpVVEVNb2wvUWE0?=
 =?utf-8?B?YUJNTnBQYUhvV0VmZHpXbkFpVFNPZDVVNmVuMFFIY1VvU05LZ3NscFNmbkFo?=
 =?utf-8?B?b28wVURWN2NJcHJCNkhQOUVpWDdNMFBuaHF1TEl3RC9QSjBEa0RoRVl1NXFZ?=
 =?utf-8?B?QlZMVDl6MEs5VytRRWVTOVRyQ0FXeStYOWg1OW9xMW54T2ZsUVN1YVpLSTB6?=
 =?utf-8?B?S0ZVcHplRUdiVUJzbzl0TWNOdlRwYnlOYlRIY3RtVVoxQzA3dnlVSUl5clNt?=
 =?utf-8?B?WFNjdnNwYmc3VU9oOVg0SHpaQzYveUxXMHo3aHlCZS8ycG1qQUpOUCsrUHpl?=
 =?utf-8?B?cVlkYWZlQ2xyYW1RY05ZUzNkdHpYTXM2d0d0UDh2Z1dXQ0ZGWkxDWkJybksz?=
 =?utf-8?B?TlIxWWFPUVV1YXpweHlJSFNrZ0djWnpOMVZDeHBlOGJlVU5JcUxTSVU0Q3BW?=
 =?utf-8?B?Ym9rMmRXcThYRTJVSFhTNlo1bVUvZ0U2M2pjWEdGMThkQnNTMDNReFkrVE9G?=
 =?utf-8?B?dEtuMHBwMC83MVpRV2xpSENMckRETFJnUEpVdHNiWFRuV0VaZnp6ZDZwSklZ?=
 =?utf-8?B?TFdNSEpmaUJydlJ4a2Q1SkhmaXZHMnJ3WW42TlNaczU2OWhTTHpZd1pNUVR1?=
 =?utf-8?B?TlJGbytuWDlHWGJXbjBWTUJQK2FNbTkzelJIOS80R0YzcDd2TS9JeVc1dHhT?=
 =?utf-8?B?L0tyaVZKOEJRUm1McUwza25pNmo0OW5MeUs4QjBsa1dWSHF4cVMxSzJ2alR0?=
 =?utf-8?B?WURwbzUzTnordG1UQ2JRTXc0L0tZYStDbHJVclZ2VFZ6RDhSQ3hnampKRkZT?=
 =?utf-8?B?UWV5KzZWU1NvcWd1bmVORENIRkxVSFJtYkVtUng4UVZOQ2JBT25EMSt2Qmpp?=
 =?utf-8?B?YVRZckhRUG14RlBUdlZmMWlpT3dOY0F3eldmVS82OVlYb2pzaDJ6V1JmZ2or?=
 =?utf-8?B?dXgzcThHMUZWNURvbTBsWGJZWnBaQVo3eXM5Z1h1M1VFVCtpOWNUZG9UcFow?=
 =?utf-8?B?NEJXTDhqd3JlaFRxbDhJVEovREQ2TTY0NmtWN2hicEdKRk5UcTdiYm85NTZx?=
 =?utf-8?B?VzRKVWh1by85aVo1RWFjbUFteTF6Mk5YcnJWc25BWjV6RlkrZTkzL2dzd2NS?=
 =?utf-8?B?RldpZXV3WXVoZGdsaXliM2lvT2NTVm9sMndyOHhOaXQ1MGhtc3VURktSS1V2?=
 =?utf-8?B?YnJmSDI3UWNaNGtucWNNbThwMHZORGpib082c2hQN3VoazZ0WTZ0Wnl0djVG?=
 =?utf-8?B?RDdBK1NhMjhLK1hRTWJ4M2lYTWZHdXM2OFAxU0hLY3RVV0hkUjdWQWFOMFgx?=
 =?utf-8?B?SDZwbDlWNURHRTNuTk9qOGlwT1hWejZiaS9CM0lvVHZySHBQTW5NTTFIZk9W?=
 =?utf-8?B?QTNGRVRuNkxzbThKOUM0NjNKY3VObDJkcWN4QkZ4TWZ2Z2hhUk5oNzZ0T1VK?=
 =?utf-8?B?ZXhqdGNoSmdBVDREZFZEN0xmSmo0Z1h3d2JNczJyYlFLRjRMUU9TY3JLQUc1?=
 =?utf-8?B?cG92Z3pzRzNCUklXU2hibnVHTjJ0TWxoeUNOb3Jsem5obXFnWTQrdUdUaHZn?=
 =?utf-8?B?WStIV0JqbXpNTHc0OXh5bTdMSWhzQkRWU1I0ZFoxNU85YWkrNFZGaGtMaStk?=
 =?utf-8?B?RWtBYUhoRHY5WHFHUUFQRVhodHMxbDQ4Z2I5YS85bktoSktOSkZLQXdqV3Uy?=
 =?utf-8?B?cTlUbmVHUkJ4NzdoQkZ3UUxYenFOeE43UXJTeXUwTm9PZ05vUXAxa0EwUTkz?=
 =?utf-8?B?b2MvWDc4T1h1bTU4eGc3U21kVnVvVU0vTVVWOU14WGFMNTdyOWgzdE41Qm4r?=
 =?utf-8?B?NFdDWVM1ckh4T2FsazJrS0NXWFVNb0RBL1AyZFMyMUFaejlOeHJGdjUxTnRa?=
 =?utf-8?B?OTJQUU01L3UrV3RnUFdyN1dkQUhLSVkyL3lEdFplSnUvOWhWZklEZUR6U1Fh?=
 =?utf-8?B?UVlObFRhSmhjN1JRWjZ6ck8yM1lubVJoV3U4aHB2dnl0YTd4WURGOGVoTFJa?=
 =?utf-8?B?WXEzMmNYcE9QemFaZ3RTNC9TTDArRDlYTkhUVkZCaGt5NTNFbGhXVTAySjJH?=
 =?utf-8?B?b3lzVTBZTnA0SlpqOFg3bEZvWDFSejVGTjgxZXNFUFU5dXRFV1Bza0gzWElr?=
 =?utf-8?B?WU5yRlcwc0VRdkhjeDlRcEd5Q3RSc3IrYkMwOGgyMUpvRkFZcU14Q2VSWHZU?=
 =?utf-8?Q?eX7AUmvg5JoShOSzVqGBRuU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF08FCD97BAFB044BBD54DDCB4A9D975@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: St/PL7/ao9sJ30TaL/assxvlFTzPNE/H203LXmP2IxRjg5NcPmGIT97LzjsC20hdoUhWy421asSWzEXudhL5cTZek23OGLn2lsi0Ibr6EOZ9Q4ROu02iqo+DEsQH9SD2Nt0fyGt0j1e1/9NRbovMaXIwDm8x4m/yIJCm05jPUkQQhs/1Oi0Xo9LZno9rOppwxDU3AjHyzElsg6+OjVFQeVTLZvqpaKNgzZp5y5hV7yB82n4b47a1a/IMUnbS4l0PdJIpWd+Ikk5p2RPFmbO8Tj1n2s62mJ5TW/QR/EFYqDN4jN0wLQRS++k14NzMyrzw5weThG86WMSnlNf6WgVwjiNwNAkN4NYXUfrwcA6bVhOn4kITBEaWWw67clHdpoXgUqsEhUt9ybeENTZfm//KNuALLReW85KXLjVDhCgJ5ETOnnl5uK97xE2dxSItE0CWsuudZefli/t0fPcM0H0jESXJs0P+f49dmVumPvmiAYwev8zr92GVE88yeZtEu73oOCYFZbNZaPjBtA/wENOZusqtMbgD5we7vQGKQovo8TyxnGGg92XT8UBqsvmdOLcDSvIz/BY4q8PQW6gp8fM/bLED5W7dgwiBZN15f1JHlU7RJ8vsF1rfpNpFo5mjbX4RScrc0xBVB8R403/waX8TilXd2T0gxQ1IhDrb8nJnMb9OaJaB3/IMlki+3RIMO4gMVMrRb+reCiz+PwcA5iGp+4LaCRCmvhuGDpvsbBHKowYWnTZSt8HYVqJi2e1m+gXNrN36WWlwCb7l8VJgMkMUbUW8Ud5YGBpQprFqLnjPRUHWHvpwoZhXTEEYFuRtKj7NNQ5niMJG78KkZFiALxH1o1esx8H7a35QR1Ht78/fLbx2E9eMSvB6gNk+LWiO7K6QAvxxwstVqy6kA6zv9vTzHlqPRTC2XYTppIKXS9wxGqo=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b3784e-3cb5-4748-c583-08dbcfe82353
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 14:40:13.4948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vM0qonKt8oQ9uJm1PW8y1Jc/0iP0EkKmgelGLyph0fiyQzzPrdkRSjHw553TY3eLrzfVmwHOLHY0z1gHzDnVcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7249
X-BESS-ID: 1697640016-104134-12333-3083-1
X-BESS-VER: 2019.1_20231013.1615
X-BESS-Apparent-Source-IP: 104.47.70.101
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYmBgZAVgZQMDHJPMk02TLZOM
        XY3CjVyNA0zcLYOM04zdws1dzM0thSqTYWABmpx4ZBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251526 [from 
        cloudscan16-10.us-east-2b.ess.aws.cudaops.com]
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

T24gMTAvMTgvMjMgMTY6MjYsIEFuZHLDqSBEcmFzemlrIHdyb3RlOg0KPiBPbiBXZWQsIDIwMjMt
MTAtMTggYXQgMTE6NTIgKzAwMDAsIEJlcm5kIFNjaHViZXJ0IHdyb3RlOg0KPj4gT24gMTAvMTgv
MjMgMTM6NDYsIEFuZHLDqSBEcmFzemlrIHdyb3RlOg0KPj4+IE9uIFdlZCwgMjAyMy0xMC0xOCBh
dCAxMTozOSArMDAwMCwgQmVybmQgU2NodWJlcnQgd3JvdGU6DQo+Pj4+IE9uIDEwLzE4LzIzIDEz
OjE1LCBBbmRyw6kgRHJhc3ppayB3cm90ZToNCj4+Pj4+IEZyb206IEFuZHLDqSBEcmFzemlrIDxh
bmRyZS5kcmFzemlrQGxpbmFyby5vcmc+DQo+Pj4+Pg0KPj4+Pj4gVGhpcyByZXZlcnRzIGNvbW1p
dCAzMDY2ZmY5MzQ3NmMzNTY3OWNiMDdhOTdjY2UzN2Q5YmIwNzYzMmZmLg0KPj4+Pj4NCj4+Pj4+
IFRoaXMgcGF0Y2ggYnJlYWtzIGFsbCBleGlzdGluZyB1c2Vyc3BhY2UgYnkgcmVxdWlyaW5nIHVw
ZGF0ZXMNCj4+Pj4+IGFzDQo+Pj4+PiBtZW50aW9uZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLCB3
aGljaCBpcyBub3QgYWxsb3dlZC4NCj4+Pj4+DQo+Pj4+PiBSZXZlcnQgdG8gcmVzdG9yZSBjb21w
YXRpYmlsaXR5IHdpdGggZXhpc3RpbmcgdXNlcnNwYWNlDQo+Pj4+PiBpbXBsZW1lbnRhdGlvbnMu
DQo+Pj4+DQo+Pj4+IFdoaWNoIGZ1c2UgZmlsZSBzeXN0ZW0gZG9lcyBpdCBleGFjdGx5IGJyZWFr
PyBJbiBmYWN0IHRoZXJlDQo+Pj4+IGhhdmVuJ3QNCj4+Pj4gYmVlbg0KPj4+PiBhZGRlZCB0b28g
bWFueSBmbGFncyBhZnRlciAtIHdoYXQgZXhhY3RseSBpcyBicm9rZW4/DQo+Pj4NCj4+PiBUaGUg
b3JpZ2luYWwgcGF0Y2ggYnJva2UgdGhlIGV4aXN0aW5nIGtlcm5lbCA8LT4gdXNlciBBQkkgYnkg
bm93DQo+Pj4gcmVxdWlyaW5nIHVzZXIgc3BhY2UgYXBwbGljYXRpb25zIHRvIHBhc3MgaW4gYW4g
ZXh0cmEgZmxhZy4NCj4+PiBUaGVyZSBhcmUgdmFyaW91cyBzaWRlLWVmZmVjdHMgb2YgdGhpcywg
bGlrZSB1bmJvb3RhYmxlIHN5c3RlbXMsDQo+Pj4ganVzdA0KPj4+IGJlY2F1c2UgdGhlIGtlcm5l
bCB3YXMgdXBkYXRlZC4NCj4+PiBCcmVha2luZyB0aGUgQUJJIGlzIHRoZSBvbmUgdGhpbmcgdGhh
dCBpcyBub3QgYWxsb3dlZC4gVGhpcyBpcyBub3QNCj4+PiBzcGVjaWZpYyB0byBhbnkgcGFydGlj
dWxhciBmdXNlIGZpbGUgc3lzdGVtLg0KPj4NCj4+IEhvdyBleGFjdGx5IGRpZCBpdCBicmVhayBp
dD8NCj4gDQo+IEF0IGxlYXN0IGluIEFuZHJvaWQsIGNyZWF0aW5nIG5ldyBmaWxlcywgb3IgcmVh
ZGluZyBleGlzdGluZyBmaWxlcw0KPiByZXR1cm5zIC1FRkFVTFQNCg0KSG1tLCBjb3VsZCB5b3Ug
cGxlYXNlIHBvaW50IG1lIHRvIHRoZSBjb3JyZXNwb25kaW5nIGFuZHJvaWQgdXNlcnNwYWNlIA0K
bGlicmFyeT8gSSBndWVzcyBpdCBpcyBub3QgdXNpbmcgbGliZnVzZT8gQXQgbGVhc3QgSSB3b3Vs
ZCBsaWtlIHRvIA0KdW5kZXJzdGFuZCB0aGUgaXNzdWUuLi4NCg0KPiANCj4+ICAgVGhlc2UgYXJl
IGZlYXR1cmUgZmxhZ3MgLSBpcyB0aGVyZSByZWFsbHkgYQ0KPj4gZmlsZSBzeXN0ZW0gdGhhdCBy
ZWxpZXMgb24gdGhlc2UgZmxhZyB0byB0aGUgZXh0ZW5kIHRoYXQgaXQgZG9lcyBub3QNCj4+IHdv
cmsgYW55bW9yZT8NCj4gDQo+IEkgZG9uJ3Qga25vdyBlbm91Z2ggYWJvdXQgdGhlIGltcGxlbWVu
dGF0aW9uIGRldGFpbHMsIGJ1dCBldmVuIG91dHNpZGUNCj4gQW5kcm9pZCB1c2VyIHNwYWNlIGhh
ZCB0byBiZSB1cGRhdGVkIGFzIGEgcHJlcmVxdWlzaXRlIGZvciB0aGlzIGtlcm5lbA0KPiBwYXRj
aDoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1ltVUtaUUtOQUdpbXVwdjdAcmVkaGF0
LmNvbS8NCj4gaHR0cHM6Ly9naXRodWIuY29tL2xpYmZ1c2UvbGliZnVzZS9wdWxsLzY2Mg0KPiAN
Cj4gV2hpY2ggbWVhbnMgYW55IG5vbi1BbmRyb2lkIHVzZXIgc3BhY2UgcHJlZGF0aW5nIHRob3Nl
IGNoYW5nZXMgaXNuJ3QNCj4gd29ya2luZyBhbnltb3JlIGVpdGhlci4NCg0KVGhlIHBhdGNoIGlu
IGxpYmZ1c2UgaXMgZnJvbSBtZSwgdGhlcmUgd2FzIG5vdGhpbmcgYnJva2VuLg0KQW5kIEkgZG9u
J3QgdGhpbmsgdGhhdCBhbnkgb2YgdGhlIGFkZGl0aW9uYWwgZmxhZ3MgYWRkZWQgYXJlIGEgDQpf
cmVxdWlyZW1lbnRfIGZvciBsaWJmdXNlIGZpbGUgc3lzdGVtcyB0byB3b3JrLiBJJ20gbm90IHN1
cmUgaWYgREFYIGFuZCANCnRoZSBvdGhlciBmbGFncyBiZWZvcmUgdGhlIHBhdGNoIHdhcyBtZXJn
ZWQgYXJlIGEgX3JlcXVpcmVtZW50XyBmb3IgDQp2aXJ0aW9mc2Qgb3IganVzdCBhIG5pY2UgZmVh
dHVyZSB0byBoYXZlLi4uDQoNCkluIGFueXdheSwgcGxlYXNlIHN0aWxsIGNvbnNpZGVyIHRoYXQg
dXNpbmcgcG9zc2libHkgdW5pbml0aWFsaXplZCBmbGFncyANCmlzIG5vdCBhIGdvb2QgaWRlYSBl
aXRoZXIgYW5kIGNvdWxkIHJhbmRvbWx5IGJyZWFrIHRoaW5ncyBhcyB3ZWxsLg0KDQoNClRoYW5r
cywNCkJlcm5kDQoNCg0K
