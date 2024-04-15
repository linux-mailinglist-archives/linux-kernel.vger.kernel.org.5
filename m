Return-Path: <linux-kernel+bounces-144949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C68F8A4D08
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9C91F2534D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DE95CDF0;
	Mon, 15 Apr 2024 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="esfc/36z";
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="V6Jdet4N"
Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6047C3C062;
	Mon, 15 Apr 2024 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178544; cv=fail; b=caugjJur5QaLt4boJrYANTxTHwBKsVSF9cg6vOCHbN49LJ53ayXXxyzoWYT+hAIp9JHOO2NOKzhmI7X/ykeRnXo/6oiM6IvtDQTsIatcrEBp9D3yjFv6kSRCmvsUIiXjGrvefi3wPGAk3fKi39PYM/C2i77q02+v3PzLmu8cpwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178544; c=relaxed/simple;
	bh=9lSXZlY51B0MS2tg9691UP5zYxAeMxpBEQdObrnRLOM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lba6S0wiY3XXvctnU1ZMUWH4iY4FeuhL1Tld+8g8McMUIQahPN8w/D9DAb96Y10HLHCdFRj85tciXJ8yHDg13BcBYI22maVFELTIHHCfy4ZyCf/w/GISnsP3w0dbmXyEAdKdO+XLNYEqHLvCp+Hnm+C3+nh2qOWESf/bNo/Q/CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=esfc/36z; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=V6Jdet4N; arc=fail smtp.client-ip=173.37.142.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4562; q=dns/txt; s=iport;
  t=1713178542; x=1714388142;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9lSXZlY51B0MS2tg9691UP5zYxAeMxpBEQdObrnRLOM=;
  b=esfc/36znpohBQGso/OayI1G1tsFlpK628vrTkbdSX7uATXL15Q8MR+P
   rbJRnjNOBceH9dxdvfLZsz7Lm+UZZLBlCsVRzkRCdmwWz15hCsWbu6/yG
   RSplzGZpCCPepY5UfotYfJDnVNQAcoaywlYMvIz0AlAYPC/PmWV/rm6Dx
   Y=;
X-CSE-ConnectionGUID: 8qXqmtvQSnqg8GetxwHeeQ==
X-CSE-MsgGUID: 2scPPsC+RqStZ2gQ1tLUhA==
X-IPAS-Result: =?us-ascii?q?A0ABAADwBh1mmIcNJK1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQCWBFgUBAQEBCwGBcVJ6AoEXSIRVg0wDhE5fiGwDngiBJQNWD?=
 =?us-ascii?q?wEBAQ0BATETBAEBhQYCFogBAiY0CQ4BAgICAQEBAQMCAwEBAQEBAQEBBgEBB?=
 =?us-ascii?q?QEBAQIBBwUUAQEBAQEBAQEeGQUQDieFbQ2GWQEBAQECARIREQwBATcBBAsCA?=
 =?us-ascii?q?QgRBAEBAQICJgICAi8VCAgCBA4FCBqCXgGCPCMDAaYiAYFAAoooeoEygQGCC?=
 =?us-ascii?q?gEBBgQF3XUJGIECLgGILQGBWYhjJxuCDYEVQoJoPoJhAoFgAhWDRDmCDSKBG?=
 =?us-ascii?q?IUMfpF2glIQLYVKCUt9HANZIREBVRMiDwwaAhsUDSQjAik+AwkKEAIWAx0UB?=
 =?us-ascii?q?C4RCQsmAyoGOQISDAYGBlsgFgkEIwMIBANQAyBwEQMEGgQLB3WBfIE9BBNGA?=
 =?us-ascii?q?Q0DgTKKEgyBfYE0KYFOKYERgyFLcYQbgTkDRB1AAwttPTUUGwUEIB17BZxsA?=
 =?us-ascii?q?YJ/AT1RTDqBACoEKkWSToMrSY8/ijaVAwoog2uMDpVVF4QFgVaLKJkxiByQR?=
 =?us-ascii?q?oJUpgcCBAIEBQIPAQEGgWQ6gVtwFTuCZwlJGQ+OIBkfgmRelRR4OwIHAQoBA?=
 =?us-ascii?q?QMJhkiEIAEB?=
