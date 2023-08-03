Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A192576F330
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjHCTDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjHCTCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:02:50 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3224494;
        Thu,  3 Aug 2023 12:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691089356; x=1722625356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=c8pkHCOMhFg+uoH/5VsewgNCWpQy62BPUkk8FVv3lFfhWbCKQT+nL7Sp
   Rp3VAj8SIXl3WsoJ9DFwcEuKo7piE7mJfJ+2Xc2MohCUdKJ2x+aD6nD/A
   Yru8Z6PHWPTjUo7GZuWFSRXsSK2F3oLupbMDnB4FSh9QMxJXA1Z9IC5wp
   CQ+eNRNyUWbttRw5lUiMT3OimtObkXPPyAHMv9H5If4iZYausXoU4Y/4Y
   JfoFMSXXHtDhE3q57+wEGO/Z7s+oU+UyJCtxe514+S0x3VS80jyLJbMdH
   nBq8NnPF7NNWylk8kv6l+m/EmSz3BnHG74rdypWN/awnHzUk5PNmTJjg/
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,252,1684771200"; 
   d="scan'208";a="238357766"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 04 Aug 2023 03:02:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuT3cfXL4RPrX4j0isB4mGYEP5s32/Qx592slDNsA5vegRKX1pRcS54WaY1xkGKUSfoDQncPkmp1ZitQd5dw5CD3NRTlf2TWcqDyTyuPBwMbCAs1KVRoVgh2hA+PLoOL3TJ9RB7dB8ilx9wZgzX35eoZZ+rQsVAu2uXe/IFzrsJSYTgkZ3BTRyidrB5ORv0mvA8Y+mcqLtYM0461MRayc1ke4o0i0qoN3vEpTcO7RiGqPLnb7HIhm1lqZ9sQFDODPL7aTZL1njKIL6qvq4b4LyybKaYL1aXu60GfaYUJtBmJ9C1zVF/CrQZf8Qj0M4jJJd/6JsDI8h/P9pt46g//ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=S9CpLMPFv5M93hxvYSxO94MRxMyGfJ6q15ebPCzS/pgQvDxI0UOP7KRwqjmBVCxR0LbCDpon/hgpUnG1sw+rW2cLa8FEIE25M0ehRMXx6+7rDG9pqTjGxnthm44FJQli7jDmdW/VKUvvkUSPr1vE8uJjDcyB6ek1hdfCl8MlU1Pl9ixrCmS9erKuysOIyFDTamkFaj3L17kkP+QGL2+pJWVgW8/xizrDMjYypGFSuDUM9rGcjqb3nK2C8bMb5uotFLWCAdIY0neI0ZszynvEkrgGdx5Al8kAmhyak0iR+P2wbNkDvMll2dKez+i3Q/2Pvh6kowS7fOY4oK8axnK1Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=o77EC1rHAfLttQAZviHTXKKeYU5VvdPt60Wh7/613ee6BJd14Am0V0+zUKlFVz47Yqzx3swKhVrRwJ214RW3hvzTXsW4wqUjy/oWendLL3GWIuoZaoKlAhnW0KYt06B+ey3rIXgZFhItdkORw5chN+lu0nfXKKTsuoPs5BNMcMA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB8344.namprd04.prod.outlook.com (2603:10b6:a03:3db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 19:02:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 19:02:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>,
        Ming Lei <ming.lei@redhat.com>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 1/3] ublk: add helper to check if device supports user
 copy
Thread-Topic: [PATCH v10 1/3] ublk: add helper to check if device supports
 user copy
Thread-Index: AQHZxhQb/zI5TOJAcE2TQoo84pajg6/Y7fIA
Date:   Thu, 3 Aug 2023 19:02:31 +0000
Message-ID: <675882b2-5ce4-609d-ca87-3e20660a7a01@wdc.com>
References: <20230803140701.18515-1-nmi@metaspace.dk>
 <20230803140701.18515-2-nmi@metaspace.dk>
