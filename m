Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460308065E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376461AbjLFDxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjLFDxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:53:10 -0500
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E44018D;
        Tue,  5 Dec 2023 19:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1841; q=dns/txt; s=iport;
  t=1701834796; x=1703044396;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JZhrDtKrJOBIabiyhzTmORAvpCnH1dYSUitnUNAqMZA=;
  b=dEENiwROLubJgonYu95AwgtUlFHoIxQicgNHYc4Xaev9z/7K6wN+VAL+
   WkyCYNBUIJoDhZ6yUmdYU8d17/k76ywf0+iWwP/p2Z4M99NH+/CDl6Vng
   WbUhFBBwHrlHBsBWi1dR2zlImsVlUFC0+SSOmrKARNvc5+4obAtYP/eXK
   c=;
X-CSE-ConnectionGUID: 6+NGyz+/R/6br7OLKbjytg==
X-CSE-MsgGUID: 1+B7K6nzS2aKfsHteUAPSw==
X-IPAS-Result: =?us-ascii?q?A0AtAABS729lmJxdJa1QCh0BAQEBCQESAQUFAUAlgRYIA?=
 =?us-ascii?q?QsBgWZSeVsqEkiIHgOETl+GRIIiA51+gSUDVg8BAQENAQFEBAEBhQYChykCJ?=
 =?us-ascii?q?jQJDgECBAEBAQEDAgMBAQEBAQEBAgEBBQEBAQIBBwQUAQEBAQEBAQEeGQUOE?=
 =?us-ascii?q?CeFdQiGPQEBAQECARIVEz8FCwIBCBEDAQIBHQEQMh0IAgQOBQgagl6CPCMDA?=
 =?us-ascii?q?aJNAYFAAoooeIEBM4EBghUFsnmBSAGIDQGKDicbgg2BV4JoPoQWL4QSgi8Ei?=
 =?us-ascii?q?RoHMoIhgykpkDF+R3AdAwcDfw8rBwQtGwcGCRQtIwZRBCghCRMSPgSBXYFSC?=
 =?us-ascii?q?n8/Dw4Rgj4iAgc2NhlIglsVDDVKdRAqBBQXgRIEagUWEx43ERIXDQMIdB0CM?=
 =?us-ascii?q?jwDBQMEMwoSDQshBRRCA0IGSQsDAhoFAwMEgTMFDR4CEBoGDCcDAxJJAhAUA?=
 =?us-ascii?q?zsDAwYDCzEDMFVEDE8Dax82CTwLBAwfAhseDScjAixCAxEFEgIWAyQWBDYRC?=
 =?us-ascii?q?QsoAy8GOAITDAYGCV4mFgkEJwMIBANhA0QdQAMLbT01FBsFBGRZBaMxaYIuE?=
 =?us-ascii?q?kdHASmWI5oWlG0KhA+hQheEAYxzmRKYQqgvAgQCBAUCDgEBBoFjOoFbcBWDI?=
 =?us-ascii?q?lIZD445k1h2OwIHCwEBAwmKYQEB?=
IronPort-PHdr: A9a23:I+W4MBEaB0Kclaaltu4fM51Gfu4Y04WdBeZdwpMjj7QLdbys4NG+e
 kfe/v5qylTOWNaT5/FFjr/Ourv7ESwb4JmHuWwfapEESRIfiMsXkgBhSM6IAEH2NrjrOgQxH
 d9JUxlu+HToeVNNFpPGbkbJ6ma38SZUHxz+MQRvIeGgGYfIk8Wz3uOa8JzIaAIOjz24Mvt+K
 RysplDJv9INyct6f78swwHApGdJfekeyWJzcFSUmRu9rsvl9594+CMWsPUkn/M=
