Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6647DF9EE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377123AbjKBSaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjKBS35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:29:57 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0F2128;
        Thu,  2 Nov 2023 11:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjbMGtTNEY2LRwkpT6ywGQNiQbCt7vaFomA78AyJfamBg3xPVjFGTCCkkrmw1VJTuq9znCrUrxZOiVKFoTsskRQXJWX56rVelN00MWgJeTdZrhPszz5J4HxwMAHkM8F1pCGZYDV+UkPRP6S7z3BNQ2O+/mrYTGFy/OQXMC/Mz2ntqAz4kENzfnFRSjoFLCOxPZNEcUnwyu+8lJdsit5ONKkcjxxkpgAgnoY/b49lnpTQWaPmET4EZLJNR0puT9xB3mT+8pqpsvX/xod4SgonW/Gu+dY0CRAXOSkKhQZQ+wvYuYEtbSN4EDB/+oWrrmb8fxbgjn8uN9+kThrVDimsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASKb/3rn8aYmShC1v65rDttMC3OqKENd0W/UHouoa/E=;
 b=KvjvSZ7KGJBDslPiNX5kc0U9+UzxQTnx+CXOucHg1hAs8TtqR6pBawJG2gckmpw9w55zEF1Aqz7g4xfJT/EMMn5QWLRl87drW/wTWc9sORWg+lKEpFGo/VYFVdD4o0Vu9SO9Wai/TUCyMEVl7M5lIYjvk+tbzuTeS7T9BYtByJjMbnwkj1jQ1oVBFXS+7va7cSSBEqz99+GfbBsooRr09pYv5Y4a3DC8yfVeehMCY46o28hdWJEmDP/54yMWllyC7vOznTIv3ry+vCDXgWwXpt/jaVYJ9Suzzi4Yqp/49MfTvYCzsPLlDtGmHx7CK1PI1x5+AgfPQZkzxH4rGKPM0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASKb/3rn8aYmShC1v65rDttMC3OqKENd0W/UHouoa/E=;
 b=Mewe3bziZe2Ilwzpwf/lV5v/4z74GiSKBo5E6cfx+tQs1A9WurrhSFRCg5zbtNqUUSU0JRtre8pYtm/CWPo584xYsDrAD/YuiCl6tBHZJBDXVo381rAKfPZtg0Q2yMMHXmoh1WFB9zzJk+/VfS8symakyesscM3U1FaeIwwo7Wk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8990.eurprd04.prod.outlook.com (2603:10a6:102:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 18:29:49 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098%7]) with mapi id 15.20.6954.017; Thu, 2 Nov 2023
 18:29:49 +0000
Date:   Thu, 2 Nov 2023 14:29:41 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bhelgaas@google.com, imx@lists.linux.dev, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lpieralisi@kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        robh@kernel.org, roy.zang@nxp.com
Subject: Re: [PATCH v3 4/4] PCI: layerscape: Add suspend/resume for ls1043a
Message-ID: <ZUPqlSMRLtvz129n@lizhi-Precision-Tower-5810>
References: <20231017193145.3198380-1-Frank.Li@nxp.com>
 <20231017193145.3198380-5-Frank.Li@nxp.com>
 <20231102173900.GF20943@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231102173900.GF20943@thinkpad>
