Return-Path: <linux-kernel+bounces-8800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4034E81BC72
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE901F2220B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ADA64A93;
	Thu, 21 Dec 2023 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IasY44lk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2053.outbound.protection.outlook.com [40.107.15.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F463503;
	Thu, 21 Dec 2023 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bP/H7UlzxF2QmcfAx8HdmaIjpxKVtdslBtOpdyrRjsqt/NxJCmnfxmgvHq3uGLDLu3PXHro8H6L0g/0Yct5PwjnW91bfzpp9hd2h1cs1xrzMBAZQnORevcZACiDzS8LVFsAAAM8dUyiBkh1L9PRnqJhAaxZklDvecOZLCcdsw8d7TNeChcYG1Bcb7x6bqWzPDRzSH+/dgjtrRrHzeTCUuqtQxXJ77XsmALxthH6bFfSyCamClIGjx3ad7bPvzl0QH2ti1OF4Xpb7soSbEYw8FwKFbZ8Grth0Vad9QjaOmaP0ppowoQHAJo8rWBwThP+eQGtuXPuTyOyEhxr0fhGMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqLzhXm7w+Z4S953PqAan6WN230SCZ/ZGpCHh5sp2NE=;
 b=FsT2V5f95TOnV2QCJnYIxocodzsasSUfeK1vxMooCruyNC6+FZV+3gwKR8AmU/ujlg8uQJuTWjPuaKzknSd4p86DtRV/MQKy0EvVob/hll/mnk9xxhnDyvNh7s/tqnxniz32sUFl28nJQdsoaAXeER9fZfatPSjmum6lvBTHedPC43WzgJzp7ylhoAbHxsRdwUBAQKEZGYkcrKIoHbDBRRrIBuGmxZG9b6if7/Y0E0/EiSApMyNg2JLiykkL9oBunKTVdkCwuCkrZCLJNtXAblfcExObg1yLo6G0ExtYv/FiNRDrZVBkaeJFGk7UY/DXbRmBLsnTiZ3iYDO379YCCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqLzhXm7w+Z4S953PqAan6WN230SCZ/ZGpCHh5sp2NE=;
 b=IasY44lkS26oNEmdNqlNRwsIJPplF4Efo762T7UvDqCTKpFny8f1VEAinPIxEkCrJmfVAhR8J2FjX6rwhmC5YEVVRllI4/9MSYnuAeumUFaZwOCs2vUFUGmhJ6UCj2p/BnTkt0J5qWpH9j347h2sw5EzfgXYiwjhZZlSrLmZmD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7324.eurprd04.prod.outlook.com (2603:10a6:102:91::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 16:54:52 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 16:54:52 +0000
From: Frank Li <Frank.Li@nxp.com>
To: peter.chen@kernel.org,
	cugyly@163.com
Cc: Frank.Li@nxp.com,
	a-govindraju@ti.com,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pawell@cadence.com,
	rogerq@kernel.org
Subject: [PATCH 4/4] Revert "usb: gadget: f_uvc: change endpoint allocation in uvc_function_bind()"
Date: Thu, 21 Dec 2023 11:54:26 -0500
Message-Id: <20231221165426.1590866-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221165426.1590866-1-Frank.Li@nxp.com>
References: <20231221165426.1590866-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::21) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PR3PR04MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 4927bfe6-e06e-4ad7-0454-08dc02458d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vd5K+vbCdtN8PTC7YdHoWxWVNlDokVYUEnJi7d2Q1vRoVJJ9TfJUlLleLSt3KvnwkEisD2nIHhAKmYa6CSaYhoUhn30/Qriwf17SBXRb3YD8brgY3CFWmQOv9EajRcMpo7jBlDsKi6cRHG92zOl/oIN5/7MAD0XsQ7bbG87oeTDo2m+tyHaBllYhjA3PpoFpe9taiurrmBqlJo38tJnyE9y16DfdrBaXzybDhbMu6RxXTeJ+ArNaxKkktHptOGOnSNJ+Re3zUaGzxIIS4BmWrJaO0zYSeIMPA1oYTEwaIvrJJb0iJOS2sxHNzoQy8egVU7taP2675CCACwlwQgr1LQaWn5jmVhyeIBlFJJM54yiauHfgxpVTk263rzkDt/oVtAIyBBR0KDzUAgXDlJlX2Q1j/s9WePWyrP44TtVHC/sk3Z9vFLXzUTsLRRk4lLY7HybF5YujonAd0iSVz5mVxoQl3MXdniIomFSzalI/J2BR1jZo7im8FP2zK0f7yx7TF4ZSSw/WDPfcGlohWPl5QdsqkEym1VGh44Fa8+Zhxs8gw8jRO88byDx+09QWPcXuqM/hNpJ4t1MfpTLCD9MOfwiS+c0HCYXoLjOu1VVws3he6k/jZlsv3edzUEFDSReW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2616005)(6512007)(6666004)(26005)(6506007)(1076003)(52116002)(83380400001)(4326008)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(5660300002)(66946007)(66476007)(66556008)(36756003)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fj2Sab4oPmLafOSZ6T45riIbVP1QZ7RLKkHqmIgtTmtsTfebH6SBmv17DzCd?=
 =?us-ascii?Q?vZPcchx0v+EhRUeWUJbeOm/bwKIyQZTX7h/ggJjxPFyUEALal7irsY3OGcE5?=
 =?us-ascii?Q?P2InlsXhSyuNifcPAEP64urKN7+KI1w/V2kFBWYgtMfXntjYvVTRz7e8mELq?=
 =?us-ascii?Q?xuIZrt7mO2ABrU+LJ7dVDVAC+xIEcKE1GcD7sf2XOr2QHaMOULvJTIo2OCTS?=
 =?us-ascii?Q?sedQYInVHnXniJRh3XkfijL0pViYfi22OZAGxi6R10ZEr6KwWzKjGgDfhjxl?=
 =?us-ascii?Q?0AhEnJ+8b1u/mK/IdX7UrFHZtcHcA5T8ZoKEiiBXnmY0e3J+TRcC94uMZ+gZ?=
 =?us-ascii?Q?mwWkWIQNlpPXrxHldmvjmYumh4w7LcCG9isg7SIW0QrMmOzHCCjzu8ZP6uRa?=
 =?us-ascii?Q?GhDSy3jsRMyauZuXLYuBOkIV2m359cQd6J+8YEd2bV4A/ROr4EGcerAaUaQH?=
 =?us-ascii?Q?dzaS4mykti8GybtTAaMUONIZfAJ+O7U1FszChtzc3fdlelwN9gjyDFtWjDjo?=
 =?us-ascii?Q?sy2DM1f2Z+ubF0u6xalu2rxCToj05QBsvoqHR+xUCce2+2fv/TJyNnc0nfAL?=
 =?us-ascii?Q?rEIOCbpIbKi+j+cfLSkXmlF/NNJhn99VvzJ2g3Brs1oeWa0EV1AWxab8USCe?=
 =?us-ascii?Q?ez6LAr+klKsdQX4dA4YrEyNPdAIo265BclT5EQ2lDbPk5BUVGDc0K9pKsCs+?=
 =?us-ascii?Q?YjiABgV4bOhJRd+SWxASiIx8d5zUZ+JWwe7fIHeBJmTWb7BPJs6Z6DZgS6Mp?=
 =?us-ascii?Q?GULwdVFFTOJcD30qDwMD2a0i3Ehi/uoy78A1m47HEq/03eoMDouuquPuCgow?=
 =?us-ascii?Q?YO1XwgfvIh6zllpfInCeC3V5k15peXw8H0zLl/l3wKzoSv9BABqvc303gTJp?=
 =?us-ascii?Q?65Ht6SsJ4HfZUu0CWcIWJy8R3PAxpwzhI6NLW2dJj++EPNEnD0UGazy2LPmd?=
 =?us-ascii?Q?7STEdTSJ4S5hkF1A9SE/W7mMPaykxYzeCBgTzCVvsR5Rp6zTtGq+PHKm6swS?=
 =?us-ascii?Q?D1pNhA/M+2wEZ7BebNOQRIB/+4XG48cggeKFFGxVy/np2V6qs6Mpm0CcRUWC?=
 =?us-ascii?Q?nz2N6zWUfLAGxWgVXo2ZS99RFVe0X2yez1lkGxg+TlLEjw8S6p8n0LTMmJPK?=
 =?us-ascii?Q?ssPxi5XRe16zTP8RCQCXBEzNPb6vnieTOGpvcoqSKbteySzbGCrGx1eH2+5r?=
 =?us-ascii?Q?QF92HQgMuslQWAPGwovhaayXX8aTZD4vxXX5vKNbHJ/P9aBcJhHoYOIzMGFf?=
 =?us-ascii?Q?VNbU6fjo4sVtX967atxHXAjZhgYWulXLtbtbmc1Lj9OW1Co7GPBYyv3brcf5?=
 =?us-ascii?Q?/bdxKT6Ku9JzvAhnfv09SNKMZdKskjS7knkSg0fMWltp2lluG/e9/4FHiK10?=
 =?us-ascii?Q?pfrUxJZGjYQLbtsUiTPC5Be6EtpbcB/QydCgbnSMyYwYvtX97EHHhvF3MiAZ?=
 =?us-ascii?Q?4DdU/dMge6zSQRqnrEnPUCR25J4mpkNu+6YY9YjUbiJl80qiRRawVsqfk/qx?=
 =?us-ascii?Q?h6t+BQNI/hce9JpUVmoHe0clSdYaCGWaH99Vsbw0bD5HtCEcwK9nfXLwXOK6?=
 =?us-ascii?Q?cC8foswuZA6EjljakgiwnOQDvtuwMM39WuhMZhNP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4927bfe6-e06e-4ad7-0454-08dc02458d32
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 16:54:52.5966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zbfeu7dtY9yy8jjzuRx9ymsZAHCth4jlcnTtRb+gdDhKGNdzeVUG3icyoLgF8slVBEfVH27DuSJMktXZLkll0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7324

