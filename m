Return-Path: <linux-kernel+bounces-31840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C57983355B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 17:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BAB11F227F2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 16:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D0B10961;
	Sat, 20 Jan 2024 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="j9KhdAd1";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="j9KhdAd1"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A75F11718;
	Sat, 20 Jan 2024 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705767319; cv=fail; b=APAusK7CGri4jTaH/3aicZB/TYz0z5kIWsCgsAC65FKKj3dFRFJVYj359ZirN/4Dq0rpxk6zB8N9CiUWnW1lCqfEzfzJRdk2w+7xL6oaQdd9Puv9gcGWsWA+MS/gPR7ni3kDfzrAdF2XXKjFAyl+bLbTXJAc7hm4/8/zwjeqBuM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705767319; c=relaxed/simple;
	bh=aD2gXvQDID4tjU7kQ8xZyiIEL/GEwtyJ3fB3USCDnHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VVvycMXLC7/ySxeY80FcQhPNifSQ4S8bXiXIfH27u+ef+D+XGCi+dh+B0XzCbVQ/vuY7VpY29dSzidTdYsi8QC1pxc8Whaec0KTpCJJU7NDZrutug33vyrJH9jsbv4wA2PukL0xHSdjQsignaytHyJAMUzvKBISyets5nSAvL0o=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=j9KhdAd1; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=j9KhdAd1; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=fMsA8WztMW5ZLxnW+Zw5bXhqeWzw8GbaMmeg8UropKCQ0rXQ+iYy+r9t4QztVVxY1QWt+KSmGdD8OpTHlikf7xxh9AyoFmzi9g2xYdTslYkUOIJuRNeHzP1qf01RWOZ9IGr1NdvraQnKkQapRVrNUUUCxJYgMJpU40j5+P48JUKGR2EDBLunRdjjNvQ3i4Leg/75YS3qjaV9ghJ73wnoH3JiFeMyl7GdcRiMIfkorHNP04mUFeUqZ8bbQsrcV5qry+jghM+Zcsw0HUkvvFVA2/U9qFUASQajzrxSgug2weB3WwEYey95dmJcTlEjA9yyOsfdeC3CsouwOT9XUDZOHA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aD2gXvQDID4tjU7kQ8xZyiIEL/GEwtyJ3fB3USCDnHg=;
 b=AdQfCZfKBKV5+zR+uOdJaEIGYcH44sM70+UjjwiVB1oWXNZadl49aZoIJaECWw7lSys2PCEd9kvP0kUULhWCeqDke5dyP7/mSl24ILTqANLYloQCUqZaSVh1F5YDcQAqZHGSMfkA5sFjFjwb+mmZX6AEQMDMSWN8OjC1D+rzuko5H7/UmbQH0iYW4SVUJevqRrYoHgChjN5H4G/e3eYa6BvRsat5AwEHe+qCr2a0rMHjq2p46WBUi2ynkAM4cui8jY1fspqEn7fcezvVxA56E37qM/z9QdDVOebhICJQ/uSwInM8+AekUK6qX8bYIZtwObXhOGKY439kMPBu+wdHYw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aD2gXvQDID4tjU7kQ8xZyiIEL/GEwtyJ3fB3USCDnHg=;
 b=j9KhdAd1DZS8Aok8mYYbMQBi3j9WU063j1dvCxRROVheoWxomX0DzQeZt+IPS59FuexuT6+92Xa+1zNtW4rUWX8sO/X49akaRg7zUe9fmP3ep1VYSLoXOrj8TtbwQWLe5BfDgZ0zXw3ZAgu98pFTcNxzjR5Y9yfv57akWX5SnPo=
