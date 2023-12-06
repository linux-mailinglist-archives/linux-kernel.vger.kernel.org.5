Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800728071CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378811AbjLFOJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378713AbjLFOJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:09:11 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08A7D1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:09:17 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-67ac8e5566cso20027476d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 06:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701871757; x=1702476557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGMF19c5kJzbSyKx565uqVwlQwisEwFHDLMgcKSV7W0=;
        b=KnY70DhUuVx9k3HkFPPJxQvQgofsCtlkODKpXr9Kj/ZtoA6D/KEtulxy/DLsRdtfp/
         0yyD+6ck95M76vCJJ6uSz2/q6DC1g5yFEtt6wliA3X531bwpXW8kSlefdHpv8KE2Wud4
         YqmlJbiS61MD3orM8KNZIpVop7Ae5xFpRhBN503QsLMeCh/3TK3riuZPwMbYC2haHPHP
         xFAF5i9I0igJrzvQnsYsy2K7ZjudN1ElKE9IVewk+2qKABK8++JANwBaywbQ9f8/R6sg
         Ie4QHu44mDIDx65WR7T9xy2bLXJchTi71KsUO9AwqJ5w9lL4DojsGVwCrksj12e83iw3
         yBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701871757; x=1702476557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGMF19c5kJzbSyKx565uqVwlQwisEwFHDLMgcKSV7W0=;
        b=q5waQxrGb3sNdSF9Mu5HeQNyB/d2Lslmi2e7eXntVWgo76sQ6vFoa3eyRTFOMaMH+l
         q63khWlxw+/2Y1kgWuyyY7Ubfl4kls3KFcmoUdbjmQLslTesiQT4MV6gXnvIZKDvqRa7
         nxcVAOEfl7TUdS1vhWsZjFtvN4ttHycYr8eDMqGLp9hdw4eZigkZdvP9hlZAlYj9fDg6
         3dH6nEmTZWM/wUCvnh8iwCyCIc10THWBcXgn3jF6vuunF2grHJh8cm3L+zkOgmWeW9YJ
         oc19VGtTMLPRQA44yItzzZ7fM6joOYRF/uLNabLs494uvuyPjHqSyKpj0FmtNEjLzMkf
         T6+Q==
X-Gm-Message-State: AOJu0YyMc684QCLgmwMX0lDkyV2LhuCSeis5mxiwYxSgPnaz2eqZckKv
        L5snksKxy7p3QmXGpNEwv3ZA+MB4XywFu+1qm/SBq3Z6rK1a82JM
X-Google-Smtp-Source: AGHT+IF+BBiB9cogfaFxa9k5NpzdfYPWWxsUecN2d60x3c/49rRoXAv9EekGMEXVo1rVsDWt2A9EhHq+DSLVanTCgf8=
X-Received: by 2002:a0c:e802:0:b0:67a:c192:630b with SMTP id
 y2-20020a0ce802000000b0067ac192630bmr886782qvn.46.1701871756871; Wed, 06 Dec
 2023 06:09:16 -0800 (PST)
MIME-Version: 1.0
References: <20231206115355.4319-1-laoar.shao@gmail.com> <2023120644-pry-worried-22a2@gregkh>
In-Reply-To: <2023120644-pry-worried-22a2@gregkh>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 6 Dec 2023 22:08:40 +0800
Message-ID: <CALOAHbDtFKDh7C0NYeZ0xBV1z3AsNBDdnL7qRtWOrGbaU7W9VQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: base: Introduce a new kernel parameter driver_sync_probe=
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 9:31=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Wed, Dec 06, 2023 at 11:53:55AM +0000, Yafang Shao wrote:
> > After upgrading our kernel from version 4.19 to 6.1, certain regression=
s
> > occurred due to the driver's asynchronous probe behavior. Specifically,
> > the SCSI driver transitioned to an asynchronous probe by default, resul=
ting
> > in a non-fixed root disk behavior. In the prior 4.19 kernel, the root d=
isk
> > was consistently identified as /dev/sda. However, with kernel 6.1, the =
root
> > disk can be any of /dev/sdX, leading to issues for applications reliant=
 on
> > /dev/sda, notably impacting monitoring systems monitoring the root disk=
.
>
> Device names are never guaranteed to be stable, ALWAYS use a persistant
> names like a filesystem label or other ways.  Look at /dev/disk/ for the
> needed ways to do this properly.

The root disk is typically identified as /dev/sda or /dev/vda, right?
This is because the root disk, which houses the operating system,
cannot be removed or hotplugged. Therefore, it usually remains as the
first disk in the system. With the synchronous probe, the root disk
maintains a stable and consistent identification.

>
> > To address this, a new kernel parameter 'driver_sync_probe=3D' is intro=
duced
> > to enforce synchronous probe behavior for specific drivers.
>
> This should be a per-bus thing, not a driver-specific thing as drivers
> for the same bus could have differing settings here which would cause a
> mess.
>
> Please just revert the scsi bus functionality if you have had
> regressions here, it's not a driver-core thing to do.

Are you suggesting a reversal of the asynchronous probe code in the
SCSI driver? While reverting to synchronous probing could ensure
stability, it's worth noting that asynchronous probing can potentially
shorten the reboot duration under specific conditions. Thus, there
might be some resistance to reverting this change as it offers
performance benefits in certain scenarios. That's why I prefer to
introduce a kernel parameter for it.

--=20
Regards
Yafang
