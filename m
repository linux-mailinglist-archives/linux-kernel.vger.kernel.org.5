Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B097D1270
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377643AbjJTPRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377601AbjJTPR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:17:29 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE0DD60
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:17:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6hlSLHE0hxFq/wIi7Ab9O4v7DjZChc7gHIsPLrPyX8zCR969SOiWwdqsbEjahmXPFpGZj5uo97IrDuPQz7Fe2rp66NHQ8u1zYd5FpAjD2C/bMFW5pf0THh0taYfDvyGthbrD747lLN2IHafhSIgjesXLNDRdAwMAQ+X0ciQCAPZM8rd7N6YRkYIV35tZg5QFK62cSUX8ayPdM64bny0XvN6uqmHoXfaL6OoS/vqlVm4o7BpvP0uuHo8FEadObSXdvzuRLu6P0UUzaRykbXXkrVWKk4eJXVXaVpxbhLMVxLxD1hXc+ooCXr1Lj5lD8/6qlOi3ppwb6adHI8petz5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0Bi3bn8qMesLCanq7j4h2Qx8K9aDOprrhmewVyXw2Q=;
 b=OdQYjumGkcWmeioB9aBafmQGk5iMQX0yqWUnIxOtTJ/CKC3uUbCE0WqJICZxDoK3FbyOqzk1x/OyYbEezY9/tWWOq9cx7LGR7cKqTZfNq3rxssdsiob58iz52Jw8RfeCxPv55/NRigpcJWILs+H2TZ932dxxQ6OUY7gn+V0fKrZhrZ4o+hfFCmYSdEmpTsz0yUQut1+QwFWtWk2NP2wW59PwyJe/MqUh/S+7raQjzXxXTg/fSf+KH5tuzkljFv7yRUuu0w8o+fXvQKoQbuZAI7fljEjwVpBMxZ880NAsT7PLo/4eMFF/tHfriyUJ/NC9d4WmtR4Jk4t2jebgcgQnSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0Bi3bn8qMesLCanq7j4h2Qx8K9aDOprrhmewVyXw2Q=;
 b=gyhkkBSv5mCvd5k5ziUw9k/EY9q7q9dMzvyRd0IpEVrq49tg1idSYcM/zm2rs9eC3cX0sECldOFYwgZ1ZJbEfjcRPjL2Q7HnLKowzNynUIZIGqA9HBzoXhcEJ+KkWeOW0Gn3J/Feh3IH4Sb6k4csOxKtzV2Gw/6JRUPq7pf+pfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM7PR04MB6902.eurprd04.prod.outlook.com (2603:10a6:20b:107::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22; Fri, 20 Oct
 2023 15:17:25 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 15:17:25 +0000
Date:   Fri, 20 Oct 2023 11:17:17 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 Resent 6/6] i3c: master: svc: fix random hot join
 failure since timeout error
