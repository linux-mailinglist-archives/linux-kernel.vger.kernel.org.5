Return-Path: <linux-kernel+bounces-30628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FEF832239
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04A7CB22BB4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18511EA78;
	Thu, 18 Jan 2024 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="HNFr0eWz"
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7233A1DA4B;
	Thu, 18 Jan 2024 23:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705620176; cv=fail; b=rX0gjfBeR5W3FRfdAY5pX5hcmjv4v2cGxh5n/oj4OlbtF8NJalW6iTELuEcBQ6vX98dOjmFnJOHStIPrCGDAt/w+IiDcxJcsZTMDFb5kW5CXMKxqnfLX9QorUMm5Ko8iuhtEwDBChmmw0HjzKJK+L3kdkeXsQNBTZGHPjFapSRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705620176; c=relaxed/simple;
	bh=Oyr/MPtW1HD0hfvexB6JZx4rDmFsnv4IEzuNbgLtagI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eF1zvbzcy5Fx3ODNS23FYM5JhzTgMhlRIlM65uiqWz3pGccS01gpF8KcdH4iPP4otmiF4dv6HTCSjQJcp/qas4C7yFo/pZaoHmlfFmRtqowX1c7i6pb8oh7sUXvovqbgq1zLQGKej/d3zz6hGnwgEZzoaWiOyCr9k3ULFKIm7cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=HNFr0eWz; arc=fail smtp.client-ip=173.37.86.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1333; q=dns/txt; s=iport;
  t=1705620174; x=1706829774;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Cboys2nFl31MPrMfjcgr2rPDbGrkY2QRq4S7BIfrjVQ=;
  b=HNFr0eWznd8/hMq89TYahu4Ve0QlVXvoRZPCUogFKSJJ2i+5KvJwHG27
   Kj1rnVxUNTGxaXXV2o71IrU1/r6s5GEWMt2Zt5X81GFebEqtQ2Wvg9XEN
   zgvPuszGk0jwGes+vSzVNKk2DTGsdOhm2WKj2gYdbJSzyr0/AoZP38r7T
   w=;
X-CSE-ConnectionGUID: BnqdERTZR4GkRNzJMoSf9Q==
X-CSE-MsgGUID: KHvhgjaZSXuYWD60rcDyag==
X-IPAS-Result: =?us-ascii?q?A0CPAQAlsqllmJtdJa1aHgEBCxIMQCWBHwuBZ1J6AoEFE?=
 =?us-ascii?q?kiIHgOFLYhqngQUgREDVg8BAQENAQE5CwQBAYUGAodFAiY2Bw4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEGAQEFAQEBAgEHBRQBAQEBAQEBAR4ZBQ4QJ4VsDQiGPQEBA?=
 =?us-ascii?q?QEDEhUTPxACAQgYHhAxJQIEAQ0FCBqCXgGCXwMBEKpBAYFAAoooeIEBM4EBg?=
 =?us-ascii?q?hYFsncGgUiIHAGKIicbgg2BV3mBbz6CYQQYgS0bhBKCLwSCFoJlXZEqUoECH?=
 =?us-ascii?q?QOBBQRcDwUWDx43ERATDQMIbh0CMTwDBQMEMgoSDAshBRNCA0AGSQsDAhoFA?=
 =?us-ascii?q?wMEgTAFDRoCEBoGDCYDAxJJAhAUAzgDAwYDCjEwVUEMUANlHzIJPA8MGgIbG?=
 =?us-ascii?q?w0nIwIsQAMREgIWAyQWBDQRCQsmAyoGNwISDAYGCV0mFgkEJQMIBANUAyN0E?=
 =?us-ascii?q?QMECgMUBwsHeIISewNEHUADC209NRQbBQSBNgWVMAGCO4EOHBCCFJMogymPe?=
 =?us-ascii?q?IozlHoKhBGMBZVHF6oUmFMgjU2aVgIEAgQFAg4BAQaBaggrgVtwFYMiUhkPj?=
 =?us-ascii?q?jmDWJAAdgI5AgcLAQEDCYpnAQE?=
