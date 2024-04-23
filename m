Return-Path: <linux-kernel+bounces-154945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947B28AE360
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447A32862C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C8B77F1B;
	Tue, 23 Apr 2024 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yUGUlKSU";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SfkbUl9T"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D2E5812B;
	Tue, 23 Apr 2024 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870373; cv=fail; b=lIlJLPyTF6lVlvTRcLF+tfFuHE808j5BF46R4r21eedUmKzVEcPr2nCbrglZkdJ2e43nCbrHHs2TXZPOHuYtJK6tOzUowTfyjYW87sxLsYHPCAAcmlumH0k5gOEA3qnONCO7ipr/ge5+BTPRrPjFYZUmh7dLfxznHbx5RuKuUNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870373; c=relaxed/simple;
	bh=sP7UemDdRUCwXCESonSrocWZNMHRLcyAj6CAOvtjf9k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TRJZvXv8SOALpNWuC3fa/Vwlo494n8uMG73ayKdDyksHFBI5aNz/NgJXyrPZWditRJ3VbS9WbjJ5hjZjcaZyAqmSx0z6bxO0w5l0qPBBtnYLcLLr3eknBr2pOgJ3EfQm6r479VSxeqATjc5K3caxFqLCYMjUrGuziR9kzYbJBoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yUGUlKSU; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SfkbUl9T; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713870370; x=1745406370;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=sP7UemDdRUCwXCESonSrocWZNMHRLcyAj6CAOvtjf9k=;
  b=yUGUlKSUviu/1+rb7AWDqHlDJXn57Ryxk1TB6YOltV04uyIfCwKpkaOK
   A7e/950DosEaIgaJDebeJGeYPAJKPLSHL4kEPYhYfnf7lFYhyPuOEJt6v
   UA4otRyU6KcCrXRu40ljMZO6qU4++rdmPk1GBvK2zMS9W2aULBgqR9RPG
   3nO4tVEO/5OhNkFt7O8zOOM1wOOdJpC9hRW3CvE5kDBwa4tmvpldU1y0R
   4bMBXibBaCJ/+1Z4rJApTtXZ0tQiD7jez7Y9/FeLXKFtuzAELSn0R15FK
   AIcZeyWiIDDsNMA+2dvQdtD/tKUFMiV7XHbOamKiDuGGwubMb4scZodX7
   Q==;
X-CSE-ConnectionGUID: SY0SePApRjOR8XyzsBxYoA==
X-CSE-MsgGUID: p10Hp3PzSzCbcS/FVR20dA==
X-IronPort-AV: E=Sophos;i="6.07,222,1708412400"; 
   d="scan'208,223";a="189582414"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Apr 2024 04:06:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 04:05:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 04:05:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f68EVn2s//RnIYt1Mw22Lsv9/bw+FpUENUQi5ZnJk7f+N/N6hzERM9e7/7/qNveT1Kch8d+E16H19cg2NGqX6qT/eL3bN+UZbPtLtnHN7JPcIqBq4RE5d1Q/sokhtOVr/P/RTiAMXqpi1XoYnQVI4Afi4snwwC6kTkc0qWvnSjFtRvXc2l3X9m8NU+QLBOXosDAbBGAlRDmYL6zy+jOn2WlSlOxsb7YpiK0Nw3xciOc8F3DQCeGh9C3jZGpF2KeSqNicIq5D0v0zyTouDW3yFekpGxqD0+09QENQhyUeqnwjY/D/JySvDUPY+H034PCAmJrxBlnAIFSz1RlQ7nQ5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPltObU02XI/2/63HVB2lzVs+NuhTo4YRlq98V8tshA=;
 b=cZdRJB0XXMa+fKBQiDyCLH4WoHz0aYGqx0sDADS9ushXx7K2mdnu9Nrybg4j9GM1vXN35WKDArOwlZLHX5wNUdUNuPt8owzpT3mpG9d+mso+EPhlx8D3UwaqVJpeNs9C5zgJxsWpdMvEiGAdaL/mV3MH7ha2MDhlQsULzqX/srrQk4qx/6P99EebI3k78kvgkJ+iAs4I/J+fLexZzbQ1ztnMJNWeeapUBpG1vWNRyVzjrm1em4m/eAbfKY1S1HbN0r0HTK3BGbhdcqpUwf6NJ0deP1Ex65sXSpfaBIv7PldOt6AbrqJ3VbgGrIAWg1nkC1A/N6PNswcjfl0/UoxENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPltObU02XI/2/63HVB2lzVs+NuhTo4YRlq98V8tshA=;
 b=SfkbUl9TpNWUCtI4gGU2NVAjoTENf/XfWvAvEtKrOVoNg+nSMex03bOU4M/c+oExyr7/4mKsoGJPykBh79ZzIWX/v5pvgWHCgq8ZKjI9IxUYf12VbTtf5bAKQKBVjLOLZbUkeSVaa4nEA5kMIqum3Qr4ukY2W8TlbkCVx3N0tV//jDjTAa2T8tAh6IoGWlhAur1oa85n7zuBxCRgDEkGEMyKRWz0Bk/IIaGXK8E1E7EreLJI/bIfgn0rgJZPV0GWFFa2teACqOfPZU8lC6UQ9Pugr1BpGKbCHyHeyU6UJaZQoYMzKaqB/BiVj5ItYBE9f7wU38OarwMCE/7y0nDdrQ==
