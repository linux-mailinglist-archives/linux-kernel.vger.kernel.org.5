Return-Path: <linux-kernel+bounces-92703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AE687248C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F0C282DBE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BC4C2D0;
	Tue,  5 Mar 2024 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bL7yJobJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="X1JUHtuO"
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E44F944F;
	Tue,  5 Mar 2024 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656959; cv=fail; b=mwUuuGvxcjmYUnFQ7I4Bz+aImIVSIv+XNggEmtn1wWeg3UoXyqnYRfUUJt1+oaqIBKRW89JPTEJfKdLz7+Y2wUCFsyAI7FqFP584o9FUm1Bkn4hXMkg9MUG3WVGocRD0L9JRuP0+CG0B063quni9rAm17I0zT7wUSrSR3n2GkgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656959; c=relaxed/simple;
	bh=x6PdwjhV/q70Wuoto+WJN+pA7gCbA5IcUmFKwu8/14c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=foM99/+y6aSmBl3xE08Na1KSYAE7UUEHhPy75MLnwSCJlsJF69M/Xjj2CZlz4I/RvuZdjzF+edW23mgR1vbcrD5TtQHU9Qo+TBGRIvtQBnheIlaXYUc3Isl9imNx/xo9ZDuCfP925b+kMAUhGXDzpYYXWOnzjCiUMrbZ+y5IzSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bL7yJobJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=X1JUHtuO; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709656958; x=1741192958;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x6PdwjhV/q70Wuoto+WJN+pA7gCbA5IcUmFKwu8/14c=;
  b=bL7yJobJTyEbUfdzfXrP6bNSF2ch73mjhHwhuabXPxetPqYW6s9yagYW
   qOXC6SuE/DpuSm+Mxtr+SjMBaMda1zS9WWk2E0O43d8hTD13lWckItiWQ
   pOFJgkUbzuws9OrpA3qF1ws8NdrFSMUPNgTT6YE2mk7ne/voBMo+GuVzS
   mM36ARTNEZMPmosD1VAHsuHM42VoLVLjAxCDJSYvWnPSWOns/fgWu0+wY
   kPECP6L5YJw/+lLBzki/5vPVY5ZTkJpJqiHVW1ZphZ82U8LeabQVmjXrn
   U61oprJ3fVoRqODt0j+fwbFjSv00LLpnFdf/M1BASMQlYReJMcudk71sJ
   A==;
