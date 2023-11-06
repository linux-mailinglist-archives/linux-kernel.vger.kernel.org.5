Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F31F7E2D6F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjKFT7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjKFT7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:59:10 -0500
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE1A1BF;
        Mon,  6 Nov 2023 11:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1118; q=dns/txt; s=iport;
  t=1699300748; x=1700510348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZeZAI87OVZ8CPmt3ASoBB1n/HoHpgiISHlF5JoRUqDc=;
  b=E/DrzBa6nGZV28HEFQDTcf0BgRx7SNVwdZ3tdSdx3D2c52MVQ17ygwTu
   VD11j4H4EhGL/grQUa87fQvFkRrT/orLGTGU5nt+XC9C3bGJx5afbk6Ry
   Cbs+nA53LJh3uN8KwnM0qEKQkGnEICDpbAcnIJa2dIb2izfvhPbKdqEkA
   s=;
X-CSE-ConnectionGUID: ZfvoLy//QgWfHUhB/c2rYQ==
X-CSE-MsgGUID: Fir0Oh1lQVO8FpPzm7bl2w==
X-IPAS-Result: =?us-ascii?q?A0AnAACzREllmJldJa1aHQEBAQEJARIBBQUBQCWBFggBC?=
 =?us-ascii?q?wGBZlJ4WzxIhFKDTAOETl+IZZ1+gSUDVg8BAQENAQFEBAEBhQYCFocQAiY0C?=
 =?us-ascii?q?Q4BAgICAQEBAQMCAwEBAQEBAQECAQEFAQEBAgEHBBQBAQEBAQEBAR4ZBRAOJ?=
 =?us-ascii?q?4VoDQiGRAEBAQEDEhERDAEBNwEPAgEIDgoCAiYCAgIwFRACBAENBQgaglyCX?=
 =?us-ascii?q?wMBoGMBgUACiih6gTKBAYIJAQEGBAWybAmBGi4BiAkBgVCINicbgg2BFUKCa?=
 =?us-ascii?q?D6CYQKBYhWDRDmCL4kuBzKCIoMrKY0MCXdHcBsDBwOBABArBwQwGwcGCRQtI?=
 =?us-ascii?q?wZRBC0kCRMSPgSBY4FRCoECPw8OEYI/IgIHNjYZSIJYCRUMNUp2ECoEFBeBE?=
 =?us-ascii?q?QRqBRgVHjcREhcNAwh2HQIRIzwDBQMEMwoSDQshBRRDA0IGSQsDAhoFAwMEg?=
 =?us-ascii?q?TYFDR4CEBoGDScDAxNNAhAUAzsDAwYDCzEDMFVEDFADbB82CTwPDB8CGx4NJ?=
 =?us-ascii?q?ygCNUMDEQUSAhgDHgNEHUADC209NRQbBQQ7KVkFoR0xXYI/AZZHSa0FgS4Kh?=
 =?us-ascii?q?AyhPxeqAJg+IKgIAgQCBAUCDgEBBoFjOoFbcBWDIlIZD44gGR+DQI95djsCB?=
 =?us-ascii?q?wsBAQMJi0oBAQ?=
IronPort-PHdr: A9a23:caeKRhHlZMWwhP6dwIGUr51Gfu4Y04WdBeZdwoAsh7QLdbys4NG+e
 kfe/v5qylTOWNaT5/FFjr/Ourv7ESwb4JmHuWwfapEESRIfiMsXkgBhSM6IAEH2NrjrOgQxH
 d9JUxlu+HToeVNNFpPGbkbJ6ma38SZUHxz+MQRvIeGgGYfIk8Wz3uOa8JzIaAIOjz24Mvt+K
 RysplDJv9INyct6f78swwHApGdJfekeyWJzcFSUmRu9rsvl9594+CMWsPUkn/M=
