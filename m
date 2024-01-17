Return-Path: <linux-kernel+bounces-29516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3639C830F84
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE621C21971
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F6A1E880;
	Wed, 17 Jan 2024 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d3WE/Y9x"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E051E87F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531832; cv=fail; b=FsOzVtheX4q5/FI1tNlymn4e4Og1nL8FgNiKwNDwJa52MwgABa99mxsc3V7uzOAHK8i9oi04dncFE9uLEFcQ++3QLJrLdVy45mjsA3q4fgY9pkENjizjeVe3E0NaJgmoFTP2Tg+b8mwgwPaHKMcGhkgxN25cgxyaq5bYQAGI8W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531832; c=relaxed/simple;
	bh=DPj1G2w2NMG3/ZwSwjS2S0jkR9IDQdPixGFtKa5TJ+Q=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:Subject:Date:Message-Id:X-Mailer:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=Mx7mOsaAR6ruupmaQsEV3ArspwLKRtpwlZc15NINHW6nsHWqq5tSofbDjt+Tzg9xAowxbkBrExQiPvLOBPLHS0Rx8LClI5agO60H9E9oLSD+WAhLhdVOf6QAzHv20JPiLK9YImaNfO6a/sPDVQSLkWksXZ0A0lVyO8dWW0XCG/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=d3WE/Y9x; arc=fail smtp.client-ip=40.107.104.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpQXnHykO7PcqPtkAsa+Vod+EOKVStsr7e6P1w8001NPk71jp3PI27q4CWdf4gsntk6QtmDMwySWi7AmRUzjS8snwZI/BiHvVPVBAl2Be/Q3I973d7bvOpvGDAFhouxqzk1XaL+nKpb9fXp/+ZiV2ben5lsVNPX+4g1OITXA4kVydVk/jI/NVLKBMyR62fJ4gQyLvkkVDa0rHqlcCVYB/ZHMj00O/mh394MZR5RR2vpDuEHzKd3pDPKSPbHWwd0S9vcu28Tl84czDFjcdc4y9Fol/AbNNWhFznLoYyhIEjgYtyLfxkGBURcC9J4+yS148WSIqQQYl46ek3nwA3h+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOtJ80JffkOgKKh0YsiAty6fMdEIu6BMNilzlP9Ml1Q=;
 b=gZgg5p+8juWVErVDL1yMs4UxLgtqm4pwhKruhdDCAXC7PcPrngRclHKnFlUZDyUW3LZEBAuRNB2rneRXM1ZzLtoX6YSzUV3ymcUbZ3q17XzmbZVMHhly7UtEDN8LVy4jDo5fuuAVZwvoWRDd3tY6itMUIWl+F8GMrkOAULh8A1vwRRPRkw2+miOUxXxKBvrAHD29JuOHfvDpEGNyyePZzaSpAsYj5TUN769ylkpVrXqCbGvowtgd0DvuRgKuMNVKXvh/GyNFjVjlvF7BcSj3jzKgN1mdGJ0vX8VkTlKOVtf3yWO7RycmpkBnVQTyyfrNJqKG83UioG4zOHUPFSAxlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOtJ80JffkOgKKh0YsiAty6fMdEIu6BMNilzlP9Ml1Q=;
 b=d3WE/Y9xc0Bm1ZX1zsl52tlMD+yd3o60pW/UPKxAqyYhvYQfk0QAv7EWVG2GglewgW/KbEBjHxNehEEzj6d2MAEhDpMFxuY+mDIk3zdKjHz0dL0pWsJ7ha3Z2EEE5MX1rVqwSO7N1dOMPoqS3OYJdCqOkbgpgJuzM/Quy+ws79c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7714.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 22:50:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 22:50:27 +0000