IronPort-PHdr: A9a23:nwBeoxKF2nRq87iMLtmcua0yDhhOgF28FgcR7pxijKpBbeH/uZ/jJ
 0fYo/5qiQyBUYba7qdcgvHN++D7WGMG6Iqcqn1KbpFWVhEEhMlX1wwtCcKIEwv6edbhbjcxG
 4JJU1o2t2qjPx1tEd3lL0bXvmX06DcTHhvlMg8gJe3vBo/Whsef3OGp8JqVaAJN13KxZLpoJ
 0CupB7K/okO1JFvKKs61lPFo2AdfeNQyCIgKQeYng334YG7+5sLzg==
IronPort-Data: A9a23:JiJpsq3h7Z//g3b9A/bD5fVxkn2cJEfYwER7XKvMYLTBsI5bpzBWz
 GcXDT2OO/iIZGekeNtwOovkpkpQu5KDyNBjQVQ53Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ1yFjmE4E71btANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXV5
 Lsen+WFYAX5g2ctYjpOg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauG4ycbjG
 o4vZJnglo/o109F5uGNy94XQWVWKlLmBjViv1INM0SUbreukQRpukozHKJ0hU66EFxllfgpo
 DlGncTYpQvEosQglcxFOyS0HR2SMoVs/qbLDEKDg/bP4E78VWnO5vJVAhAPaNhwFuZfWQmi9
 NQCIzwLKxuEne/znPSwS/JngYIoK8yD0IE34y47i2qGS6d9B8meHs0m5vcAtNs0rsNHB+rfY
 8MaQTFudx/HJRZIPz/7Dbpnw7331yekI2cwRFS9hoop42fRxT5K4KXcD/aLIsaBadRckRPNz
 o7B1z+kWk5BboP3JSC+2natgPLf2CD2QoQfEJWm+fNwxl6e3GoeDFsRT1TTif24jFOuHslUM
 E085CUjt+4x+VatQ927WAe3yENopTYGUNZWVuY98gzIluzf4h2SAS4PSTsphMEaWNEebzoz2
 nKzo+HTWRNsipuHa1eazbnFlGbnUcQKFlMqaSgBRAoDxtDspoAvkx7CJuqP9obo3rUZ/hmtk
 1i3QDgCulkFsSIcO0yGEb3vmTmgoN3CSRQ4o1mRVWO+5QQ/b4mgD2BJ1bQ5xagdRGp6ZgDd1
 JThpyR4xLteZX1qvHfdKNjh5Jnzu5643MT02DaD5aUJ+TW34GKEdotN+jx4L0oBGp9bIWK3O
 BWN6VwMucY70J6WgUlfPtPZ5yMCkPmIKDgZfqC8gidmO8EuJFHdoEmCm2bJgz6z+KTTrU3PE
 czGKZn3Vyly5VVPxzutTOBVyq4w2i073ivSQ5u9pylLIpLADEN5vYwtaQPUBshgtfvsiFyMr
 753aZDQoz0BC7KWX8Ui2dNJRbz8BSJlVcmeRg0+XrPrHzeK70l/UKGAnu99ININcmY8vr6gw
 0xRk3RwkTLXrXbGMg6NLHtkbdvSsVxX9BrX4QRE0Y6U5kUe
IronPort-HdrOrdr: A9a23:OKvjVaPynSqwksBcT47255DYdb4zR+YMi2TDiHoBKiC9I/b5qy
 nxppUmPEfP+UgssREb9expOMG7MBXhHO1OkPgs1NCZLUbbUQqTXc1fBOTZskfd8kHFh4pgPO
 JbAtdD4b7LfBZHZKTBkXSF+r8bqbHtntHL9ILjJjVWPH1Xgspbnn5E43OgYzZLrX59dOIE/f
 Snl616jgvlU046Ku68AX4IVfXCodrkqLLKCCRtOzcXrCO1oXeN8rDVLzi0ty1yb9pI+9gf2F
 mAtza8yrSosvm9xBOZ/XTU9Y5qlNzozcYGLNCQi+AOQw+cyjqAVcBEYfmvrTo1qOag5BIBi9
 /XuSotOMx19jf4Yny1mx3wwAPtuQxeqEMKiGXow0cLk/aJAA7SOPAxwr6xtSGprXbIiesMlZ
 6jGVjp7qa/QymwxBgVrOK4Jy2C3nDE0kbK19RjzkC2leAlGeVsRUt1xjIPLL4QWC3984wpC+
 9oEYXV4+tXa0qTazTDsnBo28HEZAV5Iv6qeDlKhiWu6UkfoFlpi08DgMAPlHYJ85wwD5FC+u
 TfK6xt0LVDVNUfY65xDPoIBZLfMB2BfTvcdGaJZVj3HqAOPHzA75bx/bUu/emvPJgF1oE7lp
 jNWE5R8WQyZ0XtA8uT24AjyGGGfEytGTD2js1O7ZlwvbPxALLtLC2YUVgr19Ctpv0Oa/erLc
 pb+KgmdMMLAVGebbqhhTeOKaW6AUNuJfEohg==
