Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729B779B648
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbjIKWYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237884AbjIKNR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:17:57 -0400
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BD4EB;
        Mon, 11 Sep 2023 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3089; q=dns/txt; s=iport;
  t=1694438271; x=1695647871;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HsXSX1CEcf1aBUewFjghHuPt/BoX0QKluVg/xfiUjxk=;
  b=kmGLrCKmD6pcXXx1oqHuLKfqERpX5ZQReZZqRhcCVkFrioyG7iteGvmm
   2pwPjJLFZ6LR6vQBk6wo6kff33BIAInwa11uUr7+eCWX5Hk92Vb3cN6/0
   /q2f5M7HFmlZN3uzd+eNxYqKb7YqMP3v0n9cf4xOIZp1UQO10I11P+It1
   c=;
X-CSE-ConnectionGUID: vgGM1Kb1QqmhXYIXktvOVg==
X-CSE-MsgGUID: aAZM1hFHRyeXlLVIZOC2Tw==
X-IPAS-Result: =?us-ascii?q?A0AcAACSEv9kmIYNJK1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEWBwEBCwGBZFJ2WyoSR4gdA4ROX4hkA517gSUDVg8BAQENAQFEBAEBhQYCh?=
 =?us-ascii?q?nECJTQJDgECAgIBAQEBAwIDAQEBAQEBAQIBAQUBAQECAQcEFAEBAQEBAQEBH?=
 =?us-ascii?q?hkFDhAnhWgNhgQBAQEBAgESFRMGAQE3AQQHBAIBCBEBAgEBAQEeBQsyFwYIA?=
 =?us-ascii?q?gQOBQgaglyCKwMOIwMBm0sBgUACiih4gQEzgQGCCQEBBgQFsBYEglIJgUgBi?=
 =?us-ascii?q?AgBhTmETScbQIFNgViCaD6CYgKBYoQSgi6JR4VABQIygiaDMiqJRiqBCAheg?=
 =?us-ascii?q?Wo9Ag1UCwtdgRGBKIEdAgIRORNHcRsDBwOBAhArBwQyHQcGCRYtJQZRBC0kC?=
 =?us-ascii?q?RMSPgSBZ4FRCoEGPxEOEYJEIgIHNjYZS4JgCRUMNU52ECsEFBiBFARqBRoVH?=
 =?us-ascii?q?jYREhkNAwh2HQIRIzwDBQMENgoVDQshBRRDA0gGSwsDAhwFAwMEgTYFDx4CE?=
 =?us-ascii?q?BoGDisDAxldA0QdQAMLbT01FBsFBGZZBaB5gkyBMYEwLU5LGcQ1CieDZKE7F?=
 =?us-ascii?q?4QBjG6YcC6XCHejEg6EfAIEAgQFAg4BAQaBYzqBW3AVgyJSGQ+OIAwNCRaDQ?=
 =?us-ascii?q?I95dgI5AgcLAQEDCYhuBIJWAQE?=
IronPort-PHdr: A9a23:unqApB3jjF8GSkYDsmDPZ1BlVkEcU/3cNwoR7N8gk71RN/3l9JX5N
 0uZ7vJo3xfFXoTevupNkPGe87vhVmoJ/YubvTgcfYZNWR4IhYRenwEpDMOfT0yuBPXrdCc9W
 s9FUQwt5Gm1ZHBcA922fFjOuju35D8WFA/4MF95K+nvE5LSiOy81vu5/NvYZAAbzDa4aKl5e
 Q2/th6Z9tFDmJZrMK831hrPrzNEev8Dw2RuKBPbk0P359y7+9ho9CE4hg==
