Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4971A7D1166
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377480AbjJTOTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377364AbjJTOTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:19:07 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21899D45
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnNA9ZbGaaUWl4NaTlSzDsq37ONbTl6om7RXpGsUelrcD51hy6vq5ftleRYNsSH/FVefZ0Ffmjrp8LDhfX1xrqiGFc75rIayyf+WpGMjjoQZPbAuO4KhU18P8Vo9Xpek8KEa0l9miv7sUnuO9cKSoi0bs1sKmCdP7ETmKDnEF854lGBsSq4AX3H9H1lR4GQCC4BtntevkNJiQME1iFuPzQ1ODvg2PypgEAWkrB+rLtJQnLZFqhKNxvVnjd1njrPZpuq/w2WlUDkTUBs+wZdHbO93oWmK0OmRm+CCfxZ+57TTyFLvp3+LGHTl732f1ZkVMit7dwHJncxOdKQZmLjtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhoPxG6wRCNe1W0w6x7WTuNoBxrj/Qn9Z2kElRwpkrk=;
 b=lwAxb0i4kUHo7xHt5mitC40I/WmDDmhFEZ6YuY48omHMvAof7inuWzX2dRXFWywpMIxrBF9j2f1r4LP2mSM/a8+a98d4cZ7kDU4LV2zCwE+FWCx0c7DRdzFDbzKOCTOk9088h8qwOAHhh4JR+mdrnMnpnEU6db9yQBeblF3HiEtlrdG1Pbxzl8Eyn6SexaqWrGcjxu9M//rJCk0AI+VftJieqY+H9jk52sR1AwZrQjmdtlYvSZP4DS9IMk7z8TlfBdhGJYKDroFFVYxyHxT6HiJ6n8ETnh1xRSg/Oncw+YJZzSNvk7GiQR4KR2VE8I6soG0txNg1LpMyqlvcHVfHeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhoPxG6wRCNe1W0w6x7WTuNoBxrj/Qn9Z2kElRwpkrk=;
 b=r8KAmNyc0epj5nOMp+66e3iW2EFf/bnKrFtHQheLJRciki7F7uYYTuqooOltklZGjirX3tKC52tIlDVL1Zzur/WnBDMMSCSZSD9xEGgLzojhkfyoNY+ie4xgZZfnItkQ9at16YOG/jMLop/lzz+biN07R3tkhqZT9Ffx65BaRco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB7619.eurprd04.prod.outlook.com (2603:10a6:20b:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.9; Fri, 20 Oct
 2023 14:19:01 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 14:19:01 +0000
Date:   Fri, 20 Oct 2023 10:18:55 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 Resent 6/6] i3c: master: svc: fix random hot join
 failure since timeout error
Message-ID: <ZTKMTwU6cVAfGCKG@lizhi-Precision-Tower-5810>
References: <20231018155926.3305476-1-Frank.Li@nxp.com>
 <20231018155926.3305476-7-Frank.Li@nxp.com>
 <20231019084452.11fd0645@xps-13>
 <ZTFNvrsSoHOS3P2g@lizhi-Precision-Tower-5810>
 <20231020160645.67e678ee@xps-13>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020160645.67e678ee@xps-13>
