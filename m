Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D31A7CDCF4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjJRNPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjJRNPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:15:36 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB7C94;
        Wed, 18 Oct 2023 06:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DaQ6cGTv6XMBNUYEJLOizIHbSt4Dr0Tm0u2P2jx7WHQ=;
  b=JLloD9Ih8tfGPpU3niVRQTWFIgN2YFaBBQsmgj9eN6wDzmrsQXxAaakb
   nrkm7m+flApLfrB7N7W2soYGtAlwr2kj2KntxviLP61GWckjinkpV0fcs
   kBDfcu/9YF/E5V9825npk1EIJQwaroiDlPwAFF25IrrUCYaiO/NFjlo/A
   0=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,235,1694728800"; 
   d="scan'208";a="131910169"
Received: from dhcp-138-246-3-50.dynamic.eduroam.mwn.de (HELO hadrien) ([138.246.3.50])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 15:15:28 +0200
Date:   Wed, 18 Oct 2023 15:15:28 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Dorcas Litunya <anonolitunya@gmail.com>
cc:     Julia Lawall <julia.lawall@inria.fr>, outreachy@lists.linux.dev,
        dan.carpenter@linaro.org, andi.shyti@linux.intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: sm750fb: Remove unused return value in
 program_mode_registers()
In-Reply-To: <ZS/Wr9ShnEe3umeY@dorcaslitunya-virtual-machine>
Message-ID: <254c6d21-3f44-4e6c-156-67fb3b56b426@inria.fr>
References: <cover.1697619623.git.anonolitunya@gmail.com> <492e63bbc58147fb534930ef9e1fb5d844ae8769.1697619623.git.anonolitunya@gmail.com> <4b7129ae-27f9-7ff4-845-9c327aff488c@inria.fr> <ZS/Wr9ShnEe3umeY@dorcaslitunya-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Oct 2023, Dorcas Litunya wrote:

> On Wed, Oct 18, 2023 at 02:06:41PM +0200, Julia Lawall wrote:
> >
> >
> > On Wed, 18 Oct 2023, Dorcas AnonoLitunya wrote:
> >
> > > Modifies the return type of program_mode_registers()
> > > to void from int as the return value is being ignored in
> > > all subsequent function calls.
> > >
> > > This improves code readability and maintainability.
> > >
> > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> > > ---
> > >  drivers/staging/sm750fb/ddk750_mode.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> > > index 83ace6cc9583..e15039238232 100644
> > > --- a/drivers/staging/sm750fb/ddk750_mode.c
> > > +++ b/drivers/staging/sm750fb/ddk750_mode.c
> > > @@ -73,8 +73,8 @@ display_control_adjust_sm750le(struct mode_parameter *mode_param,
> > >  }
> > >
> > >  /* only timing related registers will be  programed */
> > > -static int program_mode_registers(struct mode_parameter *mode_param,
> > > -				  struct pll_value *pll)
> > > +static void program_mode_registers(struct mode_parameter *mode_param,
> > > +				   struct pll_value *pll)
> > >  {
> > >  	int ret = 0;
> > >  	int cnt = 0;
> > > @@ -202,7 +202,6 @@ static int program_mode_registers(struct mode_parameter *mode_param,
> > >  	} else {
> > >  		ret = -1;
> >
> > Is it still useful to have ret = -1?  Maybe the ret variable is not useful
> > at all any more, but one would have to check the parts of the function
> > that aren't shown.
> >
> I agree Julia. I will remove the setting part for ret = -1 but keep the
> ret variable just in case it is being used by parts of the function not
> shown. Thanks for the feedback.

You can check the rest of the function code and see if ret is still
useful.

julia

>
> Dorcas
> > julia
> >
> > >  	}
> > > -	return ret;
> > >  }
> > >
> > >  int ddk750_set_mode_timing(struct mode_parameter *parm, enum clock_type clock)
> > > --
> > > 2.42.0.345.gaab89be2eb
> > >
> > >
>
