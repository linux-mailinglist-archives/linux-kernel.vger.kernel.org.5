Return-Path: <linux-kernel+bounces-141403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9231D8A1DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2C428B163
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60C657894;
	Thu, 11 Apr 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="eyaHuL6o";
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Nr8vcigl"
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAB654BE8;
	Thu, 11 Apr 2024 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712856538; cv=fail; b=Ga7Xnb2vAWizDEX7tdxoc67UNtqDYe2opLFuyf5csytksyzvQW+tMkrjXjW4pBHiZtjJoYHYRPhEzw5XGafD5DA2rYNfdgW8Xw+iuMJJfIROA4X8KqG65YazcjQqZWgsbUXDOQwsKfflqXX94gMbTcFDHJBWsce74KMX/DAIkVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712856538; c=relaxed/simple;
	bh=lPwfzHM/8MSJvLXpKRDLLt/7G3QgB+wsnR8Lq4sH3Sg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cn7nQDXhMXW+2Z6LZiueejm8I31Ehg/E7/V6caQZeFMyTRWPh3epjfroidrsP14YMKACFC6ilc5xGWhFHBm+SO2j4ymYF0KjvAY5Vg5cuv3baQZg/89FsOmeIEWLgxa99kGxwTOfe9fm4rJDuFRIeZZN7jnFmMuy6jTT36FAVjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=eyaHuL6o; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Nr8vcigl; arc=fail smtp.client-ip=173.37.142.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1195; q=dns/txt; s=iport;
  t=1712856536; x=1714066136;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dIJUJGn6kGns5Gh1XWGLKoN/X/R/8wJToYt9TjupAZ0=;
  b=eyaHuL6oWZDEPYCe4u7RhQNZv5Rv8Dn+tXt54ScGlrc/Q0wjFSCRnPLS
   m9jktHW6ZDr3jt0i1JjkdlQb4vMMHKA9bSTj69fSIex8rwmphhDxbzcaP
   GwxBTKjG7RX20WY456GPYQooRC4FfbAgBpxMmMd/r68WknD6MFNSn6UOB
   o=;
X-CSE-ConnectionGUID: /diDNKqJQPKuVEkWnut8Yg==
X-CSE-MsgGUID: eMx4fNE3QUSnnhkv8R7usg==
X-IPAS-Result: =?us-ascii?q?A0CbAQBQHRhmmJxdJa1aHgEBCxIMQCWBHwuBclJ6gRlIi?=
 =?us-ascii?q?CEDhS2GSoIlhXqMSxyLJ4ElA1YPAQEBDQEBRAQBAYUGAogWAiY2Bw4BAgICA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBBgEBBQEBAQIBBwUUAQEBAQEBAQEeGQUQDieFbQ2GW?=
 =?us-ascii?q?gEBAQMSKAYBATcBDwIBCA4KHhAQISUCBA4gB4JegmADAaUXAYFAAoooeIE0g?=
 =?us-ascii?q?QGCCgEBBgQF3XUJGIEwiCwBijcnG4FJRIQ/PoJhAoFghkODG5I3gRSBcII4h?=
 =?us-ascii?q?hxUfRwDWSERAUsKNAk6DwwaAi8NJCMCLEoKEAIWAx0YMhEJCyYDKgY2AhIMB?=
 =?us-ascii?q?gYGWyAWCQQjAwgEA1ADIHARAwQaBAsHOD2BfoE9BBNHgUKKFwyDMymBUCmBE?=
 =?us-ascii?q?oMtQnGEIFcDRB1AA3g9NRQbBiIBolaBLXArD5V5rgWBPAqEE6INg3KMfpkxm?=
 =?us-ascii?q?GKoWwIEAgQFAg8BAQaBawEygVtwFYMiUhkPjiAZg2GePng7AgcLAQEDCYpoA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23:isdUlxzipbE+vpXXCzMVngc9DxPP853uNQITr50/hK0LK+Ko/o/pO
 wrU4vA+xFPKXICO8/tfkKKWqKHvX2Uc/IyM+G4Pap1CVhIJyI0WkgUsDdTDCBjTJ//xZCt8F
 8NHBxd+53/uCUFOA47lYkHK5Hi77DocABL6YAZ8IOX4HpHbp8+2zOu1vZbUZlYAiD+0e7gnN
 Byttk2RrpwMjIlvIbp5xhrS931PfekXjW89LlOIlBG67cC1lKM=
