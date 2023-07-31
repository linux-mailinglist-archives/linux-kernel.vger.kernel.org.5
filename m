Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECA57696B4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjGaMrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjGaMqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:46:44 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1AD22128
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1690807567;
        bh=gkt0rIqkUhHlExY4cS774r8mZa6RShIBQ5xwZJifOGA=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=gDgkZC1SHcBGjwdzSOrh14xZq6Rnem5ixqY9Au3dq9UYcY9Q+rOpTBYXAO+ysuwyI
         Fna5ExqvxpaKnV8YQ5eVY8ZZHW4KPJX7CfRnin1gvAucCx4grdoS3Gcw+aOPrcnIAR
         kNgClwbG2rddNifKf355pphKQfbeBdxNLJtLpAuqxANQBh2+ipvLrg+fO3m7QKeFN9
         RuR8kZEuzQeIDxtvKcXVhqVphaD0ca7iwfVUTd03e9udOEGz4VhZKLN+w0xNIQ8NtL
         O6s2x2D0EUsNQV9NLEfmp+qaa+4VrTQkcE4pBA/QTZRbbO1AV5TGrij7rqguN8Dnmr
         iX/0WxxQmC+3g==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 5ECE34C96;
        Mon, 31 Jul 2023 14:46:07 +0200 (CEST)
Date:   Mon, 31 Jul 2023 14:46:06 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2] checkpatch: don't take signature to be part of the
 commit SHA
Message-ID: <rxy7gchww3kwb3vltenfsq3qbrjuv3s4rg4jrvopejwekesxya@k2z4k54jp2od>
References: <yobkleyyfic3cxlslgwft7eomzc4k2e4r6goy2x3xhbnzvee46@2u4treiamxdy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zbb544vyg5m3kjn7"
Content-Disposition: inline
In-Reply-To: <yobkleyyfic3cxlslgwft7eomzc4k2e4r6goy2x3xhbnzvee46@2u4treiamxdy>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zbb544vyg5m3kjn7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I had just received:
  $ scripts/checkpatch.pl 0001-splice-always-fsnotify_access-in-fsnotify_mo=
dify-out.patch
  WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<ti=
tle line>")' - ie: 'Fixes: gpg: Signatu (":35 CEST")'
  #25:
  Fixes: 983652c69199 ("splice: report related fsnotify events")

  total: 0 errors, 1 warnings, 60 lines checked

  NOTE: For some of the reported defects, checkpatch may be able to
        mechanically convert to the typical style using --fix or --fix-inpl=
ace.

  0001-splice-always-fsnotify_access-in-fsnotify_modify-out.patch has style=
 problems, please review.

  NOTE: If any of the errors are false positives, please report
        them to the maintainer, see CHECKPATCH in MAINTAINERS.

This fails when the Fixes:ed SHAs are signed, since the output is
  $ git log --format=3D'%H %s'
  gpg: Signature made Wed 28 Jun 2023 19:05:02 CEST
  gpg:                using RSA key 7D69474E84028C5CC0C44163BCFD0B018D2658F1
  gpg: Good signature from "=D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczlewe=
li.xyz>" [ultimate]
  gpg:                 aka "=D0=BD=D0=B0=D0=B1 <nabijaczleweli@gmail.com>" =
[ultimate]
  gpg:                 aka "nabijaczleweli <nabijaczleweli@gmail.com>" [ult=
imate]
  53307062b2b644dc0de7bde916d6193492f37643 splice: fsnotify_access(in), fsn=
otify_modify(out) on success in tee
or
  $ git log --format=3D'%H %s' 983652c69199
  gpg: Signature made Tue 04 Apr 2023 15:57:35 CEST
  gpg:                using EDDSA key 408734571EA70C78B332692891C61BC06578D=
CA2
  gpg: Can't check signature: No public key
  983652c691990b3257a07f67f4263eb847baa82d splice: report related fsnotify =
events