X-ClientProxiedBy: SJ0PR05CA0196.namprd05.prod.outlook.com
 (2603:10b6:a03:330::21) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 9029b078-e562-4955-fe00-08dbdbd1b267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BoIjfGvfGeVRFBMcCQrdkBdCf5B4oayalsysT1zsTuMnKTD01Bi1h4Tns6FcJDQE5/SC3Oeql2+gzylZO+a3YZchy+1Vm07SxwjzMGdoZXzWSJJ9L1jaAhSLtNzZfF4yfTeCmxSQJ1VHhi0teLRWPmtXyzQ89JZ8F+wkBT8ykDCA9qvxG0uyW3swvOEoiHTOeItsYd3+gaIfj9wqfWkwZQDT5F5Vwm275km3daYuwcC+X1NHxc2SeoeGH4slgKcA5zd45IDWV1yi4cY8h1UMqpnhHqmS/D5FzBXqZFByV4X1TKc0GYk4w3ZL0xTzdpQSAAjdJ+95Y2R6BMN9p4Ut3EulHuz6D7KANrrnfPmSe0rt6qPLpsJZs9TNkpmdzeEDRwfYLhTkdIXLGrqW2BAZYZCK2GAf3CDlAjXsaNwo7i0iTRVKysSdy7m/7dYay+43xNyQJzvLKNVcPuEJG8AU+zQhZ73pJ3CsXANjugoD/AVBfrj8rqXs0n9phukXWIPaB0IEHzQ1GGwz+zZGHNjAKWo8MYcRGxi/DyzvyviuLsAXuNhBFPTt+1zJOasVlzODC6LaGmqnTPE7J+jYPEj6nVBc4noLGe8GTBpH21wvJhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(8936002)(8676002)(4326008)(83380400001)(26005)(33716001)(38100700002)(38350700005)(7416002)(86362001)(2906002)(15650500001)(5660300002)(41300700001)(6506007)(478600001)(52116002)(6512007)(9686003)(6666004)(66946007)(66556008)(66476007)(6486002)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWhrS0xIRWpFUng5bzFMMFJyZ0lDdzNoNCtSdlA2V2J2RUdrU2J3cUsxN0N2?=
 =?utf-8?B?b1M2NnJsN29xZmZVOUpVM3RFK29JdXZidEUreTAxWFRRdTJWVldYNnh6Y245?=
 =?utf-8?B?NE9UZWZHRzFrQitHRzFzNjgvSEtNcEExcUowWDhLdWJNV0dzeDF1ZFlWeGR6?=
 =?utf-8?B?Ym9TT0dhV3QzQnhWaEZTd0VBMlA4M3pEa2tPb1NoUnA0LytFdFZkMTdzcHZU?=
 =?utf-8?B?ZGNwbys2dnRFZWRrZkc2VzZQVTdFZWJRUncrV2lEU2xUVkdMdTB0UWRqejVO?=
 =?utf-8?B?ZS92UzI5Q0Q2MWlhYkVYQXhWZUtSVExwdTBHSktzZHh1bkRMelpuMUVyRTlW?=
 =?utf-8?B?NUJkelYvdzlpczBobEtNYy9nbzV5ekF4WUV2ZUt5UEZ3bWZ4SVhIVEN4RHpv?=
 =?utf-8?B?SHpJM0syWHZNckM2WTkybHRiVWtmNm1jU2MzV2VHL1hENG1ZZGtMSlVhWTNn?=
 =?utf-8?B?c2Z0QlpnOXBLRHU4TkhZa3JOeVNPQkNVdDJremZ2OEk3bUV3dVF2dzAyckhX?=
 =?utf-8?B?azIrODExbERUQm1wZGhBcHhuQ1lseFB4M2JEWk9MdXA1cnMveUowa0VYQU1Y?=
 =?utf-8?B?eFdtMTlmcC9IenBGU3NORjhDRzlUYmZmSVRpZkJtKzZyQ0xaakl1NVVseXJH?=
 =?utf-8?B?Z3NVai9rS1gybG5pRzdTKysxV25qRmpTZVp5YkJ6MklSSXJYTW1KNzBZcjZa?=
 =?utf-8?B?YUFSdS9kQmVaYi9Ja2pBR2h2WFhvVVBEU3JLOHc3dnd2aXExajlBc2UrNmhu?=
 =?utf-8?B?MmVHWVhnUHUzK3kxM3Q3ZHpBa09aaG5td2VVbDJFODVySk5YTjhyeFBHMGNr?=
 =?utf-8?B?Y1I3WXJlNVBEckdHejFaMVVUL05GTTBERzVKWEwyMFJEcWpya3FDSWtlaGts?=
 =?utf-8?B?VCtqVWRKcE1mVU04NzJYZVRvMUVkdzJwS0dzZTFSSjdYTUMvMjZRZGg3M3JW?=
 =?utf-8?B?Ly9WcndSbzBHWlVnaGZaRzFJcGdhaU1kV2w4VFVOTUZDUmo1ZHdyMzk5M2pQ?=
 =?utf-8?B?YlVuT0pJd3FzZGdMYnk3NzFITk9sRXBTcktwTEZyc29vK0VoREdTS3hGRTRV?=
 =?utf-8?B?LzZEaWl5cHVNSG1SbFZBdytDVU5XNGpYOHBrYWI3dGJNcmRsYURjSDFvcUQ0?=
 =?utf-8?B?c09QcFkxbzJyM2dydzE3dUtZSEdFK3JhNkhvekl0ekc3SGU0WEtQdGVmTGYr?=
 =?utf-8?B?RzJYTUtTYUM0TzFwR2w5cCtySGl5N2FBUzhjNzZheFRlb1VWUFFmZjlTLzBJ?=
 =?utf-8?B?UFdkazU2K1U2RGNEdmhTSkNGWGxIRkRHZ1dZazNGMlRNQ3h6YVVKd0RNcktL?=
 =?utf-8?B?WFRIa1huV1NiTlIrL1l1bmVTNk9NNlJwZ0RrRndhRzVDNVM4Tm1nSkxWVTgz?=
 =?utf-8?B?empRZlArSUJEeWtIMjJWWTlFaUFRVGxyQXpwVlJTVTBpSHRmZ1hxVEdrbEdY?=
 =?utf-8?B?UkkxNDdTTUh2akRtaks0bUlvRGpBZjF0OTkrSDVRckFHRk42UDNMR3RMMGJK?=
 =?utf-8?B?Rm5pSE5ORVVrdTZEUGlOUE1vUk9kaHY4Ym5ZV1IwUEpaSWd2aFQxVUxpdHVB?=
 =?utf-8?B?bVBkQ2hjSGdmMzZRaTZOUGdCWG1NR3V3TllldGRvK1RGNDR1Y1lEcUdIVlBE?=
 =?utf-8?B?SnJ6c0x2TzBzY3l3eWtBZnorOVo0QWFadTBUNjFNSlBmUDFFVlBmMUkyTkFx?=
 =?utf-8?B?dzBnY3YwZVU0UXZTUjEwVGdlU3FQdmVtM2pFc0tMcXhQdjlqYldRc1J1VDhO?=
 =?utf-8?B?a04xd25wOThSbS9QdExOY3BneVAvSlBZZUU2QVR6NWgxQktvcnhHRkxkVmVo?=
 =?utf-8?B?REJ0aHlrMUgzWVBEaGYwVlAzUWduVUtPeUxnaGFtN3k3ekFWcFRYa2UwRFg2?=
 =?utf-8?B?R0F2NldOQVhUUjI3cmF3NG5NTFpLSjRpR0JhTzhIdDZ2SmFlVFNZbU9BU201?=
 =?utf-8?B?QTlGeTIvRnlMclJFZENrcXozWkx5cWJCYk5ndXMvdlY1TEJObWFJMmh4cElJ?=
 =?utf-8?B?NENGRkNBckVUdXNYNnYwUllDWkxpaTM5QWVNdU5OdmJKczUwN3RzTS9KbWlw?=
 =?utf-8?B?WUxvLzFRVzkzdkhQN2pnTmRxeUJNQ3hqanR6cU5pNlNuS1VuR3FFMXdhRGNG?=
 =?utf-8?Q?9ufE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9029b078-e562-4955-fe00-08dbdbd1b267
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 18:29:49.2136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i19ynwNMgXUSTVZccEcm9rZzEpxb9m20hVarcEMltCuIbftPYdbHktSDjtN9eo6v5ayxlqDs1XY3rEsCJGpnVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8990
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 11:09:00PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Oct 17, 2023 at 03:31:45PM -0400, Frank Li wrote:
> > ls1043a add suspend/resume support.
> > Implement ls1043a_pcie_send_turnoff_msg() to send PME_Turn_Off message.
> > Implement ls1043a_pcie_exit_from_l2() to exit from L2 state.
> > 
> 
> Please use the suggestion I gave in patch 2/4.
> 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v2 to v3
> >     - Remove ls_pcie_lut_readl(writel) function
> >     
> >     Change from v1 to v2
> >     - Update subject 'a' to 'A'
> > 
> >  drivers/pci/controller/dwc/pci-layerscape.c | 86 ++++++++++++++++++++-
> >  1 file changed, 85 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> > index 4b663b20d8612..9656224960b0c 100644
> > --- a/drivers/pci/controller/dwc/pci-layerscape.c
> > +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> > @@ -41,6 +41,15 @@
> >  #define SCFG_PEXSFTRSTCR	0x190
> >  #define PEXSR(idx)		BIT(idx)
> >  
> > +/* LS1043A PEX PME control register */
> > +#define SCFG_PEXPMECR		0x144
> > +#define PEXPME(idx)		BIT(31 - (idx) * 4)
> > +
> > +/* LS1043A PEX LUT debug register */
> > +#define LS_PCIE_LDBG	0x7fc
> > +#define LDBG_SR		BIT(30)
> > +#define LDBG_WE		BIT(31)
> > +
> >  #define PCIE_IATU_NUM		6
> >  
> >  #define LS_PCIE_DRV_SCFG	BIT(0)
> > @@ -227,6 +236,68 @@ static int ls1021a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
> >  	return 0;
> >  }
> >  
> > +static void ls1043a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct ls_pcie *pcie = to_ls_pcie(pci);
> > +	u32 val;
> > +
> > +	if (!pcie->scfg) {
> > +		dev_dbg(pcie->pci->dev, "SYSCFG is NULL\n");
> > +		return;
> > +	}
> 
> Why scfg is optional for this SoC and not for the other one added in patch 2/4?

