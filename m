Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2939F772418
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjHGMcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjHGMcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:32:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F8310FD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:31:58 -0700 (PDT)
X-UUID: 615eddf6351e11eeb20a276fd37b9834-20230807
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=ERdiDKR1TpB4jEwlJvWAXQfuN80G2AXfqNwp/dXfsj8=;
        b=VIcd4y+bB6lNdjAqpSr16WKD6HFr8WfdyFq2ARf4GTD//7wmdwl2j5ech+BNdG7fmpFhRrJVj0RCnsfO8p20ND2F9Y8RyDTxiG0KCo3nqd/dsM0yy0prWt4K7a1E/I+ny1WDuKcFXzX0KX5IkuZD5jdiE74taJqTJ05tv72DWnk=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.30,REQID:8b8ad572-40e7-46a2-bc0e-de2d0edce5d2,IP:0,U
        RL:0,TC:0,Content:0,EDM:25,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS6885AD,AC
        TION:quarantine,TS:125
X-CID-INFO: VERSION:1.1.30,REQID:8b8ad572-40e7-46a2-bc0e-de2d0edce5d2,IP:0,URL
        :0,TC:0,Content:0,EDM:25,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:125
X-CID-META: VersionHash:1fcc6f8,CLOUDID:37b5c6d2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:230807203150SPLK858A,BulkQuantity:0,Recheck:0,SF:19|48|29|28|17,TC:n
        il,Content:1,EDM:5,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_ASC
X-UUID: 615eddf6351e11eeb20a276fd37b9834-20230807
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <john.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 670246248; Mon, 07 Aug 2023 20:31:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 7 Aug 2023 20:31:48 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 7 Aug 2023 20:31:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxZM/7by+ORzcemSuWHYH1FC4KL79p/N1ZVNd+h1PNqNdCvklnuurCiOpgpQCQ/HOUPmJEDx/2sg1y3lhocS+bHCbibFqgYO81mQGW4DCFBrRbdTDCG1RLCui6ONzQCDvvXnRV6Zrz6dTK0NmV4EwZX08lfmzKnlZCS12JQG5+Bhg6AXeyn29C6YZLW7I8zpLpSp8fUKSncRBXW8Q+vMmid5O5z0fRCgLmTXDRiExlWoGvKNrvU7D8lvkA2B2W1xnenniKdxx2SGOW5rXSqBZRe+BUbVybCWw4gPZHgkAXxOVfBEjUpKYW4jY8TuyvRkeek91NQ3xWFVTnMZAtRZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERdiDKR1TpB4jEwlJvWAXQfuN80G2AXfqNwp/dXfsj8=;
 b=h8+MaTWdyBw06rLcaEktYBStALGZBQzqio+rXemwn/lpHRyZw6NockY2bjhw3k1H4x4iTmeIEfV77G9YxydQwmnmEuVhOK/D5n84VGGLliNBvc0Q7SJ0vcHS/LijfE6y0yROtp9Jaf1BCytRB2dcIAyDnmdA3A5ATsfA9EDpbHP7M3FC1G41aDkZqFsoYbtitZlasH4pFHPcTVyCXlJ4cFKfOfKWzJb49w+NHGRZpndvpcq9qlMDu6NYqGnIu2rd4r6QtwZnMkatLQGV/lI8cFW3YknngmXFaEN8x6ElCIOEH4VwVqo/gfdtrOaHg7IyDsCftNgkyKt01mWBOn+olw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERdiDKR1TpB4jEwlJvWAXQfuN80G2AXfqNwp/dXfsj8=;
 b=ZixLSHkiGaBdLjeFgcPyvs4OlyTDS2lDpi7RN99B2sBbjcmbQVQvNgoda2PEB2Q1pC7i6k7VfBm5tafJY760lF6zP1VID0RERrsUDdccPL+l1m7fDypeDpk1vzmvWYdvZskbXsaSYJKRH26q0nMfr/SAkmjZu+O7gzgqeC6Q43k=