IronPort-Data: A9a23:1atgW673Wq7EL98oqSUEXwxRtPHHchMFZxGqfqrLsTDasY5as4F+v
 mYcDT+Oa6qNa2GkKt8lYNu/8h4CscLQzNNlGgA6+XtnZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyKa/lH1dOG58RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wq+aUzBHf/g2QvajNNsvrawP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoZWk
 M6akdlVVkuAl/scIovNfoTTKyXmcZaOVeS6sUe6boD56vR0SoPe5Y5gXBYUQR8/ZzxkBLmdw
 v0V3XC7YV9B0qEhBI3xXjEAexySM5Gq95fZLlea6O+ZlnTfdnvc8tReD10oGrMXr7Mf7WFmr
 ZT0KRgEahSFwumx2r/+E7MqjcU4J86tN4Qa0p1i5WiGVrB9H9aaGOOTvoMwMDQY3qiiGd7Sa
 scDYCZvazzLYgZEPREcD5dWcOKA3ySjK2cH+QjKzUYxy2H6/iko0JbNCsvYStiue+RnuW3Cm
 n2TqgwVBTlDZIDAllJp6EmEgu7JgDO+W48IErC83uBljUfVxWEJDhASE1yhrpGRkVK3UdZSA
 1Ib9zBorqUo8kGvCN7nUHWFTGWstxoYXZ9bFPc3rVjXjKHV+A2eQGMDS1atdeDKqucoShMPj
 3yDxurwADxfgZylSm6D0Ymb+Gba1TcuEUcOYioNTA0g6tbloZ0ugh+ncjqFOPPu5jESMWyuq
 w1mvBTSlJ1I1pZajfXTEUTvxmPy+MSUEmbZ8y2KBgqYAhVFiJlJjmBCwXHf6ftGRGpyZgbc5
 CBe8yRyARxnMH1gvCWJRONIF7az6rPcanvXgEVkGN8q8DHFF5+fkWJ4vm4WyKRBa5lsldrVj
 Kn74lg5CHh7ZyvCUEOPS9jtY/nGNIC5fTgfatjab8BVfr96fxKd8SdlaCa4hj68zBNzyf9kY
 8zBLa5A6Er274w6nVJaoM9DidcWKtwWmQs/uLiilU38iOrCDJJrYe5baADmgh8FAFOs+VWJr
 Ik32zqiwBREW+q2eTjM7YMWNjg3wYsTW/jLRzhsXrfbeGJOQTh5Y9eImO9JU9I+xcx9yLyXl
 kxRr2cFkjITc1Wdd1XTAp2iAZuyNatCQYUTZ3R8YQ7zgiF7PO5CLs43LvMKQFXuz8Q6pdZcR
 PgecMLGCfNKIgkrMRxHBXUhhOSOrCiWuD8=
IronPort-HdrOrdr: A9a23:Em56qaEZFltshXUapLqFrZLXdLJyesId70hD6qkvc203TiXIra
 CTdaogtCMc0AxhKU3I+ertBEGBKUmsjKKdkrNhTYtKOzOW9ldATbsSorcKpgeQeREWmdQtqJ
 uIH5IOb+EYSGIK8/oSgzPIUurIouP3jJxA7N22pxwCPGQaD52IrT0JdTpzeXcGPDWucKBJbq
 Z0kfA33AZIF05nCPiTNz0uZcSGjdvNk57tfB4BADAayCTmt1mVwY+/OSK1mjMFXR1y4ZpKyw
 X4egrCiZmLgrWe8FvxxmXT55NZlJ/K0d1YHvGBjcATN3HFlhuoTJ4JYczAgBkF5MWUrHo6mt
 jFpBkte+5p7WnKQ22zqRzxnyH9zTcV7WP4w1PwuwqgnSW5fkN+NyNyv/MfTvLr0TtngDi66t
 MT44utjesSMfoHplWk2zGHbWAwqqP+mwtQrQdatQ0sbWJZUs4QkWTal3klTavp20nBmdoaOf
 grA8fG6PlMd1SGK3jfo2l02dSpGm8+BxGcXyE5y4aoOhVt7ThEJnEjtYcit2ZF8Ih4R4hP5u
 zCPKgtnLZSTtUOZaY4AOsaW8O4BmHEXBqJaQupUBjaPbBCP2iIp4/84b0z6u3vcJsUzIEqkJ
 CEVF9Dr2Y9d0/nFMXL1pxW9RLGRnm7QF3Wu4xjzok8vqe5SKvgMCWFRlxrm8y8o+8HCsmeQP
 q3MII+OY6rEYIvI/c+4+TTYegkFZBFarxhhj8SYSP7nv72
