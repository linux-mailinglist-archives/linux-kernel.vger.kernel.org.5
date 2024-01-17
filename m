Return-Path: <linux-kernel+bounces-28542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C26482FFE4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A081F266AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB6D79DC;
	Wed, 17 Jan 2024 05:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LoPvtiJC";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Re9XDylt"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9126D6FB9;
	Wed, 17 Jan 2024 05:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705469958; cv=fail; b=XLuojG3aEt9wwvKHVDQ09x3GJDMgMfV+vbNqNHBqPE6EKgMaFcy5QQ9b58ZUZFqla9xKfE/5CHGYV640mi5B3/KOTbo9qjkChur2/3ljeOWBKk3SsfDldBxZa3oZox/IoXkr+jlYQrShOET6bbqBNSaI7JZ6Gw1Rlt3uKM9IkHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705469958; c=relaxed/simple;
	bh=cHlVmhpCgJYc0QR4d7LhRAnKzzh+Iw2i/l8ELxNNaz0=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:ARC-Message-Signature:
	 ARC-Authentication-Results:DKIM-Signature:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=NfLUEJpDZYKDzXAU1GgVg9MnaAz7ACd8QZLvrYHzQlLF951GBeNuUDNxakx/egd3XXKmgLJhmrh9Wk4Q7mHty6regfFqaai8Xf3L6bniN/Kx/jgiOv4IlhckuhB8vBYnlH8bwpqnTNTeSQQebZdWoMfH8p2ARBORKpQu4SydRgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LoPvtiJC; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Re9XDylt; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705469956; x=1737005956;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cHlVmhpCgJYc0QR4d7LhRAnKzzh+Iw2i/l8ELxNNaz0=;
  b=LoPvtiJC4+YhxwE45SvPHPIWz+DVJVZiB5yhT6xLAnMEoQ/invbRmeIK
   +6qzGyxj+Oqwj9NzrJfdlG+QrXK09fDFEps2rF0LM8JzxqERH7ydC/0OB
   r5BJsGL5s0S0NsMqjp1/DbO4dmZaQNbC8MsKfN4jrlfFqDZcTn4fQApoF
   5fBB2Qv1BextAXpzhIj0bzuJy8BzvI5Z8ZDQpSHImF9+Jie/gOd7AelJ2
   2H0WMqWbbMglI5TbVkkcTrfa16qygPFcO83ERF2ePSyNK32h6cJ0vuIqt
   4tM97Ed4y20X7gRxHer61IV4Ml1iXFE80ReYFQ/rHrGiL2xmDuDo4TBV8
   A==;
X-CSE-ConnectionGUID: p9jxSJAwQvq/1fMLPEsbqQ==
X-CSE-MsgGUID: RkqtRtAgRW+f13rPKbrRPQ==
X-IronPort-AV: E=Sophos;i="6.05,200,1701154800"; 
   d="scan'208";a="16058215"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2024 22:39:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 22:38:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 22:38:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIEX1wJpe+kSUMpWD2j0lGYONUz5DbqrS4OxXVTqFO4NFQ8Z1X93KiNsOq/HAGXZDWIjgRFIV/cwUqKQxMB86Roo0sgPlyaSfAL4MPD/fFqjzFIVz0hLYgQ8cFIDg4MXurZ/0E49T4hjUYvnL8QiAi1VX3dmZyfSZoFoGRtwuf32GcZZMU5Do0GPhE1CpS2nvp1+24wxNmk/IC5yX9+o73Gnvlkq1W0Nfp43l1uUGF6//4ufvQwjSIf1qaCdnb+h7uNcrAIZUYE4SYtZq6zcZ42cdOVnSu660/x+gP3bv7G/d7L0JIk9SCEkDxBTDLO+0beQu0WCMJ2z4NF5xN6+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHlVmhpCgJYc0QR4d7LhRAnKzzh+Iw2i/l8ELxNNaz0=;
 b=NnbOVZqpS/v9bF1lE+5asTwpuKDUwNGFxHBJUAdv06IW8PV7oxiTHKebveLZjO4cc3mWshmX0RLD6Hi9B6ZJgj7WksIpSBP0sx577/tAL30Scpln3hG3Ztju4rq28rNC7MGBCNG43Kz4EcxqH0M+oNiIbvDhdOBP3id5QbxbWxLP5S0VdY2+RjaBnmAIBDq8d3yag+/Pym2SHh2+di1rmm+zrecy1Uz8N25y8Efzc9qcrUciLR5sDnA3sb/rcoFJWuRk/ybPvNnUwW5raUbnxlJVn/FBQnMzbdbYfDHuwnxueUz2dOtmgCRKXG0cn10tVOB/luiqHGJ1L2aY2BcdOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHlVmhpCgJYc0QR4d7LhRAnKzzh+Iw2i/l8ELxNNaz0=;
 b=Re9XDylt84vqTYnRRlERNtjqyknPGVMva2NpJJGoEu/PgvLlkZPptZeh06Jgum7Do4ygZ1eUGK3v6FETWRSaenCIh4MCgmN9Kyx6Qs5WQlaCESm5vGhiHMlvw8neN6FMgyRHwixaT1wLKjvbQhwxhRXEfDnBXQ7ymsRF5QPcgZf0MBGHY6Zwk5XH3ql07AyujEavmwAqZwwxqH8dF4AE/B3KbENuUmrP5TFRRj1Ks4RSQg0FGtttZeADeGoenZnbR7or5GSpF0XjAgAtutkDqVb0eglMluYy7hHw9i03P+P1iNNHtCPTKDlI8ZFy2G624ojhhZyiWddVF9dvNZF8ig==
