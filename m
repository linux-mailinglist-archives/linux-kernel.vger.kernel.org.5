Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E348019B4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 02:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjLBBhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 20:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBBhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 20:37:09 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC11116;
        Fri,  1 Dec 2023 17:37:15 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cde14ff73bso2235851b3a.0;
        Fri, 01 Dec 2023 17:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701481035; x=1702085835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A0ufX68N1esanQTyLJA3w1Jj4v6Vxvaxep5R4BU75TU=;
        b=YSG9Jt+OOcZ4RFfgDHPjkbzkSC1YQ+O8GM/miYeTpUxnzWzgZjnSD2wjACjdDoATUn
         2qr4tvlFIwVPe89rTiPpXbDhnu7wlTC5vQPNsSWkkV+EM3dGRDvhEf5BQOFHWxGBQ2hc
         cVuPYGIhRgsqtyzbmDXigm+xSCBiDIYtQQfLfzhCzwwJRaXFdWF9wAZQB8qw3gi8/+v6
         KCnfAG/cVXjDRT0jpavGJSgYN2u0kNwmryXSMzvZrK5UskWbqsvRcUG8xoL+DsNMS05g
         MvXYFSqm+O84j8ZcJtxc6EZ7HU/jH2jYoi+0a8RGPMVUEwXnYADp2ANSGuJjGSLunJ/N
         LWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701481035; x=1702085835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0ufX68N1esanQTyLJA3w1Jj4v6Vxvaxep5R4BU75TU=;
        b=JMqDqM4RRSx+NdSwqjBlVm+e17aEuzf46LsSbUudKMFwkkz3hoT/Hu0VXAHkwytgdW
         mtem9d4PmjCHiaFrUyFXPbhYnAD2Ok/wan7vXbP7lR/ZXbPxt9ASXAoy9ej6oGJR60Lc
         FuOZq8/C/+ZKRTewOWDwH7dcI5Zvj38QHiXe0QOzJRmeD6U60a5hxLnGZpxGm7TJKpZg
         D7MavYBiBj1d6j9YbxSYsXlACKUAodxamXTAKweFDHz3vjIg0IAYurecCnfWIz/pFQ1z
         gcnWTjFnvoNAkLxjBUI8wh1Cy58PqpUIEhK/BWKArpMM4DXTBj54g1ZQSvixximcGTHz
         lybw==
X-Gm-Message-State: AOJu0YwYOtzWOI6n95AIU/h3DMR1k1AulsaS6PJS23pkdZ5B8lTgBAGO
        olqpXnfvytB4nS3BrJQh/A7vZqR6cYfaWg==
X-Google-Smtp-Source: AGHT+IE/awiIeWidw8WTuQ5AGkqV/4zGshQQBq3TZaN69o5OMK56wLF9Vse25T65TIbfliG+QFus1w==
X-Received: by 2002:a05:6a00:1398:b0:6ce:2731:47bd with SMTP id t24-20020a056a00139800b006ce273147bdmr509085pfg.29.1701481034783;
        Fri, 01 Dec 2023 17:37:14 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id t10-20020a63dd0a000000b005c2422a1171sm3589542pgg.66.2023.12.01.17.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 17:37:13 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 9A66710082367; Sat,  2 Dec 2023 08:37:10 +0700 (WIB)
Date:   Sat, 2 Dec 2023 08:37:10 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
Subject: Re: [PATCH -v2] locking/mutex: Document that mutex_unlock() is
 non-atomic
Message-ID: <ZWqKRkhYm7hxUDW_@archie.me>
References: <20231130204817.2031407-1-jannh@google.com>
 <2f17a9a6-5781-43ef-a09b-f39310843fe6@redhat.com>
 <CAG48ez1oXW=4MfQ0A6tthud-cvDZUTA+VB=jzu-HxvWzbj+X0g@mail.gmail.com>
 <ZWm2b+QGpOvzHjc1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oz6cg3XNiAwQ353b"
