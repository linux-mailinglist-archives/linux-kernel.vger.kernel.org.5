Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6A67929F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355299AbjIEQas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354034AbjIEJXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:23:34 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B780E9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 02:23:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31dca134c83so1877849f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 02:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693905809; x=1694510609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SBahfcXaogv50Nn5DeDfJ3oNR58HGAjSmwpQpqZujZE=;
        b=GAwTEyhXvlyuSLkzAk/nQ3EWwjOKUlun/lf6znhR8polvzVCF2wqGAgZeahHFEXLVh
         jOM9ZKkvl7UyQSwhO0nWHx6byRToXDiwk7+THr985lyaFY/SPlaIWQYWyO31wGSZcXFg
         kVlQtyFp+D9/H9JTU++m+U14tKSGYrsK7YwS8Y1h6vqB4bEf5s9wJ9/9P0AzgBss40Rr
         oWgJeZEVoFo829BNRjbPVwFCskLmUp5zeJciXTjn7rkl2YgReevMAggY1Xks2/cxYOVL
         uFpnLBGDIO5myjVEhtlGVKKlaRckUQNf7QiS97B+zi3Fhh89NJ2QyZ+B5/9XT32xt/z+
         52Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693905809; x=1694510609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBahfcXaogv50Nn5DeDfJ3oNR58HGAjSmwpQpqZujZE=;
        b=lJyx+SkOvzGNSJvcDvM/S0UIS5wRdetC/tlztoo8bTJLEWh/BPa2tqZC+82z0NY19w
         /F5IYCOgjznd6nx40RMMHzGb0asRDwN+Ur19wVEkLrjltvDEP7Q1QPjqFDifQQHFsDPN
         uV4AyzfHH4GRDATiD+SnsqUjVjKMY1SfNPgAZBqihw5jupQekyRNCeySX5fmGS+xVZZL
         HjSXRLW4TtEgVYXVQGB1g8UnO2cXSiOInWGD7rQJ6uPOMop0CEMKrBecFcwW5Li5EPji
         JH/tzvNiYgUZZPBvfgUGtbX4wFQUrh6gAugkPc2eUK3+ZnnCWNDxk9tNOElqUa43y+kr
         BxMA==
X-Gm-Message-State: AOJu0YxZN7XPETzpD4GWzxdZ5JgSWI9O9850CAH/b045/Vy0BC9P31jY
        XpXxKCJ0mIUBHP+i8Grj0ErxVUwGquMTHqGJsng=
X-Google-Smtp-Source: AGHT+IH9nEMmiLCIFRhneY6xWsRBk+qFzsEKDGdSI2xP2TEJLDVPa0zaF0xPyCX8WGVwGIgz8Z1u2w==
X-Received: by 2002:a5d:4ac4:0:b0:319:7230:d76a with SMTP id y4-20020a5d4ac4000000b003197230d76amr9292354wrs.38.1693905808894;
        Tue, 05 Sep 2023 02:23:28 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d4bca000000b003180155493esm16867491wrt.67.2023.09.05.02.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 02:23:28 -0700 (PDT)
Date:   Tue, 5 Sep 2023 12:23:25 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, philipp.g.hortmann@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: prefer strscpy over strncpy
Message-ID: <b5fcb0cd-73f7-41dc-969e-ced84edd421a@kadam.mountain>
References: <20230805075114.15186-1-straube.linux@gmail.com>
 <2023080952-maroon-waviness-9621@gregkh>
 <b15bc777-b470-3c15-5ea7-8ef2f89622c3@gmail.com>
 <cbca3311-2d5d-4b87-8966-e2b57d74d6e1@kadam.mountain>
 <69226eca-d345-f6fa-59fe-3c55674cc534@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69226eca-d345-f6fa-59fe-3c55674cc534@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 07:13:42AM +0200, Michael Straube wrote:
> On 8/10/23 07:01, Dan Carpenter wrote:
> > On Wed, Aug 09, 2023 at 08:02:05PM +0200, Michael Straube wrote:
> > > On 8/9/23 14:21, Greg KH wrote:
> > > > On Sat, Aug 05, 2023 at 09:51:14AM +0200, Michael Straube wrote:
> > > > > Replace strncpy with strscpy in two places where the destination buffer
> > > > > should be NUL-terminated. Found by checkpatch.
> > > > > 
> > > > > WARNING: Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90
> > > > 
> > > > If a global search/replace could be done, it would have happend a long
> > > > time ago.
> > > > 
> > > > How was this tested?  The functions work differently, are you sure there
> > > > is no change in functionality here?
> > > > 
> > > 
> > > It was only compile tested. To me it looked as it does not change
> > > functionality, but looking a bit deeper at it I'm not sure anymore.
> > > So, we should leave it as is.
> > 
> > So there are three main differences between strncpy() and strcpy().
> > 
> > 1) The return.
> > 2) strncpy() will always write net->hidden_ssid_len bytes.  If the
> >     string to copy is smaller than net->hidden_ssid_len bytes it will
> >     fill the rest with zeroes.  This can be important for preventing
> >     information leaks.
> > 3) strscpy() will always add a NUL terminator where strncpy() just
> >     truncates a too long string without adding a terminator.
> > 
> > We want #3.  We don't care about #1.  The only thing to check is #2.
> > 
> > regards,
> > dan carpenter
> > 
> 
> Thank you Dan,
> 
> so in this case we should/could replace strncpy with strscpy_pad,
> correct?

I'm pretty sure that strscpy() was correct.  It requires some analysis
in how this is initialized and/or used.

Don't just automatically use strscpy_pad() to try avoid doing the
analysis.  ;)

regards,
dan carpenter

