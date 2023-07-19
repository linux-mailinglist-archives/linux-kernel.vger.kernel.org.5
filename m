Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23989759621
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGSNDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjGSNDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:03:40 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F81172E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:03:38 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-766fd5f9536so465260885a.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20221208.gappssmtp.com; s=20221208; t=1689771817; x=1690376617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yVmx1ErmKUSGwgpTmxJxNkC1cHItIhkWOY1t2BSjV8Q=;
        b=WFIm/wT7DIsM2va5wLeq8CeKKISvdlWhpi3HN+9y/jdkErtnpEBWsFnlIYC3IVDwG0
         mC1khj0qrSP/kEAyX6fwU0YVQIQB8en2StaQ2WQbIOd03DJVdf8vBu40fDg2fhUZ3Iya
         vsUTwWE8xMHbYlcMggNZFnGmqMmkvUDXCGi/dcWKrDIIUV05yyrViqUcZjZXgXAs3MFp
         F8jPmDUlpEWP9kaE+GW3dDUGXjER9RyBdAnx5Ta8BSYVGjzWmbxO1a+vOkGT+0pFW9wV
         jbbLO4caVbytKmzcYKfONV14noUDYHhxE16n0pJu4wVlDT2BhK4D7znHa6rnpEM5mVMb
         bknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689771817; x=1690376617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVmx1ErmKUSGwgpTmxJxNkC1cHItIhkWOY1t2BSjV8Q=;
        b=jqZNDoejxAmk/rU9avQvdNwkxDV41WDlm2u1wvRj80Q62mhDXLCF+eqm6ejeLVLKNK
         J7/uz8I57tKAVD3piFAhVPVV5ck7enkscYjG276l6rxnKaRId/3u8EquDH1pg6j7sBo8
         8f7bkIbJEYDD78aEqBM1M9/QYFGoMPWW/+SwQLjbrR1DTq0luGPYZSaoOqQ/JvNFpdFx
         TpdYZhek1txxcF0x3n6v+Hcp0LUv/8cTRkUiIj4Hx4ofKcVtmBEIcFnG/ScKyX85PqAj
         IBTuIKQ/b7w/+mfH7BeddlQ2qATGk1aEkLEyRdYC5lL5Fl5p0kx5dZk5jJ6D9fQ/epYc
         L8Wg==
X-Gm-Message-State: ABy/qLafoPXLGkxpXqEcpRiA6OJl1LZiunDBEwEZOSrvSQI81BkxKCXX
        Ko95ea9Gm4hiBQ9nHRgfU9qWig==
X-Google-Smtp-Source: APBJJlHzFO1toSuIggCnLfxp/n3DCsCdhlZJjY2lZmt7rAuvGM36jSqUMtKNKbbu5dW0OQoTiqhnGg==
X-Received: by 2002:a05:620a:bc5:b0:768:158a:bc0 with SMTP id s5-20020a05620a0bc500b00768158a0bc0mr2646464qki.39.1689771817272;
        Wed, 19 Jul 2023 06:03:37 -0700 (PDT)
Received: from elrond.bobcopeland.com ([142.115.123.76])
        by smtp.gmail.com with ESMTPSA id r25-20020a05620a03d900b007623c96430csm1244845qkm.111.2023.07.19.06.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 06:03:36 -0700 (PDT)
Received: by elrond.bobcopeland.com (Postfix, from userid 1000)
        id 74E8EFC0158; Wed, 19 Jul 2023 09:03:29 -0400 (EDT)
Date:   Wed, 19 Jul 2023 09:03:29 -0400
From:   Bob Copeland <me@bobcopeland.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-karma-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] fs: omfs: Use flexible-array member in struct
 omfs_extent
Message-ID: <ZLffIfEKz/nR9Jj/@bobcopeland.com>
References: <ZLGodUeD307GlINN@work>
 <202307170758.14B5D83D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307170758.14B5D83D@keescook>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 08:20:22AM -0700, Kees Cook wrote:
> > @@ -14,7 +14,7 @@ static u32 omfs_max_extents(struct omfs_sb_info *sbi, int offset)
> >  {
> >  	return (sbi->s_sys_blocksize - offset -
> >  		sizeof(struct omfs_extent)) /
> > -		sizeof(struct omfs_extent_entry) + 1;
> > +		sizeof(struct omfs_extent_entry);
> >  }
> 
> I think the original calculation meant to do:
> 
>   	return (sbi->s_sys_blocksize - offset -
>   		(sizeof(struct omfs_extent) - sizeof(struct omfs_extent_entry))) /
> 		sizeof(struct omfs_extent_entry);

I can confirm the intent.  I also went back and looked at the usages just
to be sure.

In this case, there are two possible values for x = s_sys_blocksize - offset:
7728 or 8128, and both can be divided by 16 evenly so you have either:

    f_old = (x - 32) / 16 + 1 or:
    f_new = (x - 16) / 16

they both simplify to x/16 - 1 so they are equivalent for these inputs.

-- 
Bob Copeland %% https://bobcopeland.com/
