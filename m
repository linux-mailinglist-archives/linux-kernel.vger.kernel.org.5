Return-Path: <linux-kernel+bounces-108239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 601B1880844
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB2AEB2203C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69EB5FBAC;
	Tue, 19 Mar 2024 23:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="HmVYeLv4";
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="F6PXSarI"
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EE05FB90;
	Tue, 19 Mar 2024 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710891617; cv=fail; b=A7z/XMe2Yer6Ygh+7FSoULclsiPaxSpN4pEf6UGBPg7lb+EstLCtAik88oFfSPyM4fs/4KvVgWLX3s7EKyOVRcC9KKJbbKPeqUTFkxrQt1TypQ/viNLbeEQREGp4Xdk1RuR7+ihjx8HDGfow3UO2N1UTUNHuV9P/u5XsGZERJio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710891617; c=relaxed/simple;
	bh=s5C6aqf/+84IG+lYk8pzSUrWTfC3KyY69u2VWnYA9u0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VONh4nhjSQNaBJ49EMVPWee1VdYwULmkH3WRJyl1EvxwYlEezvpktzGYw8g+RFu705bW6BdqWhwvkiCzgCncLeb4IDdIPFkWEbFodAOxJxI5n7nc984754b+3gLRHbkb8g6XYj4X+xbbjTpKhA1ErmeV/l6Z+znHH2wTPifxWrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=HmVYeLv4; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=F6PXSarI; arc=fail smtp.client-ip=173.37.86.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2823; q=dns/txt; s=iport;
  t=1710891615; x=1712101215;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+7KhkR9WL/g+fy5VJLletwhDlLGs3uEk/QDyC7GIOIg=;
  b=HmVYeLv46wREIAJgSELSFPXJmM1KNYGR7DfDxdISSQNXfmKsK0r4LgCj
   Uuu9HsqZp+2MRb4ViRmCvOP89qpWU4f++IpL/u/bGvy0A7akWS8J0DgZK
   C8TgWxz6Yaf+RgmkgOfUEYXJf5fiK/Tk9mHJ1P/kbnU7tHm+zKMg5IydX
   8=;
X-CSE-ConnectionGUID: ITqhX0PzSgOP8BkdKNXfrQ==
X-CSE-MsgGUID: jEF6u2iYRkCIzKPL30YY/Q==
X-IPAS-Result: =?us-ascii?q?A0ARAABZIfplmJ1dJa1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEWBwEBCwGBZlJ6AoEFEkgEiB0DhE5fiGsDngeBJQNWDwEBAQ0BATsJBAEBh?=
 =?us-ascii?q?QYCiAICJjQJDgECAgIBAQEBAwIDAQEBAQEBAQEGAQEFAQEBAgEHBRQBAQEBA?=
 =?us-ascii?q?QEBAR4ZBRAOJ4VsDYZOAQEBAQMSFRMGAQE3AQ8CAQgYHhAxJQIEAQ0FCBqCX?=
 =?us-ascii?q?gGCXwMBEKEqAYFAAoooeIEBM4EBggoBAQYEBbJ4AwaBSAGIJQGKMScbgg2BF?=
 =?us-ascii?q?UJ5gW8+gmECgWKEEoIvgheDEimSYIZ7hSZUfxwDgQUEWg0FFhAeNxEQEw0DC?=
 =?us-ascii?q?G4dAjE6AwUDBDIKEgwLHwUSQgNDBkkLAwIaBQMDBIEuBQ0aAhAaBgwmAwMSS?=
 =?us-ascii?q?QIQFAM4AwMGAwoxMFVBDFADZB8yCTwPDBoCGxQNJCMCLD4DCQoQAhYDHRYEM?=
 =?us-ascii?q?BEJCyYDKgY2AhIMBgYGXSAWCQQlAwgEA1IDIHIRAwQaBAsHeIICgT0EE0cQg?=
 =?us-ascii?q?TQGihwMgwwCBSMqgU4pgREYggADRB1AAwttPTUGDhsFBB8BgRkFomwBgl8Bg?=
 =?us-ascii?q?Q4sUIFDATQvoiyjAwqEEowLlVMXqi8umDEgjVCVOYUrAgQCBAUCDgEBBoFkO?=
 =?us-ascii?q?oFbcBWDIhIBPxkPjiAZH4NChRSKZXgCATgCBwsBAQMJimgBAQ?=
