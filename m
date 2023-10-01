Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AF77B45E7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbjJAILE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbjJAILD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:11:03 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2087.outbound.protection.outlook.com [40.107.13.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472CCC2;
        Sun,  1 Oct 2023 01:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S81wK+Amgy0lDsjbrczVCT3kZJ8izBPYkNxr5oHfhuVxFKM2NI2rnOvTjk51PGc6r9et3f4zpQ0V6pC9yRH/OpDq6sIlhil8xg1m4CCgWy3rKR/SZq7PQHtJGRHVPAiIcw+mqsOe3r/xNpKVfSjbTdpbs1EnNK4auy/0oN2KwaCZgz/im3pHq542+EcYCJvuQWSjEN0UydX4Zk8UPFPtF7x8XHtfHkAWmfNLA0NxqMwQulMmd7c8KrmcV8vgjdnNWmFqRrsXo2tRdn0MK9RuS51SqQlURxCjia66zyTDSA93SiyesgdT7PCrxu1pRh3ZiJFEea5O2MWH2fA0p/nFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGQqYZ0FgUqrYy37FVP0MiI7B5zDK0F712BQATH/yqA=;
 b=JyAFQRjPaG2g+1drq5Nys6GiKw115sI2AP5d4EtIwSB3CHdQz7yIgPabz0wDERqCnAgv/E3YBBqNrNkI48yuaEDLh6JWfUtYfes1YkgQ/2cvbxxIPpgVn0h8DYa01xuaZGBL0KEpkunDQmrNWsW6otU3ZrMa+HpUVzjNaVBD35b0qpJa8aRMcsO0CiRJxznx0k4R56bMDXROi+lce6MU82RjbpYIRJIk6P9+yg0y47oZTc4MFKmFqZMMZschLavXLyHjYMTVYcVnQZFVoe9O8rkJnEM2XJc86Eejv9Ve0/Vy1Vl51lmrpUdVA4BNluiW/eurnEMdviD8cpLoESPUlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGQqYZ0FgUqrYy37FVP0MiI7B5zDK0F712BQATH/yqA=;
 b=v1/vfP377zE0SJNeY61iL6URa82notbdIm72akwYdIOKBGKf8+fwZyvxy9XzNl/HrMoK62w4buen4G0XwTTms5ct5pKp2UmXh4uMJ2yeNNFhUOgrCrLf9jisqfxvb1K8/vQdTuE1Rq2bMQGEZvX33S35y60v0UWRh0CHLpv9Ov8alKjE5K2m1XqCeBQWF0y7jQON0WEJ4/21HmhDrOTi4Df+B9VqS8iPnNyVmpss88qcn6dIPAhEY6J0MJMJUM++JKxMcGD03JC+D3xjv+uL8BN5uPqhJ0UMVG+ngdoH60DlrzFPQrUCE9NJ1laC70xHII8MiAHziHfm5TdBDJws+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by AM9PR04MB8572.eurprd04.prod.outlook.com (2603:10a6:20b:437::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.23; Sun, 1 Oct
 2023 08:10:57 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2%4]) with mapi id 15.20.6813.027; Sun, 1 Oct 2023
 08:10:57 +0000
