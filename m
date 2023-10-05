Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35D37BAB48
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 22:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjJEUMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 16:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjJEUL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 16:11:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D5CDB
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 13:11:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53406799540so2534739a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 13:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696536714; x=1697141514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJenS8e96CYmPYx44gSsuYhGimZlKWFUjESpGAE1Lho=;
        b=F6kOv78Hn8GGopeoRc4Axbl4jWRhmCHIywEAClrsW3VwV1ouwsb8kTpCd3i8niwAnC
         4CKSSZ8wZ640wyCz33C9/LOu3nQbwPkvuZ3lT5FNIv3aWZjiLw3tNlfbuwg3Ubl5kG9r
         De0wUcvCbfmFnp6kS6+IHYfO97+48PQ5LlJuWDF82v2kI/pfh9zA2r4fzUPWxbJSiDAy
         lMvny8p/Bk/tMHF0kyKhLIzK0AeZZMQ0s9xp9so3QwMfn3mho0IgBI+ej22tUJ389G0T
         dhUUiA/U4x0ioBRCZ2OfkixqmbTfP4iBJ2guUICJQd6OS6Wx57QWl4pJI57uklwx9Pdm
         O/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696536714; x=1697141514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJenS8e96CYmPYx44gSsuYhGimZlKWFUjESpGAE1Lho=;
        b=EPWjRSdRi/ocAXWIm8ifKopqg+oVvgGAiTAJFeloSjoYH9P5fUZ8ImNrikema4+FAn
         4aOey0KDM5nIVK4xuqNL6NhJ5hpxuECANR1b6/JIcGnBbJUYIicH9IfIHELplxr/mAKV
         foPLEn3efEtCg/M3kJP7IGhQxZ4PBNng/FpHl/F5W8a+zNQahQVxmjiYf4Y7NyjoZYYL
         KYZYQm1gVWAQCRnYRWyGdWeWQwFrmErzvuQJ0ocLQZRj5eUNJ6y6+LtFv/qT4d5bWLmX
         5GOV0W8gpluAmG8V5sT9rpMxE/qxbE5bVit0DKQTb9xpqGYsf2WKk6ndBZR8ADbEPgs0
         eNog==
X-Gm-Message-State: AOJu0YwCeCH6K1Aqn7k7px2nU8NxbMDMB1qRSt69YJ+HPi1I3iEebuNH
        wL2Trt/io/bm27iHBjEJWwB7kMpxmkqAPfOBTr6l5C51t9TfJqYNDfEElQ==
X-Google-Smtp-Source: AGHT+IHTk3c+HQmQKp2cPgHGJZmuuSUdEFKh0VZgM/x//9SuZJDNXQ66xhuriyrmKonMpqUx9kA8Sdsboeuz4SwAvTM=
X-Received: by 2002:aa7:c409:0:b0:530:d6c5:7e79 with SMTP id
 j9-20020aa7c409000000b00530d6c57e79mr5363224edq.32.1696536713873; Thu, 05 Oct
 2023 13:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231005-get_maintainer_change_k-v2-1-5f7febcfedb3@google.com>
In-Reply-To: <20231005-get_maintainer_change_k-v2-1-5f7febcfedb3@google.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 5 Oct 2023 13:11:42 -0700
Message-ID: <CAFhGd8p=X7qP+QndjBOBAXORBxLqgKpcysN61wp_Rj0xvM3+iA@mail.gmail.com>
Subject: Re: [PATCH v2] get_maintainer: add --keywords-in-file
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

disregard!

Joe's spinning up a patch -- coming soon. [1]

On Thu, Oct 5, 2023 at 1:09=E2=80=AFPM Justin Stitt <justinstitt@google.com=
> wrote:
>
> There were some recent attempts [1] [2] to make the K: field less noisy
> and its behavior more obvious. Ultimately, a shift in the default
> behavior and an associated command line flag is the best choice.
>
> Currently, K: will match keywords found in both patches and files.
> Matching content from entire files is (while documented) not obvious
> behavior and is usually not wanted by maintainers. This patch opts to
> only allow patch content to be matched against unless --keywords-in-file
> is provided.
>
> Link: https://lore.kernel.org/all/20230928-get_maintainer_add_d-v2-0-8acb=
3f394571@google.com/ [1]
> Link: https://lore.kernel.org/all/3dca40b677dd2fef979a5a581a2db91df2c2180=
1.camel@perches.com/ [2]
> Authored-by: Joe Perches <joe@perches.com>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - Use Joe's patch and ditch this one
> - Link to v1: https://lore.kernel.org/r/20231004-get_maintainer_change_k-=
v1-1-ac7ced18306a@google.com
> ---
> Note: I've opted to make this a v2 instead of a whole new patch since
> it's related and the patch is authored in v1 by Joe. It will simply
> replace the old patch in its entirety.
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
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231004-get_maintainer_change_k-46a2055e2c59
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>

[1]: https://lore.kernel.org/all/eea5087a2bd94b80b5a16af95a4caf20376bbc52.c=
amel@perches.com
