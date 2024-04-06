Return-Path: <linux-kernel+bounces-133888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F1989AA52
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 12:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D30AB21CB9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 10:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF312575A;
	Sat,  6 Apr 2024 10:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JGhoVXKC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iQprUhMh"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED5517C8B;
	Sat,  6 Apr 2024 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712399244; cv=fail; b=FcdndiwH2n9jutw3ZKXdDlr3wgo4mzzwBZPsaNDSHKeEW5tSMy+Ev+tiev2CH9lee2WUIXWERpNEgqAptCsNoHewiOS+Po6eqMks5wqTlwoOLvnnYpDFdbB+8Hm3mIQnQ8ZvTB4fokseJnWQ75PeWCyv6qh2beLHp5F71lbIpp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712399244; c=relaxed/simple;
	bh=lvH85RdH+/Av5yjJlLkKUJllfndZewf/DX1gvLevGQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gupHKSRG99iP8A13qEMMXuV9sMo8/KfYSbRxKCJWCEs/3Z0SZ4kiTeoVQkFNjGbzL4rOlYXf/IgCoaJrYgHuTy9JRKPenSVDLHkUKdNOK68Ub1N4vmuocB9+toxDNlLvShL4nTv+kJ8u+cqFzBWBEUpXQkgJmvMLegOAOPh/OIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JGhoVXKC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=iQprUhMh; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712399243; x=1743935243;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lvH85RdH+/Av5yjJlLkKUJllfndZewf/DX1gvLevGQU=;
  b=JGhoVXKC5qHoReOVlDcUB+3rBN5TTkhaxayWe8469hHx6uWIxixnT8M/
   fKFCUEPkO86PjvqUZHkeKdpmQSNeAihM7VSHt5uFmQS39rZ+thAkwogHM
   dm7SrKrczaL1BwVIp20g7wuKO0nwdhrVSkKb+p1LtJoLpCkUHdopM+CKt
   gRwiprZgIBRW20ksMCwcnPmgpQU1dg0xFFp+hv6xAgZKuS25zqrBO0blf
   CzXE0af+JQYei0cgEPl2+WMWpCaLQoqyk5slwpAnQDc7W+rxPUXyZIQ50
   C4Wq1UZvd/6+5pvhhPNtrvJ+JbRoo3N0+WqjebCMJVrO7AuTpu4ytUyMp
   A==;