IronPort-Data: A9a23:TWj6p64/vnFUqbVsBYnUawxRtP3HchMFZxGqfqrLsTDasY5as4F+v
 jQfDGuGPq2DNzSgfNx3YIjlpkpTuZfUmt9lQAY6rCE2Zn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyKa/lH1dOG58RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wq/KUzBHf/g2Qoaj5NsvrZwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoZWk
 M6akdlVVkuAl/scIovNfoTTKyXmcZaOVeS6sUe6boD56vR0SoPe5Y5gXBYUQR8/ZzxkBLmdw
 v0V3XC7YV9B0qEhBI3xXjEAexySM5Gq95eALXmTl++K7XT+UGbS7vZRClwqbbwXr7Mf7WFmr
 ZT0KRgXZRyFwumx2r/+F69nh98oK4/gO4Z3VnNIlG6CS615B8GYBfyXu7e03x9o7ixKNfrXY
 csUbSVmRB/BeBZIfFwQDfrSmc/y2ySgK20J9g/9Sawf7k3DkAJX/ePUDeHTfNyJW5VvwVuDq
 TeTl4j+KkpHbIPEk2XtHmiXruvOmz7rHYEfDru18tZ0j1CJgG8eEhsbUR28u/bRokq/Xc9Pb
 kAT8QIwoqUosk+mVN/wW1u/unHslhodXcdAVu4w9QCJxoLK7AuDQGsJVDhMbJohrsBeeNAx/
 kWCk9WsDjt1vfjID3mc7byT6zi1PED5MFPuewdDQQopxfr6grgLrQ/xY9VcFrOp3uz6TGSYL
 y+xkAAygLAajMgu3qq9/Ezajz/EmnQvZlBujukwdjz8hj6VdLKYi5qUBU83BMuswa6DRVWH+
 XMDgcXbsaYFDIqGk2qGR+Bl8FCVCxStbmC0bb1HRsVJG9GRF5iLJt44DNZWfxkBDyr8UWW1C
 HI/QCsIjHOpAFOkbLVsf6W6ANkwwK7rGLzND6+NNIUROcguL1Lco0mCgHJ8OUizyCDAdolia
 P+mnTqEXB729Iw+lWXmGb1BuVPV7nlvnzi7qW/HI+SPiufGOyXPFt/pwXOFb/sy6+ufsR7J/
 tNEf8qMwFM3bQENSne/zGLnFnhTdSJTLcmv86R/L7fTSiI4QztJI6GKntscl3lNwv49ehHgp
 C/tAye1CTPX2BX6FOl9Qi05MeOyB8Yg8xrW/0UEZD6V5pTqWq72hI83fJosdr5h/+tmpcOYh
 dFZEylcKpyjkgj6xgk=
IronPort-HdrOrdr: A9a23:e+jqsqppVNaKSbhRPB+ccf4aV5tZLNV00zEX/kB9WHVpm5Oj5q
 OTdaUgtSMc1gxxZJh5o6HwBEDhex/hHZ4c2/hpAV87NDOW+VdAX7sSnbcKpAeQWxEWl9Qtm5
 uIFpIOauEYYmIK8PoSjDPIdOrIheP3jpxA5t2ujEuFLzsaF52Ihj0RYm30YygGIDWuR6BJa6
 Z0jfA33wZIDE5nFPhTcUN1JNQryee78q4OSCR2dSIP2U2ltx/twrj8FBSTwxcZVB1y4ZpKyw
 L4uj28zJ+O99WgxDHh90K71flrcd3apedrNYipsIw4Oz/sggGnaMBKQLuZpg04p+mp9RIDjM
 TMiw1IBbU311rhOkWO5Tf90Qjp1zgjr1X4z0WDvHflqcvlABonFst6g55DeBex0TtlgDg86t
 MN44uqjesPMfryplWk2zEObWAwqqOAmwtlrQfUtQ0EbWJRUs4NkWVVxjInLH5JJlOO1GlgKp
 gtMCkZj8wmLm9zqBvizzVS6c3pUXIpEhicRE8e/sSTzjhNhXh8i1AV3coFgx47hd8AorR/lq
 /5255T5ftzZ95Tabg4CPYKQMOxBGCISRXQMHiKKVCiEK0cIXrCp5P+/b1wvYiRCdM15Yp3nI
 6EXEJTtGY0dU6rAcqS3IdT+hSIRGmmRzzixsxX+pA8sLzhQ7jgNzGFVTkV4oediuRaBteeV+
 e4OZpQDfOmJWzyGZxR1wm7QJVWIWl2arxchj/6YSPGnivmEPydigWASoemGFPEK0dSZl/C
