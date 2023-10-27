Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122167D8F67
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345363AbjJ0HPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbjJ0HPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:15:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA541B1;
        Fri, 27 Oct 2023 00:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698390914; x=1729926914;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9yFA4Raon3oImqCAI/n5eRCqfiX+zD8px2D6K2pChhc=;
  b=VKNDRWhpMadwXAJkT4qaVC2RNvxx9uzYWmjlkvS717q55WcHbYgwGR1t
   zAPd3WbyCytpTLfkovIG1Sp+BqQLwxZWGQeTJgRu/tGP9YeOzwuJA8efJ
   zHclMa6WRk6uhPzw5J/Jkq1vq51Q0uVk58fDpo4ZgmY4My1jhfzt39yiO
   k0u0WnEL1ifQQ4vlaQChsB24uekSEHAiXgvfaytF7UTMCp+F9hYx48nxA
   IDnDHBvYxvsyse+/6Q1kb5vjJuvaMCLf4r/kSq7S5/EycgF4+EcZXZ6HY
   TDSqMNrHZw8y0EFVMxW8Y+QxJZGVdYUb/o48MkZ0TZi/+2A82GL5usGb/
   w==;
X-CSE-ConnectionGUID: iXiKyUkpRBue8gKPk6ZrmA==
X-CSE-MsgGUID: LMob01miQ2SSPm3e8ilp9g==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="10788419"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2023 00:15:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 27 Oct 2023 00:15:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 27 Oct 2023 00:15:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7CEid33/tfMaRxAMyh4s3ZpVR57zZtkwHwQpKaKHOzBZS39uutbRgP8TGVYvV8gjP6OhhyxFlbef7yJPzAkeumtBwR6JyIk5anulW1sYeI53s6hACnl4ZQVm5F2UQJtGjTSRtU3abf4bl4UD3CPSaApXqYqWOtvaLzQSgtY9ci8x7lwy6KyNNJ8d5RrYUwylOidUJ037Kj0ismSwgN0XIEu5OtSvKc2PKobZk8a5K2VgE681dJVpRnlCw+jAINPViYFtr2S8ZiMbhHS1IDsQO+42VyoCu/qHVPu07bhJjDloWcSSvi0X3s7i38rT9rYFd0BVuULyxfwn8DyCNMxfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yFA4Raon3oImqCAI/n5eRCqfiX+zD8px2D6K2pChhc=;
 b=CMr+h18ard+bB0yFJ/QUoMPrvrBRdN+aSBqBuVkxYXLfgieuQBBBmYPSBmipkK5kHwppE0OVfPnuLf9Q1UM+0BhOia0os8ZCB05kP9i37v2HobypbkB3ZM/QKK0YbGzoNoXAAk7OcXG2ndn4hHA+OQBhNHATsfTlt9rI0Qx747O59V0JpM6dgDSOlbzYuA6az8XdBUBILindBf8A/SMkYmf6R1ewa7mIr2K7hPMNipAPzbv5RK3S932YU8pq0DXCGk4pokZEXm0JIoFnCLkiTab1Y4Hqbmy8yjpAOzpKmlkYQcREwX26W2rQ0GSX5Kyt6wHqCdOU7SuRgCYExVZTgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yFA4Raon3oImqCAI/n5eRCqfiX+zD8px2D6K2pChhc=;
 b=NrZRVgIW1blRE/NRhVsAti0FLUUL1zcSlBBYguhXwsIT5jBdifpG9MHrKew+Nk33pSN1aLTZhT2c1tYwGnDRSv2HOGzGnUACjjQ/Qo8dzChUVWlw1sAxgimCTqRLQ6oJIxWuoe14sNtGYW9N8KcDX+HEYbBmr2p7CzdytnB6r64=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 BL1PR11MB5349.namprd11.prod.outlook.com (2603:10b6:208:308::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.20; Fri, 27 Oct
 2023 07:15:02 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510%4]) with mapi id 15.20.6933.022; Fri, 27 Oct 2023
 07:15:02 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <andrew@lunn.ch>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <Steen.Hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
        <Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [PATCH net-next v2 1/9] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Topic: [PATCH net-next v2 1/9] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Index: AQHaBcg5Kr932Xidx0+yZeTbLM2N4rBX5EwAgAJ5dgCAAiDvAIAAwFeA
