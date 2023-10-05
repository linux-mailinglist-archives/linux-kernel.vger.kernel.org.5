Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7097BA8A0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjJESG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjJESGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:06:51 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E185593
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:06:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-533c4d20b33so2947901a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 11:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696529208; x=1697134008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBCNtxfszOVjEKTdGmoSPushe4btWUupJapnru9ayhU=;
        b=WAMiQp0celMLwqT44EkJUhCWCdTcQ7mxxv0eLx0/9hI27uN9HhYun9HIHE3pbSQAea
         SzrI/VIR3WNHPrrM8Sniv9TEdN2ki/vGMBEEkp7WCruai1NhtwQclAYjcYD6FH7yVBAP
         twlnhwbiyQHmG45YrRSOzDRWCyta3WHiG8aCLXcwMNKVc5PnGWk55HyQp5ILj6lUSy2b
         6sdO9GCU9X5hCiNhI4zQ47SeACvcR95z7/dwAQFuI+30J1KDWXYqVhRJFP/3oYOfeWNv
         QvANjAihAu62JZq/cdrd+qBk7t4L9oDh3hFAb0ej159oQ93Hxh3hSXf+T9gCZyRArNqH
         yIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696529208; x=1697134008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBCNtxfszOVjEKTdGmoSPushe4btWUupJapnru9ayhU=;
        b=Jz49mQ3gJ/E9zPUAxsQvJEEhd5l2xMiFDiniNpuOAaMjqa2WMw4haZJuNTWvU1ANBu
         3S+3nOQTiguInXCzxpCAf3XO06aSr5Nxbjah8kiMgIuq+3uMiTtvkSGNBJ/OKolly7AM
         fIQnMmLDv8mZ4K2y96yfVsVQGuDJ6dcrSGLPo0zOLWTff3wSz3EbuCEgW3gQLK4eXmPV
         X/fW3/frkXBEL1B36gUXsuxdnmGTBAht7piDcCU3P9E20VUz19SQVbn/jmdcxKJDBhGJ
         dLo86hmUzwcRJ5vy6fRpvwlQDqDPcSulhC29kaI21Vbj4GC4cjX3EQpD0x8je3IohIDl
         Rh8A==
X-Gm-Message-State: AOJu0Yx2BbTPSUDny7Pq72fh43u5RVSotUHNjppsboLSMwNCw8EQ7vYz
        8xY0Byw5xW8Qyq9kH7WOgaWpi+ILm2biNA9gwkibZw==
X-Google-Smtp-Source: AGHT+IGy1sRuFtgLH471I4B24HEfkq7jhGRUDuA236vKvMcy8OAZ2mMVr7URf3SJSs5T/aVjk8WcyfPJCggCwWNwzUQ=
X-Received: by 2002:a05:6402:278c:b0:51e:5bd5:fe7e with SMTP id
 b12-20020a056402278c00b0051e5bd5fe7emr1974648ede.17.1696529208249; Thu, 05
 Oct 2023 11:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231004-get_maintainer_change_k-v1-1-ac7ced18306a@google.com> <3dca40b677dd2fef979a5a581a2db91df2c21801.camel@perches.com>
In-Reply-To: <3dca40b677dd2fef979a5a581a2db91df2c21801.camel@perches.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 5 Oct 2023 11:06:35 -0700
Message-ID: <CAFhGd8oTHFDQ05M++E3ggAvs0567w5fSxovumX+vs8YXT8VXTA@mail.gmail.com>
Subject: Re: [PATCH] get_maintainer/MAINTAINERS: confine K content matching to patches
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 7:40=E2=80=AFPM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2023-10-04 at 21:21 +0000, Justin Stitt wrote:
> > The current behavior of K: is a tad bit noisy. It matches against the
> > entire contents of files instead of just against the contents of a
> > patch.
> >
> > This means that a patch with a single character change (fixing a typo o=
r
> > whitespace or something) would still to/cc maintainers and lists if the
> > affected file matched against the regex pattern given in K:. For
> > example, if a file has the word "clang" in it then every single patch
> > touching that file will to/cc Nick, Nathan and some lists.
> >
> > Let's change this behavior to only content match against patches
> > (subjects, message, diff) as this is what most people expect the
> > behavior already is. Most users of "K:" would prefer patch-only content
> > matching. If this is not the case let's add a new matching type as
> > proposed in [1].
>
> I'm glad to know  you are coming around to my suggestion.
:)

