Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8523C767E38
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 12:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjG2KdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 06:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjG2KdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 06:33:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73901AB;
        Sat, 29 Jul 2023 03:33:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67B0860B82;
        Sat, 29 Jul 2023 10:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDA7C433CC;
        Sat, 29 Jul 2023 10:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690626784;
        bh=rKViM9NX1GrQZ2J029oNy1RNWuLl6UeLKdOCLKRXtIo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NYdeBWQg87ZMP9BLSItrj4sSmohr1xgyOxv1g/BYpnEbeywpnSesAGtEegkbYcEdh
         8N1trksAZNqo3metlMGK3sLIv2i8jUWQvfbf73jczXoS4dN1zTfo7VKpZiRR/xlRp5
         8xbVPVyn+65sOkvUd7uC1wkV3Yw1jV2EmZxiMdt6XKCZWrguuJ8hsBV4Gy6TTlyXhd
         ZPGHe3BLL8PXFz/iDkywHMkN1c/R01JUDXH1x+KzWyOhwvpeMPEuPxQBcbtuCrRovL
         /o3vXyrooMFo/6akpx2vQ8A3LV8BAqkEaFfywOTNAOfNIWkKen7vYYHgMFNrAc0YOq
         CMAkkwcM9/1Vg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4fe2503e3easo1639610e87.2;
        Sat, 29 Jul 2023 03:33:04 -0700 (PDT)
X-Gm-Message-State: ABy/qLZ7hOmAFNUuJJgX3MYdQUVhSYigjpYIkqzgBm5kece3+USz3U5z
        EQ7CLczKsEqz9uSkWuO0NcStphFrhOoWBX5cHNc=
X-Google-Smtp-Source: APBJJlGeYb8hNy/oFr34uGXpmibjsARwkGDXhWuL5vf6q6/6EGpONGXt7KE18g1UWMPfQfNjEFd/fv4w/7as5tTqYDA=
X-Received: by 2002:a05:6512:2391:b0:4f8:6e6e:4100 with SMTP id
 c17-20020a056512239100b004f86e6e4100mr4600338lfv.52.1690626782624; Sat, 29
 Jul 2023 03:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230708092153.1418570-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230708092153.1418570-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Sat, 29 Jul 2023 18:32:49 +0800
X-Gmail-Original-Message-ID: <CAPhsuW5cBipY=JT8nRvJptyU9uePVYgqQ5ZaTtL7KnNO97K9BQ@mail.gmail.com>
Message-ID: <CAPhsuW5cBipY=JT8nRvJptyU9uePVYgqQ5ZaTtL7KnNO97K9BQ@mail.gmail.com>
Subject: Re: [PATCH -next v2 0/3] dm-raid: minor fixes
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     pmenzel@molgen.mpg.de, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, heinzm@redhat.com, neilb@suse.de,
        jbrassow@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 8, 2023 at 5:23=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Changes in v2:
>  - improve title and commit message for patch 2
>
> This patchset fix two straightforward and easy problems that is found by
> code review, please consider it for the next merge window.
>
> Yu Kuai (3):
>   md/dm-raid: fix that 'reconfig_mutex' is not released from error path
>     in raid_ctr()
>   md/dm-raid: clean up multiple equivalent goto tags from raid_ctr()
>   md/dm-raid: protect md_stop() with 'reconfig_mutex'

For the set:

Reviewed-by: Song Liu <song@kernel.org>

>
>  drivers/md/dm-raid.c | 20 +++++++++-----------
>  drivers/md/md.c      |  2 ++
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> --
> 2.39.2
>