X-CSE-ConnectionGUID: FmhicIZFSeSdD8/FkR5mqA==
X-CSE-MsgGUID: ecjLHCSJSNiSx/CXCtPKTw==
X-IronPort-AV: E=Sophos;i="6.06,205,1705334400"; 
   d="scan'208";a="10710937"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2024 00:42:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILPegAmK9STNw8ipT9OPQx9LttoF9UoCGwh1bKZ1O8K7qA3UoxYQfTXkJv/lxnQWfBn/21+gMzvqTzj9y5jUrYliAs/u1GWeTZDG8gyJU1mouYlGSuV1V9Gg4jYlXEyWBZRGcVOU1mlN7zjme3JM6w47KodFkBj/mhufHHF1xln54xLVQygtjlc4ymbp5N8BVz3ttO80XPjGIlsVQi/52baypMtAi280CkRhGvP8Ff9mlPUVo3ncN7GttyZt4WgcWvSqhPWsFkCWeUBwuPp+3y5h2bCUXgXIv1LZ02myEvlIhqO8O71AeXqukzz5OhUvZmsPvm5bG5hAf1wlo8Amng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6PdwjhV/q70Wuoto+WJN+pA7gCbA5IcUmFKwu8/14c=;
 b=XPSOUTnh+i1uFDD6UyxR/o5Y2kPB7E9BsC+60RVIGkmofRfWTOUOw+VqCUysx1oaIup9+O1QuTb+7zfo2ZM2/7oJxICegDLZiFnSHCbmyL6uzRsgJmBRNYTEBzCAAlIDri0MUM/w+AOIC2szFS8wEheZw3DdTp2V1okr8N7Q0TvkfOG2NOGDRYJmCadl0D6HV/+CcKfCLV/iZSBX+OOiYbFx5Kgseb6ZU7Vu0ZKBwu4qkqHxEG7LJ2o2a90CFA5mB0aPaQPy/lIHIguk4Ns/xXz2rdgMNgkSc5edgGKna71D0f6J8bGGOqCcYv4EnPkhItr67D077BxrfZwEdto3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6PdwjhV/q70Wuoto+WJN+pA7gCbA5IcUmFKwu8/14c=;
 b=X1JUHtuOjZUoj31nfOF4UsmshrkYtJ60Zi/N2EDHpO0VT+G1YCWh3Tdn/eDymDr62uWkfBONZtJ7lzcJWyesyzbct3T1+lJWEj0xIYKR0X8IYP+zjgt1enZPoaUVzj+i2GSCO+Y2uvNzu78yv/Aatmxd2Sz/VCGZih/0BhflzTY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB7620.namprd04.prod.outlook.com (2603:10b6:303:ad::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Tue, 5 Mar 2024 16:42:30 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 16:42:26 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc
 @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, Shyam
 Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg
	<sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart
 Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, Ard
 Biesheuvel <ardb@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>,
	=?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Subject: RE: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Topic: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Index: AQHabvgRHYnDBx+cqkmeMEfcmLAlb7EpVJaQgAAET4CAAACOIA==
Date: Tue, 5 Mar 2024 16:42:26 +0000
Message-ID:
 <DM6PR04MB657511E98570A227AD1AF40AFC222@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
 <20240227153132.2611499-2-jens.wiklander@linaro.org>
 <CACRpkdZBWBio8kvKuVzj2CknCb4eS=VB2EqUsAK-vf4e328icg@mail.gmail.com>
 <DM6PR04MB65759DF9CAF6ECB5BA78E138FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
 <1859f2a9-b3fa-4d41-86e6-aa0a18fddad4@app.fastmail.com>
In-Reply-To: <1859f2a9-b3fa-4d41-86e6-aa0a18fddad4@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB7620:EE_
x-ms-office365-filtering-correlation-id: bef36b23-930d-4b89-1832-08dc3d333db2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GEnOI5RgPjXhrpuhQj25K8BRhw5jzc3tIKPz/QDRMqACEq1V/5Gzke1ZAbEZWiVy2U9iN+7XqkDx3e16pJQhOudYyDUUHkdbrdhsVzOZG1JDCmqM3pwofhPJDSt2/4HHoE9/NC+FYGcKSRd9ZBMfRAi8BU2/WTjF6Z7/P7m3t6OgqswUJfRnTmLgVtjw1+9FcJjXMv9vQCQ4nbP4zLKRO27gh6xjyk2QuIYcu8lXyZdnShr/nrks7Vi0G9lRsmgYqt+ujK8DwWSgqN2FL/Ey+0e6aFHepuQ8PLQ6acvt+pRlMqqt8k3zLT+lPJanIHfSK1KA1fTDr0CzEKrk/DqmZBfSeInagzBg1xoiF3uTEwRjQIlX0p2uveOFd/9B63e6LNAq2zi+iGDpL79YctRfQAGqowLKhtnl9bFABgA3GIawlrwojJdVaw1grpJd9i9QH6cjOiReURqcS5BNlQ4npNwN7zxJ05yvDEb8p9zpoQdD+Ti0eCJXQipqWz9Uj9DeWSeYPZnsgp1Q6VxDh66FNFOWeSoePELvWzqU1+FJxFQ3958QG5L/8GdBZUqA4JS7ZLBFzqzSntCFwxKTVwLSefLBQnAIgdqpc+U3Lj7pv/yNmF7SZkLP31bCxsS+NcU2Dt/WxWy3oy1DFG7jVpEPSM/WqxA6w+Aop5c+zvEWwsU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MExUeVRzLzJ0WWU3anliUE45dmcxOXdTVnpIMG1tcjBBR3RuQUpoL01yRUR0?=
 =?utf-8?B?ZGVZSWhobjdJa01KeDRPTXNncER3YzZYTHFSRjVWRkJUUFpLY09hRFgwQk9Q?=
 =?utf-8?B?bWM4UWcwYXUwSm11Y2F1M1hmY0Y4QzhlalI1bjlyVmVma0lIVWMvUmdJNzBx?=
 =?utf-8?B?MnRRWklOSXNjNmFQQTI3Y3JPSUN6VGJDT05oS0t2OUVkZ2tZcjFuOVlzM1dy?=
 =?utf-8?B?UkhSSmg0RHhPQ0FzTzlDNEI1Q3NJTWJHWXlYenIvWTRqWEJQUkh0czNoWlFl?=
 =?utf-8?B?MVkvaFpGcndDcDVFWXIxSTNvbFNyWnFOTllMMkZWUTJjTTBSRmFZR1JIZFJt?=
 =?utf-8?B?RmFQQURjZm9BLzM0VC9vSGllMVlUand2UE9NRTJzM281UE5scEdhMXorcTd0?=
 =?utf-8?B?ZUdMeGFZOXVKQlFpNk1wYmlBaG5LK01OeXZJcmYxb3NOQ0VpT0JqT0M5emgw?=
 =?utf-8?B?emNESnlSQmY1dHpqenlsRlRTR2NvZDdScGE3c2RCQVZiK1RhZG9SVG5yTmdN?=
 =?utf-8?B?aE4vZEM0TnhkdnpwWW5RMThzbE9PSXdVcDM0b2xrUWdTNzl5UXNSaE9veHFD?=
 =?utf-8?B?YTdPdUhWUmo5YWZ5dnBScW4zT1JsdG9TYm9ROFlObVBLTno4T0JUVkQxdVBS?=
 =?utf-8?B?NFRsUkUwdExVTWFvOW1qZ1k1TzUvelRIRVRaSTQwUmhDSk4yMlkzaUIwNExZ?=
 =?utf-8?B?SURBKzhPUFRORjU3ZVVIelV1YmE1dGFmcDJORi9qcmdXTGY0SFYxbmszTk1a?=
 =?utf-8?B?OGxMZWMzMjFoSy9DY1FnZENiTEhLcllLbTVQOHB0NXY5WXFoREJnNzExQVdC?=
 =?utf-8?B?NHJzVklnaWpjQnlqU1EzRmFSSWpjM0VrSXcraWRLeEYvU283U0RVWCtQcFpa?=
 =?utf-8?B?YnFUTTlXMDArbW53eXBZWmF4aWNoelc2R1ZpRGMwMnY5bURFdWRQbThOR3dj?=
 =?utf-8?B?YWYraXVuY3BYMklPQktyM2pWbW9leVR4QWxaTGpDTmRxT3BLWkpmUWlKc0lN?=
 =?utf-8?B?em1yMXRpZTJOVVgxOUN6aTFTMjBRY0VPVlpUaFlWS2I1QkJBdC80NFFUM01r?=
 =?utf-8?B?dEpKWW5qSFVNdGwzMXREc2cxZStoMzNCNnN1ekgybktXSnF1TU8yZjNQcnNm?=
 =?utf-8?B?a3lyYmtyenIzb29Gd2sxTS9KUEtTQXAvSVViS0hWVnJoZ0UzRzRjNXlaKzYx?=
 =?utf-8?B?ek1ZcitUbFAvV2RqKzA1by9VMXd1bldQMkE1NE9PKzB1ckkySXQ1aFhkeXlU?=
 =?utf-8?B?Ri81THJWM3RhRG40eGRBVHd1U0tBT2RvTzUrSnBjR2Z3UGU4WEJpWlNuZWNH?=
 =?utf-8?B?VXlkRlhFaXVVRy9MSzdjSTM2bThQUXNOMHlrRzhVTHZFdUg2c05EWWxhZWhG?=
 =?utf-8?B?eTRvTHZ1YWpwa0tEZWxCaGtycTBGZ2lPR0w3Ny8yTEpCektVbzVTT3ZpZ2da?=
 =?utf-8?B?eDgxYXdFSHo5RWQySTFwclRPdFJjQVJQTlV3eGhYRkhiMEhDS2F2Z2lsbjlX?=
 =?utf-8?B?ejl3ZmZCeWc0bmI1cVJKSUptU0ROcG9wTUl2UUJray9TdWxJck9HalVIaUpM?=
 =?utf-8?B?L1RKS04wSW5oZStZanF6aERoNXRPUEtZNERoVStEcXVCQ1kzR0lRY09tZG1l?=
 =?utf-8?B?RnRFa2pzSUYzSGVRRGhyYVE5bU1GQi9iejNyYXIwS2c3SWNMWnZMUU9qVG5o?=
 =?utf-8?B?S1FiM0hVSE9ua3VlQzlqbjhFanAwcEJ3c2E5TldHRWJvUGZRUHIyRE1iNE1y?=
 =?utf-8?B?OHAvN0VUZjBOUERFWGwrc2huR2ladTJlU0hwUUcremloc2dsV1dtbWZoY21x?=
 =?utf-8?B?VTBveXZXSDYvMkRJaDJ1b0pKa0wzNStVRjgyaE4vNlVNbGFBRWZmTmpSem5N?=
 =?utf-8?B?OHI5S2pRd0g0bSt0Z0g5MDgxc2JHTmtzOTI5bnQzbG1RUEhWMWc2eS8xSjly?=
 =?utf-8?B?bGRuL09GWklPWmVvVHVFbVVsWm1OOGZXR3hmMFBjWjFoa1VLcHUrTmFJOU42?=
 =?utf-8?B?Wi9XcURJd0dvUStYU1F3YmpXc0dOR1JtbnRYN1RsZnRRTlRaeFpqeUZPa2h0?=
 =?utf-8?B?c2NsdmE2bUVsVWg1Rk1TQzByKzB1SzZWQTJCWk1hUVdoaTlkRG12WnhxMnRT?=
 =?utf-8?Q?KjHPTljOb1J14FWHjd75ZihC3?=
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
	yjdQSBON7Mk6NXLriXJJQzxEaTClZHZXpSTxMDFNca8fZdoD3xA+xN8CmiD/OgBXukeRCysUGteEGCqqoN51jHB3y2JPZLOM75MfMSFTG+yIm++LzhOjgrYfkNk3B3/poypl/CfSTZ6lp5SISrKhK0poNVtyIQK3GkXbVsUUcEeWpQA9CPSn5Ijk+5N84RVtno5GfQBVXsLkPT1uDoKYJY1e2sGPM+twAEQnMbtWNStzZThKyDRUw0XRuRt4+fpkEfn0BDDNlRjZ8O4sy0REfaQEAf7t8IfcBog/jnxLyJdgy7ITTrHio0F2ncHG9ajSI0gNDj6RGl0HWhlZcNIOV8XTcbi46m/cQ7WFgUGBCvgPyUtkbLgWejGa8n9wu2wMaxxXBikOKSnF7lYOdkDjYmMle1qMJVtuR7es2iHYPeRqwwXiUnZTVU1HjZmOewGEPWxNLVRhxSeGjrmmnAz9xWINUe/866eQXBaPj1wakBKC1Dv41HFRH5IJm0pWmleZg2OYqW0fGMR+U/Rmu6psVII06C/kllL1eS/jZNyxWBjTx6ljWj8ul/Ssy1WGPqjFRrIlo4F8f8+enJ9NEEsyyyrj4O9XccHz2sIhZsFEGgFzY8eJMwn1EDfJhJPcviW3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef36b23-930d-4b89-1832-08dc3d333db2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 16:42:26.7030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GN+7odDf4zapuhyuu5QAowhMDmPCkskx7v5qAqUoDO2fx3WGgq3pA1Nyu+FqwILVUFZj8RILRYhJLDOXU+ghJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7620

IA0KPiBPbiBUdWUsIE1hciA1LCAyMDI0LCBhdCAxNzozMywgQXZyaSBBbHRtYW4gd3JvdGU6DQo+
ID4+IE9uIFR1ZSwgRmViIDI3LCAyMDI0IGF0IDQ6MzHigK9QTSBKZW5zIFdpa2xhbmRlcg0KPiA8
amVucy53aWtsYW5kZXJAbGluYXJvLm9yZz4gd3JvdGU6DQo+ID4+DQo+ID4+IEkgd291bGQgbWVu
dGlvbiBpbiB0aGUgY29tbWl0IHRoYXQgdGhlIHN1YnN5c3RlbSBpcyBjdXJyZW50bHkgb25seQ0K
PiA+PiB1c2VkIHdpdGggZU1NQyBidXQgaXMgZGVzaWduZWQgdG8gYmUgdXNlZCBhbHNvIGJ5IFVG
UyBhbmQgTlZNRS4NCj4gPj4gTmV2ZXJ0aGVsZXNzLCBubyBiaWcgZGVhbCBzbzoNCj4gPiBNb3Jl
b3ZlciwgYXMgdGhlIHllYXJzIHdlbnQgYnksIHRoZSBkaWZmZXJlbmNlcyBiZXR3ZWVuIG1tYyBh
bmQgdWZzDQo+ID4gZ3JldzoNCj4gPiBJbiBtbWMgdGhlcmUgYXJlIDcgcnBtYiBvcGVyYXRpb25z
LCBpbiB1ZnMgOS4NCj4gPiBJbiBtbWMgdGhlIHJwbWIgZnJhbWUgaXMgNTEyQnl0ZXMsIGFsc28g
aW4gbGVnYWN5IHVmcyAodXAgdG8gaW5jbHVkaW5nDQo+ID4gdWZzMy4xKSwgYnV0IGluIHVmczQu
MCBvbndhcmQgaXQgY2FuIGJlIDRrIHdpdGggZXh0ZW5kZWQgaGVhZGVyLg0KPiA+IFNlZSBlLmcu
DQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXNjc2kvcGF0
Y2gvMjAyMjExMDcxMzEwMzguMg0KPiA+IDAxNzI0LTMtYmVhbmh1b0Bpb2twcC5kZS8gSW4gbW1j
IHRoZSBycG1iIHNlcXVlbmNlIGlzIGF0b21pYywgaW4gdWZzDQo+ID4gbm90Lg0KPiA+IEluIHVm
cyBycG1iIGlzIGEgd2x1biBpbiBtbWMgYSBwYXJ0aXRpb24uDQo+ID4gQm90aCBwcm90b2NvbHMg
c3VwcG9ydCBpbiBtdWx0aS1yZWdpb24gcnBtYiwgYnV0IHRoZXJlIGFyZSBzb21lDQo+ID4gZGlm
ZmVyZW5jZXMgdGhlcmUuDQo+IA0KPiBIb3cgc3VyZSBhcmUgd2UgdGhlbiB0aGF0IHRoZSB1c2Vy
LXZpc2libGUgQUJJIGlzIHN1ZmZpY2llbnRseSBhYnN0cmFjdCB0byBjb3Zlcg0KPiBhbGwgdGhl
IGhhcmR3YXJlIGltcGxlbWVudGF0aW9ucz8gQXJlIGFueSBvZiB0aGUgY2hhbmdlcyB5b3UgbWVu
dGlvbiBnb2luZyB0bw0KPiBiZSBub3RpY2VkIGJ5IHVzZXJzcGFjZSBvciBhcmUgdGhleSBvbmx5
IHZpc2libGUgdG8gdGhlIGtlcm5lbCBkcml2ZXI/DQpCb3RoIGluIHVmcyAmIG1tYyBycG1iIHRv
ZGF5IGlzIGFjY2Vzc2VkIHZpYSB1c2VyLXNwYWNlIHV0aWxzOg0KSW4gbW1jIHZpYSBtbWMtdXRp
bHMgKGlvY3RsKSAsIGFuZCBpbiB1ZnMgdmlhIHVmcy11dGlscyB1c2luZyBpdHMgYnNnIGludGVy
ZmFjZS4NCk5vIEFCSSBjaGFuZ2VzIGFyZSBuZWVkZWQuDQoNClRoYW5rcywNCkF2cmkNCg0KPiAN
Cj4gICAgICAgQXJuZA0K