From: Frank Li <Frank.Li@nxp.com>
To: imx@lists.linux.dev,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org (moderated list:SILVACO I3C DUAL-ROLE MASTER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] i3c: master: svc: add support for read len bigger than 255
Date: Wed, 17 Jan 2024 17:50:09 -0500
Message-Id: <20240117225009.2931699-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:a03:505::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 56823d9f-eebb-49f4-0e37-08dc17aeb2e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Et8ZPyxUH+7YaOWaymfsCYF4SRUbvhKqlqoGu4+44XE6GBck5vGxNVC3YQSTP//av8gDH60immdoDKlj5nVoKfP4MwhaMx54ULny/bOnnNZmPRzEU4o3tX+3m1dzGombjvXnbQF5OwfdAxAYh+DKU9aB4fTFvyq2zOARDZRp2Skgk5YJMWN1Ndn0lwXpjBl4XkXrPePctuyuMhSCn+kh7vYte0XbW+1KmLuWtK2DacnZjIBlSXi8kivzjX3SkFXFRZ5sWxADdvBNBXjR1DwGxG690TyvgVW139C0Zfpz2TPyYt6jqxMKxHKwVNVsFGHAYFgIIQcWzQd6oGNPDBDGt8pcGSmVs/YeK9y5BJEGWATVlWrnQ0FGgknUDz1YJNjNBlmrb+NHQo3LFbdPWmpcYO5cHwMOM9thPsDeoq3SSCjKZXOv+GQfRdP/pqgISdaZLiYmzO2uuO0v15SLKigCi0wm1Uof4Xce/H9QzHEivF87Xt0zrVHKs41snadpmUZiNXjtsakMpaHE8Wk2tuUYR6t8XluOHnJqPA0GW8HCrfEtYMCbU9VQrFvv0OacCE5JSNAHwyOrxiRecx7g/YA5NqmJ+CES8IdCcgrOepsV1GZ2458QV8OuTBLDZtrmQAontOVqhKm3RqKKRTmRMek6n66j6YSBkwYgxYzTOlxHir8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(8676002)(8936002)(36756003)(2906002)(41300700001)(86362001)(38100700002)(38350700005)(5660300002)(6486002)(52116002)(2616005)(6666004)(6506007)(26005)(1076003)(478600001)(83380400001)(6512007)(110136005)(66946007)(66556008)(66476007)(316002)(135533001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2dFRmMwVlllazliQU9XRERDNzBNK1g1TXpoMC9HdG5GREk5YlEzUG9JR08w?=
 =?utf-8?B?cVhreVREejJ0MU1lclJhRUxndHZveEV0UTFwNGJYa2hZMlNpa1BJeWQ3V2g2?=
 =?utf-8?B?SE9HcmpzWDVGY2FzOGoyZUFra3FHYmFvRmZwRTNSWEtPaWl4QUZ6NXFaMUFK?=
 =?utf-8?B?MTcvK3Z2Z2s1Um4xZTRBYVY1TlJwZUl4WG9ZeG01YUVmRG8yWC9Va3hKbUVW?=
 =?utf-8?B?MGVLRGxxMFNGWVc1bXJtOFQreXNKVWZyQ3dSMUdUeGpIbVNVRWQ1OUx1SHVD?=
 =?utf-8?B?RlVmdDVSTDZab1Yybk1JZVZkbUFIcFFyTHhVc0dOSU9idUdhT3BFUFMwY2VY?=
 =?utf-8?B?cnY2YTRVWDlMTkQxTXF6Zk5STWFCODJqUEhZaG1kamU5ci9WMTl3ZG52NjZS?=
 =?utf-8?B?OXFVNXJXT1R1bkhaeUo1MjNUTUM4eXkwZ2VUamwveE5RcnJ5NjNmT3Rsc2RH?=
 =?utf-8?B?dEhwazNhMDNTdXpKdjg3YUxjT0w5SG5HcW5oMVNnL2x0Nm16ckkwcEUyTGVL?=
 =?utf-8?B?dmxDc1VkMVNHdGJsWktaOXJaMENvVkYrOERKblNycElJeG8vQU9DQXppaGx3?=
 =?utf-8?B?WnlnVmNNbnVwNzYyNndDYzQ1U2xpTE5PcUNBckJETTlKYkdmNjVFSFlHTzA0?=
 =?utf-8?B?VG9jSTdDaXVVNksvaE12SVlyQ2VVZWRIWVg5VnJYTkNDMHUrL2g3M004OTRj?=
 =?utf-8?B?eDRCa1c4OXpMd0Evc0R3UVRuaGxqRG9PZWJvWDllY2VteFZCWUY2cUVZZGhC?=
 =?utf-8?B?UXV6UXVBTm83bHZLbmlVczZyMzk2OWtIRGxQQnUwbnJETjRJT2FsaVVlOUhv?=
 =?utf-8?B?NENSVkF4YVpkSytQRUM5bGdiUzVCSU41U1NCTE03dG9ZRk1pUXM2QXhra3A0?=
 =?utf-8?B?QjJuVFA0djMwa1E0c1pwOXFkSlBwZnAyZmZIUmwyMnl5NGhqcGdTQXlhekpz?=
 =?utf-8?B?ZFA3Y1Jud0ZjU2RSelpmSWJneG95SG11UE5oRUx0Vjk4RWIzRERMRXJOaTRT?=
 =?utf-8?B?WjlscHN0VURKUzJ0eGZvdHcrbFRTWW5jNWN6aGcrcEx5VkhndWlrTmRRSTJU?=
 =?utf-8?B?bGVSc0J5aTJSODQyQmQ0ei9qelVreGpOR1k2ZUUxdndiWXQ2RERVT2FCQ2ZB?=
 =?utf-8?B?aUJWQnBkRUxkNDBYOTVqNjAzQjZESEwyQ3Y4MmF3Ym9seXRHRGhvSFlXTFhH?=
 =?utf-8?B?YjVUSDRvbysxK1RrRTlhbk42U096UnF0S0hPMGRVU1hLNTZnRzVpanJVblM2?=
 =?utf-8?B?Ty9WTXZCbEhVUHdBYmVRdVpFSUMrT09EVjRwUlpaQU9UZkZ5bUlreEFKeGkv?=
 =?utf-8?B?ZVdBcXNGZG1EZ25lUmFYeGZ6UXRuT1ZGcTMzQnkyU1FUTW1WS2h1eldraXJW?=
 =?utf-8?B?bjFjTWNrNUlKdk03WUs4MEgwaTRyanZYcit5Q2R3eHg4WWRDemV5OTdLd1pV?=
 =?utf-8?B?L3NzR2E1ZmtWNjBTM0FMOUtmVFcvK01UNUhzZXd1VGd3M1A4NmV3ZGhVSWhK?=
 =?utf-8?B?ZjM2QW4xcDNSVjJlNFJIeXFvU3pwMmR1M2lJODI1bW14ZG1DbTJmNUhEN29E?=
 =?utf-8?B?MnhQcGVJUVJ2Y1d6OG9GT3BCYmZUc3NXL2VDOWd5b2VaWndpRHhjYnpNcmNl?=
 =?utf-8?B?ZVBuOGxWaTdneXFiV0g0d09qczZzcXNFOGR3MEJBNzd6QzB2clB1Vys2Q25q?=
 =?utf-8?B?UGdmSWFaWHJsbGYvVkJLZ3BvaUNDRjhqZVFiWlUweXk4OUlTdTJQN1VLM0Vh?=
 =?utf-8?B?dThmLy9vZEd6QUw5ajh4VHBBdkRuUTQvMG1mV0g4U1IwZGh2MUV2TS92K2lx?=
 =?utf-8?B?Z1c5OW1KYUowbHpLTWUwU2FNOUw2LzlkTWgxRjVkRnJlbXgzbUdHV3h5MVg5?=
 =?utf-8?B?aTA2WWlzMXBzdHZEVDRLV1NKNUk4QTk5cHdQK1hZQVRoc2VjbTI2NzV5LzNT?=
 =?utf-8?B?V0szZjRXcWVZY0FMWDZ1eDYvL05JSUtCUVlaTUFUL3FBdnFBWUo1RngzVDZG?=
 =?utf-8?B?SXIyTHV3bmRnUVZFZDJ2bFlQUzV5TFc4OUVwY043NFNMRFFBVzVKMklqRVlW?=
 =?utf-8?B?T2tYZUZSMS9taFE5VmlVbGhpL1g3QmwxZU9EbFlTYUlRS3BsRmx1VXBSUnB3?=
 =?utf-8?Q?e/yJ2aJ1S8SNTh18jwOn+8NyN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56823d9f-eebb-49f4-0e37-08dc17aeb2e7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 22:50:27.4826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXhD9QJDnHgEKJq4JopFiF3it0FGFSfFjmDS9j6SCupR4LOXs4+HxKHCaDcL6JAdQrSPUkYqoFxEczKYQq3qXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7714

