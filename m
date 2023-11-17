Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06707EF805
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjKQTsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjKQTsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:48:02 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B75D7A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:47:58 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4ac42a7bffeso806525e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700250477; x=1700855277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAQXfvLctTfegkgxivHiNBye3ms/lZ/+Cew/0koh39c=;
        b=D0TP6aory+bdaURvB00/Y8P2Nsls/8gzIPFQZqaykPiZLipzu3x9mL95sZVpVtMB9P
         KVJesVa9eiNRHejnxW4w8ieCqSf31x/YtyaGHH8iqTF7NqLsCzZSSK8m17yRgrkBazuc
         hbDkwEdfw5+E1g7s1hWkWxospYkdP7mD5Y1IshexbUXvF3SkmJYRjCnsj3oVcyTZfOrn
         sV21nqUcHpgQ6SV51PfKC6wm56tOgW6MlnbFdJEqOL3LDw/UmTbjHN99+IA5c+GpJXTd
         vnPAqhiq97665oZQZMLd5q6vO68dIXaq2WzJv3Mtu5ovOFKZikXK98ZHgVACV6BLf9SM
         7eDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700250477; x=1700855277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAQXfvLctTfegkgxivHiNBye3ms/lZ/+Cew/0koh39c=;
        b=aKdy59tZscPlGLrw9aXU76DVa7U9vWnjQB2IxntXjAP4lZT3B5p53wk7LNQucMHlT8
         4gmosiremymnztFHY+ZXBWv/UE9c7uwr6gvePK7wulPrC7wyY8GOlsmEJsRnDD82TtPa
         xkkGRopsV2Swp1e8gp4Agk16Jt4KYQKYZkr2VbiJQvkEoHTrGuZmNml3tPO6dlj6AoQM
         hu2Pcl+PY2SAGwOTkiosnY0Oq8e4XUuPz2tBfdPbDr35VNsTsntzWcW3o5I+tz+3bkQY
         tSU911p/lNXW4cCzTmgbkLtMxa+XueA7PkWink1msjVmbC4leMx4ZqUh9efoBEfXA2r2
         IT9Q==
X-Gm-Message-State: AOJu0YyUSRHBc3jbObZTIXfiYbnbtY519N6+cA18VsZNYU3gnGFxeEKv
        UZCeqaO7AMLY6Qbp4hsAcVjKW2XlG0nQMhn1YLg=
X-Google-Smtp-Source: AGHT+IGbJW+K2kVEHWCJQWfarsn2EJFeL5g07a3p5tGn8SR/9JYG2YtvjS0yb/bl4TIVFIt0b13QxXOs9ez40MwjSgk=
X-Received: by 2002:a1f:c301:0:b0:49c:79f3:27a4 with SMTP id
 t1-20020a1fc301000000b0049c79f327a4mr229846vkf.3.1700250477188; Fri, 17 Nov
 2023 11:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20231116173849.210205-1-kdipendra88@gmail.com>
 <3ff3e05a-8377-4b38-84ae-be24b6cae6a4@intel.com> <CAEKBCKNsw60QM=Ay6CH2Kuh-L8YdjVB5yScjG9pTZUXcBrsf5w@mail.gmail.com>
 <CAEKBCKP9WqurMp4M0Xfm3Jn_5roMGce+G6D3X2bNFuOPe5u07A@mail.gmail.com>
In-Reply-To: <CAEKBCKP9WqurMp4M0Xfm3Jn_5roMGce+G6D3X2bNFuOPe5u07A@mail.gmail.com>
From:   Dipendra Khadka <kdipendra88@gmail.com>
Date:   Sat, 18 Nov 2023 01:32:46 +0545
Message-ID: <CAEKBCKN02uSXH2hz7EV3PsgzNXbyT8N9wyyTvUAE79UJPo6mSA@mail.gmail.com>
Subject: Re: [PATCH] x86: Fixes warning: cast removes address space '__user'
 of expression in uaccess_64.h
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        mjguzik@gmail.com, ira.weiny@intel.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am sorry for the formatting of the text as it was due to changing to text
from html and also I wrote "why spare did not find the difference between
'long' and 'unsigned long' in this particular case." instead of "why Sparse
found the difference between 'long' and 'unsigned long' in this
particular case."

Thank you for your consideration.

On Sat, 18 Nov 2023 at 01:16, Dipendra Khadka <kdipendra88@gmail.com> wrote:
>
> Hi,
>
> I am not sure why spare did not find the difference between 'long' and
> 'unsigned long'
> in this particular case. I saw that in else case,there is use of
> unsigned long and sparse
> does not report a warning .Hence I thought casting to unsigned long
> will solve the problem.
> Also, there are not any other warnings thrown by spare in the uaccess_64.h file.
>
> I think casting x  to  'void __user *'before checking whether it is
> greater than or equal to zero
> in valid_user_address() will be more sensible and fix the warning either.
>
> Is this ok for you? Or have to cast to 'unsigned long' or other
> changes or no need to do anything?
>
>
>
> On Sat, 18 Nov 2023 at 00:00, Dipendra Khadka <kdipendra88@gmail.com> wrote:
> >
> > Hi,
> >
> > I am not sure why spare did not find the difference between 'long' and 'unsigned long'
> > in this particular case. I saw that in else case,there is use of unsigned long and sparse
> > does not report a warning .Hence I thought casting to unsigned long will solve the problem.
> > Also, there are not any other warnings thrown by spare in the uaccess_64.h file.
> >
> > I think casting x  to  'void __user *'before checking whether it is greater than or equal to zero
> > in valid_user_address() will be more sensible and fix the warning either.
> >
> > Is this ok for you? Or have to cast to 'unsigned long' or no need to do anything?
> >
> >
> > On Fri, 17 Nov 2023 at 21:04, Dave Hansen <dave.hansen@intel.com> wrote:
> >>
> >> On 11/16/23 09:38, Dipendra Khadka wrote:
> >> > Sparse has identified a warning as follows:
> >> >
> >> > ./arch/x86/include/asm/uaccess_64.h:88:24: warning: cast removes address space '__user' of expression.
> >> >
> >> > Since the valid_user_address(x) macro implicitly casts the argument
> >> > to long and compares the converted value of x to zero, casting ptr
> >> > to unsigned long has no functional impact and does not trigger a
> >> > Sparse warning either.
> >>
> >> Why does sparse complain about a cast to 'long' but not 'unsigned long'?
> >>  Both remove the '__user' address space from the expression.  Were there
> >> just so many __user pointers being cast to 'unsigned long' that there's
> >> an exception in sparse for 'void __user *' => 'unsigned long'?
> >>
> >> Either way, if we're going to fix it it seems like it would be better to
> >> valid_user_address() actually handle, well, __user addresses rather than
> >> expecting callers to do it.
