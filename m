Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371C37802BB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 02:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356429AbjHRAeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 20:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbjHRAdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 20:33:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A642D57
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 17:33:53 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37I0SLFh004597;
        Fri, 18 Aug 2023 00:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version : date; s=pp1;
 bh=da7gOKCb2v8bre6F6rl/YUuuzGXYCG/8B9NFQ6AVEzo=;
 b=hKuIvcnqQ8QRKqY8rV5sbblLTjsN7ZA7Uu5SxjeZnsjF0U4XU6BohS1bEY2dd9HbxL0b
 fFWIOkQpvTYbaX/xl4eeIOqP6aGGnLQ3/sYTWE6tc/Njna/eo0RY/EAjsfFKo8fL1Y3r
 pYlKJS5A/aB4j73+g0oAlru8axOzrv0/D6HUt+yBkgpJFu5a6DD8R8fRRW0jnUh2aMfd
 5ivy9LmwW03sgmhGtO7kKPwHDOzQEBMu/e7pEf59EeTRDP/u9dGl6KJ2p/WX3CTdWDWb
 Bl4lAOeqFGvdLa6lPT7bYE7tZtftZjCKbEhDA+5JgNwsQKf0SdaZn+W+PF9QdABHvNCr jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3shx4gg4t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 00:33:43 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37I0TTeM007649;
        Fri, 18 Aug 2023 00:33:42 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3shx4gg4st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 00:33:42 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37I0IgiF003439;
        Fri, 18 Aug 2023 00:33:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3semdt35xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 00:33:41 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37I0XeFk23659262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 00:33:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CD3D20043;
        Fri, 18 Aug 2023 00:33:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 823DF20040;
        Fri, 18 Aug 2023 00:33:39 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 18 Aug 2023 00:33:39 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (unknown [9.43.196.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 35578600D8;
        Fri, 18 Aug 2023 10:33:33 +1000 (AEST)
Message-ID: <98defebbdd3f0be69f76f5e6c3d7b72935f072a9.camel@linux.ibm.com>
Subject: Re: [PATCH] [next] initramfs: Parse KBUILD_BUILD_TIMESTAMP as UTC
 date
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        masahiroy@kernel.org, bgray@linux.ibm.com, n.schier@avm.de
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org
In-Reply-To: <ZMSdUS37BD5b/dn7@mail.google.com>
References: <ZMSdUS37BD5b/dn7@mail.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Fri, 18 Aug 2023 10:32:46 +1000
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nTgcWjmR_d80ClDnFH-T5JrTazVX2cUa
X-Proofpoint-GUID: agY3MHL1_OKPvw9MSJ_rPxqzJT1s7EGb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_18,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 mlxlogscore=999
 spamscore=0 clxscore=1011 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180003
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-07-29 at 17:02 +1200, Paulo Miguel Almeida wrote:
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
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$ date -d"1970-01-01" +%s
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-43200
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$ make KBUILD_BUILD_TIMES=
TAMP=3D1970-01-01
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0make[1]: Entering directo=
ry '<snip>/linux/'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GEN=C2=A0=C2=A0=C2=
=A0=C2=A0 Makefile
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DESCEND objtool
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INSTALL libsubcmd_=
headers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CALL=C2=A0=C2=A0=
=C2=A0 ../scripts/checksyscalls.sh
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GEN=C2=A0=C2=A0=C2=
=A0=C2=A0 usr/initramfs_data.cpio
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ERROR: Timestamp out of r=
ange for cpio format
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0make[4]: *** [../usr/Make=
file:76: usr/initramfs_data.cpio]
> Error 1
>=20
> =C2=A0- In Seattle, WA (UTC-07:00):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$ date -d"1970-01-01" +%s
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A032400
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$ make KBUILD_BUILD_TIMES=
TAMP=3D1970-01-01
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<builds fine>
>=20
> Parse KBUILD_BUILD_TIMESTAMP date string as UTC so no localtime
> conversion is done which fixes the edge case aforementioned.
>=20
> Signed-off-by: Paulo Miguel Almeida
> <paulo.miguel.almeida.rodenas@gmail.com>

This should also be documented in Documentation/kbuild/kbuild.rst,
including a note that you can still use local time if you include the
timezone specifier.

Thanks,
--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