X-Talos-CUID: =?us-ascii?q?9a23=3AIOPzpGrDm4/Kv2Z3QA8Q3L/mUeoja3Hw9kviGRO?=
 =?us-ascii?q?XClxPWp+wTmSeqZoxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AAgsO1A98ptOibMvRCL5ByyeQf+RI/aShCkk/qqU?=
 =?us-ascii?q?bivaoa3RqMBuMhTviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 23:21:45 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
	by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id 40INLjnD015096
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 23:21:45 GMT
X-CSE-ConnectionGUID: ezyEBZUuSDe8QBKcnFuFBQ==
X-CSE-MsgGUID: P+emm7pfSZCyfZsPapVXeQ==
Authentication-Results: alln-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.05,203,1701129600"; 
   d="scan'208";a="20541706"
Received: from mail-sn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.40])
  by alln-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 23:21:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Obx7mJ6Sx/pZl9FLHCgYEgbvz8swyrxerGRiSZSdYdg2Vq+MD/MZPOewR/mdfHf3mKcnNRe3UPBNLRsVSh4lOaaykygT3obBd2aoCswkSaoBWljNGwiiYBpBaExAOObOJNpYGyZo+FBKRqL8pGOrdOGs/D0ubWS3SJsgqic7ef6ojsGMQJM8Xp0yLoyQPGr5TYihU4KF/qEwXMAr4pWuXe4HgwbX2Vl0H8+GF3BzAfmthgnx4Qk3WiSIyzVCEume3WG97JleYoRTky2XWmoD8HS4zKPIK0bnkuJLfm95CWULw2/FqTlL/DR8RRBXRYP5iNfsbIeaBNtNDCI5WeBFFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cboys2nFl31MPrMfjcgr2rPDbGrkY2QRq4S7BIfrjVQ=;
 b=Bgh7deMOxD1pQHuIICNTFlRXhSb0AdZSvuwZee6gvROZwtHDUCffRhUJWXGAecEzfLLqiS3e9KT8k5TA/V7pZfsrVxdnMajXHJ2eq1q4qK4xgDNthkNYuhlnw/TfWIVxHgBnSalhbbmVo8auc5nVZ2V4GgBZG7URLM6nhQUfaQpNsGftfilSRrzWrY1NuLDRm2ItSviMc6d/sh2RO7bpleCVd5exP/1spVTc19wmDwk8r3tzd0CbwhrtBJzsG1o5XPKibiYyN9/VsDsseFJW89EFjJw+XD3C8CmQ7BXm4yWoMVvz910BReyCDSauW9s6O5KO/MpseMLGWjII3STrmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 23:21:43 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::55e2:9720:962:3073]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::55e2:9720:962:3073%5]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 23:21:43 +0000
From: "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "Satish Kharat
 (satishkh)" <satishkh@cisco.com>
CC: "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>,
        "jejb@linux.ibm.com"
	<jejb@linux.ibm.com>,
        "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: RE: [PATCH] scsi: fnic: clean up some inconsistent indenting
Thread-Topic: [PATCH] scsi: fnic: clean up some inconsistent indenting
Thread-Index: AQHaSbJMF9q6HN+o9kOEpYOIx9JFibDgNafw
Date: Thu, 18 Jan 2024 23:21:43 +0000
Message-ID:
 <SJ0PR11MB58969F9C068CDD09DB63728CC3712@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20240118020128.24432-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240118020128.24432-1-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|PH0PR11MB4904:EE_