Received: from AS9PR07CA0013.eurprd07.prod.outlook.com (2603:10a6:20b:46c::10)
 by AS8PR08MB9316.eurprd08.prod.outlook.com (2603:10a6:20b:5a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Sat, 20 Jan
 2024 16:15:06 +0000
Received: from AM3PEPF0000A79A.eurprd04.prod.outlook.com
 (2603:10a6:20b:46c:cafe::57) by AS9PR07CA0013.outlook.office365.com
 (2603:10a6:20b:46c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.13 via Frontend
 Transport; Sat, 20 Jan 2024 16:15:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF0000A79A.mail.protection.outlook.com (10.167.16.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Sat, 20 Jan 2024 16:15:06 +0000
Received: ("Tessian outbound 1076c872ecc6:v228"); Sat, 20 Jan 2024 16:15:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 60e5a4e032228e56
X-CR-MTA-TID: 64aa7808
Received: from 691b8d6dd6d5.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3D54FDBE-57A6-4916-AD5E-6F683500549B.1;
	Sat, 20 Jan 2024 16:14:54 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 691b8d6dd6d5.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Sat, 20 Jan 2024 16:14:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEkXR9TPHsQbU1ESS4Bicz6aW9Mk4oGEOvo7ccqphWVlIdSS2E7A58xuGN1Mo7q/uDizQJq3QMFFv/806Z/2pTpOkgWDHK3C6RqeJcK654exrpf6NNkziUu20MTW4wvdcWYLkEJ/YcTdgke8zert0ObeX0ijaB9hZFTZYmC47nq/XJUtPJa+NmUepZ6+2j1wC8MI0IafOWVFR+nksCo+/0gc8oWyXMrTTG7PElKQ3qCtNRpbn0q3Cv/4+v8X9HJHYcgOpJOLsqib78UDoUrFWDoMCdLY1bzHNrpFJJlUvN5rq5dnYblEsWKVEqGVGw1i8BvDFwy7IYD9BuXRdDermg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aD2gXvQDID4tjU7kQ8xZyiIEL/GEwtyJ3fB3USCDnHg=;
 b=V3clT+ClpcHkdotg2M87yq+BS5/CjSZZ5yL+eT27rql1sbnOK1oUWviP2ny7ntjQEnkPt+XDfqOCe3r4gtIBFgfKhSfw02yPNTGuifH1h7Cre/u7s7zHw0c60hDQGjqsu3jTU2/n/Kr7tjEnfj+WqSf5oC+QBsNjE49N6kUBySCrZgmPAy6UUP4eU/t9T5v6v0DmGdx2yYatVv8tXtIg5FnyIStoTQ9exN5jJW0xAewCP93QEUux6sWB9A8n8SPJoOG4RHa0NNLbtn4rM7tYXE+Dlh3GAxtrruiNpGbUEC2B9N7EumEeR+IPFUy/XSVLb7yHc2ST6xGwgKc7CzUAFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aD2gXvQDID4tjU7kQ8xZyiIEL/GEwtyJ3fB3USCDnHg=;
 b=j9KhdAd1DZS8Aok8mYYbMQBi3j9WU063j1dvCxRROVheoWxomX0DzQeZt+IPS59FuexuT6+92Xa+1zNtW4rUWX8sO/X49akaRg7zUe9fmP3ep1VYSLoXOrj8TtbwQWLe5BfDgZ0zXw3ZAgu98pFTcNxzjR5Y9yfv57akWX5SnPo=
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com (2603:10a6:20b:350::15)
 by PAXPR08MB6590.eurprd08.prod.outlook.com (2603:10a6:102:152::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.27; Sat, 20 Jan
 2024 16:14:51 +0000
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::bf90:87a7:c796:ce84]) by AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::bf90:87a7:c796:ce84%4]) with mapi id 15.20.7202.028; Sat, 20 Jan 2024
 16:14:50 +0000
From: Ben Gainey <Ben.Gainey@arm.com>
To: "namhyung@kernel.org" <namhyung@kernel.org>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	James Clark <James.Clark@arm.com>, "peterz@infradead.org"
	<peterz@infradead.org>, Mark Rutland <Mark.Rutland@arm.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "irogers@google.com"
	<irogers@google.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/1] Support PERF_SAMPLE_READ with inherit_stat
Thread-Topic: [PATCH 0/1] Support PERF_SAMPLE_READ with inherit_stat
Thread-Index: AQHaSvYoATZqyOE6y0OGrcMnu7mKsrDh3y6AgAECeoA=
Date: Sat, 20 Jan 2024 16:14:50 +0000
Message-ID: <fabba57db2c0e9b8f4264180cf1f941f9552a102.camel@arm.com>
References: <20240119163924.2801678-1-ben.gainey@arm.com>
	 <CAM9d7chcAVm8TyJz9iOoEom1g82O5hFD3M+DHYDrphUADATjgA@mail.gmail.com>
