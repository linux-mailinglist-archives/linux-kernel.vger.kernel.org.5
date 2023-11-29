Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989E07FCCDC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjK2C1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjK2C1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:27:04 -0500
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477FD10FC;
        Tue, 28 Nov 2023 18:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1189; q=dns/txt; s=iport;
  t=1701224829; x=1702434429;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=atvDzc1Sk45BorjT6XbmWa6to7sbNOOncArEcVF5nEo=;
  b=HEFBecPVMFhWfa11FfaQVjkSNhtOfuSS0jWrwOTkjwxz+o7bwgIngAhX
   cC8yYjGpbZX2Bsfj3gwNB2+a4gs78rcaqrhepRkCKJhQCM/mHk1c6heii
   z41XwkK94oxLP53HZXxASBacohCS+Yumxa8aqfoa/CNTd1ow4J86qYLB/
   Q=;
X-CSE-ConnectionGUID: F2ctxezhRWmXL0YWWcvIjw==
X-CSE-MsgGUID: OwFWZrF5SnWqoSzFdPPZGA==
X-IPAS-Result: =?us-ascii?q?A0ADAADqn2ZlmJhdJa1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQCWBFgUBAQEBCwGBZlJ4WyoSSIgeA4ROX4hjA51+gSUDVg8BA?=
 =?us-ascii?q?QENAQFEBAEBhQYChykCJjQJDgECAgIBAQEBAwIDAQEBAQEBAQIBAQUBAQECA?=
 =?us-ascii?q?QcEFAEBAQEBAQEBHhkFDhAnhWgNCIY9AQEBAQMSFRMGAQE3AQ8CAQgYHQEQM?=
 =?us-ascii?q?iUCBAENBQgagl6CXwMBomMBgUACiih4gQEzgQGCCQEBBgQFsm4JgUgBiAwBi?=
 =?us-ascii?q?g4nG4INgVeCaD6CYQKBJzuEEoIviSMHMoIig1GPR39HcBsDBwN/DysHBDAbB?=
 =?us-ascii?q?wYJFC0jBlEEKCEJExI+BIFfgVEKfz8PDhGCPys2NhlIglsVDDRKdhAqBBQXg?=
 =?us-ascii?q?RIEagUWEh43ERIFEg0DCHQdAjI8AwUDBDMKEg0LIQUUQgNFBkkLAwIaBQMDB?=
 =?us-ascii?q?IEzBQ0eAhAaBgwnAwMSTQIQFAM7AwMGAwsxAzBVRAxPA2sfNgk8DwwfAhseD?=
 =?us-ascii?q?SclAjJCAxEFEgIWAyQWBDYRCQsrAy8GOAITDAYGCWU0A0QdQAMLbT01FBsFB?=
 =?us-ascii?q?GRZBaM1AXoJChyBXTAXkyGDKI9nnxYKhA2hQBeqBZhAIKgLAgQCBAUCDgEBB?=
 =?us-ascii?q?oFjOoFbcBWDIlIZD44gDA0Jg1aPeXY7AgcLAQEDCYhugXMBAQ?=
IronPort-PHdr: A9a23:7tiyqB3ysbdTyTiEsmDPZ1BlVkEcU/3cNwoR7N8gk71RN/jl9JX5N
 0uZ7vJo3xfFXoTevupNkPGe87vhVmoJ/YubvTgcfYZNWR4IhYRenwEpDMOfT0yuBPXrdCc9W
 s9FUQwt5Gm1ZHBcA922fFjOuju35D8WFA/4MF92L/7pG4rbjOy81vu5/NvYZAAbzDa4aKl5e
 Q2/th6Z9tFDmJZrMK831hrPrzNEev8Dw2RuKBPbk0P359y7+9ho9CE4hg==