The fix mimics what was done in commit f24fb53984cf ("perf tools: Don't
include signature in version strings"): just don't ask for the
signatures being validated.

With this, my patch passed validation.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
No-change rebase of v2.

 scripts/checkpatch.pl | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 880fde13d9b8..734c7d4a4ac7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -71,6 +71,7 @@ my $color =3D "auto";
 my $allow_c99_comments =3D 1; # Can be overridden by --ignore C99_COMMENT_=
TOLERANCE
 # git output parsing needs US English output, so first set backtick child =
process LANGUAGE
 my $git_command =3D'export LANGUAGE=3Den_US.UTF-8; git';
+my $git_log_no =3D "--no-show-signature --no-color";
 my $tabsize =3D 8;
 my ${CONFIG_} =3D "CONFIG_";
=20
@@ -1164,7 +1165,7 @@ sub seed_camelcase_includes {
 	$camelcase_seeded =3D 1;
=20
 	if (-e "$gitroot") {
-		my $git_last_include_commit =3D `${git_command} log --no-merges --pretty=
=3Dformat:"%h%n" -1 -- include`;
+		my $git_last_include_commit =3D `${git_command} log ${git_log_no} --no-m=
erges --pretty=3Dformat:"%h%n" -1 -- include`;
 		chomp $git_last_include_commit;
 		$camelcase_cache =3D ".checkpatch-camelcase.git.$git_last_include_commit=
";
 	} else {
@@ -1226,7 +1227,7 @@ sub git_commit_info {
=20
 	return ($id, $desc) if ((which("git") eq "") || !(-e "$gitroot"));
=20
-	my $output =3D `${git_command} log --no-color --format=3D'%H %s' -1 $comm=
it 2>&1`;
+	my $output =3D `${git_command} log ${git_log_no} --format=3D'%H %s' -1 $c=
ommit 2>&1`;
 	$output =3D~ s/^\s*//gm;
 	my @lines =3D split("\n", $output);
=20
@@ -1277,7 +1278,7 @@ if ($git) {
 		} else {
 			$git_range =3D "-1 $commit_expr";
 		}
-		my $lines =3D `${git_command} log --no-color --no-merges --pretty=3Dform=
at:'%H %s' $git_range`;
+		my $lines =3D `${git_command} log ${git_log_no} --no-merges --pretty=3Df=
ormat:'%H %s' $git_range`;
 		foreach my $line (split(/\n/, $lines)) {
 			$line =3D~ /^([0-9a-fA-F]{40,40}) (.*)$/;
 			next if (!defined($1) || !defined($2));
--=20
2.39.2

--zbb544vyg5m3kjn7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmTHrQ0ACgkQvP0LAY0m
WPFSUw//QdKu5w48p2Xa5JYfsOGlZ3mcuCxXsap36cNjh06CZjahhMiS5/82Zmi3
e/D7x0jfL+rHltNU3O2Kx4k6fBJ71jttNM93b1JuPPt2bSpaz0PF9WdHaeu992xV
gC59zAHFw3ypDk4ofqywF7IPSyrYU+FTyQ6ZR6kUz/nvO06gQfba5NwMWZq0QSqp
mRhKDbcVxQkwRxDgqrLrh4A5hjbg50/ZPEOiAusb7awL9JRUbTg3fzIBV5qJA2WO
fRUnsmJmBeTWkfnl7A1qM11rPj6d45wbO+nq5W30UwwUvtDvAhXdDEuRN7oXbuuE
GjlPQRzGoe0vXP15cLzVWBNxfc5HM+qp696GBcns0AWPCSVKBBTebWkIJ/P3hCsx
FztZQrKcV+5U068t47gmOHwASeRGPTAz9Dbf/UmPYRgq8WSbISMNdHFtf5EF4J/V
CegN6h0KSf1Mnh+L4BFT7c4PZoLJBkQioZ7MQ/lbDTAVKRAJjL7c9tNSAGukg1Sc
GTT/HUcFF1Z/Uk8msQWO9uduRRDspMe0SwOlb7DTC0sRpWsSdNRD0tpGmv/CQ/jE
0N9bdR41j4PCVwX5eHJrXjo1EqYnH29PJaH33qcZ9k/SPRMQ9KCusysgioGhNaT3
5p3K53sLpMxXdqNL3+IJJKPJgYZP2U+WkW39YV7353LN042RP04=
=ZFNB
-----END PGP SIGNATURE-----

--zbb544vyg5m3kjn7--
