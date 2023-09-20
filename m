Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9837A7064
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjITC2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjITC2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:28:21 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE254DE;
        Tue, 19 Sep 2023 19:28:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEmiTAnxo8RMH+rCb36666afue76zVcOazwcjGgRxvH6P5/eQIInJ5FaKolgaviCYfG87iZQ0JMJRvqpNozNIcfPrKawmuHNQFRqafV5en6va12m6orAOpAC1EAIuE7Q9ynaZG57Ui6UuVt7R4NN/jRtkfscRumLh3klwQMSs6LVS513Xt/jcWNGEWJ9UhBD1HxOvdqVOvfuZSzyugW77ZK+sAXBeE7VEYyD1l0HYskMDnv4xdSOeZxIGAl4o8O4zUL6D7b0oYUqCsCh52suOEz+Yfh+AzholcnhVKVzlPCiy3kMv2jb6aOCF6IHcpu8+NNNQNOsCLKzPPe+678q1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0WIF9TkvfqarH6F8lLCHryMtcTIVQ3k0cw1MNystcM=;
 b=eKgdR+TExiWKYSRyf52RhTbiDSKdv5OHbpQNlF99VYCxiMhrJcrLzTBbWmJu0AXRmPniZuMNl3JiuhNagQ5aHzpfzGumt2dIRf1d2B/OS2MuoIWm29kekGBqtobFevTuCteN3TACuHIxxbUZfuHjsxMjnbUdB9NdpbaC2ar1D2oa95j+mHsy4+Dn1n9IhE1652voQauM95rVXqZarjNDPL5i9m7Q1LBxX8j5seA2SfR6kbTdjeKUNxt7qcqX8IMMhrk/umJoahw4keDWi9YaMN2pUBlIGpbSMShdqCpYoyNhz1/G1ny5+fjCP1VAqkuOZVIjJA5YroFgfgb+knnnjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=technexion.com; dmarc=pass action=none
 header.from=technexion.com; dkim=pass header.d=technexion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technexion.onmicrosoft.com; s=selector2-technexion-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0WIF9TkvfqarH6F8lLCHryMtcTIVQ3k0cw1MNystcM=;
 b=jqWUUFpMfVxkjqD0IbFP16ynHydNU1HD9h1FHccEddQvAZwyUkMMNREOgM/UFYyxxWWQE36B6YWAsfLKIK/pvILXnD50z/CxV9e62hh3FiT54NqqFvF/gURc4vNYzH8QfmGV83HS1VoPt2slg46YJzgpxfDobPFT0Cfy5qZILIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=technexion.com;
