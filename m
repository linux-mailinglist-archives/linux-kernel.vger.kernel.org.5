Return-Path: <linux-kernel+bounces-13967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4521A82161F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E8A1F2188F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 01:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D6810FC;
	Tue,  2 Jan 2024 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WwBL9CO3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA9210F3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 01:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoVjnxBufqkTfXkZnyoaT/xSGmMhwPtwiwFd67N0JHLqnOXsfK0cBBpObVf0rTJLEmSQi5cnugRzQl9zapwJlw+xSAuWnp3D3/7Pf/BpYgBOV4HpmqI/hHb1OwSmDWD5wZkcZRyaD1S0ObHRFTNLfGZM4DBbKhVEE1fB/xLGi6OqbZ/DIPNRME2aP1x7k+LEMyaQDNnVRUM1nJA0NN7+ru8vyFcndpYwa2EQKH0/4Iaba94uzRen0YkfN0HZwmyXd3p9BHvII9wPMJFZmzoWOYpCkAIcFuYLb8hjyfRO/RzcdrU38pIfugI+/UnYNe6YtiHQvOAmuMV08kyF2+c8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFvgQOvtF96Ehy9KgKAzMVqul/6o5kdBRKcfu/b63+A=;
 b=NkjXsiA+GRkxuhBrGsZrsvSJC2VBh54d8rhFmt5z5V/dAFVjyYUImJjH7ccFZr0GxakfU+tYZwoigvrNoDP4bf4NUkIHGIS+RzS4VcXi6LbuzcgLjkvJ51CpceLHQ8dQq10LqOcgneBJWbqyJLn+CmEaU5uxce7ewUMENekbWgrhpzhfwP4xbgFpRd9gqA+MSegdU8Bq6n4mwI8ikXN4mXQo2noaz/u8sYV/ritFhqkSEhEYMIottWD9fOaagubYMe9hE+W7iy87cOi25G1iiYYiOKYSZgkcb7fB6gUC25BIVa2QJOzr3RxdZ7gv9hpOuVbH/lc4HUTO13Lh+SO4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFvgQOvtF96Ehy9KgKAzMVqul/6o5kdBRKcfu/b63+A=;
 b=WwBL9CO31rQs6PZ+qa+s+QJRmDLzYy2igLrhLEFN59sW3ySqVxXYtibTgNXNS9hBmmlFXF75o1h6R2xQ22SD6X5Z8PigzifzUGN/hwJCpSPJClR4/8/mFGdQ1ChPkc5Hf7rQeUEMp3HxXWCsJUUM9BGnTqVPro3Ce+LiQhbgS4fHaC9tt35ZSHyO8vU4T1aObOaFjIeABpm1UmMu6Y4aeE3a40m9JGDI8uPJQ8HcRXr8dUeMiFbqjKdk6PhpZxv0wXMiT5RG+bWXkSGJM3Evi2vDT6EC+ISSic5KejqHFB8KI7n0scFG7uKFNrgnsUYRs7fn8zb5NgkmnwZFBS6X4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by JH0PR06MB6583.apcprd06.prod.outlook.com (2603:1096:990:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 01:19:51 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 01:19:51 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v2] mm: fix shrink nr.unqueued_dirty counter issue
