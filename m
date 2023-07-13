Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACF7751C44
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbjGMIvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbjGMIum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:50:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20722.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::722])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6083F26B3;
        Thu, 13 Jul 2023 01:50:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBqNZahS7JMTsq0ax/T1Chq5GBdLtVLKyuOs/nM6W5ye7IcbZ9Y4r/+JEkGW6SRwSMsJ+9SgGGCHoOrnY0t/dGUdJaEt5KJ9MGn4hV6dLAq/iiFLtak+IaHDBUiOxJSSH5KCsyhFyU1zjYoQOWiT2H948M6xVoxvpGXnHKF2+f1Ruqr47vDs1GjVs8uId2Rt78dYKq81RENnuKbZYLoXwF94ako9nvkt4o06wZLYOLz8hdg22/r5yS9jUS7rq8qLDkWXL3LbOFCjx661p/WCgFfg64R7EQMs8aZXKXeTSQlD9hbTKCRRg9prG5G+36cS2x9p8NjbK8cOLeE2KhIaBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMbZXWsFsmjuDsEnYynJV4gWeWcmt23yIrtyCK7OUx0=;
 b=RNqx4+YpGzws8MWjuw0c9tMnLoTzbDng+tc168mX9TqnruLjAyn9hgnSwE86IckYXrgrkOZWgWFa1knV1HnHKMXaxJE7aEJqo9T9EuMZMTqP9UfYqsvobeaPiZbjmc0mYcgnbMPyq7UCjtBiSgwWcuLcutfEG+DnsWcPE0YX76pDMgo0150K7XcsenIhNG/22137GI95cAoYsXq9S0+Cdsu2nR9iwHtljnOELWn0Cf/a4hWxDL5QqqqLtNwLb03omyWy9BQDBG29sw///VpksCPwoBOT8GTBqTWh7w2eSYsFOWWQTSxt7fmLiCqXKnx8nLsXlj5xZCvPMpbF48phdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMbZXWsFsmjuDsEnYynJV4gWeWcmt23yIrtyCK7OUx0=;
 b=o1gh7sr25CWiGDrqHHMk/ADpYNF9hq9fNGQfID/s4cXb7YSucRN2DIZ+ZWF0vKUF4x+7Dqqd+YHQdKDxRglPwFW23UU/CAn6EHPsA9HwGgkeZ+2N/0YZw2A4U/WQTlZNmsGB3J1rnpkFl1d5RyNnmj2P+qMGd1yD5WMrfb2Se78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB4889.namprd13.prod.outlook.com (2603:10b6:510:98::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 08:50:30 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 08:50:29 +0000
Date:   Thu, 13 Jul 2023 09:50:21 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     "Anwar, Md Danish" <a0501179@ti.com>
Cc:     MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [EXTERNAL] Re: [PATCH v8 2/2] net: ti: icssg-prueth: Add ICSSG
 ethernet driver
Message-ID: <ZK+6zVnUSJG5GKd4@corigine.com>
References: <20230710053550.89160-1-danishanwar@ti.com>
 <20230710053550.89160-3-danishanwar@ti.com>
 <ZK2VRYwW8DxIZCY2@corigine.com>
 <afbd4c9d-5ff7-e366-f866-6b718907d6fa@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afbd4c9d-5ff7-e366-f866-6b718907d6fa@ti.com>
X-ClientProxiedBy: LO4P123CA0598.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::22) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB4889:EE_
X-MS-Office365-Filtering-Correlation-Id: 560da080-40e2-4ab0-9466-08db837e3571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVX5V4qN1BeCuHmK3B3rL4HCUlnT1ya6lSrlX9OsAf4SSFd0NYwBokap2gPRddtD7KzKSewtRx4numerERXZDu6OuANk8gyQ9hIIG8C5ho6ScYDtZK9xvdc/iIk+Ecg+CTT79LAm/Hk3zxZYHoBABBRZgvvXJQ3RxESg+zx5JCrvyuxsCnJkNyLvCeJikDRc6woEKSLgIntikSRHpXkC9THLOuGbCSvY4xg0XgaFnVntrYUV+9pFVPgDPyfmOyV8mTlKApPVGXDZiRP78Ch9JFsNGs/xERuCbg+b6xLRx84zyjg+u3lEi1777Wwt/LbJDqYulply4GV+dck7W+C+MLpS3SEcEl3aVSlZ6tPzSRjEQtXta5L0jeTToEPZbRowoMqblubJl9BC1ChlWsME/RaMnPLlYTuhrOdN9nQ9jquf9bc5pCkO/fydxzg8D85rrgBAtJ1ulI8EJEoK7Mk0YcTf3HGyN970wLnSpa+lfZSNXPqatRskOP22vkQLsJsJagDtJ2Ni3WVVW5qCdylTOboo5R6Go0rV8e/K5n36DXViXyCI86WnF1C5mgAL4smrCMzu/Ye8F4Ly9X0uS1g5cx16/7EbW+gLyeDu5zcYpet7PGj7PhRmyWwbCGOPRwI627viFUfh3crfDsUZvoySn40rYoFNkMHVBLjTN0bPGws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39840400004)(346002)(376002)(451199021)(6512007)(6916009)(4326008)(66476007)(66556008)(66946007)(38100700002)(86362001)(186003)(26005)(6506007)(2616005)(53546011)(83380400001)(36756003)(478600001)(54906003)(41300700001)(8676002)(8936002)(44832011)(7416002)(6486002)(6666004)(2906002)(316002)(5660300002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?25KscmT1ItaBOe17nCTV6Og4118Iw72uCs+aWxm78q3MJ4+K+fNL0nuPCUsG?=
 =?us-ascii?Q?nxoVJatFW13O2WHI1Y30NpoPbxL05BS8kqfi+8759ut8MQOuQD2wWyAhLu6d?=
 =?us-ascii?Q?SQeKvNdbOAccyr0RL+2L72UO2PzZ4gEwlpti4qfyn5Mm8Vw9uM83UPm+kncP?=
 =?us-ascii?Q?gKzoaItFCsvNRig2uYVQSF397pTcx1MD8MiJ2ijtUuelONEO2smWuev9yWeR?=
 =?us-ascii?Q?OsdxpVpI1AYxTIRuX6daeUdaC+kI2HOCBMrIvIwYfqw/3QTwo0+F3ygtjta3?=
 =?us-ascii?Q?2urgeWxqS8L73TD4zaMv6ru29hP9yMQDrxcZNXc8F3pMcPSPhjq86dzmvU6s?=
 =?us-ascii?Q?vIiL119xx2kIn4Oz52KoMzziXVzxmGOQt/hwSuScM7aZZCigLLVqmZVR03rH?=
 =?us-ascii?Q?okUxeqx64Iojskdax65g1pP+2UlZBBSBnubZ0VJXcr+aaI2jl/j0b7Ki9gqs?=
 =?us-ascii?Q?HwyGNQ3w4RbBizBoV+PY2TL+3/uQ+3ZBOCzFyRIe6hpSl96mbjJoH2RPfyh2?=
 =?us-ascii?Q?RqAUZqtF2oyJ4OleMlUQg8OsWkkexeNK6Wk6AFwqX/4jR9ZSEjI8F0PVvBBo?=
 =?us-ascii?Q?tccVMW/6i6nir+AWdRhNG+n6JQ4xsf1NDQgT7UY4JlcYkXoF1wqYbrxbB15K?=
 =?us-ascii?Q?A3xp8DcLrWmsf5/0rmS9HPvlebIerpENGza76lGtECmeyYTZtJ5bZh/Bq2/t?=
 =?us-ascii?Q?XUZbWSnxCUF/Lw8IwEnaicM+bxC1RZT+qLe+qJfdI2DJCZ3eC7fLkIiE4Owg?=
 =?us-ascii?Q?FenjLIvu39tVS/hsHUxE/UlhzaadXI6PY7alYxFcw7+JQB4OHnP5qzuqTDX1?=
 =?us-ascii?Q?aS3ghIoDbjWcW2AqyFKamIhZ7uMunEtZmQ+hITVaLqt37hepqCq1kOLWf2u0?=
 =?us-ascii?Q?+JsfYZBYPMJo2M5Dcgt8HUkOxyuS9Dtcd2TJLqLQ5jmGilCaSBsQFkfxD4xW?=
 =?us-ascii?Q?BfbyCNBDhgkphyjFVq2wjFzAc0VVqBVt+zYyB787KFqx3mCYT3p6wHtQrkAH?=
 =?us-ascii?Q?Xr2UrTQuu1IYri1MuA5u4Zl0W/iHroQ0jRH21+iPyVE5L54mrFP1KRfXFci0?=
 =?us-ascii?Q?1Vn2nrzMq0vjP1Dtz8YUjJQ/tsOHI06Obuu+DDzrefYlhy+FJWJsOq9++oGs?=
 =?us-ascii?Q?np6IIw1Pr1ObP60qtU6ztV232qbuslihhV5r6w8IN6HhQp0lKnCrgI9pKxYt?=
 =?us-ascii?Q?aaJyCObtYUn45SqRge2YS451Eraw9HXeSOH55av9M5jRJiVRLdTAlTOkF/sv?=
 =?us-ascii?Q?UKxS5V6Vhd4wDBbeaD6XxP5eVDobeP/tYYPmNcRNDapGB0FOxV+5tHLWZR5B?=
 =?us-ascii?Q?iDcF19HIJYWnzqVXA6bYvvPhEOsw2sbS21U2v0DugkBnovoGxK0xhXJFVct+?=
 =?us-ascii?Q?B2WuFjAVfgApJ3dUnPeGZegM9HbyxRhsdcKIEHvv4zBZ5bsYjW9fXp1/OrXd?=
 =?us-ascii?Q?bm/WTj/XVgmo+ai1YwX/dn/+XEYsk4xj8C7G1NqW309ZpdUURmrbxvlxmckD?=
 =?us-ascii?Q?orUh/uVrEpLayGPc2ijqh9s5kC5RmIpqPYOxEvd/IDJRmteiFdML/o1vBenm?=
 =?us-ascii?Q?SiV6yrBh84kERvUiOdmXVUHKOlfnuFyKuDtTBotWKQSjsrsCbelFyi0AB3TO?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560da080-40e2-4ab0-9466-08db837e3571
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:50:29.0436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYwxpNI++GnlZutaPgy938ouVH1Kfpc/42yWyeXp1VMaoShAUmbFOda4MKTJBVOufD85xXAUR+f18pyCDz2Y52ZS24b0UTAg5+hqTN7UNyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4889
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anwar,

On Wed, Jul 12, 2023 at 05:55:57PM +0530, Anwar, Md Danish wrote:
> Hi Simon
> On 7/11/2023 11:15 PM, Simon Horman wrote:
> > On Mon, Jul 10, 2023 at 11:05:50AM +0530, MD Danish Anwar wrote:
> > > From: Roger Quadros <rogerq@ti.com>

...

> > > +static void icssg_miig_queues_init(struct prueth *prueth, int slice)
> > > +{
> > > +	struct regmap *miig_rt = prueth->miig_rt;
> > > +	void __iomem *smem = prueth->shram.va;
> > > +	u8 pd[ICSSG_SPECIAL_PD_SIZE];
> > > +	int queue = 0, i, j;
> > > +	u32 *pdword;
> > > +
> > > +	/* reset hwqueues */
> > > +	if (slice)
> > > +		queue = ICSSG_NUM_TX_QUEUES;
> > > +
> > > +	for (i = 0; i < ICSSG_NUM_TX_QUEUES; i++) {
> > > +		regmap_write(miig_rt, ICSSG_QUEUE_RESET_OFFSET, queue);
> > > +		queue++;
> > > +	}
> > > +
> > > +	queue = slice ? RECYCLE_Q_SLICE1 : RECYCLE_Q_SLICE0;
> > > +	regmap_write(miig_rt, ICSSG_QUEUE_RESET_OFFSET, queue);
> > > +
> > > +	for (i = 0; i < ICSSG_NUM_OTHER_QUEUES; i++) {
> > > +		regmap_write(miig_rt, ICSSG_QUEUE_RESET_OFFSET,
> > > +			     hwq_map[slice][i].queue);
> > > +	}
> > > +
> > > +	/* initialize packet descriptors in SMEM */
> > > +	/* push pakcet descriptors to hwqueues */
> > > +
> > > +	pdword = (u32 *)pd;
> > > +	for (j = 0; j < ICSSG_NUM_OTHER_QUEUES; j++) {
> > > +		const struct map *mp;
> > > +		int pd_size, num_pds;
> > > +		u32 pdaddr;
> > > +
> > > +		mp = &hwq_map[slice][j];
> > > +		if (mp->special) {
> > > +			pd_size = ICSSG_SPECIAL_PD_SIZE;
> > > +			num_pds = ICSSG_NUM_SPECIAL_PDS;
> > > +		} else	{
> > > +			pd_size = ICSSG_NORMAL_PD_SIZE;
> > > +			num_pds = ICSSG_NUM_NORMAL_PDS;
> > > +		}
> > > +
> > > +		for (i = 0; i < num_pds; i++) {
> > > +			memset(pd, 0, pd_size);
> > > +
> > > +			pdword[0] &= cpu_to_le32(ICSSG_FLAG_MASK);
> > > +			pdword[0] |= cpu_to_le32(mp->flags);
> > 
> > Sparse warns that the endieness of pdword is not le32.
> 
> I will fix this.

Thanks.

> > There are also other sparse warnings added by this patch.
> > Please look over them.
> 
> There is one more warning for "expected restricted __le16 [usertype]
> rx_base_flow got restricted __le32 [usertype]". I will fix this as well.

I haven't looked carefully through these.
But for the record, this is what Sparse tells me:

  .../icssg_config.c:91:18: warning: symbol 'hwq_map' was not declared. Should it be static?
  .../icssg_config.c:189:35: warning: invalid assignment: &=
  .../icssg_config.c:189:35:    left side has type unsigned int
  .../icssg_config.c:189:35:    right side has type restricted __le32
  .../icssg_config.c:190:35: warning: invalid assignment: |=
  .../icssg_config.c:190:35:    left side has type unsigned int
  .../icssg_config.c:190:35:    right side has type restricted __le32
  .../icssg_config.c:225:11: warning: incorrect type in assignment (different address spaces)
  .../icssg_config.c:225:11:    expected struct icssg_r30_cmd *p
  .../icssg_config.c:225:11:    got void [noderef] __iomem *
  .../icssg_config.c:228:42: warning: incorrect type in argument 2 (different address spaces)
  .../icssg_config.c:228:42:    expected void volatile [noderef] __iomem *addr
  .../icssg_config.c:228:42:    got unsigned int *
  .../icssg_config.c:237:11: warning: incorrect type in assignment (different address spaces)
  .../icssg_config.c:237:11:    expected struct icssg_r30_cmd const *p
  .../icssg_config.c:237:11:    got void [noderef] __iomem *
  .../icssg_config.c:240:36: warning: incorrect type in argument 1 (different address spaces)
  .../icssg_config.c:240:36:    expected void const volatile [noderef] __iomem *addr
  .../icssg_config.c:240:36:    got unsigned int const *
  .../icssg_config.c:270:19: warning: incorrect type in assignment (different address spaces)
  .../icssg_config.c:270:19:    expected struct icssg_buffer_pool_cfg *bpool_cfg
  .../icssg_config.c:270:19:    got void [noderef] __iomem *
  .../icssg_config.c:289:17: warning: incorrect type in assignment (different address spaces)
  .../icssg_config.c:289:17:    expected struct icssg_rxq_ctx *rxq_ctx
  .../icssg_config.c:289:17:    got void [noderef] __iomem *
  .../icssg_config.c:297:17: warning: incorrect type in assignment (different address spaces)
  .../icssg_config.c:297:17:    expected struct icssg_rxq_ctx *rxq_ctx
  .../icssg_config.c:297:17:    got void [noderef] __iomem *
  .../icssg_config.c:325:38: warning: incorrect type in initializer (different address spaces)
  .../icssg_config.c:325:38:    expected void *config
  .../icssg_config.c:325:38:    got void [noderef] __iomem *
  .../icssg_config.c:332:19: warning: incorrect type in argument 1 (different address spaces)
  .../icssg_config.c:332:19:    expected void volatile [noderef] __iomem *
  .../icssg_config.c:332:19:    got void *config
  .../icssg_config.c:361:32: warning: incorrect type in assignment (different base types)
  .../icssg_config.c:361:32:    expected restricted __le16 [usertype] rx_base_flow
  .../icssg_config.c:361:32:    got restricted __le32 [usertype]
  .../icssg_config.c:406:11: warning: incorrect type in assignment (different address spaces)
  .../icssg_config.c:406:11:    expected struct icssg_r30_cmd *p
  .../icssg_config.c:406:11:    got void [noderef] __iomem *
  .../icssg_config.c:417:61: warning: incorrect type in argument 2 (different address spaces)
  .../icssg_config.c:417:61:    expected void volatile [noderef] __iomem *addr
  .../icssg_config.c:417:61:    got unsigned int *
  .../icssg_prueth.c:1665:9: warning: incorrect type in argument 1 (different address spaces)
  .../icssg_prueth.c:1665:9:    expected void const *
  .../icssg_prueth.c:1665:9:    got void [noderef] __iomem *va
  .../icssg_prueth.c:1665:9: warning: incorrect type in argument 1 (different address spaces)
  .../icssg_prueth.c:1665:9:    expected void const *
  .../icssg_prueth.c:1665:9:    got void [noderef] __iomem *va
  .../icssg_prueth.c:1665:9: warning: incorrect type in argument 1 (different address spaces)
  .../icssg_prueth.c:1665:9:    expected void *
  .../icssg_prueth.c:1665:9:    got void [noderef] __iomem *va

> There is one more sparse warning "warning: symbol 'icssg_ethtool_ops' was
> not declared. Should it be static?". This should be ignored as no need to
> change 'icssg_ethtool_ops' to static as this is decalred in icssg_ethtool.c
> and used in icssg_prueth.c

I think the preferred approach there would be to declare the symbol
in a header file that is available to both .c files.

...

> > > +	prueth->dev = dev;
> > > +	eth_ports_node = of_get_child_by_name(np, "ethernet-ports");
> > > +	if (!eth_ports_node)
> > > +		return -ENOENT;
> > > +
> > > +	for_each_child_of_node(eth_ports_node, eth_node) {
> > > +		u32 reg;
> > > +
> > > +		if (strcmp(eth_node->name, "port"))
> > > +			continue;
> > > +		ret = of_property_read_u32(eth_node, "reg", &reg);
> > > +		if (ret < 0) {
> > > +			dev_err(dev, "%pOF error reading port_id %d\n",
> > > +				eth_node, ret);
> > > +		}
> > > +
> > > +		of_node_get(eth_node);
> > > +
> > > +		if (reg == 0) {
> > > +			eth0_node = eth_node;
> > > +			if (!of_device_is_available(eth0_node)) {
> > > +				of_node_put(eth0_node);
> > > +				eth0_node = NULL;
> > > +			}
> > > +		} else if (reg == 1) {
> > > +			eth1_node = eth_node;
> > > +			if (!of_device_is_available(eth1_node)) {
> > > +				of_node_put(eth1_node);
> > > +				eth1_node = NULL;
> > > +			}
> > > +		} else {
> > > +			dev_err(dev, "port reg should be 0 or 1\n");
> > 
> > Should this be treated as an error and either return or goto an
> > unwind path?
> > 
> 
> I don't think we should error out or return to any goto label here. Here we
> are checking 'reg' property in all available ports. If reg=0, we assign the
> node to eth0_node. If reg=1, we assign the node to eth1_node. If the reg is
> neither 0 nor 1, we will just keep looking through other available ports,
> instead of returning error. We will eventually look through all available
> nodes.
> 
> Once we come out of the for loop, we should at least have one node with reg
> property being either 0 or 1. If no node had reg as 0 or 1, both eth0_node
> and eth1_node will be NULL, then we will error out with -ENODEV error by
> below if check.
> 
> if (!eth0_node && !eth1_node) {
> 	dev_err(dev, "neither port0 nor port1 node available\n");
> 	return -ENODEV;
> }

Thanks, that makes sense to me.

> > > +		}
> > > +	}
> > > +
> > > +	of_node_put(eth_ports_node);
> > > +
> > > +	/* At least one node must be present and available else we fail */
> > > +	if (!eth0_node && !eth1_node) {
> > 
> > Smatch warns that eth0_node and eth1_node may be uninitialised here.
> > 
> 
> Sure, I will initialise eth0_node and eth1_node as NULL.

Thanks.

...
