Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D897E621A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 03:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjKICVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 21:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKICVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 21:21:22 -0500
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896072107;
        Wed,  8 Nov 2023 18:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1098; q=dns/txt; s=iport;
  t=1699496480; x=1700706080;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MgN97BSZGEyocvONEDMyalB/nwkuL4OkImPIfjXqaTA=;
  b=WASIss11mUMzDElF/0vyb9wKYXTocsyTt4ERGtApE8El3NpGB3tL0Ml3
   EWKNpQVXXFc2at5WcyNhzol8Fz0ygGEBT2K9+gjpq4cR9i4yTCldQVBBv
   oraMzqprV/GzVROGU5Wg/mKHi5IZUTN04GqpxXLlvFuuW00fx85b3ZCD3
   Q=;
X-CSE-ConnectionGUID: OphA510NQKST8xgA8MQ+XQ==
X-CSE-MsgGUID: NxELHNfBRvOYRQ8GxLWL6g==
X-IPAS-Result: =?us-ascii?q?A0AcAABlQExlmJxdJa1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEWBwEBCwGBZlJ4WzxIhFKDTAOETl+GQIIlnX6BJQNWDwEBAQ0BAUQEAQGFB?=
 =?us-ascii?q?gIWhxACJjQJDgECAgIBAQEBAwIDAQEBAQEBAQIBAQUBAQECAQcEFAEBAQEBA?=
 =?us-ascii?q?QEBHhkFEA4nhWgNCIZEAQEBAQIBEhERDAEBNwEECwIBCBgCAhkNAgICMBUQA?=
 =?us-ascii?q?gQBDQUIGoJcgjwjAwGgaQGBQAKKKHqBMoEBggkBAQYEBbJtCYEaLgGICQGBU?=
 =?us-ascii?q?Ig3JxuCDYFXgmg+gmECgWKDWTmCL4kpBzKCIoNTjUcJd0dwGwMHA38QKwcEM?=
 =?us-ascii?q?BsHBgkULSMGUQQoJAkTEj4EgWKBUQp/Pw8OEYI9IgIHNjYZSIJbFQw1SnYQK?=
 =?us-ascii?q?gQUF4ESBGoFFhUeNxESFw0DCHQdAhEjPAMFAwQzChINCyEFFEIDQgZJCwMCG?=
 =?us-ascii?q?gUDAwSBNgUNHgIQGgYNJwMDE00CEBQDOwMDBgMLMQMwVUQMUQNsHzYJPAsED?=
 =?us-ascii?q?B8CGx4NJygCNUMDCQoFEgIWAycbBDkDRB1AAwttPTUUGwUEOylZBaVFlh5Jm?=
 =?us-ascii?q?UmUagqEDKE/F4QBjHOZDS6YECCoCAIEAgQFAg4BAQaBYzqBW3AVgyJSGQ+OI?=
 =?us-ascii?q?AwNCYNWj3l2AjkCBwsBAQMJi0oBAQ?=
IronPort-PHdr: A9a23:kePrxRElD9dm2vCwB/94c51Gfu4Y04WdBeZdwpMjj7QLdbys4NG+e
 kfe/v5qylTOWNaT5/FFjr/Ourv7ESwb4JmHuWwfapEESRIfiMsXkgBhSM6IAEH2NrjrOgQxH
 d9JUxlu+HToeVNNFpPGbkbJ6ma38SZUHxz+MQRvIeGgGYfIk8Wz3uOa8JzIaAIOjz24Mvt+K
 RysplDJv9INyct6f78swwHApGdJfekeyWJzcFSUmRu9rsvl9594+CMWsPUkn/M=
