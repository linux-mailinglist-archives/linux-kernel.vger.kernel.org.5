Return-Path: <linux-kernel+bounces-30629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0D983223C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F120286D56
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AADD1EA78;
	Thu, 18 Jan 2024 23:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="VJmQsuDE"
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65321DA4B;
	Thu, 18 Jan 2024 23:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705620297; cv=fail; b=R7p/xwnhOOAFwnxZimMYv3zh+Okby4N5UtGlzWkXVlNqjjzqis3BgWAQqt3Da6wJVf6aRl1FYDSz8amKOhudn6vfxnefgsfTZQ3e9PgT/Sov7wNixq6Tqo4IljBa9+Xk5OlU+eHRqu1k2T2HGBrd0bznBQP4ZQo0BSo9NARSUtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705620297; c=relaxed/simple;
	bh=8A4w4H/NDdUMQyMqUuCA9/gRVLD+e4po8NpArKJhPKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PKmUv2rVbH1oBZ1LIlf3VaNvyg8RehE9BuXcWESCffL0bLlYy17tRg4Ns83G6YoJ3D50zDwFvS50oNDn605XtwejM7oMV3jHUOqsUL5V+qW0S0TQHq5X3Zvu2XL+MbPcj3NCqSxXOat498Xf3wx/3Ic7J68MbLKMv7TNKo53mNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=VJmQsuDE; arc=fail smtp.client-ip=173.37.86.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2404; q=dns/txt; s=iport;
  t=1705620295; x=1706829895;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pa3oBwZww7syU36UkWSvyjs5krCsvFLoCnQ2401857o=;
  b=VJmQsuDEcNAv8qMo3jLxMHuB7Jel9TF29X8WLiDNGqtK4ndG/I6zbR0W
   g6+dFDO+Z4Iu/ROiZK37jHGKf+DoVBjAMeNnYf7EiQEQgUtozUJtJYouP
   TgaFWOKubvPZY88S5k4SUK3ACTkFr/LLhdt4ZhUW7ZokSvyRAu5fdgzjW
   M=;
X-CSE-ConnectionGUID: dj4DDTcyQ6OtrA+HWNk4Lg==
X-CSE-MsgGUID: nQDHZRcvTgqMqc5DaoNC6w==
X-IPAS-Result: =?us-ascii?q?A0AUAAAlsqllmJhdJa1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEWBwEBCwGBZlJ6gQcSSDGHbQOETl+IZwOeBIElA1YPAQEBDQEBRAQBAYUGA?=
 =?us-ascii?q?koBBAEIhm0CJjQJDgECBAEBAQEDAgMBAQEBAQEBAQYBAQUBAQECAQcFFAEBA?=
 =?us-ascii?q?QEBAQEBHhkFDhAnhXkIAQ4QgX2EIQEBAQEDEhUTPxACAQgYHhAxJQIEAQ0FC?=
 =?us-ascii?q?BqCXoJgAwGqUQGBQAKKKHiBATOBAYIWBbJ9gUgBiBsBiiInG4INgRVCeYFvP?=
 =?us-ascii?q?oRFhBKCLwSCFoNCkSpSgQIdA4EFBFwPBRYPHjcREBMNAwhuHQIxPAMFAwQyC?=
 =?us-ascii?q?hIMCyEFE0IDQAZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDEkkCEBQDOAMDBgMKM?=
 =?us-ascii?q?TBVQQxQA2UfMgk8DwwaAhsbDScjAixAAxESAhYDJBYENBEJCyYDKgY3AhIMB?=
 =?us-ascii?q?gYJXSYWCQQlAwgEA1QDI3QRAwQKAxQHCwd4ghJ7A0QdQAMLbT01Bg4bBQSBN?=
 =?us-ascii?q?gWXawGBDhxggUQ0lh2aK5R6CoQRoUwXhAGMdZkeLpglIKM9hGYCBAIEBQIOA?=
 =?us-ascii?q?QEGgWM6gVtwFYMiUhkPjjmTWHY7AgcLAQEDCYkJC4FTAQE?=
