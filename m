Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC357F75F2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjKXOFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjKXOFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:05:42 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B100C198D;
        Fri, 24 Nov 2023 06:05:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ch5wpzDevh/3XldD/rYUAmvgRPRsheRQYvWYX0kUKL9k9CmGyLvg3KTu9sOrHtASDZ/+Bylb+cLpGh5WU9RK2c+kgr0NnjKAr9sQ//LSJxs4cST67xnb0oqSlcQLdNRD6ydJELAAKFJrsV0NWmueQAHlNG0fDniqzHKmZ/n22gt1PqBhLjKa08BHUmOmfuJL0jyCDTIL7xjXB+0urBYiMqen/X1KJXl89s+x8Wh1l+PYB7b8BRC7wpZeKyQhTBKL33NbxBSe0BcGl4BnAxALVDkrQN/flzjYXTok9dUsID1S8zqp55de7qv8fKFktCMuG7PA+jhIXFqXZZMhCc2T6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+nQAjGg01tLbVFfALJExQwr1vo6BbA70/slS9161vM=;
 b=aTzFhTzB413Vg4Z1WwdsfCAqgm8tBQv8g2yTMYYNzJSdVAW3sd6ZQHRyMKRa/jvbwkMDSNb3cObt2qZc/CWssr8Oad0qICSKNFSQEK2uKlc4KmxTOaPWB8UPYUshKOu0ZkjDnrPBh9u3rrGFu4eV0vW12A7fuoTstJGmQSHmCcx2WMnZgVhQFBZOc2f53qjTZLUfD0DBmlDmtWWZ4PgeRKNf8aGankXGVLbmjkXUy8wcea8nmLzjMlt6Ri3bY9Ql6tAf8BCLxu/qNsELVFHhoYl4sKMBuXfEOvvKH56EZaqIeWYdtrnBl7NUIUFP+CQKY0GDgNiBugQt/Zz+OIHJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+nQAjGg01tLbVFfALJExQwr1vo6BbA70/slS9161vM=;
 b=OSeRq3tg+KaFuKNkQop9tXoB5IjYOQrnDuOLxdOBFkBSFW40nXPsL5yKEDzOL6PmOA7ruSwLvb+ALRusMIFbe6ih4efA3LvuIL935efBT7KnsRD0q90Qzex+BlfQzLc141xyLepnwrgIfJXIdb7qIADn3RyFOWoARiwHIYO6+3l0SMtm6sO6K5cgZdg/+6As4IsLjr6m4zD0Q2eJIa6RG0wi3fRiH43YmoS7rWif1yyjaiPziyfxmYkfeyhSTUOoDaVLfHBnwiakpewsG8MnFhubs41FHazNREZ2RmiqMqZ9asVPmZ5oxyDTwBsEC/HDndIe6WY0JA3esABq8OBRfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DU2PR04MB9131.eurprd04.prod.outlook.com (2603:10a6:10:2f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.14; Fri, 24 Nov
 2023 14:05:44 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7046.012; Fri, 24 Nov 2023
 14:05:44 +0000
Date:   Fri, 24 Nov 2023 09:05:37 -0500
From:   Wei Gao <wegao@suse.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     axboe@kernel.dk, hare@suse.de, hch@lst.de, niklas.cassel@wdc.com,
        martin.petersen@oracle.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] block: ioprio: Fix ioprio_check_cap() validation logic
Message-ID: <ZWCtsVw9cHhmkPf9@wegao>
References: <20231124030525.31426-1-wegao@suse.com>
 <160ecdfc-cb58-47fe-b9ce-fd126acc10fe@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160ecdfc-cb58-47fe-b9ce-fd126acc10fe@kernel.org>
