Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72217BFEF2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjJJOSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjJJOSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:18:45 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362EE99;
        Tue, 10 Oct 2023 07:18:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1ivSOf6me8ZYbE5wmbZVZsZnfyukI7nUggq8ycOWgEfMNO+QtyXYu7rP0INAc3qGD5PyabCfOtylzQZrPRQqNI9pvC0BcTRrHQu9dTBJVv360+VEFiTwQnAa3+F/fh+OxwzLIH1aqHQ75U5Nw0abUXFwwUQY24I2VAEAbahlwWAmeVvOQ12jgr3A9j7Bw9TwJzSZfOMWiRYdFI2hCWmdGxv/P7QMFNEK7K1Nxe0g+QYH41ifv94h6b1w+MmMzvfCsc8m7F+bOLXyC9ZnETqvgh9YXl0EbiOwo4C19G/rxVTmk0g+xEjAeKXQYQXtrIrx/ufvAKWcAbeAOYFy9wUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZlpw69zicqEowQtJW+15gX/O0wULMciP7kT7FyNC3Q=;
 b=epATLZCOpf8JTO6FpVTDRCF3r1CN/aa08VxjtkE7BajPNsI60/E7+6jmURkqN0WZhCFnHzdyXELmmI2QWjBZvyPrarb4O5c9rV2lJaPrnUhsmNU4P/bXwGaOXfYW7cI2YRq2a6PU2PI+2Z3fgwvtnwihetBJneAzZ5TggKUSDVVtNZAASSiwnq2T6IvRMXHomvdYP+DOstfrl0Yy2WyZ0lEHNbKsOHZEwAtTy3lyci19E+KHE6CAivo7M7FAZEP/tz+HerskLsIrRfJB0FiQi4MM35Uy69MAS1F8rZqPv9Huu/HXq/cwzXC1melKMxz0HHmuXM8+2p3Ttv8v/5XS1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZlpw69zicqEowQtJW+15gX/O0wULMciP7kT7FyNC3Q=;
 b=EO4VAhaBZP9kHQ4Sku0GXA6WvK56nxmpu64lyu8k0oJiTFPR2mq5zg5CBmuIORohx806Vd6IUE973Mi478Ty0A6W7Tw7RlIqkYxQtl5NjxWoFtnHUeNNJ5/QDLdi19VagdCDR7HTuNLQj5GiYP+dsWBFzwkdOSLd378O3Xk9uho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8997.eurprd04.prod.outlook.com (2603:10a6:10:2e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 14:18:39 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 14:18:39 +0000
Date:   Tue, 10 Oct 2023 10:18:29 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     hch@infradead.org, bhelgaas@google.com,
        christophe.jaillet@wanadoo.fr, imx@lists.linux.dev, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lpieralisi@kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        robh@kernel.org, roy.zang@nxp.com
Subject: Re: [PATCH v3 1/1] PCI: layerscape-ep: set 64-bit DMA mask
Message-ID: <ZSVdNXBiUxIq/87p@lizhi-Precision-Tower-5810>
References: <20230926140445.3855365-1-Frank.Li@nxp.com>
 <20230927124621.GD18050@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230927124621.GD18050@thinkpad>
X-ClientProxiedBy: BY3PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:a03:255::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3e999b-8f9d-46a3-5b1a-08dbc99bccc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKz+jgXeL6BNuDIgiZalQn3f/FXJ1jwsHGr6QKfY1vYW7Uo6TkEi3VBZ/UtJRk741+/xc1FZnj+bcKZvzupn6Jx6CpQhgrchCcd/Ye0dngp5Ydp3MnqEWsdLD9JSKlRJ9AnwHFXYJDl/lvFEAFX9mX3ZLfeRHr9APn/xNBuonCxfxkSPIxmagh+rI81cKkA0iI7mRRn8o3K/cUNL2iV7gNq/EsHMQcbpnoB+zuKXFucPSpJBaLa71l9baNA8eV5e1Xloz/0zbhBSHPjIEcOg/vMBDtUquAjODnONCrOCOSN+fBx6038X92M81Rbymcaobzv4GMnbgN9Er3TweUmcCi6bel2z6SXKdrBtP3uuwtcJPfMAhVzgxD+Aa9FDShCpduIRDKSCOQoFrBhPCava5cusNN34to7goC4RWvmzSQGCpe2CU611GSvoi42ZdbFgBJ2SWAUtMwp1taKiuPm8A63h8pKpeWiThIzXpC+fCVW9ibBcHktT/XjNcpngJj8/SDa0bqavzeaNwZ75ycmiEFCfv3rp2RKT3MxF0lcAmadgdVEUsN2QiIMDg49i6Poqa0lruO4a00fLdeBWeSA05kwlMwBMs9x3ZnWpblzt6PQXWLFLxRSOg/+tswXf3rkw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(478600001)(6486002)(33716001)(6666004)(9686003)(6512007)(6506007)(86362001)(52116002)(41300700001)(38100700002)(38350700002)(5660300002)(66476007)(66556008)(66946007)(316002)(6916009)(7416002)(2906002)(8936002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXZVaVh6S0kyRjZlTTRXL0ZqcmprR2RWeFJub2lGbTdXVmxIMDNzbEpFODZw?=
 =?utf-8?B?MERxa1NwSWNTeklEK2M1YWxDREJvUXU0bjJNeElNT0hoRFdSKy92dVJpTFo5?=
 =?utf-8?B?ZGx4anVKS0dlazhuWUNsaFhVRzB5UmhmNUNKT3gyekdCZlN5OWdCT2ZSaWZI?=
 =?utf-8?B?cWdTWDJMMTR0WktreHg5RnBkSkJmODBxdGlkQ3kvMzdzOE9LMTg4QXIwUHZO?=
 =?utf-8?B?VmU4aHM5M0x4UXhPUTRMNm5uRU1xYzM5TVZOQ2dvcUtUUytLb1oyWVJEbjBF?=
 =?utf-8?B?cEEvNGV2OWlPemVjcXZYL3QzSnUwcWJWMEtrOEloalA4WktTdHljMzJYRDla?=
 =?utf-8?B?YktZOFRIcTJDaVBHYWRmWnh3QnU4cUQvVkRsRWcwcy9yNUcyaEJEUTUzVGxZ?=
 =?utf-8?B?eXFKNnpHRGpDc09QMmZidld2RkwrdTk4eW1KSXZVZUZnMzJGVzRYWnNSOUdF?=
 =?utf-8?B?TWNab3lJLzh0dHpQbFdWNEFOa3JXQ2ZLTnBGbnFPWlJDTTdtY2JWZDl1WkVu?=
 =?utf-8?B?K1RSbSsvL0dJdWVxRVRSdjlKTG4rUys4a0FVaHVMRytsakpNUUplY0J6YnNK?=
 =?utf-8?B?YXdUK2ZCallEOUxDT1lXOGpPZ2hkOWJ5dEhtdGk4MHlHVmppbll0aUFNUDlw?=
 =?utf-8?B?RSsyZGphN2ExMzJqMnZKam8rWUgwWEZpY2RSdmN2bG1zUVc0UTQ5WkMxVHZi?=
 =?utf-8?B?WmNTQkVzYTRjVnQzSFNuK2hDc3ZzNHIzSHN6elpNWWdQdzRwcFR0ci9VMHU3?=
 =?utf-8?B?YzFXR09GUXgzUDlBdEY0aFh0d0tmMlArL2toNEtjQ0RKZVFiQnBSTk9zbjlO?=
 =?utf-8?B?dnFwSmdXVzlWMnF0dG9VcUNKNFc0YkFRWWJWd1RFRzg0Nkx3aXJUbUN4VytC?=
 =?utf-8?B?YUk2bEFqWEZwZG9IYmFyT1ZpVzU1RUR4Z3YvV3NLZGw2UFF2ejZKOGVwSTdU?=
 =?utf-8?B?YmRDWlVnZURWakVWdTRSWlZLTnhkb0FORDNnUkNRdU5ZeVNWRUpYZnovNUtV?=
 =?utf-8?B?c2NoTngzcWNVYlNzc3ZWTzhwLzNFcWpUaS9MV0RKbnJQdm1UZFhHYmpuU0NM?=
 =?utf-8?B?bkdjOVF3TFd5dnRDOEdwbGJEbXR6R01kaDhTb2hGNzBxK2xLZlNrZnRkb3ln?=
 =?utf-8?B?Ym1WbG5ERVBHbHBTNDBTcFp0K0g5dWVKYXkvemVNMlUzRTFYYXVYZ3pWYkRs?=
 =?utf-8?B?M3RRbFVyVDNyR0xQV3ZHVU9JYVk4cnlRYjVYZDlCTzE4dnIxY0JCbnlrQ3V0?=
 =?utf-8?B?L1JEaFB6Vnl2ME1tWkxOc1pqNVM5cTh5c0ZHMkhNYm8rSjhBWlFGNUgrZ1Ax?=
 =?utf-8?B?N3JjL0N2S1hGQ3lHR0crSEltNE4zSDRiSDhiYXJsN0JhWkJyaXllaUExb05z?=
 =?utf-8?B?Snd3eE1nWEtycTB3ekRVakVTM1VEcStreG4yZHhTVUNCZC9JenAyYkRxYjVI?=
 =?utf-8?B?Q2tOcEphY0FvZ0FyTjd3SDk5Mk81dGFheXZ3TmpTS0FsZFVCS083bDBldXQw?=
 =?utf-8?B?RlIzME9sSmJqOFI5VTVBalJmQy9yS2RybVJOT2taWmJTQ0ttNmZKTDZiYUJ0?=
 =?utf-8?B?ZXRxQ0UzTWZsUmUvL0orNS9lK0FadUlnYXJSRmJJd2t4T0NRSmVrVEpaTWNN?=
 =?utf-8?B?cWs5R29TZkZpWklNTTVHS2w4SHA1Z1VPNGNGNlcxMmNBUWhuYXhpSWV0UE1I?=
 =?utf-8?B?Mkdpa2hxQlBDN2xOTFJmN0I0Z1lReStZTGFLY1hyaVAwSHhQT1JTY1NxZHBJ?=
 =?utf-8?B?d2llWWhtR1AxQ2pVSTVEbS9TOUxHZ3dUUFA1WlNqR1ovdkZVMU5sU3Zub051?=
 =?utf-8?B?OFczMGxGQUxEUndDd01iS2Y3WVM0V2FsM1d0YVQreGhDaHJhbERMRVlPZi9n?=
 =?utf-8?B?bWV2cFBZbHROY1g2VnBOQldjN0R6akZ1M2tRTDh6a1NMSnZ2VXFCTVo0NGRv?=
 =?utf-8?B?U2U4cVBYdWppczROOHJmcHZVd2dSUE45aFhlVGtCamFSM1E4dG84WXdjZXhy?=
 =?utf-8?B?dmRzZHcwSEt4SDNYTWJGdnE5SDM4Sm5UbGFVM0NjOG02czBZOXFDaWg0MTgw?=
 =?utf-8?B?bWZCS1ZHVCtnSHc4dkUxY1gvMnVFYjV4SlVQdEJ6UmxFcDZWdk1xSzI3WmE5?=
 =?utf-8?Q?ZwiATBWKrRQvfi5vZxGiZ3caM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3e999b-8f9d-46a3-5b1a-08dbc99bccc8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:18:39.7446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLGx9Ml+zdzHnii9XaCvsNG3mHM2nv/0kClLCBc6ebagT8O80DBx5Ma2xmMcEvDjv6sW7amkficFVebxt7nSLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8997
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 02:46:21PM +0200, Manivannan Sadhasivam wrote:
> On Tue, Sep 26, 2023 at 10:04:45AM -0400, Frank Li wrote:
> > From: Guanhua Gao <guanhua.gao@nxp.com>
> > 
> > Set DMA mask and coherent DMA mask to enable 64-bit addressing.
> > 
> > Signed-off-by: Guanhua Gao <guanhua.gao@nxp.com>
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

@Lorenzo 

Could you please consider pick this patch?
Manivannan already reviewed and only impact layerscape.

Frank
 

> 
> - Mani
> 
> > ---
> > 
> > Notes:
> >     change from v2 to v3
> >     - remove check return value of dma_set_mask_and_coherent. 64bit mask always
> >     return success.
> >     - remove redundate comments
> >     change from v1 to v2
> >     - Remove 32bit DMA mask set.
> > 
> >  drivers/pci/controller/dwc/pci-layerscape-ep.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > index de4c1758a6c3..2c2c9aaa8700 100644
> > --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > @@ -249,6 +249,8 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
> >  
> >  	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
> >  
> > +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > +
> >  	platform_set_drvdata(pdev, pcie);
> >  
> >  	ret = dw_pcie_ep_init(&pci->ep);
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
