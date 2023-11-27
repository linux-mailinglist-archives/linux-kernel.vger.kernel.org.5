Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7C97FAB2C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjK0URx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjK0URu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:17:50 -0500
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423F7D59;
        Mon, 27 Nov 2023 12:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1008; q=dns/txt; s=iport;
  t=1701116277; x=1702325877;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+lNvIz+meuYk6HCIJ8l7VTRWgv6XS0XUOaRLmxgJ7Dg=;
  b=F6LPakEZ5gMZTDRlsnAmkxyu4/sxs2lHGjWtXWxbSSY0WDGFb1lwfcz5
   QJL9fLHRClOZPO1brf5yQXDkBVVSvdckuN7NclIniIobJHsTzts4YtUCX
   mDFglp5zkapLWuGfJOgAB2l+LpvmY2VbrfhzI2+Klk2YC+tTjniMC6guC
   M=;
X-CSE-ConnectionGUID: TclkbVP1SGKzI/+99WxEiA==
X-CSE-MsgGUID: u8OeA/r7R/aCo/FLrJg09g==
X-IPAS-Result: =?us-ascii?q?A0AfAgC5+GRlmJtdJa1QCh4BAQsSDEAlgR8LgWdSeFs8S?=
 =?us-ascii?q?IgeA4UtiGMDnX6BJQNWDwEBAQ0BAUQEAQGFBgKHKQImNAkOAQICAgEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAgEBBQEBAQIBBwQUAQEBAQEBAQEeGQUOECeFaA0Ihj0BAQEBA?=
 =?us-ascii?q?xIoBgEBNwEPAgEIGB4QMiUCBA4FCBqCXoJfAwGfPwGBQAKKKHiBNIEBggkBA?=
 =?us-ascii?q?QYEBbJuCYFIiA0Big4nG4INgVeCaD6CYQKBMy+EEoIvg2yFNgcygiODUY59f?=
 =?us-ascii?q?0dwGwMHA38PKwcELRsHBgkULSMGUQQoIQkTEj4EgWGBUQp/Pw8OEYI9IgIHN?=
 =?us-ascii?q?jYZSIJbFQw0SnYQKgQUF4ESBGoFFhMeNxESFw0DCHQdAhEjPAMFAwQzChINC?=
 =?us-ascii?q?yEFFEIDRQZJCwMCGgUDAwSBMwUNHgIQGgYMJwMDEk0CEBQDOwMDBgMLMQMwV?=
 =?us-ascii?q?UQMTwNuHzYJPA8MHwIbHg0nJQIyQgMRBRICFgMkFgQ2EQkLKwMvBjgCEwwGB?=
 =?us-ascii?q?gk9A0QdQAMLbT01FBsFBGRZBaIYYXxfZYEOlkqtT4EuCoQNoUAXhAGMc5kRm?=
 =?us-ascii?q?ECoKwIEAgQFAg4BAQaBYzqBW3AVgyJSGQ+OIBmDX495djsCBwsBAQMJimEBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23:FVs+aRzSEEqsdoLXCzMRngc9DxPP8539OgoTr50/hK0LK+Ko/o/pO
 wrU4vA+xFPKXICO8/tfkKKWqKHvX2Uc/IyM+G4Pap1CVhIJyI0WkgUsDdTDCBjTJ//xZCt8F
 8NHBxd+53/uCUFOA47lYkHK5Hi77DocABL6YAl8PPj0HofRp8+2zOu1vZbUZlYAiD+0e7gnN
 Byttk2RrpwPnIJ4I6Atyx3E6ndJYLFQwmVlZBqfyh39/cy3upVk9kxt
