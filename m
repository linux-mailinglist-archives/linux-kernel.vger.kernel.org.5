Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE94C7B11E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 07:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjI1FER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 01:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjI1FEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 01:04:14 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B29122
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 22:04:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bf3f59905so1571436066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 22:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695877449; x=1696482249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMt3VDFkV8v21xpyS36v/wPorubRh0WtZEJ/4wI1WC4=;
        b=WD7FtNpGWztgyXdP/zVeiTvntgHqIHr7hdfIcSfrtkcisvtjUWn+yNMc5B+XL/t/W2
         Z2jCIcgfz2R8DApmtNpmoFsQpSAwJ0Oda1FWPhXg7SIKu5xnSRkH4gBbDR+RIH1x+vnh
         dXZ5gqeNxbOn+JOyJ/eoiCoY3W5GGMH61qT5NwNmvZE5CSeP5fwY0kaSaW5EedL9F1we
         01z6bsfehFLrxee7aA6ckQqc2bFzMElTgcie7TnuYDtilnmrF5U6AkQ/DFBku7M49b0y
         UuGfXRmjUgZRupI2UO9WFK2xpHe6sI51KAgdgkUUdUORtqqVbQ4rVLahuk8vg8hrPxdd
         T96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695877449; x=1696482249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMt3VDFkV8v21xpyS36v/wPorubRh0WtZEJ/4wI1WC4=;
        b=HBYb6dwK62O6WZvskUf9/G3vZsY+NMM1Luc0xysf6swyhoPq3Jul2rLw5IL44J5QXi
         PzH3RJxSyHBrf9LEtcDqapp2A8Us/+QTB/tiv3hzbW0uR2W31ULFDPQLVo20sWRyYG6K
         Zus8m0LdQJbaIQ94OtBj1YQ1Y1Uci1V1hQYLvHV9c5CfKrQs20/jIXeWre9fs7A6lsqb
         oTo6aonKAKz+Ula/jAvaLbsug0cKqO3InB3izCPYD4a4znda0p16rElge+1s7hHGlddl
         U6x2m4hgQeHHfZuyqFncGKJSr25OQvsZfJLG2fTo6ETEuDOVw/9u4nin47t0yEI/rxKw
         6gYg==
X-Gm-Message-State: AOJu0YwqjpMrSYBL7bjNhH15DmDvpABLKmx0fmcYQT72cG/FuaPtyj6t
        Jp0dsYQ3nBBsWFATPZd8mFYHIJgIwSr/nITHDdlOfA==
X-Google-Smtp-Source: AGHT+IHsbDNwZygpDuT8nX6B5NMlbaklBzWjXfydWD5M8zeH1vBPpsNN38cIuIC0s484UMYxn+RCte3D4iaMMnjmMbY=
X-Received: by 2002:a17:907:1dcc:b0:9ae:406c:3425 with SMTP id
 og12-20020a1709071dcc00b009ae406c3425mr221236ejc.0.1695877449159; Wed, 27 Sep
 2023 22:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230928-get_maintainer_add_d-v2-0-8acb3f394571@google.com>
 <20230928-get_maintainer_add_d-v2-1-8acb3f394571@google.com> <bf9200e2fc9c55187f2b7661a3b5043f56b0deff.camel@perches.com>
In-Reply-To: <bf9200e2fc9c55187f2b7661a3b5043f56b0deff.camel@perches.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 28 Sep 2023 14:03:57 +0900
Message-ID: <CAFhGd8o8ihYeML6WpiE1-=eeXC+k1yzSEdA-WJXjwB-f9VcHoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] get_maintainer: add patch-only keyword-matching
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        workflows@vger.kernel.org, mario.limonciello@amd.com,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 1:46=E2=80=AFPM Joe Perches <joe@perches.com> wrote=
:
>
> On Thu, 2023-09-28 at 04:23 +0000, Justin Stitt wrote:
> > Add the "D:" type which behaves the same as "K:" but will only match
> > content present in a patch file.
> >
> > To illustrate:
> >
> > Imagine this entry in MAINTAINERS:
> >
> > NEW REPUBLIC
> > M: Han Solo <hansolo@rebelalliance.co>
> > W: https://www.jointheresistance.org
> > D: \bstrncpy\b
> >
> > Our maintainer, Han, will only be added to the recipients if a patch
> > file is passed to get_maintainer (like what b4 does):
> > $ ./scripts/get_maintainer.pl 0004-some-change.patch
> >
> > If the above patch has a `strncpy` present in the subject, commit log o=
r
> > diff then Han will be to/cc'd.
> >
> > However, in the event of a file from the tree given like:
> > $ ./scripts/get_maintainer.pl ./lib/string.c
> >
> > Han will not be noisily to/cc'd (like a K: type would in this
> > circumstance)
> >
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> >  MAINTAINERS               |  5 +++++
> >  scripts/get_maintainer.pl | 12 ++++++++++--
> >  2 files changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b19995690904..94e431daa7c2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -59,6 +59,11 @@ Descriptions of section entries and preferred order
> >             matches patches or files that contain one or more of the wo=
rds
> >             printk, pr_info or pr_err
> >          One regex pattern per line.  Multiple K: lines acceptable.
> > +  D: *Diff content regex* (perl extended) pattern match that applies o=
nly to
> > +     patches and not entire files (e.g. when using the get_maintainers=
.pl
> > +     script).
> > +     Usage same as K:.
> > +
> >
> >  Maintainers List
> >  ----------------
> > diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> > index ab123b498fd9..a3e697926ddd 100755
> > --- a/scripts/get_maintainer.pl
> > +++ b/scripts/get_maintainer.pl
> > @@ -342,6 +342,7 @@ if ($tree && !top_of_kernel_tree($lk_path)) {
> >
> >  my @typevalue =3D ();
> >  my %keyword_hash;
> > +my %patch_keyword_hash;
> >  my @mfiles =3D ();
> >  my @self_test_info =3D ();
> >
> > @@ -369,8 +370,10 @@ sub read_maintainer_file {
> >                   $value =3D~ s@([^/])$@$1/@;
> >               }
> >           } elsif ($type eq "K") {
> > -             $keyword_hash{@typevalue} =3D $value;
> > -         }
> > +          $keyword_hash{@typevalue} =3D $value;
> > +         } elsif ($type eq "D") {
> > +          $patch_keyword_hash{@typevalue} =3D $value;
> > +      }
> >           push(@typevalue, "$type:$value");
> >       } elsif (!(/^\s*$/ || /^\s*\#/)) {
> >           push(@typevalue, $line);
> > @@ -607,6 +610,11 @@ foreach my $file (@ARGV) {
> >                       push(@keyword_tvi, $line);
> >                   }
> >               }
> > +    foreach my $line(keys %patch_keyword_hash) {
> > +      if ($patch_line =3D~ m/${patch_prefix}$patch_keyword_hash{$line}=
/x) {
> > +        push(@keyword_tvi, $line);
> > +      }
> > +    }
> >           }
> >       }
> >       close($patch);
> >
>
>
> My opinion: Nack.
>
> I think something like this would be better
> as it avoids duplication of K and D content.