Received: from PUZPR03MB7015.apcprd03.prod.outlook.com (2603:1096:301:f2::6)
 by SI2PR03MB5305.apcprd03.prod.outlook.com (2603:1096:4:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 02:28:04 +0000
Received: from PUZPR03MB7015.apcprd03.prod.outlook.com
 ([fe80::f4df:54b4:c6a5:ef1d]) by PUZPR03MB7015.apcprd03.prod.outlook.com
 ([fe80::f4df:54b4:c6a5:ef1d%3]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 02:28:04 +0000
Date:   Wed, 20 Sep 2023 10:27:59 +0800
From:   Jerry Liu <jerry.liu@technexion.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Modified uvc_ctrl_fill_xu_info
 'kmalloc' to 'kzalloc'
Message-ID: <ZQpYr4oGTg7CQDm3@technexion.com>
References: <20230915161213.42503-1-jerry.liu@technexion.com>
 <20230915190449.GA12131@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915190449.GA12131@pendragon.ideasonboard.com>
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To PUZPR03MB7015.apcprd03.prod.outlook.com
 (2603:1096:301:f2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB7015:EE_|SI2PR03MB5305:EE_
X-MS-Office365-Filtering-Correlation-Id: e6cad12e-afae-4ed7-68f2-08dbb981379c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1TAzo6KsU1YvG2P13/5DQaS4cuTIy6i0TYqiM9qZxRKwsA873IIWYjIEmx+X+N4LXbdL4L3RTOLeS0UzgAEKBf8qc71lZUiViK/ikR+ScMIys//IF/4T79o12mp8olpLdSU51xwatHPBna683CcJDqWOt/9Rv/EgxRgYhU3PEJbQtsri0nZvukeMcEeRrEizKKTgQaPyRneRUmmUsJDHv+yHlv3iAQKdfgSvVHqnHU8oxeJeu3KNJpUHjTFItUnPZMnb7YDFtSBa2mMBGjpBibeNvk1x9jgQwbGI8Gof3g9ZEhhlVr/d3VXwXux6LxNvAAT/N686IxbCPFTgxdpaGotz8Sj6MuTibuo5QK6Yuy8CCryrFAt+hcKdQp0fcNcHTkbymeLvpzkxKhgQY5wDLxvw8orT+5oHtR2FXzFaZfOBSFGWdmbsUjauPX3muj7uDhzWwfhMwqcNPobi2zxCaujqhgvcqxo40nYPBJmnZW4fMl6gyuOnhkYO+inCssTXmj+nv3iqEigFjHBPbBROCCmOOl0elqyO1KxMB09suwHiN8wtwfebZj3SIBb59y/8jK5SVKP/P9yKJGeQdsk/KhXFosPB24jDVzXwzy8PSzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB7015.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(396003)(366004)(376002)(346002)(136003)(451199024)(186009)(1800799009)(2906002)(5660300002)(44832011)(26005)(41300700001)(316002)(66476007)(66556008)(66946007)(6916009)(8936002)(4326008)(8676002)(478600001)(6666004)(6486002)(6506007)(6512007)(2616005)(36756003)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c0IKyAumSRLXw47/Iu/R94fu5rzHfD69ITbM87Hj7D7+ks6Yu5xF6alfwAov?=
 =?us-ascii?Q?acRnIi1fiQYADXNbGeiBgZzlXekJZG+sm0Gcn3vI2MDgy4tUEoZoHmk9Ff11?=
 =?us-ascii?Q?lcKWOryQ9HBH3ngvK9RXnRN4m2vwAEHEtWim1HafETRkfbu0UfzP3Cg7+cFg?=
 =?us-ascii?Q?j/kjDvIUjx51RRP98rqCGjosAh5rbeHh7sL36EtJTwdraHoVy9m2nt94H7pO?=
 =?us-ascii?Q?fPMqEmOZl0z+nj1pBz73HSDfdasKeXkygRRWtg0tNGv54z4FPRf2kH/VCMLO?=
 =?us-ascii?Q?0njL/xUdlImYdUE01lHjuZ91BzTQFP7kSMs1ikNopVuvjVIurgYS9w0ASUzz?=
 =?us-ascii?Q?PgyLnBuTiYPJ3l0RlCSSFEuhua9GAXNL8fS3VHPpCLjhHTC7ffkKjSKhL5x0?=
 =?us-ascii?Q?ypKYpHBBzlO1tqrPkeVOEyNQv5VWTlSeJQX9HgL43vzFPWc/L9XFe1v6TLha?=
 =?us-ascii?Q?+4mDtt3JnP1FtW2CsgUUV46jGtodf/Dy1zc8I1Hee0V1S+FTLCTcONL3auBT?=
 =?us-ascii?Q?uWM+pqg3NyP8erKnYcoXJbe3N568itBv1polJ4H7VsEFnYQZeEkxCydK0BUH?=
 =?us-ascii?Q?vyGqh1IJD3PDyAddnenocISeyMbAX8mBwnl4B39Mj4hin2K2eW9fSHXj3R3R?=
 =?us-ascii?Q?5tXmInsE0UssCY/tjhz0CvMOpmY5t9s2ncVceRIMIm/X4FFIVEnkx8VNzKcr?=
 =?us-ascii?Q?rFB14LZzIqszBAP3a9+2jcLF9K1bgZV6HqxFIHAWFpVRmZptRgDziqW4Jw0F?=
 =?us-ascii?Q?efLVT5pvIeq+Smb/W+vUhP27PvlZbEGovvocXQ/fQjq3Vy21h69+2vvrwTTB?=
 =?us-ascii?Q?Tg0zzXJs362/aLR2Xg0r3SOTktXRAUA38c0P8J6ZNM1OQAWEOazq9LDR2fTv?=
 =?us-ascii?Q?yJI9nilPScl8GOv5JQWrjlxwptJW/2YTjZi7Fh2OryBmTImj7n974PO0KjY2?=
 =?us-ascii?Q?VWLA7DdQLpuxj74W4Xzoe1fH448PaYb9X9Gio8GXmik3+nieihUgs5WC6kNS?=
 =?us-ascii?Q?sk2GxNrFkERqbke3uN4Tv/V8X+dXnV775plkYWZIStiFFGXG+IPZ+ML/h3uA?=
 =?us-ascii?Q?ufcDk0aTSgZKFvPVokewWPDGmYc79iQtI9rXH8Honp9GZIB635dCq85DiARH?=
 =?us-ascii?Q?T/ZUAcHXJh5G6YOMqNT0/8JyFUewkXaZ5XdbSEjZuWee6hoILwG8XMktKFqC?=
 =?us-ascii?Q?dd/WITO/YUfJhm0v9lenj3adURTsDnh7wZCKp3hLGSi90GFhqbgDvrGwTBqo?=
 =?us-ascii?Q?VA8dXUfbU+Y9jqPEheT6To6WOyH/BzJCJ3FonIlMA9qZuDMiXpAexyQMwVG8?=
 =?us-ascii?Q?hiQkYHwiwW/OspFlTmJN5ddYftnjVm1QUT0y2FYOH4lZK0KXqNx+aAYWP/RE?=
 =?us-ascii?Q?Du7KryD30Sccc2OvEh7EleaXbo0+9R8bzPgvwwFwCuuhLOpRElPDCC83BpHy?=
 =?us-ascii?Q?twcz1n9uoGhO7HHSFmlj0ZNwrr01aOkr8UqR4jnz4SjR2wrldIrlSWxWEA+w?=
 =?us-ascii?Q?nFK1DOT6Rd7yE1I7JSjQWiA7IygV1CHdpV4ECa4Yuk9PHjCQWI/lEJ0pkPth?=
 =?us-ascii?Q?VY7wqICKssKsr2WJclurQy+W+6vNxyfMSz42EW52wlMrzNONoRlhad3gGarb?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: technexion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6cad12e-afae-4ed7-68f2-08dbb981379c
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB7015.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 02:28:04.0013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5ee19679-b9a6-4497-8ed2-1eda849e753b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtHiF/yYdGg6Lo2r3T/mvMI1mlp3tiJQD/bOr4VJzxLDVGxaZGPoMqRdBcUFDFC6LhuI42O8sFAYEK7dqxm2vKSMWDImmSYkR1gUNmvflzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5305
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thanks for your comment!
I'm sorry I have a confusing description for that.

You're right it's sure to return the error if it gets an error length 
from UVC. But I think it still can work despite receiving the length is 1.
In uvc_query_ctrl, it will return an error but the value is 1 not '-EPIPE', 
I think even though the length is less than 1, it still continues to execute 
the XU command.
However, I found it will receive the wrong data from uvc_query_ctrl because 
it only assigns 1-byte, not 2-byte value to the data array.

For example:
if data array is not allocated with zero bytes:

                        asssigned value of  
data[0]  |  data[1]       1 byte length       data[0]  |  data[1] 
---------------------  -------------------->  --------------------- 
  0xcc   |   0xcc                               0x01   |   0xcc

then in uvc_ctrl_fill_xu_info, 'info->size' will get wrong size from data array.

Somtimes, the data array is allocated with zero bytes:

                        asssigned value of  
data[0]  |  data[1]       1 byte length       data[0]  |  data[1] 
---------------------  -------------------->  --------------------- 
  0x00   |   0x00                               0x01   |   0x00

In this case, 'info->size' will get correct size from data array.

On Fri, Sep 15, 2023 at 10:04:49PM +0300, Laurent Pinchart wrote:
> Hi Jerry,
> 
> Thank you for the patch.
> 
> On Fri, Sep 15, 2023 at 09:12:14AM -0700, Jerry Liu wrote:
> > If the request length of UVC XU is 1 (even though this is illegal), due
> > to 'data' may be the non-zero value, UVC_GET_LEN could potentially result
> > in a length that is not 1 because of the high byte is not zero. In order
> > to ensure that 2-byte data array is set to 0, 'kmalloc' is modified to 'kzalloc'.
> 
> I don't think this can happen. The call to uvc_query_ctrl(UVC_GET_LEN)
> is given a length of 2. If the device responds with less than two bytes,
> the function will return an error, and uvc_ctrl_fill_xu_info() will
> propagate the error to the caller, without accessing the data array.
> 
> > 
> > Signed-off-by: Jerry Liu <jerry.liu@technexion.com>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 5e9d3da862dd..054bc14f7a58 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -2088,7 +2088,7 @@ static int uvc_ctrl_fill_xu_info(struct uvc_device *dev,
> >  	u8 *data;
> >  	int ret;
> >  
> > -	data = kmalloc(2, GFP_KERNEL);
> > +	data = kzalloc(2, GFP_KERNEL);
> >  	if (data == NULL)
> >  		return -ENOMEM;
> >  
> 
> -- 
> Regards,
> 
> Laurent Pinchart
