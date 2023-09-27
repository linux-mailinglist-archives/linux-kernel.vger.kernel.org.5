Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50967AF94C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjI0EZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 00:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjI0EXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:23:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911AE1E97D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:19:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81e9981ff4so14943754276.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695784770; x=1696389570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfDWpIW/8CUzA5xcRwDkz4QJ+K8yTRgqRPHqwiaPezA=;
        b=j+UznnK3pIfZjulacSD2myHCBhnNku+hRXgBhw4OcPaLfZkMJ1woa5y6VWiqBJuj7t
         1g63QsfHBWYNt7xX2OZmDnZsXH/J1WIkNXprNxJm8mfq3xsa4qNJlXFjrtZNrFc4s0Cv
         1BD/X0jPkDMRnxP5QvmvlP7UCBxomHExdDRzWJ1NSIyOdJ68XFcPxfzgOWGy9PTFx0DF
         L5z1iY5cVNXiFsnJuHtjxxcoTIeSt/LCRpiH1xHMqaslnDqiZB9toYDF8L1J0LpqYeCs
         JeuOtuVwj+TgNOfEX3pQA/zqX7O3hfSv15W8Rq9yLHlp7LQwh6oIUriCnx0PjtfIPf/6
         pX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695784770; x=1696389570;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hfDWpIW/8CUzA5xcRwDkz4QJ+K8yTRgqRPHqwiaPezA=;
        b=ge5Vjpxw1cSvsKW1wjGNlxXwVXJGoJk62Zihti3K7Wy+gyIwrkE4FV10nfaN3LoxFR
         WZpeQ/VDgf7q3Yxdzz9MnHhJyCnizuiS5zWCbsLXXxOzyUpuRHEs/Qktng1tM742lLvl
         6l+Er+0afkQQcLQCtzgvHfIy64xyMlrgEmntOGOSBTJPDSPAG7wZwO8ssByRnbYxmKqu
         oCuItzBOa1RZvYapv2Ki+kSi46ZbOorTP8KGhXVpfJApkpYgFMuELAnqruuLei8SaZ6F
         YKiCSaJwUW3wjz23hOGaAuir1aD0nVC7RSU+CHq9gkwFpo7F/PljAuscL2EnNTukniAB
         ufjA==
X-Gm-Message-State: AOJu0Yw/tTu6XTwlgC3QGSUiPGRglaqzXFKj+msCSkss+9NS+lmpmbGq
        HKVVEx7b029z6HTE66yJ/kzK4MvEl+Epnx7+tw==
X-Google-Smtp-Source: AGHT+IEb+E5oHNQLhoT/jTKDa7FgPEbF40bd2cHkUdO5pkanqp8v+peF0n20EhJ79lAvIO7Dx1oMDRJKPpKgzaIPPg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1613:b0:d80:ff9:d19e with
 SMTP id bw19-20020a056902161300b00d800ff9d19emr8429ybb.9.1695784769795; Tue,
 26 Sep 2023 20:19:29 -0700 (PDT)
Date:   Wed, 27 Sep 2023 03:19:15 +0000
In-Reply-To: <20230927-get_maintainer_add_d-v1-0-28c207229e72@google.com>
Mime-Version: 1.0
References: <20230927-get_maintainer_add_d-v1-0-28c207229e72@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695784766; l=137699;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=a5IMoV96NTdQdZo9TXRyC6eIeYI5zLVOlaygkttIAEg=; b=B4J9CoEMGjsEW10NeaG8Wco+w1j6Y3boxhiVQ86YnfOY9i4ykR5yyTe75JlV7+f2ewRy4YTVv
 QZD7s0cRyEBAUxtJRE+OA7adKKqwx51HnDShuNvrx8jiUTfvyRiGWCO
X-Mailer: b4 0.12.3
Message-ID: <20230927-get_maintainer_add_d-v1-2-28c207229e72@google.com>
Subject: [PATCH 2/3] get_maintainer: run perltidy
From:   Justin Stitt <justinstitt@google.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        workflows@vger.kernel.org, mario.limonciello@amd.com,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm a first time contributor to get_maintainer.pl and the formatting is
suspicious. I am not sure if there is a particular reason it is the way
it is but I let my editor format it and submitted the diff here in this
patch.

Note that my next patch [3/3] probably won't apply without this one. If
for some reason we don't want this file formatted I'll send a new patch
series with my changes diff'd against the non-formatted
get_maintainer.pl.

Note that I don't write perl very often and might not be aware of
particular styling decisions that were made. I just let perltidy do its
thing.

There's an online version of perltidy available here [1]

[1]: https://perltidy.com/
---
Note: I used these options (pretty sure these are default)
options=3D"-l=3D478 -i=3D4 -ci=3D4 -vt=3D2 -cti=3D0 -pt=3D1 -bt=3D1 -sbt=3D=
1 -bbt=3D1 -nsfs -nolq -it=3D2 -wbb=3D"% + - * / x !=3D =3D=3D >=3D <=3D =
=3D~ !~ < > | & =3D **=3D +=3D *=3D &=3D <<=3D &&=3D -=3D /=3D |=3D >>=3D |=
|=3D //=3D .=3D %=3D ^=3D x=3D"

Note: I did not notice any regressions in my usage of get_maintainer
post-formatting. I'd be surprised if my formatter broke functionality
but you never know.
---
 scripts/get_maintainer.pl | 3325 +++++++++++++++++++++++------------------=
----
 1 file changed, 1706 insertions(+), 1619 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ab123b498fd9..e679eac96793 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -21,58 +21,58 @@ use Cwd;
 use File::Find;
 use File::Spec::Functions;
=20
-my $cur_path =3D fastgetcwd() . '/';
-my $lk_path =3D "./";
-my $email =3D 1;
-my $email_usename =3D 1;
-my $email_maintainer =3D 1;
-my $email_reviewer =3D 1;
-my $email_fixes =3D 1;
-my $email_list =3D 1;
-my $email_moderated_list =3D 1;
-my $email_subscriber_list =3D 0;
-my $email_git_penguin_chiefs =3D 0;
-my $email_git =3D 0;
+my $cur_path                      =3D fastgetcwd() . '/';
+my $lk_path                       =3D "./";
+my $email                         =3D 1;
+my $email_usename                 =3D 1;
+my $email_maintainer              =3D 1;
+my $email_reviewer                =3D 1;
+my $email_fixes                   =3D 1;
+my $email_list                    =3D 1;
+my $email_moderated_list          =3D 1;
+my $email_subscriber_list         =3D 0;
+my $email_git_penguin_chiefs      =3D 0;
+my $email_git                     =3D 0;
 my $email_git_all_signature_types =3D 0;
-my $email_git_blame =3D 0;
-my $email_git_blame_signatures =3D 1;
-my $email_git_fallback =3D 1;
-my $email_git_min_signatures =3D 1;
-my $email_git_max_maintainers =3D 5;
-my $email_git_min_percent =3D 5;
-my $email_git_since =3D "1-year-ago";
-my $email_hg_since =3D "-365";
-my $interactive =3D 0;
-my $email_remove_duplicates =3D 1;
-my $email_use_mailmap =3D 1;
-my $output_multiline =3D 1;
-my $output_separator =3D ", ";
-my $output_roles =3D 0;
-my $output_rolestats =3D 1;
-my $output_section_maxlen =3D 50;
-my $scm =3D 0;
-my $tree =3D 1;
-my $web =3D 0;
-my $subsystem =3D 0;
-my $status =3D 0;
-my $letters =3D "";
-my $keywords =3D 1;
-my $sections =3D 0;
-my $email_file_emails =3D 0;
-my $from_filename =3D 0;
-my $pattern_depth =3D 0;
-my $self_test =3D undef;
-my $version =3D 0;
-my $help =3D 0;
-my $find_maintainer_files =3D 0;
+my $email_git_blame               =3D 0;
+my $email_git_blame_signatures    =3D 1;
+my $email_git_fallback            =3D 1;
+my $email_git_min_signatures      =3D 1;
+my $email_git_max_maintainers     =3D 5;
+my $email_git_min_percent         =3D 5;
+my $email_git_since               =3D "1-year-ago";
+my $email_hg_since                =3D "-365";
+my $interactive                   =3D 0;
+my $email_remove_duplicates       =3D 1;
+my $email_use_mailmap             =3D 1;
+my $output_multiline              =3D 1;
+my $output_separator              =3D ", ";
+my $output_roles                  =3D 0;
+my $output_rolestats              =3D 1;
+my $output_section_maxlen         =3D 50;
+my $scm                           =3D 0;
+my $tree                          =3D 1;
+my $web                           =3D 0;
+my $subsystem                     =3D 0;
+my $status                        =3D 0;
+my $letters                       =3D "";
+my $keywords                      =3D 1;
+my $sections                      =3D 0;
+my $email_file_emails             =3D 0;
+my $from_filename                 =3D 0;
+my $pattern_depth                 =3D 0;
+my $self_test                     =3D undef;
+my $version                       =3D 0;
+my $help                          =3D 0;
+my $find_maintainer_files         =3D 0;
 my $maintainer_path;
 my $vcs_used =3D 0;
=20
 my $exit =3D 0;
=20
-my @files =3D ();
-my @fixes =3D ();			# If a patch description includes Fixes: lines
-my @range =3D ();
+my @files       =3D ();
+my @fixes       =3D ();    # If a patch description includes Fixes: lines
+my @range       =3D ();
 my @keyword_tvi =3D ();
 my @file_emails =3D ();
=20
@@ -80,29 +80,30 @@ my %commit_author_hash;
 my %commit_signer_hash;
=20
 my @penguin_chief =3D ();
-push(@penguin_chief, "Linus Torvalds:torvalds\@linux-foundation.org");
+push( @penguin_chief, "Linus Torvalds:torvalds\@linux-foundation.org" );
+
 #Andrew wants in on most everything - 2009/01/14
 #push(@penguin_chief, "Andrew Morton:akpm\@linux-foundation.org");
=20
 my @penguin_chief_names =3D ();
 foreach my $chief (@penguin_chief) {
-    if ($chief =3D~ m/^(.*):(.*)/) {
-	my $chief_name =3D $1;
-	my $chief_addr =3D $2;
-	push(@penguin_chief_names, $chief_name);
+    if ( $chief =3D~ m/^(.*):(.*)/ ) {
+        my $chief_name =3D $1;
+        my $chief_addr =3D $2;
+        push( @penguin_chief_names, $chief_name );
     }
 }
-my $penguin_chiefs =3D "\(" . join("|", @penguin_chief_names) . "\)";
+my $penguin_chiefs =3D "\(" . join( "|", @penguin_chief_names ) . "\)";
=20
 # Signature types of people who are either
 # 	a) responsible for the code in question, or
 # 	b) familiar enough with it to give relevant feedback
 my @signature_tags =3D ();
-push(@signature_tags, "Signed-off-by:");
-push(@signature_tags, "Reviewed-by:");
-push(@signature_tags, "Acked-by:");
+push( @signature_tags, "Signed-off-by:" );
+push( @signature_tags, "Reviewed-by:" );
+push( @signature_tags, "Acked-by:" );
=20
-my $signature_pattern =3D "\(" . join("|", @signature_tags) . "\)";
+my $signature_pattern =3D "\(" . join( "|", @signature_tags ) . "\)";
=20
 # rfc822 email address - preloaded methods go here.
 my $rfc822_lwsp =3D "(?:(?:\\r\\n)?[ \\t])";
@@ -113,282 +114,250 @@ my $rfc822_char =3D '[\\000-\\377]';
 my %VCS_cmds;
=20
 my %VCS_cmds_git =3D (
-    "execute_cmd" =3D> \&git_execute_cmd,
-    "available" =3D> '(which("git") ne "") && (-e ".git")',
-    "find_signers_cmd" =3D>
-	"git log --no-color --follow --since=3D\$email_git_since " .
-	    '--numstat --no-merges ' .
-	    '--format=3D"GitCommit: %H%n' .
-		      'GitAuthor: %an <%ae>%n' .
-		      'GitDate: %aD%n' .
-		      'GitSubject: %s%n' .
-		      '%b%n"' .
-	    " -- \$file",
-    "find_commit_signers_cmd" =3D>
-	"git log --no-color " .
-	    '--numstat ' .
-	    '--format=3D"GitCommit: %H%n' .
-		      'GitAuthor: %an <%ae>%n' .
-		      'GitDate: %aD%n' .
-		      'GitSubject: %s%n' .
-		      '%b%n"' .
-	    " -1 \$commit",
-    "find_commit_author_cmd" =3D>
-	"git log --no-color " .
-	    '--numstat ' .
-	    '--format=3D"GitCommit: %H%n' .
-		      'GitAuthor: %an <%ae>%n' .
-		      'GitDate: %aD%n' .
-		      'GitSubject: %s%n"' .
-	    " -1 \$commit",
-    "blame_range_cmd" =3D> "git blame -l -L \$diff_start,+\$diff_length \$=
file",
-    "blame_file_cmd" =3D> "git blame -l \$file",
-    "commit_pattern" =3D> "^GitCommit: ([0-9a-f]{40,40})",
-    "blame_commit_pattern" =3D> "^([0-9a-f]+) ",
-    "author_pattern" =3D> "^GitAuthor: (.*)",
-    "subject_pattern" =3D> "^GitSubject: (.*)",
-    "stat_pattern" =3D> "^(\\d+)\\t(\\d+)\\t\$file\$",
-    "file_exists_cmd" =3D> "git ls-files \$file",
-    "list_files_cmd" =3D> "git ls-files \$file",
+    "execute_cmd"             =3D> \&git_execute_cmd,
+    "available"               =3D> '(which("git") ne "") && (-e ".git")',
+    "find_signers_cmd"        =3D> "git log --no-color --follow --since=3D=
\$email_git_since " . '--numstat --no-merges ' . '--format=3D"GitCommit: %H=
%n' . 'GitAuthor: %an <%ae>%n' . 'GitDate: %aD%n' . 'GitSubject: %s%n' . '%=
b%n"' . " -- \$file",
+    "find_commit_signers_cmd" =3D> "git log --no-color " . '--numstat ' . =
'--format=3D"GitCommit: %H%n' . 'GitAuthor: %an <%ae>%n' . 'GitDate: %aD%n'=
 . 'GitSubject: %s%n' . '%b%n"' . " -1 \$commit",
+    "find_commit_author_cmd"  =3D> "git log --no-color " . '--numstat ' . =
'--format=3D"GitCommit: %H%n' . 'GitAuthor: %an <%ae>%n' . 'GitDate: %aD%n'=
 . 'GitSubject: %s%n"' . " -1 \$commit",
+    "blame_range_cmd"         =3D> "git blame -l -L \$diff_start,+\$diff_l=
ength \$file",
+    "blame_file_cmd"          =3D> "git blame -l \$file",
+    "commit_pattern"          =3D> "^GitCommit: ([0-9a-f]{40,40})",
+    "blame_commit_pattern"    =3D> "^([0-9a-f]+) ",
+    "author_pattern"          =3D> "^GitAuthor: (.*)",
+    "subject_pattern"         =3D> "^GitSubject: (.*)",
+    "stat_pattern"            =3D> "^(\\d+)\\t(\\d+)\\t\$file\$",
+    "file_exists_cmd"         =3D> "git ls-files \$file",
+    "list_files_cmd"          =3D> "git ls-files \$file",
 );
=20
 my %VCS_cmds_hg =3D (
-    "execute_cmd" =3D> \&hg_execute_cmd,
-    "available" =3D> '(which("hg") ne "") && (-d ".hg")',
-    "find_signers_cmd" =3D>
-	"hg log --date=3D\$email_hg_since " .
-	    "--template=3D'HgCommit: {node}\\n" .
-	                "HgAuthor: {author}\\n" .
-			"HgSubject: {desc}\\n'" .
-	    " -- \$file",
-    "find_commit_signers_cmd" =3D>
-	"hg log " .
-	    "--template=3D'HgSubject: {desc}\\n'" .
-	    " -r \$commit",
-    "find_commit_author_cmd" =3D>
-	"hg log " .
-	    "--template=3D'HgCommit: {node}\\n" .
-		        "HgAuthor: {author}\\n" .
-			"HgSubject: {desc|firstline}\\n'" .
-	    " -r \$commit",
-    "blame_range_cmd" =3D> "",		# not supported
-    "blame_file_cmd" =3D> "hg blame -n \$file",
-    "commit_pattern" =3D> "^HgCommit: ([0-9a-f]{40,40})",
-    "blame_commit_pattern" =3D> "^([ 0-9a-f]+):",
-    "author_pattern" =3D> "^HgAuthor: (.*)",
-    "subject_pattern" =3D> "^HgSubject: (.*)",
-    "stat_pattern" =3D> "^(\\d+)\t(\\d+)\t\$file\$",
-    "file_exists_cmd" =3D> "hg files \$file",
-    "list_files_cmd" =3D> "hg manifest -R \$file",
+    "execute_cmd"             =3D> \&hg_execute_cmd,
+    "available"               =3D> '(which("hg") ne "") && (-d ".hg")',
+    "find_signers_cmd"        =3D> "hg log --date=3D\$email_hg_since " . "=
--template=3D'HgCommit: {node}\\n" . "HgAuthor: {author}\\n" . "HgSubject: =
{desc}\\n'" . " -- \$file",
+    "find_commit_signers_cmd" =3D> "hg log " . "--template=3D'HgSubject: {=
desc}\\n'" . " -r \$commit",
+    "find_commit_author_cmd"  =3D> "hg log " . "--template=3D'HgCommit: {n=
ode}\\n" . "HgAuthor: {author}\\n" . "HgSubject: {desc|firstline}\\n'" . " =
-r \$commit",
+    "blame_range_cmd"         =3D> "",                                    =
                                                                           =
                          # not supported
+    "blame_file_cmd"          =3D> "hg blame -n \$file",
+    "commit_pattern"          =3D> "^HgCommit: ([0-9a-f]{40,40})",
+    "blame_commit_pattern"    =3D> "^([ 0-9a-f]+):",
+    "author_pattern"          =3D> "^HgAuthor: (.*)",
+    "subject_pattern"         =3D> "^HgSubject: (.*)",
+    "stat_pattern"            =3D> "^(\\d+)\t(\\d+)\t\$file\$",
+    "file_exists_cmd"         =3D> "hg files \$file",
+    "list_files_cmd"          =3D> "hg manifest -R \$file",
 );
=20
 my $conf =3D which_conf(".get_maintainer.conf");
