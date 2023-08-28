Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0571078B4A3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjH1Pkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjH1Pkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:40:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2033.outbound.protection.outlook.com [40.92.19.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE9799
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:40:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NU2uvfK1DngSmhrVDOKNBqVC9O0AuYugh9fhcHiVEvKkXw730o64fmZ29cJoEKuVGadrTbRV5k5PLiSFZD/yxfR+H3dQIruZQ2nefoBIR/ixZDEpCILJ99RcPKaJ6nMIpy3Tcc3nqpYb2BWQihjSZfcT/TXBoN+NTkBw+dMisljSaynYIu2wR9lwLj5S2w+/Ly7u68axr8DWg+o17mncbp03YhMlotxfFQxJariSv5cZLuowauwb3spy+scN2kSLY8tZmjYQN/mtpF8HvQz7J55CWW7TAlj0hnKFdFFyh3+7IGaPj3M6d4M5dOKGIVLNAOjysR/32nDHWIB/a+83qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXkagwhPfSZcPv+ExWTuXTfzdu7MK7gZZg8wfDD06fo=;
 b=TvDjSgzv2PoRKz5zevOMUPuEZ98VrK2HjhOGCVC+DP2sjGcpwo2dhi9aZztFnQ/Erxmv7xn5cm34T+2lgeg7hZzi0vJigCEv59Gdz2QIKS91W3kDymkfT7T9OjQJm1rnGxmCr8MC9yNT2G68+GyTqpbHcKb7222Z/jUwz/WR+1BbSSEC/BhuMyM5YZ7v2iAOwhp6Ymqpf9uqhfi58qGfQSjRBWBOgNE9KelUjrBxX3uRUZ7K3/d49w10vuEXAPWLH6OehokPMbgjlB8Od8PbP753GOzKDcLNzTgq0tz6RDJF905GUqgKoa7DH7jwhrZ6y7oTurWeQC4jzLWEk07AoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXkagwhPfSZcPv+ExWTuXTfzdu7MK7gZZg8wfDD06fo=;
 b=Eib2AH9qy5732Ydp3d2zLriB1FxrIGDzm8pAj+elbWCqVKOfHJF+Si6dv58VVpYuUZ52yep4ZZZyQIEu032DQ7fD1hw702wwSWzIw0/PCXWq+MzbC8KvINeYHS9IBKK3dmT5YmIeQseNK9adUwRN2nhm7OqfDSofMot39oxcj1igzYjZ/llPqtbdfWSNyrVEuv4UoXx3BR/akh+XcSci5Z5ZP8QcH3yfLR2Vsv2WsI2EzLX7mD505y9NIoUi9Y9aXnagzX0dUFjdIqWoT2/PQW/0CjOWngXrwa3PfebMIFou/UxRQpxGQJ0bRK+FZXBmpZfiL2sx4eynXsgnonQJrA==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 15:40:28 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 15:40:28 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v5 1/6] staging: octeon: remove typedef in enum cvmx_spi_mode_t
