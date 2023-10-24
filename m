Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255287D572D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343995AbjJXQAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343676AbjJXQAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:00:08 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2047.outbound.protection.outlook.com [40.107.247.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB3610C3;
        Tue, 24 Oct 2023 09:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMbU9rxKzMqUQjou+2tineTc13jXtJtvsILCKh+PLaa+zkNnlQu16bL+JEhO/Lv8lHgYpyxG3aoAIrPsRslLfE0dSI4CWwiPFzZVTckfRezqh7OenmYdPj6yps5twPOJpn5XpY9H0O9JY0I02u6SGqi7107xijgkNHYum4jTf6iRWsZTIo+OrGr5P2xQOezXQB1mjkkTuXwGJMnfhvhvQsBhc3wvZp9u2v1600KMUIEXZo87sX+2Bct/sNX1toBdmrZO8cZjWA5BDfyHQiPQqZhR9QSQ/GU+1uPYggGl4hSwT8wZOhBBKCfe9q9Z3bt9Hc5K0J8L0hnWMql7Cnp3Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWuPLt4IYPBsZNhhoL1fbPUfbrSRZ3eMEQjHgEVQaV4=;
 b=OEtTYTC97xp6desMGAxm/nC3H89NOE3i44tOfKmaDTxRDx8cx85xJ5tJkyjhXuFlc/w/mja22LbnWD9rsF3YW5/AMhDovxoEDHZ902cCOpBGWkurI6qCFARfzMiF0aqWKZ0JCTNSFTz4uD2Zfuq/RwYv8NP+wfdteACZNpJHNlVf5oDJcfJgpX99SqTrLahl1WwduspYYiysj1M2g+4Jkd3h2jINn7NZBCnHUpHc/363+ZLlikLqvPVWIIRer6yHu714Vqf+gRWgNhk6TeM5cXLd6PdLzbKdXBCe3yxHnp1llwU20LwI21Qnj5RjYQSQlNWF4N1VTIS/mDEGxGYFsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWuPLt4IYPBsZNhhoL1fbPUfbrSRZ3eMEQjHgEVQaV4=;
 b=IKhP/j/LuhgxX3AQ2P1U8sKWHL+neSAPPgJpdbSmLgW1UC6FdAwpC6wyO2VFFMXXXVbL0OFs2CRXbP8lZWiL672XKRMYvvSQU6Vyw1RdWai9YbY8Sn9dZ9WESU6urIycWbNxZXgmoi9s6x6k71qYaI+tO7xc1mR0/C3xc3kmx6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB6991.eurprd04.prod.outlook.com (2603:10a6:803:12d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Tue, 24 Oct
 2023 16:00:01 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098%6]) with mapi id 15.20.6933.011; Tue, 24 Oct 2023
 16:00:00 +0000
Date:   Tue, 24 Oct 2023 11:59:53 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, jirislaby@kernel.org, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, miquel.raynal@bootlin.com
Subject: Re: [PATCH v2 1/1] tty: i3c: add TTY over I3C master support
Message-ID: <ZTfp+c60YOiwDUFd@lizhi-Precision-Tower-5810>
References: <20231020160027.3663772-1-Frank.Li@nxp.com>
 <2023102105-outfit-legroom-1633@gregkh>
 <ZTaewidgtcDaBega@lizhi-Precision-Tower-5810>
 <2023102457-galore-uphill-4c84@gregkh>
 <ZTfVV3DW8jqH6ek9@lizhi-Precision-Tower-5810>
 <2023102442-immorally-repost-e736@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023102442-immorally-repost-e736@gregkh>