IronPort-PHdr: A9a23:b09/jB+5j0I9dP9uWOnoyV9kXcBvk7zwOghQ7YIolPcSNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8ERHER98SSDOFNOUN37e0WUp3Sz6TAIHRCqNgNvOuXxE436hMWs3Of08JrWME1EgTOnauZqJ
 Q6t5UXJ49Mbg4ZpNu49ywCcpHxOdqUeyTZjJEmYmFD34cLYwQ==
IronPort-Data: A9a23:To/4ta2eKpCZTnsqBfbD5fVxkn2cJEfYwER7XKvMYLTBsI5bpzEOx
 2tOX2vQM/qCNmTyfNl3PYy39k1Vu5OGztIxTQNp3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ1yFjmE4E71btANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXV5
 Lsen+WFYAX5g2ctYjpOg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauG4ycbjG
 o4vZJnglo/o109F5uGNy94XQWVWKlLmBjViv1INM0SUbreukQRpukozHKJ0hU66EFxllfgpo
 DlGncTYpQvEosQglcxFOyS0HR2SMoVK+uPrDUS0oPXN6FHcWjjM/NNtUGU5aNhwFuZfWQmi9
 NQCIzwLKxuEne/zmfSwS/JngYIoK8yD0IE34y47i2qGS6d9B8meGc0m5vcAtNs0rsNHB+rfY
 8MaQTFudx/HJRZIPz/7Dbpnw7331yajK2QwRFS9o5Mbw1rpxxJN36HIKdGIVtWNY+4LgRPNz
 o7B1z+kWk5BboP3JSC+2natgPLf2DjwQ4M6CrK17LhpjUeVy2hVDwcZPXO/oP+kmgu9VshZJ
 kg85CUjt+4x+VatQ927WAe3yENopTYGUNZWVuY98gzIk+zf4h2SAS4PSTsphMEaWNEeST52+
 nO1lMLQWxtzqpTWaU279euwombnUcQKFlMqaSgBRAoDxtDspoAvkx7CJuqP9obo3rUZ/hmtk
 1i3QDgCulkFsSIcO0yGEb3vmTmgoN3CSRQ4o1yRVWO+5QQ/b4mgD2BJ1bQ5xagdRGp6ZgDd1
 JThpyR4xLtRZX1qvHfSKNjh5Jnzu5643MT02DaD5aUJ+TW34GKEdotN+jx4L0oBGp9bIWK3O
 BWN6VwMucY70J6WgUlfPtPZ5yMCkPmIKDgZfqC8gidmO8EuJFHdoEmCm2bJgz6z+KTTrU3PE
 czGKZn3Vyly5VVPxzutTOBVyq4w2i073ivSQ5u9pylLIpLADEN5vYwtaQPUBshgtfvsiFyMr
 753aZDQoz0BC7KWX8Ui2dNJRbz8BSJlVcmeRg0+XrPrHzeK70l/UKGAnu99ININcmY8vr6gw
 0xRk3RwkTLXrXbGMg6NLHtkbdvSsVxX9BrX4QRE0Y6U5kUe
IronPort-HdrOrdr: A9a23:WN6BTKlDJOIU1UBlBvmSIgd8h4LpDfNjiWdD5ihNYBxZY6Wkfp
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
X-Talos-CUID: 9a23:MwI92GEa4iN2qGaAqmJr9hI4NvwuY0SD62vKCgyYNkBqFJmaHAo=
X-Talos-MUID: 9a23:sbt/RAuLfp+NoLTGgM2ngghOFPVS6LqSB1koiJ5bl8CDEwcuJGLI
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 23:24:53 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
	by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTPS id 40INOrPS013827
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 23:24:53 GMT
X-CSE-ConnectionGUID: wsY4SCj4R1CiL8GlrNrwNg==
X-CSE-MsgGUID: rjtcb+XaTASGPgkFW64FHg==
Authentication-Results: alln-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.05,203,1701129600"; 
   d="scan'208";a="20541906"