IronPort-Data: A9a23:Er1eU6mIc1SfKpV96xQx7mDo5gygJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIZUW+Oafzea2T0LtogPtiy/RkE6MKBzddjSQptrn08H1tH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaB4E/rav649SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+5G31GONgWYuaTtNsfLb8nuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSq
 zHrlezREsvxpn/BO/v9+lrJWhRiro36YWBivkFrt52K2XCukMCdPpETb5LwYW8P49mAcksYJ
 N9l7fRcQi9xVkHAdXh0vxRwS0lD0aN6FLDvDyK0rdye3U38TH7c561fM349I6wa5bMiaY1O3
 aRwxDEldBuPgae9x6i2D7AqjcU4J86tN4Qa0p1i5WiGVrB9HtaSGOOTuIUwMDQY3qiiGd7db
 tAFaD5mbzzLYgZEPREcD5dWcOKA3yWvL2EE+AvNzUYxy0/M4jNDypawC9zqY9uxV+tZpn6qi
 UuTqgwVBTlBaYTAkmDamp62vcfLnCXmSMcRGae++/pCnlKe3CoQBQcQWF/9puO24ma6WtRCO
 wkP8TEvhbY9+VbtTdTnWRC85nmesXYht8F4CeY27kSGzbDZpl/fDWkfRTkHY9sj3CMredA0/
 nHTlM/5CC5vioKQeVbFx4irpi2TOzdAeAfuehQ4ZQcC5tDipqQ6gRTOUstvHcaJYjvdR2mYL
 9ei8nBWulkDsfPnwZlX6rwuvt5BjoLCQghw7QLNUyf8qAh4f4WiIYev7DA3DMqszq7HFTFtX
 1Bdx6ByCdzi67nRz0Rhp81RRdmUCw6tamG0vLKWN8BJG86R03CiZ5tMxzp1OV1kNM0JERewP
 xeK4FIPvsEOYyvzBUOSX25XI5pwpUQHPYq9Ps04kvIXOvCdiSfepX4xOxbIt4wTuBJ9zv9X1
 WinnTaEVitCVv89k1Jats8W0KQgwWgl1HjPSJXghxWh2vz2WZJmYeltDbd6VchgtPnsiFyMq
 753bpLWoz0BC7eWSneMruYuwaUicCJT6Wbe8ZIHL4Zu42NORQkcNhMm6e98K9U/xPUEzo8lP
 BiVAydl9bY2vlWeQS2iYXF4Y7SpVpF6xU/X9wR1Vbp08xDPubqS0Zo=
IronPort-HdrOrdr: A9a23:mrd5uqpWtGTVnz3Y8CCM2uIaV5tuLNV00zEX/kB9WHVpm5Oj5q
 OTdaUgtSMc1gxxZJh5o6HwBEDhex/hHZ4c2/hpAV7QZniXhILOFvAt0WKC+UyuJ8SazJ8+6U
 4OSdkCNDSdNykcsS++2njHLz9C+qjHzEnLv5aj854Fd2gDAM8QinYcNu/YKDwIeOAsP+tAKH
 Po3Ls8m9PWQwVtUi3UPAhiY8Hz4/fwuNbNZxkACxQ76A+Iow+JxdfBeSSw71M1aR8K5a0t31
 TkvmXCi5lLtcvV9jbsk0voq7hGktrozdVOQOaWjNIOFznqggG0IKx8RryrplkO0aKSwWdvtO
 OJjwYrPsx15X+UVHqyuwHR1w7p1ytrw2P+yGWfnWDoraXCNXAH4ot69Mdkmynimg0dVeJHoe
 R2NqWixsNq5Cb77WDADh7zJklXfwSP0CEfeKUo/g9iuMMlGc1sRMokjQNo+FNqJlOm1Gjhe9
 MeVv309bJYd0iXYGveuXQqyNuwXm4rFhPDWUQavNeJugIm1kyR4nFojPD3pE1wv64VWt1B/a
 DJI65onLZBQosfar98Hv4IRY+yBnbWSRzBPWqOKRC/fZt3d07lutry+vE49euqcJsHwN87n4
 nASkpRsSo3d1j1AcOD0ZVX+lTGQXm7Xz7q1sZCjqIJ94HUVf7uK2mOWVoum8yvr7EWBdDaQe
 +6PNZMD/rqPQLVaM90Ns3FKu9vwFUlIbooU4wAKiezS+rwW/nXitA=