IronPort-Data: A9a23:4pMEHqsZeKoB2grM8VN4ahqg4+fnVGteMUV32f8akzHdYApBsoF/q
 tZmKTzQaKzbYWL9fd1zbN6//U1X6MWDztYyGlRv+HxhHisRgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0rrav656yAkiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuHYzdJ5xYuajhPsvvb9ks01BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 44vG5ngows1Vz90Yj+Uuu6Tnn8iG9Y+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0HgkmVZCq9oMrLlCNv9KU61yBNELj/PtOMUEceoZC4NdOVDQmG
 fwwcFjhbziZjO6whbm8UOQp3IIoLdLgO8UUvXQIITPxVKl9B8ucBfSRo4YFh1/chegWdRraT
 8kQcyZuaB3DSxZOIVwQTpk5mY9Eg1GmKGcC8gvI/vZfD2774g1riJ/tad7sRPvaa91tjEPHr
 Gac4DGsav0dHIXPlWXamp62vcfLnCXmSMcRGae++/pCnlKe3CoQBQcQWF/9puO24ma6WtRCO
 wkP8TEvhbY9+VbtTdTnWRC85nmesXYht8F4CeY27kSGzbDZplzfDWkfRTkHY9sj3CMredA0/
 m2HgdTNFHsoibKqR1Kg9p3TpmmoCBFAeAfuehQ4ZQcC5tDipqQ6gRTOUstvHcaJYjvdRG+YL
 9ei8XhWulkDsSIY//7kog2f0lpAsrCMH1FlvFyGNo6wxlohPNbNWmC+1bTMAR99wGuxVFKNu
 j0PnNKTqbpIBpCWnyvLS+IIdF1I2xpnGGOF6bKMN8B8n9hIx5JFVdwLiN2ZDBw2WvvogRezP
 CfuVfp5vfe/xkeCY65teJ6WAM8316XmHtmNfqmKP4sUM8UtKFfXoXkGiausM4bFzhBEfUYXZ
 8/zTCpQJSpy5VlPlWDvHL5NjdfHOAhknTqNLXwE8/hX+ePOOCHKIVv0GFCPdes+pLiVuxnY9
 s03Cid540s3bQEKWQGOqdR7BQlTdRATXMmmw+QJLbTrClQ9Rwkc5wr5nOlJl3pNxfoFz48lP
 xiVBydl9bYIrSacdl3TOiE8N+mHsFQWhStTABHA9G2AghALSY2u96wYMZAweNEaGCZLlJaYk
 9Ftlx28P8ly
IronPort-HdrOrdr: A9a23:dOn8FK23iFnimDNJnyV71AqjBfdxeYIsimQD101hICG9Lfbo9P
 xGzc566farslcssSkb6KG90cm7LU819fZOkPAs1MSZLXnbUQyTXc9fBOrZsnLd8kjFh4xgPM
 hbAtVD4bHLfD9HZIPBkXeF+rUbsZi6GcKT9JvjJh5WJGkABdAEnmNE40SgYzJLrWJ9dOIE/e
 +nl7B6Tk2bCA8qh6qAdx84dtmGjefm0LjhZhkLDQMm7g6hsROEgYSRLzGomj0lf3dq27kNzU
 jp+jaV2kykiZ6G4y6Z81WWw4VdmdPnxNcGLteLkNIpJjLljRvtTJh9WpWZ1QpF492H2RIPqp
 3hsh0gN8N85zf6ZWeuuybg3AHmzXIH92Li81mFmnHuyPaJBg7SSvAxwL6xQCGprHbIj+sMlp
 6jGFjp7qa/OCmw2BgVIeK4Dy2C2HDE+kbK2tRj/EC3GbFuGoO567ZvvH+81Pw7bX/HAEdNKp
 g1MOjMoPlRal+UdHbfoy1mx8GtRG06GlOcTlEFodH96UkdoJlV9TpR+CUkpAZKyLstD51fo+
 jUOKVhk79DCscQcKJmHe8EBc+6EHbETx7AOH+bZQ2PLtBKB1vd75rspLkl7uCjf5IFiJM0hZ
 TaSVtd8Wo/YVjnB8GC1IBCthrNXGK+VzLwzdw23ek1hpTsAL7wdSGTQlEnlMWt5/0ZH83AQv
 62fIlbBvfyRFGeULqhHzeOLaW6BUNuJ/H94OxLLm5mivi7XrHXig==