X-ClientProxiedBy: BYAPR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:a03:60::30) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: c68eab64-2003-43a9-7f06-08dbd1778208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Db9yeFfPQ8NoaH0TTtYQlR3154Fom+TNqmP5WIn9OEFGHeB9a3srbhm2QGJLzYBzdC/9PsaRhoVCY72Ca1SJC+Z3MTZ1vV4EicedH2FIOOo6cd2gm2C98MyuAfPinzB/eAc2d7ya/Y+hnmWw3ctJ0SH0P17X7jpWYmsJrQ7QLThITOaiUYHsvZRUdCHg62EOn99J7WS3uzTu1PaqS0sgWKk/eyYAbwK0XnaB3h7yPAU8nEY9H/SZrDxXqXAUM0rZTd7bA6wHGFlEYWKCGBAkR+982s9qLybSsm1WSWizdv+oWNOie1ZKPPSRwfZsvSEpaLpzB5OtINS8YuG45RpU56ctBEiHOhn1ThppMLUdonVFCzDOYgGWYVDGv8HAFKNPAqQJcbfgrf6Egiwv4zLa32JvxJyW359pr7VKu1dn5pUCVaDi8GSwXsjS3+SPzKnmCRdMeIxAV5R2KFq7fY2q9/kGk8sUsOt1wn0VXRAFUisMKOSz3jpPtK3ZQ3uljrZTKjreArGOIE4qSXSDoRoNVtT6/KyIAI4VkZopoCA0t7qT83Yi1uDeDdU6IM3z18byQ/kcaa313Mxju6XUuil+RK7RE/Sb+K6K91exnS26TzrsXMubv2gNce+Nc7Mde5BP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6916009)(38350700005)(2906002)(6486002)(5660300002)(8936002)(8676002)(6666004)(4326008)(41300700001)(38100700002)(66556008)(26005)(86362001)(66946007)(33716001)(316002)(478600001)(6506007)(9686003)(52116002)(66574015)(66476007)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmR6VlRxL0VYVW45aVFmVmM4UTIxb1pHN1A5OW5xN2VWWFMzTHJsWGgzTGp2?=
 =?utf-8?B?K3lZdGVyZGE1NTlTRllmK2FYWXhoYTU4bllkeVJMNDduT3l5ek0wV1ZmeFhm?=
 =?utf-8?B?MEt6RW5jOTBuOUk5OEhvRjFoWjNNa3A4OGJ5amtmRmhqWlFCNHo3OWRQelFO?=
 =?utf-8?B?dW5Hd0tXOVIwV0JjWnBLR3M1OEY2ZFFxdHduc0IxVjVqTnNSdGtGNFFMYXQ4?=
 =?utf-8?B?dWdQRlRFWHk3dm1GS290RGY0RVlvSXNpcWRIemkwclRHVFViSHQrV0ZXL3J4?=
 =?utf-8?B?d0QvMjdvblRndjNpVGw5ekowQnNWZzg2QUdZRFdHZWsrdWIvbVBxY2U4SUlz?=
 =?utf-8?B?M0pGenFiYXhaRHQ4d2pzSk9HTFJWeXFnMFFsaUVQMEVkNHlBWU91clF5cUY0?=
 =?utf-8?B?TXZ3NDFwWHhnL0o0ZjdlbWt0dFVER3RBNlk0eC9HYjlKUkwxWlZsWUpSeU5t?=
 =?utf-8?B?Zy9MWVEwbmZrNGY3bUpzYjBJdjYwMlB0UEdyTExaUlVremtRVzhIWmNPSzQ1?=
 =?utf-8?B?eFlJc2krNFdVeG9lUDBsbW92RzFqc1R4ZWxnRDNWWHFLUUJkcDJGbGZlNTVp?=
 =?utf-8?B?VlA1dnAxaU9FMEVVdVYreGVZbEdlL0lXTTNybGN4K2grVE4zQk1FV3NPQVFz?=
 =?utf-8?B?OGZFTEtMK2R3bjZuZHVVdTdaUGJZS2s3RjdObFhOVnFyanJoWXNMMlc3cGNY?=
 =?utf-8?B?WmpjazQ0OXNQSldjTk5ZNjNkcUtueXMreHBWN084aFJGK2txMHNnVGg5ZzN6?=
 =?utf-8?B?akF4R0dXUnpxNE41UU45R3dGRjRIS3lqVDdJNGxrdVE2MHJmZ05KUllTVmNW?=
 =?utf-8?B?K0NwS29nWEZ5bkxnaGxDMDVXRW5XMjJzQWZHWlNXWGI4R0hGSXBXOUNmWDlC?=
 =?utf-8?B?Sllsb0RhdWxYQlVxblcrSmw5UmozR09EZm5ZdHljZ1VnMzl4OVpsMk1LN3Zl?=
 =?utf-8?B?QzBWdDZPVEl4Wmp6dE1LM3FxN2srSm1pZHhvdm5VWTFBQWpSWWNvZThYRVlN?=
 =?utf-8?B?Y1JOclFMQUdiQnBZOThVcTc0RVdybjltVlUrRjNvNXJ4OFhwVFUrZ0pUV0lB?=
 =?utf-8?B?cVdMZUc3VlptZkk5UkRGT29NL3duRmtxbnQxRXlUQjArZE9lUXlyVzhCc1BJ?=
 =?utf-8?B?Q2RHbDFycGtrR1RHMFY3S1JlbmpsSWtsZllzVm9zV3Jpb0I0c1BkMlljV21W?=
 =?utf-8?B?Z1pnUmZ2cXBRWno2NHhiUW9hRGJrSDh6SURxTitFc1VZTSt0VTJteVpXVU45?=
 =?utf-8?B?YnFTSTl6Ynowak95aFBLNENFNmptWUlrNDJmekx1Y202Vlp0MFMrVWtkZEZK?=
 =?utf-8?B?dU9EbFFsYktNMjk1cS9iQURkbTdTTzFLSVAxazU1NURWVGtYK1ltUHBqTmdq?=
 =?utf-8?B?TVBUNzJUcVJ2dXhJT3d1NVp6N2NDQkhZYXhHZXNoc0V1YzVlMkw2UkNnOGZQ?=
 =?utf-8?B?bUNZSmpPVnF1ZWxST2hHN2RZY21aUFV5cHpsTUwxZ3dkSHl4OVpWYVRaZEJV?=
 =?utf-8?B?UG44KzdQaVU3WTBOSlMxK3d3Y1I4OUlLN2N6Mk5HS1puS0l1Q2hPZzd3bnJJ?=
 =?utf-8?B?QUhnWFF5UENwNjZOL2ZUcVBUWG1KcktJT2cwUVhkTi8zTFM3a1Vydm9WZnRt?=
 =?utf-8?B?RTF0QnUwNUtGVHpBby9DVVgzV2Z5c0htTUZ5TjZKNnZJZmJoaUhzVm4vRmxZ?=
 =?utf-8?B?VlNqV092L242QWxyTzlzV0VVZzNJMGNCRnBTdEs5cGNCK0hxL3FsY2ZpZGp3?=
 =?utf-8?B?NkxKMEV5R2h4SXE3WE0waXhJcUdNVVlZNDBNZXI2QUZTbkx3UFd6THoycDR1?=
 =?utf-8?B?eXRIMTFwSHdjSXphalo5SU5RcUVLK0VGQ01GZHdaZWdBTnBJQmJBTUVOb1Iz?=
 =?utf-8?B?VzF2OC8waFM5cjhWa1hGRGZSaVFjVmdFa0hucTBTdE1ocmE0ZVJUczRkc2cv?=
 =?utf-8?B?eUptZ0djczRzaUhEYmxSOFJYcGVMekZHRFBad1F4TU1KWUwwZnhGNS90M3By?=
 =?utf-8?B?S1NQeTlVWWVXdHIxZTVDb0lBMnRWUExxY2hLS25INlc4QytXQUhBMTBtY0lO?=
 =?utf-8?B?SmJjc3JORDR1SnFqdFh1U2lheDl2K2lPVUJwcmJKcGoxT0RIRlFJdWRVTWFV?=
 =?utf-8?Q?0ViM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68eab64-2003-43a9-7f06-08dbd1778208
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 14:19:01.7527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wp/fO9057pPOvppddgSbBl+KysH6Qi0mW8KfHOG59+WMFQGjidMuWddNOh1HYXC/HsRNVLOhUkLCtrKXH0XAqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7619
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 04:06:45PM +0200, Miquel Raynal wrote:
> Hi Frank,
> 
> Frank.li@nxp.com wrote on Thu, 19 Oct 2023 11:39:42 -0400:
> 
> > On Thu, Oct 19, 2023 at 08:44:52AM +0200, Miquel Raynal wrote:
> > > Hi Frank,
> > > 
> > > Frank.Li@nxp.com wrote on Wed, 18 Oct 2023 11:59:26 -0400:
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
> > > 
> > > I am still not convinced this should be ignored in all cases.
> > > 
> > > Case 1 is a problem because the hardware failed somehow.  
> > 
> > But so far, no action to handle this case in current code.
> 
> Yes, but if you detect an issue and ignore it, it's not better than
> reporting it without handling it. Instead of totally ignoring this I
> would at least write a debug message (identical to what's below) before
> returning false, even though I am not convinced unconditionally
> returning false here is wise. If you fail a hardware sequence because
> you added a printk, it's a problem. Maybe you consider this line as
> noise, but I believe it's still an error condition. Maybe, however,
> this bit gets set after the whole sequence, and this is just a "bus
> is idle" condition. If that's the case, then you need some
> additional heuristics to properly ignore the bit?
> 

                dev_err(master->dev,                                       
                        "Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
                        mstatus, merrwarn);
+
+		/* ignore timeout error */
+		if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT)
+			return false;
+

