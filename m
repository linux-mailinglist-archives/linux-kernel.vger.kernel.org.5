Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1926796FD3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 07:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbjIGFVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 01:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjIGFVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 01:21:35 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D77319A5;
        Wed,  6 Sep 2023 22:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1694064092; x=1725600092;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0e4jwCAooOxcXDykTYt4mdyrWz7klFHw/yEtX7xbyWA=;
  b=D4NkCl35a0rj6veHVBNqYUPRISEe29f7hUrplfXy8/PG2B1La9AZatnt
   Mb4jhhuw30NBbGYICuXJv7wPjovKkt0HOVe0VUVekzcuZJBsFp1AWQWKI
   /zCqNNXlUnYfgv/f0pTeowhPtgcBR2f+lNPdcWDqQMtl5ZBtAqHnMCX60
   dNEO03dhMnkUd0oZWqxdV7cDviH1aaSQzlg7K6gytrjMLxnep9B7QM77K
   JkFK9dN85cI9ucqldCTfibMGRHMvQr0p4PkWbA5Lwg3rqsskqN78ElZ/1
   XRiqkd5dVWof6muEHMWkNDu42vb+VIlaTVptcnaOKqNDMXvKMtafg0rZZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="94437964"
X-IronPort-AV: E=Sophos;i="6.02,234,1688396400"; 
   d="scan'208";a="94437964"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 14:21:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpfMkFpwgI8ekK9f5EfW8ItGlTRqPlMzAA5VKpUvdVVXRBCblXFHBTRpR7HQUJFv7VDh0oiQdAMvETs9T830E/eLQ1Nty1P7iqsNRHspjVPALfaKJJX3UGf6V+5NEIHfBC++XZJtEidFcmhWcNi59rItDdD48Yl7+rlajoZu633p8UTCNXxdKrF1QIQMn2UH+/5IyWYcaTb7gUOSToCxIYISB/50ZXjPAwuty5JUaB/W6X76a9l5x/thLRWHfFgixMHSsyxAVY0SBMPnyccLcv5Mxq7s/Tf03csjuwi5hb75LD5r17bsEh6yaTZhUO6AjxRYs+7/X2To0ewiN7DIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEAYx9g+Zjz5gHVWLcwwQIvHc+lhPu7jjI2iuyjIFgA=;
 b=hU68zatGdjx6PZaCJxqE2XX11u7BhAi1eKwkap0R+C8b1tAoBvZsaZc975kFcMjvuuYHWF46jkgz2p6upMQhIOZN7xWVlKkVgaI/yktkOS8Md35Tl3L3/m70YKpJNt3j9PUQi3qTnxSaJQUx9DdubFykA4tQLB5t4OhpDt2Y5fbO8yW9knIMU8XdTtYoOjUleON9h/I6LX73D1+2/7MzTNQ0ROdB0xplIhDN163LN4wquZfKTJsb448ObHgCw+kX+vBPPwR1L2wMzkEhhvJCf4aTNtgH/Qp/MO77ICQIYxnpTQdpmWoS/OAoJS/CDl0fFtWnoMTNJI6ae3CJMhw/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TY3PR01MB11790.jpnprd01.prod.outlook.com (2603:1096:400:404::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 05:21:20 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26%3]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 05:21:20 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'Tony Luck' <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 8/8] selftests/resctrl: Adjust effective L3 cache size
 when SNC enabled
Thread-Topic: [PATCH v5 8/8] selftests/resctrl: Adjust effective L3 cache size
 when SNC enabled
