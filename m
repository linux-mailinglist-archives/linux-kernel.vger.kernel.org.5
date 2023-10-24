Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245807D539B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343612AbjJXOFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbjJXOEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:04:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A0C19BF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:57:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9adb9fa7200so940675466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1698155877; x=1698760677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CFq2Fg3zVAnOrmEfLn53FQxN7jmqeIO+YSPDEZIOjqc=;
        b=dBGQjqFyfkxCERh0ht6T4zHtOMCIAEEElWD0aSCE56alg9Tf21JyvwveX0xPtdPfJM
         2lNl7cJUacZQZfQsx6uluR+8JzJ/pMrkSihbCje0m4cS3jM8oLrrlfpDYCiy6VeP+X72
         nsEYRXs8dvXwPwr3u5i/31goOMOKzmLc8zBag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155877; x=1698760677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFq2Fg3zVAnOrmEfLn53FQxN7jmqeIO+YSPDEZIOjqc=;
        b=kpoCJopsafvWy/Ov+ybWMPtY3Aau4IkXRNpLf3cPEl9EafrcEdXzOPtluTsFdxYSV2
         HpUE+IvgqXaWBFK8ocd/SRF+Uog7euO/IjnO4ofe0L7UhCnBvY8//l68KWjVGzrpoWw2
         +F36yZJD8PRQ5wyw92k4CWNm173lGKtLp50cFr2ynjJpiAVDE892wzqE3YycxfcB++fL
         fslLcKtH3u7yOzX7v8lpz6Z6P0sOmbXBW/Vj+/4szQJBcVShhMPQPpgg1ttsOCvOHp8Y
         AEX7sT7BYRXU6v/wJ2ZU2MEFNuAfu7spAZVuSLAVXIM/vFIzq0WuWCCecyxWZ/vZTs/e
         I9sw==
X-Gm-Message-State: AOJu0YwasWSdZ/dcYc+7iaI70QLH1OLZ/AAqwUohfZFE9AoipI154CJD
        59tYidO96lSsuMWBUNsia9aDs/0nFxNrDZ6LK5jmng==
X-Google-Smtp-Source: AGHT+IEV11aVuDatR+GsbiTzkdam4eLmDzs7DndyyWqozB2d9zhCaHb3NdyEF13kC/pQx/zoObUqvAUWAIwVd1XT2cQ=
X-Received: by 2002:a17:907:94cd:b0:9ae:614e:4560 with SMTP id
 dn13-20020a17090794cd00b009ae614e4560mr9998911ejc.29.1698155877064; Tue, 24
 Oct 2023 06:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230928130147.564503-1-mszeredi@redhat.com> <20230928130147.564503-5-mszeredi@redhat.com>
 <CAHC9VhQD9r+Qf5Vz1XmxUdJJJO7HNTKdo8Ux=n+xkxr=JGFMrw@mail.gmail.com>
 <CAJfpegsPbDgaz46x4Rr9ZgCpF9rohVHsvuWtQ5LNAdiYU_D4Ww@mail.gmail.com>
 <a25f2736-1837-f4ca-b401-85db24f46452@themaw.net> <CAJfpegv78njkWdaShTskKXoGOpKAndvYYJwq7CLibiu+xmLCvg@mail.gmail.com>
 <7fe3c01f-c225-394c-fac5-cabfc70f3606@themaw.net> <c45fc3e5-05ca-14ab-0536-4f670973b927@themaw.net>
In-Reply-To: <c45fc3e5-05ca-14ab-0536-4f670973b927@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 24 Oct 2023 15:57:45 +0200
Message-ID: <CAJfpegvTFFzCN9nssL0B6g97qW5xbm6KsrFPRqtSp5B1jaYbLg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] add listmount(2) syscall
To:     Ian Kent <raven@themaw.net>
Cc:     Paul Moore <paul@paul-moore.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 at 04:40, Ian Kent <raven@themaw.net> wrote:

> But because we needed to enumerate mounts in the same way as the proc file
>
> system mount tables a flag FSINFO_ATTR_MOUNT_ALL was added that essentially
>
> used the mount namespace mounts list in a similar way to the proc file
>
> system so that a list of mounts for a mount namespace could be retrieved.

Makes sense.

Added a LISTMOUNT_RECURSIVE flag.

Thanks,
Miklos
