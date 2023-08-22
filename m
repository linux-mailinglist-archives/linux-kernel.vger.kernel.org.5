Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FDE78383A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjHVC7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjHVC7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:59:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587A3184
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:59:29 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37M2p47Q009298;
        Tue, 22 Aug 2023 02:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=MMwpKZTR3loitLXFWxg9FyWYJi69JC54MDLGW2Rxaik=;
 b=T81PzbdUlOp/KZfeN2QXUlp/zvFl6IrMbHJ7F98V1ofolG6+4IhLpjwtM848Y2LDUQOQ
 yKWZNQrHLrNe/Qtb7uNXLl2Y7MybYJdPn/gWk596zIzoS60IzBY2oNnA4gX8BJuE4B9F
 Qg6CpyGM5Gul3eh5lacRR/OcOL1ntsGnHYaYw4R6CXRiUtkizxUTUkhryVTdiR2zaN8c
 MU+JgCZV6zbuum/G/EiNa3fecx6mvBafBk9cUTX4O6bmfToAzIUn+2sd76iOawSrQ5d1
 lu0HqInh5KgL2v0obtiLQGq/m+2ZrLqxaOg7yQKR881eQ90DlB8VZrugxsnDBsfJDjAm Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3smmkn03ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 02:59:22 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37M2pYfY011129;
        Tue, 22 Aug 2023 02:59:22 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3smmkn03tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 02:59:21 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37M1FF7l007242;
        Tue, 22 Aug 2023 02:59:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3smc7w36yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 02:59:21 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37M2xJB524379974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Aug 2023 02:59:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C61D20049;
        Tue, 22 Aug 2023 02:59:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 708EE20040;
        Tue, 22 Aug 2023 02:59:18 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 22 Aug 2023 02:59:18 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 629A360113;
        Tue, 22 Aug 2023 12:59:15 +1000 (AEST)
Message-ID: <6672135f7db2ae6481b605d7d33f2265a562712f.camel@linux.ibm.com>
Subject: Re: [PATCH v2] [next] initramfs: Parse KBUILD_BUILD_TIMESTAMP as
 UTC date
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        masahiroy@kernel.org, bgray@linux.ibm.com, n.schier@avm.de
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org
Date:   Tue, 22 Aug 2023 12:59:15 +1000
In-Reply-To: <ZOPTbkHvj8XQiott@mail.google.com>
References: <ZOPTbkHvj8XQiott@mail.google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HiRkfrUS_4nZYAGFmDMo2ewKwDgumj-c
X-Proofpoint-ORIG-GUID: fG2oGBsHWrjXLQGmQ5jB4BB_znbUNj2i
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_13,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220019
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-08-22 at 09:13 +1200, Paulo Miguel Almeida wrote:
> When KBUILD_BUILD_TIMESTAMP is specified, the date command will parse
> it to Unix Epoch time in UTC. However, the date command is
> timezone-aware so it will convert from the local timezone to UTC
> first
> which hits some of the sanity checks added on commit 5efb685bb3af1
> ("initramfs: Check negative timestamp to prevent broken cpio
> archive")
>=20
> This creates an edge case for the UTC+<N> part of the world. For
> instance
>=20
> =C2=A0- In New Zealand (UTC+12:00):
> =C2=A0=C2=A0=C2=A0=C2=A0 $ date -d"1970-01-01" +%s
> =C2=A0=C2=A0=C2=A0=C2=A0 -43200
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 $ make KBUILD_BUILD_TIMESTAMP=3D1970-01-01
> =C2=A0=C2=A0=C2=A0=C2=A0 make[1]: Entering directory '<snip>/linux/'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0 Makefile
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DESCEND objtool
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INSTALL libsubcmd_headers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CALL=C2=A0=C2=A0=C2=A0 ../scripts/ch=
ecksyscalls.sh
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0 usr/init=
ramfs_data.cpio
> =C2=A0=C2=A0=C2=A0=C2=A0 ERROR: Timestamp out of range for cpio format
> =C2=A0=C2=A0=C2=A0=C2=A0 make[4]: *** [../usr/Makefile:76: usr/initramfs_=
data.cpio] Error
> 1
>=20
> =C2=A0- In Seattle, WA (UTC-07:00):
> =C2=A0=C2=A0=C2=A0=C2=A0 $ date -d"1970-01-01" +%s
> =C2=A0=C2=A0=C2=A0=C2=A0 32400
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 $ make KBUILD_BUILD_TIMESTAMP=3D1970-01-01
> =C2=A0=C2=A0=C2=A0=C2=A0 <builds fine>
>=20
> Parse KBUILD_BUILD_TIMESTAMP date string as UTC so no localtime
> conversion is done, which fixes the edge case aforementioned
>=20
> Signed-off-by: Paulo Miguel Almeida
> <paulo.miguel.almeida.rodenas@gmail.com>

Thanks!

Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>

> ---
> Changelog:
>=20
> - v2: Document behaviour and way to override it on
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Documentation/kbuild/kbuild.rst. (Req: And=
rew Donnellan)
>=20
> - v1:
> https://lore.kernel.org/lkml/ZMSdUS37BD5b%2Fdn7@mail.google.com/
> ---
> =C2=A0Documentation/kbuild/kbuild.rst | 9 ++++++++-
> =C2=A0usr/gen_initramfs.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A02 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/kbuild/kbuild.rst
> b/Documentation/kbuild/kbuild.rst
> index bd906407e307..8c204186c762 100644
> --- a/Documentation/kbuild/kbuild.rst
> +++ b/Documentation/kbuild/kbuild.rst
> @@ -296,7 +296,14 @@ KBUILD_BUILD_TIMESTAMP
> =C2=A0Setting this to a date string overrides the timestamp used in the
> =C2=A0UTS_VERSION definition (uname -v in the running kernel). The value
> has to
> =C2=A0be a string that can be passed to date -d. The default value
> -is the output of the date command at one point during build.
> +is the output of the date command at one point during build. E.g.::
> +
> +=C2=A0=C2=A0=C2=A0 $ make KBUILD_BUILD_TIMESTAMP=3D"1991-08-25"
> +
> +By default, the value is interpreted as UTC. To override this,
> append
> +the desired timezone. E.g.::
> +
> +=C2=A0=C2=A0=C2=A0 $ make KBUILD_BUILD_TIMESTAMP=3D"1991-08-25 UTC+03:00"
> =C2=A0
> =C2=A0KBUILD_BUILD_USER, KBUILD_BUILD_HOST
> =C2=A0------------------------------------
> diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
> index 14b5782f961a..a90316d9a080 100755
> --- a/usr/gen_initramfs.sh
> +++ b/usr/gen_initramfs.sh
> @@ -221,7 +221,7 @@ while [ $# -gt 0 ]; do
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0shi=
ft
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0;;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"-d")=C2=A0=C2=A0=C2=A0# date for file mtimes
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0timestamp=
=3D"$(date -d"$1" +%s || :)"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0timestamp=
=3D"$(date -d"$1" -u +%s || :)"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if =
test -n "$timestamp"; then
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0timestamp=3D"-t $timestamp"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
