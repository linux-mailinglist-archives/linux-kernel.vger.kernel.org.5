Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51225767F20
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 14:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjG2M2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 08:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjG2M2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 08:28:34 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6402D7D;
        Sat, 29 Jul 2023 05:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690633712; x=1722169712;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8HphHL75LPyEdqSy1/eN9x4UvV/FMDjjsZ9+lbFOCBM=;
  b=kRTDb9xXDlh3ktbf0c0poqFOXBUzQdDRqPHBqFPdQf1dbKwqM3V8E323
   IFvPDZ4ofuS03HglIt6qYR5dmseGajpjfrTD7/8KZpr/uVv1ZCRPFBbt5
   msz24VX18BSNyoty4NEnAYUfsPU07lO2U2ofSI65VUXSgKB4oOd8yvLzm
   zTlNoqaMkavSuuisg4rOl7vcbzu837qm6QUo5ZRD5q7fdlipVN4r0VdT3
   Vk4fGTcHo6KRY7oYiua8VR205WHVfZqJwjaHMPrxvN514hkI35hTWHHqI
   uP9A78h20aTPIYert0niCUcb+xnrE4RyUq1aiNKUm6D9shy21hISxiNeN
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,240,1684771200"; 
   d="scan'208";a="239847527"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2023 20:28:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CV9ryyvwGCvPpXGIn0cJHBLKRo4swGEDCs29PCrmmJa0ehSpB+b9RAaYaeVvCDbzt7d60/Ajy2ZykvbnUBwFUajOkJSWHFTiXX41MjsQaP1XAUxCp7D7NpelTKPiLMUFn2pXvin1+kNlNXSE9BwztZ6qr7vwLh8jrHfYBKaTJVt3Kaj8ouUXLolG8QrNtVYp8QtC22dCzEPHLRk1v8KkbC0r0HTRjC1LezKEUUHAuU3TgIf+hZMNoh+n5A3tVabLOORgzIYmYK70of1j4vWjsvw1CAyHB9BwS/2RH+ZIVAwDPE/o2/Mb2zC6mtbuoFXfAnp60IgRJQ2zzQHZV+PmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HphHL75LPyEdqSy1/eN9x4UvV/FMDjjsZ9+lbFOCBM=;
 b=E+VBy4Zl+rqyD7875NrL2l/pvqMnSZd2xsJQ/UdiMu9BSr2EPG1g9gKha3weT/M0ivBOEHwUfbzdv2zk2BwIIZThbtJ3sstsUTR+SRz0zFuHE8piw7cMGK/MTjvGzAS95FBRtXU4t1EQesfYqghxdLehT1I+5OTXHTd6FzUzCVQoRMtQSE3HU1qC+4CvNXx8kluxr8kmHB0InI5rgxhmuklFwsIGImuv9o5L793nN/Qz3uJYbI1yWUJL4Hn7cHWJjBmnha6EKSaXN/y1ls+ckGZNGXM1No+/XIBXlBrdFc689gduzph3hC4+PfQHy/ofdMbnKLlakGx6D6l0sK9kXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HphHL75LPyEdqSy1/eN9x4UvV/FMDjjsZ9+lbFOCBM=;
 b=IRvihCJG1jHQEFJCYVhZF6mxpLp1cSepXvPpN0cVGvGTmPcznv3t2qRpixciE8TXWq+wiDJJfTwLQZhJkge8vf+CC+RexAvsSs5jYAVgBme3YZT9c9DesOS8SM01j5fvBCzcnqP6uEGekO2vN8fytjGdvFLCPL5Syc8YgJq8SOI=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH3PR04MB8876.namprd04.prod.outlook.com (2603:10b6:610:179::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sat, 29 Jul
 2023 12:28:29 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::4781:1e0e:9df8:940b]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::4781:1e0e:9df8:940b%7]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 12:28:28 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH] mmc: core: propagate removable attribute to driver core