Date:   Fri, 27 Oct 2023 07:15:01 +0000
Message-ID: <92e0a4d4-82fe-4e2f-828e-e9d450cf59ad@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-2-Parthiban.Veerasooran@microchip.com>
 <c51d9660-d6c3-4202-9fc6-b9add06b64ce@lunn.ch>
 <8430c607-4a62-47fc-9c13-9ba17cf09679@microchip.com>
 <3c7a04a3-4ae2-4f83-b7bf-0db75f58f5be@lunn.ch>
In-Reply-To: <3c7a04a3-4ae2-4f83-b7bf-0db75f58f5be@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|BL1PR11MB5349:EE_
x-ms-office365-filtering-correlation-id: efbfcda8-75cc-48da-61d3-08dbd6bc6fb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fnYrk2TuVF2EmkKf8jcaLvx4DB58NC5mWi4neo5Pq5a0urFNvCEuEz4CgQo5lsHpAmNRa5bYVAHS9LxvfZS9vstPI0HZBDtvI/4282g2uJ69JbflD13Ye/Cr9Ctt0/foML85y0uRxU9mubiGjw7smCMEDpVFfo6Z5d5hrK9Y/yazY8JIvnEXUjSwxUh3KIcapLHJ0ME5jkdg2zCG/5zVWIdzmFrpf9qACmH02hWvH2ZZL4/XO+goCgxctl089WP2I3CFV/jvoju8kpOjWsNsbr14Ld5PH/YnDMJpat46nTNeVWzC7ttTdX7oT/H6QmTzTg+Km63WW/vejPYwVcarU+y1gRUcBztl9Vx96FlT0t45E+7YmusI7Z7PKatZ0fpLhZNRFxMhfrW0r4a2JEisC1JXzXkyqmCmgKgzLoYzzgcLabZxn/ss/mnFgVswWgIY4KG2eQfXzF6hRVO6TrHdiD5wzKudmUeuvjz+tYfPwVMSDsOE0QYmjKHOe9OtHr+l7mQtIkN1ab2CMe8p7FbSm7Q62LI8A8Oa8/RhufKVmhh8sp4WEU4jj+xrVRCqILnaL1pEvgzkDu6xUiTM338repIVIXF8bAyU4AHPBSpKnGBitjf/KwN3w8Sba3dnkKzL78R8v2W4PM+HsgMq/JI5JTu+WXBASIskF9jd4nmeX5w+cf/Pv0tGH5vkTdszDI+cK6tqvhiKH3fmBR/9x9ZS+U/s7+GeGQdz+UhVgsL5F1Lmbx6bDB/e/4VtgI8u6QPu3CWMWmCHGNg2lav4JvH7fg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(451199024)(1800799009)(2906002)(41300700001)(31696002)(478600001)(4326008)(8936002)(8676002)(6486002)(7416002)(91956017)(66946007)(76116006)(5660300002)(54906003)(66556008)(86362001)(316002)(31686004)(66446008)(66476007)(6916009)(64756008)(71200400001)(53546011)(38100700002)(2616005)(107886003)(6506007)(122000001)(36756003)(6512007)(38070700009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0RWSUR2dGlqVjJtWlRXN3c4czFMdk4yV3ljTkUzWDM1MUlTQzJCaS9HTnBu?=
 =?utf-8?B?WXh2YnM4RDFmdkRBakFuRGRvWHdhcVIzWS9RUWZGKzZXQjJROXJZc0JRMlRO?=
 =?utf-8?B?L0F5K0ErMEhMN1JBTWI4d2pIR09lL3d2cnpHckxzUVFjMktBZzhRaEpyY3lN?=
 =?utf-8?B?RFBDU1ZDMkVPSVB4NzNwc3lEZzlrTWhUYncyRlN1SkNJWkw3S21IRy9TdVlT?=
 =?utf-8?B?K0NHaG1reHRzS2hNaWNYTHEzaE1mVUpHMGtLTnNpdzdiaDJkdGd5NjBPNlh4?=
 =?utf-8?B?Rk9aVW5BYTlvU296Z1M1WHVBUUU0SW5HeUN0cTlMdlRxMTJDVlluR3dEbzJE?=
 =?utf-8?B?TzMvNTBpTVdObXFzdStPdFZubUsxaWg1UWJiTkZ4eGRNZm16TVFtRGtTNEdM?=
 =?utf-8?B?NStibXJnOFRwMTMzeEpFTUVxRUUrazhySGtrUS94TEdXRjYwcWxkVzVmZGlM?=
 =?utf-8?B?L0ZpdXUvNmpuaHhTRTdxVjBRM2F4NkdHdzZ2SzdUdXpySU1NUzYxc0ZKZzFy?=
 =?utf-8?B?c3JIMlI2ZDlzKzRkaXpwM2pycXBRSitpekhtbmR0YVl0M3BjWHAwdmRFV2ZF?=
 =?utf-8?B?eDF0c3FZZHB4TWpBMEJhM1RQSDhRZVdRYkc5NFpRL3p3Ym1MNXZLTFZYNUtJ?=
 =?utf-8?B?UG5kdWg5eWpUSklyOGp1MUxYalFpS2d5bUMwS2dDTlR4b21MeFdZOTNVWXg0?=
 =?utf-8?B?K2lKZlRBUlovVEtUd0hHeTRDSXZqVUd6WFJjWVBDKzFBUlc0dGlHNWdSZTRW?=
 =?utf-8?B?ZjF2MUx3Q04vdTNQcFZvdFZITU1kNEJZUDJXMGNsaHB3UjlXR08xTTF0b1Fh?=
 =?utf-8?B?R1dncTNZOGN0SzlMRnF5ZURLeGJVZ3c0aVEzejlFU3F1RkZZT1ZCb2UrK1JK?=
 =?utf-8?B?NEFmcUZiTFozZ0l1d1R5cThUd1BVSTlMcWlYd0Z3YkxYZWpVY08wL2pLVHBs?=
 =?utf-8?B?OEc2WHp0a0plK2d5UnBNUHYxNVpOV3cvd2cySUl4dVFvK0EwN3QwSXQrOVNh?=
 =?utf-8?B?eUlkTTBuTFVJSXJqdG82bnE1U3N4UnFtNENVRW9HWnRFcHMrQzNBc1JlWnZl?=
 =?utf-8?B?S05sc2cxaVJMaXplWXk3NllPTXMxZlgzdFkrM1JJUVRrTFBIcDV2bjJFK0sx?=
 =?utf-8?B?TVRhVVgrUkpKelR1a2ZBTWRJdy9jUjdyWkM2WU1aR3h2c2d2LzF2RkExeXFB?=
 =?utf-8?B?eVorQS9LalV1TmNHelNLMnpGc2tHYmF4aENXdW1JVS9GUm1IazZaRkxaQmo0?=
 =?utf-8?B?c0RydUtHa1ZNdnFGaUJFMHFoNmxrSGFSSXpSS0ZzcStGU3A0ZVpIclIxWTJY?=
 =?utf-8?B?dllLVjVvWjRrL2pjcjRDVi9RWUl6Q3lmc1dGZ2V0d056YjMxMGVtdnAyT2R1?=
 =?utf-8?B?Qm1nRWk2NTk4REZ5UTZoMEQrUEhKblljVzA4T0FzakNCWEhERXRZNE1yTEM1?=
 =?utf-8?B?b0dURC9KN3pFb01qU3d6QjlncndhZDhUYWZ4cFJlclAvekN2ZmRtR1JDeVNa?=
 =?utf-8?B?Q3hweTdJekkrZW0za2VFbGtHTEs4MmZrVG1yZWhvVHByc1NnT1B6Y21UKzh3?=
 =?utf-8?B?RTBEem9Ed1ZxeUw1UGhRVWQvTmNqUUZsOUR4NlB2TlhQQ1ZXeVJEV2dPNHdn?=
 =?utf-8?B?ZEdJeFVUOUovSkpCY0MwdXk0YjlUN0FMMnJGS29IV2RDUzRydGZ6dG9UTzQw?=
 =?utf-8?B?V0EyWUM5SldEY0wyVWNDTytMQjdJM1BCckxyZ3JKa1NxbUEyejBHMjdodkgw?=
 =?utf-8?B?VHlBUGRsSVh2UmI3alhJdHgrcVBkdGdUVldUZUpVd0hEbFZVaURlRzhoNWo3?=
 =?utf-8?B?RTR2QXcwblUySWxYTHRCU2lYS1k5bDN3c0YvS3Y5SlhuVWNhckF2YjdyTUpS?=
 =?utf-8?B?YTVXOUZUUXYwdDNYV29lMzBua3VrMGQyWkxFaTZYS3FLckxWZXMrdTE5MnVn?=
 =?utf-8?B?Q3dyVCsvZHloK1lCTWU5YmJXTWt5ZGxuTzk5MUZiTWRzSGx3aWUrSUVOWnRY?=
 =?utf-8?B?b2JMTFB1ZHBTamF5L2U4cDdDWXM2Y3FpclJadTlDdFpoQ1VpSUlPK1hjZVY3?=
 =?utf-8?B?TmhnaXBMR1hrd2V1NE85Tlc4K2RSbENxTU40endYTHcxWUxjaVdlTWR1QXcw?=
 =?utf-8?B?Y1pnSjRnNVBTK0VaSlQ5ZHBLNkE4RG9sQTA4eXZDSHpuNDBQbVNHOFhpallj?=
 =?utf-8?B?c0EwZzFQeHpyYUQ4UjBsejREVS9jTDZ5OUNHWFh5VExsSFVyWWR3VGI1MTc2?=
 =?utf-8?Q?P5K9L0eUXepNdEAUbM+CMIZivg3KalxmANXyt7yJnc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E2E0DD5CC4E6B48854787241A272C51@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbfcda8-75cc-48da-61d3-08dbd6bc6fb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 07:15:01.8893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mlKqOunZ7Oq+ixzR/2z29b7/zy4O7/J2aZcKSmAKR3ZGvFoMrfWJS6fmipY1Kdw1U5UTP8GXzxorc3ylTPNqqOqWmVxJB57yzF/omixSbmXBpxdIJtZVSk9vUG6HOiPB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5349
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAyNy8xMC8yMyAxOjE2IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gU3RpbGwgaWYgeW91IGZl
ZWwgbGlrZSB1c2luZyAid3JpdGUiIGluc3RlYWQgb2YgInduciIgYW5kICJwcm90ZWN0Ig0KPj4g
aW5zdGVhZCBvZiAicHJvdGUiLCBJIHdpbGwgY2hhbmdlIHRoZW0gaW4gdGhlIG5leHQgcmV2aXNp
b24uDQo+IA0KPiBUaGVyZSBpcyBzb21lIHZhbHVlIGluIHVzaW5nIG5hbWVzIGZyb20gdGhlIHN0
YW5kYXJkLCBpZiB0aGV5IGFyZQ0KPiBhY3R1YWxseSBnb29kIG5hbWVzLiBCdXQgaSBndWVzcyBt
b3N0IGRldmVsb3BlcnMgZG9uJ3QgaGF2ZSBhIGNvcHkgb2YNCj4gdGhlIHN0YW5kYXJkIGJ5IHRo
ZXJlIHNpZGUuDQo+IA0KPiBZb3UgYWN0dWFsbHkgd3JvdGUgaW4gdGhlIHBhdGNoOg0KPiANCj4g
Ky8qIENvbnRyb2wgaGVhZGVyICovDQo+ICsjZGVmaW5lIENUUkxfSERSX0ROQyAgICAgICAgICAg
QklUKDMxKSAgICAgICAgIC8qIERhdGEtTm90LUNvbnRyb2wgKi8NCj4gKyNkZWZpbmUgQ1RSTF9I
RFJfSERSQiAgICAgICAgICBCSVQoMzApICAgICAgICAgLyogUmVjZWl2ZWQgSGVhZGVyIEJhZCAq
Lw0KPiArI2RlZmluZSBDVFJMX0hEUl9XTlIgICAgICAgICAgIEJJVCgyOSkgICAgICAgICAvKiBX
cml0ZS1Ob3QtUmVhZCAqLw0KPiArI2RlZmluZSBDVFJMX0hEUl9BSUQgICAgICAgICAgIEJJVCgy
OCkgICAgICAgICAvKiBBZGRyZXNzIEluY3JlbWVudCBEaXNhYmxlICovDQo+ICsjZGVmaW5lIENU
UkxfSERSX01NUyAgICAgICAgICAgR0VOTUFTSygyNywgMjQpIC8qIE1lbW9yeSBNYXAgU2VsZWN0
b3IgKi8NCj4gDQo+IFRoZSBjb21tZW50cyBzdWdnZXN0IHlvdSBhbHNvIGRvbid0IHRoaW5rIHRo
ZSBuYW1lcyBhcmUgcGFydGljdWxhcmx5DQo+IGdvb2QsIG90aGVyd2lzZSB5b3Ugd291bGQgbm90
IG9mIGFkZGVkIGNvbW1lbnRzLg0KPiANCj4gQnV0IGlmIHlvdSBpbnN0ZWFkIGhhZDoNCj4gDQo+
IC8qIENvbnRyb2wgaGVhZGVyICovDQo+ICNkZWZpbmUgQ1RSTF9IRFJfREFUQV9OT1RfQ1RSTCAg
ICAgICAgICAgQklUKDMxKQ0KPiAjZGVmaW5lIENUUkxfSERSX0hEUl9SWF9CQUQgICAgICAgICAg
ICAgIEJJVCgzMCkNCj4gI2RlZmluZSBDVFJMX0hEUl9XUklURSAgICAgICAgICAgICAgICAgICBC
SVQoMjkpDQo+ICNkZWZpbmUgQ1RSTF9IRFJfQUREUl9JTkNfRElTQUJMRSAgICAgICAgQklUKDI4
KQ0KPiAjZGVmaW5lIENUUkxfSERSX01FTV9NQVBfU0VMRUNUT1IgICAgICAgIEdFTk1BU0soMjcs
IDI0KQ0KPiANCj4gdGhlIG5hbWVzIGFyZSBwcm9iYWJseSBzdWZmaWNpZW50IHRoYXQgY29tbWVu
dHMgYXJlIG5vdCBuZWVkZWQuICBBbmQNCj4gaXMgc2hvdWxkIGJlIGVhc3kgZm9yIHNvbWVib2R5
IHRvIG1hcCB0aGVzZSBiYWNrIHRvIHRoZSBuYW1lcyB1c2VkIGluDQo+IHRoZSBzdGFuZGFyZC4N
Cj4gDQo+IFRoaXMgYWxzbyB0byBzb21lIGV4dGVudCBjb21lcyBpbnRvIHRoZSBjb21tZW50IGFi
b3V0IGNvZGluZyBzdHlsZSwgYQ0KPiBmdW5jdGlvbiBkb2VzIG9uZSB0aGluZywgaXMgc2hvcnQs
IGV0Yy4gU2hvcnQgZnVuY3Rpb25zIHRlbmQgdG8gaGF2ZQ0KPiBsZXNzIGluZGVudGF0aW9uLCBt
ZWFuaW5nIHlvdSBjYW4gdXNlIGxvbmdlciBuYW1lcy4gQW5kIGxvbmdlciBuYW1lcw0KPiBhcmUg
bW9yZSByZWFkYWJsZSwgbWFraW5nIHRoZSBmdW5jdGlvbiBlYXNpZXIgdG8gdW5kZXJzdGFuZCwg
c28gaXQNCj4gZG9lcyB0aGF0IG9uZSB0aGluZyB3ZWxsLg0KT2ssIHRoYW5rcyBmb3IgdGhlIGV4
cGxhbmF0aW9uLiBJIHdpbGwgZG8gaXQgaW4gdGhlIG5leHQgcmV2aXNpb24uDQoNCkJlc3QgUmVn
YXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiAgICAgIEFuZHJldw0KPiANCg0K
