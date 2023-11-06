Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB667E2D28
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjKFTro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjKFTrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:47:42 -0500
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC7D125;
        Mon,  6 Nov 2023 11:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=764; q=dns/txt; s=iport;
  t=1699300059; x=1700509659;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MTBLT4546eGlQFRu/LMpRQXjGxREB9UXu+ODSUVP+nU=;
  b=AWdYFmND4yjQBcB0z2bQMQDOwZArUmQnkdcAANZV1F06QOWVyMfhS8cS
   EMGuT70zbp+VcxlbAS3G+RNcsTYB+DXU3h7qI754h1poCiNOeTZUXJQqv
   n+o3xTO4F3iwj33T1NQ8zzPZ0ARlmdSestBBrJS/uY+ezO/hTGsQ/BVvh
   k=;
X-CSE-ConnectionGUID: jmtVknSUQDenX9FlPzEaVw==
X-CSE-MsgGUID: o3csgfKNR9mhEHoVCUBWJQ==
X-IPAS-Result: =?us-ascii?q?A0BUAgCWQUllmJJdJa1aHgEBCxIMQCWBHwuBZ1J4WzxIh?=
 =?us-ascii?q?FKDTAOFLYhlnX6BJQNWDwEBAQ0BAUQEAQGFBgIWhxACJjQJDgECAgIBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQIBAQUBAQECAQcEFAEBAQEBAQEBHhkFDhAnhWgNCIZEAQEBA?=
 =?us-ascii?q?QMSEREMAQE3AQ8CAQgOCgICJgICAjAVEAIEAQ0FCBqCXIJfAwGgVAGBQAKKK?=
 =?us-ascii?q?HqBMoEBggkBAQYEBbJsCYEaLogKAYFQiDYnG4INgVeCNzE+gmECgWKDWTmCL?=
 =?us-ascii?q?4kuBzKCIoJAgRSNCwl3R3AbAwcDgQAQKwcEMBsHBgkULSMGUQQoJAkTEj4Eg?=
 =?us-ascii?q?WOBUQqBAj8PDhGCPyICBzY2GUiCWAkVDDVKdhAqBBQXgREEagUYFR43ERIXD?=
 =?us-ascii?q?QMIdh0CESM8AwUDBDMKEg0LIQUUQwNCBkkLAwIaBQMDBIE2BQ0eAhAaBg0nA?=
 =?us-ascii?q?wMTTQIQFAM7AwMGAwsxAzBVRAxQA2wfNgk8DwwfAhseDScoAjVDAxEFEgIYA?=
 =?us-ascii?q?xwDRB1AAwttPTUUGwUEOylZBaEag0wBKQKWHEmtBYEuCoQMoT8Xg26mEpg+I?=
 =?us-ascii?q?KBVhzMCBAIEBQIOAQEGgWM6gVtwFYMiUhkPjiAZg1+PeXY7AgcLAQEDCYtKA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23:d+89TRWcUaazztZUUxYDaEwXDsjV8K0yAWYlg6HPw5pUeailupP6M
 1OaubNmjUTCWsPQ7PcXw+bVsqW1QWUb+t7Bq3ENdpVQSgUIwdsbhQ0uAcOJSAX7IffmYjZ8H
 ZFqX15+9Hb9Ok9QS47lf1OHmnSp9nYJHwnncw98J+D7AInX2se+zfyz/5TQSw5JnzG6J7h1K
 Ub+oQDYrMJDmYJ5Me5x0k7Qv3JScuJKxGVlbV6ShEP64cG9vdZvpi9RoPkmscVHVM3H
