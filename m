Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CBC7E7315
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjKIUvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjKIUvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:51:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F9344A6;
        Thu,  9 Nov 2023 12:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699563103; x=1731099103;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=qQL6ukIuR94B3PPT5+OT+gY4jBfxzMu1TIUCX0/43oI=;
  b=Q2dCuSyd9K/1INZ3Irluil/KtTieQ3xkHHxlXPlaWURYKENlKpHb2L4T
   7ei/0pis8VZlul+w5W1BlXNpyVDrCQmXilJkYg+QzG7iT3sqmljO7jhbW
   gX/zH6GPdeZgSeARm5lhtCY1+9bo2kQ+hn9PHvHRO9HYb3dCnG7omLNH7
   0Y13vJsl6k7qfzhVsB77vN9UTHZwt9wo4sGaUbgr0OK9ZaBE/hVp9vL9I
   i46dWhEZgJL9eWwWlgwSpkoa46DG+Vj/H5B14E0+OMNRWL9Zwpy0Fanyh
   Znza0bOTJ+QGGIFMZaoTQBhtSylv7sHykv5U6NYXxugAC7y1C9bgBxune
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="389877498"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="389877498"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 12:51:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="4662111"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 12:51:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 12:51:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 12:51:42 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 12:51:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzig49iCWzuf5MJTu+xu1h46X6vbKe+NvlD9G5AIFkL/gpoWfkaYAfm9vqvz8DYHDeRdxj2p6wgMMLmrjM6aD4NndG1JGgKWkdwNzYHzHkQPxJIMwUCD9/V/kYxDePpPB7UPc1mvK3NU/nbFLpz7OjOzGHmI8k603L9idvZvFhwiwdlYFvo26MoOcuEDgfWzVbispWcLYsonfkoXcchlolsZUU5+5cyeynRqsn73UPQR4GIwCWNcq+17Piy+bFMGDwtbNZEzSHD8aUOwLxL1nSDDl4tV2dth7OILNRZQa26uEJKt8XdET3zDQEu0NqbMlf75ifEwhnCVw+SazffnSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEpBpRmrsEZLyKzp6aQVCwG/m2zbL/7R30a8qO8TssA=;
 b=nWlEnpNfQr+Um1ZYcABTR/2KWIKm5hsf86WsCuGIilvk3S0OIELki5cAD63qtRNlc7riae2CiO7fIwdt01sUgQMy+54mXl/xrsGvSsCwJBBNbi976AVbCXC2miCy5WaVcGYDrcthX+DP0b0vauvHeWrNZPpU3K9A7/tgXAevrMDkHHwlVtdvdESkh7L2eE8cKZSLtc3YdKFgN7Ev7MUllgvxqdBoyd/efdjXpHgQgbX4R8WrqHhMoPZKqXhoIWCWYds91kKsPBmd9GOKjYYBLcY3jEYYyUDcY1NkFGMEGmDQki/7ZtDP8ugF9/JRdebkCKNWfBaQdHiSJo1OZ2QvOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 9 Nov
 2023 20:51:40 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%6]) with mapi id 15.20.6954.021; Thu, 9 Nov 2023
 20:51:40 +0000
