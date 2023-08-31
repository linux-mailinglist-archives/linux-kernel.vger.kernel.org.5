Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1314A78ED47
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346291AbjHaMgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244864AbjHaMgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:36:50 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E331A4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:36:47 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Rc0z15j1Pz9c;
        Thu, 31 Aug 2023 14:36:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693485406; bh=3dUaAopyJHyO0Wwx7qyw+2jSFISrZHx41t06OUC87J0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gh5sVA2evMLbxcRhpBqWcgeDSqgMmyVjw76MWzhnMEkocX3PD7eehs3Ei18IFuYo2
         0Ttw1HunL7ErJNwC+HfeSl2Ah2mAhwq9j9SLiGjQAgdLZgOU5zTd5F1I1Uw//gkLfp
         jNGOO9ov4+D3wrV/NxDidNvvlNK+0f7rQlafWOARIonzW1NWEIsyBzjMmN0bCBUz3+
         7dTZVyDFVdK2uSgmaAakpUeyJ8PrZiBF/SsIi3y8NKhs9mdLLULfKBg8Uqg+5wdJIA
         5dfj1ZaJv77W+X4kRTLHzmWGcfbigui6lpmaw5vn0Vmw+JNsPh4RGe2Eay07WyD5vi
         E9R92aPDS3h8w==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Thu, 31 Aug 2023 14:36:44 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] regulator/core: regulator_ena_gpio_ctrl: pull in
 ena_gpio state handling
Message-ID: <ZPCJXAjZ8ScAAZnL@qmqm.qmqm.pl>
References: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
 <c2551b3da420ab9b69f80ec7a0d646ff69bd0a03.1693431144.git.mirq-linux@rere.qmqm.pl>
 <4434c869-6ef5-40b4-869d-8e4d292ac30e@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4434c869-6ef5-40b4-869d-8e4d292ac30e@sirena.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 12:13:16PM +0100, Mark Brown wrote:
> On Wed, Aug 30, 2023 at 11:38:56PM +0200, Micha³ Miros³aw wrote:
> 
> > -		if (pin->enable_count > 1) {
> > -			pin->enable_count--;
> > -			return 0;
> > -		}
> > -
> >  		/* Disable GPIO if not used */
> > -		if (pin->enable_count <= 1) {
> > +		if (pin->enable_count-- <= 1) {
> 
> The goal isn't to write the minimum number of lines possible - this just
> makes the logic harder to follow and for bonus points isn't obviously
> related to the chnages described in changelog.

I see that I missed this fragment when splitting patches. I'll resend
without this part if the other ones are good to go.

Best Regards
Micha³ Miros³aw
