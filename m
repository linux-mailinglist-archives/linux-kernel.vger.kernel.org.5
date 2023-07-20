Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0940375AD90
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGTLza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjGTLz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:55:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893E4E75
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:55:04 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so57085e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689854102; x=1690458902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7W1A++0DmK32WknpFfFMJvCsm3vvkm9n73s4zuJV0A=;
        b=ZN0pvitrpyGLGHO7DXi/CBmlTQA8KHBrZMzlz3oGazd+8bDa7qzIJ+Xj0z2GiJtZOU
         iCJQVdRt5eqS+el53qE+5cpS4za7pvXs4GpwDW5IktKoQvxWYZ5rx/Ga6yhAjObCcdBb
         CeViB+SqwwF2cWcYfmK3NRXmWkPMqjHis6+i6u2uTyaKwPNaHLc1e4idr8pamrQC5n3R
         0e0Jxy+GNG1pNJKDlI9VoItQwXadT/nWW2A1l9DPTQRiCbiXdBE7X1DOxlBvpRlvCwsM
         7G3DwHpOmIe74X2B9q8VPwu32pr2xqg4g8GNNxX8GOhlqTtr3G4WER6Yun8AP+yQYARz
         /jVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689854102; x=1690458902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7W1A++0DmK32WknpFfFMJvCsm3vvkm9n73s4zuJV0A=;
        b=jDxRLNU3amvDl9bex1T+deCi8soSr8O9H3yGi+daCHSnjw9sagkLiFGapEZMetw4T6
         3nbjS0ub19Py+GZIERGoEhBZJr7IL7+jYUDol4tbc5q/ZqqS8WcSLGzdUulCQ9/cYan2
         nmBi+KWP28jLGx1HE758oijlxuDUvBG72h1Sqp4h8thfiTw8tSY/NnAS2DivEAOj8qNl
         PB3FyduVGSZPATYGv6YMGhor9erLrb5X7HGzbYPYCDv7xvdK30s4wzwcKHmyCk9W+ydc
         aBftwxesXKhLq1Sx78K4IcaRNQ/3njCwbzUEKZf2OMzpa+vlQMRS/r1pWYpj1/OtrtZF
         uq+A==
X-Gm-Message-State: ABy/qLan6XyvE6YPso0CB1ndjQ1efIuPt6UuvHZJUEeJZVQobLQR5min
        2FkiCbID0fH+ibxyQYjPFgcVReZD/h71dcHzSBfw3GJmEN3+3WakxvpsgA==
X-Google-Smtp-Source: APBJJlF6quPHTwSBR/5D8iYhvQDfr+5h6tZoGC1DPqjiaFa0POXQFNfCEXlT/1hj/qSzkPD5fWrzqYeGqeg9c27DzZI=
X-Received: by 2002:a05:600c:450e:b0:3f7:e463:a0d6 with SMTP id
 t14-20020a05600c450e00b003f7e463a0d6mr101638wmo.0.1689854102589; Thu, 20 Jul
 2023 04:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003ee3610599d20096@google.com> <000000000000c26a66060035ad18@google.com>
 <20230712211112.GD30092@pendragon.ideasonboard.com>
In-Reply-To: <20230712211112.GD30092@pendragon.ideasonboard.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 20 Jul 2023 13:54:50 +0200
Message-ID: <CANp29Y7Y=0m4y0awEd5E4sgWYvpxbHQUTOMXH+6ub6BdBoEGwQ@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __media_entity_remove_links
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     syzbot <syzbot+0b0095300dfeb8a83dc8@syzkaller.appspotmail.com>,
        andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, sakari.ailus@linux.intel.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 11:11=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Tue, Jul 11, 2023 at 06:00:08AM -0700, syzbot wrote:
> > This bug is marked as fixed by commit:
> > media: uvcvideo: Avoid cyclic entity chains due to malformed
> >
> > But I can't find it in the tested trees[1] for more than 90 days.
> > Is it a correct commit? Please update it by replying:
>
> #syz fix: media: uvcvideo: Avoid cyclic entity chains due to malformed US=
B descriptors

Thanks for providing the correct name!

>
> Can a commit ID be used as well ?

The problem with commit hashes is that we fuzz quite a number of
different Linux trees and every new commit might appear in all of them
with totally different hashes. Name is a much more reliable
identifier, so that's what we currently require in #syz fix.

>
> > Until then the bug is still considered open and new crashes with
> > the same signature are ignored.
> >
> > Kernel: Linux
> > Dashboard link: https://syzkaller.appspot.com/bug?extid=3D0b0095300dfeb=
8a83dc8
> >
> > ---
> > [1] I expect the commit to be present in:
> >
> > 1. for-kernelci branch of
> > git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
> >
> > 2. master branch of
> > git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> >
> > 3. master branch of
> > git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
> >
> > 4. main branch of
> > git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
> >
> > The full list of 9 trees can be found at
> > https://syzkaller.appspot.com/upstream/repos
>
> --
> Regards,
>
> Laurent Pinchart