IronPort-Data: A9a23:Yys3za64q0d2vjRHm/vWXwxRtAXHchMFZxGqfqrLsTDasY5as4F+v
 jdLW2uAM/iJMWuhfd91aY6/9BwHsJbQx9VrGlA5pSg0Zn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyKa/lH1dOG58RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wq+KUzBHf/g2QvaztMuvrawP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoZWk
 M6akdlVVkuAl/scIovNfoTTKyXmcZaOVeS6sUe6boD56vR0SoPe5Y5gXBYUQR8/ZzxkBLmdw
 v0V3XC7YV9B0qEhBI3xXjEAexySM5Gq95fgOXiW7JXL6XTlSEe80/pHXGQPfr0hr7Mf7WFmr
 ZT0KRgXZRyFwumx2r/+F69nh98oK4/gO4Z3VnNIlG6CS615B8GYBfyXu7e03x9o7ixKNfXXf
 dYYbTNsRB/BeBZIfFwQDfrSmc/x3SWkKWQA8AL9SawfxXj+6CxX3pLXLv3kQOXaatVxoWLGq
 TeTl4j+KkhKaIPAodafyVqoh+nSjWb4VZgUGbmQ6PFnmhuQy3YVBRlQUkG0ydG9i0ijS5dEI
 FcV0jQhoLJ090GxSNT5GRqirxa5UgU0QdFcFagx7xuAj/eS6AeCDW9CRTlEADA7iCMobRsy1
 nbUxovPPB9UjO2FRlvN047XnQrnbED5MlQ+TSMDSAIE5fzqr4cykg/DQ75f/Eid04Kd9dbYn
 mDikcQuu1kApZVUiPjjrDgrlxrp98eZFFdkjunCdjv9tlsRWWKzW2C/BbHmARtoNo2VSByKu
 2IJ3pXY5+EVBpbLnyuIKAnsIF1Lz6jcWNE/qQcyd3XEy9hL0yL5FWy3yGouTHqFyu5eJVfUj
 Lb74Gu9HqN7MnqwdrNQaImsEcksxqWIPY27B6GIMIoUPsUgKlPvEMRSiai4gTmFfK8Ez/lXB
 HtnWZrE4YsyUP4+l2PmG4/xL5dxnHtnrY8seXwL5033jeXBDJJkYbwEK1CJJvso97+JpR69z
 jqsH5Xi9vmra8WnOnO/2ddKdTgidCFrbbio8JY/XrDYfWJb9JQJVqW5LUUJIdI1xsy4V47go
 xmAZ6Ov4ACl1CWWdVTbMyoLhXGGdc8XkE/X9BcEZD6A83Mieo2oqqwYcvMKkXMPrYSPEdYco
 yE5Rvi9
IronPort-HdrOrdr: A9a23:ZAw0JKBIyegc7GPlHejpsseALOsnbusQ8zAXPh9KOH9om52j9/
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
X-Talos-CUID: 9a23:21J/qWCRkMx51HD6Ew5/9GdJQ5gDS17m8CfALGboLF8qeITAHA==
X-Talos-MUID: 9a23:z5qdVAvriZrR69fYqM2noiFPEOdO7Y6UFmc8q6xWlNmgCgguNGLI
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 02:21:19 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
        by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 3A92LJ7q008905
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Nov 2023 02:21:19 GMT
X-CSE-ConnectionGUID: XETtaEdyQEqhoMkTcz6ZLg==
X-CSE-MsgGUID: c1oJJPDXSRurQNaSWyJ5Rw==
Authentication-Results: alln-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,288,1694736000"; 
   d="scan'208";a="7628581"
Received: from mail-bn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.40])
  by alln-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 02:21:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPtLK3z/y6KeVIzl/lki1ZOVN1HunLvPzuKYO9QLgkJgh4aisJ96uPmCO3TI33Pkf8I54gSCksxYo538aDR7ef8ly9QELFKaLgz+Yd70soVlnUODk//XouKwgA6QFOFgIja0ffjyTWJVXwLulu8GUI+LZdn8Bt1ECbyX2C2vnnteAfEi38Vawbdo8zC8TLKIgGjgXPqK1dWgJZxF3pEA24ZaQj0JJtptpwDF/EUn5EcUej7EXg2yvPMGIIZ5jgB1/mHZs+hs0x6HYLCNHknG04rLi8L28RDSQQw/LA8FaDZJ1K+lgfLW2gmafYec97Xh88dDTneZ2+CsVw2JFwOP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgN97BSZGEyocvONEDMyalB/nwkuL4OkImPIfjXqaTA=;
 b=nFeIWaDh4F0qtM1MXl9CXcnU5bDh0oM5KcQWiqO3ZavA17ASLvK/Iv8UYqqoX9HsHbEKdrRCxgxBn7PE6qXFg5tlxWDhhLwlfPcqs0Q/PJz+96SYoRElQPA+NbwP1tYDtOnSkbS6EinkEHC5JorsBbg2r3GLzzBYmEiUf00/Pvh+Bl02FZbK/VofuQ+ZLEVtckHJ3eZNU0/zRFsMg+1lpml4R8KhdEol+3opYpHlcUjTMYVbkwoCAq/UPqqNlkQ8tG6VGN8jgcYaW+/hNUhtczY8ISGu09ilrN+EFDS522DEMkQzEz8oupZ2rutN0LlO4yV7MWbiS4v9+8FN6XcSRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgN97BSZGEyocvONEDMyalB/nwkuL4OkImPIfjXqaTA=;
 b=PdtScSU9k6yKlfnu2Zjz5Elm8PhVsMRWx/NqWNp+ZFH8Cdjh3umTUKPZx+vlsvuB8XmHtz9rBw1F7kSYdkMvJgkugUGLXgz8v8he/B7Lsv/OlCs28kGVrjkjN61kNJV1mJPW2+2r6TJMfVyDuqtrokoCDGPC+FOPC2XFzVmKtbM=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by IA0PR11MB7380.namprd11.prod.outlook.com (2603:10b6:208:430::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 02:21:17 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 02:21:17 +0000
From:   "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To:     John Garry <john.g.garry@oracle.com>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>
CC:     "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Dhanraj Jhawar (djhawar)" <djhawar@cisco.com>,
        "Gian Carlo Boffa (gcboffa)" <gcboffa@cisco.com>,
        "Masa Kai (mkai2)" <mkai2@cisco.com>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 10/13] scsi: fnic: Add support for multiqueue (MQ) in
 fnic_main.c
