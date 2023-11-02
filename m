Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C90C7DF3F3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347476AbjKBNhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjKBNhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:37:45 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79144A6;
        Thu,  2 Nov 2023 06:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698932259; x=1730468259;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EONZt20WYfza82DAuUiZJbgOJxljNVDgFEkMUyOcX0M=;
  b=EAtei7ExdY6LvG50Av9iH6wnTVlmVHky/ISeocfDe0JlCnFj95RTNaZH
   /2O2a8g5wZjoY2+U/w2JNLv5f1YjsLajIatVNblAfAGUFpq8rMGUaoKwi
   4h+M2uYgee/ZtV1h9flf+J5tb5PzUZ1U2lSD2jSD5r40Remk2aeXOBBE7
   kG9fT4aLz7Hlb+RhBNVNp23RXNkLeivwiU4iOY/fZ2Bt2nroDV+u9U0YE
   gsy3gHSC3Ln2K0CUZfqmb5nGinSo+WfswWNyy+5vdm2fuRvRztQGxD1Vj
   uhh7qcu6uOVtVk3aibMa8ztPD50M0WnT9//cvADA2AKxf7tiJSqO1gsy3
   A==;
X-CSE-ConnectionGUID: PMrNA95kTTCl+zLBnceKWg==
X-CSE-MsgGUID: LXQ5IOC1Q9W+eqPSi1/wYA==
X-IronPort-AV: E=Sophos;i="6.03,271,1694707200"; 
   d="scan'208";a="1302238"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2023 21:37:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESa1oD/GebEMaKweSRtpwgHc1JApnTl3VCOZGoSkQSskfUl04wClGv0bEYAaBRSNGuoawmSEyPMqLaXeqZTUcCMjFPUIlNFlXVJKlkwr5ysq5qXrPXuyHnuQeZmcwd1Wgr39YUIRnz332BpIHecgN0qmMnv00dDEkrGE70Ag9H+oT/H2TriLnol/7VyJenzK7pX7tXeDd+kPJWICYwWY+3bMIA6HFkzZwQdVm58IIvCRy3XY5AKbCu95rEtEh5Eo4DLtl7SFQ3NdeiKwaeoDKmdsoioYe7DB5eKERfnVC2oFANVK3opLEjWy5p+jxIX/XKgrs6aOXU1QwXyjOvEhdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EONZt20WYfza82DAuUiZJbgOJxljNVDgFEkMUyOcX0M=;
 b=ith3T6FslEcihWXY3CvJ4IPh940sHLZTB71Wxinii/ZDgt1JirwImwmp09bbvUyGdbnlOKfCtNrBQfFAE33Uv5MpsqEydaVtb0BX5psu7K6qYX24lQ5wGAKtNL39fwUeMv562qL5b0dM8AaAJeuwKjz+e+frMSsKYkcWm3AfP71cruOgajWSUaEZ3ZQZUixo8NhivTMWJVnHQAYqw9mY/bYY7acJJL+U8p+HOeQCcP9NAZQwh38gsFtYJlVfqFSK8iFAmfUWV2Khz9jyFzGiX7Ew3hxcFFMeX03q5QidNtPd81lRhq5Ph6xZwE6ZFVQIrSQTH1QO9E+fYR5l1V5Ujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EONZt20WYfza82DAuUiZJbgOJxljNVDgFEkMUyOcX0M=;
 b=c8D0wfqwffAS57FU375NmG1dSmRICcdDkykkrKPckhalCFz+z8zUl72sqk7DXQsOnaAjQplTSY+PyN7btTmRx7ArWMD+XfuwSm3joLXG1Nx+5NKoTV+/LPiHLAzyXOuMhwlauim5/l754w9hhad1xTjxLWiB8PMvzZVakL1UTI0=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB7493.namprd04.prod.outlook.com (2603:10b6:510:51::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19; Thu, 2 Nov 2023 13:37:36 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd%5]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 13:37:36 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
