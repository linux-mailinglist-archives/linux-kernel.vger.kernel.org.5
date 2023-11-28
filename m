Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BFB7FC16D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346224AbjK1OyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346248AbjK1OyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:54:07 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC8E1739
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:54:13 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cfd9ce0745so128975ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701183253; x=1701788053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vsh2mMUKOXR8rABG0J7/JCsvNsJy41xjQD3uPT5bxQQ=;
        b=WgHfHB3gtR4cQNfCXmT6g5D69yDeXnejdR9BJtKnJkXs8TBpaYH7O/2KKBSFlhsKui
         lmUVfK4uoM2Fn9M5TbUcyzZ2zCKz+sz2sM2svN8wAPJOaaQ+asuUVSrzi5WHn/lbFu9f
         806fxUWYtNJ3SnAAEJ3IFeATf/fFl/gJxZRYZcBxw2In+eoY3y96YqgXG0WnBBdZaVLL
         Ab9PdDVnHJvuGfnG/Kv3cBPn/L+w4V1MMgDxTFV3gaEhzqLjUTvwa5MdNBPKCgoPIKTr
         GKyZ8u5lWFTP4+cJGmFdJP/cRUDEVVsDq0oLU7MlkXVtSq3h0EGpq6zYe9rTY2Htq+iq
         RB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183253; x=1701788053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vsh2mMUKOXR8rABG0J7/JCsvNsJy41xjQD3uPT5bxQQ=;
        b=BbOcTguKPDSFfx9GyDY56Mj9VThL3Pz8jptujjmzjm7BxLwx4ejhgOuaf16og4sqqE
         /ICWx5eEpE8K2jqrbCRmqpvnjMqGaJoY/FqGylqhOaqnP4viVPxlOBCMNajU50sCaSKH
         Fw89iFffCSj+7FnmG3SJEXyNmRl3kov6BlMzc++ku61ArHQcrNcFuua6gX7myC+werep
         7ldyZFDcW6Th1RSJFwXcqrJywgLNMxlFNHfA1FJajTynR0OY9ncyK6cV3YAj4KlW2pjo
         6JH/mN5N1PvAI2+l7f5O3jeZZ7wlduHjDL70euov0EqvmftUx3CdwLFhwUxTr0pwVIu1
         9lQQ==
X-Gm-Message-State: AOJu0Yy9W3NeG7HcJvesS4D2txlCGO+G1xHA42BHVEQunQ1yi0A6z2l1
        Ph/HKEqAOhEkGeQpikSqVSTVjNXRHqItnpZf0DSXVHH0OwVx5awp3yWhdg==
X-Google-Smtp-Source: AGHT+IGa7uI6oT3u3fJpJBJLDKtUv6BkE/bZhI/Oz3lcbQXkUrx2pktUUQxDz/STXFo5kafOwENu7BifWcNK7JUsFF0=
X-Received: by 2002:a17:903:4d1:b0:1cf:a032:aeff with SMTP id
 jm17-20020a17090304d100b001cfa032aeffmr891111plb.11.1701183252371; Tue, 28
 Nov 2023 06:54:12 -0800 (PST)
MIME-Version: 1.0
References: <00000000000029fce7060ad196ad@google.com> <20231124182844.3d304412@kernel.org>
In-Reply-To: <20231124182844.3d304412@kernel.org>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 28 Nov 2023 15:54:00 +0100
Message-ID: <CANp29Y77rtNrUgQA9HKcB3=bt8FrhbqUSnbZJi3_OGmTpSda6A@mail.gmail.com>
Subject: Re: [syzbot] Monthly net report (Nov 2023)
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     syzbot <syzbot+listaba4d9d9775b9482e752@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 3:28=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 23 Nov 2023 05:12:23 -0800 syzbot wrote:
> > <8>  240     Yes   BUG: corrupted list in p9_fd_cancelled (2)
> >                    https://syzkaller.appspot.com/bug?extid=3D1d26c4ed77=
bc6c5ed5e6
>
> One nit - p9 is not really net.

At least it's not reflected in MAINTAINERS:

$ ./scripts/get_maintainer.pl --nom --nor ./net/9p/
v9fs@lists.linux.dev (open list:9P FILE SYSTEM)
netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
linux-kernel@vger.kernel.org (open list)

Maybe it could be worth it to add "X: net/9p/" to "NETWORKING [GENERAL]"?
Syzbot would then eventually also pick up the change.

--=20
Aleksandr

>
> Thanks again for restarting the reports!
>
