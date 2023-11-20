Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06EB7F1921
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjKTQw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjKTQwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:52:21 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C864CBA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=TIyy+E298XjGUjbzMye18sX2KmraXyhPG0hLxTVQGzw=; b=bEfbiQWWqUGGBB3mXkRLg63bnB
        08FFRl7lWOWDRxhVtaeRMOcGUuXB20KGjg8Cc9VmzOsRY1IiSSqPMb53A2tH6S0L0uIMflTeOQQDS
        TfFLiacYLCV3u+kKVFDlwXmk36jgusdPA678uotRm93sbbXrSUa0gEGA+7cTIm0qUM2g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r57VJ-000fSz-Qw; Mon, 20 Nov 2023 17:52:09 +0100
Date:   Mon, 20 Nov 2023 17:52:09 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH] firmware_loader: Expand Firmware upload error codes with
 firmware invalid error
Message-ID: <4cae34b1-b68b-4ebd-aee9-4e39f4243f9f@lunn.ch>
References: <20231117-feature_firmware_error_code-v1-1-92c973a50847@bootlin.com>
 <2023111720-slicer-exes-7d9f@gregkh>
 <548c3b60-60ce-4166-9943-224e03152cc5@lunn.ch>
 <2023111727-exert-dab-b940@gregkh>
 <20231120162537.468de5b6@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120162537.468de5b6@kmaincent-XPS-13-7390>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, my fault, I did not know well the merge actions that were needed for
> this particular case.
> 
> > > If you don't want to do that, we can ask Arnd to take it, and he can
> > > create a stable branch which we pull into netdev.  
> > 
> > You want a stable tag to pull from, right?
> > 
> > But really, why not just take this through netdev?  It's just one
> > commit, I have no problem with it going that way at all.  If the odd
> > chance there's a merge conflict in the future, I can handle it.
> 
> Seems a good and simple idea to me, Andrew any thoughts about it?
> Do I send a single patch to net-next and ask Conor to pull it in his
> subsystem for his patch series?

Yes, send a single patch to netdev. Under the ---, ask for a stable
branch. Jakub should then hopefully reply with information about the
branch, which other Maintainers can then pull.

	Andrew
