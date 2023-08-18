Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B8178052D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 06:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357879AbjHREqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 00:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357873AbjHREpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 00:45:43 -0400
Received: from out-31.mta0.migadu.com (out-31.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598643A8B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 21:45:38 -0700 (PDT)
Date:   Fri, 18 Aug 2023 14:41:08 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1692333936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AqEuvMUt2iX6Thy2whkDMydqr25IsjJ4JATm7CmA4rU=;
        b=FWDCnVztAe35jNcI9/V0DTer5UMDmXgJLpJJyK0ysq9k3R8rIw3y/TYyy06ahetPQrvu1p
        J76WxJoLSdz/1G5EtRIJMlkMxG2BrE+5Ybxwuir53+cU+iwuPU3A7ogMwQbHZOxH+rvz5x
        afxTk20VjrdBm7btuPhs2efF6bZLdL6jKMRwo5TNEWZiiVezJ5M0KGGQjSissuDzriTNR/
        7fMZhZ3Sd1OV+yMPj6PCRGpEdhfo1IqOP2VL/a0fnK1QZutBAKKdSwvtxfUmRks8ms4bjN
        dC4MN9HNdQ3uu8DWqVqQiJnxTVYqz4bLOjGx7j/pO+/N2sMydKjtk6Jj1pPB8g==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Fawad Lateef <fawadlateef@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux sunXi <linux-sunxi@lists.linux.dev>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        boris.brezillon@collabora.com
Subject: Re: Question regarding Linux-6.3.5 and Sunxi A20 NAND/NFC support
Message-ID: <ZN72ZMSPBYvStfzy@titan>
References: <CAGgoGu7Vim82Hu1JKc+m6cPkcn7+WWDFwK5P_YE6grFQS9E21Q@mail.gmail.com>
 <ZNm2ihdTojuPJM2f@debian.me>
 <CAGgoGu5XuHhVbnrNKBzhZyZH993bBHiLgjTrtyofvePZ-dxLow@mail.gmail.com>
 <CAGgoGu5iTE1xeupwTUUAcJv59294dNQJEf9oUWQKF72hrpFxRw@mail.gmail.com>
 <ZNwWNopPItNwKCTV@titan>
 <CAGgoGu4R2Y5Yj4zEQyekZK0Vkb+XpWg+mudmW3LNmfq3tCFDjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGgoGu4R2Y5Yj4zEQyekZK0Vkb+XpWg+mudmW3LNmfq3tCFDjw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 10:21:35PM +0100, Fawad Lateef wrote:
> Hi John,
> 
> Thanks for your help. I found the reason for my issue. I defined the
> pinctrl information under the "soc" next to "nfc" entry in
> sunxi-a20.dtsi which was messing it up.
> 
> I moved them inside the "pio" dtsi block and NAND is detected now.

Congratulations!

> Though almost all blocks are reported as bad-blocks.  I am thinking
> that it's happening as I don't have partition information defined in
> DTS. Do you think that this is the reason for bad-blocks reporting?

I don't have much knowledge here but you might want to confirm the
contents of your bad block table is being read and has correct values.

This might help: https://linux-sunxi.org/Mainline_NAND_Howto

> Regards,
> 
> Fawad Lateef

John.
