Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23FD78B224
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjH1Nkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjH1NkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:40:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2044.outbound.protection.outlook.com [40.92.19.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF407B0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:40:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmwsLzPbxNI7SbVoGTbhMW1fcxju1FAaMxuVUv2Q5GIgELrP8pcxzDeidJz+QbD+NAJppadtOvRBWI0C8D95kFAT9gwjn9JijDszn/7lmR7RlrJoUdi9kNN9/VR84bwnrnTfN9ayJ3WEe9Q863m9w+LrxNXWomZGNfvEY0PJoSRydJX0tCvOLvGiQ2orhYSgTujufq6JmbmVnthbQXzFQ8poMmOWWWc6VHA7NamOkZZl8apv5/UHwPmGBpsYsWhL1APsMk+he1MULK7f+Me7oDp6saqDWw2L6yfp0slQiCnp59wNTYeTSIPy4ZqZwTIlYARZMkD6qIPNTFS6+pk5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hn69V79SOUQHhXoiSJ9I/wSOI0ikr8NuuZiGEyLuBY=;
 b=NkMCXupTJf4/Dq4MhfjmHZej4k3hu+iwOjZ9RnRr0btDvEX1+SdTi6Dd7TVN4rz335yqmA06x9dO60YRYHNf+1TRnR89f4F0uayK1lLqLIpZC3msjlBguHA3VasBGD0u7U/Uw6uIHKacy6pOa4QHLdfR04H03/FZS3ZJR8H0DzBtWS3i4+MTNC+ZXrX/E8MIree+jPwqhhQY0qPvMVF6ONOOvhW5yg6T4VXN0qxAGWOXuTcpNrMcYkcpqGdEpLeZWtu24W386TXN4sSEcIs2LpEw9ZvxaqnIFmObyONH53zkMPN4b3pyhLE9BWQBm9FRCJzS0vG+4cwGj4zR9G2clw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hn69V79SOUQHhXoiSJ9I/wSOI0ikr8NuuZiGEyLuBY=;
 b=cVPtZH01N6/wYAXFcW03L+kh7sBM8VFLkcfV6/O5BrRNCG8wAQbdRC7agJpJzK9DSilwuGqKrc4jMNoCiB3MUxLgNA8u/SvgkY9FGLEM006y8+xuRhZLmIVmyffpc+SV5C3Nhmj05eHTJQuGw+OGby4jXNN9fuPo3SRuVVNbjadHcHpGdQ5wDx7uQ00qga47MmSPi8MbyTAZO8yy0aApy/eAXtvWZlIci6rPVIzTuWhrPf1wFzLpEcMJMvGLW3e0nAC/cdC9svIVClF3sApU59JwwT8lXajDfYoIr1G+ifrp1oVloCz2zlJWcV3McACdsgqBmubUtlvrT43itRNTqQ==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by CH3PR11MB8773.namprd11.prod.outlook.com (2603:10b6:610:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 13:40:19 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 13:40:19 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v4 6/6] staging: octeon: clean up the octeon ethernet driver
Date:   Mon, 28 Aug 2023 09:39:19 -0400
Message-ID: <PH7PR11MB7643E52AF72688CEFDA4DAFABCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693229582.git.ozlinux@hotmail.com>
References: <cover.1693229582.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Wcj4upEAaSx8vgGVScVMhJC4XSCAKy71u+cW44KtJgVbdtr7bqUGZ6/VtgtmoPYh]
X-ClientProxiedBy: MN2PR19CA0008.namprd19.prod.outlook.com
 (2603:10b6:208:178::21) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <5f5e9ee60edff26fbf12c47928943699509272c0.1693229582.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|CH3PR11MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: ee372cae-cb68-483e-ba3d-08dba7cc51bd
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmr1VCrDDYJl/lCLgD1Tr5zrrErctzovFMAyPOmh8m/0VDJhwbEeVYnckXHZD6tHeBrmWmvCGrx+BD55OYNf1IKp8rr62kGMYGNxMPyfuIPI7TY4cSblf/e3m2NUe+ApGbfpGfJmTYvuu/RKIL/uAqD+GJQGCB0rSbIjNQaHpapmsabBFiMfDQOMw9KV0b0PqbwyIIp72AY79oaypUBXCS9KUsVKALXRikirk6Cadn3Te9rM4YS22jDhf20hxuofRCVBgkXGLukg/zR/Q7WOU2abdNd7c2Txi1PGMx7moNLXZhNl3yCXTw+MD8/cx6I1s5Rd03fzDdSZc2rQm7X8JKWUWUIOx5aebSYiWDllrZrXP3603RcSm/JwZNQzBnkb3GrBpPvg2foJbxRNRyoJ9KPej8YVW60sCQxDUGIc3sTjtG8MkWaaBjxVolPHUwHGJYqT/G/UD+ktK5BA7lPfFvtLNxu95qIL+++ZDC1KDpYfoMopl/g2NRA6UhnwfxT5mlKFOPNgMEX/GnPjZovckehiODkJ88SoGrfJ9OA3KRDPeezxgoi6buXQqBSD3Vp9fBRrTS5p0RDswS7ytntRsj9YJy92tMIhvQq5Q3LhfyWq79M4PjYXqScio1mqQYM8vVod9WI4u3TT4ve/YDs++lhb6H1lGfogksQzFpxQQcpqunG3bRMCazrzr5UEhrMf0V2kjw9crc20ezDT+tsw/2FyOVDQpuqLU/3dUk+6OocSU38POhYJD1yiZosAbApgO0M=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5d07+gccOpWkD7979oPFuo56m8e3ypccGTuygZou4pottV3JcF2EiT3TQGEGQIaRcMB9MZa09T2Cr5bBnblRuO8gr6rmLfWSf36TsTBWlrcRyvEN9j/Jy3012S5XdCTG4cjbxcQ/9XEt2xCi3joEVRqOI6EpJ69c7OgiWL3jQXizPQxtBCztectgpcFyifUezHMjHV/y2uERYqZleEK9OlGbgNPo3yY1t/iMWyUTJW+p+BwSI0CD4b2NRBiLRg+EcZVmJaXKv8bllUjbudlPCJWwZkSmwsKqfKy7DfQ+5zx6T5fKyZlIglZldHoP6RISD489ZjsReEoBK/yhCHYuDUTtjj5DugcWpv94hfh/06rxQKp6Wn59Gzi5kT6ag454HCR3vqAZEDDcYAaQjW+aeYRM1fBz8hIPBP7dfBlG5PJeqbin9ZW/fR0mTU4aSjq6740OW+gWxVr2K2RW0CgHUQ1zYjyi2Rz70bw1Evy6FADIwalyr+dD9164cakQ+f8RHS5VTKgU/ZjqO2iX2spDj8g/o2m2tOzCUc2osqK+VGpT2AtFaDTC6Z2yBQIs4jG3TGoA2PXil4FnakIce1ebOY3Fcxu+kRipn+vYJHmpnUjwtjl59qRhztQCQ265+JXn
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yA/Ztdf9rrV6G7IQJdKCBFkJ/3B/vumrEpGF4aRb/X1lL6q/2nIuUH46wWJJ?=
 =?us-ascii?Q?8v3ljd088Px4+Mc6/nB8hSu/jceMrpRd8Hqq0r3WafM+Fw8JohKxFihkKz2V?=
 =?us-ascii?Q?Egc3tZ2Ll1FDtG5eDGMcKD1SPTMvmoQtKMZ/PZXRY1FIJ217VqtbfU0wtrr7?=
 =?us-ascii?Q?g3iVrKatcK3vQYxvwLLkYQQT2wBoc7b2NNIcYGtyHm2L77WnNPdphNnyAmFM?=
 =?us-ascii?Q?4POWuV6fo0eVry5qRhNz/KnWnRrbV6lxvcq+DkGkeVmIXKn23qW4d188ns9m?=
 =?us-ascii?Q?bgllVMQabluHucqoV7iozDuu/BDpDA29ZNEu23GMhVnryFmEgKJDWCBqq/h7?=
 =?us-ascii?Q?03v5ug1u7MVNF27bAsrhrm4q9c6ta4x4fRvLErzajDIqCAnz+Yvn0hKCs0OV?=
 =?us-ascii?Q?sxPoeHkD1bsj6lZtNUOwModGsHlGJKRSXwhJNO7uInrFc8OB3wNv6ZrBDct2?=
 =?us-ascii?Q?j5r8fSgCGgwgMlavrdBnjjpZO7CEx0pCZ1evwcp99Mn6EVG93Q3MsC9Ehgon?=
 =?us-ascii?Q?+YYDonk2097Ja6+xa62t/w2/0I7h4NyIQ25+Xe749IGVI3+vr5KcFbG3ih5I?=
 =?us-ascii?Q?YLtv7xQOEjA0mJdOd7GLNPxT6vnBj5gijon4InD5iJ12oGBwu74JY+Ar6sfg?=
 =?us-ascii?Q?VtMvWNJoTqsLc0kFJ7QXPYnS7mnyxL/+CTgErO5ZA2QmJFV9ijzDIx4tHgww?=
 =?us-ascii?Q?jSUzreR7cW84F/cgEKiaNVLpRg7WfSqa0C+p7i648if23410Fe9Y/yulc3Na?=
 =?us-ascii?Q?YFTdudT87BwXZWN5+uYFqFTWoekKnj/Jl1HSwAnz4ZT+A9NLsWyHi3qxBDQh?=
 =?us-ascii?Q?fpBYsjVtv1RaEdllrqpDkHxqPLAeqqccXIoxCfqcrTfUfxBOFlpUura8C5uz?=
 =?us-ascii?Q?z3DrYXQa3MGVvcLHu/0DLrDdXu/ZVa2t+x4+lxmeteCVUlSZawbwJhYV/+UM?=
 =?us-ascii?Q?T6fcLsOHv/Bh1Lzh6TPQP7l5vr6NFPB5jVQ+QOl/FjrLWWM+H/HU4etT+cbr?=
 =?us-ascii?Q?46dGG1WsbGJ9fo65+M3JVmNwrW2DQiQNwjEUW1Gh2YoQ1u77X4reZWcpw9N0?=
 =?us-ascii?Q?4Dxz/E2eNvr6G8X9qHh+wCY7nYUFUOljxFzNGEMhr50fG73zpP9W/UqCh5LZ?=
 =?us-ascii?Q?KMpBT3AEA59GvL3i1kcrTkzcQDxtWaRr6qQgsLhGd8HQbzTS5l58QVaKenNO?=
 =?us-ascii?Q?ibzQztKjLk4Vhhlg0HrJTdKF27ZejBplMcsHtBYLdJm+f8yRPP63IcVe9meU?=
 =?us-ascii?Q?HmuWchBQwKzsexxW9iG/BS6Ph8WbCy2xMmHSthZf/g=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ee372cae-cb68-483e-ba3d-08dba7cc51bd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 13:40:19.2984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8773
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
v3: Fixed a bug where I forgot to change all instances of a struct
v4: Actually fix that bug (this is my first patch, give me a break)

 drivers/staging/octeon/ethernet.c     |  4 ++--
 drivers/staging/octeon/octeon-stubs.h | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 023b107e077a..8e1f4b987a25 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -201,8 +201,8 @@ EXPORT_SYMBOL(cvm_oct_free_work);
  */
 static struct net_device_stats *cvm_oct_common_get_stats(struct net_device *dev)
 {
-	cvmx_pip_port_status_t rx_status;
-	cvmx_pko_port_status_t tx_status;
+	struct cvmx_pip_port_status rx_status;
+	struct cvmx_pko_port_status tx_status;
 	struct octeon_ethernet *priv = netdev_priv(dev);
 
 	if (priv->port < CVMX_PIP_NUM_INPUT_PORTS) {
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index b9852994882b..579c755cfdc0 100644
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
@@ -407,13 +407,13 @@ typedef struct {
 	uint32_t inb_packets;
 	uint64_t inb_octets;
 	uint16_t inb_errors;
-} cvmx_pip_port_status_t;
+};
 
-typedef struct {
+struct cvmx_pko_port_status {
 	uint32_t packets;
 	uint64_t octets;
 	uint64_t doorbell;
-} cvmx_pko_port_status_t;
+};
 
 union cvmx_pip_frm_len_chkx {
 	uint64_t u64;
@@ -1258,11 +1258,11 @@ static inline int octeon_is_simulation(void)
 }
 
 static inline void cvmx_pip_get_port_status(uint64_t port_num, uint64_t clear,
-					    cvmx_pip_port_status_t *status)
+					    struct cvmx_pip_port_status *status)
 { }
 
 static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
-					    cvmx_pko_port_status_t *status)
+					    struct cvmx_pko_port_status *status)
 { }
 
 static inline enum cvmx_helper_interface_mode cvmx_helper_interface_get_mode(int
-- 
2.39.3

