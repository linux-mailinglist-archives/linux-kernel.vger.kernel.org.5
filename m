Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCCE7E141C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 16:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjKEPhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 10:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKEPhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 10:37:01 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2041.outbound.protection.outlook.com [40.107.14.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B8FA7
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 07:36:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDdKLQvKv5KyYzKh9s9IGhiL1+QAXGh0rTicXrZ5EaOLiXcclctE8GaUt3Wwydcs37wZ1OJaCzeaMPFPLTn9YMRWS6nzRO4OVfHmCEAS8e8bkALu2UEjOi+yDrGZrHl8JQQsVVqTMlCNA9DyHRvLldNTxW/D/8yjBHu+WZaVOzXNELNcG1LiaMNjWk4hxM759ydn44eP28vl8l0AauyPrMbGHJG2KwxE4xIS+hICRBJBqhnEVFpTUtcJ42q/+Ery2bbj9TWSr8PT/8pq/pZHgnLxmQbfCuEJ9sp+80uJ4maWito/gZ1IsFaYHEgRtmAk5vF2Juh2en/wv48BXCRuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEh9gN5qE3yQe+vn+12QjSRTTZxQK3bGFlEzGq1KHGE=;
 b=XYyPrGPDJ36MlMTiAyLDDLKIT/vlvgnSQSU7jXJJNQRxPriscad9S4dSmmAwoEn+8oewTwOPIskBRMRSAGewVCqaI4dXhL1TMGbi20aHiEkaZkRLsgNwnKeYNiSQy5Sk2OIXXYlY5H9sycsrsjNi5OIOmWBxYebuDWgYRstd0eiKeXQl+kjndQ/t4jNogic3uRpvF3vdCE3Hgg8WmtAglsIE6UhhQntTAa+oeQmB3AZEqSLtUazm8XCSrG7+Apy3+Bn3AWQU01EDczrP5gOy7UjhLVrz4r4DW9Ojt3bUds0rTOk1rnGVROYxHZxG8LLTgJwI0fVKU/gKo6ZPCrEHxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEh9gN5qE3yQe+vn+12QjSRTTZxQK3bGFlEzGq1KHGE=;
 b=InI0kL6Dbtb4aWMNTVOL7rj1GMn53215zvHV9BIIxKFn/rR3FP7OvTI1O3q/cR89VjOMUslhrMP6h7yBZIGghhfxE8haoTVpg7un4jVN7SHPZTAUPDhcngBVtXW38pADOSMrvtqqm7aTUu+tl5I0U5IWe3++4KUnuKTd5DJXeV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8914.eurprd04.prod.outlook.com (2603:10a6:20b:42d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.11; Sun, 5 Nov
 2023 15:36:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::2635:52a:c866:2576]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::2635:52a:c866:2576%6]) with mapi id 15.20.6977.013; Sun, 5 Nov 2023
 15:36:54 +0000
Date:   Sun, 5 Nov 2023 10:36:46 -0500
From:   Frank Li <Frank.li@nxp.com>
To:     "Zbigniew, Lukwinski" <zbigniew.lukwinski@linux.intel.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] i3c: master: add enable(disable) hot join in sys
 entry
Message-ID: <ZUe2jpMa6ntsDVPg@lizhi-Precision-Tower-5810>
References: <20231018205929.3435110-1-Frank.Li@nxp.com>
 <20231018205929.3435110-2-Frank.Li@nxp.com>
 <57efe6de-cf65-32ed-fd1e-a388e1676c70@linux.intel.com>
 <20231020154528.2f5f68f5@xps-13>
 <ZTKMyW939rB6sSKq@lizhi-Precision-Tower-5810>
 <20231020163348.1752167d@xps-13>
 <8a7ac52e-f102-6f5e-35ab-217e6ecc6ba5@linux.intel.com>
 <20231020202519b2449707@mail.local>
 <ZTLktpI2rbAT4Ztb@lizhi-Precision-Tower-5810>
 <86955c20-22e6-0d02-813f-02f0096c2819@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86955c20-22e6-0d02-813f-02f0096c2819@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::24) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8914:EE_
