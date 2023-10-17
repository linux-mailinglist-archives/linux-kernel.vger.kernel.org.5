Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23697CC767
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344341AbjJQPZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344061AbjJQPZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:25:51 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576549E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:25:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcV1zp2LxqSavayH2ymx2lq/wkA5MttX6t+vvx/akAZ02prYRGuLWFzAOKOO/DhPPTk319XDUHubnTUxMUP4eMdtNZzJxnXf+XdzX1xo0ztTdlrLMGGdkCSzQkYc6yYL4jZFEXrWb34zdsKoAHvop8mVfsliEdaWeRHHjU/FutefwcHdT95s+05Hl7gdUKWlglQOQEUTJbWr7TK+B71gyc/YfpZzr02A+pRZWIoteXdz/8te6v0DXDDQasoP7PTDyRTzUPka8dRPIpjnP23g3tsfHZAY0Hksvs58iDzSSiuTZsDnczX5jgALasCiJtizoP3SFUSEVe9Jy8KW6MQ3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhpL+3p/lYUiDJGPKlnyBtBYFV8mchDVP4HqJ9uv/DA=;
 b=k1BRyzs4ykhDRTExn4EetyiWbIsu9EJCuSRmpVCRzhMs1IYGPYiWKpAU1M3vOAFHOSjQSUwwddW1PoNDBl+zbZd1b+8rdTIJ33cQ9BIP4RTqRVPxAXmJ9y5yE1AxYWf2K8Sf5tttYkQMAN3rirnuPRmNGHxghEbjOpGZ80bkcid6QrMgpMA83xbdcUJeYMDBJf1YdqPKT6E2IbdqxaQQnxNWzf6Vkz5kq7vLwgB+eHqsTT19oBgEDfu+ZBvgjZ0iDpp3DyMI68NDZdRh3JuHOBZRmFSE0cFVbPgUVzJJMRDYSmIhcP5eP20YmCmnSijcdTlWuhSw7wu9n2Pe5bXEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhpL+3p/lYUiDJGPKlnyBtBYFV8mchDVP4HqJ9uv/DA=;
 b=GLvXg4+yOUo8kDArRm+5OHhR/6r82gPgsnhQN9mRwgbYZEpRyrVZEbA+oLUG+OkI2yqGbEjpZ30b4er36KlqPEsxRbZn678ARo3JBFTi1JYXU9JkT3RVWaAexjMXRUhHpZRsw59aKMKDtUIUO04L0NR445YSGuhiVme3Jr75pmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8185.eurprd04.prod.outlook.com (2603:10a6:10:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 15:25:44 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 15:25:44 +0000
Date:   Tue, 17 Oct 2023 11:25:37 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 6/6] i3c: master: svc: fix random hot join failure since
 timeout error
Message-ID: <ZS6ncZeNaen13s1b@lizhi-Precision-Tower-5810>
References: <20231016153232.2851095-1-Frank.Li@nxp.com>
 <20231016153232.2851095-7-Frank.Li@nxp.com>
 <20231017163335.16770af2@xps-13>
 <ZS6d+mANtuhoAcuX@lizhi-Precision-Tower-5810>
 <20231017170603.5ef996c2@xps-13>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017170603.5ef996c2@xps-13>
