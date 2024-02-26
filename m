Return-Path: <linux-kernel+bounces-80604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BD6866A42
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC931C218C1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC041BC5E;
	Mon, 26 Feb 2024 06:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=elektrobit.com header.i=@elektrobit.com header.b="Lz4tuZIt";
	dkim=pass (1024-bit key) header.d=elektrobit.com header.i=@elektrobit.com header.b="Lz4tuZIt"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2127.outbound.protection.outlook.com [40.107.95.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC99179B2;
	Mon, 26 Feb 2024 06:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.127
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708930079; cv=fail; b=ZgrDNXHZJazfi79nafiacGhngqRFQyhBwf6rX1XhvCY2HpPf7Z5HZr46mzFNnuSZ+4kqsXA9pQc9rR1k5FXsVeJX4Yue2KOraUiXfi82naApoRwn23/tx3q+cVkCchJYKnSmG/5Nq397NM5OSVX9WC2dvqrJnLBjneGy+Boywcw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708930079; c=relaxed/simple;
	bh=giAfVprPp1OG8ZSg2t6ixjS8v0Q5jWceVToyHEc4XJI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lj50/bvWIdY2eJLuagMP+KV9/m2bY4WzQcLTvcsnG2WTPEKgYdyLwOBosWdirTHNsr8cNe8rSmJyuF0Kr61/Ej94tIampOjJajy8qOFw+XWKOSzw3pDTRuS/CAsyN7ZyFG+PtVZRHrKjUKSzFtI+3TsC4R9gmNFJTFH/+Dqci2I=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elektrobit.com; spf=pass smtp.mailfrom=elektrobit.com; dkim=pass (1024-bit key) header.d=elektrobit.com header.i=@elektrobit.com header.b=Lz4tuZIt; dkim=pass (1024-bit key) header.d=elektrobit.com header.i=@elektrobit.com header.b=Lz4tuZIt; arc=fail smtp.client-ip=40.107.95.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elektrobit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elektrobit.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=RVfuX1Ew44kFDPx6zx5VEXyqAcelBKKL11Akfj0OtCgd0jdJiqdlB2+eoPBPei36RihD12k31w4QPAhmACPD+hEkU2h8J5aMex+fapqAkn6ZoYfZQFM+mlGcoaCBb+WEcxFfDYfO1pTBl1ZSO+23+TiViVfniM76WSqbD3T0qLIEIAwKJoO3g/4Ld7ojpXAn4yc5Ls4lRUaYJzyDprtvNAK0Lm8JqWFZnzVQtVBX1wuvlmIIgTdjiNYL7hFcQquVRYnfZ1iJ6stcXmTjvJKfJbeICQNTXM9Ceh3BQQ7N5Ady8Z4ot7JWwXyHIRhX8va01hKp/o4+56Rk9634nDlX7A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giAfVprPp1OG8ZSg2t6ixjS8v0Q5jWceVToyHEc4XJI=;
 b=cGSP9nNPI5qktMRWGeztwJVYjLsSfF1TTw4KGoltaUQR3sHidH+WUbqtfsjIqGWx+bGMSvCpy2goCHYmONfPjerLK+jzxJAJtW44HkY9q+I6na99PJwX312GZtmJk+ZMkiG/8jyAJiqmMwqd1DQXdx5x5WRp9OIvyyTI+Xni0CF/gD5dwUaob/uRZniMHU3FDgwpc/Luo5dW7TVrYd46Tu6hBmCVvp9aNsw6BU1fxQnwjNw9sCd7vKAJVZI8fA9BBHu+bhbdHNny3GqXO4vtpkA6ITtLs4eDXuOi7beJmC7v+7BKSD1ggpvDwvZ6ZoCB8N67n/fbatPldZO6wFXckg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.79.107.243) smtp.rcpttodomain=gmail.com smtp.mailfrom=elektrobit.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=elektrobit.com; dkim=pass (signature was verified)
 header.d=elektrobit.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=elektrobit.com] dkim=[1,1,header.d=elektrobit.com]
 dmarc=[1,1,header.from=elektrobit.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elektrobit.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giAfVprPp1OG8ZSg2t6ixjS8v0Q5jWceVToyHEc4XJI=;
 b=Lz4tuZItuM5GmBV27xkY6SE9gFvXD1HnBCkHxj8mahHwjja3SfFHkcKCqX+tNza5BXtHM1HfFDiNTsGDRyL2Khf07TFVnaCgPPKr9gQ2g5vTlz5xLyyUmx152L2kZ4g3JymteUkcagFFEeB73aKkmrIfVt40lQ+ZAntCpfB6JLA=
Received: from MW4PR03CA0198.namprd03.prod.outlook.com (2603:10b6:303:b8::23)
 by LV3PR08MB9402.namprd08.prod.outlook.com (2603:10b6:408:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 06:47:54 +0000
Received: from MW2NAM12FT045.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::83) by MW4PR03CA0198.outlook.office365.com
 (2603:10b6:303:b8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 06:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.79.107.243)
 smtp.mailfrom=elektrobit.com; dkim=pass (signature was verified)
 header.d=elektrobit.com;dmarc=pass action=none header.from=elektrobit.com;
Received-SPF: Pass (protection.outlook.com: domain of elektrobit.com
 designates 4.79.107.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.79.107.243; helo=usbth1es003.ebgroup.elektrobit.com; pr=C
Received: from usbth1es003.ebgroup.elektrobit.com (4.79.107.243) by
 MW2NAM12FT045.mail.protection.outlook.com (10.13.181.12) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7339.23 via
 Frontend Transport; Mon, 26 Feb 2024 06:47:53 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by usbth1es003.ebgroup.elektrobit.com (Postfix) with ESMTPS;
	Sun, 25 Feb 2024 22:47:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXSnMW69PO0rv3ucCt/ZpsuIIPRcXz6nqqyCioaXiESdKHVk4WeE4hDvgExIM+BEbvWTKhrBv9GCwI7qmm3dMz63VV8OlF5h287dnX9rUcw0V6lvSDFX/Sp0rZqpScyv5A0R7mIy1hl5wIatGO0vQqN2yoknTyjIdthmEVqoVXLNrTYVtw3x4nyIkLB20108j4yoJ0GPHq284NGwA51DZhGF/paJkybH5vF62g6KxJqsv/spKLIMK1T0x47t+9gx42vuWl+IpJhFOcx3WAastgS9TxNt0Ni6Kn9RzytzAdKnKTXlzTAtiYH8ohU/YEK9g9g0KPfplSubVHYji8LVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giAfVprPp1OG8ZSg2t6ixjS8v0Q5jWceVToyHEc4XJI=;
 b=JuYX/bZ5Y/iQttPhhTGiNBbdjdljw12IH6P5mB/1BMCYEeVZHLho4ldXc7rPguTEpswZkAIzt95pM7yP/7TLFRaxNtaizcmq3x1pWA6pdPYCuYl7yB2v1xEFRag4ku7DqlIbxaUr4H7fvT6gyJTWMwKZtRBt1YQxbLsB+dBgcBMnJn09IivDrMukZcIKBZ7zQ5USQOpq0QPqldcQULkExuwRAfdI4I5wj3G8NrWJ+4CKA2Ga/bJ6jUmX8qZb134k2wKxlU7D8kDGBtuHY/sJwCY8Dqaxm6s9JuHLWhg+k3Lw2cMkOkzyRHP9UUQWokVs7i9pKCxbnVNuBwU5Yu9+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=elektrobit.com; dmarc=pass action=none
 header.from=elektrobit.com; dkim=pass header.d=elektrobit.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elektrobit.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giAfVprPp1OG8ZSg2t6ixjS8v0Q5jWceVToyHEc4XJI=;
 b=Lz4tuZItuM5GmBV27xkY6SE9gFvXD1HnBCkHxj8mahHwjja3SfFHkcKCqX+tNza5BXtHM1HfFDiNTsGDRyL2Khf07TFVnaCgPPKr9gQ2g5vTlz5xLyyUmx152L2kZ4g3JymteUkcagFFEeB73aKkmrIfVt40lQ+ZAntCpfB6JLA=
Received: from PAXP195MB1231.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:1a3::10)
 by PRAP195MB1579.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:298::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Mon, 26 Feb
 2024 06:47:48 +0000
Received: from PAXP195MB1231.EURP195.PROD.OUTLOOK.COM
 ([fe80::dd67:dab1:27ba:981a]) by PAXP195MB1231.EURP195.PROD.OUTLOOK.COM
 ([fe80::dd67:dab1:27ba:981a%6]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 06:47:48 +0000
From: =?utf-8?B?V2Vpw58sIFNpbW9uZQ==?= <Simone.Weiss@elektrobit.com>
To: "mpatocka@redhat.com" <mpatocka@redhat.com>
CC: "song@kernel.org" <song@kernel.org>, "Tomerius, Kai"
	<Kai.Tomerius@elektrobit.com>, "simone.p.weiss@posteo.net"
	<simone.p.weiss@posteo.net>, "agk@redhat.com" <agk@redhat.com>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yukuai3@huawei.com" <yukuai3@huawei.com>, "lukas.bulwahn@gmail.com"
	<lukas.bulwahn@gmail.com>, "snitzer@kernel.org" <snitzer@kernel.org>
Subject: Re: [PATCH] [RFQ] dm-integrity: Add a lazy commit mode for journal
Thread-Topic: [PATCH] [RFQ] dm-integrity: Add a lazy commit mode for journal
Thread-Index: AQHaW43LYOGlNHnfu0CczaL+NCYlN7ETpNcAgASmmYCAACyogIAD0DUA
Date: Mon, 26 Feb 2024 06:47:48 +0000
Message-ID: <a0ff2007f08b7a55e3aa58f1cac2b9314559f598.camel@elektrobit.com>
References: <20240209192542.449367-1-simone.weiss@elektrobit.com>
	 <8a485b9-6dbb-78c-9a84-ed3ba65d9cb3@redhat.com>
	 <3e5a2087667333bb88135a6b6f9620201989605f.camel@elektrobit.com>
	 <9788e2a-8a61-3c76-e11e-a3f23b4d90c8@redhat.com>
In-Reply-To: <9788e2a-8a61-3c76-e11e-a3f23b4d90c8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=elektrobit.com;
x-ms-traffictypediagnostic:
	PAXP195MB1231:EE_|PRAP195MB1579:EE_|MW2NAM12FT045:EE_|LV3PR08MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4a8e8e-371e-4778-e022-08dc3696dba7
X-SM-outgoing: yes
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 InOwppJJFOSyGOcJftIKHVHxdtWxTCqZ0Cb+990PQcuE7KFOVWg0MRQMIswZ9w2fc60Tclc/p09agejrb9FEi2BSMcuNtEAIihZyFDUrEylIkdQAomfbCtmlZsu7mnlU0W36BQgv7O6ubBoFDcjAXfxM4v5EHdD8sYqEq5Z5EoPTlRm6dNvuYRVa7yHtxxrCOLUZYh6rRTxCZZfk1/F+bEZ/YEcqJg4BwjSF9M98dhmeWIHnfcY+gYlGSTTCLM93Jy711waKBsrTx1444xNspKwOfaone9zJbUJtr9o7lwLD6TYld85dDJp/35Aiy5tACP/233QTH1GsVhkveghvw+J96+uSYff+gTEbgXdYlxPgHirAwerBqQTQgYcSh+Qdutk4AE25BW9oa2VGNCkLnXwAQVkKlQ8K2uU33pg/Md+LpTTzMgs6Imle+1FRWDx/drKYTL3VIHrYL6UNZfFmLivwXdzprs6oBOMIidQcYsOM7gyehtUUW1bFg5Y6ve7jm6VfvEWWbqYMyVZ5Qvfg6kwkxrM4kO3nQnIEq7Wgv9mu0h/Rr5HQFE0ag+1fWK9eqpgybocA2j57StGxwiIvhFeiXmHH4uh7Wexzg7K/A24L4tI1UeL3jocjfwMmAuVnIiij6yv8W/EPfJWuM7m1xCEFmn0kZ8/OwsFMgtKONbiWUwdgHftsts4ZVb9bvfTu7CFnTZ3VOVcoA7GXsYNBD2ih93ilID9bWFHGzNDhkic5TTaEtmQLdKCiD/KjgpfB
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXP195MB1231.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009)(1580799018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E2755F3CE075E4F9BE07DDCEBCC882F@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 1EXZqBF4DACw287ab1Ysmcg+ryrILpLM4OxE1z7dyZrOmUe1r6GCCtoPw0BRmmI1zftnPlBgi/YoZQmuKxKj8Dst9IZlbtHL0k9ktXKNZLhXuD5ytEDfcRCljP7LetyoZWD8mWFQIyTykY2D9LzsNL5nkHvDeC7JWVZvNJTx+7h1eOUkJJ7jTgJCh3DNz0MLHVBCk2hKuyrvJl89c39hbryM2dzAgAF14iqbUdGLfC+4HgYyYp7ATb7w3OIOhXSgV3s5rBFtjpryjDQnkuKhojHM/Bj/SYyRWsh9H2GckyVnf335nzvzomhr+URRF2G5K3xr2TA2j0yWF1MALmTTjnkN+SXPGfsKwdw4L76HswPuVTGaWVO0r9mdtmC7JKiCQR+TgNDduPi3tVHBelodJsr+yBihEY4KjhywIc8euII3jtRXjQa3LuB/xffWi0bmPvuICRwPM4LfIHQVoS3Jf0IxP8dQuGeUbwpd4lZZJY8dUibwxBxz1k45aH3waN1rELwlLiRpa5WOrb+Wdyhjcr+fl4fLHCOBY4BSxxnbmtWrH84Z7LUY99BvstNJcdcKzkdb2qGtMBojY5tFx6HqogUy4dNuvmfgT7NP4KaSq4IiYcDCCqDj6ueereXYy0oceG1BuAV+fxYlsb20ClptaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP195MB1579
X-SM-smarthost: [elektrobit-com.mail.protection.outlook.com]
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MW2NAM12FT045.eop-nam12.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9d9f682a-3edb-4784-754d-08dc3696d84c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/fr7SuPwcyfoJv5M9+wcMMorB8rMTQoljTKA8H3BKDtSgGZmWDgtZBirx1w/GCNbw9KpPlVbm3y9EzFuBTVhqfXGj1KwyOjywx3F8ZbxgLMkLWQUdewH8qDsz5ckKtNC/D+AYV+Cbi6uzxLY8KMzzE8TUGKPHnajr7Na1+QTr7lY8BoSZcJT1JplA40RQw2J/zCpKOEFsiUtMUM+zWpcHtWwxJmGYm9XeU5MBaVSgU5Per261Q01vztBZDUUgm3nJnJn8lUshCI3OxQuhSFxTnlQMS2GblhwieTi9G0GJ+zeRr7tDdoa5OU7ap8MyoVMOEM0ERBGIpRCO6SFtq5S+OAjDez6PcAxr1TnB88DCl0+KXvQAAzN8oJgtzUo0UClkiyaoEyokQFr8eUXCZXuZRnEM+OX6NqR7SLDPNaNl8TK3ypyP4mLemXEE6x0HUjdDWpP6TggDEqT5H2OMQ8unbWvDt2EJiB3K115xjj9yGsrJceN60fl9kvQl1vYuk3Z1qQFjPfZxDhv2G3TA/md4fiuWW7fGAuwVsfb+494qrqDHaQuncCofFWT0Azuipd+Pm7JnNrKerQRMkgCMW8oeRcxzlICdE5qcwABwatl1BfeHgbqc0tdDFjFrM2iZRQNb1ejzXq2kuJhy31F+ng8vuc26N1ipcR/ra62+XwO6+M8sU4CH6KWu1yZk8eA+CPGNH/aWR0q8LGS6cMSV0h8C5WUv8lD2XpeNpq5gc8VQA5a84Z297YYOsxepLjAw7zgOcLQGvdTzH+k3ZSL3RyJlR5EVtxlge8cr5tzzz3+I8k=
X-Forefront-Antispam-Report:
	CIP:4.79.107.243;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:usbth1es003.ebgroup.elektrobit.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(230273577357003)(36860700004)(1580799018);DIR:OUT;SFP:1102;
X-OriginatorOrg: elektrobit.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 06:47:53.7036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4a8e8e-371e-4778-e022-08dc3696dba7
X-MS-Exchange-CrossTenant-Id: e764c36b-012e-4216-910d-8fd16283182d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e764c36b-012e-4216-910d-8fd16283182d;Ip=[4.79.107.243];Helo=[usbth1es003.ebgroup.elektrobit.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2NAM12FT045.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR08MB9402

T24gRnJpLCAyMDI0LTAyLTIzIGF0IDIxOjMzICswMTAwLCBNaWt1bGFzIFBhdG9ja2Egd3JvdGU6
DQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIEVs
ZWt0cm9iaXQgb3JnYW5pemF0aW9uLiBEbw0KPiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93DQo+IHRoZSBj
b250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gT24gRnJpLCAyMyBGZWIgMjAyNCwgV2Vpw58sIFNp
bW9uZSB3cm90ZToNCj4gDQo+ID4gT24gVHVlLCAyMDI0LTAyLTIwIGF0IDE5OjUyICswMTAwLCBN
aWt1bGFzIFBhdG9ja2Egd3JvdGU6DQo+ID4gPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0
ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBFbGVrdHJvYml0DQo+ID4gPiBvcmdhbml6YXRpb24uIERv
DQo+ID4gPiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJl
Y29nbml6ZSB0aGUgc2VuZGVyIGFuZA0KPiA+ID4ga25vdw0KPiA+ID4gdGhlIGNvbnRlbnQgaXMg
c2FmZS4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBPbiBGcmksIDkgRmViIDIwMjQsIFNpbW9uZSBX
ZWnDnyB3cm90ZToNCj4gPiA+IA0KPiA+ID4gPiBFeHRlbmQgdGhlIGRtLWludGVncml0eSBkcml2
ZXIgdG8gb21pdCB3cml0aW5nIHVudXNlZCBqb3VybmFsIGRhdGENCj4gPiA+ID4gc2VjdG9ycy4N
Cj4gPiA+ID4gSW5zdGVhZCBvZiBmaWxsaW5nIHVwIHRoZSB3aG9sZSBqb3VybmFsIHNlY3Rpb24s
IG1hcmsgdGhlIGxhc3QgdXNlZA0KPiA+ID4gPiBzZWN0b3Igd2l0aCBhIHNwZWNpYWwgY29tbWl0
IElELiBUaGUgY29tbWl0IElEIHN0aWxsIHVzZXMgdGhlIHNhbWUgYmFzZQ0KPiA+ID4gPiB2YWx1
ZSwNCj4gPiA+ID4gYnV0IHNlY3Rpb24gbnVtYmVyIGFuZCBzZWN0b3IgbnVtYmVyIGFyZSBpbnZl
cnRlZC4gQXQgcmVwbGF5IHdoZW4gY29tbWl0DQo+ID4gPiA+IElEcw0KPiA+ID4gPiBhcmUgYW5h
bHl6ZWQgdGhpcyBzcGVjaWFsIGNvbW1pdCBJRCBpcyBkZXRlY3RlZCBhcyBlbmQgb2YgdmFsaWQg
ZGF0YSBmb3INCj4gPiA+ID4gdGhpcw0KPiA+ID4gPiBzZWN0aW9uLiBUaGUgbWFpbiBnb2FsIGlz
IHRvIHByb2xvbmcgdGhlIGxpdmUgdGltZXMgb2YgZS5nLiBlTU1DcyBieQ0KPiA+ID4gPiBhdm9p
ZGluZw0KPiA+ID4gPiB0byB3cml0ZSB0aGUgd2hvbGUgam91cm5hbCBkYXRhIHNlY3RvcnMuDQo+
ID4gPiA+IA0KPiA+ID4gPiBUaGUgY2hhbmdlIGlzIHJpZ2h0IG5vdyB0byBiZSBzZWVuIGFzIGV4
cGVyaW1lbnRhbCBhbmQgZ2V0cyBhcHBsaWVkIGlmDQo+ID4gPiA+IENPTkZJR19ETUlOVF9MQVpZ
X0NPTU1JVCBpcyBzZXQgdG8geS4gTm90ZSBwbGVhc2UgdGhhdCB0aGlzIGlzIE5PVA0KPiA+ID4g
PiBwbGFubmVkIGZvciBhIGZpbmFsIHZlcnNpb24gb2YgdGhlIGNoYW5nZXMuIEkgd291bGQgbWFr
ZSBpdCBjb25maWd1cmFibGUNCj4gPiA+ID4gdmlhIGZsYWdzIHBhc3NlZCBlLmcuIHZpYSBkbXNl
dHVwIGFuZCBzdG9yZWQgaW4gdGhlIHN1cGVyYmxvY2suDQo+ID4gPiA+IA0KPiA+ID4gPiBBcmNo
aXRlY3R1cmFsIExpbWl0YXRpb25zOg0KPiA+ID4gPiAtIEEgZG0taW50ZWdyaXR5IHBhcnRpdGlv
biwgdGhhdCB3YXMgcHJldmlvdXNseSB1c2VkIHdpdGggbGF6eSBjb21taXQsDQo+ID4gPiA+IMKg
Y2FuJ3QgYmUgcmVwbGF5ZWQgd2l0aCBhIGRtLWludGVncml0eSBkcml2ZXIgbm90IHVzaW5nIGxh
enkgY29tbWl0Lg0KPiA+ID4gPiAtIEEgZG0taW50ZWdyaXR5IGRyaXZlciB0aGF0IHVzZXMgbGF6
eSBjb21taXQgaXMgZXhwZWN0ZWQNCj4gPiA+ID4gwqB0byBiZSBhYmxlIHRvIGNvcGUgd2l0aCBh
IHBhcnRpdGlvbiB0aGF0IHdhcyBjcmVhdGVkIGFuZCB1c2VkIHdpdGhvdXQNCj4gPiA+ID4gwqBs
YXp5IGNvbW1pdC4NCj4gPiA+ID4gLSBXaXRoIGRtLWludGVncml0eSBsYXp5IGNvbW1pdCwgYSBw
YXJ0aWFsbHkgd3JpdHRlbiBqb3VybmFsIChlLmcuIGR1ZQ0KPiA+ID4gPiB0byBhDQo+ID4gPiA+
IMKgcG93ZXIgY3V0KSBjYW4gY2F1c2UgYSB0YWcgbWlzbWF0Y2ggZHVyaW5nIHJlcGxheSBpZiB0
aGUgam91cm5hbCBlbnRyeQ0KPiA+ID4gPiBtYXJraW5nDQo+ID4gPiA+IMKgdGhlIGVuZCBvZiB0
aGUgam91cm5hbCBzZWN0aW9uIGlzIG1pc3NpbmcuIER1ZSB0byBsYXp5IGNvbW1pdCwgb2xkZXIN
Cj4gPiA+ID4gam91cm5hbA0KPiA+ID4gPiDCoGVudHJpZXMgYXJlIG5vdCBlcmFzZWQgYW5kIG1p
Z2h0IGJlIHByb2Nlc3NlZCBpZiB0aGV5IGhhdmUgdGhlIHNhbWUNCj4gPiA+ID4gY29tbWl0DQo+
ID4gPiA+IElEDQo+ID4gPiA+IMKgYXMgYWRqYWNlbnQgbmV3ZXIgam91cm5hbCBlbnRyaWVzLg0K
PiA+ID4gDQo+ID4gPiBIaQ0KPiA+ID4gDQo+ID4gPiBJIHdhcyB0aGlua2luZyBhYm91dCBpdCBh
bmQgSSB0aGluayB0aGF0IHRoaXMgcHJvYmxlbSBpcyBhIHNob3dzdG9wcGVyLg0KPiA+ID4gDQo+
ID4gPiBTdXBwb3NlIHRoYXQgYSBqb3VybmFsIHNlY3Rpb24gY29udGFpbnMgdGhlc2UgY29tbWl0
IElEczoNCj4gPiA+IA0KPiA+ID4gwqDCoMKgwqDCoMKgwqAgMsKgwqDCoMKgwqDCoCAywqDCoMKg
wqDCoMKgIDLCoMKgwqDCoMKgwqAgMihFT0YpwqAgM8KgwqDCoMKgwqDCoCAzwqDCoMKgwqDCoMKg
IDPCoMKgwqDCoMKgwqAgMw0KPiA+ID4gDQo+ID4gPiBUaGUgSURzICIzIiBhcmUgbGVmdCBvdmVy
IGZyb20gcHJldmlvdXMgaXRlcmF0aW9ucy4gVGhlIElEcyAiMiIgY29udGFpbg0KPiA+ID4gdGhl
IGN1cnJlbnQgZGF0YS4gQW5kIG5vdywgdGhlIGpvdXJuYWwgcm9sbHMgb3ZlciBhbmQgd2UgYXR0
ZW1wdCB0byB3cml0ZQ0KPiA+ID4gYWxsIDggcGFnZXMgd2l0aCB0aGUgSUQgIjMiLiBIb3dldmVy
LCBhIHBvd2VyIGZhaWx1cmUgaGFwcGVucyBhbmQgd2Ugb25seQ0KPiA+ID4gd3JpdGUgNCBwYWdl
cyB3aXRoIHRoZSBJRCAiMyIuIFNvLCB0aGUgam91cm5hbCB3aWxsIGxvb2sgbGlrZToNCj4gPiA+
IA0KPiA+ID4gwqDCoMKgwqDCoMKgwqAgMyhuZXcpwqAgMyhuZXcpwqAgMyhuZXcpwqAgMyhuZXcp
wqAgMyhvbGQpwqAgMyhvbGQpwqAgMyhvbGQpwqAgMyhvbGQpDQo+ID4gPiANCj4gPiA+IEFmdGVy
IGEgcmVib290LCB0aGUgam91cm5hbC1yZXBsYXkgbG9naWMgd2lsbCBmYWxzZWx5IGJlbGlldmUg
dGhhdCB0aGUNCj4gPiA+IHdob2xlIGpvdXJuYWwgc2VjdGlvbiBpcyBjb25zaXN0ZW50IGFuZCBp
dCB3aWxsIGF0dGVtcHQgdG8gcmVwbGF5IGl0Lg0KPiA+ID4gDQo+ID4gPiBUaGlzIGNvdWxkIGJl
IGZpeGVkIGJ5IGhhdmluZyBhbHdheXMgaW5jcmVhc2luZyBjb21taXQgSURzIC0gdGhlIGNvbW1p
dA0KPiA+ID4gSURzIGhhdmUgOCBieXRlcywgc28gd2UgY2FuIGFzc3VtZSB0aGF0IHRoZXkgbmV2
ZXIgcm9sbC1vdmVyIGFuZCBpdCB3b3VsZA0KPiA+ID4gcHJldmVudCB1cyBmcm9tIG1peGluZyBv
bGQgSURzIGludG8gdGhlIGN1cnJlbnQgdHJhbnNhY3Rpb24uDQo+ID4gSGkNCj4gPiANCj4gPiBU
aGFua3MgZm9yIHRoZSByZXZpZXcgb2YgdGhlIGNvbmNlcHQuIEkgd2FzIG91dCB0aGlzIHdlZWsg
YW5kIGNvdWxkIG9ubHkNCj4gPiB0aGluaw0KPiA+IGFib3V0IGl0IG5vdy4gSSB1bmRlcnN0b29k
IGl0IHJpZ2h0LCB0aGF0IHRoZSBwcm9wb3NhbCBpcyB0byBhZGQgYW4gZXh0cmENCj4gPiB2YWx1
ZQ0KPiA+IHRvIHRoZSBjb21taXQgSUQsIHRoYXQgaXMgZS5nLiBpbmNyZW1lbnRlZCB3aGVuIGlu
dGVncml0eV9jb21taXQgaXMNCj4gPiBleGVjdXRlZD8NCj4gPiANCj4gPiBJZiBzbywgSSB0cmll
ZCB0aGlzIHF1aWNrbHkgYW5kIGxvb2tzIGdvb2Qgb24gZmlyc3QgZ2xhbmNlLiBXaWxsIGNoZWNr
IGFuZA0KPiA+IHRlc3QNCj4gPiBmdXJ0aGVyIG5leHQuDQo+ID4gDQo+ID4gU2ltb25lDQo+IA0K
PiBJIHByb3Bvc2UgdG8gdXNlIHRoZSBjb21taXQgSUQgMCB3aGVuIHdyaXRpbmcgdGhlIGpvdXJu
YWwgZm9yIHRoZSBmaXJzdA0KPiB0aW1lLCB0aGVuIDEgd2hlbiB0aGUgam91cm5hbCByb2xscyBv
dmVyLCAyIHdoZW4gaXQgcm9sbHMgb3ZlciBhZ2FpbiwgMw0KPiB3aGVuIGl0IHJvbGxzIG92ZXIg
YWdhaW4sIDQgb24gYW5vdGhlciByb2xsIG92ZXIgYW5kIHNvIG9uIHVwIHRvDQo+IDB4N2ZmZmZm
ZmZmZmZmZmZmZiAod2hpY2ggd2lsbCBiZSBuZXZlciByZWFjaGVkIGluIHByYWN0aWNlKS4NCj4g
DQo+IEFuZCB1c2UgdGhlIHRvcCBiaXQgYXMgYW4gZW5kLW9mLXNlY3Rpb24gbWFya2VyLiBBcyB0
aGUgY29tbWl0IElEcyB3aWxsDQo+IG5ldmVyIHJvbGwgb3ZlciwgaXQgd29uJ3QgaGFwcGVuIHRo
YXQgYW4gb2xkIHRyYW5zYWN0aW9uIHdvdWxkIGJlIG1peGVkDQo+IGludG8gYSBuZXcgdHJhbnNh
Y3Rpb24gb24gcGFydGlhbCBqb3VybmFsIHdyaXRlLg0KPiANCj4gTWlrdWxhcw0KSGksDQoNCkkg
Y2FuIGRvIGl0IHRoaXMgd2F5IGZvciBzdXJlIGFzIHdlbGwuIEFub3RoZXIgcG9pbnQgc3RpbGwg
aW4gbXkgbWluZCBpcyB0aGUNCnN1cGVyYmxvY2s6IEkgd291bGQgbGlrZSB0byBnZXQgcmlkIG9m
IHRoZSBidWlsZCB0aW1lIHN3aXRjaCBhbmQgY2FycnkNCmluZm9ybWF0aW9uIGFib3V0IGxhenkg
Y29tbWl0cyBlbmFibGVkIGluIHRoZSBzdXBlcmJsb2NrLiBBcyB0aGVyZSBpcyBKLCBCLCBEDQph
bmQgUiBhcyBtb2RlIGFscmVhZHksIGEgbmV3IG1vZGUgTCBvciBzdWNoIGNvdWxkIGJlIGFkZGVk
LiBJIHdpbGwgd29yayBvbiB0aGlzDQphbmQgYWxzbyB0YWtlIGEgbG9vayBhdCBzdHVmZiBsaWtl
IGRtc2V0dXAgdG8gY2hlY2sgaWYgc29tZXRoaW5nIHdvdWxkIGJlIG5lZWRlZA0KdGhlcmUuIElm
IHRoZXJlIGFyZSBmdXJ0aGVyIHBvaW50cyBmb3Igbm93IG9uIGFueW9uZSdzIG1pbmQsIHBsZWFz
ZSB0ZWxsLg0KDQpCZXN0LA0KU2ltb25lDQo=