IronPort-Data: A9a23:ur43lalH5XwuRO5UGF5yJp3o5gyhJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xJOXzuGM6mKN2vyfdolPY3g9U8AuZSAyNZmSVY//nwzFltH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaB4E/rav649SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+5G31GONgWYuaTtNsf3b8nuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSq
 zHrlezREsvxpn/BO/v9+lrJWhRiro36YWBivkFrt52K2XCukMCdPpETb5LwYW8P49mAcksYJ
 N9l7fRcQi9xVkHAdXh0vxRwS0lD0aN6FLDvHXO7ssat9xT9XFj+4rItXRAJLaAZ07MiaY1O3
 aRwxDEldBuPgae9x6i2D7UqjcU4J86tN4Qa0p1i5WiGVrB9HtaSGOOTuIIwMDQY3qiiGd7db
 tAFaD5mbzzLYgZEPREcD5dWcOKA3yWhI20E9grNzUYxy3WD6wFYl6KyCp3cUdvNa+FPvEnA9
 22TqgwVBTlBaYTAkmDamp62vcfLnCXmSMcRGae++/pCnlKe3CoQBQcQWF/9puO24ma6WtRCO
 wkP8TEvhbY9+VbtTdTnWRC85nmesXYht8F4CeY27kSGzbDZplrfDWkfRTkHY9sj3CMredA0/
 mOCm9DjOwQ2i5K2W1PatebFkiOfOAFAeAfuehQ4ZQcC5tDipqQ6gRTOUstvHcaJYjvdR2mYL
 9ei8nBWulkDsfPnwZlX6rwuvt5BjoLCQghw7QLNUyf5qAh4f4WiIYev7DA3DMqszq7HEjFtX
 1Bdx6ByCdzi67nRzERhp81RRdmUCw6tamG0vLKWN8BJG86R03CiZ5tMxzp1OV1kNM0JERewP
 xeK4FsAtMANYyb6BUOSX25XI5pzpUQHPYq8Ps04kvIXOvCdiSfepX4xOxbIt4wTuBJ9wf9X1
 WinnTaEVitCVv89k1Jats8W0KQgwWgl1HjPSJXghxWh2vz2WZJmYeltDbd6VchgtPnsiFyMq
 753bpLWoz0BC7eWSneMruYuwaUicCJT6Wbe8ZIHL4Zu42NORQkcNhMm6eh7KtY1xfsPyL+gE
 7PUchYw9WcTTEbvcG2iQntic7joG514qBoG0eYEZD5EB1BLjV6T0Zoi
IronPort-HdrOrdr: A9a23:z/ZKIKAiuzrUI6LlHejpsseALOsnbusQ8zAXPh9KOH9om52j9/
 xGws576fatskdhZJhBo7y90KnpewKkyXcH2/hgAV7EZniphILIFvAs0WKG+UyDJ8SQzJ8h6U
 4NSdkYNDS0NykFsS+Y2nj4Lz9D+qj6zEnAv463pBkdKHAPV0gj1XYHNu/xKDwPeOAyP+tCKH
 Pq3Ls9m9PPQwVwUu2LQlM+c6zoodrNmJj6YRgAKSIGxWC15w+A2frRKTTd+g0RfQ9u7N4ZnF
 QtlTaX2oyT99WAjjPM3W7a6Jpb3PH7zMFYOcCKgs8Jbh3xlweBfu1aKv6/lQFwhNvqxEchkd
 HKrRtlFd908Wntcma8pgao8xX80Qwp92TpxTaj8DneSI3CNXcH4vh69MVkmyjimgwdVRZHof
 t2Nleixt5q5NX77XzADpbzJkpXfwGP0AkfeKYo/g5iuM0lGf9sRUh1xjIJLH/GdxiKsrwPAa
 1gCtrR6+1Rdk7fZ3fFvnN3yNjpRXgrGAyaK3Jy8PB9/gIm1EyR9XFoj/A3jzMF7tYwWpNE7+
 PLPuBhk6xPVNYfaeZ4CP0aScW6B2TRSVaUWVjibWjPBeUCITbAupT36LI66KWjf4EJ1oI7nN
 DEXElDvWA/dkryAYmF3YFN8BrKXGKhNA6dh/129tx8oPnxVbDrOSqMRBQnlNahuewWBonBV/
 O6KPttcrbexKvVaPB0NiHFKu5vwCMlIbgoU/4AKiaznv4=
