Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABFA7CA93E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjJPNTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjJPNTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:19:36 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10938A2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:19:35 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b2cee40de8so923149066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697462373; x=1698067173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ofsX2ld2Y35hldDs43R40eV9lYWcpyBA4x3tj2sdNUM=;
        b=Fo5wLOpfEpziYpTAd/VKyBQPkgXnEhmQ9X2NW8SbRkjzaowKOINivrVjt0DPqpk8uh
         Nn0XlCzQeh5p1pL0HjbU9n3CfJI86eK8jE+TX7SAdY8sHc5X2MFL+tDU8wD16c4CTIng
         aba+Pfs7wpfnpSVyqWH5bUXu7iLb/jrmc/BAwnu1GBecQe2hvtB6GsjrMiN54aXMxe4o
         766zlzB+zSgux+p950OFktfPuvIoS7R8+j1jJA6B/qlxkL/Omecumjv3nj+Yvd8eRWbc
         T4HbblWAk9h9LtOMUByQWxbJVL/SGmNcmXZCfNTuYak6VZ1S0BwGQjFo1FZ7DLBWzcSu
         j/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697462373; x=1698067173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofsX2ld2Y35hldDs43R40eV9lYWcpyBA4x3tj2sdNUM=;
        b=NFL4GHP3GrPJ6owRpFO99SeTPyKXLSOobqNB9bX6KEw+zM+a8Z4hOGt9AYRh3y0PtY
         dt+LYB5DcNbs1kDB2qYMQdB2VBRU5XfNLYX4rUVFNRXD5dUSzgxBT6OldffsGb7PN0hO
         YU5MYhd/HUe6yo7uYznw4Ud7UGeRhpFk3GHHRl0nMYZ0mfR6RfM4/XAQDX4q+ZXl6DK4
         xbmLs2IBWx81XeHWrUa70aML2xgsXHleJHaijnlWec425bqKtNic+MYkInqVk5AAUHjX
         i7I/nEjmJ1nX4XmMIDA19Aa44IGPjU48QONVnDQPEsGZYLMyG/MdXybfhJnz11t6ZNft
         yxMA==
X-Gm-Message-State: AOJu0Yw7BdUre+cablhAfsl9/+0y4S3xWKDDoIUgtZmC0s/p+QXOIDOA
        W0fDq3kVJai4yJCR9K+DO8yqaoPHqCTvlkqKmnVFOQ==
X-Google-Smtp-Source: AGHT+IFuH/XgysB7Sxky39MfcG4hkkSZ6xm21/9jC7buhA0x7DsWtKnFalffqQ9KEVpl9pkg+JUIfKq8xTStyGVkKkM=
X-Received: by 2002:a17:907:5ca:b0:9ae:6648:9b53 with SMTP id
 wg10-20020a17090705ca00b009ae66489b53mr6876194ejb.23.1697462373491; Mon, 16
 Oct 2023 06:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <267abf02-4b60-4a2e-92cd-709e3da6f7d3@gmail.com>
 <CAMZdPi9RDSAsA8bCwN1f-4v3Ahqh8+eFLTArdyE5qZeocAMhtQ@mail.gmail.com> <ZSiJdxjokD0P9wRc@debian.me>
In-Reply-To: <ZSiJdxjokD0P9wRc@debian.me>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Mon, 16 Oct 2023 15:18:56 +0200
Message-ID: <CAMZdPi8qmc4aKPsm3J60Fb+wa0ixVCV+KK11TDsvqFJk81Gfrw@mail.gmail.com>
Subject: Re: Intel 7560 LTE Modem stops working after resuming from standby
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Intel Wireless WAN <linuxwwan@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

On Fri, 13 Oct 2023 at 02:04, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Thu, Oct 12, 2023 at 06:54:11PM +0200, Loic Poulain wrote:
> > Hi Chetan,
> >
> > On Thu, 12 Oct 2023 at 11:52, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> > > I notice a regression report on Bugzilla [1]. Quoting from it:
> > >
> > > > I noticed a few days ago, after Fedora moved to Kernel 6.5, that my Intel LTE Modem was not working anymore after resuming from standby.
> > > >
> > > > The journal listed this error message multiple times:
> > > > kernel: iosm 0000:01:00.0: msg timeout
> > > >
> > > > It took me a while to determine the root cause of the problem, since the modem did not work either in the following warm reboots.
> > > > Only a shutdown revived the modem.
> > > >
> > > > I did a bisection of the error and I was able to find the culprit:
> > > >
> > > > [e4f5073d53be6cec0c654fac98372047efb66947] net: wwan: iosm: enable runtime pm support for 7560
> >
> > Any quick fix for this issue? alternatively we will probably revert e4f5073d53.
>
> Chetan can't be contacted as sending to his address bounces (error 550)
> (had he left Intel?). Last message on LKML is this culprit patch [1].
> Hence, revert for now.

Could you please submit the revert fix?

Regards,
Loic
