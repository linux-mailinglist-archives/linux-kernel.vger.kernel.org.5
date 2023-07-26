Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A6B762B27
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjGZGLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjGZGLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:11:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94F910B;
        Tue, 25 Jul 2023 23:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690351846; x=1690956646; i=efault@gmx.de;
 bh=pmVD+3FXDOIySM8L/dNVyDU03+BJJU6WxydMHdkVqZ0=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=L9/WgD5qRZoyhQciRjHMRO9sSnxjcz5swVMd1/QFzRpD1eT/PDbsylHUr5lHL9FLA73259S
 JsKWhan/cZNzMQxqrgg7n6uuU2BJdBFGbcPjfs8MTd90a5jz1WHezGnvQSmwdb02Sghwbsxh7
 +IWcBnM3u9KG8hjk5agzYPeKU9CDCLcCJ9+XKfmMSSneEJsDQ1DlgULbpI1ZXsztJp/wRkdzR
 Nz1tDf2TqCTOAuUsuKLpuSVYn+6tqbP+cpy56SiXaGEXpGlBl5mPZzhasP32vZ4hJ8ZTcipZ0
 Oq1NZWOi6XqWYhSL2VbadnrwSub9ewwMZzZgu9kNUuiCsde1lsZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.218]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhD6W-1pu8rn3JQI-00eJDn; Wed, 26
 Jul 2023 08:10:45 +0200
Message-ID: <e368f2c848d77fbc8d259f44e2055fe469c219cf.camel@gmx.de>
Subject: Re: 'perf test sigtrap' failing on PREEMPT_RT_FULL
From:   Mike Galbraith <efault@gmx.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-rt-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        ThomasGleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Wed, 26 Jul 2023 08:10:45 +0200
In-Reply-To: <ZMAtZ2t43GXoF6tM@kernel.org>
References: <ZMAtZ2t43GXoF6tM@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tFomh51HarlLrgYqs7Ahj091uxhl/LdMRpz1QiGrQjsN/9ZogOx
 erWuxuhIFuYrlbmka9NLGZg+1UsO5YoXPO/5Pos04fTfn3s3RghWEIZnISxYVPwql5CNb/c
 MexrGU3SAkDAI7Qirt9Y7g6NySDaXFBAlLm1NNrs+y642B1d9km7Fej1gmZoZ4mh44shNdI
 86mk0PrwAYFbRTLAB17LA==
UI-OutboundReport: notjunk:1;M01:P0:BqEQPilMj9A=;r6kvVaW4pGDCM5z55y/bkn7s5k7
 SkCvS3t2AUokSHUomifXqYXRFdzvpbj0zBTTvC5mmQluq7Y7YiroJ0JgafkDMfg/BTqF4vLVs
 7wX7Lp5vBTlsstq+zpebgqKoez8sPo8fYaTNSr7T3NHApKijEilUqmBVqBIuuvLFo6hdjheMB
 ldVfOgybGMswB3M1tVVIxot9I7jzskGZdb1NDzMSq8WtEa3BjVV0OqCHmjGV0UTi7AnLcMWwG
 HfqdWjs+fbDgSMWQSpLqXgsK2OUjIQYQIb9aTwjlnZSwo3oxe3Fx01mKdkB/0b53YTEHxzGEb
 mqqzXBVdugEKutBrYmjEa1pIIGQIXb7jqgPkVu3BLGXIcmRIaAN3V+yTrhjBkPjWojINd5xU4
 nnnYzrhIYtT9EewTJPAnY/x75aaXZYypeOXu7zQ5JKAm1SvriN4BQTE5hf6s3pAFOjG8R/WPq
 7c+ZqKT0BjtoJkI92fgMaQObP6zz3wdOAO6UGv68ZaM58kLSk5mXsRqhqvnKvBKLcJ3K+C7Fx
 p95WZjGWuhjvf6SN5sBsJ3aJAkIYQVyHYE+QPf2Dwxf9wwrscTETAFTXNP6C6zw3eKlpKni8/
 k7dG2J9kT5slwEJf3iHt5JNjWLgVFgf2d0+O+zA4LyW1VD4ouXTZ8XTf3B3jkQxGJeX2F7S6/
 JMvy/QKSN1aVRsvbvB3xWKT0ry4qITPnJAfJ3dEawGufrn7jXmeNsuDy9Qts9BnxJaoIZFmo5
 DDZAXioZOprqS/Xmm9J8/vF8IYHdc1yZQMrczXBiMCPDoGhYYZWYjHgHb/7OIjkDzxBMnb8vR
 n1MB9U9XDZaH0NntfSEoo0DsUy1VJ4xyvKtZ3KF11IOIS6Bq1lfDW5kxPhufC787pqtguhg/5
 LN1pa2dvHAc28gdoQroTIAcrvonjPxitCW0PIVfaE8O6LfEg1ruWQSy//6hLnzYcN6GM7iRSv
 AD91QQcNF5Glx7qfvltHaFiMB8s=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-25 at 17:15 -0300, Arnaldo Carvalho de Melo wrote:
> Hi Marco, Peter,
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0I got a report that 'per=
f test sigtrap' test failed on a
> PREEMPT_RT_FULL kernel, one that had up to:
>
> commit 97ba62b278674293762c3d91f724f1bb922f04e0
> Author: Marco Elver <elver@google.com>
> Date:=C2=A0=C2=A0 Thu Apr 8 12:36:01 2021 +0200
>
> =C2=A0=C2=A0=C2=A0 perf: Add support for SIGTRAP on perf events
> ...

> [=C2=A0=C2=A0 52.848925] BUG: scheduling while atomic: perf/6549/0x00000=
002

Had bf9ad37dc8a not been reverted due to insufficient beauty, you could
trivially make the sigtrap test a happy camper (wart tested in tip-rt).

	-Mike

@@ -1829,6 +1869,9 @@ int send_sig_perf(void __user *addr, u32
 				     TRAP_PERF_FLAG_ASYNC :
 				     0;

+	if (force_sig_delayed(&info, current))
+		return 0;
+
 	return send_sig_info(info.si_signo, &info, current);
 }