x-ms-office365-filtering-correlation-id: 0a3e4212-bad8-45aa-c793-08dc187c3b70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 R+PnfzcmuA+VoenNd5Ap8dbuoCHunnUicsKbaNZJCfJ9955qATYxKK9tOS6b0fMxjphFFDXFTOUhtX5EYbllX9GrUzJbgx0+fBAuZfu/98rNBsudKBlDXbx82Tw/ly4cHm+97gj3u/mpweiPYvB2qjwIu/UdyRPlL+HTPARsP0nsMw1bVd6kMXZZax4ace99BMx1tmc4pgztGY9aYzSjXNAMTHc3cJrZqbxWi9v8fPPGTaKMIuCU2qBwb8/1amXKMvMQFQJfTP9QXIFb28otvvzbjs183wZmdFhh6mL/K8XHIxwaXUcwn5fEg8h64uo8PKHISlUeddT4+x7RdKzJu+MCEB4jCm3qdClG2eUMWU1bQU3AiApci+ICnniV5m2dI5ltKm1fkf8MOT+PmQNMKhSH4+dKxvo9vqy6GUP6l4sCgD4wwU4EYxv6T9V63jdvPnmBQhSiW7wWbLknlZY1C8L+DoZOfNSDSBVK8IWNg+1/ew2l85nKfnCio9Dz11X9/JVdjn8zIHWRYTsZGjUtu819eO7QHlwvjRvBM/sCmeQAxoJopmMSp51rD3qI/KGYUX6bDQGLwxWUZrAVGMCiz7ieuBkeyHLSL6vPq8uEaus=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(33656002)(2906002)(76116006)(66446008)(66556008)(66946007)(64756008)(66476007)(86362001)(6636002)(5660300002)(6506007)(71200400001)(38100700002)(7696005)(966005)(478600001)(53546011)(8676002)(8936002)(52536014)(54906003)(4326008)(316002)(110136005)(122000001)(55016003)(9686003)(38070700009)(41300700001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?P9hAqg2xUhBRAwyAT39dCO6eYj4CG6lpqW7L8bvDNMs9EuJe619NQyG9xgt5?=
 =?us-ascii?Q?NajgELxRElTAnh0oSWGcD9dlZENtLeED3/FpRaK7UvRsJBtBA1NVkqsZQzIs?=
 =?us-ascii?Q?noIMVFfbclrmHayKoea1p0HatadtKo+oR0Q9hO8zBMGSYNhFu+khw+U1IS73?=
 =?us-ascii?Q?wlEh5apxy+9L8oQIM5Gy+66crupE9MtTks8Kzt4iT7aDdi0Akd6nfmSNmOrP?=
 =?us-ascii?Q?9XfKAXDOT61MQ5banYQi/0RTPmb6Ur0pMRkMWJTrP+YpgQOnkBmNwTYcdRUa?=
 =?us-ascii?Q?TXxK3gVZ2G/8RPY0WsZomxxKJlNKRDDD6TNy9zO/WxQrjrcwpnOqGM1VKzei?=
 =?us-ascii?Q?etIQWmyNnVDLYCP2TUV/NcUQGhRARjnxG/+P9zynACajZ5IjprLVWl0+Hdv3?=
 =?us-ascii?Q?7zfOXkcgIgOzfrZ9Rywmw54KhU2efgXzRpLN9DgLsoUVY+CD+3VgXwnwnqg8?=
 =?us-ascii?Q?4ZWx8Kwet1db87H5n0ZG0SiWvaQDxd56cQhUUGFE+KVRC6gnInOkhN/k2qtE?=
 =?us-ascii?Q?gVdFwvrp8kBxxwQssKdFMndwHPGB4ZtbvUrHPNZWzPz8uLNQsf1i9gtQ0EZH?=
 =?us-ascii?Q?FPKjCTpZ8Wv/vkYzw1NQzEW0wSpCTM54NldTbTgPI8diklXPM9jGvdWhG15y?=
 =?us-ascii?Q?y39KjwfN3hxx5FaAdCR9GahqvnnZw+i2hOSLmwbci0gaXKTxwQejBPKkeS/2?=
 =?us-ascii?Q?rzqvvhnO67t4Xr6eReQPgqnvIN3aU6/PFVmGM2+LgoU3gm3UjG2Qw5UXFsUN?=
 =?us-ascii?Q?eMYCT1Vmh8UFwxB8FsnNGuKGmpck7zYGsW+x8IDplHJnoMeu8ahtlfzKyAqQ?=
 =?us-ascii?Q?FwnJxq46ZyuftGhSxB5rWzYXGiLagDqZ1yMqbYPea4WaLL7ePNdfvHPMqV6+?=
 =?us-ascii?Q?/fbcZOxiHA8/OwCUwmS5H8a3hK795YG5Bbh9wqrULA7v+iVh1vNsHAxORvHj?=
 =?us-ascii?Q?Yup7l9zZZ9BKDMZvSrn8mJcaOLOrp7twDNz/+1cLFYdT4L4TggbnT4ugr8IH?=
 =?us-ascii?Q?JRV2F0nZoLcilcStvuZjGAtqMVFd0iITmlbuPOPNAXOZJ0gNHcXSsGCGH1Ym?=
 =?us-ascii?Q?4wm+1i4KgCK3M7xpauPR7TMqn/Q9q8fWYd1Kqcz8QPX4s5xPgcwY1utKUmxl?=
 =?us-ascii?Q?JtbKKXGbv0d+ugtbDVjquLPnPx6OwyMWjiMULQKkh9VknQFjvRx7aOf/noEm?=
 =?us-ascii?Q?+DQX9NkFaBlZHrfnYnu8QkmFhuea/qOwGPcTZSlMrVOMFQ+vIIzUmtBcikd4?=
 =?us-ascii?Q?nOT/4hX2X3LFIvvzcAuriYmkqz34uqLRE20B7kV9RB+E9OyRoyPszy3lbt2Z?=
 =?us-ascii?Q?osYTVz5CxOVjfos9WI+ugt0lol8zufZ0WNzKGwn4BNAh36i6LO5uUAfB00R+?=
 =?us-ascii?Q?+F7h6jhDTZEnfsGW9p3Silqjdi8rZrkuTqC1EF6aLnx7cBvOVWIgSSsz2U3E?=
 =?us-ascii?Q?IgPtWcP5UdVqprKjebP92yMnn4P7ez8RnqhdBOvBe0/GCdy5hdoWFFXkLrM+?=
 =?us-ascii?Q?JNOxIR9ZrPCH8GnySuidtcJ/rAGhO0/FW573gJl6Os79K6F2EZ6WCvx43o1z?=
 =?us-ascii?Q?m7XVxgM6ZOVUl9uP2/bZZ9WD/5u3DiHkGxFAwO6bPKoYMcCQ0Oou3mvmMZpY?=
 =?us-ascii?Q?jT/FoYww7r13YyxIG0Ku7H8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3e4212-bad8-45aa-c793-08dc187c3b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 23:21:43.1676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1YLgsXGuXFu3zCG08A4N/S4sD6frTBWrSBiulse1BCbvPc1KfCK8Yq0Dc/6K7iEjtOUKvcM9WH0Zri7pjz158Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4904
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-4.cisco.com

On Wednesday, January 17, 2024 6:01 PM, Jiapeng Chong <jiapeng.chong@linux.=
alibaba.com> wrote:
>
> No functional modification involved.
>
> drivers/scsi/fnic/fnic_scsi.c:1964 fnic_abort_cmd() warn: inconsistent in=
denting.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D7930
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> drivers/scsi/fnic/fnic_scsi.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.=
c index 8d7fc5284293..5b4768e669f0 100644
> --- a/drivers/scsi/fnic/fnic_scsi.c
> +++ b/drivers/scsi/fnic/fnic_scsi.c
> @@ -1961,8 +1961,8 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
>
> if (!(fnic_priv(sc)->flags & (FNIC_IO_ABORTED | FNIC_IO_DONE))) {
>               spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
> -         FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
> -                     "Issuing host reset due to out of order IO\n");
> +             FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
> +                           "Issuing host reset due to out of order IO\n"=
);
>
> ret =3D FAILED;
> goto fnic_abort_cmd_end;
> --
> 2.20.1.7.g153144c
>

Looks good to me.

Reviewed-by: Karan Tilak Kumar <kartilak@cisco.com>

Regards,
Karan

