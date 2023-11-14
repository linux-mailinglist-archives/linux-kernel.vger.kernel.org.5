Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248C37EB28F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjKNOj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbjKNOjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:39:45 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D91D4D;
        Tue, 14 Nov 2023 06:38:34 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32f9268bf8cso3509354f8f.0;
        Tue, 14 Nov 2023 06:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699972713; x=1700577513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vorw/gu3GSENL4iOEf1h3n+d1k2FLNe0fLO0LG+3W6c=;
        b=OyHS/uUAheVZfq33d9mXkEL8bMthKdvS02PXgisJW/QtGv4TuBDHv8150Ctp4O6eaH
         Kb9LNn4XpGnaPxTPMTtGHftJPeNAKXDbNs/D9nYFSSkpB4SWLnc07c2Y5g0uI1LBrGwO
         aoV0VRV1tARhgds7Qa8CVxy+s7qHeZ7Vne1Zqb/V9lEeobZBOo6g035V2s6REzYMmi0K
         0xlMNh6EgROn1bauq6m3ZjYIQwwuDwd1xykiUK/j+ObrWmWsRgg/R4wggQI1uSS23yI7
         N/WCS2kZp+05CEkCJc1ES2546GCQN+p/DFWJYxAfnTBOK6WVYUkjCNmRq76qxOxj4PYY
         KEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699972713; x=1700577513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vorw/gu3GSENL4iOEf1h3n+d1k2FLNe0fLO0LG+3W6c=;
        b=w5jhK/W0znUOKfTOGbSw5rSmhtzRPVW/kwYTXWR2/5zNvGobGu29kpq18yZWTMXWE6
         o435WgCCZC+PlwKBDnqzCzyfTOz9msdxrC32JxqctmWeIqB1fZJB83LC7IvyBO5xnmQt
         HX6SZRxOYyBslXVBiqRjGZehDz++Q8awo+IL6vcg7EIBQw1s7OuVCtf/sTKQQlKTTJBR
         4nV4+E2yn4QAHci1vmKCBuOHHh8O0lBAv9zc4uIf8dPIRCneoxLnVinylWjlzGHwTPUb
         4ZEzjy7b0ezkyEhG5vDYK5O1SuMtNFjOmYJquZ0Xyxmv02L5UiS2T/NV3VdHshR5gChJ
         uIrA==
X-Gm-Message-State: AOJu0Ywlg/cd1y2wSEhpLHMX2wWfyUvMc/uzK6iWquei1qlcRI2IPQi7
        me9GhmJsk76HUIl68hK8xC3YpCDT+Zg3QGEpI08=
X-Google-Smtp-Source: AGHT+IEa3756+IK7kLn8TfUIhyxRe5b/b+mREq0xSgDtiRMc+7zmEFv+NGYQSChhd2xJgv/8L7sNxuGpwYP0239K3rE=
X-Received: by 2002:a05:6000:184c:b0:32d:a022:8559 with SMTP id
 c12-20020a056000184c00b0032da0228559mr6469652wri.47.1699972712797; Tue, 14
 Nov 2023 06:38:32 -0800 (PST)
MIME-Version: 1.0
References: <20231112095353.579855-1-debug.penguin32@gmail.com>
 <2655833.BddDVKsqQX@oscar> <CALk6UxoRHWsJYuTcqg7zvf5rxGwMQymMpjGuSEw3d+syAVyt=g@mail.gmail.com>
 <13392533.uLZWGnKmhe@oscar>
In-Reply-To: <13392533.uLZWGnKmhe@oscar>
From:   Ronald Monthero <debug.penguin32@gmail.com>
Date:   Wed, 15 Nov 2023 00:38:21 +1000
Message-ID: <CALk6UxqF26rpNi1wD1Q8VmX6X-woe5YuuRK-Uk7bNcwqsRFKZA@mail.gmail.com>
Subject: Re: [PATCH] qnx4: fix to avoid panic due to buffer overflow
To:     Anders Larsen <al@alarsen.net>
Cc:     keescook@chromium.org, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Niek Nooijens <nieknooijens@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 1:40=E2=80=AFAM Anders Larsen <al@alarsen.net> wrot=
e:
>
< Snipped>
>
> sizeof(de->di_fname) is evaluated as QNX4_SHORT_NAME_MAX already at compi=
le
> time, see the definition of di_fname in uapi/linux/qnx4_fs.h
>
> I agree that the code is confusing, as 'de' is declared as a pointer to a
> struct qnx4_inode_entry but in reality points to a struct qnx4_link_info =
iff
> QNX4_FILE_LINK is set in de->di_status.
> (Note that the corresponding field dl_status in qnx4_link_info is at the =
same
> offset as di_status in qnx4_inode_entry - that's the disk layout.)
>

Thanks for the details, yes in  struct qnx4_inode_entry  its size
char di_fname[QNX4_SHORT_NAME_MAX];

< snipped>
>
> Niek reported that this fix improved the situation, but he later got a cr=
ash,
> albeit at a different place (but still within the qnx4fs).

Yes I saw that Niek has shared the second crash dump stack in above email t=
hread
and also in [1] Bugzilla 218111.The dump stack of the crash looks to
be doing a similar
lookup call context, do_statx =3D> vfs_statx =3D> filename_lookup =3D>
qn4x_lookup =3D> fortify_panic ( )
[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D218111#c4

But  I also see a softlockup also in the dump stack, so something in
their environment
is causing softlock ups.  And that tallies with the symptoms of system
freeze that Niek
mentioned " I can mount and view the directories, but after several hours
my system froze up again."

watchdog: BUG: soft lockup - CPU#7 stuck for 26s! [pool-gvfsd-admi:31952]  =
 <<<<

It's possible the softlockups were occurring on fews of the CPUs on the sys=
tem
for a few hours before the crash occurred that caused a system slow down.

BR,
Ronald