IronPort-Data: A9a23:YHxziq6QAtNV7QeVifryNwxRtAbHchMFZxGqfqrLsTDasY5as4F+v
 mceCm+GPP7bamemetB3a4+18xgEsZLVmN9qSQRsr301Zn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyKa/lH1dOG58RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wq+KUzBHf/g2QvaztMtfrYwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoZWk
 M6akdlVVkuAl/scIovNfoTTKyXmcZaOVeS6sUe6boD56vR0SoPe5Y5gXBYUQR8/ZzxkBLmdw
 v0V3XC7YV9B0qEhBI3xXjEAexySM5Gq95fFJGSBssqo8nTqfn3ckttqNFMbNLMHr7Mf7WFmr
 ZT0KRgXZRyFwumx2r/+E7EqjcU4J86tN4Qa0p1i5WiGVrB9HtaSGOOTuYEwMDQY3qiiGd7db
 tAFaD5mbzzLYgZEPREcD5dWcOKA3yKmI2UB8wLLzUYxy2+Ixxd+3pvLCovQevGqQvt+o2ynh
 FuTqgwVBTlDZIDAllJp6EmEgu7JgDO+W48IErC83uBljUfVxWEJDhASE1yhrpGRjk+4RsIaM
 EcP+wIwoqUosk+mVN/wW1u/unHsg/IHc8BbH+t/4waXx++Nu0CSB3MPSXhKb9lOWNIKqSIC1
 FqVodDvPgFWnLCTeSOz8o+GgDqMJn1ARYMdXhMsQQwA6tjlhYg8iBPTU9pueJJZaPWoR1kcJ
 BjX/EADa6UvYd0jjPrkoAiW6964jt2YEV5vv1S/sneNt1shPOaYi5qUBU83BMuswa6DRVWH+
 XMDgcXbtbhIBpCWnyvLS+IIdF1I2xpnGGOF6bKMN8B8n9hIx5JFVdwLiN2ZDBw4WvvogRezP
 CfuVfp5vfe/xkeCY65teJ6WAM8316XmHtmNfqmKP4sUM8UtKFfXoXkGiausM4bFzhBEfUYXZ
 8/zTCpQJSpy5VlPlWDvHL5NjdfHOAhknTqNLXwE8/hX+ePOOCHKIVv0GFCPdes+pLiVuxnY9
 s03Cid540s3bQEKWQGOqdR7BQlTdRATXMmqw+QJLbTrClQ9Rwkc5wr5nOlJl3pNxfoFz48lP
 xiVBydl9bYIrSacdl3TOiE8N+mHsFQWhStTABHA9G2AghALSY2u96wYMZAweNEaGCZLlJaYk
 9Ftlx28P8ly
IronPort-HdrOrdr: A9a23:njUw0KMmOmkULcBcT4T255DYdb4zR+YMi2TDiHoBKiC9I/b5qy
 nxppUmPEfP+UcssREb9expOMG7MArhHO1OkPks1NCZLUfbUQqTXc5fBO7Zsl/d8kLFh5NgPM
 tbAs9D4ZjLfCZHZKXBkUiF+rQbsaW6GcmT7I+0oQYJPGVXguNbnnhE422gYzVLrXx9dOAE/e
 2nl7F6TlSbCBIqR/X+LEMoG8LEoNrGno/nZxkpOz4LgTPlsRqYrJTBP1y9xBkxbxNjqI1OzY
 HCqWPEz5Tml8v+5g7X1mfV4ZgTssDm0MF/CMuFjdVQAinwiy6zDb4RGIGqjXQQmqWC+VwqmN
 7Dr1MLJMJo8U7ceWmzvF/ExxTg6jAz8HXvoGXow0cL4PaJAQ7SOfAxwr6xQSGprXbIe+sMiZ
 6j6ljp86a/yymwxBgVqeK4DC2C3XDE0kbK2dRj/UC3F7FuKIO4aeckjR5o+FBqJlOh1Kk3VO
 ZpF83S//BQbBeTaG3YpHBmxJi2Um00BQrueDlJhiW56UkfoJlC9TpS+OUP2nMbsJ4tQZhN4O
 rJdqxuibFVV8cTKaZwHv0IT8e7AnHEBUukChPfHX33UKUcf37doZ/+57s4oOmsZZwT1ZM33J
 DMSklRu2I+c1/nTceOwJpI+BbQR3jVZ0Wh9uhOo5xi/rHsTrviNiOODFgojsu7uv0aRtbWXv
 6iUagmSsML7VGeb7qh8zeOLKW6c0NuJfH9kuxLL26zng==
X-Talos-CUID: =?us-ascii?q?9a23=3AE9vFW2jqz52G5waZvTaaZIfpDzJucHjB8nTWGHK?=
 =?us-ascii?q?BJWtveOy7TWeC1apajJ87?=
