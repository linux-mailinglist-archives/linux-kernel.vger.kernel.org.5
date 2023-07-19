Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40663758B74
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGSCng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGSCne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:43:34 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E84CFC;
        Tue, 18 Jul 2023 19:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1689734613; x=1721270613;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vfojfqxzGtyLOfNv5/f0aefbZw659/u7Q1Ft/aBkZu0=;
  b=Hc0Ojm1e7lo24VxzkfCyoYUTw9WjYkMvb+aCV+6CS4Wl0DQTXiaUEJcs
   qHyAMctzooRcQbO1QTB5ISZG2/6C+ixk8MAy9WDu4GHA21Mf5UwfPpGgP
   GQHnElYnhnGgMheJyrn7/2yHAjnc7ZPY8Wdb1wvnqxzrhPtOk9Aw+8+hZ
   w4Yv4iqqNBxDCqrOLeqX6em4jLWfjqurCQVIzF7AW4E6joxEKzbqT34ns
   NUByrrQ4xuQGr2cRINWgQ6xMNXPX6NnbEADKjATVBhSIjBDHgFHleKZGw
   B7zyvrO4RXpISeYEBCfQ1ms/HdFvVyjKqv+ZP63KDXdPlQMrQmLYu+QZ8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="90111783"
X-IronPort-AV: E=Sophos;i="6.01,215,1684767600"; 
   d="scan'208";a="90111783"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 11:43:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrUK2G3ImlbRQyOIerbWBMFJjbS9cbfKRvzoc2VwtqbdNckVLcNPWoCxcPvSY0Cwx9E+pEntZ2Jp7lUaH2YvYRugu4Ih0FanZpZiM35klz7T4MwZOe9Mw9mbuSHinxz0U5X2HS5eioT89r0ZOjWRbecVjwkCNsfbXab6RWA+aPXoso9e7FGn8eUDgY3C5LPtluntPrkSNU1w60OzJ1fXZWtNaRxQRrZgfDqE5+V83wNOMN8TT3HC3cEaZBSd3KWSsnkjoSy5qsr0OZtYw8/fKGPaFeyuNhsYOPC95Mq6Pd/g5D5xSCf5RzKUt98AslAJT1EKM/IIiBqYt+MAKDqfGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5imrVfIstCyWCsuNnIwhWMGFXM1myLTVQtyVQLp2Vpc=;
 b=D5SFUyGxNmsu1Ku9ZOek8NWTky4njeL4V4sjfdDO6YUnSFfOMEHlFW2//cmdGzizG2bzyp7vUhOILMaqfuWqU3qmyPtx4naK/bobiNSPlN+T7wL47Q4kWEtCueY+my243ZjRTcNclQ0OnZDgFtbc2WpIDp63qe8ugGY9EvORvfJj9J4tQ6tSdAP6TahgxF6HVjXFHLSWLQufD9EXDkrehdWMGTl8EHonTMe6ldMRYDBMTNOf98eFCXJ+zXivKg0IHC1VoVwJAZXFyvdXk7PnA9URn1alTmbhvIeN7JcI8h7LPzeZzL0O3AlOrwTAVsMVwsxRe6nEGp/PendBjofJ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYVPR01MB11228.jpnprd01.prod.outlook.com (2603:1096:400:36d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 02:43:20 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::70a6:407f:e7cf:3231]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::70a6:407f:e7cf:3231%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 02:43:20 +0000
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
Subject: RE: [PATCH v3 0/8] x86/resctrl: Add support for Sub-NUMA cluster
 (SNC) systems
Thread-Topic: [PATCH v3 0/8] x86/resctrl: Add support for Sub-NUMA cluster
 (SNC) systems
