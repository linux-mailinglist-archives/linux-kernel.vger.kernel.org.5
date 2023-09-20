Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F8E7A82DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbjITNGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbjITNGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:06:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4209E12F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:06:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CBDC433C8;
        Wed, 20 Sep 2023 13:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695215170;
        bh=mNQOrDyhJXJTHq5CdUXfZUgfdF0J3zdwaPLZQImoRmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0bwOztNmaitohiVC2o5hp4mrZsUpT/279wZH3wh3PtxA6Imh1psCy+9nhdfpL2nSy
         xPutEm3mqlgueE6hUZj6DDPj7XaLI6gTQhVKaZzoUtdIp1+ajoZw6M8pQCzZ8QiwWn
         muRZcMgYg6zAW4yoqgketrj5uteV6/KfXM2g/gBo=
Date:   Wed, 20 Sep 2023 15:06:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Grandperrin <paul.grandperrin@gmail.com>
Cc:     Ricky WU <ricky_wu@realtek.com>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Jade Lovelace <lists@jade.fyi>
Subject: Re: [PATCH] misc: rtsx: Fix some platforms can not boot and move the
 l1ss  judgment to probe
Message-ID: <2023092055-recopy-coveted-0772@gregkh>
References: <37b1afb997f14946a8784c73d1f9a4f5@realtek.com>
 <2023092032-blurred-upload-30bd@gregkh>
 <RIBA1S.HYP1X2RG9UAF3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <RIBA1S.HYP1X2RG9UAF3@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 02:47:15PM +0200, Paul Grandperrin wrote:
> Hi Greg and Ricky,
> I just finished testing the patch (on top of 6.1.53) and AFAICT it's working
> perfectly:
> - system boots and all hardware devices seems to work fine
> - nothing weird in kernel and system logs
> - suspend-to-ram (S3) works
> - the SD card reader works
> 
> If there's anything more you want me to test, don't hesitate.

Great, can I get a "Tested-by:" tag from you for this?

thanks,

greg k-h