-if (-f $conf) {
+if ( -f $conf ) {
     my @conf_args;
-    open(my $conffile, '<', "$conf")
-	or warn "$P: Can't find a readable .get_maintainer.conf file $!\n";
+    open( my $conffile, '<', "$conf" )
+        or warn "$P: Can't find a readable .get_maintainer.conf file $!\n"=
;
=20
     while (<$conffile>) {
-	my $line =3D $_;
+        my $line =3D $_;
=20
-	$line =3D~ s/\s*\n?$//g;
-	$line =3D~ s/^\s*//g;
-	$line =3D~ s/\s+/ /g;
+        $line =3D~ s/\s*\n?$//g;
+        $line =3D~ s/^\s*//g;
+        $line =3D~ s/\s+/ /g;
=20
-	next if ($line =3D~ m/^\s*#/);
-	next if ($line =3D~ m/^\s*$/);
+        next if ( $line =3D~ m/^\s*#/ );
+        next if ( $line =3D~ m/^\s*$/ );
=20
-	my @words =3D split(" ", $line);
-	foreach my $word (@words) {
-	    last if ($word =3D~ m/^#/);
-	    push (@conf_args, $word);
-	}
+        my @words =3D split( " ", $line );
+        foreach my $word (@words) {
+            last if ( $word =3D~ m/^#/ );
+            push( @conf_args, $word );
+        }
     }
     close($conffile);
-    unshift(@ARGV, @conf_args) if @conf_args;
+    unshift( @ARGV, @conf_args ) if @conf_args;
 }
=20
 my @ignore_emails =3D ();
-my $ignore_file =3D which_conf(".get_maintainer.ignore");
-if (-f $ignore_file) {
-    open(my $ignore, '<', "$ignore_file")
-	or warn "$P: Can't find a readable .get_maintainer.ignore file $!\n";
+my $ignore_file   =3D which_conf(".get_maintainer.ignore");
+if ( -f $ignore_file ) {
+    open( my $ignore, '<', "$ignore_file" )
+        or warn "$P: Can't find a readable .get_maintainer.ignore file $!\=
n";
     while (<$ignore>) {
-	my $line =3D $_;
+        my $line =3D $_;
=20
-	$line =3D~ s/\s*\n?$//;
-	$line =3D~ s/^\s*//;
-	$line =3D~ s/\s+$//;
-	$line =3D~ s/#.*$//;
+        $line =3D~ s/\s*\n?$//;
+        $line =3D~ s/^\s*//;
+        $line =3D~ s/\s+$//;
+        $line =3D~ s/#.*$//;
=20
-	next if ($line =3D~ m/^\s*$/);
-	if (rfc822_valid($line)) {
-	    push(@ignore_emails, $line);
-	}
+        next if ( $line =3D~ m/^\s*$/ );
+        if ( rfc822_valid($line) ) {
+            push( @ignore_emails, $line );
+        }
     }
     close($ignore);
 }
=20
-if ($#ARGV > 0) {
+if ( $#ARGV > 0 ) {
     foreach (@ARGV) {
-        if ($_ =3D~ /^-{1,2}self-test(?:=3D|$)/) {
+        if ( $_ =3D~ /^-{1,2}self-test(?:=3D|$)/ ) {
             die "$P: using --self-test does not allow any other option or =
argument\n";
         }
     }
 }
=20
 if (!GetOptions(
-		'email!' =3D> \$email,
-		'git!' =3D> \$email_git,
-		'git-all-signature-types!' =3D> \$email_git_all_signature_types,
-		'git-blame!' =3D> \$email_git_blame,
-		'git-blame-signatures!' =3D> \$email_git_blame_signatures,
-		'git-fallback!' =3D> \$email_git_fallback,
-		'git-chief-penguins!' =3D> \$email_git_penguin_chiefs,
-		'git-min-signatures=3Di' =3D> \$email_git_min_signatures,
-		'git-max-maintainers=3Di' =3D> \$email_git_max_maintainers,
-		'git-min-percent=3Di' =3D> \$email_git_min_percent,
-		'git-since=3Ds' =3D> \$email_git_since,
-		'hg-since=3Ds' =3D> \$email_hg_since,
-		'i|interactive!' =3D> \$interactive,
-		'remove-duplicates!' =3D> \$email_remove_duplicates,
-		'mailmap!' =3D> \$email_use_mailmap,
-		'm!' =3D> \$email_maintainer,
-		'r!' =3D> \$email_reviewer,
-		'n!' =3D> \$email_usename,
-		'l!' =3D> \$email_list,
-		'fixes!' =3D> \$email_fixes,
-		'moderated!' =3D> \$email_moderated_list,
-		's!' =3D> \$email_subscriber_list,
-		'multiline!' =3D> \$output_multiline,
-		'roles!' =3D> \$output_roles,
-		'rolestats!' =3D> \$output_rolestats,
-		'separator=3Ds' =3D> \$output_separator,
-		'subsystem!' =3D> \$subsystem,
-		'status!' =3D> \$status,
-		'scm!' =3D> \$scm,
-		'tree!' =3D> \$tree,
-		'web!' =3D> \$web,
-		'letters=3Ds' =3D> \$letters,
-		'pattern-depth=3Di' =3D> \$pattern_depth,
-		'k|keywords!' =3D> \$keywords,
-		'sections!' =3D> \$sections,
-		'fe|file-emails!' =3D> \$email_file_emails,
-		'f|file' =3D> \$from_filename,
-		'find-maintainer-files' =3D> \$find_maintainer_files,
-		'mpath|maintainer-path=3Ds' =3D> \$maintainer_path,
-		'self-test:s' =3D> \$self_test,
-		'v|version' =3D> \$version,
-		'h|help|usage' =3D> \$help,
-		)) {
+        'email!'                   =3D> \$email,
+        'git!'                     =3D> \$email_git,
+        'git-all-signature-types!' =3D> \$email_git_all_signature_types,
+        'git-blame!'               =3D> \$email_git_blame,
+        'git-blame-signatures!'    =3D> \$email_git_blame_signatures,
+        'git-fallback!'            =3D> \$email_git_fallback,
+        'git-chief-penguins!'      =3D> \$email_git_penguin_chiefs,
+        'git-min-signatures=3Di'     =3D> \$email_git_min_signatures,
+        'git-max-maintainers=3Di'    =3D> \$email_git_max_maintainers,
+        'git-min-percent=3Di'        =3D> \$email_git_min_percent,
+        'git-since=3Ds'              =3D> \$email_git_since,
+        'hg-since=3Ds'               =3D> \$email_hg_since,
+        'i|interactive!'           =3D> \$interactive,
+        'remove-duplicates!'       =3D> \$email_remove_duplicates,
+        'mailmap!'                 =3D> \$email_use_mailmap,
+        'm!'                       =3D> \$email_maintainer,
+        'r!'                       =3D> \$email_reviewer,
+        'n!'                       =3D> \$email_usename,
+        'l!'                       =3D> \$email_list,
+        'fixes!'                   =3D> \$email_fixes,
+        'moderated!'               =3D> \$email_moderated_list,
+        's!'                       =3D> \$email_subscriber_list,
+        'multiline!'               =3D> \$output_multiline,
+        'roles!'                   =3D> \$output_roles,
+        'rolestats!'               =3D> \$output_rolestats,
+        'separator=3Ds'              =3D> \$output_separator,
+        'subsystem!'               =3D> \$subsystem,
+        'status!'                  =3D> \$status,
+        'scm!'                     =3D> \$scm,
+        'tree!'                    =3D> \$tree,
+        'web!'                     =3D> \$web,
+        'letters=3Ds'                =3D> \$letters,
+        'pattern-depth=3Di'          =3D> \$pattern_depth,
+        'k|keywords!'              =3D> \$keywords,
+        'sections!'                =3D> \$sections,
+        'fe|file-emails!'          =3D> \$email_file_emails,
+        'f|file'                   =3D> \$from_filename,
+        'find-maintainer-files'    =3D> \$find_maintainer_files,
+        'mpath|maintainer-path=3Ds'  =3D> \$maintainer_path,
+        'self-test:s'              =3D> \$self_test,
+        'v|version'                =3D> \$version,
+        'h|help|usage'             =3D> \$help,
+    )
+    )
+{
     die "$P: invalid argument - use --help if necessary\n";
 }
=20
-if ($help !=3D 0) {
+if ( $help !=3D 0 ) {
     usage();
     exit 0;
 }
=20
-if ($version !=3D 0) {
+if ( $version !=3D 0 ) {
     print("${P} ${V}\n");
     exit 0;
 }
=20
-if (defined $self_test) {
+if ( defined $self_test ) {
     read_all_maintainer_files();
     self_test();
     exit 0;
 }
=20
-if (-t STDIN && !@ARGV) {
+if ( -t STDIN && !@ARGV ) {
+
     # We're talking to a terminal, but have no command line arguments.
     die "$P: missing patchfile or -f file - use --help if necessary\n";
 }
=20
-$output_multiline =3D 0 if ($output_separator ne ", ");
+$output_multiline =3D 0 if ( $output_separator ne ", " );
 $output_rolestats =3D 1 if ($interactive);
-$output_roles =3D 1 if ($output_rolestats);
-
-if ($sections || $letters ne "") {
-    $sections =3D 1;
-    $email =3D 0;
-    $email_list =3D 0;
-    $scm =3D 0;
-    $status =3D 0;
-    $subsystem =3D 0;
-    $web =3D 0;
-    $keywords =3D 0;
+$output_roles     =3D 1 if ($output_rolestats);
+
+if ( $sections || $letters ne "" ) {
+    $sections    =3D 1;
+    $email       =3D 0;
+    $email_list  =3D 0;
+    $scm         =3D 0;
+    $status      =3D 0;
+    $subsystem   =3D 0;
+    $web         =3D 0;
+    $keywords    =3D 0;
     $interactive =3D 0;
-} else {
+}
+else {
     my $selections =3D $email + $scm + $status + $subsystem + $web;
-    if ($selections =3D=3D 0) {
-	die "$P:  Missing required option: email, scm, status, subsystem or web\n=
";
+    if ( $selections =3D=3D 0 ) {
+        die "$P:  Missing required option: email, scm, status, subsystem o=
r web\n";
     }
 }
=20
-if ($email &&
-    ($email_maintainer + $email_reviewer +
-     $email_list + $email_subscriber_list +
-     $email_git + $email_git_penguin_chiefs + $email_git_blame) =3D=3D 0) =
{
+if ( $email
+    && ( $email_maintainer + $email_reviewer + $email_list + $email_subscr=
iber_list + $email_git + $email_git_penguin_chiefs + $email_git_blame ) =3D=
=3D 0 )
+{
     die "$P: Please select at least 1 email option\n";
 }
=20
-if ($tree && !top_of_kernel_tree($lk_path)) {
-    die "$P: The current directory does not appear to be "
-	. "a linux kernel source tree.\n";
+if ( $tree && !top_of_kernel_tree($lk_path) ) {
+    die "$P: The current directory does not appear to be " . "a linux kern=
el source tree.\n";
 }
=20
 ## Read MAINTAINERS for type/value pairs
=20
 my @typevalue =3D ();
 my %keyword_hash;
-my @mfiles =3D ();
+my @mfiles         =3D ();
 my @self_test_info =3D ();
=20
 sub read_maintainer_file {
     my ($file) =3D @_;
=20
-    open (my $maint, '<', "$file")
-	or die "$P: Can't open MAINTAINERS file '$file': $!\n";
+    open( my $maint, '<', "$file" )
+        or die "$P: Can't open MAINTAINERS file '$file': $!\n";
     my $i =3D 1;
     while (<$maint>) {
-	my $line =3D $_;
-	chomp $line;
-
-	if ($line =3D~ m/^([A-Z]):\s*(.*)/) {
-	    my $type =3D $1;
-	    my $value =3D $2;
-
-	    ##Filename pattern matching
-	    if ($type eq "F" || $type eq "X") {
-		$value =3D~ s@\.@\\\.@g;       ##Convert . to \.
-		$value =3D~ s/\*/\.\*/g;       ##Convert * to .*
-		$value =3D~ s/\?/\./g;         ##Convert ? to .
-		##if pattern is a directory and it lacks a trailing slash, add one
-		if ((-d $value)) {
-		    $value =3D~ s@([^/])$@$1/@;
-		}
-	    } elsif ($type eq "K") {
-		$keyword_hash{@typevalue} =3D $value;
-	    }
-	    push(@typevalue, "$type:$value");
-	} elsif (!(/^\s*$/ || /^\s*\#/)) {
-	    push(@typevalue, $line);
-	}
-	if (defined $self_test) {
-	    push(@self_test_info, {file=3D>$file, linenr=3D>$i, line=3D>$line});
-	}
-	$i++;
+        my $line =3D $_;
+        chomp $line;
+
+        if ( $line =3D~ m/^([A-Z]):\s*(.*)/ ) {
+            my $type  =3D $1;
+            my $value =3D $2;
+
+            ##Filename pattern matching
+            if ( $type eq "F" || $type eq "X" ) {
+                $value =3D~ s@\.@\\\.@g;    ##Convert . to \.
+                $value =3D~ s/\*/\.\*/g;    ##Convert * to .*
+                $value =3D~ s/\?/\./g;      ##Convert ? to .
+                ##if pattern is a directory and it lacks a trailing slash,=
 add one
+                if ( ( -d $value ) ) {
+                    $value =3D~ s@([^/])$@$1/@;
+                }
+            }
+            elsif ( $type eq "K" ) {
+                $keyword_hash{@typevalue} =3D $value;
+            }
+            push( @typevalue, "$type:$value" );
+        }
+        elsif ( !( /^\s*$/ || /^\s*\#/ ) ) {
+            push( @typevalue, $line );
+        }
+        if ( defined $self_test ) {
+            push( @self_test_info, { file =3D> $file, linenr =3D> $i, line=
 =3D> $line } );
+        }
+        $i++;
     }
     close($maint);
 }
=20
 sub find_is_maintainer_file {
     my ($file) =3D $_;
-    return if ($file !~ m@/MAINTAINERS$@);
+    return if ( $file !~ m@/MAINTAINERS$@ );
     $file =3D $File::Find::name;
-    return if (! -f $file);
-    push(@mfiles, $file);
+    return if ( !-f $file );
+    push( @mfiles, $file );
 }
=20
 sub find_ignore_git {
@@ -399,51 +368,58 @@ read_all_maintainer_files();
=20
 sub read_all_maintainer_files {
     my $path =3D "${lk_path}MAINTAINERS";
-    if (defined $maintainer_path) {
-	$path =3D $maintainer_path;
-	# Perl Cookbook tilde expansion if necessary
-	$path =3D~ s@^~([^/]*)@ $1 ? (getpwnam($1))[7] : ( $ENV{HOME} || $ENV{LOG=
DIR} || (getpwuid($<))[7])@ex;
-    }
-
-    if (-d $path) {
-	$path .=3D '/' if ($path !~ m@/$@);
-	if ($find_maintainer_files) {
-	    find( { wanted =3D> \&find_is_maintainer_file,
-		    preprocess =3D> \&find_ignore_git,
-		    no_chdir =3D> 1,
-		}, "$path");
-	} else {
-	    opendir(DIR, "$path") or die $!;
-	    my @files =3D readdir(DIR);
-	    closedir(DIR);
-	    foreach my $file (@files) {
-		push(@mfiles, "$path$file") if ($file !~ /^\./);
-	    }
-	}
-    } elsif (-f "$path") {
-	push(@mfiles, "$path");
-    } else {
-	die "$P: MAINTAINER file not found '$path'\n";
-    }
-    die "$P: No MAINTAINER files found in '$path'\n" if (scalar(@mfiles) =
=3D=3D 0);
+    if ( defined $maintainer_path ) {
+        $path =3D $maintainer_path;
+
+        # Perl Cookbook tilde expansion if necessary
+        $path =3D~ s@^~([^/]*)@ $1 ? (getpwnam($1))[7] : ( $ENV{HOME} || $=
ENV{LOGDIR} || (getpwuid($<))[7])@ex;
+    }
+
+    if ( -d $path ) {
+        $path .=3D '/' if ( $path !~ m@/$@ );
+        if ($find_maintainer_files) {
+            find(
+                {   wanted     =3D> \&find_is_maintainer_file,
+                    preprocess =3D> \&find_ignore_git,
+                    no_chdir   =3D> 1,
+                },
+                "$path"
+            );
+        }
+        else {
+            opendir( DIR, "$path" ) or die $!;
+            my @files =3D readdir(DIR);
+            closedir(DIR);
+            foreach my $file (@files) {
+                push( @mfiles, "$path$file" ) if ( $file !~ /^\./ );
+            }
+        }
+    }
+    elsif ( -f "$path" ) {
+        push( @mfiles, "$path" );
+    }
+    else {
+        die "$P: MAINTAINER file not found '$path'\n";
+    }
+    die "$P: No MAINTAINER files found in '$path'\n" if ( scalar(@mfiles) =
=3D=3D 0 );
     foreach my $file (@mfiles) {
-	read_maintainer_file("$file");
+        read_maintainer_file("$file");
     }
 }
=20
 sub maintainers_in_file {
     my ($file) =3D @_;
=20
-    return if ($file =3D~ m@\bMAINTAINERS$@);
+    return if ( $file =3D~ m@\bMAINTAINERS$@ );
=20
-    if (-f $file && ($email_file_emails || $file =3D~ /\.yaml$/)) {
-	open(my $f, '<', $file)
-	    or die "$P: Can't open $file: $!\n";
-	my $text =3D do { local($/) ; <$f> };
-	close($f);
+    if ( -f $file && ( $email_file_emails || $file =3D~ /\.yaml$/ ) ) {
+        open( my $f, '<', $file )
+            or die "$P: Can't open $file: $!\n";
+        my $text =3D do { local ($/); <$f> };
+        close($f);
=20
-	my @poss_addr =3D $text =3D~ m$[A-Za-z=C3=80-=C3=BF\"\' \,\.\+-]*\s*[\,]*=
\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0=
,1}$g;
-	push(@file_emails, clean_file_emails(@poss_addr));
+        my @poss_addr =3D $text =3D~ m$[A-Za-z=C3=80-=C3=BF\"\' \,\.\+-]*\=
s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)=
\>\}]{0,1}$g;
+        push( @file_emails, clean_file_emails(@poss_addr) );
     }
 }
=20
@@ -457,181 +433,188 @@ read_mailmap();
=20
 sub read_mailmap {
     $mailmap =3D {
-	names =3D> {},
-	addresses =3D> {}
+        names     =3D> {},
+        addresses =3D> {}
     };
=20
-    return if (!$email_use_mailmap || !(-f "${lk_path}.mailmap"));
+    return if ( !$email_use_mailmap || !( -f "${lk_path}.mailmap" ) );
=20
-    open(my $mailmap_file, '<', "${lk_path}.mailmap")
-	or warn "$P: Can't open .mailmap: $!\n";
+    open( my $mailmap_file, '<', "${lk_path}.mailmap" )
+        or warn "$P: Can't open .mailmap: $!\n";
=20
     while (<$mailmap_file>) {
-	s/#.*$//; #strip comments
-	s/^\s+|\s+$//g; #trim
-
-	next if (/^\s*$/); #skip empty lines
-	#entries have one of the following formats:
-	# name1 <mail1>
-	# <mail1> <mail2>
-	# name1 <mail1> <mail2>
-	# name1 <mail1> name2 <mail2>
-	# (see man git-shortlog)
-
-	if (/^([^<]+)<([^>]+)>$/) {
-	    my $real_name =3D $1;
-	    my $address =3D $2;
-
-	    $real_name =3D~ s/\s+$//;
-	    ($real_name, $address) =3D parse_email("$real_name <$address>");
-	    $mailmap->{names}->{$address} =3D $real_name;
-
-	} elsif (/^<([^>]+)>\s*<([^>]+)>$/) {
-	    my $real_address =3D $1;
-	    my $wrong_address =3D $2;
-
-	    $mailmap->{addresses}->{$wrong_address} =3D $real_address;
-
-	} elsif (/^(.+)<([^>]+)>\s*<([^>]+)>$/) {
-	    my $real_name =3D $1;
-	    my $real_address =3D $2;
-	    my $wrong_address =3D $3;
-
-	    $real_name =3D~ s/\s+$//;
-	    ($real_name, $real_address) =3D
-		parse_email("$real_name <$real_address>");
-	    $mailmap->{names}->{$wrong_address} =3D $real_name;
-	    $mailmap->{addresses}->{$wrong_address} =3D $real_address;
-
-	} elsif (/^(.+)<([^>]+)>\s*(.+)\s*<([^>]+)>$/) {
-	    my $real_name =3D $1;
-	    my $real_address =3D $2;
-	    my $wrong_name =3D $3;
-	    my $wrong_address =3D $4;
-
-	    $real_name =3D~ s/\s+$//;
-	    ($real_name, $real_address) =3D
-		parse_email("$real_name <$real_address>");
-
-	    $wrong_name =3D~ s/\s+$//;
-	    ($wrong_name, $wrong_address) =3D
-		parse_email("$wrong_name <$wrong_address>");
-
-	    my $wrong_email =3D format_email($wrong_name, $wrong_address, 1);
-	    $mailmap->{names}->{$wrong_email} =3D $real_name;
-	    $mailmap->{addresses}->{$wrong_email} =3D $real_address;
-	}
+        s/#.*$//;          #strip comments
+        s/^\s+|\s+$//g;    #trim
+
+        next if (/^\s*$/); #skip empty lines
+                           #entries have one of the following formats:
+                           # name1 <mail1>
+                           # <mail1> <mail2>
+                           # name1 <mail1> <mail2>
+                           # name1 <mail1> name2 <mail2>
+                           # (see man git-shortlog)
+
+        if (/^([^<]+)<([^>]+)>$/) {
+            my $real_name =3D $1;
+            my $address   =3D $2;
+
+            $real_name =3D~ s/\s+$//;
+            ( $real_name, $address ) =3D parse_email("$real_name <$address=
>");
+            $mailmap->{names}->{$address} =3D $real_name;
+
+        }
+        elsif (/^<([^>]+)>\s*<([^>]+)>$/) {
+            my $real_address  =3D $1;
+            my $wrong_address =3D $2;
+
+            $mailmap->{addresses}->{$wrong_address} =3D $real_address;
+
+        }
+        elsif (/^(.+)<([^>]+)>\s*<([^>]+)>$/) {
+            my $real_name     =3D $1;
+            my $real_address  =3D $2;
+            my $wrong_address =3D $3;
+
+            $real_name =3D~ s/\s+$//;
+            ( $real_name, $real_address ) =3D parse_email("$real_name <$re=
al_address>");
+            $mailmap->{names}->{$wrong_address}     =3D $real_name;
+            $mailmap->{addresses}->{$wrong_address} =3D $real_address;
+
+        }
+        elsif (/^(.+)<([^>]+)>\s*(.+)\s*<([^>]+)>$/) {
+            my $real_name     =3D $1;
+            my $real_address  =3D $2;
+            my $wrong_name    =3D $3;
+            my $wrong_address =3D $4;
+
+            $real_name =3D~ s/\s+$//;
+            ( $real_name, $real_address ) =3D parse_email("$real_name <$re=
al_address>");
+
+            $wrong_name =3D~ s/\s+$//;
+            ( $wrong_name, $wrong_address ) =3D parse_email("$wrong_name <=
$wrong_address>");
+
+            my $wrong_email =3D format_email( $wrong_name, $wrong_address,=
 1 );
+            $mailmap->{names}->{$wrong_email}     =3D $real_name;
+            $mailmap->{addresses}->{$wrong_email} =3D $real_address;
+        }
     }
     close($mailmap_file);
 }
=20
 ## use the filenames on the command line or find the filenames in the patc=
hfiles
=20
-if (!@ARGV) {
-    push(@ARGV, "&STDIN");
+if ( !@ARGV ) {
+    push( @ARGV, "&STDIN" );
 }
=20
 foreach my $file (@ARGV) {
-    if ($file ne "&STDIN") {
-	$file =3D canonpath($file);
-	##if $file is a directory and it lacks a trailing slash, add one
-	if ((-d $file)) {
-	    $file =3D~ s@([^/])$@$1/@;
-	} elsif (!(-f $file)) {
-	    die "$P: file '${file}' not found\n";
-	}
-    }
-    if ($from_filename && (vcs_exists() && !vcs_file_exists($file))) {
-	warn "$P: file '$file' not found in version control $!\n";
-    }
-    if ($from_filename || ($file ne "&STDIN" && vcs_file_exists($file))) {
-	$file =3D~ s/^\Q${cur_path}\E//;	#strip any absolute path
-	$file =3D~ s/^\Q${lk_path}\E//;	#or the path to the lk tree
-	push(@files, $file);
-	if ($file ne "MAINTAINERS" && -f $file && $keywords) {
-	    open(my $f, '<', $file)
-		or die "$P: Can't open $file: $!\n";
-	    my $text =3D do { local($/) ; <$f> };
-	    close($f);
-	    if ($keywords) {
-		foreach my $line (keys %keyword_hash) {
-		    if ($text =3D~ m/$keyword_hash{$line}/x) {
-			push(@keyword_tvi, $line);
-		    }
-		}
-	    }
-	}
-    } else {
-	my $file_cnt =3D @files;
-	my $lastfile;
-
-	open(my $patch, "< $file")
-	    or die "$P: Can't open $file: $!\n";
-
-	# We can check arbitrary information before the patch
-	# like the commit message, mail headers, etc...
-	# This allows us to match arbitrary keywords against any part
-	# of a git format-patch generated file (subject tags, etc...)
-
-	my $patch_prefix =3D "";			#Parsing the intro
-
-	while (<$patch>) {
-	    my $patch_line =3D $_;
-	    if (m/^ mode change [0-7]+ =3D> [0-7]+ (\S+)\s*$/) {
-		my $filename =3D $1;
-		push(@files, $filename);
-	    } elsif (m/^rename (?:from|to) (\S+)\s*$/) {
-		my $filename =3D $1;
-		push(@files, $filename);
-	    } elsif (m/^diff --git a\/(\S+) b\/(\S+)\s*$/) {
-		my $filename1 =3D $1;
-		my $filename2 =3D $2;
-		push(@files, $filename1);
-		push(@files, $filename2);
-	    } elsif (m/^Fixes:\s+([0-9a-fA-F]{6,40})/) {
-		push(@fixes, $1) if ($email_fixes);
-	    } elsif (m/^\+\+\+\s+(\S+)/ or m/^---\s+(\S+)/) {
-		my $filename =3D $1;
-		$filename =3D~ s@^[^/]*/@@;
-		$filename =3D~ s@\n@@;
-		$lastfile =3D $filename;
-		push(@files, $filename);
-		$patch_prefix =3D "^[+-].*";	#Now parsing the actual patch
-	    } elsif (m/^\@\@ -(\d+),(\d+)/) {
-		if ($email_git_blame) {
-		    push(@range, "$lastfile:$1:$2");
-		}
-	    } elsif ($keywords) {
-		foreach my $line (keys %keyword_hash) {
-		    if ($patch_line =3D~ m/${patch_prefix}$keyword_hash{$line}/x) {
-			push(@keyword_tvi, $line);
-		    }
-		}
-	    }
-	}
-	close($patch);
-
-	if ($file_cnt =3D=3D @files) {
-	    warn "$P: file '${file}' doesn't appear to be a patch.  "
-		. "Add -f to options?\n";
-	}
-	@files =3D sort_and_uniq(@files);
+    if ( $file ne "&STDIN" ) {
+        $file =3D canonpath($file);
+        ##if $file is a directory and it lacks a trailing slash, add one
+        if ( ( -d $file ) ) {
+            $file =3D~ s@([^/])$@$1/@;
+        }
+        elsif ( !( -f $file ) ) {
+            die "$P: file '${file}' not found\n";
+        }
+    }
+    if ( $from_filename && ( vcs_exists() && !vcs_file_exists($file) ) ) {
+        warn "$P: file '$file' not found in version control $!\n";
+    }
+    if ( $from_filename || ( $file ne "&STDIN" && vcs_file_exists($file) )=
 ) {
+        $file =3D~ s/^\Q${cur_path}\E//;    #strip any absolute path
+        $file =3D~ s/^\Q${lk_path}\E//;     #or the path to the lk tree
+        push( @files, $file );
+        if ( $file ne "MAINTAINERS" && -f $file && $keywords ) {
+            open( my $f, '<', $file )
+                or die "$P: Can't open $file: $!\n";
+            my $text =3D do { local ($/); <$f> };
+            close($f);
+            if ($keywords) {
+                foreach my $line ( keys %keyword_hash ) {
+                    if ( $text =3D~ m/$keyword_hash{$line}/x ) {
+                        push( @keyword_tvi, $line );
+                    }
+                }
+            }
+        }
+    }
+    else {
+        my $file_cnt =3D @files;
+        my $lastfile;
+
+        open( my $patch, "< $file" )
+            or die "$P: Can't open $file: $!\n";
+
+        # We can check arbitrary information before the patch
+        # like the commit message, mail headers, etc...
+        # This allows us to match arbitrary keywords against any part
+        # of a git format-patch generated file (subject tags, etc...)
+
+        my $patch_prefix =3D "";    #Parsing the intro
+
+        while (<$patch>) {
+            my $patch_line =3D $_;
+            if (m/^ mode change [0-7]+ =3D> [0-7]+ (\S+)\s*$/) {
+                my $filename =3D $1;
+                push( @files, $filename );
+            }
+            elsif (m/^rename (?:from|to) (\S+)\s*$/) {
+                my $filename =3D $1;
+                push( @files, $filename );
+            }
+            elsif (m/^diff --git a\/(\S+) b\/(\S+)\s*$/) {
+                my $filename1 =3D $1;
+                my $filename2 =3D $2;
+                push( @files, $filename1 );
+                push( @files, $filename2 );
+            }
+            elsif (m/^Fixes:\s+([0-9a-fA-F]{6,40})/) {
+                push( @fixes, $1 ) if ($email_fixes);
+            }
+            elsif ( m/^\+\+\+\s+(\S+)/ or m/^---\s+(\S+)/ ) {
+                my $filename =3D $1;
+                $filename =3D~ s@^[^/]*/@@;
+                $filename =3D~ s@\n@@;
+                $lastfile =3D $filename;
+                push( @files, $filename );
+                $patch_prefix =3D "^[+-].*";    #Now parsing the actual pa=
tch
+            }
+            elsif (m/^\@\@ -(\d+),(\d+)/) {
+                if ($email_git_blame) {
+                    push( @range, "$lastfile:$1:$2" );
+                }
+            }
+            elsif ($keywords) {
+                foreach my $line ( keys %keyword_hash ) {
+                    if ( $patch_line =3D~ m/${patch_prefix}$keyword_hash{$=
line}/x ) {
+                        push( @keyword_tvi, $line );
+                    }
+                }
+            }
+        }
+        close($patch);
+
+        if ( $file_cnt =3D=3D @files ) {
+            warn "$P: file '${file}' doesn't appear to be a patch.  " . "A=
dd -f to options?\n";
+        }
+        @files =3D sort_and_uniq(@files);
     }
 }
=20
 @file_emails =3D uniq(@file_emails);
-@fixes =3D uniq(@fixes);
+@fixes       =3D uniq(@fixes);
=20
 my %email_hash_name;
 my %email_hash_address;
 my @email_to =3D ();
 my %hash_list_to;
-my @list_to =3D ();
-my @scm =3D ();
-my @web =3D ();
-my @subsystem =3D ();
-my @status =3D ();
-my %deduplicate_name_hash =3D ();
+my @list_to                  =3D ();
+my @scm                      =3D ();
+my @web                      =3D ();
+my @subsystem                =3D ();
+my @status                   =3D ();
+my %deduplicate_name_hash    =3D ();
 my %deduplicate_address_hash =3D ();
=20
 my @maintainers =3D get_maintainers();
@@ -663,131 +646,148 @@ if ($web) {
 exit($exit);
=20
 sub self_test {
-    my @lsfiles =3D ();
-    my @good_links =3D ();
-    my @bad_links =3D ();
+    my @lsfiles         =3D ();
+    my @good_links      =3D ();
+    my @bad_links       =3D ();
     my @section_headers =3D ();
-    my $index =3D 0;
+    my $index           =3D 0;
=20
     @lsfiles =3D vcs_list_files($lk_path);
=20
     for my $x (@self_test_info) {
-	$index++;
-
-	## Section header duplication and missing section content
-	if (($self_test eq "" || $self_test =3D~ /\bsections\b/) &&
-	    $x->{line} =3D~ /^\S[^:]/ &&
-	    defined $self_test_info[$index] &&
-	    $self_test_info[$index]->{line} =3D~ /^([A-Z]):\s*\S/) {
-	    my $has_S =3D 0;
-	    my $has_F =3D 0;
-	    my $has_ML =3D 0;
-	    my $status =3D "";
-	    if (grep(m@^\Q$x->{line}\E@, @section_headers)) {
-		print("$x->{file}:$x->{linenr}: warning: duplicate section header\t$x->{=
line}\n");
-	    } else {
-		push(@section_headers, $x->{line});
-	    }
-	    my $nextline =3D $index;
-	    while (defined $self_test_info[$nextline] &&
-		   $self_test_info[$nextline]->{line} =3D~ /^([A-Z]):\s*(\S.*)/) {
-		my $type =3D $1;
-		my $value =3D $2;
-		if ($type eq "S") {
-		    $has_S =3D 1;
-		    $status =3D $value;
-		} elsif ($type eq "F" || $type eq "N") {
-		    $has_F =3D 1;
-		} elsif ($type eq "M" || $type eq "R" || $type eq "L") {
-		    $has_ML =3D 1;
-		}
-		$nextline++;
-	    }
-	    if (!$has_ML && $status !~ /orphan|obsolete/i) {
-		print("$x->{file}:$x->{linenr}: warning: section without email address\t=
$x->{line}\n");
-	    }
-	    if (!$has_S) {
-		print("$x->{file}:$x->{linenr}: warning: section without status \t$x->{l=
ine}\n");
-	    }
-	    if (!$has_F) {
-		print("$x->{file}:$x->{linenr}: warning: section without file pattern\t$=
x->{line}\n");
-	    }
-	}
-
-	next if ($x->{line} !~ /^([A-Z]):\s*(.*)/);
-
-	my $type =3D $1;
-	my $value =3D $2;
-
-	## Filename pattern matching
-	if (($type eq "F" || $type eq "X") &&
-	    ($self_test eq "" || $self_test =3D~ /\bpatterns\b/)) {
-	    $value =3D~ s@\.@\\\.@g;       ##Convert . to \.
-	    $value =3D~ s/\*/\.\*/g;       ##Convert * to .*
-	    $value =3D~ s/\?/\./g;         ##Convert ? to .
-	    ##if pattern is a directory and it lacks a trailing slash, add one
-	    if ((-d $value)) {
-		$value =3D~ s@([^/])$@$1/@;
-	    }
-	    if (!grep(m@^$value@, @lsfiles)) {
-		print("$x->{file}:$x->{linenr}: warning: no file matches\t$x->{line}\n")=
;
-	    }
-
-	## Link reachability
-	} elsif (($type eq "W" || $type eq "Q" || $type eq "B") &&
-		 $value =3D~ /^https?:/ &&
-		 ($self_test eq "" || $self_test =3D~ /\blinks\b/)) {
-	    next if (grep(m@^\Q$value\E$@, @good_links));
-	    my $isbad =3D 0;
-	    if (grep(m@^\Q$value\E$@, @bad_links)) {
-	        $isbad =3D 1;
-	    } else {
-		my $output =3D `wget --spider -q --no-check-certificate --timeout 10 --t=
ries 1 $value`;
-		if ($? =3D=3D 0) {
-		    push(@good_links, $value);
-		} else {
-		    push(@bad_links, $value);
-		    $isbad =3D 1;
-		}
-	    }
-	    if ($isbad) {
-	        print("$x->{file}:$x->{linenr}: warning: possible bad link\t$x->{=
line}\n");
-	    }
-
-	## SCM reachability
-	} elsif ($type eq "T" &&
-		 ($self_test eq "" || $self_test =3D~ /\bscm\b/)) {
-	    next if (grep(m@^\Q$value\E$@, @good_links));
-	    my $isbad =3D 0;
-	    if (grep(m@^\Q$value\E$@, @bad_links)) {
-	        $isbad =3D 1;
-            } elsif ($value !~ /^(?:git|quilt|hg)\s+\S/) {
-		print("$x->{file}:$x->{linenr}: warning: malformed entry\t$x->{line}\n")=
;
-	    } elsif ($value =3D~ /^git\s+(\S+)(\s+([^\(]+\S+))?/) {
-		my $url =3D $1;
-		my $branch =3D "";
-		$branch =3D $3 if $3;
-		my $output =3D `git ls-remote --exit-code -h "$url" $branch > /dev/null =
2>&1`;
-		if ($? =3D=3D 0) {
-		    push(@good_links, $value);
-		} else {
-		    push(@bad_links, $value);
-		    $isbad =3D 1;
-		}
-	    } elsif ($value =3D~ /^(?:quilt|hg)\s+(https?:\S+)/) {
-		my $url =3D $1;
-		my $output =3D `wget --spider -q --no-check-certificate --timeout 10 --t=
ries 1 $url`;
-		if ($? =3D=3D 0) {
-		    push(@good_links, $value);
-		} else {
-		    push(@bad_links, $value);
-		    $isbad =3D 1;
-		}
-	    }
-	    if ($isbad) {
-		print("$x->{file}:$x->{linenr}: warning: possible bad link\t$x->{line}\n=
");
-	    }
-	}
+        $index++;
+
+        ## Section header duplication and missing section content
+        if (   ( $self_test eq "" || $self_test =3D~ /\bsections\b/ )
+            && $x->{line} =3D~ /^\S[^:]/
+            && defined $self_test_info[$index]
+            && $self_test_info[$index]->{line} =3D~ /^([A-Z]):\s*\S/ )
+        {
+            my $has_S  =3D 0;
+            my $has_F  =3D 0;
+            my $has_ML =3D 0;
+            my $status =3D "";
+            if ( grep( m@^\Q$x->{line}\E@, @section_headers ) ) {
+                print("$x->{file}:$x->{linenr}: warning: duplicate section=
 header\t$x->{line}\n");
+            }
+            else {
+                push( @section_headers, $x->{line} );
+            }
+            my $nextline =3D $index;
+            while ( defined $self_test_info[$nextline]
+                && $self_test_info[$nextline]->{line} =3D~ /^([A-Z]):\s*(\=
S.*)/ )
+            {
+                my $type  =3D $1;
+                my $value =3D $2;
+                if ( $type eq "S" ) {
+                    $has_S  =3D 1;
+                    $status =3D $value;
+                }
+                elsif ( $type eq "F" || $type eq "N" ) {
+                    $has_F =3D 1;
+                }
+                elsif ( $type eq "M" || $type eq "R" || $type eq "L" ) {
+                    $has_ML =3D 1;
+                }
+                $nextline++;
+            }
+            if ( !$has_ML && $status !~ /orphan|obsolete/i ) {
+                print("$x->{file}:$x->{linenr}: warning: section without e=
mail address\t$x->{line}\n");
+            }
+            if ( !$has_S ) {
+                print("$x->{file}:$x->{linenr}: warning: section without s=
tatus \t$x->{line}\n");
+            }
+            if ( !$has_F ) {
+                print("$x->{file}:$x->{linenr}: warning: section without f=
ile pattern\t$x->{line}\n");
+            }
+        }
+
+        next if ( $x->{line} !~ /^([A-Z]):\s*(.*)/ );
+
+        my $type  =3D $1;
+        my $value =3D $2;
+
+        ## Filename pattern matching
+        if (   ( $type eq "F" || $type eq "X" )
+            && ( $self_test eq "" || $self_test =3D~ /\bpatterns\b/ ) )
+        {
+            $value =3D~ s@\.@\\\.@g;    ##Convert . to \.
+            $value =3D~ s/\*/\.\*/g;    ##Convert * to .*
+            $value =3D~ s/\?/\./g;      ##Convert ? to .
+            ##if pattern is a directory and it lacks a trailing slash, add=
 one
+            if ( ( -d $value ) ) {
+                $value =3D~ s@([^/])$@$1/@;
+            }
+            if ( !grep( m@^$value@, @lsfiles ) ) {
+                print("$x->{file}:$x->{linenr}: warning: no file matches\t=
$x->{line}\n");
+            }
+
+            ## Link reachability
+        }
+        elsif (( $type eq "W" || $type eq "Q" || $type eq "B" )
+            && $value =3D~ /^https?:/
+            && ( $self_test eq "" || $self_test =3D~ /\blinks\b/ ) )
+        {
+            next if ( grep( m@^\Q$value\E$@, @good_links ) );
+            my $isbad =3D 0;
+            if ( grep( m@^\Q$value\E$@, @bad_links ) ) {
+                $isbad =3D 1;
+            }
+            else {
+                my $output =3D `wget --spider -q --no-check-certificate --=
timeout 10 --tries 1 $value`;
+                if ( $? =3D=3D 0 ) {
+                    push( @good_links, $value );
+                }
+                else {
+                    push( @bad_links, $value );
+                    $isbad =3D 1;
+                }
+            }
+            if ($isbad) {
+                print("$x->{file}:$x->{linenr}: warning: possible bad link=
\t$x->{line}\n");
+            }
+
+            ## SCM reachability
+        }
+        elsif ( $type eq "T"
+            && ( $self_test eq "" || $self_test =3D~ /\bscm\b/ ) )
+        {
+            next if ( grep( m@^\Q$value\E$@, @good_links ) );
+            my $isbad =3D 0;
+            if ( grep( m@^\Q$value\E$@, @bad_links ) ) {
+                $isbad =3D 1;
+            }
+            elsif ( $value !~ /^(?:git|quilt|hg)\s+\S/ ) {
+                print("$x->{file}:$x->{linenr}: warning: malformed entry\t=
$x->{line}\n");
+            }
+            elsif ( $value =3D~ /^git\s+(\S+)(\s+([^\(]+\S+))?/ ) {
+                my $url    =3D $1;
+                my $branch =3D "";
+                $branch =3D $3 if $3;
+                my $output =3D `git ls-remote --exit-code -h "$url" $branc=
h > /dev/null 2>&1`;
+                if ( $? =3D=3D 0 ) {
+                    push( @good_links, $value );
+                }
+                else {
+                    push( @bad_links, $value );
+                    $isbad =3D 1;
+                }
+            }
+            elsif ( $value =3D~ /^(?:quilt|hg)\s+(https?:\S+)/ ) {
+                my $url    =3D $1;
+                my $output =3D `wget --spider -q --no-check-certificate --=
timeout 10 --tries 1 $url`;
+                if ( $? =3D=3D 0 ) {
+                    push( @good_links, $value );
+                }
+                else {
+                    push( @bad_links, $value );
+                    $isbad =3D 1;
+                }
+            }
+            if ($isbad) {
+                print("$x->{file}:$x->{linenr}: warning: possible bad link=
\t$x->{line}\n");
+            }
+        }
     }
 }
=20
@@ -795,64 +795,66 @@ sub ignore_email_address {
     my ($address) =3D @_;
=20
     foreach my $ignore (@ignore_emails) {
-	return 1 if ($ignore eq $address);
+        return 1 if ( $ignore eq $address );
     }
=20
     return 0;
 }
=20
 sub range_is_maintained {
-    my ($start, $end) =3D @_;
-
-    for (my $i =3D $start; $i < $end; $i++) {
-	my $line =3D $typevalue[$i];
-	if ($line =3D~ m/^([A-Z]):\s*(.*)/) {
-	    my $type =3D $1;
-	    my $value =3D $2;
-	    if ($type eq 'S') {
-		if ($value =3D~ /(maintain|support)/i) {
-		    return 1;
-		}
-	    }
-	}
+    my ( $start, $end ) =3D @_;
+
+    for ( my $i =3D $start; $i < $end; $i++ ) {
+        my $line =3D $typevalue[$i];
+        if ( $line =3D~ m/^([A-Z]):\s*(.*)/ ) {
+            my $type  =3D $1;
+            my $value =3D $2;
+            if ( $type eq 'S' ) {
+                if ( $value =3D~ /(maintain|support)/i ) {
+                    return 1;
+                }
+            }
+        }
     }
     return 0;
 }
=20
 sub range_has_maintainer {
-    my ($start, $end) =3D @_;
-
-    for (my $i =3D $start; $i < $end; $i++) {
-	my $line =3D $typevalue[$i];
-	if ($line =3D~ m/^([A-Z]):\s*(.*)/) {
-	    my $type =3D $1;
-	    my $value =3D $2;
-	    if ($type eq 'M') {
-		return 1;
-	    }
-	}
+    my ( $start, $end ) =3D @_;
+
+    for ( my $i =3D $start; $i < $end; $i++ ) {
+        my $line =3D $typevalue[$i];
+        if ( $line =3D~ m/^([A-Z]):\s*(.*)/ ) {
+            my $type  =3D $1;
+            my $value =3D $2;
+            if ( $type eq 'M' ) {
+                return 1;
+            }
+        }
     }
     return 0;
 }
=20
 sub get_maintainers {
-    %email_hash_name =3D ();
-    %email_hash_address =3D ();
-    %commit_author_hash =3D ();
-    %commit_signer_hash =3D ();
-    @email_to =3D ();
-    %hash_list_to =3D ();
-    @list_to =3D ();
-    @scm =3D ();
-    @web =3D ();
-    @subsystem =3D ();
-    @status =3D ();
-    %deduplicate_name_hash =3D ();
+    %email_hash_name          =3D ();
+    %email_hash_address       =3D ();
+    %commit_author_hash       =3D ();
+    %commit_signer_hash       =3D ();
+    @email_to                 =3D ();
+    %hash_list_to             =3D ();
+    @list_to                  =3D ();
+    @scm                      =3D ();
+    @web                      =3D ();
+    @subsystem                =3D ();
+    @status                   =3D ();
+    %deduplicate_name_hash    =3D ();
     %deduplicate_address_hash =3D ();
+
     if ($email_git_all_signature_types) {
-	$signature_pattern =3D "(.+?)[Bb][Yy]:";
-    } else {
-	$signature_pattern =3D "\(" . join("|", @signature_tags) . "\)";
+        $signature_pattern =3D "(.+?)[Bb][Yy]:";
+    }
+    else {
+        $signature_pattern =3D "\(" . join( "|", @signature_tags ) . "\)";
     }
=20
     # Find responsible parties
@@ -861,172 +863,180 @@ sub get_maintainers {
=20
     foreach my $file (@files) {
=20
-	my %hash;
-	my $tvi =3D find_first_section();
-	while ($tvi < @typevalue) {
-	    my $start =3D find_starting_index($tvi);
-	    my $end =3D find_ending_index($tvi);
-	    my $exclude =3D 0;
-	    my $i;
-
-	    #Do not match excluded file patterns
-
-	    for ($i =3D $start; $i < $end; $i++) {
-		my $line =3D $typevalue[$i];
-		if ($line =3D~ m/^([A-Z]):\s*(.*)/) {
-		    my $type =3D $1;
-		    my $value =3D $2;
-		    if ($type eq 'X') {
-			if (file_match_pattern($file, $value)) {
-			    $exclude =3D 1;
-			    last;
-			}
-		    }
-		}
-	    }
-
-	    if (!$exclude) {
-		for ($i =3D $start; $i < $end; $i++) {
-		    my $line =3D $typevalue[$i];
-		    if ($line =3D~ m/^([A-Z]):\s*(.*)/) {
-			my $type =3D $1;
-			my $value =3D $2;
-			if ($type eq 'F') {
-			    if (file_match_pattern($file, $value)) {
-				my $value_pd =3D ($value =3D~ tr@/@@);
-				my $file_pd =3D ($file  =3D~ tr@/@@);
-				$value_pd++ if (substr($value,-1,1) ne "/");
-				$value_pd =3D -1 if ($value =3D~ /^\.\*/);
-				if ($value_pd >=3D $file_pd &&
-				    range_is_maintained($start, $end) &&
-				    range_has_maintainer($start, $end)) {
-				    $exact_pattern_match_hash{$file} =3D 1;
-				}
-				if ($pattern_depth =3D=3D 0 ||
-				    (($file_pd - $value_pd) < $pattern_depth)) {
-				    $hash{$tvi} =3D $value_pd;
-				}
-			    }
-			} elsif ($type eq 'N') {
-			    if ($file =3D~ m/$value/x) {
-				$hash{$tvi} =3D 0;
-			    }
-			}
-		    }
-		}
-	    }
-	    $tvi =3D $end + 1;
-	}
-
-	foreach my $line (sort {$hash{$b} <=3D> $hash{$a}} keys %hash) {
-	    add_categories($line);
-	    if ($sections) {
-		my $i;
-		my $start =3D find_starting_index($line);
-		my $end =3D find_ending_index($line);
-		for ($i =3D $start; $i < $end; $i++) {
-		    my $line =3D $typevalue[$i];
-		    if ($line =3D~ /^[FX]:/) {		##Restore file patterns
-			$line =3D~ s/([^\\])\.([^\*])/$1\?$2/g;
-			$line =3D~ s/([^\\])\.$/$1\?/g;	##Convert . back to ?
-			$line =3D~ s/\\\./\./g;       	##Convert \. to .
-			$line =3D~ s/\.\*/\*/g;       	##Convert .* to *
-		    }
-		    my $count =3D $line =3D~ s/^([A-Z]):/$1:\t/g;
-		    if ($letters eq "" || (!$count || $letters =3D~ /$1/i)) {
-			print("$line\n");
-		    }
-		}
-		print("\n");
-	    }
-	}
-
-	maintainers_in_file($file);
+        my %hash;
+        my $tvi =3D find_first_section();
+        while ( $tvi < @typevalue ) {
+            my $start   =3D find_starting_index($tvi);
+            my $end     =3D find_ending_index($tvi);
+            my $exclude =3D 0;
+            my $i;
+
+            #Do not match excluded file patterns
+
+            for ( $i =3D $start; $i < $end; $i++ ) {
+                my $line =3D $typevalue[$i];
+                if ( $line =3D~ m/^([A-Z]):\s*(.*)/ ) {
+                    my $type  =3D $1;
+                    my $value =3D $2;
+                    if ( $type eq 'X' ) {
+                        if ( file_match_pattern( $file, $value ) ) {
+                            $exclude =3D 1;
+                            last;
+                        }
+                    }
+                }
+            }
+
+            if ( !$exclude ) {
+                for ( $i =3D $start; $i < $end; $i++ ) {
+                    my $line =3D $typevalue[$i];
+                    if ( $line =3D~ m/^([A-Z]):\s*(.*)/ ) {
+                        my $type  =3D $1;
+                        my $value =3D $2;
+                        if ( $type eq 'F' ) {
+                            if ( file_match_pattern( $file, $value ) ) {
+                                my $value_pd =3D ( $value =3D~ tr@/@@ );
+                                my $file_pd  =3D ( $file  =3D~ tr@/@@ );
+                                $value_pd++    if ( substr( $value, -1, 1 =
) ne "/" );
+                                $value_pd =3D -1 if ( $value =3D~ /^\.\*/ =
);
+                                if (   $value_pd >=3D $file_pd
+                                    && range_is_maintained( $start, $end )
+                                    && range_has_maintainer( $start, $end =
) )
+                                {
+                                    $exact_pattern_match_hash{$file} =3D 1=
;
+                                }
+                                if ( $pattern_depth =3D=3D 0
+                                    || ( ( $file_pd - $value_pd ) < $patte=
rn_depth ) )
+                                {
+                                    $hash{$tvi} =3D $value_pd;
+                                }
+                            }
+                        }
+                        elsif ( $type eq 'N' ) {
+                            if ( $file =3D~ m/$value/x ) {
+                                $hash{$tvi} =3D 0;
+                            }
+                        }
+                    }
+                }
+            }
+            $tvi =3D $end + 1;
+        }
+
+        foreach my $line ( sort { $hash{$b} <=3D> $hash{$a} } keys %hash )=
 {
+            add_categories($line);
+            if ($sections) {
+                my $i;
+                my $start =3D find_starting_index($line);
+                my $end   =3D find_ending_index($line);
+                for ( $i =3D $start; $i < $end; $i++ ) {
+                    my $line =3D $typevalue[$i];
+                    if ( $line =3D~ /^[FX]:/ ) {    ##Restore file pattern=
s
+                        $line =3D~ s/([^\\])\.([^\*])/$1\?$2/g;
+                        $line =3D~ s/([^\\])\.$/$1\?/g;           ##Conver=
t . back to ?
+                        $line =3D~ s/\\\./\./g;                   ##Conver=
t \. to .
+                        $line =3D~ s/\.\*/\*/g;                   ##Conver=
t .* to *
+                    }
+                    my $count =3D $line =3D~ s/^([A-Z]):/$1:\t/g;
+                    if ( $letters eq "" || ( !$count || $letters =3D~ /$1/=
i ) ) {
+                        print("$line\n");
+                    }
+                }
+                print("\n");
+            }
+        }
+
+        maintainers_in_file($file);
     }
=20
     if ($keywords) {
-	@keyword_tvi =3D sort_and_uniq(@keyword_tvi);
-	foreach my $line (@keyword_tvi) {
-	    add_categories($line);
-	}
+        @keyword_tvi =3D sort_and_uniq(@keyword_tvi);
+        foreach my $line (@keyword_tvi) {
+            add_categories($line);
+        }
     }
=20
-    foreach my $email (@email_to, @list_to) {
-	$email->[0] =3D deduplicate_email($email->[0]);
+    foreach my $email ( @email_to, @list_to ) {
+        $email->[0] =3D deduplicate_email( $email->[0] );
     }
=20
     foreach my $file (@files) {
-	if ($email &&
-	    ($email_git ||
-	     ($email_git_fallback &&
-	      $file !~ /MAINTAINERS$/ &&
-	      !$exact_pattern_match_hash{$file}))) {
-	    vcs_file_signoffs($file);
-	}
-	if ($email && $email_git_blame) {
-	    vcs_file_blame($file);
-	}
+        if ($email
+            && ($email_git
+                || (   $email_git_fallback
+                    && $file !~ /MAINTAINERS$/
+                    && !$exact_pattern_match_hash{$file} )
+            )
+            )
+        {
+            vcs_file_signoffs($file);
+        }
+        if ( $email && $email_git_blame ) {
+            vcs_file_blame($file);
+        }
     }
=20
     if ($email) {
-	foreach my $chief (@penguin_chief) {
-	    if ($chief =3D~ m/^(.*):(.*)/) {
-		my $email_address;
-
-		$email_address =3D format_email($1, $2, $email_usename);
-		if ($email_git_penguin_chiefs) {
-		    push(@email_to, [$email_address, 'chief penguin']);
-		} else {
-		    @email_to =3D grep($_->[0] !~ /${email_address}/, @email_to);
-		}
-	    }
-	}
+        foreach my $chief (@penguin_chief) {
+            if ( $chief =3D~ m/^(.*):(.*)/ ) {
+                my $email_address;
+
+                $email_address =3D format_email( $1, $2, $email_usename );
+                if ($email_git_penguin_chiefs) {
+                    push( @email_to, [ $email_address, 'chief penguin' ] )=
;
+                }
+                else {
+                    @email_to =3D grep( $_->[0] !~ /${email_address}/, @em=
ail_to );
+                }
+            }
+        }
=20
-	foreach my $email (@file_emails) {
-	    $email =3D mailmap_email($email);
-	    my ($name, $address) =3D parse_email($email);
+        foreach my $email (@file_emails) {
+            $email =3D mailmap_email($email);
+            my ( $name, $address ) =3D parse_email($email);
=20
-	    my $tmp_email =3D format_email($name, $address, $email_usename);
-	    push_email_address($tmp_email, '');
-	    add_role($tmp_email, 'in file');
-	}
+            my $tmp_email =3D format_email( $name, $address, $email_usenam=
e );
+            push_email_address( $tmp_email, '' );
+            add_role( $tmp_email, 'in file' );
+        }
     }
=20
     foreach my $fix (@fixes) {
-	vcs_add_commit_signers($fix, "blamed_fixes");
+        vcs_add_commit_signers( $fix, "blamed_fixes" );
     }
=20
     my @to =3D ();
-    if ($email || $email_list) {
-	if ($email) {
-	    @to =3D (@to, @email_to);
-	}
-	if ($email_list) {
-	    @to =3D (@to, @list_to);
-	}
+    if ( $email || $email_list ) {
+        if ($email) {
+            @to =3D ( @to, @email_to );
+        }
+        if ($email_list) {
+            @to =3D ( @to, @list_to );
+        }
     }
=20
     if ($interactive) {
-	@to =3D interactive_get_maintainers(\@to);
+        @to =3D interactive_get_maintainers( \@to );
     }
=20
     return @to;
 }
=20
 sub file_match_pattern {
-    my ($file, $pattern) =3D @_;
-    if (substr($pattern, -1) eq "/") {
-	if ($file =3D~ m@^$pattern@) {
-	    return 1;
-	}
-    } else {
-	if ($file =3D~ m@^$pattern@) {
-	    my $s1 =3D ($file =3D~ tr@/@@);
-	    my $s2 =3D ($pattern =3D~ tr@/@@);
-	    if ($s1 =3D=3D $s2) {
-		return 1;
-	    }
-	}
+    my ( $file, $pattern ) =3D @_;
+    if ( substr( $pattern, -1 ) eq "/" ) {
+        if ( $file =3D~ m@^$pattern@ ) {
+            return 1;
+        }
+    }
+    else {
+        if ( $file =3D~ m@^$pattern@ ) {
+            my $s1 =3D ( $file    =3D~ tr@/@@ );
+            my $s2 =3D ( $pattern =3D~ tr@/@@ );
+            if ( $s1 =3D=3D $s2 ) {
+                return 1;
+            }
+        }
     }
     return 0;
 }
@@ -1126,26 +1136,27 @@ EOT
 sub top_of_kernel_tree {
     my ($lk_path) =3D @_;
=20
-    if ($lk_path ne "" && substr($lk_path,length($lk_path)-1,1) ne "/") {
-	$lk_path .=3D "/";
-    }
-    if (   (-f "${lk_path}COPYING")
-	&& (-f "${lk_path}CREDITS")
-	&& (-f "${lk_path}Kbuild")
-	&& (-e "${lk_path}MAINTAINERS")
-	&& (-f "${lk_path}Makefile")
-	&& (-f "${lk_path}README")
-	&& (-d "${lk_path}Documentation")
-	&& (-d "${lk_path}arch")
-	&& (-d "${lk_path}include")
-	&& (-d "${lk_path}drivers")
-	&& (-d "${lk_path}fs")
-	&& (-d "${lk_path}init")
-	&& (-d "${lk_path}ipc")
-	&& (-d "${lk_path}kernel")
-	&& (-d "${lk_path}lib")
-	&& (-d "${lk_path}scripts")) {
-	return 1;
+    if ( $lk_path ne "" && substr( $lk_path, length($lk_path) - 1, 1 ) ne =
"/" ) {
+        $lk_path .=3D "/";
+    }
+    if (   ( -f "${lk_path}COPYING" )
+        && ( -f "${lk_path}CREDITS" )
+        && ( -f "${lk_path}Kbuild" )
+        && ( -e "${lk_path}MAINTAINERS" )
+        && ( -f "${lk_path}Makefile" )
+        && ( -f "${lk_path}README" )
+        && ( -d "${lk_path}Documentation" )
+        && ( -d "${lk_path}arch" )
+        && ( -d "${lk_path}include" )
+        && ( -d "${lk_path}drivers" )
+        && ( -d "${lk_path}fs" )
+        && ( -d "${lk_path}init" )
+        && ( -d "${lk_path}ipc" )
+        && ( -d "${lk_path}kernel" )
+        && ( -d "${lk_path}lib" )
+        && ( -d "${lk_path}scripts" ) )
+    {
+        return 1;
     }
     return 0;
 }
@@ -1153,52 +1164,56 @@ sub top_of_kernel_tree {
 sub parse_email {
     my ($formatted_email) =3D @_;
=20
-    my $name =3D "";
+    my $name    =3D "";
     my $address =3D "";
=20
-    if ($formatted_email =3D~ /^([^<]+)<(.+\@.*)>.*$/) {
-	$name =3D $1;
-	$address =3D $2;
-    } elsif ($formatted_email =3D~ /^\s*<(.+\@\S*)>.*$/) {
-	$address =3D $1;
-    } elsif ($formatted_email =3D~ /^(.+\@\S*).*$/) {
-	$address =3D $1;
+    if ( $formatted_email =3D~ /^([^<]+)<(.+\@.*)>.*$/ ) {
+        $name    =3D $1;
+        $address =3D $2;
+    }
+    elsif ( $formatted_email =3D~ /^\s*<(.+\@\S*)>.*$/ ) {
+        $address =3D $1;
+    }
+    elsif ( $formatted_email =3D~ /^(.+\@\S*).*$/ ) {
+        $address =3D $1;
     }
=20
-    $name =3D~ s/^\s+|\s+$//g;
-    $name =3D~ s/^\"|\"$//g;
+    $name    =3D~ s/^\s+|\s+$//g;
+    $name    =3D~ s/^\"|\"$//g;
     $address =3D~ s/^\s+|\s+$//g;
=20
-    if ($name =3D~ /[^\w \-]/i) {  	 ##has "must quote" chars
-	$name =3D~ s/(?<!\\)"/\\"/g;       ##escape quotes
-	$name =3D "\"$name\"";
+    if ( $name =3D~ /[^\w \-]/i ) {    ##has "must quote" chars
+        $name =3D~ s/(?<!\\)"/\\"/g;    ##escape quotes
+        $name =3D "\"$name\"";
     }
=20
-    return ($name, $address);
+    return ( $name, $address );
 }
=20
 sub format_email {
-    my ($name, $address, $usename) =3D @_;
+    my ( $name, $address, $usename ) =3D @_;
=20
     my $formatted_email;
=20
-    $name =3D~ s/^\s+|\s+$//g;
-    $name =3D~ s/^\"|\"$//g;
+    $name    =3D~ s/^\s+|\s+$//g;
+    $name    =3D~ s/^\"|\"$//g;
     $address =3D~ s/^\s+|\s+$//g;
=20
-    if ($name =3D~ /[^\w \-]/i) {          ##has "must quote" chars
-	$name =3D~ s/(?<!\\)"/\\"/g;       ##escape quotes
-	$name =3D "\"$name\"";
+    if ( $name =3D~ /[^\w \-]/i ) {    ##has "must quote" chars
+        $name =3D~ s/(?<!\\)"/\\"/g;    ##escape quotes
+        $name =3D "\"$name\"";
     }
=20
     if ($usename) {
-	if ("$name" eq "") {
-	    $formatted_email =3D "$address";
-	} else {
-	    $formatted_email =3D "$name <$address>";
-	}
-    } else {
-	$formatted_email =3D $address;
+        if ( "$name" eq "" ) {
+            $formatted_email =3D "$address";
+        }
+        else {
+            $formatted_email =3D "$name <$address>";
+        }
+    }
+    else {
+        $formatted_email =3D $address;
     }
=20
     return $formatted_email;
@@ -1207,12 +1222,12 @@ sub format_email {
 sub find_first_section {
     my $index =3D 0;
=20
-    while ($index < @typevalue) {
-	my $tv =3D $typevalue[$index];
-	if (($tv =3D~ m/^([A-Z]):\s*(.*)/)) {
-	    last;
-	}
-	$index++;
+    while ( $index < @typevalue ) {
+        my $tv =3D $typevalue[$index];
+        if ( ( $tv =3D~ m/^([A-Z]):\s*(.*)/ ) ) {
+            last;
+        }
+        $index++;
     }
=20
     return $index;
@@ -1221,12 +1236,12 @@ sub find_first_section {
 sub find_starting_index {
     my ($index) =3D @_;
=20
-    while ($index > 0) {
-	my $tv =3D $typevalue[$index];
-	if (!($tv =3D~ m/^([A-Z]):\s*(.*)/)) {
-	    last;
-	}
-	$index--;
+    while ( $index > 0 ) {
+        my $tv =3D $typevalue[$index];
+        if ( !( $tv =3D~ m/^([A-Z]):\s*(.*)/ ) ) {
+            last;
+        }
+        $index--;
     }
=20
     return $index;
@@ -1235,12 +1250,12 @@ sub find_starting_index {
 sub find_ending_index {
     my ($index) =3D @_;
=20
-    while ($index < @typevalue) {
-	my $tv =3D $typevalue[$index];
-	if (!($tv =3D~ m/^([A-Z]):\s*(.*)/)) {
-	    last;
-	}
-	$index++;
+    while ( $index < @typevalue ) {
+        my $tv =3D $typevalue[$index];
+        if ( !( $tv =3D~ m/^([A-Z]):\s*(.*)/ ) ) {
+            last;
+        }
+        $index++;
     }
=20
     return $index;
@@ -1252,10 +1267,10 @@ sub get_subsystem_name {
     my $start =3D find_starting_index($index);
=20
     my $subsystem =3D $typevalue[$start];
-    if ($output_section_maxlen && length($subsystem) > $output_section_max=
len) {
-	$subsystem =3D substr($subsystem, 0, $output_section_maxlen - 3);
-	$subsystem =3D~ s/\s*$//;
-	$subsystem =3D $subsystem . "...";
+    if ( $output_section_maxlen && length($subsystem) > $output_section_ma=
xlen ) {
+        $subsystem =3D substr( $subsystem, 0, $output_section_maxlen - 3 )=
;
+        $subsystem =3D~ s/\s*$//;
+        $subsystem =3D $subsystem . "...";
     }
     return $subsystem;
 }
@@ -1265,35 +1280,40 @@ sub get_maintainer_role {
=20
     my $i;
     my $start =3D find_starting_index($index);
-    my $end =3D find_ending_index($index);
+    my $end   =3D find_ending_index($index);
=20
-    my $role =3D "unknown";
+    my $role      =3D "unknown";
     my $subsystem =3D get_subsystem_name($index);
=20
-    for ($i =3D $start + 1; $i < $end; $i++) {
-	my $tv =3D $typevalue[$i];
-	if ($tv =3D~ m/^([A-Z]):\s*(.*)/) {
-	    my $ptype =3D $1;
-	    my $pvalue =3D $2;
-	    if ($ptype eq "S") {
-		$role =3D $pvalue;
-	    }
-	}
+    for ( $i =3D $start + 1; $i < $end; $i++ ) {
+        my $tv =3D $typevalue[$i];
+        if ( $tv =3D~ m/^([A-Z]):\s*(.*)/ ) {
+            my $ptype  =3D $1;
+            my $pvalue =3D $2;
+            if ( $ptype eq "S" ) {
+                $role =3D $pvalue;
+            }
+        }
     }
=20
     $role =3D lc($role);
-    if      ($role eq "supported") {
-	$role =3D "supporter";
-    } elsif ($role eq "maintained") {
-	$role =3D "maintainer";
-    } elsif ($role eq "odd fixes") {
-	$role =3D "odd fixer";
-    } elsif ($role eq "orphan") {
-	$role =3D "orphan minder";
-    } elsif ($role eq "obsolete") {
-	$role =3D "obsolete minder";
-    } elsif ($role eq "buried alive in reporters") {
-	$role =3D "chief penguin";
+    if ( $role eq "supported" ) {
+        $role =3D "supporter";
+    }
+    elsif ( $role eq "maintained" ) {
+        $role =3D "maintainer";
+    }
+    elsif ( $role eq "odd fixes" ) {
+        $role =3D "odd fixer";
+    }
+    elsif ( $role eq "orphan" ) {
+        $role =3D "orphan minder";
+    }
+    elsif ( $role eq "obsolete" ) {
+        $role =3D "obsolete minder";
+    }
+    elsif ( $role eq "buried alive in reporters" ) {
+        $role =3D "chief penguin";
     }
=20
     return $role . ":" . $subsystem;
@@ -1304,8 +1324,8 @@ sub get_list_role {
=20
     my $subsystem =3D get_subsystem_name($index);
=20
-    if ($subsystem eq "THE REST") {
-	$subsystem =3D "";
+    if ( $subsystem eq "THE REST" ) {
+        $subsystem =3D "";
     }
=20
     return $subsystem;
@@ -1316,161 +1336,171 @@ sub add_categories {
=20
     my $i;
     my $start =3D find_starting_index($index);
-    my $end =3D find_ending_index($index);
-
-    push(@subsystem, $typevalue[$start]);
-
-    for ($i =3D $start + 1; $i < $end; $i++) {
-	my $tv =3D $typevalue[$i];
-	if ($tv =3D~ m/^([A-Z]):\s*(.*)/) {
-	    my $ptype =3D $1;
-	    my $pvalue =3D $2;
-	    if ($ptype eq "L") {
-		my $list_address =3D $pvalue;
-		my $list_additional =3D "";
-		my $list_role =3D get_list_role($i);
-
-		if ($list_role ne "") {
-		    $list_role =3D ":" . $list_role;
-		}
-		if ($list_address =3D~ m/([^\s]+)\s+(.*)$/) {
-		    $list_address =3D $1;
-		    $list_additional =3D $2;
-		}
-		if ($list_additional =3D~ m/subscribers-only/) {
-		    if ($email_subscriber_list) {
-			if (!$hash_list_to{lc($list_address)}) {
-			    $hash_list_to{lc($list_address)} =3D 1;
-			    push(@list_to, [$list_address,
-					    "subscriber list${list_role}"]);
-			}
-		    }
-		} else {
-		    if ($email_list) {
-			if (!$hash_list_to{lc($list_address)}) {
-			    if ($list_additional =3D~ m/moderated/) {
-				if ($email_moderated_list) {
-				    $hash_list_to{lc($list_address)} =3D 1;
-				    push(@list_to, [$list_address,
-						    "moderated list${list_role}"]);
-				}
-			    } else {
-				$hash_list_to{lc($list_address)} =3D 1;
-				push(@list_to, [$list_address,
-						"open list${list_role}"]);
-			    }
-			}
-		    }
-		}
-	    } elsif ($ptype eq "M") {
-		if ($email_maintainer) {
-		    my $role =3D get_maintainer_role($i);
-		    push_email_addresses($pvalue, $role);
-		}
-	    } elsif ($ptype eq "R") {
-		if ($email_reviewer) {
-		    my $subsystem =3D get_subsystem_name($i);
-		    push_email_addresses($pvalue, "reviewer:$subsystem");
-		}
-	    } elsif ($ptype eq "T") {
-		push(@scm, $pvalue);
-	    } elsif ($ptype eq "W") {
-		push(@web, $pvalue);
-	    } elsif ($ptype eq "S") {
-		push(@status, $pvalue);
-	    }
-	}
+    my $end   =3D find_ending_index($index);
+
+    push( @subsystem, $typevalue[$start] );
+
+    for ( $i =3D $start + 1; $i < $end; $i++ ) {
+        my $tv =3D $typevalue[$i];
+        if ( $tv =3D~ m/^([A-Z]):\s*(.*)/ ) {
+            my $ptype  =3D $1;
+            my $pvalue =3D $2;
+            if ( $ptype eq "L" ) {
+                my $list_address    =3D $pvalue;
+                my $list_additional =3D "";
+                my $list_role       =3D get_list_role($i);
+
+                if ( $list_role ne "" ) {
+                    $list_role =3D ":" . $list_role;
+                }
+                if ( $list_address =3D~ m/([^\s]+)\s+(.*)$/ ) {
+                    $list_address    =3D $1;
+                    $list_additional =3D $2;
+                }
+                if ( $list_additional =3D~ m/subscribers-only/ ) {
+                    if ($email_subscriber_list) {
+                        if ( !$hash_list_to{ lc($list_address) } ) {
+                            $hash_list_to{ lc($list_address) } =3D 1;
+                            push( @list_to, [ $list_address, "subscriber l=
ist${list_role}" ] );
+                        }
+                    }
+                }
+                else {
+                    if ($email_list) {
+                        if ( !$hash_list_to{ lc($list_address) } ) {
+                            if ( $list_additional =3D~ m/moderated/ ) {
+                                if ($email_moderated_list) {
+                                    $hash_list_to{ lc($list_address) } =3D=
 1;
+                                    push( @list_to, [ $list_address, "mode=
rated list${list_role}" ] );
+                                }
+                            }
+                            else {
+                                $hash_list_to{ lc($list_address) } =3D 1;
+                                push( @list_to, [ $list_address, "open lis=
t${list_role}" ] );
+                            }
+                        }
+                    }
+                }
+            }
+            elsif ( $ptype eq "M" ) {
+                if ($email_maintainer) {
+                    my $role =3D get_maintainer_role($i);
+                    push_email_addresses( $pvalue, $role );
+                }
+            }
+            elsif ( $ptype eq "R" ) {
+                if ($email_reviewer) {
+                    my $subsystem =3D get_subsystem_name($i);
+                    push_email_addresses( $pvalue, "reviewer:$subsystem" )=
;
+                }
+            }
+            elsif ( $ptype eq "T" ) {
+                push( @scm, $pvalue );
+            }
+            elsif ( $ptype eq "W" ) {
+                push( @web, $pvalue );
+            }
+            elsif ( $ptype eq "S" ) {
+                push( @status, $pvalue );
+            }
+        }
     }
 }
=20
 sub email_inuse {
-    my ($name, $address) =3D @_;
+    my ( $name, $address ) =3D @_;
=20
-    return 1 if (($name eq "") && ($address eq ""));
-    return 1 if (($name ne "") && exists($email_hash_name{lc($name)}));
-    return 1 if (($address ne "") && exists($email_hash_address{lc($addres=
s)}));
+    return 1 if ( ( $name eq "" )    && ( $address eq "" ) );
+    return 1 if ( ( $name ne "" )    && exists( $email_hash_name{ lc($name=
) } ) );
+    return 1 if ( ( $address ne "" ) && exists( $email_hash_address{ lc($a=
ddress) } ) );
=20
     return 0;
 }
=20
 sub push_email_address {
-    my ($line, $role) =3D @_;
+    my ( $line, $role ) =3D @_;
=20
-    my ($name, $address) =3D parse_email($line);
+    my ( $name, $address ) =3D parse_email($line);
=20
-    if ($address eq "") {
-	return 0;
+    if ( $address eq "" ) {
+        return 0;
     }
=20
-    if (!$email_remove_duplicates) {
-	push(@email_to, [format_email($name, $address, $email_usename), $role]);
-    } elsif (!email_inuse($name, $address)) {
-	push(@email_to, [format_email($name, $address, $email_usename), $role]);
-	$email_hash_name{lc($name)}++ if ($name ne "");
-	$email_hash_address{lc($address)}++;
+    if ( !$email_remove_duplicates ) {
+        push( @email_to, [ format_email( $name, $address, $email_usename )=
, $role ] );
+    }
+    elsif ( !email_inuse( $name, $address ) ) {
+        push( @email_to, [ format_email( $name, $address, $email_usename )=
, $role ] );
+        $email_hash_name{ lc($name) }++ if ( $name ne "" );
+        $email_hash_address{ lc($address) }++;
     }
=20
     return 1;
 }
=20
 sub push_email_addresses {
-    my ($address, $role) =3D @_;
+    my ( $address, $role ) =3D @_;
=20
     my @address_list =3D ();
=20
-    if (rfc822_valid($address)) {
-	push_email_address($address, $role);
-    } elsif (@address_list =3D rfc822_validlist($address)) {
-	my $array_count =3D shift(@address_list);
-	while (my $entry =3D shift(@address_list)) {
-	    push_email_address($entry, $role);
-	}
-    } else {
-	if (!push_email_address($address, $role)) {
-	    warn("Invalid MAINTAINERS address: '" . $address . "'\n");
-	}
+    if ( rfc822_valid($address) ) {
+        push_email_address( $address, $role );
+    }
+    elsif ( @address_list =3D rfc822_validlist($address) ) {
+        my $array_count =3D shift(@address_list);
+        while ( my $entry =3D shift(@address_list) ) {
+            push_email_address( $entry, $role );
+        }
+    }
+    else {
+        if ( !push_email_address( $address, $role ) ) {
+            warn( "Invalid MAINTAINERS address: '" . $address . "'\n" );
+        }
     }
 }
=20
 sub add_role {
-    my ($line, $role) =3D @_;
+    my ( $line, $role ) =3D @_;
=20
-    my ($name, $address) =3D parse_email($line);
-    my $email =3D format_email($name, $address, $email_usename);
+    my ( $name, $address ) =3D parse_email($line);
+    my $email =3D format_email( $name, $address, $email_usename );
=20
     foreach my $entry (@email_to) {
-	if ($email_remove_duplicates) {
-	    my ($entry_name, $entry_address) =3D parse_email($entry->[0]);
-	    if (($name eq $entry_name || $address eq $entry_address)
-		&& ($role eq "" || !($entry->[1] =3D~ m/$role/))
-	    ) {
-		if ($entry->[1] eq "") {
-		    $entry->[1] =3D "$role";
-		} else {
-		    $entry->[1] =3D "$entry->[1],$role";
-		}
-	    }
-	} else {
-	    if ($email eq $entry->[0]
-		&& ($role eq "" || !($entry->[1] =3D~ m/$role/))
-	    ) {
-		if ($entry->[1] eq "") {
-		    $entry->[1] =3D "$role";
-		} else {
-		    $entry->[1] =3D "$entry->[1],$role";
-		}
-	    }
-	}
+        if ($email_remove_duplicates) {
+            my ( $entry_name, $entry_address ) =3D parse_email( $entry->[0=
] );
+            if (   ( $name eq $entry_name || $address eq $entry_address )
+                && ( $role eq "" || !( $entry->[1] =3D~ m/$role/ ) ) )
+            {
+                if ( $entry->[1] eq "" ) {
+                    $entry->[1] =3D "$role";
+                }
+                else {
+                    $entry->[1] =3D "$entry->[1],$role";
+                }
+            }
+        }
+        else {
+            if ( $email eq $entry->[0]
+                && ( $role eq "" || !( $entry->[1] =3D~ m/$role/ ) ) )
+            {
+                if ( $entry->[1] eq "" ) {
+                    $entry->[1] =3D "$role";
+                }
+                else {
+                    $entry->[1] =3D "$entry->[1],$role";
+                }
+            }
+        }
     }
 }
=20
 sub which {
     my ($bin) =3D @_;
=20
-    foreach my $path (split(/:/, $ENV{PATH})) {
-	if (-e "$path/$bin") {
-	    return "$path/$bin";
-	}
+    foreach my $path ( split( /:/, $ENV{PATH} ) ) {
+        if ( -e "$path/$bin" ) {
+            return "$path/$bin";
+        }
     }
=20
     return "";
@@ -1479,10 +1509,10 @@ sub which {
 sub which_conf {
     my ($conf) =3D @_;
=20
-    foreach my $path (split(/:/, ".:$ENV{HOME}:.scripts")) {
-	if (-e "$path/$conf") {
-	    return "$path/$conf";
-	}
+    foreach my $path ( split( /:/, ".:$ENV{HOME}:.scripts" ) ) {
+        if ( -e "$path/$conf" ) {
+            return "$path/$conf";
+        }
     }
=20
     return "";
@@ -1491,28 +1521,30 @@ sub which_conf {
 sub mailmap_email {
     my ($line) =3D @_;
=20
-    my ($name, $address) =3D parse_email($line);
-    my $email =3D format_email($name, $address, 1);
-    my $real_name =3D $name;
+    my ( $name, $address ) =3D parse_email($line);
+    my $email        =3D format_email( $name, $address, 1 );
+    my $real_name    =3D $name;
     my $real_address =3D $address;
=20
-    if (exists $mailmap->{names}->{$email} ||
-	exists $mailmap->{addresses}->{$email}) {
-	if (exists $mailmap->{names}->{$email}) {
-	    $real_name =3D $mailmap->{names}->{$email};
-	}
-	if (exists $mailmap->{addresses}->{$email}) {
-	    $real_address =3D $mailmap->{addresses}->{$email};
-	}
-    } else {
-	if (exists $mailmap->{names}->{$address}) {
-	    $real_name =3D $mailmap->{names}->{$address};
-	}
-	if (exists $mailmap->{addresses}->{$address}) {
-	    $real_address =3D $mailmap->{addresses}->{$address};
-	}
-    }
-    return format_email($real_name, $real_address, 1);
+    if (   exists $mailmap->{names}->{$email}
+        || exists $mailmap->{addresses}->{$email} )
+    {
+        if ( exists $mailmap->{names}->{$email} ) {
+            $real_name =3D $mailmap->{names}->{$email};
+        }
+        if ( exists $mailmap->{addresses}->{$email} ) {
+            $real_address =3D $mailmap->{addresses}->{$email};
+        }
+    }
+    else {
+        if ( exists $mailmap->{names}->{$address} ) {
+            $real_name =3D $mailmap->{names}->{$address};
+        }
+        if ( exists $mailmap->{addresses}->{$address} ) {
+            $real_address =3D $mailmap->{addresses}->{$address};
+        }
+    }
+    return format_email( $real_name, $real_address, 1 );
 }
=20
 sub mailmap {
@@ -1520,7 +1552,7 @@ sub mailmap {
=20
     my @mapped_emails =3D ();
     foreach my $line (@addresses) {
-	push(@mapped_emails, mailmap_email($line));
+        push( @mapped_emails, mailmap_email($line) );
     }
     merge_by_realname(@mapped_emails) if ($email_use_mailmap);
     return @mapped_emails;
@@ -1531,13 +1563,14 @@ sub merge_by_realname {
     my (@emails) =3D @_;
=20
     foreach my $email (@emails) {
-	my ($name, $address) =3D parse_email($email);
-	if (exists $address_map{$name}) {
-	    $address =3D $address_map{$name};
-	    $email =3D format_email($name, $address, 1);
-	} else {
-	    $address_map{$name} =3D $address;
-	}
+        my ( $name, $address ) =3D parse_email($email);
+        if ( exists $address_map{$name} ) {
+            $address =3D $address_map{$name};
+            $email   =3D format_email( $name, $address, 1 );
+        }
+        else {
+            $address_map{$name} =3D $address;
+        }
     }
 }
=20
@@ -1547,7 +1580,7 @@ sub git_execute_cmd {
=20
     my $output =3D `$cmd`;
     $output =3D~ s/^\s*//gm;
-    @lines =3D split("\n", $output);
+    @lines =3D split( "\n", $output );
=20
     return @lines;
 }
@@ -1557,7 +1590,7 @@ sub hg_execute_cmd {
     my @lines =3D ();
=20
     my $output =3D `$cmd`;
-    @lines =3D split("\n", $output);
+    @lines =3D split( "\n", $output );
=20
     return @lines;
 }
@@ -1575,71 +1608,71 @@ sub extract_formatted_signatures {
 ## Reformat email addresses (with names) to avoid badly written signatures
=20
     foreach my $signer (@signature_lines) {
-	$signer =3D deduplicate_email($signer);
+        $signer =3D deduplicate_email($signer);
     }
=20
-    return (\@type, \@signature_lines);
+    return ( \@type, \@signature_lines );
 }
=20
 sub vcs_find_signers {
-    my ($cmd, $file) =3D @_;
+    my ( $cmd, $file ) =3D @_;
     my $commits;
-    my @lines =3D ();
+    my @lines      =3D ();
     my @signatures =3D ();
-    my @authors =3D ();
-    my @stats =3D ();
+    my @authors    =3D ();
+    my @stats      =3D ();
=20
-    @lines =3D &{$VCS_cmds{"execute_cmd"}}($cmd);
+    @lines =3D &{ $VCS_cmds{"execute_cmd"} }($cmd);
=20
-    my $pattern =3D $VCS_cmds{"commit_pattern"};
+    my $pattern        =3D $VCS_cmds{"commit_pattern"};
     my $author_pattern =3D $VCS_cmds{"author_pattern"};
-    my $stat_pattern =3D $VCS_cmds{"stat_pattern"};
+    my $stat_pattern   =3D $VCS_cmds{"stat_pattern"};
=20
-    $stat_pattern =3D~ s/(\$\w+)/$1/eeg;		#interpolate $stat_pattern
+    $stat_pattern =3D~ s/(\$\w+)/$1/eeg;    #interpolate $stat_pattern
=20
-    $commits =3D grep(/$pattern/, @lines);	# of commits
+    $commits =3D grep( /$pattern/, @lines );    # of commits
=20
-    @authors =3D grep(/$author_pattern/, @lines);
-    @signatures =3D grep(/^[ \t]*${signature_pattern}.*\@.*$/, @lines);
-    @stats =3D grep(/$stat_pattern/, @lines);
+    @authors    =3D grep( /$author_pattern/,                    @lines );
+    @signatures =3D grep( /^[ \t]*${signature_pattern}.*\@.*$/, @lines );
+    @stats      =3D grep( /$stat_pattern/,                      @lines );
=20
-#    print("stats: <@stats>\n");
+    #    print("stats: <@stats>\n");
=20
-    return (0, \@signatures, \@authors, \@stats) if !@signatures;
+    return ( 0, \@signatures, \@authors, \@stats ) if !@signatures;
=20
     save_commits_by_author(@lines) if ($interactive);
     save_commits_by_signer(@lines) if ($interactive);
=20
-    if (!$email_git_penguin_chiefs) {
-	@signatures =3D grep(!/${penguin_chiefs}/i, @signatures);
+    if ( !$email_git_penguin_chiefs ) {
+        @signatures =3D grep( !/${penguin_chiefs}/i, @signatures );
     }
=20
-    my ($author_ref, $authors_ref) =3D extract_formatted_signatures(@autho=
rs);
-    my ($types_ref, $signers_ref) =3D extract_formatted_signatures(@signat=
ures);
+    my ( $author_ref, $authors_ref ) =3D extract_formatted_signatures(@aut=
hors);
+    my ( $types_ref,  $signers_ref ) =3D extract_formatted_signatures(@sig=
natures);
=20
-    return ($commits, $signers_ref, $authors_ref, \@stats);
+    return ( $commits, $signers_ref, $authors_ref, \@stats );
 }
=20
 sub vcs_find_author {
     my ($cmd) =3D @_;
     my @lines =3D ();
=20
-    @lines =3D &{$VCS_cmds{"execute_cmd"}}($cmd);
+    @lines =3D &{ $VCS_cmds{"execute_cmd"} }($cmd);
=20
-    if (!$email_git_penguin_chiefs) {
-	@lines =3D grep(!/${penguin_chiefs}/i, @lines);
+    if ( !$email_git_penguin_chiefs ) {
+        @lines =3D grep( !/${penguin_chiefs}/i, @lines );
     }
=20
     return @lines if !@lines;
=20
     my @authors =3D ();
     foreach my $line (@lines) {
-	if ($line =3D~ m/$VCS_cmds{"author_pattern"}/) {
-	    my $author =3D $1;
-	    my ($name, $address) =3D parse_email($author);
-	    $author =3D format_email($name, $address, 1);
-	    push(@authors, $author);
-	}
+        if ( $line =3D~ m/$VCS_cmds{"author_pattern"}/ ) {
+            my $author =3D $1;
+            my ( $name, $address ) =3D parse_email($author);
+            $author =3D format_email( $name, $address, 1 );
+            push( @authors, $author );
+        }
     }
=20
     save_commits_by_author(@lines) if ($interactive);
@@ -1649,16 +1682,16 @@ sub vcs_find_author {
 }
=20
 sub vcs_save_commits {
-    my ($cmd) =3D @_;
-    my @lines =3D ();
+    my ($cmd)   =3D @_;
+    my @lines   =3D ();
     my @commits =3D ();
=20
-    @lines =3D &{$VCS_cmds{"execute_cmd"}}($cmd);
+    @lines =3D &{ $VCS_cmds{"execute_cmd"} }($cmd);
=20
     foreach my $line (@lines) {
-	if ($line =3D~ m/$VCS_cmds{"blame_commit_pattern"}/) {
-	    push(@commits, $1);
-	}
+        if ( $line =3D~ m/$VCS_cmds{"blame_commit_pattern"}/ ) {
+            push( @commits, $1 );
+        }
     }
=20
     return @commits;
@@ -1669,62 +1702,65 @@ sub vcs_blame {
     my $cmd;
     my @commits =3D ();
=20
-    return @commits if (!(-f $file));
-
-    if (@range && $VCS_cmds{"blame_range_cmd"} eq "") {
-	my @all_commits =3D ();
-
-	$cmd =3D $VCS_cmds{"blame_file_cmd"};
-	$cmd =3D~ s/(\$\w+)/$1/eeg;		#interpolate $cmd
-	@all_commits =3D vcs_save_commits($cmd);
-
-	foreach my $file_range_diff (@range) {
-	    next if (!($file_range_diff =3D~ m/(.+):(.+):(.+)/));
-	    my $diff_file =3D $1;
-	    my $diff_start =3D $2;
-	    my $diff_length =3D $3;
-	    next if ("$file" ne "$diff_file");
-	    for (my $i =3D $diff_start; $i < $diff_start + $diff_length; $i++) {
-		push(@commits, $all_commits[$i]);
-	    }
-	}
-    } elsif (@range) {
-	foreach my $file_range_diff (@range) {
-	    next if (!($file_range_diff =3D~ m/(.+):(.+):(.+)/));
-	    my $diff_file =3D $1;
-	    my $diff_start =3D $2;
-	    my $diff_length =3D $3;
-	    next if ("$file" ne "$diff_file");
-	    $cmd =3D $VCS_cmds{"blame_range_cmd"};
-	    $cmd =3D~ s/(\$\w+)/$1/eeg;		#interpolate $cmd
-	    push(@commits, vcs_save_commits($cmd));
-	}
-    } else {
-	$cmd =3D $VCS_cmds{"blame_file_cmd"};
-	$cmd =3D~ s/(\$\w+)/$1/eeg;		#interpolate $cmd
-	@commits =3D vcs_save_commits($cmd);
+    return @commits if ( !( -f $file ) );
+
+    if ( @range && $VCS_cmds{"blame_range_cmd"} eq "" ) {
+        my @all_commits =3D ();
+
+        $cmd =3D $VCS_cmds{"blame_file_cmd"};
+        $cmd =3D~ s/(\$\w+)/$1/eeg;    #interpolate $cmd
+        @all_commits =3D vcs_save_commits($cmd);
+
+        foreach my $file_range_diff (@range) {
+            next if ( !( $file_range_diff =3D~ m/(.+):(.+):(.+)/ ) );
+            my $diff_file   =3D $1;
+            my $diff_start  =3D $2;
+            my $diff_length =3D $3;
+            next if ( "$file" ne "$diff_file" );
+            for ( my $i =3D $diff_start; $i < $diff_start + $diff_length; =
$i++ ) {
+                push( @commits, $all_commits[$i] );
+            }
+        }
+    }
+    elsif (@range) {
+        foreach my $file_range_diff (@range) {
+            next if ( !( $file_range_diff =3D~ m/(.+):(.+):(.+)/ ) );
+            my $diff_file   =3D $1;
+            my $diff_start  =3D $2;
+            my $diff_length =3D $3;
+            next if ( "$file" ne "$diff_file" );
+            $cmd =3D $VCS_cmds{"blame_range_cmd"};
+            $cmd =3D~ s/(\$\w+)/$1/eeg;    #interpolate $cmd
+            push( @commits, vcs_save_commits($cmd) );
+        }
+    }
+    else {
+        $cmd =3D $VCS_cmds{"blame_file_cmd"};
+        $cmd =3D~ s/(\$\w+)/$1/eeg;        #interpolate $cmd
+        @commits =3D vcs_save_commits($cmd);
     }
=20
     foreach my $commit (@commits) {
-	$commit =3D~ s/^\^//g;
+        $commit =3D~ s/^\^//g;
     }
=20
     return @commits;
 }
=20
 my $printed_novcs =3D 0;
+
 sub vcs_exists {
     %VCS_cmds =3D %VCS_cmds_git;
     return 1 if eval $VCS_cmds{"available"};
     %VCS_cmds =3D %VCS_cmds_hg;
     return 2 if eval $VCS_cmds{"available"};
     %VCS_cmds =3D ();
-    if (!$printed_novcs && $email_git) {
-	warn("$P: No supported VCS found.  Add --nogit to options?\n");
-	warn("Using a git repository produces better results.\n");
-	warn("Try Linus Torvalds' latest git repository using:\n");
-	warn("git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git\n");
-	$printed_novcs =3D 1;
+    if ( !$printed_novcs && $email_git ) {
+        warn("$P: No supported VCS found.  Add --nogit to options?\n");
+        warn("Using a git repository produces better results.\n");
+        warn("Try Linus Torvalds' latest git repository using:\n");
+        warn("git clone git://git.kernel.org/pub/scm/linux/kernel/git/torv=
alds/linux.git\n");
+        $printed_novcs =3D 1;
     }
     return 0;
 }
@@ -1739,9 +1775,9 @@ sub vcs_is_hg {
 }
=20
 sub vcs_add_commit_signers {
-    return if (!vcs_exists());
+    return if ( !vcs_exists() );
=20
-    my ($commit, $desc) =3D @_;
+    my ( $commit, $desc ) =3D @_;
     my $commit_count =3D 0;
     my $commit_authors_ref;
     my $commit_signers_ref;
@@ -1751,17 +1787,17 @@ sub vcs_add_commit_signers {
     my $cmd;
=20
     $cmd =3D $VCS_cmds{"find_commit_signers_cmd"};
-    $cmd =3D~ s/(\$\w+)/$1/eeg;	#substitute variables in $cmd
+    $cmd =3D~ s/(\$\w+)/$1/eeg;    #substitute variables in $cmd
=20
-    ($commit_count, $commit_signers_ref, $commit_authors_ref, $stats_ref) =
=3D vcs_find_signers($cmd, "");
+    ( $commit_count, $commit_signers_ref, $commit_authors_ref, $stats_ref =
) =3D vcs_find_signers( $cmd, "" );
     @commit_authors =3D @{$commit_authors_ref} if defined $commit_authors_=
ref;
     @commit_signers =3D @{$commit_signers_ref} if defined $commit_signers_=
ref;
=20
     foreach my $signer (@commit_signers) {
-	$signer =3D deduplicate_email($signer);
+        $signer =3D deduplicate_email($signer);
     }
=20
-    vcs_assign($desc, 1, @commit_signers);
+    vcs_assign( $desc, 1, @commit_signers );
 }
=20
 sub interactive_get_maintainers {
@@ -1773,68 +1809,69 @@ sub interactive_get_maintainers {
     my %selected;
     my %authored;
     my %signed;
-    my $count =3D 0;
+    my $count      =3D 0;
     my $maintained =3D 0;
     foreach my $entry (@list) {
-	$maintained =3D 1 if ($entry->[1] =3D~ /^(maintainer|supporter)/i);
-	$selected{$count} =3D 1;
-	$authored{$count} =3D 0;
-	$signed{$count} =3D 0;
-	$count++;
+        $maintained       =3D 1 if ( $entry->[1] =3D~ /^(maintainer|suppor=
ter)/i );
+        $selected{$count} =3D 1;
+        $authored{$count} =3D 0;
+        $signed{$count}   =3D 0;
+        $count++;
     }
=20
     #menu loop
-    my $done =3D 0;
+    my $done          =3D 0;
     my $print_options =3D 0;
-    my $redraw =3D 1;
-    while (!$done) {
-	$count =3D 0;
-	if ($redraw) {
-	    printf STDERR "\n%1s %2s %-65s",
-			  "*", "#", "email/list and role:stats";
-	    if ($email_git ||
-		($email_git_fallback && !$maintained) ||
-		$email_git_blame) {
-		print STDERR "auth sign";
-	    }
-	    print STDERR "\n";
-	    foreach my $entry (@list) {
-		my $email =3D $entry->[0];
-		my $role =3D $entry->[1];
-		my $sel =3D "";
-		$sel =3D "*" if ($selected{$count});
-		my $commit_author =3D $commit_author_hash{$email};
-		my $commit_signer =3D $commit_signer_hash{$email};
-		my $authored =3D 0;
-		my $signed =3D 0;
-		$authored++ for (@{$commit_author});
-		$signed++ for (@{$commit_signer});
-		printf STDERR "%1s %2d %-65s", $sel, $count + 1, $email;
-		printf STDERR "%4d %4d", $authored, $signed
-		    if ($authored > 0 || $signed > 0);
-		printf STDERR "\n     %s\n", $role;
-		if ($authored{$count}) {
-		    my $commit_author =3D $commit_author_hash{$email};
-		    foreach my $ref (@{$commit_author}) {
-			print STDERR "     Author: @{$ref}[1]\n";
-		    }
-		}
-		if ($signed{$count}) {
-		    my $commit_signer =3D $commit_signer_hash{$email};
-		    foreach my $ref (@{$commit_signer}) {
-			print STDERR "     @{$ref}[2]: @{$ref}[1]\n";
-		    }
-		}
-
-		$count++;
-	    }
-	}
-	my $date_ref =3D \$email_git_since;
-	$date_ref =3D \$email_hg_since if (vcs_is_hg());
-	if ($print_options) {
-	    $print_options =3D 0;
-	    if (vcs_exists()) {
-		print STDERR <<EOT
+    my $redraw        =3D 1;
+    while ( !$done ) {
+        $count =3D 0;
+        if ($redraw) {
+            printf STDERR "\n%1s %2s %-65s", "*", "#", "email/list and rol=
e:stats";
+            if (   $email_git
+                || ( $email_git_fallback && !$maintained )
+                || $email_git_blame )
+            {
+                print STDERR "auth sign";
+            }
+            print STDERR "\n";
+            foreach my $entry (@list) {
+                my $email =3D $entry->[0];
+                my $role  =3D $entry->[1];
+                my $sel   =3D "";
+                $sel =3D "*" if ( $selected{$count} );
+                my $commit_author =3D $commit_author_hash{$email};
+                my $commit_signer =3D $commit_signer_hash{$email};
+                my $authored      =3D 0;
+                my $signed        =3D 0;
+                $authored++ for ( @{$commit_author} );
+                $signed++   for ( @{$commit_signer} );
+                printf STDERR "%1s %2d %-65s", $sel, $count + 1, $email;
+                printf STDERR "%4d %4d", $authored, $signed
+                    if ( $authored > 0 || $signed > 0 );
+                printf STDERR "\n     %s\n", $role;
+
+                if ( $authored{$count} ) {
+                    my $commit_author =3D $commit_author_hash{$email};
+                    foreach my $ref ( @{$commit_author} ) {
+                        print STDERR "     Author: @{$ref}[1]\n";
+                    }
+                }
+                if ( $signed{$count} ) {
+                    my $commit_signer =3D $commit_signer_hash{$email};
+                    foreach my $ref ( @{$commit_signer} ) {
+                        print STDERR "     @{$ref}[2]: @{$ref}[1]\n";
+                    }
+                }
+
+                $count++;
+            }
+        }
+        my $date_ref =3D \$email_git_since;
+        $date_ref =3D \$email_hg_since if ( vcs_is_hg() );
+        if ($print_options) {
+            $print_options =3D 0;
+            if ( vcs_exists() ) {
+                print STDERR <<EOT;
=20
 Version Control options:
 g  use git history      [$email_git]
@@ -1848,8 +1885,8 @@ x# max maintainers      [$email_git_max_maintainers]
 t  all signature types  [$email_git_all_signature_types]
 m  use .mailmap         [$email_use_mailmap]
 EOT
-	    }
-	    print STDERR <<EOT
+            }
+            print STDERR <<EOT;
=20
 Additional options:
 0  toggle all
@@ -1862,145 +1899,172 @@ k  keywords in file     [$keywords]
 r  remove duplicates    [$email_remove_duplicates]
 p# pattern match depth  [$pattern_depth]
 EOT
-	}
-	print STDERR
-"\n#(toggle), A#(author), S#(signed) *(all), ^(none), O(options), Y(approv=
e): ";
-
-	my $input =3D <STDIN>;
-	chomp($input);
-
-	$redraw =3D 1;
-	my $rerun =3D 0;
-	my @wish =3D split(/[, ]+/, $input);
-	foreach my $nr (@wish) {
-	    $nr =3D lc($nr);
-	    my $sel =3D substr($nr, 0, 1);
-	    my $str =3D substr($nr, 1);
-	    my $val =3D 0;
-	    $val =3D $1 if $str =3D~ /^(\d+)$/;
-
-	    if ($sel eq "y") {
-		$interactive =3D 0;
-		$done =3D 1;
-		$output_rolestats =3D 0;
-		$output_roles =3D 0;
-		last;
-	    } elsif ($nr =3D~ /^\d+$/ && $nr > 0 && $nr <=3D $count) {
-		$selected{$nr - 1} =3D !$selected{$nr - 1};
-	    } elsif ($sel eq "*" || $sel eq '^') {
-		my $toggle =3D 0;
-		$toggle =3D 1 if ($sel eq '*');
-		for (my $i =3D 0; $i < $count; $i++) {
-		    $selected{$i} =3D $toggle;
-		}
-	    } elsif ($sel eq "0") {
-		for (my $i =3D 0; $i < $count; $i++) {
-		    $selected{$i} =3D !$selected{$i};
-		}
-	    } elsif ($sel eq "t") {
-		if (lc($str) eq "m") {
-		    for (my $i =3D 0; $i < $count; $i++) {
-			$selected{$i} =3D !$selected{$i}
-			    if ($list[$i]->[1] =3D~ /^(maintainer|supporter)/i);
-		    }
-		} elsif (lc($str) eq "g") {
-		    for (my $i =3D 0; $i < $count; $i++) {
-			$selected{$i} =3D !$selected{$i}
-			    if ($list[$i]->[1] =3D~ /^(author|commit|signer)/i);
-		    }
-		} elsif (lc($str) eq "l") {
-		    for (my $i =3D 0; $i < $count; $i++) {
-			$selected{$i} =3D !$selected{$i}
-			    if ($list[$i]->[1] =3D~ /^(open list)/i);
-		    }
-		} elsif (lc($str) eq "s") {
-		    for (my $i =3D 0; $i < $count; $i++) {
-			$selected{$i} =3D !$selected{$i}
-			    if ($list[$i]->[1] =3D~ /^(subscriber list)/i);
-		    }
-		}
-	    } elsif ($sel eq "a") {
-		if ($val > 0 && $val <=3D $count) {
-		    $authored{$val - 1} =3D !$authored{$val - 1};
-		} elsif ($str eq '*' || $str eq '^') {
-		    my $toggle =3D 0;
-		    $toggle =3D 1 if ($str eq '*');
-		    for (my $i =3D 0; $i < $count; $i++) {
-			$authored{$i} =3D $toggle;
-		    }
-		}
-	    } elsif ($sel eq "s") {
-		if ($val > 0 && $val <=3D $count) {
-		    $signed{$val - 1} =3D !$signed{$val - 1};
-		} elsif ($str eq '*' || $str eq '^') {
-		    my $toggle =3D 0;
-		    $toggle =3D 1 if ($str eq '*');
-		    for (my $i =3D 0; $i < $count; $i++) {
-			$signed{$i} =3D $toggle;
-		    }
-		}
-	    } elsif ($sel eq "o") {
-		$print_options =3D 1;
-		$redraw =3D 1;
-	    } elsif ($sel eq "g") {
-		if ($str eq "f") {
-		    bool_invert(\$email_git_fallback);
-		} else {
-		    bool_invert(\$email_git);
-		}
-		$rerun =3D 1;
-	    } elsif ($sel eq "b") {
-		if ($str eq "s") {
-		    bool_invert(\$email_git_blame_signatures);
-		} else {
-		    bool_invert(\$email_git_blame);
-		}
-		$rerun =3D 1;
-	    } elsif ($sel eq "c") {
-		if ($val > 0) {
-		    $email_git_min_signatures =3D $val;
-		    $rerun =3D 1;
-		}
-	    } elsif ($sel eq "x") {
-		if ($val > 0) {
-		    $email_git_max_maintainers =3D $val;
-		    $rerun =3D 1;
-		}
-	    } elsif ($sel eq "%") {
-		if ($str ne "" && $val >=3D 0) {
-		    $email_git_min_percent =3D $val;
-		    $rerun =3D 1;
-		}
-	    } elsif ($sel eq "d") {
-		if (vcs_is_git()) {
-		    $email_git_since =3D $str;
-		} elsif (vcs_is_hg()) {
-		    $email_hg_since =3D $str;
-		}
-		$rerun =3D 1;
-	    } elsif ($sel eq "t") {
-		bool_invert(\$email_git_all_signature_types);
-		$rerun =3D 1;
-	    } elsif ($sel eq "f") {
-		bool_invert(\$email_file_emails);
-		$rerun =3D 1;
-	    } elsif ($sel eq "r") {
-		bool_invert(\$email_remove_duplicates);
-		$rerun =3D 1;
-	    } elsif ($sel eq "m") {
-		bool_invert(\$email_use_mailmap);
-		read_mailmap();
-		$rerun =3D 1;
-	    } elsif ($sel eq "k") {
-		bool_invert(\$keywords);
-		$rerun =3D 1;
-	    } elsif ($sel eq "p") {
-		if ($str ne "" && $val >=3D 0) {
-		    $pattern_depth =3D $val;
-		    $rerun =3D 1;
-		}
-	    } elsif ($sel eq "h" || $sel eq "?") {
-		print STDERR <<EOT
+        }
+        print STDERR "\n#(toggle), A#(author), S#(signed) *(all), ^(none),=
 O(options), Y(approve): ";
+
+        my $input =3D <STDIN>;
+        chomp($input);
+
+        $redraw =3D 1;
+        my $rerun =3D 0;
+        my @wish  =3D split( /[, ]+/, $input );
+        foreach my $nr (@wish) {
+            $nr =3D lc($nr);
+            my $sel =3D substr( $nr, 0, 1 );
+            my $str =3D substr( $nr, 1 );
+            my $val =3D 0;
+            $val =3D $1 if $str =3D~ /^(\d+)$/;
+
+            if ( $sel eq "y" ) {
+                $interactive      =3D 0;
+                $done             =3D 1;
+                $output_rolestats =3D 0;
+                $output_roles     =3D 0;
+                last;
+            }
+            elsif ( $nr =3D~ /^\d+$/ && $nr > 0 && $nr <=3D $count ) {
+                $selected{ $nr - 1 } =3D !$selected{ $nr - 1 };
+            }
+            elsif ( $sel eq "*" || $sel eq '^' ) {
+                my $toggle =3D 0;
+                $toggle =3D 1 if ( $sel eq '*' );
+                for ( my $i =3D 0; $i < $count; $i++ ) {
+                    $selected{$i} =3D $toggle;
+                }
+            }
+            elsif ( $sel eq "0" ) {
+                for ( my $i =3D 0; $i < $count; $i++ ) {
+                    $selected{$i} =3D !$selected{$i};
+                }
+            }
+            elsif ( $sel eq "t" ) {
+                if ( lc($str) eq "m" ) {
+                    for ( my $i =3D 0; $i < $count; $i++ ) {
+                        $selected{$i} =3D !$selected{$i}
+                            if ( $list[$i]->[1] =3D~ /^(maintainer|support=
er)/i );
+                    }
+                }
+                elsif ( lc($str) eq "g" ) {
+                    for ( my $i =3D 0; $i < $count; $i++ ) {
+                        $selected{$i} =3D !$selected{$i}
+                            if ( $list[$i]->[1] =3D~ /^(author|commit|sign=
er)/i );
+                    }
+                }
+                elsif ( lc($str) eq "l" ) {
+                    for ( my $i =3D 0; $i < $count; $i++ ) {
+                        $selected{$i} =3D !$selected{$i}
+                            if ( $list[$i]->[1] =3D~ /^(open list)/i );
+                    }
+                }
+                elsif ( lc($str) eq "s" ) {
+                    for ( my $i =3D 0; $i < $count; $i++ ) {
+                        $selected{$i} =3D !$selected{$i}
+                            if ( $list[$i]->[1] =3D~ /^(subscriber list)/i=
 );
+                    }
+                }
+            }
+            elsif ( $sel eq "a" ) {
+                if ( $val > 0 && $val <=3D $count ) {
+                    $authored{ $val - 1 } =3D !$authored{ $val - 1 };
+                }
+                elsif ( $str eq '*' || $str eq '^' ) {
+                    my $toggle =3D 0;
+                    $toggle =3D 1 if ( $str eq '*' );
+                    for ( my $i =3D 0; $i < $count; $i++ ) {
+                        $authored{$i} =3D $toggle;
+                    }
+                }
+            }
+            elsif ( $sel eq "s" ) {
+                if ( $val > 0 && $val <=3D $count ) {
+                    $signed{ $val - 1 } =3D !$signed{ $val - 1 };
+                }
+                elsif ( $str eq '*' || $str eq '^' ) {
+                    my $toggle =3D 0;
+                    $toggle =3D 1 if ( $str eq '*' );
+                    for ( my $i =3D 0; $i < $count; $i++ ) {
+                        $signed{$i} =3D $toggle;
+                    }
+                }
+            }
+            elsif ( $sel eq "o" ) {
+                $print_options =3D 1;
+                $redraw        =3D 1;
+            }
+            elsif ( $sel eq "g" ) {
+                if ( $str eq "f" ) {
+                    bool_invert( \$email_git_fallback );
+                }
+                else {
+                    bool_invert( \$email_git );
+                }
+                $rerun =3D 1;
+            }
+            elsif ( $sel eq "b" ) {
+                if ( $str eq "s" ) {
+                    bool_invert( \$email_git_blame_signatures );
+                }
+                else {
+                    bool_invert( \$email_git_blame );
+                }
+                $rerun =3D 1;
+            }
+            elsif ( $sel eq "c" ) {
+                if ( $val > 0 ) {
+                    $email_git_min_signatures =3D $val;
+                    $rerun                    =3D 1;
+                }
+            }
+            elsif ( $sel eq "x" ) {
+                if ( $val > 0 ) {
+                    $email_git_max_maintainers =3D $val;
+                    $rerun                     =3D 1;
+                }
+            }
+            elsif ( $sel eq "%" ) {
+                if ( $str ne "" && $val >=3D 0 ) {
+                    $email_git_min_percent =3D $val;
+                    $rerun                 =3D 1;
+                }
+            }
+            elsif ( $sel eq "d" ) {
+                if ( vcs_is_git() ) {
+                    $email_git_since =3D $str;
+                }
+                elsif ( vcs_is_hg() ) {
+                    $email_hg_since =3D $str;
+                }
+                $rerun =3D 1;
+            }
+            elsif ( $sel eq "t" ) {
+                bool_invert( \$email_git_all_signature_types );
+                $rerun =3D 1;
+            }
+            elsif ( $sel eq "f" ) {
+                bool_invert( \$email_file_emails );
+                $rerun =3D 1;
+            }
+            elsif ( $sel eq "r" ) {
+                bool_invert( \$email_remove_duplicates );
+                $rerun =3D 1;
+            }
+            elsif ( $sel eq "m" ) {
+                bool_invert( \$email_use_mailmap );
+                read_mailmap();
+                $rerun =3D 1;
+            }
+            elsif ( $sel eq "k" ) {
+                bool_invert( \$keywords );
+                $rerun =3D 1;
+            }
+            elsif ( $sel eq "p" ) {
+                if ( $str ne "" && $val >=3D 0 ) {
+                    $pattern_depth =3D $val;
+                    $rerun         =3D 1;
+                }
+            }
+            elsif ( $sel eq "h" || $sel eq "?" ) {
+                print STDERR <<EOT;
=20
 Interactive mode allows you to select the various maintainers, submitters,
 commit signers and mailing lists that could be CC'd on a patch.
@@ -2020,26 +2084,27 @@ maintainers are appropriate.  You may enter multipl=
e selections separated
 by either commas or spaces.
=20
 EOT
-	    } else {
-		print STDERR "invalid option: '$nr'\n";
-		$redraw =3D 0;
-	    }
-	}
-	if ($rerun) {
-	    print STDERR "git-blame can be very slow, please have patience..."
-		if ($email_git_blame);
-	    goto &get_maintainers;
-	}
+            }
+            else {
+                print STDERR "invalid option: '$nr'\n";
+                $redraw =3D 0;
+            }
+        }
+        if ($rerun) {
+            print STDERR "git-blame can be very slow, please have patience=
..."
+                if ($email_git_blame);
+            goto &get_maintainers;
+        }
     }
=20
     #drop not selected entries
     $count =3D 0;
     my @new_emailto =3D ();
     foreach my $entry (@list) {
-	if ($selected{$count}) {
-	    push(@new_emailto, $list[$count]);
-	}
-	$count++;
+        if ( $selected{$count} ) {
+            push( @new_emailto, $list[$count] );
+        }
+        $count++;
     }
     return @new_emailto;
 }
@@ -2048,9 +2113,10 @@ sub bool_invert {
     my ($bool_ref) =3D @_;
=20
     if ($$bool_ref) {
-	$$bool_ref =3D 0;
-    } else {
-	$$bool_ref =3D 1;
+        $$bool_ref =3D 0;
+    }
+    else {
+        $$bool_ref =3D 1;
     }
 }
=20
@@ -2058,28 +2124,29 @@ sub deduplicate_email {
     my ($email) =3D @_;
=20
     my $matched =3D 0;
-    my ($name, $address) =3D parse_email($email);
-    $email =3D format_email($name, $address, 1);
+    my ( $name, $address ) =3D parse_email($email);
+    $email =3D format_email( $name, $address, 1 );
     $email =3D mailmap_email($email);
=20
-    return $email if (!$email_remove_duplicates);
+    return $email if ( !$email_remove_duplicates );
=20
-    ($name, $address) =3D parse_email($email);
+    ( $name, $address ) =3D parse_email($email);
=20
-    if ($name ne "" && $deduplicate_name_hash{lc($name)}) {
-	$name =3D $deduplicate_name_hash{lc($name)}->[0];
-	$address =3D $deduplicate_name_hash{lc($name)}->[1];
-	$matched =3D 1;
-    } elsif ($deduplicate_address_hash{lc($address)}) {
-	$name =3D $deduplicate_address_hash{lc($address)}->[0];
-	$address =3D $deduplicate_address_hash{lc($address)}->[1];
-	$matched =3D 1;
+    if ( $name ne "" && $deduplicate_name_hash{ lc($name) } ) {
+        $name    =3D $deduplicate_name_hash{ lc($name) }->[0];
+        $address =3D $deduplicate_name_hash{ lc($name) }->[1];
+        $matched =3D 1;
+    }
+    elsif ( $deduplicate_address_hash{ lc($address) } ) {
+        $name    =3D $deduplicate_address_hash{ lc($address) }->[0];
+        $address =3D $deduplicate_address_hash{ lc($address) }->[1];
+        $matched =3D 1;
     }
-    if (!$matched) {
-	$deduplicate_name_hash{lc($name)} =3D [ $name, $address ];
-	$deduplicate_address_hash{lc($address)} =3D [ $name, $address ];
+    if ( !$matched ) {
+        $deduplicate_name_hash{ lc($name) }       =3D [ $name, $address ];
+        $deduplicate_address_hash{ lc($address) } =3D [ $name, $address ];
     }
-    $email =3D format_email($name, $address, 1);
+    $email =3D format_email( $name, $address, 1 );
     $email =3D mailmap_email($email);
     return $email;
 }
@@ -2087,89 +2154,89 @@ sub deduplicate_email {
 sub save_commits_by_author {
     my (@lines) =3D @_;
=20
-    my @authors =3D ();
-    my @commits =3D ();
+    my @authors  =3D ();
+    my @commits  =3D ();
     my @subjects =3D ();
=20
     foreach my $line (@lines) {
-	if ($line =3D~ m/$VCS_cmds{"author_pattern"}/) {
-	    my $author =3D $1;
-	    $author =3D deduplicate_email($author);
-	    push(@authors, $author);
-	}
-	push(@commits, $1) if ($line =3D~ m/$VCS_cmds{"commit_pattern"}/);
-	push(@subjects, $1) if ($line =3D~ m/$VCS_cmds{"subject_pattern"}/);
-    }
-
-    for (my $i =3D 0; $i < @authors; $i++) {
-	my $exists =3D 0;
-	foreach my $ref(@{$commit_author_hash{$authors[$i]}}) {
-	    if (@{$ref}[0] eq $commits[$i] &&
-		@{$ref}[1] eq $subjects[$i]) {
-		$exists =3D 1;
-		last;
-	    }
-	}
-	if (!$exists) {
-	    push(@{$commit_author_hash{$authors[$i]}},
-		 [ ($commits[$i], $subjects[$i]) ]);
-	}
+        if ( $line =3D~ m/$VCS_cmds{"author_pattern"}/ ) {
+            my $author =3D $1;
+            $author =3D deduplicate_email($author);
+            push( @authors, $author );
+        }
+        push( @commits,  $1 ) if ( $line =3D~ m/$VCS_cmds{"commit_pattern"=
}/ );
+        push( @subjects, $1 ) if ( $line =3D~ m/$VCS_cmds{"subject_pattern=
"}/ );
+    }
+
+    for ( my $i =3D 0; $i < @authors; $i++ ) {
+        my $exists =3D 0;
+        foreach my $ref ( @{ $commit_author_hash{ $authors[$i] } } ) {
+            if (   @{$ref}[0] eq $commits[$i]
+                && @{$ref}[1] eq $subjects[$i] )
+            {
+                $exists =3D 1;
+                last;
+            }
+        }
+        if ( !$exists ) {
+            push( @{ $commit_author_hash{ $authors[$i] } }, [ ( $commits[$=
i], $subjects[$i] ) ] );
+        }
     }
 }
=20
 sub save_commits_by_signer {
     my (@lines) =3D @_;
=20
-    my $commit =3D "";
+    my $commit  =3D "";
     my $subject =3D "";
=20
     foreach my $line (@lines) {
-	$commit =3D $1 if ($line =3D~ m/$VCS_cmds{"commit_pattern"}/);
-	$subject =3D $1 if ($line =3D~ m/$VCS_cmds{"subject_pattern"}/);
-	if ($line =3D~ /^[ \t]*${signature_pattern}.*\@.*$/) {
-	    my @signatures =3D ($line);
-	    my ($types_ref, $signers_ref) =3D extract_formatted_signatures(@signa=
tures);
-	    my @types =3D @$types_ref;
-	    my @signers =3D @$signers_ref;
-
-	    my $type =3D $types[0];
-	    my $signer =3D $signers[0];
-
-	    $signer =3D deduplicate_email($signer);
-
-	    my $exists =3D 0;
-	    foreach my $ref(@{$commit_signer_hash{$signer}}) {
-		if (@{$ref}[0] eq $commit &&
-		    @{$ref}[1] eq $subject &&
-		    @{$ref}[2] eq $type) {
-		    $exists =3D 1;
-		    last;
-		}
-	    }
-	    if (!$exists) {
-		push(@{$commit_signer_hash{$signer}},
-		     [ ($commit, $subject, $type) ]);
-	    }
-	}
+        $commit  =3D $1 if ( $line =3D~ m/$VCS_cmds{"commit_pattern"}/ );
+        $subject =3D $1 if ( $line =3D~ m/$VCS_cmds{"subject_pattern"}/ );
+        if ( $line =3D~ /^[ \t]*${signature_pattern}.*\@.*$/ ) {
+            my @signatures =3D ($line);
+            my ( $types_ref, $signers_ref ) =3D extract_formatted_signatur=
es(@signatures);
+            my @types   =3D @$types_ref;
+            my @signers =3D @$signers_ref;
+
+            my $type   =3D $types[0];
+            my $signer =3D $signers[0];
+
+            $signer =3D deduplicate_email($signer);
+
+            my $exists =3D 0;
+            foreach my $ref ( @{ $commit_signer_hash{$signer} } ) {
+                if (   @{$ref}[0] eq $commit
+                    && @{$ref}[1] eq $subject
+                    && @{$ref}[2] eq $type )
+                {
+                    $exists =3D 1;
+                    last;
+                }
+            }
+            if ( !$exists ) {
+                push( @{ $commit_signer_hash{$signer} }, [ ( $commit, $sub=
ject, $type ) ] );
+            }
+        }
     }
 }
=20
 sub vcs_assign {
-    my ($role, $divisor, @lines) =3D @_;
+    my ( $role, $divisor, @lines ) =3D @_;
=20
     my %hash;
     my $count =3D 0;
=20
-    return if (@lines <=3D 0);
+    return if ( @lines <=3D 0 );
=20
-    if ($divisor <=3D 0) {
-	warn("Bad divisor in " . (caller(0))[3] . ": $divisor\n");
-	$divisor =3D 1;
+    if ( $divisor <=3D 0 ) {
+        warn( "Bad divisor in " . ( caller(0) )[3] . ": $divisor\n" );
+        $divisor =3D 1;
     }
=20
     @lines =3D mailmap(@lines);
=20
-    return if (@lines <=3D 0);
+    return if ( @lines <=3D 0 );
=20
     @lines =3D sort(@lines);
=20
@@ -2177,23 +2244,24 @@ sub vcs_assign {
     $hash{$_}++ for @lines;
=20
     # sort -rn
-    foreach my $line (sort {$hash{$b} <=3D> $hash{$a}} keys %hash) {
-	my $sign_offs =3D $hash{$line};
-	my $percent =3D $sign_offs * 100 / $divisor;
-
-	$percent =3D 100 if ($percent > 100);
-	next if (ignore_email_address($line));
-	$count++;
-	last if ($sign_offs < $email_git_min_signatures ||
-		 $count > $email_git_max_maintainers ||
-		 $percent < $email_git_min_percent);
-	push_email_address($line, '');
-	if ($output_rolestats) {
-	    my $fmt_percent =3D sprintf("%.0f", $percent);
-	    add_role($line, "$role:$sign_offs/$divisor=3D$fmt_percent%");
-	} else {
-	    add_role($line, $role);
-	}
+    foreach my $line ( sort { $hash{$b} <=3D> $hash{$a} } keys %hash ) {
+        my $sign_offs =3D $hash{$line};
+        my $percent   =3D $sign_offs * 100 / $divisor;
+
+        $percent =3D 100 if ( $percent > 100 );
+        next           if ( ignore_email_address($line) );
+        $count++;
+        last if ( $sign_offs < $email_git_min_signatures
+            || $count > $email_git_max_maintainers
+            || $percent < $email_git_min_percent );
+        push_email_address( $line, '' );
+        if ($output_rolestats) {
+            my $fmt_percent =3D sprintf( "%.0f", $percent );
+            add_role( $line, "$role:$sign_offs/$divisor=3D$fmt_percent%" )=
;
+        }
+        else {
+            add_role( $line, $role );
+        }
     }
 }
=20
@@ -2205,195 +2273,200 @@ sub vcs_file_signoffs {
     my $stats_ref;
     my @authors =3D ();
     my @signers =3D ();
-    my @stats =3D ();
+    my @stats   =3D ();
     my $commits;
=20
     $vcs_used =3D vcs_exists();
-    return if (!$vcs_used);
+    return if ( !$vcs_used );
=20
     my $cmd =3D $VCS_cmds{"find_signers_cmd"};
-    $cmd =3D~ s/(\$\w+)/$1/eeg;		# interpolate $cmd
+    $cmd =3D~ s/(\$\w+)/$1/eeg;    # interpolate $cmd
=20
-    ($commits, $signers_ref, $authors_ref, $stats_ref) =3D vcs_find_signer=
s($cmd, $file);
+    ( $commits, $signers_ref, $authors_ref, $stats_ref ) =3D vcs_find_sign=
ers( $cmd, $file );
=20
     @signers =3D @{$signers_ref} if defined $signers_ref;
     @authors =3D @{$authors_ref} if defined $authors_ref;
-    @stats =3D @{$stats_ref} if defined $stats_ref;
+    @stats   =3D @{$stats_ref}   if defined $stats_ref;
=20
-#    print("commits: <$commits>\nsigners:<@signers>\nauthors: <@authors>\n=
stats: <@stats>\n");
+    #    print("commits: <$commits>\nsigners:<@signers>\nauthors: <@author=
s>\nstats: <@stats>\n");
=20
     foreach my $signer (@signers) {
-	$signer =3D deduplicate_email($signer);
-    }
-
-    vcs_assign("commit_signer", $commits, @signers);
-    vcs_assign("authored", $commits, @authors);
-    if ($#authors =3D=3D $#stats) {
-	my $stat_pattern =3D $VCS_cmds{"stat_pattern"};
-	$stat_pattern =3D~ s/(\$\w+)/$1/eeg;	#interpolate $stat_pattern
-
-	my $added =3D 0;
-	my $deleted =3D 0;
-	for (my $i =3D 0; $i <=3D $#stats; $i++) {
-	    if ($stats[$i] =3D~ /$stat_pattern/) {
-		$added +=3D $1;
-		$deleted +=3D $2;
-	    }
-	}
-	my @tmp_authors =3D uniq(@authors);
-	foreach my $author (@tmp_authors) {
-	    $author =3D deduplicate_email($author);
-	}
-	@tmp_authors =3D uniq(@tmp_authors);
-	my @list_added =3D ();
-	my @list_deleted =3D ();
-	foreach my $author (@tmp_authors) {
-	    my $auth_added =3D 0;
-	    my $auth_deleted =3D 0;
-	    for (my $i =3D 0; $i <=3D $#stats; $i++) {
-		if ($author eq deduplicate_email($authors[$i]) &&
-		    $stats[$i] =3D~ /$stat_pattern/) {
-		    $auth_added +=3D $1;
-		    $auth_deleted +=3D $2;
-		}
-	    }
-	    for (my $i =3D 0; $i < $auth_added; $i++) {
-		push(@list_added, $author);
-	    }
-	    for (my $i =3D 0; $i < $auth_deleted; $i++) {
-		push(@list_deleted, $author);
-	    }
-	}
-	vcs_assign("added_lines", $added, @list_added);
-	vcs_assign("removed_lines", $deleted, @list_deleted);
+        $signer =3D deduplicate_email($signer);
+    }
+
+    vcs_assign( "commit_signer", $commits, @signers );
+    vcs_assign( "authored",      $commits, @authors );
+    if ( $#authors =3D=3D $#stats ) {
+        my $stat_pattern =3D $VCS_cmds{"stat_pattern"};
+        $stat_pattern =3D~ s/(\$\w+)/$1/eeg;    #interpolate $stat_pattern
+
+        my $added   =3D 0;
+        my $deleted =3D 0;
+        for ( my $i =3D 0; $i <=3D $#stats; $i++ ) {
+            if ( $stats[$i] =3D~ /$stat_pattern/ ) {
+                $added   +=3D $1;
+                $deleted +=3D $2;
+            }
+        }
+        my @tmp_authors =3D uniq(@authors);
+        foreach my $author (@tmp_authors) {
+            $author =3D deduplicate_email($author);
+        }
+        @tmp_authors =3D uniq(@tmp_authors);
+        my @list_added   =3D ();
+        my @list_deleted =3D ();
+        foreach my $author (@tmp_authors) {
+            my $auth_added   =3D 0;
+            my $auth_deleted =3D 0;
+            for ( my $i =3D 0; $i <=3D $#stats; $i++ ) {
+                if (   $author eq deduplicate_email( $authors[$i] )
+                    && $stats[$i] =3D~ /$stat_pattern/ )
+                {
+                    $auth_added   +=3D $1;
+                    $auth_deleted +=3D $2;
+                }
+            }
+            for ( my $i =3D 0; $i < $auth_added; $i++ ) {
+                push( @list_added, $author );
+            }
+            for ( my $i =3D 0; $i < $auth_deleted; $i++ ) {
+                push( @list_deleted, $author );
+            }
+        }
+        vcs_assign( "added_lines",   $added,   @list_added );
+        vcs_assign( "removed_lines", $deleted, @list_deleted );
     }
 }
=20
 sub vcs_file_blame {
     my ($file) =3D @_;
=20
-    my @signers =3D ();
+    my @signers     =3D ();
     my @all_commits =3D ();
-    my @commits =3D ();
+    my @commits     =3D ();
     my $total_commits;
     my $total_lines;
=20
     $vcs_used =3D vcs_exists();
-    return if (!$vcs_used);
+    return if ( !$vcs_used );
=20
-    @all_commits =3D vcs_blame($file);
-    @commits =3D uniq(@all_commits);
+    @all_commits   =3D vcs_blame($file);
+    @commits       =3D uniq(@all_commits);
     $total_commits =3D @commits;
-    $total_lines =3D @all_commits;
+    $total_lines   =3D @all_commits;
=20
     if ($email_git_blame_signatures) {
-	if (vcs_is_hg()) {
-	    my $commit_count;
-	    my $commit_authors_ref;
-	    my $commit_signers_ref;
-	    my $stats_ref;
-	    my @commit_authors =3D ();
-	    my @commit_signers =3D ();
-	    my $commit =3D join(" -r ", @commits);
-	    my $cmd;
-
-	    $cmd =3D $VCS_cmds{"find_commit_signers_cmd"};
-	    $cmd =3D~ s/(\$\w+)/$1/eeg;	#substitute variables in $cmd
-
-	    ($commit_count, $commit_signers_ref, $commit_authors_ref, $stats_ref)=
 =3D vcs_find_signers($cmd, $file);
-	    @commit_authors =3D @{$commit_authors_ref} if defined $commit_authors=
_ref;
-	    @commit_signers =3D @{$commit_signers_ref} if defined $commit_signers=
_ref;
-
-	    push(@signers, @commit_signers);
-	} else {
-	    foreach my $commit (@commits) {
-		my $commit_count;
-		my $commit_authors_ref;
-		my $commit_signers_ref;
-		my $stats_ref;
-		my @commit_authors =3D ();
-		my @commit_signers =3D ();
-		my $cmd;
-
-		$cmd =3D $VCS_cmds{"find_commit_signers_cmd"};
-		$cmd =3D~ s/(\$\w+)/$1/eeg;	#substitute variables in $cmd
-
-		($commit_count, $commit_signers_ref, $commit_authors_ref, $stats_ref) =
=3D vcs_find_signers($cmd, $file);
-		@commit_authors =3D @{$commit_authors_ref} if defined $commit_authors_re=
f;
-		@commit_signers =3D @{$commit_signers_ref} if defined $commit_signers_re=
f;
-
-		push(@signers, @commit_signers);
-	    }
-	}
+        if ( vcs_is_hg() ) {
+            my $commit_count;
+            my $commit_authors_ref;
+            my $commit_signers_ref;
+            my $stats_ref;
+            my @commit_authors =3D ();
+            my @commit_signers =3D ();
+            my $commit         =3D join( " -r ", @commits );
+            my $cmd;
+
+            $cmd =3D $VCS_cmds{"find_commit_signers_cmd"};
+            $cmd =3D~ s/(\$\w+)/$1/eeg;    #substitute variables in $cmd
+
+            ( $commit_count, $commit_signers_ref, $commit_authors_ref, $st=
ats_ref ) =3D vcs_find_signers( $cmd, $file );
+            @commit_authors =3D @{$commit_authors_ref} if defined $commit_=
authors_ref;
+            @commit_signers =3D @{$commit_signers_ref} if defined $commit_=
signers_ref;
+
+            push( @signers, @commit_signers );
+        }
+        else {
+            foreach my $commit (@commits) {
+                my $commit_count;
+                my $commit_authors_ref;
+                my $commit_signers_ref;
+                my $stats_ref;
+                my @commit_authors =3D ();
+                my @commit_signers =3D ();
+                my $cmd;
+
+                $cmd =3D $VCS_cmds{"find_commit_signers_cmd"};
+                $cmd =3D~ s/(\$\w+)/$1/eeg;    #substitute variables in $c=
md
+
+                ( $commit_count, $commit_signers_ref, $commit_authors_ref,=
 $stats_ref ) =3D vcs_find_signers( $cmd, $file );
+                @commit_authors =3D @{$commit_authors_ref} if defined $com=
mit_authors_ref;
+                @commit_signers =3D @{$commit_signers_ref} if defined $com=
mit_signers_ref;
+
+                push( @signers, @commit_signers );
+            }
+        }
     }
=20
     if ($from_filename) {
-	if ($output_rolestats) {
-	    my @blame_signers;
-	    if (vcs_is_hg()) {{		# Double brace for last exit
-		my $commit_count;
-		my @commit_signers =3D ();
-		@commits =3D uniq(@commits);
-		@commits =3D sort(@commits);
-		my $commit =3D join(" -r ", @commits);
-		my $cmd;
-
-		$cmd =3D $VCS_cmds{"find_commit_author_cmd"};
-		$cmd =3D~ s/(\$\w+)/$1/eeg;	#substitute variables in $cmd
-
-		my @lines =3D ();
-
-		@lines =3D &{$VCS_cmds{"execute_cmd"}}($cmd);
-
-		if (!$email_git_penguin_chiefs) {
-		    @lines =3D grep(!/${penguin_chiefs}/i, @lines);
-		}
-
-		last if !@lines;
-
-		my @authors =3D ();
-		foreach my $line (@lines) {
-		    if ($line =3D~ m/$VCS_cmds{"author_pattern"}/) {
-			my $author =3D $1;
-			$author =3D deduplicate_email($author);
-			push(@authors, $author);
-		    }
-		}
-
-		save_commits_by_author(@lines) if ($interactive);
-		save_commits_by_signer(@lines) if ($interactive);
-
-		push(@signers, @authors);
-	    }}
-	    else {
-		foreach my $commit (@commits) {
-		    my $i;
-		    my $cmd =3D $VCS_cmds{"find_commit_author_cmd"};
-		    $cmd =3D~ s/(\$\w+)/$1/eeg;	#interpolate $cmd
-		    my @author =3D vcs_find_author($cmd);
-		    next if !@author;
-
-		    my $formatted_author =3D deduplicate_email($author[0]);
-
-		    my $count =3D grep(/$commit/, @all_commits);
-		    for ($i =3D 0; $i < $count ; $i++) {
-			push(@blame_signers, $formatted_author);
-		    }
-		}
-	    }
-	    if (@blame_signers) {
-		vcs_assign("authored lines", $total_lines, @blame_signers);
-	    }
-	}
-	foreach my $signer (@signers) {
-	    $signer =3D deduplicate_email($signer);
-	}
-	vcs_assign("commits", $total_commits, @signers);
-    } else {
-	foreach my $signer (@signers) {
-	    $signer =3D deduplicate_email($signer);
-	}
-	vcs_assign("modified commits", $total_commits, @signers);
+        if ($output_rolestats) {
+            my @blame_signers;
+            if ( vcs_is_hg() ) {
+                {    # Double brace for last exit
+                    my $commit_count;
+                    my @commit_signers =3D ();
+                    @commits =3D uniq(@commits);
+                    @commits =3D sort(@commits);
+                    my $commit =3D join( " -r ", @commits );
+                    my $cmd;
+
+                    $cmd =3D $VCS_cmds{"find_commit_author_cmd"};
+                    $cmd =3D~ s/(\$\w+)/$1/eeg;    #substitute variables i=
n $cmd
+
+                    my @lines =3D ();
+
+                    @lines =3D &{ $VCS_cmds{"execute_cmd"} }($cmd);
+
+                    if ( !$email_git_penguin_chiefs ) {
+                        @lines =3D grep( !/${penguin_chiefs}/i, @lines );
+                    }
+
+                    last if !@lines;
+
+                    my @authors =3D ();
+                    foreach my $line (@lines) {
+                        if ( $line =3D~ m/$VCS_cmds{"author_pattern"}/ ) {
+                            my $author =3D $1;
+                            $author =3D deduplicate_email($author);
+                            push( @authors, $author );
+                        }
+                    }
+
+                    save_commits_by_author(@lines) if ($interactive);
+                    save_commits_by_signer(@lines) if ($interactive);
+
+                    push( @signers, @authors );
+                }
+            }
+            else {
+                foreach my $commit (@commits) {
+                    my $i;
+                    my $cmd =3D $VCS_cmds{"find_commit_author_cmd"};
+                    $cmd =3D~ s/(\$\w+)/$1/eeg;    #interpolate $cmd
+                    my @author =3D vcs_find_author($cmd);
+                    next if !@author;
+
+                    my $formatted_author =3D deduplicate_email( $author[0]=
 );
+
+                    my $count =3D grep( /$commit/, @all_commits );
+                    for ( $i =3D 0; $i < $count; $i++ ) {
+                        push( @blame_signers, $formatted_author );
+                    }
+                }
+            }
+            if (@blame_signers) {
+                vcs_assign( "authored lines", $total_lines, @blame_signers=
 );
+            }
+        }
+        foreach my $signer (@signers) {
+            $signer =3D deduplicate_email($signer);
+        }
+        vcs_assign( "commits", $total_commits, @signers );
+    }
+    else {
+        foreach my $signer (@signers) {
+            $signer =3D deduplicate_email($signer);
+        }
+        vcs_assign( "modified commits", $total_commits, @signers );
     }
 }
=20
@@ -2403,14 +2476,14 @@ sub vcs_file_exists {
     my $exists;
=20
     my $vcs_used =3D vcs_exists();
-    return 0 if (!$vcs_used);
+    return 0 if ( !$vcs_used );
=20
     my $cmd =3D $VCS_cmds{"file_exists_cmd"};
-    $cmd =3D~ s/(\$\w+)/$1/eeg;		# interpolate $cmd
+    $cmd =3D~ s/(\$\w+)/$1/eeg;    # interpolate $cmd
     $cmd .=3D " 2>&1";
-    $exists =3D &{$VCS_cmds{"execute_cmd"}}($cmd);
+    $exists =3D &{ $VCS_cmds{"execute_cmd"} }($cmd);
=20
-    return 0 if ($? !=3D 0);
+    return 0 if ( $? !=3D 0 );
=20
     return $exists;
 }
@@ -2421,13 +2494,13 @@ sub vcs_list_files {
     my @lsfiles =3D ();
=20
     my $vcs_used =3D vcs_exists();
-    return 0 if (!$vcs_used);
+    return 0 if ( !$vcs_used );
=20
     my $cmd =3D $VCS_cmds{"list_files_cmd"};
-    $cmd =3D~ s/(\$\w+)/$1/eeg;   # interpolate $cmd
-    @lsfiles =3D &{$VCS_cmds{"execute_cmd"}}($cmd);
+    $cmd =3D~ s/(\$\w+)/$1/eeg;    # interpolate $cmd
+    @lsfiles =3D &{ $VCS_cmds{"execute_cmd"} }($cmd);
=20
-    return () if ($? !=3D 0);
+    return () if ( $? !=3D 0 );
=20
     return @lsfiles;
 }
@@ -2436,7 +2509,7 @@ sub uniq {
     my (@parms) =3D @_;
=20
     my %saw;
-    @parms =3D grep(!$saw{$_}++, @parms);
+    @parms =3D grep( !$saw{$_}++, @parms );
     return @parms;
 }
=20
@@ -2445,7 +2518,7 @@ sub sort_and_uniq {
=20
     my %saw;
     @parms =3D sort @parms;
-    @parms =3D grep(!$saw{$_}++, @parms);
+    @parms =3D grep( !$saw{$_}++, @parms );
     return @parms;
 }
=20
@@ -2454,42 +2527,46 @@ sub clean_file_emails {
     my @fmt_emails =3D ();
=20
     foreach my $email (@file_emails) {
-	$email =3D~ s/[\(\<\{]{0,1}([A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+)[\)\>\}]{=
0,1}/\<$1\>/g;
-	my ($name, $address) =3D parse_email($email);
-	if ($name eq '"[,\.]"') {
-	    $name =3D "";
-	}
-
-	my @nw =3D split(/[^A-Za-z=C3=80-=C3=BF\'\,\.\+-]/, $name);
-	if (@nw > 2) {
-	    my $first =3D $nw[@nw - 3];
-	    my $middle =3D $nw[@nw - 2];
-	    my $last =3D $nw[@nw - 1];
-
-	    if (((length($first) =3D=3D 1 && $first =3D~ m/[A-Za-z]/) ||
-		 (length($first) =3D=3D 2 && substr($first, -1) eq ".")) ||
-		(length($middle) =3D=3D 1 ||
-		 (length($middle) =3D=3D 2 && substr($middle, -1) eq "."))) {
-		$name =3D "$first $middle $last";
-	    } else {
-		$name =3D "$middle $last";
-	    }
-	}
-
-	if (substr($name, -1) =3D~ /[,\.]/) {
-	    $name =3D substr($name, 0, length($name) - 1);
-	} elsif (substr($name, -2) =3D~ /[,\.]"/) {
-	    $name =3D substr($name, 0, length($name) - 2) . '"';
-	}
-
-	if (substr($name, 0, 1) =3D~ /[,\.]/) {
-	    $name =3D substr($name, 1, length($name) - 1);
-	} elsif (substr($name, 0, 2) =3D~ /"[,\.]/) {
-	    $name =3D '"' . substr($name, 2, length($name) - 2);
-	}
-
-	my $fmt_email =3D format_email($name, $address, $email_usename);
-	push(@fmt_emails, $fmt_email);
+        $email =3D~ s/[\(\<\{]{0,1}([A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+)[\=
)\>\}]{0,1}/\<$1\>/g;
+        my ( $name, $address ) =3D parse_email($email);
+        if ( $name eq '"[,\.]"' ) {
+            $name =3D "";
+        }
+
+        my @nw =3D split( /[^A-Za-z=C3=80-=C3=BF\'\,\.\+-]/, $name );
+        if ( @nw > 2 ) {
+            my $first  =3D $nw[ @nw - 3 ];
+            my $middle =3D $nw[ @nw - 2 ];
+            my $last   =3D $nw[ @nw - 1 ];
+
+            if (( ( length($first) =3D=3D 1 && $first =3D~ m/[A-Za-z]/ ) |=
| ( length($first) =3D=3D 2 && substr( $first, -1 ) eq "." ) )
+                || ( length($middle) =3D=3D 1
+                    || ( length($middle) =3D=3D 2 && substr( $middle, -1 )=
 eq "." ) )
+                )
+            {
+                $name =3D "$first $middle $last";
+            }
+            else {
+                $name =3D "$middle $last";
+            }
+        }
+
+        if ( substr( $name, -1 ) =3D~ /[,\.]/ ) {
+            $name =3D substr( $name, 0, length($name) - 1 );
+        }
+        elsif ( substr( $name, -2 ) =3D~ /[,\.]"/ ) {
+            $name =3D substr( $name, 0, length($name) - 2 ) . '"';
+        }
+
+        if ( substr( $name, 0, 1 ) =3D~ /[,\.]/ ) {
+            $name =3D substr( $name, 1, length($name) - 1 );
+        }
+        elsif ( substr( $name, 0, 2 ) =3D~ /"[,\.]/ ) {
+            $name =3D '"' . substr( $name, 2, length($name) - 2 );
+        }
+
+        my $fmt_email =3D format_email( $name, $address, $email_usename );
+        push( @fmt_emails, $fmt_email );
     }
     return @fmt_emails;
 }
@@ -2499,15 +2576,16 @@ sub merge_email {
     my %saw;
=20
     for (@_) {
-	my ($address, $role) =3D @$_;
-	if (!$saw{$address}) {
-	    if ($output_roles) {
-		push(@lines, "$address ($role)");
-	    } else {
-		push(@lines, $address);
-	    }
-	    $saw{$address} =3D 1;
-	}
+        my ( $address, $role ) =3D @$_;
+        if ( !$saw{$address} ) {
+            if ($output_roles) {
+                push( @lines, "$address ($role)" );
+            }
+            else {
+                push( @lines, $address );
+            }
+            $saw{$address} =3D 1;
+        }
     }
=20
     return @lines;
@@ -2517,48 +2595,50 @@ sub output {
     my (@parms) =3D @_;
=20
     if ($output_multiline) {
-	foreach my $line (@parms) {
-	    print("${line}\n");
-	}
-    } else {
-	print(join($output_separator, @parms));
-	print("\n");
+        foreach my $line (@parms) {
+            print("${line}\n");
+        }
+    }
+    else {
+        print( join( $output_separator, @parms ) );
+        print("\n");
     }
 }
=20
 my $rfc822re;
=20
 sub make_rfc822re {
-#   Basic lexical tokens are specials, domain_literal, quoted_string, atom=
, and
-#   comment.  We must allow for rfc822_lwsp (or comments) after each of th=
ese.
-#   This regexp will only work on addresses which have had comments stripp=
ed
-#   and replaced with rfc822_lwsp.
+
+    #   Basic lexical tokens are specials, domain_literal, quoted_string, =
atom, and
+    #   comment.  We must allow for rfc822_lwsp (or comments) after each o=
f these.
+    #   This regexp will only work on addresses which have had comments st=
ripped
+    #   and replaced with rfc822_lwsp.
=20
     my $specials =3D '()<>@,;:\\\\".\\[\\]';
     my $controls =3D '\\000-\\037\\177';
=20
-    my $dtext =3D "[^\\[\\]\\r\\\\]";
+    my $dtext          =3D "[^\\[\\]\\r\\\\]";
     my $domain_literal =3D "\\[(?:$dtext|\\\\.)*\\]$rfc822_lwsp*";
=20
     my $quoted_string =3D "\"(?:[^\\\"\\r\\\\]|\\\\.|$rfc822_lwsp)*\"$rfc8=
22_lwsp*";
=20
-#   Use zero-width assertion to spot the limit of an atom.  A simple
-#   $rfc822_lwsp* causes the regexp engine to hang occasionally.
-    my $atom =3D "[^$specials $controls]+(?:$rfc822_lwsp+|\\Z|(?=3D[\\[\"$=
specials]))";
-    my $word =3D "(?:$atom|$quoted_string)";
+    #   Use zero-width assertion to spot the limit of an atom.  A simple
+    #   $rfc822_lwsp* causes the regexp engine to hang occasionally.
+    my $atom      =3D "[^$specials $controls]+(?:$rfc822_lwsp+|\\Z|(?=3D[\=
\[\"$specials]))";
+    my $word      =3D "(?:$atom|$quoted_string)";
     my $localpart =3D "$word(?:\\.$rfc822_lwsp*$word)*";
=20
     my $sub_domain =3D "(?:$atom|$domain_literal)";
-    my $domain =3D "$sub_domain(?:\\.$rfc822_lwsp*$sub_domain)*";
+    my $domain     =3D "$sub_domain(?:\\.$rfc822_lwsp*$sub_domain)*";
=20
     my $addr_spec =3D "$localpart\@$rfc822_lwsp*$domain";
=20
-    my $phrase =3D "$word*";
-    my $route =3D "(?:\@$domain(?:,\@$rfc822_lwsp*$domain)*:$rfc822_lwsp*)=
";
+    my $phrase     =3D "$word*";
+    my $route      =3D "(?:\@$domain(?:,\@$rfc822_lwsp*$domain)*:$rfc822_l=
wsp*)";
     my $route_addr =3D "\\<$rfc822_lwsp*$route?$addr_spec\\>$rfc822_lwsp*"=
;
-    my $mailbox =3D "(?:$addr_spec|$phrase$route_addr)";
+    my $mailbox    =3D "(?:$addr_spec|$phrase$route_addr)";
=20
-    my $group =3D "$phrase:$rfc822_lwsp*(?:$mailbox(?:,\\s*$mailbox)*)?;\\=
s*";
+    my $group   =3D "$phrase:$rfc822_lwsp*(?:$mailbox(?:,\\s*$mailbox)*)?;=
\\s*";
     my $address =3D "(?:$mailbox|$group)";
=20
     return "$rfc822_lwsp*$address";
@@ -2566,13 +2646,18 @@ sub make_rfc822re {
=20
 sub rfc822_strip_comments {
     my $s =3D shift;
-#   Recursively remove comments, and replace with a single space.  The sim=
pler
-#   regexps in the Email Addressing FAQ are imperfect - they will miss esc=
aped
-#   chars in atoms, for example.
=20
-    while ($s =3D~ s/^((?:[^"\\]|\\.)*
+    #   Recursively remove comments, and replace with a single space.  The=
 simpler
+    #   regexps in the Email Addressing FAQ are imperfect - they will miss=
 escaped
+    #   chars in atoms, for example.
+
+    while (
+        $s =3D~ s/^((?:[^"\\]|\\.)*
                     (?:"(?:[^"\\]|\\.)*"(?:[^"\\]|\\.)*)*)
-                    \((?:[^()\\]|\\.)*\)/$1 /osx) {}
+                    \((?:[^()\\]|\\.)*\)/$1 /osx
+        )
+    {
+    }
     return $s;
 }
=20
@@ -2581,7 +2666,7 @@ sub rfc822_strip_comments {
 sub rfc822_valid {
     my $s =3D rfc822_strip_comments(shift);
=20
-    if (!$rfc822re) {
+    if ( !$rfc822re ) {
         $rfc822re =3D make_rfc822re();
     }
=20
@@ -2601,19 +2686,21 @@ sub rfc822_valid {
 sub rfc822_validlist {
     my $s =3D rfc822_strip_comments(shift);
=20
-    if (!$rfc822re) {
+    if ( !$rfc822re ) {
         $rfc822re =3D make_rfc822re();
     }
+
     # * null list items are valid according to the RFC
     # * the '1' business is to aid in distinguishing failure from no resul=
ts
=20
     my @r;
-    if ($s =3D~ m/^(?:$rfc822re)?(?:,(?:$rfc822re)?)*$/so &&
-	$s =3D~ m/^$rfc822_char*$/) {
-        while ($s =3D~ m/(?:^|,$rfc822_lwsp*)($rfc822re)/gos) {
-            push(@r, $1);
+    if (   $s =3D~ m/^(?:$rfc822re)?(?:,(?:$rfc822re)?)*$/so
+        && $s =3D~ m/^$rfc822_char*$/ )
+    {
+        while ( $s =3D~ m/(?:^|,$rfc822_lwsp*)($rfc822re)/gos ) {
+            push( @r, $1 );
         }
-        return wantarray ? (scalar(@r), @r) : 1;
+        return wantarray ? ( scalar(@r), @r ) : 1;
     }
     return wantarray ? () : 0;
 }

--=20
2.42.0.582.g8ccd20d70d-goog

