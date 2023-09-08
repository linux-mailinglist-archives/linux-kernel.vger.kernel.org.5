Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FBE798464
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbjIHIr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjIHIr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:47:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5911BF8;
        Fri,  8 Sep 2023 01:47:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E46AC433C7;
        Fri,  8 Sep 2023 08:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694162869;
        bh=RKazeNausWM6tPwdKCpl5s1mIWcdBnzHHJqJ5487TXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z62vsB6g3tQAwXvNxqDvT2MSnN2e8BQFvu7VPHVtY3o9dCp3qiV9soyQc3VSY+o9i
         e63/m30jM9eXsmvxaXQmPRGIZqibL7AGCgl+biR1wzg5HvSxwhG+GI36kYuAg+708p
         3KDgE6ZAaA0P52ik7aylgzdQzrrwDjZyPyCZirDM=
Date:   Fri, 8 Sep 2023 09:47:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stefan Lippers-Hollmann <s.l-h@gmx.de>, stable@vger.kernel.org,
        patches@lists.linux.dev, Luis Chamberlain <mcgrof@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.5 11/34] modules: only allow symbol_get of
 EXPORT_SYMBOL_GPL modules
Message-ID: <2023090813-plug-path-b06f@gregkh>
References: <20230904182948.594404081@linuxfoundation.org>
 <20230904182949.104100132@linuxfoundation.org>
 <20230907084135.02d97441@mir>
 <2023090719-virtuous-snowflake-d015@gregkh>
 <20230907221737.07f12f38@mir>
 <2023090848-chastise-paycheck-6d4d@gregkh>
 <2023090841-antitrust-reword-d6bc@gregkh>
 <20230908083139.GA9985@lst.de>
 <20230908083538.GA10228@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908083538.GA10228@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 10:35:38AM +0200, Christoph Hellwig wrote:
> On Fri, Sep 08, 2023 at 10:31:39AM +0200, Christoph Hellwig wrote:
> > On Fri, Sep 08, 2023 at 08:07:08AM +0100, Greg Kroah-Hartman wrote:
> > > And it's over 130 symbols, attached, I'll figure out a way to script
> > > this...
> > 
> > Eww. Sorry for missing this, and I suspect it really should be
> > entirely reworked in the future.  But for now the scripting sounds
> > right.  Let me know if you'd done anything, otherwise I can look into
> > it this afternoon Chilean time.
> 
> .. and it turns out dvb_attach has already been deprecated for 5 years
> time, it's just that it still has all these users around.

Yeah, apis never seem to go away.  I'm scripting it now, almost done...

greg k-h