IronPort-PHdr: A9a23:J7QFYxz7BK+hkWHXCzMVngc9DxPP853uNQITr50/hK0LK+Ko/o/pO
 wrU4vA+xFPKXICO8/tfkKKWqKHvX2Uc/IyM+G4Pap1CVhIJyI0WkgUsDdTDCBjTJ//xZCt8F
 8NHBxd+53/uCUFOA47lYkHK5Hi77DocABL6YBR+JunvHInPp8+2zOu1vZbUZlYAiD+0e7gnN
 Byttk2RrpwMjIlvIbp5xhrS931PfekXjW89LlOIlBG67cC1lKM=
IronPort-Data: A9a23:IkjNW6Lw6cR/sIaLFE+R8pUlxSXFcZb7ZxGr2PjKsXjdYENS0jRWn
 GpLCj2Ebq2JZzDzL99/O4uzoRtQ6pCGzdVjSQAd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcYZsCCea/0/xWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVvS0
 T/Oi5eHYgP9h2cpajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKmWDNrfnL
 wpr5OjRElLxp3/BOPv8+lrIWhFirorpAOS7oiE+t55OLfR1jndaPq4TbJLwYKrM4tmDt4gZJ
 N5l7fRcReq1V0HBsLx1bvVWL81xFf1fyKbCPWaGisqKwB3pfmf83NVjAXhjaOX0+s4vaY1P3
 fUcLDZIZReZiqfshrm6UeJrwM8kKaEHPqtG5Somlm+fVK1gGMueK0nJzYcwMDMYmMtOEOzYY
 NcxYjt0ZxOGaBpKUrsSIMhjx7/33iimLVW0rnrPvqEP23P4jzZo66TfatXsI8CueMV8yxPwS
 mXupDmhXUpAa7Rz0wGt9nOqm/+Kni7hXo8WPKO3++Qsg1CJwGEXThoMWjOTpfi/l177WNhCK
 kgY0jQhoLJ090GxSNT5GRqirxa5UgU0Ut5UFagx7xuAj/CS6AeCDW9CRTlEADA7iCMobWwz5
 kaMg83QPjp2v+26RG6N6ZeZoArnbED5MlQ+TSMDSAIE5fzqr4cykg/DQ75f/Eid042d9dbYn
 WrikcQuu4j/m/LnwElSwLwqqzuoop6MRQkv60CNGGmk9Qh+IoWiYuRECGQ3D94efe51rXHY4
 BDofvRyCshVVflhcwTWEI0w8EmBvartDdElqQcH82Md3zqs4WW/Wotb/StzIkxkWu5dJmayO
 RaC5V0Aus4IVJdPUUORS9/qYyjN5fWxfekJqtiFBjazSsEoK1/Zpn0GibC4hTi1zyDAbp3Ty
 b/ALJ7zVixFYUiW5DG3XOwamaQ63TwzwHibRJbwiXyaPUm2OhaopUM+GALWNIgRtfrcyC2Mq
 oY3H5XRkX13DrahChQ7BKZOdzjm21BhW8CvwyGWH8beSjdb9JYJUKaAkex5I9U0wMy4VI7gp
 xmAZ6OR83Km7VXvIgSRYXclY7TqNauTZ1piVcDwFT5EA0QeXLs=
IronPort-HdrOrdr: A9a23:iRtbFaONASX4nMBcT7P255DYdb4zR+YMi2TDiHoBKiC9I/b5qy
 nxppUmPEfP+UcssREb9expOMG7MArhHO1OkPks1NCZLUnbUQqTXcBfBO7Zsl/d8kLFh5NgPM
 tbAs9D4ZjLfCZHZKXBkUqF+rQbsaW6GcmT7I+0oQYJPGVXguNbnnhE422gYzVLrXx9dOAE/e
 2nl7F6TlSbCBIqh+2Adws4dtmGjefm0LjhZhkLDQMm7g6hsROEgYSRLzGomj0lf3dq27kNzU
 jp+jaV2kykiZ6G4y6Z81WWw4VdmdPnxNcGLteLkNIpJjLljRvtTJh9WpWZ1QpF5d2H2RIPqp
 3hsh0gN8N85zf6ZWeuuybg3AHmzXIH92Li81mFmnHuyPaJAA7SSvAxwr6xQCGpsnbIj+sMiJ
 6jGFjp7Ka/OCmw2hgVIeK4DS2C2HDE/EbK2tRj/EC3GbFuHYO567Zvvn+81Pw7bX3HAEdNKp
 gzMCnRicwmBW+yfjTXuHJiz8erWWl2FhCaQlIassjQyDROmmtlpnFoiPD3s01wvq7VcaM0qt
 jsI+BtjvVDX8UWZaVyCKMIRta2EHXERVbJPHiJKVrqGakbMzaVwqSHrokd9aWvYtgF3ZEykJ
 POXBdRsnMzYVvnDYmL0IdQ+h7ATW2hVXDmy91Y5ZJ+prrgLYCbfhGrWRQriY+tsv8fCsrUV7
 K6P49XGebqKS/0FYNAz2TFKtJvwLklIYUoU/oAKhuzS5jwW/rXX8TgAYDuGIY=