IronPort-PHdr: A9a23:14HXyh2f1Mx2wOp5smDPY1BlVkEcU/3cNwoR7N8gk71RN/nl9JX5N
 0uZ7vJo3xfFXoTevupNkPGe87vhVmoJ/YubvTgcfYZNWR4IhYRenwEpDMOfT0yuBPXrdCc9W
 s9FUQwt5Gm1ZHBcA922fFjOuju35D8WFA/4MF92L/7pG4rbjOy81vu5/NvYZAAbzDa4aKl5e
 Q2/th6Z9tFDm4ZgJ60tghfIuS5OfOJbhCtkcFmShB37oMy3+fZe
IronPort-Data: A9a23:7HAXI67pGJbjSipQKKVEHAxRtB7HchMFZxGqfqrLsTDasY5as4F+v
 mpLXWrTM/rfamr1KY10b9u+9hkB7cLWnNZiGVFrripnZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyKa/lH1dOG58RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wq/KUzBHf/g2QoajlNuvrYwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoZWk
 M6akdlVVkuAl/scIovNfoTTKyXmcZaOVeS6sUe6boD56vR0SoPe5Y5gXBYUQR8/ZzxkBLmdw
 v0V3XC7YV9B0qEhBI3xXjEAexySM5Gq95fmHWG/gZSr3XbJVEO86fZiL2cGM5chr7Mf7WFmr
 ZT0KRgXZRyFwumx2r/+FK9nh98oK4/gO4Z3VnNIlG6CS615B8GYBfyXure03x9o7ixKNfXXf
 dYYbTNsRB/BeBZIfFwQDfrSmc/y3iKgL2QJ8wr9Sawf4UX9khEr0YnXM/H0aP+yYZ4Nr3ffn
 zeTl4j+KkpHbIPEk2XtHmiXruvOmz7rHZkZD7yQ6PFnmhuQy3YVBRlQUkG0ydG9i0ijS5dcJ
 lYS9y4Gs6c/7gqoQ8P7Uhn+p2SL1iPwQPJKGOE8rQqK0KeRvUCSB3MPSXhKb9lOWNIKqSIC9
 2OQn+OxPS5Uv5qtGVie+pSynT2oAH1ARYMdXhMsQQwA6tjlhYg8iBPTU9pueJJZaPWrQ1kcJ
 BjU9kADa6UvsCId60msEbn6b9+EvJPFSEs+4R/aGzzj5QJib4njbIutgbQ60RqiBNjHJrVil
 CFY8yR70AzoJcrQ/MBqaL5QdIxFH97fbFXhbadHRvHNDQiF9X+5Zpx36zpjPkpvOctsUWa2O
 ReD5lgJu8MLYCvCgUpLj2SZVpRCIU/ISISNaxwoRoYmjmVZLVbYrH80OSZ8IUiyzhBEfV4D1
 WezKpv0Ui1AVsyLPRK9RvwW1vcw1zsiyGbIDZH9xFLP7FZtTCD9dFvxC3PXNrpRxPrd+G39q
 o8PX+PUkE83eLOlPUHqHXs7cApiwY4TX86m8qS6t4erf2JbJY3WI6aKkeN8KtM7xvQ9eyWh1
 ijVZ3K0AWHX3BXvAQ6LcXtkLrjoWP5CQbgTZETA4X7AN6AfXLuS
