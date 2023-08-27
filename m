Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9132B78A36B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjH0X1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjH0X0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:26:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2098.outbound.protection.outlook.com [40.92.40.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C888E128
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:26:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+tVOdlJIZXcdcLnH27Tf0jaJYHgejap9Mv54QO/6u7bBA7wnSYuuR6LKPQEKel0V4znJZByBZ2JUPXEjJ4LGMRbC+VefPjAL7+M79RPnyp2yJ1FGB7Zs1lJjlfxhrJsVku+HjN8OiqmU1pnufGwhjlihHaWGTWnNce8WkpYwWq4iz8QJ+CHrxPU18SvvQD5QhKZ+EzFscOtGe9o4AkM1eq0LeCivMI/dKW7rF0tI0OUnU4OS0LeCbJbUK2RmQLLLIK+4fGF8VXAWXIORuYA1kPBc1uold1bdnqUq28JgnJRU/7Bli9RtapMujjFKON/0wOHLB9IgQUoJxGrtxtGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZYTAG2n0FEM9ClDtktW0dG2S/x0g/r2PSmzcW9Q6DU=;
 b=O7oQg6S2pKJfj3IW8VCyoCzvBcBM8fVFEIGcPiQE/RzIuxEzPaPSkWzPWHCah927viqCeU29BxohG83aOoHBRkT4CHwb+zSWGnG72ILPKhiu55ZqZNe6nyFnIHC4yLDCpaOi3lQRmdOT3+GL1T9tjb+KhzdMkBWmqYW2AIq+DltlY8cbVO4X0SP9aajxPfwgOzLmOBdcDeSuIb4L5khtFuIZ1J7LBZIgRM0Sk77a63BGXY0FLdXH7MT/O9Zf7e9IqQW9kcwssmy6Oe1vNmDkRnn0p6iXHy0trmc3YjQ3ceAPg8SYYlp8fcXNy40KpaPnKyZomHdU7NGofvuTkFEQSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZYTAG2n0FEM9ClDtktW0dG2S/x0g/r2PSmzcW9Q6DU=;
 b=jhZ9nt9+P9KBuwO7reFnrf8s4WDQBJNggwmcFc1Bs/N9Ugk9rIPpn0iyW3T3SaBNO2OgzQBwZc8/unqNrTPlEj6WKKHvc1RE/IIiSM/UP3MTve2IO7qZpdsFTF5bPJHIo+FsBI6qTvF5dOapEorm1gFfBcUrWnZzhjiKJJ4m2oGrX6XSTpd7JP8bp6sf3jMKe432wBFwiJyRwSAXTmlozFQFIkbkR6fMK/afJbaki3g6vWwbbbFJR6GhAfQJMLgoeRw3amABs9ygvkUAdzYUhf3LCH6ceMSSICNELa8oWoPyDTAzLkLjV3Dbla6oLb4HkFwj1JDr6nMhB3BjIfSh8Q==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by SN7PR11MB8027.namprd11.prod.outlook.com (2603:10b6:806:2de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 23:26:27 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 23:26:27 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 6/6] staging: octeon: clean up the octeon ethernet driver
Date:   Sun, 27 Aug 2023 19:25:56 -0400
Message-ID: <PH7PR11MB7643513968387B51B3A62418BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693177830.git.ozlinux@hotmail.com>
References: <cover.1693177830.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [GGzvanq5IaRzCsCM9v9NyyM/Fw2eL6RXx8CPIHZCLo2RftQ3M09bNI3uT1H8mZlm]
X-ClientProxiedBy: BL1PR13CA0314.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::19) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <34d9faca22425cdccdaabbfaed140342a1ed550a.1693177830.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|SN7PR11MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: d58d2268-51b0-49b6-5fc2-08dba755096e
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmrTVQo2E8YhiYZbimk9QHlfee0RmoCxeVKGkhSSrBoyA9vjmfyYTLiiR+xlbyDYNWRm6VZ6eANmf+c0w5ftUWBsQGugOUOp1niysfMu06zbVVkbY+SWohro8EC8K1Q8N/KGUAV4307fdkRa8Ou/Bhyweuh9ndqUrZvI3n0dFZCWtxMHPtDbtB41xO1phTt75icluGpLQJrxsUPjI6T86HaJzEQ9IHVuj2CnZYpNNuQhU6ePoY71YIGd45n+P9ntVC9A7JvdcQN5FeuZDt38OlKDkD+ho31s2SJdP7s9NBhC0Aje0bmQwAMhNMLXHb44e7WjKwXwmxJcMGBwoXenslHQ5oZAGVyAHGZoD4pvjKH6Z/zjoYMSIEHOeCdiE20r4OS8Q3/XX3tjLxpb19T2aJBpFURfgUTb8loDiyddXXdXQUma060lEl/EYT2Aq09R/CHYR4gGF4HbBqUwtITMcNVcia7gLMMYoskF/vZS3Bq6RQeodGAI/8QdrasNKMqi1wVnsMNBBSw9D8R27VWf4eQmxsfdGdX0ItY7oS1KzfrDSpewHMC84Qmb73DsHrh65NCh3ugIgXOam5u3m05lEbc/tmjmRaTjb66E/XE7FjQBzGdwwpYY+TX5MPhFMa7lBgXyNsf+zDwFpkH02xybJDvd4/7xnmHzKRv8+SxxeqheDRjU0MwBxl2PtLIev/hYzF6fubWUReyb1gXL7vw5+WutPJf/RzTXV3keZdSkBMBj0/j6bKZ7cAUDu7Hh6pNXVNI=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1Seo70lAZsTlbraTZ8Tyeb5rOrx6eepgGnSZD1iRiqCokoVvQh7d+fK9ki5YOiZ502X/2afxmdgGf4PwbNpGU4JK2mZP6FTaOllofGJ7pj43YRSmr/K6c399MjtiHaywkIBn+Iyf8e2Yufxsh+zm0ObPMjaHxERwRoLo9VCxcxqA+aKiTXPfJOo+axUmKpyBdl+xIj2cPJqB7a3ZW34xDXV90mqXmDGT5QjevbkLeiKN3S8ocI+BrBhq7VUSa8UMMRAQnVIzWz61LXt3PwzuJcAecuFD62s/Fd9r05hVmcaMqwbUah7w4/ETjOqylcHL1sVQxGPBvPX+9q11YEax2G7qQvSQxR01Ewvm/m51nBkr/vIQTVebE60nhh6Vj0k3v6gg77JrkVhsf/ON9d3kTSTV/GEaWiJEu9TJsdyRe/SjUO+REjwThaclmYkw8TLTM6Qk9PVSNBLupSO3N+VtQo3Q0ZInlIOqzXHifXf1HccP9iIArBzjwxlFMo/keGb5ceeanmsKwkGSrN4zfsMQ+SMA7QmbmOxI904jOAk3R4E29v6eGZAqfhGutsJdxWtvancVzzjUxolW81WnoNfrbvL9jSBFDwmiO8edImrZ1rSiyI+giHryV1OkipsaVfK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jWS+xSin859K4zNs8+8YDFjNoW6QED6Nv185uGSP2EUMMLp5JXUgwAqxCRkq?=
 =?us-ascii?Q?go4dNAOf764t1Lr/oKJQzvQhwWM0DNB1xKT/zx2XDvXDlbXsA/rpEIJh/B3y?=
 =?us-ascii?Q?IrKjdA9uIRPeAAWv58ktAs8YqDR0IezeEoyNVPXS9ljDz5FhyKogmELX6zHx?=
 =?us-ascii?Q?dC1ABNjw2Ijt5JzpPVh5N2P6qWCw602zzL4wB2oksxFewZjpTG7CeqkMj5Xh?=
 =?us-ascii?Q?ZkMuLQgNaeHNFsycRBtLc418OAsw0P3qm0SiLiRPxpEQFhWmp3jI/2NTQLVu?=
 =?us-ascii?Q?LuAU40ulhe3hzXobEn2ra08b/R0mgjQwzVf3RerfGKGFieS9Ox7Vg+UBsL4Y?=
 =?us-ascii?Q?j2ve6WQtHjAG2lF/DoUTrAO8UN2yfLbTJIAOJYu+23ozoG7Git/HHpHrq9n3?=
 =?us-ascii?Q?3OhpmygxcxeQM8rLQduebCpzHmf/jl5Qx5ODS7pySBAuFe1jDam+jYqGKuUv?=
 =?us-ascii?Q?VP3sEbhOGj0VlT8Xu2/unoYsvyXWusmvSaY3vJ8L7euV8uSi7mIM7YO2rOjx?=
 =?us-ascii?Q?qmDaKzVx2TMx12yz6Ij97jUyoWp86YpbKwEelaQ6HttR9R4poBYkGeVQg85O?=
 =?us-ascii?Q?YE5mzRFCH0F2X3HsE9FsqCxy7uKM/aLbqqndKDZF+iHbhGRYByjEEok94Hk0?=
 =?us-ascii?Q?2azzq0sTdtDFi3uWrqpsPcR9W21DhMNQgOnw+pop/PZT3vTO5khXehzuTirX?=
 =?us-ascii?Q?8+bYwnjjpgXUAJb/kH+pomQWZrC3ihsh9q0JLA0VV08YvWfPtp2dtyvqSzSJ?=
 =?us-ascii?Q?VWTW4zajzVYOX9/eAFVguTxhxdrmb+R63JgAoVtKxD55Qv3kXBzgSnB32XYr?=
 =?us-ascii?Q?tj4lUUFaVv45zLmOMODHZPjoFjvdpBJyOIj49Q7GxVUuk5QI3cjeL2Rv78Eb?=
 =?us-ascii?Q?kDHlZD/OUTsW/kh7imwgyyhSB6PdVawzzK0Fa6vRgmc6wl5mMg7nVvEXEH5U?=
 =?us-ascii?Q?VYgz1tvttKspRAye0QJIBYGwneDGieMd2esYNokQTG74zSW7U3nJL5UA+fhn?=
 =?us-ascii?Q?Q9mcGthVhHh0fOdC194aYcXheOpHoYu63TqMVguhjKqI5zySYZh5ABW7l0Fx?=
 =?us-ascii?Q?BUTtM9xjoGSF6WZVEyG3e8t8/pBJz7l9hEyT7uVooH78d569JU0WhtwAIzbY?=
 =?us-ascii?Q?QMUIeYd71pQIM1gV74/aziPcfxSEdK/oTJpG/d9qut23ji2u7iHXxUk7CQWM?=
 =?us-ascii?Q?D8unXD5ZxWq+uMGwNU40hzLJll7cCLxjnNn6vLwrjskufvVn9KHuYePg7F1i?=
 =?us-ascii?Q?psNnRz0x5hLqwtLfjma4FNDH7r903CTOE3TpYG89qw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d58d2268-51b0-49b6-5fc2-08dba755096e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 23:26:27.8668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the octeon ethernet driver better adhere to the
