Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4357D2A37
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjJWGS6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Oct 2023 02:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjJWGS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:18:56 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37AA10C0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:18:53 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5aaebfac4b0so1438463a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698041933; x=1698646733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oY3KVPJZDN5B1mC9ixo9DAttDXi3GZI2y9Bgw45cDd8=;
        b=kra93MhIcI+mzB/pWjDEw/DiSRzmPh49bgNFYBnEybM1GwWl0kuwtzvp7DUqn9clvn
         VrwyJQq6yezjrZDJBM37EgVxGrKJIiYX/3HOZ5z2Q4em/w3A9VjCpaEigzRTQRyz9Ucx
         o1efhOa/C09tLZstcVGgHKgSObXy1vBhfdzDqrDliggJGrwwZnSk4FzA9exOQoq/p+Og
         ArC/Wi/TLf6pgS6xCmE+9q4vIRrs2ZCMEdQaVjb3FYkcqovpwEemj/W4BsHfEfc6hVFo
         SpBC0gWZocbci9HHqsa+H36GlaMEsyJhg8mCWRdLHsCieF7/kgxzLGVncH0wbxMQUYpN
         8/XQ==
X-Gm-Message-State: AOJu0YxCTjge+Nh97u2UAbGWSi6qWEkms/74evFeySrGFzRHe2uIWt0m
        FL8R6fofJu7MExv0sZDutK/7KajC4cN7O/V8vcw=
X-Google-Smtp-Source: AGHT+IEKpX9/QMS1JqYPyKFMkTHWUx9SEB6l+eBwhfrXStCogym7MPS05OEg0QkCcTIBsGR4eCYUdtEb8JCCc3CV5jY=
X-Received: by 2002:a17:90b:3a8c:b0:27d:dc9:be7a with SMTP id
 om12-20020a17090b3a8c00b0027d0dc9be7amr5774303pjb.7.1698041933041; Sun, 22
 Oct 2023 23:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230601075333.14021-1-ihuguet@redhat.com> <CAMZ6RqLoRVHD_M8Jh2ELurhL8E=HWt2DZZFGQvmfFyxKjtNKhg@mail.gmail.com>
 <874jiikr6e.fsf@meer.lwn.net>
In-Reply-To: <874jiikr6e.fsf@meer.lwn.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 23 Oct 2023 15:18:41 +0900
Message-ID: <CAMZ6RqLJmTjM0dYvixMEAo+uW+zfhdL1n4rnajsHCZcq971oRA@mail.gmail.com>
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
To:     Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Cc:     ojeda@kernel.org, danny@kdrag0n.dev, masahiroy@kernel.org,
        jgg@nvidia.com, mic@digikod.net, linux-kernel@vger.kernel.org,
        joe@perches.com, linux@rasmusvillemoes.dk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon. 23 Oct. 2023 at 11:28, Jonathan Corbet <corbet@lwn.net> wrote:
> Vincent MAILHOL <mailhol.vincent@wanadoo.fr> writes:
>
> > On Thu. 1 June 2023 at 16:53, Íñigo Huguet <ihuguet@redhat.com> wrote:
> >> EditorConfig is a specification to define the most basic code formatting
> >> stuff, and it's supported by many editors and IDEs, either directly or
> >> via plugins, including VSCode/VSCodium, Vim, emacs and more.
> >>
> >> It allows to define formatting style related to indentation, charset,
> >> end of lines and trailing whitespaces. It also allows to apply different
> >> formats for different files based on wildcards, so for example it is
> >> possible to apply different configs to *.{c,h}, *.py and *.rs.
> >>
> >> In linux project, defining a .editorconfig might help to those people
> >> that work on different projects with different indentation styles, so
> >> they cannot define a global style. Now they will directly see the
> >> correct indentation on every fresh clone of the project.
> >>
> >> See https://editorconfig.org
> >>
> >> Co-developed-by: Danny Lin <danny@kdrag0n.dev>
> >> Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> >> Signed-off-by: Íñigo Huguet <ihuguet@redhat.com>
> >> ---
> >
> > Is there any news for this patch? I would really love this to become mainstream.
>
> I have concerns about this patch that I have expressed in the past.
>
> I'm not going to apply it... since it's a global change that affects all
> kernel developers, I don't think I *should* apply it.  I would recommend
> sending it directly to Linus; if you can get an ack from him, I'll apply
> it then.

Hi Jonathan,

Thanks for the comment, message taken.

Hi Íñigo,

The last version of the patch being from you, would you like to bring
the topic to Linus yourself or shall I do it instead?


Yours sincerely,
Vincent Mailhol
