Return-Path: <linux-kernel+bounces-86934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4972886CD2A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03AB628958F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE6C14A089;
	Thu, 29 Feb 2024 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uS/PZkcF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E20145B20;
	Thu, 29 Feb 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220956; cv=none; b=lfoD9vRGKcIIwN3ibfSt0qwZWWIlSUygA6dQBfVrVUlvQ4SoAw/QuVXBglqUDPkme493QXsPl7dEBqHqyWShT5D1N/tA2cTxAkWIVE5P5EswJfKdL3eUPZC0ZdOxDje6XxHaBbQapIiIzFrc5ddaO+f2YbtEYX1q5xVnn5HkPRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220956; c=relaxed/simple;
	bh=S0pg8HD5HPJZ+W0z7c+ghy6HqUIw/o0VmlMPZWI0wUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIMULnoBCV228qmT0OWHn7W327HTNohWsi295mIXIJ4QghzAAPac42dMRtwEpdn+TXg9rZx7bE0LPGO3bYQQ3EglkQx0heNXGQUmhCU9KrWn5nn6gruZB9Eekx5FK9Ky6RKFY7C1KwF6eLRa57c1lz7z06hvD7WfW5kOu6ehqpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uS/PZkcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8C4C433F1;
	Thu, 29 Feb 2024 15:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709220955;
	bh=S0pg8HD5HPJZ+W0z7c+ghy6HqUIw/o0VmlMPZWI0wUE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uS/PZkcFjtUoyue8paleT+CRUAMvHho4vnLmhQc6+e/9bHfiBdjIm1Lgyq3/lyf1D
	 hAXu+6KMWIh0iXoQ023w09LuZ6P+EGcyDSsHrrfRTK2NMFrAkC7C4qpnTO+UBTr0Oj
	 nKOsdA8sIP9Ww+NA8Q9GOqYMtWmmRUh0cyu/Aad1s2pz9IJgAVbk9OlnJAlySSAgyy
	 FdiNib6E7zc15wJUjgkU4ydNuYzgkji+4JvN50zhC9SyZ1IjwXibXnuYyEF8n/ygkR
	 rYJ5Uyj5CKDDOlhpheUu5snYztB4K8lQ/oCNU1j5pv0brsFCC7vbWEIXt3dyfn2Nfn
	 ck0sG40usC18g==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51320ca689aso1219773e87.2;
        Thu, 29 Feb 2024 07:35:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6y/mSyHJZJQjz0U69f8K7p1VYX070l9nUiWyeyc5ZEob6oGcJh/HwlTJZPS20Zecym/RR7KWd/I72K7uUokBEZfv8N+ULnAIr5rHb
X-Gm-Message-State: AOJu0YyLcY+eQr84AdJNOyBDVelyO1rh3d86NbMAE5gxL4ZS5ub+80kt
	tku7sxfyy/gBdvSkA2RkWotcPVEudoXcDShLMnh7km9iotlHTO+yE6USaekCeXEVPH26BVJeaey
	Y8GhnUTKpH9yQuroccPTKUZ4ypkE=
X-Google-Smtp-Source: AGHT+IE53TzUvOIsVjjfv2AO7pn6ej+DpUNwo0bxMm81LBFtdNaJ/O5NCWVsPsvyBkJETlVxhDmzO7aeQEg55KjZ48o=
X-Received: by 2002:ac2:5599:0:b0:513:25c6:e98d with SMTP id
 v25-20020ac25599000000b0051325c6e98dmr1445481lfg.57.1709220954262; Thu, 29
 Feb 2024 07:35:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222031801.GG11472@google.com> <20240222032559.496127-1-senozhatsky@chromium.org>
 <CAK7LNARo4L6qxoqRU-0dgABarukJKAaZpCRtfA3MyUHhSuDQxQ@mail.gmail.com>
 <20240222051621.GH11472@google.com> <20240228045652.GH11972@google.com>
 <CAK7LNAQ8OyNMeGzVoTRg-sHDZ4YK0EKY_eEWNepekaibO_ZKwg@mail.gmail.com>
 <20240229021010.GM11972@google.com> <CAK7LNASujf8m4PpMyoCC1cTN_YGeG1HVaOR+3pZx5=3OJp=85A@mail.gmail.com>
 <20240229034739.GN11972@google.com>
In-Reply-To: <20240229034739.GN11972@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 1 Mar 2024 00:35:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS-mOxY884pLEMwWaX+wgzXdc6+=vqN=wfHBekuKL5ryA@mail.gmail.com>
Message-ID: <CAK7LNAS-mOxY884pLEMwWaX+wgzXdc6+=vqN=wfHBekuKL5ryA@mail.gmail.com>
Subject: Re: [PATCHv2] kconfig: add some Kconfig env variables to make help
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 12:47=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/02/29 12:36), Masahiro Yamada wrote:
> > > On (24/02/29 11:03), Masahiro Yamada wrote:
> > > > > > > > +++ b/scripts/kconfig/Makefile
> [..]
> > > > > > > > +       @echo  ''
> > > > > > > > +       @echo  'Configuration environment variables:'
> > > > > > > > +       @echo  '  KCONFIG_WERROR                 - Turn som=
e Kconfig warnings into error conditions'
> > > > > > > > +       @echo  '  KCONFIG_WARN_UNKNOWN_SYMBOLS   - Make Kco=
nfig warn about all unrecognized config symbols'
> > > > > > > >
> > > > > > > >  # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > > > > >  # object files used by all kconfig flavours
> > > > > > > > --
> > > > > > > > 2.44.0.rc0.258.g7320e95886-goog
> > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > > > Why only two, while Kconfig supports more env variables?
> > > > > >
> > > > > > Right.  I wanted to add only those that we use (and familiar wi=
th) for
> > > > > > starters.  I'm not familiar with things like KCONFIG_PROBABILIT=
Y, for
> > > > > > instance, and not sure how to document it (its Documentation/kb=
uild/kconfig.rst
> > > > > > description is pretty lengthy).
> > > > >
> > > > > Masahiro, any opinion?
> > > >
> > > >
> > > > I do not need this patch.
> > >
> > > Do you agree that putting kconfig env knobs into help makes sense
> > > in general?  Especially those add valuable sanity checks.
> >
> > I cannot accept the attitude:
>
> This is entirely wrong interpretation.
>
> >   "I am interested only in these. I do not care about the rest,
>
> It's "I *do NOT know* what the rest do".  I cannot document something
> that I have no knowledge of, can I?  So as a reasonable start I added
> only those that I'm familiar with (and I have explicitly stated that
> in previous emails), and I disagree with the "bad attitude" label.


You were aware of:

 - several env variables are listed in the document
 - your patch would introduce a new "inconsistency"
 - somebody else would need to make efforts to solve it



> > This should be all or nothing.
> >
> > I do not think all the env variables can be summarized
> > to fit in help.
>
> So the rational for that was that people run "make help" and find
> out about new build targets, for instance, but there is no way for
> people to find out about new Kconfig features (and yes, we are talking
> "new features" here) that are controlled by env variables.  We need
> to do something about it, don't you agree?


Disagree.

I maintain the entire Kconfig, not like you only caring about
a particular feature.

If you add only two in help, I have no idea about
what it will look like in the end.
I am not convinced that it will be in good shape.
So, it is reasonable for me to reject it.



--=20
Best Regards
Masahiro Yamada