X-Talos-CUID: 9a23:K7+PBWBR6mZqcnD6Extp6kkwC4diS3LiwlftI2X/AjxzeYTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3A1RXtoA4MPfKNNv94DFGJQtyixoxG4r72L0BUlaw?=
 =?us-ascii?q?4nJmqLRRiPmiXiG6oF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 19:59:07 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
        by rcdn-core-2.cisco.com (8.15.2/8.15.2) with ESMTPS id 3A6Jx7bm006153
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 19:59:07 GMT
X-CSE-ConnectionGUID: UzADJSv2RhSd3SdagixyQw==
X-CSE-MsgGUID: l8HaAxXOSpC2Gv5BpLpCRA==
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,282,1694736000"; 
   d="scan'208";a="7047566"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 19:59:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lndvQVsLJvZ6bHPME8ok24NuiQdUi6rExu0Lgel/+gPNqB+Yp9SVIal65SOGtKYLoZdoJXvSrOweXgr4RXYGaJbaxNvNDnoZrciIKezVired/f+k2kqGeyrryIAb5McCUWS+3pWqLOTy6nMoeja35mIJhUVZAlzEkejr/mKv4AmLfdJQxDqtcIZaD+0hhs/h0abkGZjaVm4MoBVIHr/b4w/hLFt2B3XtVB9LOf6UPmS5ABenft4x1+GeO32Sslj9+u0SFfEnhJnAyKa1TRWiqai4ugLxm89GdpPgyBsuahqf3049e4yVKKSg7i+2h48/4KDD/DNGSac4MdvEblrhKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeZAI87OVZ8CPmt3ASoBB1n/HoHpgiISHlF5JoRUqDc=;
 b=eQUHFtayXiox3VeQVx6N2LO4e4WleNACgOqyVOIBQsAny5mOjzT7W+QotN7R3hreBdUKu30Y0Jw8la3M4eA+yGKd0FURXBZfmd3CtEloTK80IhgvZzgxYu9BDplxEDvgv87194WwCctwLvVYil1ytpxGx6PvTkbiLwMaKnZoYbv9Fv9ywHn9roxsVnON3d/tH/UGwZZrLyeTEczfT3sNK5uKHKOhJFn9ek4LeRhC2I2N/xrajxqSqC9fSzjkTGINkb392HUeaZMOVP4n+5O2BCkdKw5KTGeOg5XgV01YLdk7Taw2bwiiY742A3sS1UdfLWD2xMUtHpSQqulMAeYjdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeZAI87OVZ8CPmt3ASoBB1n/HoHpgiISHlF5JoRUqDc=;
 b=oUapvG1Q9lCQExYQtTmIKeIBdN+zuaJL+CKiPvYWg0+vVT3QP+RkBDmJyaEVxW+keFMi+t8KBXUpxTPg57a4KhisLpuZblMuAOyWQ9eojsZX76LvSv1XXLFWTZ34B/hIQAgqMyeoaGLAJDHyxFs+FZzAz+BSPn7RSJXL2bMQ/nQ=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by MN6PR11MB8148.namprd11.prod.outlook.com (2603:10b6:208:472::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 19:59:04 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 19:59:03 +0000
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
Subject: RE: [PATCH v2 05/13] scsi: fnic: Get copy workqueue count and
 interrupt mode from config
Thread-Topic: [PATCH v2 05/13] scsi: fnic: Get copy workqueue count and
 interrupt mode from config
Thread-Index: AQHaCP/tKShgwGDS/06BN9B0SlII17BmqsKAgAcaU4A=
Date:   Mon, 6 Nov 2023 19:59:03 +0000
Message-ID: <SJ0PR11MB58963A469E3A8A96F30940E4C3AAA@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-6-kartilak@cisco.com>
 <e53de42b-945a-4dc9-aff1-87dcae7644b6@suse.de>
In-Reply-To: <e53de42b-945a-4dc9-aff1-87dcae7644b6@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|MN6PR11MB8148:EE_
x-ms-office365-filtering-correlation-id: 07d6f395-deec-4685-9e25-08dbdf02d3c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qy4oowok0zsYU2QWAndRc93leijkhT4CgWEt2+YYFhVUHeLrY1ENS3Yn/nhHv4BfqBF8MGdFzR/1RKlFUWNHVNsh+lQUPr8y/+9MKR2l5N7SHEkJ8X9/WU/eJKlbOqIVufk3fIbnd2cm1NeAK7aX5Oy3MqkM8aWrFzWvVLPHQhyoTtg2fSAWR+NEPyCwQUEm3ZXa7q6mM8odniyAqa1DUquTS4tv/BYR5V/Y/sz4hieEFAAG0BhuVuZCTIYriMU8FlJ8pP1g0uIa2HMuYx7oHhHQ+7n3Df1B3nqks4S/FUQEeNEEmeo7NggRuOuChsXWRCgYLGX6vDAG0s0abXXPnL31BTAJk7r+nGzJ705KZ+x8nwf4r6kL829T2POZM65WjkFNU1gI/3OxgwyplIqbCR+kBtI6wYoSPkiAQ6BUDCNrYyJrlIl0VLlzcm+yexieMa1AjfESOPxHyv0FQao7JH50TfffSXQkO/LHqxx93Z1Vc2U4c3cnO0SriAKbEii1zycEkMmd5Fb8TlvoNawFXokb5JWTAREDHazX9HCmm2iJfIRomWe9TI56jQpG38ZUZYgVKoD4sSshKwkEMAKp7f48URWyFNgPlhzMELOUqYSXhnG/17a22PG9+ZXtQTqD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(55016003)(41300700001)(53546011)(9686003)(6506007)(7696005)(38100700002)(122000001)(33656002)(86362001)(2906002)(5660300002)(71200400001)(52536014)(8936002)(83380400001)(8676002)(4326008)(38070700009)(64756008)(76116006)(66556008)(66946007)(66476007)(66446008)(54906003)(4744005)(478600001)(110136005)(6636002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXg4N3A3eEtFdXFGMEhVUkNoazQyU0ZEb1JMRDE0cGhJOThMVWNBOTg4UFlt?=
 =?utf-8?B?WkJrL1Q3MFpTVlBwQ2tHSmpHUkoxSE5GWGVPTGhRTXJRQ2MwaC9ieEkrNE1y?=
 =?utf-8?B?cE9VS1VHZ1d1YjNCNmlsZzI5N1c2bWErN2lzVjZMZzJGdGRJWHVrYjd3SDlo?=
 =?utf-8?B?THFURDRqbjlPTTFJbE45aldzc3dmZmFodVY3bjlZWVlGZUJGSm1wc3Z4Q09W?=
 =?utf-8?B?VE9tcDlEWHZsWUJEWG9nOGUzbG1DSVBQaUNEbTcxb0YxeGN5anlJa0tQeGdh?=
 =?utf-8?B?K1ZFOWM1VWxzeHNLZlpjTlA2K01jRUQ2VnNxd2YzdS9xaVVVQnlpd1kzdmpk?=
 =?utf-8?B?WXpyTUMyZlc0dHBoaUcvRVdydDVUMC9VOGp1eEZMb3E3QkF2T1RsMW83U3pJ?=
 =?utf-8?B?WFROY2ZZY21zdHJHUmFnL1NNT1o3ejhvejM0U2FxM1l5T0JiM3k1Y3pJa0Fw?=
 =?utf-8?B?Z01xUEtMejVPNXozTCsxV1RzU3ppWGdoMjkzbGl5emgyOUM1QVRvbWFDWHR6?=
 =?utf-8?B?RGNFNlhQaE84bGxnWWw2b1FPM3Q1MXZRaDZFeW9vTVgrWnRZNzRPZ09sb0ZE?=
 =?utf-8?B?a0tzSDZiV0lBVVloTUNhVDlQQ1hPd0l1b2lFc1ZIaTczQkorRTdVNGFDcWhS?=
 =?utf-8?B?T25HcUlYWVhLK2dpN0RwYkRqNEErNzE4c3Z6M010d2M4U3JHYTJ1WDRFSXY5?=
 =?utf-8?B?RVFad2VOaExORmFwKzZ1Mmp1aGQ5ZWlnMnR0eGQzTmFTTDdoa3hvdTVSOTFG?=
 =?utf-8?B?VitVbmFIOUNodGc5S0E1c2NFWDI2UUhhRHRDMzQ2bThyY0QwZ2pRV3k3czB2?=
 =?utf-8?B?K1M4bHJmZ3hRdHVHUDN1ZU1qQklsVlBiM3JpSTU1Q08xUm1CZFFOdmxxVzk4?=
 =?utf-8?B?di9PVFhYeXRBVElOUEpwZENQUTBmNGs5YTFwY3g1M3habnhsdTl2QVhHdlhl?=
 =?utf-8?B?MDRmaUN2RDVlS3JkTzk3ODhWdnVoeFBiYUJ5WEd4VnRXbjNYT0d4ZnBHaGhF?=
 =?utf-8?B?dmtyeTdZREFleUVDeDJ5eHVZSEs4dk9FdzZMVzZDWlRwaXlyMjdNSW83ajBF?=
 =?utf-8?B?TEdoeElVRzNyaHBMRWhMZERBZCt1OVdNS0RyT0hUbDYxN0NsUTZxVStlUDNt?=
 =?utf-8?B?WmJNV2MxSlhvcWNTOG5ub1k5WmhDWkY2WkdyaDFNVDBwWGR6SGMyaWJZbFNT?=
 =?utf-8?B?eTFmVG5ZWXhpQ0kyY1dDRDBDbVhQMENRMEhSNVVtbDJzRDljWVlwa3JLVDVP?=
 =?utf-8?B?K1pHdjl2ZWc1eHBMMGN0U2trMDQwUzlQVGR2UEhnRy9NSUIyYVhPN1h3OEdR?=
 =?utf-8?B?UWV5WnJzQVQxakNoWVFSWEc5Z1h4aFN1YnV1ckJXdkk2UEV2NGdxNkxhZzcr?=
 =?utf-8?B?VjlkeEgySUlORUxSTVVIWWhLbEEvSmJjbEhGYmE0bzllNlI4aXZ5OE53Rlgx?=
 =?utf-8?B?a3dHL054ZGVCYVVUTUdtUG5KaDNwakVmSlpuWEpaRnBuTC93amx2Nnk4R3di?=
 =?utf-8?B?YS94M3h6RG16SDBDa2lvUlJGTjBTQWw1ZmFuenIzbkJzVGRINTZCbm9PMTJX?=
 =?utf-8?B?cnZVT3hCTE05OEE3UGJaWHppVTZ0U01lbHFFR1hqeGJtN3R4MGgrZXU3N0Nw?=
 =?utf-8?B?bHozMEJYNE5hbFQrcm1kcG05c25TTzRsQ0RiOXFlMm4vbEd1ZkkzMDIwd2Fz?=
 =?utf-8?B?cEJDT1J0WXNvLzdxc3dkUzJBakdRVlVpQVQ4OVZicmJYUUJwM0Q0Vnc5WTlO?=
 =?utf-8?B?RjJhSUlsdXpkczVTdkdtOUVaSDhIdDE3MHZ0L3JmbGsvaEVvcHllVTRERzhS?=
 =?utf-8?B?c3hudTVuT3p1aGlVeldob3VxeEJNZjAwUjl2a1VLUHF6ejN6RWsvZ2doZHAw?=
 =?utf-8?B?RGIvLzMwZTlYcGR3QTl2V3I1OEEzcXVjMzJVdUJ5TVNUb0h0OWJsSVdNTlFP?=
 =?utf-8?B?TzViRTlQN2VzRUxTWHJIczdHVGw3SE9ybjJhZzU1SE9ZRFFYWTdnb2ROSjlm?=
 =?utf-8?B?ZFBuQnhSMjREa1JCcmZUMHVUNzZzUjZIQTRIMk95UEF2U3QvWk1hWDYydjlR?=
 =?utf-8?B?bHBGSTFyM0tKVk1oUEN6UmxrcGEzbmUrZnl2NVg1T2d5VHJDRGs0NG01T2lK?=
 =?utf-8?B?ZGFsaXNXWWY1RWtnbWJXdE1YSGkxdGJleFhMbFN6Ymo4TzlldE03NVhPdUo4?=
 =?utf-8?Q?MLAtBLFpBbI+HtBKUIWD7Pc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d6f395-deec-4685-9e25-08dbdf02d3c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 19:59:03.8515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OgLUm8AGAoCkfyihvVmcHVHLoj69GMBBwZm6eq5jye+dGRUhOuEGa3hr0sXJzE2LrKAvVugXGV0WHwchPyHZ9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8148
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-2.cisco.com
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

T24gVGh1cnNkYXksIE5vdmVtYmVyIDIsIDIwMjMgMTI6MzAgQU0sIEhhbm5lcyBSZWluZWNrZSA8
aGFyZUBzdXNlLmRlPiB3cm90ZToNCj4NCj4gT24gMTAvMjcvMjMgMjA6MDIsIEthcmFuIFRpbGFr
IEt1bWFyIHdyb3RlOg0KPiA+IEdldCB0aGUgY29weSB3b3JrcXVldWUgY291bnQgYW5kIGludGVy
cnVwdCBtb2RlIGZyb20gdGhlDQo+ID4gY29uZmlndXJhdGlvbi4gVGhlIGNvbmZpZyBjYW4gYmUg
Y2hhbmdlZCB2aWEgVUNTTS4NCj4gPiBBZGQgbG9ncyB0byBwcmludCB0aGUgaW50ZXJydXB0IG1v
ZGUgYW5kIGNvcHkgd29ya3F1ZXVlIGNvdW50Lg0KPiA+IEFkZCBsb2dzIHRvIHByaW50IHRoZSB2
TklDIHJlc291cmNlcy4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBTZXNpZGhhciBCYWRkZWxhIDxz
ZWJhZGRlbEBjaXNjby5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEFydWxwcmFiaHUgUG9ubnVzYW15
IDxhcnVscG9ubkBjaXNjby5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2FyYW4gVGlsYWsgS3Vt
YXIgPGthcnRpbGFrQGNpc2NvLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvc2NzaS9mbmlj
L2ZuaWNfcmVzLmMgfCA0MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0NCj4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+
DQo+IFJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4NCj4gQ2hl
ZXJzLA0KPg0KPiBIYW5uZXMNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldywgSGFubmVzLg0KDQpS
ZWdhcmRzLA0KS2FyYW4NCg==
