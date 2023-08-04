Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE41276FE68
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjHDKZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjHDKZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:25:55 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6470846B2;
        Fri,  4 Aug 2023 03:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691144754; x=1722680754;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hL5sC2RatK1XQbsOIupY5HYMsFXlcrP6OFNnOQf8nZU=;
  b=aWIg6/Bs8SEmTo2kKECbNKl2oDsb7OPxVQwj44Pktit2IKIC/YfDreEh
   tquJLvBZ3isDuahbIpcuDy/6b9ZjNkGppcnu0MU64xeTau3zUM50y8Rpd
   +WfpWA3z/5IeP9WPkh+3ag10pW5Y4ScLBj/SJOCTJ0PHB9GiKpTNGZge1
   DzKG/8QcwR7LCFGF/DAoZQ0Swjsh4+NYcsuyO8d7OeRhQZVyL2G+dHOPl
   gzTemNgdQl4lkMaxNbwYVAqJEFIIzOuY1D4RAPuWlTUZ1iK7wx5HKjTTP
   KSWYZBPTlmYSxwMpftANUD0tqPaTsbnvOjylNHRO2XcrF6HS0Od7r+vMP
   g==;
X-IronPort-AV: E=Sophos;i="6.01,254,1684771200"; 
   d="scan'208";a="345208389"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 04 Aug 2023 18:25:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFwznmTP3lSM2gBlvv01eY4hWo8gjM0tX0ax4yhfO458RZg8bh7xwcsS2xV7pG2TGuKg8ne0isMtldV2WM/8TDM1SzePWsRx0l5JIf59rOTeD+jCXeXeM8NYCRNJ/JMUoPddpXqzTNxLM5jduUhgiD3V/7c3h1vyteHCX6fWklrgXg0TKuWOvuou2LG2wnI7k7JCkVmAC+UEDZ0I2rKe9tDDK2/3iq/dG1pwAbFmcCNaxuh8CB5/YCLtPLgJf/ldN2RM06vM7Kyl0Vjvaa5pBO+GVITi0MyrCgAsM/gmailUSNWmtdt/8AQWzoDHPlPtJvWnt4USW/F+gTlezQUUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hL5sC2RatK1XQbsOIupY5HYMsFXlcrP6OFNnOQf8nZU=;
 b=lxuelXIaVaxhQppxtT5JRk96EKjK0DZrfsR/zsPHHA1VPmhQ4i+xRxZ0NGiW38JX8+LfQ0z3dfbi7kgzIHCeoF30hlEE4+25IVZXrcs3/BzrVwuha7Zkc+bR9OSaL5LEcD1owp4oIPD/0qjNJrBvAfyket8I1Ez9ZxCZ7kmo4KRssfRnIoh9vmmSZvQb53cXTyDvYwLxGlhUyG1Qyv50ELmYS+tobX+ZFtsOVEpDopU1wzpqbnCkf8WnA61mpgH2Y8PD+NjByuLEtIQinvkWkNBZx8s91e6xXFpF7dZ+KqUihPOAg2cjw6CbJe4pRANNRbE2bTh8h8txcp2sbVwO6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL5sC2RatK1XQbsOIupY5HYMsFXlcrP6OFNnOQf8nZU=;
 b=Y1DD5eC/GSATqWj6ghmrOV5GMp66EUyS5V1kRtARg7wMI23x2V4xP2rvgHcWvTQieMSs+F4pnTX6dLG30w5UOG3OGoHQFuaDHiJFzCSwPqjnTZHWAr1lmVw+/dBm13orEYGO+AKbQgJk9Lbh6OCQ+wyiHR6t6dcXhnYhDJJ1Wuo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8018.namprd04.prod.outlook.com (2603:10b6:610:f8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 10:25:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 10:25:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
CC:     Ming Lei <ming.lei@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 3/3] ublk: enable zoned storage support
Thread-Topic: [PATCH v10 3/3] ublk: enable zoned storage support
Thread-Index: AQHZxhQZ0nPbn3NeaUu3a8qa1gGuKq/Y7zeAgADodYCAABhAAA==
Date:   Fri, 4 Aug 2023 10:25:50 +0000
Message-ID: <c4011962-013d-4a7d-8c6a-40afede101e8@wdc.com>
References: <20230803140701.18515-1-nmi@metaspace.dk>
 <20230803140701.18515-4-nmi@metaspace.dk>
 <f339913a-3f73-5fc3-27d1-73491a8028a7@wdc.com> <87y1irw1zh.fsf@metaspace.dk>
