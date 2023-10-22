Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849527D21FF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 10:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjJVI4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 04:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVI4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 04:56:30 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC8BF4;
        Sun, 22 Oct 2023 01:56:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heuc4dlKagMKJIG7W46UKfA9DUaeyf7573jZWZwmc07llnTNItkPvaF9X5jckrUERyKUPctnd+kNQ46uaUzSD+NWbW+duSWEGmlc+WqyHeFBkUzs/BgLKM8fC5N/SPSpY7QmQvCPgoje+2f0FP+OqPu9fYjCAqvB5rRMI0qAPDPGctvU2WsVBsbSL2Jry9/wnrE4lolK/E2Alsd3ZeTLvIP50bnvI3yD1q5GL64xcf30SGEm4OMZZkHGkit7cA222ka4gsY4gzFS/U7DS1NYCJExlBZFbOYcYuJ6apbIs5HdUpyFUtnsRdXkJx83BD79jJcN/1YIgk7c/yrbJE+Ipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0mN5A8kLa9tAVoIzDWEiZrnvpll+/l3Kr8ECEfw0GQ=;
 b=RLnmgU/mhB3/fwHT/o1BRrhkXL/R0aLWeq3uitNEjx7rVD7Pqc/H4nIqfe7DlOM6aExmI1u/0NryOiDEefdyI3vtZAcNfopmcCfDPsT1jHDxAaglrftJWaG7Lg9h2Cf5hUTuE5Rp/W21svAREM+izt5mEgaEnFVexM5q+vktsyhkTJvoU+Nmb8WYTxfeuxgkGmNAX9YdCNhXymXn7/hHulaSiON/739f6wNLXIFU+zR8mRlplNb0ylzDf7fZTMxIqowFv09puPgdAEbbmbLYZEfQ+82nTmQtYQn5axZZXmgPLo3fWCpZaEoiLaT7H71xdDSA/W2sSijaiWnpHB78PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0mN5A8kLa9tAVoIzDWEiZrnvpll+/l3Kr8ECEfw0GQ=;
 b=EYb7t8QhUmw8mAJtj/dvlzYzcNMNGMKYrbalIPHkgbkrCh7We4UiRZL6YUA2yvfOmcyKZK6Hirde6/hbivuCmz8U2wu3YQXX22Djgl/MAtl4aXXNu4tf9JeDNtjkkzFQCPhMCpVuqiwPbjUyT5vDnV94Tv18nfX+g8KPhaHPHRupfAzrFx4l5ldtnwIP/vaW3NxqXnoT/cc0ofmFoC+jHZadGqjhsO6U/BIMcoVB4EC6SjhCbmsn81/DBXRyIA9/zgejvW6lxRWcHDyZ2+dwQpByR1AFqHpb7sKFCDbX99RyBAlNeuqIs3AC9arj6IjxJbLbbxPjFpkX63VJdskJNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Sun, 22 Oct
 2023 08:56:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6907.025; Sun, 22 Oct 2023
 08:56:24 +0000
