Return-Path: <linux-kernel+bounces-96202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D86C087587E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD451F224C0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172D7634E9;
	Thu,  7 Mar 2024 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="427WzFJa";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="Z6Z2W3R6"
Received: from mail-edgeBI204.fraunhofer.de (mail-edgebi204.fraunhofer.de [192.102.163.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4827D6312F;
	Thu,  7 Mar 2024 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.102.163.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843631; cv=fail; b=L70zNrYavW2TpZP6CW10CJicN6A1gCG4pmg4KZbhu2sjg555vLNVkDIMPa3d2KaDTg8xI3RjuYKuuw7NZobHrOBaWgu02tHTcH+MghX8BRruehCRxtMM9yovLbTUwCyBySnhUxy3h/yHa+5U1DeUP7Uk0b9DOZO70BfZDyNerWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843631; c=relaxed/simple;
	bh=GtWUJfkcovjwu4o4eKydqLWJZswwJN+0mchiiUHoK4o=;
	h=From:To:CC:Subject:Date:Message-Id:Content-Type:MIME-Version; b=D1+smUZlAYkrAAgofbATV5cwIdcN5olKIOJV21J02jmw4pBfHdS700GfVoU99aDowFdYQb/IB2finI13XsUio/8mHuGeoibihSrjZPMucJXdVJ4AcTQxTRiQEvXt5fJCIplvsSq0pIXtyOqBV8P8eEr3knjEdOaw5AQOtiHQUqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=427WzFJa; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=Z6Z2W3R6; arc=fail smtp.client-ip=192.102.163.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1709843626; x=1741379626;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=GtWUJfkcovjwu4o4eKydqLWJZswwJN+0mchiiUHoK4o=;
  b=427WzFJa0H9kFcE8m+4/y58DG3sK3bzC1G6T5mtjLw/6IdFR42KFD1PF
   lFMiWoBlc1tHjZY5ddykA7+HYfluKeHssX1UyRHixmviXU5G7i+MUrue/
   9dRQOBiMn/O0XYLj/w5ZoUew6Z5ycBCCNxlbHj/Vg74y5NXqYomZqPXsy
   bgjkmVD2T/RfQ5Vm3VrvRknhI1ASA/kEmb1OM+wucFruO8QkmF4yAaEkt
   727ZtcIeoSQeizB/XCVdgWlqDH86CVB3vdZQsG50XPBEPDCGYCs5O2Ci5
   wPFEdDLxdU/vLgtqC+q1JKU3KvVz3H5N0/XCy1qfvQwKhbouRHHLplXL6
   A==;
X-CSE-ConnectionGUID: z8ACXhcEQ8G6t+gQIke2lA==
X-CSE-MsgGUID: YKP6El1MRzO/wNrTV+BXog==
Authentication-Results: mail-edgeBI204.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2FyBACrI+pl/xwBYJlaHgEBCxIMQIFEC4I5gluEVa4bK?=
 =?us-ascii?q?oJRA1YPAQEBAQEBAQEBBwEBRAQBAQMEhH+HeSc3Bg4BAgEDAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBBgEBBgEBAQEBAQYHAoEZhS89DYN7gSYBAQEBAQEBAQEBAQEdAjVVJ?=
 =?us-ascii?q?w8BDQEBNwEoDAImAjMrAQ0FgwCCLAMxtAyBMoEBggoBAQawJxiBIoEfCQkBg?=
 =?us-ascii?q?RAug2qEPAGEU4EihwuBFTWBBoIthFiDRoJogUFWgzuDbYYviziCV4URSoEJH?=
 =?us-ascii?q?AOBBWsbEB43ERAFDg0DCG4dAhEiOgMFAwQyChIMCx8FVANDBkkLAwIaBQMDB?=
 =?us-ascii?q?IEuBQ0aAhAsJgMDEkkCEBQDOAMDBgMKMTBVQQxQA2cfGhgJPA8MGgIbFA0kI?=
 =?us-ascii?q?wIsPgMJChACFgMdFgQwEQkLJgMqBjkCEgwGBgZdIBYJBCUDCAQDVAMgdREDB?=
 =?us-ascii?q?BoHCwdzBYNGBBNHEIE0gVuISoNCKoF7XAMJAwcFLB1AAwsYDUgRLDUUGygeA?=
 =?us-ascii?q?W8Hoxd6gQ6CYxGTCTOCZ682B4I1gWChJhozl0GSZwGYXCCoMgIEAgQFAg4Ig?=
 =?us-ascii?q?XqCADM+gzZSGQ+OIIN6j3p3AjkCBwEKAQEDCYI5hjctgUsBAQ?=
IronPort-PHdr: A9a23:U8kbOxw2aKrhQsjXCzKOy1BlVkEcU8jcIFtMudIu3qhVe+G4/524Y
 RKMrf44llLNVJXW57Vehu7fo63sCgliqZrUvmoLbZpMUBEIk4MRmQkhC9SCEkr1MLjhaClpV
 N8XT1Jh8nqnNlIPXcjkbkDUonq84CRXHRP6NAFvIf/yFJKXhMOyhIXQs52GTR9PgWiRaK9/f
 i6rpwfcvdVEpIZ5Ma8+x17ojiljfOJKyGV0YG6Chxuuw+aV0dtd/j5LuvUnpf4FdJ6/UrQzT
 bVeAzljCG0z6MDxnDXoTQaE5Sh5MC0ckk9QDwvu1x3rRbTzqC3G9dtyggWfM9fpROh3f2qTy
 qNKSjbGigUXOh1pyE+H358V7upR9SD/lUZAmLSKObGJF+NTI5HPJsgaZ0VdQcRAR3RsGoW9Q
 4QRPdZeB7h4hrjzuXw1qAu3FxKnGOXB7h1Cj0LK4ag7y8IoEyzDw0smAOsjkHSEoY2tNakca
 dLl16eVkmjFP9RY9XDdy6PZQDpmgK6BdJkhe+PhkEUyTRqGjW2VpKnZH2PM3N0GvVS0zbU4b
 O+w0FI9txp1mCCV3MV3torb354lx07UzwF7n4oHLojrAF4+YMSjFoNXrT3fLYZtX8c+Fnlho
 z1polVnkZuyfSxPxZgoyjT+MaTbNYaS6w/lVOGfLC0+iH82ML68hhPn6UG70aW8Tci71l9Ws
 zBI2sfBrHED1hHfq4CHR/Jx813n2GOn2Rra9+dEJk45j+zcLZsgyaQ3jZ0drQLIGSqepQ==
X-Talos-CUID: =?us-ascii?q?9a23=3A/23wCmkutC4GAp1WvyU8lG6pXurXOW+N5VzgI0S?=
 =?us-ascii?q?VMDZGFqHWRmax+64+l+M7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A1Q+PNQ9zMZ2HCQYw+ddn40WQf/ZL2/qDDBkoq4c?=
 =?us-ascii?q?h/NaiLxBOeB2tizviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,107,1708383600"; 
   d="scan'208";a="167699"
Received: from mail-mtaka28.fraunhofer.de ([153.96.1.28])
  by mail-edgeBI204.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 21:33:40 +0100
X-CSE-ConnectionGUID: 0MH7yCd6STyj+sIaLgZHwg==
X-CSE-MsgGUID: OmrX49hnS+KhHN55JvTvCg==
IronPort-SDR: 65ea24a2_cqVRLBWxykHTxzqr/3CB6wcsDM2pIPkWLC12AYLa16XvZiE
 VBSo4R8mRrvvduc3vWb7okkoA1hgb8pwmZYRw5w==
X-IPAS-Result: =?us-ascii?q?A0DjDwAwJOpl/3+zYZlaHgEBCxIMQAkcgR8LgWdSBz6BD?=
 =?us-ascii?q?4EHhFSDTQEBhS2GSQGCXAGcIoJRA1YPAQMBAQEBAQcBAUQEAQGFBod2Aic3B?=
 =?us-ascii?q?g4BAgEBAgEBAQEDAgMBAQEBAQEBAQYBAQUBAQECAQEGBYEKE4VsDYZRFhEPA?=
 =?us-ascii?q?Q0BARQjASgMAiYCMwckAQ0FIoJegiwDMQIBAacxAYFAAosigTKBAYIKAQEGB?=
 =?us-ascii?q?ASwHxiBIoEfCQkBgRAug2qEPAGEU4EihwuBFTWBBoItiB6CaIFBVoM7g22GL?=
 =?us-ascii?q?4s4gleFEUqBCRwDgQVrGxAeNxEQBQ4NAwhuHQIRIjoDBQMEMgoSDAsfBVQDQ?=
 =?us-ascii?q?wZJCwMCGgUDAwSBLgUNGgIQLCYDAxJJAhAUAzgDAwYDCjEwVUEMUANnHxYEG?=
 =?us-ascii?q?Ak8DwwaAhsUDSQjAiw+AwkKEAIWAx0WBDARCQsmAyoGOQISDAYGBl0gFgkEJ?=
 =?us-ascii?q?QMIBANUAyB1EQMEGgcLB3MFg0YEE0cQgTSBW4hKg0IqgXtcAwkDBwUsHUADC?=
 =?us-ascii?q?xgNSBEsNRQbKB4BbwejF3qBDoJjEZMJM4JnrzYHgjWBYKEmGjOXQZJnAZhcI?=
 =?us-ascii?q?KgyAgQCBAUCDgEBBoF6JoFZMz6DNk8DGQ+OIIN6j3pEMwI5AgcBCgEBAwmCO?=
 =?us-ascii?q?YY3LYFKAQE?=
IronPort-PHdr: A9a23:ciLomhZp/kPMAjUqvsmoLiz/LTFg0YqcDmcuAucPlecXIeyqqo75N
 QnE5fw30QGaFY6O8f9Agvrbv+f6VGgJ8ZuN4xVgOJAZWQUMlMMWmAItGoiCD0j6J+TtdCs0A
 IJJU1o2t2ruKkVRFc3iYEeI53Oo5CMUGhLxOBAwIeLwG4XIiN+w2fz38JrWMGAqzDroT6l1K
 UeapBnc5PILi4lvIbpj7xbSuXJHdqF36TFDIlSPkhDgo/uh5JMx1gV1lrcf+tRbUKL8LZR9a
 IcdISQtM2kz68CujhTFQQaVz1c3UmgdkUktYUDP7ETiUpTaiSfrrcl/wi+mfvz5F5wxVy695
 v8obkHZrSMmNRcX8kPHh+8gtIwL9UHExVR1lryKUtuqb8AgJ5PBXso3GFhTBd1RdQNdHYGtf
 9MiF+wAEelGnbWinQUuhCqwGy6XAfPm2CRDmnnY+Y8w2tkdLQTHxCopHf8LrzPSs+zYFKdCX
 LjtzafG9QeTdP0Lhmr7uK/GXlcBgtqdb5g3UJXc4GJ+HSr111mN85WmPAuQ28ExkzjC5dNrW
 96AqTF/kgxu+QS12twosJHznIBO9lPWrDlJzZglH/m6F0JJaov3WIsVtjudMZNxWN9nWWxzp
 SImn6UPooXoFMBr4JEuxhqabuCOUKHSslTtTu+MJzd/in9/Pr6y1F6+8kmln/X1TdL8kE1Lo
 SxMjsTWuzgT2gbS5MmKRro1/kqo1TuVkQGGwu9eKF0yla3VJoRnxbg1l5EJtl/EEDOwk0Lz5
 JI=
IronPort-Data: A9a23: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
 jzWcW8+Em/oaFyoq/knDAjLBW9z3tAzB+o=
IronPort-HdrOrdr: A9a23:ZbYRV6hmz2WVHXl9LAThOXBXyHBQXyx13DAbv31ZSRFFG/FwyP
 rAoB1L73PJYWgqNU3I+ergBEGBKUmskaKdhrNhR4tKPTOWw1dASbsN0WKM+UyHJ8STzJ8+6U
 4CSdkANDSPNykCsS+S2mDReLxBsbq6GciT9JvjJhxWPGZXgs9bnmJE4lHxKDwKeOAKP+tOKH
 LajfA31AaISDAyVICWF3MFV+/Mq5nik4/nWwcPA1oC5BOVhT2lxbbmG1zAty1uGw9n8PMHyy
 zoggb57qKsv7WSzQLd7Xba69BzlMH6wtVOKcSQgow+KynqiCyveIN9Mofy9QwdkaWK0hIHgd
 PMqxAvM4Ba7G7QRHi8pV/X1wzpwF8Vmgrf4G7dpUGmjd3yRTo8BcYEr5leaAHl500pu8w5+L
 5X3kqC3qAnQC/orWDY3ZzlRhtqnk27rT4JiugIlUFSVoMYdft4sZEfxkVIC50NdRiKorzPKN
 MeQ/002cwmP29zNxvizyhSKZ2XLz8O9y69MwQ/Upf/6UkXoJh7p3FotvD30E1wt67VcKM0l9
 gsAp4Y6o2mcfVmHJ6VfN1xOfdfKla9NS4kY1jiVmgPUpt3eU7wlw==
X-Talos-CUID: =?us-ascii?q?9a23=3Aok4p3mkB8pYK1yM6hUWXKH36l/rXOSX47CjBCEP?=
 =?us-ascii?q?mMlp4Sv6OaFa095FEjMU7zg=3D=3D?=
X-Talos-MUID: 9a23:/uoHMgYdWQ8OmuBTkDr2tG0zNMFToIeuKGZQzLcYh9evOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,107,1708383600"; 
   d="scan'208";a="8864712"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA28.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 21:33:38 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Mar 2024 21:33:38 +0100
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (104.47.7.168) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28 via Frontend Transport; Thu, 7 Mar 2024 21:33:38 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnwxUoZOM8itxVxPAVyVhhBAJFlWEJ0VZXNq/ozcVkQJbzQUudISs/8kpITv1iPVzrnEctfNLbO0gzAFicTrUiuDZZhDxcDDsFmJYUB6uIO76Am72awTR4aJdIo5TO34Y7I/z3HJ755w+N6p5ORiLkyFMpLlExDs56HswJgTlQbVoziTcmA523sRIPKZ8dpwX7u7Ox/PjfJ1Mihn2sBMbD5LcbsMit7VHuIMEL4INC5IQ0zLsnWBofRXYUG+a0jCRH0wtv7ylnt5H2YoqQ6YnQ39RHVb5E4n1/fUWGKt2xBzNNzhr+cGCb3xxOLgcbXKlGbTWKsLWuAEvr+fCLwCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdkCSdysKjrnT+Yg2Dmfrwa0+N6YMlIjAFjJxeK8PF8=;
 b=hA4b/AkichjS3EZd6wY3WGK3dp4D+W8Jf2iohRwr7XpQYGt/cn/eyDVyRQdT9HsVSwDbIbXu4iMKRHDOJ2ZGmCVoHO6vWivzyM1TzVD+8R2fZ1JXi+4wudaMlpUoUXKs72ohOdP72c0vZklqiELt2uLaWP4sZ6bgS8nrXfmy6nAcnSKiYzrWMnKQu5mf1QyctMMb1KFONORmqUs3+hGWt1cc/RD2xpm7+caz72F1BoTNtVB1HzrXumao/dOnst6XK+D3pkkUOxzQs/xNQWIIq+yv/ESF1aakknY7xzBYeaH26v/aHX36TAA04jWlQeEOVZsn7kE9Qyx/0oDonasvyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdkCSdysKjrnT+Yg2Dmfrwa0+N6YMlIjAFjJxeK8PF8=;
 b=Z6Z2W3R61XtKqE5Zz3shJGtwjyx0EpniDgvZT7R6HAYfvOSmxazsctnFLJbaUTTmipNajEmw/nwQEHh8e00iffPZ8sf575n8OfD/HKCyZB/I7eAC9bAX1du2q+kPmeMTH81bQcfTGJ70Qew3TrtslRpRrj3Tkz1tXevxRLj7dZc=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by FR2P281MB1607.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 20:33:31 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::47c2:f246:3fed:4e38]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::47c2:f246:3fed:4e38%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 20:33:30 +0000
From: =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To: Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>
CC: <gyroidos@aisec.fraunhofer.de>, =?UTF-8?q?Michael=20Wei=C3=9F?=
	<michael.weiss@aisec.fraunhofer.de>, Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <lvs-devel@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ipvs: allow netlink configuration from non-initial user namespace
Date: Thu,  7 Mar 2024 21:31:06 +0100
Message-Id: <20240307203107.63815-1-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::9) To BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:50::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2791:EE_|FR2P281MB1607:EE_
X-MS-Office365-Filtering-Correlation-Id: 234b0a40-c250-43f5-603e-08dc3ee5da06
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IboV70ZcYZYhvODI3mKgyarQdoJx5RyNrJQ2E/aL8k6ku0YuwaEKqsUcAo+zBdoaVzsFujFx5Xub3+huN5XSbNirk/j8WLbwmb/oBrtHK6BiZ3W3Tm5G0WtCtMSE6k8zvjzvtyqXjra0eMSTDQ7U//d7FOuFGuzeCW/vnbMFi0APtoUURg0wxOu29Aq5wJsAQFqYP2wvjJ9aGslgg30h8M4SfczVWfyip6W+U6OB/n3oo+XnLXjjIUlV0TfMaAMj/3SxRbfjm50R+5ckN5rJwk02n1YrOgHYdj/jtelOUCMqHz3vx7SWZ4Xhxwdm+1siHuySdvhKCf4Cf5GcuEh6T5H3D/wu0HNq8bTIQ0nhUgNLF8+vPJstlqP8OGTv0dVMkK+T6ZK34Go/E3mnthIs7C9VFlgfxJOGeRYIWJTBUixAvZEJf7KTJBcLyL7QFrm71Ih/OTINDkM48WV391+SIfx2ZBlQphRoPpVBCVg4No6rujnKRD9WHOUCGbimwrjRWxQ/mmJ2FKAtyVmTP/upm5enLIbmghG14EeIQ4nsiJtzlGxzMSpi782BEqI4USQ8R8pNMuBIHAbeo+BjEyVTFpTC+sKQWTipLMzVYzpYMH0QzpgVYueXwyYKibv9UN5cTVezfd9jHRmzD8yXChZzycgT1rasuxNKREDvHIDVVCo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlFTanIrRHlUd0pleHFsa1JaZ0RqMklzMmtBNFN4U0tOQk01djFZRG9tQWFQ?=
 =?utf-8?B?UDJFQVVhRFpmNFRvQ2V6ZFZZbXRVbGo3SnFDcTRLOXU3dTFiWHc4RUoxN2JM?=
 =?utf-8?B?U0VYNjltSG9SbzFxQXNaeTVaaXhuZU5wa3JPN3J6MUNpT2ZrZW1PbVptcDFk?=
 =?utf-8?B?elJSMC9XS3JpOW0zQmtOYmZ4MVovWTJKbnhySGNCUXZlVGVSMzQzQldaV1Q2?=
 =?utf-8?B?Wmtidit5N3IrUzYva3ZzOTJaZjlqSmllbTl1V1FuZGtuM0hFL2VJWUpiU2dT?=
 =?utf-8?B?WERsMWlKL0FQcVNSeDF3NFYraUd0SkN5MHNNbU5mYzMxb2UwdkQ0YnFDQ3U5?=
 =?utf-8?B?RHl6Wmg5d1czY2ZpaFBpUmErTzhCRlFBdnA1bkZ4WUZodEIwcVVwYURVODUy?=
 =?utf-8?B?NmR4TE9odTkzUEJaaklmMXB1d2I4Zm9acDJYdDFrQUpRRnBMUXg3QnVSV2li?=
 =?utf-8?B?SlMxempxN3Q3a3B2cDBOdjBkMHZLQzd3MHBnUVhiV3FTVHdNRXZrWTJjM0V3?=
 =?utf-8?B?Y0pQczd6WWdkN3g1Qm1aclZjUHcyRFZFZWZEdzNYRXA0T2M3bUFBTkI2K1Nn?=
 =?utf-8?B?N0dMSFE4MHJNWUo1VUEwVjE1emFlSkdxVDdNUVNtc3JINTBuaEZFdWoxMkE1?=
 =?utf-8?B?UjJ0U2xYcm05dlRLNTBrQjBGb2NBcXRKWkRyTktKYTdLbUJMOWRyaXRqTlhw?=
 =?utf-8?B?OTM0dmpmakdpc2J0WmdaVVd2TGF6aTlTbU1PcTB5Ky9NSnZtbGI2OVJjbVpW?=
 =?utf-8?B?S0VIdXNKb0oweUNnVTltWE5YOFREZE5UQUlhTVlmbVRmamRybkVYYTByZFh3?=
 =?utf-8?B?aWYvR202aVpzZUZjL0hzKy9pS2JnRWZjVGY2TkVFNHZGUzdGSEpwZWFpTFBE?=
 =?utf-8?B?Yi8wd0xXZjVGby9rMzRYQ0YyMjBtS1ZqVVJVVDVEeVRlTkloblBUMWJrVldR?=
 =?utf-8?B?WGdiVFpCQTl1TDI0UDN1M2RQWFVtYm5sTVYydXh5dURSRk5PUS9DQW1PRElF?=
 =?utf-8?B?WjFYcjJGaytyeHF3MWVLUWFCOUNRM3FPZHZTNjZTSWJJUFBEa1A3U1orcncr?=
 =?utf-8?B?bXJPUEJhT2xkUzhXRTcrTkdJOHc5TlhIcDB6dlkvNEcvRmZzd2pQWjNCd0hq?=
 =?utf-8?B?dVJlRWZiUGV1VVRoZDNqeGNteDhMRTRRZ2s2TjJmQTlvaWVVQlNaY0daNGdF?=
 =?utf-8?B?M2xoWHN5WUdTQVhwTXZVNTd1M2FhelpQcm8rVVVDUXZpUlhkTzlrYTZXYkdz?=
 =?utf-8?B?d0QwaDNUbmIrM1ZIM2lwR0Y3ekhwSHpwdnJtRDdsaDJQeDBvY2o3endaOEFH?=
 =?utf-8?B?Z1B3NFhTejRhak5xTUNPQk84OXJQcHNCbVk3YWZMTHpGdzIzTXVzUEVER25i?=
 =?utf-8?B?cWxVbFFEcU9wYWJiSjVMTnhsbU03USs0aW1WRFJIVi84a3c4Z0R5TnV2ajZW?=
 =?utf-8?B?ckp0TEJhSWh1bHZZeEJGajFqbkpDTUFsdnR3MEk4MExyc2N4UmdWa0tkWm5I?=
 =?utf-8?B?OHNQTnhZTXVSZTlPRWhFTTZSL0lNSjl1VGVlclJIK0h6NVNSYzBtZDl4Vm9R?=
 =?utf-8?B?dThGejc3U29HZ0NveitFTmk3ZkN4cHVZV2tLMzF0Z25EWnNESTAyajMvWjZu?=
 =?utf-8?B?dzhxN1ZyZERHVGZDZ3lETnpKdi9aSWt6ZTYxMWF0NGVnNk41eGpNYnNBZ1JE?=
 =?utf-8?B?OUViYzcyUUliNVd6Nmd3UzlqRkJKZm5IWFFZa2ZGNFdMTzhlKzRqTjh5TmR6?=
 =?utf-8?B?eE5KUDdybEtZVTVtSFJKV3puR1hVeXJHNFNjQ1E2ZGRRL0o1OTd5bW9PSHJP?=
 =?utf-8?B?cFhoZmMybTU5bjVhSWtqMXVLdHoyMTAwTHdnQk9tQWRUeThJLzhjbXR4TG1j?=
 =?utf-8?B?TE9qYWVWUVBlVXM4bkVjQVRsK01uZlRyUityczEvbXZ3WFF5TldXaG5oZXY1?=
 =?utf-8?B?bjJJNVpDd0x2ZFdiU2c1OXY5UkE1L3VUQmUyMWx2MnVJVnQyR0lvS3lEczZO?=
 =?utf-8?B?akdPNGRLNG1rWURCVEZ6RGJIZFBJUnZUVmF3MnZCS3JoMWtyVlBKc01kcXht?=
 =?utf-8?B?RnRCbE81MVc5MXZOR3JyVllSeXZvdlFVNkxIQXBkTlY1YmtVa0JWN0dUZHlK?=
 =?utf-8?B?NmNKOTN2UFNmYUFWUGJEWlNyeC9VV3lXM3AzdWhCMG5Gc25sdGZWVHYrNkJP?=
 =?utf-8?B?U2lRNjNuUXVlVmEzUjEwMEFrNVhTdFpJSDFNSkw1ZXBad2xNYVFaYlQ2bHRi?=
 =?utf-8?Q?+/bb4Y1Ob7cQr90omv6MZ3vj52LJ7Vz3o9k6qTLXSQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 234b0a40-c250-43f5-603e-08dc3ee5da06
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 20:33:30.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWpQDxTZoW6rSbrqr3JLXSbP3w2eRZJH3zX2nIvB0FRfT6XJW7apbxciqF2O/9g5f0GXOPWuZ6c/SFvFLV9ShRsjJsvqqMORuh4r49MUqtXJbM0X30hr2pcaYGb9fzt5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1607
X-OriginatorOrg: aisec.fraunhofer.de

