Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67837ACF57
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 07:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjIYFIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 01:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjIYFIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:08:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E12CB3;
        Sun, 24 Sep 2023 22:08:14 -0700 (PDT)
X-UUID: 84204d665b6111eea33bb35ae8d461a2-20230925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=RCNucRFZBSnECBuydn5SuFt+fGH6gtP/KSe0DHOgA6o=;
        b=J+np1a+fLZDc6pMS54O3KOEzJwRXfjfNdaL1ly/NpybHkW/epdX6+PYW9GZA4vv5SiY9Cbkehb4hBhLStMII36A7RJuIy5mjJL+v0ZEwgn8y98EW+goJyMxbvnbleQqNZP77Tvyo4BGWcCasNl9dCP5kg/gRxUv9Nwjyo/Kf0wc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:92e02579-beb3-44df-a6fe-c7b51a5a66ed,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:a9e73abf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 84204d665b6111eea33bb35ae8d461a2-20230925
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 373759955; Mon, 25 Sep 2023 13:08:08 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 25 Sep 2023 13:08:06 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 25 Sep 2023 13:08:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tlln1ENzpbyprlbRUH0ecarAqrfh6ozbRmzlOs/nPKRL5k9R+F8zK4E/mvwDBpdRJpnRxEf27qa9QWV/KrHRf+FTeZyM+nnXRNe/OZshjmoHIZaYEk30YUTKRLHOgUTCAEOXNJx3997V8oAkwOIX3FecYaqd7O1nE8zDMExPLnz7LJXhd3FR5HW+blaPD6rV/mJpWV6sN+IW+JfxkbJNMlz1av3F2hQtjG+d28ecPetwLtkdOawayqCrgkG7TNhamSmwn3gyXWb+sURbzPd+rD+X5erQHCRaq6CaoQ8h4wbDdOIuS7EEw7lad6dV07Va0mYb/8FAunHvHWNBmutvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCNucRFZBSnECBuydn5SuFt+fGH6gtP/KSe0DHOgA6o=;
 b=EHUpQwG7i/jKDl2in7yerFXPF/K91wG5THeKDXwwitO1eYuLQYbx9taUPM6kNBhJm1bLpxbvK+bDZIGf19iAmksQSIlr1agtJNIGrM4ItJ+kz/3CCw8FL4XJFFmGoZRpSUnwdLHEhXPNjHTbEQelfyNV86jrqs3rWrU+3qOrN1vqPYKGRqt9wcVYcGr+2XAE7KcN6el3DdHy5xZs+QgDKGGunFzAykm6As45+Qwz2lcevtE2LRGXUXcvulwXANPvfEQsGld3GLJo0YHA7umMwCB3o64l1MySwFVTMAw4Hm+k6Z1v01+Byhv6TCkYamEZtEpdpI/HCrtF4CyVbzOVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCNucRFZBSnECBuydn5SuFt+fGH6gtP/KSe0DHOgA6o=;
 b=giQ2+bclwPSij+ZA9XXsO2q8PTGkD83RvrRIQ/LVWNjCHXVj/HiycijE0ZkWyB22WYOM9m1cxdKbD9PL/zxGVx974hu6JbMC6Gwfp0GnsDuN9+ME895UkQLaabNg5i3clZHPllwmzXnvw3xwWZggMXU/WEpuv8GjV58tsIHI6JI=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB5343.apcprd03.prod.outlook.com (2603:1096:400:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 05:08:04 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 05:08:03 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?RWx2aXMgV2FuZyAo546L5YabKQ==?= <Elvis.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 03/15] soc: mailbox: Add SPR definition for GCE