X-Talos-MUID: 9a23:1lPWAwsx39EM/gsiHM2ng2ppL8hmwIKUWUUNvLUBheK5HxNSAmLI
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-10.cisco.com ([173.37.93.146])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 19:47:38 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
        by rcdn-core-10.cisco.com (8.15.2/8.15.2) with ESMTPS id 3A6JlcsK001432
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 19:47:38 GMT
X-CSE-ConnectionGUID: J4G9GEZ9Tt6gA9tqwuA+eQ==
X-CSE-MsgGUID: ppna4m7BS1GC0ynyD4YQtw==
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,282,1694736000"; 
   d="scan'208";a="7046528"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 19:47:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCED03133giQT2CpUqy2iRW1v5UZqNmascKlsvvO2M5pXoLqWCgFxmaDj343fcextWwedCyDFFA1jklQ2S5KLNJsfjAZjng7GG0I97+ouCwehjisZvlXwi28026Ngcw4Pp1x4XpMTN740aeFHaJVFTr/PMv7bYuoHJc7jglaDu/dFxtiSxn35uYnMh7mjtsT8lg//vejzw4EP9tNKQkaEbeC+TvcvE/q/V2ywJbJ6TPPQmRPNafx/6U74XomdWX+VuFbscae9oVTYlrY35a0ExeoFNfPxsaNG1Q/D2FaffrYhhrEOyocSKAS5X1Xhi63uUUmeFF9klPk8S2ntZfKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTBLT4546eGlQFRu/LMpRQXjGxREB9UXu+ODSUVP+nU=;
 b=f2EoTXtLoiHmOiG+uOB9cU4g5e0zc4FPXL6qqm5HCOw38Y/lyNRd89gBWEXfEGDqzC3G28Y838lmJZHGpkU5oKo+0dqMxtvJpTQg/vJ2T78RpEcEckZ59KLDlkAZDC2bArddazBOUWfolWEmYGiuztfEyxx9Fet6IgNzSQYw5yQOOib2jPNIiWh5rv65exXkA/fUYQfN4lN3r18vugDbpF8qzDyAleQOQ3MIB2X01edWazG8xbx4/65I7CEpjvKfcl3/MsgdwBQcS6ImJM41G1wne3ZZ9y0fgWzrSckZUvALp1GJufdzd5nqmY7Dco+rWST6og9GtvZdKvibCJvXNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTBLT4546eGlQFRu/LMpRQXjGxREB9UXu+ODSUVP+nU=;
 b=B9VKTqqTW7rWpU8pSdkIFCZV8ujcyyc3KabJfkQQ9AJvrlZ8P0ujmJqROjRnvoJcKGj8YWYGXxAbRdALp5nUVUT2G17Lx8TK50oxaheRyv3/hNE59kW46GOSz8L1rL25S7QTo8MVwK3AVvoML62QyaiO1vAsYSBYUDxQof4tIpU=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by BL3PR11MB6459.namprd11.prod.outlook.com (2603:10b6:208:3be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 19:47:36 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 19:47:35 +0000
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
Subject: RE: [PATCH v2 01/13] scsi: fnic: Modify definitions to sync with VIC
 firmware
Thread-Topic: [PATCH v2 01/13] scsi: fnic: Modify definitions to sync with VIC
 firmware
Thread-Index: AQHaCP/mtrnN1MRuXUicVPsfG02/dLBmqRQAgAcYY7A=
Date:   Mon, 6 Nov 2023 19:47:35 +0000
Message-ID: <SJ0PR11MB58968AEAA66C34D2E67F97B9C3AAA@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-2-kartilak@cisco.com>
 <5d718b3b-6635-4a73-8ac9-df54f4a7183c@suse.de>
In-Reply-To: <5d718b3b-6635-4a73-8ac9-df54f4a7183c@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|BL3PR11MB6459:EE_
x-ms-office365-filtering-correlation-id: 258e34ae-42c8-46f5-4585-08dbdf0139ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fIoiHmaSJTj63ppO2FG6cV2vbCkQJR6DhqbDpRkM/PAfGmFC6ofArKCw+I9ZBYmAh07mS64kNAFuAPo3JIaZklhpeS2vLDbjTVaT9L4o2Ex7IyKx3xWjkPi6MxyEJdWbDWa5t7TcvV2uKpeKfkfC16FKNqHN+PUnvgCINPx1BbqvttxZASr6u2OS4ZypYkoJtgofuoJ2mtE8kw5deUCjPdinJi79mHHVM25Od3fJioTWVXXubDjuTKBzntvMwR0yZW8OFbVqwfOkKJNWfK1+o3LL7CSlzEvphxRZtizrSAFIk6rcgudYB8GHMncJQvYlHCPYMFQ8XDp4QaRVtbZl0n23eM/5g5nucPd/wZJkSHCjo5xvAwDdavTBlPEttdzOUSoAyLzWjj/73XxlQO284e79pFsqVI9KSPo/NBOkoVxyN6ZfDtxA1UmM9N4ASCtLysGpuojkleLKEY9RRAVuLyFGhys6VjO/dH3c7FHpcsVypT6J6uZhCaHwoJrCyY2AGt5qSILMPa6l1q6lvRFQ2u6xjun0YCogj4FJ+1fYnSM02SAXyxO3iVsdvi1Dy5s8XqRfbHgEyqIbB12k2/52Ye4TNmuyeCVdLclSRGp0Iz/BzDYsRAElMMP+ln4b30PN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(366004)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38100700002)(5660300002)(41300700001)(4744005)(2906002)(86362001)(38070700009)(33656002)(122000001)(478600001)(83380400001)(53546011)(76116006)(9686003)(110136005)(66946007)(6636002)(316002)(66446008)(66476007)(54906003)(64756008)(66556008)(7696005)(71200400001)(6506007)(55016003)(8936002)(8676002)(4326008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjJIdzRxWSt3MHBwTU1HbWVQYk1aa2pjQjB6T2w4TlBKOG41bURBb2pFWjZP?=
 =?utf-8?B?SWFyTTJEelNNTVpDQ1lMb0ZoUkoyNk5OSHZCNnQvSGFjZlJ3dS80bjMrMWNV?=
 =?utf-8?B?Um5LVjlBK0NjZnVXeFFjQld5TXVEOVVkU0lMb3AzdS9EWnZaK1RIS293aVl2?=
 =?utf-8?B?aDB4MUp5SmJIOUJ4KzlvTDQzaEdkS1VUTnNrK0Q3Ty96S0piZGVpUnZhRUdz?=
 =?utf-8?B?aXVCR2tMaHhYSFFERlhtSFVXQ2RFdTk4Z0lxRXZvZnJTZHFvR1VDd2xtSzVp?=
 =?utf-8?B?a21Gb1VTWHVFWXFGSWxhTkpSMnFQNENoZkZBQUtzdTh5MnBFLzBhb1J1NFVh?=
 =?utf-8?B?NHhJdXp2b2F2MWt0TTRIbnBLYVU3WHdZVnFTQlRiL1ZrS1BkYkY4dHBWd1dw?=
 =?utf-8?B?NjVVZEtoUGsxdVZrRGZxWXl5TllXN2l2OE9WODBubGtuR1pMclp4eEY2aFhG?=
 =?utf-8?B?aW5uZk9FUXo0c1ZTUDdyWVJRTVpjT0d3eFRYbFVBT05GSm9pS0RZU2hWTmJ6?=
 =?utf-8?B?RFVRODRXaStkYm5CQlpObXRoeE9nK3Q5aFJhbmVyOCtKcEc1M0d4SWpXZUVy?=
 =?utf-8?B?Y2tqZVFkLzVETFh3N3dSWW1kUHloM1VXeks1RytTV3p2ejFaQVFPRWxyV2d6?=
 =?utf-8?B?MkVQZXZOL3VVTHRMNWtSaUs1ZmhtcHB6Q25rNkFiSVoxMFZqNmNZT3ZWUldp?=
 =?utf-8?B?eDk2TEw0cEt4MGlTL1plVExHamJ3VkN2MGRsRXV5ckt0MEZ5UUdycGcvdHRV?=
 =?utf-8?B?TVViSzdrdGMxejZuOEJ2Sjl6STd6UEdYZjhOdE94RTB6TEVrdlNaQ3VmWk8r?=
 =?utf-8?B?SThyT0t3Z2h2c1MvSmgzbS94WmREVGsyT1BaaHIyeXVBaEVZMlRKOUR1bGtv?=
 =?utf-8?B?RFgwMU5VNjVZTGZTUTNnSWY1QzlJdDI3cERWK3krSzg4dE1XN20yNHhwWStm?=
 =?utf-8?B?cm9ib01nZ3Y0YytYcHlXdHRwTnkwL1ZiTE1OMjQ3QnduZ1dIYStPUHJJQkJu?=
 =?utf-8?B?YWxDTEQ0VVFpRzFHb0VoSDJXa3lCOWNOQllmVlZRQi84Y2pIcElmckJNV3lT?=
 =?utf-8?B?aWdPTmdSVjVxRTNTRUZiY2FmcUhOaVlPemRpSDdmSFByK1JZbVJkRTV5RlZu?=
 =?utf-8?B?T1ozNXZ5RjlhdDU5NGZZODhKZlVGaGRzY1FsZE5LcEIrT0U4ZjhKdEJEcVg0?=
 =?utf-8?B?SS81eWtiWUxTeFE1Q1lvUTVYQkFuWWFqQjkrVGxnZXpkWk10UVJEaFBlclFW?=
 =?utf-8?B?U1Q5ZVNiR3JlVDhXYWhnR2lQdGphQ29mblYrbklXa09OWlBTYkZVNVNFTGZN?=
 =?utf-8?B?WHJRc1VCeXVkMmpvT21YcWU2aUtlMzJiVzFuSDhFVUdwbzlpcytjZnFDUWtC?=
 =?utf-8?B?S0JUa0VhNzk3RGl6T0pwcGpCS25QaEhvb1ZQeG02aFVsd0gySmN0UGo3a3pS?=
 =?utf-8?B?OUV2NDZHM0xZaGxsTVJrNjdxeDB2L3Vtd3Z0eFZ0YWRZTjZMeDIySUdXWkh1?=
 =?utf-8?B?dnRyVnJWVEFGVjdvc3hOZmFKS3V0UlYyNnNyQWJnU0I4eU5qL1QyQm41VGdP?=
 =?utf-8?B?VWgrT2ZCSkxqeFJxQUlHMWhXRXFmUzhZUHVJSWI0QlcyOXlOdlNEYnNoZzBC?=
 =?utf-8?B?ZW4rWkpuOHZmR1NrajZNWmx3VFFTczIwcEdCUFpPU1ZGSld6U1BQclJlblBV?=
 =?utf-8?B?T20wWm1XenJLNDZvSHJ6RXozbjZLVDJrOWZXVVh5QjBJcUtXcTBoeXJteU1n?=
 =?utf-8?B?a1Q1aFhBU3VjNEsrRDFWenJsMjlMUEQvcThXMVd6eGtOQ2huc0pCVWZycUd6?=
 =?utf-8?B?Q0U2Z2NrUjdvT2VBay9jN0FvSkRwS0UxcEVMd0hNdFJJUnR0VG1QaUxZYVFl?=
 =?utf-8?B?U24wV3JZMVYrYThzSjRtcERMMTdnQXgrRy81N0RWZjkwT0o0TDdQcGhhd09q?=
 =?utf-8?B?MGNBNWF2a2YzeG5tQXc2dkEwSmdvWHd2aDZOeGJLTG13SUdsMUQveVlpeko5?=
 =?utf-8?B?WHdlQy9WU1VnQlNyU0dxb1lEVDNLbk1DaGZnaVI5VTRvZm1nT00zclFHSlFB?=
 =?utf-8?B?R0xFQXlYbU9ieHpYNGZxVW5XM2VqVXl1VFk4ZFBQS1NwYzMxYWNoUEFhTW1E?=
 =?utf-8?B?eXhCU3RpaHlGbzFET2RnWjYxdGZHd1E0OEYva3BjaWhWTVAwSUFCR3hxdTR1?=
 =?utf-8?Q?hoc/r/Lb/uYLXWnmZ/h0U8c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258e34ae-42c8-46f5-4585-08dbdf0139ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 19:47:35.8084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vppEgZGSN9wDqlqvq7ckS9s2QhQw5WL9xu6ImCPhRwJMLUvPOCFlNE1oLDZAex9FGmqUI0sfYjJ9OeAbQWBZ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6459
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-10.cisco.com
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

T24gVGh1cnNkYXksIE5vdmVtYmVyIDIsIDIwMjMgMTI6MjQgQU0sIEhhbm5lcyBSZWluZWNrZSA8
aGFyZUBzdXNlLmRlPiB3cm90ZToNCj4NCj5JIHdvdWxkIGhhdmUgdGhvdWdodCB0aGF0IHlvdSBt
YXkgd2FudCB0byBjaGVjayBmb3IgdGhlIGZpcm13YXJlIHZlcnNpb24gaGVyZTsgdXBkYXRpbmcg
c29tZSBsaW1pdHMgd2l0aCBubyBjaGVjayBmb3IgdGhlIHZlcnNpb24gd2lsbCBtZWFuIHRoZSBk
cml2ZXIgbWlnaHQgZmFpbCBvbiBvbGRlciBmaXJtd2FyZSwgbm8/DQo+DQo+QnV0IHRoaXMgaXMg
YXJndWFibHkgbm90IHBhcnQgb2YgdGhpcyBwYXRjaCwgc286DQo+DQo+UmV2aWV3ZWQtYnk6IEhh
bm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0KPg0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3
IGFuZCByZXZpZXcgY29tbWVudHMsIEhhbm5lcy4gDQpTdXBwb3J0IGZvciB0aGVzZSBsaW1pdHMg
aGFzIGJlZW4gaW4gZmlybXdhcmUgZm9yIGEgbG9uZyB0aW1lLiBXZSBhcmUgYWRkaW5nIHN1cHBv
cnQgaW4gZHJpdmVyIG9ubHkgbm93Lg0KDQpSZWdhcmRzLA0KS2FyYW4NCg==