Received: from mail-mw2nam04lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by alln-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 23:24:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4hiTuChbGUcJjNRuGoTms1VHBRXsZ8MIbVsScAb3FVBo8ltL7rwYuPR6TxXpOmnZbx1U4GyXzE7kdxGTD+B5PsR8I8O+F8YhLuNYY4tjhtBh/xyJs0Qgoa0b5+ja/eN36jEd3ntDW4dfsxQt7qIaLChOhf5PN5Mg5iUZXLIYSbsw8Kwng/px4kwvBtcpigCveT57vpYA1eS1i5XNTzLg7j6mE9s13bsB1YQyocoC6xZ2viUSYBtW+HpBkHsbLug5lmL0R2CfahOKwPP9YzyV5jQdaazzNxYh0/LyQV+s9fY8aYEex+8884E9dYMen3e334b/UmssYe3v8rgdiHe1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa3oBwZww7syU36UkWSvyjs5krCsvFLoCnQ2401857o=;
 b=G69Bcwh5yyUVmXNvWhivin2mT82n72CZccw5kQH5T3wEfvhglNDOJPC3Z+lb+4pDnZqdPs1ZMh2A1l8Wl3SzeE2qeK0l3vtdrcc8b/Md7qsa7kZ9tIoYR+Dk2qsabaty8EON7p7RYO7fnmXqYZfWfIhXjPbqb9bdBKtS1j8iRUD82sPNjXrbHAfpwNKGaA84Z8VI3X0+ueUidijtvQt9Pc/KRJd8arLf9LHIoluvR4FIpqWMVTyIl6XCLCW9EiPqJFPUQeJoNrD60V9cJKPpHRy3uekkvRK0SeZhJ2y4kf8zn1o2jlhwW8tu6g7VyDV+WRdeH10iY8bgl3ppu0VgKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by CY5PR11MB6413.namprd11.prod.outlook.com (2603:10b6:930:37::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 23:24:51 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::55e2:9720:962:3073]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::55e2:9720:962:3073%5]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 23:24:51 +0000
From: "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To: Li Zhijian <lizhijian@fujitsu.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "Sesidhar Baddela
 (sebaddel)" <sebaddel@cisco.com>,
        "James E.J. Bottomley"
	<jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH 22/42] drivers/scsi/fnic: Convert snprintf to sysfs_emit
Thread-Topic: [PATCH 22/42] drivers/scsi/fnic: Convert snprintf to sysfs_emit
Thread-Index: AQHaSDfVBhod7SGWYUO+jzBBMDUZobDgOdlQ
Date: Thu, 18 Jan 2024 23:24:51 +0000
Message-ID:
 <SJ0PR11MB58966A005DB6136D106A1DA6C3712@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-20-lizhijian@fujitsu.com>
