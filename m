Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546D67DEB84
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 04:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348344AbjKBDkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 23:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346757AbjKBDkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 23:40:11 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C630AE4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 20:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1698896406; x=1730432406;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4nCdvhjsrwoNMP5FgEk3aV2k3LSjP6d1tRuiTUMaIys=;
  b=WyfR4DBo4BUh93/zkeQ6tnkzxfr2AR8Na+/mcYXJOoS8oqv6GMZ+NcUJ
   s8BqJjN48z1AjiZd7YkcDyNNL1mEvqFMY7VvCWyxJcfuF/qEnH7jq2RiH
   38kiPO4Fot38vw3aY3vxA3ALfKC/L1ilOkRyM1lMcUeUvfbblPfdzZmOv
   CPH1kpjoWj0G/cHDnxf5AFifN7ROTKE4XedQeb0oKIElEQdP/almMWXxV
   02OLjQVrCH+/X9nXDdKvrMEmQ+bhOyDpIrWwv02tdVwCdf9+2oUkKoQNu
   Yzw/dm/6ZgCHtrDz8zPqLYuHf1VUXJtdJpMruj07LzzanaTJi7QtevADM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="12319559"
X-IronPort-AV: E=Sophos;i="6.03,270,1694703600"; 
   d="scan'208";a="12319559"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 12:40:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQedNho9g+DU41bPl9OinUZLgn8qYS7YNzzK9xhGbtF8I7NkmlR2amhgskRGguN98kxQ39a6GG9XGGFI8Tk4Fk/cDD8PaxvU8XPt/7Wux5UXJIuMPLSuA51bJ2AhLSUyE6Avf8I3ENpfMTD9dInx7ewVrHWlAeOIYYeuAbgcLf22BvZeyGEbim1rS+A/z0URx8KX4D+Gyn+UXkdtgnLxpHoDie5Uu6+1DjFwZWBteiI/Sv0V7hE7VKCMHQbJJPvrVfQXTOBE50wVJQfpenJl/Nn1McICkA19O/39u2Ho/+HmlUxZaoP3Ze4CUhkNakjeZkqZM1UuYf9SF39Vnma6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nCdvhjsrwoNMP5FgEk3aV2k3LSjP6d1tRuiTUMaIys=;
 b=GVKJclYahOsZ2EN1ej9+vnpvIvFRGyA0QO5wzOZLXezqNJ4YlC38h1VRaK5akJqf+L8XMIHHkRZLkF5DZUw8feBaPT5exX+xaFWyrzUiJqoQ8C9yH9DjWELSAJddmOCo3uokkh347q+lLiH0EwjOG0PDEiBFiO00TTf3rwppuoYJ4GqSrvgynaqoFa3xmXIyW4hmbRkFYVTvgkbJFhq8AL6cMEThE3Pq2I7qYWTP/Evq/aB20kdWEj8Po+/gOtxRWQSv1j19BPkJxGjwpVmhERLOnMcW1gJCd0Quu6+PrFR8Kl7OX964zfNzOkXxNG4pl5c9bZZweyWWHtZL51GgVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYCPR01MB8040.jpnprd01.prod.outlook.com (2603:1096:400:11f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 03:39:59 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::51e9:b5fa:db90:6c2a]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::51e9:b5fa:db90:6c2a%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 03:39:58 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/4] drivers/base/node: Add demotion_nodes sys
 infterface
Thread-Topic: [PATCH RFC 1/4] drivers/base/node: Add demotion_nodes sys
 infterface
Thread-Index: AQHaDTg+8WEYMUmyx0WBKXqinoE2/bBmXHiXgAADMoQ=
Date:   Thu, 2 Nov 2023 03:39:58 +0000
Message-ID: <OS0PR01MB5442868460921E488B525176A5A6A@OS0PR01MB5442.jpnprd01.prod.outlook.com>
References: <20231102025648.1285477-1-lizhijian@fujitsu.com>
        <20231102025648.1285477-2-lizhijian@fujitsu.com>
 <878r7g3ktj.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <878r7g3ktj.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-11-02T03:39:58.673Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYCPR01MB8040:EE_