IronPort-HdrOrdr: A9a23:OI3gwq8PmAbVQTT1MDZuk+Gddr1zdoMgy1knxilNoENuA6+lfp
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
X-Talos-CUID: 9a23:z27sDGFVdJD0JbMzqmJGyFcUKpgdYEbS60+ACUy0KkBZRqesHAo=
X-Talos-MUID: 9a23:QM6DnwjpICZuqJh1uaHiQsMpNupGvbn0CXE3kr4nqeq8EXcoCgbatWHi
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 23:39:04 +0000
Received: from alln-opgw-5.cisco.com (alln-opgw-5.cisco.com [173.37.147.253])
	by rcdn-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id 42JNd44D012870
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 23:39:04 GMT
X-CSE-ConnectionGUID: KUCraE4yQZq061IGFnoA1w==
X-CSE-MsgGUID: dCmb38NXTO2u4Ah3kv2tMw==
Authentication-Results: alln-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.07,138,1708387200"; 
   d="scan'208";a="5948531"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by alln-opgw-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 23:39:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPutBX6mnxs+1dCwbf8pJ9zvCjjITQQgW7XIvtjWL9S2mVMg4DyqUNMmls3PPhQ6lgCwbmpxliCAYyQCF9SbF3MUbtbYyG1bBVzWMVEKTkZJ0XWt+v9pITR/9evpvkteBh2zAMZc+QjCT6nUmJNs8f1R+t5ET7MAt6NJQVDaqXbhc11pTllRAJT98GIvrC4eISbP0TDyJ+rU9OM1aQjGNCdk0UkaJn5FUe4nagRK47ik79bIJ+XZitvkqb+o9nmdDEMsjNQOEm5iMfQs/H5Hp8QJRdfY4shzfFd5NFDGi1j6yBETGxWPuPYZSodnWTkC4yRFGSyvvvzYzT2lmy+xUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7KhkR9WL/g+fy5VJLletwhDlLGs3uEk/QDyC7GIOIg=;
 b=QeV04NFxcRXY2zK7NzRLgLemyaEgtxEDUOaY7dNO/DNDFhobRalEwJCG2EcaOYPySkPj2XRvC9segtckyxa86qPFfqO38kjAZKyGbLy9tGvQfg85oCSC9ex/iBT3pbHPg07zXOZz2ivhcuO2UwIhSr4Arv3ietj/BC5PuP6VlgFy44ijW6075YdewJ9wg6j2U+LoKguojsu2lcUD0eGoLfvpdHWlw90+7rahJ+uTyu6y7QjUFD098XRjE2CollfC9aspHnCc7ZfiAqf5ihPheZcKJOqi0rarfrW1aP7LOG62t/t5KwLpsxhp0I0IYKKjtpoAEmvXBGyHu2QI1qDgRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7KhkR9WL/g+fy5VJLletwhDlLGs3uEk/QDyC7GIOIg=;
 b=F6PXSarIlVpvnmxKd2E6ZDtjU52I+uTVyqGJBtv7zqZZf/csZ1vR4PrWMIhirBh6WnfiZj1tI1SqdXfREhK5QXxnfdDAeSapex67dcTDLETCproLCrHOrS1/WMzScr9pf8pylEBopsI3RPTg8V3ZwdGF7gVKPreAM2Fp5Li81co=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by CO1PR11MB4900.namprd11.prod.outlook.com (2603:10b6:303:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Tue, 19 Mar
 2024 23:39:02 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::db54:936f:ac82:4516]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::db54:936f:ac82:4516%4]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 23:39:02 +0000
From: "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To: Li Zhijian <lizhijian@fujitsu.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>,
        "James E.J. Bottomley"
	<jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH v2 12/25] scsi: snic: Convert sprintf() family to
 sysfs_emit() family
Thread-Topic: [PATCH v2 12/25] scsi: snic: Convert sprintf() family to
 sysfs_emit() family
Thread-Index: AQHaecc+MkuUcRMBh0aVAdlHnrVgVrE/t/wQ
Date: Tue, 19 Mar 2024 23:39:02 +0000
Message-ID:
 <SJ0PR11MB5896A8AF663BFF279C8077E7C32C2@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20240319063132.1588443-1-lizhijian@fujitsu.com>
 <20240319063132.1588443-12-lizhijian@fujitsu.com>