Received: from LV8PR11MB8700.namprd11.prod.outlook.com (2603:10b6:408:201::22)
 by DS0PR11MB8666.namprd11.prod.outlook.com (2603:10b6:8:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 11:05:45 +0000
Received: from LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::bef5:e3b9:4214:8eda]) by LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::bef5:e3b9:4214:8eda%6]) with mapi id 15.20.7519.020; Tue, 23 Apr 2024
 11:05:45 +0000
From: <Raju.Lakkaraju@microchip.com>
To: <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <linux-kernel@vger.kernel.org>,
	<Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when PHY
 does not
Thread-Topic: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when
 PHY does not
Thread-Index: AQHaen5pA5HIVZmbdE+YwqVuzvYGF7FBPcYAgBgZppCAAKxcAIAbyhww
Date: Tue, 23 Apr 2024 11:05:44 +0000
Message-ID: <LV8PR11MB8700A34520EA2521BC5F59EF9F112@LV8PR11MB8700.namprd11.prod.outlook.com>
References: <20240320042107.903051-1-Raju.Lakkaraju@microchip.com>
 <20240320042107.903051-3-Raju.Lakkaraju@microchip.com>
 <22089299-a3e2-4cbd-942a-65ea070657b8@lunn.ch>
 <LV8PR11MB87003ABBCA98F00F3EEA9AB09F032@LV8PR11MB8700.namprd11.prod.outlook.com>
 <fb5a6f19-ae4c-443e-babb-cbbcf6ba5fc6@lunn.ch>
