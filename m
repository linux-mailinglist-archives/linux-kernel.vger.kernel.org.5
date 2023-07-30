Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34441768656
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 18:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjG3QJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 12:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjG3QJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 12:09:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CF610F9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 09:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690733356; x=1691338156; i=efault@gmx.de;
 bh=30KU6uhA2dYHzSo+IuxIfT+wc1vnoytUNnxdaHVwU04=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=ny85DKkVL3UimhYcC3Wh+BYRpLdHOJiFn9X/1lc4XWQ69unj9g9Av5pXtF83ygWvmNzxPM+
 ipgy+AC/bfjUr8I5dxzeU9dBUvM9k35etfDetlxDO+hgWndulN7ez6ZWlvJzfN9OvKKCo6z08
 pbJwHlMHyilCSy8ZL51qukSf2xKpMRBY832UFBgl4kR1EQZFgg4YJF3g4g9kKs3z0qIT0HWJx
 BGUTOZ28LCKGYa9TDVihHE0GtwHRBT5RmmMsOG6nsWbu73jpUm9iwxdFn7bk/HRwGpvhPZj3X
 VROAkfzdBGXJi2A64Qkmz/eeZt6bqiQKEtxfh6sTigoVxPYJ0XvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.149.208]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hzj-1pgjt511j5-011l3r; Sun, 30
 Jul 2023 18:09:16 +0200
Message-ID: <8c56256399e2e6c41bc574749d6170d5529f24fc.camel@gmx.de>
Subject: Re: arm64: perf test 26 rpi4 oops
From:   Mike Galbraith <efault@gmx.de>
To:     Will Deacon <will@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Date:   Sun, 30 Jul 2023 18:09:15 +0200
In-Reply-To: <20230728141852.GA21718@willie-the-truck>
References: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
         <20230728141852.GA21718@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u1OuaKafwCesQFew5dhGh/4P0ibEODRjLUO1MgtdymAL5jrnwxz
 ZCwzUxfqPbLYaeLsMKUO+oievmIte/K1y6lYvgUeSsIa899OpXz/WhrlIHjW39PM+jHWgsw
 l0Cotj4s3+B/OdVt6diXjHUZNHClYvmoeBcdRw8MWT7yhpmT83YRInquixMHTgXB9igKloM
 4CPjJhThcrF2Ls1DPyrGg==
UI-OutboundReport: notjunk:1;M01:P0:ipSK4lrVGE8=;fZ4XnU9Ewaty9D6gMOdefnw1EkG
 PJ5rhTPAzHPzfHcyrd/kjsV+tgqXeJIkhFuaVLVU9a6K9ukW0JJqLn2FYbwMs7Zxnjn2tRLfM
 mu1Jdo6zrvydWKJkr7fSmRLQKoovzqZqlHBmoe+4v8Yi42+SyZiYAhr4pHRwvY3W8PXUGKD5y
 ZGXALX0illzUB01siw2N0mXBPJNX3xYyiHco2BRXalu6R8hpaz7dcySyffp9dyVnRAAnRXjc0
 L7MJYmtqO92XVizopQxhRXZY/2DS1AYqEWiy0+bdMnejJ97Sy3tER8Vctc4N9NjHrNs2J6p5L
 U6SOxAYDNxbKgh0GPxvBWzcx77Mi6R6ULXUAbVPPbZY/Xd/zFHacxWfyLr8/mX4azSFnsnLAT
 xPqLW2b2xj16Bjb/e0Ggfml6JHWso+PoeoEgHKWCsUugSIMfrsBf/LwafoxVdJSsikJqGOPUf
 6db0Q75g5CgnHP64CMEQF8r92iASbjy/OBuzwxOY63oo2G4Gih/Yqve/0YGMX+Tk0I2mlSfxY
 A+Ib4+0uyWK699y6M6gR/2clkR3GLAH7FVr5dYHinprdGlYSBLLpoafOAmMhS3KUyeLQEt27N
 yrqTMrPvI40R7+UdUccBiJPDL7+lE1WAMfjw2k/VuC0EbRZqT6r1URsOKCcNO02Pi1awpZUmE
 Ut48bqw+/ZHkko8HJs20eDEPZLj5dug2xRskAP1/Xy9zerjhPHcVrIFY5qZpqMgRQu6t+i660
 FlV5I5lJSI5iwVZjc2SOBi2BnFxBYCQS8vAcHv2xp1ymWaU3U9N/T9e9+K2g9m8unRERsgSVg
 A04BYTmQt8vpdqdZ2hwD89QdJLEXk6OK7lWEv63PbhnAzhZw2Lsp5qzGGCz7E29SZ+7mH116z
 mJEeJHJwLbQS0oGoCKFPREjTC07W49YkilEXnybnkujnGDPgkUN0tu47mmOlFcClg4HvDLbHK
 gmOdAZlByUrbkVBm4h3Rdlbi6xk=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-28 at 15:18 +0100, Will Deacon wrote:
>
> Looking at this quickly with Mark, the most likely explanation is that
> a bogus kernel address is being passed as the source pointer to
> copy_to_user().

'start' in read_kcore_iter() is bogus a LOT when running perf test 26,
and that back to at least 5.15.  Seems removal of bogon-proofing gave a
toothless old bug teeth, but seemingly only to perf test 26.  Rummaging
around with crash vmlinux /proc/kcore seems to be bogon free anyway.

Someone should perhaps take a peek at perf.  Bogons aside, it also
doesn't seem to care deeply about kernel response.  Whether the kernel
oops or I bat 945 bogons aside, it says 'OK'.  That seems a tad odd.

	-Mike