Thread-Index: AQHZtaepRvtW31XAYk+ZtGkjDGRY46/AabVg
Date:   Wed, 19 Jul 2023 02:43:20 +0000
Message-ID: <TYAPR01MB6330A4EB3633B791939EA45E8B39A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230713163207.219710-1-tony.luck@intel.com>
In-Reply-To: <20230713163207.219710-1-tony.luck@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-07-19T02:41:24Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=a7230f06-24fa-4bd4-bbe5-b0ff3fc223ee;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: bc3bde77e7ab44de99b41642cb6b00b4
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYVPR01MB11228:EE_
x-ms-office365-filtering-correlation-id: 575326e2-7bd7-4065-e8de-08db8801ea18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9G4Cj0GQicDuaAY7Zq+2Kk7DbPmeBlqnMHhLGFPf20xc/6ogDD5V3vka6uqpFF+KINnFyBGpW3Tfg4winbsu4vyCpr+1GuUSdXXhAENieY2kR4FGFvXYXoYtnPEILOegDBxiD6GBTnQc1JbEWEmNzM8oK1vi6BIne8Heh0gW28vrmhU5r9OlDV8X1ij7PEIMbEFPEQ7LvqL5sMGLzXQgPlAaZ2crnWxoO3eGopUJvoVN4B2Mgo6IaTDJYPYJ0ZjT2Ul8IUjuhQI0GiolXX3bW7l/H6lxjjZiKzXw8d8Tf05aqypd5KKSA64Jd5l2RxOFjRcp8vhqLnX2PmQqmYML3KY/e7MyCi12gum46NnL7HadZjF+N279ozMq47UwopGzcfwnoSPbHLQW/lLQ4MNw2UBKgr0kdzMQJYjkUKDoCJdp3xuVVyo4JJ5OggqN4Mvqak2NmBzKoelmqL6ymIRSLgCMH1PGCL9kTCUhCRNDojRKUd13d1f+yvclEEtUlbEWQ1MIJqea6/yCamHLyomILu7NLB8px6v2Qdi1IqlWT8MUXKMueXFNz7c2VVNFhpaFQpT/G+I+vtjpMUYAwxUgUcqTUwU3NmZ1EJaZIrp24aeiEDD5jC5zO6BoMJRK/0i1pCysI9GlTZcwVKJoUzDDVrTolhUbM2bxxrta/6YWfKk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199021)(1590799018)(55016003)(1580799015)(110136005)(122000001)(82960400001)(54906003)(7696005)(71200400001)(5660300002)(41300700001)(478600001)(8676002)(8936002)(66946007)(66476007)(64756008)(66556008)(4326008)(316002)(76116006)(66446008)(186003)(83380400001)(9686003)(26005)(52536014)(6506007)(38100700002)(38070700005)(33656002)(7416002)(2906002)(86362001)(85182001)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?N3kvTWxtdm5hVWprNGczaHJ3Q0RPNW53a1BpNldsNEFIUHNHV0hWT09K?=
 =?iso-2022-jp?B?WGpPYWVuUDEzaXVjYWlHQVFkZE9nRlRnZlNlRkI5Z1ViVTROZ2dwR1R0?=
 =?iso-2022-jp?B?bXJ4b1oveXdERDJoQklvcWRKMjJDZmFOWXF3Nm83QXV6M0wxNzFBT2Vw?=
 =?iso-2022-jp?B?NExoRUZIT3I2ckZndkZpZkwvcWlpSXV0R1ZBZUViK3RDd0twckhWOXVE?=
 =?iso-2022-jp?B?VkNCMk9jRHN2U2haVVhxV2hSRFpGS05uNTRLdjNSakpTY3A3aWVBZWNI?=
 =?iso-2022-jp?B?SWttcDdDUis4RDVGd1RoY3IySWVNR3BLVDZTNmV5bFZiTlowNFBtS2pt?=
 =?iso-2022-jp?B?bEp4b25HWnE2TkdjN3FkMG1jNmxacUQrYjJDSVNlR0k1MklIZGxzYkt4?=
 =?iso-2022-jp?B?Q3NpeGhFVXNBOUZOWHF1Q3BhZ2FoV1oyUE5PSys5aXA3NGV2dS9Ga3Ba?=
 =?iso-2022-jp?B?RUJ2Yy9MWFkzWmdMQjJleHp6cnZFaVBCQm9UVE5vVkEwbUgrUmVVNVVN?=
 =?iso-2022-jp?B?L3Bib3JuY1ptOWdEOEY0WXpqRjk5Vkcxd0ppcDFucEc5TW1EcmNvUm9m?=
 =?iso-2022-jp?B?SVFETitjMEZTb0hBakVQU1A2QmliUCtFMmpOT1crbjZtaUVTSkh0SWh5?=
 =?iso-2022-jp?B?b0JqeWx2SlVJR3pBUkp0YWlGMnJwQTNjOEt6ZW9JYURON2dmWEN3NjVI?=
 =?iso-2022-jp?B?RG9qYmNRVXRRVnFYTmdrU2tYVy9iOElZd2ZXNFluNlV3OXN5VVJaMnRE?=
 =?iso-2022-jp?B?cm10d2pIQ3I0eWlmb2cvUHBkZHVaakJuUnBYZS9aT0pPRll0TmVocmtH?=
 =?iso-2022-jp?B?R1dweEQ0K3IvWmNtMWpyTm5reW5JNUNqTkgrRndIOWd2bzBoUk5Cd3JD?=
 =?iso-2022-jp?B?S3A3SHdqYjhpcGJRTElDY05uSlhiTTlJRVhMQ0o3TTV0K1gvV2hDUDY5?=
 =?iso-2022-jp?B?djlLdFY2R1ByQXBkckJFT0xzL1RDeEhZU1Mzbm1PL2JUZU1idk5PQkdJ?=
 =?iso-2022-jp?B?Yi9TK29iaEdpZzNwSWZpNmh3bkRLcjBPK2N3VW1LSHdEdGxkSDMxMDRS?=
 =?iso-2022-jp?B?Z2VyTmVOeFp5TkN3Y3lyT1YveTdzajNrRFFiWE5DdXVWVFBVTnowRFhx?=
 =?iso-2022-jp?B?ZGlHMVpZNnNnMk9OOGNrZlArSnJ4di9hVExzWjM0MDc5amJqT1ZsNlVT?=
 =?iso-2022-jp?B?VXBzNGRIZ2h2V3VzdzBRc3Vhd3A4MnhHNUkrQmRpR0ZyL2RkRU1SODU2?=
 =?iso-2022-jp?B?d2lCc2JteU1DMHZGT1Foamt1TGY2UGgveVg3L3VnM25wRTMySytMWC8v?=
 =?iso-2022-jp?B?NUpwbmw0UEIrNnppVWpqV0hFNEphWTBzSzdwbm5XR2NzSFo1bzh2V29y?=
 =?iso-2022-jp?B?NEh5WmVaV0pCak4rNWlGejhrUzNnVGhjK1RURG5zOCtkRGc4N21DMUcr?=
 =?iso-2022-jp?B?dUxRWEtVMUJoa0pLQmsxc3ZiSmJzQ2ZzRjdRelVpdzhkZmN1N01ObDJx?=
 =?iso-2022-jp?B?YllENUhNQS9tUkY0YUYrRU83eGJKTWE2SzQzQ2RpbDJ2ZVZNQ0xDQWFT?=
 =?iso-2022-jp?B?UkxmOUZVNTdSRUpsQVFMM2gxUTFYbVArSklhYk03bG1Xb1IraWhRUHdk?=
 =?iso-2022-jp?B?a3l5R0tnaWFNQVF3UGFkTzdHZFJEWnBXR2JYNmljN01tNFdvdmswN0dS?=
 =?iso-2022-jp?B?N1FZYmlVcCtpOGFZeVAyUUgvc0hPcHA3Y1NzVERHa005QWNHc1ZUQmRI?=
 =?iso-2022-jp?B?c0RVTVBrQk5DRFJqbC9MV0xybVkwQi90MW1hVHNia0NWeVh4NThMTEd5?=
 =?iso-2022-jp?B?SkdMdEdXNnMySU0xZGJUY1ZzOTFvWDZXRENuZTdZUUVhVU5QOGp0WTVO?=
 =?iso-2022-jp?B?UGFyRjhrVFlDdkd6c0Jxd2J4alpzRXYyamdVek44b21vOTNZN1N1SW5q?=
 =?iso-2022-jp?B?VnE3ZGFGeHZjQU1lQnBIcWpyWngwMlYxOExEQ3pFeTVHWjQ4dWNDSkxx?=
 =?iso-2022-jp?B?bWJwN1UycWFvdGdxZGpXUWZiZnNRU2R5ekJXRzJadm1JSkVVRnNaOVI5?=
 =?iso-2022-jp?B?RjdrQUYvd0hjT1lHTkkraHpjWWtHZ3o2czZDVmxPRDBZa2cxNUVFa3Rq?=
 =?iso-2022-jp?B?NnZPNitWOS9JcEZRTjhZN1hMekk0MmpCS1BRYjI2Y2ZlM0RSNXM3azV4?=
 =?iso-2022-jp?B?U05qNG13UmxidThtZ0E4aENERnZwZWdidjMxMHppbE15RlM0VzE4Qmdj?=
 =?iso-2022-jp?B?L3AvcFE2Ry9GSStwM24vRWNYNFN6L0ZjK0J3MFk1clZIWm5GelU5RGhJ?=
 =?iso-2022-jp?B?c1BRSkJqTU02S2JuUG1tZFArNDcwam9naGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?Z0I0dk55SHRtTGw4VXZoY1hqcjFCZ3lMdDJVRFF2NysvVEV1V2JLclRi?=
 =?iso-2022-jp?B?TUhaMkNhaTR4TUhMdzlhQjJ2czhBS3VBUy9kSHZ2dUZHWjA2VmQ1eGNj?=
 =?iso-2022-jp?B?Q2EvZjVOL3o1aTJuR2pnbWMvRVBzbnNpbStpT0dONXRLcGpoQzdMZmth?=
 =?iso-2022-jp?B?L3YvbEYxNHNiR0xLVEFFYjBpWHVtT3Vwc3ROTXdaUEo3cEZ5bmRrczNS?=
 =?iso-2022-jp?B?TklmSHRyWisxOW5menY1MEJGR05xRFgxSmc2cHNDSExOT2NrN0hVSlhT?=
 =?iso-2022-jp?B?b253R1N0QkFWRFo1M0ZjTXRVUmdSTjZLVm5kRktqQXVtd3AzQ0Y2OGNT?=
 =?iso-2022-jp?B?TzIrVUZ1VlJoU1M2d2FkM0RmSGJ3WXVPbTBWWlpJK1QyOE1kVm1qMUY1?=
 =?iso-2022-jp?B?TDV5Wmc5MUtMNHR1QzR3bkZwL2ZSem93RThadXh0Q3R0bHduQ3lPaDBy?=
 =?iso-2022-jp?B?aGpUcXNoYnRFRzY5ZWpleThsS24zMXNMdlRua2dYSk01Q3RGWUJaVUZS?=
 =?iso-2022-jp?B?QWVxRld5ZTBoUVZtdGpUaDd4ZzhWTXErT2pOME9oTnJSdUF0SWJLYnlz?=
 =?iso-2022-jp?B?VG5SYytBVmVyQlhSVDZCd3VDZmt2Q3c4L0s2d3RMdlhuSy9jNFZHWUV4?=
 =?iso-2022-jp?B?Y29YRTAvVmszajROUkxJaHM1bFlxdnQ1MGY2QWRka2ZlaDN6YkE2cWls?=
 =?iso-2022-jp?B?ajRDR0IxQll2SVJMNWx6Q2Q3NzlPL0tCWFZ0YmlVT3BlWlllWDhIeXI2?=
 =?iso-2022-jp?B?eEkwYW9QcytXV1JhVEM5bzVjWHVCRXdGWFJ4NGhNOExXMFJOZGxNMnl5?=
 =?iso-2022-jp?B?Sktqb2hWbjlGTzE5TXN6ZE5GVVgxdXAwOC9Nb1lqQWdnNU1LdkU3QTdx?=
 =?iso-2022-jp?B?cHZqWXphRDYrTE5aWDQzYWlxd08xd0kzMi9hMzMvaXhOYmV3ZHJ4b00y?=
 =?iso-2022-jp?B?UTR4MEdCaENkWC9Kd3krSlpvVDRoelUyUDJkVTFIVGJSWkcyK2RIcmFD?=
 =?iso-2022-jp?B?MlFLT3R0M2VFL2dwYjZBKzFWZEZNNGRFanhENkw5YzNKYkN1VG9QQmQy?=
 =?iso-2022-jp?B?NzdLQVJ0b3B1REZvVzE2K3BDRmFxZmw0RXF1RFhEUm9JUldGbGNjRzhW?=
 =?iso-2022-jp?B?QVk2L25VTHZCdW5oNFVJM09JVkU0VzRMZE1GZzl4dnYvejJOa0ZpMTFa?=
 =?iso-2022-jp?B?Nks3ZDViMUtrbHlJdDJ5THdpYWQwVnd1aTl5Y0lOdXpSOUU2TytkR1Fh?=
 =?iso-2022-jp?B?b2xYK0xxdGV4SXBnNE5rczRoY3JuR3V2aEdmWndDSzFDUndFUmpxTjBM?=
 =?iso-2022-jp?B?WFFmY3BCOTNBL3hUM3RkSnFYL2R3V1FES3d5NTBISzJvL2o4RlhwaW9N?=
 =?iso-2022-jp?B?TkhUVVlnU1BOTjNmYkhUcTA2RktXQXRBMWtRYmY1ckM2a3liWnNHM3A2?=
 =?iso-2022-jp?B?cVpJZXNvcUcxK2p0YkNtcDRCNDZBTGE1Rmhjblg3Zk1sQTJ6dmpmRHBG?=
 =?iso-2022-jp?B?dzJibGRXQlRJREQ1SGovV2N2dnRrTnRXYWN2c1JmUXE1c0hYREVib3Rt?=
 =?iso-2022-jp?B?S3Z6b1NjcHBVUUtaTVY4UGt3PT0=?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575326e2-7bd7-4065-e8de-08db8801ea18
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 02:43:20.6765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CBie7Zim3gGP12gUK+yDS+9M9EagXtDMssoAoeEPBpxgm8oObBcrPz/rBIp71xsHRY+33a8kAmbsSNuqfnNNi+meRgyOdU6hG7RwcOmTeE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11228
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi tony,