If I understand correctly, this puts the onus on the get_maintainer users
to select the right argument whereas adding "D:", albeit with some
duplicate code, allows maintainers themselves to decide in exactly
which context they receive mail.

Adding a command line flag means sometimes K: is treated one
way and sometimes treated a different way depending on
the specific incantation.

This could all be a moot point, though, as I believe Konstantin
is trying to separate out the whole idea of a patch-sender needing
to specify the recipients of a patch. Instead some middleware would
capture mail and delegate automatically based on some queries
set up by maintainers.

Exciting idea, I wonder what the progress is on that?

Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

[1]: https://lore.kernel.org/all/20230726-june-mocha-ad6809@meerkat/

> ---
>  scripts/get_maintainer.pl | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index ab123b498fd9..07e7d744cadb 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -57,6 +57,7 @@ my $subsystem =3D 0;
>  my $status =3D 0;
>  my $letters =3D "";
>  my $keywords =3D 1;
> +my $keywords_in_file =3D 0;
>  my $sections =3D 0;
>  my $email_file_emails =3D 0;
>  my $from_filename =3D 0;
> @@ -272,6 +273,7 @@ if (!GetOptions(
>                 'letters=3Ds' =3D> \$letters,
>                 'pattern-depth=3Di' =3D> \$pattern_depth,
>                 'k|keywords!' =3D> \$keywords,
> +               'kf|keywords-in-file!' =3D> \$keywords_in_file,
>                 'sections!' =3D> \$sections,
>                 'fe|file-emails!' =3D> \$email_file_emails,
>                 'f|file' =3D> \$from_filename,
> @@ -318,6 +320,7 @@ if ($sections || $letters ne "") {
>      $subsystem =3D 0;
>      $web =3D 0;
>      $keywords =3D 0;
> +    $keywords_in_file =3D 0;
>      $interactive =3D 0;
>  } else {
>      my $selections =3D $email + $scm + $status + $subsystem + $web;
> @@ -548,16 +551,14 @@ foreach my $file (@ARGV) {
>         $file =3D~ s/^\Q${cur_path}\E//;  #strip any absolute path
>         $file =3D~ s/^\Q${lk_path}\E//;   #or the path to the lk tree
>         push(@files, $file);
> -       if ($file ne "MAINTAINERS" && -f $file && $keywords) {
> +       if ($file ne "MAINTAINERS" && -f $file && $keywords && $keywords_=
in_file) {
>             open(my $f, '<', $file)
>                 or die "$P: Can't open $file: $!\n";
>             my $text =3D do { local($/) ; <$f> };
>             close($f);
> -           if ($keywords) {
> -               foreach my $line (keys %keyword_hash) {
> -                   if ($text =3D~ m/$keyword_hash{$line}/x) {
> -                       push(@keyword_tvi, $line);
> -                   }
> +           foreach my $line (keys %keyword_hash) {
> +               if ($text =3D~ m/$keyword_hash{$line}/x) {
> +                   push(@keyword_tvi, $line);
>                 }
>             }
>         }
> @@ -1076,6 +1077,7 @@ Output type options:
>  Other options:
>    --pattern-depth =3D> Number of pattern directory traversals (default: =
0 (all))
>    --keywords =3D> scan patch for keywords (default: $keywords)
> +  --keywords-in-file =3D> scan file for keywords (default: $keywords_in_=
file)
>    --sections =3D> print all of the subsystem sections with pattern match=
es
>    --letters =3D> print all matching 'letter' types from all matching sec=
tions
>    --mailmap =3D> use .mailmap file (default: $email_use_mailmap)
> @@ -1086,7 +1088,7 @@ Other options:
>
>  Default options:
>    [--email --tree --nogit --git-fallback --m --r --n --l --multiline
> -   --pattern-depth=3D0 --remove-duplicates --rolestats]
> +   --pattern-depth=3D0 --remove-duplicates --rolestats --keywords]
>
>  Notes:
>    Using "-f directory" may give unexpected results:
>