X-Talos-CUID: =?us-ascii?q?9a23=3AARRjkGm9pKLybHr6jSIsr0r3wPPXOUHWyHTaHXf?=
 =?us-ascii?q?hMklKWpzSCg7Bx7NJkuM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AELQarw+5PEbibxu/4DXVyu6Qf9o4xKmHT1pSq9I?=
 =?us-ascii?q?PkM7DGwhqGTjF3TviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 20:17:56 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
        by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id 3ARKHtja013234
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 20:17:56 GMT
X-CSE-ConnectionGUID: rz+XjJL3ToOM5/ldpvqqPQ==
X-CSE-MsgGUID: bsKdfTgZRYia1R1GF1NZCg==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.04,231,1695686400"; 
   d="scan'208";a="10183236"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by alln-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 20:17:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTytADp//ZwG5axSg+FQSJ5ZTr6lm5kfXXRB/NdI0cD329QRu9QSCoDUrZ7a+NpYTkkqHltU1z+xojuFitlqlL+dOcQUsy+oJ0ZgSz28NjKH5yecgC8NQzsKA5edZH5TpuabqjIShcqOdBw9yrTxw5ZADk/2kLBlCN2pYwKPzY3a1lZc5VRmzwVouiorp1HjdlPdWbB0JWCDPvmMSsQwHKBxev6ZXSoe8Uk5zwmHUDbr/EUqCZKiLxCis8mhrW3wmU9P5XXev3eppkY69vinMHwBV0QwMfSwYkr1109rp4BkDTLMd6iiKQl4U9+Cksl2TSO8CE3c4hVzH8+GK9zjug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lNvIz+meuYk6HCIJ8l7VTRWgv6XS0XUOaRLmxgJ7Dg=;
 b=aIhDigU8ndibMIPWaSZHCCmhZJoznpkDqKkzziPYOP+3BhBZKTjdOMdu6Ih8QtbS2VmznvlVa+4g7aZNymiWv0R0veGeg53axvc1vWviEBDJmc0I6nvn8H9hakv0BONxoDkjKDjLx3QkcHTjU1pm9HmnkhO7ZmcsJb31UNOmFTIFWSABipd9TxokisjmcG+eB8pjj1dc/tCFoZok9+FB6UePe9880BwmiH9UnGh8gVsaDreg/3KiTeL/HYIdf4+0rxtA4GfAnXWN8b5u8WTpQLHfGjB947BBLBHo5NiXCJq4JH8IMy6mJfB/B3Kyph3go2GXoGYURHA5ENM1X5yMnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lNvIz+meuYk6HCIJ8l7VTRWgv6XS0XUOaRLmxgJ7Dg=;
 b=XYa7fipN7s4J1ImDKia8vxRx3b4hcX8eInYNkAcd7njtRHEyMBF7UuPc5jN2BxKJbZzjNyfDQzwCQKb7j7ljSTJQHgjB10os51sj+VX8HhZR00TEZpTNDjFHzFexy7NBFElL5z7h9xJ6OCbhnCc9T6gQYFznkiE4Zvi+lWRMkmI=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by SA2PR11MB4876.namprd11.prod.outlook.com (2603:10b6:806:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 20:17:53 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 20:17:53 +0000
From:   "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>,
        "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Dhanraj Jhawar (djhawar)" <djhawar@cisco.com>,
        "Gian Carlo Boffa (gcboffa)" <gcboffa@cisco.com>,
        "Masa Kai (mkai2)" <mkai2@cisco.com>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 02/13] scsi: fnic: Add and use fnic number
Thread-Topic: [PATCH v3 02/13] scsi: fnic: Add and use fnic number
Thread-Index: AQHaF0p6uXPGn2t9xE+tpp//qiyWn7CKTRQzgARhDUA=
Date:   Mon, 27 Nov 2023 20:17:53 +0000
Message-ID: <SJ0PR11MB58960721DF0510FC1CED01F8C3BDA@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231114223221.633719-1-kartilak@cisco.com>
 <yq1y1emtzok.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1y1emtzok.fsf@ca-mkp.ca.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|SA2PR11MB4876:EE_