Received: from PUZPR03MB5963.apcprd03.prod.outlook.com (2603:1096:301:b3::11)
 by SEYPR03MB7464.apcprd03.prod.outlook.com (2603:1096:101:146::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 12:31:46 +0000
Received: from PUZPR03MB5963.apcprd03.prod.outlook.com
 ([fe80::2b8b:2de2:f8da:155e]) by PUZPR03MB5963.apcprd03.prod.outlook.com
 ([fe80::2b8b:2de2:f8da:155e%4]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 12:31:45 +0000
From:   =?utf-8?B?Sm9obiBIc3UgKOioseawuOe/sCk=?= <John.Hsu@mediatek.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?WGlhb2JpbmcgU2hpICjlj7LlsI/lhbUp?= 
        <Xiaobing.Shi@mediatek.com>,
        =?utf-8?B?Q2h1bmh1aSBMaSAo5p2O5pil6L6JKQ==?= 
        <chunhui.li@mediatek.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        =?utf-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [BUG kernel-5.15] aarch64: __pi_strncmp() out-of-bound error
Thread-Topic: [BUG kernel-5.15] aarch64: __pi_strncmp() out-of-bound error
Thread-Index: AQHZySsgQqgDIB4e4U6us84aKq58SQ==
Date:   Mon, 7 Aug 2023 12:31:45 +0000
Message-ID: <e9f30f7d5b7d72a3521da31ab2002b49a26f542e.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5963:EE_|SEYPR03MB7464:EE_
x-ms-office365-filtering-correlation-id: 4fe5068c-356e-483c-cd6a-08db9742437b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uJ6qw+Vfah9S6pzlqPHROtAldoYkCX+bX87EKTGAGOAS3NY/jGk24fuLXLsQr4YwifeRxVGOpTGBvVoyuvrCSUYl5MmfeyK/I1uB9I89UnxjfmHqHWw4QC8DGePBKxw7RqcoFd8hq2euk2JOOBzE5VAqdESeFJwyAcCUs8lBGOmRxfj4FMPi3zT20XZtmQ5kkFCCguFMi8O84M+1t88HNaYzvds58uu/1mYnv5llF1gZkDpc2nxLL6/gXXkAVB2jZqmeb9tJNkVfmCvKAlJ005Gony1iew6t25awRUkxIfOrHPUK+3lkfGAFaDoMImGwknEjTXAJtE+SJUgOOAY7zWYe1pDqGIBHS9NupTpEOluNalKA6DXgW2sap9wLVmFBwhLxYqKEdOIQeUZOHFskjEg7MMVvrbmhH3c5LIzTxnxEEoIPnB6pFbK0NIbFpWB8IQYyzwsZ+gmBXqRJxaPF8H/B9nsFVUhkwIQH+7IjxYmJ/S60wBvt0PvgKSLG8EndNMgiu+EZduS3fis+2m5h1k7ZSzR5wEfz3rV6MvnuqBxVSQ1E+bM2JY7OFXjmWWYSvqdT8FfstFlVSTAxF74zHF/yT34XXpnObSOzZg+7W5fZ4AsH/F24KtcgzDUFxgkEZlizhv/QSG1RebW9WBoNsNVZ0nGB4Tfly0BQtma1CwErrPVFj2lwAlvOzuS6T/PZM9GBnTDtUDKdJheribm3yfaoDb6VYrUbw+hRim3RTcw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5963.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199021)(186006)(1800799003)(12101799016)(54906003)(478600001)(6486002)(6512007)(6916009)(71200400001)(66556008)(66476007)(26005)(64756008)(91956017)(66446008)(76116006)(66946007)(316002)(4326008)(83380400001)(36756003)(85182001)(2906002)(5660300002)(86362001)(38070700005)(2616005)(38100700002)(6506007)(41300700001)(122000001)(8936002)(8676002)(505234007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dm1wNnM0b0tSckZ5VktwdTFBU084bU1udjFoNHd5TzQ0T0tJWjhTK2o5L2Nz?=
 =?utf-8?B?Zm8vZElud25DNFBwaVJqRnFMUndkVkdmc2hHSzRvZWZKZ3BtUVZZQmJkcEk1?=
 =?utf-8?B?ZUFXeUJkYkNKR3drTGZNbzRUYkVwdWFwZU5VZlhmS3pwU2ZuU2RsZStlcXh1?=
 =?utf-8?B?Wm95dFZWdHVqNEZySk5YV2RwWkVZM1BvTzhIamdIaEQvMXlSQURJN0xVWGdo?=
 =?utf-8?B?NVNzcHBXQzBPakJGZUZ3RWZGWEVDN2RncGpRVWxtRnMvcDNkazFWa0MzZDdZ?=
 =?utf-8?B?bW5jRzlnTE9PZytjQ3l0VFg0TGt2UDVRS3VQY3ljc1FRTHJUUGFKWjZ4UVlw?=
 =?utf-8?B?R1AxTEZaTGtMellER1FENkZWbjRKcDNUNEZYTTM3dVJFa0V3YUcyOWNrcHZ4?=
 =?utf-8?B?Slhkb1Nmbzcxa0hlSml0a25kbUovUitwV2x5bnJLMlVNU1VMeEdEQkhQNkh3?=
 =?utf-8?B?T2RCT2Q2MnU0cXp2N25abDNtZUR1REV2YVJKQVNHK0FiL2xDUDRkdE1BK3hK?=
 =?utf-8?B?bEJUT2JYeTE3ZlBtWGVBWVlORVI3clhHblBkb3RvUWhESHB1bjZEeFl4bHpI?=
 =?utf-8?B?MjYvQncxcDFhV3ZMejdZcHZ1TlEvM2lkSG4rdnNObVVhajl6ME80bjNMMlpN?=
 =?utf-8?B?bmlhSmhRc0pHUWNuei95K0ZkSENYL1ovUGVqQVFxSTFvMkpCajJWVFJDdmMw?=
 =?utf-8?B?aitoYko4cU5nRWlkWWV1a2RiWTk2cDRxRWVZUk12cE12S0JXdHJlaVFlenI0?=
 =?utf-8?B?V05hVWtSUkhYTFBXaVJ1UXh2bDhhaXRFZmRBMTJZZGFiOU5xKzV1d0s3MW45?=
 =?utf-8?B?MXROaXVtaGNyNzBTaklCdU9jNnJZdWhZWTRqZWZvd1F3QkJwZUdnblY2NkhT?=
 =?utf-8?B?d2FlRmcwdGRWa3dsMVpOdUVqemtjOVJCOEVQLzZ3KzNzTEsrSUtxQk11TDJ5?=
 =?utf-8?B?NEdLYURac09QZWVBRzZGUllpYlRuekZnNGFORkpWZks3eVRkaGFqWkVtWmxr?=
 =?utf-8?B?L1l4L1NESE5TSVEzbDZrdmhYZThQd09VRHhCUlVVckdxTG52RjY5MjdFV0g4?=
 =?utf-8?B?bEpPMmZ0eExDd1QyTHo5TzJIRkRkZzNGWWp3TGVLUEwvejBJWjZLWDQ4ZWtG?=
 =?utf-8?B?Y25hSWpUbGMrdlBvQlUvT1plbnJrQ04vcHdEdGw2Z1NRQ2RYSEE4UlNpQzY2?=
 =?utf-8?B?dnNEeVZxa3BacjhzR0pQN0Fwb254TjB4SGRxS3ZSeWRhWFhuMVFFQWY4ejFw?=
 =?utf-8?B?WUltSXpPVjJFeTVwOXJIa0d1MUtCZHlDSDdEL3pPOGNOR1hTcXgrRU84VjZV?=
 =?utf-8?B?MTNwVDdVcG5NMlhaRXlhM0xXWkNha2V2Sm9NeTB6OUZtdTkwL0N4S1ZCNE4y?=
 =?utf-8?B?VFVrWGZpNlh2czN6cUErT2R1RzhuUFlFTUZ2YldjMHNkYi9QVXEvY0k5TURr?=
 =?utf-8?B?eENjOEhnY0o0K1ZnUGZzQWRGY2QxdlpiWHdJaWtKTWo2WEJpOVRmTUpSUkU3?=
 =?utf-8?B?N0kxdTZuUmE4TVNTaW53YzZodmk5bjNwSzFZL1l5MEd3OS9YVVEyV2R0QTky?=
 =?utf-8?B?dmp1R09TVGEzL2ZuOTJHU2xWQXlmTS9Ja3VOYUJVSlEwWTZxUkl5Q1YwNjBS?=
 =?utf-8?B?Y3RueTR3U0c4UEZZTWRRa0xFV0V5Zk5lM2RDeWQ4SXVpWk5GVjZNbzVoL0ov?=
 =?utf-8?B?b1ExekdaczMyS2hUdnB6QWt0Y2NtN2UrQ3JKSWgzNHk0bHc2Ymk5UnNycE5m?=
 =?utf-8?B?Vng0Y3VGRTl4WVRqSzUxMis2Ri9zTmQ5RHhrc3Y2aWNvQW5zZkpIZ0IrS00v?=
 =?utf-8?B?clRFTGdBNVdUUWJnUkdVb0U4c0pkMXAybXdVUERMYUg4SnQzaXNadnV2bkhV?=
 =?utf-8?B?Vmt6bk1XSVlkZVRycXg2ZUlKQXlsajlDd200OXpEY3pLdkxWa0VmaUs4RWJk?=
 =?utf-8?B?S2dYdWVHZkQvSHo1Z05uZ05UK0xOZWNyU3NJd3l4aHpiZXpNTGh4TVhzbXpE?=
 =?utf-8?B?enp6RVFNY21OeUEzUSt4ai9jektxU3lORE44WkozZm9WVGlwVHQ5UUtLbGdD?=
 =?utf-8?B?NTFORHhQa3pHS0JnTEJWbk9JbTRoR2hQUmtmRTBWUDFLcERLSzZkb0ZPOTBS?=
 =?utf-8?B?QitUVVZkeC8yN3RqYmtleDBBcCtET2JTb0Nab0MwVG8xRU1uZTBKU1VWTTFs?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <737CDA5E2B3F3D4EAD39C5C662EFC5F2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5963.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe5068c-356e-483c-cd6a-08db9742437b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 12:31:45.8562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xAL4dweK8QAtsSAsl7otj6GHLUDvajQzZONlNvG+DaQ8j/uZP/Vo7mlq1k9J708hJMWMPSeks8IQKPo6zBBEBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7464
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQVJNIG1haW50YWluZXJzLA0KIA0KV2UgbWV0IHRoaXMgaXNzdWUgdW5kZXIgb3VyIGludGVy
bmFsIHRlc3QuDQpJdCBzZWVtcyB0aGF0IF9fcGlfc3RybmNtcCgpIHJlYWRzIG91dC1vZi1ib3Vu
ZC4NCiANClsgNzQ0NS4yNjgwNDNdWyAgVDM4Ml0gdWV2ZW50ZDogW25hbWU6ZmF1bHQmXVVuYWJs
ZSB0byBoYW5kbGUga2VybmVsDQpwYWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJlc3MgZmZm
ZmZmODAzZmQzZjAwMA0KWyA3NDQ1LjI2ODA3OF1bICBUMzgyXSB1ZXZlbnRkOiBbbmFtZTpmYXVs
dCZdTWVtIGFib3J0IGluZm86DQpbIDc0NDUuMjY4MDg0XVsgIFQzODJdIHVldmVudGQ6IFtuYW1l
OmZhdWx0Jl0gIEVTUiA9IDB4OTYwMDAwMDcNClsgNzQ0NS4yNjgwODldWyAgVDM4Ml0gdWV2ZW50
ZDogW25hbWU6ZmF1bHQmXSAgRUMgPSAweDI1OiBEQUJUIChjdXJyZW50DQpFTCksIElMID0gMzIg
Yml0cw0KWyA3NDQ1LjI2ODA5NV1bICBUMzgyXSB1ZXZlbnRkOiBbbmFtZTpmYXVsdCZdICBTRVQg
PSAwLCBGblYgPSAwDQpbIDc0NDUuMjY4MTAwXVsgIFQzODJdIHVldmVudGQ6IFtuYW1lOmZhdWx0
Jl0gIEVBID0gMCwgUzFQVFcgPSAwDQpbIDc0NDUuMjY4MTA1XVsgIFQzODJdIHVldmVudGQ6IFtu
YW1lOmZhdWx0Jl0gIEZTQyA9IDB4MDc6IGxldmVsIDMNCnRyYW5zbGF0aW9uIGZhdWx0DQpbIDc0
NDUuMjY4MTEwXVsgIFQzODJdIHVldmVudGQ6IFtuYW1lOmZhdWx0Jl1EYXRhIGFib3J0IGluZm86
DQpbIDc0NDUuMjY4MTE1XVsgIFQzODJdIHVldmVudGQ6IFtuYW1lOmZhdWx0Jl0gIElTViA9IDAs
IElTUyA9DQoweDAwMDAwMDA3DQpbIDc0NDUuMjY4MTIwXVsgIFQzODJdIHVldmVudGQ6IFtuYW1l
OmZhdWx0Jl0gIENNID0gMCwgV25SID0gMA0KWyA3NDQ1LjI2ODEyNl1bICBUMzgyXSB1ZXZlbnRk
OiBbbmFtZTpmYXVsdCZdc3dhcHBlciBwZ3RhYmxlOiA0ayBwYWdlcywNCjM5LWJpdCBWQXMsIHBn
ZHA9MDAwMDAwMDA0MjZjNjAwMA0KWyA3NDQ1LjI2ODEzM11bICBUMzgyXSB1ZXZlbnRkOiBbbmFt
ZTpmYXVsdCZdW2ZmZmZmZjgwM2ZkM2YwMDBdDQpwZ2Q9MTgwMDAwMDMyN2ZmNTAwMywgcDRkPTE4
MDAwMDAzMjdmZjUwMDMsIHB1ZD0xODAwMDAwMzI3ZmY1MDAzLA0KcG1kPTE4MDAwMDAzMjdmZWYw
MDMsIHB0ZT0wMDAwMDAwMDAwMDAwMDAwDQpbIDc0NDUuMjY4MTU0XVsgIFQzODJdIHVldmVudGQ6
IFtuYW1lOnRyYXBzJl1JbnRlcm5hbCBlcnJvcjogT29wczoNCjk2MDAwMDA3IFsjMV0gUFJFRU1Q
VCBTTVANClsgNzQ0NS4yNjgyNzhdWyAgVDM4Ml0gdWV2ZW50ZDogW25hbWU6bXJkdW1wJl1LZXJu
ZWwgT2Zmc2V0Og0KMHgyODI1NDAwMDAwIGZyb20gMHhmZmZmZmZjMDA4MDAwMDAwDQpbIDc0NDUu
MjY4Mjg2XVsgIFQzODJdIHVldmVudGQ6IFtuYW1lOm1yZHVtcCZdUEhZU19PRkZTRVQ6IDB4NDAw
MDAwMDANClsgNzQ0NS4yNjgyOTRdWyAgVDM4Ml0gdWV2ZW50ZDogW25hbWU6bXJkdW1wJl1wc3Rh
dGU6IDgyNDAwMDA1IChOemN2DQpkYWlmICtQQU4gLVVBTykNClsgNzQ0NS4yNjgzMDFdWyAgVDM4
Ml0gdWV2ZW50ZDogW25hbWU6bXJkdW1wJl1wYyA6IFsweGZmZmZmZmU4MmQ0MjAyMTBdDQpfX3Bp
X3N0cm5jbXArMHgxYTAvMHgxYzQNClsgNzQ0NS4yNjgzMTBdWyAgVDM4Ml0gdWV2ZW50ZDogW25h
bWU6bXJkdW1wJl1sciA6IFsweGZmZmZmZmU4MmRiZTEyYzBdDQpfX3NlY3VyaXR5X2dlbmZzX3Np
ZCsweDEwMC8weDE2OA0KWyA3NDQ1LjI2ODMxOV1bICBUMzgyXSB1ZXZlbnRkOiBbbmFtZTptcmR1
bXAmXXNwIDogZmZmZmZmYzAwOTdjYjhiMA0K4oCmDQpbIDc0NDUuMjY5MzM3XVsgIFQzODJdIHVl
dmVudGQ6IENQVTogMCBQSUQ6IDM4MiBDb21tOiB1ZXZlbnRkIFRhaW50ZWQ6DQpHIFMgICAgICBX
ICBPRSAgICAgNS4xNS40MS1hbmRyb2lkMTMtOC1nYjFmMWFkNjI4NjI4ICMxDQpbIDc0NDUuMjY5
MzQ3XVsgIFQzODJdIHVldmVudGQ6IEhhcmR3YXJlIG5hbWU6IE1UNjg4NihFTkcpIChEVCkNClsg
NzQ0NS4yNjkzNTRdWyAgVDM4Ml0gdWV2ZW50ZDogQ2FsbCB0cmFjZToNClsgNzQ0NS4yNjkzNTld
WyAgVDM4Ml0gdWV2ZW50ZDogIGR1bXBfYmFja3RyYWNlKzB4MC8weDJhOA0KWyA3NDQ1LjI2OTM3
NF1bICBUMzgyXSB1ZXZlbnRkOiAgZHVtcF9zdGFja19sdmwrMHg3NC8weGE0DQpbIDc0NDUuMjY5
Mzg0XVsgIFQzODJdIHVldmVudGQ6ICBkdW1wX3N0YWNrKzB4MTQvMHgxYw0KWyA3NDQ1LjI2OTM5
MV1bICBUMzgyXSB1ZXZlbnRkOiAgbXJkdW1wX2NvbW1vbl9kaWUrMHgzMmMvMHg1YWMgW21yZHVt
cF0NClsgNzQ0NS4yNjk0NzBdWyAgVDM4Ml0gdWV2ZW50ZDogIGlwYW5pY19kaWUrMHgxYy8weDI4
IFttcmR1bXBdDQpbIDc0NDUuMjY5NTM5XVsgIFQzODJdIHVldmVudGQ6ICBfX2RpZSsweGJjLzB4
MzA4DQpbIDc0NDUuMjY5NTQ4XVsgIFQzODJdIHVldmVudGQ6ICBkaWUrMHhkOC8weDUwMA0KWyA3
NDQ1LjI2OTU1Nl1bICBUMzgyXSB1ZXZlbnRkOiAgZGllX2tlcm5lbF9mYXVsdCsweDk0LzB4YTgN
ClsgNzQ0NS4yNjk1NjVdWyAgVDM4Ml0gdWV2ZW50ZDogIF9fZG9fa2VybmVsX2ZhdWx0KzB4MWQ4
LzB4MjE0DQpbIDc0NDUuMjY5NTcxXVsgIFQzODJdIHVldmVudGQ6ICBkb19iYWRfYXJlYSsweDQw
LzB4MTc0DQpbIDc0NDUuMjY5NTc5XVsgIFQzODJdIHVldmVudGQ6ICBkb190cmFuc2xhdGlvbl9m
YXVsdCsweDQ4LzB4NTQNClsgNzQ0NS4yNjk1ODVdWyAgVDM4Ml0gdWV2ZW50ZDogIGRvX21lbV9h
Ym9ydCsweDNjLzB4MTAwDQpbIDc0NDUuMjY5NTkyXVsgIFQzODJdIHVldmVudGQ6ICBlbDFfYWJv
cnQrMHgzOC8weDU0DQpbIDc0NDUuMjY5NjAyXVsgIFQzODJdIHVldmVudGQ6ICBlbDFoXzY0X3N5
bmNfaGFuZGxlcisweDU0LzB4ODgNClsgNzQ0NS4yNjk2MTBdWyAgVDM4Ml0gdWV2ZW50ZDogIGVs
MWhfNjRfc3luYysweDc4LzB4N2MNClsgNzQ0NS4yNjk2MThdWyAgVDM4Ml0gdWV2ZW50ZDogIF9f
cGlfc3RybmNtcCsweDFhMC8weDFjNA0KWyA3NDQ1LjI2OTYyNl1bICBUMzgyXSB1ZXZlbnRkOiAg
c2VsaW51eF9nZW5mc19nZXRfc2lkKzB4MTE0LzB4MjIwDQpbIDc0NDUuMjY5NjM2XVsgIFQzODJd
IHVldmVudGQ6ICBpbm9kZV9kb2luaXRfd2l0aF9kZW50cnkrMHgzZDAvMHg1OTgNClsgNzQ0NS4y
Njk2NDRdWyAgVDM4Ml0gdWV2ZW50ZDogIHNlbGludXhfZF9pbnN0YW50aWF0ZSsweDFjLzB4MjQN
ClsgNzQ0NS4yNjk2NTJdWyAgVDM4Ml0gdWV2ZW50ZDogIGRfc3BsaWNlX2FsaWFzKzB4NWMvMHgy
ODANClsgNzQ0NS4yNjk2NjJdWyAgVDM4Ml0gdWV2ZW50ZDogIGtlcm5mc19pb3BfbG9va3VwKzB4
ZWMvMHgyMWMNClsgNzQ0NS4yNjk2NzRdWyAgVDM4Ml0gdWV2ZW50ZDogIF9fbG9va3VwX3Nsb3cr
MHhjNC8weDE1MA0KWyA3NDQ1LjI2OTY4NF1bICBUMzgyXSB1ZXZlbnRkOiAgbG9va3VwX3Nsb3cr
MHg0MC8weGYwDQpbIDc0NDUuMjY5NjkwXVsgIFQzODJdIHVldmVudGQ6ICB3YWxrX2NvbXBvbmVu
dCsweDE0NC8weDE2MA0KWyA3NDQ1LjI2OTY5Nl1bICBUMzgyXSB1ZXZlbnRkOiAgbGlua19wYXRo
X3dhbGsrMHgyNWMvMHgzNDQNClsgNzQ0NS4yNjk3MDNdWyAgVDM4Ml0gdWV2ZW50ZDogIHBhdGhf
bG9va3VwYXQrMHg2NC8weDEyMA0KWyA3NDQ1LjI2OTcxMF1bICBUMzgyXSB1ZXZlbnRkOiAgZmls
ZW5hbWVfbG9va3VwKzB4YzQvMHgxYjANClsgNzQ0NS4yNjk3MThdWyAgVDM4Ml0gdWV2ZW50ZDog
IHVzZXJfcGF0aF9hdF9lbXB0eSsweDQ4LzB4YjQNClsgNzQ0NS4yNjk3MjVdWyAgVDM4Ml0gdWV2
ZW50ZDogIGRvX2ZhY2Nlc3NhdCsweGE4LzB4MWYwDQpbIDc0NDUuMjY5NzMyXVsgIFQzODJdIHVl
dmVudGQ6ICBfX2FybTY0X3N5c19mYWNjZXNzYXQrMHgyMC8weDI4DQpbIDc0NDUuMjY5NzM4XVsg
IFQzODJdIHVldmVudGQ6ICBpbnZva2Vfc3lzY2FsbCsweDNjLzB4ZjANClsgNzQ0NS4yNjk3NDZd
WyAgVDM4Ml0gdWV2ZW50ZDogIGVsMF9zdmNfY29tbW9uKzB4ODQvMHhlOA0KWyA3NDQ1LjI2OTc1
M11bICBUMzgyXSB1ZXZlbnRkOiAgZG9fZWwwX3N2YysweDIwLzB4ODQNClsgNzQ0NS4yNjk3NTld
WyAgVDM4Ml0gdWV2ZW50ZDogIGVsMF9zdmMrMHgxYy8weDQ4DQpbIDc0NDUuMjY5NzY2XVsgIFQz
ODJdIHVldmVudGQ6ICBlbDB0XzY0X3N5bmNfaGFuZGxlcisweDdjLzB4ZDgNClsgNzQ0NS4yNjk3
NzNdWyAgVDM4Ml0gdWV2ZW50ZDogIGVsMHRfNjRfc3luYysweDE1Yy8weDE2MA0KIA0KV2UgZm91
bmQgdGhhdCB3ZSBoaXQgdGhpcyBpc3N1ZSB3aGVuIHdlIGNvbXBhcmUgdGhlc2UgdHdvIHN0cmlu
Z3MuDQogDQpfX19fX19fX19fX19fX19fYWRkcmVzc3xfMF9fMV9fMl9fM19fNF9fNV9fNl9fN19f
OF9fOV9fQV9fQl9fQ19fRF9fRV9fRg0KX18gICAwMTIzNDU2Nzg5QUJDREVGDQogICBOU0Q6RkZG
RkZGODAwODlFREEwMHw+MkYgNjQgNjUgNzYgNjkgNjMgNjUgNzMgMkYgNzYgNjkgNzIgNzQgNzUg
NjENCjZDICAvZGV2aWNlcy92aXJ0dWFsDQogICBOU0Q6RkZGRkZGODAwODlFREExMHwgMkYgNjIg
NkMgNkYgNjMgNkIgMkYgMDAgRTAgMDMgMDEgQUEgRTEgMDMgMDINCkFBICAvYmxvY2svLi4uLi4u
Li4uDQogDQpfX19fX19fX19fX19fX19fYWRkcmVzc3xfMF9fMV9fMl9fM19fNF9fNV9fNl9fN19f
OF9fOV9fQV9fQl9fQ19fRF9fRV9fRg0KX18gICAgMDEyMzQ1Njc4OUFCQ0RFRg0KICAgTlNEOkZG
RkZGRjgwM0ZEM0VGRTB8IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDJGIDY0IDY1IDc2
IDY5DQo2MyAgICAuLi4uLi4uLi4uL2RldmljDQogICBOU0Q6RkZGRkZGODAzRkQzRUZGMHwgNjUg
NzM+MkYgNzYgNjkgNzIgNzQgNzUgNjEgNkMgMkYgNkQgNjkgNzMgNjMNCjAwICBlcy92aXJ0dWFs
L21pc2MuDQogICBOU0Q6RkZGRkZGODAzRkQzRjAwMHwgPz8gPz8gPz8gPz8gPz8gPz8gPz8gPz8g
Pz8gPz8gPz8gPz8gPz8gPz8gPz8NCj8/DQogICBOU0Q6RkZGRkZGODAzRkQzRjBFMHwgPz8gPz8g
Pz8gPz8gPz8gPz8gPz8gPz8gPz8gPz8gPz8gPz8gPz8gPz8gPz8NCj8/DQoNCldlIG9ic2VydmUg
dGhlIHNlY29uZCBzdHJpbmcgaXMgcHV0IGF0IHRoZSB0YWlsIG9mIHRoZSBmaXJzdCBwYWdlIGFu
ZA0KdGhlIG5leHQgcGFnZSBpcyB1bnJlYWRhYmxlLg0KVGh1cywgd2UgbWFkZSBhIHNpbXBsZSB0
ZXN0IGFzIGJlbG93IGFuZCBpdCBjYW4gcmVwcm9kdWNlIHRoaXMgaXNzdWUuDQoNCnN0YXRpYyBu
b2lubGluZSB2b2lkIHN0cm5jbXBfdXQodm9pZCkNCnsNCiAgICBpbnQgcmV0ID0gMDsNCiAgICBp
bnQgc2l6ZSA9IDQwOTY7DQogICAgY2hhciAqc3JjMSA9IHZtYWxsb2Moc2l6ZSk7DQogICAgY2hh
ciAqc3JjMiA9IHZtYWxsb2Moc2l6ZSk7DQogICAgY2hhciAqc3RyMSA9ICIvZGV2aWNlcy92aXJ0
dWFsL2Jsb2NrLyI7DQogICAgY2hhciAqc3RyMiA9ICIvZGV2aWNlcy92aXJ0dWFsL21pc2MiOw0K
ICAgIGludCBsZW4xID0gc3RybGVuKHN0cjEpOw0KICAgIGludCBsZW4yID0gc3RybGVuKHN0cjIp
Ow0KICAgIGNoYXIgKnN0cjFfc3RhcnQsICpzdHIyX3N0YXJ0Ow0KDQogICAgcHJfaW5mbygic3Jj
MTogJXB4XG4iLCBzcmMxKTsNCiAgICBwcl9pbmZvKCJzcmMyOiAlcHhcbiIsIHNyYzIpOw0KICAg
IHByX2luZm8oImxlbjEgOiVkLCBsZW4yOiAlZFxuIiwgbGVuMSwgbGVuMik7DQoNCiAgICBtZW1z
ZXQoc3JjMSwgMCwgc2l6ZSk7DQogICAgc3RybmNweSgmc3JjMVtzaXplLWxlbjEtMV0sIHN0cjEs
IGxlbjEpOw0KICAgIG1lbXNldChzcmMyLCAwLCBzaXplKTsNCiAgICBzdHJuY3B5KCZzcmMyW3Np
emUtbGVuMi0xXSwgc3RyMiwgbGVuMik7DQoNCiAgICBzdHIxX3N0YXJ0ID0gc3JjMSArIHNpemUg
LSBsZW4xIC0gMTsNCiAgICBwcl9pbmZvKCJzdHIxX3N0YXJ0OiAlcHgiLCBzdHIxX3N0YXJ0KTsN
CiAgICBzdHIyX3N0YXJ0ID0gc3JjMiArIHNpemUgLSBsZW4yIC0gMTsNCiAgICBwcl9pbmZvKCJz
dHIyX3N0YXJ0OiAlcHgiLCBzdHIyX3N0YXJ0KTsNCiAgICByZXQgPSBzdHJuY21wKHN0cjFfc3Rh
cnQsIHN0cjJfc3RhcnQsIGxlbjEpOw0KICAgIHByX2luZm8oInJldDogJWRcbiIsIHJldCk7DQp9
DQoNCg0KRG9lcyBhbnkgaXNzdWUgZXhpc3QgaW4gX19waV9zdHJuY21wIGluIGtlcm5lbC01LjE1
Pw0KDQpBbnkgc3VnZ2VzdGlvbiBpcyBhcHByZWNpYXRlZC4NCg0KVGhhbmtzLA0KSm9obiBIc3UN
Cg==