Configuring ipvs in a non-initial user namespace using the genl
netlink interface, e.g., by 'ipvsadm' is currently resulting in an
'-EPERM'. This is due to the use of GENL_ADMIN_PERM flag in
'ip_vs_ctl.c'.

Similarly to other genl interfaces, we switch to the use of
GENL_UNS_ADMIN_PERM flag which allows connection from non-initial
user namespace. Thus, it would be feasible to configure ipvs using
the genl interface also from within an unprivileged system container.

Since adding of new services and new dests are triggered from
userspace, accounting for the corresponding memory allocations in
ip_vs_new_dest() and ip_vs_add_service() is activated.

We tested this by simply running some samples from "man ipvsadm"
within an unprivileged user namespaced system container in GyroidOS.
Further, we successfully passed an adapted version of the ipvs
selftest in 'tools/testing/selftests/netfilter/ipvs.sh' using
preliminary created network namespaces from unprivileged GyroidOS
containers.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 36 +++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 143a341bbc0a..d39120c64207 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1080,7 +1080,7 @@ ip_vs_new_dest(struct ip_vs_service *svc, struct ip_vs_dest_user_kern *udest)
 			return -EINVAL;
 	}
 
-	dest = kzalloc(sizeof(struct ip_vs_dest), GFP_KERNEL);
+	dest = kzalloc(sizeof(struct ip_vs_dest), GFP_KERNEL_ACCOUNT);
 	if (dest == NULL)
 		return -ENOMEM;
 
