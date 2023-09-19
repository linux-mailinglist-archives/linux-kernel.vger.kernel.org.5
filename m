Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815177A5BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjISH5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjISH5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:57:46 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3037F100;
        Tue, 19 Sep 2023 00:57:39 -0700 (PDT)
X-UUID: 2ef32e5656c211ee8051498923ad61e6-20230919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=y3UNZRZkStE/oix1LW2KuEpLXthO62RoZaycpGsl93A=;
        b=S+tmBpRWJaG/+3fDgFDc8InWjrpzqonJJvlLa0vsht3IhRCKeUbw6Za9H3OzU6nXFRU/3+0435CaTVBLFy+l7Ylf5gsRLTIC4oBJsDTNt1hwxx59IxGs/7Gz+hYkqI+SIEH2sTQlf/cHgV2yJ03pK55W3SHkbpkDEaOYQfOGxVE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:5dc60e79-0cd3-4684-999c-27a7b11095aa,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:ffd201bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2ef32e5656c211ee8051498923ad61e6-20230919
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1102026814; Tue, 19 Sep 2023 15:57:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Sep 2023 15:57:29 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Sep 2023 15:57:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QttUI+cQx8H1D+gMzyh0XD/ZdlwxBqOePgoKEsNyw+9pMNXcgzMGLVhPEBHnty1RBJAPHt9FfFBxXtNpG3c01YLbiBXc+tBIdvqXpCsmgTQH02jAecXIr4lTCbD9bPv/daIWE7BIgyINXr3bHsVRbmnRMFR9KeQE0TKAnYLj9LIQZEAYoNJE1DDLNKMj/TXGTrb23+wxM4GUMeD3uJgPAkGg0asjYt//Z4HoM2/MNtblLbm91KANCIO6CZnHQeZ06jAEVjKMCRZ/SEP/vMkFYd/vrdpuEnCjexw8LED8PWzugBbUaoHQoVNP/7Z9Bj7ECsAA2VHXf2t27vDFwIGDdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3UNZRZkStE/oix1LW2KuEpLXthO62RoZaycpGsl93A=;
 b=lg/rln7Ly7OoUWjmcpZ52+EJnhE0LHJ4IEsisT2cGLSQYxFSJZhlZe7EmhVNcygCW+zQUiYvSVEsu4VViF6wgAHtin549fAH/62hJ+eTWnCRzvMYWm/LqoKcYanwh3WfFmw5ekHkbdVTwcg3M946wPSCKSRttyI5//VRSRVU9HGZcvYfpFJYgaTlms0WBL7ZOps5aKfD/SVxU+dintLjAoaOHKKcZfz0+zVzGNttSSjGXNnQVdYByGKAY5qhhiBPEczrarqwaiVcFvWt68I11rNaec/sxkpwsfxu/j/Yvhcfyw3ydh67TYZ42/peWkPJhPVeVkIM5wubQltJWGSiSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3UNZRZkStE/oix1LW2KuEpLXthO62RoZaycpGsl93A=;
 b=sJUOZfZ3ZLFI3VrNiRJXZRfypVlrucQLxYfITRIhAQTQ+sx7pbtIxwiaFJxu5DrJ9ulSTjd3z5DtH7bvjDbwjNBhDRu8WsvTN+ohfliw2DibhhLS3VxBxgEFO2pbrVmjQh6MZtEm9SXH+SDmDuGPpj3Is1Vd6K2u4M9ryIsbbro=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by JH0PR03MB7656.apcprd03.prod.outlook.com (2603:1096:990:b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 07:57:27 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::ca92:ecfd:d3bd:a9d3]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::ca92:ecfd:d3bd:a9d3%5]) with mapi id 15.20.6768.029; Tue, 19 Sep 2023
 07:57:26 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 1/2] usb: xhci-mtk: add a bandwidth budget table
Thread-Topic: [PATCH 1/2] usb: xhci-mtk: add a bandwidth budget table
Thread-Index: AQHZ2z15Jmfk9XeA8E+8+1vP3dvpyrAaMeSAgAe1dQA=
Date:   Tue, 19 Sep 2023 07:57:26 +0000
Message-ID: <51d4f160ea5d99c310f88381a1e0a3cd2ebd9f05.camel@mediatek.com>
References: <20230830122820.18859-1-chunfeng.yun@mediatek.com>
         <712ab5f3-eb61-f7e5-fc67-c6c175beaac0@collabora.com>