Date:   Mon, 28 Aug 2023 11:39:06 -0400
Message-ID: <PH7PR11MB764333BA75F5760600A4D08EBCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693236450.git.ozlinux@hotmail.com>
References: <cover.1693236450.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [EwP99WgxVDfk75J363PMWU2/yFHbos5jQmL15BeFbtLFgHVcEZXE7Y4qjl+L2rN3]
X-ClientProxiedBy: BL1PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::34) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <50a22f80690bb0fe947c4d90d7c8893f66e94769.1693236450.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|MN0PR11MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: f23e2b0b-6a49-4f75-b39b-08dba7dd1a86
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmr1VCrDDYJl/lCLgD1Tr5zrS4fiborvUdTwMz9F3qWa8j4q4J5sU385THFqXZ7vI6A5yd0FEBiyF8Aki+OVIT7SO9Y4ZU8SqvTKvAW0mbc+1lKO3tqS0DE67rxDN2DiOcaz5tArMpaI/ydIqrEpo9Bo0+iQ1QD+uI+Gx+eLdKqxMJz97YmKeEph2uyZ0sjbaP+ClPjd2LLSRzeTuHJF/JnMSjmieCAYSIasw++ajLJE++w5oEFxx299EZIUs1EOYLDncbjQ3ovcrYL0LDL0+oAf08pvxYkH4M6uoLwa5o66w6+xOGv+60yDckPGuWeNo++u5aWD0pSxDrl4TllglOxGMG1HkmLSnhxLcs+/0lDEO4if3dlV6jVjpWsfqj/d8vEx3Bd6IRHPDZUQdzkvWguQJFJO2MCELH92jTRlFbbKUS+ZLJYDuoA+4yv/A2eFcrzEAQOOLC+94e7CHhFSpdPMuig+mqrgDlMytgklpi06/9+onPg7vWDSf83tEzftThBwfdKaHC7JnL3IPX2MLV9e1hayhnvoQb4+X1bm8AR+JoNsppRTWVbZywVWkRYYZsQUWyvzlFTb/VPL8zlWOyMtoTh34Nq5pLz96h7INzLMXJ2LF1efmghhwen/Ux86W2RPm+Qq6k26osx0w2uXrT/zzuBxb6JUSftQ53CfkO6NZ4p9gh1oFjYqWPI1LNyIcjtXw7qSsLQfWRu49DCJIDdtPtVAD/gfJSyFdpNMsyLFO7a8yWy2/4qwplvHI5GYQmk=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8UX572Xkp5PZhZY5hZgXDTbmT03LaNaXr6u3AGOGHVemkC4WjLXtFyE1J0ZadaFB6ocTHhyB3m6WK+MrAkQoiDX1qrNWPqww9TpdUu4m38d9wyVfyh9kc7IY9WiXT1F5l+Qd4VAOzqWnctea6SaaqjyjlZlHH5aBqqoRuhsGmYl1TDYhNnGLoEWio3i7eoKfnnnhS185yOUwxJdwkfz149EpG97/TLX84Ip2f78MsNzkXoWcRjTX6wjbWDmyGG1GI61O1fLlJhDgGzcS1+FRKU0bsDDWVnFhYqCJSmI/LYhRQUpLk26vgYO+EEkvhf+OZvO1aA3V5s+UGVcK+VkmkqGnWgEvod7BbIYWAq5J7appXZe4EqS/lnnat4tqYKnDXsTgV59Bp9djw/xZyMGZ+eavO3IdWBEdsK7BMnWz5k8JqD7onrihf875JXxqOEuhmiL/Wum3ynVWaSvN/0HvFs8yn8SgPFKEkWFr4oraxrxktkyAlay77ve/+tC6hY8/6coQi4tWMbA8DRO/ljnVWw6+Pl5tIfe4A5UitEf5LkJGrYq4u4Y2l/LDpuwhP5UwR1gbFj668GKHJPCLa7r5PmT6WibYeZ+pmrSMP02BHOr3CFyYNg9b4e28kRHDK65
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XdlTFluKdcgB5kFGX9BVtdTnVrWng03XqhXBhtNt572APJujPewA5ofkWAfB?=
 =?us-ascii?Q?Hb76mWmrJ+Dfej6HkV6QgWtlQYrQbxnvqH47GhLucf/JUoKCEqxcxzXQPwOL?=
 =?us-ascii?Q?uWDD9kUZyntDd+RA1xBVXxoZq9nh5+OudqSRXScFLJPBKoFbdvDN8E5EHC1g?=
 =?us-ascii?Q?CWOHAvA/uTe5OdQRtBE0MljfJ41c6bMT1pKuCFirj+q/UiUPq7av6pondDhf?=
 =?us-ascii?Q?tjHt1iGnIYuChYysW/ayPAmcDNyKhne8tG4QObkEWE/sQ25tgc71/pFlfybq?=
 =?us-ascii?Q?sgXOqwlFrZaKVfZb9/Dd2U3STNzZxkjyzbfGoQVEdt5+57oCT4CdibEewta3?=
 =?us-ascii?Q?nYyh+0qh4aDsRNjdhTbMJPIB/8lw438JDDuof2LcMkOe+t00OqxpqTJmrRPc?=
 =?us-ascii?Q?noEeGUMVbOk9yWstkM1DGiBZJ1pZflQKQ3iHsaXOAG1pPkNkVSHcW9Hxis8u?=
 =?us-ascii?Q?jSOWZ3s/tZNABxS0ZuBLmsRcjsuquv06L6BtiwMvAMIH7BLoTXkCuqKkUKvB?=
 =?us-ascii?Q?4LcFbhzyZv5ONuoKzQqPqwM8rHiBJ8xHydYU55dmQWp86MRQ1XX8TweyhMPw?=
 =?us-ascii?Q?CsplsgJIMJjXDGohI9tmQC/FF8DLwFcXgNeuTFosLYm4j0605Rw+4GBRzEa5?=
 =?us-ascii?Q?rsCpGbkTqMwkpVOtpAlYSaMzdghr0uKmwNmE6Fs9Jvx8B1/KSUUUklmTIjGL?=
 =?us-ascii?Q?sc7StOZAUsvndKYmR/4yc8WOIyKdr1mKjKhzESfS5oPSbr4Y53nZLCnLAheD?=
 =?us-ascii?Q?BZSM13PGczeqTymaslqOb2opEJDirF8UTlQ/nev6DbRypcFgWBPkRb9L3fbr?=
 =?us-ascii?Q?XdgAuy2n5n5b2IjjymS2AIjSQIJl1JdOVg18uqEI0tDHlfFuPGlf8dC+SZ4a?=
 =?us-ascii?Q?W9FokoHbLAn3Ar2RD1WIE4Jxq5/5TBZ/2ph3DJqXaTvmenhlL2MoHqYInmF4?=
 =?us-ascii?Q?YgNPLVgthZOq97e0J+wUyt/a8xjaqMfzcYXS0NhWJ1lqVLeIhOmIrLqPoazK?=
 =?us-ascii?Q?nT6XikL64LqFtG3PoYW0whtRbT2xmvFfGfFVF9ury7RN4cGh3KGuNMMuxLw2?=
 =?us-ascii?Q?zCJFSfu7/hIiYjulFaiOV3vMKJtr06jU/aahWblMu7sjRflpKV8O6F8KRSdC?=
 =?us-ascii?Q?oL2KuljkkV3izVj/e31XrV7ZxXZLVK8b26TF27Cvr3CSGAT+XPjIoHuzbHpV?=
 =?us-ascii?Q?kmX0jA7NdIyI4QeHIOw1/HEe3DC0oLsBpRrHHcPplDapgB5xeF16nsdYFX8R?=
 =?us-ascii?Q?zpUihYfV7eT/aXw5kLwGGr9AdmZA7DRbX/vRX/xOIg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f23e2b0b-6a49-4f75-b39b-08dba7dd1a86
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 15:40:28.1863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove typedef in enum cvmx_spi_mode_t, and rename all instances to
cvmx_spi_mode

Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
---
v5: More descriptive commit descriptions
v4: No change in this file
v3: No change in this file
v2: Send the patch set properly, with messages in a single thread

 drivers/staging/octeon/octeon-stubs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 3e7b92cd2e35..9f269626b862 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -213,12 +213,12 @@ enum cvmx_fau_op_size {
 	CVMX_FAU_OP_SIZE_64 = 3
 };
 
-typedef enum {
+enum cvmx_spi_mode {
 	CVMX_SPI_MODE_UNKNOWN = 0,
 	CVMX_SPI_MODE_TX_HALFPLEX = 1,
 	CVMX_SPI_MODE_RX_HALFPLEX = 2,
 	CVMX_SPI_MODE_DUPLEX = 3
-} cvmx_spi_mode_t;
+};
 
 typedef enum {
 	CVMX_HELPER_INTERFACE_MODE_DISABLED,
@@ -1362,7 +1362,7 @@ static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
 }
 
 static inline int cvmx_spi_restart_interface(int interface,
-					cvmx_spi_mode_t mode, int timeout)
+					enum cvmx_spi_mode mode, int timeout)
 {
 	return 0;
 }
-- 
2.39.3