In-Reply-To: <87y1irw1zh.fsf@metaspace.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8018:EE_
x-ms-office365-filtering-correlation-id: 6409306a-bb16-4420-0308-08db94d52cfe
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rWTZ7s94lgPUqAuWRXF2KH4Yy6ThktoAv6KVNy/mGZHhr2Qzv4iWfZkQpcDoVxkHX6NGpjB1wAKUw8+hIJbr3AeaiSJ6wnrYEVzvAP5BcFXvGFctGbUk2M3rxcCkVjNKBAGtBLc+jhQxsUNZHTQAN+WA9MdevkcVJmB1PeIgfBWa8pSoZfsxHQddMcD00yRovvTne32kLP8yOBwdZC1lNQ9lvikMbx9jEWB6Gn0Gx4igXHj1OOxW0mEEv3BDVxz5+EK8Jh+1JFRVT74X/P1rc+dI5LMhwnAWdoaCnKnbiITjJSxeF8qZ08Dxd1j610nfXGHsGh33I+y9ve6TD4akKLYFIqmae2iZ0Ouj+SLWpKmXr9IOinFTtPmn6fJoLl1XD3VCcjsu6eWiI6/yhTvvWFMPmJYdhSuXJXix2L2ud/JZO5cllFrNKLYQyO77yIDASYVMsiBUyoGnuUm76/1ZUvlx9EFBvy4eL1iOQoWeW82XlUdMoQ4nGLhuJzUT38v/rsulrCZx16wThiy1MTQLnWBsO+bnxAsUjyNzaZ3DmgM9RhFUAgZHkTs3a89GumKgc6KhyUJwNLpp/0YQnDQiPA7DtEyvhjjELUvcfdI3dUQzp4Sit5TFxJl7xc+tGNIn660bOHFgINcH7Ql9sVRZFWZQyvQ56CakevewbgW6Pmimp13ztCcQszMJ0FQ88H/x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(186006)(451199021)(1800799003)(66476007)(66446008)(66946007)(66556008)(64756008)(4326008)(6916009)(76116006)(91956017)(2906002)(82960400001)(38100700002)(2616005)(122000001)(53546011)(38070700005)(6506007)(7416002)(54906003)(86362001)(6512007)(31696002)(478600001)(36756003)(6486002)(71200400001)(4744005)(8936002)(8676002)(5660300002)(41300700001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0lGN0MxMkJPVjFmQ29takRtUkJtaUpRZ3ZpdkdLTDBTUUVQc0ZFWi9vYUJz?=
 =?utf-8?B?ZmRRZlQxNFRDVXVtVkJiczRwaXVRb2VLbHlITUE2aGRZeWU4a1BhVHZkWUcr?=
 =?utf-8?B?STJKalZKZUFxQWkvSEdCc2VjYjV3K0tvT2JZNHEvU0g2QlF1c3VDMUVidTNJ?=
 =?utf-8?B?YXpNcnQ0NE9EbDRKMkd4Sm5lQjNYcUR1UVNGN0FmMGZXTFFBdGJrYjVGSVZ1?=
 =?utf-8?B?ZGVKandRNkpPRzg2aHNaNTErZXVSZ3ZnbzkxTUFzMHZvL0EramVuTWE5dUls?=
 =?utf-8?B?SnNpd01Lakg0NnFKY1FjcVUxUm53RUhUYlA2SVJEcnRyV1Rrb0dOa2V6dURK?=
 =?utf-8?B?NlQzZjhDUmtQNnpDRE50eG9KMU1LSkp3WmlWR1U0a1lsREluWW55MGFZVzFt?=
 =?utf-8?B?NVpuWHBoMXFDV1plc09LL2dNMGdjQjJjRjJjMEZtd3Y2dHlFT2Z4TkN2aVFW?=
 =?utf-8?B?cGxQaHRlbjR3bEdRUzg4dHNNQXlIL1NwYTZTNitCVjlMVnM4OWxlY3pnU2x0?=
 =?utf-8?B?cTBRSk1GVmNYTGREVzZESFVIcjlIdFRpQlE1eVo5U0NSNWlsSWlXaU9WOFgy?=
 =?utf-8?B?bG9SSG0raTVhSzQ4WXE3RFR1SkNBbnFyTHBGaDVoVU13QkFuYVpRM2EvUFJI?=
 =?utf-8?B?ZlBCMS9BaERvcndmSU1ROEtYaHJPRmpxajVPMnYxeFZvVk05ckFTWU5SelFx?=
 =?utf-8?B?STJvMmxaajc5U0Z5SVhhaTk5WmY2RlZjWTVaQmhhNlF4S040UlVNcko3V0xt?=
 =?utf-8?B?OG5HYnZET0JHN2lTdHJYSXpxejFPYisxcWhNczdhV3VFamZaaUw0bjdvM0RW?=
 =?utf-8?B?Z2VEcDF5Sk13alhKNzNiVDJjVVduT2IrbEwwcTBTeEdMK3VrMmNQYzNIV1Ez?=
 =?utf-8?B?TnVTWGVYN05Ua3I3Wlp5SXZHWG9NbVVLczlwU2xxN1d3OWhCcFhyWlE1RVFn?=
 =?utf-8?B?UXdad1BHd3h2c25UaDlkM1lLYjRzTG5aQkZodFJmYzVMeGdtWlRqREJDdWFN?=
 =?utf-8?B?VjdHWHF1VmQ1N2NhMjVCZ3laazVqUzVwWmFqZnBZaXN5NGluU3pPdHhYcVFW?=
 =?utf-8?B?SjVmRFk5TSticG5YMnhNQWQxZVpOMjQ3TDhHbUVlTHlvOHl0ZDR2bFViYzRW?=
 =?utf-8?B?TllqUW9MODVEeCtyaWY4bjNBbWpqUjhRcXhreUNBTFBDdmRyNFFHeG92Wi80?=
 =?utf-8?B?dEQyVTRCK3hzUGlsNjJDeVFNK1BQQzVqL2JtZzhiTFEwUCtqSTE3QjlqM0t5?=
 =?utf-8?B?MDhCMHk5V2xRUGQ5YnBkdUIydGp3UjJyZ0dVWE1VL0hic0FjVHdMM01VdExX?=
 =?utf-8?B?VEh6SFJlK2dybGRiUjF2MXVhQUQ5cHZnRmdoeVVjb2dhdTc1bVV2WURpalBH?=
 =?utf-8?B?MXFBTmZ6anE0U2RvWWZOWVVsd2cyYkpiMTRuUzR2RjJYWHF6SU9aODRKZEI5?=
 =?utf-8?B?VXViMkdVSDdBVG1CVi9OSzJFQy94ZTliR09senRZS1A2U2VaWGFhQk1iK2FU?=
 =?utf-8?B?M3hMYi91SExmOEYxUHZYOURxeG1rNmk1WXB1d1FWMFo4Nmw4ZXlOSUV6TS9y?=
 =?utf-8?B?SHFtTUhFWmphREZyb1dORGswMTE3cU9sT3U0cFBwTFhheFg0NlF0RzhrUGNM?=
 =?utf-8?B?RlB4QkJXYThBNE9obkVsMUVhejUvVlQrVURzaVB1K2U5THRnMjBKckxqLzYz?=
 =?utf-8?B?WjVpUERNRDU5NVZ5QWFncDExdWFEUFFXdmlKZFh1ZTJEeU43U3MzU3U1SzdQ?=
 =?utf-8?B?cFVQL3NlVXJBUnN3R1VWOFRybkdldDlzRGRZWFZRajc1NEYxV3FLYUJvUkFI?=
 =?utf-8?B?aUhtUUNkck5Ta2MweCtya3dBMit1RWlVZ0haa1hKMzJTYjEycGFvdUlIWUVp?=
 =?utf-8?B?L0tCUVorUkNUMGtWMmtlaHFyVVB4V0FuaUV2bjJzZHl2VzFkeHZPVWc0VTlX?=
 =?utf-8?B?dFNldTBEdmthZGpySzFXbFRuSlJaT1kvZENtWEZURkowMzlqWkRHVEtGWGhx?=
 =?utf-8?B?b0t1bVZWSjVXSkpVYlpmRXdxZ2tvYVdpa3ZzTWIrdlVMdDhIeVBmbTg2OWZs?=
 =?utf-8?B?TlJZNnYvMkorT2hwK2haQjlFeWx5NGJ4Z3RKajJSOEcyekl2ejJtUEJOWEQv?=
 =?utf-8?B?MHU4Y05mcjlOU2dnUk5zdTV5UXhIY2F1c3JiV24xSWlKSllnUURUWVhnVlVx?=
 =?utf-8?B?U0xNTXZKaEFRYXA0ckNuRVdaemlpeDVZZWxmTHJrVU1uZlBjK2w1a1kxSWVo?=
 =?utf-8?B?VnJ5UjJ2VGdUZGF2VFJiZkU4Z29nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B9BBA34DE910E439F0CEAFA556A9229@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cGk0c3Y4Qy92azg2YlFFWTVkKzhEaXlNcUUrZnJMWVdiMVF3bm5YSndYUjg4?=
 =?utf-8?B?bEhRQ05VWkRJUEViYWcrMzNOQWllSWlOTU1JdEtORk1jemZzVXhuOXFBOVho?=
 =?utf-8?B?c09nUzM5QktNTmhmV0VudDRZeUhZN3hucFBpWlJBVGFuRVVnTmhvcWliRENp?=
 =?utf-8?B?OHZLODVKaWNhUkNDZHRpT1AyNkFpRSt2OUs2YytybnFUbnE1cnM5S0lYYzdn?=
 =?utf-8?B?aEFIUlpNWDB0cTR5SENyMTNrWVNuUjhYMFRFRTVyTHQ1T2h6YUNGdFZTS0t4?=
 =?utf-8?B?MzBxMCtSczlFdTFFc3lGVFRLa2Y1OTZlZHYxU0QzUnp6dDVYM0UrTXNNZU5B?=
 =?utf-8?B?WitUSkF4Y3MvaUhPdkV3NnZTRnU0amdHVzA5S2k4WXdaOXFlN1FDaUdNU3c1?=
 =?utf-8?B?Ym1zalZ4dlc1bVlFTVlKQTV2SW82N1dEbTkvejJFa2ZZeEM5K2JqVVBybzA0?=
 =?utf-8?B?YUNJVVQ1eTBSc2daVVdYTStDeXhpcURzSmc2QXZZbDNSOEhMdWhvUEtUeFNt?=
 =?utf-8?B?MFFQenFnemVSMkFMbXRYdnVCQUhKOEt0eHlSYnF2dXBzM2FjMFRzSUhzQnVP?=
 =?utf-8?B?TnE3bWRIa1lQblBtU0xhVVRqTit3MDI2dDAvNXUrWWl0emM5NWUvaGptRDZC?=
 =?utf-8?B?VCtIY0FONU82VHcyRy80eUF1SmdORjVsclF0ZDJTVzJvMHF5SzI5SFZmWWJK?=
 =?utf-8?B?d0QrcVYvZkRLajdtcXk2ckt6ZGkrcVhmWlZKb053Q0s4SmJPdDhicGVCbEYz?=
 =?utf-8?B?WE84OHhYY2YvRUZ0MmFDZHV5Q0lEdm4zckNtTkxZaUx4VVhNaytIT0VXeTlI?=
 =?utf-8?B?bDB4TFhJenkwL3A2ak5sUHBERzduNTdRVkI0cHJxeVR2eVorb1BzdStuSXVH?=
 =?utf-8?B?M1IvOG5nYVBaZ3ZOTmxETGh0QS94aEJHVGFsemxmR2FzcjZ4TGZwd0IwREpx?=
 =?utf-8?B?NCsyVUNVWEFWTGJ1cEt3U3k3QnZPdER1Z0taWTlzaW56WDFkUEZVOWdZOUtX?=
 =?utf-8?B?YjZDb3FTcHhRQ28ySHNCTER1bk5vSE0vSGVMc3U4dVNzYkdmZThjOUFwc1BJ?=
 =?utf-8?B?bDhwTnB0ZTVyeHl4Um5Kd1daNkpodHVRU3lvQjJuWHUwRjA2N3pMOEwvbE9D?=
 =?utf-8?B?SHppdUZZZFo5S1VkcHVxWUZyUnZrcjJvd3BzVndLd3kwaEpod1kxL0pURWZQ?=
 =?utf-8?B?UFg2dXdBUnB3SWN4YzZpd1lGYlJ4Qkc0U0xMMlVDVEtVWitIN2VSUy82dnlp?=
 =?utf-8?B?WHdaYU5rQTZ4VE5MeEs3NVVFMEN1MG1MM0ZPbXUreENab0c3Y04vR1dzWSsw?=
 =?utf-8?Q?AqG4hGpFjt9A4xAwoVMyS1O2PuUSp9ft+I?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6409306a-bb16-4420-0308-08db94d52cfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 10:25:50.6452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8i7JWOTno7pco34RbfTqE45B9ND7hfZuBLIeElWDRtKWcJFG3joLc4pamNrTdzCm7EuohjtXX0nsAuhZKpyguVFanobjArXgcZ+ytSPwHys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDguMjMgMTI6MTIsIEFuZHJlYXMgSGluZGJvcmcgKFNhbXN1bmcpIHdyb3RlOg0KPiAN
Cj4gSm9oYW5uZXMgVGh1bXNoaXJuIDxKb2hhbm5lcy5UaHVtc2hpcm5Ad2RjLmNvbT4gd3JpdGVz
Og0KPiANCj4+IE9uIDAzLjA4LjIzIDE2OjA5LCBBbmRyZWFzIEhpbmRib3JnIChTYW1zdW5nKSB3
cm90ZToNCj4+PiArIGJ1ZiA9IF9fdm1hbGxvYyhidWZzaXplLCBHRlBfS0VSTkVMIHwgX19HRlBf
Tk9SRVRSWSk7DQo+Pg0KPj4gTWlzc2luZyAjaW5jbHVkZSA8bGludXgvdm1hbGxvYy5oPiBzbyB0
aGUgYm90IGRvZXNuJ3QgY29tcGxhaW4uDQo+IA0KPiBUaGFua3MsIGdvdHRhIGFkZCB0aGF0IHNv
IGNvZGUgY29tcGlsZXMgZm9yIFNlZ2EgRHJlYW1jYXN0IQ0KPiANCj4+IEJ1dCB3aGlsZSB3ZSdy
ZSBhdCBpdCwgd2h5IGNhbid0IHlvdSBqdXN0IHVzZSBrdm1hbGxvYygpIGhlcmU/DQo+IA0KPiBJ
IGRvbid0IHNlZSB3aHkgbm90LiBJdCBzaG91bGQgYmUgYmV0dGVyIGZvciBzbWFsbCByZXBvcnRz
IEkgZ3Vlc3MuIEkgd2lsbCBjaGFuZ2UgaXQuDQoNClllcCwgdGhhdCB3YXkgeW91IHdvbid0IG5l
ZWQgdm1hbGxvYy5oIGVpdGhlci4gVGhlIGRvdWJsZSB1bmRlcnNjb3JlIA0KdmVyc2lvbnMgb2Yg
YSBmdW5jdGlvbiBhcmUgYWx3YXlzIGEgcmVkIGZsYWcgd2hlbiByZXZpZXdpbmcgY29kZSB0byBt
ZS4NCg0K
