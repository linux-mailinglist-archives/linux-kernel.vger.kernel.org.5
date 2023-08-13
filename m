Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BED277A703
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 16:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjHMOlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 10:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjHMOlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 10:41:51 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBBA10FD
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 07:41:52 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so54398481fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 07:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691937711; x=1692542511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnO3PmCn30n5xbeq5GUi5oVZC3HsNOcy8ts4GlaH4vE=;
        b=CTC0lsczhmswXNxFIM3zvA/6X+f7vThA2LJ2rcZbyecUXg3iTed62Ipg+dmpBLb79B
         RgBe9gYx1wsPdFg2SUldO4WC5z38PQOCJufWrL3aua7aV6kkdaLpcQYjnGx3L7b0XYAB
         0KcejgbBkGAslci8El2DeARYPfUnW6KMd39lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691937711; x=1692542511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnO3PmCn30n5xbeq5GUi5oVZC3HsNOcy8ts4GlaH4vE=;
        b=ieNgOr1LQq6GsSiHfdLaT/2tgEd76TKhsIOH/x6aIuMyfRHkFhN6lcJbgGOkaEi9mf
         TqIXwSvx74hpiym+u6rTDAl1s0w16W/qcpGChOpgwh/hAlqdQ97K+uoAkloegbqIxcL1
         P2VmOllgPcPedgpA9P8WL5QJnolOcjo4+xZxqf5KplOUXt9RQ+tXgFave6fTP+EeEm+n
         a9Zwdxl/mEaV0S/X0eaWJyEHHqD7IhyeNEoithiL4/OohVq+xipyrfrLO+PgAShwm527
         WQXc2eOdwP4JAcPYzCtalCJsaTjblfAWeNuoLgDEh3TJ9yabptUXmanW/8bTULldX2ZT
         qMiA==
X-Gm-Message-State: AOJu0YxN9a2yRmHa8/Cs5cLMhy19xCVBhXuZvfam85OyBopNAXxd75cl
        qe/HcUJ+ABXUtbME9kAWjPXoDDWda9XtkEqvFWDyWQ==
X-Google-Smtp-Source: AGHT+IHxbQigoKtMcn3roqdpsFfVukg6GeGMbqguN1Xof1u3+VwFxhgH6/lyOLcKxb5c8D8h678jAV5EAh0ntivHY08=
X-Received: by 2002:a05:651c:104a:b0:2b8:67ce:4ad7 with SMTP id
 x10-20020a05651c104a00b002b867ce4ad7mr4969134ljm.6.1691937710915; Sun, 13 Aug
 2023 07:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230813033737.3731290-1-joel@joelfernandes.org> <2023081317-engine-pauper-2a6a@gregkh>
In-Reply-To: <2023081317-engine-pauper-2a6a@gregkh>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 13 Aug 2023 10:41:41 -0400
Message-ID: <CAEXW_YRW4Q2mtaKjyHpLhfjuF04aLO6UBrvWvUrOYSU-kg=7SQ@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Copy out ftrace into its own console file
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Joel <agnel.joel@gmail.com>,
        rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 2:28=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sun, Aug 13, 2023 at 03:37:36AM +0000, Joel Fernandes (Google) wrote:
> > From: Joel <agnel.joel@gmail.com>
> >
> > Often times it is difficult to jump to the ftrace buffers and treat it
> > independently during debugging. Copy the contents of the buffers into
> > its own file.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> "From:" doesn't match the signed-off-by :(

Yeah I suck. Apparently I still don't know how to send a patch after 13 yea=
rs.