Date:   Sun, 1 Oct 2023 16:10:46 +0800
From:   "Lee, Chun-Yi" <jlee@suse.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_event: Ignore NULL link key
Message-ID: <20231001081046.GA14551@linux-691t>
References: <20231001080328.GA14494@linux-691t>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001080328.GA14494@linux-691t>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYCP286CA0157.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::12) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|AM9PR04MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b646b5b-a635-4e29-9baf-08dbc255f127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YwDHG8n2HLFuH74X7q1bdHwnPQHfrCB16E/gh1pvLYjbWnDtHqpzmS8xx/CIqrEOjTmO0c7DrlWQIgcTudbbL4IxIfjRkxJGk3C7dcvccC2g4JxdzyLOFNHkMKg2cOoGyKx4SItnapbxxUQNpK6Bjq9RHDwV299wCeQJlbXZLVYSZTz9GIMpk/x0ankPPX2XzkHxIV9V4TjmSF/6ObZsy9og7By9ksLOFex1PzhczEjJaVVXoXU7cqGXB2nkvu+8txAcqeWzkRM3dIH4+mDapPhsEo4CCv0R21mD1oQV0p0tQGSzUgElChJTh2Ky+rJY8DbOBpbtCN3EnK3yo5ToomMzBfovgT5DmO3TE+B8AmwJVEjqqYSKf89yPQ1zvfqY7nGFa/IK+MQ1UDFGgQzZivIusjjrA16AoEFJY8ZUIPndQPqgcyqqVnjGuSvO/WBe7EUFems0vRYh5QYiNZ6dg0x57E4FYzRScmFEeLkd1XzT6uditCEWrK0MsrroNEdMvyUc+DmiFEayAU+B9FoakaT2DJrdRCA9nu8FcJZ1bxI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(1076003)(26005)(33716001)(38100700002)(86362001)(33656002)(83380400001)(316002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(110136005)(66476007)(66556008)(66946007)(2906002)(6506007)(6666004)(6512007)(9686003)(6486002)(966005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zEMj0mD50TTEnaJySBBmqPou5dH7eNIYeO1VcLSkIkpR7HFzetpziBMP8OsZ?=
 =?us-ascii?Q?W7JsLwpylWmy6Zeawf+4Uestp/7sW8wcLwFS1l/S9T2ihLT9Zv1RKOuqSlvn?=
 =?us-ascii?Q?+PA4BkRc0jRTpqlqEEktzMbIr/61WNXsGqpkUS8YNKbk6ZqXSGd6kINBZPtD?=
 =?us-ascii?Q?EonTE9aUzcrDIn5CvsPzRIHXrc9AFcey+4MM18mdvsvM07wVbW+iGjLjg1c+?=
 =?us-ascii?Q?OiUSDsazCS2HXKdvD1pujLOQqRYUOFdxlm6ADuuhKJ37yiCvv/UTQ2cgANzX?=
 =?us-ascii?Q?SnrS3K6Z8B7CGu6LVFb4ryUDJL9TO3ot5cn9OhofELdfujIBMny3OxvxdL96?=
 =?us-ascii?Q?KPsIpCw+hLA1Fiygkx965AVHbfs1XpjXy+vbO312aWCEhuoMXkSf2+OAYchE?=
 =?us-ascii?Q?rCWKfKFfxvSB+GaevDx4AGIqCuSgpnK6DauvPt95NXyxDOT8sD4m2T+3utyi?=
 =?us-ascii?Q?/dndezSi0SNU3IpAYVwr667ElIiK89DRLgICMPkXwPasqpeDtWiNUAdjz7bQ?=
 =?us-ascii?Q?o97JdAIJzMg2FQ4i8NcbD9x+AUahUx6hWS/WrqqHsqZHEAk/RJF6dSwW/KKe?=
 =?us-ascii?Q?H5TNwqjiDjicqaQY7zQcSPCOG8mmxE4z3KLOPZ1B0XAWAlH0xDkq9HBxbA6s?=
 =?us-ascii?Q?MOy8RJLqriKc/5xKRyP7BLMzq2ZB4S/9EZjAtBuSoS2222Uq2kDiE0gB5IdZ?=
 =?us-ascii?Q?wP11Ok0X3rQU9sFznrLEEQWXFBfZLp/FhudsCWIgonhor38SmoVSOsFCSvpg?=
 =?us-ascii?Q?RX+yiv5sr85J7j3Futmq8+FjVe9DzKGih7tJdwLdIE3wCPXQUBPBpzTeOiJf?=
 =?us-ascii?Q?INDFkdlvpO+WbYkrZ+QWRGi2OyjRKl8O7RPgn4hUdEqUpaNHx8Py1ugc9Xwe?=
 =?us-ascii?Q?Ucpq1Y3HGh/YYfI7ztnfrUdpi+GkjFtD8R9rMYkBk3FD2LMvT7eAVpDf25w/?=
 =?us-ascii?Q?exe5ohYnBpTCz9YGXXYvvir3/qzTNtMuXNIbpFOypkDjSSnW6q7bkuJYRXR2?=
 =?us-ascii?Q?4IUDUyjR0cvhd5bQSUbjSV15irs9k/FYt783tqDX4cmuawfag3sTVKgISY7i?=
 =?us-ascii?Q?QWMEWgEgh112kdmkSzpklM1Coi/MrcQNgY19tMn1FrkWhfp/2Rv3sGWhjdat?=
 =?us-ascii?Q?fImUC6aVdrdIQDgU+fumcMerPOKWDAjWW/GnTpdhOJpZz6IudlsXru2WUfig?=
 =?us-ascii?Q?CK8pKkTMVgaK0OqdM0I2ONyOQS80DxQgGxkKXB21nCWUYQH+SI3nU22VEqoT?=
 =?us-ascii?Q?3O+xvXk2QVnp3gLGarzXu0lPGUyPTaP0WwYsBUwzvCjKIetn0+wBGucFoFyC?=
 =?us-ascii?Q?6YBaz3nXSxRS1Ndm2NXl7RI6pZmZbAA4UuXGH5Ahy4lx1DnDaGNwnsZU7a3E?=
 =?us-ascii?Q?SbOqTv2wGbleThYC9J/pp9LpbARUrIXPTwjb0/FnFPdwEcr+f/hwZmw9UHt+?=
 =?us-ascii?Q?1m2RBmObJDWVDWeSnMMfS648JP5bTFW2+eBz3J73mtFdYKvmm2d/CVKMdll/?=
 =?us-ascii?Q?6oAzUYcwpOzlX9LiJLYaqqKfcIl7A+HtBIv8JMWyfZMbsesoqb9aPbDm4uoc?=
 =?us-ascii?Q?gzOTgqtcuWQ/WlZj37KXryNejHxWcaMMUmsgOU//?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b646b5b-a635-4e29-9baf-08dbc255f127
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 08:10:57.7861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MdnDpaJKBBTeqAgC0Lj0ONTyLnmY6kwo/y4sjTQcuvYAFvi9BrSLXZLG0zEI9Isx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8572
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

