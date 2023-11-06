Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFD77E2E31
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjKFUaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjKFUao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:30:44 -0500
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE7FD75;
        Mon,  6 Nov 2023 12:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=448; q=dns/txt; s=iport;
  t=1699302641; x=1700512241;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KS2X6VDEpUu3NmbSWrb0eMgZFM4x5cP416IML0dwHR8=;
  b=hggtNFQMr6lCNuoLKI1Q6MNXli5fuxatGv6TZI/ZwcRYj2FoYByzqvWI
   NN9RZIzvOGWM+YbYkzM4MIoUk9+jacWnHdAx5qId6+mbBUXiNmwsSKNv6
   u/6sKDGB9/745XN5dlYcaMj8uakuxvZ06vu+Pckax6p0MpggX0KM0Rnt0
   0=;
X-CSE-ConnectionGUID: wLQOumuWR524nDo+hnmUag==
X-CSE-MsgGUID: rVgqe021TTaRulox0CsH7g==
X-IPAS-Result: =?us-ascii?q?A0AnAAClS0llmJtdJa1aHQEBAQEJARIBBQUBQCWBFggBC?=
 =?us-ascii?q?wGBZlJ4WzxIhFKDTAOETl+IZZ1+gSUDVg8BAQENAQFEBAEBhQYCFocQAiY0C?=
 =?us-ascii?q?Q4BAgICAQEBAQMCAwEBAQEBAQECAQEFAQEBAgEHBBQBAQEBAQEBAR4ZBQ4QJ?=
 =?us-ascii?q?4VoDQiGRAEBAQEDEhEEDQwBATcBDwIBCA4KAgImAgICMBUQAgQBDQUIGoJcg?=
 =?us-ascii?q?l8DAaBhAYFAAoooen8zgQGCCQEBBgQFsmwJgRouAYgJAYFQiDYnG4INgVeCN?=
 =?us-ascii?q?zE+gmECgWKDWTmCL4kuBzKCIoNUjQ8Jd0dwGwMHA4EAECsHBDAbBwYJFC0jB?=
 =?us-ascii?q?lEELSQJExI+BIFjgVEKgQI/Dw4Rgj8iAgc2NhlIglgJFQw1SnYQKgQUF4ERB?=
 =?us-ascii?q?GoFGBUeNxESFw0DCHYdAhEjPAMFAwQzChINCyEFFEMDQgZJCwMCGgUDAwSBN?=
 =?us-ascii?q?gUNHgIQGgYNJwMDE00CEBQDOwMDBgMLMQMwVUQMUANsHzYJPAsEDB8CGx4NJ?=
 =?us-ascii?q?ygCNUMDEQUSAhgDJANEHUADC209NRQbBQQ7KVkFpReWHkmuMwqEDKE/F4NuA?=
 =?us-ascii?q?RKMc5kMmD4ggi+lWQIEAgQFAg4BAQaBYzqBW3AVgyJSGQ+OIBkfg0CPeXY7A?=
 =?us-ascii?q?gcLAQEDCYtKAQE?=
IronPort-PHdr: A9a23:I2px6xAzH2KwWYfqJWqpUyQVoBdPi9zP1kY9454jjfdJaqu8usikN
 03E7vIrh1jMDs3X6PNB3vLfqLuoGXcB7pCIrG0YfdRSWgUEh8Qbk01oAMOMBUDhav+/Ryc7B
 89FElRi+iLzKlBbTf73fEaauXiu9XgXExT7OxByI7H2E5TOjsC+1Mi5+obYZENDgz/uKb93J
 Q+9+B3YrdJewZM3M7s40BLPvnpOdqxaxHg9I1WVkle06pK7/YVo9GJbvPdJyg==