Thread-Topic: [PATCH 10/13] scsi: fnic: Add support for multiqueue (MQ) in
 fnic_main.c
Thread-Index: AQHaA4in646ucXDkD024owD3Y+IpgbBwj9QAgADOAEA=
Date:   Thu, 9 Nov 2023 02:21:17 +0000
Message-ID: <SJ0PR11MB5896F9262C82755C5491B85FC3AFA@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231020190629.338623-1-kartilak@cisco.com>
 <20231020190629.338623-11-kartilak@cisco.com>
 <7912855c-c661-2b83-f19a-4ec6287ddb4b@oracle.com>
In-Reply-To: <7912855c-c661-2b83-f19a-4ec6287ddb4b@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|IA0PR11MB7380:EE_
x-ms-office365-filtering-correlation-id: 455feb7d-c47a-49d5-1334-08dbe0ca8def
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C3+UajU2EHymuePn5pjmYM2QRsTYtD9VlrM/WOdrEoU/NvLl2neBlGv0sJbaFtA2ioOecfpe7J5VHIN1Jj1dHjJaevVCE+lZ5EMXw11+48qdMQEvjEAUxEthhpf/xqT0Fh3w1jjtHwCdpXM1X8ujeuwx1BeeCuvopoJz9EPHzoXHlGgu3N8dWPa1JohOFj5f20aLNsOeRaw9OjlyO/59Xz7XReC9IcVk8QQPrRPEpeq0tKZ4rbDhcGFBlfEI+VnTRRj71fGLA8UAaz1pC607fpfoZs8uA0JDZpVAcCxw1K3lnOHZeUZcXFOxjZP1XXMvIYhhVpah1TkyvibA5YJr5M81uwIFMJoqSyLpVItjbi3olbofjAjobXbFNkZFB01Ff7SI6oSQbodaLMMfs7xhqgSzvS1GyCMbkovVvc5tixphXz9MQtuA0+BR18zUIbyOlpnke7bco9qHWcRFKKep4wQ3HSQMy+MPYQ5FUa7ZTIGcmCYo9d6xfSP1tnZYnKLeidlTb0SYZsrTRv1nzw2+kvFyeEuTq10QqpR3vdw5vK9zwh3GAeY+AsJh5ooTTZNCeIoUsJf1rinBsHMhgT1CAGE4aXY3l8Bs0dhFM98lDgaFgmIH+QibFHsKvWWCA8JN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(52536014)(4326008)(2906002)(41300700001)(478600001)(8936002)(8676002)(5660300002)(4744005)(54906003)(66946007)(66556008)(66476007)(76116006)(316002)(6636002)(55016003)(86362001)(64756008)(6506007)(7696005)(9686003)(38070700009)(110136005)(71200400001)(53546011)(33656002)(38100700002)(66446008)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWtMMm14aEpDOXd1czlTaGVKaWllRTR2QjBLbFYxM0ZFN2p4aGdRUldMSE1M?=
 =?utf-8?B?MStTaEEzUDlmemc1ZS9USzdocmxiVUdaOTBGUkFlTGF1UFp4S1RvdmluekVO?=
 =?utf-8?B?ajRTWjdaazkvQkF3b01oSzBGL3duQnBkdWhJdkd2TklRMlJQRmdGbDlLVDZE?=
 =?utf-8?B?TCt1Qm04ZHJmVzg5S3R4ZXdzVjk5WDgyMWJ2TGFsUWloK3docEN1OFovaDhi?=
 =?utf-8?B?a05zOVZRQWd6S1A1NzRlcTJzQVBtTzhJejVvZ3B2aDBDQ2poRk5CaXBnRlNk?=
 =?utf-8?B?YnZPZUpXNVB1cmthaFBOU1krVWxnMWI0UlBWc0NDcFlmTnRlakJ3alFqdWhI?=
 =?utf-8?B?OEtqY0pxOC9LSG9vTEVBczMyVTVEczI2R2o2MUNHOGZIaFhacHorK1hnNVJC?=
 =?utf-8?B?TEZDUTFaVWhNUE55YldSVlhIbkQwZDJHdjlpM3lGdGNGYUxCbTFTeVYxUzIv?=
 =?utf-8?B?Nlg2bSszNUw5cHRld3hISHRPUlJLVytpSDBHSklnL2YxZFNyV1ptbTZqRVdy?=
 =?utf-8?B?TXZQTjc1MHVtaWUrUkhlZ0lMRHlRY1E1S1UzRVpxMHhXaGJMcUt2T2FRenRP?=
 =?utf-8?B?eDR3aWEzRi9VdVd6Tzd3ZXdFbk85TmUzRzEwVW1mRm5zOEcwWlFhV05RMzVX?=
 =?utf-8?B?dHhMcHV2UWxjaEVwNVMxcEFjQkxJMzNnWkZVYUVndFVpaUM3c2tZNWRhUzZD?=
 =?utf-8?B?WEs2VU9nV3lLdndEbmxyajZ6OG9nVlNSenNQTUlHODFDMDlVYUZ4RVgvTlRP?=
 =?utf-8?B?M2xudXBLREYyV091MlRhYWc1dys2ZDMxb1VJSkhwR1ZqVGR2YmlQeFp1bFV0?=
 =?utf-8?B?dnp5WVBWUEUwZlhJMVc0V3VqcGwvVWROeEZjK2RxRDgxM2ZDc1R3RTJnc2h0?=
 =?utf-8?B?Ym5lazVoRXVmNlNkSVFBV3ZsRHJWQ3kyd1pHek5TdjNTejVZTEYxWE1WbXVh?=
 =?utf-8?B?b3NqaFZFamt5T0ZpSS9qQmIrQWtScklvSWpnUlVWby9jcmxzQ2pJS0Z2ZVJm?=
 =?utf-8?B?d2hqTWJmeFRCRTZrWDhuMHhxRUxqclUvTXVJV2djTTNoemlzV2hpbWRoZC8y?=
 =?utf-8?B?Q3ZwTmFHV2g3ZWxVWDE2WWpLQWIzZEhoZ3pHbzBHT3RST1lSY0tjVnJyazlr?=
 =?utf-8?B?dzV6ZnFRVFhMdWx5d004eTQxM2FzcnN0a1ZVYURpUWtLeisybE9zQjlGQXlN?=
 =?utf-8?B?K2VSdkhhYWdsdmFteTIxOW9oazlQVHdSYk1TN2NWTWtBcy95NzNWSGIxbmdF?=
 =?utf-8?B?eUNGSWRKck1mNG9CaXpIOUJiSzFpdUhXMTBlNVB5MStNYjBoc2FrQVRzSDQ5?=
 =?utf-8?B?R3BvMGpwVExFbDV3MEkvZ002eVFaRHVPazVNWkFaTmxjOFQ4dy9HS1pxQThI?=
 =?utf-8?B?QWJ4YkJidllLenpnZExGQjg3M2diVVQ1RFM3cEZvNlVTUDkwME1kRFM4WmRj?=
 =?utf-8?B?ci8rbHlLNmg1cDhWcDZyVGluVFAzdEw4R1BmQ1RXY1lCTmVXWndzOER3UXZn?=
 =?utf-8?B?SW5pSlM4dUNhMW1uNHYyZk1leHpMYlZPQXV1b0htOUNZOWdBeCt5Wmw4TFdO?=
 =?utf-8?B?Yk4wakRCOHc4RFpST29teVR6alJYdE1sSEN6N3FoNFNKUlFUZko4SGl6ck5y?=
 =?utf-8?B?cVlPQjBrQTdFK20rSG91WjlNWnkwZXZwWVJ2WUZWU2phS1UyMVZyWjBWdWYz?=
 =?utf-8?B?ZU9mMG8xTm1TbS8wOHBydS9OZ1BDT3Y0MEZHWkVGSzJhektaZ2lkTloxZTkz?=
 =?utf-8?B?SVVCbUJrOEhSanpqSm9RUnFtUGg5bmZFNWJCMmF0ZnpqeFlTRlk4VCt2YVlo?=
 =?utf-8?B?S0JMc3d4M3p0T3M0dzhmcDhJSlRRVDNKOHFnRmRPeUdFSGhDUXg3UTBnOEZp?=
 =?utf-8?B?VlVvTEpmR1hVVUg3YytMbnFQT3cvMWhlNmI2clltVkM5cDU4RnJjZ3lDWlZ0?=
 =?utf-8?B?alYrK0IzSk9kL21rcStSZ2xGZ3ZGWml5K0c5Ump4WkRQVGsyK3pmYzh4T0dn?=
 =?utf-8?B?QS9idmJyRnVsNkV1TE1pVUd6MEJvSFBDcUk0aEIxZDR4U1NCeml1RDFhM2tH?=
 =?utf-8?B?cFFTNDNrR2ZNYmhFSGRWNHJGM2RYajJ2YVpiOXBPaVNKYjc5U3IxZ0dBaE1w?=
 =?utf-8?B?SmNSZTd4cnZTR3Q4aUZqOWFuQmVGMHVJRXVSS2Vna0EzZzU0Z29BNE9XbXhj?=
 =?utf-8?Q?jd6p6dl3ovhaQfdYsgj2vydRb2uTPKxhNg9iJMrko/9f?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455feb7d-c47a-49d5-1334-08dbe0ca8def
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 02:21:17.1795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6S7PxgpiN1sQUSH0qbY6B5DfvXC/4ejU1wsv7yyXt1UiqOT1Soy4iKwtgXsgigXgvJnmHagxtq6dHVvitcFIVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7380
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-5.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkbmVzZGF5LCBOb3ZlbWJlciA4LCAyMDIzIDU6NTcgQU0sIEpvaG4gR2FycnkgPGpvaG4u
Zy5nYXJyeUBvcmFjbGUuY29tPiB3cm90ZToNCj4gUGxlYXNlIGJlIGF3YXJlIG9mIGNvbW1lbnQg
b24gbnJfaHdfcXVldWVzIGluIHNjc2lfaG9zdC5oIC0gbWF5YmUgaXQgaXMgcmVsZXZhbnQgdG8g
dGhpcyBhZGFwdGVyOg0KPg0KPiAidGhlIHRvdGFsIHF1ZXVlIGRlcHRoIHBlciBob3N0IGlzIG5y
X2h3X3F1ZXVlcyAqIGNhbl9xdWV1ZSINCg0KVGhhbmtzIEpvaG4uDQoNCj4gQWxzbywgc2luY2Ug
eW91IHNlZW0gdG8gYmUgdXNpbmcgYmxrX21xX3VuaXF1ZV90YWcoKSBhcyB0aGUgcGVyLUlPIHRh
ZywgSSBhc3N1bWUgdGhhdCB5b3UgZG9uJ3QgbmVlZCB0byBzZXQgc2hvc3QuaG9zdF90YWdzZXQg
KGZvciB0aGF0IHJlYXNvbikuDQoNClllcywgdGhhdCdzIGNvcnJlY3QuDQoNCj4gPiArdm9pZCBm
bmljX21xX21hcF9xdWV1ZXNfY3B1cyhzdHJ1Y3QgU2NzaV9Ib3N0ICpob3N0KQ0KPg0KPiBUaGlz
IGZ1bmN0aW9uIGxvb2tzIHRvIGRvIGVmZmVjdGl2ZWx5IHRoZSBzYW1lIGFzIGJsa19tcV9wY2lf
bWFwX3F1ZXVlcygpLCByaWdodD8NCg0KWWVzLCBpdCBsb29rcyBsaWtlIGl0IGlzIGFjY29tcGxp
c2hpbmcgdGhlIHNhbWUgZ29hbC4gVGhhbmtzIGZvciB0aGlzIGluZm9ybWF0aW9uLg0KSSdsbCBl
eHBlcmltZW50IHdpdGggdGhpcyBmdW5jdGlvbiBvbiBteSBzZXR1cCBhbmQgbWFrZSBzdWl0YWJs
ZSBtb2RpZmljYXRpb25zIGluIHYzLCBpZiBzdWNjZXNzZnVsLg0KDQpSZWdhcmRzLA0KS2FyYW4N
Cg==
