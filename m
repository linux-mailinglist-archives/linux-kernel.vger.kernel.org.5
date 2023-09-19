Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6567A5D16
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjISIy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjISIym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:54:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688D0131;
        Tue, 19 Sep 2023 01:53:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5274DC433C8;
        Tue, 19 Sep 2023 08:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695113619;
        bh=vaM9XujXeErMiUJR9Emy3Wd84QrswDsnFHmrPWGnP3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FLLd6uXlkKnqZAu62F3c58mAiaRiXosNiF5hIo21358ZlBPBD4qiGGE2f3enJQr5W
         NtCZHbIOEzvJ+KnApf4ohCucCzLHkGRITaqzQngWn+AhqPvKIYI+teqtdpJJ408jex
         8wpPlHGBHuDksEdxhORGUvFrzjmO8NPpyjjNt6l4=
Date:   Tue, 19 Sep 2023 10:53:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, corbet@lwn.net,
        alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ALSA: Add new driver for Marian M2 sound card
Message-ID: <2023091917-zippy-alienate-3efc@gregkh>
References: <20230918181044.7257-1-ivan.orlov0322@gmail.com>
 <20230918181044.7257-2-ivan.orlov0322@gmail.com>
 <2023091955-dried-popsicle-f3d8@gregkh>
 <56a4a085-6b1d-19c6-4160-4513c8c41e57@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56a4a085-6b1d-19c6-4160-4513c8c41e57@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:46:34PM +0400, Ivan Orlov wrote:
> By the way, is there any way to detect such issues automatically? I've seen
> that the kernel test robot detects a lot of similar stuff, perhaps there is
> any tools/linters which can be set up locally?

Not that I know of, sorry, I rely on the kernel test robot for lots of
these things :)

But, the robot is running all open tests, so dig into the public repo of
it to see what it is using and perhaps run those tests locally?  Lots of
them are just different build options and running sparse.

thanks,

greg k-h
