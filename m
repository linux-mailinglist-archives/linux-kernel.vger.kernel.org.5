Return-Path: <linux-kernel+bounces-3192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAF48168DF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251B51F22F52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85171097B;
	Mon, 18 Dec 2023 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="gNMDWy+S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB9E10945;
	Mon, 18 Dec 2023 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4UsnYYgl/jhsCKuuBzPVDLT1yDhrdM44lbjQfyadKfEqZSehPGtYVTXtlnMlh0ObQY5YKArFfTQPvJfGHy0bz2mnsTQN4UP0SxOZGtKoBALcdSKqCDM7QgPHPBZtvZJTykL7/NHXykcJMULwXoeEc9WjXPNf5pl3+2r+9xCvo7XF4edcmv5BQILrRLH6dYo53RdBVUVtFg2EN90S4pQW2I/ezmbUT2I1/5kQLDEuLU87mVhn3AivQoYD4isLVjrmbLMoxdJPWGsAhkYj0uZNw8yFSf9VfuRL2eoq29bSRPHgPFUsZW4UGGkgPujTkm+WDf22ypje8l+IWRXHq/O0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yU975NSkeUvPa/7r56o+4apDy1VByIzIvc+oMEQ+j7w=;
 b=C0uQoqMvdm5HW5uREBm2NbnTZk5qQkM1MD9bvRQHEXRoT/kk6zFKKOgA4CnniATtFt7/3W2oSOjBQLWi2BAxgNM/0px0/4DD0rlVsQQ6Zo7LnwDdOOuYmH/150J5hlMnhwn8IbAHGOW6CCuhAl8aiR+LntoJNxFFDqkpIQoS1BLZYNSQ1LUKDty1REiUxlNqLXlERItJHuUZOQ6ZuMdSB0vF30zRVckfd5ZEpP2gs4F47apVb4nzPNI6EYmCgLziFydoCKncUa3tW8deTh4SIToL51jdpb4s7qCkBHEynInCKPA4HKwgU4NTiaZPyC7P55NfxmtIf60jIHMulnLUNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yU975NSkeUvPa/7r56o+4apDy1VByIzIvc+oMEQ+j7w=;
 b=gNMDWy+S+yGWNmob+p3RZsuGXPLKfim3IpiI0O/tdmNWKaksXtYza+idXKOdqNMBBrovbd4jVEfAgekUM3wjCT73s2JMAIAhmqKyRPXB5whMf/rbKhCu1lPAmH9iijGkjLNKlgTGV7/hO2hEruXfC8HKzNCrZxHOk3h0cIxrJ9T4Up/Hax66qV7T9qzXbJ6vnFSo9PS2U0pyPwoT6f+D7YVKPRqBDV0mYEI1iQHEr0wUxJk+qMJ/O+xS/Rubf9LA+1BztdRuSdkY7uv05cRD6DpC5r2xCtOfMUEunhwGem8XUpNmNH6q1kUxQib694GdxXq5kLSCYiADXBF/tpeBVA==
