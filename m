Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1056D7673B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjG1Rph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjG1Rpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:45:30 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2827E3AA8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:45:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so3036983a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690566322; x=1691171122;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WY3Feo8GPlidh1PLbTYaalrVAHf4dxKu9JSTiyyBg5Q=;
        b=Tf8RCsMUawT9Lcim2FlNcW649OJli0tjM2vUORcuG0ev9z5EE6npEp30lmBntt0udn
         231FWDICa/goN9zdEawmwUvLn+dH9WSZUDnzpV2eL04p5PZ8C2aAClwup++3p/9RMP5V
         OENb0767LotLvTjNmVUbH5shIZ8LN4ZLpzAv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566322; x=1691171122;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WY3Feo8GPlidh1PLbTYaalrVAHf4dxKu9JSTiyyBg5Q=;
        b=FowQDAPN1be1udOM/fbw0PIdO2PboQ0+XVf9t0H2TxDJnSUSKin4TVnZPjZBWiQOv7
         OXeGXhkRca7Z0dk2dZRd7GDyCaYGD0vmp9xrWG9R+wD/RxK0J5oUcCNIwjg/EldF560L
         CcF/PQMJN4RDmNDIehBg4SrD4/KpHS7KYmHApUX9YVgVD4AtECl4njo9VPNQCy6qh9Mp
         r0rmUJTEem81LmTMtuyPXVt8tzdwQsJokitXDlRHSVIW8p7oA2dYJhS90hpxoSLXuxtG
         YWcBNBuuHvGiasnTO1RdrmF5ZPmPnk3ZQcOrdGZL715f+jWyfOC7ZN0alcBC2sfTY2qh
         Fizw==
X-Gm-Message-State: ABy/qLYpN54lWoLHuRDJ+ifgToogNjqGgQbLaOVrXQvrxf4oXICMeZBY
        mvR5OOMw6v9MPjkAAI/RksT8aHZZk1yXA5E5moMGi/eR
X-Google-Smtp-Source: APBJJlED4qWoMS/UqdoWEteRfBBg9s5VVNhgnah82m/OVcR+3KtKBjElsgNzAtaxFkxVdb1w5a68Mw==
X-Received: by 2002:aa7:d903:0:b0:522:23e8:2c69 with SMTP id a3-20020aa7d903000000b0052223e82c69mr2755686edr.27.1690566322366;
        Fri, 28 Jul 2023 10:45:22 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id s25-20020a056402165900b0051d9dbf5edfsm2015110edx.55.2023.07.28.10.45.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 10:45:21 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51e619bcbf9so3044538a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:45:21 -0700 (PDT)
X-Received: by 2002:a05:6402:1651:b0:522:595f:5a29 with SMTP id
 s17-20020a056402165100b00522595f5a29mr2522798edx.29.1690566321333; Fri, 28
 Jul 2023 10:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <ZMMjWSvfFutpaK6t@e8f1df9eb5bc>
In-Reply-To: <ZMMjWSvfFutpaK6t@e8f1df9eb5bc>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Jul 2023 10:45:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnCth-xYWDG8q8ESFJO-KYGNbaXQkMg5ABLEGPmtFE6A@mail.gmail.com>
Message-ID: <CAHk-=whnCth-xYWDG8q8ESFJO-KYGNbaXQkMg5ABLEGPmtFE6A@mail.gmail.com>
Subject: Re: [GIT PULL] fs/9p fixes for v6.5-rc3
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 at 19:09, Eric Van Hensbergen <ericvh@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git fixes/next

Please be more careful.

You *meant* to write "tags/9p-fixes-6.5-rc3", not "fixes/next".

                    Linus