X-Talos-CUID: 9a23:RT1Nh203MhtF6NCev51AQLxfBM8KVyT+xi7pOkq4OVdIeL6JV3iu9/Yx
X-Talos-MUID: 9a23:jD0pHwvYFJcmRfMW/c2njRhQEZ5ozYSUGU09lbE4mvujHnZMJGLI
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-12.cisco.com ([173.36.13.134])
  by alln-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 13:17:50 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
        by alln-core-12.cisco.com (8.15.2/8.15.2) with ESMTPS id 38BDHoKn005263
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 13:17:50 GMT
X-CSE-ConnectionGUID: iIZuuLCYR/2y6pG69fq9ug==
X-CSE-MsgGUID: csUfYnfLSzuiR4tXBzw91Q==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=deeratho@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.02,244,1688428800"; 
   d="scan'208";a="1133391"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by alln-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 13:17:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqWlrEI/Nj1rrQHYugyqaifWTwB87/KuOK7OqM8Hjie+XYUh1bAVdxdxD6CISPWYPvANE40VasDQ8T935oOd2w8rEiB/mAOsWDOoREvzzVaGoBeMJCCW9RocMESdRv2DvTKPh8quRHN9ixjG3y+uc2i1+j2+Bo+5lzzZbLw+jPU5OIybTHcMaOFaFH6ZAAPOv86NSzUj39z8HOBvXUTXHwHTaWL/cstCN9CDZF+lWLkaFm2UEYIwCvfqMO3FeAZGQ+31TQODSVHEWQLpkn9+MqK3FS851AhtiTRYy0oOduo4hP/6j3851KoHtVIRtXIHyaKsuYYHxHmu5i5NLk+8CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FupnPpJTqOlBNhk0YNkMjttFrmWjLDbFjTr5G9Q8So=;
 b=J1nR3a95iIhffKyzhlHDDQw1tHfl1cGwzj01bgjglXCnVCXq2civSbyarRslkbmJfGsIYV+3/dE6krpCfRbgm2RCqPJkklNFg3x/hSRLZEHsV38Gju0vFV8PqBdigUAHJWeaR/oZkhP0DI8qlzPJ3XM5KC484Eew81k/hml05LH1AVIBgbBkxUwnAwZMFQFn8sIk4A7fcilovrtmhnsetjiGRFAtJU4O80UgprcPzjxhwq9lfycpMt6QtsXpBFCydcSI4nLPA6WG21cZRcz+uf/kG1cm5F2stqO7vvu1KaAfnXnk1JkqmKV/dpJ69MsYBkqaN2rZVUzFnQ2JuGxZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FupnPpJTqOlBNhk0YNkMjttFrmWjLDbFjTr5G9Q8So=;
 b=D4D2JkIYErWBjDngr9VD8xLmRxMaABoxPAnCr7YVjpts021V2IWu7AtfW0QcgRknQpPYg18Zcg7LHvjyqozTUHHD9PQ7jJksiWbhY6v6PLOjhwyiF3Flnr2eA/aL0qXiM640DTGDbYelkf6IvXOefIwEALyxUwJLva/EGhT9qTM=
