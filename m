Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF9F7CC5D3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344053AbjJQOWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343637AbjJQOWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:22:13 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Oct 2023 07:22:09 PDT
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D1EB0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=462; q=dns/txt; s=iport;
  t=1697552529; x=1698762129;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5aAWebvPEcDpKtjwQ/nVVboltxcJGpq7ZDfeNGcav3g=;
  b=laUuwNkoH4rceT/HqBEn1RLH0veAw975gBqe+g3Gdd6qpJy3tv1D9vSD
   ji4IsPZMjT0y7VPaXr5laULw/mFPB0OGCwhoiP7L4FFa3r53nCNenIXiO
   0CjLQnwp0Br4L6yehn40osaEvtBajOjK+jtJT/6u1HL/wOaFPNif0sQMg
   Q=;
X-CSE-ConnectionGUID: UCloXBs5Rw2ZxcFC8Km0sQ==
X-CSE-MsgGUID: lF/varPLT6Gpqhln2as8oA==
X-IPAS-Result: =?us-ascii?q?A0CHAABuly5l/5ldJa1aHQEBAQEJARIBBQUBQCWBFggBC?=
 =?us-ascii?q?wGBZVIHcVsqEkiIHgOETl+GQIIGIIV6jF2LJIElA1YPAQEBDQEBRAQBAYUGA?=
 =?us-ascii?q?ocRAiY0CQ4BAgICAQEBAQMCAwEBAQEBAQECAQEFAQEBAgEHBIEKE4VoDYZNA?=
 =?us-ascii?q?QEBAxIoBgEBNwEPAgEIDgoeEBAiJQIEDieFOwMBp1UBgUACiih4gTSBAYIJA?=
 =?us-ascii?q?QEGBAWybAkYgTABiAkBigYnG4FJRIRAPoJhAoFghkODdoU9B4JUg1mLBF4iR?=
 =?us-ascii?q?3AbAwcDgQMQKwcEMhsHBgkWGBUlBlEELSQJExI+BIFngVEKgQY/Dw4RgkMiA?=
 =?us-ascii?q?gc2NhlLglsJFQw0TXYQKgQUF4ERBGofFR43ERIXDQMIdh0CESM8AwUDBDQKF?=
 =?us-ascii?q?Q0LIQUUQwNHBkoLAwIcBQMDBIE2BQ8eAhAaBg4nAwMZTQIQFAMeHQMDBgMLM?=
 =?us-ascii?q?QMwgR4MWQNsHzYJQgNEHUADeD01FBsGZ51BnHsBrnYKhAyhaINbARKMcph2m?=
 =?us-ascii?q?DyoJQIEAgQFAg4BAQaBYzyBWXAVO4JnUhkPjiCDeI95djsCBwsBAQMJi0oBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23:FWX9ExR9epplw2F3zf7HymJ0jdpso3PLVj580XJvo6hFfqLm+IztI
 wmFo/5sl1TOG47c7qEMh+nXtvX4UHcbqdaasX8EeYBRTRJNl8gMngIhDcLEQU32JfLndWo7S
 exJVURu+DewNk0GUN3maQjqq2appSUXBg25MAN0IurvHYuHg82x1u225JT7aARTjz37arR3f
 126qAzLvZwOiJB5YuYpnwLUq2FBffhXw24gKVOIyhD74MrxtJI2+CVLsPVn/MlFOZg=
