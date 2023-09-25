Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2347AD63E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjIYKmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjIYKmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:42:10 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC43AA3;
        Mon, 25 Sep 2023 03:42:03 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6c496719a9aso3168760a34.0;
        Mon, 25 Sep 2023 03:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695638523; x=1696243323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCYYXo6QUFwHENfz0rJ0lvEQqMwZMCKqE5h3IXB6SP4=;
        b=GQMxrc4uaqUAdD4IFXQzz4bl/EcVU3G0L+Vd4EAdO3bbYt2po0LLV2L80SOh0gQ2EB
         NyKHAEg9SouH5LNQOS57rfE1eRi4h0KIXZ46hiVXJ0KjpVFVvdDGK0TTE4ccYNrD64T1
         NaAMGN0GNlMbDE8FetPQhyYaC9Ivqy9lx2Uz3bMEuUimkeukcfnz4OQwBjdVGRZNAfcp
         HNiY4qMwKjBoXQrUR4dpMTyNlyUcLH3BgA3gXRcHgYyxnGYgy34df/4dFCzzVD8/9yOo
         zK86jKreAy9M8eacJ1jtInYUD8RRgjeN4oyHZbGF0cUavif4TEeUtcB+JAhqhvNydIVa
         gP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695638523; x=1696243323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCYYXo6QUFwHENfz0rJ0lvEQqMwZMCKqE5h3IXB6SP4=;
        b=DhEc1JOcMmRGlqztkpwnlGLPARzhKUVbg1U31fLhXH8w5Fv9njn1Opoarifr1x4TFj
         HtHZVHto9SOFXLwV5nVERZWVx+D5e3tjPsPbvca57orINcbjcqW00tc2uN/cHawoiW3m
         GEqVjizfTUKH62/4mqd1OmCRN8U44BhkwkwrfT/ON96mH2RCYMACWnhPyzZK1W+IcdJ3
         ZjItthH22lvlCrnc0PbxNIDN8sRmgWUyyma91sSHpBA2jMOk9t8CHgPyIYEEqsTaGu4K
         3IUWhjp79XSJ4RLzFZS3skrmCqK9cjVcP2Fh9/TNk6K9CJFrzIN90LuB5L489jpcZvH8
         hMkA==
X-Gm-Message-State: AOJu0YyoSiT1ErKCDLZNclYemkaK4/A4v5xkhLy80jjVwEr6f4O4oZPa
        Xd0EnGwOGXbAwldLm+9TLe5PByZMAGLNezI3URw=
X-Google-Smtp-Source: AGHT+IHRj6B4gV6c9UrNFtjuTnDus2mT2FyyKn58IUZeKZXJH1hrC5+sjE4iyYt+aE7mj3ooEtN5n8Hajc099CwwSM0=
X-Received: by 2002:a05:6830:438e:b0:6bd:335e:1eda with SMTP id
 s14-20020a056830438e00b006bd335e1edamr5653596otv.11.1695638523271; Mon, 25
 Sep 2023 03:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230922062558.1739642-1-max.kellermann@ionos.com>
In-Reply-To: <20230922062558.1739642-1-max.kellermann@ionos.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 25 Sep 2023 12:41:51 +0200
Message-ID: <CAOi1vP80WvQhuXgzhvzupQP=4K2ckgu_WpUCtUSy5M+QdDycqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/ceph/debugfs: make all files world-readable
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Sep 22, 2023 at 8:26=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> I'd like to be able to run metrics collector processes without special
> privileges

Hi Max,

A word of caution about building metrics collectors based on debugfs
output: there are no stability guarantees.  While the format won't be
changed just for the sake of change of course, expect zero effort to
preserve backwards compatibility.

The latency metrics in particular are sent to the MDS in binary form
and are intended to be consumed through commands like "ceph fs top".
debugfs stuff is there just for an occasional sneak peek (apart from
actual debugging).

Thanks,

                Ilya