IronPort-Data: A9a23:qfOD86keJpjaSFStUMVqc1vo5gy8JkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIXWG3SPq2LYGv2ctsiYIq39BwB6sKAxoBiGwdrqys0EFtH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaB4E/rav649SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+5a31GONgWYuaTtNs/zb83uDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSq
 zHrlezREsvxpn/BO/v9+lrJWhRiro36YWBivkFrt52K2XCukMCdPpETb5LwYW8P49mAcksYJ
 N9l7fRcQi9xVkHAdXh0vxRwS0lD0aN6FLDvPlyGltGW0nL8LiGwxdlpT0EwOLAR9bMiaY1O3
 aRwxDEldBuPgae9x6i2D7UqjcU4J86tN4Qa0p1i5WiGVrB9HtaSGOOTuIIwMDQY3qiiGd7db
 tAFaD5mbzzLYgZEPREcD5dWcOKA3yKlKWAC9gLFzUYxy3LtwxV8iOK0DObcQMGOQtUNtV24+
 W2TqgwVBTlDZIDAllJp6EmEgu7JgDO+W48IErC83uBljUfVxWEJDhASE1yhrpGRjk+4RsIaM
 EcP+wIwoqUosk+mVN/wW1u/unHsg/IHc8BbH+t/4waXx++IpQ2YHWMDCDVGbbTKqfPaWxQ18
 maugtb0OgYy6uGTZXXe9rGRkDq9bH19wXA5WQcISg4M4t/GqY41jw7SQtsLLEJTpoCrcd0X6
 23axBXSl4n/nuZQiPrmpQGvbyaE48mWHlRst207S0r8tlshDLNJcbBE/rQy0BqtBJySQl/Et
 38elo3CqusPFpqK0ieKRY3h/Y1FBd7bbFUwYnY2QvHNEghBHVb/J+i8BxkifC9U3j4sI2OBX
 aMqkVo5CGVvFHWrd7RrRIm6Ft4ny6Ptffy8CKGFNIsTPsQpJFLflM2LWaJ29z61+KTLuf9nU
 ap3je7wZZrnIf09lWHvF7t1PUEDnHhnmws/uqwXPzz+gebBOxZ5uJ8OMUCFaagi/biYrQDOm
 +uzxOPUoyizpNbWO3GNmaZKdAhiBSFiWfje9ZcNHsbdeVUOJY3UI6KLqV/XU9Y7z/09eyah1
 izVZ3K0P3Kk3iKfcFXbNS85AF4tNL4mxU8G0eUXFQ/A81AoYJ2k6+EUcJ5fQFXt3LULISJcJ
 xXdR/i9Pw==
IronPort-HdrOrdr: A9a23:95V/ta8Cpr+gUFKajPNuk+Gddr1zdoMgy1knxilNoENuA6+lfp
 GV/MjziyWUtN9IYgBQpTnhAsW9qXO1z+8N3WBjB8bTYOCAghrnEGgC1/qs/9SEIVydygcz79
 YcT0ETMqyWMbE+t7eF3ODaKadg/DDkytHVuQ629R4EJm8aDtAF0+46MHflLqQcfng/OXNNLu
 vn2iMxnUvaRZ14VLXcOlA1G8L4i5ngkpXgbRQaBxghxjWvoFqTgoLSIlyz5DtbdylA74sD3A
 H+/jAR4J/Nj9iLjjvnk0PD5ZVfn9XsjvFZAtaXt8QTIjLwzi61eYVIQdS5zXMIidDqzGxvvM
 jHoh8mMcg2wWjWZHuJrRzk3BSl+Coy6kXl1USTjRLY0I7ErXMBeo98bLBiA1zkAnkbzZdBOW
 VwrjukXq9sfFf9deLGloD1vl9R5xGJSDEZ4J0uZjRkIPkjgflq3MwiFIc/KuZcIMo8g7pXSt
 VGHYXS4u1bfkidaG2ctm5zwMa0VnB2BRueRFMe0/blmQS+sUoJh3fw/vZv1Uso5dY4Ud1J9u
 7EOqNnmPVHSdIXd7t0AKMETdGsAmLATBrQOCbKSG6XWJ0vKjbIsdr68b817OaldNgBy4Yzgo
 3IVBdduXQpc0zjBMWS1NlA8wzLQm+6QTPxo/suqqRRq/n5Xv7mICeDQFchn4+ppOgeGNTSX7
 KpNJdfE5bYXCLT8EZyrnvDsrVpWA4juZcuy6MGsnq107b2FrE=
X-Talos-CUID: 9a23:am3h/29/w1TwToT2MHCVv1EwI+c4d2Di9iqKf0mUDiVpTrioQFDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A1LdNnQ9ByandCmx7IOgiGKOQf91W7L2jUBpUrak?=
 =?us-ascii?q?PgdSAMjwoECy90zviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 20:30:40 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
        by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id 3A6KUWts003500
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 20:30:37 GMT
X-CSE-ConnectionGUID: 8aKAGLVZSN6RD7Z324wpJw==
X-CSE-MsgGUID: osCu+knPTOOh+Mf/lPNMWg==
Authentication-Results: alln-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,282,1694736000"; 
   d="scan'208";a="7286059"