Content-Disposition: inline
In-Reply-To: <ZWm2b+QGpOvzHjc1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oz6cg3XNiAwQ353b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 11:33:19AM +0100, Ingo Molnar wrote:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
> From: Jann Horn <jannh@google.com>
> Date: Thu, 30 Nov 2023 21:48:17 +0100
> Subject: [PATCH] locking/mutex: Document that mutex_unlock() is non-atomic
>=20
> I have seen several cases of attempts to use mutex_unlock() to release an
> object such that the object can then be freed by another task.
>=20
> This is not safe because mutex_unlock(), in the
> MUTEX_FLAG_WAITERS && !MUTEX_FLAG_HANDOFF case, accesses the mutex
> structure after having marked it as unlocked; so mutex_unlock() requires
> its caller to ensure that the mutex stays alive until mutex_unlock()
> returns.
>=20
> If MUTEX_FLAG_WAITERS is set and there are real waiters, those waiters
> have to keep the mutex alive, but we could have a spurious
> MUTEX_FLAG_WAITERS left if an interruptible/killable waiter bailed
> between the points where __mutex_unlock_slowpath() did the cmpxchg
> reading the flags and where it acquired the wait_lock.
>=20
> ( With spinlocks, that kind of code pattern is allowed and, from what I
>   remember, used in several places in the kernel. )
>=20
> Document this, such a semantic difference between mutexes and spinlocks
> is fairly unintuitive.
>=20
> [ mingo: Made the changelog a bit more assertive, refined the comments. ]
>=20
> Signed-off-by: Jann Horn <jannh@google.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Link: https://lore.kernel.org/r/20231130204817.2031407-1-jannh@google.com
> ---
>  Documentation/locking/mutex-design.rst | 6 ++++++
>  kernel/locking/mutex.c                 | 5 +++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/Documentation/locking/mutex-design.rst b/Documentation/locki=
ng/mutex-design.rst
> index 78540cd7f54b..7572339b2f12 100644
> --- a/Documentation/locking/mutex-design.rst
> +++ b/Documentation/locking/mutex-design.rst
> @@ -101,6 +101,12 @@ features that make lock debugging easier and faster:
>      - Detects multi-task circular deadlocks and prints out all affected
>        locks and tasks (and only those tasks).
> =20
> +Releasing a mutex is not an atomic operation: Once a mutex release opera=
tion
> +has begun, another context may be able to acquire the mutex before the r=
elease
> +operation has fully completed. The mutex user must ensure that the mutex=
 is not
> +destroyed while a release operation is still in progress - in other word=
s,
> +callers of mutex_unlock() must ensure that the mutex stays alive until
> +mutex_unlock() has returned.
> =20
>  Interfaces
>  ----------
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 2deeeca3e71b..cbae8c0b89ab 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -532,6 +532,11 @@ static noinline void __sched __mutex_unlock_slowpath=
(struct mutex *lock, unsigne
>   * This function must not be used in interrupt context. Unlocking
>   * of a not locked mutex is not allowed.
>   *
> + * The caller must ensure that the mutex stays alive until this function=
 has
> + * returned - mutex_unlock() can NOT directly be used to release an obje=
ct such
> + * that another concurrent task can free it.
> + * Mutexes are different from spinlocks & refcounts in this aspect.
> + *
>   * This function is similar to (but not equivalent to) up().
>   */
>  void __sched mutex_unlock(struct mutex *lock)

Hi Ingo and Jann, thanks for the patch.

The patch LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--oz6cg3XNiAwQ353b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWqKPwAKCRD2uYlJVVFO
o/M0AQCWThPVVQ64FGDrGvqpOy6HkiUdyNm4B2y18fcJPzVeGAD/Yt1nlTW5XE+7
tvPu9yAzTY0HdYy/CVr/UJc7UzICbQU=
=yca7
-----END PGP SIGNATURE-----

--oz6cg3XNiAwQ353b--
