Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162B97E2BD2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjKFSWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjKFSWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:22:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C59D71
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 10:21:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70288C433C7;
        Mon,  6 Nov 2023 18:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1699294914;
        bh=bEl7DhnFqJXbycO9qmDsomjeYbtHPHOHDeb6W6KioRo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fFRMDFfRq/fJ5zwwCW75TCYH62U41kGfnafcGOt1AAX42k0UG28PGVcfS2pvGDSCO
         GbRsUbdpBHyKlor7+j1kalq8NaVij5jHTVNmgzQHwaORplnrBnHv26e74rPaPHRU4t
         td/2++cjKDGeHHBngHrO0LAjF7HrNtlHFjdysr/o=
Date:   Mon, 6 Nov 2023 10:21:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tom Rini <trini@konsulko.com>
Cc:     Joe Perches <joe@perches.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH RESEND] get_maintainer: add email addresses from dts
 files
Message-Id: <20231106102152.c3decaba911fb177241344ab@linux-foundation.org>
In-Reply-To: <20231028174656.GA3310672@bill-the-cat>
References: <829b122da52482707b783dc3d93d3ff0179cb0ca.camel@perches.com>
        <20231028174656.GA3310672@bill-the-cat>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2023 13:46:56 -0400 Tom Rini <trini@konsulko.com> wrote:

> > -    if (-f $file && ($email_file_emails || $file =~ /\.yaml$/)) {
> > +    if (-f $file && ($email_file_emails || $file =~ /\.(?:yaml|dtsi?)$/)) {
> >  	open(my $f, '<', $file)
> >  	    or die "$P: Can't open $file: $!\n";
> >  	my $text = do { local($/) ; <$f> };
> > 
> 
> This seems to have not been picked up, and would be useful for the tool
> to have both for the kernel itself and other projects which also use it
> and MAINTAINERS files. Can this please be picked up? Thanks!

I'm not finding the original in my archives.  Can we have a resend please?
