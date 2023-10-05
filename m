Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58317BA0B5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbjJEOlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236874AbjJEOhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:37:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B824E353;
        Thu,  5 Oct 2023 07:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696514596; x=1728050596;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Wm7md2P/GB2mCe4lVvRJQYvsVFZWK0KJN4f+GcC0l30=;
  b=hRPgGHYhOkQkCiJrZSkeWpz4Na2laBgQ/gtrYC9fZSmWXatpzSJaZeXd
   Ce+Bu29pGZTSpFO3PmsMQ32q7QBPkpIraVphkKfvU51KUvfGwmV/50KDE
   kh3Yk/17VdZHt7NTNXJmcvdVaYqNnkr01nc673rWbtfTRJXS3wkS8I7HO
   7Qmvbbp6EllAHWoFqvFB4+iWG9HIXgd4Atz3nIBh3IdZ3Dv1erlM9yhPQ
   rEs/T3eLIDPkabTTdo/V3tiKd/pw5jgbhV+1Dthta3hirXQbEKTtHsDis
   LsAIZySUmbq6V28SvA+AU1976cpj1y5n9Y89olDGKliSbGcAWLxILB+sS
   w==;
X-CSE-ConnectionGUID: WR3d0xOeS0eP+tLJngtczA==
X-CSE-MsgGUID: EwfY3Lg4TC6ps7FT5fnyGA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="8518351"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2023 04:02:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 5 Oct 2023 04:02:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 5 Oct 2023 04:02:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkR93gV+Y+2znDnTYATNv7i/sWvJlw3bbS6CJgsT3U5y3nhpq8/fHauHrqE9f7vb8HLb6ENio+7AT1FPBU/fT0zJL7pfbTp15jkrLB9/OkWt5NoB0d38sCoFaN5tyvjOOaTUah99Yez4HDsk68ImSsEub/u4b6SKfOYsf0YXBFDoodn9hFkWaVZu9UtSOxC/5f6Xd4MiYnAhuGH8bjxZdM5I6VOOSIladQcauiXynmoBRqk62iGF436ujUSq2CjOnHKTiIU9wJVeXhU/idzXmIUIARN3lURlKLkWr2F8GUQrWRAJ6JsGeWGLOvl2JW9JI4OfuaJ3DC/eHfJEOfTglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wm7md2P/GB2mCe4lVvRJQYvsVFZWK0KJN4f+GcC0l30=;
 b=cZmEiTNptJPO4yKnz0JzoyTnh51Axg8FZc7ZIl25gko6vnsnvgZaOpQce0x9TbBx02kZyHRN6fZBX8+bjqIKPpJKnBItX8xLc8nx5tFZcJt6w6C0vxGlvyn/GLnxiOZQyib8sr/OAyNIUHkKVLAG9oxiyO34cKgPdixY7VXmTlaZZUIyk2ZxjMrEqzFqd2UNkC9DVQOFHGSPqfwohyghtRQv8oSZKK3RZwtAEPfHNLZK0tMixiG1MfmubpU2u4VAdrhoyeu68X2kEcDGLSFzXZ6FpYJcDfhoWiMMgXAiFIvIX6LFV3Qz/7nYcKjgGrA+ChMz9uTEVuYt7czz/sljDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wm7md2P/GB2mCe4lVvRJQYvsVFZWK0KJN4f+GcC0l30=;
 b=Lyt46nnFEBrtpon4pgyP7EC4aoduiI0wj9fNAx2pShO0YZCS0MQrky69GpvDndozKH3XDePjl0Q5THtkOZKEBGlEUO6pr8n9ANv4n+ecv96uFryUDuHRVHAoEyqz9kFRLRzBImmhHduF+eugp2Q6Wn7Fu4Ha+XW+hWr1sYuNn7E=
