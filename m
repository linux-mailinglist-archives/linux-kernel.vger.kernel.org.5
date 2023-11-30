Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951007FEA29
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344820AbjK3IEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344771AbjK3IEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:04:38 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A412A3;
        Thu, 30 Nov 2023 00:04:44 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc9b626a96so6584415ad.2;
        Thu, 30 Nov 2023 00:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701331484; x=1701936284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bgB6RoiFobLknzEtO8MoirvVaa88Hx4zUcBwWoGsM5M=;
        b=hkc85nqZxyWeTZmix33vJMZGwli9+hCPe7VJIUw4DKH5c0Cqla8yawWXNXelM7tLdJ
         buIUWH2KTFIrYGwIRQSRhZfRbvYE2T9tS9LXJSGwHW8JodouWhumdupGyIsSfuTRIrpa
         BasjGRxz4ktiw0XFzMgLHhrrMC2BjobuTmNRNNNrUL7Yq4KWDZqU7fwV4Fyfwp7okk+9
         hJA3VvDxCLsXejRk+erpjrjp5PbRWbrnGoO7xkUDbO0h9GWPzhesWSqT5H08Ui+41Xgb
         hQuJvf98wdln+k9xbyNWJ8FJFo/tkrVkR5XT1ZskBQrh6BCIgdApDCQumw6/nStH0g5K
         kEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701331484; x=1701936284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgB6RoiFobLknzEtO8MoirvVaa88Hx4zUcBwWoGsM5M=;
        b=R0wtYRH60ky1CAr5RLIn4LbH7Y9/u5WFlqEj0unYRaOu0/CBEEQu74Uzm/G4uWjsZx
         532LU/KiF//Z/1/O10CVGHdjE0qAxP46fe4ZZRUgAc5t8XjXwuzeMJ09X9QC6dP80vtE
         B5A8TXgQaIJAckIEZkR7IoUTIWFN7ppZ9Dnjl+4JDAgDxhJqw1jJ21m8MxSEm4eEpBUc
         gmkMEpLr+SS+jlIEvpy6Ztrs17BHIRzf3P8SE8fN4yYK9WeKsvnsshttyAM797ceuhJY
         YWzdsnpmxkLaYzTmDFrWcEbIElDHC+xKCWUIvlv6QfkbfPUuPivoClgEifiQjZQ7BL9h
         fU1Q==
X-Gm-Message-State: AOJu0Yyr5+bndC8i1ewoMoLhCV9uy3HG3fnddlXYqSh0FfMdgEZwBWTL
        cc2mOjRBP6dexaQnU2DuZGI=
X-Google-Smtp-Source: AGHT+IEGoOdRQFIyflKN6XFRtYjPec4rcSFOpDa2HyGuCnXvq+plqF4HG9/xF+7ogLVZ5KUFPMcqAA==
X-Received: by 2002:a17:902:db06:b0:1cf:c376:6d8d with SMTP id m6-20020a170902db0600b001cfc3766d8dmr15663408plx.32.1701331483766;
        Thu, 30 Nov 2023 00:04:43 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c20a00b001c9dac0fbbasm697119pll.63.2023.11.30.00.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 00:04:41 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id F2BF610F63FA9; Thu, 30 Nov 2023 15:04:38 +0700 (WIB)
Date:   Thu, 30 Nov 2023 15:04:38 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Livepatching <live-patching@vger.kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Attreyee Mukherjee <tintinm2017@gmail.com>
Subject: Re: [PATCH 0/2] Minor grammatical fixup for livepatch docs
Message-ID: <ZWhCFic541YaYf4w@archie.me>
References: <20231129132527.8078-1-bagasdotme@gmail.com>
 <ac7a90a7-4d29-059b-fbff-6b67e6f5c2d3@redhat.com>
 <a4da77c2-7a23-4988-b65a-a58c105d89a4@gmail.com>
 <87h6l4ksni.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p+we3TKRNR7h2S1s"
Content-Disposition: inline
In-Reply-To: <87h6l4ksni.fsf@meer.lwn.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p+we3TKRNR7h2S1s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 05:10:25PM -0700, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>=20
> > On 11/29/23 20:53, Joe Lawrence wrote:
> >> On 11/29/23 08:25, Bagas Sanjaya wrote:
> >>> I was prompted to write this little grammar fix series when reading
> >>> the fix from Attreyee [1], with review comments requesting changes
> >>> to that fix. So here's my version of the fix, with reviews from [1]
> >>> addressed (and distinct grammar fixes splitted).
> >>>
> >>=20
> >> Typical kernel workflow would be for Attreyee to incorporate feedback
> >> and post their v2 after a day or two.  From the format they posted, it
> >> appears to be a first(ish) kernel contribution post.  Let's be kind and
> >> patient so they we all may benefit from the practice of iterating on
> >> their patch.
> >>=20
> >
> > I do this posting because I thought the OP (Attreyee) didn't respond in
> > timely manner (just like random Chinese contributors like @cdjrlc.com
> > and @208suo.com people).
>=20
> Seriously?  The original post was on Monday, yours came less than 48
> hours later.  Not only can we not expect that kind of rapid turnaround
> from anybody, but we actively discourage rapid resending of patches.
> Rather than dig yourself in deeper, I suggest you simply apologize to
> the original poster and find something more useful to do.

Done, thanks!

And yes, I'm also focusing on regression tracking and Bugzilla
triaging.

Ciao, Bagas.

--=20
An old man doll... just what I always wanted! - Clara

--p+we3TKRNR7h2S1s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWhCBgAKCRD2uYlJVVFO
o4KyAP9QAMwScjDOefXLk7AsKL3A93x/m/r/RPaaE04kNiQHzAEA2Wo/kuHugyoY
7LAoCn4OIfARydmbZskeF2tkU8O70gU=
=HZuv
-----END PGP SIGNATURE-----

--p+we3TKRNR7h2S1s--