In-Reply-To: <20240116045151.3940401-20-lizhijian@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|CY5PR11MB6413:EE_
x-ms-office365-filtering-correlation-id: c0260d1c-e9aa-4b99-c8b2-08dc187cab9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gPGGDJtxkuPiCGVMPPOfMu0ZZminr1trg5us2c47s/XYioOZvBbrj3/9Ndp1MSuvaDGwBfpztP8et8yDYmZsR/LtTDW7JMBWdhy58779dJf98dQrVAtQBGWMwXizCGq1YGadQ8i/893L2nO/EQGKDK84OhO8gVllbAtob5qKUm8zYliyT9VY75mGahInRCPkE0rSp9PZxZD4g8USt1OzpdhBTWuFKlGD9nVmKFIEI8IPW+cUtd0vGm2b156rdNAVN0IF/8lPdZ4zuwRHLLEJ3dzFl26IOkvY+5jCE8q58ExWW23cmvKOMUfb1vxeVgSu9AKmJWiJTqUvY/CGXg7jgMiBisA1ciq/BboGbKciBez99ceDiCUK5tIlwGMVk5tvCwwN7KM7RvMIVaengxpvbLQJ1MveKbesYZCPHXO1wgcPfjUQvkdIWKH/Nt9vjd0L5rQv2wEEAfKms1nBDTfn4CI3MybdS44aMGXdSfQMigjPMB4qOba2jOvuBC9DI4AtLVj5HW7N/XLvuM6akbLBhnuAsKk/w4ENQLmZUmazJGADezG3Y7wy4qOY6jcA0OPJmQCk2e7L61JaKB1pk7L8K1GwLjoHiEj9SQqYXKVQfzuUjp0PIY4BayoNHHHKVDdOGIgT0MycdgmFKcWE3zc/OIsxrALKvVVctybUsVqAWm4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(64100799003)(1800799012)(122000001)(38070700009)(41300700001)(52536014)(478600001)(53546011)(66556008)(66446008)(6506007)(66476007)(8936002)(76116006)(7696005)(316002)(8676002)(110136005)(64756008)(54906003)(71200400001)(9686003)(2906002)(5660300002)(83380400001)(33656002)(86362001)(4326008)(66946007)(38100700002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BWZzrXrYjME55mDQFxo8vCHHVvuxW8VTvQMZUv7MN10R4/OqDA8g08BsAvOQ?=
 =?us-ascii?Q?RW7ANLKACXyUgLVovoHXdLBX/uEh7R7iqcrtLUkf65RfJhkSPOgv4rK1wEfL?=
 =?us-ascii?Q?8yRUbewqyWSAKogkOO7J6rbIzVjhUz+LMNsnbZ8RyJnLZw/J0cAleR8mi59n?=
 =?us-ascii?Q?VJi9ewiaBGRbgJKxWXPg0EiiH+sJKGKawxhnl4fl+bTp9yyMrwr85lanUQz6?=
 =?us-ascii?Q?9YqHi+jjMUk1QoJs1tTpcix5SuHTcl39IcJawYPjN3xXDtdCJhkXZziRp0BW?=
 =?us-ascii?Q?XDKUe0pILuNAKm9ajj5K5L2Tdsuvxmnn3j377oaN/mH56SQG5q9X28vdBBqb?=
 =?us-ascii?Q?Jth3GVWYC+kZC08QS/lS15e7Zh7qgjIXWHHPtOTstBULPEMA93uHJkpJh+wf?=
 =?us-ascii?Q?+flCqn85niNz+7RmsqC8WXcof0QoBH3K2s+3SJPkQtY7z1rqkMTRIzVexg9Y?=
 =?us-ascii?Q?fFB/84TKTHnux3kZbG1lGGptlj+4UmcOw1yKrFrY6owxEiS5nqJXki3j0lij?=
 =?us-ascii?Q?T6i/jERjAVTw+CDQ7qDNyzn+mEz//Amsavq/jGjjsFx0o77yyTHaLXrJ7K/L?=
 =?us-ascii?Q?Eg2tSX8xr1m7H8mbdNSuZVUM73BxLRCglH8XUctw73bwUTIiQROnsf+lp1MZ?=
 =?us-ascii?Q?pFnhfD+8mLhrCLo0hp5bL6Qu9RKv1ppUpk+WbSr3DSg1pZz0sA6Or5V7L9Xl?=
 =?us-ascii?Q?lXa6I5+9dOm0H7YRUSvZSG1EQV3dMlNJU9fr0iQD9TyUZMwNRGGDAr1IrDiY?=
 =?us-ascii?Q?UeKyWj4C33jZ3GuNnplkGsEe+FRy+lufc98E0Qxpuf/yf78wwqogCmi6pama?=
 =?us-ascii?Q?J8C1jg+AWBHtS7J3IXqb8xy0YKPRS61hk2+TeYbkz18O3ZQVM+/7KEZ+VHRZ?=
 =?us-ascii?Q?wpZiGhvk8AlO19vBnZrSN/54fU7xV1yr0r6qNPCQD3i5B8JKZmCcIUi10iIG?=
 =?us-ascii?Q?LX52TUqWUIm+6YqHG6lSeNPtaOFkxSYVnGH/jx4OUWwfJxazxQ7FgAeYLAm0?=
 =?us-ascii?Q?EYOEKMumOB7wk3ncOFeEPXM1wuCuLRxFI6/v9xFVBhseo80znKKV9uUjCntU?=
 =?us-ascii?Q?7Y7zUZq0Ph2hALUEVNE7VnpCWa8H5NfVAX573iGnbAvAeH0cAByVHqOxw7zo?=
 =?us-ascii?Q?Ld7h05Djukc0qA9AjpC8Sj+H3ipZUhVmG4B5tKNcFB9YDT+3m4+Go6rzKdNw?=
 =?us-ascii?Q?dPHgsNMllzdIflNjtKhhrpyTXbta70iaDC+ZoeL3GdaOtxz+mlHRDpJ4isp3?=
 =?us-ascii?Q?zrgusA4Ssb50QLMj3b+iGv2kd42+/1DIBx/l+xEeZPJnO2XLxy0infKcSFyi?=
 =?us-ascii?Q?LTxJjzhYbPcaPCfV1UgVhpBfn2JErrM/tgJCL6ozaeMj1ajPqsb/LQ+9Sb3h?=
 =?us-ascii?Q?T3HTm570JzPgMnN2uph1mynvZnmezuxAWTJgB5BZE6vthsQPFUj8OV5gOONW?=
 =?us-ascii?Q?yphpAllOvV+MFvsYkzm7WUtCWFrUjP23+WrIxhKjLNbUMK7rdu2mWW64P6mC?=
 =?us-ascii?Q?QzrQ+YqzvcTiQfKLu2y9TnvH94CVVtizEXhEZpnGYV8ijEz7VVo/69/BXZCP?=
 =?us-ascii?Q?JpPx+fZNzPLbQGpQpVjpxLbAB1jPKkG1KKR+7oPobCXUvTU9glkLvnQCdz0L?=
 =?us-ascii?Q?yMshvxWhWhYF36TX8NYzSt8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0260d1c-e9aa-4b99-c8b2-08dc187cab9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 23:24:51.3913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l9uelnZMRUM7guvyNP1M8GtbaBG9AARkq/Kt7A/7nlKD0OgsEocoT/Feid8Zw+Vxknwq5CX/OnwUp9rjxOYZig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6413
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-1.cisco.com

On Monday, January 15, 2024 8:52 PM, Li Zhijian <lizhijian@fujitsu.com> wro=
te:
>
> Per filesystems/sysfs.rst, show() should only use sysfs_emit() or sysfs_e=
mit_at() when formatting the value to be returned to user space.
>
> coccinelle complains that there are still a couple of functions that use =
snprintf(). Convert them to sysfs_emit().
>
> > ./drivers/scsi/fnic/fnic_attrs.c:17:8-16: WARNING: please use
> > sysfs_emit
> > ./drivers/scsi/fnic/fnic_attrs.c:23:8-16: WARNING: please use
> > sysfs_emit
> > ./drivers/scsi/fnic/fnic_attrs.c:31:8-16: WARNING: please use
> > sysfs_emit
>
> No functional change intended
>
> CC: Satish Kharat <satishkh@cisco.com>
> CC: Sesidhar Baddela <sebaddel@cisco.com>
> CC: Karan Tilak Kumar <kartilak@cisco.com>
> CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
> CC: "Martin K. Petersen" <martin.petersen@oracle.com>
> CC: linux-scsi@vger.kernel.org
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> drivers/scsi/fnic/fnic_attrs.c | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/scsi/fnic/fnic_attrs.c b/drivers/scsi/fnic/fnic_attr=
s.c index a61e0c5e6506..0c5e57c7e322 100644
> --- a/drivers/scsi/fnic/fnic_attrs.c
> +++ b/drivers/scsi/fnic/fnic_attrs.c
> @@ -14,13 +14,13 @@ static ssize_t fnic_show_state(struct device *dev,
> struct fc_lport *lp =3D shost_priv(class_to_shost(dev));
> struct fnic *fnic =3D lport_priv(lp);
>
> -     return snprintf(buf, PAGE_SIZE, "%s\n", fnic_state_str[fnic->state]=
);
> +     return sysfs_emit(buf, "%s\n", fnic_state_str[fnic->state]);
> }
>
> static ssize_t fnic_show_drv_version(struct device *dev,
> struct device_attribute *attr, char *buf)  {
> -     return snprintf(buf, PAGE_SIZE, "%s\n", DRV_VERSION);
> +     return sysfs_emit(buf, "%s\n", DRV_VERSION);
> }
>
> static ssize_t fnic_show_link_state(struct device *dev, @@ -28,8 +28,7 @@=
 static ssize_t fnic_show_link_state(struct device *dev,  {
> struct fc_lport *lp =3D shost_priv(class_to_shost(dev));
>
> -     return snprintf(buf, PAGE_SIZE, "%s\n", (lp->link_up)
> -                     ? "Link Up" : "Link Down");
> +     return sysfs_emit(buf, "%s\n", (lp->link_up) ? "Link Up" : "Link
> +Down");
> }
>
> static DEVICE_ATTR(fnic_state, S_IRUGO, fnic_show_state, NULL);
> --
> 2.29.2
>
>

Looks good to me.

Reviewed-by: Karan Tilak Kumar <kartilak@cisco.com>

Regards,
Karan

