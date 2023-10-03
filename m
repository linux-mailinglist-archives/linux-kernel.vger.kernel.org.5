Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800A57B72E0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 22:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241129AbjJCUyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 16:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241100AbjJCUyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:54:18 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FDEAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 13:54:14 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7aae07e7ba4so673296241.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 13:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696366454; x=1696971254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSF3rAZ/OYaS8r3BMyNvB7IqKeUPgct0QtaKI/2kXKU=;
        b=bh4aG8/qSiH5vYhLQGU5t6mVxNmu+WjiglaIC433cj4KuO7peQV/oo/l1jq+hNMWXl
         q8I6ZV5FVEo3XF6JEHB9buZ6ICNWZX/kTJUJ+uoX2t29zux+E4gzO0sQxqgwjxaJsHUG
         4d/jUQ/BKiDZjfD7ZeCNxWVFJhdwUPK3VjuT1sjBb/Woxta9Z2cO4sMU3berFT1wg0v7
         S5AF8qzmWeTRVWJhwcTmFyg1MJX13hMn5vbRcnAjpS51yxAiKpRP0/15UPdXS/2qHSFq
         5pzEIjtKlhTxPMAv8gbo3Fajbnmudg/0+Fb7+MRiVzH1V7yruH8yU6amaBtNrZCIaBJx
         wTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696366454; x=1696971254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSF3rAZ/OYaS8r3BMyNvB7IqKeUPgct0QtaKI/2kXKU=;
        b=ZtlPcS8Usf6OJwhAtDB1z0D5r12RL+jJ9isZphcBKreWPe+vBhw4Kz5Gj6KZ8SO4NU
         uSgSeEF/BHpIi8apNB08kBOBz9yTx5P7/C5+pBaH0AdvH1wSv4V7KO7ZxX6n9fBoENCn
         LsWdgaNovTLqAGOBq/8esbOI7GmFL2GVftZ6/xp6ezsV6Vv0bwM6Fd3EWlaa1NBImYkT
         Ko37fL7/1WNTyPQqhKljULqtcH4Ua7QevCp9X9THM1aWk3yuB/ixY8o8Lzzf2ZYioKQM
         dUxjxiKrjuI8pwoy/o7YubvABK9mSkuWDmqZMIFpurs3/9LtixiU1B0je/t2Kq68tCm1
         WdNw==
X-Gm-Message-State: AOJu0YyPhDhGweKsZyIWWejG2Xn/SCt1liJBoGeAlhhVHh8TbEpdzYCw
        PazdYs85/39eTtK2hROMmt4yGG2hVgSjra92G1o=
X-Google-Smtp-Source: AGHT+IE1YEGj2aiIvJ4SRC3IlUO0ordqzoJ2W87sPHDHrDkG8gp24OU67L+rSC223Qe2cKG3kS4rqVGus/pLg4ZBmQ4=
X-Received: by 2002:a05:6102:3a76:b0:454:6dc6:cd5e with SMTP id
 bf22-20020a0561023a7600b004546dc6cd5emr510382vsb.15.1696366454006; Tue, 03
 Oct 2023 13:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230915154856.1896062-1-lb@semihalf.com> <CAJfuBxyFYyGCtr5i=P7N=1oX3J=jmdp1VLGLt+z1fAnuvGK2aA@mail.gmail.com>
 <CAK8ByeJBrPEQSgUc91LQO9Krzjh2pauhMTjEC82M8ozayE76Yg@mail.gmail.com>
 <CAJfuBxxmL-GtBgt=033F9UNeLCreFbJh3HrQQN2nYKwR_0uTbg@mail.gmail.com> <20231003155810.6df9de16@gandalf.local.home>
In-Reply-To: <20231003155810.6df9de16@gandalf.local.home>
From:   jim.cromie@gmail.com
Date:   Tue, 3 Oct 2023 14:53:47 -0600
Message-ID: <CAJfuBxyJyFbFEhRxrtxJ_RazaTODV6Gg64b1aiNEzt6_iE4=Og@mail.gmail.com>
Subject: Re: [PATCH v1] dynamic_debug: add support for logs destination
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 1:57=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Mon, 2 Oct 2023 14:49:20 -0600
> jim.cromie@gmail.com wrote:
>
> > hi Lukasz,
> >
> > sorry my kernel-time has been in my own trees.
> >
> > What I dont understand is why +T is insufficient.
> >
> > IIUC, tracefs is intended for production use.
> > thats why each event can be enabled / disabled
> > - to select and minimize whats traced, and not impact the system
> >
> > and +T  can forward all pr_debugs to trace,
> > (by 1-few trace events defined similarly to others)
> > or very few, giving yet another selection mechanism
> > to choose or eliminate specific pr-debugs and reduce traffic to
> > interesting stuff.
> >
> > Once your debug is in the trace-buf,
> > shouldnt user-space be deciding what to do with it ?
> > a smart daemon could leverage tracefs to good effect.
> >
> > IMO the main value of +T is that it allows feeding existing pr_debugs
> > into the place where other trace-data is already integrated and managed=
.
> >
> > At this point, I dont see any extra destination handling as prudent.
> >
>
>
> I'm fine with either approach. I kind of like the creation of the instanc=
e,
> as that allows the user to keep this debug separate from other tracing
> going on. We are starting to have multiple applications using the tracing
> buffer (although most are using instances, which is why I'm trying to mak=
e
> them lighter weight with the eventfs code).
>
> -- Steve
>


Ok Im starting to grasp that multiple instances are good
(and wondering how I didnt notice)

What doesnt thrill me is the new _ddebug field, it enlarges the footprint.

can you make it go away ?
I have some thoughts ..
