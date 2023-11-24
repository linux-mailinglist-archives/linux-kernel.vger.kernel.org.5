Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9E27F6DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjKXIOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbjKXINp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:13:45 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF36B1721;
        Fri, 24 Nov 2023 00:03:00 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a03a900956dso311255366b.1;
        Fri, 24 Nov 2023 00:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700812979; x=1701417779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+9mS8wUs/EyfGlD/tVfrIDSEpr686gFINNJUf7j5xY=;
        b=eDQR9nrYnf6SkLws71k4ssq4McScH9B5Hg2Qj0w5xqQTJws6NbUojh/gOIDKkeO/dR
         JLIbagKWLfJaHeopNqXj6nwc3biNidtFoyFjgpCCQKzzWjCkQEhj0iqM11KDRq43r6ec
         hFJxqCndDBpaUwG5UR9vufmQQ0T0GnDL1TINuru9ri56X1lE1vyOQy60iuOaF7REEYXk
         ChDbOHIFr1rC8ZJMQy6szYGNIWDnLcknFxpbsorAMm1U56wU4E9r6SyCiwlqcuS4JjIy
         uU60b2VFOfh74dYs8JZhvvTHW+DUd4xhHORBXurZcIUptnUw65Y+VBwvstTzQw7Z//re
         TG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700812979; x=1701417779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+9mS8wUs/EyfGlD/tVfrIDSEpr686gFINNJUf7j5xY=;
        b=GNMdoGw9BxPuXrbuYdmPMz7Bx1NC26OzxHVhTZIzkeLHHgJoSf4Flm6HgK7bwaRi1K
         aKcJklqyTQ4emc1PNcZmdxQzNFgkAeNRPBfzkU13WXNSpf3jJuJVqqv8PWw4/Pru9q+/
         YiNmhoGnJcxBhryUNONUCG12NsKWR7Sz5dh0Wuo0NBt6iZ8VbvoDHuu8bwPS3UjhBZMV
         eQKSMo9MMKZ/iO1VaCblgjARYVdWa1wLUQr3/+tOmetms0vs0z6JkKrR11au9jDJ0awo
         ZEh4nxzOol+X4O+kOZs4lfwZFDGchexpZn7qqx2oRSLMX0C4Z0ql0Q6yr2OLOWHyDnLC
         nQTw==
X-Gm-Message-State: AOJu0Yw6waZVdUWgbZaazRgF+ehsb706TaOvrnkZoNqj9vM/7GCHen9a
        c6YDMJO2hjWYePIusgaMwbpc/5VFNvjrE/vGR8RVAH8JQ4w=
X-Google-Smtp-Source: AGHT+IHi5zsC9aRjfdWcgHeJlktzyKKA6C2Wi5zbBpTEKNZhohPdG5Q+EzM0n6b5E1Q4LY+WIGLlxIwly8m3FgC26Ec=
X-Received: by 2002:a17:906:e17:b0:9e8:1ba0:18fb with SMTP id
 l23-20020a1709060e1700b009e81ba018fbmr4498898eji.29.1700812978787; Fri, 24
 Nov 2023 00:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20231124060200.GR38156@ZenIV> <20231124060422.576198-1-viro@zeniv.linux.org.uk>
 <20231124060422.576198-3-viro@zeniv.linux.org.uk> <CAOQ4uxjyS45FKJORfxpMHeFbZhszNR2QM6nTF46UxT1iz85Gsg@mail.gmail.com>
 <20231124075509.GU38156@ZenIV>
In-Reply-To: <20231124075509.GU38156@ZenIV>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 24 Nov 2023 10:02:46 +0200
Message-ID: <CAOQ4uxhVCzJtX7sNqHH2btkGY-Lnin4GjvXJv1nEEfk-O+EK_g@mail.gmail.com>
Subject: Re: [PATCH v3 03/21] dentry: switch the lists of children to hlist
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 9:55=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Fri, Nov 24, 2023 at 09:44:27AM +0200, Amir Goldstein wrote:
> > On Fri, Nov 24, 2023 at 8:05=E2=80=AFAM Al Viro <viro@zeniv.linux.org.u=
k> wrote:
> > >
> > > Saves a pointer per struct dentry and actually makes the things less
> > > clumsy.  Cleaned the d_walk() and dcache_readdir() a bit by use
> > > of hlist_for_... iterators.
> > >
> > > A couple of new helpers - d_first_child() and d_next_sibling(),
> > > to make the expressions less awful.
> > >
> > > X-fuck-kABI: gladly
> >
> > ???
>
> It breaks kABI.  Hard.  For a good reason.  And if you need an elaboratio=
n
> of the reasons why kABI is, er, not universally liked - let's take it
> to private email.  Some rants are really too unprintable for maillists...

I don't mind rants, even quite fond of yours :)

But "X-fuck-kABI: gladly" serves no real value.
You'd already documented the kAPI change in porting.rst.
If you want to add a note about kABI, I suggest that you add it there.

Thanks,
Amir.
