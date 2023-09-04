Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F255F79169A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352862AbjIDL5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236349AbjIDL5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:57:50 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81EE195;
        Mon,  4 Sep 2023 04:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693828666; x=1725364666;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sKU4QKkY9ueV1gLEnoIKrgEHeVAMgMgvEcOAf7V4aWU=;
  b=jxLKFc1OOi+tv6FemIgh1zGLUzwUNmFlOItKzXFSx/uotGKGFenQghtC
   LDlz6vdKEZd/5FZx8gpakUffO4opfrR6S4n8GzXCHznqUYATDnzKasYGp
   uFDf/nHuB0oym4dGNTmdyJf34xAWoHRnN+/TztJ1dz8CWS6NBG+XvVSJZ
   wCOxOMPEGbq5z6VmeCxJc8dY6NWwEbWGzGJNssUxZxkXU4R6x8DRIy+7r
   5LLnocGJWwa13mUJ6yPnSJagpPm/0Flu9DdJgUOXS7tR5+qR51dj0RuyY
   mZ+LyM+KKol1Z6ME00rf6DMmpQxyt4meH1l3yfjO7Z6ZB2NcJjeIcF/B8
   A==;
X-IronPort-AV: E=Sophos;i="6.02,226,1688400000"; 
   d="scan'208";a="354976572"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2023 19:57:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmBKKKf7Wufv7jACk3YP4jR6+rfhqO6ruQ+QWlpJCXJZQ+lUs2gysKDFYkeQGQB5rwnwyaQ9zet/gJu1RoqT1kTQMK276x3Qa53HaeJs17KXKfS2yCHs/ZUe4RliyGg/+cgjYveHkSMZ9EUtE9IGfWI8obfUxxNZjaoqtH33yh8yauL4LZ4T0A6YO115dgVnY4pIlGndlboZHUUn4AOTxV8trI0HlYwpm1e45Lh5uEV5nrhrK89asuTL8ara9xuyfZYlcasbpq8IpTnsehnyzY4V6PPN+ZGGAWCBCKVtCBZbXK/5bsSZWQjmw7AWXT//EW1SuuXTQzM0MKGyjY1dOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKU4QKkY9ueV1gLEnoIKrgEHeVAMgMgvEcOAf7V4aWU=;
 b=BeNiWkFn3CE/kh6Vwz1KgQcLzq4BWVf1j9L/s8+xIORQAkgwT0JSkdzVWgabn4LeBL8LJvf8Ur+n893omoOfYC2NiLI9daJ2rphyMDq+hzOusPdCy51BI4U9e1wq3kQrl/LgghtCz63EjGL4lsdjItAJEZNH+wts/8QpMpYjkaKLPEv/wxDKklospQeYcur75PNosHb7wHYHn/a/mOrjnfXo36AzbEK5Ig0Rx3L5Wj9kH63DZdWGIPYkbHznWh5yZ7ad7AFV8kRj/J6ZkUrwGMSd87LDgPqoBa4ILwaxwVa9Y+uol5cC4bqUu6x4mTSleuJA5rycN6HaFYl3on7I2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKU4QKkY9ueV1gLEnoIKrgEHeVAMgMgvEcOAf7V4aWU=;
 b=N23NIMcJ4KyKcUXm9bdFHJM3aoFdnw1FUxe+pLsPR/WKDeqaxxSg0HP+N0O2+cu1sQL87U7x2StXKmJhkQ+TVSF3OOd7xtDk2iTUKTeemTLngrv8Tbsn2Jqh6XDLeTMqYVt9Ks1iKM/CJnp7uBrx7N5yBzX0OsKOue8x7M7xq3A=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CH2PR04MB7046.namprd04.prod.outlook.com (2603:10b6:610:96::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.25; Mon, 4 Sep
 2023 11:57:41 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6768.024; Mon, 4 Sep 2023
 11:57:41 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Li Nan <linan666@huaweicloud.com>
CC:     "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: [PATCH] scsi: ata: Fix a race condition between scsi error
 handler and ahci interrupt
Thread-Topic: [PATCH] scsi: ata: Fix a race condition between scsi error
 handler and ahci interrupt
Thread-Index: AQHZ1DaPr2epsK7l90GFuVSrpD3hoq/2C2CAgAATd4CAFINwgIAAA0yA
Date:   Mon, 4 Sep 2023 11:57:41 +0000
Message-ID: <ZPXGM0YUPP4+n0Rz@x1-carbon>
References: <20230810014848.2148316-1-linan666@huaweicloud.com>
 <ZONr0f26IT/QKsSu@x1-carbon>
 <f33816ef-ce26-1501-99b6-c75f91c6d8f5@huaweicloud.com>
 <ZOSONbLwc6RtQnS0@x1-carbon>
 <5d37add3-41ce-e2af-b45a-d701eaf36a6c@huaweicloud.com>
In-Reply-To: <5d37add3-41ce-e2af-b45a-d701eaf36a6c@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CH2PR04MB7046:EE_
x-ms-office365-filtering-correlation-id: eac8ac1f-0923-4884-bead-08dbad3e2447
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SzABqpfE1g7QG5jdmvi4NMsHyNE0cbUiOi3mX8KibKk1Ybdoa7tNK5a/iPpkmQilAdA5QylGP6HZyn0yrI3j8SBPoDHC68EUNBcYUFr/J5B/MAy8JlD/nP/s/Q1FQ+UEY/dGgytT4jWqp31uq515Ap4aJzgEfgtqhc+0lpuIYbUfNIzKDK93qQwHMq2ZF0/85PsyBQ7OJa2v4fLQF8KMJOZtpDiJ0tBs811rGznyDFvtiP9EJqE/xVjdXjRebOWhWbjsArSttNk5/LRP9tqk4ps8JdEmly1f6HmkXnWJppUfW7u4yWbSEbIkksXpsqiiate6p085IHHQlaeZATMmhswP1ESrjjqKKPp7AvdGu2u9+8BsVgmJlQfTTT5oZRDQooOv9Kws2neqQE9Q3Xu6uqm+YmpSpAAVKOIjW9mr/3HWbhgXpzxMRskctnAjf2XCI/JfsWcNy+Jon9tROJs3uCYxOYssttRDhfOCLpJdEXAJcsrzsd09yIzLoANUobs2L1u7RI5A2QStGI4QeLn/SNZTtgmwz4yrCknoP0M4RJU9xDbOi3Iy4rmpZ2nD+GwZis1wUfuVS3Y8oqd9+8EbsTGfnMzPswRvvlQ7sWWCCo7hNuL49HBhfT0qzBsI7eTH+gqCuYCFB+pYRU1g9BzOHSyL0WgXr8rw1lLrz/gpnLU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(39860400002)(396003)(136003)(1800799009)(451199024)(186009)(82960400001)(966005)(122000001)(9686003)(6512007)(8936002)(478600001)(38070700005)(91956017)(76116006)(66946007)(64756008)(316002)(6916009)(66556008)(66476007)(41300700001)(54906003)(38100700002)(8676002)(4326008)(66446008)(33716001)(71200400001)(86362001)(6506007)(6486002)(26005)(5660300002)(2906002)(83380400001)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWtwYnMyTW1FNTN0VG9FbTJmMng4RjNHRHcwOUpRcVc5QmtHUnpVNGl1NU5v?=
 =?utf-8?B?UDk1WEFrYlRiRDRxU3dNMjNmRWlxRkI3d2hxc295S2FPZDZFWVUxbk1wUjlB?=
 =?utf-8?B?djlZR3NPcjdhRitZV2lvOVZiMTZoN0ZsTXQxUHpqdk54NzcvWkoyQXM2Y1ZU?=
 =?utf-8?B?NDE3dzFhWTVpRm9FRElYY0x3RHp5Z0NVVzZXWW5FM1REYmtVczM3Rk42NUM5?=
 =?utf-8?B?SjFpcStJN0dpT04zbmE0L2NrVk4ycWxaNDZXSDdvQlp3Q2hwV3JNZEtBYWxN?=
 =?utf-8?B?ZDBBalhYL2FzZ3F2bWNpUmEwZVJERHdSOVQvTmFZWGtFalJ6bHlENHVRTVkr?=
 =?utf-8?B?TDhIVEFWamoraGhZKzhXblJpcXBYRnhBSTlFdmt1cWszMEVQY3ZjY09tOC9J?=
 =?utf-8?B?dWh0QTFXWkhPeWFSaFRYb2FzZ1FQb1c1WXlyS0lmMjFDc3R3U2U2VXhuWnRk?=
 =?utf-8?B?QTZJcThXT2pvODlQUVJEREpDUnl2UzJhOUUrVGtENHVuVEdHQ1Q5VUhqcVRV?=
 =?utf-8?B?b3JVa0dldXBSNHdyYjlVZDg1enZKa3VpVGtOQVJ0N0s5b2V3T2VCUytrRno0?=
 =?utf-8?B?SlB2ajRzYm5sb3BZdkhZMWJyalJwUnF1WEljNmhHRXZyZG1LbzZ6bytHWVhM?=
 =?utf-8?B?TU9pWnpSemk5ZE5jZnNUeWdmRUZQaG01MGpueEtSK3lNNlVGL2pkL3U0L3Z5?=
 =?utf-8?B?ZW5YSGs1djI5UVg5bzd5WEloeUd6VkhNSTBpdjVZZ0lJUWw3OStYVlBIckhx?=
 =?utf-8?B?WlRRVkhrVXVoWFJ5akFaWkJiSjFUYUhlWklQN2tOemVZZVhZTnBaTDNWVUxM?=
 =?utf-8?B?Wi9JTng1ZWlGNnBmQkdNNXpZUk5NZnRXWngvZWtpTThOaXJqYUhNVkFxT3ZX?=
 =?utf-8?B?ay9UdWV0dXFxMXpOblJlSVQ1aHMzT2xxcTBDaks1Tld0RkVoZ0ZvbFgyTVhV?=
 =?utf-8?B?MnRoYVR2NWxCQlVxNlFGNlY5MUZRbFdRc2hzVDJUd3FBTG5VR3lISUtJL3I4?=
 =?utf-8?B?aGJza09iSU9wWjlYVmdSbnlFc1lDd09SRkVJQkFHTm05VXZKSzU4cFZqMUdh?=
 =?utf-8?B?bjBXSnFWU0dUZXFIU1ZUdGJiS0dBd1U3b3dlOUs0ZEhqcUdxdFFjUUJ6UVRB?=
 =?utf-8?B?NUt6dEdOV01ybEVHdWVuSU1wRmNmTTFWM01KdEQ0cmZrOStUdS8rSFVaODJN?=
 =?utf-8?B?K1QwWVFnb0NicG1yZGQ4TlJrWXdkRnV3TXd5TjB5cElEZi9zbEZCMU1FeWZs?=
 =?utf-8?B?SVArL2o3YUN6ZjA4TlJiZkxSSmJqcWNzZ3U0cGg4YlJiVkZFdUI2SnRqakZD?=
 =?utf-8?B?RFFGMmwySFdma1ZWWVh3Qk9vVzVsZnlOLzhYYkVLbjEwaDZoWjd1Wm9taUlB?=
 =?utf-8?B?elJPZS9aOHVxbVNzV1puN3FKbk4rVTlzbXRKMHR5dzBlNVdsemI5ZXBET1Mz?=
 =?utf-8?B?d2gzcTYyUWV6Z1QvK1VWaUN2TTJBcjhib2lTUlNFbmxtdUs1NlNpejNJbGlK?=
 =?utf-8?B?Q1pVOTRzYzBmUkJpL3dNYzBUS2ZVNkp5MERTdjR2Ykx3QWdKYlE5ZkZjVVFl?=
 =?utf-8?B?K0pmcmxWVEZQbm5uMHZ1Q0c3S295c0FPV3ZXZGhKN1lDVHFxcG5Hbksyd1dw?=
 =?utf-8?B?WnNubVBsZ0g2U0RxcmlGUm43bXo0QUJlc0ZwZFVFWlIwSE9zdjhwQUNidVBy?=
 =?utf-8?B?VDdkM0dyUHJERzZ2dWtTYjJCVUpqRjV1aEU4OHVoZWhHOEhuL2pqbUg1clhL?=
 =?utf-8?B?WmJKNkZ1bWwzODdyK1FSK2tHTWJVU2s1dEh0aWdGMWZzMG84elRxam1ubVRt?=
 =?utf-8?B?UEN5QVF2R2FNWWRjRjNjYWlKUHNPbkdERUVFUnN0LzdoRzlPL1ZVUitHQUJV?=
 =?utf-8?B?cVdKMjhxbU1pa3ZFcHRQMnpYK29heEJnSEFqVWV3THpsVW4zNFpYazlOK2RB?=
 =?utf-8?B?YXRwM0pNUmcrQ2RSd1g1YzJSSWRPditPK1B5L0k3bEg0NEI0ZHM1cjE4amJV?=
 =?utf-8?B?d0NKTDd2Tk1QeExqZFlEdlc3QjEwUnE4bmxBbnoyR2tpOGdneDlLNDZzSXRY?=
 =?utf-8?B?MVNRZ1ZaMURZUUc5WGlHMm9pZGhhM3dPSVE0THAwSm01MGVmY2tMOWM2U0VR?=
 =?utf-8?B?eUE2SE5XZnJ3MWZ2d2lyTlpwelpRTUpGUXRFSllpUDFRdFVBMWhKdFhDQVQ1?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67B1B6AA01BEC34A8DAF97695A1183D2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qfwqTWIv+xf0xxwmX5iNbO6k73mbnBhAgUYUP9SNQkCltD9a4eqyn1CnwgwltC8KraItpuLD1Q2HG+wF1GiNaBBrcZFbbpJbu2jeRlo6EG02lXIhc6IFEMYJofJAEankNq6aKaptEkXXco0Lp0m/x8qfy0yIhSz8XXFUPbAHHm9ZN4yMHJ/kZjeu/yhlZ7elrlbYmXnGFJSXerHDp8aml7/kEjIK/gQfLQJ4ztnyoZD80r/2QBIQ6DLaeb6KnPdfPvK7WeaExKpLvts4NJcKW4KTv+zCZFmRJcmvOlkRhB0Ox16wAMm3Fjb5CZzBkbErcttzZh0zSnXszo+fOGZSm3t03T7OP1wu8snD6mPPNuiM/MWFaJ2383eK7HlqJWDUxHL+ntAZNt1fUDTPnt2IkDPCRStakjZ1l5EtMd8Rvy7nXpk6MYCIfh6u0zFMLyBFWc3BqnLSuFSMjW1SsYFt0OMzbqjiedv8A9gjpC4z5tD6syNLtexalVQdmcjAI4sDjIZvZLJQa8IzjTitzrS5q7bx8uKSHZ3GyY3wL6WvgImG0ShxvyvHn/3IYTXfAmVM9f/q5mOYtHvGrKoBExNjgTc/3UA0+1A4blRNdh8DtuLrOfdeF8YDCcuUGcVYz/eHNqVpoAS1fTNlmrHIifXIUa+sj8Z7AOVtgAbHhr2V+HjevZ7tr5Pye9Lxungr0R0COEGy7ix28TJkhfUVICZJbq4QpxSHfWBDdwaGzDzDPO0sB6W/D4skTpOlqtmguh7VdZI2cpXhdVZt6Vyycx8W+M1ZzKcYaZv0zxxPukHd1jtOb/QV50DpUp8jb1w/0FN8ro0O5LsfLOPrY0nJl9q3/3eXkcPob/ACRZIOvlLeXV8XhR/p/Ac2Ziply8bPra7a
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac8ac1f-0923-4884-bead-08dbad3e2447
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 11:57:41.0893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sEtxlIEl/oooy0iG+7Tpnm1qvznTCJnCfljNxESakw0ZLhQNM5pDoBvqd4Z2okuew9XmqEyR/7yPPOP8OgQdkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBTZXAgMDQsIDIwMjMgYXQgMDc6NDU6NTFQTSArMDgwMCwgTGkgTmFuIHdyb3RlOg0K
PiANCj4gDQo+IOWcqCAyMDIzLzgvMjIgMTg6MzAsIE5pa2xhcyBDYXNzZWwg5YaZ6YGTOg0KPiA+
IE9uIFR1ZSwgQXVnIDIyLCAyMDIzIGF0IDA1OjIwOjMzUE0gKzA4MDAsIExpIE5hbiB3cm90ZToN
Cj4gPiA+IFRoYW5rcyBmb3IgeW91ciByZXBseSwgTmlrbGFzLg0KPiA+ID4gDQo+ID4gPiDlnKgg
MjAyMy84LzIxIDIxOjUxLCBOaWtsYXMgQ2Fzc2VsIOWGmemBkzoNCj4gPiA+ID4gT24gVGh1LCBB
dWcgMTAsIDIwMjMgYXQgMDk6NDg6NDhBTSArMDgwMCwgbGluYW42NjZAaHVhd2VpY2xvdWQuY29t
IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBbc25pcF0NCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4g
SGVsbG8gTGkgTmFuLA0KPiA+ID4gPiANCj4gPiA+ID4gSSBkbyBub3QgdW5kZXJzdGFuZCB3aHkg
dGhlIGNvZGUgaW46DQo+ID4gPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9i
bG9iL3Y2LjUtcmM3L2RyaXZlcnMvYXRhL2xpYmF0YS1laC5jI0w3MjItTDczMQ0KPiA+ID4gPiAN
Cj4gPiA+ID4gZG9lcyBub3Qga2ljayBpbiwgYW5kIHJlcGVhdHMgRUguDQo+ID4gPiA+IA0KPiA+
ID4gPiANCj4gPiA+ID4gRUhfUEVORElORyBpcyBjbGVhcmVkIGJlZm9yZSAtPmVycm9yX2hhbmRs
ZXIoKSBpcyBjYWxsZWQ6DQo+ID4gPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51
eC9ibG9iL3Y2LjUtcmM3L2RyaXZlcnMvYXRhL2xpYmF0YS1laC5jI0w2OTcNCj4gPiA+ID4gDQo+
ID4gPiA+IFNvIGFoY2lfZXJyb3JfaW50cigpIGZyb20gdGhlIHNlY29uZCBlcnJvciBpbnRlcnJ1
cHQsIHdoaWNoIGlzIGNhbGxlZCBhZnRlcg0KPiA+ID4gPiB0aGF3aW5nIHRoZSBwb3J0LCBzaG91
bGQgaGF2ZSBjYWxsZWQgYXRhX3N0ZF9zY2hlZF9laCgpLCB3aGljaCBjYWxscw0KPiA+ID4gPiBh
dGFfZWhfc2V0X3BlbmRpbmcoKSwgd2hpY2ggc2hvdWxkIGhhdmUgc2V0IEVIX1BFTkRJTkc6DQo+
ID4gPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL3Y2LjUtcmM3L2Ry
aXZlcnMvYXRhL2xpYmF0YS1laC5jI0w4ODQNCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiAN
Cj4gPiA+ID4gTXkgb25seSBndWVzcyBpcyB0aGF0IGFmdGVyIHRoYXdpbmcgdGhlIHBvcnQ6DQo+
ID4gPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL3Y2LjUtcmM3L2Ry
aXZlcnMvYXRhL2xpYmF0YS1laC5jI0wyODA3DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgc2Vjb25k
IGVycm9yIGlycSBjb21lcywgYW5kIHNldHMgRUhfUEVORElORywNCj4gPiA+ID4gYnV0IHRoZW4g
dGhpcyBzaWxseSBjb2RlIG1pZ2h0IGNsZWFyIGl0Og0KPiA+ID4gPiBodHRwczovL2dpdGh1Yi5j
b20vdG9ydmFsZHMvbGludXgvYmxvYi92Ni41LXJjNy9kcml2ZXJzL2F0YS9saWJhdGEtZWguYyNM
MjgyNS1MMjgzNw0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gWWVhaCwgSSB0aGluayBzby4NCj4g
PiA+IA0KPiA+ID4gPiBJIHRoaW5rIHRoZSBiZXN0IHdheSB3b3VsZCBiZSBpZiB3ZSBjb3VsZCBp
bXByb3ZlIHRoaXMgInNwdXJpb3VzIGVycm9yDQo+ID4gPiA+IGNvbmRpdGlvbiBjaGVjayIuLi4g
YmVjYXVzZSBpZiB0aGlzIGlzIGluZGVlZCB0aGUgY29kZSB0aGF0IGNsZWFycyBFSF9QRU5ESU5H
DQo+ID4gPiA+IGZvciB5b3UsIHRoZW4gdGhpcyBjb2RlIGJhc2ljYWxseSBtYWtlcyB0aGUgImdv
dG8gcmVwZWF0IiBjb2RlIGluDQo+ID4gPiA+IGF0YV9zY3NpX3BvcnRfZXJyb3JfaGFuZGxlcigp
IHVzZWxlc3MuLi4NCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBBbiBhbHRlcm5hdGl2ZSB0
byBpbXByb3ZpbmcgdGhlICJzcHVyaW91cyBlcnJvciBjb25kaXRpb24gY2hlY2siIG1pZ2h0IGJl
IGZvcg0KPiA+ID4gPiB5b3UgdG8gdHJ5IHNvbWV0aGluZyBsaWtlOg0KPiA+ID4gPiANCj4gPiA+
IA0KPiA+ID4gV2UgaGF2ZSB1c2VkIHRoaXMgc29sdXRpb24gYmVmb3JlLCBidXQgaXQgd2lsbCBj
YXNlIFdBUk5fT04gaW4NCj4gPiA+IGF0YV9laF9maW5pc2goKSBhcyBiZWxvdzoNCj4gPiA+IA0K
PiA+ID4gICAgV0FSTklORzogQ1BVOiAxIFBJRDogMTE4IGF0IC4uL2RyaXZlcnMvYXRhL2xpYmF0
YS1laC5jOjQwMTYNCj4gPiA+IGF0YV9laF9maW5pc2grMHgxNWEvMHgxNzANCj4gPiANCj4gPiBP
ay4NCj4gPiANCj4gPiBIb3cgYWJvdXQgaWYgeW91IHNpbXBseSBtb3ZlIHRoZSBXQVJOX09OIHRv
IGF0YV9zY3NpX3BvcnRfZXJyb3JfaGFuZGxlcigpDQo+ID4gYXMgd2VsbDoNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9hdGEvbGliYXRhLWVoLmMgYi9kcml2ZXJzL2F0YS9saWJhdGEt
ZWguYw0KPiA+IGluZGV4IDM1ZTAzNjc5YjBiZi4uNWJlMmZjNjUxMTMxIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvYXRhL2xpYmF0YS1laC5jDQo+ID4gKysrIGIvZHJpdmVycy9hdGEvbGliYXRh
LWVoLmMNCj4gPiBAQCAtNzQxLDYgKzc0MSwxMiBAQCB2b2lkIGF0YV9zY3NpX3BvcnRfZXJyb3Jf
aGFuZGxlcihzdHJ1Y3QgU2NzaV9Ib3N0ICpob3N0LCBzdHJ1Y3QgYXRhX3BvcnQgKmFwKQ0KPiA+
ICAgICAgICAgICAgICAgICAgICovDQo+ID4gICAgICAgICAgICAgICAgICBhcC0+b3BzLT5lbmRf
ZWgoYXApOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAoIWFwLT5zY3NpX2hvc3QtPmhvc3RfZWhf
c2NoZWR1bGVkKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgLyogbWFrZSBzdXJlIG5y
X2FjdGl2ZV9saW5rcyBpcyB6ZXJvIGFmdGVyIEVIICovDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgV0FSTl9PTihhcC0+bnJfYWN0aXZlX2xpbmtzKTsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBhcC0+bnJfYWN0aXZlX2xpbmtzID0gMDsNCj4gPiArICAgICAgICAgICAgICAgfQ0K
PiA+ICsNCj4gPiAgICAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoYXAtPmxv
Y2ssIGZsYWdzKTsNCj4gPiAgICAgICAgICAgICAgICAgIGF0YV9laF9yZWxlYXNlKGFwKTsNCj4g
PiAgICAgICAgICB9IGVsc2Ugew0KPiA+IEBAIC05NjIsNyArOTY4LDcgQEAgdm9pZCBhdGFfc3Rk
X2VuZF9laChzdHJ1Y3QgYXRhX3BvcnQgKmFwKQ0KPiA+ICAgew0KPiA+ICAgICAgICAgIHN0cnVj
dCBTY3NpX0hvc3QgKmhvc3QgPSBhcC0+c2NzaV9ob3N0Ow0KPiA+IC0gICAgICAgaG9zdC0+aG9z
dF9laF9zY2hlZHVsZWQgPSAwOw0KPiA+ICsgICAgICAgaG9zdC0+aG9zdF9laF9zY2hlZHVsZWQt
LTsNCj4gPiAgIH0NCj4gPiAgIEVYUE9SVF9TWU1CT0woYXRhX3N0ZF9lbmRfZWgpOw0KPiA+IEBA
IC0zOTQ4LDEwICszOTU0LDYgQEAgdm9pZCBhdGFfZWhfZmluaXNoKHN0cnVjdCBhdGFfcG9ydCAq
YXApDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgICAgICAgICAg
IH0NCj4gPiAgICAgICAgICB9DQo+ID4gLQ0KPiA+IC0gICAgICAgLyogbWFrZSBzdXJlIG5yX2Fj
dGl2ZV9saW5rcyBpcyB6ZXJvIGFmdGVyIEVIICovDQo+ID4gLSAgICAgICBXQVJOX09OKGFwLT5u
cl9hY3RpdmVfbGlua3MpOw0KPiA+IC0gICAgICAgYXAtPm5yX2FjdGl2ZV9saW5rcyA9IDA7DQo+
ID4gICB9DQo+ID4gICAvKioNCj4gPiANCj4gPiANCj4gPiANCj4gPiBLaW5kIHJlZ2FyZHMsDQo+
ID4gTmlrbGFzDQo+IA0KPiBXZSBoYXZlIHRlc3RlZCB0aGlzIHBhdGNoIGFuZCBpdCBjYW4gZml4
IHRoZSBidWcuIFRoYW5rIHlvdSBzbyBtdWNoLiA6KQ0KDQpBd2Vzb21lISA6KQ0KDQpQbGVhc2Ug
c2VuZCBvdXQgYSByZWFsIHBhdGNoLCBzbyB0aGF0IGl0IGlzIGVhc2llciBmb3IgdGhlIG1haW50
YWluZXIgdG8NCmFwcGx5Lg0KDQpObyBuZWVkIHRvIGdpdmUgYW55IGNyZWRpdCB0byBtZS4NCg0K
DQpLaW5kIHJlZ2FyZHMsDQpOaWtsYXM=