Received: from PH0PR08MB7955.namprd08.prod.outlook.com (2603:10b6:510:11a::17)
 by LV3PR08MB9170.namprd08.prod.outlook.com (2603:10b6:408:21f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.16; Mon, 18 Dec
 2023 08:56:03 +0000
Received: from PH0PR08MB7955.namprd08.prod.outlook.com
 ([fe80::c91e:e46f:6de0:65f5]) by PH0PR08MB7955.namprd08.prod.outlook.com
 ([fe80::c91e:e46f:6de0:65f5%7]) with mapi id 15.20.7113.016; Mon, 18 Dec 2023
 08:56:03 +0000
From: Srinivasulu Thanneeru <sthanneeru@micron.com>
To: "Huang, Ying" <ying.huang@intel.com>, Srinivasulu Opensrc
	<sthanneeru.opensrc@micron.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "aneesh.kumar@linux.ibm.com"
	<aneesh.kumar@linux.ibm.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, gregory.price <gregory.price@memverge.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "tj@kernel.org" <tj@kernel.org>,
	"john@jagalactic.com" <john@jagalactic.com>, Eishan Mirakhur
	<emirakhur@micron.com>, Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
	Ravis OpenSrc <Ravis.OpenSrc@micron.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory tiers
Thread-Topic: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory tiers
Thread-Index: AQHaLe1WCWEmLbBSRk2O5Sdey42WeLCpzLPHgAT264E=
Date: Mon, 18 Dec 2023 08:56:02 +0000
Message-ID:
 <PH0PR08MB79551628EFA3B1B3CB55DFFEA890A@PH0PR08MB7955.namprd08.prod.outlook.com>
References: <20231213175329.594-1-sthanneeru.opensrc@micron.com>
 <87cyv8qcqk.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87cyv8qcqk.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=True;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2023-12-18T08:56:02.479Z;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=0;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=micron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR08MB7955:EE_|LV3PR08MB9170:EE_
x-ms-office365-filtering-correlation-id: e81d6057-80d9-4b5f-a131-08dbffa729d4
x-ld-processed: f38a5ecd-2813-4862-b11b-ac1d563c806f,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EbkqUwY3OW93uiNqG0ufFu4oim2o3uiHccpzg4XpFjisarlptNG14kibvsioA6aIpp1ZY6sCPocwt/S2gnkAFeIjfJEslC9R4x89gCRtZz+1NPZ+HX/er1VHBca86y43M3SvZrNnwSckgxLBcepv7p+759uevGuP6FNW8H8ljU1vpf4aHww0GGzyB7bYn0ghMtrqK6zO4aHgJNBT0IAHzCImADWJxq69o9wtKcmvQyvN7Ygp7YmXfYeEAT8xdTckofCY2JqcFeBhk9IicPEOjF7ji08rWZEYF9r553ijnWUmBGulEA/SQqANBC/av8M7bVI+uZZwWHUf3+gvIi9kqTIJDCZga8b2bTZrd3qA6qggVu8SdkNjSnY3sbcPCImgcTUa6ZkQoS+D/cXG/XefHsJ4vJvbkUZcZXmVN6RxTsn0kQ5NEKjLO+3GFcsW+7PWnUjX3s9ydaE4p4I/4ZJINNAj0VMCf8s8oGDjBarb0j0o5fXuCiqply3db+r9TVn3NwzSQ4l8boZVmPmPEh29OJQxCJFoVRL5SreEaHx6FJ6YgBQB4gxocW4NttA2f3vEQMmrYWawDfIaTjFjfIM6rbIuDPkwS6+owOJdqqxq+Bk9QawYKPCS4Jl5gasNoFvhqDbMW6WKpiEB1/fOatx75w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR08MB7955.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(230173577357003)(230273577357003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(66556008)(66946007)(55016003)(110136005)(6636002)(64756008)(91956017)(66476007)(76116006)(66446008)(478600001)(316002)(54906003)(38100700002)(26005)(966005)(4326008)(53546011)(52536014)(8676002)(8936002)(6506007)(45080400002)(55236004)(7696005)(9686003)(71200400001)(7416002)(5660300002)(2906002)(33656002)(86362001)(122000001)(41300700001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?N254MlhMR3pRcm1NMDBzcUV5L2xIQ2JLTDNzWDlsc0QxME1WNDQ1T0w5elQ0?=
 =?utf-7?B?YmdUYkJPdFVGUnpveWRpRVE1QjNiL09adTBLcmkwbklTcWUrLVRCTWx3Q0Jj?=
 =?utf-7?B?QistcTB6MEhEem45U3FUdEpwYm4vNFFobWJWQkNMY04xaTk3aE5hbjhJb1pQ?=
 =?utf-7?B?M1hYYkQrLUdwc1E0R1NYdi9xenFxcVdrU2JQQjBoYk5lMmExbXRob01Mc2RV?=
 =?utf-7?B?WGRWV2Jwb0pEbER1OVluVEUvVjRKdG5rZVJUMG5yREJIU0VCQThEeENCY1dP?=
 =?utf-7?B?RWlkUEg2TUc3bkxXMjdxZ2JUNENQUEVuTzU5OWhIaWNRSmRwM2hpcWlTZ2hR?=
 =?utf-7?B?a2RPeWlhOGE0cnlJMUJXSkkvQ3FIRWdhZktWczJjemxMUGNwdjdLZE5KYURk?=
 =?utf-7?B?YXdRWDc5RW5mekdlcERZNElYMmd1Wm81RXR5cnVMdDVDdHRjZTZmR0JrelMx?=
 =?utf-7?B?VlBxMTkzL1FFSjhGRElIRmVvSjdzMjF3Z3VmRDVnYWlOSzFZb0c5VG1jRE14?=
 =?utf-7?B?S00xWTNNeTNjbVl6RUJTOVozWXpwa2hoTEYvV1AzNVZ2QmJDVDNJMVhUYzg5?=
 =?utf-7?B?NnBzTjRsSmdqa3pPbEg3NEhudm5kQm5NNVh2a3hVdmJOcDhnendhVkFib3Bk?=
 =?utf-7?B?dDNvTmFiKy1OUFlobExnSVdMaWhwOGRRTVhNdzhYQTc5dmROZFplNm85bjdz?=
 =?utf-7?B?L04zcGZaNnBEanY4RGFPajlxMlNWUWZ0eTVSSzNhRnpic2pjc1NZYlc1YWYx?=
 =?utf-7?B?Ky00Vll0cDdWTVdCZkF3dEI0SGF5ZW5EVFBFRFhOakVsVS9ia0FYREY3NnBF?=
 =?utf-7?B?NzFaTS9OOHc5Ky1uZVJWeDVlcFpMNm1xOWZMdGlaQUc5ZmRINDFmeTRpWjUy?=
 =?utf-7?B?NUVVUjhIS2RFdWErLTZsUEFCdVBHbUx3MEZ5blhxdVE4U3lJenN3bm51amtK?=
 =?utf-7?B?R0RvdDZGbDBGY2M5SzlCOG51RjhuT2xjZ2ExUllSM1VTREI2N2s5RGo5ekNP?=
 =?utf-7?B?N3JuajljUjVmYkF5a1hrejN6MjJRdktub3NsY00vT2tvUnZaQThZa2J3a1hm?=
 =?utf-7?B?ckRmNXJNNEwrLWZzZVhCa1Rqb29aak1XTmF4Yk1ZeU94dG92cW5ySmg0S3k0?=
 =?utf-7?B?ekVuR25EUENoNGk5RkdLVkFLVUVUR2xUc3l0MGdtbFVxYzFCbDVadnoxR0t5?=
 =?utf-7?B?amhES1MwS2kvaU4rLXRMcE4xTistQ1BwcUw0Y2Z3RXBBU09rNWJ4WVdWT2E=?=
 =?utf-7?B?Tystc3pxbGNobWUyNWRrcG8yZGc2a1JGTWVSeTZaMkoydTNtdy9jV08wVmFy?=
 =?utf-7?B?aFU0RE0rLTQvbDJGSEtYZ0I1Zzljck8wMGZvRmlHbnhlMHIwWm5LTXlPejU4?=
 =?utf-7?B?Z0R0TUFibE1zKy1nRWQ1Ky1nS280Y2lKKy1LOVorLTAzc3NaSnJQZENZME85?=
 =?utf-7?B?SVpCWVhRRnlscmo5eU9TdWFLQmZlSEVnWVZnVUk1dWswamlaTEtHWUhoczZ2?=
 =?utf-7?B?bnBrVnhQalNDYWplLzNNNm9oWEdFU0R3RkZRc09DZjFUdUxFQ2tkVXhxem4v?=
 =?utf-7?B?eTlneDRUMEM5SjczczVnV3RLTHdPc0tKZXRzRDYzS3NaKy1KT1lLbkRwc2V6?=
 =?utf-7?B?YTVneCstR2FKd2pJRjVBUjIwZ3FFaDZjU3NCbU9rdjVkZ1FoQVJ1MDBycVU4?=
 =?utf-7?B?M3lWc3dEeUxYMzc5aXBPYkpYYjZSeGNVTnkwYWJidkRpdkdvN3dUY3cwR0pL?=
 =?utf-7?B?NXZXbkhTUHhsTlRYRGJ0UVdiNlNvWEFGS01hRlJTWVlYWUZtWEFGL2lvV1ZM?=
 =?utf-7?B?bE5LZ002WWZlZ0xZblZEVlRPZ01QamdUdEFwam1wT3VEYU5ESjBZbS93T0V4?=
 =?utf-7?B?anJjaXFIUWdGVGNRMjRQaFh1bkMrLXduaUtBSG95WGhlb2U4S1ExdzNBbSst?=
 =?utf-7?B?MGhFS1VCSzdnMzJtRk95WXJzNHFsQ3ZiVzFnZUs4MFMxOGszYjZpWVFFNC8y?=
 =?utf-7?B?d2JuL3M1VUJDQmNRRTVKT2IvNTBxenhlKy1zY01lNlhMOWpMcnJzYjhIOVJD?=
 =?utf-7?B?YlY5NFpTL3crLVlaWVYzUDY3VGcxeFlsQ3o1d2tickFTYVliSkJZcystYmdE?=
 =?utf-7?B?VnJTMistV09ORmZoeWFvVTBud3pZR2l0S2hYL1hIYWxUQU8xd0RRcTd1cWFT?=
 =?utf-7?B?Z2ZvS2o=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR08MB7955.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81d6057-80d9-4b5f-a131-08dbffa729d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 08:56:02.9369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: poFjYyaKuu93QYLy4x2V9TY9rKjoeRHbAFgDP1k/ew3Z3Zls7pGTNNUyzJpojf03ZTTWaTi1EbpNjzVj/CNF1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR08MB9170


Micron Confidential



Micron Confidential
+AF8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF=
8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF8-
From: Huang, Ying +ADw-ying.huang+AEA-intel.com+AD4-
Sent: Friday, December 15, 2023 10:32 AM
To: Srinivasulu Opensrc
Cc: linux-cxl+AEA-vger.kernel.org+ADs- linux-mm+AEA-kvack.org+ADs- Srinivas=
ulu Thanneeru+ADs- aneesh.kumar+AEA-linux.ibm.com+ADs- dan.j.williams+AEA-i=
ntel.com+ADs- gregory.price+ADs- mhocko+AEA-suse.com+ADs- tj+AEA-kernel.org=
+ADs- john+AEA-jagalactic.com+ADs- Eishan Mirakhur+ADs- Vinicius Tavares Pe=
trucci+ADs- Ravis OpenSrc+ADs- Jonathan.Cameron+AEA-huawei.com+ADs- linux-k=
ernel+AEA-vger.kernel.org
Subject: +AFs-EXT+AF0- Re: +AFs-RFC PATCH v2 0/2+AF0- Node migration betwee=
n memory tiers

CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you =
recognize the sender and were expecting this message.


+ADw-sthanneeru.opensrc+AEA-micron.com+AD4- writes:

+AD4- From: Srinivasulu Thanneeru +ADw-sthanneeru.opensrc+AEA-micron.com+AD=
4-
+AD4-
+AD4- The memory tiers feature allows nodes with similar memory types
+AD4- or performance characteristics to be grouped together in a
+AD4- memory tier. However, there is currently no provision for
+AD4- moving a node from one tier to another on demand.
+AD4-
+AD4- This patch series aims to support node migration between tiers
+AD4- on demand by sysadmin/root user using the provided sysfs for
+AD4- node migration.
+AD4-
+AD4- To migrate a node to a tier, the corresponding node+IBk-s sysfs
+AD4- memtier+AF8-override is written with target tier id.
+AD4-
+AD4- Example: Move node2 to memory tier2 from its default tier(i.e 4)
+AD4-
+AD4- 1. To check current memtier of node2
+AD4- +ACQ-cat  /sys/devices/system/node/node2/memtier+AF8-override
+AD4- memory+AF8-tier4
+AD4-
+AD4- 2. To migrate node2 to memory+AF8-tier2
+AD4- +ACQ-echo 2 +AD4- /sys/devices/system/node/node2/memtier+AF8-override
+AD4- +ACQ-cat  /sys/devices/system/node/node2/memtier+AF8-override
+AD4- memory+AF8-tier2
+AD4-
+AD4- Usecases:
+AD4-
+AD4- 1. Useful to move cxl nodes to the right tiers from userspace, when
+AD4-    the hardware fails to assign the tiers correctly based on
+AD4-    memorytypes.
+AD4-
+AD4-    On some platforms we have observed cxl memory being assigned to
+AD4-    the same tier as DDR memory. This is arguably a system firmware
+AD4-    bug, but it is true that tiers represent +ACo-ranges+ACo- of perfo=
rmance
+AD4-    and we believe it's important for the system operator to have
+AD4-    the ability to override bad firmware or OS decisions about tier
+AD4-    assignment as a fail-safe against potential bad outcomes.
+AD4-
+AD4- 2. Useful if we want interleave weights to be applied on memory tiers
+AD4-    instead of nodes.
+AD4- In a previous thread, Huang Ying +ADw-ying.huang+AEA-intel.com+AD4- t=
hought
+AD4- this feature might be useful to overcome limitations of systems
+AD4- where nodes with different bandwidth characteristics are grouped
+AD4- in a single tier.
+AD4- https://lore.kernel.org/lkml/87a5rw1wu8.fsf+AEA-yhuang6-desk2.ccr.cor=
p.intel.com/
+AD4-
+AD4- +AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0-
+AD4- Version Notes:
+AD4-
+AD4- V2 : Changed interface to memtier+AF8-override from adistance+AF8-off=
set.
+AD4- memtier+AF8-override was recommended by
+AD4- 1. John Groves +ADw-john+AEA-jagalactic.com+AD4-
+AD4- 2. Ravi Shankar +ADw-ravis.opensrc+AEA-micron.com+AD4-
+AD4- 3. Brice Goglin +ADw-Brice.Goglin+AEA-inria.fr+AD4-

It appears that you ignored my comments for V1 as follows ...

https://lore.kernel.org/lkml/87o7f62vur.fsf+AEA-yhuang6-desk2.ccr.corp.inte=
l.com/

Thank you Huang, Ying for pointing to this.

https://lpc.events/event/16/contributions/1209/attachments/1042/1995/Live+A=
CU-20In+ACU-20a+ACU-20World+ACU-20With+ACU-20Multiple+ACU-20Memory+ACU-20Ty=
pes.pdf

In the presentation above, the adistance+AF8-offsets are per memtype.
We believe that adistance+AF8-offset per node is more suitable and flexible
since we can change it per node. If we keep adistance+AF8-offset per memtyp=
e,
then we cannot change it for a specific node of a given memtype.


https://lore.kernel.org/lkml/87jzpt2ft5.fsf+AEA-yhuang6-desk2.ccr.corp.inte=
l.com/

I guess that you need to move all NUMA nodes with same performance
metrics together?  If so, That is why we previously proposed to place
the knob in +ACI-memory+AF8-type+ACI-? (From: Huang, Ying )

Yes, memory+AF8-type would be group the related memories togather as single=
 tier.
We should also have a flexibility to move nodes between tiers, to address t=
he issues described in usecases above.

https://lore.kernel.org/lkml/87a5qp2et0.fsf+AEA-yhuang6-desk2.ccr.corp.inte=
l.com/

This patch provides a way to move a node to the correct tier.
We observed in test setups where DRAM and CXL are put under the same
tier (memory+AF8-tier4).
By using this patch, we can move the CXL node away from the DRAM-linked
tier4 and put it in the desired tier.

Regards,
Srini

--
Best Regards,
Huang, Ying

+AD4- V1 : Introduced adistance+AF8-offset sysfs.
+AD4-
+AD4- +AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0-
+AD4-
+AD4- Srinivasulu Thanneeru (2):
+AD4-   base/node: Add sysfs for memtier+AF8-override
+AD4-   memory tier: Support node migration between tiers
+AD4-
+AD4-  Documentation/ABI/stable/sysfs-devices-node +AHw-  7 +-+-
+AD4-  drivers/base/node.c                         +AHw- 47 +-+-+-+-+-+-+-+=
-+-+-+-+-
+AD4-  include/linux/memory-tiers.h                +AHw- 11 +-+-+-
+AD4-  include/linux/node.h                        +AHw- 11 +-+-+-
+AD4-  mm/memory-tiers.c                           +AHw- 85 +-+-+-+-+-+-+-+=
-+-+-+-+----------
+AD4-  5 files changed, 125 insertions(+-), 36 deletions(-)