CC:     Dominique Martinet <asmadeus@codewreck.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Alex Fetters <Alex.Fetters@garmin.com>
Subject: RE: [PATCH] mmc: truncate quirks' oemid to 8 bits
Thread-Topic: [PATCH] mmc: truncate quirks' oemid to 8 bits
Thread-Index: AQHaB+Fund2V2t/1tkG/nk83veyIqLBnED2AgAABcgA=
Date:   Thu, 2 Nov 2023 13:37:36 +0000
Message-ID: <DM6PR04MB6575F41E713E2BD7C6D6023DFCA6A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231026075230.414685-1-dominique.martinet@atmark-techno.com>
 <CAPDyKFqkKibcXnwjnhc3+W1iJBHLeqQ9BpcZrSwhW2u9K2oUtg@mail.gmail.com>
In-Reply-To: <CAPDyKFqkKibcXnwjnhc3+W1iJBHLeqQ9BpcZrSwhW2u9K2oUtg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB7493:EE_
x-ms-office365-filtering-correlation-id: db741dc7-ad32-4084-4d27-08dbdba8e020
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +vKwhFUrUELOTF9T8EnrvakbFr8Rye7Ks5iRVSrSL9+JGDSgrrRyL/BSKMHZFmuA9oAdL+Y2YZ7ooQAoHl5W7zY64TwkT74TFoci2lf4hkHJjoeWgy1D1TcZgY1BaDkLiQrAOpumPmrvdl3jx4kXvHIVLMLC5ou0IfJPFrq8yWo78FAI9h5gWbGqehESHE3v1hnamurYdlJpSrxJ7/ODFu9d5q81vOdcUtlYNKRlcbv2qxBLRRkcAKQBlSZpa7GWbZn/PdDmUuPUtvN7Jc5Mn0uPeN2QItLWuJKo0LCTYoi60UJFNB62HrwXqomhy6JR+gXSRM/ICY+5hFqHdIEbtRgr8dOXw7YZfts2U1OKyccwjAuJ9f8qEdiFnUO3sST+lfdc8Ci7JyVIAa49hsWwbYqTppGkJwikqhqdXIa13wYP7B2iy+pxonRWJUyzO2u7bMMntu/6Z+DoKNskfIdcC06KUjpu3dLUUsppJ5zbwhiW6vh1l/mfQq6l8mPVUQRPYUxUevkPEscJbghx0jLgh5eR1pw1vbBgErmnXyGzPwKCTs2Ovp44bTQBhzCnFUAAbfjo8sTZUoivdFVWXAmtZVyFxfj53+8QjHrGeFjwIeA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(966005)(76116006)(8676002)(8936002)(4326008)(478600001)(122000001)(38070700009)(52536014)(2906002)(41300700001)(5660300002)(66556008)(33656002)(86362001)(110136005)(316002)(66446008)(66946007)(66476007)(64756008)(54906003)(55016003)(38100700002)(82960400001)(83380400001)(6506007)(9686003)(7696005)(71200400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlQ4T2YzeTh6QmRQVnlXMnAxblNYcWtXMDY5NVVKeGZEZzVrS2dGOWQ2TjY1?=
 =?utf-8?B?RU1yakV5V1Awd3F0UE14YUxLMnpzM0ozYVhWelVja2lyK3BUSHdJbTlvMHhR?=
 =?utf-8?B?dDdnMDYzTWpDaU8vN3NoYzdaMllQNDltcWQwYTBCYlFvWEw1WGNPVGtqMmpG?=
 =?utf-8?B?S0ZQeEs1Q0xTQld5ZGVRZVlra1ZGK293WEtwUnlqT1kvOWZXNFB3ODUvc0gz?=
 =?utf-8?B?VXZ3TlZjNDgvVDdtQXRlNlBpRlZoVW5lRFlSWTk4N3hEZUdoQVFsdkV1OStS?=
 =?utf-8?B?V1RoTGxKUEFWaXNBa2VUSnJvSURqSlZubW11dk1aTnVPR3FNWHVFWWFPYUFT?=
 =?utf-8?B?aWxhaTQrd2pCUG16YU1Yc0VjOGNjNzdYelBxTkkrTm1xdjlwNWNwTlBDSU9L?=
 =?utf-8?B?dkpvZWxlWm5GMEwrVXJUczhndDQ4SHdEcVlmM1V4SSs2Z3ltTFYxL0RqY2ZB?=
 =?utf-8?B?R01yYWFJN3J1d3Q1V0U4VzdOSFJPQlFoajdHWWszejhyZElBcFRVN05IRisw?=
 =?utf-8?B?UU5admdWT0tsUUp6NExtTkJmOSt3VThsZE43Q09UYWhMSjk1UHhvVkJ2cWlQ?=
 =?utf-8?B?Mk0rL3JKRWt6Z0FOcXI3Z3U0MzAwV3haNW5nemRuT0ZjeWtzN2F4L2hVY211?=
 =?utf-8?B?ektYYWtoZStaMFNYNlQ1YUNHaVdjSXYxYkgrbXNnZGdydUxlVHZ1dEsyWWtT?=
 =?utf-8?B?ZWhid01DSXZza2ZJYWlOcXpab0JHYTdwRW5GQzA5TzRuTGNlRi9ZcVYzNzRz?=
 =?utf-8?B?V0wyaXZVSlBxaTZ0QzhhSXJKcUMzTnNtOHUyQ0d5ZnM2bGhLS1Z3Y3lLZmJV?=
 =?utf-8?B?VHNlR0hjV2VzUk1ZVmQ2bWtJNG0xK0VDR2NScTAwcjVmQjdnNDBPQjFGK21x?=
 =?utf-8?B?b01NOWFLaFU2My9CT2k4clZzR0wxcm1RNnVnWmdmVTh0aFZtOVE0bWt1aGpC?=
 =?utf-8?B?cm1Dc2Z1L2szR2l2Z2dvaUNmK0t2dXRaOXRSM3Vpcjg0WVBuaHplQ1FWa1Vp?=
 =?utf-8?B?Ymg0dy8rbW5OTmZLQVdYK0hXdWJ5aE1hMUNXVUs5SGE3STN1aUs3S0RZQWFn?=
 =?utf-8?B?c0xqZittbDFwMDFOWXA5NlM1SnkwZ2pxNms5MURpdlJGbkcvWjZ1NnBmdkd5?=
 =?utf-8?B?N0tsTnQxc09ySlZLOHJ6cGtWMzY2SzFRa2hvN1I4aGU5YlVpeWJPS2d5cndN?=
 =?utf-8?B?RlI0V2NvY2pwY3ZLRmxXUGJKZzd5Zi9tYkU3UWdkdXJBeXFaTUtmcDV1YnA5?=
 =?utf-8?B?OGo5WTAyN3NtT3Y5RW5qWEZkZWJRSkU1UkxXV2ltSjBVZHRJcmdmT0VPdnlt?=
 =?utf-8?B?eThnQzZlWE9SdDRmSVRhMmpMdzRaYlA0Ny9yZ2wvTGxZNjR3K1NBUW1hVTFo?=
 =?utf-8?B?WWFCY3c1VlZSaDUramFTTmdydHVsdjFOM0dxTllmUWVJUnNsTjE1SGw2bDlZ?=
 =?utf-8?B?NC9VZ1NscXJwTWxUT25DaVlOeVlyZ0RXTUFCd3pDNzUyOFJDMnZFSjFFVkVJ?=
 =?utf-8?B?V0VjMXJYVE9FZHFUTTJyWU13ckFGQUJ5NllSdjZVWWpsT3VMVVY0S2RLZThy?=
 =?utf-8?B?ZmU1MS96UzYyVXJoTGNOSE5TM214dzdieHVWVzV6diszbHdiWXhPUFdOTUQ5?=
 =?utf-8?B?Y0pyblhGNzlSOHJadk1DTUwxaG4wN1hhZXBISUNISWR2aGM2UERqOHRnc2t2?=
 =?utf-8?B?NXpwQzZmTlg2MGtvSUY2TUFIeG01UGZISlExdVdjS0QrYSsxajhVcUQzU1M2?=
 =?utf-8?B?Q0xSUkhvUGVyYi9DdWU3b1l1Tk4yeW13WFRTRGhPdWZXK3BlRm1EOWhHYzB6?=
 =?utf-8?B?S0dlZG15UjN0Mm9YV3hHRDJsNDlWOWJNOTZhYnRaZG5kOU1QREE0R3QwUW9t?=
 =?utf-8?B?RlhLZXh5WTk2elh5OUo0Mng5dXFrSStISG50ay8yVXI2Q1IrdVZDZUhPMU1B?=
 =?utf-8?B?WTFmZlN4ajhPTzZ6L1pKdXZKWDErT2hidXorQW9UQkY1SFJCam53N1RXYXpr?=
 =?utf-8?B?VE0vc2RMREpNVlZSclpjTHgyM21MZWpZYnNyUVN2RkFBaEdEU2Fmc2ZQaWxj?=
 =?utf-8?B?OG5UcHRRUnk5OVZ3ZmplUDBRZWZmTUJ2YzRsS2FTSXE2NkFIQ0RCNHBha2JH?=
 =?utf-8?Q?AebAZlX4MbMt00LkOzSAn7eWa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cp2j8uARhILjZWASBDXZ68AsG3XuTIPvSSJdCYzh5GW/UQC3Rsd2S+qAePfcJlXF2rOVJ8b2lleCdLI0SRtQqsPsYBrSPd4usrVY1Muqcgz8+XeyfaUMBBLp1+R16hRzBwDiDEJf42HmZnluJyzdVxvzN474ZZB+N0ROzgbwbeaXMJn0XW76wDwSoBEN992Dd1i5869Nl1/oyQH9DsTtQ7GS8ro7JFLakAExM+4eswpt2JMs6z0nKP11sr+3+VEkTfPO1xxtyUHMVT0ZcZZ0E0RNKQYUxwPC1A8vyvNdmn7dtc7FubZWzWr4mqWRv3fuOofhh3JnIHp3vO7n5xXMaPkbxVUrzsO5vjAcr6zrHKG6RShC+Yuv+MffzWu6EbTFBP3+IW7SBZWiIFAhYi8c+tTYw9tKyxMiJm3JT+N4/vTBBaRHbfh5UtKucFBARQmZb4AlOpWyJVgj1wjfhW83WorXyGDPhOe/R43rjwcs80LUxzax2RnrWrkhAM5EUxtOViSENBb6c5taGx0orqfAHrovpXrW3TF+BAXfi/nWJm1e91KmaN8HaK8ZGafjRDa+wdOH8acqJlc3NvqYH3lLaxqGMHoNQB+D5ndqy0yLUBhecwtcoOrW1D/4WQxNiYJjdRrNMakwoyeXD7GQLe/CLNKF1hbv2A8wDJgipSM+fTBxNPSKVaquWhYsGUE5P/ropbv9g9Zj9GCZzdztSrolRWtjmsl4heBhZ7poAXyHrWSCNQOmppuOmQ7p/5EZa+k2j6qxHHKRZTThXy3WGQkU2C0zGm2zncRvrNkYAlCstdxQbU5QSi2JYmmJZtx93t2GB3su6XwAqJwEVVOLp+XkoaGEL/0uuqhuD/UCpK3Zg4PVo0FmBr1AgkwaNkl/gvaTqwX/Yyw3a6yk+5R6KQq7hvb1J7iB7raZzZYWiyMcl4E=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db741dc7-ad32-4084-4d27-08dbdba8e020
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 13:37:36.3650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6dXI16kLqN1F2h9f+zZs1jl+thZDZVZeQpC+BmMof+DZLAqqr+zHCF88ch0SGU34WZb47zgYDx8U2nhCb8mZvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7493
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBPbiBUaHUsIDI2IE9jdCAyMDIzIGF0IDA5OjUyLCBEb21pbmlxdWUgTWFydGluZXQNCj4g
PGRvbWluaXF1ZS5tYXJ0aW5ldEBhdG1hcmstdGVjaG5vLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBX
ZSBub3cgb25seSBjYXB0dXJlIDggYml0cyBmb3Igb2VtaWQgaW4gY2FyZC0+Y2lkLm9lbWlkLCBz
byBxdWlya3MNCj4gPiB0aGF0IHdlcmUgZmlsbGluZyB1cCB0aGUgZnVsbCAxNiBiaXRzIHVwIHRp
bGwgbm93IHdvdWxkIG5vIGxvbmdlciBhcHBseS4NCj4gDQo+IEh1aCwgdGhhbmtzIGZvciBzcG90
dGluZyB0aGlzIQ0KPiANCj4gPg0KPiA+IFdvcmsgYXJvdW5kIHRoZSBwcm9ibGVtIGJ5IG9ubHkg
Y2hlY2tpbmcgZm9yIHRoZSBib3R0b20gOCBiaXRzIHdoZW4NCj4gPiBjaGVja2luZyBpZiBxdWly
a3Mgc2hvdWxkIGJlIGFwcGxpZWQNCj4gPg0KPiA+IEZpeGVzOiA4NGVlMTliZmZjOTMgKCJtbWM6
IGNvcmU6IENhcHR1cmUgY29ycmVjdCBvZW1pZC1iaXRzIGZvciBlTU1DDQo+ID4gY2FyZHMiKQ0K
PiANCj4gSSB3b25kZXIgaWYgdGhlIHF1aXJrIGFwcHJvYWNoIGlzIHJlYWxseSB0aGUgY29ycmVj
dCB0aGluZyB0byBkby4gSSBoYWQgYSBjbG9zZXINCj4gbG9vayBhcm91bmQgd2hhdCBoYXMgY2hh
bmdlZCBhbG9uZyB0aGUgbmV3IHZlcnNpb25zIG9mIHRoZSBNTUMvZU1NQw0KPiBzcGVjcywgdGhl
IGJlbG93IGlzIHdoYXQgSSBmb3VuZC4NCj4gDQo+IEJlZm9yZSB2NC4zOiBPSUQgWzExOToxMDRd
IDE2LWJpdHMuDQo+IEJldHdlZW4gdjQuMy12NS4xOiBPSUQgWzExMToxMDRdIDgtYml0cywgQ0JY
IFsxMTM6MTEyXSAyLWJpdHMsIHJlc2VydmVkDQo+IFsxMTk6MTE0XSA2LWJpdHMuDQo+IEJleW9u
ZCB2NS4xQTogT0lEIFsxMTE6MTA0XSA4LWJpdHMsIENCWCBbMTEzOjExMl0gMi1iaXRzLCBCSU4g
WzExOToxMTRdIDYtDQo+IGJpdHMuDQo+IA0KPiBPSUQ6IE9FTS9BcHBsaWNhdGlvbiBJRA0KPiBD
Qlg6IERldmljZS9CR0ENCj4gQklOOiBCYW5rIEluZGV4IE51bWJlcg0KPiANCj4gSXQgbG9va3Mg
dG8gbWUgdGhhdCB0aGUgb2ZmZW5kaW5nIGNvbW1pdCAoODRlZTE5YmZmYzkzKSBzaG91bGQgYmUg
cmV2ZXJ0ZWQNCj4gaW5zdGVhZCBvZiB0cnlpbmcgdG8gaW50cm9kdWNlIHNvbWUgd2VpcmQgcGFy
c2luZyBvZiB0aGUgY2FyZCBxdWlya3MuDQpBZ3JlZWQuDQoNCj4gDQo+IEluIGZhY3QsIHVwIHVu
dGlsIHY1LjEgaXQgc2VlbXMgbm90IHRvIGJlIGEgcHJvYmxlbSB0byB1c2UgMTYtYml0cyBmb3Ig
dGhlIE9JRCwNCj4gYXMgdGhlIENCWCBhbmQgdGhlIHJlc2VydmVkIGJpdHMgYXJlIHByb2JhYmx5
IGp1c3QgZ2l2ZW4gc29tZSBmaXhlZCB2YWx1ZXMgYnkNCj4gdGhlIHZlbmRvcnMsIHJpZ2h0Pw0K
T3Igc29tZSByYW5kb20gZ2FyYmFnZS4uLg0KDQo+IA0KPiBCZXlvbmQgdjUuMUEsIHdlIG1heSBo
YXZlIGEgcHJvYmxlbSBhcyB0aGUgQklOIG1heSBhY3R1YWxseSBiZSB1c2VkIGZvcg0KPiBzb21l
dGhpbmcgdmFsdWFibGUuIE1heWJlIEF2cmkga25vd3MgbW9yZSBoZXJlPw0KQUZBSUssIHdlIGRv
bid0IHVzZSBpdC4gIEJ1dCBJIGNhbiBhc2sgYXJvdW5kLg0KDQpZZWFoLCBJIHRoaW5rIGl0cyBi
ZXN0IGp1c3QgdG8gcmV2ZXJ0IGl0Lg0KSWYgYW4gZU1NQyB2ZW5kb3IgaGFzIGFuIGlzc3VlIHdp
dGggdGhpcyAxNmJpdHMgYm9ndXMgb2VtaWQgKFNhbmRpc2sgZG9lcykgLQ0KdGhleSBjYW4gaGFu
ZGxlIHRoZWlyIG9lbWlkLXNwZWNpZmljIHF1aXJrcyAtIEkga25vdyBJIHdpbGwuDQoNClBsZWFz
ZSBub3RlIHRoYXQgaXQgd2FzIHBpY2tlZCBieSBzdGFibGUgYXMgd2VsbC4NCg0KVGhhbmtzLA0K
QXZyaQ0KPiANCj4gVGhhdCBzYWlkLCBpZiB0aGUgb2ZmZW5kaW5nIGNvbW1pdCBpcyByZWFsbHkg
bmVlZGVkIHRvIGZpeCBhIHByb2JsZW0sIHdlIG5lZWQNCj4gdG8gZmlndXJlIG91dCBleGFjdGx5
IHdoYXQgdGhhdCBwcm9ibGVtIGlzLiBUaGUgRVhUX0NTRF9SRVYgZG9lc24ndCBwcm92aWRlDQo+
IHVzIHdpdGggdGhlIGV4YWN0IHZlcnNpb24gdGhhdCB0aGUgY2FyZCBpcyBzdXBwb3J0aW5nLCBi
dXQgYXQgbGVhc3Qgd2Uga25vdyBpZg0KPiB2NS4xIGFuZCBvbndhcmRzIGlzIHN1cHBvcnRlZCwg
c28gcGVyaGFwcyB0aGF0IGNhbiBiZSB1c2VkIHRvIGZpeHVwL2ltcHJvdmUNCj4gdGhlIE9JRC9D
QlgvQklOIHBhcnNpbmcuDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0KPiANCj4gPiBMaW5r
OiBodHRwczovL2xrbWwua2VybmVsLm9yZy9yL1pUb0pzU0xIcjhSbnVUSHpAY29kZXdyZWNrLm9y
Zw0KPiA+IFNpZ25lZC1vZmYtYnk6IERvbWluaXF1ZSBNYXJ0aW5ldA0KPiA+IDxkb21pbmlxdWUu
bWFydGluZXRAYXRtYXJrLXRlY2huby5jb20+DQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcNCj4gPiBDYzogQXZyaSBBbHRtYW4gPGF2cmkuYWx0bWFuQHdkYy5jb20+DQo+ID4gQ2M6IFVs
ZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiA+IENjOiBBbGV4IEZldHRlcnMg
PEFsZXguRmV0dGVyc0BnYXJtaW4uY29tPg0KPiA+IC0tLQ0KPiA+IE5vdGVzOg0KPiA+ICAtIG1t
Y19maXh1cF9kZXZpY2UoKSB3YXMgcmV3cml0dGVuIGluIDUuMTcsIHNvIG9sZGVyIHN0YWJsZSBr
ZXJuZWxzDQo+ID4gICAgd2lsbCBuZWVkIGEgc2VwYXJhdGUgcGF0Y2guLi4gSSBzdXBwb3NlIEkg
Y2FuIHNlbmQgaXQgdG8gc3RhYmxlDQo+ID4gICAgYWZ0ZXIgdGhpcyBpcyBtZXJnZWQgaWYgd2Ug
Z28gdGhpcyB3YXkNCj4gPiAgLSBzdHJ1Y3QgbW1jX2NpZCdzIGFuZCBtbWNfZml4dXAncyBvZW1p
ZCBmaWVsZHMgYXJlIHVuc2lnbmVkIHNob3J0cywNCj4gPiAgICB3ZSBwcm9iYWJseSBqdXN0IHdh
bnQgdG8gbWFrZSB0aGVtIHVuc2lnbmVkIGNoYXIgaW5zdGVhZCBpbiB3aGljaA0KPiA+ICAgIGNh
c2Ugd2UgZG9uJ3QgbmVlZCB0aGF0IGNoZWNrIGFueW1vcmU/DQo+ID4gICAgQnV0IGl0J3Mga2lu
ZCBvZiBuaWNlIHRvIGhhdmUgYSB3aWRlciB0eXBlIHNvIENJRF9PRU1JRF9BTlkgY2FuIG5ldmVy
DQo+ID4gICAgYmUgYSBtYXRjaC4uLi4gV2hpY2ggdW5mb3J0dW5hdGVseSBteSBwYXRjaCBtYWtl
cyBtb290IGFzDQo+ID4gICAgKCh1bnNpZ25lZCBzaG9ydCktMSkgJiAweGZmIHdpbGwgYmUgMHhm
ZiB3aGljaCBjYW4gbWF0Y2ggYW55dGhpbmcuLi4NCj4gPiAgLSB0aGlzIGNvdWxkIGFsc28gYmUg
d29ya2VkIGFyb3VuZCBpbiB0aGUgX0ZJWFVQX0VYVCBtYWNybyB0aGF0IGJ1aWxkcw0KPiA+ICAg
IHRoZSBmaXh1cCBzdHJ1Y3RzLCBidXQgd2UncmUgZ2V0dGluZyB1Z2x5IGhlcmUuLi4gT3Igd2Ug
Y2FuIGp1c3QgZ28NCj4gPiAgICBmb3IgdGhlIGJpZyBib29tIGFuZCB0cnkgdG8gZml4IGFsbCBN
TUNfRklYVVAoKSB1c2VycyBpbiB0cmVlIGFuZA0KPiA+ICAgIGNhbGwgaXQgYSBkYXksIGJ1dCB0
aGF0J2xsIGFsc28gYmUgZnVuIHRvIGJhY2twb3J0Lg0KPiA+DQo+ID4gIGRyaXZlcnMvbW1jL2Nv
cmUvcXVpcmtzLmggfCAzICsrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9x
dWlya3MuaCBiL2RyaXZlcnMvbW1jL2NvcmUvcXVpcmtzLmgNCj4gPiBpbmRleCAzMmI2NGI1NjRm
YjEuLjI3ZTAzNDllMTc2ZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL3F1aXJr
cy5oDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9xdWlya3MuaA0KPiA+IEBAIC0yMTEsOCAr
MjExLDkgQEAgc3RhdGljIGlubGluZSB2b2lkIG1tY19maXh1cF9kZXZpY2Uoc3RydWN0DQo+IG1t
Y19jYXJkICpjYXJkLA0KPiA+ICAgICAgICAgICAgICAgICBpZiAoZi0+bWFuZmlkICE9IENJRF9N
QU5GSURfQU5ZICYmDQo+ID4gICAgICAgICAgICAgICAgICAgICBmLT5tYW5maWQgIT0gY2FyZC0+
Y2lkLm1hbmZpZCkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gPiAr
ICAgICAgICAgICAgICAgLyogT25seSB0aGUgYm90dG9tIDhiaXRzIGFyZSB2YWxpZCBpbiBKRVNE
ODQtQjUxICovDQo+ID4gICAgICAgICAgICAgICAgIGlmIChmLT5vZW1pZCAhPSBDSURfT0VNSURf
QU5ZICYmDQo+ID4gLSAgICAgICAgICAgICAgICAgICBmLT5vZW1pZCAhPSBjYXJkLT5jaWQub2Vt
aWQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgKGYtPm9lbWlkICYgMHhmZikgIT0gKGNhcmQt
PmNpZC5vZW1pZCAmIDB4ZmYpKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVl
Ow0KPiA+ICAgICAgICAgICAgICAgICBpZiAoZi0+bmFtZSAhPSBDSURfTkFNRV9BTlkgJiYNCj4g
PiAgICAgICAgICAgICAgICAgICAgIHN0cm5jbXAoZi0+bmFtZSwgY2FyZC0+Y2lkLnByb2RfbmFt
ZSwNCj4gPiAtLQ0KPiA+IDIuMzkuMg0KPiA+DQo+ID4NCg==