Thread-Topic: [PATCH 03/15] soc: mailbox: Add SPR definition for GCE
Thread-Index: AQHZ6mV+OMIN5fPo3EKCCvwEF6sInLAou1wAgAJMXQA=
Date:   Mon, 25 Sep 2023 05:08:03 +0000
Message-ID: <d2fee308c86c23e98e99497d2de138e31ad72537.camel@mediatek.com>
References: <20230918192204.32263-1-jason-jh.lin@mediatek.com>
         <20230918192204.32263-4-jason-jh.lin@mediatek.com>
         <797fc698-54d2-4848-3a4d-43ca631eb96d@linaro.org>
In-Reply-To: <797fc698-54d2-4848-3a4d-43ca631eb96d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB5343:EE_
x-ms-office365-filtering-correlation-id: cd4a1745-0269-4892-111d-08dbbd85656b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NfbT6R4BlS463xDVaGhZJJqmz2WNqv0159yQDFCr3Cm1pe6t5slo2U5HH5XUT/ZEZfQKkqoyoxvqo/9/rH0ohubmwla6b/BEL78p2mWuwsNEow0LXhxi31ycsdpXXHPm0w8oQ6B5+Ck5c2H9IBZHKMpOwvw93OwX9Dmwft0eZo0E34CDp7EJo/ocAxYrMHdtmNneNj5yAe8s6C1APM4ev9RQ+GZ+SgUjQRgesx91zLq5nUfIghOjzxH1xoAeDQSvj82XoItjyUAJGnNZlg4sJQRhepcJx+WSSlgjw3nAX4cpZcyKUO0/yPKa0KrZSvcQuk+gOEGPfm6GPNL6fffbEr6HfMtlwo+IqAQLNtxiErwCibFwBfCbEbwYk8BMgWSe7risycxoGwf1FNiIULs3H+S3k0ktognjsuZFKiY6JRJXtZJ9EZMYQDRJ2wnWSB1TBTJZqhkvxpZHwNv0eFrqO/wlthAfmjAGWeyd/kMSujHYDXy68fF8Y4rS+/mErLTxvKLpCBU4v0Du0fQcifw+2T0lKrKc+H6nro52iZZfYMdqG/pjRfUXXuM6Mmdt4uAhEO7HkqOjW645dT5toX5x6JLQBONtO7+fZnRt+xYxjQOh8khg6ImWsS4kEINjrm6232zV44lBERJjnmZHToccStJX1uPfMm8nS+GQ/A5xhZ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(7416002)(54906003)(83380400001)(4744005)(2906002)(5660300002)(316002)(15650500001)(41300700001)(8676002)(8936002)(36756003)(4326008)(85182001)(2616005)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(86362001)(110136005)(91956017)(6486002)(53546011)(6512007)(6506007)(26005)(71200400001)(107886003)(122000001)(38070700005)(38100700002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUU1bVdQRWtmMGR0UzdReVRoTDYvOG1RWlBwdklWVlJjcWNqL2RaaW1QaDVI?=
 =?utf-8?B?Wk5NcCtqclNiUFFXdGxRSC9pbUFOVm1uQm9JZVdDZTliWnpnSFlJUjRjdkJG?=
 =?utf-8?B?YnFYTU9vUVYwOTBLM0J5aitNUlNUYUNFelNZWXlWdWNwZ0p5MlN1bFpEbjlX?=
 =?utf-8?B?UmpoL2NVSXh3bGdFQUttNWhBVG91d2tVOWlEaE9mYmt1amxLOEM5K0RHYWJj?=
 =?utf-8?B?TlRyZXArRkRDYXRYVXNQZXVYQjdpQkJrM1cvVXhBVUV2VHFpU3FUbzhLUkRm?=
 =?utf-8?B?MTJjR0pkdHNYMnlzR1ZPL2JSaHRRYnBLTFRwcVF2TlRXb1NHN1M1RlFDQ2x4?=
 =?utf-8?B?b2FLaU96aHpUVlJoZlR4cmIzOFFpYW1wZVl0dm9SNHBCbG9LemsyU0JVU1o3?=
 =?utf-8?B?czNiOGNQOWowcWF5bFFIK3YrcU9ORXo0bUxkdVJiOHZqTjZZTlY2R3NScWZ1?=
 =?utf-8?B?NFpOemNrd1BzQWNPTGRMK2QzRGdQbWV4T2YvcGpITFY2RkYvcndWa0srVk5a?=
 =?utf-8?B?RzlwbFY4MHFYRFdxQ0YxcWdHcVlBckhlSWNBdUR5WU1MUlNLaitsNWsvdjAr?=
 =?utf-8?B?SHUvVUhzdzUvQUtqZXg1QXZJVWpsSGw2bU41RkJWSnZjWUQ5MXR1UDNNaHlk?=
 =?utf-8?B?ckpCK1pTd2lIOWJSWnBaMUFZMVd1cHczZHBLK3B4SHNYTm8rZUxLazgrWUVO?=
 =?utf-8?B?T1NiOHVqYXFkV3g5UFZ2dHV3NTZ4TWZqaGZ4ZEpWRUpja1NBWjFPMG44Qzli?=
 =?utf-8?B?TXF0T1ZOeTJERzZvcllhSGxtYkhnSnlTc0ZQU1pZclU3c1N6MkQ0K0VaQVdt?=
 =?utf-8?B?SHFyOURhY3FaenJNUjBUSFBnMkJoME9FMGpHSldURlZ1UnhVSjZ3SXZNWFUv?=
 =?utf-8?B?N3N5amk2bW9OQ1lLUnNzUHAzNlZLRWxaenB1K3o2Sk9ubkdhL0E1VTQ5TU5H?=
 =?utf-8?B?Rk85d1lkaWEyZFFnc01nZmoyNWlwc0JackgvMHVmbVhXV3I1Kzl3NkY0dDlB?=
 =?utf-8?B?VHc3YXQ4czlBNGZuUW1oeU90YWJqK3hvNVVDYlRGOGwxUlZZRnJOWThRTDNS?=
 =?utf-8?B?VnQ4cVFsWlVrVjJ5NXFISkNjVGlXU3lYRW0rT0hJQnBHU0traGRtZGpxMm5x?=
 =?utf-8?B?WFhQTDE0dVBjcFh4Z1lIakhObmRscVJJN05hODlrTnR6ZTlybVlBazdNSlVi?=
 =?utf-8?B?b25oTjRUR2tRajlrNjRoaWJia3FMZy8ra0RhakJHdWEwNXRYZ3pFVnBtSm83?=
 =?utf-8?B?M2FXRlltaXJzelFmb3lTNlNZdjcyaEVVTDRIUDBvWHdTRFhRLzUxcjlMSDd4?=
 =?utf-8?B?NmhEdnRZbDI2aW8rK2Z1ZVVGTTNXSE9ZUjFLc3ZKbFRSdzl0YllCc0pjbWZk?=
 =?utf-8?B?QS9wZ0p5OWgwYWFWcW9NZ0lsWW9IQ0N6Wkx1dFJpRXl6NUNyQWFrOVhseXYx?=
 =?utf-8?B?QisrUUxUdkVzbXRtdVR5ZHl5SzF6RjNhSVBnRUNWbmsvaUltRHZlNUFLUEk2?=
 =?utf-8?B?OEJWeEp1ckpPS0tWUTVjVnZSem5TMm5yWm02L3pDNit2dUI1WVJTOEc5Wi9C?=
 =?utf-8?B?OWNGelV2ekMvVzIvZjRIUEhiZkZLK05mbDZIZ1ZlSkkyUDdIcWhJdTM1MjFp?=
 =?utf-8?B?OCtibTFnMnVkaVlUQUhnZVZuaStvcW9iWElFRjVSTFRUam9WU1o1T1E3M1RW?=
 =?utf-8?B?TkhGYm5mdmpHSzl1VERXMkxrcFhUa09FME9CMUp5YWZVaFhYWUZHdGFRYnlV?=
 =?utf-8?B?b1kydkpwZkdRVktpbUg4U2ZvcTJFNkpUcEVLZ1NXT0dMTGxFVGVnQlJ0WlNz?=
 =?utf-8?B?V1R4LytVMzJTeG1Gbm5XUGNZS1VhRnRXL0pRKzJMNGVlc2w2WThncC9HMmJ6?=
 =?utf-8?B?WUx1aEQvVmowUWM1VWlXMWJOSTFlTld2QU0wVVBjT0laajVQLzdqckJvN0hS?=
 =?utf-8?B?UFNROVFjRFd4c0ZDY0dBck1yNlRSczJtN2hmYXdndUZMQjVKZUtuTUVHOWJ2?=
 =?utf-8?B?Uk0yZW1rWDhZSXA2SHVYQmpxN1NvZXAvQVQ0VDlIRXgyQkxmY3VJdkpoWDRv?=
 =?utf-8?B?Y0FNWEhVZ0F3eWRhTEhhR1ZlT1l1UmExOU52aC85MWtHaDdTWnZWTkNseTJC?=
 =?utf-8?B?N0ZsUXErTU1qUmkrM0ZCaGxtS3NPR2FRT1JTWkorTjlQVGFpdi84dUNKbjdP?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F8CFE9E0AF8E447AC6618B5A39EFF48@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4a1745-0269-4892-111d-08dbbd85656b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 05:08:03.2751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OsSweU+SEuTOibWwyhKNnw1CR440hjAOEiR6XBjbar04rCn9OuMeGakIR9N5Ot/odE8z0YTfmcMFfKtVjAbcV0p9J3a2r/nB4Fy+XzngIKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5343
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBTYXQsIDIwMjMt
MDktMjMgYXQgMjA6MDIgKzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ICAJIA0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiAgT24gMTgvMDkvMjAyMyAyMToyMSwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+IEdD
RSBoYXMgc3BlY2lmaWMgcHVycG9zZSByZWdpc3RlcnMsIGFiYnJldmlhdGVkIGFzIFNQUi4NCj4g
PiBDbGllbnQgY2FuIHVzIFNQUiB0byBzdG9yZSBkYXRhIG9yIHByb2dyYW1zLg0KPiA+IA0KPiA+
IEluIENNRFEgZHJpdmVyLCBpdCBhbGxvd3MgY2xpZW50IHRvIFNUT1JFIG9yIExPQUQgZGF0YSBp
bnRvIFNQUi4NCj4gPiBUaGUgdmFsdWUgc3RvcmVkIGluIFNQUiB3aWxsIGJlIGNsZWFyZWQgYWZ0
ZXIgcmVzZXQgR0NFIEhXIHRocmVhZC4NCj4gPiANCj4gPiBUaGVyZSBhcmUgNCBTUFIgKHJlZ2lz
dGVyIGluZGV4IDAgLSAzKSBpbiBldmVyeSBHQ0UgSFcgdGhyZWFkLg0KPiA+IFNQUiBpcyB0aHJl
YWQtaW5kZXBlbmRlbnQgYW5kIEhXIHNlY3VyZSBwcm90ZWN0ZWQuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0t
LQ0KPiA+ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIHwgNSArKysrKw0K
PiANCj4gVGhlcmUgaXMgbm8gdXNlciBvZiB0aGlzLi4uIFdoeSBkbyB5b3UgYWRkIHVudXNlZCBk
ZWZpbmVzPw0KDQpJdCdsbCBiZSB1c2VkIGluIGNtZHFfc2VjX2luc2VydF9iYWNrdXBfY29va2ll
KCkgYXQgW1BBVENIIDEwLzE1XS4NClNob3VsZCBJIG1lcmdlIHRoaXMgcGF0Y2ggaW50byBbUEFU
Q0ggMTAvMTVdPw0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gDQo+IEJlc3QgcmVnYXJk
cywNCj4gS3J6eXN6dG9mDQo+IA0KPiANCg==