Received: from CY8PR11MB7688.namprd11.prod.outlook.com (2603:10b6:930:75::20)
 by SA0PR11MB4623.namprd11.prod.outlook.com (2603:10b6:806:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Thu, 5 Oct
 2023 11:02:43 +0000
Received: from CY8PR11MB7688.namprd11.prod.outlook.com
 ([fe80::77ff:74d2:4d5a:875]) by CY8PR11MB7688.namprd11.prod.outlook.com
 ([fe80::77ff:74d2:4d5a:875%6]) with mapi id 15.20.6838.024; Thu, 5 Oct 2023
 11:02:43 +0000
From:   <VishvambarPanth.S@microchip.com>
To:     <kuba@kernel.org>
CC:     <Bryan.Whitehead@microchip.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>,
        <richardcochran@gmail.com>, <UNGLinuxDriver@microchip.com>,
        <edumazet@google.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: microchip: lan743x: improve throughput with
 rx timestamp config
Thread-Topic: [PATCH net-next] net: microchip: lan743x: improve throughput
 with rx timestamp config
Thread-Index: AQHZ8GQzSatw7vX1TECH+oIn8mKcFLA5+IuAgAEeOAA=
Date:   Thu, 5 Oct 2023 11:02:43 +0000
Message-ID: <a49fa745b9bbf05dd6174a176a7749e5a683fe89.camel@microchip.com>
References: <20230926155658.159184-1-vishvambarpanth.s@microchip.com>
         <20231004110031.7e9c32e8@kernel.org>
In-Reply-To: <20231004110031.7e9c32e8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7688:EE_|SA0PR11MB4623:EE_
x-ms-office365-filtering-correlation-id: 59c091a7-cb2f-4da7-ff24-08dbc59299c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PdqFEo0u2WLmkjklDj9hOkdZwck+83WpGf4ROWn6LLrI9CgFWmQ7VD/iyDQ7B3PrG7tCctnDVGxNe6yMFZk6dE2i3N+JqH1g9Riv2K7hfEj3c9JCS9bTqnXeTYXh4F87jSAHbf0z69neCFO5P1rusX6HCGo1kUyfurEIg7PZrL9f+g4hRRdrh5aF15q4DqnW4ezz5XSLfVTmyhZb0BfP9WsOTJHwleQ+2zX3nhk5PGaQY55zJc6rmCgv+LlwRqj9J0VDzLVfGQ2jDZMD5l9hD3QnzC2fcE69XN+V9U8Gk5SLvFQVKcGklGilk8biFpJ+mJ0Mdoi0HY0F6LIqoqtJENkOu+0LZzetV7Ll9BoqhNGUhQ5gkgSVLhjQW5Gzt3i2C4JK4/srkXYchpqBTYquxoUDxGI8xNaSkeUz+rOMTekviSjzC1R/GWUtbfLczb6D339inlwRKFZFJ/g1dWV+N5hdWMiDavEsTIPgK3jtIqyfsSl4a/OVYt9jXTMmTU8Qei6tkniLsJYhpU/eaCpY0PoGjX9rsH+vaaeM5MWuJgpTy7RRddDT17e8ThF7ZZXPj/wirGe1wjy1+5eRY2016F4B4u73iBDUFirBA7A8reWBAtHahVRrpSD6SJQfr8ML
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7688.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(54906003)(2906002)(83380400001)(122000001)(4744005)(38070700005)(38100700002)(76116006)(8676002)(6512007)(8936002)(66556008)(6486002)(66946007)(66476007)(6506007)(71200400001)(4326008)(2616005)(91956017)(41300700001)(64756008)(26005)(5660300002)(316002)(66446008)(6916009)(478600001)(36756003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzZvOWphT3VXZUZUd3plYUljVHhFNGhUYnEwZGJjVnR6SXUzWlkybGVrZU1J?=
 =?utf-8?B?WHpUQU1UUEpBOFo4RFBWdE9FRE1ZODMvQnVmRUdUTk5pQSs5M044QWFITVpk?=
 =?utf-8?B?M0RtSjZ4YjZUQVNBSmtiaGx6M2dVb1oxcUxtaDJEcHV6bzdIRFM3RGwyNlRL?=
 =?utf-8?B?aEp5QWNvc05wTUNCZFhRQ0dnbDArME80MXdwS21mU0J6dW9aN2owbzhDb2Zx?=
 =?utf-8?B?U3NZZWdXOXNjenBRcGhqMHRzWE5wd3hsMWovMkx5VlJTMUVWMHpObHhyM1lI?=
 =?utf-8?B?UDNweENvK0V1bWpBTU5tSzFvdXNRVitXRkgvVU55cjhwNXEvcDBzaThJa25G?=
 =?utf-8?B?YitjdEd3MVJzb2FWcG8zM21jZlRkaFhBaFZtSytpalNScHhsWEFXdXNndUhH?=
 =?utf-8?B?L1N6aldCT3kxZ1FiQUc3ZmFFVjdTeVptUGEyQmdibmhaaXRZZGh1RVdHUWxI?=
 =?utf-8?B?MWFZZmJ2Z0pFWnl0c2lvQ3MzM3p0Qmtka0JEUXlZa0VRSFRwZ2UvbjJXc3ZL?=
 =?utf-8?B?c2VNdzJKN1FTU29nb0tyUmZIRDFwSjdtYnQ4SVNJbEJJdjVPL2FFRzh5ajVp?=
 =?utf-8?B?alU4T00yTUlDa1RROVQrVGNGdFAzUDYzSzBQMEl5R1ZEd0lpVFVDb1VFdUZr?=
 =?utf-8?B?QkdtWWZrRUptVTAvcEZqanpHWmRVazdnY003SmM5U3FDbC9JWVNPOXYyS2Nx?=
 =?utf-8?B?Qkt0NnhuV3hxamovNXJzWGdzanJqc2VwdmNrNXRlRGo5R21WbEg0QWs1LzNu?=
 =?utf-8?B?N0dqMUZQNVRZalNvZmRPM1FEU3p0N0k2di9TL1g3WVJxZXFSZG5UckgwRlNt?=
 =?utf-8?B?WUxkdGdYb09XQ3ppb0RKOVVtZ2RUem5EM3BVMWxzaC9sdm9tdXN0Z2MrQnly?=
 =?utf-8?B?eVdBeG4wa0oyTmtqbnFKak1hd3gxSlRoYnY4R0VZSi9seENockxJb0FQdWdE?=
 =?utf-8?B?R0JnanJlMitUWlZiQkJ6cjZyMHJtMkFIOXJZUkw4RTdlS1QxSEZDQW41dllj?=
 =?utf-8?B?TmdHemc5N2VDT2pQUGgwYlZFOFlYY3h2SlJzK1N3SWpmdlNZVkVTUUUyT3RT?=
 =?utf-8?B?ejZuYzlBS0h5YWZFZ1FESHNGc0IrTXJaY2VVQm93ZWtPMitYY1RkdWdJdnF1?=
 =?utf-8?B?MlNST0JDWGN2R2xFYUFBcUVZRkdBOUlNdFBUcGxNVGhKa2tTbklQcTJFWkpW?=
 =?utf-8?B?aHJOQWZGTzRYUGFPRk90bnNqcHhtOS80OU9VSUx6QUNPYjhQZ2dJRmtESUxV?=
 =?utf-8?B?bnRRYjN3OTN2dmt3eXhNQUQ3SGw1TjA0bWo1cWZWYVhnaVJ4bllqc0N4SFpY?=
 =?utf-8?B?bnM2QWowdFdvOWl1djhMSGhQRnMycGY5M2kxNEQ1dm9ETGlkNFY2L1dVOVpJ?=
 =?utf-8?B?OGkwYmZtV25xaEVMb3lGOGtKS0pVb01yNmo2MW5zN3ZxWXdzc3lTbGpEemNj?=
 =?utf-8?B?VXBJRUFMdmVOOGpIUGFweUhXVjhoWEJpVmZ0bDZROUV6b1lFaFYxZm1RWmZV?=
 =?utf-8?B?WWs5eUVURldkcFpZQmhlV3grM1loejFnVEduQ2pmbm51RDZ0WlFBZG12ZkFR?=
 =?utf-8?B?YnFNN1laMFptb3ZHSmNBbTkzaE5WNUVNcnkyb0c2NUMzK204cmE4VE5MWWV3?=
 =?utf-8?B?bXRjSmJkZHhDNkxnNFQzSHRVOWE3V2k3U1pPWkJ6YStWakw0R21wVkExTFJy?=
 =?utf-8?B?T3dQTGFwT0draFZxQXFlb2pjd05sMG5WZllSdnJHUnRKMnBmT1ZjVHk5eFdQ?=
 =?utf-8?B?K1lLa1V6blpIZDE1S0xhdk52NWVYY3NKc0RGcW9uYXErTkw0a0czcE03RjRj?=
 =?utf-8?B?UnA0QzkyUEZocW9vMW00US9keXFRUGNWRC9uTG1wNnlZcTRqVXdyUk1KWjRM?=
 =?utf-8?B?TDM0dHNTWTZ1a1ltSUR6VVduOEJ1YmYrK1d6R0NMdWRIY3pnczYzbFVnak95?=
 =?utf-8?B?WjNicVZOOEl3UmdIOGtwS3NVVXFhWWhYNENmQ09RdGYwTHE5MThiTVBndm1j?=
 =?utf-8?B?WFBvLzkxNWJQNTl2TTZuYWgxbXVuN0ZTZmFtNG1oaW9QRmo1WEZmWTlwM1RQ?=
 =?utf-8?B?VHBMNjNFend6NUdQci9XNEJUTkVsaGFUMFVreFhaMkRUMXN2eUNhdlVkazlS?=
 =?utf-8?B?ajBrMnk4a1dqcHU1dG9CTnFwcWk1SEF5RUVaYmZoOVBIZHB6ZElOUVBKWTlK?=
 =?utf-8?Q?VGTCQHxjTb2OrNaQ0mTDgYM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBAB755F4BC4884FB9291AD110B9BD87@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7688.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c091a7-cb2f-4da7-ff24-08dbc59299c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 11:02:43.8299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aNY9G3cd+pm5Rc5VMxoUMhpDnzdNEfFQjqYH7GPDRTu34yQd38FGQSjBldKchudsoUIM6OEwuQmoRAo6ofIU3cqvwx9bU7e3ezYpFdWK53g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4623
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTEwLTA0IGF0IDExOjAwIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToK
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQo+IAo+IE9uIFR1ZSwgMjYgU2Vw
IDIwMjMgMjE6MjY6NTggKzA1MzAgVmlzaHZhbWJhciBQYW50aCBTIHdyb3RlOgo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmV0aWZfd2FybihhZGFwdGVyLCBk
cnYsIGFkYXB0ZXItPm5ldGRldiwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAicnggdGltZXN0YW1wID0gJWQgaXMgbm90
Cj4gPiBzdXBwb3J0ZWRcbiIsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcnhfZmlsdGVyKTsKPiAKPiBJIGFkZGl0aW9u
IHRvIEpha2UncyBjb21tZW50cyBwbGVhc2UgYWxzbyBkcm9wIHRoaXMgd2FybmluZy4KPiAKSGkg
SmFrdWIsClRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzLiBTdXJlLCB3aWxsIGRyb3AgdGhlIHdhcm5p
bmcgb3IgYWRkIGl0IGFzIGRlYnVnCm1lc3NhZ2UuCgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4gCj4gQW5kIG1ha2Ugc3VyZSB0
aGlzIGlzIHRoZSBjb3JyZWN0IHJldHVybiBjb2RlLgo+IEkgdGhvdWdodCAtRVJBTkdFIHdhcyBt
b3JlIGFwcHJvcHJpYXRlIGhlcmUsIGJ1dCBJIGNvdWxkIGJlIHdyb25nLgoKV2lsbCBjaGVjayBh
bmQgYWRkIHRoZSBhcHByb3ByaWF0ZSByZXR1cm4gY29kZSBpbiB2MiBwYXRjaC4KCg==
