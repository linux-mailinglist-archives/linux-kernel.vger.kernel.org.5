Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF5F7FA575
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjK0QAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbjK0QAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:00:20 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486AEB4;
        Mon, 27 Nov 2023 08:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701100826; x=1732636826;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=mHMwuEFkgqPuHnCweZy1VSiJ9GbKtb8cY/fnaIisBRc=;
  b=VrW4BmDx2jKarUFs985tClSanEHIq2ZFNrZUSJnYYIntepNEf1LeceFW
   WPW+EEjtFSGqi9NkjY9iydWVna2hDlst/lOxcUTbFTV+cy9JqDilYEQPw
   1QXWq1U54BP+3BTc7FZkVFl9EFQ3qozlg7hP38V7kCCbrqflYEKAyTxmp
   sOOP0I7G85ZIj7saqjEkdqYjum7BaTPVkiebNeomloaXFXGwppvMj0hHG
   J0qrJ9Jl6uZM5AMHDccwSXEdoRTa/vtJvRhKVWaXERqV2yS09Sc1se+ab
   0jit0S5M1d95n+TViCQ3HfvsRhLu+S1SAaa9oC8iAgCGnaIFV8NeLGyOc
   w==;
X-CSE-ConnectionGUID: r/zOYhdLSuSMOG7mPyHSXA==
X-CSE-MsgGUID: drEekEklQMisHBtyPS4dSg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="12613216"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2023 09:00:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Nov 2023 09:00:24 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Nov 2023 09:00:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BX3uuAOkbGxc0vbtfiDXKjdEkTE9S3g8JQXK05h4BpJeZa2XHgABbrTjjVLgp7QD7N+0osWrkxjsSgKphloQH6emYf16DFK5ma7FmWAYfmvYUdTV7x/wnJzTHraU7cixUL9UfiQUgaCGBFdEz+hmQUEnm9qrMHjjDiVpIVFfWoZxPe/wiO4BBJUJPY2dmVJu/GeS26It4yOdJyBjPKQZFvLlWkbz/30cg+Ke9Q2Id7940qTV2qGDG8fWbjKsnm5AvHjpPwKOEYO8jexlRGpifw9v5sZ+461lPdyJm+vJMH7BtXPLKQPAviFV+FL6aZnr2+5zEOO+1nJ/XijSDk9GwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHMwuEFkgqPuHnCweZy1VSiJ9GbKtb8cY/fnaIisBRc=;
 b=DuPGXVkjkRtlffS5zpauyp+aYClY2C6AtepKW7JoJQRQf6H1aRWgHcpYxEe1BhtHW4OmUDBzsv31cETxoFanG3iIYnktM6vo+QnzTJDzH7jx7XO0wDmlAtr2GcJegP/it1GyQUuBpTQ3QrpS5iB/3uM0mI4woUj91RGQgiIrTLdcP4iMhJZxhnzE0IDqSLSrkT1YxGjYMvLl+o/ohhsrK4juT+tknBciUTkV9l5aI3Xx8P1cNoP2VPUaN6P5hex/VmZtU1DrOoQVyVQgN9GkyZJggA5tSq+bwXgBfj57tiXfjbsQgBiGxOIMapvZNObwav45ZOI4y0IyPqdiaW4DUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHMwuEFkgqPuHnCweZy1VSiJ9GbKtb8cY/fnaIisBRc=;
 b=hk4ndUPR6xO74iPbpIlIzsigFsRmH8ZAoLpeIEsXoHWGGs6mRGSpWSGojhyzD7QDapc+8CIbt8ocu4WmE3MNDY2156kNadwdX/9N9Y7CUP3zvI/HcivCbU+FlUoxJAidf9j8p9shuvK3RGjrDmQFwEgW4JiwwDAnMvNdtC5qOmbEMUCjHN+Jt3Sk1kUgRDzH2ZvjFJSV1kuVD2KwV8zxOH6NbbeynjQadhICFxs65uH/+9y8eX8z4Q6dH+xqK09w5ZQNrY9rpJJsz0fk8zRN5nO0DZYXORwNzLDdbi+pl+0Sk747YTrdEyGgdfN6sSiXLU8j1T03htqPyEkN4nFZew==
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 SA3PR11MB7653.namprd11.prod.outlook.com (2603:10b6:806:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 16:00:19 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::ba6d:cd09:d24:48de]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::ba6d:cd09:d24:48de%6]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 16:00:18 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <ramon.nordin.rodriguez@ferroamp.se>, <andrew@lunn.ch>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] net: microchip_t1s: conditional collision detection
Thread-Topic: [PATCH 3/3] net: microchip_t1s: conditional collision detection
Thread-Index: AQHaIR5wk3YgliVBQEuBhfUZ1bg7VLCOU2UA
Date:   Mon, 27 Nov 2023 16:00:18 +0000
Message-ID: <142ce54c-108c-45b4-b886-ce3ca45df9fe@microchip.com>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
 <20231127104045.96722-4-ramon.nordin.rodriguez@ferroamp.se>