Received: from DM4PR11MB6189.namprd11.prod.outlook.com (2603:10b6:8:ae::18) by
 MN0PR11MB6134.namprd11.prod.outlook.com (2603:10b6:208:3ca::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.31; Mon, 11 Sep 2023 13:17:47 +0000
Received: from DM4PR11MB6189.namprd11.prod.outlook.com
 ([fe80::9b29:81ff:3783:1740]) by DM4PR11MB6189.namprd11.prod.outlook.com
 ([fe80::9b29:81ff:3783:1740%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 13:17:47 +0000
From:   "Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco)" 
        <deeratho@cisco.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in
 btsdio_remove due to race condition
Thread-Topic: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in
 btsdio_remove due to race condition
Thread-Index: AQHZ4LvcJrVsnoRBq0W95V9qrz7orbAUiIIAgAEW5tA=
Date:   Mon, 11 Sep 2023 13:17:47 +0000
Message-ID: <DM4PR11MB61891026BF701EB7254CECF4C4F2A@DM4PR11MB6189.namprd11.prod.outlook.com>
References: <20230906121525.3946250-1-deeratho@cisco.com>
 <2023091012-python-image-6f03@gregkh>
In-Reply-To: <2023091012-python-image-6f03@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6189:EE_|MN0PR11MB6134:EE_
x-ms-office365-filtering-correlation-id: 7913af98-c5d8-442b-93a8-08dbb2c97dd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IbLKrV56dMohS4UryQ1zp4MQsunCv9OQGGKnMuRgajPely8x7Yts4Ppzqb96qGugqTgAdVCI17QaERRFyld1vSOrTyCUCzHP847GpaHzz4sxaXz9JXNujFg/jlB5/2X9x3914QKoszTXiWR07A762U/rfYN002Mj0+Z4xzFSOTwjnV9y4Yaj404AnhQFAXl+bHzVwvYH9sUglgmKmDl0vIE+E883l1sSeHAGZ3SKYrUTKDJYmduJ4xt51MnlUx9GUSRD5XtFUhMXKxv1XuLz+EBBc2MC8MAGlAOoMpCyWqNp4t2115y4To87XklMGRU90bnc//LAbj4DM8cMmMhTI1N/io8LIrR6U6lIUu179+NbDp1arbid+AcZxoXGP58ha0l5W4WeK76PyD/aOltTCjlRWNDtMKW3TTP0SwI84oJnSQ5UphYroQPddXhFURyi+nHQ1FHPuNxoJISbL/4JjQ/q3lvRi3ICqXKe2/dQtuMukgdBNo1AxGOcC6N6TLCe4neQi5GF9oYNClW6g8psm5Ywce/p4wGuhVhcM7AclopZLuYaltHQnKSYba7jAi384UAvS7ED5CsZX6Rj/Sm3bK5/kkTKNfrs3u+sSrxMIXMNzpHKtr5qg/8JEIOFuaLE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(1800799009)(186009)(451199024)(6916009)(71200400001)(316002)(66946007)(64756008)(66476007)(54906003)(66556008)(66446008)(76116006)(9686003)(53546011)(7696005)(6506007)(41300700001)(478600001)(4326008)(8676002)(8936002)(52536014)(5660300002)(33656002)(38100700002)(38070700005)(122000001)(55016003)(83380400001)(2906002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qJLGzfZDrWoIL3q0jyrdzdc8sf0vpfXbh9rNIHAltGvZPZ+U6BKQ/xblhKXQ?=
 =?us-ascii?Q?2QldrrE5zlDzAm/oCQnASWIp/N5rT4s0lpdG+NDnCfQXrpgHSSqJoe3ESr6A?=
 =?us-ascii?Q?Bb3qHJss1aPyA3YFjhlekJW6rwVvzeZB1URqFB6vaK6tzrZV3gjPnG4H8Njo?=
 =?us-ascii?Q?dr9amI976s+7YrxCQht6wlVqQbiU2by7fnTdmg5oJe0ZVXaVSPxhc11BXJu3?=
 =?us-ascii?Q?16BwShuBOxnu8/yFF//i+0BqCd7YQb9cZ1ibLGqcTy6NEBTzRpjBvwbrtVS7?=
 =?us-ascii?Q?IcPNf/n5nNndPIOvkKmjorWWc35+2R+E3xe3icADIvhX349eYSOO8NXLRLb8?=
 =?us-ascii?Q?fZR+auRtfi2cjvIupnezo3B9BWFXLo6w/uADq+0AEjuC0+dgXJ4bpKXppH/v?=
 =?us-ascii?Q?Cain8oVomOXRp+FK1x7NrsgOn6AnvY0EkBtu4jl6+A7jIaololrO3DyFM79M?=
 =?us-ascii?Q?kGEcou0wCw8Gw2IwYEWYjvZUAAIj0NxgkRO+gmPuaJcY1d3oDxRgBS14j8y9?=
 =?us-ascii?Q?4+ESWjm6H2AyL5goiEJGaTumsrdcTAUImoU5vv0BxKY/vVOVqb3vT6oIED4w?=
 =?us-ascii?Q?ces09a5n7SCK5JnpRKzpuoSehXim5Je8QKcCi4v53kaEJhwlP7s73F14RuuN?=
 =?us-ascii?Q?qEbbNU1Yq7+SuRRpnH6/2Ca60N2e9+lLJR95lzVxAONcZbLdn5X9T6YpLHtR?=
 =?us-ascii?Q?vtzs+PcS6F+0IioFpRihjXNH4/RTRaTp/hs//EGt5wWvDquRr+sATgvUB6qu?=
 =?us-ascii?Q?L15tB1j1zmp4bgYHisflELZHFVPoNMff+rGxPm+kNUYjzxEC9BwUvEW7WVW9?=
 =?us-ascii?Q?wErxW4acobRKYnePRX+wdtJIZ8tN5Ql7Q3w0OfE6cna/BXAm2AvcOUrr9E7N?=
 =?us-ascii?Q?nAnY5o0eW5IJk9CdZ4ae4AEaj8y5Q5s0QzL9gEQTY85A5Y863e/ti5wFLFYX?=
 =?us-ascii?Q?Djj0T9ILYjAO1/ut0CHQlLgaiNeH2EJJM8d3ovW2UBZOvNYh8i469cpM2QX4?=
 =?us-ascii?Q?1VyLnCpz1dHMgwYemV65yfMZ7rAbie8IqMUf2kyEsDWHuZCRdICS2T9ZfAfT?=
 =?us-ascii?Q?WlFiNFsmrNIRgnn21aAbhMTALmqceGN9S/25WQ1UU7SmEFBO4U8piypCUjc/?=
 =?us-ascii?Q?2+yyGslKQqwgn9HvHW+5n3C0BTMQBclk+BqBFRSI8n/4fAoKmcp1kCoJJfwQ?=
 =?us-ascii?Q?rXF8/pt7Xy0HyDGkXUFOAWOSnyuZs53doOZNrv7sRFmT1cnAq85lP0SuADmu?=
 =?us-ascii?Q?piePQKlqYdoiAcIV1nnCW/LUJOI/tOW5OWbSrBRzuSwcpV/Ks8b6CiETa+eE?=
 =?us-ascii?Q?LHATxGdKeF4cE6LX5pOTSySep5Ydj+Zw2d7CjKZWskr8WYXygjj3jr2/2fhu?=
 =?us-ascii?Q?m5J1W/A/RGIWclu4xAASm0ervsLxrEf612OPZ797WNKGM7JEmo9WBGqV9Im4?=
 =?us-ascii?Q?rpVOL6OKY/zQd7Vkp+Sc3AFynMnH+LMZLKrAr9ki0OwvpMokuVgMDeLC9vvd?=
 =?us-ascii?Q?993YFW9CQa99Xdj1EdOzDmh+57pUR/z2uWQpXhgQGSEyzyrzKv2GMnEVElN5?=
 =?us-ascii?Q?EutN86Z08DrGet57H6jahJgWlvIYuG95llgJbqMGqMFMTQRct9iCFYKu+G2o?=
 =?us-ascii?Q?Rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7913af98-c5d8-442b-93a8-08dbb2c97dd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 13:17:47.1929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZziDzy7svqoaSw6QJdq2oynGH3hxijm1OORWhCGucQZffX2/7RMbww/KsSESGI4za2+65t4Ru+h7YF90scFHDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6134
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: alln-core-12.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>=20
Sent: Monday, September 11, 2023 1:56 AM
To: Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco) <deeratho@cisc=
o.com>
Cc: stable@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in =
btsdio_remove due to race condition

On Wed, Sep 06, 2023 at 05:45:25PM +0530, Deepak Rathore wrote:
> From: Zheng Wang <zyytlz.wz@163.com>
>=20
> [ Upstream commit 73f7b171b7c09139eb3c6a5677c200dc1be5f318 ]
>=20
> In btsdio_probe, the data->work is bound with btsdio_work. It will be=20
> started in btsdio_send_frame.
>=20
> If the btsdio_remove runs with a unfinished work, there may be a race=20
> condition that hdev is freed but used in btsdio_work. Fix it by=20
> canceling the work before do cleanup in btsdio_remove.
>=20
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Signed-off-by: Deepak Rathore <deeratho@cisco.com>

> Meta-comment, are you SURE you want this applied?  If so, why was it reve=
rted upstream in 6.4 in commit db2bf510bd5d ("Revert "Bluetooth:
> btsdio: fix use after free bug in btsdio_remove due to unfinished
> work"")

> What testing did you do that determined this should be added to the tree?=
  How did you come up with just this one commit to be requested to be appli=
ed to just this one branch?

> thanks,

> greg k-h-

Hi Greg,

Yes. I am sure that this fix should be applied to v6.1 stable branch. Our C=
VERT tool reported kernel CVE CVE-2023-1989 on v6.1 kernel and this fix is =
also missing in upstream kernel v6.1 as well.

In the reverted upstream commit db2bf510bd5d ("Revert "Bluetooth: btsdio: f=
ix use after free bug in btsdio_remove due to unfinished work""), it is cle=
arly mentioned that this commit db2bf510bd5d is causing null-ptr-def proble=
m and fixed bug by this patch have resolved by another commit 73f7b171b7c0.=
 I have backported same commit 73f7b171b7c0 and sent this for review. Pleas=
e see the below commit message of commit db2bf510bd5d:

git show db2bf510bd5d
commit db2bf510bd5d57f064d9e1db395ed86a08320c54
Author: Liu Jian <liujian56@huawei.com>
Date:   Fri Apr 14 18:30:06 2023 +0800

    Revert "Bluetooth: btsdio: fix use after free bug in btsdio_remove due =
to unfinished work"

    This reverts commit 1e9ac114c4428fdb7ff4635b45d4f46017e8916f.

    This patch introduces a possible null-ptr-def problem. Revert it. And t=
he
    fixed bug by this patch have resolved by commit 73f7b171b7c0 ("Bluetoot=
h:
    btsdio: fix use after free bug in btsdio_remove due to race condition")=
.

    Fixes: 1e9ac114c442 ("Bluetooth: btsdio: fix use after free bug in btsd=
io_remove due to unfinished work")
    Signed-off-by: Liu Jian <liujian56@huawei.com>
    Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

After backporting, I have verified the compilation of x86 architecture at m=
y end and it is success.

- Deepak
