Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202FE7AC679
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 05:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjIXDVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 23:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjIXDVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 23:21:02 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C6A136
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 20:20:55 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c46b30a1ceso38283935ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 20:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695525655; x=1696130455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vm7SCjjGy1Czz0oUxMb12CgrgnjC7R0vO3/WEnyLchc=;
        b=nnMWdjCMIB1XJ7/J5zhYC2iOXRCSPzJkNbPokyjM6/w1ON8c5NpFRHs6XmX0DheMSK
         0eKC9bDoU3yogqLfAGT/5ymWdu72faS05bCtYgEkxc49u9PybwIuyk88IDx0YjgDQJaK
         5ZdSZsitUR9UlwMBSwy9xPVIZZWgtha2YhZ3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695525655; x=1696130455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vm7SCjjGy1Czz0oUxMb12CgrgnjC7R0vO3/WEnyLchc=;
        b=f41DgMgiNHMGaP1rnnnXKre8tqsH8S6rYAqoxcdQZaXYWLzJp4U31BelovYT1BfjN8
         sigWze+YLhhvK1GiDM5Y4h+etQvYy9bGySRqdi6zRkdpFsDRn5gwt+FDfA2F+CHtSo8O
         8XUgTjUcFaCAeCFHK0N756/JtjS0iCmv2qVp2mSNz0c1CpLjzqTWplCVAIslPIHi7lqL
         9ARPblFHerMPLbpV4ftrZoR86TUsfMunl/Y4Q6w5YKmMWzqAVAHXgxisqNQnbZDMenKt
         Hvrc6Wjv+uW81eeN6hWxy+mJiAEFhIU8WrNJsEth4XsbXpIkkBIJj1uMv1ifOFMG2sC+
         hOow==
X-Gm-Message-State: AOJu0YzjbotHhFKh4YXq4O+4le93s9E+Ja6weQJk0aSR65RQS0U3Yb2I
        yuNh5hkysJ+ueQK2T8Krd2B+hg==
X-Google-Smtp-Source: AGHT+IEH+ufcAfsC/h1xsmpcmOa3SWqJmAQ4vBQv3H+anN+BqhYa/Dh+uB5O8ypum1NEvfheOeVWpQ==
X-Received: by 2002:a17:903:120a:b0:1c4:2641:7744 with SMTP id l10-20020a170903120a00b001c426417744mr4619036plh.25.1695525655440;
        Sat, 23 Sep 2023 20:20:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902d2cb00b001c1f4edfb9csm6070846plc.173.2023.09.23.20.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 20:20:54 -0700 (PDT)
Date:   Sat, 23 Sep 2023 20:20:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dean Luick <dean.luick@cornelisnetworks.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Justin Stitt <justinstitt@google.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] IB/hfi1: replace deprecated strncpy
Message-ID: <202309232019.BE78A9C0@keescook>
References: <20230921-strncpy-drivers-infiniband-hw-hfi1-chip-c-v1-1-37afcf4964d9@google.com>
 <169537858725.3339131.15264681410291677148.b4-ty@kernel.org>
 <2f4bd46c-664e-4253-8d57-16bd46dd3be8@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f4bd46c-664e-4253-8d57-16bd46dd3be8@cornelisnetworks.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 09:25:39AM -0500, Dean Luick wrote:
> On 9/22/2023 5:29 AM, Leon Romanovsky wrote:
> >
> > On Thu, 21 Sep 2023 07:17:47 +0000, Justin Stitt wrote:
> >> `strncpy` is deprecated for use on NUL-terminated destination strings
> >> [1] and as such we should prefer more robust and less ambiguous string
> >> interfaces.
> >>
> >> We see that `buf` is expected to be NUL-terminated based on it's use
> >> within a trace event wherein `is_misc_err_name` and `is_various_name`
> >> map to `is_name` through `is_table`:
> >> | TRACE_EVENT(hfi1_interrupt,
> >> |        TP_PROTO(struct hfi1_devdata *dd, const struct is_table *is_entry,
> >> |                 int src),
> >> |        TP_ARGS(dd, is_entry, src),
> >> |        TP_STRUCT__entry(DD_DEV_ENTRY(dd)
> >> |                         __array(char, buf, 64)
> >> |                         __field(int, src)
> >> |                         ),
> >> |        TP_fast_assign(DD_DEV_ASSIGN(dd);
> >> |                       is_entry->is_name(__entry->buf, 64,
> >> |                                         src - is_entry->start);
> >> |                       __entry->src = src;
> >> |                       ),
> >> |        TP_printk("[%s] source: %s [%d]", __get_str(dev), __entry->buf,
> >> |                  __entry->src)
> >> | );
> >>
> >> [...]
> >
> > Applied, thanks!
> 
> It is unfortunate that this and the qib patch was accepted so quickly.  The replacement is functionally correct.  However, I was going to suggest using strscpy() since the return value is never looked at and all use cases only require a NUL-terminated string.  Padding is not needed.

Is the trace buffer already guaranteed to be zeroed? Since this is
defined as a fixed-size string in the buffer, it made sense to me to be
sure that the unused bytes were 0 before copying them to userspace.

-Kees

> 
> >
> > [1/1] IB/hfi1: replace deprecated strncpy
> >       https://git.kernel.org/rdma/rdma/c/c2d0c5b28a77d5
> >
> > Best regards,
> 
> External recipient

-- 
Kees Cook
