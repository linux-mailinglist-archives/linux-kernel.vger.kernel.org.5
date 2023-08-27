Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFA578A398
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjH0X7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjH0X6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:58:48 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2103.outbound.protection.outlook.com [40.92.22.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BA2113
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:58:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhlMXJb3fGKGZ/IrKJupAfgJ3/RGNqlB7eleN8G7SdS6bxXZNitZ82k2fNRXH71ZP7gTUsBAa2ee4Y+nGAZhtVFQMJYUvZnRPSeHa97N2UfCNWN7zsyQG/+4Kkcd1bRVix/az6z7zGAGyiE5HqWfyPcSLIdDqoO9sHJUH1Nm8V4xSwAN9vzVuNspUedY+0AwMFoPJKsySAMdhqu/DdTU3C7xAb6SYM587kjm4sY0Fso8ISK+TYsvd376xLi2I6Ch9i4rK4x2nErcp+3We71EtAx+9NjOjZzIuF4KTCckktSCBAJ2e3wWfF0zYSNBDV9d2EZRcUywYHZo1ZqHXfbyEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CH6A5pNtyBo+PsFO36TtFwEp+sGHnoBMjrinRkeXiZU=;
 b=L/CXFLtp9BLWOT+69lTwgIxmbmhVhTD7MrnRREFMsheTqAiIMmZy1qlSZ2tsgKk4laAcEbtMGF2yIUiQKwgOmWZMOu9eUJeHIrpix6z8bizNR5X+ISkNqcE/w+SgY8crzoZO93MZ9kgR/z/NwI8mH07v2AVpoIzG+dNKxtNqHw2qBc0y01yrI49ugN4x/obFwMh49dIzC2Qu+5yr9C3zI+mYsAIId1Mn8Hbiq1W1IT7IuQ6NVdfeGWp4HXn8wQXFem73tbkXp05wTjflVx1zfJtQp/CfVkrQ47XvUGxOd/Lt7G0//TJYNLZgvSvVKOdNkdfRpqoaqoJ3eW1hERoKvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH6A5pNtyBo+PsFO36TtFwEp+sGHnoBMjrinRkeXiZU=;
 b=El1az9swUnaot0eFga7MQqtPFdJVs0KkHWe67ub7nuxFia7paClnbzxhM3JVOvZok82gIF0SVoJ6gf72ZfOwBf6Nvw08wCXNN7H6eBXrEGyOz+N5zGcm6vWq0Fjt3+OE6djci9oycf4ryAmUt4QoVW71g27zPvJAhzApiSNND4o5QmRhHCSD5cl9cpDuSfLr9f6FIOs/ytMMB8GWjD+ZqkfdEWZC9SckAzkZMZ1BY8by7biDTtUbtxpcFFnS9zcueJ9LDPqTd0fRxZ1OX+fRZ4oL/OIfyaiB0P1bb42OyG5CrYLb+Kc+i4bFP/2EyUAf+Rs/6mJsG1uUDb8cLaN5Ew==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by BN9PR11MB5306.namprd11.prod.outlook.com (2603:10b6:408:137::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 23:58:44 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 23:58:44 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v3 3/6] staging: octeon: clean up the octeon ethernet driver
Date:   Sun, 27 Aug 2023 19:58:19 -0400
Message-ID: <PH7PR11MB7643C76979B1DE3FC3CF3A1DBCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693180346.git.ozlinux@hotmail.com>
References: <cover.1693180346.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [RPW2V89ExVRyCNaC2F6lfHqsLJe6IhH8nE5XejbCZWwIE5eeepWBTsgRAx++g2+h]
X-ClientProxiedBy: MN2PR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:208:23d::11) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <83f0e6973905abb9a96ad2b104f2cca5df4e6966.1693180346.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|BN9PR11MB5306:EE_
X-MS-Office365-Filtering-Correlation-Id: d05ab124-19dc-41e8-f2b1-08dba7598ba9
X-MS-Exchange-SLBlob-MailProps: EgT5Wr3QDKxdJFFr+sHMsCiKI8T/Q8I57MoUUeFPEIRL+4dKjnDzFfdgvX+UDwgmL4+B1WMsI+y2UPxS5Zn3HeBWvl+xSenHiWqP11nCe4pLA7uAeD5EO8G+O8Fo3b/P2sxGxFGWewL0wDithmtcRaTx+zKXaYZlo2dmf+3ep8pvZOD0RowvrQvQLYd4AwNNvAlPpuxPB2bOW2fiKvV2iZ20Vxqad0KvGWpeUKMdZvH7Lf2k67hk/YCJTDPFRgw1VRxMynVUctu+vc7zW/2S4sy2WL4oFMiw3x4VWetOAJ3JnyVljTj5mmBVTgCPm9jr3fRzm35B9Dzcx/W1aX7JbNUUVFSV+xjkybEXzdEWzeSq5FuJC6+LYFakt95r2poA9SjEFEFQzqMSSR8Ta9IQIsf51rUBeQTvDpbYkFw6o5jRrKsal5+Txae7kb9YCyuHsUOWoJ7xu9l9YRfflP1Pj7PeNXa3+40WUpJtINMBlwOCyJ/QUA1hwRcy1L2xFkekLwSspoKoOX5QT2f+R3Eic6CkUL0/H52ZaGh2oDW5lruaRB9JJQCmshkGOyIJG26DCLInmBg5b9OnK93UqJAIiYIjs76CVvLJsS6yEgKgbjqwcjC39U//GyiNOkkFl615D5SVYTez95/Emlg6hgc8dNQiCaaW+puun7UWM9fYggXxskbDvfuh+F3Xf8QJduXsfzQ5CtNvC+OupPZSjB/mC7/Tx2QTUY/Q5zrjrpXDVn0=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yupq1nEeL8DrastgDvSJe7qiqyTPPIwhfVwe1hAnsgKISMdqnD7YMYe6k7ZKtaEWH39ihB7Ijv9BPCA0WrTvIjkNJnlKhAUcEaFiKAkEY7xyG+fD334sbU5oD86klLFGYfwe62uTZKEtteGR6k3zxhQKKxxqvsGRNYjcPd5c8REQyYe8gELAawuNeMnb7X+MNDb431aQEtMhreg3hK4AuCuK4FTd8/zUgtHafQqSrJq4Sys1o+1/vRR8qvLHO0iZ9ZdDJ6NIOXP1clvHqHmOinnLHoJ2szwmxgRFhq5Jo2jAblSlSLPSf+4Xtd+R2bs4tiBtAtUKQHvfeGhNwdqc3d4pRvGEkTZOYLMAYvKgfYsN4shZvpi9wRdbGMkE1s7k6va2WfBKPitynj+W8UitQZptZA/V2+y6FbW+V3ILNlxp5Hht61OpCvduz02hAieQ0w0tmLSEInJlEHqQbPnMyhUa1lkrLjwShJjEJrsnLh2JT9B0G65LRb0lRN1pO2RXg/SQQl5H7f5zq5lEjzXiWoBNsJ+jO+EPSvEUNIdLvLtgqce8u+H5gfIpwZyVR7Fix6BEsz1AdPcXcL7CwBpzltpscxDXUACgesDKPIAEa8fcguRrAtBbQ6+H6c02Vmwp
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bj6aQGNKMOtD328f+5TnO1LBFBNQHDpVTLfMvUZt+b85MeVEc2Wv8VVkDpnt?=
 =?us-ascii?Q?Ox8aUm482frkpRlbdU1fAtnB9azEUKK5qX2C30yM5YphYqE5qA8OLbMvtK1f?=
 =?us-ascii?Q?k8vpsDjJSPSqA1iI1j0IP+FcHBUdc0n1CHGtPV0fO2j9iLimP/VxXZkCJW1u?=
 =?us-ascii?Q?fu4D5hJH346c/Dyg4542GXyinzYppVubaR78svqmAqiyZub9JjpytSkAYbAC?=
 =?us-ascii?Q?6Co3BkRMXEpUq0P2PB77qboqRN/s7UBx2fdawq8BheQnxtb1m0zJUuSET10n?=
 =?us-ascii?Q?Mid7crLnw5TlJPtusUXfg7wjRFCIAuzps0KtUG8jqmOUx/2Xbw0pLPQSIUZh?=
 =?us-ascii?Q?kkZgu0WZP4LxekA7mxvD0QcncvZIg6d4FPI9iuxNsF70hfuebyfBIeeGrmhw?=
 =?us-ascii?Q?CWGNz+6+/HwKOYaA3ayBOxgQVLmnuLjX8jfPtoNUK0Gnijz/G8NHtResq4HX?=
 =?us-ascii?Q?jeAc6cE9VRcPxrarZQV7woJQ5RF5896ajdlBw19O7HbWJIgHp9czeIO7Pndi?=
 =?us-ascii?Q?czjUKSxD7i+mNWkr0vm5qS8KWL5Zwye5wIGbnThRIipICLy/6Xeq0dFhyuzb?=
 =?us-ascii?Q?a+ZI+sWA9G93U+Pt+I1YcfHjNMMZWCCcIpj+kng7IInBA9e3UZnYw+C1e7g7?=
 =?us-ascii?Q?f186x6TxAm2ax+YMU7Wu2c0SRgFZ4pZQGTXOaS0fL5BtBGAtMWRRBSat9Ou8?=
 =?us-ascii?Q?u4wDeWMe/5X0COrC/Mb2tq+yCgr4I7ntodS7cm1JdntAjs8H3IduBZrDFh0Y?=
 =?us-ascii?Q?ck3bjQR2QpLv8uwKuyTr1e9HqmlWHipIzvZUrhPsTvfi6X9jP2j6hvWLPWB0?=
 =?us-ascii?Q?xC0glNML02AcpKfRkLgfOX4RicSNp2cugYQRN0tgJK+Qw4oQwEAax6uzF4JF?=
 =?us-ascii?Q?Vi8QgeV3oRbra5ndyStYNru8QxPXdFj99uV4ziBe+Q2jdi0FE3KigIckH8aN?=
 =?us-ascii?Q?eqyJJIxad0WpkYxfxu4YqrRHegInZ1XKnKTNnP/MpRGgrCbX9/A2OJ5Kpo4z?=
 =?us-ascii?Q?T7d1a615hIhIz6b4evxB5LQRtQoXcgqogxZHbSVDNXvT2Q979Q25mPg7Sb8R?=
 =?us-ascii?Q?AlXWMVttqP03oJ6wpfp84nNTeFUBOeS4BrMaIHqOT2zXc1n7aE/RpXxgyusX?=
 =?us-ascii?Q?iyIxYrLd0+9Q30XE/EG0r/cZcTewmAzDl3/f2FIpGw9wnjDmnt+rVcNuuiDi?=
 =?us-ascii?Q?EILCqMpjWM1PcehvyjsAYeRhdqnv/QhaiKA0BhFnrYfbeV0eCVm224nCQWS8?=
 =?us-ascii?Q?e2Yuyf4pPd5ifMb7fQLVpu9jQvp9519xKvJxr4+Vyg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d05ab124-19dc-41e8-f2b1-08dba7598ba9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 23:58:44.3445
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

 drivers/staging/octeon/octeon-stubs.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 0b0c609a771c..4470c985dc5d 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -233,10 +233,10 @@ enum cvmx_helper_interface_mode {
 	CVMX_HELPER_INTERFACE_MODE_LOOP,
 };
 
-typedef enum {
+enum cvmx_pow_wait {
 	CVMX_POW_WAIT = 1,
 	CVMX_POW_NO_WAIT = 0,
-} cvmx_pow_wait_t;
+};
 
 typedef enum {
 	CVMX_PKO_LOCK_NONE = 0,
@@ -1342,11 +1342,11 @@ static inline unsigned int cvmx_get_core_num(void)
 }
 
 static inline void cvmx_pow_work_request_async_nocheck(int scr_addr,
-						       cvmx_pow_wait_t wait)
+						       enum cvmx_pow_wait wait)
 { }
 
 static inline void cvmx_pow_work_request_async(int scr_addr,
-					       cvmx_pow_wait_t wait)
+					       enum cvmx_pow_wait wait)
 { }
 
 static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
@@ -1356,7 +1356,7 @@ static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
 	return wqe;
 }
 
-static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
+static inline struct cvmx_wqe *cvmx_pow_work_request_sync(enum cvmx_pow_wait wait)
 {
 	return (void *)(unsigned long)wait;
 }
-- 
2.39.3

