Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1259766472
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjG1Gtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjG1Gtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:49:33 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36FE19B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:49:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbea147034so18721715e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690526970; x=1691131770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LmJ6BXegUrc9i3x0UWFPriRnJhYU37oWkfBZx21F9OQ=;
        b=NB+3mL2mAhd0YNBs/9gVkXH/rRmzR6u6M0m7sPyFprTN2R/hGF+5M2mPSNp4/SOSpl
         qC0s1rVwnH04Tk6QWodWYUUHLIcH+jFdHAZfoRGwnjH/GLQCa9+nvvGBatiULPc+zTp/
         hLdvXQRjhv53Mqo7bCMHNs9tTrjfkk76AxB1Upfm0/yK4ojTTGQMsJ+QoUvRekHJb9Mr
         cPRJwKWHzTfnGlifODQd6PI/1eV7yapZ0J1wKMVxFNCyhUljvt3cZpY/vV3LYtIStstk
         +iQscmKU656z51yzL0X0N9UgIZlVFj4tiJfLr4kvaMpO8gEXZGi4O2ifVMxnICwrKoXC
         S4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690526970; x=1691131770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmJ6BXegUrc9i3x0UWFPriRnJhYU37oWkfBZx21F9OQ=;
        b=f6wAKislrTdmG0UlJ0ceL54Kf/sER0I/WiovOkS0/zJgNMQxeJRDHBqmIHI9zoFTLn
         Z2WEgmkJGXpL1W+HEIGsGSHHa+TmEMbpoTaoi+/IpIcuKpKNG0r4rGICTA+407NRTjJI
         xd94U+24iT+JjYewBsDAYeRoY0EZQqXJbyqYzsoNMCHMuI5aUA0+6HeSMHWIoT0OHiWr
         Vjw79rWQ+4ild5Bqug7EdJuhLmt/TOWLv9sdD3sM9YwiKhZ+6H9g9Zv2rRVOC7BdgNaP
         8hHz8yARmU7yITKtA+aoverMEGgMH3INZlcFoPf+7jX2FPAyCVw4vneawlcPoXz1G+Us
         ONSw==
X-Gm-Message-State: ABy/qLYhpCVaAVLJfBXWdnmLYXrxhjQ7MKjW9lLR4TRSRT4eNcuLrbk3
        9wc+MUl0CN4opZNdJETjNf6hpgFY1cTO+mHdwmM=
X-Google-Smtp-Source: APBJJlHndBTQ7yQ5tqQ+eyksuvSaue33KmB/4JaPkdv9G0scjZN4tAaQl2hHktY8JagmgFSWeQ/+NA==
X-Received: by 2002:a05:600c:21cd:b0:3fc:4e0:be97 with SMTP id x13-20020a05600c21cd00b003fc04e0be97mr891135wmj.6.1690526970178;
        Thu, 27 Jul 2023 23:49:30 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b0031766e99429sm3907635wrq.115.2023.07.27.23.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 23:49:29 -0700 (PDT)
Date:   Fri, 28 Jul 2023 09:49:26 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        gregkh@linuxfoundation.org, anjan@momi.ca, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Staging: rtl8192e: Function name cleanup series 1
Message-ID: <f47c3d86-aada-470d-8ed8-5d7957edb28a@kadam.mountain>
References: <20230728054742.622297-1-tdavies@darkphysics.net>
 <f4aaf5f5-a6b0-ef10-0d9b-fc52035ca309@gmail.com>
 <ZMNf2d615rXJ8O95@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMNf2d615rXJ8O95@basil>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 11:27:37PM -0700, Tree Davies wrote:
> On Fri, Jul 28, 2023 at 08:16:03AM +0200, Philipp Hortmann wrote:
> > On 7/28/23 07:47, Tree Davies wrote:
> > > Rename functions to fix checkpatch warning: Avoid CamelCase
> > > 
> > > 
> > > Changelist:
> > > v3: Changed patch #5, Rename global function ResetBaEntry to rtllib_reset_ba_entry
> > > v2: Sent to mailing list via git send-email, patches are the same.
> > > 
> > > Tree Davies (5):
> > >    Staging: rtl8192e: Rename function ActivateBAEntry
> > >    Staging: rtl8192e: Rename function DeActivateBAEntry
> > >    Staging: rtl8192e: Rename function TxTsDeleteBA
> > >    Staging: rtl8192e: Rename function RxTsDeleteBA
> > >    Staging: rtl8192e: Rename function ResetBaEntry
> > > 
> > >   drivers/staging/rtl8192e/rtl819x_BAProc.c | 44 +++++++++++------------
> > >   drivers/staging/rtl8192e/rtl819x_TSProc.c |  6 ++--
> > >   drivers/staging/rtl8192e/rtllib.h         |  2 +-
> > >   3 files changed, 26 insertions(+), 26 deletions(-)
> > > 
> > Hi Tree,
> > 
> > those patches have been accepted and cannot be applied again.
> > 
> 
> Hi Philipp,
> 
> Right, patch #5 was not accepted though. Grep asked to fix it up.
> I thought that because it was part of that series I was supposed to
> resend as new version.

But now you understand what to do, right?  Pull the latest code and do
all your work on top of that.  Don't resend the stuff which was applied.

regards,
dan carpenter

