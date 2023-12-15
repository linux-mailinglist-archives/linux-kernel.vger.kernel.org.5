Return-Path: <linux-kernel+bounces-1832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 542B381549D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB351F258A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F8456390;
	Fri, 15 Dec 2023 23:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="dppXAbEc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B636456380
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1702683814;
	bh=X52KSOowDpoAN2/LFdbP/Y6i6s1LAR7ZCBgSZlrjJgg=;
	h=Date:From:To:Subject:From;
	b=dppXAbEcRJ8iMCotNQD7ZU5OOimFY/0Z/q7OPHGNN3db2jUEArx2UPa0R7SQjSPv9
	 01PHU/la7pTFvbEZhRxVdmPjnZOKwNXX7BuSWeDkA2tA8syaPKbDACHm0pUCBOl3tW
	 ZGjndfIBv7HnkIuV+uygtfhiwCuE/OcieI2HesMOmE+Dd7Z/8gJ63P9Vg9n1q6Kdcg
	 9yoldamq6283AHF83mri2LcZluzoju6eqcZsCnr8W0YU7i+gcZ4FCvRMClnx+b6fMw
	 C2oZ/lTrxdKRsjjezPL7mnmJgpiYEsuf9wzqJFgTYZAAUURJpyRt7CyK+tJq2TXbk4
	 KwGqO+6L4VCGA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id AA4F91399C;
	Sat, 16 Dec 2023 00:43:34 +0100 (CET)
Date: Sat, 16 Dec 2023 00:43:34 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] checkpatch: don't take signature to be part of the commit
 SHA
Message-ID: <fx6bkooamii3p5sa74i7x5xqsehezfgskpyq5v7f47bqi56bgb@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ec5xqngclvlcjozk"
Content-Disposition: inline
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--ec5xqngclvlcjozk
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
v1: https://lore.kernel.org/lkml/cmhc6xudksabuza2jrhgs5yg2a2xbohadyyazitg64=
63uskhjp@enclcjvmbx4r/
v2: https://lore.kernel.org/lkml/yobkleyyfic3cxlslgwft7eomzc4k2e4r6goy2x3xh=
bnzvee46@2u4treiamxdy/
v2 RESEND: https://lore.kernel.org/lkml/rxy7gchww3kwb3vltenfsq3qbrjuv3s4rg4=
jrvopejwekesxya@k2z4k54jp2od/

No changes. Reapplied to master and sending again because it bit me again.

 scripts/checkpatch.pl | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 25fdb7fda112..fa1ce85dd2c4 100755
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
@@ -1166,7 +1167,7 @@ sub seed_camelcase_includes {
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
@@ -1228,7 +1229,7 @@ sub git_commit_info {
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
@@ -1279,7 +1280,7 @@ if ($git) {
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

base-commit: 26aff849438cebcd05f1a647390c4aa700d5c0f1
--=20
2.39.2

--ec5xqngclvlcjozk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV85KYACgkQvP0LAY0m
WPFDUBAAhK4ipdjKD8317Lw6RRQBhyQcPgKqZJ0R1JpG68pZPtoaTyt/fjfawaw+
PTA2Pv1mPBCdo0hfozyZMXHtDnWFJ7sXw9wbnvPeG9lB9m/3B0lBBgjt2ffykSmO
tSlq+54yV/44a8VOciXvTpSLDn+yrntMVejZJ5IQ0TfBpY79rOU1kHLC3Cuooa3f
g050ZiNum+1NcWrdUoeY67Ikgt1nx5zP6tCyUKJO0Sef6sQD3MZZiokeKNxm+Yqj
VXZ6Mrs2z5IRGOkckalwAznbAOq4RRwTXPrGj0QpdnzXXj9GvCI5j3nhREIuF0Bi
AWmcaet39hikSap4TjbFZXUKltwBSG6RvUGDfBE7WWK4SkiNOTd7CtTtNtggGtIH
TOXj/skgxvBZsfFSPOPJsWdrVdTbLTiDpa3+oypmnklGxDdsrBmluAVi88qhiJXf
IhIxp3qFRWRMgf2scnfzwyFfN1c1zo8yxyEbOUaIHnQEvDB8qg47jfI7A6DfRBZf
YmnKXeBe/8RgiuACx4DSZfL/YEY3NaJ8hndcXPV5n2pt7YHzYILN8Nbwfsmpuu6b
tQPMeT38AwqwzNwfdWKGBfx5rtfv67CctsLM0U+9MrtD3IsM/IqjKI/kMqAPz1Q3
stqfJoIveWqLmS9wrHq93FB4YgRsgkfS6peA4MkYM+gD0XJ6lpc=
=7Uam
-----END PGP SIGNATURE-----

--ec5xqngclvlcjozk--

