Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A93D80AED5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjLHV1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHV1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:27:17 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76B411D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:27:23 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce32821a53so1733465b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 13:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702070843; x=1702675643; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mix9yN+rFBE8tcJIqsswkQecCZSelxz7obmiD13PDJk=;
        b=KRy2uwbrNXlqBRQM5J/YBUe2XoQrUyL8l9YmgAblbpjpIfu3vDgEig9kyTNg/RHXod
         uorJ/zi7BzFyXkiVitaQ7qHe0Va61sWIVTTk/tym+J1oit63gf8zbu2vOi+o05Q8VLUM
         7UrXPpLhaowrNL97g9Ob4gZW2okor7vl9WFUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702070843; x=1702675643;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mix9yN+rFBE8tcJIqsswkQecCZSelxz7obmiD13PDJk=;
        b=l/VIrMGkXO2m59uYrxwyhGBMn67U7nXGh51FCWwHmv7dawSSK3TE8Y1QLHiE06+Tih
         o3Qb5wOYf6t3iRz0SlcxVt+tJ0EwaidqaPX5hy0dmtZLiGV5oh3ro4gVpknj2ikF00J7
         qT1MbRRqtuGDGiS4AtUlWnDry0EcJhCTmCxpYbbZjU3Io4rqdxW6TsCEJJsKsPS1/KHP
         U2Fy5uFlEtdCTHkogZBwLu2/MkyDvAgvw9JxotsgrFetjvXCl5EswJaOYD+r93BSNzCd
         sAsV4out6/HRuUWfDpuYvpHk6rYnyL/MAnkA/LGQdAvfP6EsPPiMiFjm0TpVEx4sGYIo
         jA6Q==
X-Gm-Message-State: AOJu0YydWRwV8SSqVacmYSuFGlQzoaZjL/Ge5gmoiu9xgKLpLysgn2xC
        cn/jzSQnKB5lyWA8U6QbBVNIwA==
X-Google-Smtp-Source: AGHT+IFW9I9beJ59YFn0ICvmnTLt/nIR+xlNNNgyYig3pnrACbKn9r1AyU2p7cUe8mYp5UTVBMTrdQ==
X-Received: by 2002:a05:6a00:179e:b0:6ce:2731:c243 with SMTP id s30-20020a056a00179e00b006ce2731c243mr874129pfg.50.1702070843341;
        Fri, 08 Dec 2023 13:27:23 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u18-20020a056a00159200b006bf83e892e9sm2035637pfk.155.2023.12.08.13.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:27:22 -0800 (PST)
Date:   Fri, 8 Dec 2023 13:27:22 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] VMCI: Remove handle_arr_calc_size()
Message-ID: <202312081325.1202F2042@keescook>
References: <adf0c48a57d911be5509688614d2e00694ff57eb.1702068153.git.christophe.jaillet@wanadoo.fr>
 <202312081258.85F7D88E@keescook>
 <7fee5580-37ad-4c0a-b1d2-f45b592f86a4@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fee5580-37ad-4c0a-b1d2-f45b592f86a4@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 10:14:35PM +0100, Christophe JAILLET wrote:
> Le 08/12/2023 à 21:59, Kees Cook a écrit :
> > On Fri, Dec 08, 2023 at 09:46:09PM +0100, Christophe JAILLET wrote:
> > > Use struct_size() instead of handle_arr_calc_size().
> > > This is much more conventionnal.
> > > 
> > > Suggested-by: Kees Cook <keescook@chromium.org>
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > 
> > Looks good. And since capacity in u32, there's no need for size_add().
> 
> Hmm,
> 
> isn't u32 + u32 --> u32, so can overflow?
> If I understand correctly, the type promotion to size_t will occur after the
> addition.

Oh lovely, I thought the promotion was first. Ugh.

> So size_add() looks needed, or I missed something?

Yeah, and I'm also to stuck in pretending 32-bit systems don't exist.
So, yes, please include size_add()...

-Kees

> 
> CJ
> 
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> 

-- 
Kees Cook
