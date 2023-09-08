Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6FC798A79
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbjIHQI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244919AbjIHQIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:08:25 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE721BF8;
        Fri,  8 Sep 2023 09:08:20 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bcb5df95c5so1662037a34.1;
        Fri, 08 Sep 2023 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694189300; x=1694794100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioMBA312u8rZ2G3SfmQl4tBGa0wJ5xDvWGQvYcgDxIQ=;
        b=lr1mckZPOWgasJVMxpu307nE8ekmLHXLWqHlhKhnYnjH6vhM5fbfNRXU5+eKP8iw4k
         PNEHJ0ioyfL0pRIZnEtITkNMgrsq7XogiAKQym1l2ofpW0vtHcsWbz9Nd9zHM7x4k24X
         H1i1mcY/FHapQm8aEpeand/BuDPt7E6/8Fk+hCl6LgG+EQc0LAZDGyW+t9mFeKvY4gEs
         3KsSolNlFeP9pdL1XZqa2hAeMb5RhNf4+vzpNa6H/A1L01fopOX9T28aqJn0LV71QIFx
         Xp7rC8U3qxkCgZDksa/QF7OjDhavAA01XwF4O3KngKkFn631LmpQD1bClouMzeoXJ/0N
         Gw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694189300; x=1694794100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioMBA312u8rZ2G3SfmQl4tBGa0wJ5xDvWGQvYcgDxIQ=;
        b=IOeyvB3LSvsSuX+9z8GxYYXDQSREjiENxR7fsqJ6S2VMIWjkbOLHGdEb7KlPqN6fGm
         J3kELPPwKzgahtX5n8zERaKbCmuAB8Grb8wlYXtKwuOSVtmd7VZLpKXS52P7PTQwQ81k
         kEm47XsvwocYrk5mpUCTe+V9hjqrqv5TSb+ezNTWOw8iNjpl8pCicyLgzeNHeHPeXYng
         0eM9iMpVZIb3LqLxr0yTaZjkbwcntsWF0mq3A/+nZSk4bgbCD66UbTyj/trOx+z9YZK0
         d0NrHOy6dKW3dwp2cDGwRMPI/ZgE5VfX2TQXaekKBArGYbgRwkQNQxYBjprctTNlhAiK
         MRGQ==
X-Gm-Message-State: AOJu0YwX+YKNz2bDKjb+agfmqVQRPbsqqYSdsWV6HawQ9jYWpAH/M0gY
        Er7I9Je/7FnS1W1s8A/rQA6i/oVaJxhxtFAx3yKQ8fkn
X-Google-Smtp-Source: AGHT+IGNyRVazOPyK6gK4oWPvpz+W6lfMswY1fJ6C5Cd1rq4LuwlUm/SL3kAC7JfD+S263w6cEFnHHlOYx4fNZmNOKQ=
X-Received: by 2002:a05:6830:22e4:b0:6bd:7b8:8646 with SMTP id
 t4-20020a05683022e400b006bd07b88646mr2792504otc.5.1694189299911; Fri, 08 Sep
 2023 09:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230818151220.166215-1-cgzones@googlemail.com> <20230818151220.166215-2-cgzones@googlemail.com>
In-Reply-To: <20230818151220.166215-2-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 8 Sep 2023 12:08:06 -0400
Message-ID: <CAEjxPJ6wXDu3DJEVCGNkKJCBSnhz=xc+s1Bb3BkvUjNq0dGkng@mail.gmail.com>
Subject: Re: [PATCH 3/6] selinux: improve debug configuration
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
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

On Fri, Aug 18, 2023 at 11:12=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> If the SELinux debug configuration is enabled define the macro DEBUG
> such that pr_debug() calls are always enabled, regardless of
> CONFIG_DYNAMIC_DEBUG, since those message are the main reason for this
> configuration in the first place.
>
> Mention example usage in case CONFIG_DYNAMIC_DEBUG is enabled in the
> help section of the configuration.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
