Return-Path: <linux-kernel+bounces-35190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC002838D58
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B141C211FA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C465D753;
	Tue, 23 Jan 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="NAQEWx0U";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="NAQEWx0U"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E815C606;
	Tue, 23 Jan 2024 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706009061; cv=fail; b=vB6SIKFy8w3WeQmP0GhekKq7X0scAUx3Mqt8lhQA49XcHKBjPmE2Q6a6sVcS0w9A02YyVJD3C6kat7heXmsJyHXNHwI6xiNE3RhAfWaNWkZf/R1ipRZxEkfy1PpkoOjLJcOA7e6wx+J12AW4WKfjLWq1J5//1s/zfVa8p4oC+PE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706009061; c=relaxed/simple;
	bh=Bm0NynEH8WigxEJc3gHcBPGm3MP48fcZEgDhH1bCPwY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wwmz2aBQWRgwsfQDFrTjUZCC3uydM7yVGADmzYUrcyrE6AHdnX9xsPGKEpEEyNnuy15HmzpqZ0eG4sTP+k6ozOxZn8pWVuicCZnbHr9nJhOYg/2uvXChdaEtLDNQ7Osg4bASIF71Mgcf2Eoi03Rd2BD3yXr5TITSNwNj83sCVas=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=NAQEWx0U; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=NAQEWx0U; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=eYmIRxV+562rHezmWfhNroaS/7ypGTzmmgENkN+tQS/0BDN/t4YFU/GTHZQiWf/3IrDX1Z0IukRjwO6DU6vbnSO2QM36hFMzLNVPnaNgu+AHhtHWgHEiCmsMYYQroqbpdx3hJffF/XJQWwC7FbZQ6kK7eYSkt83kc11PC700wu4t3kA0+JMzCX7HMalgI+GCcCaL4uxelodzr+b2Pt6S4fE6pPk6BDIJy7onDmPy/8HBbxrmkqooxGMouSSonJphaa5uqEKU0asiXwdCBP+gkM7BYrIVdv3SjqhIgiNRernyQhU8MVHuhtrKz8IECQvHI/i6m8HIpclK0z3YpBYoLQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bm0NynEH8WigxEJc3gHcBPGm3MP48fcZEgDhH1bCPwY=;
 b=M9ECN9lnDkHvNxEV42f/K4hzKPa/WKkY1L8jM97ukvOdVS//qpLhJRHt6snB2U1QDCsFhlhT3sTUIBxjrouhvGYKFBeTGhXmbgzuC4BThk8ZqFeey1UGdF0IGtQiQmaklAiFCtF7oFbPlacPB+mt8wDy5KS1bRhBIIEeWtOz1S0XcD76S21w+GT0LM7jFR/BQnlCn9QEGl5URTxHz3VmWhT5fHAeu1nk97060HlDq+AuT90zLvJJb6jaKcFbGCXgENRMouu6rDmj6+onoMzZch++9FupQjRX9rHmC2jFd7XSVuCHzha4AdVuiqHw2Js6yIJA/eXq5LLHuWBVkRah5A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bm0NynEH8WigxEJc3gHcBPGm3MP48fcZEgDhH1bCPwY=;
 b=NAQEWx0Uv4CJ51rTR4xidpY9c+Fu9H2J85OvLcXazely4LKXRLJRz59a1aAKrcLkHDxnWEVg1BpcM54QsFjZai7lzjcmRzBUN4FPnxwGlms0i9aMdgyqGZf1lMpcebuJAAcY22w61vPyFlvz9avu21fpEH7h3sxOIG+N+BkxcRA=