X-Talos-CUID: 9a23:b26dBm8mj8YXRLepLkmVv2BOEdw1f2/d9kjVE2vgOFlWQ6O0S0DFrQ==
X-Talos-MUID: 9a23:s5xwMQRGfiFqdIvWRXTLmx9dBt1Gvp+oN1kKqocot/G8BwNZbmI=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:27:08 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
        by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTPS id 3AT2R8vQ026797
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Nov 2023 02:27:08 GMT
X-CSE-ConnectionGUID: GMRQvVJQT1O8lcpFHskTnA==
X-CSE-MsgGUID: m6ayiMo7RveAQuxIgBV4mw==
Authentication-Results: alln-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.04,234,1695686400"; 
   d="scan'208";a="10512698"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by alln-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:27:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+i0HQt+BOvS/CTyKKadDDc1aV0Klqp/QP9lEu8fN7dgkD1KSNwW/aniM5Hc9qW26mLsP9Wzr6pQ6DkjlFwjITtrdV5jOaBYyQ1XnExuUnauJYyUnj5Sztn86Uqyib/Z3zbYo9EVhPhnzQrWEpwpUcS9iNg+pbF7GHH0MVxq23kFDASnFKuUE+GGfi+/LFgPdcnflV9wWOhwOfVzN4vczsVjXUT2vbqOMzPXR2iibGbrvvO6jGCHHMjn878WDUb/LNR7HIeLOzbokrlkxDBZUJ/GTXGV0bGzM8HL+sepc1ZnQmfdU0hZiHR9cBRvHS39NVjsm5oknx9aB0+JPjprdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M09gKwmnVM+OSTGGXESMBvzzbVQBEyWoa1BTjHXto+k=;
 b=eohxch/aVZvfnG/IDG9FV7qMKjU+kDRj4+C+We+qhBa9L0jFXE4xQHT7bJ/Dg/xLof1ItN2QS9NaloGwiZUJpKJ2pCoXLvtc+JdxV773ZcjU9efO5TNpNUDcpwOobN7ktwlyGkTBm//1vOH75FJ6na4idXiWqbrwn8LDmPfpmHxSuLFesWqpdxycE34+8KFfqnL++iMiUdvx6uHm3ABfNozPGwi9NkCH8A+i5AqpM6uTVD9P/FYTH1TvIaXtn4HczmIIfdIWhVKsuRtRYI6DHtiKQ2++IAthwfvyet8k4zTpjjXqi3ShUL9Hl0QgScV+0yg+kKrOyakeGbV+oZbCxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M09gKwmnVM+OSTGGXESMBvzzbVQBEyWoa1BTjHXto+k=;
 b=STHO+s/oSg6LyojGopCVnySkLeRkoPAPyBB1AqTWXCZ148dqsaataPp/x+B7jABgYX6zAwH1sneyxTR/Dphje+H2LQKEV/IdtI+lownE7knRlqwrnbP5EZq62+BR1Bs3an/Lgav2JytIb1Z37lK73u2tbMvTORKJXmgO3Qq01go=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by LV8PR11MB8462.namprd11.prod.outlook.com (2603:10b6:408:1e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 02:27:05 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 02:27:05 +0000
From:   "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To:     Artem Chernyshev <artem.chernyshev@red-soft.ru>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>
CC:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH] scsi: fnic: return error if vmalloc failed
Thread-Topic: [PATCH] scsi: fnic: return error if vmalloc failed
Thread-Index: AQHaIeuTqSz8Slaqd0GdEcptW/9HrrCQkN5w
Date:   Wed, 29 Nov 2023 02:27:05 +0000
Message-ID: <SJ0PR11MB58964B3A97175826216EA8D7C383A@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231128111008.2280507-1-artem.chernyshev@red-soft.ru>
In-Reply-To: <20231128111008.2280507-1-artem.chernyshev@red-soft.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|LV8PR11MB8462:EE_
x-ms-office365-filtering-correlation-id: f0b51486-a1ab-44b8-6e28-08dbf082ada5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gSsX2qK961NNhVBhF1W4qOMtZrEySuT1LD78NO/AH5UfPMVW3jDvm9FeaVybXsWeWm/IphV0ji81kJ+FPJ/d+vwMbu2L+a22jbbULZItcDi0/xR7co2PoKgC6zcD/HppxHJlyeWl/kl0HV9vBtXF3AIFPvWZRkjYDvOxbfMKGywAkyIrAol6PRFQ/Qov2yknQNvj28qAYctYPdgxnHG844Dhmckzm3N/zLeLkcVXT/8vLDC5SIvDziqTFFwNAsBvO4ESR7x1ud8JYhd1PEkB4J3Qvkauao2pheaoEqRJkRjE3CDi6wbQNbR4vbRWDkS1ouo3VZqWqigPxorNGKPepoP//znDkloCaZGEzENTWyAENpBqRs1E9eBIi+bfF2GUY3ZKsOFiQ1XrxVTLSLFed7EzvHXiXF1yF9e+xBXxKFAgMLmXFQiMk81QVmUNyuoKAoPPdTUlxlO+0h5TsnAZN12kte7RdFOfO/JAmcM7O/nzi4uAQgGD+Dgg5/Yv8qji6je9LmU3/5TqkSVtg1bWY4HnJDY0y1FOpcBRd/EykuunZUISmvfgUwjI31nhEcsH0Kv8z2vrwTJDneOAY638RiddEjORwqnsbNVBKEAjCn/Wc32HbQpcar2pCtXuP6BS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(55016003)(478600001)(8936002)(86362001)(2906002)(8676002)(53546011)(7696005)(6506007)(9686003)(71200400001)(4326008)(110136005)(54906003)(52536014)(5660300002)(6636002)(316002)(66556008)(66446008)(64756008)(66476007)(33656002)(66946007)(76116006)(41300700001)(122000001)(83380400001)(38070700009)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eZ9r5kuYB1VnYC5fXSO+gNcCHQLYGMLxoEr+fo+ZApxENikEJMY3kWx/pKDM?=
 =?us-ascii?Q?IAGzfd1kcEd0qwx0wvskWj6OLe8mxadx/qu1on/+QlWbMBNiSYzZENM4nLlw?=
 =?us-ascii?Q?b5Oi0jXUskn6GlPpbuso9OeV8rB/QeecHM81/4+rfuWWJQt2IwktHQNCPBRH?=
 =?us-ascii?Q?w6/IhLlTR8EUk4lkvIG/dkymi2u9YEAn21a5otL10pxthPh7TsmB/LJJynFw?=
 =?us-ascii?Q?/r54Cu9IWEjzRuQ/8CqNl73I53WtLeCU2NOBG/9/LUP0BbC/rLd8vrUK4s+2?=
 =?us-ascii?Q?GY7BcE51a73noD5HSHRj9nXT6QmQ+qaTkULszU6Yxey+APpcYNutUMnOM8+D?=
 =?us-ascii?Q?8/7xuwfB5fyyHNCJYSn6Z293y5MKs2tzfK3pY4c/h9eMiV7C8QG9j+ywcJ4i?=
 =?us-ascii?Q?xrB701oLXMRwdC1+lg60Z6cDM/Ri5p2tAb54Q7D135SeLtJddi2S3aSRCqEI?=
 =?us-ascii?Q?hMh3vDgQ3FY7V2Pp4033vfPcHb5+o2Sbcq9D6nLZZYeVU6xsZvikWMIMGS+F?=
 =?us-ascii?Q?x7XLTz5JLMs8ZqqQ+wwSgSNlruDLeRXEI21BjncgocxfGj4gTjdaMZocHMZN?=
 =?us-ascii?Q?uU0GZhQwvPA0UlwYkiK/O2LRspMJVf7sFg6nnZ2/lck9jAo+aXIpPtNrJVFH?=
 =?us-ascii?Q?9iRBclmsiOEwbh4YIT8x6D+P3lnoIwXiOxEtaVhdw3omp0gI22xjALrk92LP?=
 =?us-ascii?Q?ZsFQR0MPKlNGtcP86wZS1/e8ODtRwIgU8litRngVwh6aKcex7bbikXkGVeC3?=
 =?us-ascii?Q?UYU6eOAq6Kt6f8AcQovS7MAWXZ5yQlt4MSvYZmvEZK5RvZTHL99xPPG/syyu?=
 =?us-ascii?Q?IvqrSclxd8midgXi9ukaitWsXNiZ513lGKEQViJL0zBLoTkGD0oKPVAOXCjj?=
 =?us-ascii?Q?sNc79LVlaQKTMk3qMH1ogIjk+L4U+M6hdRqcliYX2MZFt7KJTcW9dqE1UCfj?=
 =?us-ascii?Q?Jd3um6MgcqrDab0AS+9vIPT4ZbDBjzZg2Yqk0n51r8aIk+tZ+KjJV0NjkiQv?=
 =?us-ascii?Q?Xva9mvPY4/DcOJI2aTaILJBUhxgiWPPp0cOHtNUSixnLacVAOIM3T1rgLhqr?=
 =?us-ascii?Q?zQJ6fuaV0mQiXe5bbjr+mv2pWyWmndF+3xZWcreFbwQif2V8QMWGaQ8OpFjH?=
 =?us-ascii?Q?bGBpiYcx30feDrV0868vrzSU90XLEfEbGFenfKpRx3T8gsBDB9bM8v/37QWw?=
 =?us-ascii?Q?yUkahVWKz7azm8S4j3DBmOW/Ud14mrmnD8jt1OjMQlZXQYkIXcy25mdeuiGY?=
 =?us-ascii?Q?OiGiNZBTKdvfAjqWnZpnvi0VeaUJ9vahrwE9ohpCXPP2aWt1KoIK3Bgc867q?=
 =?us-ascii?Q?OohXkjymIizFJ4VT13z7wWzJx/KdKqoDpY2pVi0Gq87N51Nr/PDeUIgzwsR5?=
 =?us-ascii?Q?2a9VYBT9nKtT6o4aft9wTP+wrUgcsbMbZo0AHtQ+p3O8xW1kG5iDHhaGIuKM?=
 =?us-ascii?Q?r6MUSoAoz8h8uOPNBZxiqTB/zTOqetPbwJsGFo8X9QSWoe8xqj10LPdW9a60?=
 =?us-ascii?Q?Em690Re01mJPjYAvixaEViwoU/k5RQojAoYkq/Rjse9oSuoF77xB1lKYzqGG?=
 =?us-ascii?Q?G0z/vAtz8dlfqXatezIgEW09nr1Nmt3hLeH/+AQoOuiDEqyGK+Ql22490N66?=
 =?us-ascii?Q?A7AC4eElsqamvHJl1uwvBWo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b51486-a1ab-44b8-6e28-08dbf082ada5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 02:27:05.2679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O4kJwbE7DdnpuykbisXrzL7Zkx7/BrV8Vt0USy91VCHJEx/zlrvyYfQtj8TCu2NwfPj/LhwtgpPeZaDtijFZkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8462
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-1.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, November 28, 2023 3:10 AM, Artem Chernyshev <artem.chernyshev@r=
ed-soft.ru> wrote:
>
> In fnic_init_module() exists redundant check for return value from fnic_d=
ebugfs_init(), because at moment it only can return zero. It make sense to =
process theoretical vmalloc failure.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 9730ddfb123d ("scsi: fnic: remove redundant assignment of variable=
 rc")
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
> ---
> drivers/scsi/fnic/fnic_debugfs.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/fnic/fnic_debugfs.c b/drivers/scsi/fnic/fnic_de=
bugfs.c
> index c4d9ed0d7d75..cf2601bf170a 100644
> --- a/drivers/scsi/fnic/fnic_debugfs.c
> +++ b/drivers/scsi/fnic/fnic_debugfs.c
> @@ -52,9 +52,10 @@ int fnic_debugfs_init(void)
> fc_trc_flag->fnic_trace =3D 2;
> fc_trc_flag->fc_trace =3D 3;
> fc_trc_flag->fc_clear =3D 4;
> +             return 0;
> }
>
> -     return 0;
> +     return -ENOMEM;
> }
>
> /*
> --
> 2.37.3

Looks good to me.
Reviewed-by: Karan Tilak Kumar <kartilak@cisco.com>

Regards,
Karan
