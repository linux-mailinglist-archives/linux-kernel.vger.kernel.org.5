Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146997ECA13
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjKOR4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKOR4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:56:33 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42385D41;
        Wed, 15 Nov 2023 09:56:29 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DD9D18D;
        Wed, 15 Nov 2023 18:56:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1700070961;
        bh=B84mM6617p9zO8gKPZeo7FnDkXTNNw/3Ui+JuYQYZ44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AF3Qle88iQHXmtPhaiheiGfq+kLIMg2g6lVW7W61hL/Ss5snExp5kG1/qTbhnCX0g
         YRLFSFGnxkY+3v61QW+LsS1xYQo+aC0VgODIplApSmUGvCZI02jlCYYt8+rtc+6fYc
         XUvC/MbS8nhpctMsrymMZ+hsrxI2YngSU1SaDhvM=
Date:   Wed, 15 Nov 2023 19:56:32 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: submitting-patches: improve the base commit
 explanation
Message-ID: <20231115175632.GA29486@pendragon.ideasonboard.com>
References: <20231115170330.16626-1-bp@alien8.de>
 <202311150948.F6E39AD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202311150948.F6E39AD@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 09:49:31AM -0800, Kees Cook wrote:
> On Wed, Nov 15, 2023 at 06:03:30PM +0100, Borislav Petkov wrote:
> > From: "Borislav Petkov (AMD)" <bp@alien8.de>
> > 
> > After receiving a second patchset this week without knowing which tree
> > it applies on and trying to apply it on the obvious ones and failing,
> > make sure the base tree information which needs to be supplied in the
> > 0th message of the patchset is spelled out more explicitly.
> > 
> > Also, make the formulations stronger as this really is a requirement and
> > not only a useful thing anymore.
> > 
> > Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> 
> Yup, I wonder if making "--base=auto" a default in git might be a good
> idea too?

When the base of a series is in Linus' tree, or in the corresponding
subsystem maintainer's tree, things are easy, but there are many
situations where the base is a merge of multiple branches (perhaps a
for-next and a fixes branch for instance), or where prerequisites have
been applied manually for one reason or another. This can and should of
course be described in the cover letter, and the submitter should push
and provide a link to a branch that contains the series on top of the
appropriate base (or just a link to the base). This won't help the bots
much though, if they just look at the base tag. Is there a way, or can
we standardize on a way, to indicate where the base can be found ?

> Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Regards,

Laurent Pinchart
