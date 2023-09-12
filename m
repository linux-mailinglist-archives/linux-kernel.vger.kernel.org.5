Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31E179D8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbjILSd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjILSd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:33:57 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4630010D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:33:53 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-56f84de64b9so96566a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694543633; x=1695148433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYj8kQK94vyfpA0qvUS8rx44v/iPFppkj9lEtRsUc4k=;
        b=sRyw8LK3a6TXHVMm4bhblgulJv0bPVRqsBllosVteB4h73xTnpQChTG+x8aJDYbayu
         bFlcSon4b0SHkePwqu4UQrMYIleMrQ8l4Zn/n+lz7/tStpmffAgdcZGq73iKqc1u8o9i
         21DZZhT5YV3vWDiktHLlVyG51aHLKPGVy+A7mS0sTjYTrQB8HwG9etbbzn21r3DoFAwR
         SFPF23FlfPcqTE9CW0N4ZEyAaiWw0IjiiwiBTevZwzs3SvA9J19QGmouExFjEvH+venc
         4ycqEsYCEzE5LGZOsE81LOKGKq0ECkACuXkfUw42Oc0QNd28ukGQeGlvrG+myxCQPLOE
         hSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694543633; x=1695148433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYj8kQK94vyfpA0qvUS8rx44v/iPFppkj9lEtRsUc4k=;
        b=EB7imcjD9WF/9ALas99Qnv/aZHzDuwO4/CnyG29mPH29zKPofslJFLJz7DWs79Kmv+
         S/tNM/t+BlT2ZbGkyIY/vOv4E10btsbB+uzHtvujy6Nw6gEs/EuxHmkxEALy8wH+28PN
         jJrRzEm28IqVmChhkPx27vVGaZXt02MHMdBzGMTeJZXmjI5vDjUgcC6DHBD7Mh3O4/N1
         gD/mvkpCc5Uhrkim8+ISOEYdcQYXWYIJqQjm6vwQlmMgk0JEjKG89DOW9Vsf2ww/6XcR
         dZWEkl5Ez/jNx7yE/OtPQNOsM8S8NgiGk0FovPj8YksdRKO3B/qCxozwT57FnGtphcWo
         jjKQ==
X-Gm-Message-State: AOJu0YzUJxm0W9JUL2zQspnPlaX2L7zLpjKSYQRRFp5i3OwRhr/WjRwx
        XhGb86GILywjGii66+HNd38=
X-Google-Smtp-Source: AGHT+IF7fDzqbHbNsUl08eqx0pSVWEB6ibiUrpZtVx9umgEfPZR6P4G/JPa9kYP+sWlXuG6EsjL+9Q==
X-Received: by 2002:a17:90b:1d90:b0:26d:4d1c:5395 with SMTP id pf16-20020a17090b1d9000b0026d4d1c5395mr4542838pjb.18.1694543632655;
        Tue, 12 Sep 2023 11:33:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090a800100b0026971450601sm7606751pjn.7.2023.09.12.11.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 11:33:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 12 Sep 2023 11:33:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>
Subject: Re: Linux 6.6-rc1
Message-ID: <7d549be3-0b46-4c71-9296-b72ccf47fd86@roeck-us.net>
References: <CAHk-=wgfL1rwyvELk2VwJTtiLNpwxTFeFtStLeAQ-2rTRd34eQ@mail.gmail.com>
 <3c85e5f7-c9a4-4c77-b4e9-3b476ac6c1fb@roeck-us.net>
 <CAHk-=wh+rYcuh0zp3b3qFuhwykXK1u1HcpRPCpeZ5EUnUKjJew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh+rYcuh0zp3b3qFuhwykXK1u1HcpRPCpeZ5EUnUKjJew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 11:17:07AM -0700, Linus Torvalds wrote:
> On Tue, 12 Sept 2023 at 11:00, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > loongarch:
> >
> > INFO: trying to register non-static key.
> >
> > Caused by commit 0a6b58c5cd0d ("lockdep: fix static memory detection even
> > more"). No fix available as far as I know.
> 
> Isn't this
> 
>    https://lore.kernel.org/lkml/ZPl+Y2vRYUnWtTQc@ls3530/
> 
> the fix? You even replied to that saying it's fixed.
> 

Sorry, I should have be more specific. You are correct, that was a
suggested fix, not a proper patch.

Guenter
