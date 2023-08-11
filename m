Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D974D778BA6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjHKKOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjHKKOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:14:19 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2047.outbound.protection.outlook.com [40.107.249.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643645247;
        Fri, 11 Aug 2023 03:13:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNreWm3vGHrrAep+nshJNdXtqRPoA89jBc5yZc5o2ey6WB6NHbfRdyE1QChFuXSpkAk83maXnx019xyZI/ZFzfV/+OPEEky9ifib5bK3ZT60KTDGtwt2aKej26k4lasMyH1G7aGgpyHbtK8moh7nLfnUNaBP23GBIDRwqOVVEymzHAtDjmXImZSX75cynAnVu9wOpVtj8e7NXF2DbQy+HaFKm2vM8Vr6JqGHDkXzw7+Nxpq7euhjqKSz9mAH+JLIhTJLLKgS4f6PCtNUn9Ct7G1t0lA6J0zf6pQdocBsBa3616tfQOVCRILlZJ/ZoV1uhKfBzGKKlhkSt4I66VKPkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rycIkm4I/eQtJoiXewSPV9qcJ8yPGak3fOOIKP18G80=;
 b=IsdpetNkgdqlveiZ3OT/+OguD19sL4CgZwSITE3ddRiz3ANxCXsKrw6cJgL2v5I+E9PMDwQiqkTYgpDEEfhCCpKmWm7LxwqEP0vHFShYuZEqaTAT0pJfz58whYmBC0X91skCdGliwq7eB8mzXBRKUxItuJYxjY1A2AcHIhTWKVguZHL7oeSCLH/rbx0f1I2pC7Drh98lFVl/iw64PfJYdDvsPJpEo2oJQAQigoccu2RIAnmkH0HIG/pL2vhJ4Nv64R5PPRXaJsK5CJ8C5EJcr4VYPbzIqT6r/dQCD+l35x2vlUbR8YtIFTn5xKYLlP2gE3FZ5m7DwMXDKUuob/dlmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rycIkm4I/eQtJoiXewSPV9qcJ8yPGak3fOOIKP18G80=;
 b=ZFqXfS2dufg4Dfvrp/Iqs/bVkwFofXQnAD4wBirMg1iTGt+86xzcdGvYAwA2FgndCbjr0BIB1TQ16KVEUZP4/0ke4ZKFbLJAMHvA0oO9n7W8QRsewviFCW2V+OkreiNaOKRKLVcMn77my7Ehf0IH4amHRAvy7SrPYWein+nbpdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by PAXPR04MB8441.eurprd04.prod.outlook.com (2603:10a6:102:1d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 10:12:19 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7504:9897:4e5d:df25]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7504:9897:4e5d:df25%4]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 10:12:19 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com
