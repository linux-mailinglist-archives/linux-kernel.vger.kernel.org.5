Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302667A4D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjIRPrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjIRPrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:47:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535F1E72
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:45:55 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-530ea522f5eso1846121a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695051736; x=1695656536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C9LMcgPXK0TzUHzj0llknV/i85+aKix5XO5smaiKOg=;
        b=dWcdYG0bWYWuLkkekdErc0mCmQeubj06fRU3g7NC7pFqEjv5jlka9NhyjhIs0z0MXD
         av3Qs8YffnXo/36arlTt/x30nkYAUje6JuVappy2H6KOlwqwoQ2p9/95btvhETCXSgV+
         neYKFO9O1k96hwXpYMcy7PdyFWYplFSZnPTwEFG9y0Rn+BD0pzTd78wrVUjMpAK/QVzx
         mDE8z6ryfUf2UK2itrtzR2GIS4IF4vzLIp8I9boGCV+xRZswkiF0BFFHMMS/YDLR0v74
         vc6anLYp26meUaXu/EvMSspgySmRtF7CwzfkGWXebP1L1o+OjZB3GuI5X036xyX0EzVi
         IV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051736; x=1695656536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9C9LMcgPXK0TzUHzj0llknV/i85+aKix5XO5smaiKOg=;
        b=QTGJFiZzroqzoXPpi8LOeFya+DU+LgbXkLBI21ehkeSA6ILH2RFRl1iH0vR8iQgQ0N
         uUHyUsiWNzQ3DWYSKueoPjThIpWpDU6nHJgT3rYgHDqcpcKzEEAJJDoNR/1PEMOH+s1p
         1uNyx2QimZvuZwrzD0FvR6/8SpR4KMgQ6tqyCHfVTJySJe6u7/s5VwIRreJjjHOtJYvs
         MikkWr0hSDyGsrJB5pdDzwLwMiZrfSSydN5c8gIqvKzbGtVrAr19pYXEd41ZrQkqHQM1
         +4IYukD/7it03wPQC0m+0/fbAOsVrxlfXC8SpQYbbsw6Nam8NGQ4abj+G2gyiIXyLIx8
         7G9Q==
X-Gm-Message-State: AOJu0YxH9fYWxtHREzIBCiNsQZkxP6W/78dVPEDciOl3Nktwbj+MLsOI
        VLt9IvaUYhhgjQZhajyq1hda78HQOChe//JS+GYUpUdz+Fq/difX
X-Google-Smtp-Source: AGHT+IFxQdZh1SSfT9LlcG8tguxv47bZ6juM9AMuyh79H5Fz+DIpzr7wrwRr2QmAMQ4fv2MEeFcw6z/nFXVW1jP2iKM=
X-Received: by 2002:a2e:3e0e:0:b0:2b6:bc30:7254 with SMTP id
 l14-20020a2e3e0e000000b002b6bc307254mr7553866lja.13.1695045474573; Mon, 18
 Sep 2023 06:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com> <20230918124050.hzbgpci42illkcec@quack3>
In-Reply-To: <20230918124050.hzbgpci42illkcec@quack3>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Mon, 18 Sep 2023 15:57:43 +0200
Message-ID: <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
Subject: Re: [PATCH 3/4] inotify_user: add system call inotify_add_watch_at()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        amir73il@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 2:40=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> Note that since kernel 5.13 you
> don't need CAP_SYS_ADMIN capability for fanotify functionality that is
> more-or-less equivalent to what inotify provides.

Oh, I missed that change - I remember fanotify as being inaccessible
for unprivileged processes, and fanotify being designed for things
like virus scanners. Indeed I should migrate my code to fanotify.

If fanotify has now become the designated successor of inotify, that
should be hinted in the inotify manpage, and if inotify is effectively
feature-frozen, maybe that should be an extra status in the
MAINTAINERS file?

Max