No, it is not optional for this SoC. This check can be removed as your
previous comments about 2/4.

> 
> > +
> > +	/* Send Turn_off message */
> > +	regmap_read(pcie->scfg, SCFG_PEXPMECR, &val);
> > +	val |= PEXPME(pcie->index);
> > +	regmap_write(pcie->scfg, SCFG_PEXPMECR, val);
> > +
> 
> In my previous review, I asked you to use a common function and just pass the
> offsets, as the sequence is same for both the SoCs. But you ignored it :/
> 

Sorry, I will fixed it at next version. 

> > +	/*
> > +	 * There is no specific register to check for PME_To_Ack from endpoint.
> > +	 * So on the safe side, wait for PCIE_PME_TO_L2_TIMEOUT_US.
> > +	 */
> > +	mdelay(PCIE_PME_TO_L2_TIMEOUT_US/1000);
> > +
> > +	/*
> > +	 * Layerscape hardware reference manual recommends clearing the PMXMTTURNOFF bit
> > +	 * to complete the PME_Turn_Off handshake.
> > +	 */
> > +	regmap_read(pcie->scfg, SCFG_PEXPMECR, &val);
> > +	val &= ~PEXPME(pcie->index);
> > +	regmap_write(pcie->scfg, SCFG_PEXPMECR, val);
> > +}
> > +
> > +static int ls1043a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct ls_pcie *pcie = to_ls_pcie(pci);
> > +	u32 val;
> > +
> > +	/*
> > +	 * Only way let PEX module exit L2 is do a software reset.
> 
> Same comment applies as patch 2/4.
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