In-Reply-To: <712ab5f3-eb61-f7e5-fc67-c6c175beaac0@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|JH0PR03MB7656:EE_
x-ms-office365-filtering-correlation-id: 0fc158f2-318a-451d-0ab2-08dbb8e610e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wla+3kaG7wfn1Z/vu17Yv3s+lURlTdLiQrNiZzIG3qbDQHylNoI2loGfis6nfiJLJrolsrTD9HFDWuEIllyR7IZ0AEncn6/0HPxLFnP67/XnZQSzNCSjb1Xqh/Y8yMJED9X2GZ2AaaEJZ/V7PTnSmDt7J2psZP4/dDhDo+Pu8ip9lg8EE/EzR0ygSWGlxZYIQ4D/iKv61nYReNV0uai3rna+Z5ovQygVE4GsV3mNv0s2wDUITwWRQ1LgjGb6Qgu4KPkkSEJiBLsdro8T5AT+8JP4zr0/097waTuIpBU1fyNYKNdZhA87K/8iaFWF5x4TqnCjIGQCKvo4YGuT1MDgQCyvMBvThiYrNnCkaWBusCU1O1n9WD0QvhvpUlTEjAqo3HvWAub6G3dfT4aqjud1NcfHvzoRk9HaSd0HV36mouWMve448aUtaUa7EmcYMir+ZidZBR60XKRk+Cs0EZoOtMLFjXHrQhL8h+nhRMGrlmHVYpn3BjrF5J4ZsA9RavMq9t/Zh3RAZQQ21oQe4rNY9RJdF/BDE5uNdo+fRhmu3OnIEhBK+X7F92jArMlPv5Cco0rcaAt/hF2pjyXEu34R/IdXgUD8ed9I1z/iZdOvCQAMM+7ld9Yf3fSy2Yn0orNtKW0iUrKb49eka+DlCMilonpBaXuc7zED6eTmo0lnET+qSeLQBzGd3Cwnu/ghyv9g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199024)(1800799009)(186009)(2906002)(5660300002)(66446008)(110136005)(26005)(66946007)(66556008)(41300700001)(316002)(66476007)(64756008)(54906003)(91956017)(4744005)(76116006)(478600001)(8936002)(4326008)(8676002)(71200400001)(6486002)(6506007)(6512007)(2616005)(36756003)(85182001)(38070700005)(122000001)(38100700002)(86362001)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?citnNUFHMHpEd1R1Z1M3YVI1cWxSS0tlMWlDNmg2bFBEL0VmZUVrU1ZoRnJF?=
 =?utf-8?B?RTBib0NTNEJvaEwvbGZma0FqNlJEaW01TUY3NGNPOWRMOGFKenIrYlowcFZx?=
 =?utf-8?B?OUEyR1Jpc3ZNR1FDWVprZzFNeWNRRmRETFN3eE4wWUttcWZlMW9VZUtpdHph?=
 =?utf-8?B?SzE3N1ZpaHh2WmVmb1Z2akg0d2dFWFFEbHBNRnIxa2QwT2dxVTVYUG5jOFZh?=
 =?utf-8?B?ZkUrYjlVL1lPODJ5clV5VEZrWlJHZU96ZmRqZVZ4aUFLQk9sNHJoZGdoMVh3?=
 =?utf-8?B?YXlvc3FWNHdFQ2RzM2k1bHEzNGlGY2pRTU9aSnB2SkI5Q3IvdldBeWZReXZj?=
 =?utf-8?B?bmpkVjhwUm5yTUIvZzl1N2Y5cG14c2hldmVzUEwvWW9WVGxoUHZSRUluNGpM?=
 =?utf-8?B?UWkvVEx4N0l2RHU5TGVRUnlTZnBZY0V6ZjF4aC9uNndxcFdIbklSM0xEazZ5?=
 =?utf-8?B?d2FlUEVzQS8rV2JiQzcvenAveUJaTWNpNnU5VUhHdjZQaGZ2WWwrWnBuVDhh?=
 =?utf-8?B?TmVRR1hYb2hGTFg1b0VORzNCZFIybUdsUjBja3d6NXhSeU0vVWM1QjcwMTRx?=
 =?utf-8?B?eWs1OVh1aHhwKzRGd09qZGtPWjErK3c5MUw1cjlmSWRvcHh6cW5obzVSVU0y?=
 =?utf-8?B?bkdZekNIT1VuRlA2MldaallDd3lCSjN4ZDhjYnNHcVZFTFJJQ2NUQ0VHczc1?=
 =?utf-8?B?SXRBK0tlRjBHbkxVN0Z6ZXVhZzRXZ0IxVXlsMTRsTyszZm1QZ1BPQnVwcU9W?=
 =?utf-8?B?eFpQemk0QmtXY1greU8vMlcrTmhZQ3ErUUd4Qk83VEJCL291aEk4bWlSYW1m?=
 =?utf-8?B?NW9Iejd0RjVxdGhmeTRHMWlQMlBUbGxwTTJKdTNOM01xd0FQU01yZ3RpQzF3?=
 =?utf-8?B?Zmt2TFdwMVZSVVprTlhKRC9sc3J3Q0s0SmlQYTlrbDZtdHpoaEVZT1BKOVI0?=
 =?utf-8?B?MTF1VG5qZWtJMTZCUWxvc3BQRVFDNjVobFN1QncwUWFhUnZ2cXIzV1pSZ1dS?=
 =?utf-8?B?dllpd2JOanU0a2NXZ0EzLzZpU3U2cndBWm5mWTExYlZ4a3VYeGY3eHdjUnhZ?=
 =?utf-8?B?ek1BTXp4QmF1M0pERlZjZE40NjN6WTJ3VU9uSVFtR0NuSFd6QnZQUzFGOUVj?=
 =?utf-8?B?T0pzNDJmeVJnZmFVbVBtUFY5ZGNBLy9sWG5mQndqOXN2bkRLUzRmN0Zod3JT?=
 =?utf-8?B?T1VJWWFYTTVSQmQ1Z0ZkYnJaWU0ybkpodUF0ejZOZmF3OEF1LzZYTGh1NnNS?=
 =?utf-8?B?bGJCVENIdzdwZ08zVWgxK3JYZi9FK2pGRHpDWWFrRjdQQ01zVXlYaDl4bCti?=
 =?utf-8?B?VldETEgybEdkTUljMUU0eHRab2ZLdEt1aFBQZzZyMGY1R3I0dktmVXpsYWVi?=
 =?utf-8?B?c0J2YUR0aWI0dmFHOEF1MVJvSW9wWnlpVkZUSUJDVFlzVUFuSHliSnJCWGQy?=
 =?utf-8?B?d2xrUkxxc1FIby9PRkNsYnJaaWhmNXJjMDkrdHk1NG5BUWxkdlg2WE0wRXg4?=
 =?utf-8?B?bElFRGRXcW1Wcys0Vm5tYmw3UklyN3BWOXhESFRkNEY5Q0RieG5nVjgyNTlt?=
 =?utf-8?B?em5LczRJbWdJOCtiODhJZ05DNlJCZTZRUkJ1bmNiT0ROSUdvVjh6TDE5Q3RK?=
 =?utf-8?B?S3NISXNpUlFjVjBzYllxQ2V1TmtJNEN1cnZsVit3T01ycnBTMjB5MW80QURn?=
 =?utf-8?B?WXJZTUx4VE8xVXcwZHdKQlBVZmtBSURmZ29tci9veEhOclBGRWtGQmtkcU15?=
 =?utf-8?B?VVI2WTRVbThjMU5XcGJxOUkvcVZzMS9IU3NicFl6OEpsNTF2a1dhZ0Mzd1B5?=
 =?utf-8?B?YTNlaUYwZE1KN0wzVmdoRHhTTEZ1ZmVZK0VLbzRIT2F0TXRxM3pPcnBMTjhU?=
 =?utf-8?B?OUJTN2gwVGY0eFJPUFNYUXNZR1ZEUXpiV0IzZDJibVF6YXpjWE1TS2ViVjgx?=
 =?utf-8?B?ODZsdjJNTEpmR1BzL21kRXh0ankwT0xSN1hSZzkwdDM5SE5PMnZDTUgwWVBP?=
 =?utf-8?B?QkpXYjdpL0ZDVE9HQTY4RGlhVHRxVjRkdTlVQnQ5NXlidEcrbGJTVURmZ20r?=
 =?utf-8?B?OGk3aElYQW1DdS95a3ZQbmo1VFV2TzJWdFhqL2QvcTB5RHRWRFdjcFFFQzJ5?=
 =?utf-8?B?YTNkL3JtUUduTng3QVdvSGtDWkJGL1dEVzErOU5SdW5TTzJqV3pZT3J3VWNz?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE1CF312BE610741BFFA7ADBCB23AF77@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc158f2-318a-451d-0ab2-08dbb8e610e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 07:57:26.8118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwOUIKVcsUA2FGQSYfqUDd0GVgp3gqu9OKGwgW+ZCyVC19Jx2Rtc8LxpxuY1waI+Y6Z6cR2tB3ZV5JirJQC1vcVXGRA+nu8yjNvlM+gCmtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7656
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.098100-8.000000
X-TMASE-MatchedRID: dwNgap4H9hjUL3YCMmnG4kD6z8N1m1ALjLOy13Cgb4/TEy+FT1zrl4RB
        2ZnwTN8bUmsNbSHn8eC6zbhlzid4ERaIShUFI4YdHcQQBuf4ZFtQCOsAlaxN71eilmPI7oJlmAI
        yWr6xn59ZI0kOn/pCEdN2QZGIqLOvN0IbjpLRv2AP+h/WmwyDEcnlJe2gk8vIqPm/sjj9KBhdpM
        SiKlvaL+LzNWBegCW2PZex/kxUIHVmIVC+RmEW7Wrz/G/ZSbVq+gtHj7OwNO0CpgETeT0ynA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.098100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 85293322F3B0F22C6A6ABFE7C453781841646E40AE1B6C67D2BE050CDE460DF72000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA5LTE0IGF0IDEyOjE0ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMzAvMDgvMjMgMTQ6MjgsIENodW5mZW5nIFl1biBoYSBzY3JpdHRv