X-Talos-CUID: =?us-ascii?q?9a23=3Auu7tj2pSCG5d6chUCZhMsPjmUZA8QmTY0GnpGEm?=
 =?us-ascii?q?hBjZGRaGFVn+d9Zoxxg=3D=3D?=
X-Talos-MUID: 9a23:4UuJnQah7AXgYOBT7STnvAl5H4RS+p+yOhoCqMwan/SEHHkl
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-2.cisco.com ([173.36.13.135])
  by alln-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 10:55:40 +0000
Received: from rcdn-opgw-1.cisco.com (rcdn-opgw-1.cisco.com [72.163.7.162])
	by alln-core-2.cisco.com (8.15.2/8.15.2) with ESMTPS id 43FAteor003576
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 10:55:40 GMT
X-CSE-ConnectionGUID: fcH1uFrSQxyREa0NHfb5Ag==
X-CSE-MsgGUID: z3bOba27QbaqYh9yzISZDA==
Authentication-Results: rcdn-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=vchernou@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.07,203,1708387200"; 
   d="scan'208";a="8702388"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by rcdn-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 10:55:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SolQTPfqhU1MbmYFRWRPq/VQzCXIueS3P3eu6OZyJbySagHLMRRG/PzHeTS7mf9qt3kUlfWJ4fCiVaLkHLrxv+hsFIZW163Zp2s98gvUxxbsVrhLhli/uGzOGtYBS+CdwOvs1hm88zYJ6ujngpPxCtPWO3Hxunz6/RkR4nBd7s6jrznxaUOuY3GLZojJ+Ifo+L0d5mMzkdkLLpdKLBx0yf1MMI7LeSDlVZoC+PuO40+BrRGRPMa6+yGYsxUsUof4ZuKzMe/U51oMaLpPc9MasFWHN6Ig+QByslOYMsF2WIH8TI+8jgRHeRUq4iuIgGDaQYH97fcC0dRclrHp2hrPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lSXZlY51B0MS2tg9691UP5zYxAeMxpBEQdObrnRLOM=;
 b=Fykp7yyQKGz3Mv5fmLscszGs+nUgxOXja4O/l6yCZ/Ix9MitHWSHiVo3Cw4ni5K5dv8kAoz/UibiO34wVp1f/BDncFueU+HojUlQoPGSGFHG/MniK1HwASuThnQ2XYlkukQV1lYRbYgMboqc/oem2l2YdrSWIPyNL3ohUnywMBrZQc/0qa66nwytn5r8MB1nFCVbg4zk8B/wUu44DRSgnmS4XFPVyXowi+bawzxpseqVGbcAeU2QeO1A+yxaWLPMAbeIr0N0frOw3K6MQrrVkxN4YcvsrgkqsOPBddjjHDDn3c9HGWNLAFQOMvV/NdoLDroqmDAj8F+OCu5WRXmWJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lSXZlY51B0MS2tg9691UP5zYxAeMxpBEQdObrnRLOM=;
 b=V6Jdet4NlI+53Q/H4c7zFRbi8Qp7WVNhVx0mNWlonPwefScqlC78YQKretj290WJC0nmcv7F8jc4tUC4zJL45si5ID0RLeCjCa8H1km0RvKzD+phNaad9CRJRMO4csu6K9KkW5WMuIyMYt+3wXLTTwGOUYOn05l6kDuEsBTbjwI=