Message-ID: <895ae9c1-b6dd-4a97-be14-6f2b73c7b2b5@siemens.com>
Date:   Sun, 22 Oct 2023 10:56:22 +0200
User-Agent: Mozilla Thunderbird
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] net: ti: icssg-prueth: Add phys_port_name support
Content-Language: en-US
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        MD Danish Anwar <danishanwar@ti.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4005:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e09368-9ba2-429a-d447-08dbd2dcc4f9
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNCrGJaFLqpQHeoDBOGRVaAcMbmITykxAGkxf0tvvWsPf+AQgzDGN7spaDEqvzqxjOVx2R43qBiRYuGEguzTmPBow29cJ/b+VMqhDNmpXeNdNKzKyRHiDwv6Mpve5zagNG1lFcDu+Kdn6EfRS3QnGh06hcAlWN/hDGXB3REcvzUyM+0tZ0TIH0eNZPnqbhOEUx7Ph/r9x3n1zfL2bpfe64fX81CMuL4ulvxH2kes8MlLw3+e2tcYzsJuzdP4t8oodUvrLRBKnpcH6aTMyMP4BkzAhvyfm56nMlOQ19wyrHRNEqORMiE7p9Fv5wXxT74ViAwvmT1HUpR/fikKUxTwdz2AXz5svm8ROnmwQcqiGwr3IGwf2p3GMYycOtLyomvr9dW46nCNXk7y3Xm1/MbzjZMRqdnewv1hk0UkUwDVw0hwvsS43CH4IlmKQw1jssaz+ef5HTtcQuaMLoXNBMPdOSwQAZWVjQxCPR2GiZk8vDsKz15EJlWKbQ3M5wF7fzOHhDL9orlEBvWYsz86PG4U3ElIav1pegcHo24m3nfqypueENUms4LVGCt2XRGY5Jrzbqsl2AinoRPUWxGnkChcJv7mWvOMXmc8DQgT+zY/+pDeZ1ZawiCTQJuYzGqPGDsxCPnoqJA3yqdjzi5frNhAQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(366004)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(316002)(66556008)(54906003)(66476007)(66946007)(41300700001)(110136005)(4326008)(2616005)(31696002)(8936002)(82960400001)(2906002)(6486002)(44832011)(107886003)(31686004)(86362001)(5660300002)(6506007)(8676002)(478600001)(36756003)(26005)(6512007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUZNajh4anpWb0JpbG1jKy9kNWM0U09MYm5aWkYxdDUrSitobit1anJvRlpM?=
 =?utf-8?B?Myt5OEsraGR2MUF3OS9IQkczV3BBT2FIMG5PalhudFlxTDZxY0N1MURUd1JK?=
 =?utf-8?B?WkNPWHFNcldzVU1vdy8zTVJPdDEzYzdRYVdHRllIVDkzUGpRVzBYYjZrQ2wz?=
 =?utf-8?B?Q09NTVFMbjVWSkV4NU01WEMzUjUrTmV6anFiTU9VYWw5UTdtSFkyV3V6Nkhh?=
 =?utf-8?B?c2lMZUxaeXR6UmI3ZU1Oejlubk1YbW0wRDFhcDk0SVR3SWgxRzJET0VSWXhu?=
 =?utf-8?B?bjVaOHJZR3pCSXJoT0xuMDNMMHlnc3JHOEF1amhmSkJmcHpqVmFPdWl4Ump5?=
 =?utf-8?B?S245Y2E2U1pLYVZaaEp6OENEVnU4V2VXZVhiYmdFbGZvZTVmcFdBU0hFMGZV?=
 =?utf-8?B?aGVlTDcyR01sakIxZ1p3ZldiTHh6L0x5dnVlZHloM1RCaUFoRjg1Z1lHa3Jj?=
 =?utf-8?B?S3NvZ1d0a0dROEN0WUQrTFdEQ0Uxem4zZnVNQitaUFBpUlBnY3hXdklsdWgw?=
 =?utf-8?B?aGxOczZaN2ZJbFRWblR6RmtHeWhPc3N3aHFtK0pXQ1h5VHlHbk45dSttZk5C?=
 =?utf-8?B?ZU0vRmlyVE5KdWQzU1I4Vkl1QktzeEZOTEFtM0V3SUxWQWN4UGgyU0w1YWVU?=
 =?utf-8?B?ODliV2xGQTB4dCtJZ2VFR0svNE00cC9rc3pNRFZjM0V1TmkvL01xTlBRaml4?=
 =?utf-8?B?eXg5U3ZTT1pJa1dQRkVYdnR3WHl0UVNOUDhxTkZ4VUpEN3ltK2l3cnpwaFpV?=
 =?utf-8?B?dFFTMTdwMjhBQWVCQjlYQVh2d0lkV0owUHhzZVU5cXZ0NENXUzl5MC9tYnMv?=
 =?utf-8?B?cndocFc0cktLVUZsY1pVRithc2sxNnBpMGRteDBZUm1hZk5OY3ZCUGk2Q2Mr?=
 =?utf-8?B?N1RVYWNLUHh4YVJPc3UvdTIvWmpBSytTc0J5ZkRwNHY4QjFVN2tmdnRoRWd5?=
 =?utf-8?B?WVVHWm5lRnYzcDlDQWpacmp4Z2F1S01hNUdaM0xqSngxcGp4Tk1peWFITjI5?=
 =?utf-8?B?aWRoN2hIRTY3Y3lvbXdxdlVUYzVocUFPMmRIZEs4Sm8vNG1CL21MU2xQSnRw?=
 =?utf-8?B?N09RZktZZlpvbDJCVHRnZUhuWTFJcXpZV3B6QTNsczlvaGFKSDQreERZcTR1?=
 =?utf-8?B?STFTMWRBVUZwUVVSdS9sWlBtekNVdWFZeTFFcUtxY1VubDNMcjFBdlVuckh5?=
 =?utf-8?B?UWRkU09oUFE0bW1uNTYvZE94OWVoL0JWK1lNUDkrdDkxMHVtTHRZMjJsUFQx?=
 =?utf-8?B?MzdmeS9QNXp0SE1Xd250VnhienJmdjN3dzMxbmYzSUxiMzNSaG9JSmM3MHk5?=
 =?utf-8?B?ZzRKMS9xMEpCK1NBeWxzdHpWVXd5b1UyaU1yNnV4RGJqKzRzY2xBdm1rRlpy?=
 =?utf-8?B?TllTSlR6OE9vQWhzdW1VdXZIUjZhZ2o4K093Rkwwd2xKN2kyYWRQdWpqSjZ3?=
 =?utf-8?B?aW5oeTBmY1c4TUdPKzB5bWhUTWRKSEsvdEhtYy9ScStNRzBRRWFFdDErYlBp?=
 =?utf-8?B?Q1RHT3NFQ2JMaE51M3JkeVQ5MWJZaDlVUXBXSk1IZ0kvV1ZTaVpEb3ZtOFFo?=
 =?utf-8?B?ZWM4UldUaGhxSXRRQ1NSOHJvelA1MFVzWlcyNkxiL1hHUSsyTi9wNzNDVEQr?=
 =?utf-8?B?UWF3QkRiTGRqUERIZzRrQlZXSElMZWt4bkh0OGp5dHg3LzNlMHd2a0hVMmwr?=
 =?utf-8?B?WS9FTHpQbmhMS3k1K2xJYmt1elNkaXBQcUFHakZJOHZFL0hUSmVVL1lSay9s?=
 =?utf-8?B?ZFVzT2k0TDZKTW1jSlVlbVhiZlA0OEFEYXJQWlNyaVlHVUQ3OGxaSzVIUlRs?=
 =?utf-8?B?RnVpd2pUWDJ6OEZ6YVVaQWVEcjVKTGRuRWRlUENKemtHOUI3clhxb0ZYNXdL?=
 =?utf-8?B?bVB3SjQxTzMzMitwSkZQdkZaKzBWVjlIL1kycEpsQjhGSjR6aGplbFdNeHNy?=
 =?utf-8?B?K1FHaUtnQlZESEFuNU14cTllNXVTMnpkd1RHR0hGcXExRVZRR1Jzd0RpSlZE?=
 =?utf-8?B?ZTc0aXkvZG10NkltWkVDMk5nTUZBM2pVVU5aTW42TkhmdHhTY1QzeGtGOUwy?=
 =?utf-8?B?UnJLRG45OFYzMXo4TVdwRFd1cFhLWDk1ZnR2czl2UThKeUp4TTNaNytGNlBY?=
 =?utf-8?Q?NS789PIuPDt4bBSOHq4QHiJct?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e09368-9ba2-429a-d447-08dbd2dcc4f9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2023 08:56:24.3521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+8JdtuHq4bGIG9unJKcJuoTFT1j6pkxdSUaYnKf0rSzDVyMWNBTPsIzMv1aKMmp192ZpvNP1iyDi3MzEKjaDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4005
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Helps identifying the ports in udev rules e.g.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Seems such logic was lost during the upstream rewrite of the SDK 
version.

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 4914d0ef58e9..ffae89a6ccc5 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1653,6 +1653,19 @@ static void emac_ndo_get_stats64(struct net_device *ndev,
 	stats->tx_dropped = ndev->stats.tx_dropped;
 }
 
+static int emac_ndo_get_phys_port_name(struct net_device *ndev, char *name,
+				       size_t len)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int ret;
+
+	ret = snprintf(name, len, "p%d", emac->port_id);
+	if (ret >= len)
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct net_device_ops emac_netdev_ops = {
 	.ndo_open = emac_ndo_open,
 	.ndo_stop = emac_ndo_stop,
@@ -1663,6 +1676,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_set_rx_mode = emac_ndo_set_rx_mode,
 	.ndo_eth_ioctl = emac_ndo_ioctl,
 	.ndo_get_stats64 = emac_ndo_get_stats64,
+	.ndo_get_phys_port_name = emac_ndo_get_phys_port_name,
 };
 
 /* get emac_port corresponding to eth_node name */
-- 
2.35.3