Date: Tue,  2 Jan 2024 09:19:33 +0800
Message-ID: <20240102011939.1026-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|JH0PR06MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 781873c2-4b1a-4080-2dcf-08dc0b30ead0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AIna4mOw4g7yXkM/BS7YzQRPbiJNH38dE0r/wkr7D3riJZ9MEI8wqWP1Ma5IUM0lLR6VKEFtNK2R7W6breQAbsl+89qUBZqNtPcIId4JYUKP2Jo1ePZx4mFcDMa+cDWgKdjxL6A6ylGW8e+eFR9rWUCNy+NF7R6/Y//YDIPpN7+fbrI9mrkFLXqcPJ9qWmym/gG30Bei67MeKyeGA6iQEf3vnJdakB71hwQTu9sLENkxrBwhbXpWb1SF5hJc/EuciTB1Dhh8W2ea3bRI+2h0VlXKNSAe63vaqriGSSWPjornQuJQN28FDU1sROsU4cGFTWoq87kP1aKn/ExThXWd6AMR6k0rvwERUvEDM2DpbLa3Oqbpuw4zg1+TGT4/Onna7YYwut29HDiQEXOlSCEpFPz/eEmC6araE+XBcxFdnZEcl5BcQqDFFpOcHHvnohukLcQ0VSsTULIt/k+Sw2UzwlKyogP6JTMiAcjXk/gSyfB+d68GAAXjctZpz29Xim2PsYE3rVnf184kVGFK+zxP0JtA75Ws4HRdlf1GdQD9Mpr7L0q9cxPl6KXcFCyKPCMxvmirQQ7Xvq7f4sEoD+Psn0uuOVCIV0Bwa7o9byf70/JLkO0wCtvFqBltA2Nnd7p1bDU3J2GXMUo7JSAc3pyJqw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39850400004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(107886003)(1076003)(83380400001)(86362001)(38350700005)(38100700002)(36756003)(4326008)(5660300002)(4744005)(2616005)(6666004)(52116002)(6506007)(6512007)(8936002)(8676002)(66946007)(316002)(66476007)(66556008)(2906002)(41300700001)(478600001)(6486002)(14143004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVFmQXZ2Qm42VTRINjVjR0NxQ0tMeFdOZ1VHUno2VWlQOVlJby82Wkc3NWw4?=
 =?utf-8?B?Z2o4aXQ5UzRnS1FvdzRNVVhiWVRWZmFBb3BpbUNvVXR3c3ExR3owSXBReERt?=
 =?utf-8?B?UXNGYzR5bml4UmlscGd4cU9FQTVzWTlLajVFRUtCREdBUCtTY3E2SGdqT3ZZ?=
 =?utf-8?B?ZEtCbmRYM25qczdQZy9vNkxhcDg5OE1DcFZ3Kzc3Y0R1aGQvTkJNaGJyd1FK?=
 =?utf-8?B?aHdZZTdlWGpnSVFjeGJwQkw3ekhiajh6V04xdmJ6YWl0QkRPNC9FRWpsYmFr?=
 =?utf-8?B?VkxRSk40NHU4VkhOTzRDNmNZNHFTSmNKb1dsTENBQ25oNE5tcDhIQ01qUjFk?=
 =?utf-8?B?MzJ1bllpbEE1RDI2elN3N0h5VVBSNDFjNDhXZWpiK1RCdTJINndOLzM3VjU3?=
 =?utf-8?B?bmJxbW9lbzVXTUovak9VMU4wZE5YQjVtYWlaNS9HVlYrL0Z6YTc3ZWVLN3hM?=
 =?utf-8?B?ZzJrQXdXMmhVdjMvMStBQ3R2bzJlSDgwT0JZeVlOWUhwZWRoYXdzSHBvZUtI?=
 =?utf-8?B?UlBaTi9qYk5rdXJkVXI2WmR6c2hzTnhHVzlmeURkWXdnbXNRaVBpRFNFRXBj?=
 =?utf-8?B?aHYrQ0pxZjdDeXlpTFZUT2hqZXBhQklZQmRKaE9DSitsTGZNaENObCt5MENj?=
 =?utf-8?B?Vjk5ZXlMclo2ZE1QUm5vUFViYzBtVHB5QWFhQWZld1RvZzdkY2RUSk1DT2p5?=
 =?utf-8?B?bU9zMFNMTnB2eVpvUWp2elhYQ25JQU4wUE80cHNubU5NdnhvR1k4SnJySnlM?=
 =?utf-8?B?Ujd4NDJ4dUJad3EyYjhsUW9TM3NZOHZBenA0L09kK1QzYTVsQXlVY1pEV0Zh?=
 =?utf-8?B?cGt6b0t5U1hHY0Y2UnoxM1BFQlkwSUZ0d3V3anh6VExMNHFsdWlXdW92S3Vk?=
 =?utf-8?B?UVJpT3hsc2h4ckIrcWRDbndoZjBFK3huYmZSejRuZEoyeE43MlFxK29KY3lQ?=
 =?utf-8?B?WVFIMERLQXRSbmZjWGlHRTdIRWhpYVNTdkwvbHAzM1JsWi81WW9QblFxQVRT?=
 =?utf-8?B?ZEhvdGFleVB5YWt2czJoY3Fwd1VkcFk0TjUwakNKbEhJM0FYOXdjVzFOVUFl?=
 =?utf-8?B?M1Ric295RThpeHZJV05PZ2w3VGRYU3pOOTVNT0hacnJkNFhpWEJHNHQxc2l1?=
 =?utf-8?B?RjMxVVhrZU9iUnlBS0FDNisrcTZBTmdPTnFtMFhTeG1rWVRrLzcwcDNuR0h0?=
 =?utf-8?B?TXNaZDgxVGx3Qk5FcG9GS25lYmdlS0RYWjVMb2NXaHBNQkcveGM2YmlMeE44?=
 =?utf-8?B?bks4eWtOVVBiZUp3ODRUVUNpaGJhaEJWWU1WS2NaSmkxTS9MWGpDelpsR29m?=
 =?utf-8?B?Vys1ZGd6dXNJd01QTjZGN0UvRXlqNWxsWFplQ2RqamJzbGtUNWcvQTl3MktB?=
 =?utf-8?B?OXZyNjRMN09nOUZmVnNMMFVLTHhKQklZUHlkRVVTb3JxaHllTlMzK0hBSjZC?=
 =?utf-8?B?QWg3dEpKUnorQ2p0SmdtMEhVMVdxQUNvVzNiTkFNalc4MFE1b1o0U05sKzlk?=
 =?utf-8?B?alVQeFdFa1I4Y2dwYU8xMUIrblU2NUQ2bEcwd2ZPclZ2Qm1WYlFzWFR2L283?=
 =?utf-8?B?a1FFS2dJd01ZTktndEwxQ3Q4Z0VyTEwvZi84Q1dmK1RVM3QvZUFzbjRzN3di?=
 =?utf-8?B?VTNNcWcvTSs1KzB4cEJlSDBKaWF1OFJQNFgyd0p2aHc2NTZ3c0FBRVg4cGw4?=
 =?utf-8?B?OHpsTEV5cE9iT2k3U3lwZkJlM1ZYK2lobDRrazFzRGNDTTRRckt4eTh2emhy?=
 =?utf-8?B?UEg5RG16bEg4elh3WGIreXRJeGdrcVFTTUJMWUtwTWNnOVhPZFZ4WlQ2V1Vl?=
 =?utf-8?B?ZzBSQTJLTis4bjRXbkJNWERmbURWN1paTWVYbkRNdVFiM2EvRXIyT1V5cnlU?=
 =?utf-8?B?R3BCeWVsVFcxNXNOYzBxWm54TlVRdVN0d2U2YldXWHBGSUJ5OVptTytsVkZO?=
 =?utf-8?B?aHJSSW1HdkhqRnNwTURwd3pMTi9UNEl1RUlpM0lNMWJDZ29IK1RpaE8rVFN2?=
 =?utf-8?B?cWFQc3FwY04vZXpYamxLUC9JRE9CeUROV2MyVmF0NnIyOTY1RFRucVRMdGhQ?=
 =?utf-8?B?bmdwRktEZ0pCaE94NXBjWFJmWEdYUGVZT0N3eDAyWFNBTGhMUlFVZVBqMnhK?=
 =?utf-8?Q?/OzhWZiDv4p4XL06oe966tWPL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781873c2-4b1a-4080-2dcf-08dc0b30ead0
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 01:19:51.4469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIvc6O1J3Ed4rOWDS8WhMHK1FviKkGFyAIHxDewtQlgkhzbT1WLt+E0ffimW5w6XaIGcVuj1qMXIB9D9h3m14A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6583

It is needed to ensure sc->nr.unqueued_dirty > 0, which can avoid to
set PGDAT_DIRTY flag when sc->nr.unqueued_dirty and sc->nr.file_taken
are both zero at the same time.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
Changelog：
v1->v2:
Update based on the latest version.

 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 mode change 100644 => 100755 mm/vmscan.c

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b4ca3563bcf4..c00418e34dc3
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5914,7 +5914,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
 
 		/* Allow kswapd to start writing pages during reclaim.*/
-		if (sc->nr.unqueued_dirty == sc->nr.file_taken)
+		if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty == sc->nr.file_taken)
 			set_bit(PGDAT_DIRTY, &pgdat->flags);
 
 		/*
-- 
2.39.0


