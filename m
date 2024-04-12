Return-Path: <linux-kernel+bounces-142117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 133DF8A27BF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF8F281D86
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF814B5CD;
	Fri, 12 Apr 2024 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JqcmA4vF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WbQRvCIp"
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3933F4655D;
	Fri, 12 Apr 2024 07:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905970; cv=fail; b=FApX+zfmmoduc2DL/4FdYhINNkws40/Nec2EW1ETz9UOSheSRDk/TPlQY176jXpjj9AeRcg8GWnMNBnpt4RV8d7vqIHW/Jj0hzTeX+p8kyS1oYoAw43cePlE3jTodNOj5tJ8F+TignMUirmnR1xC6Y5LVml+wLvHToesHXCaTK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905970; c=relaxed/simple;
	bh=9qiOkHe2S8WeLlp0MyuDAuH/AtnDeCTTdA/HQxeAK7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cf+Qtg+boM5rHG2ygyS1EfNQu1/goKZop7pb/Eh5mcqQp0jynXHzIbzl/Cx0YpGzXz6IXEZcawV3cctLgaU5DthApjmv2uy2usZ2kogxjmsWj8Ad/hnOM28gDVz+b2vAnOzHI6xZR+0hA24ijeL285sXt+8VCjMcebRGf59IN+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JqcmA4vF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WbQRvCIp; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712905968; x=1744441968;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9qiOkHe2S8WeLlp0MyuDAuH/AtnDeCTTdA/HQxeAK7U=;
  b=JqcmA4vFSmO2Ugx7kACw+rqkPJk7cXlCX7sGWvLLZSh7cXkOAKdBggHF
   ONAa+7YECBXD0LcW++8M4bt+NXDXk8zEgV3i6IogBR/dgaWmLIEohefZW
   y9l1+nGolRe9a3rWrM9FFucsi1fmsFYPGt5yFBRlAZ4pkrQRVD4qdZB/T
   LnoxqxhYZ3RWtSbtlik7vI+0CxuKgkyuiEH/yhcfaEFJ9cyXfU9rQW6lb
   XdX2i9jRbDK/R7YnJTUi93LQzIlqdTMOn4Uv42Rd6uLctimupPtdwODFs
   CRlvGAgVkqXVkloueqbC61efmxsjKZRN1K7ad65JLnqkS/nqnrNrV7BX0
   w==;
X-CSE-ConnectionGUID: qm81SHSGTsSeptzo5mmBAQ==
X-CSE-MsgGUID: HCIyG+MbTi2b21YaCppIZg==
X-IronPort-AV: E=Sophos;i="6.07,195,1708358400"; 
   d="scan'208";a="13297940"