X-ClientProxiedBy: SJ0PR13CA0207.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::32) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: 30442970-a6d1-44ba-1f0b-08dbd4aa471b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uCKJka3dVEUr8b63vL8lLN0rr3bEoWTu42d7KIeU01EcieHs4wauygnpZNPvWMVsbrNm9JNwrKWBeQhXztqf00owtz3sZZCB2/bvPrWZICPGjEgMz3X1vcloabRf2Kf+W5aKfvRjws0O2O/UhmmDTydYm+e51BxyI7QiuFQTJSwpI6TRFG35MIM7xmsgVaxK96qAbYbS/TesWCmudzGJ11TS8pisbLr/rXH3fEBGnWfPKOMRjXuup1re4TzKsItF5bb5ba5YnClvfNF9P1wfTmSRtoD5v1oEO3Uy+FpRPvdlwuNAqWyklzfvvHYoGEAL3ZFSNgzXnRH46WOjG5i8tAmh135hYetRT90vOuB8ECIDCnuiUcPxCE/mJBQN1YZxzQAosQYwNPsKBGFt8W/KWd5Ymgh12K+6G5vlgP5hU29oe6HjX+7F4TYSbjE4ekqFhDnqlPosYVB7zDoiqDCuk3u1oZqrXl+aQG53NakZHYMGRLuWY9OngU3KeN32vjwcEd4BKgttB/Xl1Ouo1WAjUCVHTQYpJGecHwwbdR1cuY8r6Oi8pmEHbJl7SkQPrtJFHh6L3e4AdB8sBfVxe3Y+Te5VCTF7smpRko/8zU8UsW4orhYLGDiLT77eqoIGBTRZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(39860400002)(366004)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(26005)(38350700005)(66899024)(66476007)(6916009)(66556008)(66946007)(86362001)(316002)(38100700002)(52116002)(83380400001)(6512007)(9686003)(6666004)(6506007)(33716001)(6486002)(478600001)(966005)(41300700001)(8676002)(5660300002)(4326008)(2906002)(8936002)(7416002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nYicvzx39QvU8u3MuXNZFg/b31ETwmr7ZS1Unts4GSuqbSUkWUtgJ0bGOcdx?=
 =?us-ascii?Q?LHcyfqucuw7fdH740uGWaSYe2Yi0E4XAYysqCZ1XhNIiMKm9HiuAYX5C3NXN?=
 =?us-ascii?Q?SBZn9HVxEEbP+JRaxohnZVpE6BzlKERIgsDsFJCp0b0ufs1G3Wh9N2xhmjKw?=
 =?us-ascii?Q?ALQIvR9juLzk9f4dUEySMIgcnrTPWqiob8KRn3Z6/Ug/W/UhjoSoDNimbylk?=
 =?us-ascii?Q?pEHcuv3DpH8gvBpVzoQmBqJCUZBUL9cCFOYJcJIz6iIxAxOgXO39VCaA04aj?=
 =?us-ascii?Q?t61hxB7HIlJn4lstCnk8dDSjoygtIO5UXaMnxxR4PrCWGegPbqFFZQIKfH7B?=
 =?us-ascii?Q?s3Anrv8h2qBKexnFt6PdHxjbdXad9w6DMqOfzfQS9F3Yqc8gk3Mube5X5JHj?=
 =?us-ascii?Q?/kxdb1uB5Y7zN1y/nIbJrWGBzP2/tf+NMmHAKR9KAuh4noH7oaZhyD2rb9Z7?=
 =?us-ascii?Q?7EvfGCceA/iTh5a09cLHUfj8fz/Z3K+jfb2DQWndhtvJagC9GSwVvm1dPSm1?=
 =?us-ascii?Q?AAi3QT2b5m8lDSv9ETBRfkAP+cQ2j+nOy8x3Yu3ofGv3ltRXdfFuwAtwVaO4?=
 =?us-ascii?Q?7FHlPodnDi48BJYcPmu+Hw6D75QtAvTMHLBIOZ3gFKlVNgZTXhn0Oi+FBCnR?=
 =?us-ascii?Q?DZke+u6xnLeEVXtDn3YT9WwHlHPio0v5+OzwSHaEO19OhSoOvQ8YwLuUQmd0?=
 =?us-ascii?Q?7oIWPwK+Y2aE64/5v1U80x5pi57S21nrES5IKkvsM4Z9Usfbe9AoWGFXEzlB?=
 =?us-ascii?Q?X4v4H+brur5vEmbluNHKat9z80WqTcqZrI4MlD1UMZG2LpMC14g1E3+bw9rz?=
 =?us-ascii?Q?slIS0TEgHcS1gtjWSa+sv2BbtImXgkY6Tdw1LAL0mcBSXriT99ZWYVqs8Gt9?=
 =?us-ascii?Q?7nhS9Jq9GNvfbICa9LjFCLF9vELZCd0Ee/atCxjP6+Kf8DV67Dc7nvD2grUF?=
 =?us-ascii?Q?6adD/YvGc1Fafn6LZQJuuEvVg9lzxlhcvHmqQtIem88rjmWJ7w9laC8xytkh?=
 =?us-ascii?Q?VLVqmORDASIeMbFjqr5d5DCTBAZrE46tBvkCR/9lWZ7EWKGuL39VRzvvN0YR?=
 =?us-ascii?Q?BWWaqEF5jRIviU8D+qUh9aDmi/2qFsg0gb0G9VNVUznh2xSq50kFqvQ38J0B?=
 =?us-ascii?Q?1PGMgS2Jv+sh9hU/Ea4wU1COUJGn81mNZ9OPNfQtG5K4NsLcvYCa58d43o89?=
 =?us-ascii?Q?xb0sGGZKn2EMpUz6z9cbcGWpVY2vvdZyWZQWz2cVodJKUdpHo21fCy98ZOfM?=
 =?us-ascii?Q?qaJEaTvmuUJleDHaDOG61tCKC8zWiwJsW1SoBxg6TKNBijNR8yc6PMJ7UmfR?=
 =?us-ascii?Q?SKcaMRjb0QYdv+q49jltKNh2VYzYTIgRNVp3ZItVj1JcjqsH/rPhHYZ6PFXd?=
 =?us-ascii?Q?bJDTrKzWm18fQVeWv5s2c5ES+JvznvXU1XFU/foFtsqonQ2mA+Z0gRolH9jN?=
 =?us-ascii?Q?WiCNPOJDNdZ4s5wHLkF1bAaWaVZjMZqUBdVPJ2suIS1HrKDhk4fkgTmprX54?=
 =?us-ascii?Q?Y0IazevYTIR6Xtoh0TUIudcXDHKPtGjPDRhCmx7/3IPRTwzD/lhlzgN+QUnp?=
 =?us-ascii?Q?sFc60SDEKV48RIVfvxs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30442970-a6d1-44ba-1f0b-08dbd4aa471b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 16:00:00.7352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPvux32vJjCQSc1qy4XlJosr8Z4bxBDl/R+TF4RaNpeajh0VKZhqxaac9rPG+i+LomnEiGPffyk+aHkYwoYwkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6991
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 05:05:47PM +0200, Greg KH wrote:
> On Tue, Oct 24, 2023 at 10:31:51AM -0400, Frank Li wrote:
> > On Tue, Oct 24, 2023 at 11:30:33AM +0200, Greg KH wrote:
> > > On Mon, Oct 23, 2023 at 12:26:42PM -0400, Frank Li wrote:
> > > > On Sat, Oct 21, 2023 at 07:02:40PM +0200, Greg KH wrote:
> > > > > Note, your subject line needs to change.
> > > > > 
> > > > > On Fri, Oct 20, 2023 at 12:00:27PM -0400, Frank Li wrote:
> > > > > > In typical embedded Linux systems, UART consoles require at least two pins,
> > > > > > TX and RX. In scenarios where I2C/I3C devices like sensors or PMICs are
> > > > > > present, we can save these two pins by using this driver. Pins is crucial
> > > > > 
> > > > > "Pins are crucial"
> > > > > 
> > > > > > resources, especially in small chip packages.
> > > > > > 
> > > > > > This introduces support for using the I3C bus to transfer console tty data,
> > > > > > effectively replacing the need for dedicated UART pins. This not only
> > > > > > conserves valuable pin resources but also facilitates testing of I3C's
> > > > > > advanced features, including early termination, in-band interrupt (IBI)
> > > > > > support, and the creation of more complex data patterns. Additionally,
> > > > > > it aids in identifying and addressing issues within the I3C controller
> > > > > > driver.
> > > > > 
> > > > > But where is the serial data ending up at?  Not a normal uart, what is
> > > > > on the other end?  And do line settings mean anything here?
> > > > 
> > > > Currently, it use slave i3c code. 
> > > > https://lore.kernel.org/imx/20231018215809.3477437-1-Frank.Li@nxp.com/T/#t
> > > > 
> > > > idealy build an i3c->usb dongle to bride it to usb acm. 
> > > 
> > > So no one has built such a thing yet to determine if any of this works?
> > 
> > It is easy to proof concept by I3C slave code and USB gadget ACM, then pipe
> > two tty (ttyACM0 and ttySI3C0 together).
> 
> So you have not actually tested this?  why write a driver that no one is
> using?

I3c slave side tty at
https://lore.kernel.org/imx/20231018215809.3477437-1-Frank.Li@nxp.com/T/#t

I just have not tested tty to USB part. This patch is major for tty -> i3c
master -> i3c taret -> tty now.

As my previous said, two major purpose now. 
1. Save two pads.
2. Test i3c master and i3c target driver. I3C target driver frame was
written by me and posted. It needs a driver to verify it works. In stead of
write a test driver (such as i2c slave, pci-endpoint), it is better to
write an actual function driver, such as tty. It can exchange message
between two boards, which connected by SDA/SCL.

Frank
> 
> > Of we also can implement a USB to I3C class standard, base on this, reuse
> > this tty driver at host side.
> 
> Is there a USB I3C standard?  I see i3c descriptors assigned by the
> USB-IF, but haven't dug to see if there's more than that anywhere...
> 
> thanks,
> 
> greg k-h
