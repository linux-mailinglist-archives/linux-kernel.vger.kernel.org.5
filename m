Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB2C7D232D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 15:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjJVNSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 09:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVNSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 09:18:10 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284C4A1;
        Sun, 22 Oct 2023 06:18:05 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39MDA9B1024218;
        Sun, 22 Oct 2023 13:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=FozGdIRQmW2EWY82p0+85v8JSoc6DFTbluojPbCfYpI=;
 b=CvijnA/XVqP6m/hUU7yVVZk2vlh+AwWiQ4Frvgko18WP4fiaYphbOF8Jys0Cy1UjwfI3
 rKyEKl1NyDdkM3fZuQqXyUiWOe0qfFGO7p76VYpRgTbKT3CkC1qiThJ1BFxaA/6/38oS
 ZGeAmbzkUVfTlGNFgYMOwo6cpBRdeNjOtNrqdsR4jP4P43+8vLAIO9au/VCoI4uO+TMt
 CdHPbBPhjV3kNx5EDn701pUrJSFGLKar7P7DbmVvBzSY4kVogYwdAYHSaebQOmjh9b6S
 o044hPfJCG4MaG/aEFxWOKxp6gk7EmlYmuLD4SuhT4ddqJ/vBMAgFjvHDcokIPCY+FbW YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tw4cjr4g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Oct 2023 13:18:01 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39MDBBml027279;
        Sun, 22 Oct 2023 13:18:00 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tw4cjr4fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Oct 2023 13:18:00 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39MAkWr8012399;
        Sun, 22 Oct 2023 13:18:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvup1aaxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Oct 2023 13:17:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39MDHvbj45154598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Oct 2023 13:17:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 111A720043;
        Sun, 22 Oct 2023 13:17:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 715C020040;
        Sun, 22 Oct 2023 13:17:56 +0000 (GMT)
Received: from localhost (unknown [9.171.9.54])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sun, 22 Oct 2023 13:17:56 +0000 (GMT)
Date:   Sun, 22 Oct 2023 15:17:54 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [GIT PULL] s390 fixes for 6.6-rc7
Message-ID: <your-ad-here.call-01697980674-ext-9589@work.hours>
References: <your-ad-here.call-01697881440-ext-2458@work.hours>
 <CAHk-=wgTUz1bdY6zvsN4ED0arCLE8Sb==1GH8d0sjm5bu7zesQ@mail.gmail.com>
 <CAHk-=wjxAk=PQBX4OvscNfGKfc+M8iKmNd6D39wOZzXV0k729w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjxAk=PQBX4OvscNfGKfc+M8iKmNd6D39wOZzXV0k729w@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aPVmjF00rwTxrNjB_9hQ_Bj55XRM0iMD
X-Proofpoint-GUID: amtIQaC2dMxAfJ0XIJ_PzqcYIFVYY9uv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-22_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310220120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 11:08:31AM -0700, Linus Torvalds wrote:
> in case you or somebody has a better idea for BITS_TO_LONG handling
> than just "you need to check for zero before and after".
> 
> On Sat, 21 Oct 2023 at 10:56, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > If you *do* want to add proper overflow handling, you'd need to either
> > fix BITS_TO_LONGS() some way (which is actually non-trivial since it
> > needs to be able to stay a constant and only use the argument once),
> > or you do something like
> >
> >         if (!bits)
> >                 return ZERO_SIZE_PTR;
> >         longs = BITS_TO_LONG(bits);
> >         if (!longs)
> >                 return NULL;
> >         return vzalloc(longs * sizeof(long));

This might work.

BITS_TO_<TYPE>(bits) utilizes __KERNEL_DIV_ROUND_UP, which may potentially
result in an overflow condition when

	bits > ULONG_MAX - sizeof(<TYPE>) * 8 + 1.

To resolve this issue, avoid using the overflow-prone
__KERNEL_DIV_ROUND_UP. To meet the requirements of BITS_TO<TYPE>(bits)
for remaining constant and preventing side effects from multiple
argument uses, employ __is_constexpr to differentiate between constant
and non-constant cases, employing a helper function in the latter.

In the constant case, this ensures compatibility with constructs like
DECLARE_BITMAP. While in the non-constant case, the __bits_to_elem_count
function could be optimized for potentially improved code generation
by compilers, though this might come at the expense of readability and
visual consistency between the constant and non-constant cases.
I could further investigate if this approach, in general, appears acceptable.
---
 include/linux/bitops.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e067fe..72be25d4b95d 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -15,11 +15,21 @@
 #  define aligned_byte_mask(n) (~0xffUL << (BITS_PER_LONG - 8 - 8*(n)))
 #endif
 
+static inline unsigned long __bits_to_elem_count(size_t nr, size_t sz)
+{
+	return nr / sz + (nr % sz ? 1 : 0);
+}
+
+#define BITS_TO_ELEM_COUNT(nr, sz)					\
+	__builtin_choose_expr(__is_constexpr(nr),			\
+			     (nr) / sz + ((nr) % sz ? 1 : 0),		\
+			     __bits_to_elem_count((nr), sz))
+
 #define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
-#define BITS_TO_LONGS(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
-#define BITS_TO_U64(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
-#define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
-#define BITS_TO_BYTES(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
+#define BITS_TO_LONGS(nr)	BITS_TO_ELEM_COUNT(nr, BITS_PER_TYPE(long))
+#define BITS_TO_U64(nr)		BITS_TO_ELEM_COUNT(nr, BITS_PER_TYPE(u64))
+#define BITS_TO_U32(nr)		BITS_TO_ELEM_COUNT(nr, BITS_PER_TYPE(u32))
+#define BITS_TO_BYTES(nr)	BITS_TO_ELEM_COUNT(nr, BITS_PER_TYPE(char))
 
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
-- 
2.39.2

