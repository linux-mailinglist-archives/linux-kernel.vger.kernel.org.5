Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F13C7BAE8A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjJEWBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJEWBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:01:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4998795
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 15:01:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b6559cbd74so277257266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 15:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696543260; x=1697148060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7rW+zsppbDSR83e2mu/w1o69uKLyDR0SFckkgNxcXI=;
        b=QkUHUGHUzlqi/NIVOZyWv0gfGbDEy/mMbPC3nVWsYUx/inUu0v5zhTC0tLCUAABR4H
         KZU8Mkrt2kjOeFeeLoA1fhS4vaP9Z75lxVS00jXU5SSSS90UCCTqxJwAA+aH7ybuS4Ye
         JgtPIvKmRsX1clhV4RHxIQZc/tcJrZT5MlODNMIWhuom175Yeok2RogCBI9GLIbBcIDw
         ytakB2XX79h0AOy+DOshD6RPqvMCZz2m6X6W15F01PL1zvPz9bBlv2pGRXjvbBdNbQ1x
         XxyMQhFB7c6VvApKsPvC2GGlOubSKOsWVAdO8GwjLBsVPZSZPDOAcENVuY39anyVCwC3
         /IEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696543260; x=1697148060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7rW+zsppbDSR83e2mu/w1o69uKLyDR0SFckkgNxcXI=;
        b=HPhZQJF3I9uebven06pjPhkQJ7YoyBzL0V2JfAVWLHybR8BXrfx73TN3om9FXsXA1E
         vCViBh9Dmcz4UN2TUTrP3W7kTMkyaxyLDtfDGtR8HbtoYtCtxdua7+FB7sjxgFcg4IFC
         UohQ0Q8WvAqu/u2A1Eeg29raBJHkCdwXxxF9gXcMhxy4u+gTgmaaRIz+bxzfQi0ulaWv
         bioTDxI+gtvjSISid4G2cnMYeEW463wrcNDwUcOBaONOHL90hyo7JV5byRtg1aqP8dok
         d0h5/my3dtHUn/mhqrY6xOYK3jTePISRb71aW5WTy6SD87vTufyCyn8ZZjOhqaEYYM83
         xzVg==
X-Gm-Message-State: AOJu0Yz0qLSFfjcnHlvP0FoiXS4d0PETfg4BdQDVe03VXJzouBQyRTjF
        iQplo20LV8FoLLmu8tpZazLyRDn2H3B7D6PuqBuMaA==
X-Google-Smtp-Source: AGHT+IH3GfxRS/3sVDu+yQ1Gy2+/8Wlf1t6GCIUPhTuL6dybptTu/zucWb6U/HMliFqydqhaSYe1gZVejZcjJVEKf74=
X-Received: by 2002:a17:906:cc15:b0:9ae:4b88:cdbf with SMTP id
 ml21-20020a170906cc1500b009ae4b88cdbfmr5763847ejb.29.1696543259592; Thu, 05
 Oct 2023 15:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <01fe46f0c58aa8baf92156ae2bdccfb2bf0cb48e.camel@perches.com>
In-Reply-To: <01fe46f0c58aa8baf92156ae2bdccfb2bf0cb48e.camel@perches.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 5 Oct 2023 15:00:47 -0700
Message-ID: <CAFhGd8q5Tktj4d_Y3Z12xycz_iwwWgVvspUdTGxOYM4M318bsg@mail.gmail.com>
Subject: Re: [PATCH] get_maintainer: add --keywords-in-file option
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Thu, Oct 5, 2023 at 2:35=E2=80=AFPM Joe Perches <joe@perches.com> wrote:
>
> There were some recent attempts [1] [2] to make the K: field less noisy
> and its behavior more obvious. Ultimately, a shift in the default
> behavior and an associated command line flag is the best choice.
>
> Currently, K: will match keywords found in both patches and files.
>
> Matching content from entire files is (while documented) not obvious
> behavior and is usually not wanted by maintainers.
>
> Now only patch content will be matched against unless --keywords-in-file
> is also provided as an argument to get_maintainer.
>
> Add the actual keyword matched to the role or rolestats as well.
>
> For instance given the diff below that removes clang:
>
>    diff --git a/drivers/hid/bpf/entrypoints/README b/drivers/hid/bpf/entr=
ypoints/README
>    index 147e0d41509f..f88eb19e8ef2 100644
>    --- a/drivers/hid/bpf/entrypoints/README
>    +++ b/drivers/hid/bpf/entrypoints/README
>    @@ -1,4 +1,4 @@
>     WARNING:
>     If you change "entrypoints.bpf.c" do "make -j" in this directory to r=
ebuild "entrypoints.skel.h".
>    -Make sure to have clang 10 installed.
>    +Make sure to have 10 installed.
>     See Documentation/bpf/bpf_devel_QA.rst
>
> The new role/rolestats output includes ":Keyword:\b(?i:clang|llvm)\b"
>
> $ git diff drivers/hid/bpf/entrypoints/README | .scripts/get_maintainer.p=
l
> Jiri Kosina <jikos@kernel.org> (maintainer:HID CORE LAYER,commit_signer:1=
/1=3D100%)
> Benjamin Tissoires <benjamin.tissoires@redhat.com> (maintainer:HID CORE L=
AYER,commit_signer:1/1=3D100%,authored:1/1=3D100%,added_lines:4/4=3D100%)
> Nathan Chancellor <nathan@kernel.org> (supporter:CLANG/LLVM BUILD SUPPORT=
:Keyword:\b(?i:clang|llvm)\b)
> Nick Desaulniers <ndesaulniers@google.com> (supporter:CLANG/LLVM BUILD SU=
PPORT:Keyword:\b(?i:clang|llvm)\b)
> Tom Rix <trix@redhat.com> (reviewer:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?=
i:clang|llvm)\b)
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:1/1=3D100%=
)
> linux-input@vger.kernel.org (open list:HID CORE LAYER)
> linux-kernel@vger.kernel.org (open list)
> llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:cl=
ang|llvm)\b)
>
> Link: https://lore.kernel.org/r/20231004-get_maintainer_change_k-v1-1-ac7=
ced18306a@google.com
> Link: https://lore.kernel.org/all/20230928-get_maintainer_add_d-v2-0-8acb=
3f394571@google.com
> Link: https://lore.kernel.org/all/3dca40b677dd2fef979a5a581a2db91df2c2180=
1.camel@perches.com
> Original-patch-by: Justin Stitt <justinstitt@google.com>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  scripts/get_maintainer.pl | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index ab123b498fd9..16d8ac6005b6 100755
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
> +           add_categories($line, ":Keyword:$keyword_hash{$line}");
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

Works great!

Some inboxes/lists should now be a little less noisy.

Tested-by: Justin Stitt <justinstitt@google.com>