IronPort-Data: A9a23:OLT3O6/WKi9Akco4HO1ZDrUDPXyTJUtcMsCJ2f8bNWPcYEJGY0x3n
 2MfWW6POKqJN2HyKYp0Od/gpx8D6pCDzdRlTlQ9pCpEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEzmB4E/rauCxxZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4upyyHjEAX9gWUtajtLs/jrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dgJtb
 7+epF0R1jqxEyYFUrtJoJ6iGqE5auK60Ty1t5Zjc/PKbi6uCcAF+v1T2PI0MS+7gtgS9jx74
 I0lWZeYEW/FMkBQ8QgQe0EwLs1wAUFJ0ILsJX+Pm9fO9VKcQWvn7d4+L0RuJrRNr46bAUkWn
 RAZACoGYhbGjOWszffhDOJtnc8kasLsOevzuFk5kmqfVqlgEMuFGviRjTNb9G9YasRmEf/YZ
 scddjNHZxXbaBoJMVASYH47tL722CGgK2EG8jp5o4IzzS/NxRZJ9ISzH8LMetiMH8xOzkGx8
 zeuE2PRR0ty2Mak4T6E9G+8w+zChyX2XKoMG7CisP1nmluewioUEhJ+aLegieOyhkj7UNVFJ
 glOvCEvtqM1skesS7ERQiGFnZJNhTZFM/J4GOwh4wbLwa3Rizt1zEBeJtKdQLTKbPMLeAE=
IronPort-HdrOrdr: A9a23:aB7Xy6MrJfe5LsBcT7P255DYdb4zR+YMi2TDiHoBKiC9I/b5qy
 nxppUmPEfP+UcssREb9expOMG7MArhHQYc2/hRAV7QZniXhILOFvAj0WKC+UyvJ8SazJ8+6U
 4OSdkCNDSdNykcsS++2njHLz9C+qjFzEnLv5aj854Fd2gDAM8QinYcNu/YKDwIeOAsP+tAKH
 Po3Ls8m9PWQwVtUi3UPAhiYwHrnay4qLvWJTQ9K1oM7g6IgTm06Lj8PSS5834lOQ9n8PMJy0
 SAtxb2yJmCnpiApyM00VW9071m3P/ajvdTDs2FjcYYbh/2jByzWYhnU7qe+BgoveCG8j8R4Z
 zxiiZlG/42x2Laf2mzrxeo8RLnyiwS53jrzkLdqWf/oPb+WCkxB6N69MZkm1rimg0dVeNHof
 t2NlGixsJq5NT77X/ADu3zJldXf4yP0CAfeKAo/iFiuMAlGcxsRMQkjTZo+dE7bWDHAERNKp
 gwMCkaj8wmLW+yfjTXuHJiz8erWWl2FhCaQlIassjQyDROmmtlpnFoifD3s01wv67VcaM0rd
 jsI+BtjvVDX8UWZaVyCKMIRta2EHXERVbJPHiJKVrqGakbMzaVwqSHr4kd9aWvYtgF3ZEykJ
 POXBdRsnMzYVvnDYmL0IdQ+h7ATW2hVXDmy91Y5ZJ+prrgLYCbfRGrWRQriY+tsv8fCsrUV7
 K6P49XGebqKS/0FYNAz2TFKtFvwLklIYQoU/oAKiSzS5jwW/nXX8TgAYHuGIY=
X-Talos-CUID: =?us-ascii?q?9a23=3AsenQX2nboWmhbUmZapDYUD0/OwDXOUD2yHDgCVT?=
 =?us-ascii?q?lM3kzeq2eZ3TA26Y8iPM7zg=3D=3D?=