This reverts commit 3c5b006f3ee800b4bd9ed37b3a8f271b8560126e.

gadget_is_{super|dual}speed() API check UDC controller capitblity. It
should pass down highest speed endpoint descriptor to UDC controller. So
UDC controller driver can reserve enough resource at check_config(),
especially mult and maxburst. So UDC driver (such as cdns3) can know need
at least (mult + 1) * (maxburst + 1) * wMaxPacketSize internal memory for
this uvc functions.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/gadget/function/f_uvc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index faa398109431f..cc4e08c8169b4 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -719,13 +719,21 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	}
 	uvc->enable_interrupt_ep = opts->enable_interrupt_ep;
 
-	ep = usb_ep_autoconfig(cdev->gadget, &uvc_fs_streaming_ep);
+	if (gadget_is_superspeed(c->cdev->gadget))
+		ep = usb_ep_autoconfig_ss(cdev->gadget, &uvc_ss_streaming_ep,
+					  &uvc_ss_streaming_comp);
+	else if (gadget_is_dualspeed(cdev->gadget))
+		ep = usb_ep_autoconfig(cdev->gadget, &uvc_hs_streaming_ep);
+	else
+		ep = usb_ep_autoconfig(cdev->gadget, &uvc_fs_streaming_ep);
+
 	if (!ep) {
 		uvcg_info(f, "Unable to allocate streaming EP\n");
 		goto error;
 	}
 	uvc->video.ep = ep;
 
+	uvc_fs_streaming_ep.bEndpointAddress = uvc->video.ep->address;
 	uvc_hs_streaming_ep.bEndpointAddress = uvc->video.ep->address;
 	uvc_ss_streaming_ep.bEndpointAddress = uvc->video.ep->address;
 
-- 
2.34.1


