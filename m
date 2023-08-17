Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFFB77F9AA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352293AbjHQOua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352286AbjHQOt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:49:59 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268B1EE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:49:57 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe11652b64so12272961e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692283795; x=1692888595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qPKIf1c5VLgWM12jpFOQJTrws/cH5kcxIi4RhufSrew=;
        b=Y9EiYYZC9ZflNxWOTITi3phhdzzPYQr7TcoA1GKuD9yPPc4Cs5k95d/RvZ3D12nE5m
         kiHRJyZe4X0IGMfVEr+AgT9a2+78oWQf3Z6tEtcIakoNWnpgCEO3LvrY9onZmwaxb/y1
         NAjw25jgRbjpzOc03ucL/B8u6O8BvdHK0462I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692283795; x=1692888595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPKIf1c5VLgWM12jpFOQJTrws/cH5kcxIi4RhufSrew=;
        b=RnOjn4fxbNGVnQqC6iBynWfsYcsU7wBQ2nuusiw6c/Tcz5V0pVe4q056uZ4GsDIvWW
         IiCEAzYnLJkcq4HxOuRUnK7rSECm45C6zD6jdY9LRZ4wBaloWXuJZeaQlZvSwkqt2S7O
         9pfbPncd6iTpjP5MATWESunxTZnptx0H71SQ2Xa55MPkwJ5VAmXH1+1pxg/BuA0XJWuD
         t/Vmiig59Qx+ShUxJ6HaoQMJHnVm4gzIGNbDq+P2rOYP4sVrfI+kP4cAAUCZTH4sULlv
         oDOoWFJx6nRDTgKfGcEScR/IKaBX1z7Lo0al9Dc/Z/2M3g72qD6s5S22LQpZIAOaZsYM
         JJJQ==
X-Gm-Message-State: AOJu0Yzs60/pFQudTmQYjXHTJjNtt8658iRHQaZV4pbsf0xUB7e1XfTX
        lG2MZLp93aI/3EtZv1c5sPzIl7G1f9rtF5YwOZQqGKz7
X-Google-Smtp-Source: AGHT+IGfs0Ma0A8ZRHMCxqCsBk1T658tEKGJ7nnpIuXjGeTlxewY/i4+XrW1JJbI++B/6oX17DYVDw==
X-Received: by 2002:a05:6512:3135:b0:4ff:8f12:c4d7 with SMTP id p21-20020a056512313500b004ff8f12c4d7mr3851935lfd.31.1692283795094;
        Thu, 17 Aug 2023 07:49:55 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id a4-20020ac25204000000b004f8675548ebsm618245lfl.20.2023.08.17.07.49.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 07:49:54 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2bb99fbaebdso27939541fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:49:54 -0700 (PDT)
X-Received: by 2002:a05:651c:22c:b0:2b7:2ea:33c3 with SMTP id
 z12-20020a05651c022c00b002b702ea33c3mr4781874ljn.22.1692283794124; Thu, 17
 Aug 2023 07:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <499058D2-E924-464F-BBFE-C15EE6028787@oracle.com>
In-Reply-To: <499058D2-E924-464F-BBFE-C15EE6028787@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Aug 2023 16:49:37 +0200
X-Gmail-Original-Message-ID: <CAHk-=whnm7RyZfy2s4BOdkMz=dMrPJRnH79KVH8rtC1vrV9G1w@mail.gmail.com>
Message-ID: <CAHk-=whnm7RyZfy2s4BOdkMz=dMrPJRnH79KVH8rtC1vrV9G1w@mail.gmail.com>
Subject: Re: [GIT PULL] one more nfsd fix for 6.5-rc
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 at 16:11, Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.5-4

I've pulled this, but...

> Jeff Layton (1):
>       sunrpc: set the bv_offset of first bvec in svc_tcp_sendmsg

.. what an odd place to set bv_offset that is.

I'm sure it's right, but it really smells odd to set that initial
offset not when the bvec is created, but long afterwards, just before
it is used.

Is there some reason why 'bv_offset' isn't initialized when the bvec is created?

             Linus