IronPort-Data: A9a23:1N+DyKvCW9VVpO4z8QvFMhxuk+fnVHZeMUV32f8akzHdYApBsoF/q
 tZmKTiGPfeJMWGhLYogbdji8R5V78XVm9JiSlM/+SE2FHlHgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0rrav656yAkiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuHZDdJ5xYuajhPsvjb9ks21BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 44vG5ngows1Vz90Yj+Uuu6Tnn8iG9Y+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0HgkmVZCq9oMrLlDh8uq83l+FNEGrnf90U2YSHoca6/p4VDQmG
 fwwcFjhbziZjO6whbm8UOQp24IoLdLgO8UUvXQIITPxVKl9B8ucBfSRo4YFgl/chegWdRraT
 8kQcyZuaB3DSxZOIVwQTpk5mY9Eg1GmLmEE8ArO/fFfD277lU9bj5uzNsjuINWpS951gkulj
 1r94DGsav0dHIfCkWXeqC3EavX0tSf6Xp8CUb617PhnhHWNyWEJTh4bT122pb++kEHWc9ZeL
 VEEvzEltqka6kOmVJ/+Uge+rXrCuQQTM+e8CMUg4w2Lj6HT+QvcWy4PTyVKb5ots8peqSEWO
 kGhwZDPKi198/qvDiyX7OiziRC4OzkJIjpXDcMbdjct797mqYA1qxvASNd/DaK45uEZ/xmum
 1hmSwBg390uYd436kmtwbzQb9uRSnXhVAU54EDcWXioq14/b4++bIvu4l/ehRqhEGp7Zgfb1
 JTns5HChAzrMX1rvHDXKAnqNO3wj8tpyBWG3TZS82AJrlxBAUKLc4FK+y1ZL0x0KMsCcjKBS
 BaM4VoBvMYLYybzPfMfj2eN5yICk/KI+TPNCKm8UzaySsEoHON61Hg3OhHOhziFfLYEyvhjY
 P93jvpA/V5BVPw4l2DpLwvs+bQq3Ss5jXjCXoz2yg/v0LyVIhaopUQtbjOzghQCxPrc+m39q
 o8HX+PTkkk3eLOlOEH/r9VMRW3m2FBmX/gaXeQNKL7aSuencUl8Y8LsLUQJItI/z/gPzLeZr
 xlQmCZwkTLCuJEOEi3TAlhLY7L0VpE5pnU+VRHA937xs5T/Se5DNJsiSqY=
IronPort-HdrOrdr: A9a23:zwYJjqlkxGKX0JoJGSTo4GPUp0PpDfNjiWdD5ihNYBxZY6Wkfp
 +V7ZcmPE7P6Ar5BktApTnZAtj/fZq9z/JICYl4B8bFYOCUghrYEGgE1/qs/9SAIVyzygcz79
 YbT0ETMqyVMbE+t7eE3ODaKadv/DDkytHUuQ629R4EJm8aCdAE0+46MHfmLqQcfng+OXNNLu
 vm2iMxnUvZRZ14VLXdOlA1G8L4i5ngkpXgbRQaBxghxjWvoFqTgoLSIlyz5DtbdylA74sD3A
 H+/jAR4J/Nj9iLjjvnk0PD5ZVfn9XsjvFZAtaXt8QTIjLwzi61eYVIQdS5zXAIidDqzGxvvM
 jHoh8mMcg2wWjWZHuJrRzk3BSl+Coy6kXl1USTjRLY0I/ErXMBeoh8bLBiA1/kAnkbzZZBOW
 VwriSkXq9sfFb9deLGloH1vl9R5xKJSDEZ4J4uZjRkIPgjgflq3M0iFIc/KuZbIMo8g7pXS9
 VGHYXS4u1bfkidaG2ctm5zwMa0VnB2BRueRFMe0/blmAS+sUoJhnfw/vZv1kso5dY4Ud1J9u
 7EOqNnmPVHSdIXd7t0AKMETdGsAmLATBrQOCbKSG6XWZ0vKjbIsdr68b817OaldNgBy4Yzgo
 3IVBdduXQpc0zjBMWS1NlA8wzLQm+6QTPxo/suraRRq/n5Xv7mICeDQFchn4+ppOgeGNTSX7
 KpNJdfE5bYXB3T8EZyrnrDsrVpWA0juZcuy6QGsnq107f2FrE=