In-Reply-To: <20240319063132.1588443-12-lizhijian@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|CO1PR11MB4900:EE_
x-ms-office365-filtering-correlation-id: 16177d37-7a62-4f3a-4c41-08dc486dc211
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RE/ewd7lHE6hZvOAhG8WXjf7mbiZtmuQUQ0vCCmI+l3SyGwqCE1hXdBFcDu60kJTB38RykJyAZLI5oYVsyrDz4+z/28/l3Bzk/ftWUJRMp+AM4/CNB5BnGGEYHbyqXUQfOBrkt/hWSbfI72FPWX/uU/50/gFeZcVQG730wMbNdvGEja+/AaZhozUHR6V4w6d8piqQZ/CMnAcFY3/xF8TEkHpssrY7/OId3QVNruS/EV/LX4trsh+LlwDw4veZD0go5bFpl9vrRVQc2p61RnoY7r1KGWY/gPC61IgabB9i2khTlvlORNt60RCkh0DF/xBszRi/4U8LMW3/2lL7rNVFTcG5FXLhxQIHRPjadRJWfB9CaEJZd5FTBOyRWdHgZDIwiLMeefwEH6EkmVCbGpag7/9VQldkNoo8RMoo7E4otcByH2YQZHpmTbTXBGcmgOlYdUvBVg/TFHNITYXfIc8QnQZV/xJshpSHAWegnYkbvrhuhTxl/QBCUAPFK7tTlwEbu7Y6jF4q00gpcTy4fcN54XKGAF0KGOQsXFSIaYDiEJe4VxQvrUVuZoqRj62aBCv26hFjYnz3REu7Wzhw9eoQIhDQ5/ekobfk0UQif5CHKHaYo0fx9YbazbBDBa8mar5NvUgR23ujEP1+bdwEg3dUD1iGzS/3VwbUIUcKkRTXuQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rYVtiZClPquLuLBLvdmI8y/QwjBxM2qdqMTkwJPMfIeMB9w8aI4DJZdycWXH?=
 =?us-ascii?Q?VnBS9sKNkrKoLHVPQvWcBrplk/3D3WoeBd3GK5wyySX7EIUFwd4a9HuCUqSX?=
 =?us-ascii?Q?g3OH+9i1/6bq0tILLKF9ANYAawtkJ4+6vtP3e47X+OKNAE08sRdbYsfoiM6B?=
 =?us-ascii?Q?OXxpEFX4LzYf2SaWCL04cz/TZFb38PrQn238E2dsCika6BkADl8YKeS8UF4p?=
 =?us-ascii?Q?da73iNu2x9Ossd6ALXHAKGlQPbpO8pIJBL8AahWbjg5qGoOtsHAAuaGTzimH?=
 =?us-ascii?Q?0WKrME8ICenDeJHNcCP32FXicbog46vvh8w96AH5PUaxD2puFgOvqqF5O5jR?=
 =?us-ascii?Q?L3cfSldvMdOSUzBk9ecuXTywUcjy6WhDWK9fiwmKgpW74kPtxVEeJNV6usOZ?=
 =?us-ascii?Q?+o0nOeHdpAD5viuTohRz8HQzFOMK1djntxCSuypHFK+/2/8WBe1E7n17340c?=
 =?us-ascii?Q?PMeN0tAsLj7QJOFNnRwdSS/d/otktsrjrob6EQwZ9ivrMmdPIj8UlTcxV5Ol?=
 =?us-ascii?Q?o7i8YefA4SThxVZ8GSL+KcjyHM9fDr07bSEgM6lzcBmHmFY6w0Dohebb9Egr?=
 =?us-ascii?Q?KagZUsMV/88kaHNat0SHeaZxWbezmhCnb348+nKJPewkRxTFe1VQofQrFH+j?=
 =?us-ascii?Q?V+xr1qrkJ5Opw2DdxWsKCEshpyZboheMTL9sdISuk/tpq9VEW5sGQPN6Z5CT?=
 =?us-ascii?Q?pjBFlgAHyQwlcH/3gVDS6esNbEaZUF0R/3qOESPyd/msn/piRZQ/PcwxGE2h?=
 =?us-ascii?Q?rh0yinmobL80SmTxpzHf/kYbzgc/A/KTw1hlcIMH/wFfqUTNM6HsttYboMqD?=
 =?us-ascii?Q?oGbBTWnWtEtoKy6q9L6+KDYUX3a7O02DeOS+BT4HHb4vpA8zXSo5QVhh4Iu1?=
 =?us-ascii?Q?bmKqLzRLg/DFhFTxlPYCntbQsFo3GX02G40rLCfXzkCFxy9MemhQ6moMQuaO?=
 =?us-ascii?Q?ABV1YSXBc/44ci5JMYs13XnqHGQQSwENdX1Z2K2QFCuLtZH+pEcSGCONetxA?=
 =?us-ascii?Q?aEcq6PgxbiRIBAVDeET+lN0qk9PmDgEEmimGNKVC79aIrDQMR8ywo7KJl4cq?=
 =?us-ascii?Q?mWnU+veLoxvA1/8YOtzvhX2ve4baMFGpCrqtYMfsoVYOKBhlmu7GldzpHpWn?=
 =?us-ascii?Q?62P1cdIXZh3iWjqNOAvbAUQ6fSFZKbVoz5bIH3BJYJwFttAYVFuGoHhtc5sd?=
 =?us-ascii?Q?W2D5ZoezWHnqoJu3p7qhAxTqDIWnYPXpgPV7sxcoDSrgHGvlYjv9fmZxVScN?=
 =?us-ascii?Q?iiZuwxnpwtO5XfVC0GdsiGjvcIIeqcX6Q9mikvocLs+aCOW7Z6LZdprCM6pp?=
 =?us-ascii?Q?/FPxUSpo0hDnR0FUFTD/J45qogzY2DBryTFoF1sEkDkTh0Y7oCdwXFbseDJ0?=
 =?us-ascii?Q?a8EzpmhP81nA4t5nO45gGIdWWf5C2/rIWy2ADTjk9DCqDCP3zLWTfaknlCPQ?=
 =?us-ascii?Q?t+L9DMF4mPjCOnbjJXwdhxuiOYclZGIDyILwmcJtcQYopAPagWq7Rc9BnW6/?=
 =?us-ascii?Q?sEUXOzN9vc/yt0HyMlH8rWUCDPDIWmvOR47Z0q3cys44piHuYvpTA96anKu7?=
 =?us-ascii?Q?5W7NhhTP+tsskjzWjYV2gbkM9NAEbvZayG5fml4N3/B0GKnqVD8A96rokeBJ?=
 =?us-ascii?Q?Wa3xWM50n3lYWOWAnVokm2P6rBv8+YHT/omScLbd8A+O?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 16177d37-7a62-4f3a-4c41-08dc486dc211
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 23:39:02.4149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hcHQEWLTy8HeiMAwxO149VTGYYIZRSypZeshxqql5sWULDFEToDwn2rUUrTiHD05Elj6PW4Zp2tVEu2tnCxvGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4900
X-Outbound-SMTP-Client: 173.37.147.253, alln-opgw-5.cisco.com
X-Outbound-Node: rcdn-core-6.cisco.com

