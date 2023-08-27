Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD3578A397
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjH0X7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjH0X6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:58:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2046.outbound.protection.outlook.com [40.92.22.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FA1F5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctC33hPqFEQbYoX0KrflCAi2uzOlGX+vvye6OSd/MxdiA00707tTY0K/NeizCogbZmuq0o79RMUON1TSRIh2f21pYNfUYpckpvrN8sOMDCxQhkPcuQ57ueICKGw6aK974x3PS3HOgAm+IkudLZd82BL5BO25EJzoZVnh7Lo3BMkSwDHnYFuOfjG2SlDe17Vv/cWYj5uEf8lGVbjwLW/eIiRdvIMsJVjFbuBSzMgqdSCMWqxTsfgk5aTrya1gZx/NMnhlO4dkzrm27Bqv8x0kbUw0jT4Z8z9xtJuL6mLEijwkW/Us29C33rH8ukpSJvIyKp+TbGNswjAOvgmPEPAZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ztwhM0HwT1qvX7KMqTvCbM0QHvA4r7neeKDcy5q7hU=;
 b=Vy8f3YmauZIdt2DAx4cHQ6u4n8phWk9FdZEfZ9c9hUplWws8hlXUU1fimVUcOnONp9EuxQhVI+qeOdUOueX8hnB9J3y7hYtVhkgtz2kww8H5itBJp/FMgjoVGpZPKsRWFgUCfIXr+cGvurlWCKaie7vp5kNkgLQ+dKePmCUvQ5G2kICXOVyJWr5tRuus43Pq4MAifGquT+UCO7hJqYl/uvSi1uycFums2gXu2S/HFPe4i05xFa6DulXW2/VT6aYSy2FplFBgFZMiNh3i17yY1OnYZ2i0mB07wcz5hcyegOkP9xp0blC843bOMIuaHvsnrLwyT24c+OFJsYAL0yX4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ztwhM0HwT1qvX7KMqTvCbM0QHvA4r7neeKDcy5q7hU=;
 b=pmc06KhXhAVM1q5ZK936MCo/lNbe4qITpisLZ058QU7UaWuReI9GRsDsgp/VMEkmk0hHAk0EFYaxphI0wTovdjooGBloeAdoK1eyaGZxmPqprYB9CzfhKMe2oSBFcOfLGMH9ezsIsshWTMVCVFll0umQgi5uAjRPo0jbG0aFOjfjQe/5A/zlWY728uaPH43GgJsu0xcM0xoHp1ql3G2akmaWtQUKipvmcU/ynwAFvXc9GYCo8/LhFwjlGN/qmSSQD4smvzO0q0BwBsyQbgy0CsKxlnCbp/gTdIu5guT++Og32cIchPnGBlvZFasXbwaqnE1wMYGOS0aclcklY83ayg==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by BN9PR11MB5306.namprd11.prod.outlook.com (2603:10b6:408:137::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 23:58:42 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 23:58:42 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v3 2/6] staging: octeon: clean up the octeon ethernet driver
Date:   Sun, 27 Aug 2023 19:58:18 -0400
Message-ID: <PH7PR11MB76433DA33CF3E327D8C57FC0BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693180346.git.ozlinux@hotmail.com>
References: <cover.1693180346.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [cGyk9u64f+/MMoaTzx6PamxDe2ORqTd/ajxmeeKPX6CClGzo4LInqso1I8PHdqkx]
X-ClientProxiedBy: BL1PR13CA0246.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::11) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <4b6d2f7303b6a3d37e2aa62a76421acb8fef0146.1693180346.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|BN9PR11MB5306:EE_
X-MS-Office365-Filtering-Correlation-Id: a60cb527-349c-490d-4cd5-08dba7598a50
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmrTVQo2E8YhiYZbimk9QHlfee0RmoCxeVIePFgCIRpvUQLtO43q2wbXoHvczawx9aWltp3Mq0Fbh3B11D18qJyhzf5lpk+bYLYI+UpnKLRhuQeaK8G7sdAF2Z7YB1R2exzNsKgQznQJksVw0u2XE3KlFQhYBBvEM7bCRAaEh0UJ1Rfqeqd4Z8OSTGruzP6/q6xNMhKHtz6jbia5p+zjzvJE6MUFlD+VjpO+gdSHNQH9/L9oHC/XDgDds5JbjVGlTSaE9nBdiSlW/fA/FCUw/8uWGnpugdAguMIsNRhTY0Ol7FfAID2bAHBInY8kroBjtuza/6MtNERQSsydFcTEVZ+9zACYQlhsKARlU1uhJlvyQ98Y9wOqcuTkI41u8wm9jBxfx4zvcz6ThnZu+r3LVIGdAlK3qI/xk5ivvQN0cgjEirRUXj+i2432X/f0j9y5tNPsd8eiDohRwxwp2hfFkJ3QLD0mDpOwxegU/shS7gTRBkQ3oHSpZ7z+ZX6gvIySvbd+YLYfp8IpW08GbbvY9GdmhCaIWBdS2GBF9uIejooY0w0VhMM86sARDIIgXzA5+7UziCA8ONndJPdrzFOfPMJNUMQH4KMnWkBNRwiESh1fZP61w37oLfyJ+Um1t5UPUyEjnyFNGKHgLUMvhds5Xu15lS2kKMWvr51f0Lr2QM+Jz4htL6F2x1axYImzrScMhwgqTFa+sescxARL2p5jZQl/SMK4DAPaNIAwInI6/BMJxOstl3VTkA2n/9THO+4AzAQ=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vemLIzsFB1ONVMdEVo0ZneMsmS+oMLipa3UYihX6aQjLRDy0XfP0Ps8pPzirkLN9k7/dsYACSHIVeIg05wEneae19nFsxLmLyK/Ao5s87fYzPGG/hrZ7LkLnmH62PILIvIJ9NaHDzp8FsCv3nv70H6qI0AWdJ7u2t334TWxnIPRloFjg3Q4856aeuMqCL1/mo6ccq00LnuBH0uKRJ9fegKKhcYkB60nYH07yKaqn2rYmMQjDl4En/Db/JU0L/puDb2rRePw4fGhFukirnSUw9avaS1gt1V/z5bkQeJrWpkIgImbNob+E26b2XukJPHMqAHaUACw/dfVSWCyjLVIfmJYwGnfqh2GFL0FELSu98nPGA5QPC7qhb/SMg1RzIPkfuBgH/TU/S5uppSvYxJTJdECoITyp/bVZSCWT7QH0RHs7E1V00Fv+VhUWRN2YOfJzRYeheq7CegbzTNOQlzE2MCA3a4z97hKV+a9ZbRMDTm03p1xY8MqfemHvexhccNMYqApcbvOc2sFTmfvTdUrUiYq3Hb6IgSP29OcXylnb6FmMD8i9MjR47JR/icYVn0roy4NJhhCxuyTRQm6TNqL1xciDQmnQ76ZoQ8r/Sjf9t1fRMPPzE7HxLXH70K3qLK7q
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eG5h6mplTGFyLsX7A/+SksFs3obfGzgiNTf5qa4v5haJyvVyccqkIFCYcWbx?=
 =?us-ascii?Q?M3EAx8EN8OxZO8zQdRBm0GGSByc1W5CqRnyRcHM248lznEPQ3k6iWwW9GBMG?=
 =?us-ascii?Q?At3D+N+1JFv0ZFRZxHhUpQg0/EZ7mauCnSP5DEmZnY6zL9UOr51nO1ISxGf6?=
 =?us-ascii?Q?ynk1MqtrREi+Gd2keLtYfiyEjiwC8jcHTGS3gVKKFN/i+malvKo9L6y7txwq?=
 =?us-ascii?Q?S30u+P6pSkycR+nwB402aXXpxL3KbpyVtCirb6yMrley8j9SJILPs5B5cKrK?=
 =?us-ascii?Q?5s7dMfLijcpRjWA/RxBFaQm4u/Fg0+f8TI+ki0yz6L12KDw39qaJro3Bjcjl?=
 =?us-ascii?Q?cjiJUtbBZ2mMs25o+Z4WFOPPOLtHCU5V1ZzbTXeW4zD88o7IyyhuCXE+T/4j?=
 =?us-ascii?Q?WD5vFfdFadsgiGPzt+vlH/0108tOlTF6WYv+w9HXLWXEZxPoOQHyqmw41Xny?=
 =?us-ascii?Q?SW8tczKCYvaxbwnE6zCviUOZtmZxbiT5YwePdMRfraTk6ASFEcd/kh/J/H1d?=
 =?us-ascii?Q?WkYZFdHNkceu1411oSz0FkRSEtwURSZnFWLjH0LQ4eongOdQBB0UM7odTBPg?=
 =?us-ascii?Q?t/OrgZcu787dpANCUHQd+ySBjOwu+pcpWL8WmEMFw6W20+mzhX0bDYgp5oCi?=
 =?us-ascii?Q?KYWoGHYolVwzHOVO1CnC44/PSd6ZtXDeM2I8oDOmwLOWSmpldEmFBwehCGQF?=
 =?us-ascii?Q?Mt6v4L6yhmxNhcR1naUAXWpqVm/Edj8931mUiUwOrFQQwExmwwpIrH8BEnYs?=
 =?us-ascii?Q?xM9U9W6abVo9G6JzJpo2H2pIpZvyZmhOPp8at7B8V8tDRRJGbpIlbiGMKJEZ?=
 =?us-ascii?Q?Vqgd4p02u9lcfngFVfcPylyKWcRoqAmFxECP36Piz7HyciCSB/Y+jbTw+NbO?=
 =?us-ascii?Q?LoIg0xY0Td237VLoPynYKiyRcO0vwtdjGjeAUXyj4wv9fsfPRNwbioQc9NEg?=
 =?us-ascii?Q?+5qXimFevvDFjuhOQJ55upSjtTUzNMXpOj3wmbqi9sWEozuG/LDIcmm/Psc9?=
 =?us-ascii?Q?b2J9EcHsIiidaFfKbeQqbMh3LnTOq+dqDRXEYZUNmTLwkAX+s/TZ8q0H7hTc?=
 =?us-ascii?Q?1CIYI8arczRor65C3aY9LhoBm8fZTmmRDLfTM7l3Y0d9W2f5bHAxupw026WB?=
 =?us-ascii?Q?gOl2S2NFJxQgXcLW0fYeM78PB186x5usCeLUP2BDRhTlajbPd5A2epcubupx?=
 =?us-ascii?Q?zU+DCbZnGFNmsdAdnBTFw2QGjxkfCvAMlTT1cK6a02M9rW7vlr57Qsi8z3nX?=
 =?us-ascii?Q?9ZwiVhkZ+jRQuq74IGEXhaRxUYq9oBFM+cV7UgPuwA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a60cb527-349c-490d-4cd5-08dba7598a50
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 23:58:42.0657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5306
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
v3: Fixed a problem where I forgot to rename all instances of a struct

 drivers/staging/octeon/ethernet.c     | 2 +-
 drivers/staging/octeon/octeon-stubs.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 9eee28f2940c..023b107e077a 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -798,7 +798,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
 
 	num_interfaces = cvmx_helper_get_number_of_interfaces();
 	for (interface = 0; interface < num_interfaces; interface++) {
-		cvmx_helper_interface_mode_t imode =
+		enum cvmx_helper_interface_mode imode =
 		    cvmx_helper_interface_get_mode(interface);
 		int num_ports = cvmx_helper_ports_on_interface(interface);
 		int port;
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 9f269626b862..0b0c609a771c 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -220,7 +220,7 @@ enum cvmx_spi_mode {
 	CVMX_SPI_MODE_DUPLEX = 3
 };
 
-typedef enum {
+enum cvmx_helper_interface_mode {
 	CVMX_HELPER_INTERFACE_MODE_DISABLED,
 	CVMX_HELPER_INTERFACE_MODE_RGMII,
 	CVMX_HELPER_INTERFACE_MODE_GMII,
@@ -231,7 +231,7 @@ typedef enum {
 	CVMX_HELPER_INTERFACE_MODE_PICMG,
 	CVMX_HELPER_INTERFACE_MODE_NPI,
 	CVMX_HELPER_INTERFACE_MODE_LOOP,
-} cvmx_helper_interface_mode_t;
+};
 
 typedef enum {
 	CVMX_POW_WAIT = 1,
@@ -1265,8 +1265,8 @@ static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
 					    cvmx_pko_port_status_t *status)
 { }
 
-static inline cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int
-								   interface)
+static inline enum cvmx_helper_interface_mode cvmx_helper_interface_get_mode(int
+								       interface)
 {
 	return 0;
 }
-- 
2.39.3

