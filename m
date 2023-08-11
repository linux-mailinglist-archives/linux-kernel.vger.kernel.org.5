Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD400778635
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjHKDsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjHKDse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:48:34 -0400
Received: from sonic309-25.consmr.mail.gq1.yahoo.com (sonic309-25.consmr.mail.gq1.yahoo.com [98.137.65.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1708271B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1691725710; bh=NLdXBpcpi60kipC/kOSajFw8jygoNTvhv+qTHtaLJDk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=tO0pOBNtfVArn0Bd8IRvPWfgB2Bcel/wOmNwKEWg8NFMGtE4XtsiJlGGKavhzSR1ddj9+/rv1Hf/Aa1q4znFqmFHZUZhkL/8GFfUo8QWgtC2Nsz0I8rX+B0/5TWEN3G7u/dmrg4StG344oJNPNMG8amKUmk17IF/6iXUPD01eR4=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1691725710; bh=M/nKhs1vLR8ghEpP3LQHthk2YJOS7jDUD2SqasVP06C=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=cBsJ7t/pVMnP2fOIu1dnaRAJVoaZpn/q9PvkLLBTY7gw42Z1dXpamrbGIC3nHnvaxyL87BIg9UqBG30BOqcjUOCT2K3iiJC0HXLVKvimFK91UOqFVcoUlHK4Ef4SQzKmJjMURBbk+cgAq5Exf3AXTxPWejn680aJZ8tMGqEBHp0SAYCUAUi/+uFXH54aUDZf1XVPyhmCcev2rYw8IXo0O2wVyDpOQsvxspoLQ5q0OgWjv0+goBE1EwYtwXqJyoTeT019ZpT0CoA1LDiTIWwqo7gy3cZ4ZGLMwbDFUu5WXFUgZu0428gjCSddjlShWzHdTM4/72Qh7W6hVOSB6tHorQ==
X-YMail-OSG: y8PjfssVM1lKZURoKw6TWr6haDDecNBzriTBi0G2HSJA3bF1CGnssnA1ODsovAr
 EklFPahHDrCeL4zoExMpWbZXdJLffdpqPA87.gCfZ3UHpDiO6YjOHH83bn.32PmRSm42wC5OngmW
 bPb14aT4EhuObH0.d0W2STRp8o3QTvapPh5Py1HNx7A8q4ZUrSK_WvV33bf6SN3gQr9w2zkgId91
 ycJpFUt9MX0Faho8.RVP_tVCXXqIkYkwC4UEH6bAJ_0c5cgL370vPWhOEoDkrJwpEcOnsdHwM_Nr
 rDjoDniaq6aChPMGrPAK3aQm_1UUjCqT4ZglIGwllD1Omz7xKjjOasYRjxILmCl7M2cdSlbLLuTc
 jZecW2Uf2Ye6Rw75YC.qzGWvqz4Kv9bfjxz4O2CJDgxJVh_txgEOt5r0vQlTNzZNgRFtGa8Aqt6k
 QcgSYoyXEbbZzVPFedVpo5nPvGJSzXoi1ef5FC6heJgVDEQNkvdSQEBhdlRar_YyC8ceyHPKyVWm
 GRSGoI4FummLYZNpBelj0_Ui6qwpParjGcb4s3xM3p_8iGiSC9NfnxWcve6eZWGkLdZFTl_MjUM.
 VwiMP.g99U.TD5n5P2e.fmJq5GYP.Xf6EsPHr2f6DherQR5xuNoBbcLYyljkdEX0tbEBgtjhkMTe
 5iSr2NrL7dxbgjCwC2Cl8tgLpgMiFS3YYbNa_B.DeQd5Id1TTLhT2PH_RrzgVI78mbSEJn3Iy1zu
 gwNC30VKrg2nsO2jn3NIfS3FQCCvoYzWzC_xY4WazjKYQeRMZHMJvxagEDn80ccyAcaI1Jl3IaKE
 ARDNNtndBwddcLQ4n65Fir3iDVwm5.QlW..cFXXC.SyWfmhlm6sOwXqD5_au_3s3EGFJKrY_gQV.
 m1Gf1BSBS.R7i7Kg6gfJuAZC3lDZvJG5WUDTbf5O2GsKVINk3arwGQtYQdUxr7SjfwPQ4iKF6uXb
 IUJJjhWv7E4eSUa.MTaAGsd2PtlELp2eX10X90jR77DyPaLm7dIqIa_oFDc71FuEu7F6mehAl1so
 p9eQ515JTbE_wZf7sB.vtvc4vfPjlrI9O4DVl33KDFDcCzfn6pOYJU4Ck6pbX0jY7UkyR5v5ssvZ
 NLjnYxyWwL29PVAtEeyPRhdzoJvc206uLIxQVep4QMKeZNhN0unWZcqPImnxNhtE7x1XQlFegleN
 ZfnWOe2HbplUkOOO6b0LWhiTVrcVGhDpRG9nvunJy91bjN1CutaB7JUfekBEtlZ6r7B6LdAhgUhG
 uc29kiCfA8FoPhH.jgqzWSTdwSrP32rsXUo6pT.wy7s_sPD_ivOBU136LhlubtwoqeHCGPIXpz3M
 QXfku2WIKFl8tglgs0B5deFmHKQndT8Soao4IBtpS3lySY7VMZDRpLb6WCnCEjkqKp80S_rB8zoY
 Q455JMk7J0Tt566cjKblulH5mOiLlE2UpV_GPBiBGW0vQaRQD5nHUGUrBUkvbjnrBPysO3oR3c5M
 FAb9sAOJahSufJbGuBZlgjHbtW..niuO9XIpXqs7UOcMlV5H4.1oMaAcCJYsys4_n_MZYNlyZ5vi
 aCJhre7I4afT38zHS0nZsxwkAWFNN2ujPnl5ScT8W3gjfzABfM4c_uXQQPIxCGRvI5VEVShig1HE
 Zao3q_yUCBL5.Bcz8Yto1KQiKY6DwuOyWo.CkTM5h3O2lY.xVX24JcI4iA3dr5ySNUY1o34z2LHv
 1BloFD_SLSKYCsNs689ktxyRJs4AwEg7mGxbBczUxvzCQ9fLsfAffsQu2SiV0.Z1RVYXT0Vp9Y33
 SSMczsVtKh7FojgJlBx0HtzZQfaoI0uPmlcralFd9IQ2anl9OGqwiWkvv.Z9riFps8CmqRa1gHhK
 YdKoEuegBqeF_i1E9UArlLr5sLx_EKOfelN9SFHrXzrHDX7IsahLd0CAvm6m0uQLPfVHEz4zZG42
 ulRG2T9IxtjHNn6OG.aG5I7FNJ2kfizKvxA9ZDBZMpeLZuE3.83FamlFhJhe7JMdUpP3ZIBcc0IF
 8ls12YWPB_bS5QegKfrUjatwJ8YyXMYZq3e6.AjZ9V1Oq2spWNmIUnEy3XDxlM3jke6tKdh4A4nK
 oj9PFqMfCwHJQueC8_1vfMtU.nX8kcG2HflUnSJlRdavNalW2_1cxbEcnoRFdJDvwIabr2pqxq0G
 Inm4tz8hn0Koodq5FyTTtNIkK5OglLChI.vTdQg6esGLiypfY.9FoxcPteKmCL3Ib2ZSHB5U_V17
 9kRv7xZ7UMhoDnUBHKlY6RBbllUgGcFuzvhXmq0ZKwmub7w--
X-Sonic-MF: <lesrhorer@att.net>
X-Sonic-ID: ff0799a5-16a9-4def-8471-2a276ca8da86
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Fri, 11 Aug 2023 03:48:30 +0000
Received: by hermes--production-bf1-865889d799-7vf9r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID af749de47665fc8a294a907e1ae52cbd;
          Fri, 11 Aug 2023 03:48:25 +0000 (UTC)
Message-ID: <06bc7efa-c486-f995-a73c-3f1dd6a5ce64@att.net>
Date:   Thu, 10 Aug 2023 22:48:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Majordomo not working
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        pmladek@suse.com
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y9BIU5SGOS6YEdSh@bombadil.infradead.org>
From:   Leslie Rhorer <lesrhorer@att.net>
In-Reply-To: <Y9BIU5SGOS6YEdSh@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21695 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	I know this is not exactly the right place to post this, but I am at a 
complete loss what else to do.  Please forgive me, but I cannot get the 
Majordomo at vger.kernel.org to respond to me.  I have tried everything 
of which I can think, but the Majordomo will not recognize when I send 
it the authorization command in order to try and include my 
siliconventures.net address in the linux-modules mailing list.  My 
att.net address is supposed to already be a member of the list, but 
whenever I send to the linux-modules list from mt AT&T address, the 
message bounces.

	Thus , I seem to be having two issues.  The more immediate is I cannot 
get any messages through to where they need to go, both to the Majordomo 
and to the linux-modules list.  The more important long term issue is I 
am having a problem with the NIC card on one of my Debian Linux servers.
