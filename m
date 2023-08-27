Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F11E78A1BD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 23:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjH0VOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 17:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjH0VNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 17:13:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2020.outbound.protection.outlook.com [40.92.23.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E28FC1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 14:13:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fghe1YfnN6cibuJRVFOLffVQDCj9GldQQzBCrZnLvd22grHU/44jBP3MAS5FddAQjyCjWtrpKM3XikN/OmNQEiU++jId+ar3f7OKwtBbiOXQd5OO3Wu9LFqCZ8llkPFnyYlufz3KVvg0vEe/96DeTkGBT8iWEi0PDkc6CnwDKiUu7s4lTX0eSrllbr1DNYPuypopaoYq8Pckj5pmQY99vv4UmbhrML/H4fXZrS3vCg1Fq61zKAHH+ajnnG3nkVckvutTnLgE+oP+g4huxcR0S6J+ZfH2Kl0JTj4c3PSyvgOf5lXoJIFUEUGtWfq/1a4lFWB9jGk4sLqPGgg+bnlh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrMArZbJb39LHpXcLLgvxUf2b5j0g/FFShNIxFNzD/4=;
 b=eBJndohRjCfWHaI/uHLBFIK3qngwz4A57JRMrSN/aCKvWw8VBMD90i8eRslgViDxqaCdEU1G55jC36AVYuf872fopkzSUJCiyMCW7QWYGrcoGoUGQzoDrrW1AHCptoj8ZZVBUrIKGws/VTQAJL7OuBV1Xik9iRKoDXGgNfK8TZhYZZPv28Bb6T+5eZtLl4CAQTZBAlM4841OTaTfwlVrEfHtCY7uEKt/ThHYyi/rU1NREClGZzgWyaOY2o9slZFSRu1J6/getRvuKOcXNLbghlNX9miccUgc+6T9ZjZyM+Xof0KCEAwFdbzOr51VGFpwRQNiHs9xEaNP9mU6Zq0D7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrMArZbJb39LHpXcLLgvxUf2b5j0g/FFShNIxFNzD/4=;
 b=kVK2XxBYQW9ip6bnWAkcoyXQYE9YEOfA0uUFaoOkVAOhecWhY3z4oKXLiOad2VHHnjgGSLwKVGfT62ArsXWP2UFx+UsZJTFrtOytk6uBuovQQ3ul/tsiNJ6Gmei+QbalMPbF/hwxXHOjaq7qGjBQm3mD3FmQQd4tBJCpSzWtdsE/pxaGu9Z0FHsKONtWMAmI/k+AxkdtT/mubo0Low+3wc6W0n9Ew92x1I8J7f/yh0AeCsIsFuOfvSFd2/nCZEfh/P3EYtddVAdbaNnacqpeTEa3glheBAE+kVGymGiv10lvQKHHc0mKLleQKYf1x9ZCAN7qKBYPJr+Ztn9Hy/uffg==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by CY5PR11MB6115.namprd11.prod.outlook.com (2603:10b6:930:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 21:13:28 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 21:13:28 +0000
Date:   Sun, 27 Aug 2023 17:13:26 -0400
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 2/6] staging: octeon: clean up the octeon ethernet driver
Message-ID: <PH7PR11MB76434738C5959C463F318FB7BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [/C6Z+86Hab/TPNAMbO1NMdpQvkjdpnw67NOJDMPM/5t9LRvKJ0r5RGpP4vFBCK3s]
X-ClientProxiedBy: BL1PR13CA0316.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::21) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <d2da65vqsbjmdwrc7ln3ao7z32ewjjg5t7nt6j4wktfbbdq3sc@nfecn27odz27>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|CY5PR11MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8998da-9219-451a-d394-08dba7427547
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cfx39Sv/OV1YbJKjJDK3ZVRq6oQlU/CqycFdmeqahU42H9nkUNWYRXuatml9ccLizdC67WZ9VT7ERrip44F24C/puBnw9La5QQPvXw+qrcE/Hkj2MdpWhzxQn0TurzK+d+EV4tkjQSgmXXWFhC7ToBp+JbAtG9YJTtJOK+H5gAWjOdP5IPuRNxkYskM4kh/JNzjHruipSAzEl4OZVKP/maXAhNq/PHjPwaweYNcuDkl1f/AQ8kb9GA88v+BIsjwercgX/4JmTL2mJ0aLDgeWdYzV6mdGTINn2lQHEpEXkB/X1A2+CPsZMlVzOr56RJ8HpcdO/I8oZWkBXKOOig6MddUg807nFxXBRRabjEJTgt5WrUybYnDBRQkkq5/nCVhtj4EN+v7IO/kNjtxp/VqWbWtn+Qz1SNVngIvyQUybE4q0fKAeqvAZewAMSZgU0Mx7gJtwCFyRj4kf4OlXEUNvRYlcD1/w6qHdEMdmOI7BJc1M9UrIqBYOZ5FG3DMujTI4W2tMAZoP3RLO9nD+LpTCGJ7/r1mkkk4TTqT6L8hdYLYyS4N/CkU1+sAQo4W5Ovm9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9YqJ/tfFhd4BSAr4V5Eji6V4kNvxyPKVlUoq0bLZQb/1tX20CKYTPrLrSBId?=
 =?us-ascii?Q?5GRWZcjsjcVIdlZnvKpVGPS1MLDp8Z0/5RMoYiVdT5OqLKYqKa+6SlaYe/iV?=
 =?us-ascii?Q?NoT13kT9JjufTrYxYG1o/eBSq/lbeX0YyeCunKHR6Zn+QuZ4INDpne4WZ26J?=
 =?us-ascii?Q?j4QqvSEuFiSV5gh6oKuM/tKgm11oLDGbJtm0A1PZ18kZLBccrG34gEndPJiN?=
 =?us-ascii?Q?R9XueQ0hQDuAc/fA6I9oqa/pooRPPKmA4YVqTG0KvawjjkSgaf0ZT63L9Q3G?=
 =?us-ascii?Q?UzZ+07MOtdSYA1ITR8+4O2lwZDhzNWftCqyg1SPOGgckKBtoGQi6pnoUc+t0?=
 =?us-ascii?Q?/IapHtJqwn9ybmNqQUDDcxG7lqFVb4tE+rkGz2qCO04LFKU1aGt98658k6KA?=
 =?us-ascii?Q?k760g/HPdxJfADXoEmx7QRJigNSGG2mCEt1Hni+vFb/MZ/MBNiJTcCwSeN0o?=
 =?us-ascii?Q?3dhA2VU+rb38DgIckAEkojKCONb4F1+cMvO6S3JqQXfqBgEq6yk3o1Xp7HLC?=
 =?us-ascii?Q?a4fumUndUL37wob9K2hsBlgX6ir6siqj844hdXdjnNhJZ6KxbvgQwKvrTjhC?=
 =?us-ascii?Q?bmbA0Z4ioKQoM0Zi0kzynPper/nnQhoBMIUGc5sOtz7R5ohU+e5Ln6zxUibo?=
 =?us-ascii?Q?LUv06OpQ2/ZkttpqVscBW2YdU68XIF3TxRYlBR3Og7ah5lzw9fHrWQlGGKPI?=
 =?us-ascii?Q?uY7DyS9FrqmGkjpUj0DNnhi9jtn/SMSf+DSRDcyBbPzHpqy/dldm9ExMQAHa?=
 =?us-ascii?Q?y/Q4dby7BQW2hnJE3xk97RhRpcU22ZZ3L3jIsqpn4Gwan29QXDP5sEHanTvF?=
 =?us-ascii?Q?R7MB0nO9FyUNGpONclK7MUKNmqx3QIKds7r+rRrI3KJ41z06xoRqRG/oOYsm?=
 =?us-ascii?Q?ABkeE+WyfsgcNujdCp6mfyWMdKwMb7pH5pUEO+ZzUjziBVoGFi5+szBEQtSC?=
 =?us-ascii?Q?aAzSU35ozz/OEuXilyt69/mzuPWbL+v0v+lhoVE0p8tMIYFkW95ENvmygoUc?=
 =?us-ascii?Q?w6GpPlZy5hxfStaGsIN3Nq4lqP8Lt//S8XEt6oIM4VOJn8VNLyR9C2AYq7A7?=
 =?us-ascii?Q?zzzpFbsVLWxu6JQXM1+0qCf/+IdRQLo76mj8NRebZ2yeW4ewsjfjHMQGMumc?=
 =?us-ascii?Q?okDetCILqPu+qNvw2jU/DTCbrJ8FiZ/ceohZPYUA0hq9lKOg0A3s5tt8jkzU?=
 =?us-ascii?Q?CsNPL6bDjor56bVcMSbMrbQRUIDpF0HhguPr/Rho1Jg7cFJHcyLX+91mg/vt?=
 =?us-ascii?Q?qEK5RkhI2tPhW+YDvQvwvCqooqPBuPk0RtZyCZ2kjg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8998da-9219-451a-d394-08dba7427547
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 21:13:28.4557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6115
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