Received: from mail-eastus2azlp17013021.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([40.93.12.21])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2024 15:12:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtvcUk3vYRLQ6am4Z6ez16/QyWmGbUEOPDuLEoQ1S4gqMEZpCY0gZvmMfjb4LL1Ydcm4MhBlytcJcr2wokXBa4ma9ArLNhls+WKndgPscSPdkFFetOJ7WToJkDGFQPq9by5jpc9JrtOFQbAZy9ClWsSV+HNMh7HAWtvjsxfAHqqu7Mjifnh+Sv18lrQFmhfKykzhEHf0MblJQVPyMDLGb809jcEzZ81PQAE9MwtDQLQK0ZJCVmPyFHNAU/YzvtVr9+RaAuk17D9BLSZWltRTo6skxjACyP+ixflqRS2C4pW1jsEJ60U84Y97QP18DfwkYc9skVWznjphFCDXWsLBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qiOkHe2S8WeLlp0MyuDAuH/AtnDeCTTdA/HQxeAK7U=;
 b=ap4Hl6TPXVgRDRDEourXf5FE58bqtgBZ/It32fiEn/r622WsjGfc6smtMmGWVY5VdPmRUWoQljBt2f1d0sm9TdQps97lUFKXbcxCH2pl/pUZsTauX62jjvfq/kqiUH1JMdfFWQnCpbOqk3RgAuQ7t9PJ3yIBgFzP1H7vNWdWXjfst+ivTEZ/QHISmhuCX9AUTgeWhBelpZ9rE7z9RLEqU8fIEXBA3MEkffAkN7q7i6kbr2OemNkshsWDvtyfbVwKRSe7C8sX3utMO+l8wx6+5TF+VV7SaFgc3f+yBVqyJdHJDqCDW3XIG6WiDpa5ml838gBsNZBj7OjjXYFOQtY0Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qiOkHe2S8WeLlp0MyuDAuH/AtnDeCTTdA/HQxeAK7U=;
 b=WbQRvCIpHZZ7AXP0UPgBkJi1e5CoWhft0v9hhUTztRHUYEFydRJZ3SfPC8M2MHQY+GMniYOpePkhKzaD1vWU6x2pYz7pLoTm4B8AVbx5Tzhek3xH1XSBz7w4BRRvwXl1B4EdYEjxkKfeZoJHuDaVDqwbhDIErlNGZrgiEwhZabk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6309.namprd04.prod.outlook.com (2603:10b6:a03:1e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 07:12:37 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 07:12:37 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Saranya Muruganandam <saranyamohan@google.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "tj@kernel.org"
	<tj@kernel.org>, "yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>
Subject: Re: [PATCH] block: Fix BLKRRPART regression
Thread-Topic: [PATCH] block: Fix BLKRRPART regression
Thread-Index: AQHaiwSINB8WBnJl30qPCQCcaD9o87FiKqMAgAIQ7IA=
Date: Fri, 12 Apr 2024 07:12:37 +0000
Message-ID: <zvmwp3n3yx55ogzb5gtfe2xdmsg53y3umgnezcwd4weq5vloru@w6qi7lfvezls>
References: <tnqg4la2bhbhfbty3aa74uorkfhz76v5sntd3md44lfctjhjb7@7qbx5z2o7hzm>
 <20240410233932.256871-1-saranyamohan@google.com>
In-Reply-To: <20240410233932.256871-1-saranyamohan@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6309:EE_
x-ms-office365-filtering-correlation-id: 1c57d12d-f612-4dfa-a202-08dc5abfef38
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1RKilA5qts2cEDnicfvhsmIiI5XU00aFzyytUsThz0qAKW0dp8GSGLg0YPgNq/PnSFhFukkF0/2wsPgceCyrFkBotFnMevOB09bJj/n7xiGwCMagsaw45u8hRXDZvfQ/8+HOj0YMCZLzHIWGwWf9eEoqtxL6OINsVxxYMnwDG1sbxCTqrwejzRHsWRm7dNmeV4JUP+GA16xTyLag2SLHckAWvMPQY+EMWBUa4rwwysXW+mzytZkLYwlH67Z86l1RJ6kKvtscYDwHN8x6brFP3BSb4auvRhlIZ7lN9uV+fdbr8Z12yL+O4YNlXLuaf7ifLtIfmZ4yfPmfjX23cKK3sw4FMIbvmLLnD90oRa1FW0Q1EG4+cM//bxfnEXN2Jnbw+Db3FXDahtadEOQbrXXkdBu6lLs8qvs+/EAZWhUjaxwua5mzMb7HyD77+dvZIZO37sFRMwK+03pOZlv8pO5egflJp+L/kVC90quKKYjMxJ3xf1W759aeUfzMGghVLKe6OkIrHLyO8tnwislWL5bPe4zA78RXy+M1oFNLKkOaMeducDYLV27xy1zQXu9B07IFWrJWu+sUc9Gk1diRSGtpg5zCyX4NcAb7KkBIzzVMQkJQdy66/Ymh0p3qyo8zErdOS44yWAEHhbT799A1BM6hH3p024xMmdTBa0Mi7H7aPWOkN95RDd4z8Pc/YbvaXiFTmjGNMu7sjWVHVCBgnOJWNV/f7+jlY3T/AI590BO6c2g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NBiioRM4Dq/XtoUpZT/zeWBkzBItj/n+bldykSkPMYxasHl6Fsu8p4wKfsXa?=
 =?us-ascii?Q?cqHNTQ/TiazGu4AeNHN/vk9AFYMPYe5zFfnLj9BJG08XqJlwoLKiVzvTnAUh?=
 =?us-ascii?Q?qUNr94xCkcmpNc8kBleEHkoDFu9gYdhWX36A/h4/M0gaLUvP2OFILIWNXTBF?=
 =?us-ascii?Q?Aa99Hz9xDYk/btQLtvxBOy657yUhXCmONI7p3xw5i0/EArEaX0sIt+cdNESP?=
 =?us-ascii?Q?PD+nIBWCKqHLg4v1cOUhTy4i1VyhltfjSxA7dXENAbDQRhjl+3eBvvPU70hw?=
 =?us-ascii?Q?B+meNIXzjHd8nZ45j3mBrcAIeWy0fd73lOhlIf+JscAYqt4jtHL23IFDsUti?=
 =?us-ascii?Q?yhCxGNnjDLV9ljd4qsMk1xvUPYJtovyXtELuCFGDxkeaXNwO5xB/hi2AQqzV?=
 =?us-ascii?Q?inUQnsvRal5JjS9vD5bIVBLyjpMLaiPX5BDizvvrpIboRo4UW00b94SRt72q?=
 =?us-ascii?Q?xia6pI3OCAgtPwZT0y1N8XxZb+eABXep3PDml4eX8tF7SEFdRUhaRySW/e4L?=
 =?us-ascii?Q?HYr+J2ftoozBqJQMwFgxlzKgsF/jxdBgasm4DUZltO9W4tisxq1+WnvQjyHc?=
 =?us-ascii?Q?3r2eIm9jc6OziNZMp+miaF+ITdIPzKb9r07rUnKbBlfCv2He23TwvuF7URBA?=
 =?us-ascii?Q?fMQoEynb+Zw4jaRuCRkmPoLEdODBT0YI38s94SvxZrNCMXoR8t0KG03vy5+7?=
 =?us-ascii?Q?/Ss+4IQVSLysJNLwGkvp4VLjIjHnNrBa5rpMCQJo1iW/LWnnqAfekcUfnl6g?=
 =?us-ascii?Q?iTu/uNYwIml+gGNwscpe588MVPPOlADyISJ2X2OMK8XHXwgL5FpOzQPPkZbN?=
 =?us-ascii?Q?6ARxYP6nBqHnWBS8B5qnJC7YxGIQHI55ZYKVZVtqicUSQrN5u9L3ej9S/Tpp?=
 =?us-ascii?Q?gvfWEkF45fOQCXUcsJEjVmvjJgqixdsMAs03v7U1765NjiRWMhtX6Ey1Z3Oo?=
 =?us-ascii?Q?PeDfEDgDaeEOrTZb2p8598y1IJr/GZxwH4jps6l5zMDuFFyBd1w918E6TQqb?=
 =?us-ascii?Q?uWprvo1MgVl22KprwtDxFnukgi3uDDlVdMj2+04x8FZEXfhO+NAZv1gQG+3p?=
 =?us-ascii?Q?i6G/W3NFClkhCh0CJJpS1ZqxyiUoE524k8e+TswXzZ+mvPUklz3Tw5R8Q08d?=
 =?us-ascii?Q?CLDNasp/lkg1q3vMnXzUOcVGXX62/6fUm+zW79pSDxMAZS4MFrNLNIwfEyG5?=
 =?us-ascii?Q?dJIxzN9dRrTh29j+Dcb9rw0967NgoF1sQdNho46OMonDu0uJ5FgTIAkPSd4c?=
 =?us-ascii?Q?QdETyvM0BSkmc/HPaW8WYius2di+v3mIn9pbmg6uNW400iFfz2WbX7oSYvWA?=
 =?us-ascii?Q?kD27zfMjf75y84QJyQP7yOl4fWlyccwWeRmuKsP8ZlGeGf7Tgh+syq/x/qU5?=
 =?us-ascii?Q?/bCM9y1i4c+WPn9TE2MtZpCf72rEFOGHnbmnPVBlMY/+LqJL7625VAO3qUX+?=
 =?us-ascii?Q?TbSjmT9tQNRdnuemN1uleBiqXXGRV+DD20JP8/pWYZkXCBxA38Ly+3oePDGw?=
 =?us-ascii?Q?yhcZPYNCVwweHqcBi82q/0jHGPxYfvldKl835mIbGhTv0mVgHrrVH+rcSJxA?=
 =?us-ascii?Q?tHGX8TD8/jSYdniND0SM76z6OBUuPs6QemiE7y+t5+4ucAojQ8MOwVnrgsXC?=
 =?us-ascii?Q?AFWv/ESif2QbDjL82rYRf+s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E7C95529097DDE429B38B49B8AA3ADB7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xg7UqeNzbGyAiPEwLZ+C4zkLTlR46c3nKHVq0uLEbq7dpUWUBJLmSs0DLDLCCI8OQBsMOqFBnI9fuzR1SmI0RRV+9k9+DmIQpC4mGye22Zj1YIUrvi+II8I7/tuLzo2UeagAD91ag+WxitjBmGjwu7wen3xsbDjFqUk8I6laJqwdG0h3qQBrK/GuxYPwZmLN5yJF1Q411Q7k+CJYxc/zPEDZxhto1vbOy4KX4reW0dW3WDljCKe9n4sf2R5pZH5mlN43h4Hvsepji2BBkXAnOHFH7fWL9j2r/N4oLW6aC9A8ltKVh6hMBU3VK8Q42tb1bmgVBYPUaIoBeDaK/WIh3EwcNLCsyhsdtL+cIw3VeDzKAQtFI0ReN+R+C+QileFXLC8VZws7QyAMtxT43iuKJcfI+BOyAsklW8C/GPNNYhSwKeXgJ/IMoADPQRkcKVdvDocX1/HXBvaX0AaqZPC1oWXKLfbFD0hq44IlFyAiON1+KcNzW4qGoC35/BsgU35YkE0eGOfdAZFSvbcjV3sJf1izg5I0ggGpXG70PmvdFvmkkyTCsg9s6bA4MfcFAc+I/Eo5rdsiXtNz/IjuU6KsT/8+ROugXA17+dgD8zMzUhKCWSN9B6MPvAYCLecgj2VR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c57d12d-f612-4dfa-a202-08dc5abfef38
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 07:12:37.8052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J21s3qC8yMSJuPh9TwR74VXCTO7RvwZEf9v/GN/w5GPYUym/BKNEL+zS8+ksryjp5jDTj+sH5F5a1yOCVemaUK/2WZS2Ip/pZPV2AKM1gZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6309

On Apr 10, 2024 / 23:39, Saranya Muruganandam wrote:
> The BLKRRPART ioctl used to report errors such as EIO before we changed
> the blkdev_reread_part() logic.
>=20
> Add a flag and capture the errors returned by bdev_disk_changed()
> when the flag is set. Set this flag for the BLKRRPART path when we
> want the errors to be reported when rereading partitions on the disk.
>=20
> Link: https://lore.kernel.org/all/20240320015134.GA14267@lst.de/
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Tested: Tested by simulating failure to the block device and will
> propose a new test to blktests.
> Fixes: 4601b4b130de ("block: reopen the device in blkdev_reread_part")
> Reported-by: Saranya Muruganandam <saranyamohan@google.com>
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>

The change looks good to me. I also confirmed the fix with the new,
corresponding blktests test case.

Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=

