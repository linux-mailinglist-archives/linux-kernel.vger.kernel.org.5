Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E4C7D16B1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjJTT6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjJTT6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:58:37 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B5FD53
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQh5jeHQ6wYoYYUK4LsPwDfh7VqG8OKgldCkp0qe0vAz5876NKKwQdaQL51d1A7abtN01wpZQanl21F7YRFTa9SppIdFPg3WgNfQJwoSfa6hPjZAsLOzEcho56TSYDDxMTEVJMzB/ETRxi8dqv4gpzMkQiN+sySV2rKoBym27+RclNAa5+F7rGKWxB9U6qbNMYZ0gnCUJZP/S9oqAfhKD0/FuQZPvZKS5yl3sl9gQFNwi/nCNebr5rv06SBGgVr9pX75gh7V6Y8FMN6Rbkn6mo6/zO+NRv9/0CkoxY+IrejZJ257Lp1wA+40Gho3V0eT/vpb+S/kpiz52b5KVYDXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2HTqMHvWiLffF7lXvsQxhC49pzmz0g29IypF9xT4a8=;
 b=HbgrVMe/VksM2RLYimM8x1TPfueBVxxMHXJaooRw2U9vSfl1hBVw1aTNBAqYLxLBEO7fcjtrv16at3+ZekUVPukG8nPyNf/7qraz0aUR9ZHLCTCrP6MtdSDHooRwamc+/99r+9RzizpXk/pNMGmTbQ/2udTXEAiOuPMbZrS99E8zJCw2iQv3QOzuMmx2XtzF6SWpZ24h+V+qtrDNTpYMDtIPrMe8lki0Uhr1aN/iu51tIFVjLIhU4QVtElWkzym6KqCFtcSjx5Q4MODj3TYxuCat+Icq/yxUG9TZnZb7LAiLhlcrZYgDZAWRKu4W6l4a2urZgcnhVvCFHR75wS0FqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2HTqMHvWiLffF7lXvsQxhC49pzmz0g29IypF9xT4a8=;
 b=TPQHWKHBVapDONAu514dkmmuYj3aIuqeLqF1ryJLPElqSNYgEbi5A1DnIqfx5q/UEGw7cUs6/yFbNGfNsQKTiBvmG01+jNu65gDp/7Dg5AGHs2ooG/cFQYrM40uWC61dK9Ptqxe1D2tokrj5t4IL/DXZbsXx1F0o7zbS17Pdgc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8164.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Fri, 20 Oct
 2023 19:58:33 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 19:58:32 +0000
Date:   Fri, 20 Oct 2023 15:58:25 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 Resent 6/6] i3c: master: svc: fix random hot join
 failure since timeout errory
Message-ID: <ZTLb4f4WieyLnb6m@lizhi-Precision-Tower-5810>
References: <20231018155926.3305476-7-Frank.Li@nxp.com>
 <20231019084452.11fd0645@xps-13>
 <ZTFNvrsSoHOS3P2g@lizhi-Precision-Tower-5810>
 <20231020160645.67e678ee@xps-13>
 <ZTKMTwU6cVAfGCKG@lizhi-Precision-Tower-5810>
 <20231020163525.66485920@xps-13>
 <ZTKTGG7J55Sj19Nd@lizhi-Precision-Tower-5810>
 <20231020172006.5de0998b@xps-13>
 <ZTKhJOAAz4CaupEf@lizhi-Precision-Tower-5810>
 <20231020190337.13ef5638@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020190337.13ef5638@xps-13>