x-ms-office365-filtering-correlation-id: c9a9d9de-29fb-4720-c5a4-08dbef85ef81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i1lP+L8d33N90mbTnsN/3UNcrB4KLjRUjTW6wQCcMXbZ1EFEcWnl240Y+IifiNyoAcxB+XkIXniXg0V/Y/iIF0FclxKVg1saMQ1LPjkCpBIvJqkempj9T8YXSUyxEs4lTTwbJNjezRY5UZQX2TC7KOtZnnftWbRPDaf9aOwjRp48IN+NrEU/St+YPDwRkW4kt8+kNtrJJ2rSQFMp9bUa+5dPBa+ilR/T+LcVT3YSvxpeqhm9vaemqsjRVUFAB4PGMbGtsxBdxncWADbiXL3MA7dBJ6hVSV5psh15eLiYIlkr2JaPy9j7pyUBq2FjdqX5Rn9hvYcK8zZpkSeKrcOpG5q9b349o+cwwbqrGf1jgmCnh6+KsswA6QfJ8HHnF4rf0of+HXQ42AX/BjdpAh84+uvqCpOf/YfVjEQbh4443MnUedLqVQxqzsD5N+6V3qcj9ST6L4MSTj+cOH7HODIeqOavMeKHVSORn7FWH2JujO0HnnswV2dOmZeUFZbLiyJvip0Coy3hi8KFsUv/Ru5dM8NuGFj528nVhbmq5rMft1r1rynvBejNFp/UCAiEDybLnNcO7z8B+vtX1RoCMtShd2HLuSzL9HS+uzE90skuYhleaKIkfY+cDjMRqn3m8V5E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(83380400001)(38100700002)(122000001)(4326008)(8936002)(8676002)(9686003)(7696005)(6506007)(71200400001)(55016003)(66476007)(66446008)(66556008)(316002)(6916009)(64756008)(54906003)(66946007)(76116006)(53546011)(5660300002)(52536014)(86362001)(478600001)(4744005)(2906002)(41300700001)(33656002)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WCBhNHAWNCyUJ+tP4wSWAR3QB+4w+uv3ZL9iNmHZ4nsyryIY3o/GssqI19aW?=
 =?us-ascii?Q?Le60u/9f5boViU5kcJc2ziresrMIV8sqK6tQfxxa8IiqFJh9fDMMTNsy3i66?=
 =?us-ascii?Q?uYtb2gD0Z+KvogEUVJ5cx1FzcnDvBdunwUK9J8lcGY+Po99Y9OhcVNPofGHz?=
 =?us-ascii?Q?PHtBq+reNBQtz80SCxaGUO0ocgapQOry1kFTHBcUkg97ZPvw/xVLo8HeoGw9?=
 =?us-ascii?Q?QyPxsgUiyTwLuQd6Uemv9WC5Q8DRgszzeT12gXXTdkl71dcJCp3rhtNaYFqx?=
 =?us-ascii?Q?O7KdgzYROR7cL1uTvtEv1NVRGZCdt8cVjuzyWB5LFtuCirj/7FrAW+5NwU8J?=
 =?us-ascii?Q?zK9Frwutg655ccfpwnVcZZit/YKVSSz7HtPbXF3Vhl8sZe23ety/27N3BHN6?=
 =?us-ascii?Q?S57s1QyoguBZEzuQxU6GDMxMrTh3MLqeIoVCdSVWpiSizDR8AZpR4ARmJ4nh?=
 =?us-ascii?Q?BGP3WW9nmyPc2Rw7QMNhtY55Et/ruyLZPxH97HjZD/JPyLdo8AKeal9u5Bw7?=
 =?us-ascii?Q?iRBfNJp0dblXnj2Z64ifu8c+Jg0Pd9WY4KrVeeas/AZjlJr9zfO4EYODsEPV?=
 =?us-ascii?Q?63gEX3MWAoICjqhhDrrEHVI0hyJdF3lA1aV/Z0rICiTJi/GSj5jrYkVOTMSU?=
 =?us-ascii?Q?UxpJzip13LNAsSuU/nvxvyc8CTisPuVU6sjD5YF7gIc2CxBFcuw0xxy8RERs?=
 =?us-ascii?Q?i4oYJ3i06kCfGNXCoSBn8UDw7Rp9AG1r1ubFqT9c3fBwCtFWRpL71zwx7ipz?=
 =?us-ascii?Q?7nEgC7AlY7dHpuHf1GKpnofJAtZg6tkwgFpcydRQB9G5E4ni3X4AITrin4CM?=
 =?us-ascii?Q?9KYoqSyAvI7PFzCED5fsgfc52q5+rgqQADpSrLaPDyT5F309hprEPoiDPn1t?=
 =?us-ascii?Q?nuj/crpm4rNHiaFArdYaTq78+cyQqaj2ESrxUoR3mzZobFjH731OWdEVo7Uw?=
 =?us-ascii?Q?TEhCfNCWM/EC1WR+KlvWNGoHTd30Ylu+FY6m5Gr4CoHDYaEHDOXtyQwpUqoi?=
 =?us-ascii?Q?bqoc7mT+Yljv309fZbc2Y/ZyHU9Dw+h4V4/47/LohGHfGmDdJ6BAMw6hnnge?=
 =?us-ascii?Q?7TjvtNKLEGal+jnZgcpfSx/hE83hgw+b/wvSfd2iDzPWRqqFkQTDG8tDltIE?=
 =?us-ascii?Q?MTj6+ByLCjR2uZ1dgQxY5E3NIopw2zBARi2niaGu+mw2Ppi0W6HgkFjvHHUx?=
 =?us-ascii?Q?3bXBDAKdgnv03wJXp/vYxN8ka+RWesrlfFZDh18WYnRaK8brCSO8gZfzSrmL?=
 =?us-ascii?Q?SPC8ANFxA091aMGwkr7JcYextyx5BaQ/mu86KOhwrp6YhgXFZ2Makv9Y2sHh?=
 =?us-ascii?Q?XBsvPJmSla7Dbfg6CY1JgICUfSRyvXJ5wW6UrO3Nl2JWUidS4fguB+/QqkNe?=
 =?us-ascii?Q?SVEe1i0b2Ck3IG8MPp16uyJ8xHNc+wAcke0eAefqqti/WpmOU+zDG3nUsC2u?=
 =?us-ascii?Q?D+Bn2o3Jv+sUNySJXTY2qJBxUbjx/EktI5+oxjfC6O4XY74p1H56XqTODjXJ?=
 =?us-ascii?Q?VFIymZCAPSb7F2JaQqPIsJKRSGSBHi46feEFl411P76A720JAwQE/jwQ5tPb?=
 =?us-ascii?Q?wMdPUYC1JtjWTbWC6OlsPSs8Xgww5eSYhCp120KvOo3c0eYEQJjJ/ZZoPpLy?=
 =?us-ascii?Q?h+9SHpX3RqClCDRerCl8VZ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a9d9de-29fb-4720-c5a4-08dbef85ef81
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 20:17:53.0662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YnKOn1SvthNabVIsXsgg0GKLLkjWDH8ejAmevO0EdWFMhUWM+SlSBkKdleIxUMaqeTrmapm4nj0zmI2MlJe8Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4876
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: rcdn-core-4.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, November 24, 2023 5:22 PM, Martin K. Petersen <martin.petersen@o=
racle.com> wrote:
>
>
> Hi Karan,
>
> > Add fnic_num in fnic.h to identify fnic in a multi-fnic environment.
> > Increment and set the fnic number during driver load in fnic_probe.
> > Replace the host number with fnic number in debugfs.
>
> I agree with Hannes. Everything else in the stack will be using the host =
number. Your change will make it harder to correlate a SCSI error message t=
o an fnic driver instance.
>
> If you absolutely need an instance number I suggest you add it as an orth=
ogonal value instead replacing the host. Also, we typically use an idr for =
enumerating things like this.
>

Thanks for your review and comments, Martin.

I understand the issue. I'll take your suggestion about adding the fnic ins=
tance number as an orthogonal value instead of replacing the host number.
Could you please help me understand what is meant by "idr"? How can I use i=
t?

Regards,
Karan