Og0KPiA+IEluIG9yZGVyIHRvIGVzdGltYXRlIHdoZW4gZnMvbHMgdHJhbnNhY3Rpb25zIGFwcGVh
ciBvbiBhIGRvd25zdHJlYW0NCj4gPiBidXMsDQo+ID4gdGhlIGhvc3QgbXVzdCBjYWxjdWxhdGUg
YSBiZXN0IGNhc2UgZnVsbC1zcGVlZCBidWRnZXQsIHVzZSBhIHRhYmxlDQo+ID4gdG8NCj4gPiB0
cmFjayBob3cgbWFueSBieXRlcyBvY2N1cmUgaW4gZWFjaCBtaWNyb2ZyYW1lLg0KPiA+IFRoaXMg
cGF0Y2ggaXMgcHJlcGFyZWQgZm9yIGludHJvZHVjaW5nIGFuIGltcHJvdmVkIGJhbmR3aWR0aA0K
PiA+IHNjaGVkdWxpbmcuDQo+ID4gDQo+IA0KPiBIZWxsbyBDaHVuZmVuZywNCj4gDQo+IGl0IHdv
dWxkIGJlIGhlbHBmdWwgaWYgeW91IGFkZCBhIGNvdmVyIGxldHRlciB3aXRoIHNvbWUgdGVzdCBy
ZXN1bHRzDQo+IGZvcg0KPiB0aGUgQlcgaW1wcm92ZW1lbnRzIHRoYXQgeW91J3JlIHNlZWluZyBo
ZXJlLg0KT2sNCj4gDQo+IFRoYW5rcywNCj4gQW5nZWxvDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAg
IGRyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGstc2NoLmMgfCAxMTMgKysrKysrKysrKysrKysrKysr
KysrKystLQ0KPiA+IC0tLS0tLS0NCj4gPiAgIGRyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuaCAg
ICAgfCAgIDQgKy0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgODUgaW5zZXJ0aW9ucygrKSwgMzIg
ZGVsZXRpb25zKC0pDQo+ID4gDQo+IA0KPiANCg==