Thread-Topic: [PATCH] mmc: core: propagate removable attribute to driver core
Thread-Index: AQHZvwM/Iku4ao6tPUCYlLYoDmTxAK/QsVFg
Date:   Sat, 29 Jul 2023 12:28:28 +0000
Message-ID: <DM6PR04MB657588B4D59F500881051B38FC07A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230725-mmc-removable-v1-1-b2e0c4f18e6d@weissschuh.net>
In-Reply-To: <20230725-mmc-removable-v1-1-b2e0c4f18e6d@weissschuh.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH3PR04MB8876:EE_
x-ms-office365-filtering-correlation-id: f4724047-28c8-4c3a-588c-08db902f504b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1oRsYh6FpFh1cwfWukIRqoODW/H94MUx88eC2bfJQkiFnqpRoB5Ut5HQVtqcJKEm81P6/Zmsb3lymj9Ycliro7GebXhoLthPrVVSU2+QFCGjgsGeMt4hgVVOd5U0/7ipQdzMR33/1mmiI8rfNMUts/wZNdohub5CuaFEXyLa69A+lg7vQwaSMu+DH/s/evURPQ+DvIHRnrKmNe8lm7lfCkEVu27dBoyR3dpQiodeJPaxhgY8rhHa46un68JuJ4vYNq5an60gtja5nbR5is5wcQWMyyamsfXtgAtZtuX+OoiiZLZwsMLhKsUiXs9kukvT/YaC44c4cF1HOt3FLn2QCgwN7bw7He0CZk7Z0qZTp2q1AUNlJ8WIvM2NMVMTCoAs6osBsChejhZ3khhqwwZyw4tOlZMaekXhuLidmnc/wOW4dxHCEDTFLZdsdCIlnYHfAYDtlzWtVzQZHetvDAaiFrumNYnsHngQBsG75k4WZGSPMwpb8J4KakpgGbgrIk2cladMi3v3t176s33Cyg3xbKnW2Zu7TOUiSk38Rk3xdgK9ZeDD/VhThb+3MIYKiYAjmXlJi4qhK/kUj1cOTUH6cuSbz+fEAuSV/+heQN0iu7c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199021)(66556008)(316002)(26005)(8936002)(41300700001)(4326008)(8676002)(6506007)(33656002)(55016003)(54906003)(110136005)(122000001)(82960400001)(66946007)(478600001)(66476007)(966005)(76116006)(9686003)(64756008)(66446008)(7696005)(71200400001)(38100700002)(2906002)(83380400001)(38070700005)(86362001)(186003)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0tJMTdxQzI5ZlQ1VUEvY0lyS3ZPMURmejZFcUR5RHJ6bGtuMDNONkYzdWk4?=
 =?utf-8?B?S2VESzdDU2hXbzN1bWk5ckN5OXVMa3IwLzI5b3o1cFVSYlJSK2U5TUR2ZXdD?=
 =?utf-8?B?R1JHRGVCVU9XZlNNUHhETTZHa2c3dC9EVS9jVWZlSVRzd0QyNGIwWWlQbWx0?=
 =?utf-8?B?SjNDRFZqeXZONmJQR0FkU2JUcmdXbCtkT1FiQzlIV3FrT09MSlh2bkx5dVNO?=
 =?utf-8?B?dEpmOHlSckdZNEpUcTJXTmc2d055U2t3cE5SbzJGOEQ2OXRHVmEwN1pPTkdk?=
 =?utf-8?B?dmRaamhhQ1V2SXI0Z1NucXNDOWpWeVNtN1JhTTMxTkZYaEg5WDlrc1NBUjlU?=
 =?utf-8?B?S1hsWGlZVld5MVBESWd6NHZhTnQxSHFSd1B3aVI1Wm5oRGVsMFRtSGZTWW9Y?=
 =?utf-8?B?N3BvUUNHZFBGOTdSZ0VGd3U1ajR6TmNsNXdwandMVVNMZWtVMkZ3dFU3UDJI?=
 =?utf-8?B?bk0ybmd5ME1ZaUdzUVJWSEZ5bTRZL05wSTVhZmwzSHhRMTNmOHl0MDhoMEFp?=
 =?utf-8?B?N1R0eDhtNkVKQlh3OTdKK1FIb0c5RWJ1M2JZamNQdkJLc2piZHlmRFV1MDFu?=
 =?utf-8?B?d2crc1Q3S0JWTXk4TDNyaXRad0o1RklRR3ZOS2hseUNQZWsvTDZ4SmJRNFRV?=
 =?utf-8?B?eFArZVl5d3VlN3ltWG9GY1VNQm9NOE5sNFAzN2RBSHFzNnB0MDIxdStjMFBx?=
 =?utf-8?B?alluV3BjNVkzbUFXL0N6LzdtTWw4VjJtNkd5ZHZYU3FHTkw0WjVRTFVjUVRQ?=
 =?utf-8?B?S1lVOWo4M1F6b1h2ZUkxUzFqNkNmcWEreVFlVHZFVkFLYmJxSEhMYk1mY1Uv?=
 =?utf-8?B?RU9PVEUwSjl4ZFR5b0poaW1YZWpyVE83aWE3ZzFKSWlTdUh5MWV2RWV0STc3?=
 =?utf-8?B?T3lSR3FHaW9NUkE0eUNOaTJaaDNadk93SEIxRkFGUFpVN2VRLzRJQ05uL2Zh?=
 =?utf-8?B?bDhrQThSdXhDZTRzWjVpaDc0ZVk4K3dkWWduOUYxVXd3RWxpK29VbHRGcFVO?=
 =?utf-8?B?Y0ZGbS9XYS9GUm1XSTZUZW4vWFBjSTlxVjFscWN1T2xtd2RMMHRMRGhoSHdR?=
 =?utf-8?B?K3Q1NjY5V0tCSlljemdzNkNtQVhZZHNGaUhzd3BuTnI4enJHY1N5RW1DcGY5?=
 =?utf-8?B?WUwxVlB2Wkw2YWZZVWNTV0VlZUJlL1VqOERoc2pyTnYvK2hFWmVuc3BSYVlG?=
 =?utf-8?B?bUllVUVYQnVpVmJGVkpHd3JJWTJ0OUFPaVltcXZ6NTlHRHRCekZpc2tXTjVI?=
 =?utf-8?B?V3FpU2U4VHBkODNsQmxPWUx5S2c4TTVMUDhoZ1c0RVVJcGxYS2NQWitCK3BQ?=
 =?utf-8?B?TE1jQjhDVDRVYXhTUk5rRXNGeGJ1b0NaZTVsN1BPM1lCN01kSVVjc3FaRktH?=
 =?utf-8?B?bmZzOGs1d3Z1MFJIeXNXZEFKcDREblRmNEhIRE9FaGc2RDR5eVRGRk1GYlBQ?=
 =?utf-8?B?aXdSVGExU1pwMjgwZUR4R0lwelMxRFA0K1JCUy9qdWpEUzFJWFdRSFJuNzd4?=
 =?utf-8?B?U0FFTHVNU3RzWmFvZUpNUksrUXNZMVA4T2pmM296bUZJc0lkME5PTnNWTTVz?=
 =?utf-8?B?SVJJaFIxYjV6ZXB6cWNremdoNFpqS2FMNyt6RDNrZkF2SDQyWVdZbERpSHFv?=
 =?utf-8?B?TzNsdXlxdzdyTVk4dW1SZjVTMnVsdzB6R0NLNTNJSk83MldFdWlMVzQrWC9C?=
 =?utf-8?B?VGNPUlZUa0JhRTZkRmJQQXhyM0JIenpuS0ZrSmZ0OFlNTzZZSytTb29lS3o4?=
 =?utf-8?B?SlJ5UzhhUkx1bmdVekIrVzQyR01LUmVEZUJEV2RBZEllUEl2SFBJSG42TU1o?=
 =?utf-8?B?dGxwcjJRbFhhT0xycUxNVlJPU0oxMFJiaDZ5bnJSSzNnRG1RSERjSW0rTGJF?=
 =?utf-8?B?K2lxNFB0M0FyWERTOEpoMWt1eXk3eHZrb2c3dEdDemk1ZTNpeVA3NDVsWGFD?=
 =?utf-8?B?M01Sdk9EcmNnWFhxNVp3WllsYWsxT3BhS3RiWEJUQURxNzRNS09yM0ZxUEtG?=
 =?utf-8?B?Nmhta25NSnR3Qko1UndsVVA0eklGSVY1QlptQmRESjN0MjRuSnQ1aDQ1dk9C?=
 =?utf-8?B?WTRQSXZaMUNscWRTdTREaVRnVEpVd1BBUDFlY0xqQ1FrblBFbnFsR2xpSm5t?=
 =?utf-8?Q?j2PMjai7ea/NLe+NbajDahDQI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Nn9YPfjuNMj5/ORWGdJJMyUn3/nItJvsGG9Gz/mO6C23xGMr7j7e0RjJdkN/hiH6zjvb/GY4JVmG/vQBa+w0Eh4IRCbP/MtL7fH7Mf1FDH8fhBbaXmDjOXacY6z/MS5xNkK/QG9LueVfrjjrDZwIYJ9uIoB0F+f8q5CMhIsTpH+IIPEdutfrLu50wafuNM66E3u1ymaGdx6pSqLt5rna2jPZ7re0in7pq6n4YcdEqU2Jr4Q6WciMj981jcl5SHPkXsNSu4zc+FjBRtw/wxDYlI6ZFzhZNDoS86W77Q9pnV/fZm/atFqq7q+MTAB4PMPrLib9X1ZOzGk8Uq1GDWJRcweA0akOJr7jlunwc/kOQiA5HAYHrdYG/zSPTIpCF4IrtxVljfelzcZ+1T9bpxZN2hQ+dMIGQXDzpb16Aooyg/rpAl6MG8UuzKkjKbpxsXzxGwc/K76N2rpzjnY7QX3l945ULP6xU7qxIVs1zi6DC0xAzDTvKnkybnb5JbI9ucBVlVVh7V/U4FFxzfBwXW0B3hrd9Tto8E3pxlBQhpC5HmLlnsAu01zN28uLbRuxlnjSWL9mLqZhrxy0XXXCflWg7ELo+fQqGAQnCgfkcLK+3q0S3SiQZPt0lhgMgoZkXVLTl+pRyO+bUVM+zRGW1CwOYI8gHuAbZmCPrg29LoQm+5skLYoIf81NNEuUUASWrnr8f0C0ojlGFzUd7bVb+yCpp/zXDDDxoXgGufbcOOKS7c1Mqw+6vnIC/3AXJ3yAxKgijETNW08FriVufkEoUTq2xX/mbKXfNr5+lF9YjMgDTz/mLjZWBgYWPV1Rdwua//aAsyxEk9bcqCOlQs4l57fuXvwG5gBZbvIykGuECjyRGqAtCgbK4pVLiUg1eb/Q0fOx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4724047-28c8-4c3a-588c-08db902f504b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2023 12:28:28.7796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LH2JlDC33IR2xipMSyKPa/cbn6BZJypauwrmlGwvHqZRposuQCv5XKeClplUQE3F3eIliqs4di0r9AEpRYcGeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8876
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gVXNlcnNwYWNlIGNhbiB1c2UgdGhpcyB0byBkaXN0aW5ndWlzaCBob3RwbHVnZ2FibGUg
bW1jIGRldmljZXMgc3VjaCBhcw0KPiBzZGNhcmRzIGZyb20gbm9uLWhvdHBsdWdnYWJsZSBvbmVz
IHN1Y2ggYXMgZU1NQy4NCj4gT25lIGV4YW1wbGUgaXMgdGhlIGxzYmxrIHRvb2wgZnJvbSB1dGls
LWxpbnV4Lg0KPiANCj4gTm90ZSB0aGF0IGRldl9zZXRfcmVtb3ZhYmxlKCkgaXMgbm90IHJlbGF0
ZWQgdG8gR0VOSERfRkxfUkVNT1ZBQkxFDQo+IHdoaWNoDQo+IGlzIG5vdCBhcHBsaWNhYmxlIGFz
IHBlciB0aGUgY29tbWVudCBpbiBkcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMNCj4gDQo+IExpbms6
IGh0dHBzOi8vZ2l0aHViLmNvbS91dGlsLWxpbnV4L3V0aWwtbGludXgvaXNzdWVzLzIzNzkNCj4g
U2lnbmVkLW9mZi1ieTogVGhvbWFzIFdlacOfc2NodWggPGxpbnV4QHdlaXNzc2NodWgubmV0Pg0K
UmV2aWV3ZWQtYnk6IEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1hbkB3ZGMuY29tPg0KDQo+IC0tLQ0K
PiAgZHJpdmVycy9tbWMvY29yZS9idXMuYyB8IDMgKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9idXMuYyBi
L2RyaXZlcnMvbW1jL2NvcmUvYnVzLmMNCj4gaW5kZXggMmMzMDc0YTYwNWZjLi4wYWY5NjU0OGU3
ZGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvYnVzLmMNCj4gKysrIGIvZHJpdmVy
cy9tbWMvY29yZS9idXMuYw0KPiBAQCAtMzEwLDYgKzMxMCw5IEBAIGludCBtbWNfYWRkX2NhcmQo
c3RydWN0IG1tY19jYXJkICpjYXJkKQ0KPiANCj4gDQo+ICAgICAgICAgZGV2X3NldF9uYW1lKCZj
YXJkLT5kZXYsICIlczolMDR4IiwgbW1jX2hvc3RuYW1lKGNhcmQtPmhvc3QpLA0KPiBjYXJkLT5y
Y2EpOw0KPiArICAgICAgIGRldl9zZXRfcmVtb3ZhYmxlKCZjYXJkLT5kZXYsDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgbW1jX2NhcmRfaXNfcmVtb3ZhYmxlKGNhcmQtPmhvc3QpID8NCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICBERVZJQ0VfUkVNT1ZBQkxFIDogREVWSUNFX0ZJWEVE
KTsNCj4gDQo+ICAgICAgICAgc3dpdGNoIChjYXJkLT50eXBlKSB7DQo+ICAgICAgICAgY2FzZSBN
TUNfVFlQRV9NTUM6DQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDBiNTU0N2M1MTgyN2UwNTNj
Yzc1NGRiNDdkM2VjM2U2YzJjNDUxZDINCj4gY2hhbmdlLWlkOiAyMDIzMDcyNS1tbWMtcmVtb3Zh
YmxlLTVjZmRjYTllZDA2Mg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBUaG9tYXMgV2Vp
w59zY2h1aCA8bGludXhAd2Vpc3NzY2h1aC5uZXQ+DQoNCg==