Received: from PH0PR11MB4773.namprd11.prod.outlook.com (2603:10b6:510:33::7)
 by SJ0PR11MB5133.namprd11.prod.outlook.com (2603:10b6:a03:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 05:38:29 +0000
Received: from PH0PR11MB4773.namprd11.prod.outlook.com
 ([fe80::9926:6fae:6173:9a4]) by PH0PR11MB4773.namprd11.prod.outlook.com
 ([fe80::9926:6fae:6173:9a4%7]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 05:38:21 +0000
From: <Divya.Koppera@microchip.com>
To: <Horatiu.Vultur@microchip.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net 1/2] net: micrel: Fix PTP frame parsing for lan8814
Thread-Topic: [PATCH net 1/2] net: micrel: Fix PTP frame parsing for lan8814
Thread-Index: AQHaRiLSj48hD1DswUWEVzEa7zAoErDdgeqw
Date: Wed, 17 Jan 2024 05:38:17 +0000
Message-ID: <PH0PR11MB47739B4AB7E5AC36E21650FFE2722@PH0PR11MB4773.namprd11.prod.outlook.com>
References: <20240113131521.1051921-1-horatiu.vultur@microchip.com>
 <20240113131521.1051921-2-horatiu.vultur@microchip.com>
In-Reply-To: <20240113131521.1051921-2-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4773:EE_|SJ0PR11MB5133:EE_
x-ms-office365-filtering-correlation-id: a65c21e9-d5ab-4013-7c88-08dc171e81be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1+GyoVq+Z6ECkA6G8iPGeQXvqAum0O10T3P530C7XwciiXCdUBsldMjH43U6trbtLzyiNj1AooEma+rjQ5bbsB5UM6TStvhsVK1YbZFBwiVjLDQ8PdeWMRh7Debxha1PTJMCv0NqpfM01xUy1E+fDGUcuKG02euNrAwE53aCB5930FA2UQbeYKF7kQUB8s48oH46uV6Ko+0jcwuvlD0GXPkTf4QxySF9T0Dvql9+DIOAmttIh6u9mzsgbYuQeSvFinmyfEWQ1OeVRDpimogOqVckB9qBpwewsL2YwO6Ak6TzfZD+Ev9j1Ctxi3EwUinCbDkLCRgWdpypthNZijXK7HqRes4nxMUiz/g12zuswflzrr5cDXuPQVyfmf26Gttl3nmKSH866M85GOTcePhpLLGa2LU9BZ5fg056kgnkhMCbVbZUemwvf4M6oovBwV5ZCVnHnB9yWG2Ic3ed7LPWWfCDDZAkhaY+Dvp/HB2ixVPjNz5Mx1MKgCTiLWINBHI4CC+XlJ/EfSTGiuokrjUx0cx5AO9fOLCOF38MkPid6ljKPpBpttpWeoT8JU83k1juP4+TWZe6KmqV2TCL9UEBKo41LEBdQCMALIm8FhobLseJQfpSQapOGJZ58KeWC/+2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38070700009)(55016003)(66556008)(9686003)(7696005)(6506007)(52536014)(83380400001)(64756008)(54906003)(66446008)(316002)(6666004)(66476007)(478600001)(66946007)(76116006)(110136005)(26005)(107886003)(71200400001)(4326008)(8676002)(8936002)(122000001)(33656002)(7416002)(2906002)(5660300002)(41300700001)(4744005)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pnAKdkvvWJW3o495VPgG5uZnl3s8iDyo1viP7BrBAtMMFqOhjo1SQiMDONt4?=
 =?us-ascii?Q?jsV5ZUcBm0pxN/4SCkYCoYdZjlWhetRw4j5ndY3AR3885P2NeP+dUJR36mhS?=
 =?us-ascii?Q?2steUJUNVEXB48vPUyj6ubEE3dVpoFc8X/sLYNGJ4MoU4NVIR7F01txyH3IP?=
 =?us-ascii?Q?PZO8FwRGolE7kIIRyWVEKBJNrLLa8FdG80imicWSNNnCWevlna4BvUFAGTtg?=
 =?us-ascii?Q?j66WFt0QqPvfiu3WGMOCP3l58q3hs5HOUfknsNN5EDonWPjsfM0S7IBKG/1d?=
 =?us-ascii?Q?anCyAZN9sfC1OlEQwuxY07MHQRr9xgmZgRzW97ahsvKky2pMqi6fhyH4vALa?=
 =?us-ascii?Q?+wPaD97NTxKUeKX4kQtFZtrIdtH93J3VLR6N4uSWU32uJ3xiHV4gXYU6dEDO?=
 =?us-ascii?Q?bh+i3XEg8fFU1/mTragv9FOISEB2ByByxIreZDRs9DNOhw/ZaXcwgKtamsNX?=
 =?us-ascii?Q?ZRl4inTVyjUKNJR+O9OIGIvz1v9RYVePSRrVWyWKF6F9WgvhIdiMnyBy/u/K?=
 =?us-ascii?Q?S5RJUSJ7b5vxP8FFNJZ5ifr632JEFaoDboR353PZt3xC0qesBlpi/sqvbLxO?=
 =?us-ascii?Q?5R+X82pjpbYP1uJQPMdC2/GUchuY4m6TmC6Aw6B9k4qe76Oj4LZagbf/4iB4?=
 =?us-ascii?Q?N2RxbwPJneLyiy7RSiyPIokyN9ypgWYxqvMangGMfEVJ3E/Daj1c268GjnNK?=
 =?us-ascii?Q?hIs69apjeqoSlHDFByOZZ1vVJkMlbFERfzqDzEDcwMQo4E/vJBbdJ6N9Om1W?=
 =?us-ascii?Q?LYoWpxMrz8RZtTdfnRJJAlmSFU3S9v+5evQbdrdxtyvrU4HV03hgAqqWyCmz?=
 =?us-ascii?Q?rgy1ye3AVQAmXMXNXg5UhfVFsiiuUL68qQGGi6xyOZYm5hZ8ruHZQpfV+92c?=
 =?us-ascii?Q?bkWNNb+VopjcU3/ZkPqQ9Sf6OT6nZ1SFKvO0u5OLgScOb6fM1uwSRaPW1fyq?=
 =?us-ascii?Q?OpG7VvQfqKqvrUvWZguwwcmwv79pgB6/S/6cVkEJqeAfcf7p9JSTUS9bCb9Z?=
 =?us-ascii?Q?KU/HR9ei7xskyd8QqNNAS3OzBhkRT6Z0A8Byza/nD9oVf8NRr6auI1BorXYU?=
 =?us-ascii?Q?FHQsbixs6u27JvMecVp1iMyeyEsvOutrvMvxJEctMyXJ/4sN64SEhSxud/ez?=
 =?us-ascii?Q?SqeZfDgZg7JCjegMFSG4p4M3vaNaLgq4n9VT6ql/wYouj8sJqc36A/TKJngH?=
 =?us-ascii?Q?4DnxR5OjuckCkM7LXpoRmS0OPDd3C1ymk+Lgir5VN4xRuIvI0HDeIIy7wSLw?=
 =?us-ascii?Q?yTnreG5yYJN5Gfw3vHG2TaFWvN2ZlqReeZWK4nhbpSTfMxPswSv0eQq88vWm?=
 =?us-ascii?Q?95RE5sbavzNVwOuQmF5Nz6ah1UqiHoDQzNbdEDIbdOfyuZpt0isPC3OweoZH?=
 =?us-ascii?Q?XQv6Z6UZFZE7Ym6f3T8OjznMbnMJSSfB9TfGGaWtG/UlQWjSHLGbn5sujD11?=
 =?us-ascii?Q?bAlwg0l53YryH3KUCA1xM2YSSh+CEY6D5LlQVxvQcQa8W6C6gGGcsfm8XmZ1?=
 =?us-ascii?Q?uVHHXS/kL097F0DuZw+76FsbgtPRwarIkVOCy171hTgbNKgxLBPfy8E4vLj+?=
 =?us-ascii?Q?qfb/wEPhfRAaRVitSAQ1No5nEoxNl1BrwCKkfRerVoEYp9bnu6AypptSQL83?=
 =?us-ascii?Q?kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65c21e9-d5ab-4013-7c88-08dc171e81be
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 05:38:17.2799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9TibUgiVGXEfeI4eJ3ZZF+fwBlnTC0YYD3+x79zdnnjgo/hjuEk4DBXrJbiFUiz9xKUQvYHqPIKXWXmkDC+drvCDy2AasONk70f5aTyMUAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5133

> The HW has the capability to check each frame if it is a PTP frame, which
> domain it is, which ptp frame type it is, different ip address in the fra=
me. And if
> one of these checks fail then the frame is not timestamp. Most of these c=
hecks
> were disabled except checking the field minorVersionPTP inside the PTP
> header. Meaning that once a partner sends a frame compliant to 8021AS
> which has minorVersionPTP set to 1, then the frame was not timestamp
> because the HW expected by default a value of 0 in minorVersionPTP. This =
is
> exactly the same issue as on lan8841.
> Fix this issue by removing this check so the userspace can decide on this=
.
>=20
> Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Divya Koppera <divya.koppera@microchip.com>