In-Reply-To: <20231127104045.96722-4-ramon.nordin.rodriguez@ferroamp.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|SA3PR11MB7653:EE_
x-ms-office365-filtering-correlation-id: c4dfb832-0cc1-421a-9399-08dbef61f3fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zZJSbxCQJfopSE3ozrwOCo6pSBovydikvVVEBElW01y1wWCEilp27I/aU+v72exCbzCc2OzApnLSBvarFOPfe14DVj8SaItD3dRlCAtuVU3qPsqQfIWZFWa1AEJSk2x2Hqv7WRy6VTmSErWVWoevPLh8rBhh6oNWbgC7up3hUYak+NxrNchofoJWarY4QE4IJ1OeK2ccOfPcjYwbNWlGI/yQKJpiNQJed8L8WJKFHZVuF6Z1KdxKu1k3k/Kp5eNIxwlokRs3kUw+jOuc0JlnqRfMqeVtQAyPOHL1Y8tsp6kki6EFq1i1kqq0GxLoMOMlrj8EA7O26XN5tqDVnmMNGodFivbgefZzWbgM3Za+LFUaCJFqItgAsnFFj5oBHfFFaCgsxYm+zz5PblGV06PI0Vs6HSUlokI7lyrkQQG1z07niSBTc+vKx7NwJJsNKlgNZDOzHm8EzCDFM9EBtFPGmrEx+hTtco8GcZ6WsTc6CZrrUVsEh+rFW7o6eHK2DzsxyXMazhazlMsASfHYujy3we9jdyRm/UJStd9wH968/yixPPSNfw6DcrQSS3DNn+KNjL+ErTZH4Cc6pQ+2iseCJveYIDeYf4Vszo+nmprPUC8LdL/hUSuLLZHC/ixu//og2yoMIFSkEVIOkez4Vpb1Rp/UhEjsYAAug9k1coutoRqBoLnHG45ynmLon8YJjFWMDPci6Cquig/qDMxRqyMRj0rLG/nfzS8SGumCEcZ9/w6L7HDoOZnt/ZMVE33UpaP63YCD4Xa88Bicnt+A7p6Mxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(38100700002)(31686004)(122000001)(66574015)(8676002)(8936002)(6506007)(53546011)(6512007)(71200400001)(76116006)(66946007)(316002)(91956017)(66556008)(110136005)(64756008)(66446008)(66476007)(7416002)(86362001)(31696002)(6486002)(5660300002)(478600001)(966005)(41300700001)(36756003)(921008)(2906002)(38070700009)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0lab0xyUFdua0JVWklveWlGa3hSNWxhOURpMDBjVmlHeTd4MEI3dlA3MTZ6?=
 =?utf-8?B?UjgxR3RoRGd4VHY1UnBLbVdFbnRRbWtldlZVMTJFSS9uVTJQVUlkUkJSMkxs?=
 =?utf-8?B?MEd2L09VMzM1U2N5U1RIeDNNNWtRR0V6ZGJHVHkzK0RuNDRMSzNtLzVFOGw1?=
 =?utf-8?B?dmY3NmlGb1ozenlIRlZmaXUzb1pkTU9jTEhOdWE3dHphYTMralYrRFhnZWhr?=
 =?utf-8?B?aEZYbXR6TExRcmE5LzNmcEw5amZHMTA3YStoVTVUbmlrN0NWSnFFdE9Venc5?=
 =?utf-8?B?MFhpaEtQMW5HK1lpbHBWTlVyOWVvSXhsZm5jc1RmZ25EMkp0UVlMUlRyeXl2?=
 =?utf-8?B?OWRndFBmYUl2SFpEall6ek1tNFBvWEJUREY1YUE4a1ZyNVZVYkVPay9Ob0VG?=
 =?utf-8?B?enRmN094bmFxSjdnUE1TK1JIWWVLUVNJcXNBdjM3RGE4WURWWW5Ta1BvelZX?=
 =?utf-8?B?N1B4b1RJTC9QelpPV2VQMUdCanMwd01GMWhMbWhNTDZvTTl1U0NNRkhLZ3Q5?=
 =?utf-8?B?elgvSGtySzBha2ZQZFd4MksyM29UVDYrZW92Z3ZhL09sMEFtY20zUkJNUDdI?=
 =?utf-8?B?ZVl6UlJQcUE0UjFTMUZtak0yUkJjQlVQbGhmOUNGSkZrNEk1SU1uVFBZRFhi?=
 =?utf-8?B?cE5GWGRFM1BaWVhBOGFLeW1sN2VWN1oyS2U0WTh4SThGMFZiTTltMWY2UzBH?=
 =?utf-8?B?d1lkTzkzcWgzcDR2eXo0aDlMVmRNQUNTTmJ5QjhDYTYzWkVOZlk0S3lKRTR1?=
 =?utf-8?B?NDZtM0lqN2hVUG1QbTNENmRZa2xqN25adUxiUFdwUGU4Sk9BYkhMOUk1R1dB?=
 =?utf-8?B?d1hNd2lGS29EOEdUSENrSnZhNHJteGZUaVRGSm5PbDdiR0lpUTVRdW4vc0Fq?=
 =?utf-8?B?Vk5WV28xdkNDd29jNmtxN0p0WGhYYkt6SzVKNC9rMGNrY1c0OTlnR3VQVTRR?=
 =?utf-8?B?Y01Nc2ovcXNXMXpMZzNIZ09JbkJXUVRSeWM1QTZFRlVQTTBKN0pSRkU4TmRm?=
 =?utf-8?B?YnVzZUs5RlE5T2pxaHlpWXpWTUtYc0FyRlhacTU0dWVmM3M3aC9FbndWUEN6?=
 =?utf-8?B?aTlJR3hXYkF0UWw1UmtrclkzTHM2akJhMnBsYlFJVmVkV3A5V2w2T3ZmQXhk?=
 =?utf-8?B?VnVSd1N6Zmpib0ZWc20zVzlhZTNCTFBIeDRSclR0ZnBCT3dqcEdWL3FJSVMz?=
 =?utf-8?B?VzNGREdLa3dmTlUxSVZWZHc3ZW9aWXAxRndrb25WdWVTbkgyRGcrNEZjODl0?=
 =?utf-8?B?UEE1VGFiR2MvSFlOenZtZ0x4RXpINFl1TDBtWTFkTWJ6Z0tRVGo2d1lTSkdX?=
 =?utf-8?B?L0ZpVGhPRTVJRzNmMEpRQnR5WXRxNG1lUGxKRXAyYldzTUFvZGJNdVYyNmVh?=
 =?utf-8?B?ZmRJVUppNlc1WmVNT3hia0VSUUI5MlV0bGdqZHpJaURlcERuWi9tQ3hwb3NX?=
 =?utf-8?B?YWhiSTNDSXNFeGFRRDYwdVFwK1MzaE1OdkNkSzFMc2RVTUpJb1NLRGU3ZnFp?=
 =?utf-8?B?a0pzTHFTczdwZkJpbU9pNGdkZ2ZlUEZEbktwa3dqRlYzMi8zOXpsVmF5ZFl2?=
 =?utf-8?B?eUlHZXZFMThQSkV1VnBkcGxoR2xRVW5yN3p1M0JYc253VHBsTTZneS9xTWlk?=
 =?utf-8?B?K1Y3QnNlNy9zN1dYVVpkNXdVZ0QyVWN1R2hPOS9Xb1BBWmxIenlwOGZzZFdI?=
 =?utf-8?B?eEZHaWlUMGdzOTlUa2lqMGlNekZINUpjYkpEcENla3lFSVlPNUJyOUpObHgr?=
 =?utf-8?B?K21DWWJEWk9pNDgzU3pCTXpFUWFXYzBEVnh5MnVrcUxJN1Bpd2ZqTWxQcmQv?=
 =?utf-8?B?VXJ0K0lIaUZWS2R5WnNOd3hlZG1EZXFneDJHakpsSndjY2huQ0dHaFBOaFp0?=
 =?utf-8?B?OEV1Qm1rZzMycjdsQVVUVGpzaERKaWwxaEhPamxSWEx3ZzdncVpPR0k1eUR2?=
 =?utf-8?B?T09kUS9lcjlPS3JvNVMyR3FJK3A5eTRpNEJIVzU0QWw0NElscnI3Yjh5b0c4?=
 =?utf-8?B?d2ZWaWg0aGJ2UEZSRjVlNndkZHlueHYrblYvL2J5OXQzOGJtQ2dBTDdwYWx2?=
 =?utf-8?B?Mlh3UDM5U1c1eStBNy9vTFV3WWJxdEpjbjVuMjF6V1NlVzlhUlYvbzJKd1Bm?=
 =?utf-8?B?VFZyVm5HZXZsbUk4VU41eFVRaUhTS2E5dGJzdzdxWVZNZXNpM3FlWEJUTVZr?=
 =?utf-8?Q?owC/YjSPFHh/IbXZ3GW4fE0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC09D3F212D4C6478214774FBCB27A30@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4dfb832-0cc1-421a-9399-08dbef61f3fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 16:00:18.6954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dU3bsp6aSjZd/oQSQ0jl8cYvXRNiUODJCpQtdKwsD/jmJRdDsqXod6dDBhYtIEdf9l2E9v6DNo5iKqDvsTo8G1D+NBokpyUDUvWuhUdZl7UlaMGF296y17Nq5kZxxc3P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoaXMgaW1wbGVtZW50YXRpb24gd2FzIGludHJvZHVjZWQgaW4gdGhlIGJlbG93IHBh