In-Reply-To: <fb5a6f19-ae4c-443e-babb-cbbcf6ba5fc6@lunn.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8700:EE_|DS0PR11MB8666:EE_
x-ms-office365-filtering-correlation-id: ae167f58-b55e-459d-17da-08dc638552bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?yNqY8ZAj77KkE664ZYYcO27sYJDSoV/iPI2vP0v/bvZyLA6uVYdSYfGgAczg?=
 =?us-ascii?Q?HOmgQ1d9pd1dVp8hpVm2RN2HMo58Q8HADJHh1oVp+FYzwj4obpQXnXgStWPM?=
 =?us-ascii?Q?VuNKDm8eoza0wLdoDyQvsBBXf/VAEOQuXiAgkwRH9P060WwPquyB01g7Oeg+?=
 =?us-ascii?Q?en71tT3r/iepaxOdYC8AACiNb47uJ76ODSFpEaHozxOuAk1pe/EZZ8LpllQ6?=
 =?us-ascii?Q?OtFpfyJqD6n+vBTY8qkpgZWlS7Z7qae6KGijDRRFyZ7uSg+MAt7/GulCG0Bi?=
 =?us-ascii?Q?l3Zlo8Coffxw2ZGjbd/RrFYE6Nnvu/fK3SCh5oGtWVpU53gejwgqEdSMPSHh?=
 =?us-ascii?Q?8Zfw0BWTKrHLtW9LQ6TsWmGdBdWJ5LEO+4aWpNEBRj/Bs8QZwYT889a9NuhS?=
 =?us-ascii?Q?Ycoc0yca4uu0rBatiVcl90r9uBlq68hXMXliJfQIwsId7RVjMCfipNy1sM2r?=
 =?us-ascii?Q?2b/oj8+WWFOzl162o7gb4i1tDeaoF44sBMUo5/iuIwKR24QP0y/Lj9BtFXZ5?=
 =?us-ascii?Q?HRWdgEudBHkOBPBGSn6tz9/vbAOff/eIvJG6eD7U0OZ1dU5t0xORXCxzDnjs?=
 =?us-ascii?Q?EFm+tDx8R2frzClIx6D7fQEmMX5OblaNRi7dD8dZhTwVtHbN88/tX2od68CZ?=
 =?us-ascii?Q?NnsU/GPdKasqMu/TI56oUhjbXC4Zju8dG5iiWrrA1kkK4Rcxw6Dvh4fQOUgQ?=
 =?us-ascii?Q?4PWRVBWWY7qJAczxQoWL11ze985vWatbzepMPa4fiNpBxrsSs/4QeE1oJCe7?=
 =?us-ascii?Q?mbCDwHVG/6b/LJjoYVoMrbYpe7Yb40+8k8JX9Zx98Zc1XzkZX0+tB4OjPKxQ?=
 =?us-ascii?Q?N9yPfFsHns80IpPOcbXV/yTWBaaU/qFbY4GdBv9S3MVz8AA+cwdjlDCQBeXb?=
 =?us-ascii?Q?3lvFI+1rMFGTumE/42yFyTFx83KMMALdk4LS3lmVdmhPZhHtVzcXke/Y27eU?=
 =?us-ascii?Q?+QEsdnC0aNaBGRKa0H01o6lS2fBjNzECsZxWJ/q5ZCUoBkfK+mT2KIkkKCxW?=
 =?us-ascii?Q?yUNKclTgnIboOi2kPnqjvgVIoY0pVZ81HBfIjRcyqMQ+wk2KRVgg6tQYLPA7?=
 =?us-ascii?Q?1MnmjMTXIPVakUi0ax3V8ovwI0sG+MZir2DvMHJ1vqB8yPCvQUVxBvZusxjx?=
 =?us-ascii?Q?Jv+7GK2+hbtuij3zvS3Ze8sMPpzqGbe8ZPn+udENdkqK2tmHHdUuW6MP5GXk?=
 =?us-ascii?Q?VyyKdNIOYcjIj/GVRisTHU8qK1CH85VpQ8FoQuRm18bOxUWcHCtNhMo9ahKg?=
 =?us-ascii?Q?jO1LzSlWjZpEnJOH2/Zulf4h6RjxyWluZF4COlcYlyXaw+Fu7vA7pIh9zyKG?=
 =?us-ascii?Q?gO9iQvNB+PCw27JOpp/7KRIEcPSb+Y2xC6N3EAgiJ5c/WQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8700.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kyjwMIfbEBkvtU4nHVvHy8nk318YLIJQP0mPbiY9gZ/QG8aqI74Zz7BoGdn4?=
 =?us-ascii?Q?C7ojswpSCcD2p1phEoKfvXt+wrMwcnqFu40rxlnhRISEoSSWsufzGPqvYKM3?=
 =?us-ascii?Q?OHjS8S0u5npCvdbfDECrnQm4g2BYFqbuIsXpG4mLPF4xm0dHpkD3HqW3iZtg?=
 =?us-ascii?Q?HFgz+plEQIwAwjbtx3uVGY4X2wsw/hyGXUQekP37eWWDR0U4tlUwWCWqIR46?=
 =?us-ascii?Q?3SkLmWgtYXkvLWlx9r2ASck4HrSZAEq1IIuYScvxWmNB4SUTi+JoEzlMOLOV?=
 =?us-ascii?Q?R5BALTxA1b1zIXFjj3cyIeBhRIqX7BPB/QadgpQU/SwOjMGnCxzw3MWlZ/L1?=
 =?us-ascii?Q?nGOJWUu5vKaYslW2gEdzTwaRFduUfIn0+TtQ6JdhOtzPskievdosG+23nY5B?=
 =?us-ascii?Q?8jlljUjikvBN+yHpyMVXNhfDSqdzMWw2UNHH3Hy18gtCl6l3r++wBgjNINgM?=
 =?us-ascii?Q?NN0HbowiunPICooKzIjYLmdL8wdEH95ifdIIVId55HK7vg/JOUlTHuc/iOqE?=
 =?us-ascii?Q?4dcrgJ94jiBtsY359mxX8CAw5Xqu/5RWHmgZ4T4he8gnuZ9Q4/tgJJvMx46q?=
 =?us-ascii?Q?EcbcNyfS2KqUibeh5JAlEMyGyaJQueyYcg9ZKjn9YyRWd9zVZ7B3zw+Caklv?=
 =?us-ascii?Q?UhP7v4FSN8YXQri6APGGSP3i7m3bARlce4GMJNUnMmiKIcrW5wINUeP7eGMT?=
 =?us-ascii?Q?Mw1HnM6thtQdNzI1RSunZf0BbKyQ+0E/8vDbZ4qmi9x/gcOwGNOXX6x0wqre?=
 =?us-ascii?Q?FPSkynyl2w5H5GDpP/0sZSoNm4HH/Cc2FSMxqqmta9YuZfkyzDEkUBC/n+uM?=
 =?us-ascii?Q?ZL+mlMPgXTvSFtDeMnSUojXaG6DDSm96msuiopNRGo4aCcBbD3NbszlHc97G?=
 =?us-ascii?Q?/+olYKWqMZ9z3pEfsyengN9aGWS6RyFbibjD5oGXzYOUZA+UjoZvBczK2Xdj?=
 =?us-ascii?Q?tvDhcYHr7udair/Q/+gpaEDoxZxeAhqujreJfdhjpFA27jcYYZRRoHWjvFE9?=
 =?us-ascii?Q?6AWQzchKYhIiibM+623GnVPMtBOqWWw5jmsrTj6x5WvQFLtJdFJtV+q52Sy4?=
 =?us-ascii?Q?gBTSgDjtSPoREHZK0eIlb8wYvXn8iMRdqe+vstqZr2YWT98Obg1S/Xvw4mLj?=
 =?us-ascii?Q?CXSdoDxIFl14KVR261zsCU6sq1oOHoMSxCsGB71yjWjUHXY4i2AAGN3rk4dM?=
 =?us-ascii?Q?mZPFvhH0FthsawrcrwJl0PYhcMrCTp6rvIpifZvbZZdjv5C5Iy3YhMChlxKq?=
 =?us-ascii?Q?/2hh92zUrzATBIccvOAPPSuptG5uYfp4YtIixNqB032e8r4p7bE0VJXGeSag?=
 =?us-ascii?Q?WtvdDfm/cVv3vFenszS8r5jiX+uqSJkk0ajxAJttkBSKqbYhSTB8dU59mj6i?=
 =?us-ascii?Q?8Zm0YqB0xj+gcBV01tR2jBfrCRyP9b0+NjQayg/LPsBvdo6q9ghFHtmciADF?=
 =?us-ascii?Q?ceCwXSFB8/4yIb/3KOmZv+7nz9uh1Qhw862kA8LNifWECfzu9lKX0J0LM/D6?=
 =?us-ascii?Q?qT/BbhDnFZkEahOPwVxf9c9CRCehORLenF+eSLsLw6sksRw5ZblmVzVHz777?=
 =?us-ascii?Q?In6IGsbnptfV12+F5LSnH2vXZGKSYJNPSAgsB2Qvfk6Gra8RKafJQRvqAZW6?=
 =?us-ascii?Q?sQ=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_LV8PR11MB8700A34520EA2521BC5F59EF9F112LV8PR11MB8700namp_"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8700.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae167f58-b55e-459d-17da-08dc638552bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 11:05:44.9001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SK25Dzjjq72yqN1/GaWxD1XkgOx7ep3kM4uNpEdHq2xAGuM+j0xYRKMafak4KEUQeePgnZgO3EGXlM+Y0+0Np5UQOC4Jlb7Ow7tETB7kmSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8666

