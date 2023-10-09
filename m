Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0F07BEA34
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378247AbjJIS53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377444AbjJIS51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:57:27 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5767A4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:57:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690f7bf73ddso3271005b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696877842; x=1697482642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ef2KltIf/Jizj+cWsThstfJI8FTNgm2Gv7ZqircULnk=;
        b=lpO2oNy6rAUVMqUJwdzK9SfX0IgGOBBDrVu9kPv+W3YBwUBE6DDo2Uis7+f31qOLxe
         xCjOdkEOGfVkzJVsxZ5cwIbfnkSAkoAVNBF12e/XHsjuPjNnI29nBAJdapMefJbp2uUT
         2/iVht4Z0z1D4nN5WcvRnOCc2aq82qvEwGZn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696877842; x=1697482642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ef2KltIf/Jizj+cWsThstfJI8FTNgm2Gv7ZqircULnk=;
        b=IRuVWAxVXyM5JmUF2JUbQtHbcM0C7i+1zmN/egOcIs1CSebAoy5MnOZ7BaYwM/NOdz
         c9kdRjDeuEGzVbQDild3XuSSH4SwaMehGRhEOrSMWm1A+kZgU7jMKZWHdp8GfXKeHor/
         7AGD/EVfH+KyvXcvE8U4krjxy7dcGNEvND+48fL0hNlt2fjfdUFL+atgrfBp0R4NVyTZ
         3hwfzP7+11LHajvSM1b5UEds3898me5bX7T2D9o7HgnXmTOxSjDxwraYs9SytUdMgdPa
         vfjkvdB4jfu1+wAj+G2rzzWsLoehXLppmmY0X4P4RmK+CGPd0XqnOr0dvMlfHoG8Mdn5
         YTEg==
X-Gm-Message-State: AOJu0Yy6bvIF0FUzFoX8cLVwVAWV+4h5ymZ+zH3Ku9Q1peKCA/xlj6mM
        VA9KX6PXdaUYrVDbve5gLJV4HQ==
X-Google-Smtp-Source: AGHT+IE4vqs9atio0N5fkJGlaREins6sf7uxHziFBJfwRZO5gxQHdqS9RWYAu7UcEcHK+4OWLtOB9g==
X-Received: by 2002:a05:6a20:841b:b0:137:2f8c:fab0 with SMTP id c27-20020a056a20841b00b001372f8cfab0mr16715873pzd.49.1696877842295;
        Mon, 09 Oct 2023 11:57:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p18-20020aa78612000000b00689f5940061sm6902037pfn.17.2023.10.09.11.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:57:21 -0700 (PDT)
Date:   Mon, 9 Oct 2023 11:57:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: dsa: lantiq_gswip: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <202310091156.978D4E1@keescook>
References: <20231009-strncpy-drivers-net-dsa-lantiq_gswip-c-v1-1-d55a986a14cc@google.com>
 <202310091134.67A4236E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310091134.67A4236E@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 11:34:27AM -0700, Kees Cook wrote:
> On Mon, Oct 09, 2023 at 06:24:20PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> > 
> > ethtool_sprintf() is designed specifically for get_strings() usage.
> > Let's replace strncpy in favor of this more robust and easier to
> > understand interface.
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> > ---
> >  drivers/net/dsa/lantiq_gswip.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
> > index 3c76a1a14aee..d60bc2e37701 100644
> > --- a/drivers/net/dsa/lantiq_gswip.c
> > +++ b/drivers/net/dsa/lantiq_gswip.c
> > @@ -1759,8 +1759,7 @@ static void gswip_get_strings(struct dsa_switch *ds, int port, u32 stringset,
> >  		return;
> >  
> >  	for (i = 0; i < ARRAY_SIZE(gswip_rmon_cnt); i++)
> > -		strncpy(data + i * ETH_GSTRING_LEN, gswip_rmon_cnt[i].name,
> > -			ETH_GSTRING_LEN);
> > +		ethtool_sprintf(&data, "%s", gswip_rmon_cnt[i].name);
> 
> Sorry, I read too fast: this should be "data", not "&data", yeah?

As I said in the other email, please ignore me. &data is correct. I'm
not used to ethtool_sprintf(), clearly. :) My original Reviewed-by
stands. Sorry for the noise!

-Kees

-- 
Kees Cook