RDTERM is 8bit. Only support max 255 read transfer for auto terminate. Use
manual terminate when read len bigger than 255.

When left data length is FIFO size + 1, issue terminate
(RDTERM(1) | REQUEST_NONE). So hardware will stop fetch data after next
data.
	│ ◄──────────  buff length     ────────►│
	│                                       │
	│                       ┌─┬─────────────┤
	│                       │ │  FIFO SIZE  │
	│                       └─┴─────────────┘
	                        ▲
	                        │
	                  Wait FIFO Full and Issue read termniate here!!

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 76 ++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 12 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 5ee4db68988e2..58047ad357791 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -977,7 +977,7 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
 }
 
 static int svc_i3c_master_read(struct svc_i3c_master *master,
-			       u8 *in, unsigned int len)
+			       u8 *in, unsigned int len, bool auto_term)
 {
 	int offset = 0, i;
 	u32 mdctrl, mstatus;
@@ -995,16 +995,60 @@ static int svc_i3c_master_read(struct svc_i3c_master *master,
 			return -ETIMEDOUT;
 		}
 
-		mdctrl = readl(master->regs + SVC_I3C_MDATACTRL);
-		count = SVC_I3C_MDATACTRL_RXCOUNT(mdctrl);
-		if (offset + count > len) {
-			dev_err(master->dev, "I3C receive length too long!\n");
-			return -EINVAL;
-		}
-		for (i = 0; i < count; i++)
-			in[offset + i] = readl(master->regs + SVC_I3C_MRDATAB);
+		if (auto_term || completed) {
+			/* auto termate or early termate by target */
+			mdctrl = readl(master->regs + SVC_I3C_MDATACTRL);
+			count = SVC_I3C_MDATACTRL_RXCOUNT(mdctrl);
+			if (offset + count > len) {
+				dev_err(master->dev, "I3C receive length too long!\n");
+				return -EINVAL;
+			}
+			for (i = 0; i < count; i++)
+				in[offset + i] = readl(master->regs + SVC_I3C_MRDATAB);
+
+			offset += count;
 
-		offset += count;
+		} else {
+			/*
+			 * Controller will fill whole RX FIFO in manual mode. FIFO full can prevent
+			 * controller continue fetch data from target.
+			 *
+			 * When left data length is FIFO size + 1, issue terminate
+			 * (RDTERM(1) | REQUEST_NONE). So hardware will stop fetch data after next
+			 * data.
+			 *
+			 * │ ◄──────────  buff length     ────────►│
+			 * │                                       │
+			 * │                       ┌─┬─────────────┤
+			 * │                       │ │  FIFO SIZE  │
+			 * │                       └─┴─────────────┘
+			 *                         ▲
+			 *                         │
+			 *                         Wait FIFO Full and Issue read termniate here!!
+			 */
+			mdctrl = readl_relaxed(master->regs + SVC_I3C_MDATACTRL);
+			count = SVC_I3C_MDATACTRL_RXCOUNT(mdctrl);
+
+			if (offset + count + SVC_I3C_FIFO_SIZE < len) {
+				for (i = 0; i < count; i++) {
+					in[offset] = readl_relaxed(master->regs + SVC_I3C_MRDATAB);
+					offset++;
+				}
+			} else {
+				if (count != SVC_I3C_FIFO_SIZE)
+					continue;
+
+				/* Issue manual read terminate at next data */
+				if (offset + SVC_I3C_FIFO_SIZE == len - 1)
+					writel_relaxed(SVC_I3C_MCTRL_REQUEST_NONE |
+						       SVC_I3C_MCTRL_DIR(1) |
+						       SVC_I3C_MCTRL_RDTERM(1),
+						       master->regs + SVC_I3C_MCTRL);
+
+				in[offset] = readl_relaxed(master->regs + SVC_I3C_MRDATAB);
+				offset++;
+			}
+		}
 	}
 
 	return offset;