From:   Johnathan Mantey <johnathanx.mantey@intel.com>
To:     <netdev@vger.kernel.org>
CC:     <sam@mendozajonas.com>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <johnathanx.mantey@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net v2] ncsi: Revert NCSI link loss/gain commit
Date:   Thu, 9 Nov 2023 12:51:37 -0800
Message-ID: <20231109205137.819392-1-johnathanx.mantey@intel.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::25) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|MN0PR11MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0cda59-a0ca-467c-5ecf-08dbe165ac6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ag5YqGwB8DzqjJxgVRGR6wIwMUrR7PpGwpMoVsCFaa1ynrudskx0cuvTrA2Winjp1MrkaKY9hoPRq23+xkKxp4k0eQ0IGUfPxwh31rtaxG4HkmKo1jUu1w7gH7w/Lzju835BVQhH4IEnr7EVHyNcYdnYcEuuBzcs0x1n3xIQV7DPn98BKDLQy2MvW2ywbtytuEIYvCt7MhjbWn4PEuiICHMM1+T1/RrFiYKKIeYq0VYFJjadSOD9AMcGN+P8Q8HkXzrHvmtrTJkhdYJ3JgLZAjSeEWPh8lE4oeEo6vKZvZWufI8lMUhnG0GeBCvO+9fISvR4iOE4M8H2scjHp+hZoevp/oG7tJZVaFG2x8H2LHIhS4gacmMqAGsH7eiTeGxPXm5s9WivIpc9dA3cDsdsJxeOHcBOblsFFLsDa1QWsj+UaJsrdBH/Zt/n+RhhWR5einQMQC8XlK7xSfl46aNZaVo7sZMbDCJ4Y1jhmfhAlOVN1OJ9T5q4rA11rggMS2IA9OEeTGlIoUU3t/Gm0Orug2JFAK58T5afjYcUkULVt+j+4QpgoamvMh8Oi+gdnC6b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6916009)(26005)(1076003)(316002)(8936002)(8676002)(36756003)(6512007)(86362001)(6666004)(4326008)(2616005)(66946007)(6486002)(38100700002)(66556008)(66476007)(82960400001)(83380400001)(6506007)(5660300002)(478600001)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IlJNDy20XQ9EKhUg3MgaTvyGTebBDhnQP1D2mC1kEAnZDPMqt91MbAESzxi3?=
 =?us-ascii?Q?CKbrA7ObLmg5royRrupXJLp/qPHw4t7Y/Jt/sBlokrHmwE3SP1W8oX9pUp91?=
 =?us-ascii?Q?MKktn6h6AS6HnRN2QhyFEq06Vl0730zcLXCz1EBcjxc8Uo6PnUisSg1iCpDy?=
 =?us-ascii?Q?NqHCcJiTPeC8q9j1ghum+BqC3q9T6l1+Y3Bk129XM+mf3CFH02tURjEFEtrz?=
 =?us-ascii?Q?DsY14zSfhWy0Ta3O8xJ3RRWqwtRaLcQlipbCzAfODkTJ49QwIkZVHaeDbIRG?=
 =?us-ascii?Q?8cpz2f+HqmLC55J31nZ78+jYJVb78GyRzYwkXWx1ZHpt76+myd7U/3HKrdl2?=
 =?us-ascii?Q?uMkXL2/9LWCHJ6ZEGdfNlk3H1l8XvsVoJ4z6h1dzQZHRlRj/iIXNkkBCV12q?=
 =?us-ascii?Q?LAIufVcyNea/7Te/5Km0kyKJu5eObQnBPBiU/Ph00C7L8tM6seOPks4+zyTX?=
 =?us-ascii?Q?G4i+QStu6y+cDiJBzwRqBwl/NJxG/vChBJUedt9QJN1tm/yTsxzyKatHfHsA?=
 =?us-ascii?Q?RoD+yrar3R+KzaHypuaIuHgdcBJsNrIfe4gf3V9a1KdDzas4U9mQodoYZzRL?=
 =?us-ascii?Q?M+miNvTcQLSA2uEkigtN1O69MZxAC8BAEjn25tm5ofqWm4U5ah7+visKvBYJ?=
 =?us-ascii?Q?XF48TvIq8I5EG+05G9y2siya5o16Fpyw/0akUxxbMkn10sQ49wv1S4yahEgS?=
 =?us-ascii?Q?DVHRiWYWTrsNJ2SFQKUA54W1eGRK3mhcIpRzsEIWxtLyfAIUesvSp61LdjNy?=
 =?us-ascii?Q?Dulf3ORZKLf0fbuPIQdq2Kw9t7LcdzL+qSVHOznsSo9FCHjp7MOdiACt7Mqn?=
 =?us-ascii?Q?22RadryGs/1wCvCn4eWZOW//UUw0GzkzYOI4sEXJOpR/RxcODxkr/rXoF069?=
 =?us-ascii?Q?SbIc0bgtXftKI2gIdETLrMSH7hvMzthxn83DKpZIVvTs18SvYCdGpZY/KJMM?=
 =?us-ascii?Q?z7/rz5oiHEnG+Aaj9XYveqJww/RZGUnPbWLvw8Z1KbfFNnrRhXBMdYP0dqk0?=
 =?us-ascii?Q?wX1+d/r7tZXnN29+M1GAC9XDL0GS/7YoKp4iMBm1qdIF2EWE/30SnobSMwEJ?=
 =?us-ascii?Q?BR7ekfQrk7KbvIaCO9ymcOrhpwAX3Dpa+HHiifjwcm0pDSJvmqZFDSzGidHC?=
 =?us-ascii?Q?eqUVCsPE4f14OqcSUPk2kUwGU3uYg9TlrWN8NGRDLDZJyGHCkyYJZDkgYESg?=
 =?us-ascii?Q?v5FZLXY8qgc5pGwoR+MTRBKtkkFAAvwA9VjTCdxRGnmaBzWJQEcG7I7DxkiL?=
 =?us-ascii?Q?Ws3YHb1/LZGU8BI2OGSk8+TGh+EPOY7l36AnnCWZp3rPB+f1gR5RwEGZ6dAA?=
 =?us-ascii?Q?gQMp7P8cx993dIcJ8M+LDOCyvtQxlMEr/+gnggTyKrDa2YDgxZ2fJtwYb/lG?=
 =?us-ascii?Q?odORe+4EtzQPg8KKtlUtiGMt6WEmivYXKU57jC3phM3e+cgcJuPUtVsS+/XR?=
 =?us-ascii?Q?BK3Dk7GP4kVojKB2oH6zFE6x7uLQv6WH8gs5ciH9jDimU7I/3gh+RX0F4dtj?=
 =?us-ascii?Q?ew4ayL85bu32nerZku/J96rVG5OMpRiX20MyYF46gsxNISlthJJyj0U2Be8o?=
 =?us-ascii?Q?5fPCu7XOQAmW3NBMITDa1vAMyKnj1B6ijai21wrpAK3WYhw+f1EurVukhDcW?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0cda59-a0ca-467c-5ecf-08dbe165ac6a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:51:40.5905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DcClPHys8w+aMY/uCTrSM75k9dXmDov4/5AdalJVn0X23a6KHtCJPv6xO5x2rE1fWHl0tIHI4ui6Qj0Rac+PRRNsFd+lUF0QMjy7IwkE3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6206
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NCSI commit
ncsi: Propagate carrier gain/loss events to the NCSI controller
introduced unwanted behavior.

The intent for the commit was to be able to detect carrier loss/gain
for just the NIC connected to the BMC. The unwanted effect is a
carrier loss for auxiliary paths also causes the BMC to lose
carrier. The BMC never regains carrier despite the secondary NIC
regaining a link.

This change, when merged, needs to be backported to stable kernels.
5.4-stable, 5.10-stable, 5.15-stable, 6.1-stable, 6.5-stable

Fixes: 3780bb29311e ncsi: Propagate carrier gain/loss events to the
CC: stable@vger.kernel.org
Signed-off-by: Johnathan Mantey <johnathanx.mantey@intel.com>
---
 net/ncsi/ncsi-aen.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index f8854bff286c..62fb1031763d 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -89,11 +89,6 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 	if ((had_link == has_link) || chained)
 		return 0;
 
-	if (had_link)
-		netif_carrier_off(ndp->ndev.dev);
-	else
-		netif_carrier_on(ndp->ndev.dev);
-
 	if (!ndp->multi_package && !nc->package->multi_channel) {
 		if (had_link) {
 			ndp->flags |= NCSI_DEV_RESHUFFLE;
-- 
2.41.0

