Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360527D171E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 22:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjJTUgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 16:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJTUgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 16:36:21 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2046.outbound.protection.outlook.com [40.107.249.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E142C0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 13:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjTy092vKx/ci87zJTJYnmD9I6lkXs23blrN0mE2ztHOALf5FNYqbSCfop4gvrwEcuCGz0ajIM/AHWHbjhzDNjrCQRjeS5/dtBN7E2kw2JGFVCyE2ynaLjs9d4hF9FTEfvhz1vGTCoH2x3mPIboP/PJKfBIX3bQyl8r28CKcx/WvGVnaIR5Eqy7A9mPwY4W6r3TuYXlbGv2POKqttnlRffcnhvtg0PkHuibVQv9rbgnqpTk8ZJsMoz/cejI4qjQxXQTjBNZXi/j8qXfvxcAZ7GnyyjepjeT/a+deI4s4LzWayXe796AwWdd6qa1zpqxToitKluPSbjRI+D6zJ2KHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRyWqnB+02XGFWGf6Y8vAWk5slkhEGQs809WbJuR/Co=;
 b=Ru6qCIpHbP17ynT8y9UOPs2JNx9YRuMkad+h3PhZAw1YikLN3AEtmJ4t5SwVnfIKtGTp7zsrH87uptS7Ge2rIkgidwVSOHgt4CvQjsvxty9Me7/4AfCkSMjjhxzdENV3OtKqMznhP1+2WfPU4N6FeNiSU9b5AwOmMUv9xBbosurhBcHkqoJT1lqfmumebSNI9/YroEBxIo/C3a3InSeAlUp6ScDZHpVkwkLO4MH9YDutEVHfmgnYmVrLcnmcuavshtXB4dR6HbOZ9e1dANQicEd5BC5bh4+tBJnSY9Rm6SJOLoIgAbWqlXt0FL4LdU5+Y3yOfK/PSrOUEUWLbJI7nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRyWqnB+02XGFWGf6Y8vAWk5slkhEGQs809WbJuR/Co=;
 b=HguSkWXDtaOzN0nO5+7wXhlyjigITNrZMRRh3aXi5xkrKS4W9sjg/s5SLbfseUERnJWwqMmhIjbFzpY6N2h3sauxX5WP3Cl1cMUhbXyLgiecGCjK1p4yicFB5e/qXgiHGNRhL+SbzeTlBs06ocOb9xh5+mydgvJohSfv1DiGDiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.9; Fri, 20 Oct
 2023 20:36:15 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 20:36:15 +0000
Date:   Fri, 20 Oct 2023 16:36:06 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "Zbigniew, Lukwinski" <zbigniew.lukwinski@linux.intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] i3c: master: add enable(disable) hot join in sys
 entry
Message-ID: <ZTLktpI2rbAT4Ztb@lizhi-Precision-Tower-5810>
References: <20231018205929.3435110-1-Frank.Li@nxp.com>
 <20231018205929.3435110-2-Frank.Li@nxp.com>
 <57efe6de-cf65-32ed-fd1e-a388e1676c70@linux.intel.com>
 <20231020154528.2f5f68f5@xps-13>
 <ZTKMyW939rB6sSKq@lizhi-Precision-Tower-5810>
 <20231020163348.1752167d@xps-13>
 <8a7ac52e-f102-6f5e-35ab-217e6ecc6ba5@linux.intel.com>
 <20231020202519b2449707@mail.local>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020202519b2449707@mail.local>