X-ClientProxiedBy: FR0P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::10) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DU2PR04MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: 63cfce9d-aeb1-46b8-9597-08dbecf672ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qi5dmV7DqFlectZRX21C1MiGYnTaAjAPFzw+W9p7U1HJTu/UaC0WumZkJruXxddBwVRx4eV/DlKo9nxf+fKkKT3/rcYilbDDJFYAD7AYRX5Z+mT2WMBPZtiJKJzapJEIkEjr2QFrUMbFKIdPvhKwClMFwTHFCuPBm735012m86j8lQgArQzuel4Mf046k+oj382ME8TZ7EV7NcxaDeuAuWpK3Mg+DfSpMqOFyvlMOQvc0bFKRd3breSuNTVKU47tvgn7YMkNcDkPuvU4pCuzg3uxTQxqcRtKKXl8dSe48LQ+7Hvk9Ba2dIQQ10OzLL4Z6pi6WA4TMo8BsK31WjIi77SwHLjSUeJW9Nna7tdz0V4yWquNn8b8caImg2A+xKN03ChrMWVK8u4rdrxhF8jllTddhnDXBOhrJnrX7EYcVlW3lJw6fTcm0IWHDNr7R71JpcrMrm90XSfDWfXxR4456HtpyeGYwE/2yiJD/Jjhcv0EAA+0Q+egx1Cj9hGUfUCASgo/+Q5VA9RZmCdOxnz3bhtAVZt9pSn0fptn/kHtaHWwohoor6CowUo1/61oZTax
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8199.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(136003)(346002)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(66946007)(6916009)(66476007)(66556008)(38100700002)(86362001)(6486002)(83380400001)(9686003)(6512007)(6666004)(53546011)(6506007)(478600001)(33716001)(2906002)(8676002)(316002)(8936002)(4326008)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TyjHbfQ93uvpinIX2OZOO4nF49XiRSCy/R3O1ZI7ChWiPu7HeNQG9cZIed1k?=
 =?us-ascii?Q?nXJI50I0l1OmsdmpSTFpn+ovs6la9gkCSqRAaHuO/a7SvpwUtwZNYqPHzYsP?=
 =?us-ascii?Q?m5L0NXp5nqlHzF603z+FGelciSS70wUjy//LX08SF7H5RSL5/xSbQU08kVAA?=
 =?us-ascii?Q?YjdrzZyQfeVeFvebbUOUmNly8Hk0cNsOt/ptyCDewiQ+c3FeKqOrUyyqUJaZ?=
 =?us-ascii?Q?PgnjL4R+ENgfeyoL11rYTSe4EF1JiDBtKJnv/Xry9JuBeFlfO//O5c2Chc2b?=
 =?us-ascii?Q?JdZn+WQRbq3KVBmUEYPLZeU4sYLGlgmjplnYqfXsH57he6f7yW9eLHhxsvs5?=
 =?us-ascii?Q?5Axw4C9FZFdMGECHlpVTx4T41N4iKvYwinxOZQ2lssHxtB41OZN83oFvPgTW?=
 =?us-ascii?Q?ozq6rjseRhi6UIGuao11hyOFOHq2wyHCG5mBWo1tVx74o049yPaiXui8CUMv?=
 =?us-ascii?Q?eK/A9kj8eS1tDmb0p0KVt5j/fIhpIHsgUj4iIx/Yfwvif+uS08s2Hv/eJiI+?=
 =?us-ascii?Q?KbXOot3j5j3555+XxvKVneMjyZFRw4auruRfFBbX1hcOoRVcUL1CCtRSDQ7X?=
 =?us-ascii?Q?5vm1aDXsSmnwJCkwhEXhG5/WvBwaoaBnUcgUuCLVyfwuEpurIa0S3Xy1aUGg?=
 =?us-ascii?Q?LoHfZnZuER+VhoONSp0zosKxOiBDbw902x397hQo9m6s5lU7u2ZJ851dVCzS?=
 =?us-ascii?Q?g5EXDT6Iq8egMCiTLLF4kvMLfd1hXVJ4cNYI+jqwSUoyONwu46Dy25VreP5y?=
 =?us-ascii?Q?Y40RMN80WjIt7jbuVGxPct36JAZsCb8B++H3Edw1ru+daL1JCqUfZ6+39ZNP?=
 =?us-ascii?Q?H3KTku2ebBiIwUjplD3Fqhwon+1F0RsiGEZu/QA0YbujgfJISjSYzIjBkUZm?=
 =?us-ascii?Q?Dgu2qs1KAdaHIsSOaBXbfwwvrZmQBTIXp5EArTTLVOvuDpVXFN/j4Y7doAMK?=
 =?us-ascii?Q?VEJnOXcULofkuyU/d/fZpBYWa2v8WQmQLg61tNqwTj6xRRYuGeBxgMUr9wEi?=
 =?us-ascii?Q?y8QMtDOkTzlUL8/3xRWEZha8E4p1zgltjV/dVSr5kYrkxInEtLCZFsh1iyqK?=
 =?us-ascii?Q?iBFshx8P/oqgBdMP190M6f/BWbv2k+bAwSdv2R++0hxpoGm4Hq4h6oFH32at?=
 =?us-ascii?Q?yyAai9/ATdP2SSYDI/J11fRnw2f8+j92Vfr3NPKFoILRqrNfx0kOPCo6Ih2d?=
 =?us-ascii?Q?PTBRpP96OrKipezZK1N2tYH7Heq28JI/H76VPTrG89sihyLrHOKggcXjLA3V?=
 =?us-ascii?Q?pd11tm5Mp6CRZG0woJk8XzmSIT7yAWbY6bbTCSKerDI2efiGzesUMJRg6ETJ?=
 =?us-ascii?Q?t4+wSS6wrty8ZnAizRH6BQcACX2ceCeoIKNomY98ZOMQILbD8eh4BgdkVwet?=
 =?us-ascii?Q?7gqkKllbT8quE5k430QHYTmEZyR3WdtXXfp8O1QN2kLoPFrCWTZnigB2s2L7?=
 =?us-ascii?Q?gwpzGQbd7DQ/8UPzF50fHZ1zFg0AiWNhnTWGXlBW/HtHkriKaURqrBXRN5Ol?=
 =?us-ascii?Q?gyEWWoMlg6x/C7lvbd3T4NzfZuFka5e0k3dYsCl9v91AGwTN5Dv2nBryEftx?=
 =?us-ascii?Q?D8vvywn+12JpdFRJUPM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63cfce9d-aeb1-46b8-9597-08dbecf672ff
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 14:05:44.3770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptTzZK/AjxDpVWl8WasgOYgtvhV5uW+e6VpJftVJnXd1bM534e3LXhTr9eq/Lu6E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 02:53:52PM +0900, Damien Le Moal wrote:
> On 11/24/23 12:05, Wei Gao wrote:
> > The current logic "if (level >= IOPRIO_NR_LEVELS)" can not be reached since
> > level value get from IOPRIO_PRIO_LEVEL ONLY extract lower 3-bits of ioprio.
> > (IOPRIO_NR_LEVELS=8)
> > 
> > So this trigger LTP test case ioprio_set03 failed, the test case expect
> > error when set IOPRIO_CLASS_BE prio 8, in current implementation level
> > value will be 0 and obviously can not return error.
> > 
> > Fixes: eca2040972b4 ("scsi: block: ioprio: Clean up interface definition")
> 
> No. Please see below.
> 
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >  block/ioprio.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/ioprio.c b/block/ioprio.c
> > index b5a942519a79..f83029208f2a 100644
> > --- a/block/ioprio.c
> > +++ b/block/ioprio.c
> > @@ -33,7 +33,7 @@
> >  int ioprio_check_cap(int ioprio)
> >  {
> >  	int class = IOPRIO_PRIO_CLASS(ioprio);
> > -	int level = IOPRIO_PRIO_LEVEL(ioprio);
> > +	int data = IOPRIO_PRIO_DATA(ioprio);
> >  
> >  	switch (class) {
> >  		case IOPRIO_CLASS_RT:
> > @@ -49,13 +49,13 @@ int ioprio_check_cap(int ioprio)
> >  			fallthrough;
> >  			/* rt has prio field too */
> >  		case IOPRIO_CLASS_BE:
> > -			if (level >= IOPRIO_NR_LEVELS)
> > +			if (data >= IOPRIO_NR_LEVELS || data < 0)
> 
> This is incorrect: data is the combination of level AND hints, so that value can
> be larger than or equal to 8 with the level still being valid. Hard NACK on this.
> 
> The issue with LTP test case has been fixed in LTP and by changing the ioprio.h
> header file. See commit 01584c1e2337 ("scsi: block: Improve ioprio value
> validity checks") which introduces IOPRIO_BAD_VALUE() macro for that.
> 
> And for ltp, the commits are:
> 6b7f448fe392 ("ioprio: Use IOPRIO_PRIO_NUM to check prio range")
> 7c84fa710f75 ("ioprio: use ioprio.h kernel header if it exists")
> 
> So please update your setup, including your install of kernel user API header files.
> 

Thanks a lot for your quick feedback and detail explaination, if i am guess correctly, 
my test kernel include eca2040972b4 ("scsi: block: ioprio: Clean up interface definition") but 
not include 01584c1e2337 ("scsi: block: Improve ioprio value validity checks") by coincidence.

> >  				return -EINVAL;
> >  			break;
> >  		case IOPRIO_CLASS_IDLE:
> >  			break;
> >  		case IOPRIO_CLASS_NONE:
> > -			if (level)
> > +			if (data)
> >  				return -EINVAL;
> >  			break;
> >  		case IOPRIO_CLASS_INVALID:
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 
