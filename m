Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EB67B45D2
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 09:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbjJAHsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 03:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbjJAHsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 03:48:24 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2040.outbound.protection.outlook.com [40.107.14.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401C5C2;
        Sun,  1 Oct 2023 00:48:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLB0t7zC/lq3iMg+c9TVDX9Ayl+IqmP0Se1vwHZIS7p1TiOPI4/HMHv2OWB571dOVWVVszuD/Eg+86scSQeWOBaO7rSOWD/A76JPfWiS5PKSsZbWDqUl/5O/Z6D0+/N0VihsUSoMYXfRWcW+/1Btr3HGDMFGZYr/pbPDjipo/iYDuwRP4ePyi1feQnzBs0ebmw/LYJ7AuK0ll+v1nrx1AGjfA9/lgR+xL8V2x7CP032r7CMljWd4uEkD2WLfzCWbP7XqwN5rwMgg2aV4dSI+cnETOwmM2RGykQ6n+aYLj+38Yngf3/v7fu3JD+iFRjvOhIbZ0wDvQ5fwmJYW62w9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0MNFp2UntHJFx1dXGI+BT0ZJ6l0Ay9Gxz6P+d2eqlQ=;
 b=G4sWXEbxJjEN8+7wtibDI11Wf4KbUFlmCOThzYUshKM+I2hqnif2J5Q4jznu8VpTNl0HtSg+KL0HMUfUv/YWCeQIOKK5jYRRXpBJY9v5ucjVhi17JFFKbf3fOq3knrTR69EM1bAwerXqVUOnEyZgVp+xxd5A/t0za80reP/f8IdCQb4KOXpR6YGm6HpnB900x7TzacLMNH6HF8gPNWmmjeVc+uNehFz0eygpQ40QnjtCH8zxbchXfaV2upanvV7wLIBeEmYDrTpycjrxuHUYSFc7PwOvq2aEF57jPqG9vwdqJWIdPIF4oLol6oztZyQOCDPThU7Vy2Wa25HBMhg5dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0MNFp2UntHJFx1dXGI+BT0ZJ6l0Ay9Gxz6P+d2eqlQ=;
 b=oz1V9/cvFEADADhJabXqwMwSl0qRWCveCmCt83Zf9Spu3+0OvbG8PIirLFo5u3RiQ1XIInoU2O2EOWuosMFTJ6CaOVZW3jUaCM3kqMbvzCI/e0YbL9GvAmPPxGripTwwdL4ko81Yzx5IDIYCt78rJtMja6hruaRTVo52Tq7ytOPyYUsNO4PC/P8YuEMiXFIWWiOExtsZwGi++4xGjx97ViNCKXSARrXkCnfGpxoSmFn0iTIv8LfOnDBPie6L7YIvujnROKqJsumtmGLUaM/9ZvlRDwbj8J9uRMNydicJbs8jp5AcYo1gdxlNYcbQqQVNVIljm9dG+pA+0XG7/TMtMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by DBBPR04MB7531.eurprd04.prod.outlook.com (2603:10a6:10:20c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Sun, 1 Oct
 2023 07:48:18 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2%4]) with mapi id 15.20.6813.027; Sun, 1 Oct 2023
 07:48:18 +0000