>
> I believe the file-based keyword matching should _not_ be
> removed and the option should be added for it like I suggested.

Having a command line flag allowing get_maintainer.pl
users to decide the behavior of K: is weird to me. If I'm a maintainer sett=
ing
my K: in MAINTAINERS I want some sort of consistent behavior. Some
patches will start hitting mailing list that DO have keywords in the patch
and others, confusingly, not. I understand setting the default state of
that flag is probably good enough as it is what 99.9% of users will use.

What do you think about this issue in particular, though?

To note, we get some speed-up here as pattern matching a patch that
touches lots of files would result in searching all of them in their
entirety. Just removing this behavior _might_ have a measurable
speed-up for patch series touching dozens of files.

>
> I also think it might be better to mark the "maintained" output
> differently as something like "keyword matched" instead.
>
>
> Something like:
> ---
>  scripts/get_maintainer.pl | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index ab123b498fd9..befae75e61ab 100755
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
> @@ -919,7 +920,7 @@ sub get_maintainers {
>         }
>
>         foreach my $line (sort {$hash{$b} <=3D> $hash{$a}} keys %hash) {
> -           add_categories($line);
> +           add_categories($line, "");
>             if ($sections) {
>                 my $i;
>                 my $start =3D find_starting_index($line);
> @@ -947,7 +948,7 @@ sub get_maintainers {
>      if ($keywords) {
>         @keyword_tvi =3D sort_and_uniq(@keyword_tvi);
>         foreach my $line (@keyword_tvi) {
> -           add_categories($line);
> +           add_categories($line, ":Keyword");
>         }
>      }
>
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
> @@ -1312,7 +1314,7 @@ sub get_list_role {
>  }
>
>  sub add_categories {
> -    my ($index) =3D @_;
> +    my ($index, $suffix) =3D @_;
>
>      my $i;
>      my $start =3D find_starting_index($index);
> @@ -1342,7 +1344,7 @@ sub add_categories {
>                         if (!$hash_list_to{lc($list_address)}) {
>                             $hash_list_to{lc($list_address)} =3D 1;
>                             push(@list_to, [$list_address,
> -                                           "subscriber list${list_role}"=
]);
> +                                           "subscriber list${list_role}"=
 . $suffix]);
>                         }
>                     }
>                 } else {
> @@ -1352,12 +1354,12 @@ sub add_categories {
>                                 if ($email_moderated_list) {
>                                     $hash_list_to{lc($list_address)} =3D =
1;
>                                     push(@list_to, [$list_address,
> -                                                   "moderated list${list=
_role}"]);
> +                                                   "moderated list${list=
_role}" . $suffix]);
>                                 }
>                             } else {
>                                 $hash_list_to{lc($list_address)} =3D 1;
>                                 push(@list_to, [$list_address,
> -                                               "open list${list_role}"])=
;
> +                                               "open list${list_role}" .=
 $suffix]);
>                             }
>                         }
>                     }
> @@ -1365,19 +1367,19 @@ sub add_categories {
>             } elsif ($ptype eq "M") {
>                 if ($email_maintainer) {
>                     my $role =3D get_maintainer_role($i);
> -                   push_email_addresses($pvalue, $role);
> +                   push_email_addresses($pvalue, $role . $suffix);
>                 }
>             } elsif ($ptype eq "R") {
>                 if ($email_reviewer) {
>                     my $subsystem =3D get_subsystem_name($i);
> -                   push_email_addresses($pvalue, "reviewer:$subsystem");
> +                   push_email_addresses($pvalue, "reviewer:$subsystem" .=
 $suffix);
>                 }
>             } elsif ($ptype eq "T") {
> -               push(@scm, $pvalue);
> +               push(@scm, $pvalue . $suffix);
>             } elsif ($ptype eq "W") {
> -               push(@web, $pvalue);
> +               push(@web, $pvalue . $suffix);
>             } elsif ($ptype eq "S") {
> -               push(@status, $pvalue);
> +               push(@status, $pvalue . $suffix);
>             }
>         }
>      }
>