@@ -1042,9 +1086,17 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 			       u8 *in, const u8 *out, unsigned int xfer_len,
 			       unsigned int *actual_len, bool continued)
 {
+	int rdterm = 0;
 	u32 reg;
 	int ret;
 
+	if (rnw)
+		rdterm = xfer_len;
+
+	/* If read length > max RDTERM in MCTRL, using manual terminate */
+	if (xfer_len > 255)
+		rdterm = 0;
+
 	/* clean SVC_I3C_MINT_IBIWON w1c bits */
 	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
 
@@ -1053,7 +1105,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	       SVC_I3C_MCTRL_IBIRESP_NACK |
 	       SVC_I3C_MCTRL_DIR(rnw) |
 	       SVC_I3C_MCTRL_ADDR(addr) |
-	       SVC_I3C_MCTRL_RDTERM(*actual_len),
+	       SVC_I3C_MCTRL_RDTERM(rdterm),
 	       master->regs + SVC_I3C_MCTRL);
 
 	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
@@ -1086,7 +1138,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	}
 
 	if (rnw)
-		ret = svc_i3c_master_read(master, in, xfer_len);
+		ret = svc_i3c_master_read(master, in, xfer_len, !!rdterm);
 	else
 		ret = svc_i3c_master_write(master, out, xfer_len);
 	if (ret < 0)
-- 
2.34.1