X-ClientProxiedBy: SJ0PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::12) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: b1877dbf-d046-46fd-32d7-08dbd1a6f009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCRVOKgreKHCHDi/XN+yc8EZY2EPRDb3AhHbl75NXcU91xlWXTu6mwm/BqGGEHoX1DXdI4buA3ztVxmoY1E/XX2uybgx0b0eNvD0eBdgMyTei28xrtGFIFvNpljOxI725rifE6Jxemq9RJEHNH22LZVkViJaFCxzasAhoZoHioFuE7epBE10SEzSkvWrp3498GXb+N6GJvE8+hIw21HBUFSY3dVoDPYUbDg4zUpSrx0/5J7ILmB1vK2W5CqJ/OqqeLUL47BRnqeHYP5/JFhvWtUkB4G2sf2k0M8AhVcch801LF/QxZJPpg3HqeBej2a5V6QSxEf16xIN0aRMI6ctsKckx9/wKRjkYZC3m/3oVk9xGbsK+OqEgqKrlVxdLXyuPhQNYK7cah4gxmG8XCdEeHCXUcNVCk3J6/+C47Lva2Xcock74r4wgIMW/fVuDtstZPYhgTiszdW7ZUbu812qbUL+7QhqmQBO1XAdAZfyZqTQ/5ArfV4ye3dUIkmklu22U6zmIkgelK3/v2hwx6qTacbNUMQ753pHu9AVkc/KDNW7X5cop3xwQTYm+96oD59dkr1tYH9GNGC0b29Q5diFvIOIMWdRx14BcPG3wVCLLcFekfODE0d1jjayDF6WkiVx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(39860400002)(136003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38350700005)(6916009)(316002)(66946007)(66476007)(66556008)(86362001)(38100700002)(83380400001)(52116002)(26005)(66574015)(6512007)(9686003)(6506007)(6666004)(478600001)(2906002)(8936002)(6486002)(33716001)(5660300002)(41300700001)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fcljvdrrLDy+bHUi90S0oKpGPdjK11XpZeP+2roaPVxgtTjQJD0EcVkb6t?=
 =?iso-8859-1?Q?3T0iBEwzbBOuTi0JniRFt4u9OXstmSj7Qn4FjQlX7S+pa0b3WZU89T3wJF?=
 =?iso-8859-1?Q?gBlJDFs2p2mgvFJYzw5XSHHpB6HcWjsHIpqmixits7Wdri6Che0CZpzBES?=
 =?iso-8859-1?Q?8tBI/pddDv1DMKDLv3jY/gMXGpishHOeUYoiwOWEcY3ze/pVOlfSjn8hhc?=
 =?iso-8859-1?Q?JQrrRclwNy7Ah98Qi/b5wM1Cd8ZHyxLHfnJAIWB2jwcEDY5/SQJwHDxlFQ?=
 =?iso-8859-1?Q?PgKVHiG8j5hCuuWlGckBiVB0c+ERTo+MgUFJ5LcEREoQQoQtOzat9+3ZlO?=
 =?iso-8859-1?Q?tsyozh1wE2I4vVE9MM74ANgqXnfaPzC6sSgzB+c4okbZVeu3cG2Tf/oXcW?=
 =?iso-8859-1?Q?jWH9LwCrx7+0d+BSvdczldTxs1qs6iqvZUw7aJN9hAnveRDJY9WDyfCQ0s?=
 =?iso-8859-1?Q?tcN+wh5463x/CWz+tMz5hKZ0fRGFTCQFW3EW1bxseHi2WDjinZBo2t421u?=
 =?iso-8859-1?Q?cysk8t4hw3+R1QHqWBE4LdxUaA0aue/iH/BFPhvY0JUH3i4TGUDZEcxJei?=
 =?iso-8859-1?Q?ckzEXB6zWRtNG73+WCkzmnRjyrjxuuN5oHmZxp04eiFUG0MhZ7AclhHRlH?=
 =?iso-8859-1?Q?hy349iS7yLgecu8e8/7gKMlag4pf7ZM3ZznaYzdxAmEHudn47aoBz1Bsh9?=
 =?iso-8859-1?Q?X7C9sNFoqPEXye9DAjck8V/NxfB4h5b2e6HjIqlE4r/EhBaYpMpZH2FdNw?=
 =?iso-8859-1?Q?fyWenEqLkdxDCzgnHV7ZxFIfN3MMvxvv9F3pgFNSAOFpTjBHpzMRWi1/TY?=
 =?iso-8859-1?Q?UT/JgKUBFrXr5lPMvFl5LQxq8oKV1xQMQbWPgTHIMxGNIlhKjT+SlJPtAk?=
 =?iso-8859-1?Q?qFx6H4GjevyPe5ZodWEy/vi7rfbE6IitqwoIo0qYNyZU+YLtF1Jpi3feC/?=
 =?iso-8859-1?Q?jFRtKHjD+qiXHS+4fy2WIoRDPU/5Tox1ifKNdfyE4iCsk41g1xUNB2b3Gi?=
 =?iso-8859-1?Q?GZdnX23aGO/zEpES7irJZHLUlmHSC//I7qttG2RKZmAdegsTxOjmUbpr06?=
 =?iso-8859-1?Q?riAGjsVZvvvs2yyvIsFXHCnJ/QX5WIW2fAO9IuAfa8pYm2I9yKN/S8zlqU?=
 =?iso-8859-1?Q?aDeTHMsxcAFzvu7pGbzsz/JWlBOlVcaKRgRX6prvFjSgkYtPX1iCLwbiDy?=
 =?iso-8859-1?Q?hhm3yR/g3kx1gQ4DquaFp63O3tKG6E6coWWu9EGvEVUQ6fWlr1TGHgdevQ?=
 =?iso-8859-1?Q?LnuniqqnGjvIba/LrKC8ibOmJsGO8OapdqQ+7CML+zhBd57XM9+lEQX2gn?=
 =?iso-8859-1?Q?UT9pk3n0QSMZyBEV3a2/uaWZtbEJv5IMwbqPv3Dt7SkdbjvYGpmYV6V/jV?=
 =?iso-8859-1?Q?itzyKQGQtnJ37w+sblFoAKJ+My9t4BaEy8fezR8uPF6AkFzu8CQ0dBXA8x?=
 =?iso-8859-1?Q?sVJhYHcSAe1AZGoB9pIgdwUq7iFORfgAp1veV4cHGaEfEt9Kj69rx09ycG?=
 =?iso-8859-1?Q?gNteG4fHYvlzjXz8ecX7ZqpMXmnXst5215q6YSxIWE0cj/8hIbVQXXE+42?=
 =?iso-8859-1?Q?OmLGRGuRhVpsYBgPEzTpuS4vilX5OQURSr4dwci/Q3pqHU1WnuYQ653d8k?=
 =?iso-8859-1?Q?1Xa1uHWTRgew4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1877dbf-d046-46fd-32d7-08dbd1a6f009
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 19:58:32.7143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PgalJOQzX4McW/e7Vqy94gVm69Qi+GNEUuzHp3J6NJu0prB4XjAxtBvRZouhygzL1JwWcPnpv3QWtSngTckug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8164
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 07:03:37PM +0200, Miquel Raynal wrote:
> Hi Frank,
> 
> Frank.li@nxp.com wrote on Fri, 20 Oct 2023 11:47:48 -0400:
> 
> > On Fri, Oct 20, 2023 at 05:20:06PM +0200, Miquel Raynal wrote:
> > > Hi Frank,
> > > 
> > > Frank.li@nxp.com wrote on Fri, 20 Oct 2023 10:47:52 -0400:
> > >   
> > > > On Fri, Oct 20, 2023 at 04:35:25PM +0200, Miquel Raynal wrote:  
> > > > > Hi Frank,
> > > > > 
> > > > > Frank.li@nxp.com wrote on Fri, 20 Oct 2023 10:18:55 -0400:
> > > > >     
> > > > > > On Fri, Oct 20, 2023 at 04:06:45PM +0200, Miquel Raynal wrote:    
> > > > > > > Hi Frank,
> > > > > > > 
> > > > > > > Frank.li@nxp.com wrote on Thu, 19 Oct 2023 11:39:42 -0400:
> > > > > > >       
> > > > > > > > On Thu, Oct 19, 2023 at 08:44:52AM +0200, Miquel Raynal wrote:      
> > > > > > > > > Hi Frank,
> > > > > > > > > 
> > > > > > > > > Frank.Li@nxp.com wrote on Wed, 18 Oct 2023 11:59:26 -0400:
> > > > > > > > >         
> > > > > > > > > > master side report:
> > > > > > > > > >   silvaco-i3c-master 44330000.i3c-master: Error condition: MSTATUS 0x020090c7, MERRWARN 0x00100000
> > > > > > > > > > 
> > > > > > > > > > BIT 20: TIMEOUT error
> > > > > > > > > >   The module has stalled too long in a frame. This happens when:
> > > > > > > > > >   - The TX FIFO or RX FIFO is not handled and the bus is stuck in the
> > > > > > > > > > middle of a message,
> > > > > > > > > >   - No STOP was issued and between messages,
> > > > > > > > > >   - IBI manual is used and no decision was made.        
> > > > > > > > > 
> > > > > > > > > I am still not convinced this should be ignored in all cases.
> > > > > > > > > 
> > > > > > > > > Case 1 is a problem because the hardware failed somehow.        
> > > > > > > > 
> > > > > > > > But so far, no action to handle this case in current code.      
> > > > > > > 
> > > > > > > Yes, but if you detect an issue and ignore it, it's not better than
> > > > > > > reporting it without handling it. Instead of totally ignoring this I
> > > > > > > would at least write a debug message (identical to what's below) before
> > > > > > > returning false, even though I am not convinced unconditionally
> > > > > > > returning false here is wise. If you fail a hardware sequence because
> > > > > > > you added a printk, it's a problem. Maybe you consider this line as
> > > > > > > noise, but I believe it's still an error condition. Maybe, however,
> > > > > > > this bit gets set after the whole sequence, and this is just a "bus
> > > > > > > is idle" condition. If that's the case, then you need some
> > > > > > > additional heuristics to properly ignore the bit?
> > > > > > >       
> > > > > > 
> > > > > >                 dev_err(master->dev,                                       
> > > > > >                         "Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
> > > > > >                         mstatus, merrwarn);
> > > > > > +
> > > > > > +		/* ignore timeout error */
> > > > > > +		if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT)
> > > > > > +			return false;
> > > > > > +
> > > > > > 
> > > > > > Is it okay move SVC_I3C_MERRWARN_TIMEOUT after dev_err?    
> > > > > 
> > > > > I think you mentioned earlier that the problem was not the printk but
> > > > > the return value. So perhaps there is a way to know if the timeout
> > > > > happened after a transaction and was legitimate or not?    
> > > > 
> > > > Error message just annoise user, don't impact function. But return false
> > > > let IBI thread running to avoid dead lock. 
> > > >   
> > > > > 
> > > > > In any case we should probably lower the log level for this error.    
> > > > 
> > > > Only SVC_I3C_MERRWARN_TIMEOUT is warning
> > > > 
> > > > Maybe below logic is better
> > > > 
> > > > 	if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT) {
> > > > 		dev_dbg(master->dev, 
> > > >                         "Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
> > > > 			mstatus, merrwarn);
> > > > 		return false;
> > > > 	} 
> > > > 	
> > > > 	dev_err(master->dev,                                     
> > > >                 "Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
> > > >                  mstatus, merrwarn); 
> > > > 	....
> > > >   
> > > 
> > > Yes, this looks better but I wonder if we should add an additional
> > > condition to just return false in this case;   
> > 
> > What's additional condition we can check?
> 
> Well, you're the one bothered with an error case which is not a real
> error. You're saying "this error is never a problem" and I am saying
> that I believe it is not a problem is your particular case, but in
> general there might be situations where it *is* a problem. So you need
> to find proper conditions to check against in order to determine
> whether this is just an info with no consequence or an error.

I checked R** code of this TIMEOUT, which is quite simple, set to 1 if SDA
is low over 100us if I understand correctly. I also checked, if I add delay
before emit stop, TIMEOUT will be set. (Read can auto emit stop accoring to
RDTERM, so just saw TIMEOUT at write transaction).

TIMEOUT just means condition "I3C bus's SDA low over 100us" happened since
written 1 to TIMEOUT.

I think "I3C bus's SDA over 100us" means nothing for linux drivers.

I think there are NO sitation where it *is* a problem. If it was problem,
there are NO solution to resolve it at linux driver side. And I think it
already happen many times silencely. 

Frank

> 
> > > something saying "this
> > > timeout is legitimate and has no impact".  
> > 
> > Add comments "this timeout is legitimate and has no impact" or dev_dbg
> > print that?
> 
> No I'm talking about the additional heuristics.
> 
> Thanks,
> Miquèl
