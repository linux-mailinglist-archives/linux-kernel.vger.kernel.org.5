Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310A179CD92
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjILKNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbjILKNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:13:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773D210E4;
        Tue, 12 Sep 2023 03:13:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911D1C433CA;
        Tue, 12 Sep 2023 10:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694513611;
        bh=tGhelaPFNZuEx0uPoA53JqxqfGlMwrEXqhnIkceP5Qc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=STypyJxFv+PolVK7AM9K42rOjuvdetg84wPOqeGVM0/rI+oH63XkwmDZwJe+rakQr
         2wiId0RyfwrtR2BExQpEHpc5QFw3Uk5ePJDNw56Y1aQnKb3BeyNs24jdYH7gV0/KPS
         C7QEVXzFIFb5nSS+IPpFaEJH39dpDWt1wC/jagus=
Date:   Tue, 12 Sep 2023 12:13:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     H Hartley Sweeten <hsweeten@visionengravers.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>, stable@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "comedi: add HAS_IOPORT dependencies"
Message-ID: <2023091226-foe-reanalyze-b859@gregkh>
References: <20230905090922.3314-1-abbotti@mev.co.uk>
 <76acff7e-3959-4193-9531-22a5e5a68221@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76acff7e-3959-4193-9531-22a5e5a68221@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 11:44:39AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 05.09.23 11:09, Ian Abbott wrote:
> > This reverts commit b5c75b68b7ded84d4c82118974ce3975a4dcaa74.
> > 
> > The commit makes it impossible to select configuration options that
> > depend on COMEDI_8254, COMEDI_DAS08, COMEDI_NI_LABPC, or
> > COMEDI_AMPLC_DIO200 options due to changing 'select' directives to
> > 'depends on' directives and there being no other way to select those
> > codependent configuration options.
> > 
> > Fixes: b5c75b68b7de ("comedi: add HAS_IOPORT dependencies")
> > Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> > Cc: Arnd Bergmann <arnd@kernel.org>
> > Cc: <stable@vger.kernel.org> # v6.5+
> > Acked-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> 
> Hmmm, that fix for a regression from the 6.5 cycle was posted a week ago
> but didn't get a single reply afaics and hasn't hit next.
> 
> Greg, is this still in your to-review queue and just delayed due to the
> merge window? Or are you waiting for something? A ACK fromn Niklas
> maybe? Or a newer patch to address the kernel test robot report in case
> its relevant?

The merge window "freeze" ended on Monday, give me a chance to catch up
with patches please, this is part of my very large todo mbox:

	$ mdfrm -c ~/mail/todo/
	1637 messages in /home/gregkh/mail/todo/

thanks,

greg k-h
