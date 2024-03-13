Return-Path: <linux-kernel+bounces-101672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A2587AA54
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1BB283D83
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C5846542;
	Wed, 13 Mar 2024 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq8pgzb5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11212446B4;
	Wed, 13 Mar 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343405; cv=none; b=uSmQQgtwhkzSyYElNhq8yRmees7NbcbK0OTuJqVuG48rs+upd7G0UdwTBKtEnDOOWQ37N3rsr6JNNiCmp+RdQrQd9vBMGz1wHysLo6FNuBXNkVbfO98JmMIy/N1jBGxWnO0G6SmDaScrru93zOiGgi88I3YIrktBkRSPJ5O70fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343405; c=relaxed/simple;
	bh=+YgZIjLJQQfyctWkc/iSSuJ6jcLN8FKPMklQVQbuw2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIHup++RnS0sh0D/5JlMQKP08pAj9lOWDHqzsHmgfNdjv+sZKWIzwyxNlW9lXmddW2NwA8HXhPMBQZ3YTeo7tCkIXNhMoro8Q4xD0kHpAlcCpQ1MwusUddJiH8x0nWcF0tiAuSQTAs3qd18DMMWrXPr3DbMCdrsMY4+NI4Lajeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq8pgzb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE69C43390;
	Wed, 13 Mar 2024 15:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710343404;
	bh=+YgZIjLJQQfyctWkc/iSSuJ6jcLN8FKPMklQVQbuw2Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Tq8pgzb5DD0nX/2aGbUB2kIBqw/7oPmyjy0oQt0eazOvdPSwUKeqgLII7/YHqqFR0
	 18pAf06Sw5VX5gHoIHwpcraUISShn4/yTcgtZ26S2HmngKWkV4xDJxaSgf9krMJ8OB
	 UyCF6OX102dac7O2h/V8639AYBs9QxPvbs0dvj5lwHCbNRcG15Zp3qciz/0r01f/6H
	 JsdLxKNZYgGx8dCszfbebizaEP3m17jRsz+Z2JUGFeY5x/5W/bgo+uQrNE7C90XDqT
	 7H344HkYDv5Vk4l6twyNB7kYJR9SfedHK0RVG8Wo2Q7yQQfwf/J/6gp/Tp06LKV+xA
	 VLdc6F41pGrtw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513c53ed3d8so1354017e87.3;
        Wed, 13 Mar 2024 08:23:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6Hrq54L+IyYWdbLakNjhmRCxlwgqpv7bynGH6qLfcvxeYcd+pEsn/RaEUVyQB9wyW0Wzks6N9SHTaiRu4FgL3HGZ2bxtdxwXvtnaMwIgrcXafUofoRlgNCZE4mpDfvWf9un+Y+aBv4ttSOuPlTNYW++U5aSRwXeyGrM9Cf13unKPTUfia1Q==
X-Gm-Message-State: AOJu0YwPTMsN2XMgIuEiLJ/roPLBP3ht88jf7BSB0z3WmpyHYfLdcdJQ
	zoXPs8C5Z7Xtn67xrrECvPsLTD3FjBqg/qywKcDL60timI66cn5hTHek16ldRZatT8qqeXg7580
	hth3BUvj1OVu5lCc6PdNi8dvwfdw=
X-Google-Smtp-Source: AGHT+IF1JfYkf3TAvlLQCXxwR59z3Mm8rlPIsK8HE4E4Rc7VOoQWVhv1uDqlEprG3GHAj8qnxQtmME7DM7SfU2o31Mc=
X-Received: by 2002:a05:6512:3b0d:b0:513:ccda:bc86 with SMTP id
 f13-20020a0565123b0d00b00513ccdabc86mr471271lfv.4.1710343403145; Wed, 13 Mar
 2024 08:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313150728.12e20208@canb.auug.org.au> <psaj3nztnhcxiwjnie3bbpsn7efcsxp3yx3mh54uello22773v@fw5qpqs4gh2i>
In-Reply-To: <psaj3nztnhcxiwjnie3bbpsn7efcsxp3yx3mh54uello22773v@fw5qpqs4gh2i>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 14 Mar 2024 00:22:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNASa-KedA_CTww6unckAGkJCQTctdbk0d-MUsN7wQpM=kQ@mail.gmail.com>
Message-ID: <CAK7LNASa-KedA_CTww6unckAGkJCQTctdbk0d-MUsN7wQpM=kQ@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the mm tree
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 6:01=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Wed, Mar 13, 2024 at 03:07:28PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the mm tree, today's linux-next build (powerpc allyesconf=
ig)
> > produced this warning:
> >
> > Use of uninitialized value $ENV{"abs_srctree"} in concatenation (.) or =
string at /home/sfr/next/next/lib/build_OID_registry line 38.
> >
> > Introduced by commit
> >
> >   325f7b0aaea6 ("lib/build_OID_registry: Don't mention the full path of=
 the script in output")
> >
> > from the mm-nonmm-unstable branch of the mm tree.
>
> Actually the warning doesn't happen on 325f7b0aaea6. The commit is only
> problematic in combination with commit
>
>         e2bad142bb3d ("kbuild: unexport abs_srctree and abs_objtree")
>
> . This commit suggests to use $(abspath ) or $(realpath ) instead, but I
> fail to apply this suggestion here.
>
> Obviously
>
> diff --git a/Makefile b/Makefile
> index 5e09b53b4850..f73a73a125e0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -39,7 +39,7 @@ __all:
>  # prepare rule.
>
>  this-makefile :=3D $(lastword $(MAKEFILE_LIST))
> -abs_srctree :=3D $(realpath $(dir $(this-makefile)))
> +export abs_srctree :=3D $(realpath $(dir $(this-makefile)))
>  abs_objtree :=3D $(CURDIR)
>
>  ifneq ($(sub_make_done),1)
>
> would help.
>
> Any ideas how to properly handle that? Would the export be ok?
>
> Best regards
> Uwe





Oh well, you are making a lot of effort just for a C comment line.




It is trivial to achieve the equivalent thing.


use Cwd qw(abs_path);

my $abs_srctree =3D abs_path($ENV{'srctree'});






I would just print a fixed string, as this is not important.


print C_FILE " * Automatically generated by build_OID_registry.  Do not edi=
t\n";

    OR

print C_FILE " * Automatically generated.  Do not edit\n";






--=20
Best Regards
Masahiro Yamada