In-Reply-To: <20230803140701.18515-2-nmi@metaspace.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB8344:EE_
x-ms-office365-filtering-correlation-id: 21111886-9d36-4249-0d72-08db9454306d
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ++IJGRfr4mX0+MmdexxWhg264YIfmCaathrDRVoxuEDMv2l19BrfAkiAMMc2mCtqI6QXq7T1CoyszEQZdHQstkK7qxdNGgtd2lqwSLkbo+uig3JFh9/Kz79SChbQHXmbrRKaoKQX/2qqs9MI9pfuMm1oyx10hkdJC6/ahqrCphvqecMZD3TNXE/0e6qHwHwvAVplupTThYWROuiadBStCBq2e/8KgzBYY3+8Hq4giDDvd4tlAMSd+OJqTaTJAVr+3GzeLCYt/kqsdJp2XjcsiHETB5sPOKJX2EiBEiH30mBSFUmQI/nu0WkPZtsSkt2JRb/JhN7YvFwIyS4BXnZozicDgOpUWyA2xkRkdfXol0LGuQTHVMlCqPRQzB1ZyAo2ETCYl2UbheClZyRQDK9mkukSeHO05+5dvjs1ZW8HGqoU01rh0ci6fxrbiAosTMkzF8goyaJSrMP9gpPAFG56sP0gtq7+Nfo3RSXJZyvlm4OESsi8m7jzElfZB4/SFXSY+7iV/mW0OPIR2CJkKHUqRhogj6hlzSajDFyFGlw8J6gsa3WQXGEajzOIAwUFuAffPAExbBBmOjvxbScdt/GpIriSgZ9U//5lz4HGLtt4+E4I57WkOUReeXo54wVD5S3eXb7te03auqKwIGZC3mATCMY8ITJLIktoLcvk5zYlHJxG7025qrhtLka0JepknroS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199021)(36756003)(2616005)(5660300002)(186003)(8676002)(4270600006)(7416002)(478600001)(6512007)(4326008)(110136005)(54906003)(76116006)(66446008)(66556008)(66476007)(71200400001)(66946007)(64756008)(316002)(91956017)(6486002)(86362001)(31696002)(41300700001)(38070700005)(19618925003)(122000001)(558084003)(2906002)(6506007)(82960400001)(38100700002)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDVuN2RPZzEvU3BRVlZBMzRpRC9OaDljL2k1dDJydHFaMTU4RTI5NkpWWXEv?=
 =?utf-8?B?UTFRTkxnSnFNZHdkdHJXamJ6N2swM0FTaDZzdGZmSzhnSzdmSkFkVGhWM281?=
 =?utf-8?B?OEhkTitncUdISzVVWXVxenk5dFhCaTRIUUZvWEpqT2Q0MUJXeXBxWk95R04y?=
 =?utf-8?B?ZWFXSnZnOWh2S1crRkRoVmJGaWZCZDZ4c2l2bWNzOEM5T25aQlNPRGM0NXRB?=
 =?utf-8?B?NkdpbFJweU1BV2hwNlFOT2ZRUjJXek5kODY5b2lEbGRhdmVxNmVyRytYNndT?=
 =?utf-8?B?RWFEbnZSdCt2bElXN0Nic2VNTk9QZjFrM2lOU0d4NmoxNUhCNS9CdkFhQWFL?=
 =?utf-8?B?VnQ0UGNPOU9pT1Rqb2hLcHAwT01iRVM4aWtleXNVR1RMNERhbitzREZ4Sk9z?=
 =?utf-8?B?bzY1ZnR2R05tbEZmRnd2TjQ3SHdpU2x5d05oRjdQcGVXM3M3ZHp3eGhTUmpV?=
 =?utf-8?B?WHRldHhBRnZ4Y01kclBhNUdSc0E0QUFING1ydHh6QWovRncvSUJTZTNMSDRr?=
 =?utf-8?B?aTdqUUE5amtPRjBIejE2eXJBajB0aUNNc08yVzA0YVkvNmUwM3dzRjQrWGRv?=
 =?utf-8?B?VE53QXpQZis4UGNiWUNkRURKTUNiWHJkbmxSa2l5YXlKKzJ3MmQzODdBNGZ5?=
 =?utf-8?B?WVdNQTZQdGNpYzcwVlNhZFB0Uno4ZlF0T09VWmRQOFVMOEtweUhnUXMxNTlm?=
 =?utf-8?B?SHdQTk5jN3AwN1QvVW5jSTUvYTNtajFySjBoMjUzcDY1Sngvb3crT0F6eFd1?=
 =?utf-8?B?N1B5LzV5UVZvQnFNdzFuVzhTOThielc5QjU1K2p2VlR0YXlRR3pNVzAzVUdN?=
 =?utf-8?B?L1BsWkpydGloNGVyWGNMKzZSYzQrdWhrTDF0dmdxL2FkalZzMXhGdFZRb3lN?=
 =?utf-8?B?YkhuRjVPbERsK3Zicm01K01TZGQ5aTFNSGQ5SkVaNE1JRlNGQ241N2kxMG9u?=
 =?utf-8?B?Uk9GYTMrNW9TUXB0YXhKenF5anJPa3JlK3hkVUdTQ1VrWHU4bE0rUjJKTWlP?=
 =?utf-8?B?R0hHc3VBOXI4RmFodmJ1Tk9ndEozQXJSWTZCQVdYOVhlR29uWUw0bm45RTRx?=
 =?utf-8?B?YXhyRXZ6ajFvSHpIYlRXeDJJSUhiajlvOVdvNVpHSDNwc2w5UEtQbG9QcVhh?=
 =?utf-8?B?c091VkR1amp2VFFVS1ZKbEFEaUEvcUF5ZitUMWZnU3FGU2dBcytSN3BOZU03?=
 =?utf-8?B?RW9KdzZ0bE5HeWFUYVNOV1ZSRkoxbXlnd3dlUDBPbERPQXdCRG9VcmVNSi9h?=
 =?utf-8?B?UFF5dnFYWEpabEJBN0FoNDYzUmE2WTlWUVZSaFJoRVpiTTJiRmI4MmQ2YS84?=
 =?utf-8?B?SHNPUXYwOHNYSHJRSEx3amsvalczdTBNMXFUNUVIMHYyTWZMcThpWGN3Vk1H?=
 =?utf-8?B?TzB1YUdNblBWNkpPajRUY2lqemd4ZDFDcEE4aGpTbnB5MXQ5WFlpQWluWkNy?=
 =?utf-8?B?RldnY0xwNkorbFY4RUdzRmM3QVZMeHZsdkFwSWkzL05veTgwNVFzRnc5SDRV?=
 =?utf-8?B?RWJyUTZENi9ISFVKL1N1czF0MEg3cFB3dHZodktiZWlpWE1vMGhUQmt0bFNo?=
 =?utf-8?B?aEhJNk1yVEllTGNoZEg3dUNMQTcvemx4VFl5Qm4rL3lrL3JiV08xN1dYR0Jk?=
 =?utf-8?B?TzYyTk9lWVlXSGJaTnd5NWpnTEI5UVBzN1JINXp0UmkwM2YvUVdxcURQZ2dC?=
 =?utf-8?B?ZkZMclpSdGZnVzgvdVhRTHhrNnl4UmVPSmxNK0hHSncyVzV6ZWx1N2VXTU1Y?=
 =?utf-8?B?YzB0bDRCU25IR2FEdXdYTDUzQlNuQW12aHNwaWZyZHdoOTd4Qk5JdEIvOW42?=
 =?utf-8?B?V2I0R05VMFNBQUdqSzIxbDFIRDVKT0pGc0lrVEFIUTlSeDIvaTFaQjkvL01G?=
 =?utf-8?B?aE9ZcThrZ091bW1EbGRGdUtzQnVnRzhHVFBRNUZWbXdaMUI3Y1hNdTI3UHFE?=
 =?utf-8?B?WjNQY25MSDZ1RkpwYllETWdWZUVoZmFpb3FkZlBkZVBUTGFXeHRiM1FFV3lF?=
 =?utf-8?B?Y0IzaGQ1eFMzMWtPNk5jVTMxVzNsR0xTb1ZQR1BISHJMekRvY0VMZjJmTWxK?=
 =?utf-8?B?MUR0aStlNkEra2VBWjFzVzRXUG5weitFUFg1N1hBZVM0Y0RBcitvNVdpVzFZ?=
 =?utf-8?B?eHVHazNQa0lDYTM2dEJkdjJUSUx3a04zb0xUMXVXdUZYZXB2UjNENk1lejJW?=
 =?utf-8?B?MTBERFpOKzFRS2hXNkFEYTdwbkNyQjZVT1hFMXdWOS83WFRZNmJzenJ3STBV?=
 =?utf-8?B?Tko5YXB0VDFkaGZVTi9yb3VUUXJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F577F96451922428BE277F4C60AF36E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?KzBSbndERnRMTnBnMHJRRW9TQVJYRW4zTm43eFNwakJRN09UaG9wSUNTTFZI?=
 =?utf-8?B?ZmRaeW85ejRzMlBjQ2IxZEtOSUU2Mm8reDI0ZEhlU1NOTVdKMFg2WkZzK25P?=
 =?utf-8?B?VkR2aVplWWJ5cEZzQi9CK1VFQ24yZFMwemNMeFZQNTRFT2ZnTW9tS1hTQkNH?=
 =?utf-8?B?dEFlTGJmOU9UVjNEQWYrb05mejc4aU56MWd5bTJPdW1tbk5UN3IyZFduUjdS?=
 =?utf-8?B?cHArT3VCVEF6bTJFNzNrRGdqUzN1Wk1VU2VPYlNUOE9GMGlFaFFrSEJCRnQw?=
 =?utf-8?B?ckJhelRPTVVjcWxCY2xlL3d0K1E1WG9FcVBEQnJLbG8yak93Ty8yemc3eUl5?=
 =?utf-8?B?K0ZMWlFKYTNmeXh1MnF4Q2Z2MEVuSlExRWdVVFowYTNWQWFPaDIxT09mbi9S?=
 =?utf-8?B?VHlHV2RqN2VWZVpGNTFPMjUzNXpDeVBqRlVFZjJJWjNHVzh0b0JoNDNSY2U5?=
 =?utf-8?B?TzJoZXkwZ2tzSUZBem0vb2RHcGNFZm9hcHZOY1J5MjV3Q0hZaVN2aFI0NmZo?=
 =?utf-8?B?aFNXZkQwM2lDdGZGYW8yZno1S0V2V2xneXRxTUwyTFFTZ3NnSUN6bUZzTTdL?=
 =?utf-8?B?OWUrWkt6LzZZNGVMSDVySnRKYUJmQzgyZStNejdPK2diZ1FMR0E3Tk9SRjRO?=
 =?utf-8?B?MWJyNWtMQ3doZkx6NGV0cSsrc1lLQUJNM0V5VUhZTTlUaU5ZeDJKc2IyWWdh?=
 =?utf-8?B?K1laZWJDOW9RS1hFY2o5WUNkRHI1R0N2RUNUeDluYkNsVVpkSTZqZVlmOVZs?=
 =?utf-8?B?VU5vbVNHU2NkSk5tbzVGWkl4RUwvSGFqMWtWQzFVSnExYW82TzJUdjFSZFc2?=
 =?utf-8?B?akFBVUZ6ak93WFlzT2ZMK0ZmallwQTVSY2RNUG9XOURjQ2QrWnA0VDcyTmZi?=
 =?utf-8?B?ZWRtSm1PbGw5MUw3V2prcms2TWplUWhvKzE3K3ZhQUxwaVlKNnpOTWg0UzFm?=
 =?utf-8?B?dTh5OE9xQ1FqRE8wNm5jSXBKT1J2aFhuM2F0VnVHMXIxajhhZ0JxekI3aVov?=
 =?utf-8?B?NHJON2JFSmVhVmNXemNMcUlzRk84Q2tsWnpRUFR1RHJhY1FRK0gyckxLa2xl?=
 =?utf-8?B?YlIvYmtQOG9jU01McDJaK3UvRVZaNjRwZDVua3NQSnJ1UlA4NU8yNVZWQzI2?=
 =?utf-8?B?dVZuMjZxbzk0K09QdDlLQmhsYmJBdzVOVGRjN3FmbXhyeVBzNFFrcHU3OVRE?=
 =?utf-8?B?QjdxYUk2REo4WUwwV2tBOTE0MmtzK1NQM25ZaGZkZ1dmajFBRVFra1VwemJR?=
 =?utf-8?B?ZlBlTnJ1M01tN3AvMy9RRXU3NWVHN3BtWFA4SE8zbGtUQ0orbFFRMWs0d0Jt?=
 =?utf-8?Q?7249V9Cgo1T2XmOWVA08lHPwZ0qECfSBPf?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21111886-9d36-4249-0d72-08db9454306d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 19:02:31.3664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JgCJx2Np0EALE1z4yuAzbDeL23vKznumn8Us2YIYaJw9M8BfR5+4BMQYs7kKgU/MLkDv1QSQTl8SdqU3tYzCIMm3xdof0RoVNR5IyhNzu0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8344
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