X-Talos-MUID: 9a23:cCNnWAn5LIru1H1Ww6O3dnpmGoB26r6WLHxTvo0fu82CbyVrazC02WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by alln-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 14:21:06 +0000
Received: from rcdn-opgw-2.cisco.com (rcdn-opgw-2.cisco.com [72.163.7.163])
        by rcdn-core-2.cisco.com (8.15.2/8.15.2) with ESMTPS id 39HEL6NQ027071
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:21:06 GMT
X-CSE-ConnectionGUID: tfJpBOipQKSVv8/3Kimb8Q==
X-CSE-MsgGUID: 2CH32QnOQ165c4yWxazKUQ==
Authentication-Results: rcdn-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=danielwa@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,232,1694736000"; 
   d="scan'208";a="5044469"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by rcdn-opgw-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 14:21:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gdq2bOP92J4vYyrz18fOtqxQWwwvdedWwmhXE5pGzga7QZpjMnpVaVQBWexN2/EZZehr6IWFB/nac1Kd5QQAQBJJTvLCDHg0SWvsma8sOWsIPnWJzLZy59HVjRlloE1Zvv1SOvKpCod1DLsXRPTHO/5uIWB4OUuxhH1dbSXDfQYFdI/qtHTHM2MzvA0A9kzVHUoOYnvHvg7MiMQC7IEXVDjO4alAhIERfzeTN4DcJPN/SyJbLoB0pF0mOmCy4DInnbG1eaDk99zDkEXzQRTlUEd1nYZUre6vIPVxNjPzQH6NZIA8cvEJVtxA4wwKUfEr/6gd2AGy5O6HwJiiq4J9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aAWebvPEcDpKtjwQ/nVVboltxcJGpq7ZDfeNGcav3g=;
 b=QaHRgmWFKkeQR1K/7p6W3HWKF+4qPz8IewG0ti9mWMn9isVdlOtW5vPIHGw+PQN53gsDsdZvKaWH+E0PUbWU/u6dM7PCDdwZjzhXLFJz7QmRUucFlznfc01+7+uYXTEg3fmjaG87/zqRpWjaHaxXM4E1AYoC60rxTYizW9l4BuYfbvJeOxI7VCcKRwQB05uY2tUAXN3DknefjvKxdGR+EV/zy3+nSFUl9Rp3GkA3Z/CMlW7kkROtR9BNQtyIBTiUHVAKLc5KiP6ifyKjz/MEFYCZwVtDcYN2a6AXCHqRPAoBI6VD66BgQSJPp2A2hR4BYCWYH3EgQ4d799mezBTB7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aAWebvPEcDpKtjwQ/nVVboltxcJGpq7ZDfeNGcav3g=;
 b=dE+CC7p4L/bUj3nlL2sbiO1Is0tCqesCjljp4vLrq2ch0Yi3nPFMuVryw2Pm2nzBSTHFxY5TRszMbB3ZU5hs2oX+urSSklCdTvK+gWV4d8G89la3Hl1uMylNlxwtLERLPBIau5FWDRWdcGvqN7bpdLYRTexh/Q2WPjjk51QxbXM=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by PH7PR11MB6859.namprd11.prod.outlook.com (2603:10b6:510:1ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 17 Oct
 2023 14:21:00 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::b8f8:71:8478:2d51]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::b8f8:71:8478:2d51%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 14:21:00 +0000
From:   "Daniel Walker (danielwa)" <danielwa@cisco.com>
To:     Pratyush Brahma <quic_pbrahma@quicinc.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>,
        "dwalker@fifo99.com" <dwalker@fifo99.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "maksym.kokhan@globallogic.com" <maksym.kokhan@globallogic.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "tomas.mudrunka@gmail.com" <tomas.mudrunka@gmail.com>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        "quic_guptap@quicinc.com" <quic_guptap@quicinc.com>,
        "quic_vjitta@quicinc.com" <quic_vjitta@quicinc.com>
Subject: Re: [PATCH 1/4] add generic builtin command line
Thread-Topic: [PATCH 1/4] add generic builtin command line
Thread-Index: AQHZcUkOD6ppc7o7REqMkKuIthkl5Q==
Date:   Tue, 17 Oct 2023 14:21:00 +0000
Message-ID: <ZS6YIjZznHMojNLO@goliath>
References: <20230417162415.GF1391488@zorba>
 <4c420081-fe57-d036-ded7-2899c13738ee@quicinc.com>