@@ -1421,7 +1421,7 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 		ret_hooks = ret;
 	}
 
-	svc = kzalloc(sizeof(struct ip_vs_service), GFP_KERNEL);
+	svc = kzalloc(sizeof(struct ip_vs_service), GFP_KERNEL_ACCOUNT);
 	if (svc == NULL) {
 		IP_VS_DBG(1, "%s(): no memory\n", __func__);
 		ret = -ENOMEM;
@@ -4139,98 +4139,98 @@ static const struct genl_small_ops ip_vs_genl_ops[] = {
 	{
 		.cmd	= IPVS_CMD_NEW_SERVICE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags	= GENL_ADMIN_PERM,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= ip_vs_genl_set_cmd,
 	},
 	{
 		.cmd	= IPVS_CMD_SET_SERVICE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags	= GENL_ADMIN_PERM,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= ip_vs_genl_set_cmd,
 	},
 	{
 		.cmd	= IPVS_CMD_DEL_SERVICE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags	= GENL_ADMIN_PERM,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= ip_vs_genl_set_cmd,
 	},
 	{
 		.cmd	= IPVS_CMD_GET_SERVICE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags	= GENL_ADMIN_PERM,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= ip_vs_genl_get_cmd,
 		.dumpit	= ip_vs_genl_dump_services,
 	},
 	{
 		.cmd	= IPVS_CMD_NEW_DEST,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags	= GENL_ADMIN_PERM,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= ip_vs_genl_set_cmd,
 	},
 	{
 		.cmd	= IPVS_CMD_SET_DEST,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags	= GENL_ADMIN_PERM,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= ip_vs_genl_set_cmd,
 	},
 	{
 		.cmd	= IPVS_CMD_DEL_DEST,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags	= GENL_ADMIN_PERM,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= ip_vs_genl_set_cmd,
 	},
 	{
 		.cmd	= IPVS_CMD_GET_DEST,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags	= GENL_ADMIN_PERM,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.dumpit	= ip_vs_genl_dump_dests,
 	},
 	{
 		.cmd	= IPVS_CMD_NEW_DAEMON,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags	= GENL_ADMIN_PERM,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= ip_vs_genl_set_daemon,
 	},
 	{
 		.cmd	= IPVS_CMD_DEL_DAEMON,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags	= GENL_ADMIN_PERM,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= ip_vs_genl_set_daemon,
 	},
 	{
 		.cmd	= IPVS_CMD_GET_DAEMON,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags	= GENL_ADMIN_PERM,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.dumpit	= ip_vs_genl_dump_daemons,
 	},
 	{
 		.cmd	= IPVS_CMD_SET_CONFIG,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags	= GENL_ADMIN_PERM,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= ip_vs_genl_set_cmd,
 	},
 	{
 		.cmd	= IPVS_CMD_GET_CONFIG,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags	= GENL_ADMIN_PERM,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= ip_vs_genl_get_cmd,
 	},
 	{
 		.cmd	= IPVS_CMD_GET_INFO,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags	= GENL_ADMIN_PERM,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= ip_vs_genl_get_cmd,
 	},
 	{
 		.cmd	= IPVS_CMD_ZERO,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags	= GENL_ADMIN_PERM,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= ip_vs_genl_set_cmd,
 	},
 	{
 		.cmd	= IPVS_CMD_FLUSH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.flags	= GENL_ADMIN_PERM,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= ip_vs_genl_set_cmd,
 	},
 };
-- 
2.39.2