X-MS-Office365-Filtering-Correlation-Id: 254fe1b7-1625-43d7-98d1-08dbde1509a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QuCn8qKV5vtpcVZ3euvx7w2sGfyZfmQgO6DV7BlxOIaDvpy4mDTcRMCK0UlzQDs1jTqyixrJMj2TpBE8i0VRKyX9HQskTeo4X4HekdYYz6PUS0Mc4Vzc3ZTJjp5jl3GTv/nMgwVxtdG/r65M3R/Blr6SQVyyanhX0XVt2rZwbmfAXrJyG77dOtQA/Xznz4c3HFuskA03jrS8v1erkfxYO4g6nGfZc2JLorAmGvqRE+vk1j7ez6evy9XJU8VoMm6LyXmLbcdnvG+HkmD7pWCDq5DNoZBTNcibB4bc2oEwrZQk8BQmeqGK1otrqXGdKR8nQX9MM7770kwl3TiUGOxt1dVUR6kM/2oYGZkPp+ABIIMFl2Na38UbcjxRR33conQPZyuMyhYNsfMoTy1tMubITHi3buM4MhjtlUemmUAM1HtQNUYXZQt7mtvm/nloJN6rqeC3izegi9NGXzgJtzNX0vAv7Hfxx2gcvk2js2v7EYbRe/rrfW+V9/e5uIRwjkbFH2L6CX9houCc3uoHTLZWap1kuQQyk3OBACg5vLlMzCRFV/c8/itD7ALK+6RJbC1J8vFD8eNXvLVlzWcnqSuIqMqRrTzftYm5HOrVRBXJnys=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(39860400002)(396003)(366004)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(33716001)(6512007)(6506007)(5660300002)(86362001)(38100700002)(53546011)(8936002)(478600001)(316002)(41300700001)(52116002)(66946007)(66476007)(2906002)(966005)(9686003)(66574015)(26005)(6666004)(4326008)(54906003)(8676002)(6916009)(6486002)(66556008)(83380400001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SSXxq4aywfyTR3CIbelK3bmMvKOnCduEhiYHeyG44u14oJCf0c1SbLK/gF?=
 =?iso-8859-1?Q?Mg2b5f8RVq3TXEjMIhLfSL0S/EA7hbT2sHbwRTveHlWQGQTuwopzwYxVFb?=
 =?iso-8859-1?Q?1vMo5IH7jajUh8AVvGLW95wZrl52sjIWkfgw1Sms8Ipvt7cnjW/pHZbxwe?=
 =?iso-8859-1?Q?b0cGHnG428boADvLVTYfA1QG8aPbYVsjYaWb+npmU91f8k19+RzgiajXzc?=
 =?iso-8859-1?Q?yA3TQ1NTYhpqww4t1RNO8G1wsxL+4A6xE3sZbJb6eNEbvC/HgSshOFTyfY?=
 =?iso-8859-1?Q?WM38OiH2GF2c6Ol/f+N1HAEaO/A9mFyvoeJJku6gXzww+0M7jYfJK+X7mh?=
 =?iso-8859-1?Q?7Q9ln9nr/LHTS034RIjXld/NswrqqZTDimeDwjPldaSxJxegCJVZuj6goI?=
 =?iso-8859-1?Q?AaFlMp3PenkFn0Ddp0LGAK2HiDhawNDKfQb1iAbuRQRsv2HtlvCW7zUeZ1?=
 =?iso-8859-1?Q?QLz6wMlP1S9U0oGJ3HhWfR7dgWnInrqlooS40Ot6EjJnnXr0LGYEUtgT6F?=
 =?iso-8859-1?Q?nhat537LdNjs+HyEMwyyXBy8IN6RYokZ1rHC1t+9JYQte5EC4ytTbTWgK+?=
 =?iso-8859-1?Q?MLzfmLK1vWoz9c3R9HNsyuf63/OWFWqogvzw2gLel4CI8dLxAUpsGeqENr?=
 =?iso-8859-1?Q?+96g9vtz66fPDahfbuEKDcGZlp7i7Kh1/2im4QDZGs83Fnoq3fJQ5gy2k9?=
 =?iso-8859-1?Q?S/edMtvCRNY176oul3cNjKrEYfnTpnKzkTT3Rp1o+vLWNdIy9HHKagyYiG?=
 =?iso-8859-1?Q?gEpk9phsxyThaxL1s9KVzONKPM6FLlTSzHsuveDfw9l/wiRyMmJOvY2IM7?=
 =?iso-8859-1?Q?w6IgMzfQ2Q+GUqfbwYm56bmL/eNTKmNCaiUCKcCDP0eKa+DOVozlF+3aw3?=
 =?iso-8859-1?Q?wvFP6aprvSh0Yr3mEerKVQNYXHpJaSbLgM2x1Q7ZkUAa14EuUYFXqKavs3?=
 =?iso-8859-1?Q?dVNlFkhbl82x9YEzLRU+zJM+L3cYW6QKHK62t4VLs4+wjQQ64hMR8fA34X?=
 =?iso-8859-1?Q?XY8NWwLW6SfBiuL6Oa9SxNIDvR7QRjmP8/hQQQrFR1Ged2V1/4ucdcsKAf?=
 =?iso-8859-1?Q?oOw2Q+QGkqLlcRP8dHZgChjjlCaJfXyL54ddRUeCtcRxxjDEdhvlYllhSo?=
 =?iso-8859-1?Q?nI31eunRT5sxlbLwbZ4oIU2GEYYMYTddGi4T5v6JTmnmX4zI/HjH41ItXa?=
 =?iso-8859-1?Q?V8p95wdzdjnzHNaBv3+XMtChG02o3yenkNQ2MJ2JzpF1NEXp9IcXJcEUsk?=
 =?iso-8859-1?Q?Lmgs3uHgWvnZILRXVltYQ7HTyRvbxtmS7aNSjQqVpeyVPTcYKD7s2nXnXu?=
 =?iso-8859-1?Q?fYsOg1EfHP7D0Z7BsF3hV9S647epHyUYoODS9zySncRHNxP/NdHOlBI1NS?=
 =?iso-8859-1?Q?hq0oP3bqv51e5K26Wq/5kCrZhnbVwNMK6IQmZpsDg5il8LsUzmsJCn6/EM?=
 =?iso-8859-1?Q?WmY9enonIOG8rwKv+bvwGZSjUhomE3u7JIE12meP7ZhtvoB23/fXyXa9u6?=
 =?iso-8859-1?Q?b0Yp2+DLQQjU45c/5jBzbmBY3nnNzq1GjwsW+e2IQ2kr5ppUfJvWt6lwlg?=
 =?iso-8859-1?Q?nega7XkJr7EybGAhwLHKLCKA+5DTNNbYDBZU70iabE6zqkvlRWM8MNRPKX?=
 =?iso-8859-1?Q?G5OYk0trVgJeE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 254fe1b7-1625-43d7-98d1-08dbde1509a8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2023 15:36:54.2409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajnpoXlMfLdiMXvTte54meBlTUrvsMjrfg4FLIFpPmvec0PejZDKhYyCUGIUWtAkk7mU9ooKEvrmmTYaCO1itA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8914
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 10:42:20PM +0200, Zbigniew, Lukwinski wrote:
> On 10/20/2023 10:36 PM, Frank Li wrote:
> > On Fri, Oct 20, 2023 at 10:25:19PM +0200, Alexandre Belloni wrote:
> > > On 20/10/2023 17:12:53+0200, Zbigniew, Lukwinski wrote:
> > > > On 10/20/2023 4:33 PM, Miquel Raynal wrote:
> > > > > Hi Frank,
> > > > > 
> > > > > Frank.li@nxp.com  wrote on Fri, 20 Oct 2023 10:20:57 -0400:
> > > > > 
> > > > > > On Fri, Oct 20, 2023 at 03:45:28PM +0200, Miquel Raynal wrote:
> > > > > > > Hi Lukwinski,
> > > > > > > 
> > > > > > > zbigniew.lukwinski@linux.intel.com  wrote on Fri, 20 Oct 2023 10:55:27
> > > > > > > +0200:
> > > > > > > > On 10/18/2023 10:59 PM, Frank Li wrote:
> > > > > > > > > Add hotjoin entry in sys file system allow user enable/disable hotjoin
> > > > > > > > > feature.
> > > > > > > > > 
> > > > > > > > > Add (*enable(disable)_hotjoin)() to i3c_master_controller_ops.
> > > > > > > > > Add api i3c_master_enable(disable)_hotjoin();
> > > > > > > > What is the use case for having HJ enable knob in sysfs available for user space other than for debug stuff? In other words, does user space really need to enable/disable HJ in runtime for other reason but debug? If it is only for debug maybe it  could be move to debugFS?
> > > > > > > I don't think hotjoin should be considered as a debug feature. The
> > > > > > > problem here is the power consumption which is higher if you enable
> > > > > > > this feature (you need to keep everything clocked and ready to handle
> > > > > > > an IBI) whereas if your design is "fixed" (more like an I2C bus) you
> > > > > > > may save power by disabling this feature.
> > > > > > > 
> > > > > > > A module parameter does not fit here because it's a per-bus
> > > > > > > configuration.
> > > > > > I agree. sys entry is more flexiable. and let controller choose better
> > > > > > power saving policy for difference user case.
> > > > > Maybe it's not the first time this case is faced, would you mind
> > > > > including power management maintainers in this discussion? Perhaps they
> > > > > might have pointers or even have the solution already.
> > > > 
> > > > I did not mind HJ as debug feature. But enabling / disabling the HJ sounds
> > > > to me like debug option.
> > > > 
> > > > So the flow you are considering here is like this:?
> > > > 
> > > >      1. system boot with HJ enabled, so HJ works during initial bus
> > > >         discovery
> > > >      2. some entity in user space decides to disable HJ because power
> > > >         consumption?
> > > >      3. some entity in use space decide some time later to re-enable HJ
> > > >         because some reason?
> > > > 
> > > > I am just wondering whether there is real use case when you starts with HJ
> > > > enabled and than disable it
> > 
> > I think it is validate user case. Assume a I3C GPS device, user only use
> > it when open map. Before map application open, enable i3c hotjoin and
> > power on GPS module. After map application close, disable i3c hotjoin and
> > power off GPS module.
> > 
> Got it. I think we are on the same page. Thanks for explanations!
> > Frank

Does everyone agree on this method? If still need further discusion, I
can repost patch 3-6, which is independent on these.

Frank Li 

> > 
> > > > 
> > > > in runtime or start with HJ disabled and enable it in runtime. If you are
> > > > taking care about power saving
> > > > 
> > > >   let's keep HJ disabled all the time. Default state for HJ could be
> > > > controlled by DT entry.
> > > > 
> > > 
> > > This would be HW configuration and not HW description.
> > 
> > Yes, DT maintainer may not accept this entry because it is not HW
> > description.
> > 
> Sure. Makes sense.
> > > 
> > > 
> > > > 
> > > > > Thanks,
> > > > > Miquèl
> > > 
> > > -- 
> > > Alexandre Belloni, co-owner and COO, Bootlin
> > > Embedded Linux and Kernel engineering
> > > https://bootlin.com
> 
