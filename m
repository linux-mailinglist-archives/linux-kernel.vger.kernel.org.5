Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3201A766766
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjG1Iil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbjG1IiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:38:07 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF01110;
        Fri, 28 Jul 2023 01:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690533463; x=1722069463;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=ZflSkQkaFWTIPuBD2ggkdZJLv9OyGt/m/e1BQ8KTeFPS5As2dAjgFqPD
   QDhj/oRRJDXfUfix7gtC4fuYo7TUEvPGA7SWFGYv45Y+4OQMjDqv/E82L
   kOCAHAIYAHVtOlMkIBpShX8o8CJ6TVr666OcxImunjqwloozEGnxO5QAy
   fsbFAzha+fYoM9XsY8gwY02u86sGiEInwHG19cByJKIYjWFV9qy5qfHOi
   W5q/KcdOceelxjCJ3wF6gs5QDIN+MRY9SatyClrQhBTTejd6oTn3U4FYl
   uwk8zybnz5d0PJuqUqaUPIPccKoPA0p/hOL5IGqSq5F5ods1zHwloqA9J
   g==;
X-IronPort-AV: E=Sophos;i="6.01,236,1684771200"; 
   d="scan'208";a="239178162"
Received: from mail-bn8nam04lp2049.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.49])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2023 16:37:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+RqycjH52UZiXQ6lRIEEBt6Z/wxIiZQ/KSkDhZw/K/w/Zd+jlOF9EJG+kFVlo2MqhwqRl2TMOFKctPoNRSH0WVO+u706wsp8j5jmVMgcar4xddwHOZiXCAJT5SDt7Tszl50SQMEHJSB4iQGaIHtMrPC/LaHmoCHGI1KNVWk/zM2x/56eBpyymAD3Ji2VyS+o91GWQcD9H8jaUs5t234+inLn7dlbgJQCk+ymc4omR5RT/nVzE5hqm5KlrV1USvt2kmw3OoKeUS+vQGK7x/yIy3uPuPMLbHUsEdBZLExd5BEzZmrqwI1nmYs1ik0e5+xg0h9ElxSWixlP7TrstoE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=G6hLj5/uMzH/6C14NuExs50Dt3jg75xR8os8qE57jSAk73IUdI3ZDOpmcvlsHzyYIGfSD9FSUdcxDUBpk32tX36FgvLL4ZaelTTlMJBlhTO3a95HrijPcxFB/3QpYmfhWVbKTZ4nJ6Ta7mcLrTad07x+yA2ngV8I9wzH+DmO5SS8NBVccq7QacgRBlZuooNWxqR0T5mv5bgDhapZI28xG83PEGD3m5GB2uoQIS1pQ17TiLWudlDy1qjMQB0KWf/nuEP4H04kqir8XKyHBM4WiT1de/fcZBPSKnUy/hAtq/0FOVzutZA7vy04SC6a479bGQ0pBbNdx1rQBCZLPqahiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=iv42yC0PuR1fS4YXL+qGD6BFjs2qXn7g3h6evLIgL19nnk4bEd/hl/LdH90D8MstTaI2m0nXE1sUH4XdExpHTPLT2wJ3/PTDtHECHWPj/FUHCLxsmhhWTqSIZ76/x2Y1M3k9NuCwALuoircOmNoW4U4BuCQ7K5mVnkE0Pl1EXRM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8556.namprd04.prod.outlook.com (2603:10b6:510:2b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 08:37:39 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::64cc:161:b43c:a656]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::64cc:161:b43c:a656%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 08:37:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Oleksandr Natalenko <oleksandr@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Saurav Kashyap <skashyap@marvell.com>,
        "GR-QLogic-Storage-Upstream@marvell.com" 
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jozef Bacik <jobacik@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Rob Evers <revers@redhat.com>
Subject: Re: [PATCH 0/3] scsi: qedf: sanitise uaccess
Thread-Topic: [PATCH 0/3] scsi: qedf: sanitise uaccess
Thread-Index: AQHZwSDpnSri0RHjb0yA3Z7wYQ/4La/O20UA
Date:   Fri, 28 Jul 2023 08:37:38 +0000
Message-ID: <57f0d130-8e44-d90c-f549-de381d5b8b2e@wdc.com>
References: <20230728065819.139694-1-oleksandr@redhat.com>
In-Reply-To: <20230728065819.139694-1-oleksandr@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8556:EE_
x-ms-office365-filtering-correlation-id: 9f261ee5-08ba-44c5-8adf-08db8f45e69c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k/VqQha6E5tBsw7WHoVclWM+tcB8PjJXiw3+vM2Pz/LR90RDZTTe32/iIgNBvFvGBlogRJPm/j/CLg32dplzhf2/sFPYyEPywkKjUXUwY2Y9cS5hnpGLLwdNswlJZX0VJw/7GGQ8PFS5wWTlOIJGqBOwfFrDU1XCjA+cni80eIJem7F/fPG284PjVnCp16g+ENft3uITWeFTj3OCk/5qIuphw/wuj3/sSLz30XK3qgHRmRI/aSpwBNavmgFO7AcStSkLeaEcXW6FoBWIj0RIvBLVRYBz4nEi0o12wm0sWUh1mrTaEgxsgyBAs7Lm5RG8bSy46rLnONvrvF3us8kuVWBOctr3O1q/qzidJC4JrJEtWQ0Fc5IH/LgZb228VFY4MwiOwmAjgoCC+EeERhl6iKeTDo6sFSTqSlE57xuosISDAarCNVpE9Grx0Q+a4P642Yuo/Pk7wM6tUMkeExvqPc1XaJw8Bq2E1lJBtt2ohM/gtCNrAlae8ZrJcW0lNLE/aEXB+Ey8YEfuo6LghIPPNIJfIff4F/ZJRpk91lc7/4mHMlN6d3Uu5ojFao47M03sM4a/pYCdQCW1d5nK6lLRUxhLmUEwZRaDT6meWE46mkLdYiCsFlagDBRdvlIZkj1KyfyAvQiugG1uxFKy78UfBxlBbskeYROpeQeY6SVo3OeRoS57KGq1fqDfPK7a+wsJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(316002)(8676002)(41300700001)(66476007)(8936002)(6506007)(66946007)(54906003)(110136005)(122000001)(82960400001)(4326008)(66446008)(64756008)(478600001)(76116006)(6512007)(66556008)(91956017)(71200400001)(6486002)(38100700002)(36756003)(2616005)(19618925003)(2906002)(38070700005)(558084003)(31686004)(86362001)(31696002)(4270600006)(186003)(7416002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0RMTEN3WEZBNTcxWnVDMmc3VkxNWGhhWFVSQmppNEh1OG96a1FCaEJMNGdj?=
 =?utf-8?B?RUZvcFozV2hQbnZRcWNUT1VrdS9tdEI4RUZpVi8vREJaQjdVczdSTDduQ21n?=
 =?utf-8?B?ZHRtbEhzcEhtUE9vSnUrQ2lVOFpjaWhFWG5nYmZlUHhldVY1djJ6TFdocWl1?=
 =?utf-8?B?cnRZS2dVUlRLWWUvUEk1elRTUE02T29ndVMwMHlVako5TjZhdnlXeUV1dXZG?=
 =?utf-8?B?NGtGdXFuejVIaWMvb2h6KzJIYkRvNXM2Smt2K3BtSnhnNHBTUExzVW15THBu?=
 =?utf-8?B?ZjUwMXNJdCtwam1hN3pjSmVJTmRxTEFJOUgxR25ON2xjZm9OTkRmdGZmalRC?=
 =?utf-8?B?b0Y3cWFhSkZWTHkyejU0bC91UTMyM0xvM0FZUGFkclJybXJCL1EzMnVsUXBJ?=
 =?utf-8?B?djQ3dUVXSW9aVUZ4aGVOZ0FRRWM3V3BSVkJxYW5MZjNjU2tudFlyR2NzMWVI?=
 =?utf-8?B?bVI5bWtIYXVUUmlUQnJja1l6Z0pBN0Via0pDS0hFL3A1ek5jL2ZkeVBZL0do?=
 =?utf-8?B?TEl6MG5IZkdpUmQzRnU3d2Z4TnFsVFBSZlhUcVpIKzdMaFJuV0pBVmdtc1hI?=
 =?utf-8?B?MGRwTjVHVmZKdXNGdXVOMGtvZHA4SlVLanl3S2k1RFlOWi9mTUNRaFRJRkFM?=
 =?utf-8?B?RnFEUVBXYkdZWEJ6Sm51a2NiVzZqc1dtdUtpMGltc1NxT0Yza3FCN2wxSEVC?=
 =?utf-8?B?S3FvVzh6TlBDRGp3d29HblJsMEU0bFE1WU13N0VsMnNGUDd5L1lXc0dwaXQ5?=
 =?utf-8?B?cDFtNTJMSFZJMGltYncyZlMwWnRLbTlFL2F6UmJneTh0eE5lRmFZNjV3QzBw?=
 =?utf-8?B?QlRlR3VETWh0RGlzWG5YQmYxa2xpaEthZGJXYlFES3pUYW00MUExT1VRY3Y3?=
 =?utf-8?B?anJtVUg0ekFFUlJXQzRmM0R1MzhMSWVOanE4d0NFV3FKcEhPYzI4Q2Q5MElu?=
 =?utf-8?B?TVROUVFUUXRhdkYzQnQ2YWc5RHdvQ3Q1Z1IxRjM5ZGF1bFh6QjJRejRxcXpK?=
 =?utf-8?B?N29iYm1VN1Z5Y05vYnN5a1ljRmFGeFFtSDF3TktSMTRWdkNBWEN1VkJ3Q3Ux?=
 =?utf-8?B?dTltRXkvOTBpNVkvc2NrcnhTeE9FRmlTdzZyK0dxT1pJZ2Q5WU03dzU5Y0NX?=
 =?utf-8?B?NEhSd3JGRnRZNStvVEdMNE5xMm95WGFwaWZXamJhcHU4K2pRWlBvNm9aeEEr?=
 =?utf-8?B?VVc1ekJUMGkzNjJBTitEYjFkdUVONE5YdDF0UGsxcU5mVnJFVkc3Tm0rOXRJ?=
 =?utf-8?B?WHF6NnVrakkvdjQvcUJoYU8wbC96K1FtNWFuTkJzVmlaazlSdGlGSTVxS25V?=
 =?utf-8?B?WWZOV0UwcFZxenlSRFUvT0FSdU1jakswMG16ckJMcDRsSkpFY24wMStEUE10?=
 =?utf-8?B?ZmU4bm1OSUd5WVlGQkRqV2M0dGE1VEtSTDRzSWxpMEZEcVZpT1ZPY2xEUXpW?=
 =?utf-8?B?bkFKd0krVGQ2WWhxQVhkYi9MQWJHdjkxNm1yb0ZnZ29hTHVQVWVzaHlkNVdQ?=
 =?utf-8?B?ekdLKzlMK2VSYWZSaEkwMHFrQ3AwV3Y5RkRlTS9UU0RNNHphNVNlTWUyU3dX?=
 =?utf-8?B?cWJnSXdUWTU5YlQwWlJ5K3dCYk4yYnNyWDJxaldsc01iMVhtUU1QekNrS3Jh?=
 =?utf-8?B?cDNnTjM3WU5xSHd4cGphMDZ0NFBxN0s2WUI2RTZIZ0VjbzNiOGRhQ1VRbDlG?=
 =?utf-8?B?eXJZQ1hhcFZ6cTdZQStYaXlHYXE0MlV6NGppZXE5ckhZdDk1VjFUdm9qYXF2?=
 =?utf-8?B?MXV3YXNDdCtwN25YU2MrQ25MSUpka3ZRaFF1cmx6NFRxVElLMTJWZm85cW1k?=
 =?utf-8?B?eVhrR3NJcjkwSG1xNHdFbU9OZWFwTllZY0c4Uzkydk1FbWh5N1BhTTlabHpS?=
 =?utf-8?B?K0dma0R1ckEyUXp1dndFeVdzeEpoTFpQY1V6bmRlTTNpaXJwQ3lGZE1rYTU3?=
 =?utf-8?B?L2FWMG5mWFpHU1Y2MkNPdDJYQkJpOWZXMGR6V1VLbDY0ckMzY3lUOVdobERi?=
 =?utf-8?B?Q3BxZkJubE1YakxDQlEvWWxkSEVOQmFxS05Fb0wzY2dmSTFnS2pUc2xibnZX?=
 =?utf-8?B?NUxmVVZYc0RSZCtJRkM3eWJCcm9kM0tBNHMrWVBaVnNtZCsrMUVwU3cxaTRS?=
 =?utf-8?B?Y1BUb1Zob1FVYnR0aWYzdW1NNnRsNXMrcnNZZ0hVZkhNVkhVYkEzbmxvQThQ?=
 =?utf-8?B?TDN4WFVEbVZFSXdvQVphaUY1MEY5aGJOQ25nWHVnTFBJMll6TjMrSEc4MVFH?=
 =?utf-8?B?SWU3a1R1SDlOZ2hQNWxYTTBYcU53PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB6E7AF408AC6B4F9BF9E72E78615840@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KsJWfrm9Vxw8nG42tI63yxCs+Rsh2pzjKl/e69sdF/Y1+lZt9pQakkgxjBPfcDDKxLCQviDAinKuiBJ73DRF4WWgQUctdwicSzKkWjAwVOPVaRC+B96kBhOTmr0lllgSjHZmWL5iu8Up0AwmpB2I/5/ft2gLXb95G654HvcfkUxeVtfi/oEXljTtSgtPNlqh4hU+CbPjEnA3tlmQ2HISInYBF3h5+vNLIuPsAur0YgLbjnMNmCsYKeZTnK48NSn4HCNMMfNb5AjgTuxMNZGGlrHBdSIfqz8MVp3Z1lFOCWSk29brdzb4kw9R7i2BdKVrmz11Rr4q56whKW1evuIWUKl0k8vkmn+exkK8jHgS1wGqSLTNeAdako92MQIebp+9o77zbH83GEfEoqLLIx0XT+VxzubWzYNpDDDRT+T2cJ4krO6HbrnetG5aA15GZD0gSxxMHjcXEbJvvX+AuknpehAbPqv0WOTpXGfEdqIzYqZ+WhQyBsvd4PTpKsgpFWSDyX+3s3S4jtllhx1wjOsmzONZAa2PYSjTaKE+W/njEw08FklnWmxDebgfeAk5g84WobgaJXL9uLutG99htE7mayNYbJP8ho36HvlAIF/E7ixwqZ7jAVbzAZHTDzWp8c1P3Afe/rpOTULy2EsPgrsSLw+dtTueOhu1AXjSBm4/HpyqOdvO25aKi36WwdRzSSvqXyYo6Hlq/HSKHbvCGNyE5xO5mvSIechdc7nLMtyEwemIRfh1JFvN2zzExIPpyx65kD9JIXZxH+i+W9EOOQZzVRdzBflG7ltu4JHhC+ALMD2IIhEdjIYyjGnFMxI1f4uC5/1VXdKTmZpfp2FdIyzAgb1n7C8cVtsM8lifAzz1fkz8OI+YsZfHNQfXh6Ii/G4zDjJ3jFN3GMmRA1HfssVcCveKVCnOLvUQgQkjRuDwGb8=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f261ee5-08ba-44c5-8adf-08db8f45e69c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 08:37:38.7543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V4N97yE7q+IREhVP17jzeiVd5F01kKk8NBEH8VyL0KiZgU0VQX5sG68f9kdPnhi2+m24VyNOw/xTMzyaV4HL4DjK4UOFNcICDwmTsPUhQxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8556
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