Received: from DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) by
 IA1PR11MB7775.namprd11.prod.outlook.com (2603:10b6:208:3f3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.26; Mon, 15 Apr 2024 10:55:37 +0000
Received: from DS0PR11MB7765.namprd11.prod.outlook.com
 ([fe80::d142:4626:e291:96cb]) by DS0PR11MB7765.namprd11.prod.outlook.com
 ([fe80::d142:4626:e291:96cb%7]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 10:55:36 +0000
From: "Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisco)"
	<vchernou@cisco.com>
To: Masahiro Yamada <masahiroy@kernel.org>
CC: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/Makefile.build: fix ext mod subdirs build with
 separate src,build dirs
Thread-Topic: [PATCH] scripts/Makefile.build: fix ext mod subdirs build with
 separate src,build dirs
Thread-Index: AQHajx2e1RSlsZNyQ0es5JvI0JNxdrFpIjCAgAAGR4M=
Date: Mon, 15 Apr 2024 10:55:36 +0000
Message-ID:
 <DS0PR11MB7765B82E94A9B0B2E41D6E83DE092@DS0PR11MB7765.namprd11.prod.outlook.com>
References: <20240415101345.3807776-1-vchernou@cisco.com>
 <CAK7LNAQ3VJN5Ga1aJnrpaPoPaKMCZR3dauo-SWaH9=y9zv1F5w@mail.gmail.com>
In-Reply-To:
 <CAK7LNAQ3VJN5Ga1aJnrpaPoPaKMCZR3dauo-SWaH9=y9zv1F5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7765:EE_|IA1PR11MB7775:EE_
x-ms-office365-filtering-correlation-id: aa06c32d-6e5d-4bea-4d55-08dc5d3a94be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YqIjb0/Ka2VrQ9TkHTWdObczh7FpemKTav0jp3XSBDs7LtWwN+exhDJev5UfOIx4v24UnDqlw1v4oVw6PrVOMSxgXKOXw0k0mErxMK9fohtXEUBcFZw3MCQU5+PFntritHvFLAJGEiLA9ZDL3TufdqDGdktTsJUT2PbdTLF1WsUcD/u764jDvUWYWgHKpiyop+7lgnW6YIrkoj1d5SjeDTzTX0IEp5Yrk3Phthg6wpoDqvOyHxjc0VmspqxvTwrmAzQLsQ/UloOrM0P1K1q62TTY7wXBrxXIzm3s/veCu31hk3cZLiw2gWefss8jJSY7e0XIHnppCKhF9rufYHdAKbmB2VKPL92CV1QqvSgdeV66NmU/zrcz7tIe9FyXM8XXMpo378QxVltkwUT7BkBdz1lFSZdibZ2hqVakNUHnE5mVs0vMWyPHUz9UiKAN3egQ9kc0GoQ19scwDjC8bO4Ri+DjLDWw8G5kNuqHxrTdtPlHakIPDUAIK2VykLnWPFpcwwnEphkURvWkB2ngDdZErzQyEMAcDQjJtdoMd8oG71yCZbSSQt8p1jedkhb3UbecrCZwjuXAn3c4QE9g4z6TDAAYIYkiJREoJ58NCg1UIhNtRkyokkcbvEkesfbD2nO7rtr8fcOy6iJUOQ4hqZOhL6CpumT0fnVlk8tYvAaYyYGYKFqWZziBRDEyOcRcqb0A6U4u3NjUxxu4Q62ZU8wSYiG4etpJYqNMaiGFHNlN6L0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7765.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjhVQzdDb2ZEY29LSG55bjFzcjNtQTVqTzVQbm56U1hHQXAwcEh1NXRSZ2l1?=
 =?utf-8?B?dlBBMm5hbWRCSXRSakVqbjQ2RUhPdzlpVkk2Q1BEVWVTbUNQNWZKbkJtK2J6?=
 =?utf-8?B?d1o3NnRsb05MSWk1c2NPcjhYbTl5MUhveTE1UUNhMVZTZTB5RFE0b0ppMFhR?=
 =?utf-8?B?Z2lnNTN0anUycWZHdkFESE1xWTRGY1d6UXh0N1UwbUJsWWVXM1JVL3p6QXo1?=
 =?utf-8?B?b2EzOUlmRk5RZzJxRENmVk9OR1Z4WTUvcnFoUS9tN0FNTXQ2Z3lCZS9ES3ZT?=
 =?utf-8?B?VnRqNEhOV1JZZmFjTnJPbHZ5MXZDWHhtQTJ2STVOWUFCODVCK3l6QlY4S2Ju?=
 =?utf-8?B?eGtIVC9mVFozN29mZHgzWndzcWh4QTJ4eWRZZ1ZscCtlT0RwM0ZlWlVtUlpO?=
 =?utf-8?B?QlczdElVT2E5UHdXN3F3S3Rwd2J4NkR6Smd0cjlBNDVtcGZNZlhxN1dPM2R6?=
 =?utf-8?B?anJTcXgzK0g2WXZ6NlZPZUJzOHdWS3JiUFJFYU5xWWJSQ0NxaVFNK3Y5bEUv?=
 =?utf-8?B?Y2lpRnZ6ajlaOSt1UkdDQm94K1VBMWZKTEprOGoxLzllNzRzdHB5RlFRYVpC?=
 =?utf-8?B?Nm5NMWNyVk9OOHVTWks3aUFlclZkMWFnMml5c3lsdi9RRW9nYTRIM1R3UDZ0?=
 =?utf-8?B?cFVTdlBMVk8yOXBCMHdVeWFlNmQzdU5EdVRvQVkvQlJUbHRXNzE1S3VGZkgz?=
 =?utf-8?B?MVB6NW1jNGpZSzdUNkNxc3pSMnNHdS9xYmNjRm9JV01hWnJOdHRYUzBjL0gy?=
 =?utf-8?B?cjEwWk1pV2tOV1orWWVSUzJYbGxOZklvQ1QrNW92RWJ4Ly8wdGk1MllxOWFS?=
 =?utf-8?B?WGEwekQzaDJ5MmRnYmxtckY3UlZ3UXk5K1JHdEN4bCttcm91a3IrWnRlSlpq?=
 =?utf-8?B?dFFwZFArQk5qUzc2ei8xZDI0WWtiTkhxcTFoWWJ4UEI0YVJkc0wyWWZvWk1y?=
 =?utf-8?B?d0hXUmxrT1QrUGgxSDFWYXRsTEtYZ2haUGVtbXRVVktYZEtnZ1ZyemtIaG0v?=
 =?utf-8?B?WXN0RHBKNEVDMm5SbWdBdmppcktNRUxSOUNjQjl0dk9nOVFscXFPbGdMY2xt?=
 =?utf-8?B?end1RkhzV3B6L2hyRDdKMFo2NmdJeXdBLzF3VERWT1pjYVJmWWtWU3ZlTWRO?=
 =?utf-8?B?R2RNYlVuUzJxN2RoWm1ZV2x3M05DdVBNMnVNK2RhQjM5TkI4RXkxL3ZwU09a?=
 =?utf-8?B?cm4wbDBzZFR2dWNkeXhER1pKdnpvZ3dSai9yVW9OMXlqZGw2U3ROZEJvRUU0?=
 =?utf-8?B?VHc5dUlBRGZ0a0JCTWhGR253WnljRXN6ZlFtZlRXbjB6a00yU2o2NkdEVVhU?=
 =?utf-8?B?TzlrQTFvcVZsbitobk1GSm5XNVRDY2lQMy9FOUcyeDh4WFYrZ2czdEh2ditr?=
 =?utf-8?B?NU9tazNpb3BhSFBvOHFJZXpONjBaU2xGU0hBcWEyaXRTVEpCZzZoMyt4Z3Ey?=
 =?utf-8?B?Z3p0VHZ2YzBmQXRIbkVsdS9tejNFY1lLL0VBcjhYd2psTDFGb1FPWVA4OGZK?=
 =?utf-8?B?VlFORVJSRzdlWHYvRHgrbENFbG5sRHlRcTdQWXNXVWtlbUd4cG55Q0EyaURI?=
 =?utf-8?B?bXE0ZFQwVjRpYVlzK2pOM0h0azRpNWRKOHpwM0lMU0JyaGRoRE5qd1BwN0Ru?=
 =?utf-8?B?eXMrU1NiVDl0ay94OG9ISmZFVStETzZQeHhYL2twMUwvV2lXOTdwUU53RTZB?=
 =?utf-8?B?aGJjWmpiMXVhb2p3a1VMNXJ4MWNpT2Q1NHNTVTVnZ3JnS2JhaUZEZGZHWE1o?=
 =?utf-8?B?aS8ySm1OUFArSERKdWhTQmJ5bUhOdzFiWUYyZHgyb1c1TllxSTRkRTlxRVhG?=
 =?utf-8?B?QUNCcEU5UHhZSFBuVms3dTA2cGF2VE1WVU9FUG44QUJRRFRiS20zZFRENzc0?=
 =?utf-8?B?cG1PMDYvMlVxWWtUV2J3U0pYRjRhc1FSc3o5WXZPTW9yV3grcWt2dlcyYkpD?=
 =?utf-8?B?U3pHVitXTk5yaUR6S0N6ckZyUjF2aUwwUit3UTRPZjlJa2FncFBPR05CK2RU?=
 =?utf-8?B?VUt5em9oM3diR0FGZXM4MTdDS0FZUFpHZlQxTDFHRVZ5ak9wcnBkTGhhNzhy?=
 =?utf-8?B?L1FqMDkvamxUZVp5eFNtWE5WU2Z4cmMrZVF4ZmFtbk41R2xzSXhCL0N5Z0F1?=
 =?utf-8?B?Y0RPWTBFdFN1b3ByZUMzM3BMNWxNZ2dybU9EOGYyeDNHcUhJRld5OEpRSUtp?=
 =?utf-8?B?K2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7765.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa06c32d-6e5d-4bea-4d55-08dc5d3a94be
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 10:55:36.4142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FF6BcAlGfuE4CVz4Xx45f/Kt0Fkyr27EO4AlC4DXxbgN7MaRdpXAXKGFW0NJCPgaAMvQ2uYXB5N0TWkmw+9WKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7775
X-Outbound-SMTP-Client: 72.163.7.162, rcdn-opgw-1.cisco.com
X-Outbound-Node: alln-core-2.cisco.com

SGkgTWFzYWhpcm8sDQoNCkFzIEkgdW5kZXJzdGFuZCBzZWNvbmQgcGF0Y2ggaXMgZXZlbiB3b3Jz
ZSBjb21wYXJlIHRvIGZpcnN0IG9uZSwgY29ycmVjdD8NCg0KPiBPbiBNb24sIEFwciAxNSwgMjAy
NCBhdCA3OjE04oCvUE0gVmFsZXJpaSBDaGVybm91cyA8dmNoZXJub3VAY2lzY28uY29tPiB3cm90
ZToNCj4gPg0KPiA+IFRoZSBjaGFuZ2UgYWxsb3cgdG8gYnVpbGQgZXh0ZXJuYWwgbW9kdWxlcyB3
aXRoIG5lc3RlZCBtYWtlZmlsZXMuDQo+ID4gQ3VycmVudCB1bm9mZmljaWFsIHdheSh1c2luZyAi
c3JjIiB2YXJpYWJsZSkgYWxsb3cgdG8gYnVpbGQNCj4gPiBleHRlcm5hbChvdXQgb2YgdHJlZSkg
a2VybmVsIG1vZHVsZSB3aXRoIHNlcGFyYXRpbmcgc291cmNlIGFuZCBidWlsZA0KPiA+IGFydGlm
YWN0cyBkaXJzIGJ1dCB3aXRoIG5lc3RlZCBtYWtlZmlsZXMgaXQgZG9lc24ndCB3b3JrIHByb3Bl
cmx5Lg0KPiA+IEJ1aWxkIHN5c3RlbSB0cmFwIHRvIHJlY3Vyc2lvbiBpbnNpZGUgbWFrZWZpbGVz
LCBhcnRpY2FmdHMgb3V0cHV0IGRpcg0KPiA+IHBhdGggZ3JvdyB3aXRoIGVhY2ggaXRlcmF0aW9u
IHVudGlsIGV4Y2VlZCBtYXggcGF0aCBsZW4gYW5kIGJ1aWxkIGZhaWxlZA0KPiA+IFRoaXMgZml4
IHVwZGF0ZSAic3JjIiB2YXIgZHVyaW5nIHByb2Nlc3Npbmcgc3ViZGlycyBhbmQgcmVzb2x2ZQ0K
PiA+IHJlY3Vyc2lvbiBpc3N1ZQ0KPiA+IFVzYWdlIGV4YW1wbGU6DQo+ID4gbWFrZSAtQyBLRVJO
RUxfU09VUkNFX1RSRUUgTT1CVUlMRF9PVVRfRElSIHNyYz1FWFRfTU9EX1NSQ19ESVIgbW9kdWxl
cw0KPiA+DQo+ID4gQ2M6IFZhbGVyaWkgQ2hlcm5vdXMgPHZjaGVybm91QGNpc2NvLmNvbT4NCj4g
PiBDYzogeGUtbGludXgtZXh0ZXJuYWxAY2lzY28uY29tDQo+ID4gU2lnbmVkLW9mZi1ieTogVmFs
ZXJpaSBDaGVybm91cyA8dmNoZXJub3VAY2lzY28uY29tPg0KDQo+IE5BQ0suDQoNCj4gUGxlYXNl
IGRvIG5vdCBzZW5kIGhhY2tzIG92ZXIgYWdhaW4uDQoNCk1heWJlLCB5b3UgY2FuIHNoYXJlIHNv
bWUgaWRlYSBob3cgdG8gaW1wbGVtZW50IHJlcXVpcmVkIGZvciBtZSBmdW5jdGlvbmFsaXR5DQpp
bnRvIHByb3BlciB3YXk/DQpNYXliZSB5b3UgY2FuIHBvaW50IG1lIHRvIHNvbWUgcGFydCBvZiBj
b2RlIHdoZXJlIHlvdSBleHBlY3RlZCB0byBzZWUgY2hhbmdlcyB0bw0KcHJvdmlkZSBmdW5jdGlv
bmFsaXR5IHRoYXQgcmVxdWlyZWQgZm9yIG1lPw0KDQpCZXN0IHJlZ2FyZHMsDQpWYWxlcmlpDQoN
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkZyb206IE1hc2FoaXJv
IFlhbWFkYSA8bWFzYWhpcm95QGtlcm5lbC5vcmc+DQpTZW50OiBNb25kYXksIEFwcmlsIDE1LCAy
MDI0IDEyOjMyIFBNDQpUbzogVmFsZXJpaSBDaGVybm91cyAtWCAodmNoZXJub3UgLSBHTE9CQUxM
T0dJQyBJTkMgYXQgQ2lzY28pDQpDYzogTmF0aGFuIENoYW5jZWxsb3I7IE5pY29sYXMgU2NoaWVy
OyB4ZS1saW51eC1leHRlcm5hbChtYWlsZXIgbGlzdCk7IGxpbnV4LWtidWlsZEB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hd
IHNjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6IGZpeCBleHQgbW9kIHN1YmRpcnMgYnVpbGQgd2l0aCBz
ZXBhcmF0ZSBzcmMsYnVpbGQgZGlycw0KDQpPbiBNb24sIEFwciAxNSwgMjAyNCBhdCA3OjE04oCv
UE0gVmFsZXJpaSBDaGVybm91cyA8dmNoZXJub3VAY2lzY28uY29tPiB3cm90ZToNCj4NCj4gVGhl
IGNoYW5nZSBhbGxvdyB0byBidWlsZCBleHRlcm5hbCBtb2R1bGVzIHdpdGggbmVzdGVkIG1ha2Vm
aWxlcy4NCj4gQ3VycmVudCB1bm9mZmljaWFsIHdheSh1c2luZyAic3JjIiB2YXJpYWJsZSkgYWxs
b3cgdG8gYnVpbGQNCj4gZXh0ZXJuYWwob3V0IG9mIHRyZWUpIGtlcm5lbCBtb2R1bGUgd2l0aCBz
ZXBhcmF0aW5nIHNvdXJjZSBhbmQgYnVpbGQNCj4gYXJ0aWZhY3RzIGRpcnMgYnV0IHdpdGggbmVz
dGVkIG1ha2VmaWxlcyBpdCBkb2Vzbid0IHdvcmsgcHJvcGVybHkuDQo+IEJ1aWxkIHN5c3RlbSB0
cmFwIHRvIHJlY3Vyc2lvbiBpbnNpZGUgbWFrZWZpbGVzLCBhcnRpY2FmdHMgb3V0cHV0IGRpcg0K
PiBwYXRoIGdyb3cgd2l0aCBlYWNoIGl0ZXJhdGlvbiB1bnRpbCBleGNlZWQgbWF4IHBhdGggbGVu
IGFuZCBidWlsZCBmYWlsZWQNCj4gVGhpcyBmaXggdXBkYXRlICJzcmMiIHZhciBkdXJpbmcgcHJv
Y2Vzc2luZyBzdWJkaXJzIGFuZCByZXNvbHZlDQo+IHJlY3Vyc2lvbiBpc3N1ZQ0KPiBVc2FnZSBl
eGFtcGxlOg0KPiBtYWtlIC1DIEtFUk5FTF9TT1VSQ0VfVFJFRSBNPUJVSUxEX09VVF9ESVIgc3Jj
PUVYVF9NT0RfU1JDX0RJUiBtb2R1bGVzDQo+DQo+IENjOiBWYWxlcmlpIENoZXJub3VzIDx2Y2hl
cm5vdUBjaXNjby5jb20+DQo+IENjOiB4ZS1saW51eC1leHRlcm5hbEBjaXNjby5jb20NCj4gU2ln
bmVkLW9mZi1ieTogVmFsZXJpaSBDaGVybm91cyA8dmNoZXJub3VAY2lzY28uY29tPg0KDQoNCk5B
Q0suDQoNClBsZWFzZSBkbyBub3Qgc2VuZCBoYWNrcyBvdmVyIGFnYWluLg0KDQoNCg0KDQoNCg0K
DQoNCg0KDQo+IC0tLQ0KPiAgc2NyaXB0cy9NYWtlZmlsZS5idWlsZCB8IDEgKw0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+DQo+IGRpZmYgLS1naXQgYS9zY3JpcHRzL01ha2Vm
aWxlLmJ1aWxkIGIvc2NyaXB0cy9NYWtlZmlsZS5idWlsZA0KPiBpbmRleCBhMjkzOTUwZTJlMDcu
Ljc1ZWE5MDUyZWE0YSAxMDA2NDQNCj4gLS0tIGEvc2NyaXB0cy9NYWtlZmlsZS5idWlsZA0KPiAr
KysgYi9zY3JpcHRzL01ha2VmaWxlLmJ1aWxkDQo+IEBAIC00OTAsNiArNDkwLDcgQEAgJChzaW5n
bGUtc3ViZGlyLWdvYWxzKTogJChzaW5nbGUtc3ViZGlycykNCj4gIFBIT05ZICs9ICQoc3ViZGly
LXltKQ0KPiAgJChzdWJkaXIteW0pOg0KPiAgICAgICAgICQoUSkkKE1BS0UpICQoYnVpbGQpPSRA
IFwNCj4gKyAgICAgICAkKGlmICQoZmluZHN0cmluZyBjb21tYW5kIGxpbmUsJChvcmlnaW4gc3Jj
KSksc3JjPSQocGF0c3Vic3QgJChvYmopLyUsJChzcmMpLyUsJEApKSBcDQo+ICAgICAgICAgbmVl
ZC1idWlsdGluPSQoaWYgJChmaWx0ZXIgJEAvYnVpbHQtaW4uYSwgJChzdWJkaXItYnVpbHRpbikp
LDEpIFwNCj4gICAgICAgICBuZWVkLW1vZG9yZGVyPSQoaWYgJChmaWx0ZXIgJEAvbW9kdWxlcy5v
cmRlciwgJChzdWJkaXItbW9kb3JkZXIpKSwxKSBcDQo+ICAgICAgICAgJChmaWx0ZXIgJEAvJSwg
JChzaW5nbGUtc3ViZGlyLWdvYWxzKSkNCj4gLS0NCj4gMi4zNS42DQo+DQoNCg0KLS0NCkJlc3Qg
UmVnYXJkcw0KTWFzYWhpcm8gWWFtYWRhDQo=

