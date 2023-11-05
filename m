Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630877E12E2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 10:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjKEJvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 04:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjKEJvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 04:51:47 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2046.outbound.protection.outlook.com [40.107.6.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BE1D6;
        Sun,  5 Nov 2023 01:51:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeNXUoZT4uRzKusjAjel1c9CYfWMug0Ts91GTmq107+mXguNa2O2biEP19nozCWEpSdI0ax3bqrYvjjU9VTHhWAnZDHixEMjv5HCeUkSmXmDEyJgeOSmTp2hhFVS0ShqOLEhkVuGsFgMAb6HMhM7bnegBR7cStK1qCGey22qVD+mnt21RwSIyAg3NaM9fJPrlPM6YrvPWF8/Pn6VQe7sk8kMsmkPvvpWziLucyhzWBSbkY0LTwXxdbH9cdqO16q1QcsDe5QEMgjsYaDJAIkt0eoxUZ3s73gE+tEid3xm36v4OMuORLSkxLTvB5Otygd29nnVl+LBM0uBvRy6qBCJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmSHTUSuso9YCa5Ui3EzNOhbaSNlqgvv4rsl6UQX70I=;
 b=GzigMjvn0YWLJRgXVlc8XPe2tOXNSrw/W5ot8gce7K7tXSODgMnPQQ95kmOg0tylgoB2lVjDTqW1+BROEigCCoXcftYrg0u6q4XtIDF8VUE+520XvD8/kCMZvft3ynfYVbCYFAMIHk0djtqowtDuFxBeURV7xohANvDoa+PFYAkSVemfEwLfMuaakiQ5xQTD+NcBeMi6Xq8y4QxdhbeOJ9MWeWb8s3uZM5fWQ1t27li+hyAvEwc4iEkZVgTTnNS5dRPUtqO8cHVwlpyzVd/ukZ83THd3u1e3ksVNHQZqc8uTqH71b3FO6vlTo3D571yjYYk51cr3yQ35E7WX7L9TmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmSHTUSuso9YCa5Ui3EzNOhbaSNlqgvv4rsl6UQX70I=;
 b=jgbHaRs+LRKNCy1+asLfmivUlkMcap50bSp8StbsRpQ1NDPIpruOsznDg8dXbmnvoA4fYf7dfcDbJZqmWt8ZervidqzieqiAeSoH+a1GK7jGYMcf1mxd82iR1Pa+TBnQIFghbUEp4oyMFXRufifWtGG6IigsHmOCz8RETtaDIX66VEXSYNnVwfMiqB51N1CGLt+HRdxhyPbrbdKZYPH/QPzo10VT85OqI085xsPVI4Yf4ewG4kbrYU0KZU7+dZsOVRnpj2p5YwFCAz3pLZR2LnWEWeh2hrskiRwh1W3UCO259vKvjUKjMTgGHcmsdySDDD0thn1CTrySBRdNUaD59g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6309.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Sun, 5 Nov
 2023 09:51:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6954.027; Sun, 5 Nov 2023
 09:51:41 +0000
Message-ID: <c8081537-f26a-4147-83f3-0c890e824192@siemens.com>
Date:   Sun, 5 Nov 2023 10:51:39 +0100
User-Agent: Mozilla Thunderbird
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH net v2] net: ti: icssg-prueth: Add missing icss_iep_put to
 error path
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
X-ClientProxiedBy: FR3P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: cc736d76-0f73-4703-017a-08dbdde4cfea
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YEdqnpSV6qqrxuRqivjdERVELbjhY1ydrZFfhg79TNnJ9aQhakRvuqu/F6ydE73JZ4Fbx3McX3jPV13uNQlULbxxS49bISteoTXcDvQHfMe2Qw9yS/m39kfvDn30PSgVWI2La1EkDqq30//joY8FV4HPri2unOvrTSFWQHfdmt3EVwlLspOFiOW99dmJKjZaFb4iMBQbmQSfcz/QM1HGuSzudbd7T/NKfFXXZPdSAyS9U/XmEjCfhGNYCOC8amh3WhqfjoB8IKutLBOg34BmijiTZmEXwIWqzKYGLdluux7HXuYmF1skLNOWxiLHdImJ2z3iLTUjesNszwk7A3F5y0PVbUO85/VRj7oKmuiCibb+2CFrHJ5PwQVH5TAaXly3afmz+4Iw42p776vmJN/5/dZwy7mY8R4cyd9Jm2kNH+Lsk+4djLPYEtAW7q6/IMSJqsT+250l4qbmU68aDrAmRMDzQVlWPWPmLc/5GlHRWHpSM5mxd6BhaoM2zSWm3F37lCVzgdzEAYUTG3A9mjeo/UWFd3Bb/NvVtNmIUSn+oDRhP1xbW9CkXU9LKY8MyRcwkUMSNQWdXqfOaKUaXNFF8/1ShWKB2yC1XQDDFoSeUEPHRK3ctJ4VvBkVReNKKdqCFTcrBQgMUygxMcfCz0GqwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(136003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66476007)(31696002)(31686004)(86362001)(316002)(2906002)(41300700001)(5660300002)(44832011)(8676002)(8936002)(4326008)(36756003)(66556008)(38100700002)(82960400001)(54906003)(66946007)(110136005)(26005)(107886003)(6512007)(2616005)(478600001)(6486002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjVvSFNkV0FaMjdZQzJNUnZOT3pUYW9ZdlgwbDZYQVFTODVmZmM1cWwvUE1M?=
 =?utf-8?B?Z2hETmlpVE12U2pIQWlnWTBjTkVxMDN1YVFCTklXVXZoS0h1dml3bWd1cEcz?=
 =?utf-8?B?Z1N3aTcxYXFUUVYzdHRFY0F6Y2hoYm5NYzRoSDNpcWRhbVROdWhlLzI3V2pm?=
 =?utf-8?B?cTMxcTFQZFoxTFRwNUVRMTluTUJUa3FSQXdvUXN2amNxemxsUDc5NmhIc2k3?=
 =?utf-8?B?V1ZqcVFJTlFJdHl4cDcwc21VMkRPMjhQdXhWMUNnVGh0R3hLZGVwVWJpdjlX?=
 =?utf-8?B?RVNnUy91TTI4eFhDNEJaVzMwbjIzRlVDV0VlRTNhYUJLNG1qM2FKdjY3TThr?=
 =?utf-8?B?M1BhR0MxTHBiWDRmOW0vdG1uUjZ2dkZOZEJmL0dsOXJUQkVmNTdzREhreFox?=
 =?utf-8?B?SVNIMUNMcnY0cVRDbmJoODdXNXhjWW9LWjZrdGpKd3ZybGc1NnBZenNyV0o0?=
 =?utf-8?B?ak5rdVhiZlZRSzNhZVRpQm9oWTdWMm1lSDg3bFZiUVJMcGUyQy92MVNxYWs5?=
 =?utf-8?B?VTZrQld0MzZLNUoyT0tzb3kwTnk2RE1MTXAyd2h3OTZxTkNudG12RDNocDE2?=
 =?utf-8?B?N0N4TkdiY0dQQ1RpN2k5OHgrNGlFcE5RYmxNWEZjUlJIeEdqY3FMcGlFTjhV?=
 =?utf-8?B?dlQyZ2dCZ2tUcTY4OWJtZmdrV1ZzOTJld0RPTkFpU0xITkx3NUNBUU9zSE9W?=
 =?utf-8?B?WW9aWXZweW5uazRTVmV3bnd1eVJxR3Z3cFlhc0pVUHFwSjlqV1F3cTZlcnZu?=
 =?utf-8?B?UTJGTzlDamJhRHE1VmIybmcxeERlaGF3Uk9lelNBNGNXMjVYQ3BwRjRyeFFC?=
 =?utf-8?B?eExSd2J1TjV6a3Z6d0M1bnNzUHgyOHhPdVJ3Q1NiWU1lN0hGVlFGMjhabStU?=
 =?utf-8?B?eUlmWFpBeWFjMmtiTTc1c3V6bmRZbFNQMVYwcElnSUVpVmExV1RLRlY4Rjk0?=
 =?utf-8?B?cDJEd2crcmpkRDJBcWgyenlsSFdOS1RURXdnajFsbWh2M2RyZllzZWpycDBQ?=
 =?utf-8?B?QlBQQ1Z1ZDJVOWxZd1gwc0hMZHpQOURveUZDZGhPK0NvTzNkTytlQmlwa1A1?=
 =?utf-8?B?cTFIa1diWGpoYlRyVDA3RDAyUitRZnIxYXI0dHF5SERCTW82M3l0Njg4TnpK?=
 =?utf-8?B?bHhUZTVJUU8xZ0RsZG0vL1I0NFZPRVRGWUc2aHNMYXhtM1pXL2loNzdaTVVT?=
 =?utf-8?B?UGRBN2MxQUdxS1had2pTOVVaVmtKanNTbTFZcnVTYTU0Z29xUmY3SlFjZFVu?=
 =?utf-8?B?NFViUDdUUndVMjBBYUlPL0dmbHBqV2dYeEZveFdPVkxzL2V1eGgrZFhXdW9w?=
 =?utf-8?B?RVBpQkh1ZTdoZ1BsS3Q0a1g4dm1KWDNYSXhWQ01pNVdDbitiYVdlV0tXYm9U?=
 =?utf-8?B?M2NEQ1hkWCtxSzZGVFZSelQ2SlFtTHh0L2dBWjk4RU5RMytZVkhwemx4N0l2?=
 =?utf-8?B?ZTJrYUVzQm1NVTduS3h4am5uZURsVC9FRmtqYXRheVRYODhMNGVoeHMzMnMw?=
 =?utf-8?B?MGYzRDU0S0Q5N3dscTFBc3dILytFT2ZaY1U1eHRsVk5aN0l0dmhwQW0wdzZo?=
 =?utf-8?B?U1YzSlVGMm5jVUlBM1RoSCtEekY2N3packlaSW5kZXBENWZKNVRoK21JVFlX?=
 =?utf-8?B?YUkwWTFoTHNnU0lzYituMUEzT1ZLVTZPb3JlVVVpenlGVUxLSHpiWStPR3J2?=
 =?utf-8?B?eW1HQU9mVTRlUzRPWVNNMklxZ3NmcUZ2a3JlZUlnS0M1TVQ2Q0lITEY2V2Vk?=
 =?utf-8?B?bTlsaG8wZUNzR1NxN1B6Z1VOOWlZQ2VKTWp3OTFmdjlBZ3NSa1NsUlhKRUNC?=
 =?utf-8?B?L2pmRFBqWUFwRVZ5d0ZtdlcrRU9SY1RHTWxNOW1tUWlQZzh6eDYzdSt6Z0FX?=
 =?utf-8?B?d2xDVGlDVlFBU2VoYUQzMmdoTjJZaWZKcUp3U2dFQWdhUWE3N29KcWUwVXda?=
 =?utf-8?B?TFhpeWRCRmgzeGNXbWJiV2RvQm9QYVlocDdKTUlPdy9qenFkMm82bHM5S3ND?=
 =?utf-8?B?OUJqK01rQ1BwcTVVNXVlb1MvRnZGUVMyOCtOekVjblFnQm5xMjlKUllNTEs2?=
 =?utf-8?B?VWJJMS83eWdKelRCemdsY2lvMGw4aTZSWlRMamc2V2NSeW9vaGphRVZvNGtX?=
 =?utf-8?Q?wFPXx9758iM5vFRqHzfE0FEnR?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc736d76-0f73-4703-017a-08dbdde4cfea
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2023 09:51:41.4899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0bRAKbQYn/6XmpA2C1Nk8/KP5SdnL/2S1debOUyrF1VM3kAiiTkNkAD/aQ+5dZ9ixNF4J+8+MC+bokeLQym1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6309
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Analogously to prueth_remove.

Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
Fixes: 443a2367ba3c ("net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - add proper tags

This was lost from the TI SDK version while ripping out SR1.0 support - 
which we are currently restoring for upstream.

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 6c4b64227ac8..d119b2bb8158 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -2206,6 +2206,9 @@ static int prueth_probe(struct platform_device *pdev)
 	if (prueth->pdata.quirk_10m_link_issue)
 		icss_iep_exit_fw(prueth->iep1);
 
+	icss_iep_put(prueth->iep1);
+	icss_iep_put(prueth->iep0);
+
 free_pool:
 	gen_pool_free(prueth->sram_pool,
 		      (unsigned long)prueth->msmcram.va, msmc_ram_size);
-- 
2.35.3