In-Reply-To: <4c420081-fe57-d036-ded7-2899c13738ee@quicinc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|PH7PR11MB6859:EE_
x-ms-office365-filtering-correlation-id: 785d98e9-1200-4c43-d199-08dbcf1c49e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7+S+6f3sK9SWw+zpkBElQVK0TD7OQ+ebTv2H3QDynCnLPiHPy2KXav87IIB3H+EhMsYvKc3MNATemJxfQqORcVxMbpOliSwhAYv/AfqmXmU9qOrWqhIStb+VTfAMreGgK79cRAuA03ijGtj4hg+7XjMAvJxIWKU89CxZqhlpkotRU9HYun5LvyM1dTCxwXdif1DnMdZboqAlonj5LnNq/lYI9ARm7QdBLMxF2K20VmxNVhFfPU1/eG080YrQP7zikEtfi9HYk431w8/aKGFaw6XAdscutAMSoHXi8RVkmieP1JWYbmS9L0Y25gbZcf29iQHMzShjISdEMNAbZb1SCCkxneppMDhjA15a2umrsGwzuykYsxfT/prkfUUvopA6Yys/fYWv0XDJLvbfYNZuYizj3VqMRx14ffuWd8+JFk4Dhq4LQmYLg2Fth6KWsPk8ANiSCD+fWSd3bRvo2CkdfefHrZT7J+idvHcG/eZ+sW6wdtt7Yle16JhojqptN/fi7KjH9goV1Gpo1/YCPcuc6S0LhjFn09A+49TipgOGUNlS51UKYqgpnG/d/1+Ztejf5YXWmK6BVgUZtLvXy2FUQfs8673fJSfVI/JGIImPu4IlATOpdxXFdBssO+HwSiaTClNjvmzV/nCQsRu7/o0clQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(136003)(366004)(376002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(122000001)(33716001)(316002)(6916009)(66556008)(66476007)(66446008)(64756008)(54906003)(66946007)(26005)(76116006)(71200400001)(6506007)(478600001)(6486002)(38070700005)(9686003)(6512007)(5660300002)(41300700001)(86362001)(7416002)(2906002)(4744005)(83380400001)(4326008)(8676002)(8936002)(38100700002)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NdjEyNsNGxA/3hf9Iz+NuOFTC17RnTPudrU3BRbMo6eXbvLWMZM83Fn+aaKK?=
 =?us-ascii?Q?GPdgBJdmhjqkG0muoxCLZA36z8iir9ehV7WKYvy+ZYxRdXpd1VeCbU4JzxyW?=
 =?us-ascii?Q?h4ImCdc8yrCEI0X1MGDSqICEkyHKroM63flBB9Jm0xL/Oo2gSvLIQk4rJe0M?=
 =?us-ascii?Q?Eo8qshB5xr/msGOQ/JfZlOzJ0mt0IFwCeArEoOx5m8zkk0RNUWIeIt7CC3CK?=
 =?us-ascii?Q?v1zTLZvFlpQgZq0Ipre/dnDYw0ywA3xu5Uf0Ck3lJbqe3ny/kELQLRcLKSFN?=
 =?us-ascii?Q?uPYxQ/tYRqEq+vB163z57Ds5xPUAzoMdKF8E6Xm1gT527wODlWhzYY3ebmO0?=
 =?us-ascii?Q?7Mq9I8syPSUAifzRNBKfXgXtXPPdJKO6Un31KXN+bbkwJGyzWxZJjDu8xIyV?=
 =?us-ascii?Q?yVpESCrrdbTlaKgdbCa6pghm6Fay3bYVLWsO8Hf1DcU7e9RGaVc0DI6KxmKn?=
 =?us-ascii?Q?I8CHWaB9p1d3D76oPYFLPQ5VWKR15Xcr20CZkUrzAORyCvf+kyR9BgUOvl+L?=
 =?us-ascii?Q?xXXKdf2fJEQKu8YyBL1EdQJvxzzuf7iIU/09qbgqMZNJTmGpNtS+fAy9Yg73?=
 =?us-ascii?Q?qswoaeeJps2kNhdhuR9gsLITc/D6kqHQBd3oiKduoCYW639nXqhjWgFfWm0Q?=
 =?us-ascii?Q?ItkTCFNMCcxvENLB0ODaTWPLqG4Qvxj3Ud21hNzer0qgqdAkqXkbDAMY/6N2?=
 =?us-ascii?Q?EB30o2AZKwo4xTnYJ7ekKIi5pOyPFH2MxuVafn9Rf6roTIaFrSzr4oE1KHRk?=
 =?us-ascii?Q?kVqZMjr7ZFshWiqV63qs7DupC9EPV+MP5AfDMXzJiGgD8mWKMUKPBMuZwSYA?=
 =?us-ascii?Q?o7M9Iez76/byuqj50/I0+xj6FrdZbi4Nhj4BeEWyJWJ/YaR/Gm41i4k6jCE/?=
 =?us-ascii?Q?weLwdMrY0d4UfyzeG50QqE40vs+RVnrCpwFVEiHMuweaQIQgLQac3vVA2ZV9?=
 =?us-ascii?Q?dvLUXsgUxwtZwGJP2bqVq0QGnxpaUrlbNp+emhJopUJcSmWcCpgQQk6gIzmm?=
 =?us-ascii?Q?oAuKbgnXw8NFXMhnWdUiEn33Yf3GY9EP6uvI3+swrV7CtPC31JunzvkYTJvJ?=
 =?us-ascii?Q?+YbFI6+MSqQLAs/x0njcxPa2zyisGAz60pwNAr72SQHmW0NwDn6xrhbwPwXj?=
 =?us-ascii?Q?qZ8Tp6P0QykLdViW/lcmorN0ptdn31RvidgbA0HZiKNTX2cTeli+nYcoIGhv?=
 =?us-ascii?Q?yPLC7C9oevsWpZu8be7po8kQXrXLMUi1VAreKGp2eWgSMcMjqtP5o6xQDpy8?=
 =?us-ascii?Q?RiBZW/ivH935E7xanjPWeCwKBDmhGxPJ9Yp5rf0AorzYaDHecMfScf5z+YQP?=
 =?us-ascii?Q?05huRFbIDDCq09P+XRMzaVpyWHeMVKudtIkF1L4E/PoPUkOtJoCoUYGFWhE5?=
 =?us-ascii?Q?+2lnFyhLkBXG7LkU8XvZM4FLYSZ75mQSyzI4YgNtxWzfktdmNOmZ8XpDv+pa?=
 =?us-ascii?Q?wv+wK9gSQswgwrT6WjbgSJCSNpKCX7B5Wnif++g603/qPoBsk0NB7Dt/kg7/?=
 =?us-ascii?Q?+ihGuYZMuv1kQcWQv4TITpf6lc3Jer8uP2WWh/+AYXrpW/1CHSFiEunzg28W?=
 =?us-ascii?Q?EjTiyGxUU65w/DWAh3GzEs8glO3ecpEZx8WLuwYR?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <38490A7D2F951C49A843CF2C73A85C03@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785d98e9-1200-4c43-d199-08dbcf1c49e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 14:21:00.8698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oFrNWFKQglYX0DsvdEcv5MUCviYzcSjIh+LzQbaFgEGH2621vQzwm2UPthZgBBeU07F9DdZOw05iLqpIaSIl4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6859
X-Outbound-SMTP-Client: 72.163.7.163, rcdn-opgw-2.cisco.com
X-Outbound-Node: rcdn-core-2.cisco.com
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

On Tue, Oct 17, 2023 at 04:10:42PM +0530, Pratyush Brahma wrote:
> For such a usecase, the CONFIG_CMDLINE_PREPEND seems to be quite useful a=
s
> it would help to stitch bootloader
> and the desired build variant's configs together. Can you please help to
> merge this patch?

Yes, your at least the second person that's asked for it, and it's been on =
my
list for some time to release again. I'll try to release it as soon as poss=
ible.

Daniel=
