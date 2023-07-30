Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6AA768922
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 00:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjG3WdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 18:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjG3WdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 18:33:15 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD46ED
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 15:33:15 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d299ed34bacso2819539276.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 15:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690756394; x=1691361194;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JR9aexNmxAlQxfM2LSqNL9gFqlh4cK9n6lEPPYGa2sg=;
        b=i/ZMYsS5fiHtMOwrS4wfPWPkDvE5PLrH3YypUxgPgN+ar/NN5nGBMw5ALNPYFLzWAI
         Mxa0jFmNeG56gRaznxvM1HHTEdoblteYTtW7abaCRqFx0DGhtlH9FjUuuOJ3uU0t6SRF
         rlNnmSfhx+aUs159+M4QQGxlXuQZ2IpGkrocrnVwrIK59nc578zkxge9ubYirpIEdvHW
         RSkK/bX022YMGlynKAX8GcWdpOw3OtnqBJsSA7RqT+6VR6PmMqm14ndhbWSN9gaVygOj
         vqT9WpanmTpInoUvbuZ/T17+dGqvW8Zl4s942agY5AH94Qs1KbWhfSokLHaqh3t5NqRY
         3cEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690756394; x=1691361194;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JR9aexNmxAlQxfM2LSqNL9gFqlh4cK9n6lEPPYGa2sg=;
        b=lIZ8I4jeHcicGayUOFEu28JtFGSPLkznM+QrKOVPL9Myo2f8wGdqfyl3+CG1F5Ebop
         TJNn2zDJsjoFoagzUGfT1IyBBDKgVKrDI0EIkUAwlqwgkjZnEUwXgOq6LIzNu+vTqMvg
         9nD1pPR7/ZzaliHAPvAgSWQmtMD8wz5O+hu1ETaQkV8H77e+7HQgG9Ki8IFhWVoDlVQH
         cspC+xoPumt7inpEkdYr4yHVB0oLx3i8t3HI4iPiM0s4h+n9irRkpcAw2WU1WrAHs9rC
         5q+BVqK57GQoEiHMT46Y4wql92cQxyD7gAKqZbi9j8woX+GcYSJN7PhW/fjZ84nfGRM0
         lJ3A==
X-Gm-Message-State: ABy/qLYdbdQsv1IqnJH7E3EGRbsVKHGO0qsbNg9fyTnr4JQ9OYFV48tv
        ccI+F08vGBGQUiGs0sigav//IZlpzT+Qoh+7NGO9qCR/hLz1Zw==
X-Google-Smtp-Source: APBJJlHZ1YMSYsnurs27MVXETByRzeYY2DzVDBzwO2fa4K+eRKwjVTWP/TwFTKBAtMaeaCDN3urA2xooOLBQg57Uxic=
X-Received: by 2002:a0d:e614:0:b0:583:8c62:b162 with SMTP id
 p20-20020a0de614000000b005838c62b162mr9363184ywe.4.1690756394191; Sun, 30 Jul
 2023 15:33:14 -0700 (PDT)
MIME-Version: 1.0
Reply-To: tjcw@cantab.net
From:   Chris Ward <tjcw01@gmail.com>
Date:   Sun, 30 Jul 2023 23:33:03 +0100
Message-ID: <CAC=wTOim6VZM7gKGQ8KuvbVSdmjyg=4G5sFbr+xY89ujPVOq8g@mail.gmail.com>
Subject: vfat file system does not allow a space at the end of a directory name
To:     linux-kernel@vger.kernel.org
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

I had a zip file (from downloading pictures from Google Photos) where
some of the directory names had a space at the end. This unzipped fine
on an ext4 file system, but gave errors when unpacking onto a USB key
which had a FAT file system.

On further investigation, file names have the same problem. On my USB key, I get

tjcw@tjcw-OptiPlex-7010:/media/tjcw/Photos$ touch 'aab '
touch: setting times of 'aab ': No such file or directory
tjcw@tjcw-OptiPlex-7010:/media/tjcw/Photos$ echo ok >'aab '
bash: aab : Invalid argument
tjcw@tjcw-OptiPlex-7010:/media/tjcw/Photos$ touch 'aab'
tjcw@tjcw-OptiPlex-7010:/media/tjcw/Photos$ echo ok >'aab'
tjcw@tjcw-OptiPlex-7010:/media/tjcw/Photos$

Is this as expected, or is it a bug in the kernel's handling of FAT
file systems ? Probably the next step is to check the behaviour under
Microsoft Windows.

Chris Ward