Is it okay move SVC_I3C_MERRWARN_TIMEOUT after dev_err?

Frank


> > In svc_i3c_master_xfer() have not check this flags. also have not enable
> > ERRWARN irq.
> > 
> > If we met this case, we can add new functions/argument to handle this.
> > Then we can real debug the code and recover bus.
> > 
> > Without this patch, simplest add some debug message before issue
> > SVC_I3C_MCTRL_REQUEST_AUTO_IBI, TIMEOUT will be set.
> 
> Yes, and sometimes it won't be an issue, but sometimes it may. Maybe we
> can find more advanced heuristics there.
> 
> > And svc_i3c_master_error() was only called by svc_i3c_master_ibi_work().
> >
> > So I can think only case 3 happen in svc_i3c_master_ibi_work().
> 
> Case 3 cannot be handled by Linux (because of the natural latency of
> the OS).
> 
> > 
> > Frank
> > 
> > > Case 2 is fine I guess.
> > > Case 3 is not possible in Linux, this will not be supported.
> > >   
> > > >   The maximum stall period is 10 KHz or 100 μs.  
> > > 
> > > s/10 KHz//
> > >   
> > > > 
> > > > This is a just warning. System irq thread schedule latency is possible
> > > > bigger than 100us. Just omit this waring.  
> > > 
> > > This can be considered as being just a warning as the system IRQ
> > > latency can easily be greater than 100us.
> 
> This was skipped in your v3.
> 
> > > > Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> 
> Thanks,
> Miquèl
