Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADB17E6BD6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbjKIN6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjKIN6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:58:39 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5BA2D77;
        Thu,  9 Nov 2023 05:58:37 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc329ce84cso8201905ad.2;
        Thu, 09 Nov 2023 05:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699538317; x=1700143117; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MJ2Yugpdshl/3e404VzjoLpD2eZMOhiQmXNMcCrfUBA=;
        b=njV3ct0F7fRU37V4U0L+jy/SXgxYpVgVjX3wHZiZwNybd26oLN1lNXRJi/RcKtuD1u
         Kqvy8symCuNkcmhytO07ddOLjv8cLvAp3SS6l33lBKMa+MmAyLsx+xISrd+/siyqpFFL
         8JAeR2MvOsQ9G202daH6l84suwP1u9UZ4ATgFgigRMk1BGg3me1HRELLt8ho7fbfhzV0
         7NIU8W2by+s8vFUTOr25iCdXSabAfeKZ3ll+T8YlZHHtSwh8L3tGsXhG4SK1C/vfJQuu
         m/Bs+pW8d+Ey7DaapeksNpj+5Kx3KBB8ZEtkNMx/LD5zuj4/3Q/QUu99mEvkNX2G6lJe
         7mYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699538317; x=1700143117;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJ2Yugpdshl/3e404VzjoLpD2eZMOhiQmXNMcCrfUBA=;
        b=lIPt1LH80ZeI06CASWwJBCP/BPmgSkW2GiMUgoqrFmrqXLsCxnZxfTwPtUXPuKRzj9
         6JGzxBLypIutQYNC86x/zfiKxysp0KK6gah5m/0MU4aLelYuh3dhzVUhs51V6AfvvzOo
         21Im3rJ0q9JhgXIZEac+wiBO2Wu2M2DuISxG2oqT4vhBzsJ8HTfm38YY8zm+yyiR8W/E
         qh6wlhotwVirzOp8dVNaJT9YI/bwk7X2CFLMQgQufy3GdXmB/cX5F831Ur1R5nf8m5/j
         fMesmqi44lI12Rk+Nt8ZbbwsuxvYNB0IvqiYpjN9QtCwAb7Q6ExrX4b5z/f9sDxAZvgE
         od8g==
X-Gm-Message-State: AOJu0YxQSeS/wZG6ficgtRqAwG2uSow+HogYfxrr3tYq5Lrp3/0Lm+gz
        l4EacefXKRFp7i+NF6gSy4E=
X-Google-Smtp-Source: AGHT+IExvxestKO7fV1vELNiWp3dvutl5J9p7FLkQYJZvt/F0qz8EWfCcBogWa4LEicVF6w5vL7T5Q==
X-Received: by 2002:a17:902:e751:b0:1cc:630d:8a5e with SMTP id p17-20020a170902e75100b001cc630d8a5emr6285495plf.48.1699538316976;
        Thu, 09 Nov 2023 05:58:36 -0800 (PST)
Received: from rigel (14-203-18-70.tpgi.com.au. [14.203.18.70])
        by smtp.gmail.com with ESMTPSA id iy3-20020a170903130300b001c9dac0fbbasm3577432plb.63.2023.11.09.05.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:58:36 -0800 (PST)
Date:   Thu, 9 Nov 2023 21:58:31 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     heminhong <heminhong@kylinos.cn>, linus.walleij@linaro.org,
        brgl@bgdev.pl, andy@kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/gpio: prevent resource leak
Message-ID: <ZUzlh9M-w4ZITvGW@rigel>
References: <20231109085419.84948-1-heminhong@kylinos.cn>
 <ZUzSM37FWz6sgH9n@rigel>
 <CAHp75Vd5Ea_yFb7tEQw5ZBr90CcETa-_BsbfpfFshFx8ddZqQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vd5Ea_yFb7tEQw5ZBr90CcETa-_BsbfpfFshFx8ddZqQA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 03:53:45PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 9, 2023 at 2:36 PM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Thu, Nov 09, 2023 at 04:54:19PM +0800, heminhong wrote:
> > > In the main() function, the open() function is used to open the file.
> > > When the file is successfully opened, fd is used to interact with the file,
> > > but the fd is not closed, it will cause resource leak.
> > >
> >
> > All open files are automatically closed when a process exits.
> > That includes both those returned by open() and by the GPIO ioctls.
> > So explicitly closing them here before exiting is redundant.
>
> I would argue that this is a good practice for GPIO cases.
> More the GPIOs we have, the more line handles we can get, then default
> MAX open FD limit may occur. The best is to combine both.
>

That makes sense if the application is long lived and is continually
requesting and releasing resources, but that is not the case here - this
is a short lived app that makes a single request.
Note the "here" in my initial reply.

Cheers,
Kent.

