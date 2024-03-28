Return-Path: <linux-kernel+bounces-123248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C4989051D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26601F27AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87422130A4D;
	Thu, 28 Mar 2024 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="M3G1FUZJ"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2112.outbound.protection.outlook.com [40.107.14.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887E12D792;
	Thu, 28 Mar 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643135; cv=fail; b=Nshzwho4G5zJZqO2T3CxYUJiVUqzqmI6o0KIY3s58gGCH7CvkZAdhTf39Wk8VS90KYZLq8hYSIRdoYqX01fXvHA3VmnYuMFcUWinbfjwByl/SuMEIefzMHjZbhfcCkdGeZ3W339bZX5hWmFu7IPvjQebkppD5VvtrPz8fTtK5FY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643135; c=relaxed/simple;
	bh=VLSh7akUhIgMn3xB/pYmXrnbq8Pdxkzfa7FYdSs/QJ4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=U9LFL7cnx3hdE1dvS23VuN5fcktC+65NQ7jKBwXFkdZBVLsI5UWEt02+hik3fM1Ou5e0a6Xw7IMPJUBddsR36VuLgi8Twz5WQc1tcZ1fhwsJCpEylxyV0+oiaUKHnFij2UZU3ObeDkzDffvSoPHy8CU72mIZ+uMZWWY16N5Tfk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=M3G1FUZJ; arc=fail smtp.client-ip=40.107.14.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8aOmOlSq7jZjcvxePxbn80gVD4m+0I7qNX5WVy+rs4dE9UYz1y8YwGfXxVfHrM6VISMaRBoaGSWYyYQwllOafsbCpIKJnglsK62BjOYWncQFlg8r94B3JM2yOer97OB5jt55mo428CU19lr3ek3i2HpYATtBRFItn9xkZJaPZD1uO1S+vJ7vW+N7uBWxfRp8qsScuDu0gCqLLEcGZSU8sjqvqTD7OSbelDklO6V8M+k8urwcFzO53ZHxBuHKvdZO07NL06aEQOaqS8w0n5HCAULo/GH6GqcnDBCuv9iXwparGNkPmQ8VyyRqIxR37HRQMpGrmszDgjs+R9+Nj3fig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa4EwFNeI1Pr3jkX8ALbOt6amLJLxrCA/F108FRHnQw=;
 b=cAcUMfxPQDvzCEfEC/WleYKNb8XSc1xZsFkqT7my+E1/eK1j+6WxOwvit9iBwNO+tDujWXih7K5HiHTDyzRSzVoSRLPmT8Tg+9iqag4hdoqblTKYTK4HM0M0MpwG5JB0AqL+IxpOkGCQbS/bprr6MvIeUedSrE5tjjOZiUAHB4cSMpsDXoA/Zc8P1CEIRaUrp1xOn1QcEIxc39lsp4DryJ4ouEQbiGKFJehnIG6dE6b6IbdEf27cU7FdVNKOoetIvTIpXD33/uk4fyiFRJ4aiAMdHDBFwxsXD6rtm0skCrIyiCHx+t1gNqFkGTpswlU9YmLnXzS2u/23owS4UIvsIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa4EwFNeI1Pr3jkX8ALbOt6amLJLxrCA/F108FRHnQw=;
 b=M3G1FUZJz31W8zoL47ZUSFKhpyALcwjoWOK+gGZPBdsNnJUWmiENtd685afJsIpUc90lwJp136t0IENVo3Pb0mqluML0RWm57WCmyStnNnbcsTRf32gCd1OqfMmgSy51yjth2c9u4w9owPPMYaSj05vdomQQchUNYEc0q7+ZK6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU0PR08MB10358.eurprd08.prod.outlook.com (2603:10a6:10:415::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 16:25:29 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 16:25:29 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH RESEND 0/2] usb: typec: tipd: fix event checking in
 interrupt service routines
Date: Thu, 28 Mar 2024 17:25:20 +0100
Message-Id: <20240328-tps6598x_fix_event_handling-v1-0-865842a30009@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPCZBWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyML3ZKCYjNTS4uK+LTMivjUstS8knigupSczLx0XYu0tDTjRDMDQ4s
 USyWgCQVFqUBVYNOjlYJcg139XJRia2sBpC4+g3UAAAA=
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Abdel Alkuor <abdelalkuor@geotab.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711643129; l=1584;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=VLSh7akUhIgMn3xB/pYmXrnbq8Pdxkzfa7FYdSs/QJ4=;
 b=L/vqrldhtXEGPxjrm6Z1YMeFNUuDqdeUe3/cow7+ZieRLcQRhn9yN2uY1HtDbfhxpdgq3MX9L
 NAJGaN5F4gbBx/QUDuxCUBRRy1/0qILjtxsj1Hw496qpk5Q81YdaIh2
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VI1PR0102CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::39) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB10358:EE_
X-MS-Office365-Filtering-Correlation-Id: b85aec0d-b2d7-434e-0fc5-08dc4f43aeb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b5ZlBnJvbAASyZTqT9SZ8eOumkgA/0LDlPVTFFcUtq/AfB9pLXpbp9jKHA7q6RY62r5CW2ZWh20AGMsR9WKiIGQIBaOiVFPPbQa2QtmYmzvwWsKURJpcHH6bzjXxLknLqaX1YM10Pgqo130j+P/S/IlvN2kZPm5sL+jSBYlks8k76RUt2z4bMGCPnS3xLsgwvhJP8WjWw5QJGEVV0vjGaxMudTE6qp6N+qpVLN95qu9Bt3P5c2URv6ZU8W8r0CPuYu1ipFNv2XOD9G1A2VehVOTQmniWAucU+9NkoOGznghOEZhcxveGmlT9HMjQHGhosGYoyjaj045JRo9YsrX0Oy+psGwZOyDyjc+VPDpDzlnQAzy0OdFgwhTCNlXgwxYw5bBi4gYFo4AgUV5fGoP9wEO6TW4NpLQA0qV55uyguwuG5Zzpp+JZ+n3acybxaBx4DBrI4eM1GmgXP6/r3W6mClvhIwAYVKhQhE9PC/43ZYbEm5/NNkewBGjkVrpS2oTsnP6Be2SOzkZPxPCz3DcCtfElSZxHBxf3WuZoTixNWvMrgp1UbkrRQ7bsdEs3TRJCpgRIQEPPeGUueFIUWAzC0Gr+Ixv19gHBAhhhNKGKvgC++9HMbKCs+yAQkZ1PzQXQit5emRpVo5m269V8jWUTiUXVjyqG+Tcryj5ocel3sFEQ9PsygUd3dlNrRdzYprW6pMDsAhilNXEmtYUswBuv0A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0F5U2ZRODlzZ0o2NFhJR3lOQW1wVnc4TjNBK0FKS0RBc3ZSbWQ4b0FrV1pB?=
 =?utf-8?B?MUhRdFFaQnFmTTAvVmtncHhOZHdETkJvOVVZcHExQlRPWUs1cm5odWp6U2dy?=
 =?utf-8?B?NGVDYU1HcnhhOC92TlpwaStrbXNIbUpkNEs2V2c5QVl5V3ljS2ZhcktJaW5R?=
 =?utf-8?B?eWcwTzc3bU8xWUpaQmswdU8yYXh1ZjBOV2dkbzNqNWl2ZUYyd0k1YTlXNDR4?=
 =?utf-8?B?c3hYK1V6V1lCL3FoMEhncUdmZzdXREp3cmhGaUVJNzIxbnlJdnQvbGdRWTkv?=
 =?utf-8?B?M1NkZ1JBMWxBZWJ5TXdrQ0Q3TGFjbkJYdllmelJEUkdIZEFvWGRIbEtCUWpY?=
 =?utf-8?B?aDlTOE8zMGdSOTE4ZVJEaVNOZWZNc0lVaUlqdGdGT1dTOVJpYlI1eHNpQ3RN?=
 =?utf-8?B?bytSV0ZWVFBvS3BOS1MrTUtNNkhlRW9qSGFtMkZrZjJyN0JnZGsvdWVveWNM?=
 =?utf-8?B?RHc2ckFLWTFWdzRXakN0MUU4UWpLMFBVL1MyV2h6UENwZVhYNk55OEwyOEll?=
 =?utf-8?B?M2xkN1Z5a0N1czZYZk4wUFNpYXh4WFBoZHZ1NHRiY3hEU0ZjZXMwQ0laSXNv?=
 =?utf-8?B?RCtMVTUxMnBLVDZOZjhKTjhCUFR3ZUNFNThBem5WU1JGSjRONktiVWFBTS9O?=
 =?utf-8?B?Um9OOGhFb1h1VEJlYWpIQ1Q1Mm1SZExWbGxlNXlhWWRKbWJZTGx3MTFuT3BK?=
 =?utf-8?B?R2Z5SjlyUnJYV3l4a3oreWRiZXQ3UUZpbndvekVzbDlCb0FKNllNT2NSMXhF?=
 =?utf-8?B?Z29jbDBzaGM2UjhoeHZBSUMyZDN5elJzOXhSMEYrRlFrZXY2dzIzV2dTSUdG?=
 =?utf-8?B?K0p6amtCT2Rhb0RoUkVENVgwdU0yS1RQSFZHdVdrVlN0bjBnbEgyYXYycmhs?=
 =?utf-8?B?Zkl2NjgrY0VxNXg2VWQ1R1BPdlBnOUF4TWlwVk5IbnA4M29kd29pcDR2cjFX?=
 =?utf-8?B?U0V3VVF0cjNmZW5FN200WVo4YnkxQ0NFVHY1SGo0TWc3RlJsVGZFa0RzbExF?=
 =?utf-8?B?NzQrTVRxOVZTb1JXbWJsbHdSQVQyTTVEc2FIODA5TTFSYzI1OHNROE5vREh4?=
 =?utf-8?B?aEs3YkhHbXFXT0Y0ZU1ycGE1WEpBdXBDalZERkkxNTZ2bEJ3Uk5VM1lmR0RT?=
 =?utf-8?B?aWpSaG1JbUVtQmY3Vlp3QXJNa2xLTGRUM0NLNlpoRVQ2cGlmd3BEMUx3VDFi?=
 =?utf-8?B?KzU0VkdGSFVlSEViWk9tYStheFNjKysrSndSc0tqV1hOeGMwQU1FRldaYmxr?=
 =?utf-8?B?eHRncWIzVEJSeTVteXhuQW00S3ZDTys2N3o2TkhwVVNXSzh2aVFReDFGUzY3?=
 =?utf-8?B?TmFPMXJUK3VoK3puVnpYci9PbjY1bXMxQWVXbTc0K3V6LzdleG4xOVVtSHV2?=
 =?utf-8?B?TVQ5aEwxdVpZc2pBMzhGb0hBR2xFTFovcWg4bmJNME5MMmU3d01NbW9uK0hR?=
 =?utf-8?B?Wng4SjgwbWpYNlE1UlEwNjMrSCtiMWRIVFkrSWZLVWtqZTEwUy9EMXhBckVu?=
 =?utf-8?B?cUh3cFdMYU5RdVl2Y3JIZEoyaDUzY1ZjTUZ6WG50QjJyU1E4ditpalg3OUFi?=
 =?utf-8?B?b1FJMmJiMzA5MGE3clVyU0wyMDNweURvdWI3ZUJmMklCNmNtM0V1THNsWHhw?=
 =?utf-8?B?OW5iOFJLUThLMmVQSWFNdUE5aFh5R0ExQ0lGd2tEbUVqdytGWVgxbjZDOHFY?=
 =?utf-8?B?OWlVN1lzQ1luc3h3RWxzODIrZWVhU3ZMbWJsOGRESFN3RlRmNVMvN0srSytY?=
 =?utf-8?B?eG1HTWJKN0MxUStva3ZGdFhQNzNJSGwzOHBNbjViTWYxYTVqczF1Q2hxdWFt?=
 =?utf-8?B?M3grVVMxTEZmek9NR2pYTTFCZUJlK0JRZG10LzRuT3lDRFJBeHdGdWFCanpj?=
 =?utf-8?B?enAyUzMzOVdNakhJUVF2SVpkeTRVRDF4VXY0OHlLbDRKTVAra3Vtc3drV2w3?=
 =?utf-8?B?V0tsYm5yelU3YjFLVkIxQ3VOZU5IMXhQYS9pdnhkd0FRc3BhUldlU2VudjlV?=
 =?utf-8?B?UUlhZnhrOWRTUzBVR3R1aGlzTjR4WjZ5RVdicjVBc0FnQnpiNSs2VndjZkRl?=
 =?utf-8?B?QzlOaEtwVThCWWhiTDRQQ0hyQVkrODdSRmxXcUlmL1A2K3hMMUlkbXFLdTJt?=
 =?utf-8?B?SENEMTBVRUswTFpKdXlCT1lmK1ZYY0Ntcldyb1pCMllBNUtEdlZwemFML2ty?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b85aec0d-b2d7-434e-0fc5-08dc4f43aeb9
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 16:25:29.3577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: reMhklkkHRtwfx/iWkdDf4F57vdQTePOODPydM6rQMEaKfXfNP20Ulw1TxvsDhyJ+2yom1shycn2JUzIr4IgEc7X9lgo80EWcDlPN7/9DDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB10358

The ISRs of the tps25750 and tps6598x do not handle generated events
properly under all circumstances.

The tps6598x ISR does not read all bits of the INT_EVENTX registers,
leaving events signaled with bits above 64 unattended. Moreover, these
events are not cleared, leaving the interrupt enabled.

The tps25750 reads all bits of the INT_EVENT1 register, but the event
checking is not right because the same event is checked in two different
regions of the same register by means of an OR operation.

This series aims to fix both issues by reading all bits of the
INT_EVENTX registers, and limiting the event checking to the region
where the supported events are defined (currently they are limited to
the first 64 bits of the registers, as the are defined as BIT_ULL()).

If the need for events above the first 64 bits of the INT_EVENTX
registers arises, a different mechanism might be required. But for the
current needs, all definitions can be left as they are.

Note: resend to add 'stable' mailing list (fixes in the series).

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Javier Carrasco (2):
      usb: typec: tipd: fix event checking for tps25750
      usb: typec: tipd: fix event checking for tps6598x

 drivers/usb/typec/tipd/core.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240328-tps6598x_fix_event_handling-8fff3a6018d9

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>


