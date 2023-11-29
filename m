Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9437FDA8E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbjK2O4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbjK2O4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:56:10 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59F1D5D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:56:16 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54b18dbf148so6236142a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701269775; x=1701874575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0w8sJtJNe2IFo+5hrLPBLvXQAClmsdeJBw/l2nW104w=;
        b=aZT8slYsbXPfZY3WPMsOz5lRFOZjmHHG7Ilgpc1fnw1/LdWAkMPG8APO5OL+1QQLI/
         PckV1qC74bpQ88v6sxwdOcieExvAN2OvGrYhLBpa8UjN4nRIgdr9OtLsD/CDKv5hCdOd
         qv2571loHJcsTt8Bs4RT1BFmAncKIdCzXlP1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269775; x=1701874575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0w8sJtJNe2IFo+5hrLPBLvXQAClmsdeJBw/l2nW104w=;
        b=ei+SylIaSZ+fyG9kJvsseN2A7AuQB9mjmFNPBHCecQzdytTU/67MpsqOazn9K1xhhe
         762G5C9HPj/Re4GzPI4ZtK4HXVCLwQHxB7l0/PgHU8f73ojcG60RCPz77dyczixGHKGG
         djOHx8SgT+596gdIhQEaeJu/KvPe9XdtHDvxPK/JEFMSHoJQHHw2De9eHVxI3C/bsZAs
         2nTJqpLp4GqAru9tl7Kjip/3z531cD1tJNKbe+HUrscSzjzk6WwngSMZFOsWW82fKPkl
         vQ7ebrjb4Xz6Tw+os09L4xUg4pxqImCK4I/6dxtCqK+EBNTlPQ4h8NjmOHrhw591WlGe
         Lygg==
X-Gm-Message-State: AOJu0YyD/WIWW3elX4/3+TN9nQkGWgIWfs53MzRi1tHrHCi4knLrPMjp
        z94mxPjr9Zz36s/SBN+dAyZNWws7v3ps9gOBSeV1mGy9
X-Google-Smtp-Source: AGHT+IFAWNwJw0xGu2Ph24BombpMOYFEQrhnG3po1DUO5MQo8gD7CyMOUiMdyXKVP6j2/6ZQ0vlelA==
X-Received: by 2002:a05:6402:3455:b0:54b:179e:eb14 with SMTP id l21-20020a056402345500b0054b179eeb14mr10349822edc.27.1701269775034;
        Wed, 29 Nov 2023 06:56:15 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id cx15-20020a05640222af00b0054b6259b44asm3509298edb.83.2023.11.29.06.56.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 06:56:14 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-54afd43c83cso7317715a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:56:14 -0800 (PST)
X-Received: by 2002:a05:6402:483:b0:54b:5b14:e77e with SMTP id
 k3-20020a056402048300b0054b5b14e77emr7070909edv.21.1701269773930; Wed, 29 Nov
 2023 06:56:13 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdZtVNZFWSUgb4=gUE2mQRb=aT_3=zRv1U71Vsq0Mm34eg@mail.gmail.com>
In-Reply-To: <CACRpkdZtVNZFWSUgb4=gUE2mQRb=aT_3=zRv1U71Vsq0Mm34eg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Nov 2023 06:55:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=whk4oNQazgpzkujc2=ntVQMhU5ko7Canp2Uuq6CpyGzmA@mail.gmail.com>
Message-ID: <CAHk-=whk4oNQazgpzkujc2=ntVQMhU5ko7Canp2Uuq6CpyGzmA@mail.gmail.com>
Subject: Re: [GIT PULL] Pin control fixes for v6.7
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maria Yu <quic_aiquny@quicinc.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Chester Lin <clin@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 at 04:09, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> The most interesting patch is the list iterator fix in the core by Maria
> Yu, it took a while for me to realize what was going on there.

That commit message still doesn't explain what the problem was.

Why is p->state volatile there? It seems to be a serious locking bug
if p->state can randomly change there, and the READ_ONCE() looks like
a "this hides the problem" rather than an actual real fix.

                   Linus