Date:   Sun, 1 Oct 2023 15:48:07 +0800
From:   "Lee, Chun-Yi" <jlee@suse.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_event: Ignore NULL link key
Message-ID: <20231001074807.GA14403@linux-691t>
References: <20231001074524.GA14361@linux-691t>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001074524.GA14361@linux-691t>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYCP286CA0169.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::12) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|DBBPR04MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3fac63-3358-4cc8-fe11-08dbc252c715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9mXWXS8rrOCiAI2nuwCKmEidnmmNQMvYikNpS8GjteL1cFkIaWZbswbh3pN1UGhAig+3yiMSVf1bgZmy28XsrTzGUUyCAQD2UsM0m2dmxFPJ7nLIDKRCcGOajj4rk64L0oWFbIPaBEnE6Jp0L+qyuzpeV83CzvqSDKLIDUGsH4/nx1Du4kNCjkWnoKH/Z+IAhcs5cbAOHheMYxPQn1jLOansYWja1h5d8S7oVdbo9EJplp6vstEeeYlHSDYeHG6ORgrV/p4pNeXqvj+4BvK90uV860e7w6mGArnMLxUVhA8BEqisYVowJVrzn44s9BqfYGvQusJX2FF731/iINIXm3UKR8KT4/nZnFMNbLMjf1h7DJ0xharVZ114nliUonF0lD+edAj9G3fpEdOi+uCQPureV3rEvPU5ofM3G3QMJyTFQYt7j0b9C0Mm7HqvSiWH0bc0c0Dc2Gy+a8e87MBaVqfFvw0W0iofZXJXj3HlwStcYWOrPtLIRmuPoacjai+MoC3O7NdZeoYBZByQDyb4PcVJLBBOq0xz/o8BhXsecE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(66556008)(66476007)(316002)(110136005)(5660300002)(66946007)(41300700001)(966005)(8676002)(38100700002)(83380400001)(478600001)(9686003)(33716001)(86362001)(2906002)(6512007)(33656002)(8936002)(4326008)(6506007)(6486002)(6666004)(1076003)(26005)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k9opQ7n7Save4OoAPzWQnyApFFhun3zNwl62b4Za1q2sctL866oGXnLrbErK?=
 =?us-ascii?Q?SbD6fm79VJI9CPlKHdiQQEQnORKbEVR6mpW96QX9PUEWyU53JRJdRR8mm90p?=
 =?us-ascii?Q?qRA/yAehoiKFyxIsJ3ExPH0bFHaYnzJM8pFAUTkV/6mo6pDE78jKxjfVWWrY?=
 =?us-ascii?Q?tgeycwNkOtZCbFmob1mB3MyiCVUpNsca3stSXOpMnX88SjTBC+RAtB3QH5qi?=
 =?us-ascii?Q?lafbKQS8f43FF3OMxxiu+J2sCqHDZGfLQUufiIwqSsDF9UOg8NjWV4WndNdQ?=
 =?us-ascii?Q?xlnOORj+aYzLdSiPraPlgxaZA82+m7JS98YKmOhrCVW9bVTpFHaSIVX9wEM5?=
 =?us-ascii?Q?sm0Z/kZ5aChccZlzJb57e8wt1UHPjbJ3U/aGQcbDF6fn7Ezy04NjPnZl9cli?=
 =?us-ascii?Q?5o+psBWrJJL2tWZSvz8WnFGZfWc+xFDQuK2F2N0ygU64OkK2ug1ZnsbmRdxs?=
 =?us-ascii?Q?Dw3xKUvpTBKxUZfxhgKK1NQ8R4pzsbpTeak/tYqJTVy8qLHNNLQRKdzCXB6C?=
 =?us-ascii?Q?4AMvndt7Z06e+DsGqrA3z69w82I16mMqwWks4EEjHIQVKoPZ3ZmdFXEumATf?=
 =?us-ascii?Q?fkhYd5ynwlTJgorT2SXaywZth89xSDCV2GBF2jZERytgpD1IjaqlOXWQBWvm?=
 =?us-ascii?Q?xZpTPdMZYdSsQjGcUjioMzsFLf0g53pAMov1ryb4gUMcd+qMwpz8ihkqaWq+?=
 =?us-ascii?Q?MkPWjtKG4yn18Yugju+fFWym3AoDeF+UiQiFHJpz96g/KlK8DByDhV7GA1wy?=
 =?us-ascii?Q?0sn8Ynb/Kvv2iuKZECiJaVPt0YS1DHCyCzvMHXCYA2iMFD0wD7Qar3PRArOw?=
 =?us-ascii?Q?+SGcC6YXU/SY2iPPd3C0H/aAZrGsA2YzviD9fYY8VBzfSzb3ZI5scwmpPOxu?=
 =?us-ascii?Q?VAWWqP1XrIwIvGx6K7N7c9Dl0jpAzBzDZG5sEE2xBCmuxmJersNI+ii5Nl4d?=
 =?us-ascii?Q?q0SOJlKDlV1Z62L6i2pkpaomF7nhdEVi9m4es4WUB5xzwUimzfNDiD4NYjOq?=
 =?us-ascii?Q?kUH6yDqQWX/pH/hL8k1gMDxLMay1fFFq5gHZ+3LSOr60S04SUNvIrQZDImvO?=
 =?us-ascii?Q?XXEA0XOvuSTsjfNKC+Inz/jMG6UyMtKzk072lIlBjVFfEfLLMvf8hPHy/FB9?=
 =?us-ascii?Q?JwsT3QrJF/kmGjyTDy+vZZtBGw986nW7n0DewkrJdfiw9xF43/IPUhxwwt97?=
 =?us-ascii?Q?QMg03ruV3npzbqk86nu6g0sRRkIUGTeoAL3Qj+adGBBhy+6t+NalaSuF2a4Q?=
 =?us-ascii?Q?en+u0vhGKRwNJinkDjEPpgsuOIUCaItOwCXraDR0cNDvN6HSvIeDXUJ80fEr?=
 =?us-ascii?Q?NZF/vquSt2bDkJsECM9funVJ5V54f7U5lZor0Syqc7Sv/eFFfL2U3k6A3bRi?=
 =?us-ascii?Q?AsQ3b4Ys0py19lL6w8eCF+0oBHr6DhmCm9XPc9fnlzl8/rm1gPHuk9gKZF4h?=
 =?us-ascii?Q?mCOmWlVV9ype4aahJElGwdlZGZb7S1YkfWXPhCntFBtCvz91LLoOByeVIQJ8?=
 =?us-ascii?Q?QjB/oIe6BFspsie7Mtn3V/FZvxeQRB/psOX6oYhRDbD/YeXTyVZt7vyFt1TP?=
 =?us-ascii?Q?dL6/kp2MlOpcUZ4IwBI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3fac63-3358-4cc8-fe11-08dbc252c715
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 07:48:18.7234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Syj0m95vYuCE59VtdhfIpFUGC2Fm4bdvRXYeY1T68DOQ2ArMjeMxc0p1zNeFuJq1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7531
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change is used to relieve CVE-2020-26555. The description of the
CVE:

Bluetooth legacy BR/EDR PIN code pairing in Bluetooth Core Specification
1.0B through 5.2 may permit an unauthenticated nearby device to spoof
the BD_ADDR of the peer device to complete pairing without knowledge
of the PIN. [1]

The detail of this attack is in IEEE paper:
BlueMirror: Reflections on Bluetooth Pairing and Provisioning Protocols
[2]

It's a reflection attack. The paper mentioned that attacker can induce
the attacked target to generate null link key (zero key) without PIN
code. In BR/EDR, the key generation is actually handled in the controller
which is below HCI.

Thus, we can ignore null link key in the handler of "Link Key Notification
event" to relieve the attack. A similar implementation also shows in
btstack project. [3]

v3: Drop the connection when null link key be detected.

v2:
- Used Link: tag instead of Closes:
- Used bt_dev_dbg instead of BT_DBG
- Added Fixes: tag

Fixes: 55ed8ca10f35 ("Bluetooth: Implement link key handling for the management interface")
Link: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26555 [1]
Link: https://ieeexplore.ieee.org/abstract/document/9474325/authors#authors [2]
Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L3722 [3]
Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
---
 net/bluetooth/hci_event.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 95816a938cea..a20a94e85b1a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4692,6 +4692,14 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
+	/* Ignore NULL link key against CVE-2020-26555 */
+	if (!memcmp(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
+		bt_dev_dbg(hdev, "Ignore NULL link key (ZERO KEY) for %pMR", &ev->bdaddr);
+		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+		hci_conn_drop(conn);
+		goto unlock;
+	}
+
 	hci_conn_hold(conn);
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
 	hci_conn_drop(conn);
-- 
2.35.3

From 5fed42878147cffa22e695732d87a85c218d217f Mon Sep 17 00:00:00 2001
From: "Lee, Chun-Yi" <jlee@suse.com>
Date: Fri, 14 Jul 2023 21:14:01 +0800
Subject: [PATCH 1/2] Bluetooth: hci_event: Ignore NULL link key
In-Reply-To: <20231001074524.GA14361@linux-691t>
References: <20231001074524.GA14361@linux-691t>

This change is used to relieve CVE-2020-26555. The description of the
CVE:

Bluetooth legacy BR/EDR PIN code pairing in Bluetooth Core Specification
1.0B through 5.2 may permit an unauthenticated nearby device to spoof
the BD_ADDR of the peer device to complete pairing without knowledge
of the PIN. [1]

The detail of this attack is in IEEE paper:
BlueMirror: Reflections on Bluetooth Pairing and Provisioning Protocols
[2]

It's a reflection attack. The paper mentioned that attacker can induce
the attacked target to generate null link key (zero key) without PIN
code. In BR/EDR, the key generation is actually handled in the controller
which is below HCI.

Thus, we can ignore null link key in the handler of "Link Key Notification
event" to relieve the attack. A similar implementation also shows in
btstack project. [3]

v3: Drop the connection when null link key be detected.

v2:
- Used Link: tag instead of Closes:
- Used bt_dev_dbg instead of BT_DBG
- Added Fixes: tag

Fixes: 55ed8ca10f35 ("Bluetooth: Implement link key handling for the management interface")
Link: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26555 [1]
Link: https://ieeexplore.ieee.org/abstract/document/9474325/authors#authors [2]
Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L3722 [3]
Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
---
 net/bluetooth/hci_event.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 95816a938cea..a20a94e85b1a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4692,6 +4692,14 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
+	/* Ignore NULL link key against CVE-2020-26555 */
+	if (!memcmp(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
+		bt_dev_dbg(hdev, "Ignore NULL link key (ZERO KEY) for %pMR", &ev->bdaddr);
+		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+		hci_conn_drop(conn);
+		goto unlock;
+	}
+
 	hci_conn_hold(conn);
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
 	hci_conn_drop(conn);
-- 
2.35.3

