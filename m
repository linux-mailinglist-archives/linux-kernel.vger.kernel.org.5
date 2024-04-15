Return-Path: <linux-kernel+bounces-144510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 648AB8A473D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66FE1F221EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC53E1BF2B;
	Mon, 15 Apr 2024 03:16:08 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619BCEEBB;
	Mon, 15 Apr 2024 03:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713150968; cv=fail; b=V9jI6d1I7WvbkSGeXHcZD56haoMrQEg9LvVP01yWW3Sb4bjJ4U3kssNC1rbR7/Q/oFKJQ3zqN8r9eOm/mfMHXqHxjNa+8jnsLir47dy7UOgu/QnFwV44gc50z5WcsXiimlA8Tn+aPxemfepfv3hvqUkU0dJNhEwZAmsjVpNmxBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713150968; c=relaxed/simple;
	bh=dTNLWWqeIwIn7i2Vt/4EKKVx0ZBs/Ml2r0puhlkmrSY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UXq6Q3V0tnVBsHMc/gWWGB0C08+VOBIfi1JSlAHSXQlKuvka113Jfjc18gO+2RhTS02rF4I4Pyw37g/YL3GKlWm+jYwZ4UqUsvM9u5nHJQxGjE8qOBwmoHnGkJiW4N0YSicC56ie+Kz3ofmOrpdItHMwJch+HcTAenjvlvZwLW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTZ/kAgtI8y+AmPwd7YKRseXWp6OIckvV+pIrPDyrSXLJbhhqpmTSLR1djA5Hh9m+POEa9guylLplLs18OwZKrPrLbdaEcHJFz7S30xWrb2hoy6a+khjsnRNyAgDEEKPkzV1ZG3s1oD6VIz7PGG2mVcyBfbxsS/Y5a0sbe8cLO8KkDnz9s1vR7j8jliSX56WuFyQhKfIJrx/VklFzt9q0Dg1Z0RLTKz6ugI/YCQz+WrMM3N3UTtwNZMxVuAJJAfTvmJDnf7BWr8rP6e3DcWltRpzJ4CqiPuPAk1Y8Vlvh61xpVaii3yb7bcTIWFponWKhci0vz8aFYaZVpKsA8hJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eq9/Dgx21isESrbx0ZbihdPWfLhm5FjKlgqENbSSy2s=;
 b=JvEDzwxL8B0ZhJsqJ7w21ZiQBV1nmItUCZU/3DfUAuHNb9GwfEaH17YfJQWckh4yNLrp7s5ZyhZ8rhdrkGFnLGx4jk1xfCvewxafwvj25T4sijDBE916bPHijqvEaOVhHLN7duwZ/0K7dzNtY2/v+YjvngWnWMh+wogiypzDFQ+Hk5xKOp4nosjeWq9ERhmZhFeCTZRZdsALQmsRjfEuHqrzzBAErZ8fEGLAyXRHVWK3Bh9+pk+7tmMdDDYs2U7oDvH1qIMvtyDX7EuQqLUxNXE6PTOr+uOXXFrE3I18dyZPo7X7W/HnzZw/FWQFVCAodRW5W7jypYb2Od0F3oSOiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB8128.apcprd03.prod.outlook.com (2603:1096:101:16d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 15 Apr
 2024 03:15:59 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::c4f9:d4f1:c115:f1ca]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::c4f9:d4f1:c115:f1ca%6]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 03:15:59 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: neil.armstrong@linaro.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: nick@khadas.com,
	linux-amlogic@lists.infradead.org,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	thierry.reding@gmail.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v2 0/2] drm/panel: add Khadas TS050 V2 panel support