x-ms-office365-filtering-correlation-id: c995e8cf-b4ae-4d05-2835-08dbdb556355
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J2S3BFoNrABE9gt0TWgCTGzJdT4+WmzrZmoFTNDNvEwQvuRNXXyiVMcyEXpf2gsWjeBdFC771dMC7ZPT19oQOD6C9DTyxQJberKUZsUAAxIgMVl8T0p9Oxj7ltnVmUlArB8NXGCs4CjY2m1kIg58s8+KG/2SV/iankmMIgEw+b2TcSq1PjOuafMVq1+vmGyCg3Ldvvaw+kvcPszqWdYTQbPvZZD/1QN1wYR6Vd4cps7U8d6wdSKvo8feWLj5A8QyYgO3i4s2rwHUeStVcVkV3mjkbAsFySWiF3l75esOjbSbNCr9YgW3F6vcEFXDc1n/JtMs+RQv19PArFsifUsgDUBduc7jwLp2fY0Mi4XCmOE2YVUKVURZTVe9sJXzyEHGLf44KbKD5DO0jyCqSw79IzwzAHCAJAAKo7MFeCcztxak9uuPm36XtUs9zUkzvWxxzyahvlW/kIFsVhyjEJ6ECJc2Z69kXf+bbY5HJbaEY2fRyLbtd6Lm7cb70UPamb35owC/Q7x6TPRZtvoJMyXpIhaOFZyE6NI2Q3yyHApP3vHuX7mNtnkyYsgVvLcATAbxoVQ/vjWK7ktqXgJLpW/NksLsAhQoJAQOE8KxPUbSMCqvl0nmiIoMNv9Dp4J1yO+Cqh465a5pB04/WD3JXxZrCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799009)(1590799021)(64100799003)(122000001)(86362001)(85182001)(82960400001)(33656002)(38070700009)(55016003)(2906002)(26005)(9686003)(478600001)(8936002)(8676002)(41300700001)(45080400002)(52536014)(53546011)(4326008)(6506007)(1580799018)(7696005)(71200400001)(76116006)(316002)(64756008)(83380400001)(6916009)(91956017)(66476007)(66446008)(5660300002)(38100700002)(66946007)(54906003)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VU9MM0l2aGNnVTZuRHpHaExXUGxGeTl3b0k1cnh4TmlLWXpnRFY4V3p5K1U4?=
 =?gb2312?B?Tjh5UDcrN2JIb1pTRUhpaWlPeFJzN1YxNkJjQVNWTjlLZmNIWnpJcm9vdHNr?=
 =?gb2312?B?ZEcwMm04cGdML2syaHBtSnpxbFpKZy83dU4rRDdHRzE2aW5kVnhEMkFxZGRS?=
 =?gb2312?B?Z1FEY0tYY2tTM2RXZXhlSHhkOWFhdTdnRmp6ek1ZMCtmY0VBNWVqT2hBUWVs?=
 =?gb2312?B?RFZIcVZwS1RiaWZQL3lKSXd4VEEwcjBmRlI0L1hHQzV4M2ZVQmx1TVZCUGVy?=
 =?gb2312?B?eElPWlpUZHJGcEpaRkRxZWJqTEw4NE96Zk41VUtpdjJoUWFwdGpZRUpvai92?=
 =?gb2312?B?THhrZWNHcFp2d2xpL2xyODBGRzNWTE9uWnJEMzBkazZRYUM3cTlQcWJCbzFp?=
 =?gb2312?B?cUI5aDdWSWU5V1Bvci9yNTNRUlY0RHNhangrWm4rU3gvYzlXckdxY3BaeEww?=
 =?gb2312?B?WWRTd3ozd2RzaDduaU9DVzdaajcrOTg4TXlnVmRQQ2xkZ0drTS9iNW5mbjdn?=
 =?gb2312?B?dmpqS1hVR2orYlQ4bVZ4cXpiZ0NNWmVjQVZ5bFBEQXRPclpBWEZMb1RabFFR?=
 =?gb2312?B?Z3JsM1pjNGR5MU1wYzJEc2xEN2Qvb0Vab3QyNHhCbitWa1QyUjdLRHlGTmhz?=
 =?gb2312?B?a0dwSFlyUmlVRkZrV2orM0tubDc3dG9QOTMyaDFyY1haOUcxTXZTK2Y1bmdZ?=
 =?gb2312?B?VUZoNTBab0dmQmMwZkYyanpsbSs1d2JMOHRiVlBFa3J1N3hBNmkrTWVueG1m?=
 =?gb2312?B?REJzL2hWd050SHFBQ3hFZ1FmcUI2ZkY2ZUkyQXI1c2h4cEY4amFHcVA2VFJO?=
 =?gb2312?B?aFFobHNSVFpISEpEWURhaE44bjhMcjdpbDkzUFdWZWEvTGdHakpjZnc0T1Nt?=
 =?gb2312?B?aHVQZXpjTkxNU0Nxa2pYWUY3dmFCSGZXVmI1QUdmdVlZbktDN2pwdGJTTmV3?=
 =?gb2312?B?K3NyekM2ZDVqakZnb0pERFJRVmY5K3FUUmxPRUdIUnVicHhsYmMwR29EM2Uv?=
 =?gb2312?B?VWZHMkZiZ3FEaU5vTE5OQUNqRCtaY0dCQ1NqRE1MQXUzYWZiN0t1dC9wcjFT?=
 =?gb2312?B?RHVObkx1U0twNkFGa0xkR1ltdlpoQkNoUUtzdGUzcEhmRjJ1NndHSkVoQmZt?=
 =?gb2312?B?T2VrZDMzc2ZsRDcxcjE4QTdBcXEveGRCYzNWSGNGZHdDRm1lSm16bkxnVDlS?=
 =?gb2312?B?TkV0Rzkzb2xaZ1hkcFJVa3JiNkg5dk9ZbWJYNlI4NklITjluNkdORWRyd2Uy?=
 =?gb2312?B?N0NtaHpCMW05YUlPM1hwZExzYjY2NFIycTFjRllyT1h4Lzhoalp5RCtJQkVG?=
 =?gb2312?B?eVBVOGxkUTF1L3dyMWdmbUhpcFZEckg3ZDJ1YTR1WFNkeXNjaDh4YmVIeEVP?=
 =?gb2312?B?eDEranp2NEZhOVg5YVJUT1JTLzd2TWViRmJwUWZMOG9BdXpjRWJYSVM1cVh6?=
 =?gb2312?B?cno0c1Y2UUhXa1I2VldMK0dPZjRzM2RTY0lzNFV0Q01Qa3FaVFlTNW1tZVRp?=
 =?gb2312?B?WDFGb3AwK2V0cnhsZnlJUFJ5UEs2K1gwYkFmN2FyQVpmNDBjTm5KSUpSeTZo?=
 =?gb2312?B?Zjc1TFg3TTJzSGJGTG5jeU9NMHl1YkJRb3UyTEdicU9MUjAzNk5Ia3BNT2hH?=
 =?gb2312?B?S3lzZGVqM052Sm9GcGt4MGtWWTBPd3lSUWRsaEY3cmUxY0pvV0ZnSmUxc1Rm?=
 =?gb2312?B?S0NXT3c3bldycTRuaS9jNTJ6MGdwemI0OE13SkF6WTdES2lEWkpCWFFlMk1F?=
 =?gb2312?B?ajJ4a2VnOWdSMTNxbklJeXJXLzh6TlFyR3FUZnRrSXorTmVCM1N4MS9zNlR5?=
 =?gb2312?B?djB0clpqbWEzTnFuSmlPQzhkRFRXU2xFQ3Bjd0g5NlU1TUs5ckxXdU1QZDZE?=
 =?gb2312?B?YUdWekdQRTluaW9zSUlOMjgvMCs0OHcvcnVGckF5am13eFNPTzZHTCsrZXFn?=
 =?gb2312?B?RmFudTZrSFk3QTMwekFGbU9lWE5xYU9ERWVUbkVIVU5ZTmhxc0hTYjNLa0l0?=
 =?gb2312?B?SkFEWGtFb3BJYzVSQVFoYkJndDR4clJhS2JXSkVwYUJnUytCUm5ITjdYM0VC?=
 =?gb2312?B?Tk9LNTIyMUJDTytYbmxIRXpLWEQyWU45U1RMNks0N3VneDBoOW91R2ZPNlk3?=
 =?gb2312?Q?9U9xDGLcRaQGfasmmCqfAh6oD?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?gb2312?B?a3NHTlBObktROHduNStnOXhwU2ZZRER0Z2liMXdsZjhlRG1RbndpeEE1NG5Z?=
 =?gb2312?B?dHByN3BmQ2lXckQ0TTVWd24zMEtYTkFSZ05rRU4zZFBwNlVRVWxDTitpcGtn?=
 =?gb2312?B?THprQjRNMElURDVKU3gzTXVoTnlvOG0yYzNma21mU3dFRmx4SWFsRnowcmJh?=
 =?gb2312?B?U2xEMjVEZG5yU3hUaTFHMkg0ek5Xc3dNcUg2N2RjenNPWWsrME1Dazc5NGh5?=
 =?gb2312?B?NXlOZE5lK0pjalB1LzQ4S2Q1Wkh4dUw3Sk53MmxwUWt6QmFEZ2J0aGFKOVFo?=
 =?gb2312?B?MHQyR1lsTDFPVGdnNnl3U3J6NzJWS3pyaURkRmVpc0drU2pCaXNXcFJiNGtr?=
 =?gb2312?B?SE0zbHE1bFFQQnpkS3IyV1EyL2xBZS9zYWt4N0hwdGZtbU5iQjZMcTJIUDQ5?=
 =?gb2312?B?Rkw5eGRNQ3QrcG5BNlFLaE9walg0RkRqYWFrWlVCTXV0WkU1QTM2MDlCeGVl?=
 =?gb2312?B?L3JQbTdxakxEQ3JpZGdLQ0tpYS81MEZRNEZzMitReDF5bDJPTkNWQ2ZUd3Vo?=
 =?gb2312?B?dUFOcitYRWVCa1F2WFR2cnB5M2F4TjFUMklPV3NEcGpvVnFTVEdVeUJ6L2h6?=
 =?gb2312?B?bEZVNjRHcTlKZTN4WWNabXNpY0FmYzlXOGpzU3I1VG1qVkNQdjU0YVFIR1E3?=
 =?gb2312?B?UlNYelMrRnhTaEtBSWJuMUxwN3FpWFB4bzJ3ejhNL3Y0dDZhVm91c2tYZTUy?=
 =?gb2312?B?SFd4ZldxNVFJN0l5MmdBa2lkcFNMRk0rRzFMRk5mdXNOblVvRk9YNWVXNDJ0?=
 =?gb2312?B?T2JUalN2bXNDKzQwTHVWUUVnV0xiNklycnV4dGN4Qk9ZREZFT0t1dm5uS2d1?=
 =?gb2312?B?VlhIVTFkYjRQanRWRC9LTE1nVy9aZTIrVmMrL3d0R01zUCsyYWlvVjEweGhk?=
 =?gb2312?B?QzA2Y2Z5RFZaeVVDOElIRzA3K0E2VWhEUUJLdFJic3RLQzYwQUpxb3ZPLy9H?=
 =?gb2312?B?MnFmbUtCeHczL3NZbFJ4b1NwUUgwU2l6UGs1N0MwdkgveHdsNmEvRUxLekJn?=
 =?gb2312?B?R3p0aWs4cmpLbHJPZm93QzBuMzJHMDJUV1NaM0h2VDNEMkMrOHQ0T3VZUnlv?=
 =?gb2312?B?WmxTSjNTVUVPN3E5RHFPL0xGbDRuQWYrTTQxYlBsbENQZzFRSXNZVFV2OE5a?=
 =?gb2312?B?Szg4Z2pBcUZKQjZyZHZPbnBQRFljeVF0aGVHYW5PLzlpV0lMREN3YWVuZVEx?=
 =?gb2312?B?cjB4ekY4U2lycFhnQk1uR1BaU0NRRjRZWVN2M2R3SlRKeDVVbjNtcmtzUjEr?=
 =?gb2312?B?aWhYODlaQkJGa0hrQ2l1RjJicDlaSTlJVkZkZWx4cXIxY0djQT09?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c995e8cf-b4ae-4d05-2835-08dbdb556355
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 03:39:58.7860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kAj19s96BVzrhFuW8GaMUD3uPBg5oHdUcCX8XdTP+qD1UAeGVdBYnFgi90OLNzEP+I7evp6F3WsQecvPOWpjsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8040
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBXZSBoYXZlIC9zeXMvZGV2aWNlcy92aXJ0dWFsL21lbW9yeV90aWVyaW5nL21lbW9yeV90aWVy
Ki9ub2RlbGlzdAo+IGFscmVhZHkuICBBIG5vZGUgaW4gYSBoaWdoZXIgdGllciBjYW4gZGVtb3Rl
IHRvIGFueSBub2RlIGluIHRoZSBsb3dlcgo+IHRpZXJzLiAgV2hhdCdzIG1vcmUgbmVlZCB0byBi
ZSBkaXNwbGF5ZWQgaW4gbm9kZVgvZGVtb3Rpb25fbm9kZXM/CgpJSVJDLCB0aGV5IGFyZSBub3Qg
dGhlIHNhbWUuIG1lbW9yeV90aWVyW251bWJlcl0sIHdoZXJlIHRoZSBudW1iZXIgaXMgc2hhcmVk
IGJ5CnRoZSBtZW1vcnkgdXNpbmcgdGhlIHNhbWUgbWVtb3J5IGRyaXZlcihkYXgva21lbSBldGMp
LiBOb3QgcmVmbGVjdCB0aGUgYWN0dWFsIGRpc3RhbmNlCmFjcm9zcyBub2RlcyhkaWZmZXJlbnQg
ZGlzdGFuY2Ugd2lsbCBiZSBncm91cGVkIGludG8gdGhlIHNhbWUgbWVtb3J5X3RpZXIpLgpCdXQg
ZGVtb3Rpb24gd2lsbCBvbmx5IHNlbGVjdCB0aGUgbmVhcmVzdCBub2RlbGlzdCB0byBkZW1vdGUu
CgpCZWxvdyBpcyBhbiBleGFtcGxlLCBub2RlMCBub2RlMSBhcmUgRFJBTSwgbm9kZTIgbm9kZTMg
YXJlIFBNRU0sIGJ1dCBkaXN0YW5jZSB0byBEUkFNIG5vZGVzCmFyZSBkaWZmZXJlbnQuCiAKIyBu
dW1hY3RsIC1ICmF2YWlsYWJsZTogNCBub2RlcyAoMC0zKQpub2RlIDAgY3B1czogMApub2RlIDAg
c2l6ZTogOTY0IE1CCm5vZGUgMCBmcmVlOiA3NDYgTUIKbm9kZSAxIGNwdXM6IDEKbm9kZSAxIHNp
emU6IDY4NSBNQgpub2RlIDEgZnJlZTogNDU1IE1CCm5vZGUgMiBjcHVzOgpub2RlIDIgc2l6ZTog
ODk2IE1CCm5vZGUgMiBmcmVlOiA4OTcgTUIKbm9kZSAzIGNwdXM6Cm5vZGUgMyBzaXplOiA4OTYg
TUIKbm9kZSAzIGZyZWU6IDg5NiBNQgpub2RlIGRpc3RhbmNlczoKbm9kZSAgIDAgICAxICAgMiAg
IDMKICAwOiAgMTAgIDIwICAyMCAgMjUKICAxOiAgMjAgIDEwICAyNSAgMjAKICAyOiAgMjAgIDI1
ICAxMCAgMjAKICAzOiAgMjUgIDIwICAyMCAgMTAKIyBjYXQgL3N5cy9kZXZpY2VzL3N5c3RlbS9u
b2RlL25vZGUwL2RlbW90aW9uX25vZGVzCjIKIyBjYXQgL3N5cy9kZXZpY2VzL3N5c3RlbS9ub2Rl
L25vZGUxL2RlbW90aW9uX25vZGVzCjMKIyBjYXQgL3N5cy9kZXZpY2VzL3ZpcnR1YWwvbWVtb3J5
X3RpZXJpbmcvbWVtb3J5X3RpZXIyMi9ub2RlbGlzdAoyLTMKClRoYW5rcwpaaGlqaWFuCgooSSBo
YXRlIHRoZSBvdXRsb29rIG5hdGl2ZSByZXBseSBjb21wb3NpdGlvbiBmb3JtYXQuKQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkZyb206IEh1YW5nLCBZaW5nIDx5aW5n
Lmh1YW5nQGludGVsLmNvbT4KU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDIsIDIwMjMgMTE6MTcK
VG86IExpLCBaaGlqaWFuL8DuINbHvOEKQ2M6IEFuZHJldyBNb3J0b247IEdyZWcgS3JvYWgtSGFy
dG1hbjsgcmFmYWVsQGtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgR290b3UsIFlhc3Vu
b3JpL87ljXUgv7XOxDsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwpTdWJqZWN0OiBSZTog
W1BBVENIIFJGQyAxLzRdIGRyaXZlcnMvYmFzZS9ub2RlOiBBZGQgZGVtb3Rpb25fbm9kZXMgc3lz
IGluZnRlcmZhY2UKCkxpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4gd3JpdGVzOgoK
PiBJdCBzaG93cyB0aGUgZGVtb3Rpb24gdGFyZ2V0IG5vZGVzIG9mIGEgbm9kZS4gRXhwb3J0IHRo
aXMgaW5mb3JtYXRpb24gdG8KPiB1c2VyIGRpcmVjdGx5Lgo+Cj4gQmVsb3cgaXMgYW4gZXhhbXBs
ZSB3aGVyZSBub2RlMCBub2RlMSBhcmUgRFJBTSwgbm9kZTMgaXMgYSBQTUVNIG5vZGUuCj4gLSBC
ZWZvcmUgUE1FTSBpcyBvbmxpbmUsIG5vIGRlbW90aW9uX25vZGVzIGZvciBub2RlMCBhbmQgbm9k
ZTEuCj4gJCBjYXQgL3N5cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGUwL2RlbW90aW9uX25vZGVz
Cj4gIDxzaG93IG5vdGhpbmc+Cj4gLSBBZnRlciBub2RlMyBpcyBvbmxpbmUgYXMga21lbQo+ICQg
ZGF4Y3RsIHJlY29uZmlndXJlLWRldmljZSAtLW1vZGU9c3lzdGVtLXJhbSAtLW5vLW9ubGluZSBk
YXgwLjAgJiYgZGF4Y3RsIG9ubGluZS1tZW1vcnkgZGF4MC4wCj4gWwo+ICAgewo+ICAgICAiY2hh
cmRldiI6ImRheDAuMCIsCj4gICAgICJzaXplIjoxMDU0ODY3NDU2LAo+ICAgICAidGFyZ2V0X25v
ZGUiOjMsCj4gICAgICJhbGlnbiI6MjA5NzE1MiwKPiAgICAgIm1vZGUiOiJzeXN0ZW0tcmFtIiwK
PiAgICAgIm9ubGluZV9tZW1ibG9ja3MiOjAsCj4gICAgICJ0b3RhbF9tZW1ibG9ja3MiOjcKPiAg
IH0KPiBdCj4gJCBjYXQgL3N5cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGUwL2RlbW90aW9uX25v
ZGVzCj4gMwo+ICQgY2F0IC9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9ub2RlMS9kZW1vdGlvbl9u
b2Rlcwo+IDMKPiAkIGNhdCAvc3lzL2RldmljZXMvc3lzdGVtL25vZGUvbm9kZTMvZGVtb3Rpb25f
bm9kZXMKPiAgPHNob3cgbm90aGluZz4KCldlIGhhdmUgL3N5cy9kZXZpY2VzL3ZpcnR1YWwvbWVt
b3J5X3RpZXJpbmcvbWVtb3J5X3RpZXIqL25vZGVsaXN0CmFscmVhZHkuICBBIG5vZGUgaW4gYSBo
aWdoZXIgdGllciBjYW4gZGVtb3RlIHRvIGFueSBub2RlIGluIHRoZSBsb3dlcgp0aWVycy4gIFdo
YXQncyBtb3JlIG5lZWQgdG8gYmUgZGlzcGxheWVkIGluIG5vZGVYL2RlbW90aW9uX25vZGVzPwoK
LS0KQmVzdCBSZWdhcmRzLApIdWFuZywgWWluZwoKPiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFu
IDxsaXpoaWppYW5AZnVqaXRzdS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvYmFzZS9ub2RlLmMgICAg
ICAgICAgfCAxMyArKysrKysrKysrKysrCj4gIGluY2x1ZGUvbGludXgvbWVtb3J5LXRpZXJzLmgg
fCAgNiArKysrKysKPiAgbW0vbWVtb3J5LXRpZXJzLmMgICAgICAgICAgICB8ICA4ICsrKysrKysr
Cj4gIDMgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvYmFzZS9ub2RlLmMgYi9kcml2ZXJzL2Jhc2Uvbm9kZS5jCj4gaW5kZXggNDkzZDUzM2Y4
Mzc1Li4yN2U4NTAyNTQ4YTcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9iYXNlL25vZGUuYwo+ICsr
KyBiL2RyaXZlcnMvYmFzZS9ub2RlLmMKPiBAQCAtNyw2ICs3LDcgQEAKPiAgI2luY2x1ZGUgPGxp
bnV4L2luaXQuaD4KPiAgI2luY2x1ZGUgPGxpbnV4L21tLmg+Cj4gICNpbmNsdWRlIDxsaW51eC9t
ZW1vcnkuaD4KPiArI2luY2x1ZGUgPGxpbnV4L21lbW9yeS10aWVycy5oPgo+ICAjaW5jbHVkZSA8
bGludXgvdm1zdGF0Lmg+Cj4gICNpbmNsdWRlIDxsaW51eC9ub3RpZmllci5oPgo+ICAjaW5jbHVk
ZSA8bGludXgvbm9kZS5oPgo+IEBAIC01NjksMTEgKzU3MCwyMyBAQCBzdGF0aWMgc3NpemVfdCBu
b2RlX3JlYWRfZGlzdGFuY2Uoc3RydWN0IGRldmljZSAqZGV2LAo+ICB9Cj4gIHN0YXRpYyBERVZJ
Q0VfQVRUUihkaXN0YW5jZSwgMDQ0NCwgbm9kZV9yZWFkX2Rpc3RhbmNlLCBOVUxMKTsKPgo+ICtz
dGF0aWMgc3NpemVfdCBkZW1vdGlvbl9ub2Rlc19zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwKPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwg
Y2hhciAqYnVmKQo+ICt7Cj4gKyAgICAgaW50IHJldDsKPiArICAgICBub2RlbWFza190IG5tYXNr
ID0gbmV4dF9kZW1vdGlvbl9ub2RlcyhkZXYtPmlkKTsKPiArCj4gKyAgICAgcmV0ID0gc3lzZnNf
ZW1pdChidWYsICIlKnBibFxuIiwgbm9kZW1hc2tfcHJfYXJncygmbm1hc2spKTsKPiArICAgICBy
ZXR1cm4gcmV0Owo+ICt9Cj4gK3N0YXRpYyBERVZJQ0VfQVRUUl9STyhkZW1vdGlvbl9ub2Rlcyk7
Cj4gKwo+ICBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqbm9kZV9kZXZfYXR0cnNbXSA9IHsKPiAg
ICAgICAmZGV2X2F0dHJfbWVtaW5mby5hdHRyLAo+ICAgICAgICZkZXZfYXR0cl9udW1hc3RhdC5h
dHRyLAo+ICAgICAgICZkZXZfYXR0cl9kaXN0YW5jZS5hdHRyLAo+ICAgICAgICZkZXZfYXR0cl92
bXN0YXQuYXR0ciwKPiArICAgICAmZGV2X2F0dHJfZGVtb3Rpb25fbm9kZXMuYXR0ciwKPiAgICAg
ICBOVUxMCj4gIH07Cj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tZW1vcnktdGllcnMu
aCBiL2luY2x1ZGUvbGludXgvbWVtb3J5LXRpZXJzLmgKPiBpbmRleCA0Mzc0NDFjZGY3OGYuLjhl
YjA0OTIzZjk2NSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21lbW9yeS10aWVycy5oCj4g
KysrIGIvaW5jbHVkZS9saW51eC9tZW1vcnktdGllcnMuaAo+IEBAIC0zOCw2ICszOCw3IEBAIHZv
aWQgaW5pdF9ub2RlX21lbW9yeV90eXBlKGludCBub2RlLCBzdHJ1Y3QgbWVtb3J5X2Rldl90eXBl
ICpkZWZhdWx0X3R5cGUpOwo+ICB2b2lkIGNsZWFyX25vZGVfbWVtb3J5X3R5cGUoaW50IG5vZGUs
IHN0cnVjdCBtZW1vcnlfZGV2X3R5cGUgKm1lbXR5cGUpOwo+ICAjaWZkZWYgQ09ORklHX01JR1JB
VElPTgo+ICBpbnQgbmV4dF9kZW1vdGlvbl9ub2RlKGludCBub2RlKTsKPiArbm9kZW1hc2tfdCBu
ZXh0X2RlbW90aW9uX25vZGVzKGludCBub2RlKTsKPiAgdm9pZCBub2RlX2dldF9hbGxvd2VkX3Rh
cmdldHMocGdfZGF0YV90ICpwZ2RhdCwgbm9kZW1hc2tfdCAqdGFyZ2V0cyk7Cj4gIGJvb2wgbm9k
ZV9pc190b3B0aWVyKGludCBub2RlKTsKPiAgI2Vsc2UKPiBAQCAtNDYsNiArNDcsMTEgQEAgc3Rh
dGljIGlubGluZSBpbnQgbmV4dF9kZW1vdGlvbl9ub2RlKGludCBub2RlKQo+ICAgICAgIHJldHVy
biBOVU1BX05PX05PREU7Cj4gIH0KPgo+ICtzdGF0aWMgaW5saW5lIG5leHRfZGVtb3Rpb25fbm9k
ZXMgbmV4dF9kZW1vdGlvbl9ub2RlcyhpbnQgbm9kZSkKPiArewo+ICsgICAgIHJldHVybiBOT0RF
X01BU0tfTk9ORTsKPiArfQo+ICsKPiAgc3RhdGljIGlubGluZSB2b2lkIG5vZGVfZ2V0X2FsbG93
ZWRfdGFyZ2V0cyhwZ19kYXRhX3QgKnBnZGF0LCBub2RlbWFza190ICp0YXJnZXRzKQo+ICB7Cj4g
ICAgICAgKnRhcmdldHMgPSBOT0RFX01BU0tfTk9ORTsKPiBkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5
LXRpZXJzLmMgYi9tbS9tZW1vcnktdGllcnMuYwo+IGluZGV4IDM3YTRmNTlkOTU4NS4uOTAwNDdm
MzdkOThhIDEwMDY0NAo+IC0tLSBhL21tL21lbW9yeS10aWVycy5jCj4gKysrIGIvbW0vbWVtb3J5
LXRpZXJzLmMKPiBAQCAtMjgyLDYgKzI4MiwxNCBAQCB2b2lkIG5vZGVfZ2V0X2FsbG93ZWRfdGFy
Z2V0cyhwZ19kYXRhX3QgKnBnZGF0LCBub2RlbWFza190ICp0YXJnZXRzKQo+ICAgICAgIHJjdV9y
ZWFkX3VubG9jaygpOwo+ICB9Cj4KPiArbm9kZW1hc2tfdCBuZXh0X2RlbW90aW9uX25vZGVzKGlu
dCBub2RlKQo+ICt7Cj4gKyAgICAgaWYgKCFub2RlX2RlbW90aW9uKQo+ICsgICAgICAgICAgICAg
cmV0dXJuIE5PREVfTUFTS19OT05FOwo+ICsKPiArICAgICByZXR1cm4gbm9kZV9kZW1vdGlvbltu
b2RlXS5wcmVmZXJyZWQ7Cj4gK30KPiArCj4gIC8qKgo+ICAgKiBuZXh0X2RlbW90aW9uX25vZGUo
KSAtIEdldCB0aGUgbmV4dCBub2RlIGluIHRoZSBkZW1vdGlvbiBwYXRoCj4gICAqIEBub2RlOiBU
aGUgc3RhcnRpbmcgbm9kZSB0byBsb29rdXAgdGhlIG5leHQgbm9kZQo=