Cc:     neeraj.sanjaykale@nxp.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: btnxpuart: Remove check for CTS low after FW download
Date:   Fri, 11 Aug 2023 15:42:31 +0530
Message-Id: <20230811101232.844769-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811101232.844769-1-neeraj.sanjaykale@nxp.com>
References: <20230811101232.844769-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|PAXPR04MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e7ed39-8ba7-4d75-49c2-08db9a537252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: agZEbx+9C+Lts44dof0JYM1HRuK++ZuTmUrT7W2PaJ9U98pDDC8KlKmeOXoM5xh4Vs1EpWZpwo8jRlqqQEE3XQsp0aTCQzcYFrsZbmvRO7AkLyt0jVURdz4HlkqYypYSu7P9VfJUOkyeprblvO2Vo8FV+ptTCHglMZermHDMGOcQ9MFokJ4+Gn9DeFS8bU55ptI8j/ilMrnE3brIWuj936Ozu1JOW+3/wV817mIPt03Y6ctxtQ2cFwh40OERIYo3eEd0lIZNpjWMuLpnLQYkfRh1OOjiVHa18XFM1xP+1d2FkM64ubR+NTpLgj2B+FDycXSSOY6HCInO6hXFlL/MUs6sXrvDfneChFjrGTash/i1hZQCQbLuPkL7tKCOKjvff7g+NaqD4LPdjLfbMdmVHHPvHm6ltiD8MGY1hhSmIn84KndFLhlWI697vmSn1Ca0IP193mzcgv3hZtV4rb86Zv7RJ5FzQYltaocGQtf0UEZ+tbB62jryd7wyw56CmJjfM9LRPErPNjelgosAWpDgYc6AvYpseThyiDPsa5z7t0iSVdg3BoXtEbZIpBHLz7d8FqiVf5ugQZsmTxmhUVO5atVamzKq0QjOfFb7AU0nrDX3NHAHcF40q+35jD3L6XkW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(376002)(346002)(186006)(451199021)(1800799006)(6666004)(83380400001)(2616005)(2906002)(478600001)(41300700001)(6512007)(26005)(316002)(1076003)(4326008)(6506007)(36756003)(66946007)(66556008)(66476007)(6636002)(38350700002)(38100700002)(52116002)(86362001)(8676002)(8936002)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vKtVOGm4KUThJPu6oNy6IXQRH2zmi1T4UzY2cgChS/59c3YzUFVy53jZ2+ka?=
 =?us-ascii?Q?AfdBUsjXJY519eRtO1+qjgXX+kvSEDfi+eLH44HMTGKPOcGP+RCCxmsQJ0aq?=
 =?us-ascii?Q?v/dG8phGwM8WZqGS1w5NrBEs281UtFPjQkz5CsWrnYGyxsVpVSudD6uzxJST?=
 =?us-ascii?Q?skumovuXE8wxRARG+rWzFwH0JcnIvlchNf9JlZE6EvSpwBo6bSaEx7HNhIWX?=
 =?us-ascii?Q?vSrsDcn1eL91AyWPQBCFkOYKD9XhLbwRN42pvArWpkolKp1Lsr/Tg6hKkejh?=
 =?us-ascii?Q?HskGOCMLw+8xCisi1g2oMr/7tem1ovrViN7ljoH7HMRZb/19ahecrnMKqOMc?=
 =?us-ascii?Q?oyLQKsCYTKQ+wgBYnqUe3f7VqG3uVM9hYlEn7Ny+fTGIXj+vj2rMaUymq3Pe?=
 =?us-ascii?Q?jDI8XjclueYdsvvZQ3DkMkfuPsHgw0BifTNNrIsywrau2udiiG3asdurryZs?=
 =?us-ascii?Q?//LaaBlGv6TIenNRRM29SANWM7ElWsojiaIJ3OmEoqd4hSyPhUWdbTB7URuH?=
 =?us-ascii?Q?7IaOzwsaXsi+U+qru5zHyu8dLHvL5fMheTJEkTmu91+RhWhzMzxLD4Rtxh/p?=
 =?us-ascii?Q?UeJRaOdCdfgLt8vQwoc3EgclkFcms6wGggaOsnBUPaOYYW0poBju9a6/LiGh?=
 =?us-ascii?Q?NL5xwfBuJLQNufEHjN/YHIMMWRNIiAUeJUe24yn88h5q6/QQI318qaVCeIyG?=
 =?us-ascii?Q?sfdqfxXZNlcik3UYNyc/qVV+cij+J8plLSYjwd8mOIk+OxEGx8EUv4L95J/L?=
 =?us-ascii?Q?6O0pOpfW2GHXZ0mgS1aIpkZRP+WONkUPTJheE5ZaVHqKQZ4XirM+74OhJVcQ?=
 =?us-ascii?Q?Anc4zBCX0s/Fs+ZYL7xELG42fv2x20xqEJn3Kt7kz61/4A2wa4ZKrG3IDqhM?=
 =?us-ascii?Q?7KMYWTh1UHg6pUdoE4uZ8Np+OeZsI6040I+n+ZSnWS/7cOAws1iHrOdIbJRJ?=
 =?us-ascii?Q?1iLWO3J0bA3gN8skNgtt9U+oqqpo2Dn13vTq3r/c8WQi9GZYr2/nAiMSlY3C?=
 =?us-ascii?Q?Mj8Fh41XWe7qZzWtiNu3H2zgCyiMp7QvBXqjxm2aj08mUKNsa7KQRqAAFsd9?=
 =?us-ascii?Q?55iHyT0gniB6OyCnz0K8h9o1bh1yPIUqWwZNJfUE88kfBHrxHJXq/fDZq/1v?=
 =?us-ascii?Q?26l3g2AzI0ml/+BgZf1OSm/93BBLAZRcbKivevbFkKbLVJX/GeX9xMtCBr8c?=
 =?us-ascii?Q?mpIdDggKMZOC3MTmle1ktz+YUkf0m6Ju057Zrh7rSkJt/pzOP5emXBAic3Xr?=
 =?us-ascii?Q?rgioPkZvU1DuP41aT3g3rv6QFhXzylUmKy+/vGKuPHI+3JlbfkaYTwL/nQK7?=
 =?us-ascii?Q?YQ7PB5eVbHuJE8rE/vsAjCy3CL5KYG6/0gXaaaTSl3TZnnDzHQuOmCZPU7W7?=
 =?us-ascii?Q?11QngaYbLxb8zthOIdFtUL2GrzLC/dUY6rSlpglgu0gySObrlKiwtKXHKPeo?=
 =?us-ascii?Q?ICNmlYFmS9pJU01gsupjXDlrCA0BAGQ3mogMGNiZVkGNxnV3UfokHeXNtXUH?=
 =?us-ascii?Q?4EjVCyPcl29D52/LQkMLbV7t6PQB1frv5K5Mm7Tpc8C3SQqZtUeUZaX5MN2H?=
 =?us-ascii?Q?MJbwd0cX1A5z1wyrcYdWxAScE1VHg2QDc5gbo7+A/ovNy7oemcHHQYiYCh2t?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e7ed39-8ba7-4d75-49c2-08db9a537252
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 10:12:19.5695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8iIukwsOHGupMtLmrFVSKbA0tHVkqS8SfV5VKZDHsyb6RxASQSBWDPGe3ENP8vuEo/rowUocAmitp6LblgWtMwv0bQW6p6I+f5xD4mb9Xx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8441
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the unnecessary check for CTS low after FW download.

After FW download is complete, the CTS line is already seen low.
It becomes high after 2 msec, and low again after FW initialization
is complete.
This makes the current check for CTS low redundant.

This removes the wait for CTS low section and increase delay to
1200msec instead, which is sufficiant for all NXP chipsets to
initialize FW.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Remove wait_for_cts low check in a separate commit (Francesco
Dolcini)
---
 drivers/bluetooth/btnxpuart.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index ee6f6c872a34..1dd60c7e6fe0 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -558,16 +558,11 @@ static int nxp_download_firmware(struct hci_dev *hdev)
 	}
 
 	serdev_device_set_flow_control(nxpdev->serdev, true);
-	err = serdev_device_wait_for_cts(nxpdev->serdev, 1, 60000);
-	if (err < 0) {
-		bt_dev_err(hdev, "CTS is still high. FW Download failed.");
-		return err;
-	}
 	release_firmware(nxpdev->fw);
 	memset(nxpdev->fw_name, 0, sizeof(nxpdev->fw_name));
 
 	/* Allow the downloaded FW to initialize */
-	usleep_range(800 * USEC_PER_MSEC, 1 * USEC_PER_SEC);
+	msleep(1200);
 
 	return 0;
 }
-- 
2.34.1