X-CSE-ConnectionGUID: eCZtK0b9QgOYMT2PqYIIzg==
X-CSE-MsgGUID: 1x1U9eV0Qq6z/IjDUAGdcg==
X-IronPort-AV: E=Sophos;i="6.07,182,1708358400"; 
   d="scan'208";a="14070134"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2024 18:27:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6qcBczfnKQmhcOpDoK+KTer4Y0/8O5CTORdknkxUWEsXHXjt9psZE8REV7SE1ntug/Qds9m86wiW88h0dOWXsVZl3RQh2092IPW+Bz7KBSKwe6lL4muP7+5V3k2GkCHu84jr8WgNqaIzYk2AnTXUzwwKzERrg8nuDEocy7vOGikdzealp0vxa+AUu/n/0Hyi3MZrYCFXTah8brbyWy4XyHxxBMrH038x6O7gixzq2cqRYnebnZxyhISLzdlxeyz4hYDFN7U5lGRRre8vP4HpUxgTTpM8XtLW/wEiDGrbm0Kh1fgDuf6Mga5WbYxz/+fr55YEaK+p0ei21mt81lnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvH85RdH+/Av5yjJlLkKUJllfndZewf/DX1gvLevGQU=;
 b=TG4ouYMFWov7CEcbTOCxXlLgZK65y2qMcMRSNlZsLjwS4YQWo7GXUq6geO2DwghBejWsf+XWCtrV7W7/Bur0gzI7MKp3EczdFn3zoZdC9Hj++0lHYzPMwVccAxM0u5KeODMNdNh/74tpYp2iCGo8jY7dMhPqBcVpr2d+yVB807fk8/qp779dCFZj4n1QN7Ieosr1kSFzRrAohYOsTa7Ck3voRnGypXEJWiMZYxqp9ro5fRk70LPvgaYsT9u9GAki65D/lOBx1vpPHzOtmRjW4JBFpfspmDRHQFnsVvhrrl4hBWbpFZprDesdfTFa5/c3i1D6WIwlxPBno7SHsG+waQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvH85RdH+/Av5yjJlLkKUJllfndZewf/DX1gvLevGQU=;
 b=iQprUhMhZq9OBgtGMVwee3CY8A6SOXUvHdRfn/tFeJa6bib6Ax/WS2lFpwJPHbjsXrTTHmac0Rde46VHiX319sfp7RSNEMs3PYmVnvERzws/LYGyQ2sbB+H+gmZaHQMNHPZRBUvSGYWiivIaoVDrdxqi8JsM85pt8YvXr9SxaDc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA3PR04MB8596.namprd04.prod.outlook.com (2603:10b6:806:2f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 6 Apr
 2024 10:27:10 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7409.042; Sat, 6 Apr 2024
 10:27:07 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Jens Wiklander <jens.wiklander@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "op-tee@lists.trustedfirmware.org"
	<op-tee@lists.trustedfirmware.org>
CC: Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Jerome
 Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche
	<bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>,
	=?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Subject: RE: [PATCH v4 1/3] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Topic: [PATCH v4 1/3] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Index: AQHah0/nox7783sO1E2O3HOOG3CvtbFa/2bQ
Date: Sat, 6 Apr 2024 10:27:07 +0000
Message-ID:
 <DM6PR04MB65757A966792C93334DE4BF1FC022@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240405115318.904143-1-jens.wiklander@linaro.org>
 <20240405115318.904143-2-jens.wiklander@linaro.org>
In-Reply-To: <20240405115318.904143-2-jens.wiklander@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SA3PR04MB8596:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MYu3Qk5EATUHl1j3fYqDbodWo57QUm/CW8OkYIonESo+elkzJBhWs9W77F99F8aGa32fMoRn8jkYCIVD3qf0z98jhgHx0/h8t7b0V5qvKmxMf6XyItIacWPwuYKwuDHscjBF7Y8+SKsEHE/b3j6oAw+F2YWA88vKSg0mwi2EVvWtc7svjPUzl97kG0mJ6oWOswW3rTS9qnQ74XzMaoUEFgQ/aNDSEOUmG2SK7NugLYLJB25N23alEGdSIhsats6b1AQg0eDJAF6VcQBOuG50uBPPTeot7pZ59k3vgG8h4oq3PCs4InFyykoMgWVNgLxSf63HaO72YCLVwzGSKjPy41agoehLvxkEBP3A02ew++c1V7bZkvCbOtA3IFElHGggwFE9SKQxgkLnrHekyDZBzfIJK4PbKQPeeGLxVCfcdHrZMSbk1SKeSX8MFCrvn2gXbngXD63HEJVcwq7trVjM2i3tNJ20ebOdtSwJ/C7NYuFWiCazGK9YwaHGFbRW+4QjDf+B2v3x/xcdHrTm8zftl3WGSHIRWt00gCWAeFzl80ErbW+e014iZgweZciyszg0llmyoBLyTmIBJ7EB3J3f2AYUeH+mjg1yt0H/oTzKrTw6boO6GAefw4HWfyeU/7kqbTjxIiDFo0MQYzwTj2GJGT3CddxrqPZXtlwy4Ae8BpM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWhWelhuKzZOK1VMMnN3bWcyL0hIWVNvME5RTTVxeHNTdC9OejRsVVpWcDlI?=
 =?utf-8?B?THluVHZOb2tmYlRhMmFIWnpRVmN1ejVxSCtibGt4VTd5c01qbEF4SjhkeHM4?=
 =?utf-8?B?RTV1Mk80V3dDTUV2dWRIajZzNTNxenl1RXZsZ24vL1MxditDWnJnTFo0WHJ2?=
 =?utf-8?B?ZlFvTlltVFR2enRuTGpDTzM0NW5TYzdCWFo3TG9Xb2NkYWZzWEI0ck40YWVP?=
 =?utf-8?B?aUR0MDMvbE1QVUxRcnF6YzVEVDQ5MUFXSmQ0REdmcG93cDlJSWJIR0ZzRXlE?=
 =?utf-8?B?VW53QVV1WGlENEIyNGpVeDNlSUczRnhwVS84M0pDV1kzMGdmTXhLYzV3MjEx?=
 =?utf-8?B?c2NVMjhaanBTMFVNVklreHk4SnZudmlUcHliOVp1Si9TWXExaFRTSGYwWTlZ?=
 =?utf-8?B?WnhKazJTVmJEVmdNZkNqL3hTVEMwTW9KMXEzL25JRFdwYUhuZExVZHNoeTBY?=
 =?utf-8?B?Slk0dUE0VmJ4VmtwZFNHMHIwREl0MG5IMitnSWZYZWF4WUFHbnU3NnYrbWUv?=
 =?utf-8?B?M2krTzYxdWROR21rNjFzd0RlQkQweFNxY3IvellHeUlZbE5zNTN1VE5Ba2tr?=
 =?utf-8?B?WFVzR1ErRXdReHJLQk40YUlmcW9wd1lUaXZjQ0pNUzhwK29QaVViWi8xSjYw?=
 =?utf-8?B?SmFrWW9Fd2NCNWJMRzFBOEhBekhsakFaeEozdUhwdmhsUHpuRmxnU2EvUUVy?=
 =?utf-8?B?SUtGWTIwcDBRQXhvTEdQcjh2SDBPVm5EVmdDMkQ0cEpIeCtSNlVMMXhrQ25X?=
 =?utf-8?B?bVV4dzJhNnl1QllMU1MwaUR5ODA4aEtvci9OekFiYzhpNE9GS21VK3dpcy96?=
 =?utf-8?B?VmtvSXpTK3lDSVZyM2FuMDJ1WUNING05Zm5IUlpWUjExbGRYMGpJWXA4ZjJW?=
 =?utf-8?B?ZFFmS3ZBUk1LTXhVczlJcWpPd21Ya2YyTlJPT0JwMkl1Q3BXVG1FYTgvU0lD?=
 =?utf-8?B?dnNUbGx6K0E4dk5YWXNnTXJuRWhsS1lEcGd2NEhFaEhNZXNyZURNM2MwclhU?=
 =?utf-8?B?dU9iY0dhSFFqWXZvcnh3WDFIRk1yeVBPLzcrUWczZVp3ZEM2V3BlbFJiT1VV?=
 =?utf-8?B?M0dwZjJHYUNCTzhKUG9PN2lONTJKZXc1aDdEazVEMHRQS2g5bk5hN3ltV0Jl?=
 =?utf-8?B?bXdzaTJLTFlLa3JmN1pvTXdvOFpNZzhVYTdTN3c2cHZMK2NJTjNNZ3ZjNDJv?=
 =?utf-8?B?VE5BN0VsL0tRTGltZkpyaVdUa05tQUFidVAxS1VZcGViNUh3TXBxbCtsbno3?=
 =?utf-8?B?aUV4bEZtK1NnNVJuckxxeXF6Rkh1S3J0dk9LekFKTnMrVk5qTDRtRzdhV2FR?=
 =?utf-8?B?NmtoWndnMlBzZkwvT2hzQkp0eGFEYlBJZDd5NHBsOElCd2JOZUxVeG1WWldn?=
 =?utf-8?B?RzJJaTBwU3ZncXRDUFNQVlBSTERWUzgyaVdFT3phOHQyRTZvMEJ1S1FnQTB3?=
 =?utf-8?B?Qzd6aUZrNWlwTitmT1VZekNmdlc2cUFoYVF6cjhtSHhJMzVydnBrUVRSR3VM?=
 =?utf-8?B?cWFkbWNoeGFMaXFUZHFJeTVsdksveHVybFdicWNqeEN5czJpcWhVOXZwZXNI?=
 =?utf-8?B?dUZGWEVZbnhlTTdqTktIOWZ4VzkxOFc2L2VLN3pjREJ2akVuakFWQU9zOHRI?=
 =?utf-8?B?RTlWVE1VcCs4OEhTaVVGVkFsaU1JZFJBNDh5K2E1SlRzbWIvbW1uQjI1N29p?=
 =?utf-8?B?MVdYQkRtVWZRMml3aGZRVTRaeFdhcnZpWE9LYnk4YkRVTzRNMkt1bEd1Z2NC?=
 =?utf-8?B?alBUdDFzQzNnRU1mSFdTRkFhZU14NTRhTlVpUElIcEZwdVplb3dCUTd0S2lM?=
 =?utf-8?B?N0lGSVYxZHdQYU5sMThhTXUrR0FCQ0JERGg0WDRMYlhpdUZSWldMTTNZUm5R?=
 =?utf-8?B?QW5lZ0ZBdk1yQzdMWEdyY2FYNFBZM1d1QW91TjVxWFUzb0NwT3k0Y29oTWZq?=
 =?utf-8?B?bEE3d2xtaVNYblBpRFRJNmtZVEVrd0xMZWYxZnN6a2paUXlhek1oOWpqa2s1?=
 =?utf-8?B?Y3pLaHVJQWp2RGFaZmRITncrOVpjWkNWRlM1czk5cEFjRHB4TlZ3WGc5V2gx?=
 =?utf-8?B?UUNQeU9xS0hWWFFGTVdXSTQ2QUNJb1Q1U2ZKaUZrWnFkakJIK2hRV0dKcWVw?=
 =?utf-8?Q?01dPaMEEEfH3zCem8vCyK1jsq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t1Hqf5osMAAuzIgzpOQ+vMThtXfIGLIISnQNX0N+EfRhZrv5XovYkgiH9IG9F5lTQv4NV971YqRgyKbi2OcJRBNmVNkZeQVaYpdYvtRPN8ASNqsnKiPYGD8Se0zy0lV2/rHcUVkNeOGE8fAYLWIW/d+oGw8h6vUu/xEzzfZYXgn+DS+fji8lKQOnJTxUvM0mtVPfgzl6hCoiup9WGsqlmoQRbQixQ//FHocSYcWlNROFMliaQUuN7KFvMea5hv1ScaN9ycvxIM7CJxX2CwLS/OzDXtE7xVSfDWocfxrkMS8WklCvOUX9ueQQkpo/DZBQ4ohgBi85KAUw0djR0yL76Xi1p7HtzeMh8I0dL/68Qhb26TqQ4+Z1hGEJQiLicnblVFn8PSuTiGQHy+TLVNpXVYdRvjEfPWYWVz6Trcok8rZy5M0hZ8lc64foKFGK9LSM6LVbUmpGEwqUZqQDvZZUWL8Y7mgk/nWHQiHTCctOxCllnJJosuRDCMfbUDsKFYonls1kY6hAjRS9o4rwkacJM7V+ZlP6xQlWHx+i0s/ytEWTqpVMfcP25ZTatQ767eBpPTCYEDsnY1S2w1cmXhYAOIzmox4CeBqLe9KLaLIVXKQ20J+su36hr0FYwTg0pw+H
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e552e37-28bb-4752-f9c7-08dc56241c94
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2024 10:27:07.7701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bgie1zhWOsZP32PVqYDLDNtGl83ACCfgQydXCVCe1dMGBrLYDMcHAE2bD2z2F3XvSvEMNt1uEvKgzcjOjxigYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8596

PiBBIG51bWJlciBvZiBzdG9yYWdlIHRlY2hub2xvZ2llcyBzdXBwb3J0IGEgc3BlY2lhbGlzZWQg
aGFyZHdhcmUNCj4gcGFydGl0aW9uIGRlc2lnbmVkIHRvIGJlIHJlc2lzdGFudCB0byByZXBsYXkg
YXR0YWNrcy4gVGhlIHVuZGVybHlpbmcNCj4gSFcgcHJvdG9jb2xzIGRpZmZlciBidXQgdGhlIG9w
ZXJhdGlvbnMgYXJlIGNvbW1vbi4gVGhlIFJQTUIgcGFydGl0aW9uDQo+IGNhbm5vdCBiZSBhY2Nl
c3NlZCB2aWEgc3RhbmRhcmQgYmxvY2sgbGF5ZXIsIGJ1dCBieSBhIHNldCBvZiBzcGVjaWZpYw0K
PiBSUE1CIGNvbW1hbmRzOiBXUklURSwgUkVBRCwgR0VUX1dSSVRFX0NPVU5URVIsIGFuZCBQUk9H
UkFNX0tFWS4NCldoYXQgYWJvdXQgdGhlIG90aGVyIHJwbWIgb3BlcmF0aW9ucz8NClRoZXJlIGFy
ZSA3IG9wZXJhdGlvbnMgaW4gZU1NQy4NCg0KLi4uLi4uLi4uLi4uDQoNCj4gKy8qKg0KPiArICog
cnBtYl9kZXZfZmluZF9kZXZpY2UoKSAtIHJldHVybiBmaXJzdCBtYXRjaGluZyBycG1iIGRldmlj
ZQ0KPiArICogQGRhdGE6IGRhdGEgZm9yIHRoZSBtYXRjaCBmdW5jdGlvbg0KPiArICogQG1hdGNo
OiB0aGUgbWF0Y2hpbmcgZnVuY3Rpb24NCj4gKyAqDQo+ICsgKiBJdGVyYXRlIG92ZXIgcmVnaXN0
ZXJlZCBSUE1CIGRldmljZXMsIGFuZCBjYWxsIEBtYXRjaCgpIGZvciBlYWNoIHBhc3NpbmcNCj4g
KyAqIGl0IHRoZSBSUE1CIGRldmljZSBhbmQgQGRhdGEuDQo+ICsgKg0KPiArICogVGhlIHJldHVy
biB2YWx1ZSBvZiBAbWF0Y2goKSBpcyBjaGVja2VkIGZvciBlYWNoIGNhbGwuIElmIGl0IHJldHVy
bnMNCj4gKyAqIGFueXRoaW5nIG90aGVyIDAsIGJyZWFrIGFuZCByZXR1cm4gdGhlIGZvdW5kIFJQ
TUIgZGV2aWNlLg0KPiArICoNCj4gKyAqIEl0J3MgdGhlIGNhbGxlcnMgcmVzcG9uc2liaWxpdHkg
dG8gY2FsbCBycG1iX2Rldl9wdXQoKSBvbiB0aGUgcmV0dXJuZWQNCj4gKyAqIGRldmljZSwgd2hl
biBpdCdzIGRvbmUgd2l0aCBpdC4NCj4gKyAqDQo+ICsgKiBSZXR1cm5zOiBhIG1hdGNoaW5nIHJw
bWIgZGV2aWNlIG9yIE5VTEwgb24gZmFpbHVyZQ0KPiArICovDQo+ICtzdHJ1Y3QgcnBtYl9kZXYg
KnJwbWJfZGV2X2ZpbmRfZGV2aWNlKGNvbnN0IHZvaWQgKmRhdGEsDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IHJwbWJfZGV2ICpzdGFydCwNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgKCptYXRjaCkoc3RydWN0
IHJwbWJfZGV2ICpyZGV2LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjb25zdCB2b2lkICpkYXRhKSkNCj4gK3sNCj4gKyAgICAgICBzdHJ1Y3Qg
cnBtYl9kZXYgKnJkZXY7DQo+ICsgICAgICAgc3RydWN0IGxpc3RfaGVhZCAqcG9zOw0KPiArDQo+
ICsgICAgICAgbXV0ZXhfbG9jaygmcnBtYl9tdXRleCk7DQo+ICsgICAgICAgaWYgKHN0YXJ0KQ0K
PiArICAgICAgICAgICAgICAgcG9zID0gc3RhcnQtPmxpc3Rfbm9kZS5uZXh0Ow0KPiArICAgICAg
IGVsc2UNCj4gKyAgICAgICAgICAgICAgIHBvcyA9IHJwbWJfZGV2X2xpc3QubmV4dDsNCj4gKw0K
PiArICAgICAgIHdoaWxlIChwb3MgIT0gJnJwbWJfZGV2X2xpc3QpIHsNCldoeSBub3QganVzdCBs
aXN0X2Zvcl9lYWNoX2VudHJ5IGluc3RlYWQ/DQoNCj4gKyAgICAgICAgICAgICAgIHJkZXYgPSBj
b250YWluZXJfb2YocG9zLCBzdHJ1Y3QgcnBtYl9kZXYsIGxpc3Rfbm9kZSk7DQo+ICsgICAgICAg
ICAgICAgICBpZiAobWF0Y2gocmRldiwgZGF0YSkpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcnBtYl9kZXZfZ2V0KHJkZXYpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91
dDsNCj4gKyAgICAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgICAgIHBvcyA9IHBvcy0+bmV4
dDsNCj4gKyAgICAgICB9DQo+ICsgICAgICAgcmRldiA9IE5VTEw7DQo+ICsNCj4gK291dDoNCj4g
KyAgICAgICBtdXRleF91bmxvY2soJnJwbWJfbXV0ZXgpOw0KPiArDQo+ICsgICAgICAgcmV0dXJu
IHJkZXY7DQo+ICt9DQoNCi4uLi4uLi4uLi4uLi4uLi4uLi4uLg0KDQo+ICsvKioNCj4gKyAqIHJw
bWJfZGV2X3JlZ2lzdGVyIC0gcmVnaXN0ZXIgUlBNQiBwYXJ0aXRpb24gd2l0aCB0aGUgUlBNQiBz
dWJzeXN0ZW0NCj4gKyAqIEBkZXY6IHN0b3JhZ2UgZGV2aWNlIG9mIHRoZSBycG1iIGRldmljZQ0K
PiArICogQG9wczogZGV2aWNlIHNwZWNpZmljIG9wZXJhdGlvbnMNCj4gKyAqDQo+ICsgKiBXaGls
ZSByZWdpc3RlcmluZyB0aGUgUlBNQiBwYXJ0aXRpb24gZXh0cmFjdCBuZWVkZWQgZGV2aWNlIGlu
Zm9ybWF0aW9uDQo+ICsgKiB3aGlsZSBuZWVkZWQgcmVzb3VyY2VzIGFyZSBhdmFpbGFibGUuDQo+
ICsgKg0KPiArICogUmV0dXJuczogYSBwb2ludGVyIHRvIGEgJ3N0cnVjdCBycG1iX2Rldicgb3Ig
YW4gRVJSX1BUUiBvbiBmYWlsdXJlDQo+ICsgKi8NCj4gK3N0cnVjdCBycG1iX2RldiAqcnBtYl9k
ZXZfcmVnaXN0ZXIoc3RydWN0IGRldmljZSAqZGV2LA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCBycG1iX2Rlc2NyICpkZXNjcikNCj4gK3sNCj4gKyAgICAgICBz
dHJ1Y3QgcnBtYl9kZXYgKnJkZXY7DQo+ICsNCj4gKyAgICAgICBpZiAoIWRldiB8fCAhZGVzY3Ig
fHwgIWRlc2NyLT5yb3V0ZV9mcmFtZXMgfHwgIWRlc2NyLT5kZXZfaWQgfHwNCj4gKyAgICAgICAg
ICAgIWRlc2NyLT5kZXZfaWRfbGVuKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIo
LUVJTlZBTCk7DQo+ICsNCj4gKyAgICAgICByZGV2ID0ga3phbGxvYyhzaXplb2YoKnJkZXYpLCBH
RlBfS0VSTkVMKTsNCj4gKyAgICAgICBpZiAoIXJkZXYpDQo+ICsgICAgICAgICAgICAgICByZXR1
cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gKyAgICAgICByZGV2LT5kZXNjciA9ICpkZXNjcjsNCj4g
KyAgICAgICByZGV2LT5kZXNjci5kZXZfaWQgPSBrbWVtZHVwKGRlc2NyLT5kZXZfaWQsIGRlc2Ny
LT5kZXZfaWRfbGVuLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR0ZQ
X0tFUk5FTCk7DQpJbiBhZGRpdGlvbiB0byB0aGUgZGV2X2lkLCB3b3VsZG4ndCBpdCBtYWtlIHNl
bnNlIHRvIGhhdmUgeW91ciBvd24gSURBIGFzIHdlbGw/DQoNCj4gKyAgICAgICBpZiAoIXJkZXYt
PmRlc2NyLmRldl9pZCkgew0KPiArICAgICAgICAgICAgICAga2ZyZWUocmRldik7DQo+ICsgICAg
ICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gKyAgICAgICB9DQo+ICsNCj4g
KyAgICAgICByZGV2LT5wYXJlbnRfZGV2ID0gZGV2Ow0KPiArDQo+ICsgICAgICAgZGV2X2RiZyhy
ZGV2LT5wYXJlbnRfZGV2LCAicmVnaXN0ZXJlZCBkZXZpY2VcbiIpOw0KPiArDQo+ICsgICAgICAg
bXV0ZXhfbG9jaygmcnBtYl9tdXRleCk7DQo+ICsgICAgICAgbGlzdF9hZGRfdGFpbCgmcmRldi0+
bGlzdF9ub2RlLCAmcnBtYl9kZXZfbGlzdCk7DQo+ICsgICAgICAgYmxvY2tpbmdfbm90aWZpZXJf
Y2FsbF9jaGFpbigmcnBtYl9pbnRlcmZhY2UsDQo+IFJQTUJfTk9USUZZX0FERF9ERVZJQ0UsDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZGV2KTsNCj4gKyAgICAgICBt
dXRleF91bmxvY2soJnJwbWJfbXV0ZXgpOw0KPiArDQo+ICsgICAgICAgcmV0dXJuIHJkZXY7DQo+
ICt9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChycG1iX2Rldl9yZWdpc3Rlcik7DQoNCi4uLi4uLi4u
Li4uLg0KDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uMjUx
ZDZiN2U2ZDE1DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvaW5jbHVkZS9saW51eC9ycG1iLmgN
Cj4gQEAgLTAsMCArMSwxMzYgQEANCj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBCU0Qt
My1DbGF1c2UgT1IgR1BMLTIuMCAqLw0KPiArLyoNCj4gKyAqIENvcHlyaWdodCAoQykgMjAxNS0y
MDE5IEludGVsIENvcnAuIEFsbCByaWdodHMgcmVzZXJ2ZWQNCj4gKyAqIENvcHlyaWdodCAoQykg
MjAyMS0yMDIyIExpbmFybyBMdGQNCj4gKyAqLw0KPiArI2lmbmRlZiBfX1JQTUJfSF9fDQo+ICsj
ZGVmaW5lIF9fUlBNQl9IX18NCj4gKw0KPiArI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ICsj
aW5jbHVkZSA8bGludXgvZGV2aWNlLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvbm90aWZpZXIuaD4N
Cj4gKw0KPiArLyoqDQo+ICsgKiBlbnVtIHJwbWJfdHlwZSAtIHR5cGUgb2YgdW5kZXJseWluZyBz
dG9yYWdlIHRlY2hub2xvZ3kNCj4gKyAqDQo+ICsgKiBAUlBNQl9UWVBFX0VNTUMgIDogZW1tYyAo
SkVTRDg0LUI1MC4xKQ0KPiArICogQFJQTUJfVFlQRV9VRlMgICA6IFVGUyAoSkVTRDIyMCkNCj4g
KyAqIEBSUE1CX1RZUEVfTlZNRSAgOiBOVk0gRXhwcmVzcw0KPiArICovDQo+ICtlbnVtIHJwbWJf
dHlwZSB7DQo+ICsgICAgICAgUlBNQl9UWVBFX0VNTUMsDQo+ICsgICAgICAgUlBNQl9UWVBFX1VG
UywNCj4gKyAgICAgICBSUE1CX1RZUEVfTlZNRSwNCj4gK307DQo+ICsNCj4gKy8qKg0KPiArICog
c3RydWN0IHJwbWJfZGVzY3IgLSBSUE1CIGRlc2NyaXB0b3IgcHJvdmlkZWQgYnkgdGhlIHVuZGVy
bHlpbmcgYmxvY2sNCj4gZGV2aWNlDQpUaGUgdXNlIG9mIHRoZSB0ZXJtICJycG1iIGRlc2NyaXB0
b3IiIG1heSBiZSBzbGlnaHRseSBtaXNsZWFkaW5nLg0KVGhpcyBpcyBiZWNhdXNlIGluIFVGUyB0
aGVyZSBhcmUgdmFyaW91cyBkZXNjcmlwdG9ycyB0aGF0IGlkZW50aWZpZXMgdmFyaW91cyBjaGFy
YWN0ZXJpc3RpY3MsDQplLmcuIGRldmljZSBkZXNjcmlwdG9yLCBnZW9tZXRyeSBkZXNjcmlwdG9y
LCB1bml0IGRlc2NyaXB0b3IgZXRjLiwgDQphbmQgcmVjZW50bHkgVUZTNC4wIGludHJvZHVjZWQg
YSBuZXcgZGVzY3JpcHRvciAtIFJQTUIgZGVzY3JpcHRvci4uLi4NCg0KVGhhbmtzLA0KQXZyaQ0K