X-ClientProxiedBy: BYAPR11CA0086.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::27) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b4d50b-179a-4ae3-e4dd-08dbcf2554b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmLouNxbQdaCfpRM0iA1PQAjpqyVVYzBbMfGnOZQgIpguW6vabnkkqduwC5fNfBP+0Lt6Fd/R62tHYRPjmzQ4XOgBEqSq8JsNl9/yOaGcscvgNgv1ODGX8vaEjEYX6zk/YPfdTYxOB0RnepTf8BDwApJniO+7RKmRzix/sSTvt8nNW1Baax8IETTpcyWDNq3LvUUHkwZ7hl5gjRsL2+mky9LuExbSFWmRgXEW48fgG5iIlfiIdAeZZPHIvyVHX3NIEjI6OChemZ2c/SdklvX2lvgUxy1Bl/3UOhctWJXmdN0KlecI4vqMaxyC+DZ3yP7kf8aw6K2ykQY69g2e05ABDcGTD/3kLl9el+AV23zggXzd/5axNSOTDJ2RtG7cwCPHKyJrxS50PdGPrM/wNLVNn7LOqcHKoB/7l3pgqqmMkiDGwqB0E8+9x7rNnQ2eSE64Wu5h8sI8ihgCZEOYdFf/rSHqbD3OMV8sHMNm0MuZD+b2oxuXRezoVgYGRnrfcTkemfwCQcM8bhkepsdv1BJwrH1jniTgCPlY0GfoVw9YRcLIwpmZitAzN39ub07cCz5kgbfo0KyDrclFBb+QpRF20GUXuo3m9jzs4ebJGHuK4a6d81fYkbUGety/ex/i4ge
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(396003)(39860400002)(136003)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(26005)(6666004)(66574015)(8936002)(52116002)(6506007)(83380400001)(41300700001)(4326008)(5660300002)(8676002)(2906002)(6486002)(33716001)(478600001)(66946007)(66556008)(6916009)(66476007)(316002)(38100700002)(86362001)(38350700005)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elVhSXVqRnQ5ZTFRMnpvajBQTU1tNmk3YnJ0eW50L2VEOXFRWlZjZ0RhTEhQ?=
 =?utf-8?B?endwSlcrZGQ2K0VOVENXUzRsUnVjaVpnZ2ZmcGczR0lkbmV3d3JENDlyaGpK?=
 =?utf-8?B?TW1xQlRETTN5US9pMXU3QXNWOFMyYXhRQmdhemhPUU5zQ1VKR1N1SDNNNk9t?=
 =?utf-8?B?TENUSVlLR3ArS3g4RGxuSmt3TWxoaGxzcHpPMFlKS0hZbEp4bkdrdTVpV3dp?=
 =?utf-8?B?TU1BaHo2dzZGWkdDaGd1Rlp4Uy9aTUhDaERQemVGdDBwcFdFaVZBZDlSZ09o?=
 =?utf-8?B?eTJzME13WVUydlhvU0VEYm5xdTlUaUdVUUpuWkdWYVRMMkQ1UkVxTmI1WHlL?=
 =?utf-8?B?RUNZeUNUS0JOVXdUQ0k0eFBUVDE0cVRhdWxIditwdHhKbkd5NGlacXlMM3BE?=
 =?utf-8?B?Y3dIM2tlK25QTFBsdTNlRTFpaHg5L0twWEFwODhPR1VFR1ZEWllUZm5rZThQ?=
 =?utf-8?B?ZHl1SmhmSzBGRkFNSGljQWt1ZWZBUGNDZGNGVTNYVklyT3UwY0xKVktFR01w?=
 =?utf-8?B?aWNWNjZWVUtDWmltNEFkOE5aVUJnc3d6MWJtUHRWejBBTTRhd3Y2S3NsSzlD?=
 =?utf-8?B?NUJGdnR4V3pKc0RzSm5FWVVjREoxNFdyb2ZYMnl3WUpCOEJrSzI1M0NlNENR?=
 =?utf-8?B?V01HNENnWWdhbEtCZ0lKQy9zdnM3MmN6RzQzWWE4TEhOUDdieExlbGRFd2pY?=
 =?utf-8?B?TVdyQ2kxZHZ2VVFSYi9EVUVCYk9BNzBvbkkxL1ZIUlhtM2dqV1lMOXJnUGtF?=
 =?utf-8?B?NVVTdmE2c1EzSWtkU3NQV2hycW1QTVpXaTBPMGZ4UEFQWC9IanNhaEpzZDlF?=
 =?utf-8?B?ZzJDSzUzUlBFYWd4bDlnaFJ6a2JvWWtOR3dJZ1FsY1REbkhIVzljSTJja0Jq?=
 =?utf-8?B?NnRZTlhjTjJiQzNSQmU4c3lqbm9QaTEvODI4eVlDWGJka2o3SVltV2tqRDNL?=
 =?utf-8?B?b1JmWDROV0VzY3RDOW9vbFByN2NOMldwUS9PNVdlYitZaFhhd094YzBFMzl1?=
 =?utf-8?B?Q0JjblRKa1FML3lVdCtmVms0MnI3THovRUJ4WHh3enRId1VZMVJ1d0xwUndY?=
 =?utf-8?B?QVNVQjVOVUYrUEZUdU44NjRxQk9SOVg2RHZHTXAxZVdBVkJOa0d5c3YxYlpl?=
 =?utf-8?B?SU8vb1k0NkpoWWVhdy8veDVoSVZQT0R1TlJnNzM3bzJtVzVQM3g4RHFLa2Ry?=
 =?utf-8?B?N2Vlc3NGVkd2RjNkdExSVGdUbTVtb1UzcWs3ZHNINHdRTlhkYnBYcXFtZ2ZM?=
 =?utf-8?B?TlBrZzg3R2dvS3U5RzF5OTFZanNKS1htY1BnWU1YQTN0QXFmZTE5Q1JVNjdE?=
 =?utf-8?B?WXJlU2tnai9SeDIvZ0U2L3U0TVQ2NnNpNUoxZmpDVWlsLzJ0RzJPRW5qVGpV?=
 =?utf-8?B?bkVBU0Iwd0gyQ0F0UXVIUFZxTWxnZVBnS3pzQlB5aVVNSjVYdVhCYk4yMUZr?=
 =?utf-8?B?SEVrUFRxWXR0MGhBU0xBSUVYeW5FalE4TEJMM1F2d25DUFZEY2Zhb3hqYndW?=
 =?utf-8?B?bzNnNndhTUk3NGRtbngweGFseEtBK1I1L2VPYnJiY01RcFF3U0FqWXd1dzJ1?=
 =?utf-8?B?SWloYnpnc1V4WmRXL2NTanJBenlIdm5QcFJiZFY0dGRvUEw3TGxDYWhmY0gy?=
 =?utf-8?B?Zmw5TWlXUjBMa1pHL1pkdXBPVWpWcDZnU2hIeE1HUVNvZ3ZULzlhU3NydWZq?=
 =?utf-8?B?U0M1SWtIcGFLSWZmZ3ljSDNmb2NBNWllSGJGTERIazlTdUp6eDFxSS9oWm5r?=
 =?utf-8?B?TVVTa05Lc1RMS1FxQS9JbzdxYUZSMHljd1BIZnhKRmNiN1J2bVlMR2hEN09Z?=
 =?utf-8?B?WmdaMnB3MHpkNHA2Q0VLRnpFUjl2bGtqSGRUVUUrNFowVUJnMWpYeU10cDB2?=
 =?utf-8?B?ZkI5RHpjbm10L2hDanh2VkhFZmZPSGhqTnFIelJDMlk3Z1RaNnZrMWdXd2dT?=
 =?utf-8?B?U012bzNvVFFDSTl5ZUtmSE9KdVdEeVhQZTBwMHJ5dWRqcFFaSWRmdUZOL3o5?=
 =?utf-8?B?WTFNQVdCNzRvMHhVZWcrUVA5cTViTmQzM2I3VDZ3VXRFaFo2Q3NPL3ZmYUJy?=
 =?utf-8?B?SVpPbVNaaDlSVU42SWgzWGNISmVqQmxFZmxoWWh3S3psbXh6WjlTWVQvYmVu?=
 =?utf-8?Q?8rB3SFMk7RndBci5OnSKG5vE6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b4d50b-179a-4ae3-e4dd-08dbcf2554b6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 15:25:44.6186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03OhmdVEmqhuInnFDxq2A9SvPTrmdIBKzSPU5boRe4uPXaKgAg0O119z4Uwz5vl1t4vyiFXih+hM0UK18N84IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8185
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 05:06:03PM +0200, Miquel Raynal wrote:
> Hi Frank,
> 
> Frank.li@nxp.com wrote on Tue, 17 Oct 2023 10:45:14 -0400:
> 
> > On Tue, Oct 17, 2023 at 04:33:35PM +0200, Miquel Raynal wrote:
> > > Hi Frank,
> > > 
> > > Frank.Li@nxp.com wrote on Mon, 16 Oct 2023 11:32:32 -0400:
> > >   
> > > > master side report:
> > > >   silvaco-i3c-master 44330000.i3c-master: Error condition: MSTATUS 0x020090c7, MERRWARN 0x00100000
> > > > 
> > > > BIT 20: TIMEOUT error
> > > >   The module has stalled too long in a frame. This happens when:
> > > >   - The TX FIFO or RX FIFO is not handled and the bus is stuck in the
> > > > middle of a message,
> > > >   - No STOP was issued and between messages,
> > > >   - IBI manual is used and no decision was made.
> > > >   The maximum stall period is 10 KHz or 100 μs.
> > > > 
> > > > This is a just warning. System irq thread schedule latency is possible  
> > > 
> > > 							can be bigger  
> > > > bigger than 100us. Just omit this waring.  
> > > 
> > > I'm not sure this is the correct approach. It's a real issue but there
> > > is not much we can do about it. Perhaps dev_err is too high, but I
> > > would not entirely drop this message. Maybe a comment and turning the
> > > message into a dbg printk would be more appropriate?  
> > 
> > The key is not message. It return true, means IBI/HJ thread will not run.
> 
> But why should the workers run if it's too late?

IBI ACK already sent, target think master already accepted IBI. then master
driver check TIMEOUT, 

If without run IBI thread, target's driver will wait target sent IBI. And
target wait for driver handle IBI. 

So the whole system may lock or wait for long time out.

Hardware check TIMEOUT and software send ACK is totally async.

> 
> Thanks,
> Miquèl