Received: from AS9PR06CA0283.eurprd06.prod.outlook.com (2603:10a6:20b:45a::14)
 by AM7PR08MB5416.eurprd08.prod.outlook.com (2603:10a6:20b:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 11:24:14 +0000
Received: from AMS0EPF000001B2.eurprd05.prod.outlook.com
 (2603:10a6:20b:45a:cafe::b1) by AS9PR06CA0283.outlook.office365.com
 (2603:10a6:20b:45a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Tue, 23 Jan 2024 11:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001B2.mail.protection.outlook.com (10.167.16.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 11:24:13 +0000
Received: ("Tessian outbound 1076c872ecc6:v228"); Tue, 23 Jan 2024 11:24:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7df56149e631f592
X-CR-MTA-TID: 64aa7808
Received: from f23c22041451.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3E8A6DBA-AF50-4114-B024-7D5323BDD4C5.1;
	Tue, 23 Jan 2024 11:24:06 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f23c22041451.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 23 Jan 2024 11:24:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aM0bIBygkbSBQRj1JfW+nVCDKTP45JNAdX2HS2cLavvD/AgyYsbnzRcv/lbHruk4iaQVHKu2vd0rP2NaN8jOpT/PY2ZhEJ5deThcyF3bFlX9OljjGK0v1L3PThiYArM4nHtrcWvGwI2lWEO2td8EXF+25UR2aRxIA5o17ZEHwt5YWDJiWTJ8zdE/xSeXso1gVVur3ZY/BGWlT4z27cOlzBX4we+Y1mF67z0L365HPH3Iodcg69HlSw27e9GBMigd/8sxIxRmJSwnb80d4svzJvqVnDoJxQFACBMHW/mL50ybSOulhemHL2Iu0xOzZQhCaV/geozBhmJFHXHdhISjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bm0NynEH8WigxEJc3gHcBPGm3MP48fcZEgDhH1bCPwY=;
 b=AtR7OKluySJIz4MWx7FohwYqBYufAxojTgTwsCXARaf48egUZ01wXAZaydrO3hGNjfH6azadMbnuNUkfcM/MZW2gfFL7AcYSE7rZmGr3ots5O/+1/TdCPixapGpF+KQE/o8ElAMT/kESYuKRFLa1ebyhZBk7fCbSI1Ot3n/Yn49Wr3piadJGhHbC6TPFZc/Tonziippjh/ik1tCoBCIn4xkkK4nYzcgsXwX0eGoJP7UAHYienmkaS1TAtLmlaZLa/IJBuGH7pWPvVeoq6DJ0O4FyI1BpNbbyVBc3dhCx7TMjbCFyukbBmJvySpaz92iMwCMwqHXw9B6yY7jxBmIPkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bm0NynEH8WigxEJc3gHcBPGm3MP48fcZEgDhH1bCPwY=;
 b=NAQEWx0Uv4CJ51rTR4xidpY9c+Fu9H2J85OvLcXazely4LKXRLJRz59a1aAKrcLkHDxnWEVg1BpcM54QsFjZai7lzjcmRzBUN4FPnxwGlms0i9aMdgyqGZf1lMpcebuJAAcY22w61vPyFlvz9avu21fpEH7h3sxOIG+N+BkxcRA=
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com (2603:10a6:20b:350::15)
 by AS2PR08MB8950.eurprd08.prod.outlook.com (2603:10a6:20b:5f9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 11:24:04 +0000
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::bf90:87a7:c796:ce84]) by AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::bf90:87a7:c796:ce84%4]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 11:24:04 +0000
From: Ben Gainey <Ben.Gainey@arm.com>
To: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, Mark Rutland
	<Mark.Rutland@arm.com>, "will@kernel.org" <will@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH 1/1] tools: perf: Expose sample ID / stream ID to python
 scripts
Thread-Topic: [PATCH 1/1] tools: perf: Expose sample ID / stream ID to python
 scripts
Thread-Index: AQHaTed0q4gkNrQV5kSxj23aVfx+e7DnPCeAgAAFYIA=
Date: Tue, 23 Jan 2024 11:24:04 +0000
Message-ID: <5c04369faf89ce1d1e3deb497199f8b1014cfd81.camel@arm.com>
References: <20240123103137.1890779-1-ben.gainey@arm.com>
	 <20240123103137.1890779-2-ben.gainey@arm.com>
	 <8568a3c6-00c9-4801-b710-e70cc06e021b@intel.com>