dGNoIGl0c2VsZi4NCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjMwNDI2MjA1
MDQ5LnhsZnFsdXp3Y3ZsbTZpaGhAc29mdC1kZXYzLTEvVC8jbTlhNTJiNmMwM2I3ZmE2MzdmNzBh
ZWQzMDZiNTBiNDQyNTkwZTI0YTMNCg0KQXMgaXQgaXMgcmVjb21tZW5kZWQgdG8gZG8gaXQgaW4g
YSBzZXBhcmF0ZSBwYXRjaCBhbmQgYWxzbyB0aGUgDQpkYXRhc2hlZXRzIG9mIExBTjg2N1ggUmV2
LkIxIGFuZCBMQU44NjVYIFJldi5CMCBpbnRlcm5hbCBQSFkgaGF2ZSB0aGVzZSANCnJlZ2lzdGVy
IGlzIHJlc2VydmVkLCB3ZSB3ZXJlIHdvcmtpbmcgZm9yIGEgZmVhc2libGUgc29sdXRpb24gdG8g
DQpkZXNjcmliZSB0aGlzIGZvciBjdXN0b21lciBhbmQgbWFpbmxpbmUuIEJ5IHRoZSB0aW1lIG1h
bnkgb3RoZXIgdGhpbmdzIA0KbWVzc2VkIHVwIGFuZCBjb3VsZG4ndCByZWFjaCB0aGUgbWFpbmxp
bmUgb24gdGltZS4NCg0KV2UgYWxzbyBpbXBsZW1lbnRlZCBMQU44NjdYIFJldi5DMSBzdXBwb3J0
IGFscmVhZHkgaW4gdGhlIGRyaXZlciBhbmQgDQpwdWJsaXNoZWQgaW4gb3VyIHByb2R1Y3Qgc2l0
ZSBhbmQgaW4gdGhlIHByb2Nlc3Mgb2YgcHJlcGFyaW5nIG1haW5saW5lIA0KcGF0Y2hlcy4gQnV0
IHVuZm9ydHVuYXRlbHkgaXQgdG9vayBsaXR0bGUgbW9yZSB0aW1lIHRvIG1ha2UgaXQuDQoNCmh0
dHBzOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2FlbURvY3VtZW50cy9kb2N1bWVudHMv
QUlTL1Byb2R1Y3REb2N1bWVudHMvQ29kZUV4YW1wbGVzL0VWQi1MQU44NjcwLVVTQl9MaW51eF9E
cml2ZXJfMXYwLnppcA0KDQpBbnl3YXksIHRoYW5rIHlvdSBmb3IgdGhlIHN1cHBvcnQuIEdvb2Qg
bHVjayENCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCg0KT24gMjcvMTEvMjMgNDoxMCBw
bSwgUmFtw7NuIE4uUm9kcmlndWV6IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50
IGlzIHNhZmUNCj4gDQo+IEZyb206IFJhbcOzbiBOb3JkaW4gUm9kcmlndWV6IDxyYW1vbi5ub3Jk
aW4ucm9kcmlndWV6QGZlcnJvYW1wLnNlPg0KPiANCj4gVGhpcyBjb21taXQgY29uZGl0aW9uYWxs
eSBzZXRzIHRoZSBjb2xsaXNpb24gZGV0ZWN0aW9uIGJpdCBvbiBsYW44Njd4DQo+IGFuZCBsYW44
NjV4IHBoeXMgb24gY2hhbmdpbmcgUExDQSBlbmFibGVkIG9uL29mZi4gVGhlIGludGVuZGVkIHJl
YWx3b3JsZA0KPiBzY2VuYXJpbyBpcyB0aGF0IGFsbCBub2RlcyBvbiB0aGUgbmV0d29yayBydW4g
dGhlIHNhbWUgc2V0dGluZ3Mgd2l0aA0KPiByZWdhcmRzIHRvIHBsY2EsIGFuZCB3aGVuIHBsY2Eg
aXMgZW5hYmxlZCB0aGUgcGh5c2ljYWwgbGF5ZXIgZ3VhcmFudGVlcw0KPiB0aGF0IG5vIGNvbGxp
c2lvbnMgc2hvdWxkIG9jY3VyLg0KPiBJbiBhIHByYWN0aWNhbCBzZXR0aW5nIHdoZXJlIGl0IHdh
cyB0ZXN0ZWQgcnVubmluZyBvbmUgbm9kZSB3aXRoDQo+IGNvbGxpc2lvbiBkZXRlY3Rpb24gb24g
YW5kIG90aGVyIG9mZiwgdGhlIG5vZGUgd2l0aCBjb2xsaXNpb24gZGV0ZWN0aW9uDQo+IG9uIGRy
b3BwZWQgYSBsb3Qgb2YgcGFja2V0cywgbGVhZGluZyB0byBhIHBvb3IgcGVyZm9ybWluZyBsaW5r
Lg0KPiBXb3J0aCBub3RpbmcgaGVyZSBpcyB0aGF0IHRoZSBwaHlzIGRlZmF1bHQvcmVzZXQgdG8g
cGxjYSBkaXNhYmxlZCBhbmQNCj4gY29sbGlzaW9uIGRldGVjdGlvbiBlbmFibGVkLiBUaHVzIHRo
aXMgY2hhbmdlIHdvdWxkIG9ubHkgaGF2ZSBhbiBlZmZlY3QNCj4gd2hlbiBjaGFuZ2luZyBzZXR0
aW5ncyB2aWEgZXRodG9vbC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJhbcOzbiBOb3JkaW4gUm9k
cmlndWV6IDxyYW1vbi5ub3JkaW4ucm9kcmlndWV6QGZlcnJvYW1wLnNlPg0KPiAtLS0NCj4gICBk
cml2ZXJzL25ldC9waHkvbWljcm9jaGlwX3Qxcy5jIHwgMjkgKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9waHkvbWljcm9jaGlwX3Qxcy5j
IGIvZHJpdmVycy9uZXQvcGh5L21pY3JvY2hpcF90MXMuYw0KPiBpbmRleCBkYjg0ZDg1MGIxNjUu
LjNiMWU4MmVjZGY2OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvcGh5L21pY3JvY2hpcF90
MXMuYw0KPiArKysgYi9kcml2ZXJzL25ldC9waHkvbWljcm9jaGlwX3Qxcy5jDQo+IEBAIC0yMyw4
ICsyMywxMCBAQA0KPiAgICNkZWZpbmUgTEFOODY1WF9SRUdfQ0ZHUEFSQU1fREFUQSAweDAwRDkN
Cj4gICAjZGVmaW5lIExBTjg2NVhfUkVHX0NGR1BBUkFNX0NUUkwgMHgwMERBDQo+ICAgI2RlZmlu
ZSBMQU44NjVYX1JFR19TVFMyIDB4MDAxOQ0KPiArI2RlZmluZSBMQU44NlhYX1JFR19DT0xMSVNJ
T05fREVURUNUIDB4MDA4Nw0KPiANCj4gICAjZGVmaW5lIExBTjg2NVhfQ0ZHUEFSQU1fUkVBRF9F
TkFCTEUgQklUKDEpDQo+ICsjZGVmaW5lIExBTjg2WFhfQ09MTElTSU9OX0RFVEVDVF9FTkFCTEUg
QklUKDE1KQ0KPiANCj4gICAvKiBUaGUgYXJyYXlzIGJlbG93IGFyZSBwdWxsZWQgZnJvbSB0aGUg
Zm9sbG93aW5nIHRhYmxlIGZyb20gQU4xNjk5DQo+ICAgICogQWNjZXNzIE1NRCBBZGRyZXNzIFZh
bHVlIE1hc2sNCj4gQEAgLTM2Myw2ICszNjUsMjcgQEAgc3RhdGljIGludCBsYW44Nnh4X3JlYWRf
c3RhdHVzKHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYpDQo+ICAgICAgICAgIHJldHVybiAwOw0K
PiAgIH0NCj4gDQo+ICtzdGF0aWMgaW50IGxhbjg2eHhfcGxjYV9zZXRfY2ZnKHN0cnVjdCBwaHlf
ZGV2aWNlICpwaHlkZXYsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qg
c3RydWN0IHBoeV9wbGNhX2NmZyAqcGxjYV9jZmcpDQo+ICt7DQo+ICsgICAgICAgaW50IGVycjsN
Cj4gKw0KPiArICAgICAgIGVyciA9IGdlbnBoeV9jNDVfcGxjYV9zZXRfY2ZnKHBoeWRldiwgcGxj
YV9jZmcpOw0KPiArICAgICAgIGlmIChlcnIpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZXJy
Ow0KPiArDQo+ICsgICAgICAgLyogRGlzYWJsZSBjb2xsaXNpb24gZGV0ZWN0IG9uIHRoZSBwaHkg
d2hlbiBQTENBIGlzIGVuYWJsZWQuDQo+ICsgICAgICAgICogTm9pc2UgY2FuIGJlIHBpY2tlZCB1
cCBhcyBhIGZhbHNlIHBvc2l0aXZlIGZvciBjb2xsaXNpb25zDQo+ICsgICAgICAgICogbGVhZGlu
ZyB0byB0aGUgcGh5IGRyb3BwaW5nIGxlZ2l0aW1hdGUgcGFja2V0cy4NCj4gKyAgICAgICAgKiBO
byBjb2xsaXNpb25zIHNob3VsZCBiZSBwb3NzaWJsZSB3aGVuIGFsbCBub2RlcyBhcmUgc2V0dXAN
Cj4gKyAgICAgICAgKiBmb3IgcnVubmluZyBQTENBLg0KPiArICAgICAgICAqLw0KPiArICAgICAg
IHJldHVybiBwaHlfbW9kaWZ5X21tZChwaHlkZXYsIE1ESU9fTU1EX1ZFTkQyLA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICBMQU44NlhYX1JFR19DT0xMSVNJT05fREVURUNULA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICBMQU44NlhYX0NPTExJU0lPTl9ERVRFQ1RfRU5BQkxFLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBwbGNhX2NmZy0+ZW5hYmxlZCA/IDAgOiBMQU44NlhYX0NPTExJ
U0lPTl9ERVRFQ1RfRU5BQkxFKTsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBzdHJ1Y3QgcGh5X2Ry
aXZlciBtaWNyb2NoaXBfdDFzX2RyaXZlcltdID0gew0KPiAgICAgICAgICB7DQo+ICAgICAgICAg
ICAgICAgICAgUEhZX0lEX01BVENIX0VYQUNUKFBIWV9JRF9MQU44NjdYX1JFVkIxKSwNCj4gQEAg
LTM3MSw3ICszOTQsNyBAQCBzdGF0aWMgc3RydWN0IHBoeV9kcml2ZXIgbWljcm9jaGlwX3Qxc19k
cml2ZXJbXSA9IHsNCj4gICAgICAgICAgICAgICAgICAuY29uZmlnX2luaXQgICAgICAgID0gbGFu
ODY3eF9yZXZiMV9jb25maWdfaW5pdCwNCj4gICAgICAgICAgICAgICAgICAucmVhZF9zdGF0dXMg
ICAgICAgID0gbGFuODZ4eF9yZWFkX3N0YXR1cywNCj4gICAgICAgICAgICAgICAgICAuZ2V0X3Bs
Y2FfY2ZnICAgICAgID0gZ2VucGh5X2M0NV9wbGNhX2dldF9jZmcsDQo+IC0gICAgICAgICAgICAg
ICAuc2V0X3BsY2FfY2ZnICAgICAgID0gZ2VucGh5X2M0NV9wbGNhX3NldF9jZmcsDQo+ICsgICAg
ICAgICAgICAgICAuc2V0X3BsY2FfY2ZnICAgICAgID0gbGFuODZ4eF9wbGNhX3NldF9jZmcsDQo+
ICAgICAgICAgICAgICAgICAgLmdldF9wbGNhX3N0YXR1cyAgICA9IGdlbnBoeV9jNDVfcGxjYV9n
ZXRfc3RhdHVzLA0KPiAgICAgICAgICB9LA0KPiAgICAgICAgICB7DQo+IEBAIC0zODEsNyArNDA0
LDcgQEAgc3RhdGljIHN0cnVjdCBwaHlfZHJpdmVyIG1pY3JvY2hpcF90MXNfZHJpdmVyW10gPSB7
DQo+ICAgICAgICAgICAgICAgICAgLmNvbmZpZ19pbml0ICAgICAgICA9IGxhbjg2N3hfcmV2YzFf
Y29uZmlnX2luaXQsDQo+ICAgICAgICAgICAgICAgICAgLnJlYWRfc3RhdHVzICAgICAgICA9IGxh
bjg2eHhfcmVhZF9zdGF0dXMsDQo+ICAgICAgICAgICAgICAgICAgLmdldF9wbGNhX2NmZyAgICAg
ICA9IGdlbnBoeV9jNDVfcGxjYV9nZXRfY2ZnLA0KPiAtICAgICAgICAgICAgICAgLnNldF9wbGNh
X2NmZyAgICAgICA9IGdlbnBoeV9jNDVfcGxjYV9zZXRfY2ZnLA0KPiArICAgICAgICAgICAgICAg
LnNldF9wbGNhX2NmZyAgICAgICA9IGxhbjg2eHhfcGxjYV9zZXRfY2ZnLA0KPiAgICAgICAgICAg
ICAgICAgIC5nZXRfcGxjYV9zdGF0dXMgICAgPSBnZW5waHlfYzQ1X3BsY2FfZ2V0X3N0YXR1cywN
Cj4gICAgICAgICAgfSwNCj4gICAgICAgICAgew0KPiBAQCAtMzkxLDcgKzQxNCw3IEBAIHN0YXRp
YyBzdHJ1Y3QgcGh5X2RyaXZlciBtaWNyb2NoaXBfdDFzX2RyaXZlcltdID0gew0KPiAgICAgICAg
ICAgICAgICAgIC5jb25maWdfaW5pdCAgICAgICAgPSBsYW44NjV4X3JldmIwX2NvbmZpZ19pbml0
LA0KPiAgICAgICAgICAgICAgICAgIC5yZWFkX3N0YXR1cyAgICAgICAgPSBsYW44Nnh4X3JlYWRf
c3RhdHVzLA0KPiAgICAgICAgICAgICAgICAgIC5nZXRfcGxjYV9jZmcgICAgICAgPSBnZW5waHlf
YzQ1X3BsY2FfZ2V0X2NmZywNCj4gLSAgICAgICAgICAgICAgIC5zZXRfcGxjYV9jZmcgICAgICAg
PSBnZW5waHlfYzQ1X3BsY2Ffc2V0X2NmZywNCj4gKyAgICAgICAgICAgICAgIC5zZXRfcGxjYV9j
ZmcgICAgICAgPSBsYW44Nnh4X3BsY2Ffc2V0X2NmZywNCj4gICAgICAgICAgICAgICAgICAuZ2V0
X3BsY2Ffc3RhdHVzICAgID0gZ2VucGh5X2M0NV9wbGNhX2dldF9zdGF0dXMsDQo+ICAgICAgICAg
IH0sDQo+ICAgfTsNCj4gLS0NCj4gMi40MC4xDQo+IA0KPiANCg0K