Thread-Index: AQHZ2tLZu2gGcfMhRUOCC7ExvTJHOLAO2ASA
Date:   Thu, 7 Sep 2023 05:21:20 +0000
Message-ID: <TYAPR01MB633033C489AAC0E514CBC6688BEEA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-9-tony.luck@intel.com>
In-Reply-To: <20230829234426.64421-9-tony.luck@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9MmIyMmI5YzItN2VmYy00ZmE4LWI2NzEtMGNh?=
 =?iso-2022-jp?B?NDA0OTJkOTU5O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjMtMDktMDdUMDQ6NTA6MzJaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: c1598cc45d9141668615fa8b41ef5790
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TY3PR01MB11790:EE_
x-ms-office365-filtering-correlation-id: 8b8ccdca-73a6-4ccc-5407-08dbaf624551
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0GZxu89rH2V2/qVbSAdXBwVNIN3ZiaLa4ay7Yk+qsJuXohHLKgvu556vYlB6vsziMFVoozkgi8vE3U/JgIc+zbrGItkVJZ38Lv+z/YLpUSt/XEJ84OmjaItcLxfJjou33XqXyDSy6JfoF4iCQrqWCU6tWLmVzjMu+hoD76XogvPuA9w0gmweAVAaNb5bANBnbmvyjhYZLGPduxsdF5Y7OlCbsA/K9pZ8Ry0YPwSXPDmNOtN7Bo+EMB+c3I2OVEJi49r09YAeQQ5KIs2/Bpg6YN1MBMxzgh+ttq79AONWX/R9dv+tBfaGcfWezjKHVEbxxIwskhN+e+rya55LWHzudicA39hCWRWOBtuzV/yqBIAnIakVI2dE77grHvnK0qmk7vZjiHBpi/puuvyTvXG40nx484n4Xnvdt/o+qHy64PMohQ0zqLOw6Az5HLPSHthffroz147nw2EljbPuLH3Qg17PGsOVieHtHFRXRkMIVrXiU57nzoyZznZgqISECh3SzBW6jRXTJPpBlasxwqDlS1ynh+3lTZ8fiRVrjxpc9tVwEV4fnpCCs+6owENfKftpIcG17APZaBJLhvBpKa/OKC+mt3cXjMJZW5vwam8FHCDeMHPsavZFODUJ25lakkwMcwALtrs+302Da+oezGHtoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(376002)(346002)(1590799021)(1800799009)(186009)(451199024)(1580799018)(71200400001)(6506007)(7696005)(9686003)(52536014)(478600001)(26005)(2906002)(83380400001)(7416002)(54906003)(64756008)(41300700001)(66556008)(316002)(66476007)(8676002)(66446008)(110136005)(5660300002)(66946007)(4326008)(85182001)(82960400001)(38070700005)(38100700002)(55016003)(86362001)(33656002)(76116006)(8936002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?RU1Kdm1qclhtc1Q5Z0x1UFp3aFlzR01GcXFOTS9tQVMxblFrTm5KZGlt?=
 =?iso-2022-jp?B?cU8xVFBCQVpFeDQxbHhWYW9pdUJacTc5MlAzYzg3eC9oUGwyMzVieXA0?=
 =?iso-2022-jp?B?NzEyTk1ndGFibUZmWGJQQkR1ekk0UGhuVDBIV3phQkx5RloyRi9LbmU3?=
 =?iso-2022-jp?B?ZmNrRkZGeW9wYTM5OHJXM2k1Wi96dmxuSXVYRDF5TlFqWENZRDdjSzd1?=
 =?iso-2022-jp?B?bEVaUmpXS1hwQkc1a3B6VkJacU1qS0wrSFJtR2xHMU05cXh3NXlXSHc0?=
 =?iso-2022-jp?B?OFdkdVBlSjQwajJldE01cTFZQTRJbUpQb3JLMHNFK0t5MFAxOVRoS3BP?=
 =?iso-2022-jp?B?NkFRUk8wYUZTV1J4dkF3UmEvVVZ0d1hKKytrcEtOcHV4WG90ejdZOXdC?=
 =?iso-2022-jp?B?MDQwZGtTU1BHamVRK2N3QzRoWThvNGJJZU1Cd241RFJvR2RJaXhBSjJa?=
 =?iso-2022-jp?B?SXdIWUo3THRVc3hra1d6T3hmcEF6ODdrL0lNMnY3Q1I4N2FhczV6L3VB?=
 =?iso-2022-jp?B?THBMQnlaemZJMG5oMm93Qks5MVFBcFk3dlVSV2x1dkNUVTJLVUdnYUpX?=
 =?iso-2022-jp?B?Tnh6aVVKOGxSUkNMNlg2VjNjNHk0ZUtoR2hkWWRyRzAxODZMUTRJMGNY?=
 =?iso-2022-jp?B?TFkxL3J5ano5U2JpOTV5VmpZVE8vckRkODJLdjdkVXM5Z3NFYlBBei9u?=
 =?iso-2022-jp?B?RDlzU0UyVXhQZ2RubWF4azZQb01HRk52WkNJZWY1ZUNOS3lGREM4cnhC?=
 =?iso-2022-jp?B?UE1SZVhueE5MLzZpL25DM3JpbGdmTytsemRmQ01jcnNtL3QyM2x1WFlj?=
 =?iso-2022-jp?B?Ni8xelNrdUdNeGFQUDhjRWVKV3BZcEw1ZFhpaUdQcHVXRXplV0FhazZj?=
 =?iso-2022-jp?B?TUY1elBSOFZCY1pKOUduSUFwakRoVThiVUZkVzJocXFQcm9ZckdBQXBR?=
 =?iso-2022-jp?B?ZEprdVpWSnpDLzZPWk03eWtieE5JN3hmQUh4b0k3RDYvQ3daTEx2MGxD?=
 =?iso-2022-jp?B?eGZ0TjBMRFgwQzRLVStUQnBKdFVuTC9GUnROSVRucURYbThHVDBlZzBI?=
 =?iso-2022-jp?B?amExNFp1R3oyV2ovcWp3NmN6V0o4K1lYVkdSbXhKL0h3Y3F2LzVoV0JV?=
 =?iso-2022-jp?B?MzduVkdMZHF4S3NCdlkxZzhvSW1SZXRLOWw5M0VRazR1cEM2TkRyeWRp?=
 =?iso-2022-jp?B?NUJHS0xSSzhEUzlUQ2kremdsY3pRTFdWbVk2YVl3ZHFUUnhSb0NKL1c4?=
 =?iso-2022-jp?B?anBXUEFpRUFUcm56THY3eG9Gd3AwNElXYWl6NEl6eDdzZlRNeTJQQXlz?=
 =?iso-2022-jp?B?NHRKZlVBbGY0OExkUWNBd210QUtZUElNQ2V5TFFURytCUHBTdnl6bzh3?=
 =?iso-2022-jp?B?a3lKYmlnUkhHeUhJTjZqSzFOUEN5VGdGbDI4c1VMcU1QTGJOTFhGejVG?=
 =?iso-2022-jp?B?aDlwQTEvRmc0clRPZk9pWHR5RkVCMnZvNm5pQmlWajk5M25wdzJYQjBG?=
 =?iso-2022-jp?B?ZUdFM0U0b2d6bGdHa21YY2s5NGx0Nzl2VmREWjc3b3d4UitOclpzM1lT?=
 =?iso-2022-jp?B?YThibnVPdDZRb1JDdksyOXhKRTR0SUNLY2duZG9KMGdKRG00SzYzYWVC?=
 =?iso-2022-jp?B?eEkrK3Y1OUZ2NGxRQ1cvekZuUzdMa1JkU0RDYzdIa1c1ejNidnQ1MDhJ?=
 =?iso-2022-jp?B?a0YyVEhhYnZma0U0TzcyUSt5ZWJJR2ZndldSbm16T21ldEJwN2VGekxv?=
 =?iso-2022-jp?B?MHFxZG5TOHl4b29ReWQ4ZUdDNThHWTIxQzNhb1pBdEU4ZTFIVEJkUFB6?=
 =?iso-2022-jp?B?elZlT0thVzl4YkpkMEVOK2dFbVlHS283S3h2WEJLZU83bGlnUTNzZExN?=
 =?iso-2022-jp?B?ODZxbnBXSXp5NCsvelJhNExlZm9hZE84NkxhYVVuQnowUmNNblRoYTJ5?=
 =?iso-2022-jp?B?N2xQOFpvK3Zib3YrZVEwMWdwRzBBZnFpYnkvaEJEaEJKdDRjREtucXd5?=
 =?iso-2022-jp?B?blJ2SHNYMUZjZmdpK3RFcS9CMEdpaGs1L2VlSGIybzRLVHI5alZzeksv?=
 =?iso-2022-jp?B?aEV5eVh5NzNyMTNic1JyckZKN0xtT25Rd0laV1Z6d0cxcXpSdmMxNDNM?=
 =?iso-2022-jp?B?T2ZqdG43dUt5TTdaVlRacE1IbVVwSkJWQ0lSdGVSUHpjM0thOXJ6NGZ0?=
 =?iso-2022-jp?B?TkcvdXV1anpvcjVLWVZ6NHpNQml3SXpUM055NmpsdjZZeEcwL29TenZn?=
 =?iso-2022-jp?B?NE1id3J4bXdsNERrZ0VFOTFZY3JTbkRsYzNERnFNM1Bia2NhNG1yT0hl?=
 =?iso-2022-jp?B?Y0ZuL0R2cWpqc1psRnU0UDlnOURhS3ExR3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?dkxnL09ZV2tmS0JpK0hlZ3ltb1lzZFZJeWUrTmxJQXA0czlCZnJOVWVY?=
 =?iso-2022-jp?B?M0k3dWdTUG9XVlhCa1MzTG1aV3llbFVwR1ZXbUdJTGkrS1VlVGx3MFhN?=
 =?iso-2022-jp?B?M3NHQmNOanlmemdBR0I2V0tCR3dxUE13eW9GazFHMHJDcHJPU1E5b2xS?=
 =?iso-2022-jp?B?QklYblFNbW96T2psK1pPUWRZcVdwaGdsSDNuc2dBUCtVY0o2dGcvL21l?=
 =?iso-2022-jp?B?d2lNRHZHSUdBeTFSei8rU0JyZzFidTB6dVJ3NFdNanQzaWZ3NFNRdHVI?=
 =?iso-2022-jp?B?NGFlMWdjbnZ1K3JnSmlnOTh4NVV2TE1MS2MyVHQ2cHJEekF4TlBXeVps?=
 =?iso-2022-jp?B?UWFEOUtoZ3N1S3ZLSzczdy9NcjdlZnJrSlY4dFNJd2lKTUdHdWE5c09x?=
 =?iso-2022-jp?B?Q3RLUGJ3cVRxTFAxWXprVUpxQlkzeVVIMXJ6ZjZWekkxRzNOVHpaSnYy?=
 =?iso-2022-jp?B?ekNtY05qTjNGbFc0dk11RDVpZTAvMWJIOUEvejhBc1NKaHNrbVhZY21m?=
 =?iso-2022-jp?B?ZmVnaWh5S0ljbEkvNEw0Rk0zNTRRNUtZK0pwaHJIazliMnBHaFdxcit6?=
 =?iso-2022-jp?B?T3huM1JnTXdMVWd6MGNDQitiWjdyNlQ4UzdKOGRWOTk4Y3RRa0x2V2Nv?=
 =?iso-2022-jp?B?NkgvQlRXZ3YyWDFkaFZwUVFHYlQxbUZJbFJqNk9FdEUzM3QyOStqZlJx?=
 =?iso-2022-jp?B?cGtRcy8rMW1tNmgvR2Ztbmk0aDEvanIrK1BzOThLVmJzZXJXYU5MRGxZ?=
 =?iso-2022-jp?B?QkJCQ0h4TmRxSjc5azlZNUxHNEQ0V0svNER4WWxYaGtVRlZ0OTBYZm5l?=
 =?iso-2022-jp?B?Ymc5ZjFwaGxpT1FBOWxJTEQrdHJVOEVuTTl6UHJ3WGFuZHFmV0xuSHhw?=
 =?iso-2022-jp?B?bkRJVUs4b0JnaFVTS1prenJ3bEorOUMrdkQzb1o0NlRZZHRUa3UyZW1p?=
 =?iso-2022-jp?B?QmxoNTJqWWJHYXJXVXJ2aENTQTJVRVEwc3dxeTMyNSs1T2Jjc3MyMDJj?=
 =?iso-2022-jp?B?K3hGT1dOTU5iVVBGSktiWlFKenRGTC9aSVJiekxTeFJ4YXorSUZoeDJv?=
 =?iso-2022-jp?B?VnY0R1orSWI3d25zN251L1dOK0JQTmRoR0Q3UjRYblA0eUtkTmJ3bERo?=
 =?iso-2022-jp?B?SGFGNGhhRjJ6R0xwcjRSMU1ENUdkQ1RXVC80Uk1hQzRCT3lWWi9jdnEz?=
 =?iso-2022-jp?B?SVJKOEI0OFMxSHlrYnA5ZXIzU2pwRDRWL0IyMkZldWVKMkdZVTE2Nm1H?=
 =?iso-2022-jp?B?WDZLTFlZVG5yZXlhRGZFYjk1QVNWVjRFeFpGU284aWdFcW9ETFNwcVFV?=
 =?iso-2022-jp?B?YnNMNGlaQ3dhNzFCekl2OWxjRDFocTdlMVNmVFJzTmlUdmkwWnlISHAz?=
 =?iso-2022-jp?B?Wm5jWHhaQ2FqcGxTKzhsVVhXL29lRjZyV2NOTDUwL0FweU9DVlVMZmpF?=
 =?iso-2022-jp?B?VmpTZVZxU2ZOcnpBeTdScCtTc3A2QkV6REFBTG9HU2U2WmRoUXpLSCtG?=
 =?iso-2022-jp?B?bjBCUHdQQTllTjJMNU5TSnFTRlY3cC94SUFqdmE4Qm54djljaDJJWllO?=
 =?iso-2022-jp?B?Q2Rtd1FJVnBSNXZ0SUp1d1VRPT0=?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8ccdca-73a6-4ccc-5407-08dbaf624551
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 05:21:20.7637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZIkHSScribKur8IPEWwC1EsPOeWnHjdvRiK9nAoGq5MJx3uMh9XINOJeeWCWalUlQesSGhOLpgYvmC6XSOGxYZbnCvznhvK5JtX9RsWrZic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11790
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

> Sub-NUMA Cluster divides CPUs sharing an L3 cache into separate NUMA
> nodes. Systems may support splitting into either two or four nodes.
>=20
> When SNC mode is enabled the effective amount of L3 cache available for
> allocation is divided by the number of nodes per L3.
>=20
> Detect which SNC mode is active by comparing the number of CPUs that shar=
e
> a cache with CPU0, with the number of CPUs on node0.
>=20
> This gives some hope of tests passing. But additional test infrastructure
> changes are needed to bind tests to nodes and guarantee memory allocation
> from the local node.
>=20
> Reported-by: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  tools/testing/selftests/resctrl/resctrl.h   |  1 +
>  tools/testing/selftests/resctrl/resctrlfs.c | 57
> +++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>=20
> diff --git a/tools/testing/selftests/resctrl/resctrl.h
> b/tools/testing/selftests/resctrl/resctrl.h
> index 87e39456dee0..a8b43210b573 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -13,6 +13,7 @@
>  #include <signal.h>
>  #include <dirent.h>
>  #include <stdbool.h>
> +#include <ctype.h>
>  #include <sys/stat.h>
>  #include <sys/ioctl.h>
>  #include <sys/mount.h>
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c
> b/tools/testing/selftests/resctrl/resctrlfs.c
> index fb00245dee92..79eecbf9f863 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -130,6 +130,61 @@ int get_resource_id(int cpu_no, int *resource_id)
>  	return 0;
>  }
>=20
> +/*
> + * Count number of CPUs in a /sys bit map  */ static int
> +count_sys_bitmap_bits(char *name) {
> +	FILE *fp =3D fopen(name, "r");
> +	int count =3D 0, c;
> +
> +	if (!fp)
> +		return 0;
> +
> +	while ((c =3D fgetc(fp)) !=3D EOF) {
> +		if (!isxdigit(c))
> +			continue;
> +		switch (c) {
> +		case 'f':
> +			count++;
> +		case '7': case 'b': case 'd': case 'e':
> +			count++;
> +		case '3': case '5': case '6': case '9': case 'a': case 'c':
> +			count++;
> +		case '1': case '2': case '4': case '8':
> +			count++;
> +		}
> +	}
> +	fclose(fp);
> +
> +	return count;
> +}
> +
> +/*
> + * Detect SNC by compating #CPUs in node0 with #CPUs sharing LLC with
> +CPU0
> + * Try to get this right, even if a few CPUs are offline so that the
> +number
> + * of CPUs in node0 is not exactly half or a quarter of the CPUs
> +sharing the
> + * LLC of CPU0.
> + */
> +static int snc_ways(void)
> +{
> +	int node_cpus, cache_cpus;
> +
> +	node_cpus =3D
> count_sys_bitmap_bits("/sys/devices/system/node/node0/cpumap");
> +	cache_cpus =3D
> +count_sys_bitmap_bits("/sys/devices/system/cpu/cpu0/cache/index3/sh
> ared
> +_cpu_map");
> +
> +	if (!node_cpus || !cache_cpus) {
> +		fprintf(stderr, "Warning could not determine Sub-NUMA
> Cluster mode\n");
> +		return 1;
> +	}
> +
> +	if (4 * node_cpus >=3D cache_cpus)
> +		return 4;
> +	else if (2 * node_cpus >=3D cache_cpus)
> +		return 2;


If "4 * node_cpus >=3D cache_cpus " is not true=1B$B!$=1B(B
"2 * node_cpus >=3D cache_cpus" will never be true.
Is it the following code?

+	if (2 * node_cpus >=3D cache_cpus)
+		return 2;
+	else if (4 * node_cpus >=3D cache_cpus)
+		return 4;

Best regards,
Shaopeng TAN