X-Talos-CUID: =?us-ascii?q?9a23=3AVDaR/2gxKEV6/xuMwkyBdbSwwDJuNXHc4FHzOm2?=
 =?us-ascii?q?BMUV0dpCWdlmN5PNVnJ87?=
X-Talos-MUID: 9a23:IzGo4QsjYzTZ1VgARM2niRRyaMlOzv+XNXsLl5UFpZm+ajFrNGLI
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by alln-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 17:27:47 +0000
Received: from rcdn-opgw-1.cisco.com (rcdn-opgw-1.cisco.com [72.163.7.162])
	by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 43BHRlnd032114
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 17:27:47 GMT
X-CSE-ConnectionGUID: yZGJQtO3Q+281CniCISftg==
X-CSE-MsgGUID: ygbEhW2eRDylscrmOCyYWQ==
Authentication-Results: rcdn-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=danielwa@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.07,193,1708387200"; 
   d="scan'208";a="8524497"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by rcdn-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 17:27:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVmyoco/83AsccemWP23HvO0X8amKmf2pmaHIcblSvsFHZ0/QEAZeug16b5jT4knBE3uaAqewUJWOJAHPmeUdlfHqe0Y+pM5tGfL1dpzIX+7/Q+ZZBtsXCsdkukl6U7+GI33yi+lx/WY1rETUTyqGjvcpBSPbPD1/5p1gKosI8QnvrwDtNsd4ba21HecQ0MLUp2ck2AhLumA/qD1Lx+XxABA7of3K3sHb6Usanli6H1qYhXTgBxQFqDdz42GYiXbPK2nCvGKjHr9Kg7Uk9CKcrzOjt+bwTdyLZqfGCyCA7SGebU/yJLTNVZv/273cejBqiGOSe7ginyqr7P+v4o92w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIJUJGn6kGns5Gh1XWGLKoN/X/R/8wJToYt9TjupAZ0=;
 b=fLGJ16QaXLiAuP0TSneTdqE9abIkMZoLMwGCIp2CIE0mhN2DwCi1iXaJS3pDSbwT4+NKPfkfAjgANfPXQPQV8OvTDowe5NrnzwDs4vMVUxfBYiAj9ws1UxW2P704MROtpIN7SIDjn5wuKnJT7e0rRxsaPAwiQbUKmZ0YJhNfNZChf+b3DPSeJALZ9gA3Nktntf7vG2ZiY4R7Sw6qDnnPmZFB2J21urDfRO+lXwKvjuKdBRaewOofjl2no/8zMa0F1a8iGv8bAyJFVmNwxRPTHSV+cCDcp7ZL55EfQH7itfEIHqEycKQhrtYVgFegUlLLdWdg4D9F8PsJmRYVIy9cag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIJUJGn6kGns5Gh1XWGLKoN/X/R/8wJToYt9TjupAZ0=;
 b=Nr8vciglxR8Lu1JTbN4VzThv8cBg5SXM0dUf5oqSg7Ju5ok7us7TAvKrCqc0Uh6S89AADyQjOHvW51mJ0mW5soGCx98ytqDYhIwlU1dIIq8Anhk57A02ovksGD7Sga/dwYF2S7o48cd0h76bMihjpounweSVkHlolJ20hd4CIrY=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by CH3PR11MB7771.namprd11.prod.outlook.com (2603:10b6:610:125::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Thu, 11 Apr
 2024 17:27:43 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::22f4:4617:117:7a44]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::22f4:4617:117:7a44%6]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 17:27:43 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
To: Nicolas Schier <n.schier@avm.de>
CC: "Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisco)"
	<vchernou@cisco.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan
 Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        Jonathan
 Corbet <corbet@lwn.net>,
        "linux-kbuild@vger.kernel.org"
	<linux-kbuild@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Add MO(mod objs) variable to process ext modules with
 subdirs
Thread-Topic: [PATCH v3] Add MO(mod objs) variable to process ext modules with
 subdirs