Date: Mon, 15 Apr 2024 11:14:06 +0800
Message-Id: <20240415031408.8150-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0264.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::15) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEYPR03MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee2896f-aaff-46d1-4f79-08dc5cfa5f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uxe3uhpm/7pJVHgMXmjvz3F5WuHgBJhB7dvDLz51GhQRkXmbnOMe24MnrVXP?=
 =?us-ascii?Q?4pZ6v0DaWk6nWwFhpXhQUeqfyecmrpzVtRkY2r3jThWyUsqP4JO1E3QnhOMy?=
 =?us-ascii?Q?iFz7ptoR6NanUZd1SEs3Ie6eSiwaeQ/xf9S9wIPDl40/eio22axIl8yPV4Cr?=
 =?us-ascii?Q?DkWJGFX/uv5jI9UZSIF7WJumqZpQX/G7SUgn4XOQqj7KmIDGp0evjVspDSu8?=
 =?us-ascii?Q?u1zDhaRX9qQGsB7FpNklcZ53hoE7YlpQMwLJT6O5uml82uXjhcBev3aHO91U?=
 =?us-ascii?Q?WxcjqVd5mfapqQZhGvqQXAy5vP1Nz+X6eSrolctiNsSScewbkvcOXP5HINix?=
 =?us-ascii?Q?wJYyuz0Ka3VAbbG2dWgKAMI2dkP6rXe1ds4Yg75IPp+xk5J13B5jiskmeFKj?=
 =?us-ascii?Q?RoHg/Q4ibRqPXELH17HAoXrWPzrnQ5FT26YPJc6abA+s//vk24+7GmudosXr?=
 =?us-ascii?Q?8hGIaHvN9Ay4+l5JUFbnhCnFpQnczRm5Aj9tJavD/qx1gctUJdSc7aAnDl92?=
 =?us-ascii?Q?+kacq27ChFkcykwjwaWya9x5YZ64XVSEBTmqn6zkut7yfE5P+ZzoMRIAnLU9?=
 =?us-ascii?Q?Rz329W8x6rDasBTyMjctxQVWZzHd05voB2cqrcsuJyOCXFfcbuDc38IuqL84?=
 =?us-ascii?Q?MMexjUH4eeBeE6c/kUUFcgw8qT2JIG0GLQz/LfCxZwzUyVh8uPPoaOcbQXT9?=
 =?us-ascii?Q?crENSE2ohCyZD//5i6sj1ifqnnyw/VVj9JEyM/Cmb2nNB0IeweaBw4nGDR52?=
 =?us-ascii?Q?brU1mbagQV2IPONRrIA10oYDVFXUyuDqU2QE5OT2MhtXQeuDUn0DDWpL1wXH?=
 =?us-ascii?Q?va+vx6ZZdyw4lHGJcG4Sv/8XuZLhQs+XDgWYr7W4ZB/Q3jz5b9lda3RBuCJE?=
 =?us-ascii?Q?FKxPoUlOeXGizC52aTX9IYUu9ar5ClnkEGvUQcITHxB/229owdNtuB8dEUkg?=
 =?us-ascii?Q?Be1SCoHspmCAwt5igpnWqXxvJ+SQT4RrAHTD8IN1rc/8ZhKnSqZJrL0CAjZd?=
 =?us-ascii?Q?87bBTTLx6YnJU0x9MbKCkeqveA4gI+rLJa7zOhewos8AiXH2VaymPDKhHxiK?=
 =?us-ascii?Q?6xasXdpdqM+yPz2+JCbjo9FS9WKJLbJDKRKrTeWbHruvghjluexyKanBsrMb?=
 =?us-ascii?Q?rZP44nZeWjEy0ORHJyDyUYRUmEg8gtHOhksr3cAw0kwagV2Rs3u+ZFPfBUI4?=
 =?us-ascii?Q?wt2z3K7WpGfSsH5+kouBDhNcWjfsY0v59NVcyvLunn+LSMrklbVLO+pKHxzf?=
 =?us-ascii?Q?eHlc5Z/3DeS0EEobIH5Y76XnVqQupxlwwSaOnZ1n5bYoQnt0J7wJCKbeO6b8?=
 =?us-ascii?Q?WIEw9kPVG58o/kmtytcCHapJABJpZvmUW+erD0FQEngBWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uAHo8ntUYHKUvtuOpAH8TTWhY8ZPiSwNrt4pPRPb/4ZLsJQY6K0B7H5EXG7k?=
 =?us-ascii?Q?CnMAiEHXD/zqDC25VtZld3yF9EjtJYxMYMOhTcn1K4rJ+KC1+j+j1OrA8JOd?=
 =?us-ascii?Q?ZTba5AWZ5h+4YF7rd5Kr3fCw28jYeZX+vd1tqyROfkMhHvVjcT8ASQY8ndJ3?=
 =?us-ascii?Q?FuYJQMe5uNuw9CR2Ih+LpgJZY6KfDwCcj+sKy46jduMH1hBSJIyexjNxRVMY?=
 =?us-ascii?Q?bMMK7vsJKrIcvbTaAQ4wkah3aHSByuLI1XgDqjpzk5P1RFIU2gMEtgvavj7O?=
 =?us-ascii?Q?j2zZXQshBBqCF53bbdNgQheikktqPhgRpO/Sw5OuTvrXc/U2EspnQoKMIL+i?=
 =?us-ascii?Q?yha9hNFA8q/HZiAeIvFmo7XHCJnHjnqwUNdEFZUcHXIjTVs2s0RHvsVTnfjL?=
 =?us-ascii?Q?UWck7+LkSuX+JWUB6z0iIx1+OE1ZZZc61kpxrBePNMT5OhZ2Z5Fd5b0vJicE?=
 =?us-ascii?Q?Dm7J1B3lIqV/zQR5U7pvf03SCg95YQtfqEOJ7y6GoV2vWFYZtUQtKVg1l5IM?=
 =?us-ascii?Q?3u/kMID4AxX79KYIBxEnrLSZPxUzOH5tM+IKu2tM6JZo0o4GodSxqPdL63Aw?=
 =?us-ascii?Q?BVaSZ8AoQCpOPwXl2ok07Th2Y5A0uRSc2FM/xM5schkG1gf3WQinmMax7z+M?=
 =?us-ascii?Q?AErFALB/9lHJADrPL2L4u100IDXCEkIGyogoCTXAViUTuqkZhC3hYDFObjOr?=
 =?us-ascii?Q?zi6vZpNX0bZH/sCPdiWwFZbHiZWvtkCsEL5noxrY5Iu6Op+i54TqFCyuTcUF?=
 =?us-ascii?Q?YnPZTcSozfe19YuAmfdnfPpgLOvOrBRKuaKKQ0l8BSuGTwHGXJw4x7zaZn75?=
 =?us-ascii?Q?DFkcbc6g+7DZuW9Oto82wNQI+BFetV+xlj8cZ4eBJ93OKzLUCwihcGo6aNho?=
 =?us-ascii?Q?CYwXHjKP+7y30oNI9+X2j5TBnHR+EZziZyJuEnPjZVXOkpd5IBhyGdRhVTbj?=
 =?us-ascii?Q?UFeTHp5gvYQO8vXEPln9vTruNSST1y5uY65UTHeNB8tvtyx0zQA+IvSSZdZb?=
 =?us-ascii?Q?uB3tQSAmRoJzNTvpAcYZmC8FKUWqSQA5AfGowR+i5qIhMkfhDKJMdzZsLPAG?=
 =?us-ascii?Q?muY5Ae2mXGqyxsj19u/g3KgSJcxYEohIypQGVJBBpHwBESni1eSxKOUOAz0k?=
 =?us-ascii?Q?tLxUvnKUgA71mAcdeU1Rz98RzC2LZ/QtZOHWpASrKKlF/1jp5n/af2ipO9i5?=
 =?us-ascii?Q?NXcHkSOLg3kqdDbyYRPDv/FbHs926JGEixD0wvwWM4zddJzUIl6xWG65SHxb?=
 =?us-ascii?Q?FJek4TqiG6qP8QEZEs1xOX7DkA5b6VOLjs/AJcskmfyV9MKCUlYT5nyIsePb?=
 =?us-ascii?Q?Ip7jaNazblAkv4Xtz/FOYfWnmuNJP8xYdtCNFl/s/8ToSKL9rdfTtkva0V2j?=
 =?us-ascii?Q?dWfZUzqiaxSzhppz33bK+uIYWZc3lypkZyniuKIvTgpZfwl67wGO2fCXqwFp?=
 =?us-ascii?Q?n8kQqaTYxJXFyzWz1KoIlBe9UNQ7bODHi+13E4+31ixhaXcIBG4kYaz0jfT+?=
 =?us-ascii?Q?SI7gmfoRSzBAkq+GL4Z8+CZEwZEeTsGOt2exQGRy9C6nCs1xRnO+oFRgmWBc?=
 =?us-ascii?Q?E8p3CxGYvuWkzFc/qxWpq1LEAxG5QuPZlwfrau+H3/iGwTacnViB3D8Dln9/?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee2896f-aaff-46d1-4f79-08dc5cfa5f72
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 03:15:59.5709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ma04OcTN9TLxZiBpjwxho7LzDA39MTz62Dcv4cbPHXS04/d7EQ7B0Mz9JqR47zRdFhf0wl4LXyysciNefxFL+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8128

Changes from v1 at [1]:
- Fix name from "newts050" to "ts050v2"
- Add specific description about controller change 

[1]https://patchwork.kernel.org/project/linux-amlogic/list/?series=842707

Jacobe Zang (2):
  dt-bindings: panel-simple-dsi: add Khadas TS050 V2 panel bindings
  drm/panel: add Khadas TS050 V2 panel support

 .../display/panel/panel-simple-dsi.yaml       |    2 +
 drivers/gpu/drm/panel/panel-khadas-ts050.c    | 1112 +++++++++--------
 2 files changed, 592 insertions(+), 522 deletions(-)

-- 
2.34.1