--_002_LV8PR11MB8700A34520EA2521BC5F59EF9F112LV8PR11MB8700namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Friday, April 5, 2024 10:42 PM
> To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
> Cc: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org;
> pabeni@redhat.com; edumazet@google.com; linux-kernel@vger.kernel.org;
> Bryan Whitehead - C21958 <Bryan.Whitehead@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>
> Subject: Re: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even whe=
n
> PHY does not
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Fri, Apr 05, 2024 at 08:17:22AM +0000, Raju.Lakkaraju@microchip.com
> wrote:
> > Hi Andrew,
> >
> > Sorry for delayed response.
> >
> > > -----Original Message-----
> > > From: Andrew Lunn <andrew@lunn.ch>
> > > Sent: Thursday, March 21, 2024 4:23 AM
> > > To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
> > > Cc: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org;
> > > pabeni@redhat.com; edumazet@google.com;
> > > linux-kernel@vger.kernel.org; Bryan Whitehead - C21958
> > > <Bryan.Whitehead@microchip.com>; UNGLinuxDriver
> > > <UNGLinuxDriver@microchip.com>
> > > Subject: Re: [PATCH net V2 2/2] net: lan743x: support WOL in MAC
> > > even when PHY does not
> > >
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > > know the content is safe
> > >
> > > > +     if (netdev->phydev) {
> > > > +             ret =3D phy_ethtool_set_wol(netdev->phydev, wol);
> > > > +             if (ret !=3D -EOPNOTSUPP && ret !=3D 0)
> > > > +                     return ret;
> > >
> > > I'm not sure this condition is correct.
> > >
> > > If there is an error, and the error is not EOPNOTSUPP, you want to
> > > report that error. However, if the PHY can support the WoL
> > > configuration, it will return 0, and this function should exit, WoL
> > > in the MAC is not needed. And doing WoL in the PHY consumes less
> power since you can suspend the MAC.
> > >
> > > So i think it should simply be:
> > >
> > > > +             if (ret !=3D -EOPNOTSUPP)
> > > > +                     return ret;
> > >
> > > Do you have a board with this MAC with a PHY which does have some
> > > WoL support. Could you test PHY WoL is used when appropriate?
> >
> > Yes.
> > We have external PHY (Max Linear GPY211C) attach to MAC of PCI11x1x
> > (PCIe Ethernet chip) If I don't register the Ethernet module in wakeup
> source, WOL is not working. Ethernet device power state shows as disable.
>=20
> So i'm talking about the case where the PHY is doing the wakeup, without
> help from the MAC. In that case, "Ethernet device power state shows as
> disable." is sensible.
>=20

If we don't enable/register the PCI11x1x's ethernet device in wake list by =
calling " device_set_wakeup_enable( )" function, device power state shows a=
s disable.
When I refer the other vendor pcie's ethernet drivers, " device_set_wakeup_=
enable( )" function called in ethernet driver Power Management's suspend an=
d resume functions.
But LAN743x driver call this function when Ethtool configure the WOL.

> > i.e.
> >
> /sys/devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:03.0/0000:09:00=
.
> 0/power/wakeup   <--  disabled

When I call the device_set_wakeup_enable( ) with enable =3D 1, wakeup (/sys=
/devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:03.0/0000:09:00.0/pow=
er/wakeup) shows enable.
Also observe that device (PCI11x1x's ethernet device : 0000:09:00.0) add in=
 wake list.
i.e.
device: 'wakeup34': device_add

> >
> > PCI11x1x is PCIe bridge device between PCIe and Ethernet along with
> > other peripherals (i.e. UART, SPI, I2C, USB and PCIe devices)
> > 0000:09:00.0 - Ethernet device
> > 0000:05:00.0 - PCIe Bridge Up link
>=20
> How does the PHY indicate wake up? It could be you can power off the MAC,
> but you need to keep parts of the PCIe bridge up, in order the wake up ge=
ts
> delivered?
>=20

PHY (GPY211C)'s interrupt pin (MDINT) connect to PCI11x1x's ethernet device=
.
When I configure the WAKE_PHY or WAKE_MAGIC on GPY211C PHY, Interrupt gener=
ation observed when magic packet or link activity (link down or link up).
If wakeup enable in PCI11x1x's ethernet device, System resumes from sleep.

> > When I test the WOL_PHY option on setup (PCI11x1x MAC + GPY211C PHY),
> > observe the following:
>=20
> > 1. When enable WOL_PHY by using ethtool (i.e. ethtool -s enp9s0 wol
> > p), GPY211 PHY configure the WOL. After resume from sleep, GPY211 WOL
> > configuration vanish. Observed that gpy_config_init( ) function reset.
> > Is it expected behaviour ? In other mail thread, we discussed that
> > Ethtool configuration should retain after resume from sleep.
>=20
> The whole point of suspend/resume is that the configuration is retained. =
So i
> would expect from the users perspective WoL is still enabled.
>=20
> As you point out, we might have a logic issue here, that on resume we hit=
 the
> PHY with a hardware reset. That could be clearing out WoL?  We might need
> to cache the PHY WoL configuration in phydev, and on resume re-apply it.
> WoL is complex so we need to be careful who is actually managing it. But =
this
> seems like something which could be done in the phylib core.
>=20

Yes. You are correct.  On resume we hit the PHY with a hardware reset. That=
 could be clearing out WoL.

On resume, phy_init_hw( ) calls the PHY's configuration and interrupt funct=
ions to resets.
As you suggested, I add the wolopts flag in phydev and update this when set=
_wol function execute. This change fix the issue.
i.e.
Re-apply WOL configuration on PHY in phy_suspend( ) function.

Please find the attached prototype code change (Temporary patch)for referen=
ce.=20
I will submit this patch separately.

> > 2. when WOL configure with ethtool, Either Link-down and Link-up on
> > CLI, WOL configuration vanish. Is it expected behaviour ? Due to this,
> > every time we have to configure WOL through Ethtool.
>=20
> This is unexpected. I would expect WoL to remain configured until the
> configuration is changed.
>=20

Observe that magic packet configuration(ethtool's wol g option) did not van=
ish.
But when Link flap occur for WAKE_PHY case, this issue observes. This might=
 be recent "netlink" changes issue.=20
I will debug and confirm.

> > Based on above information, We need to check for return < 0 condition
> > and return the error. Else enable the wakeup by calling
> > "device_set_wakeup_enable( )" function.
>=20
> Once it is clear how the PHY does the wakeup, we can look at this. Howeve=
r, if
> the PHY can support the WoL, you should not be configuring the MAC as wel=
l
> to do the same WoL, you should be putting the MAC into a low power mode.
>=20

When PHY support's the WOL (WAKE_PHY, WAKE_MAGIC), it's generated only MDIN=
T interrupt which can handle by MAC.
But we must configure the wake phy interrupt bit in MAC's Power Management =
register.

PCI11x1x's ethernet device MAC supports "Secure-ON" features, but GPY211 do=
es not support "Secure-ON".
So, we have to use MAC WOL for secure-on feature.

I tested this part.=20
When enable the MAC's WAKE_PHY_INT bit, when PHY generate the interrupt, Sy=
stem resumes from sleep.

>     Andrew

Thanks,
Raju

--_002_LV8PR11MB8700A34520EA2521BC5F59EF9F112LV8PR11MB8700namp_
Content-Type: application/octet-stream;
	name="0001-Wake-ON-LAN-PHY-reconfiguration.patch"
Content-Description: 0001-Wake-ON-LAN-PHY-reconfiguration.patch
Content-Disposition: attachment;
	filename="0001-Wake-ON-LAN-PHY-reconfiguration.patch"; size=2015;
	creation-date="Tue, 23 Apr 2024 10:19:51 GMT";
	modification-date="Tue, 23 Apr 2024 11:05:44 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2YjVhYjUzMWEyYTJhMTNiZWY2YTU0YTBlMmE3OGZmZTQwMDhiZGI0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYWp1IExha2thcmFqdSA8UmFqdS5MYWtrYXJhanVAbWljcm9j
aGlwLmNvbT4KRGF0ZTogVHVlLCAyMyBBcHIgMjAyNCAxNTo0NzoyOCArMDUzMApTdWJqZWN0OiBb
UEFUQ0hdIFdha2UtT04tTEFOIFBIWSByZWNvbmZpZ3VyYXRpb24KCi0tLQogZHJpdmVycy9uZXQv
cGh5L214bC1ncHkuYyAgICB8IDQgKysrKwogZHJpdmVycy9uZXQvcGh5L3BoeV9kZXZpY2UuYyB8
IDUgKysrKysKIGluY2x1ZGUvbGludXgvcGh5LmggICAgICAgICAgfCAxICsKIDMgZmlsZXMgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3BoeS9teGwt
Z3B5LmMgYi9kcml2ZXJzL25ldC9waHkvbXhsLWdweS5jCmluZGV4IGIyZDM2YTNhOTZmMS4uOWI5
N2ZhY2M5YjAzIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9waHkvbXhsLWdweS5jCisrKyBiL2Ry
aXZlcnMvbmV0L3BoeS9teGwtZ3B5LmMKQEAgLTY4MCw2ICs2ODAsNyBAQCBzdGF0aWMgaW50IGdw
eV9zZXRfd29sKHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYsCiAJc3RydWN0IG5ldF9kZXZpY2Ug
KmF0dGFjaF9kZXYgPSBwaHlkZXYtPmF0dGFjaGVkX2RldjsKIAlpbnQgcmV0OwogCisJcGh5ZGV2
LT53b2xvcHRzID0gMDsKIAlpZiAod29sLT53b2xvcHRzICYgV0FLRV9NQUdJQykgewogCQkvKiBN
QUMgYWRkcmVzcyAtIEJ5dGUwOkJ5dGUxOkJ5dGUyOkJ5dGUzOkJ5dGU0OkJ5dGU1CiAJCSAqIFZQ
U1BFQzJfV09MX0FENDUgPSBCeXRlMDpCeXRlMQpAQCAtNzQ4LDkgKzc0OSwxMiBAQCBzdGF0aWMg
aW50IGdweV9zZXRfd29sKHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYsCiAJCWlmIChyZXQgJiAo
UEhZX0lNQVNLX01BU0sgJiB+UEhZX0lNQVNLX0xTVEMpKQogCQkJcGh5X3RyaWdnZXJfbWFjaGlu
ZShwaHlkZXYpOwogCisJCXBoeWRldi0+d29sb3B0cyA9IHdvbC0+d29sb3B0czsKIAkJcmV0dXJu
IDA7CiAJfQogCisJcGh5ZGV2LT53b2xvcHRzID0gd29sLT53b2xvcHRzOworCiAJLyogRGlzYWJs
ZSB0aGUgbGluayBzdGF0ZSBjaGFuZ2UgaW50ZXJydXB0ICovCiAJcmV0dXJuIHBoeV9jbGVhcl9i
aXRzKHBoeWRldiwgUEhZX0lNQVNLLCBQSFlfSU1BU0tfTFNUQyk7CiB9CmRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9waHkvcGh5X2RldmljZS5jIGIvZHJpdmVycy9uZXQvcGh5L3BoeV9kZXZpY2Uu
YwppbmRleCA2MTZiZDdiYTQ2Y2IuLjk3NDBmMDhhZDk4ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9u
ZXQvcGh5L3BoeV9kZXZpY2UuYworKysgYi9kcml2ZXJzL25ldC9waHkvcGh5X2RldmljZS5jCkBA
IC0yMDM4LDYgKzIwMzgsMTEgQEAgaW50IHBoeV9zdXNwZW5kKHN0cnVjdCBwaHlfZGV2aWNlICpw
aHlkZXYpCiAJaWYgKHBoeWRldi0+c3VzcGVuZGVkKQogCQlyZXR1cm4gMDsKIAorCWlmIChwaHlk
ZXYtPndvbG9wdHMpIHsKKwkJd29sLndvbG9wdHMgPSBwaHlkZXYtPndvbG9wdHM7CisJCXBoeV9l
dGh0b29sX3NldF93b2wocGh5ZGV2LCAmd29sKTsKKwl9CisKIAlwaHlfZXRodG9vbF9nZXRfd29s
KHBoeWRldiwgJndvbCk7CiAJcGh5ZGV2LT53b2xfZW5hYmxlZCA9IHdvbC53b2xvcHRzIHx8IChu
ZXRkZXYgJiYgbmV0ZGV2LT53b2xfZW5hYmxlZCk7CiAJLyogSWYgdGhlIGRldmljZSBoYXMgV09M
IGVuYWJsZWQsIHdlIGNhbm5vdCBzdXNwZW5kIHRoZSBQSFkgKi8KZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvcGh5LmggYi9pbmNsdWRlL2xpbnV4L3BoeS5oCmluZGV4IDNkZGZlN2ZlNzgxYS4u
Yzg4ZmZhN2FjODliIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3BoeS5oCisrKyBiL2luY2x1
ZGUvbGludXgvcGh5LmgKQEAgLTc2Niw2ICs3NjYsNyBAQCBzdHJ1Y3QgcGh5X2RldmljZSB7CiAK
IAl1OCBtZGl4OwogCXU4IG1kaXhfY3RybDsKKwl1MzIgd29sb3B0czsKIAogCWludCBwbWFfZXh0
YWJsZTsKIAotLSAKMi4zNC4xCgo=

--_002_LV8PR11MB8700A34520EA2521BC5F59EF9F112LV8PR11MB8700namp_--

