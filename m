Return-Path: <linux-kernel+bounces-10466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D38281D4B4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71233B2102C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB45312E62;
	Sat, 23 Dec 2023 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="fCbmebVm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2109.outbound.protection.outlook.com [40.107.121.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF4C12E52;
	Sat, 23 Dec 2023 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMQ6cX8+dtDOxLY4KjLnVSp6BENd0770j1CR6a0I6BlS/INiEcky03v2R8a24EM6nbSqdQbNcA1XEIg2RL4E/H9W385CzUUQ40fiNqAwDfp+yM4AEniZvXT8+r79yRR3Fevxfpj5rYVs4L1UfLtUFJ4olgbCEOCwHcJ+ukpYBWM2AvkENlg/UWFkDx5zFUfg+cseUeHZtUC5V79Fnmkd8eGYc7MvQVNJPJL9QoLX2voIgSzVl5z8VBtwb1nauRx82E15kptkmgrG6iCIvh5QALixHm+8eFkayY5G2MyEEvl2+AwOavJ/hF0nQYs0JCfXw17Kd3J4qKRBVI+qTBKuaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9kAkLeaTY7PUtIotc0GGoIMfUT0m1i/I6nMD/hn4IM=;
 b=RAuFgNmqbqZe60EnvHOONloFBtfTD63EeuPNzPLKMxeATBlCDr1P8UuAQrIBmX8FhuyXGWB/9juQAC4Of3paNaOiYH42n/z4Leg9PrWNoxoJvdROmxLbqTp/3uTf8FHhauB0pLgNFRoOFN7CPDt1yUHMq3VNvUNLY8V2GULsvRv+2uxF7yCV0iIcgUxtr9mU+WeYtqdGsv5tmjEgT1PFCm8PGDZpvC7e7krW/Si2Z83oQx0KJMIy3or7qgso31U8fALWQuro7wUzER2wa8lxOpORRT3R6HKx6GltjS+bXwAVWkNyMn+7BYTU3j6OatGSS8sp9CMAXvtzvqFqVFYBoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9kAkLeaTY7PUtIotc0GGoIMfUT0m1i/I6nMD/hn4IM=;
 b=fCbmebVmTYZ1sw+QVTiKrsc5lUQa8/5Nvn+P50UKitHkQUi+wK6ezVniDQT/AFOiGkzH6MXOuRNJ0gn/5Ad7RDgcC28L0wsX/EauRHQcDvjq9Z94VZZRILCKHGYjKUAhD97dRnz+4c2BcVxAjt27Lxy+8XgYrg8olJu4sRE0J7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB5747.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sat, 23 Dec
 2023 14:43:11 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ec07:aa7e:ffbc:ba47]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ec07:aa7e:ffbc:ba47%4]) with mapi id 15.20.7113.023; Sat, 23 Dec 2023
 14:43:11 +0000
Date: Sat, 23 Dec 2023 14:43:09 +0000
From: Gary Guo <gary@garyguo.net>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo
 <yakoyoku@gmail.com>, Tejun Heo <tj@kernel.org>, Wedson Almeida Filho
 <walmeida@microsoft.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] rust: workqueue: add `#[pin_data]` to `Work`