On Monday, March 18, 2024 11:31 PM, Li Zhijian <lizhijian@fujitsu.com> wrot=
e:
>
> Per filesystems/sysfs.rst, show() should only use sysfs_emit() or sysfs_e=
mit_at() when formatting the value to be returned to user space.
>
> coccinelle complains that there are still a couple of functions that use =
snprintf(). Convert them to sysfs_emit().
>
> sprintf() and scnprintf() will be converted as well if they have.
>
> Generally, this patch is generated by
> make coccicheck M=3D<path/to/file> MODE=3Dpatch \ COCCI=3Dscripts/coccine=
lle/api/device_attr_show.cocci
>
> No functional change intended
>
> CC: Karan Tilak Kumar <kartilak@cisco.com>
> CC: Sesidhar Baddela <sebaddel@cisco.com>
> CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
> CC: "Martin K. Petersen" <martin.petersen@oracle.com>
> CC: linux-scsi@vger.kernel.org
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> This is a part of the work "Fix coccicheck device_attr_show warnings"[1] =
Split them per subsystem so that the maintainer can review it easily [1] ht=
tps://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
> ---
> drivers/scsi/snic/snic_attrs.c | 11 +++++------
> 1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/scsi/snic/snic_attrs.c b/drivers/scsi/snic/snic_attr=
s.c index 3ddbdbc3ded1..48bf82d042b4 100644
> --- a/drivers/scsi/snic/snic_attrs.c
> +++ b/drivers/scsi/snic/snic_attrs.c
> @@ -13,7 +13,7 @@ snic_show_sym_name(struct device *dev,  {
> struct snic *snic =3D shost_priv(class_to_shost(dev));
>
> -     return snprintf(buf, PAGE_SIZE, "%s\n", snic->name);
> +     return sysfs_emit(buf, "%s\n", snic->name);
> }
>
> static ssize_t
> @@ -23,8 +23,7 @@ snic_show_state(struct device *dev,  {
> struct snic *snic =3D shost_priv(class_to_shost(dev));
>
> -     return snprintf(buf, PAGE_SIZE, "%s\n",
> -                     snic_state_str[snic_get_state(snic)]);
> +     return sysfs_emit(buf, "%s\n", snic_state_str[snic_get_state(snic)]=
);
> }
>
> static ssize_t
> @@ -32,7 +31,7 @@ snic_show_drv_version(struct device *dev,
> struct device_attribute *attr,
> char *buf)
> {
> -     return snprintf(buf, PAGE_SIZE, "%s\n", SNIC_DRV_VERSION);
> +     return sysfs_emit(buf, "%s\n", SNIC_DRV_VERSION);
> }
>
> static ssize_t
> @@ -45,8 +44,8 @@ snic_show_link_state(struct device *dev,
> if (snic->config.xpt_type =3D=3D SNIC_DAS)
> snic->link_status =3D svnic_dev_link_status(snic->vdev);
>
> -     return snprintf(buf, PAGE_SIZE, "%s\n",
> -                     (snic->link_status) ? "Link Up" : "Link Down");
> +     return sysfs_emit(buf, "%s\n",
> +                       (snic->link_status) ? "Link Up" : "Link Down");
> }
>
> static DEVICE_ATTR(snic_sym_name, S_IRUGO, snic_show_sym_name, NULL);
> --
> 2.29.2
>
>

Reviewed-by: Karan Tilak Kumar <kartilak@cisco.com>

Regards,
Karan