Received: from mail-bn8nam04lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by alln-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 20:30:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTNkHuh3iihcy7oumUbUFeWiGm+3nNBPQ15WETOPLwxRDSHOVv+u3981g3OSOCcHDF0N2SOEAhdMam12pU8cX+OmJ/m7dJfRjao/0mcdgymst8JTij+O1Y3MqKHQU3z4r23GlvOOUcqLxQXDTRvwf7/uN+JcVe5O2R92ZvDAsRzDl/W2XDO0Fw+MJFZaYlVr6RoKNowAWe2Sw2+QPlFqbS5Nc26p0964Sj+gjo5KQs3eqCsmt8OanfuJwv3zkZYiqE2e+yQ7CHcMmhN7LeQYKGxYHIo3fd1pWLe8AZzG6Kx9wuZLZZJPt8lYhitiboeXJDkTrTJblke8P1a43Yz/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KS2X6VDEpUu3NmbSWrb0eMgZFM4x5cP416IML0dwHR8=;
 b=bG/RIemJk2UkAVvjlfkkNbC6YR8PV+ojL3xIXZKcKaQpCPTjVEDJfXFspt2I0vO2FJqcrt7ownAcu3vQQvv+sF5g3aRMutjMjSJiIVUSs5eJ83O8dCEcK3pYoUG/mMHsEAgaALWmesfv+tv2y+zS/8HPxTaGZepMhGa264vX+T8Mh9tfzRb83E8P5YS6Ux1TQbMnhcwUhZ3vy9fDWHml+6YDinV1ZsJq+YcmSoWCjtIniJJWFsrDngkEXe/0oOigQIJeILw8accTM6sJSrOfCDqAgxuRmkhZRfe508g33Hky3Xkn1ow28FR+K0CDHVVfh23W5rR3o3YbST6BSYrv/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KS2X6VDEpUu3NmbSWrb0eMgZFM4x5cP416IML0dwHR8=;
 b=OpYDsG0oZYBimRcqs8as8on1LdyzdA02ueE4bTj2ld4xtkUq2h2nXV/o33jwSdZFvYJTRjOehIHSy6wmNSbOPkmVRV9Mdm8CKCwwIpouMwXvN9Y27QBT3CtYPd463GUfPT9uTmIwYfCVKeRTHhJ9RGibuDDZMpFREpl088y7VX0=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by CYXPR11MB8710.namprd11.prod.outlook.com (2603:10b6:930:da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 20:30:28 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 20:30:28 +0000
From:   "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To:     Hannes Reinecke <hare@suse.de>,
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
Subject: RE: [PATCH v2 13/13] scsi: fnic: Improve logs and add support for
 multiqueue (MQ)
Thread-Topic: [PATCH v2 13/13] scsi: fnic: Improve logs and add support for
 multiqueue (MQ)
Thread-Index: AQHaCP/2MFkSdLeZq0m6/Pp6+iIsGLBmtxeAgAcWfLA=
Date:   Mon, 6 Nov 2023 20:30:28 +0000
Message-ID: <SJ0PR11MB589642B4527EE548E6496281C3AAA@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-14-kartilak@cisco.com>
 <5fb2a4d0-4b7c-4cf6-a8ed-752e85acd088@suse.de>
In-Reply-To: <5fb2a4d0-4b7c-4cf6-a8ed-752e85acd088@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|CYXPR11MB8710:EE_
x-ms-office365-filtering-correlation-id: a308acb5-a180-40fd-8866-08dbdf0736fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fQTlNlCj+nc60qaJrsi684iGUQyCnbiE0hwJHmVuDi2Sj+LKp1/i7lTYSDJ0jRe8wCYYSVN4UK4nHJNd94CgnyFMz6LBvImd0truvUSK0ke5SqOZVB9qzZkW5iXdg/mrvoOnEM4SgYwa/ouWkVfjL/dNTBmHzxrD9XYZz7xVBnZC9pcyk4k9bTnVMqa2GGSRQPoRz/wpqijgCAiisEWpV6fN634RR/Y6BpPBPFrt7jN6fwvXZqdZrU4VseuYqaBoyQTUagJ2ObDLrSSAX/JEDNLNo6R/RXSin2IUiajaSgTjZjIetf0vwjbzqUhqcllwv3aCVJDaaxOZZPOy3OL7ATir3onaglyN7tBHDgvBnR1cWIdnmSMYwPSdAOuAZ4vA9tn19NKplcUdpwDdIAD1Oi74HdLSc/FkAumgwEcFI1A2/eO6RyO9d1ahNTBGT1QfoNLhXqWd2BWTvjLCNTnVSZ2mZz4qKuSthmvF1YZsMN/AO0prIRNjE0mnbsxIeSguBUpzrJJoORsJXPYtVhsd/0ATSeKVaPqL/41yvuP46JDjCgBcH5X2xuCTnF/2lS+qVTxLh4SUIatLCJihonn6t1gyg1bZ7lStJHtwnKCwzLn73zQWh68pP5zfkouaOa+O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(478600001)(41300700001)(9686003)(7696005)(6506007)(53546011)(71200400001)(83380400001)(8936002)(8676002)(52536014)(4326008)(76116006)(2906002)(5660300002)(66556008)(64756008)(66446008)(6636002)(110136005)(66476007)(66946007)(316002)(54906003)(38100700002)(122000001)(86362001)(558084003)(55016003)(38070700009)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MitIVFZHdVhWL1huc1k0ZWN4Yys0R1o3eEo1WjNZa1R0UG9uemMvQ0hCVkxW?=
 =?utf-8?B?QmM5MUZ2c0U4SXUyODRDajRncXJlQ0toVHlCL0xXWEZLQmo0dUJlcmFjWUhV?=
 =?utf-8?B?UjRzUVh1M041VGhHRnVNRk1NU1FwZ1pxaEphQjNXYVh5NHVzWVl5S2trMkJF?=
 =?utf-8?B?cDNyRm1QTzQ2emxmWFlBaGNnQUxCSXlGbXRwNVU2cFpJZkppcC8rR2lpcnRL?=
 =?utf-8?B?SC93NlBKNTNsVnNvMXdmYy9HcCtDVEswY3hNMkQzb2wzNmJVT2VjZkorY0Iz?=
 =?utf-8?B?UjNjYXlwcVdPZ3BoTVZ4ODY0WG1LVHM2aXBBMXR4bEhNODNKci9WV1pCRTZR?=
 =?utf-8?B?OFJ2cnJ0TEV3ZFQ5RE5aeDFtZTREaFR1aE9kRnNJM1NadGloS3JEcTcrMnY3?=
 =?utf-8?B?eFg4K2ZTQnVGdm54SWROc1JocHJMOXhJTk1XZHVwMzF6RmQ1UTB3ZCswNk1Y?=
 =?utf-8?B?a1AzV0hnTlBQYzd5Q21vTG1FWHptbm5tL3dQOXUxaFE0K0xCZW1Qa0tYMUJw?=
 =?utf-8?B?TStGY09uTXphLzRFeWlZcGtQTk16OXpBZHZLZ2ZyTllvQTlaS2RtMjZ1Y21a?=
 =?utf-8?B?ZDJ2aE9zbnZQYnd3ejlzWWxlQXBoQVB0bS9CYW90ODZaeEROSUVhdFh1Wkcr?=
 =?utf-8?B?UWVyeUpWcXdTVkJOKzdxUjNQRlRwRWRaNUZpRkorK09yd2lJd0kxVXhEYzFi?=
 =?utf-8?B?NlRyYUhMR3dqQWNGNWMvWXM1REIxWkE4bStKVnd4TzhtVUFLNEUrWll3WU1D?=
 =?utf-8?B?TDFuZlZSTGJ0OW1SZ1NlM2ZZc3Iwc1lwTFFkbWVDR1JkZUNTd1FaZ2lNZytT?=
 =?utf-8?B?N1Y1eTdoU1U4V3IzMjBkRVNYRlEzNWhEZk1BVUVTODl4RTlUMHg5dUJmMk4r?=
 =?utf-8?B?QjJkMmRJN2h6ZzgyZW0xc2hIMG9QVjZzTXgwV1JEMEVYcE5CNEdLenNHYVhQ?=
 =?utf-8?B?Z1JFOWhVc1RJNUNwR2VtUGUyWmdSZDBvTzdFenZpTlNkd05wQytyanJhcE4v?=
 =?utf-8?B?Z3NmeDFnTHB1U2xaTVJENklVMU81MWdLUkdGeVNNNm8vYnZmV2QxN2Z1eUpn?=
 =?utf-8?B?SzhtNklXUGY4VzZ4Nk5BSDJ4ZzdxU0VIZTZyVmxiQ25JcnVMaEJ4Z0VXUTNN?=
 =?utf-8?B?MVpFcnlqRGEzcjlzRk1IcGpSd2ZCQVVhZXpscjBxN2Zxc2NWSXZRWDlpQ0hY?=
 =?utf-8?B?Z3ZpUTZ4RHNzMnlvM0Y3RHlGc1VQbXZjaHF6WHJBa3hWbWtjYXlLbUFFQkZT?=
 =?utf-8?B?MnBXbGNtcmVKbytLTjI5L2tOSXF2S212Z2JKbDNtSzdnRDV5ZnlaRE1hbms2?=
 =?utf-8?B?clBhTEZmL1p6WDhva2ZyVm9YVVRVNjVWUTllMTk3ejltNFdPczUzaHBtc2lK?=
 =?utf-8?B?ZndieFU3ZS9uTjB6YW9CdjU5ZlpSNGR1UXY5SmpDM3lNVCt6OU9laDR4cEhh?=
 =?utf-8?B?WmxERWltS3NGK0V3dlZoWmdmb1ArR1UyUFVEZ1RrK29nTkNMcHlUeWlyS282?=
 =?utf-8?B?YUZpSi9ZTDJuN0VhYkI0RlhKWkJ6WXlyUXdWT0lQQzB3TUFFUDIyWWh1KzFQ?=
 =?utf-8?B?NDB1YmxUTW9la09LM0VocktabzVWanRFNUpSWUpDZDlDQUtkU2dhbW1pSExa?=
 =?utf-8?B?bFZZSkRyeGtUbXp0OTRiejQ3ZmFjajZETDZjZzRHbjlwc3FjbFRKWFN1N2No?=
 =?utf-8?B?WEVxblpZdDVXS1l0d2Zlc3ZlMkVlcUN1eGg0VklGaXZWNllMT01KdlpiTVZW?=
 =?utf-8?B?YUZodHM4VUpuazFjeGY2QnZ3NDdYTkNoempVQUJFRjAwN0lZVTRNdW5wMFNK?=
 =?utf-8?B?NUFyMkVHUXFQNmd4MnNISUZZWENnM2I5WVg0NWpvRzhwUWtMMnRPU3J3Ri9O?=
 =?utf-8?B?M0REc29Da1lBbzRvSWZhWWcwbzUzdnFBcDZmZksyY0IwTGZWU01Sb3lRU3VR?=
 =?utf-8?B?UW1SMmtnWlBxc0hwSVQyRU5jei81OVV6YzZ3YjdTRHduRTc4bHVGdEw4SDln?=
 =?utf-8?B?RGltdmlwRHhvWVd2aDJmcWVjSjBkZ1RjRURDaXZzb2FyTmRGb2h6SlZmRzFH?=
 =?utf-8?B?NXl6Y205eUpWT2NHVkxGS2JGbUFCQllFMk5OVE0zeDFaRFJQU0VFSzFUUnpU?=
 =?utf-8?B?NktuUmpjMWhCZS9EOTlXaXQyU2Irb1dJZFQ3dTFNUncrTXRER2M4bmdvU0Rh?=
 =?utf-8?Q?t9C1lvVCPnRmalQtDdXKkvo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a308acb5-a180-40fd-8866-08dbdf0736fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 20:30:28.2822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lut0+LSmFKVbGeJntNUcli6+cQGYp8/m3EMPED1grv0T6xvSRQPZexXwL3Zw/t0aRO/mgG3rg3VX6DnbjqVHgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8710
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
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

T24gVGh1cnNkYXksIE5vdmVtYmVyIDIsIDIwMjMgMToxNCBBTSwgSGFubmVzIFJlaW5lY2tlIDxo
YXJlQHN1c2UuZGU+IHdyb3RlOg0KPg0KPiBTZWUgbXkgY29tbWVudHMgdG8gdGhlIHByZXZpb3Vz
IHBhdGNoLiBQbGVhc2UgdXBkYXRlIEZOSUNfU0NTSV9EQkcoKSB0byBhY2NlcHQgYW4gJ2ZuaWMn
IHBhcmFtZXRlciBpbnN0ZWFkIG9mICdmbmljLT5scG9ydC0+aG9zdCcsIGFuZCBnZW5lcmF0ZSB0
aGUgJ2ZuaWM8JWQ+JyBoZXJlIGluIHRoZSBtYWNyby4NCj4NCg0KU3VyZSwgSSdsbCBtYWtlIHN1
aXRhYmxlIGNoYW5nZXMgaW4gdjMuDQoNClJlZ2FyZHMsDQpLYXJhbg0K