X-ClientProxiedBy: SJ0PR05CA0187.namprd05.prod.outlook.com
 (2603:10b6:a03:330::12) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: d698f3e5-4a0e-48b9-44f7-08dbd1ac349d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RHIjfSpdGCq1If7+duEfbDL8Q9J/3naUncfZ/31m8xoKOKoCimDAc5yuvcRaaNk5cx5S17b+rA2tu1FwUMKj44zcyPtAvZmvaxbskzgQIA/2q0JLARXZboZGqfxgLJcjvPNLlLUGSibVe7mmpUmVGzZnNFByXDACF5nwMgCtpEgTPdVg+hGr9zZPqzANWAoJVNulBKN1rzXjtHjwA+2jtIYf89z1cBicNpx95FZ0ccgixdLlZOspBFIjEFr5+k02+629ZNksLEPm+1l1uWfq/bLItFBIsfbqWm5/nFsFMYOdAGcjrYH1mQozR3x/qp0C8Hs0KRP9YteAYXuA1QozLuYFSOipICtldhfZvV7CFES/clwKha5GJndrU9qbe8T2j8Mic5f/D2MXfqTNEfWvqaCmzprdQncKkuB6oTUnB3PKzHptFDnu3gWTm77w1MmkkbzQwajngkbl/uHdXeI8aP8s4qI3Px32nx6H5I2tC8JWSh19PDN9+9J2c4knZhV49eqNyK/MoWEXiJ5+N64LqY6jBHswPBIzwyAXLCvFcvfg/p9svWaz5NV/bNHw855eOL39a5qXjEeqXS3jut4FES6M8b9BWnM8gyVvfuTrNog=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(136003)(396003)(376002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(33716001)(4326008)(38100700002)(86362001)(6506007)(41300700001)(2906002)(6512007)(66574015)(83380400001)(9686003)(53546011)(52116002)(5660300002)(26005)(6666004)(966005)(6486002)(8936002)(66556008)(66946007)(478600001)(54906003)(66476007)(6916009)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?cJSrhbErpvjM8NC0s2YHf4XDhOhTrSgHFNtegRIAVv3gZiYwH/KFTeKgfY?=
 =?iso-8859-1?Q?/oPwnAc988ejTZI6+C2FVR0JE6JUWq7ep12BQ36P1gyG2UqNwv2hGl1oT8?=
 =?iso-8859-1?Q?vFLIHnwyP2kHN2AeLoOld+BH2hvybxJ/gFD4ZhoePmsF/aht+RsDZ//4lW?=
 =?iso-8859-1?Q?NMIswXoVU7qGhMa33W7pJ0iqhX+ocvtj86tm6RIbgG7AA1Ot3S5baOAbTb?=
 =?iso-8859-1?Q?c5l82L/tPvhRIZsYPB3PeGspVsfcxdLa2a4yWqyTSWcjb6RVabNVo5LqW2?=
 =?iso-8859-1?Q?sUNJFmV1AJ40s+E3C64+JTU2FswQDTFpSASziGofj5R9ypxe/3nKQ1N1ny?=
 =?iso-8859-1?Q?yUoGr+60TE78Y4F6DXwWip/i6721hXYiqBppBW25ZF6LqNKgsKfLJFOBIZ?=
 =?iso-8859-1?Q?YEBOePffjhfoMbFk8QQjmAIwdWJ40ESFn0B9jI4pvxE74P+EWhOZDNNsbS?=
 =?iso-8859-1?Q?dtJyYkpm61eP3/zk1xVJFPE6nGiRR1qWcP9q7quNb44WVu+/8tRY5EL9UV?=
 =?iso-8859-1?Q?3XcR71Ou5OdKnXEmBwg8fe+UZqBQfozbap3uvhgcV9Bo6KxqA/csS7+rdJ?=
 =?iso-8859-1?Q?U7PGkb0tss+FhN6ky5TKt8520qqsyOMq01lFUzHAU7No9HYEqxh16jmB+9?=
 =?iso-8859-1?Q?Zr+ku6fRHDhrUgwsGhyRZeZxMEj4dAfJ6OeXs7hPJ2hmdeFyX/RqKpDSx3?=
 =?iso-8859-1?Q?4llj4pkJxZlq9c+/dytH3eHX5NRit4tMJWSrOjSwu018U+zh+KWoltf30R?=
 =?iso-8859-1?Q?xEzkfEASIQrwE7uGtFjPTuOOtqnWkOSc23dTl9oynxCGKYxte7zjisYaEn?=
 =?iso-8859-1?Q?IgpTRC4ttWK8VDYDit6lSHLTTdhpX96eTWlsUsbBuRicRg72ypRDVteQDH?=
 =?iso-8859-1?Q?gc9P0h3/KATpWBmXz/YEkdJyClyxNAaqI/jPGuJr5cWElhUmBoH95rNcAR?=
 =?iso-8859-1?Q?jGvBsjloRUfPY0J6TP1Gczul9TkG5rn9t1M6S47mcWddigZeYQgKpI5PcN?=
 =?iso-8859-1?Q?0fZg62yaghcU5kO/dfUkr+oJlU6JaaZMjqDyInWvaa91lgVY4TBbsO6Yab?=
 =?iso-8859-1?Q?0cZKzCvfEw/4avOCXij210amf+ik3YLlgoKVdeFnaCUqVgP6YW8w5cz9bL?=
 =?iso-8859-1?Q?rWQgn+YpU0zCPN+gz8twSA6LgJ2jwtmai8N5Zoet0R1clAwRi20uHf1uDr?=
 =?iso-8859-1?Q?F/TIbYgbvMwH0EhlXVXppan7kZDjFQX/F1baWP8T4R1yjUfuqe3I3pcKNk?=
 =?iso-8859-1?Q?gokUTYD3Y0iJq6lE6bR0WlHh13/YuivU0VjifljAbolk/oq9cSUBT7JVlW?=
 =?iso-8859-1?Q?ag4fKa2QmE22LgpOtcjKT+TYsHsuWZBWm+NTx7vAE9kgjExSdbBJkVIgA1?=
 =?iso-8859-1?Q?vQRgu5hH0NqpEfJzpJ0vkEH9zAuB625MkMu4mtkG3RUtKMC4Atikx/2p9W?=
 =?iso-8859-1?Q?aMVUMZsuCuBwt6pwFquY4qpbLA9J//c7NQkSNojHHAjmAC2q88tuYFhZj5?=
 =?iso-8859-1?Q?+FjFSfb29dPaiQQ/geaXYD2E4LJJGgstxuM84uE4ipSOCP5o5bbBO08IQ+?=
 =?iso-8859-1?Q?T6Z5CqtypdGvoU6dWidVhueM/SLLrnQoCcz4ilrE4rk0OPyoijzvrFl4uA?=
 =?iso-8859-1?Q?UF8RMLFtW/6uhKlE6Qz3JzzA4rlP1FYir3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d698f3e5-4a0e-48b9-44f7-08dbd1ac349d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 20:36:15.1653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPkB3SHEQgUAurfCooqvQ02STHZ0gWgpKuygAyXyWqqc71cYysy7JogKW2uy8uJ0MdXvNBXpYbZwCEQPD2VUbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8107
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 10:25:19PM +0200, Alexandre Belloni wrote:
> On 20/10/2023 17:12:53+0200, Zbigniew, Lukwinski wrote:
> > On 10/20/2023 4:33 PM, Miquel Raynal wrote:
> > > Hi Frank,
> > > 
> > > Frank.li@nxp.com  wrote on Fri, 20 Oct 2023 10:20:57 -0400:
> > > 
> > > > On Fri, Oct 20, 2023 at 03:45:28PM +0200, Miquel Raynal wrote:
> > > > > Hi Lukwinski,
> > > > > 
> > > > > zbigniew.lukwinski@linux.intel.com  wrote on Fri, 20 Oct 2023 10:55:27
> > > > > +0200:
> > > > > > On 10/18/2023 10:59 PM, Frank Li wrote:
> > > > > > > Add hotjoin entry in sys file system allow user enable/disable hotjoin
> > > > > > > feature.
> > > > > > > 
> > > > > > > Add (*enable(disable)_hotjoin)() to i3c_master_controller_ops.
> > > > > > > Add api i3c_master_enable(disable)_hotjoin();
> > > > > > What is the use case for having HJ enable knob in sysfs available for user space other than for debug stuff? In other words, does user space really need to enable/disable HJ in runtime for other reason but debug? If it is only for debug maybe it  could be move to debugFS?
> > > > > I don't think hotjoin should be considered as a debug feature. The
> > > > > problem here is the power consumption which is higher if you enable
> > > > > this feature (you need to keep everything clocked and ready to handle
> > > > > an IBI) whereas if your design is "fixed" (more like an I2C bus) you
> > > > > may save power by disabling this feature.
> > > > > 
> > > > > A module parameter does not fit here because it's a per-bus
> > > > > configuration.
> > > > I agree. sys entry is more flexiable. and let controller choose better
> > > > power saving policy for difference user case.
> > > Maybe it's not the first time this case is faced, would you mind
> > > including power management maintainers in this discussion? Perhaps they
> > > might have pointers or even have the solution already.
> > 
> > I did not mind HJ as debug feature. But enabling / disabling the HJ sounds
> > to me like debug option.
> > 
> > So the flow you are considering here is like this:?
> > 
> >     1. system boot with HJ enabled, so HJ works during initial bus
> >        discovery
> >     2. some entity in user space decides to disable HJ because power
> >        consumption?
> >     3. some entity in use space decide some time later to re-enable HJ
> >        because some reason?
> > 
> > I am just wondering whether there is real use case when you starts with HJ
> > enabled and than disable it

I think it is validate user case. Assume a I3C GPS device, user only use
it when open map. Before map application open, enable i3c hotjoin and
power on GPS module. After map application close, disable i3c hotjoin and
power off GPS module.

Frank

> > 
> > in runtime or start with HJ disabled and enable it in runtime. If you are
> > taking care about power saving
> > 
> >  let's keep HJ disabled all the time. Default state for HJ could be
> > controlled by DT entry.
> > 
> 
> This would be HW configuration and not HW description.

Yes, DT maintainer may not accept this entry because it is not HW
description.

> 
> 
> > 
> > > Thanks,
> > > Miquèl
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