X-Talos-CUID: 9a23:KuSOEm6A6Xww7gC/FNssqg0yNdE3MTrniynaORCfLUVjSqyJRgrF
X-Talos-MUID: 9a23:EMtqTgU6q/f1Sl3q/Gavrm5BasF62P6nK04WsYkLhuC8DjMlbg==
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 03:53:15 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
        by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 3B63rEMd010480
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Dec 2023 03:53:15 GMT
X-CSE-ConnectionGUID: obTFe4sYQgalKHHxYlr5HA==
X-CSE-MsgGUID: fQCau9YCRR6ru39t3LW00w==
Authentication-Results: alln-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.04,254,1695686400"; 
   d="scan'208";a="11748177"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by alln-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 03:53:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZkwvboNcBhiXxMwBT8fUXTXWuzlsn7/guwN8zOKunlKockkrR3rP1N0zulh90dppAypWGO5PB3dSJvWTZm+oIwaA4UO4nrryPTRfgb+W4FQfyaQ5IjC0Lm7m7Y78lbWljFE+kSBY4qSZZqEkvR96X8XbpUjbiQoGtES13jSZ0ODYScdwuo9h2jZhLY1KoJZVdZ948uk0kblDIQhbpcGda0USJE9LiOTIivdTTsmpMf3VGXlhK+29JIK3ICiLuoYOUWAKRqtqmMzuYloNWCnqNiQUtePCI1pC08h8d1wXwgwmSrr30x+oV+rZ9ekQnP8J5sW5R/crNBMdLjAUcY1AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GP2Ff6c+2LcGQxGD5Y2AX3h/2WUhhBs6GqesK+kG14I=;
 b=ON/ii9LUwkaieWuB4Ge5oJ0Dfgn5UQsIBIaBG7MwohPIpWHCmNaBRr+TIRbOdPXvhx1OHDjVYT+ZXfLBD17vSLEhgDEdl2NF1BOE9ofXKiheEyKM+nuD82g+qr3WweTvkvzomxj7IeDY9KA+vEH8eFIQ20Ag61rllVLyNgvGqJD4TKHQcOsDoYuc1EepSkc+7X/LHwP+Atr+yj4NCKMqORnM1BTtHtsrDx7Kb4r/+YZN4ETq/9PsYFyv5YBRJSZ20MuOnJ049OL3tW6WtF1xTzYTjnFBEL+fY8/fGy8PN0/sdvzgRaFuTbV8gb7Q7RGd95jwFJ0q7JXdn9d3+I8tDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by DM4PR11MB5277.namprd11.prod.outlook.com (2603:10b6:5:388::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 03:53:13 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 03:53:12 +0000
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
Subject: RE: [PATCH v4 00/13] Introduce support for multiqueue (MQ) in fnic
Thread-Topic: [PATCH v4 00/13] Introduce support for multiqueue (MQ) in fnic
Thread-Index: AQHaIzW8spPreXFLkUWvW1Zcp94ae7CbnT3QgAAJcBA=
Date:   Wed, 6 Dec 2023 03:53:12 +0000
Message-ID: <SJ0PR11MB5896728CD14BD099A273C98BC384A@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231130023402.802282-1-kartilak@cisco.com>
 <yq14jgwm3gz.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq14jgwm3gz.fsf@ca-mkp.ca.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|DM4PR11MB5277:EE_
x-ms-office365-filtering-correlation-id: e77ec6a9-7199-4937-0b8e-08dbf60ede73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JZaHbDyPwYYmGCjpK8fSR/qXjGN8BIPYW/Y1Euwd7ISx42XCYVKu0mGRq/qrnbxsVIoclV5C85SylssvnWehuUE02FhtW5pdn68auyAElJW5coQu1KzMzxSbiTTBSAMAtPhBk+uHDba6c0DcPP6mNFDUtqubgqOdvN1q0Bs8sszZHIYMOxxNqoVutxcaWZ35RRQ67+Gj43vMWlkHJd3kFWOauTf66eyNYf6eRodCDjCschsLbjEKSGrsQ3ytGPCvs5lY0SjAxfKXouB1z9ukcwk+GxKZCFv335b46LbZpz6AaieDNn/D1ffacl4YNnTyMCYWyRBZKAMEevJNXVOSR5/4jtGMuj9b0v5Z2PMzt2UoTXjYuebWjEMGRWKwlFJPirVRqfvGgGJuSwsTyHBV+mTFgWqv1xBayX9bDpAaHk0zNtY8fjOV1EmlH0aY15dCJQp5bKT5LYlQwVzqyGYOE9LU9mTcDUYGl2EZG/kK3NtekVJUYZD0BlKoYhRXhFbAw1cir0T7SOIHv8vkO4DbbDhrPbjRLKC9p3IE3I6mdh2hz5z7jaFQ0vX/DTw0OspIMbsYxJGbPGTrJZg737mVcpko3ydOBadFQsre/PE2XfHEYWkN7UqgTBCbbHVUSu4w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(478600001)(9686003)(6506007)(53546011)(7696005)(71200400001)(316002)(66476007)(64756008)(54906003)(6916009)(66446008)(66556008)(52536014)(86362001)(55016003)(41300700001)(8936002)(76116006)(38070700009)(66946007)(8676002)(4326008)(33656002)(2906002)(122000001)(5660300002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fs87MuX3zyZ4yRWWddgaPGh3IRwVs46D2ZD0BGWXya2QUiW0cR+bDXmeDnok?=
 =?us-ascii?Q?RE85AFAvBE6JXCKEMiR0LDR+PWxwJeuZiftiRu2W6c9F8WIGgWygHJQo1fOY?=
 =?us-ascii?Q?9xwkkPbjzHOyubSCJVHuaJurhN+x3v3FB8uuigb4gh17nQTKL0v1a0/1FXHW?=
 =?us-ascii?Q?ur9h+QC26i5TXW9AbLrb00+y5teOvKfz+mjqz8kDx1i0CjNlqA4eEPkQDI9k?=
 =?us-ascii?Q?oJ2Dbv7u6jgUU8f5vd9+Q9WbGP0JLn+h7cS1A6DcMc5/IMGcVVvCQxRSK6sA?=
 =?us-ascii?Q?H8DEyANmLhd29xLAkGzv5Z6PSE1k7Q9eFDVfZ+DdN7XkWI9GDWnkm+7PMnoL?=
 =?us-ascii?Q?+TYtr6HxBxc9cnlAF5jFZsTmBsd5oqr7hImboB1FS9ztPESCI2Bv2gARfpRY?=
 =?us-ascii?Q?1Hztv3yI4PwhQKVFiDq65vLGmSzXIM9ahfnZuP4G/jGlgmK57G9QjYL50tI/?=
 =?us-ascii?Q?d5I0j23gPWXHHXUIGf2I4xjBeoYIdZx5ZO7uMKiSN4CA5YVvLqITpv4fMu7v?=
 =?us-ascii?Q?FxAZguJFgrW6seVvLvaoaXSr5UpXn+Dv4IXgDEQ9WrZNWFsqVKCCx7UkOttP?=
 =?us-ascii?Q?g/FY5qL5pm6Et9ZtML1Ic5Akyh7kuvxVkedeC7yu9fNAdlwZuV2ksnvF9wpS?=
 =?us-ascii?Q?P0c3+xwt69/L7HjkE0mhL+WrCJI/LzVIz8yJmcbRxrDKOJ6xAAVdLK/AbTUk?=
 =?us-ascii?Q?/v3R40J1wnkwiuKGDGU9p8M1+peTXms+4TGMAxluiW8kxEooSNpe8RryT0BG?=
 =?us-ascii?Q?HT2sOHn2DuZgoetBOTHmKx+vzMRJgGwUoa/ciCTEbC7uXMgHcB0zph2vmas2?=
 =?us-ascii?Q?gRn/7M6yyWt2hwEJ60z0H0XIk9bdL/+UWUyl+hLuIlSAyyEJ9YbKC3Td6AwC?=
 =?us-ascii?Q?yYwHuuzxMD0yNV/vKMxII6olyb3ueNOm4AavKYmUH35AM3iWX8lr3gZNvjA4?=
 =?us-ascii?Q?3Hce8xQXUfMT9LDY2xB/gkQQPpprg9G5bXd4qpVxYOm4p3LWichp4KSzaeSH?=
 =?us-ascii?Q?bBTgoOOvBB5reByK8bmHSOAFHhCJNOFQWXjGXOP2+Kvq49oDB2QZOF363NTb?=
 =?us-ascii?Q?F+pBa6n9x8P6VpcS3neMsvOIPryuDOfoqvd7tL8zGus+eLRhuyUCl/4Fduye?=
 =?us-ascii?Q?An+wArEB6xW5i8vXneqe9nZRv2FshNJyvr/GvmKA9TnCYbICSIUIxqzz9cjR?=
 =?us-ascii?Q?N+A41xYzD9tNsJD+5d+ACnqmWPAKS6XRQkE1JQSDGvtzZZlq49rATxEVzcn5?=
 =?us-ascii?Q?vwQVAsHN3jU8OQaXCX5ABf3Z9//KrU4rLfuV0302VQnN6t/Cw5/jZGT+Jg68?=
 =?us-ascii?Q?CLluwk8Cgot7i71mDW/v9u6w0BI3DXEJju+azPhK+3Jp0+7VjJ5UrVAZ+FT8?=
 =?us-ascii?Q?GH6myOzeTycOwDXzwDe7xo/BuZwueMxVa6TcDzFszIWIQJNeR/w/2JzxodZv?=
 =?us-ascii?Q?38ohu73p6JcmmLEcxmRDLQyioAULkRDMb9X7c0EETgNIQeyRvvRN5W4+G4K2?=
 =?us-ascii?Q?4iVhatqe2HuEr2VVcBNsK9prlF+BAsQPq19nIuCYQQK+DhTr9tYJ0gG5xm7o?=
 =?us-ascii?Q?vAyc9Gr59J8tUJth6Mkx93Aa1ZZaTkZB1oSuRqtHWA84xlTNAyMxsei0LgLH?=
 =?us-ascii?Q?p514qLcvc56ZcJC1tIi/JVNINc6iYOQ6Qzj82FPVmOGg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77ec6a9-7199-4937-0b8e-08dbf60ede73
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 03:53:12.5090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lZLH7BgCGRZURssUuP4oFRr70J4oABQ+MXz2Yl48aIkJvp/hOSWzQY8LPAw+n2Ef7icXIqCJvchpRDua+nyCaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5277
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-5.cisco.com
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

On Tuesday, December 5, 2023 7:11 PM, Martin K. Petersen <martin.petersen@o=
racle.com> wrote:
>
>
> Karan,
>
> > This cover letter describes the feature: add support for multiqueue
> > (MQ) to fnic driver.
>
> This series doesn't apply to 6.8/scsi-queue.

Okay. Thanks Martin.
Please advise how I can proceed with getting the patch set accepted.

> Also, for change entries for individual patches, please make sure you put=
 them after a "---" separator so they don't end up in the commit history.
>
> Thanks!
>
> --

Thanks Martin.

I'll modify the commit entries in the individual patches in the patch set a=
nd re-submit the patch set.
Just to make sure I understand this correctly, this is what I will do for t=
he individual patches in the entire patch set:

  1 From 818867e64180c2456d3f33761cb7fb6e00679849 Mon Sep 17 00:00:00 2001
  2 From: Karan Tilak Kumar <kartilak@cisco.com>
  3 Date: Fri, 13 Oct 2023 13:38:09 -0700
  4 Subject: [PATCH v4 02/13] scsi: fnic: Add and use fnic number
  5
  6 Add fnic_num in fnic.h to identify fnic in a multi-fnic environment.
  7 Increment and set the fnic number during driver load in fnic_probe.
  8 Replace the host number with fnic number in debugfs.
  9
 10 Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
 11 Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
 12 Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
 13 ---								-> Introduce a separator between the commit and the change e=
ntries
 14 Changes between v3 and v4:
 15     Incorporate review comments from Martin and Hannes:
 16     Undo the change to replace host number with fnic
 17     number in debugfs since kernel stack uses host number.
 18     Use ida_alloc to allocate ID for fnic number.

Please let me know if I've missed anything.

Regards,
Karan