Thread-Index: AQHajDWPNw0w9AAG+kK+xjeBwf3pzA==
Date: Thu, 11 Apr 2024 17:27:42 +0000
Message-ID: <ZhgdjpE+yl3IYSzl@goliath>
References: <20240405165610.1537698-1-vchernou@cisco.com>
 <ZhfLrGrED-ls6i5V@buildd.core.avm.de>
In-Reply-To: <ZhfLrGrED-ls6i5V@buildd.core.avm.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|CH3PR11MB7771:EE_
x-ms-office365-filtering-correlation-id: 56f16051-6dc8-42a1-992c-08dc5a4cb1ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 J2QdO53Q1lai2mVmFGkCVB19KfDsXKkplHVpvF6UJpD/MNRMReYQVO7icirpnYZwDZ9cy15WgNJLf266jij9Xd11ZXi+EEjyDjwql9VehG/MkRJqCH5z5uhXEk5nBFMO4cis1OPys2OFv+Tn8JKocul+Ej1Dkj4Q43cupQ6D3pdib8cUcm+ovQTL9cKdf5BCg7+NL1kP/UgRc2dordpHI2bB4PtoVtgBgF24NS15xGpxy12e07+/MjtUmWKyKB/bK7QatKUHFILbm4Nh1wmR4G4uyipc3GUU+Zv2g4LDO6e6Q4Wk6mv8On1VP/Y5fWnhC4WKnSDknbvg12pHauPDU/rArXWEQWwVTmHIid95KSKN+YIBI006AoHVvLai5JlI1MQdSjZjra5tbwEyoN9P3XSNfesBHmTAcJxwEkhkCjOGFZKTPKIH7NdzDqp4l3meLTfK51wTTN/IBVv5+2l9TcMhSVwdyIkq7WjeRKPdkgZySsyaYjf0nWXybDa0sLXli/qea4YY4d2G4YwfsntApJrAM5auxPHLDYQ3vc2bahJ7D/cl6xFgDzo0IaTSubUW/nBeRWg02QlvHlTqEuWDr6tTJxluKVHroYykdr3n/4f9Te2RC1vuf+rjjhrzIei08S2U38Dk7SZW8CoqnO2IWV2Jqu+0vwiaMVSPftyFoTaougu/a/E1scCNH2P/C6lTIAfyGNMFhKIUhUUmD+kAWg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iIIDhQe9g8Z62eQkB7c1WYpRqw2AHVJaPs5Uq+PQtVQKVNQr+QbqwH4NCIew?=
 =?us-ascii?Q?aO8RGyS4ihl8JEbBcyCwDn4hjed7GH/WgcW3/JcViRJhLaWXI0zP3lNI2oS7?=
 =?us-ascii?Q?lSreWDDpeZdJH+3CLeEewEqRMe2eXRHERuSaYzlKJmdqa1mkSOsr6IBI+2nk?=
 =?us-ascii?Q?InSdvkPEqWsurKQh/Eq89ZPbWhlpp1ffJVMstmGaXUGcwj6gJzLX+vPT4et4?=
 =?us-ascii?Q?L0qFYcV0d1E+pLTxh4UvpzNTVczIeEAT4vpnEnmNzKtrMuVM8BvH26GBipuL?=
 =?us-ascii?Q?PrunizYl3hT/8vtYJOW+V1KcJl9q3PEYpXMkZD6+nk8H1nQWqo09aofBTkHK?=
 =?us-ascii?Q?316oc63iLR3sH9URe/4+DPBH1LvjMT9QBB+l+DIRk6sVJiJPNzQpR5eub6Iw?=
 =?us-ascii?Q?C+7xGS4FDgfIZCRCiiHHFyybg50UYF8LM4XxqlnBiU9TwDGL+HkCqx6bLQEB?=
 =?us-ascii?Q?BaBU1JqpvzO9Xx1e7rKnpBDXg4LBKv3cxbmVCOyAjbRinHFDZqY0jYb4mRGC?=
 =?us-ascii?Q?QaYS4BItV+QgfUpDb/5+34FhX2VID40FbSnpOp5OdNpq0pLAOnEpD2UOx5Ep?=
 =?us-ascii?Q?JONRZzAqfiPZjRBF0Orzdi1cqyRy1zKiW4kOOrna0MF58xONvEl6hJwgd+85?=
 =?us-ascii?Q?En/fDCLscJDHXiw2ekLokXuxuSjTJlzxIqOl3mm26ih0nQOXwP5UtHwdYqe1?=
 =?us-ascii?Q?b1rDK+N8pLgYcet6xew6LaC7s608NPa0m7KNkHg8q9DXp5+Z9FUruPxH52M0?=
 =?us-ascii?Q?YTWCP90bx4Sivz6E606Wsr/PcsodmR/4EB2cYBxrn0o9YnwioK6hWvInXFuY?=
 =?us-ascii?Q?o8su7Z8tezk7wuKnWNjbehTrm6BgLzYpfhMOy8By4pCWtNAGLHKl15LfbZaa?=
 =?us-ascii?Q?X6wtrxTaHpbnHkKTcNp/D73QLBs8Y2wrjzAgu04DKBjSP3iGa6MgtChDLunz?=
 =?us-ascii?Q?PoVcOuzUErkIl9moRIknBDJACH8C22GW/sCJQum+Jm11/a43w4JEg/8gQ9b4?=
 =?us-ascii?Q?HKdN59jKZ19Toe4k693ojAUEg5d6rQqtt7ObikIuupcJoGcXT8jlHA9FxnrY?=
 =?us-ascii?Q?HQAXwrp7O4PiDTHGZwh2ikdzErnxiSLEN4nEYHWPkNRn/khW8FZ4ZkP9ZdRB?=
 =?us-ascii?Q?BII/tiJ2fevTV55NUXTxI46vIzkEFrbEuz4fSS/2z77q+R+9ON1ut69uFNQ2?=
 =?us-ascii?Q?wdkOlA47v6Y3zPGznCabG4lxve/YeA+7k9qEicYr9VhrXRl9mPJc/raO+MJU?=
 =?us-ascii?Q?rQo3mo/mh9fjXB76m1ANeqPo2e2PytphwvnlUxR9F5OVOspnusSrTXrzIcFQ?=
 =?us-ascii?Q?iQdUvqLAzbhAIZgNSco0Vihd2GC+EMM/FVLOun3CymIzCq5ZnsTKJMpVthr9?=
 =?us-ascii?Q?ZPcQNixpTTW19aSU8h4y0F8F2oQjhyIbBJaEvesFnbA1CJLNafhyPhHjusln?=
 =?us-ascii?Q?lGoC8nUe+hVOkoWB1TqntbgTIGYgOri0TLchck5bWA5LBmidT8mk5X08qYSs?=
 =?us-ascii?Q?jgExG5VytwhgIoCBjDXR3eDh5aYFPyHaA0dYBBA0gePp0knqstqZRvgfKx9c?=
 =?us-ascii?Q?e5Ef0iJeDBKtyXwSdeUUbX/USEBkP6LkIZrXdX20?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8387B0AAA8DAA645AE3802112E3C52D5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f16051-6dc8-42a1-992c-08dc5a4cb1ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 17:27:42.9604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Lc26VujeAOPHerAzvaNL9Y5QLwILKCB/DUHrk+Rz30Se2O/5DopKB8wgcYm319b/vUa3A57LaGC8E+8FDQMUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7771
X-Outbound-SMTP-Client: 72.163.7.162, rcdn-opgw-1.cisco.com
X-Outbound-Node: rcdn-core-5.cisco.com

On Thu, Apr 11, 2024 at 01:38:20PM +0200, Nicolas Schier wrote:
> Hi Valerii,
>=20
> thanks for your patch.  I know several non-upstream kernel developers
> that would like to see support for out-of-source builds of external
> kmods (and we developed several work-arounds at AVM as well); but please
> be aware that patches that don't fix or enhance the in-tree kernel/kmod
> build but only add feature for out-of-tree stuff, are rarely accepted.
>=20

If that were true we would not have driver/uio/ for example. It seems like
Cisco and NVM should work together produce a solution.

You could run into this issue even with entirely in tree modules. For examp=
le,
we may have a v6.6 kernel but we need some modules from v5.15 for some inco=
mpatibility
reason in v6.6. Then we may build the v5.15 modules as out of tree modules
against the v6.6 kernel.

You also have just normal developers making kernel modules which always sta=
rt as
out of tree modules before they are upstreamed. Those modules could be any =
level
of complexity.

I don't think it make sense to view this as strictly enhancing large of the=
 tree
modules with no upstream potential.

Daniel=