kernel coding standard

Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
---
v2: Actually send the patch set properly 

 drivers/staging/octeon/ethernet.c     | 2 +-
 drivers/staging/octeon/octeon-stubs.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 023b107e077a..f01cdfa3275a 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -201,7 +201,7 @@ EXPORT_SYMBOL(cvm_oct_free_work);
  */
 static struct net_device_stats *cvm_oct_common_get_stats(struct net_device *dev)
 {
-	cvmx_pip_port_status_t rx_status;
+	struct cvmx_pip_port_status_t rx_status;
 	cvmx_pko_port_status_t tx_status;
 	struct octeon_ethernet *priv = netdev_priv(dev);
 
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index b9852994882b..8befdcee6ee9 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -384,7 +384,7 @@ union cvmx_ipd_sub_port_qos_cnt {
 	} s;
 };
 
-typedef struct {
+struct cvmx_pip_port_status {
 	uint32_t dropped_octets;
 	uint32_t dropped_packets;
 	uint32_t pci_raw_packets;
@@ -407,7 +407,7 @@ typedef struct {
 	uint32_t inb_packets;
 	uint64_t inb_octets;
 	uint16_t inb_errors;
-} cvmx_pip_port_status_t;
+};
 
 typedef struct {
 	uint32_t packets;
@@ -1258,7 +1258,7 @@ static inline int octeon_is_simulation(void)
 }
 
 static inline void cvmx_pip_get_port_status(uint64_t port_num, uint64_t clear,
-					    cvmx_pip_port_status_t *status)
+					    struct cvmx_pip_port_status_t *status)
 { }
 
 static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
-- 
2.39.3

