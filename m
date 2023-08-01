Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AB976B894
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjHAP1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjHAP1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:27:53 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122A5EE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:27:51 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371CHvE2008767;
        Tue, 1 Aug 2023 15:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=DYB7xssKCb5oyyyt/+c7ePD3RcLRjCuyGdIdrFsfETw=;
 b=k5P7tSlfiLMtcQJUx2wyn3H0xr9ejwabcvkR7nW+kvCc6ocliOOySUGv4kKoesXUJzF3
 IigpGXVYm2LRB/4DuRhSsBbmhoZfavYRy8s87YULGpomqLiN+NTMAsktWdRPRzL0GtUO
 3s3ecQnIzqasSM3hkkgUFS2gHxqu/ZKoHhy2WkUBalhH/sz5KdL7cIbBzRfAkO1ruGPm
 xLaRCe7MKGbqiuOCEgX+/o//sXpZGdDoegS/Yyc8lk9TI39zkSKsSxjkxIKuDaRe7y2u
 SK2nBKDCthPIVcL30SUtKy6jHDuF3GcaL+GtOCaW8tYP+Uws2GuYzhmYHFp+9DR4PYAX LQ== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3s6y4du76v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 15:27:16 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id AAA52801709;
        Tue,  1 Aug 2023 15:27:14 +0000 (UTC)
Received: from swahl-linux (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 6A98D80E706;
        Tue,  1 Aug 2023 15:27:13 +0000 (UTC)
Date:   Tue, 1 Aug 2023 10:27:11 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Joel Granados <j.granados@samsung.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Robin Holt <robinmholt@gmail.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [PATCH] MAINTAINERS: Some SGI-related cleanup
Message-ID: <ZMkkQiEAICaKb+Em@swahl-linux>
References: <20201019203533.GA1203217@swahl-home.5wahls.com>
 <CGME20230801111648eucas1p1ed0ae759c5f4471ffff404fb4da66e28@eucas1p1.samsung.com>
 <20230801111646.pw2rndtbmwilutg7@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801111646.pw2rndtbmwilutg7@localhost>
X-Proofpoint-GUID: EjRt3Gbt7YrFJLpIi-RYoBgT8zqhfstw
X-Proofpoint-ORIG-GUID: EjRt3Gbt7YrFJLpIi-RYoBgT8zqhfstw
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_12,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 adultscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 01:16:46PM +0200, Joel Granados wrote:
> Hello
> 
> I recently got an error while sending a mail to Mike Travis. Does he
> have a new mail? 

Mike has retired from HPE.  We had initiated an update to the
MAINTAINERS file, but apparently that fell by the wayside.  You can
expect a MAINTAINERS patch imminently.

Thanks for brining this to our attention!

--> Steve Wahl

> Best
> 
> On Mon, Oct 19, 2020 at 03:35:33PM -0500, Steve Wahl wrote:
> > UV platforms are the only ones who currently use the XP/XPC/XPNET
> > Driver, so it seems fair HPE should take some responsibility as
> > maintainers of it; so add Mike Travis and Steve Wahl.  Cliff
> > Whickman's email address is no longer valid, so remove it. Robin Holt
> > was contacted and wishes to remain as a maintainer.
> > 
> > Update Dimitri Sivanich's email address for the SGI GRU driver.
> > 
> > Add Mike Travis to HPE Superdome Flex (UV) platform.
> > 
> > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> > Acked-By: Robin Holt <robinmholt@gmail.com>
> > Cc: Mike Travis <mike.travis@hpe.com>
> > Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> > ---
> > 
> > Third sending: increase distribution list.  Someday I may get this
> > right the first time.  (My appologies if you've seen this thrice.)
> > 
> > Second sending was due to a Return-Path: problem with my email config. My
> > apologies if you've seen this twice.
> > ---
> >  MAINTAINERS | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9350506a1127..3a18b48a5221 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15671,13 +15671,14 @@ F:	include/linux/sfp.h
> >  K:	phylink\.h|struct\s+phylink|\.phylink|>phylink_|phylink_(autoneg|clear|connect|create|destroy|disconnect|ethtool|helper|mac|mii|of|set|start|stop|test|validate)
> >  
> >  SGI GRU DRIVER
> > -M:	Dimitri Sivanich <sivanich@sgi.com>
> > +M:	Dimitri Sivanich <dimitri.sivanich@hpe.com>
> >  S:	Maintained
> >  F:	drivers/misc/sgi-gru/
> >  
> >  SGI XP/XPC/XPNET DRIVER
> > -M:	Cliff Whickman <cpw@sgi.com>
> >  M:	Robin Holt <robinmholt@gmail.com>
> > +M:	Steve Wahl <steve.wahl@hpe.com>
> > +R:	Mike Travis <mike.travis@hpe.com>
> >  S:	Maintained
> >  F:	drivers/misc/sgi-xp/
> >  
> > @@ -18905,6 +18906,7 @@ F:	arch/x86/platform
> >  
> >  X86 PLATFORM UV HPE SUPERDOME FLEX
> >  M:	Steve Wahl <steve.wahl@hpe.com>
> > +R:	Mike Travis <mike.travis@hpe.com>
> >  R:	Dimitri Sivanich <dimitri.sivanich@hpe.com>
> >  R:	Russ Anderson <russ.anderson@hpe.com>
> >  S:	Supported
> > -- 
> > 2.26.2
> > 
> 
> -- 
> 
> Joel Granados



-- 
Steve Wahl, Hewlett Packard Enterprise