Message-ID: <20231223144309.3bc42ecf.gary@garyguo.net>
In-Reply-To: <20231213220447.3613500-3-benno.lossin@proton.me>
References: <20231213220447.3613500-1-benno.lossin@proton.me>
	<20231213220447.3613500-3-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::20) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: bde98005-a658-4677-7c27-08dc03c57c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MvAhM+YgNkE0L00JYcvQgaaI42KSnTaGeo/R12JRDALe8IqfLpMQAHoOeXXWPem8YMJDVgIUgTe9QGJya1YlNmv/7NpQKK5kF/58s9K9nyNfBRLvS2ELtCfhIBUzYuvWpDNAlSGFmoSkWpkApDqx87MxWn13FtlL8YFi+glA3CX7JmLIwv3w3/d0ggD3vph8Pf1NiN3PjkqV5NnqNDwpy8UoMSPlgnITefnJb42amDyAXpVuGBqIffBPwGjkdFudr460U7R79hmdFNBDdIfA0cq3gRJYabhf2CarKdgjtPhndXIyXBatkGndiubYeiLXGtzeTxMNOKvL9L05HEnSQBm2DeN6TMhTlqliwDACJGdnt1Lz0ryNlCjwnwooB1zzU21u+pzL1x7BKcCVX5um0YvkBYh4Qx4Y8i369gaJTqwW3/LGP2xx43C7kIpK+dTJ0Xc7VC/X0kPWxfPW8dorPKtpgIsucz/vexI45VLjq3XkljZ6zE8ps7EJ8SjtKnVugLX59NMJb+jRSLGQ4mtym1XMljj23ROEBrH7lRasqpOhQrTk7mVacdo6QqCjWIbpn+nXZqz3VvN1c6szmAH0KEGxBFSPbqxB7EJbbTiwLAU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39830400003)(396003)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(1076003)(2616005)(6506007)(6512007)(36756003)(86362001)(38100700002)(5660300002)(7416002)(8936002)(8676002)(4326008)(83380400001)(66476007)(54906003)(66946007)(6916009)(66556008)(6486002)(41300700001)(4744005)(2906002)(316002)(478600001)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IyyXCvhxFUEWRFUJjn3xdRlaWNJUD/zGeQtXOb0eCtTgGpM1pbGPsnHmwhmy?=
 =?us-ascii?Q?has++O2KGlDCVB31q7LnRSCK0ZzfMHsfl/PTf5p1QMU5vW2A85A0vs5RTjVC?=
 =?us-ascii?Q?9p5s7nFO58zvU8e4P7BsODkQaqoswVHYCRMlPVpqkxfdlY/HDvfor5Wnv2Qh?=
 =?us-ascii?Q?HrMeMYK2f49vlc/3uz3HWcrBfmPFsPg44UTCzYHp4Lo5Dk3aV/m2RxoQwnvW?=
 =?us-ascii?Q?I6nO38zhlZv4MotXxTVo/izSIzlLhc/JKUtBBaLTnix78YD1mKQ1FLVgcKpS?=
 =?us-ascii?Q?1fzqgFONkGsqSMMApRi32M8wTZaGBrwydxbx9FitlmTVmGHRcZK42yy5X9+t?=
 =?us-ascii?Q?40Fm7mXx5OUd1GVGi/4M7Hu0OJZh6wWK6isSJuf6h+7sfXX141STz9yDpKmq?=
 =?us-ascii?Q?Ik0FFJIPsW+iURpPbAeuewxHoEGUV/ktFA4Ec+fhL1ETJjsmDyNfC8RUPLE8?=
 =?us-ascii?Q?pcPq8O2cyeO7ElTEVMDsi4U7WWRR9xd7un5rtIJz2ZWYp50PpE48Je60h0Wr?=
 =?us-ascii?Q?r+RYPSydkoCzcVaETc4/Ul/cAMg27Cmg2sgpIsgqbaStOhQmvXhUGWpX2/Uw?=
 =?us-ascii?Q?UKOGUWCo2NMuC7KdkufDKr19dvCqIJ8ok6xj6ftbNRNt6Pk93wpPC1GaKTrS?=
 =?us-ascii?Q?PEdFf6uwspnig0HjRN+QHEioIt/mOX/SuYFsW49WvM14cnbEKgAPcniefmEx?=
 =?us-ascii?Q?CXeeiHfIp9u5ntj11MfBhft29hmYer1rRcTKtErEKtlkTfH12Up3OT341kFy?=
 =?us-ascii?Q?YGVOsWcpkgLr8poz8HFA3Onbux/lJohXYewEedme4V2FSzmgYYC2WliIVgXw?=
 =?us-ascii?Q?jKJ+nuGwNPtzYagIkeSLcjYTUfFKNIBUrdOmAqd0coYrbZr6l0IAVo9lZsSW?=
 =?us-ascii?Q?dA9SkVY9oIEbVKVn5Iewyx3Vkt+lQ6DPDWPIgJLfybjuhusNwyoG2HfqJQbP?=
 =?us-ascii?Q?SNn1bHFKYDfcE9y6f5/AtYOp3R/ZitAfmXoT8WY1b+Xc7iTSAnZ0mUvCHNpt?=
 =?us-ascii?Q?eij93OWe48gT5De3FYPZlVcm3i3e9GyeCesz+UFe/hQF2y9SIdggC+qFZDa8?=
 =?us-ascii?Q?voSmmImIHsPQghJMumv9dD0IcYDY3mga/iHub0fg/OgrDVtU4mSdon2DZu3p?=
 =?us-ascii?Q?CmCsxDJ+Vy4DVFVX+buHTu/RD2CJTY9IMBq1Uj7nZxWP20Nl0LR60qahhLJn?=
 =?us-ascii?Q?4UFl0RaBMlt8jUGGf1PHFjIRXsetbQXT3pXsj6ofdaeM69E0aHdon4jsXhBw?=
 =?us-ascii?Q?PPWPfymXa6eKN4feuiZbqJPu2BKfbP1IVFZtYONW5t8/BZzw33+/BqM46U16?=
 =?us-ascii?Q?4d88xbp+B0iNl35T5hplyP60KVOEVcdjWF63rItCN/apVtMSB2Swbr2i8qMs?=
 =?us-ascii?Q?jQUkLCyLNWG/yTRCiSk2kLJELZ7TO9z+rqDOAMa720ADpybncgfM8IeZmqQd?=
 =?us-ascii?Q?QK+qarBtflLjbS4PtZIDubZXllpvG5v2EfjsLVV+wH+fD/QAQzxD0VRxoURv?=
 =?us-ascii?Q?A7qFrbKt6zXfnpy2tVpux+hHuCyfARxW/Gzx0FRS3/jXTqZ2DG+5kC+X+Ib3?=
 =?us-ascii?Q?c13bhRH9bgeE7ErGVYo9gLP2MTnG0goi4L3+SrUES3SYDKUjYgBUNk1Pw70C?=
 =?us-ascii?Q?pARBXTDlJ8r0haPPW2mfbkw5LtWAaMMZgX/U8ieFEj87?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bde98005-a658-4677-7c27-08dc03c57c99
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2023 14:43:11.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kto3/JJPiGSINXLZ/Y1cZcfoSl56+v7ucjD9+zuY+lJ5F3w5u0s/AC1Iy5Daj57oJ/5DA92KOTZDVNsp0s//ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5747

On Wed, 13 Dec 2023 22:09:04 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> The previous two patches made it possible to add `#[pin_data]` on
> structs with default generic parameter values.
> This patch makes `Work` use `#[pin_data]` and removes an invocation of
> `pin_init_from_closure`. This function is intended as a low level manual
> escape hatch, so it is better to rely on the safe `pin_init!` macro.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> v1 -> v2:
> - improve commit message wording
> - change `:` to `<-` in `pin_init!` invocation
> 
>  rust/kernel/workqueue.rs | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)