In-Reply-To:
 <CAM9d7chcAVm8TyJz9iOoEom1g82O5hFD3M+DHYDrphUADATjgA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS8PR08MB6646:EE_|PAXPR08MB6590:EE_|AM3PEPF0000A79A:EE_|AS8PR08MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: 479d4286-1bc5-4b28-55e5-08dc19d2f78a
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 rUvcem9YcOPOGIac5hNfWUPHxafIwxc+wGJoBkwN5o8BBzG/EaA7UMsBprLAqlHezwrQ4UC2vSl8J10iJLglxkw7MpJJ4/GpG6xlpi6MvQ+8UleC0WVSptek+wz+tmrNQ3Ukg3FLkOWS2x17eOhN2amgF7WO8UMYavD9tES2NHF7FpQW5MmkPyAcCcg1SHWKzopjOAK3Cv/Tpd1k09bInxGa40FBJMdGHonmT3RoyV+rYywN6EdDxPBqKXgSzXh+B0rQHsmkVoiFKp8tA8lUwrkh6Is1qEQSNhwM26iE7Mx9byVYMESHYlSkqkbIme2uCTT9sywPkyekTwT4SQM1HwxvqnKyYTz+jLlvY+6xvH64islVSuWxqO+JkMmqy/d0cqwweIFobPPS0r/cUkoGX21GsXSZLsiHN2WkJYV1zAjC+dQGC0dMEfL+T1+8LeQ8sgnDEQBGpg8WUdpBbJSbv2cTAoJBtccG4514Sa+s+O6nkGgJjuWLjh29+Jw9vAjsw5Y4En1JZVI94DO6fWgtJIyi4ERJGDCVXp08+SCJ+zsaeLSmWBOD0R71/V4MtUuWMTqHN1HsiYJKtmtbaTlnCS71MNTIcW/RWHYe7rKSsduTLUIA2jGyUsXXLEyLp0Yz
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6646.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(376002)(346002)(366004)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(83380400001)(53546011)(26005)(2616005)(38100700002)(122000001)(6512007)(4326008)(8676002)(8936002)(7416002)(5660300002)(6486002)(2906002)(478600001)(6916009)(6506007)(71200400001)(66446008)(66556008)(66946007)(76116006)(66476007)(64756008)(54906003)(316002)(41300700001)(91956017)(36756003)(86362001)(38070700009)(66899024);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B3F0F53C0AE914685181E3469AC47F2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6590
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2664d2e2-6d0a-4c07-5644-08dc19d2ee2b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7peOKvPDjleQSqcp/b8rwrItryuRfna+zOviusdDoIUZu/ljSG3tfOnrAbF0c1Xtpy+MRJnCQLLXwYKcfdro+Am8G2xuaLZOEUYxDogGFnDzLUXGvcUUac36n2wcrm/eWpse11DvHf1UxxeJK0FYLR+K0qVnpw0Hmq6e8LFTanu4viMQ9x/iXGs+dWHZuOrJZIaMXzsTDcTmgSoVpMbJoDraRAcyBN8ElaCfiIYLR2E9Ew7Rkref0yLCQTHMjY40TRbIHTmnRltdYkfIrm6WMDAB8lT2cK8pJLkrOvlYMqLTAATE++dF3O5W/OW1lxuQTa8Svn49lngqaUy2ZcBYosV/4nYnS//qJx78b2FUu+HMFMxJdhJCVQkd4shp0ciK9gpILBQlhnr/Ut7XAb/aracvojY67uOhqYoRl5SZO2+H99sx0kBXDv2SZxMu9HCUAC8ZIGLhK+iAGaaTvk86fXDsu78xQv0PIEFicG84XDksTPINxWSCWOEuqLGYLHPkpiUtETllcmWxahAUn1wDu08XZJvzTG6bVYxdDCWqRhhB1+yYl4hY5TBefCtV84hynPhvePmx5bvsE4o9ezZTgOI+ZAWl0YBP3vZ6GRuFxU794BDztDR5E49rdiZam4BAz4zvqMNqwHx0Hrs4pCqXUQRzjRgR+95LZ57OLOzKCWry2DEHI/ney8ItPWaIHCwH+RQDjuLc/9qghSbDYHPTaKgEp89QTFdQObnZ0Ynkv/+VRxO9UxfuXYMMgFZAh+if
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(66899024)(47076005)(83380400001)(36860700001)(2616005)(8936002)(107886003)(81166007)(82740400003)(356005)(4326008)(41300700001)(450100002)(54906003)(70206006)(70586007)(2906002)(5660300002)(8676002)(6506007)(6862004)(316002)(6512007)(336012)(26005)(478600001)(6486002)(53546011)(86362001)(36756003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2024 16:15:06.5695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 479d4286-1bc5-4b28-55e5-08dc19d2f78a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9316

T24gRnJpLCAyMDI0LTAxLTE5IGF0IDE2OjQ5IC0wODAwLCBOYW1oeXVuZyBLaW0gd3JvdGU6DQo+
IEhlbGxvLA0KPg0KPiBPbiBGcmksIEphbiAxOSwgMjAyNCBhdCA4OjM54oCvQU0gQmVuIEdhaW5l
eSA8YmVuLmdhaW5leUBhcm0uY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IFRoaXMgY2hhbmdlIGFs
bG93cyBldmVudHMgdG8gdXNlIFBFUkZfU0FNUExFIFJFQUQgd2l0aCBpbmhlcml0IHNvDQo+ID4g
bG9uZw0KPiA+IGFzIGJvdGggaW5oZXJpdF9zdGF0IGFuZCBQRVJGX1NBTVBMRV9USUQgYXJlIHNl
dC4NCj4gPg0KPiA+IEN1cnJlbnRseSBpdCBpcyBub3QgcG9zc2libGUgdG8gdXNlIFBFUkZfU0FN
UExFX1JFQUQgd2l0aCBpbmhlcml0Lg0KPiA+IFRoaXMNCj4gPiByZXN0cmljdGlvbiBhc3N1bWVz
IHRoZSB1c2VyIGlzIGludGVyZXN0ZWQgaW4gY29sbGVjdGluZyBhZ2dyZWdhdGUNCj4gPiBzdGF0
aXN0aWNzIGFzIHBlciBgcGVyZiBzdGF0YC4gSXQgcHJldmVudHMgYSB1c2VyIGZyb20gY29sbGVj
dGluZw0KPiA+IHBlci10aHJlYWQgc2FtcGxlcyB1c2luZyBjb3VudGVyIGdyb3VwcyBmcm9tIGEg
bXVsdGktdGhyZWFkZWQgb3INCj4gPiBtdWx0aS1wcm9jZXNzIGFwcGxpY2F0aW9uLCBhcyB3aXRo
IGBwZXJmIHJlY29yZCAtZSAney4uLi59OlMnYC4NCj4gPiBJbnN0ZWFkDQo+ID4gdXNlcnMgbXVz
dCB1c2Ugc3lzdGVtLXdpZGUgbW9kZSwgb3IgZm9yZ28gdGhlIGFiaWxpdHkgdG8gc2FtcGxlDQo+
ID4gY291bnRlcg0KPiA+IGdyb3Vwcy4gU3lzdGVtLXdpZGUgbW9kZSBpcyBvZnRlbiBwcm9ibGVt
YXRpYyBhcyBpdCByZXF1aXJlcw0KPiA+IHNwZWNpZmljDQo+ID4gcGVybWlzc2lvbnMgKG5vIENB
UF9QRVJGTU9OIC8gcm9vdCBhY2Nlc3MpLCBvciBtYXkgbGVhZCB0byBjYXB0dXJlDQo+ID4gb2YN
Cj4gPiBzaWduaWZpY2FudCBhbW91bnRzIG9mIGV4dHJhIGRhdGEgZnJvbSBvdGhlciBwcm9jZXNz
ZXMgcnVubmluZyBvbg0KPiA+IHRoZQ0KPiA+IHN5c3RlbS4NCj4gPg0KPiA+IFBlcmYgYWxyZWFk
eSBzdXBwb3J0cyB0aGUgYWJpbGl0eSB0byBjb2xsZWN0IHBlci10aHJlYWQgY291bnRzIHdpdGgN
Cj4gPiBgaW5oZXJpdGAgdmlhIHRoZSBgaW5oZXJpdF9zdGF0YCBmbGFnLiBUaGlzIHBhdGNoIGNo
YW5nZXMNCj4gPiBgcGVyZl9ldmVudF9hbGxvY2AgcmVsYXhpbmcgdGhlIHJlc3RyaWN0aW9uIHRv
IGNvbWJpbmUgYGluaGVyaXRgDQo+ID4gd2l0aA0KPiA+IGBQRVJGX1NBTVBMRV9SRUFEYCBzbyB0
aGF0IHRoZSBjb21iaW5hdGlvbiB3aWxsIGJlIGFsbG93ZWQgc28gbG9uZw0KPiA+IGFzDQo+ID4g
YGluaGVyaXRfc3RhdGAgYW5kIGBQRVJGX1NBTVBMRV9USURgIGFyZSBlbmFibGVkLg0KPg0KPiBJ
J20gbm90IHN1cmUgaWYgaXQncyBjb3JyZWN0LiAgTWF5YmUgSSBtaXN1bmRlcnN0YW5kIGluaGVy
aXRfc3RhdCBidXQNCj4gQUZBSUsgaXQncyBqdXN0IHRvIHVzZSBwcmV2X3Rhc2sncyBldmVudHMg
d2hlbiBuZXh0X3Rhc2sgaGFzIHRoZQ0KPiBjb21wYXRpYmxlIGV2ZW50IGNvbnRleHQuICBTbyB0
aGUgZXZlbnQgdmFsdWVzIGl0IHNlZXMgaW4gc2FtcGxlcw0KPiB3b3VsZCBkZXBlbmQgb24gdGhl
IHRpbWluZyBvciBzY2hlZHVsZXIgYmVoYXZpb3IuDQoNCkkgdGhpbmsgeW91IGFyZSByZWZlcnJp
bmcgdG8gX19wZXJmX2V2ZW50X3N5bmNfc3RhdCBhcyBjYWxsZWQgZnJvbQ0KcGVyZl9ldmVudF9j
b250ZXh0X3NjaGVkX291dCwgYnV0IGlzbid0IHRoZSBwb2ludCB0aGF0DQpwZXJmX2V2ZW50X2Nv
bnRleHRfc2NoZWRfb3V0IHdpbGwganVzdCBzd2FwIHRoZSB0YXNrcyBhbmQgUkNVIHBvaW50ZXJz
DQphcyBhbiBvcHRtaXNhdGlvbiB3aGVuIHRoZSBpbmNvbWluZyBjb250ZXh0IGlzIHRoZSBzYW1l
IGFzIHRoZSBvdXRnb2luZw0KY29udGV4dCAocmF0aGVyIHRoYW4gc3RvcHBpbmcgYW5kIHJlc3Rh
cnRpbmcpLCBhbmQgc28gd2hlbiBpbmhlcml0X3N0YXQNCmlzIHVzZWQsIGFsb25nIHdpdGggc3dh
cGluZyB0aGUgb3V0Z29uZyBhbmQgaW5jb21pbmcgdGFzayBkYXRhIGluIHRoZQ0KZXZlbnQsIGl0
IGFsc28gcmVhZHMgYW5kIHRoZW4gc3dhcHMgdGhlIG91dGdvaW5nIGFuZCBpbmNvbWluZyBjb3Vu
dGVyDQp2YWx1ZXMgaW4gdGhlIGV2ZW50IHNvIHRoYXQgdGhlIGNvdW50ZXIgdmFsdWVzIHRoYXQg
YmVsb25nIHRvIHRoZQ0Kb3V0Z29pbmcgZXZlbnQgYXJlIGNvcnJlY3RseSBhc3NvY2lhdGVkIHRv
IHRoYXQgdGFzay4NCg0KTG9va2luZyBhZ2FpbiBhdCBwZXJmX2V2ZW50X2NvbnRleHRfc2NoZWRf
b3V0IHRob3VnaCwgb25lIHRoaW5nIGkgbm90ZQ0KaXMgdGhhdCB0aGUgY2FsbCB0byBwZXJmX2V2
ZW50X3N5bmNfc3RhdCBoYXBwZW5zIGFmdGVyIHRoZSBjYWxsIHRvDQpwZXJmX2N0eF9lbmFibGUs
IHdoaWNoIEkgdGhpbmsgbWVhbnMgdHdvIHRoaW5nczoNCiAqIFRoZSBwbXUtPnJlYWQgY2FsbCBp
biB0aGUgc3luYyB3aWxsIGJlIG9wZXJhdGluZyBvbiBhbiBhY3RpdmVseQ0KY291bnRpbmcgUE1V
LCBzbyB0aGUgY291bnRzIHJlY29yZGVkIGluIGVhY2ggZXZlbnQgaW4gdGhlIGNvbnRleHQgbWF5
DQpiZSBza2V3ZWQgcmVsYXRpdmUgdG8gZWFjaCBvdGhlci4gVGhpcyBpcyBub3QgdGhlIGNhc2Ug
ZWxzZXdoZXJlIHNvDQp0aGF0IHRoZSBldmVudHMgb24gdGhlIFBNVSBhcmUgcmVhZCBpbiB0aGUg
ZGlzYWJsZWQgc3RhdGUuDQogKiBwZXJjX2N0eF9lbmFibGUgKGF0IGxlYXN0IGZvciBhcm1fcG11
KSB3aWxsIG5vdCByZWxvYWQgdGhlIHRoZQ0KaW5jb21pbmcgInJlbWFpbmluZyIgcGVyaW9kIGZv
ciBhbnkgc2FtcGxpbmcgZXZlbnRzIHNvIGl0cyBwb3NzaWJsZQ0KdGhhdCBhbiBvdmVyZmxvdyB3
b3VsZCBoYXBwZW4gc29vbmVyIHRoYW4gZXhwZWN0ZWQgaW4gdGhlIGluY29taW5nDQpjb250ZXh0
ICh0aG91Z2ggaSBkb24ndCB0aGluayB0aGlzIHdpbGwgbGVhdmUgYSBjb3JydXB0ZWQgY291bnQs
IGp1c3QgYQ0Kc21hbGxlciB0aGFuIGV4cGVjdGVkIGNvdW50IGZvciB0aGF0IHNhbXBsZSkuDQoN
Cg0KPg0KPiBBbHNvIGV2ZW50IGNvdW50cyBhbmQgdGltZSB2YWx1ZXMgUEVSRl9TQU1QTEVfUkVB
RCBzZWVzDQo+IGluY2x1ZGUgY2hpbGQgZXZlbnQncyBzbyB0aGUgdmFsdWVzIG9mIHRoZSBwYXJl
bnQgZXZlbnQgY2FuIGJlDQo+IHVwZGF0ZWQgZXZlbiBpZiBpdCdzIGluYWN0aXZlLiAgQW5kIHRo
ZSB2YWx1ZXMgd2lsbCB2YXJ5IGZvciB0aGUNCj4gbmV4dF90YXNrIHdoZXRoZXIgcHJldl90YXNr
IGlzIHRoZSBwYXJlbnQgb3Igbm90LiAgSSB0aGluayBpdA0KPiB3b3VsZCByZXR1cm4gY29uc2lz
dGVudCB2YWx1ZXMgb25seSBpZiBpdCBpdGVyYXRlcyBhbGwgY2hpbGQgZXZlbnRzDQo+IGFuZCBz
dW1zIHVwIHRoZSB2YWx1ZXMgbGlrZSBpdCBkb2VzIGZvciByZWFkKDIpLiAgQnV0IGl0IGNhbm5v
dA0KPiBkbyB0aGF0IGluIHRoZSBOTUkgaGFuZGxlci4NCj4NCj4gRnJhbmtseSBJIGRvbid0IHVu
ZGVyc3RhbmQgaG93IGluaGVyaXRfc3RhdCBzdXBwb3J0cyBwZXItdGhyZWFkDQo+IGNvdW50cyBw
cm9wZXJseS4gIEFsc28gaXQgZG9lc24ndCBzZWVtIHRvIGJlIHVzZWQgYnkgZGVmYXVsdCBpbg0K
PiB0aGUgcGVyZiB0b29scy4NCg0KSG1tbSwgb2sgcmVyZWFkaW5nIHRocm91Z2ggY29yZS5jLCBp
IHRoaW5rIHRoZSB0aGluZyBJIGhhdmUgbWlzc2VkIGlzDQp0aGUgaW50ZXJhY3Rpb24gYmV0d2Vl
biBwZXJmX2V2ZW50X2NvdW50IGFuZCBzeW5jX2NoaWxkX2V2ZW50LCB3aGljaCBJDQpndWVzcyBJ
IG1pc3NlZCB3aGVuIHRlc3RpbmcgdGhpcyBiZWNhdXNlIElJUkMgc3luY19jaGlsZF9ldmVudCBp
cyBvbmx5DQpjYWxsZWQgb24gbWlncmF0aW9uLCBob3RwbHVnIGFuZCB0YXNrIGV4aXQgZXZlbnRz
Lg0KDQpJIGRvbid0IHRoaW5rIGl0IHdvdWxkIGJlIHNlbnNpYmxlIHRvIHNraXAgdGhlIHVwZGF0
ZSB0byBjaGlsZF9jb3VudCBpbg0Kc3luY19jaGlsZF9ldmVudCBhcyB0aGlzIHdvdWxkIGJyZWFr
IHRoZSBiZWhhdmlvdXIgb2YgdGhlIGByZWFkKClgIG9uDQphbiBldmVudCdzIGZkLiBJIHN1cHBv
c2UgdGhlIGJldHRlciB0aGluZyB0byBkbyB3b3VsZCBiZSB0byBoYXZlDQpwZXJmX291dHB1dF9y
ZWFkX2dyb3VwL19vbmUgYXZvaWQgcmVhZGluZyBjaGlsZF9jb3VudCBmb3IgdGhlc2Uga2luZHMN
Cm9mIGV2ZW50cy4gVGhhdCB3b3VsZCBlbnN1cmUgdGhlIG1tYXAgc2FtcGxlIGlzIGNvcnJlY3Qu
DQoNCg0KPiAgSUlVQyBwZXItdGhyZWFkIGNvdW50IGlzIHN1cHBvcnRlZCB3aGVuIHlvdQ0KPiBk
b24ndCBzZXQgdGhlIGluaGVyaXQgYml0IGFuZCBvcGVuIHNlcGFyYXRlIGV2ZW50cyBmb3IgZWFj
aA0KPiB0aHJlYWQgYnV0IEkgZ3Vlc3MgdGhhdCdzIG5vdCB3aGF0IHlvdSB3YW50Lg0KDQpZb3Ug
Y2FuIHRha2UgdGhhdCBhcHByb2FjaC4uLiBidXQgSSBkb24ndCB0aGluayBpdCBpcyBwbGVhc2Vu
dCA6LSkuDQpJZiB5b3UgaGF2ZSBhbiBhcHBsaWNhdGlvbiB0aGF0IHNwYXducyB0aHJlYWRzIGF0
IHJ1bnRpbWUgdGhlIHRvb2wgbXVzdA0Kc29tZWhvdyB0cmFjayB0aGVtIChwZXJoYXBzIGJ5IHBv
bGxpbmcgcHJvYyBvciB1c2luZyBwdHJhY2UpLiBQb2xsaW5nDQppcyBub3QgaWRlYWwgYXMgaXQg
Y2FuIG1pc3MgdGhpbmdzIG9yIGludHJvZHVjZSBoaWdoIG92ZXJoZWFkIGluIHRoZQ0KdG9vbC4g
TW9yZSBpbXBvcnRhbnRseSwgY3JlYXRpbmcgYSBuZXcgZXZlbnQgcGVyIHRocmVhZCBjYW4gY29u
c3VtZSBhDQpsb3Qgb2YgZmlsZSBkZXNjcmlwdG9ycywgcGFydGljdWxhcmx5IGlmIHlvdSBvcGVu
IHBlci10aHJlYWQtcGVyLWNwdQ0KZXZlbnRzIHRvIGhhdmUgdGhlbSB3cml0ZSB0byB0aGUgc2Ft
ZSBtbWFwLg0KDQpGV0lXIEkgcmVjZW50bHkgcHJvdG90eXBlZCBhIHZlcnNpb24gb2YgdGhpcyBp
biBBcm0ncyBwcm9maWxlciB0b29scywNCndoZXJlIHdlIGFyZSBhbHNvIHByb3RvdHlwaW5nIHN1
cHBvcnQgZm9yIHBlci1mdW5jdGlvbiBtZXRyaWNzLi4uIE9uDQpzb21ldGhpbmcgbGlrZSBhIEdy
YXZhdG9uIDMsIGhhdmluZyA2NCBjb3Jlcywgd2hlcmUgdGhlIGZ1bGwgc2V0IG9mDQpwdWJsaXNo
ZWQgbWV0cmljcyBmb3IgTmVvdmVyc2UtVjEgY29udGFpbnMgc29tZXRoaW5nIGxpa2UgNjAgUE1V
DQpldmVudHMsIHRyYWNpbmcgYSBkYXRhYmFzZSBhcHBsaWNhdGlvbiB0aGF0IGNyZWF0ZXMgYSBu
ZXcgdGhyZWFkIHBlcg0KY29ubmVjdGlvbiwgaXQgc3Bhd25lZCB+MzAgdGhyZWFkcy4uLiB0aGUg
dG9vbCB0cmllZCB0byBjcmVhdGUgfjEwMGsNCnBlcmYgZXZlbnRzLi4uIGhpdCB1bGltaXQgYW5k
IHRlcm1pbmF0ZWQuIEkgcmVhbGl6ZSB0aGlzIGFubmVjZG90ZSBpcw0Kb24gdGhlIGV4dHJlbWUg
ZW5kIG9mIHRoaW5ncywgYnV0IGl0IGlzIHBvc3NpYmxlIHRoaXMgd291bGQgYmUgYSBjb21tb24N
Cmlzc3VlIGZvciBsYXJnZSBjb3JlLWNvdW50IHNlcnZlciBzeXN0ZW1zLg0KDQo+DQo+IEFueXdh
eSwgSSdtIG9rIHdpdGggdGhlIGlkZWEgb2YgdXNpbmcgUEVSRl9TQU1QTEVfUkVBRCB0bw0KPiBp
bXByb3ZlIHBlci10aHJlYWQgcHJvZmlsaW5nIGVzcGVjaWFsbHkgd2l0aCBldmVudCBncm91cHMu
DQo+IEJ1dCBJIHRoaW5rIGl0IHNob3VsZCBub3QgdXNlIGluaGVyaXRfc3RhdCBhbmQgaXQgbmVl
ZHMgYSB3YXkgdG8NCj4gbm90IGluY2x1ZGUgY2hpbGQgc3RhdHMgaW4gdGhlIHNhbXBsZXMuDQo+
DQo+IFdoYXQgZG8geW91IHRoaW5rPw0KDQpJJ20gaGFwcHkgdG8gZmluZCBhIGRpZmZlcmVudCB3
YXkgdG8gb3B0IGluIHRvIHRoaXMgaW5zdGVhZCBvZg0KYGluaGVyaXRfc3RhdGAgaWYgcGVvcGxl
IHByZWZlci4gVGhvdWdoIEkgdGhpbmsgaWYgbXkgdW5kZXJzdGFuZGluZyBvZg0KX19wZXJmX2V2
ZW50X3N5bmNfc3RhdCBkZXNjcmliZWQgYWJvdmUgaXMgY29ycmVjdCwgdGhlbiBzbyBsb25nIGFz
IGkNCmZpeCB0aGUgYmVoYXZpb3VyIG9mIHBlcmZfb3V0cHV0X3JlYWRfZ3JvdXAvX29uZSB0aGVu
IEkgdGhpbmsgdGhlDQpzYW1wbGVkIGNvdW50cyB3b3VsZCBiZSBjb3JyZWN0Lg0KDQoNCkkgY2Fu
IGxvb2sgYXQgYWRkaW5nIGEgbmV3IGZsYWcgYml0IHRvIG9wdCBpbi4uLiB0aGlzIHdvdWxkIHBy
b2JhYmx5DQphbHNvIGVsZXZpYXRlIHNvbWUgb2YgQW5kaSdzIGNvbmNlcm5zIGluIHRoZSBvdGhl
ciBwYXJ0IG9mIHRoaXMgdGhyZWFkLg0KT3BlbiB0byBzdWdnZXN0aW9ucyBvdGhlcndpc2UuLi4N
Cg0KVGhhbmtzDQpCZW4NCg0KDQo+DQo+IFRoYW5rcywNCj4gTmFtaHl1bmcNCj4NCj4gPg0KPiA+
IEluIHRoaXMgY29uZmlndXJhdGlvbiBzdHJlYW0gaWRzIChzdWNoIGFzIG1heSBhcHBlYXIgaW4g
dGhlDQo+ID4gcmVhZF9mb3JtYXQNCj4gPiBmaWVsZCBvZiBhIFBFUkZfUkVDT1JEX1NBTVBMRSkg
YXJlIG5vIGxvbmdlciBnbG9iYWxseSB1bmlxdWUsDQo+ID4gcmF0aGVyDQo+ID4gdGhlIHBhaXIg
b2YgKHN0cmVhbSBpZCwgdGlkKSB1bmlxdWVseSBpZGVudGlmeSBlYWNoIGV2ZW50LiBUb29scw0K
PiA+IHRoYXQNCj4gPiByZWx5IG9uIHRoaXMsIGZvciBleGFtcGxlIHRvIGNhbGN1bGF0ZSBhIGRl
bHRhIGJldHdlZW4gc2FtcGxlcywNCj4gPiB3b3VsZA0KPiA+IG5lZWQgdXBkYXRpbmcgdG8gdGFr
ZSB0aGlzIGludG8gYWNjb3VudC4gUHJldmlvdXNseSB2YWxpZCBldmVudA0KPiA+IGNvbmZpZ3Vy
YXRpb25zIChzeXN0ZW0td2lkZSwgbm8taW5oZXJpdCBhbmQgc28gb24pIHdoZXJlIGVhY2gNCj4g
PiBzdHJlYW0gaWQNCj4gPiBpcyB0aGUgaWRlbnRpZmllciBhcmUgdW5hZmZlY3RlZC4NCj4gPg0K
PiA+IFRoaXMgcGF0Y2ggaGFzIGJlZW4gdGVzdGVkIG9uIGFhcmNoNjQgYm90aCBteSBtYW51YWwg
aW5zcGVjdGlvbiBvZg0KPiA+IHRoZQ0KPiA+IG91dHB1dCBvZiBgcGVyZiBzY3JpcHQgLURgIGFu
ZCB0aHJvdWdoIGEgbW9kaWZpZWQgdmVyc2lvbiBvZiBBcm0ncw0KPiA+IGNvbW1lcmNpYWwgcHJv
ZmlsaW5nIHRvb2xzIGFuZCB0aGUgbnVtYmVycyBhcHBlYXIgdG8gbGluZSB1cCBhcyBvbmUNCj4g
PiB3b3VsZCBleHBlY3QsIGJ1dCBzb21lIGZ1cnRoZXIgdmFsaWRhdGlvbiBhY3Jvc3Mgb3RoZXIN
Cj4gPiBhcmNoaXRlY3R1cmVzDQo+ID4gYW5kL29yIGVkZ2UgY2FzZXMgd291bGQgYmUgd2VsY29t
ZS4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggd2FzIGRldmVsb3BlZCBhbmQgdGVzdGVkIG9uIHRvcCBv
ZiB2Ni43Lg0KPiA+DQo+ID4NCj4gPiBCZW4gR2FpbmV5ICgxKToNCj4gPiAgIHBlcmY6IFN1cHBv
cnQgUEVSRl9TQU1QTEVfUkVBRCB3aXRoIGluaGVyaXRfc3RhdA0KPiA+DQo+ID4gIGtlcm5lbC9l
dmVudHMvY29yZS5jIHwgNyArKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+DQoNCklN
UE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNo
bWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91
IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVy
IGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhl
ciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGlu
Zm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==