In-Reply-To: <8568a3c6-00c9-4801-b710-e70cc06e021b@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS8PR08MB6646:EE_|AS2PR08MB8950:EE_|AMS0EPF000001B2:EE_|AM7PR08MB5416:EE_
X-MS-Office365-Filtering-Correlation-Id: b78a91cb-e138-415d-8cad-08dc1c05d40d
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 Taozn1JSP1mSWpzwgoJut4RODKC7CF15JPm7jj1QR/K4QZz0VY1XhD9vohSGEgUk5AX95FkIM2wIpjvCgjWglXZYyC88Sy3QpKDjN7yUSmeI4gmC4CCMLPorqPQGHF1Oiq/NpatFsESSwtgrHA5PhFVLVuX5F1c6R4f430uyYixWz7R1opjv5MJPRiWM8jns2ZHQ6wGn4qm/w9LjD+UIQNefUmmkB14uMWSIdRN/VEZS7v0zTRwEndh8pTguLsQQKzcWh7ugaT09EEw9lgcmB0h2ipOB+phH7DBKwcdfwpotX2vjSAHoDuHfdWff8mgvBT9kiXPsLWXSw/qAQe4lJfleVmTrLqm/Gm+YKCXRykM4N43NkesS+T1hg/AnDzut/ao0nSW/fx8bQOMhudTglTSKd3XJWsDGV0wkhWbIgO+dasJRmRCc4uPNEuGgAxhgTe1rJ4owoKeT6YOwIEnSqby4DzJTP1IbZwL0avO/0vbZcS4D1fviPpy5LK3lqMDCG2riZcNLfgbe1AqA3iUV3ICy4GRl6r6tFwGueWpGfpSOvR47k4fojFdHTXzy1LOCUNLBF6Xztcqf+VlUQgsk4J5ofyzZjXWl13kXZb2i9w06HhqPQbzC0cEiWFXBvb/S
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6646.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(91956017)(36756003)(86362001)(38070700009)(122000001)(41300700001)(6512007)(38100700002)(2616005)(26005)(6486002)(53546011)(6506007)(2906002)(478600001)(76116006)(66946007)(110136005)(316002)(71200400001)(66556008)(66476007)(66446008)(64756008)(54906003)(4326008)(8676002)(8936002)(7416002)(5660300002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD821E980574D94BA55BEF5D5849427D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8950
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B2.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0ada20c0-8a00-4896-67e9-08dc1c05ce60
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y+LhV199vHSY00Bktia8tOlv9mWRuT/hajmZQ64WdZV+Hk2nYGE3x7+JHwGbozIBFBvRXXlt4dpttf8UryMgySti+M+kBYHMnLXcUp8mUt0JsPaEiz4/ivcL9hKN40COOY8Kf6B6V4tYsvm5BRCKGGK2SbzQOuw/NPJ1o4FKhKb8BeO/JsAwpdCZkN8+Y0ElysOVjsBku0QMo033MEyuvihYoPFmWFLZHaOkzyQw4/Zt/nNJm5LB70ugQjnwNK8P+T6DAVsoO5jZ1xgbKZddwqMPr7//7kIQl4z8US4vRDPb9GjyIupsSoxZ8avxKsOkOwVa1Z4BrhZCdH2y6M/Byrxjrw9nxE2a6kCIwLWnlj13AXwLBajCnXm4MoYZIeAW9sbKy8jiNxyoSI/qZ9K/LXyA7LTgdGwgp9dXjQ1xhLaI3UZWajO0BXWZBfz6ZvIEdEzuUmw/M40pkpB4rHvsSEwYuSzkO8f9UqGQk3oQKaM2NLAe43BhdoAGqIPkMskB0kNXsWnm+xR0gec4TY6JVS7LDpXeq9nN4BStfHsg/9OlU2lcL4sMF/YHcuFMIDV1jnG4F87SdmjLSrLMoR4rbY1U1eSWkApN/fhpkdCcI4AAew7qJlm0lbBYBY5mbXHXGnojVVPQ5rrbUl29cEmDMe9qc5BaXXrymseZLctzpQnkZvMxILQfmyHPv9s3bZiA9+GbedLrTJuh/jUnYcVTUAy8qBdnNm2Ma7+dahXgLMw5mbsz+hryqR5OMoB617Sm
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(450100002)(83380400001)(8936002)(8676002)(4326008)(82740400003)(81166007)(356005)(36756003)(2906002)(41300700001)(36860700001)(86362001)(47076005)(5660300002)(40460700003)(40480700001)(6512007)(2616005)(110136005)(316002)(70206006)(70586007)(54906003)(478600001)(6486002)(6506007)(53546011)(26005)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 11:24:13.6902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b78a91cb-e138-415d-8cad-08dc1c05d40d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5416

T24gVHVlLCAyMDI0LTAxLTIzIGF0IDEzOjA0ICswMjAwLCBBZHJpYW4gSHVudGVyIHdyb3RlOg0K
PiBPbiAyMy8wMS8yNCAxMjozMSwgQmVuIEdhaW5leSB3cm90ZToNCj4gPiBwZXJmIHNjcmlwdCBl
eHBvc2VzIHRoZSBldnNlbF9uYW1lIHRvIHB5dGhvbiBzY3JpcHRzIGFzIHBhcnQgb2YgdGhlDQo+
ID4gZGF0YQ0KPiA+IHBhc3NlZCB0byB0aGUgc2FtcGxlIG9yIHRyYWNlcG9pbnQgaGFuZGxlciBm
dW5jdGlvbiwgYW5kIGl0IHBhc3Nlcw0KPiA+IHRoZSBpZCBhbmQNCj4gPiBzdHJlYW1faWQgdG8g
dGhlIHRocm90dGxlZC91bnRocm90dGxlZCBoYW5kbGVyIGZ1bmN0aW9ucy4gVGhpcw0KPiA+IG1h
a2VzIG1hdGNoaW5nDQo+ID4gdGhyb3R0bGUgZXZlbnRzIGFuZCBzYW1wbGVzIGRpZmZpY3VsdC4N
Cj4gPiANCj4gPiBUbyBtYWtlIHRoaXMgcG9zc2libGUsIHRoaXMgY2hhbmdlIGV4cG9zZXMgdGhl
IHNhbXBsZSBpZCBhbmQNCj4gPiBzdHJlYW1faWQgdmFsdWVzDQo+ID4gdG8gdGhlIHNjcmlwdC4N
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBCZW4gR2FpbmV5IDxiZW4uZ2FpbmV5QGFybS5jb20+
DQo+ID4gLS0tDQo+ID4gwqB0b29scy9wZXJmL0RvY3VtZW50YXRpb24vcGVyZi1zY3JpcHQtcHl0
aG9uLnR4dMKgwqDCoMKgwqDCoMKgIHwgNCArKy0tDQo+ID4gwqB0b29scy9wZXJmL3V0aWwvc2Ny
aXB0aW5nLWVuZ2luZXMvdHJhY2UtZXZlbnQtcHl0aG9uLmMgfCA4DQo+ID4gKysrKysrKy0NCj4g
PiDCoDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+
IA0KPiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL0RvY3VtZW50YXRpb24vcGVyZi1zY3JpcHQt
cHl0aG9uLnR4dA0KPiA+IGIvdG9vbHMvcGVyZi9Eb2N1bWVudGF0aW9uL3BlcmYtc2NyaXB0LXB5
dGhvbi50eHQNCj4gPiBpbmRleCA2YTg1ODEwMTJlMTYyLi4xM2UzN2U5Mzg1ZWU0IDEwMDY0NA0K
PiA+IC0tLSBhL3Rvb2xzL3BlcmYvRG9jdW1lbnRhdGlvbi9wZXJmLXNjcmlwdC1weXRob24udHh0
DQo+ID4gKysrIGIvdG9vbHMvcGVyZi9Eb2N1bWVudGF0aW9uL3BlcmYtc2NyaXB0LXB5dGhvbi50
eHQNCj4gPiBAQCAtNjQyLDggKzY0Miw4IEBAIFNVUFBPUlRFRCBGSUVMRFMNCj4gPiDCoA0KPiA+
IMKgQ3VycmVudGx5IHN1cHBvcnRlZCBmaWVsZHM6DQo+ID4gwqANCj4gPiAtZXZfbmFtZSwgY29t
bSwgcGlkLCB0aWQsIGNwdSwgaXAsIHRpbWUsIHBlcmlvZCwgcGh5c19hZGRyLCBhZGRyLA0KPiA+
IC1zeW1ib2wsIHN5bW9mZiwgZHNvLCB0aW1lX2VuYWJsZWQsIHRpbWVfcnVubmluZywgdmFsdWVz
LA0KPiA+IGNhbGxjaGFpbiwNCj4gPiArZXZfbmFtZSwgY29tbSwgaWQsIHN0cmVhbV9pZCwgcGlk
LCB0aWQsIGNwdSwgaXAsIHRpbWUsIHBlcmlvZCwNCj4gPiBwaHlzX2FkZHIsDQo+ID4gK2FkZHIs
IHN5bWJvbCwgc3ltb2ZmLCBkc28sIHRpbWVfZW5hYmxlZCwgdGltZV9ydW5uaW5nLCB2YWx1ZXMs
DQo+ID4gY2FsbGNoYWluLA0KPiA+IMKgYnJzdGFjaywgYnJzdGFja3N5bSwgZGF0YXNyYywgZGF0
YXNyY19kZWNvZGUsIGlyZWdzLCB1cmVncywNCj4gPiDCoHdlaWdodCwgdHJhbnNhY3Rpb24sIHJh
d19idWYsIGF0dHIsIGNwdW1vZGUuDQo+ID4gwqANCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVy
Zi91dGlsL3NjcmlwdGluZy1lbmdpbmVzL3RyYWNlLWV2ZW50LXB5dGhvbi5jDQo+ID4gYi90b29s
cy9wZXJmL3V0aWwvc2NyaXB0aW5nLWVuZ2luZXMvdHJhY2UtZXZlbnQtcHl0aG9uLmMNCj4gPiBp
bmRleCA4NjBlMTgzN2JhOTY5Li5kODg5NjY2NDViMmY0IDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xz
L3BlcmYvdXRpbC9zY3JpcHRpbmctZW5naW5lcy90cmFjZS1ldmVudC1weXRob24uYw0KPiA+ICsr
KyBiL3Rvb2xzL3BlcmYvdXRpbC9zY3JpcHRpbmctZW5naW5lcy90cmFjZS1ldmVudC1weXRob24u
Yw0KPiA+IEBAIC04NTgsNiArODU4LDEwIEBAIHN0YXRpYyBQeU9iamVjdCAqZ2V0X3BlcmZfc2Ft
cGxlX2RpY3Qoc3RydWN0DQo+ID4gcGVyZl9zYW1wbGUgKnNhbXBsZSwNCj4gPiDCoMKgwqDCoMKg
wqDCoMKgcHlkaWN0X3NldF9pdGVtX3N0cmluZ19kZWNyZWYoZGljdCwgImV2X25hbWUiLA0KPiA+
IF9QeVVuaWNvZGVfRnJvbVN0cmluZyhldnNlbF9fbmFtZShldnNlbCkpKTsNCj4gPiDCoMKgwqDC
oMKgwqDCoMKgcHlkaWN0X3NldF9pdGVtX3N0cmluZ19kZWNyZWYoZGljdCwgImF0dHIiLA0KPiA+
IF9QeUJ5dGVzX0Zyb21TdHJpbmdBbmRTaXplKChjb25zdCBjaGFyICopJmV2c2VsLT5jb3JlLmF0
dHIsDQo+ID4gc2l6ZW9mKGV2c2VsLT5jb3JlLmF0dHIpKSk7DQo+ID4gwqANCj4gPiArwqDCoMKg
wqDCoMKgwqBweWRpY3Rfc2V0X2l0ZW1fc3RyaW5nX2RlY3JlZihkaWN0X3NhbXBsZSwgImlkIiwN
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFB5TG9u
Z19Gcm9tVW5zaWduZWRMb25nTG9uZyhzYW1wbGUtPmlkKSk7DQo+ID4gK8KgwqDCoMKgwqDCoMKg
cHlkaWN0X3NldF9pdGVtX3N0cmluZ19kZWNyZWYoZGljdF9zYW1wbGUsICJzdHJlYW1faWQiLA0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgUHlMb25n
X0Zyb21VbnNpZ25lZExvbmdMb25nKHNhbXBsZS0NCj4gPiA+c3RyZWFtX2lkKSk7DQo+ID4gwqDC
oMKgwqDCoMKgwqDCoHB5ZGljdF9zZXRfaXRlbV9zdHJpbmdfZGVjcmVmKGRpY3Rfc2FtcGxlLCAi
cGlkIiwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBfUHlMb25nX0Zyb21Mb25nKHNhbXBsZS0+cGlkKSk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHB5
ZGljdF9zZXRfaXRlbV9zdHJpbmdfZGVjcmVmKGRpY3Rfc2FtcGxlLCAidGlkIiwNCj4gPiBAQCAt
MTMwNiw3ICsxMzEwLDcgQEAgc3RhdGljIHZvaWQgcHl0aG9uX2V4cG9ydF9zYW1wbGVfdGFibGUo
c3RydWN0DQo+ID4gZGJfZXhwb3J0ICpkYmUsDQo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCB0
YWJsZXMgKnRhYmxlcyA9IGNvbnRhaW5lcl9vZihkYmUsIHN0cnVjdCB0YWJsZXMsDQo+ID4gZGJl
KTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgUHlPYmplY3QgKnQ7DQo+ID4gwqANCj4gPiAtwqDCoMKg
wqDCoMKgwqB0ID0gdHVwbGVfbmV3KDI1KTsNCj4gPiArwqDCoMKgwqDCoMKgwqB0ID0gdHVwbGVf
bmV3KDI3KTsNCj4gPiDCoA0KPiA+IMKgwqDCoMKgwqDCoMKgwqB0dXBsZV9zZXRfZDY0KHQsIDAs
IGVzLT5kYl9pZCk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHR1cGxlX3NldF9kNjQodCwgMSwgZXMt
PmV2c2VsLT5kYl9pZCk7DQo+ID4gQEAgLTEzMzMsNiArMTMzNyw4IEBAIHN0YXRpYyB2b2lkIHB5
dGhvbl9leHBvcnRfc2FtcGxlX3RhYmxlKHN0cnVjdA0KPiA+IGRiX2V4cG9ydCAqZGJlLA0KPiA+
IMKgwqDCoMKgwqDCoMKgwqB0dXBsZV9zZXRfZDY0KHQsIDIyLCBlcy0+c2FtcGxlLT5pbnNuX2Nu
dCk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHR1cGxlX3NldF9kNjQodCwgMjMsIGVzLT5zYW1wbGUt
PmN5Y19jbnQpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqB0dXBsZV9zZXRfczMyKHQsIDI0LCBlcy0+
c2FtcGxlLT5mbGFncyk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgdHVwbGVfc2V0X2Q2NCh0LCAyNSwg
ZXMtPnNhbXBsZS0+aWQpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHR1cGxlX3NldF9kNjQodCwgMjYs
IGVzLT5zYW1wbGUtPnN0cmVhbV9pZCk7DQo+IA0KPiBVbmxlc3MgeW91IGFjdHVhbGx5IHBsYW4g
dG8gdXNlIHRoZSBkYl9leHBvcnQgaW50ZXJmYWNlIHdpdGgNCj4gdGhlc2UsIHRoZXJlIGlzIG5v
IG5lZWQgdG8gYWRkIHRoZW0gYXQgdGhpcyB0aW1lLg0KPiANCg0KRm9yIHRoZSBwYXJ0aWN1bGFy
IHNjcmlwdCBJIHdhcyB1c2luZyB0aGUgZGIgZXhwb3J0IGludGVyZmFjZS4NCg0KDQo+ID4gwqAN
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgY2FsbF9vYmplY3QodGFibGVzLT5zYW1wbGVfaGFuZGxlciwg
dCwgInNhbXBsZV90YWJsZSIpOw0KPiA+IMKgDQo+IA0KDQo=