Message-ID: <ZTKZ/a5T6DLJz/ZQ@lizhi-Precision-Tower-5810>
References: <20231018155926.3305476-1-Frank.Li@nxp.com>
 <20231018155926.3305476-7-Frank.Li@nxp.com>
 <20231019084452.11fd0645@xps-13>
 <ZTFNvrsSoHOS3P2g@lizhi-Precision-Tower-5810>
 <20231020160645.67e678ee@xps-13>
 <ZTKMTwU6cVAfGCKG@lizhi-Precision-Tower-5810>
 <20231020163525.66485920@xps-13>
 <ZTKTGG7J55Sj19Nd@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTKTGG7J55Sj19Nd@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::17) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM7PR04MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4dc173-b15d-4765-da25-08dbd17faa5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9we8/hZi3b6sXpxIehlxp8glEEzFLKz+zNTR8xscbzzVtVzAEhY3AWT9oeL3JXh6JHwU0bO2++0+ZekvgxqL08flQY5TonL0QHJnQBaVnaYXOiuUebD7a5oDodH/T0nJP4AQUvzpq4ulLaHNPfcvtqTfOoKXj/2hJxsaQWF0K3DKgUR+xIoZEKDzQACptGCYvIXdxgR9OFJ3m7QS0/T1S8Cm8rImZwiGRJF/23lUAx3IZ3iYe6JpcQj8fcDA3d06lAnix4/YVFTDmtB+RtlZCRuZ8HDbZ67/UlNmmYCpa2vEK93Qeg6eQ50YGTXqGiBZpuf9WEQWPM9lnOZOI2nhJBIixk5P/5BwzG1ttWF40Bi3++cDGexGDyUZwZ2qpmjYj+JgGdLnE2vHIDq8YHPNfKjTLC/hbrjnEBDOstMQAtQWT2//K0EMxdynvQkoeoPgZ80VHyX8t2UkxQLDp/062wbwmBMERJ29DDo6qIcYhm4URFnhRrJ7KmRZ6PHVo7RB0CxKWaXMSkteObU/0DKb8UnwxckA9T1UjZkACXINyXvobXkJBOf1W9ckLVNC57rpCOcK3mC8FxxwtGQaizDYJwkRfhXk6SeO2s1N0/BccSrSENiKBc3k4pwabKP05CKu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(376002)(366004)(396003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(86362001)(316002)(6486002)(9686003)(38100700002)(66574015)(6512007)(26005)(478600001)(33716001)(41300700001)(66946007)(66556008)(66476007)(6506007)(38350700005)(52116002)(83380400001)(6666004)(6916009)(5660300002)(4326008)(8936002)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?FgzUpvBY2IBc8Z6LX6O72O5PzqKQ0luIpmagXSJKVKoa+hu5ovJ8sqBibz?=
 =?iso-8859-1?Q?adYX3uMDvnmL0/4B+ffovbVSnAfs+lfXBm3mll567v6GoEMfi99eullRDg?=
 =?iso-8859-1?Q?vyCWwHXSpJJKgN/dAoKbWBC8PNjvEdu3lyUibO80rtgPOwtrRwG8sRtdKY?=
 =?iso-8859-1?Q?W81Ug+eAFd82vm/8lGu7myUtCfZEUQVWCUV95F31t5XEVkyvVNRFFJJ6CO?=
 =?iso-8859-1?Q?lvhZ61fLUHAYqecy8HpjqDNP7DskYQQDRTMfJkIAUYsqkIJ+Jo6Lp0fyKR?=
 =?iso-8859-1?Q?kZBKxpvOQcmf1Te/LWGfg3DqH5c1q/DiV018HNkwZ1DGVhps8OOuwFJ7BF?=
 =?iso-8859-1?Q?139TYforYh4Z7owgqb0J1ktrQ6PAboSn+q5N+JdsjysZoyokbRWYQsmtEm?=
 =?iso-8859-1?Q?eMomASMg7MxJF3NwfQ6K40iU3CGf4ELfkcpEXRffoEY3KETPCIMR7phY6J?=
 =?iso-8859-1?Q?Z1BXuWkAkZ6mC3uMy5utWbVYZ6u6EytnVqoXZ2zVFoNufWSlXpcP2hpjnw?=
 =?iso-8859-1?Q?QaawzJIbRj5LTZyO/kGsHjXtjQQ6P8HG6+V5xRcZI1x5HODN+Xt1UhxXJ3?=
 =?iso-8859-1?Q?OehO3VkrO39C9Sjsc/O8bW36Yh9h0j6Gw7+gHihYLbsz7wCVxuWNG9nPlE?=
 =?iso-8859-1?Q?LCEJTOyQmrOXY5RP2N8Cfhc2bnnJYEWRvdPgEeVRhQrZ2DMEdnUTU91m8y?=
 =?iso-8859-1?Q?JB/ZeZ0H6CYIYywswfzUcEYgh6LrT3QGrzo/2PjrsI+D/SeS9wnhQvJQ5x?=
 =?iso-8859-1?Q?evH49bMlKFUs6wRpPfTNd8AffrA0SV6iuD8w8ymp0dfMDis4MrdpHs4W28?=
 =?iso-8859-1?Q?cQaVfAag+bAXH4ww2VhQxYfPmJm2sU/IRlVYP3aLvbPfCG+ZmVnecEWect?=
 =?iso-8859-1?Q?ZGDYPeXzbX799Idb8BlFA8a3bEH3YhfDAZSVprv+zYBUHDrF+3XS3gNu2r?=
 =?iso-8859-1?Q?Ndmc+7xagKaD0rWTOpTsHFyVNtfOi+2dmJUpJShaSKshq8zH5kY0pgFI/q?=
 =?iso-8859-1?Q?FM1pzSvqPj1/pVWdOdS5fwmy/U5KffMYeIyQR2c/D1Nmp3ULRY/X1Y1BqB?=
 =?iso-8859-1?Q?9yn9XQ6tarcvlcnJY4F0IAVMXh9HTXbHe/du1047XggY2M7PFP6Yn/0jhc?=
 =?iso-8859-1?Q?TUD6V3SZays79camNQYWLwpFUPcml634SHG/3yy3J8aap0vMCJ51C4rTFf?=
 =?iso-8859-1?Q?QIkZTUyQan0x0wPni5Oz8qyQLp7GsIcPfJEpT3ZzWju3+nEGsZ1Ks5gpLY?=
 =?iso-8859-1?Q?rH+H0BEjCQMVToQsITdptbtELjb+61K/rioq1otVog6ZJTj86T8iRdU4Fi?=
 =?iso-8859-1?Q?xf+IRPH5hlp8wZDHGrB0mYhys0ReSZNZGeQLFhArS0TYImuf2Rl0VV6BWS?=
 =?iso-8859-1?Q?UUD9iseJgL7koxKSejHPj2v28Tbe5e5A0Uh9B+zY/eAxz9lvNefMdwr+5X?=
 =?iso-8859-1?Q?DTWMQin58rYen7AFJ9zgJ1HPII7iHDu6CPAvlxGOimej+229kFkdjCj99U?=
 =?iso-8859-1?Q?epFs72Uc0eRewoDmCPqOqA0mPQm+OeRx9dH9cz8VHXSCwymqjOPJfgOAxF?=
 =?iso-8859-1?Q?FmBt8k9Bq4SDSup1RQK82HgVIt+H5KMtc9y8SHo9zsGQK+qgUOJ7D9AMz4?=
 =?iso-8859-1?Q?ZpU660Cm6UofJSY5MLpIctO92mqzZ2Kx+S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4dc173-b15d-4765-da25-08dbd17faa5d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 15:17:25.3577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNLLtHF10lWgjoz8JmiTwTRGKcEHF6u79NIa2M7OcP3i0dWGziZ0MLaT0RcpzjFdiFBZuptxSDcNe17ssL7Hkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6902
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 10:47:52AM -0400, Frank Li wrote:
> On Fri, Oct 20, 2023 at 04:35:25PM +0200, Miquel Raynal wrote:
> > Hi Frank,
> > 
> > Frank.li@nxp.com wrote on Fri, 20 Oct 2023 10:18:55 -0400:
> > 
> > > On Fri, Oct 20, 2023 at 04:06:45PM +0200, Miquel Raynal wrote:
> > > > Hi Frank,
> > > > 
> > > > Frank.li@nxp.com wrote on Thu, 19 Oct 2023 11:39:42 -0400:
> > > >   
> > > > > On Thu, Oct 19, 2023 at 08:44:52AM +0200, Miquel Raynal wrote:  
> > > > > > Hi Frank,
> > > > > > 
> > > > > > Frank.Li@nxp.com wrote on Wed, 18 Oct 2023 11:59:26 -0400:
> > > > > >     
> > > > > > > master side report:
> > > > > > >   silvaco-i3c-master 44330000.i3c-master: Error condition: MSTATUS 0x020090c7, MERRWARN 0x00100000
> > > > > > > 
> > > > > > > BIT 20: TIMEOUT error
> > > > > > >   The module has stalled too long in a frame. This happens when:
> > > > > > >   - The TX FIFO or RX FIFO is not handled and the bus is stuck in the
> > > > > > > middle of a message,
> > > > > > >   - No STOP was issued and between messages,
> > > > > > >   - IBI manual is used and no decision was made.    
> > > > > > 
> > > > > > I am still not convinced this should be ignored in all cases.
> > > > > > 
> > > > > > Case 1 is a problem because the hardware failed somehow.    
> > > > > 
> > > > > But so far, no action to handle this case in current code.  
> > > > 
> > > > Yes, but if you detect an issue and ignore it, it's not better than
> > > > reporting it without handling it. Instead of totally ignoring this I
> > > > would at least write a debug message (identical to what's below) before
> > > > returning false, even though I am not convinced unconditionally
> > > > returning false here is wise. If you fail a hardware sequence because
> > > > you added a printk, it's a problem. Maybe you consider this line as
> > > > noise, but I believe it's still an error condition. Maybe, however,
> > > > this bit gets set after the whole sequence, and this is just a "bus
> > > > is idle" condition. If that's the case, then you need some
> > > > additional heuristics to properly ignore the bit?
> > > >   
> > > 
> > >                 dev_err(master->dev,                                       
> > >                         "Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
> > >                         mstatus, merrwarn);
> > > +
> > > +		/* ignore timeout error */
> > > +		if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT)
> > > +			return false;
> > > +
> > > 
> > > Is it okay move SVC_I3C_MERRWARN_TIMEOUT after dev_err?
> > 
> > I think you mentioned earlier that the problem was not the printk but
> > the return value. So perhaps there is a way to know if the timeout
> > happened after a transaction and was legitimate or not?
> 
> Error message just annoise user, don't impact function. But return false
> let IBI thread running to avoid dead lock. 

I forget mention one thing. Any error message here will make SDA low for
longer.  Before emit stop, SDA is low.

I have not checked I3C spec yet about how long SDA will be allowed. it will
worser if message go through uart port. The bus will be locked longer.

It's better to print error message after emit_stop to reduce SDA low time.

Frank

> 
> > 
> > In any case we should probably lower the log level for this error.
> 
> Only SVC_I3C_MERRWARN_TIMEOUT is warning
> 
> Maybe below logic is better
> 
> 	if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT) {
> 		dev_dbg(master->dev, 
>                         "Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
> 			mstatus, merrwarn);
> 		return false;
> 	} 
> 	
> 	dev_err(master->dev,                                     
>                 "Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
>                  mstatus, merrwarn); 
> 	....
> 
> Frank
> 
> > 
> > Thanks,
> > Miquèl