I ran selftest/resctrl in my environment,
the test result is "not ok".

Processer in my environment:
Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz

kernel:
$ uname -r
6.5.0-rc1+

Result :
Sub-NUMA enable:
xxx@xxx:~/linux_v6.5_rc1l$ sudo make -C tools/testing/selftests/resctrl run=
_tests
make: Entering directory '/.../tools/testing/selftests/resctrl'
TAP version 13
1..1
# timeout set to 120
# selftests: resctrl: resctrl_tests
# TAP version 13
# # Pass: Check kernel supports resctrl filesystem
# # Pass: Check resctrl mountpoint "/sys/fs/resctrl" exists
# # resctrl filesystem not mounted
# # dmesg: [    3.060018] resctrl: L3 allocation detected
# # dmesg: [    3.098180] resctrl: MB allocation detected
# # dmesg: [    3.118507] resctrl: L3 monitoring detected
# 1..4
# # Starting MBM BW change ...
# # Mounting resctrl to "/sys/fs/resctrl"
# # Mounting resctrl to "/sys/fs/resctrl"
# # Benchmark PID: 14784
# # Writing benchmark parameters to resctrl FS
# # Write schema "MB:0=3D100" to resctrl FS
# # Checking for pass/fail
# # Fail: Check MBM diff within 5%
# # avg_diff_per: 100%
# # Span (MB): 250
# # avg_bw_imc: 14185
# # avg_bw_resc: 28389
# not ok 1 MBM: bw change
# # Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check =
BIOS configuration.
# # Starting MBA Schemata change ...
# # Mounting resctrl to "/sys/fs/resctrl"
# # Mounting resctrl to "/sys/fs/resctrl"
# # Benchmark PID: 14787
# # Writing benchmark parameters to resctrl FS
# # Write schema "MB:0=3D100" to resctrl FS
# # Write schema "MB:0=3D90" to resctrl FS
# # Write schema "MB:0=3D80" to resctrl FS
# # Write schema "MB:0=3D70" to resctrl FS
# # Write schema "MB:0=3D60" to resctrl FS
# # Write schema "MB:0=3D50" to resctrl FS
# # Write schema "MB:0=3D40" to resctrl FS
# # Write schema "MB:0=3D30" to resctrl FS
# # Write schema "MB:0=3D20" to resctrl FS
# # Write schema "MB:0=3D10" to resctrl FS
# # Results are displayed in (MB)
# # Fail: Check MBA diff within 5% for schemata 100
# # avg_diff_per: 99%
# # avg_bw_imc: 14179
# # avg_bw_resc: 28340
# # Fail: Check MBA diff within 5% for schemata 90
# # avg_diff_per: 100%
# # avg_bw_imc: 9244
# # avg_bw_resc: 18497
# # Fail: Check MBA diff within 5% for schemata 80
# # avg_diff_per: 100%
# # avg_bw_imc: 9249
# # avg_bw_resc: 18504
# # Fail: Check MBA diff within 5% for schemata 70
# # avg_diff_per: 100%
# # avg_bw_imc: 9250
# # avg_bw_resc: 18506
# # Fail: Check MBA diff within 5% for schemata 60
# # avg_diff_per: 100%
# # avg_bw_imc: 7521
# # avg_bw_resc: 15055
# # Fail: Check MBA diff within 5% for schemata 50
# # avg_diff_per: 100%
# # avg_bw_imc: 7455
# # avg_bw_resc: 14917
# # Fail: Check MBA diff within 5% for schemata 40
# # avg_diff_per: 100%
# # avg_bw_imc: 5962
# # avg_bw_resc: 11934
# # Fail: Check MBA diff within 5% for schemata 30
# # avg_diff_per: 100%
# # avg_bw_imc: 4208
# # avg_bw_resc: 8436
# # Fail: Check MBA diff within 5% for schemata 20
# # avg_diff_per: 98%
# # avg_bw_imc: 2972
# # avg_bw_resc: 5909
# # Fail: Check MBA diff within 5% for schemata 10
# # avg_diff_per: 99%
# # avg_bw_imc: 1715
# # avg_bw_resc: 3426
# # Fail: Check schemata change using MBA
# # At least one test failed
# not ok 2 MBA: schemata change
# # Starting CMT test ...
# # Mounting resctrl to "/sys/fs/resctrl"
# # Mounting resctrl to "/sys/fs/resctrl"
# # Cache size :6488064
# # Benchmark PID: 14793
# # Writing benchmark parameters to resctrl FS
# # Checking for pass/fail
# # Fail: Check cache miss rate within 15%
# # Percent diff=3D91
# # Number of bits: 5
# # Average LLC val: 5640192
# # Cache span (bytes): 2949120
# not ok 3 CMT: test
# # Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check =
BIOS configuration.
# # Starting CAT test ...
# # Mounting resctrl to "/sys/fs/resctrl"
# # Mounting resctrl to "/sys/fs/resctrl"
# # Cache size :6488064
# # Writing benchmark parameters to resctrl FS
# # Write schema "L3:0=3D3f" to resctrl FS
# # Checking for pass/fail
# # Fail: Check cache miss rate within 4%
# # Percent diff=3D6
# # Number of bits: 6
# # Average LLC val: 51475
# # Cache span (lines): 55296
# not ok 4 CAT: test
# # Totals: pass:0 fail:4 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: resctrl: resctrl_tests # exit=3D1
make: Leaving directory '/...l/tools/testing/selftests/resctrl'

Sub-NUMA disable:
xxx@xxx:~/linux_v6.5_rc1l$ sudo make -C tools/testing/selftests/resctrl run=
_tests
...
# # Starting CAT test ...
# # Mounting resctrl to "/sys/fs/resctrl"
# # Mounting resctrl to "/sys/fs/resctrl"
# # Cache size :6488064
# # Writing benchmark parameters to resctrl FS
# # Write schema "L3:0=3D3f" to resctrl FS
# # Checking for pass/fail
# # Fail: Check cache miss rate within 4%
# # Percent diff=3D6
# # Number of bits: 6
# # Average LLC val: 51899
# # Cache span (lines): 55296
# not ok 4 CAT: test
# # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: resctrl: resctrl_tests # exit=3D1
make: Leaving directory '/.../tools/testing/selftests/resctrl'

Best regards,
Shaopeng TAN
