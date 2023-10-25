Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241347D5F1B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjJYAhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjJYAhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:37:53 -0400
Received: from out203-205-251-82.mail.qq.com (out203-205-251-82.mail.qq.com [203.205.251.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA4A9F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1698194267;
        bh=0KqtPlkMXope95NR0/xm224zF04p2pWTZxB68OVS11w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=w5i6dBH9T68iwruLFKrOV9lkN3UEdVid5gYb7GCMDUerSvDV12UFJMqi0BtDyKQ+3
         jZZs3ejqq0JyizejSHBByvfaktz4RDEBGSGiO4oQfK5ga2u+Y3TyAlNPig/PZ32dFe
         ZAE5vS3bCbffWsgoD2eB8y9VnsXgvTg9nS9B5CZw=
Received: from RT-NUC.. ([39.156.73.12])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id 96D3F02D; Wed, 25 Oct 2023 08:37:45 +0800
X-QQ-mid: xmsmtpt1698194265tfm9ud90l
Message-ID: <tencent_0821AFD8A3B188E906574290598D97B42A08@qq.com>
X-QQ-XMAILINFO: MyHh0PQai9FpwDirSAjGbYAO6AtHKWB7xawBDw+lEGp5XryY4MxzP+oNVRBIE1
         QiBfMLH2iRovJxDCT1l0pxX3OCDsw6qQby9Mbbr8uXXS5L5coF+vpu4WW6nQStu2MMj9jW3LvkJ/
         lAVvCk+yClAL6Mf3aiCAOiSFTIDkQM3I7Ydr/9M+bgfCAcY4YY0GKISejOQIu2IA+d2RK1MqoywR
         8HiRNtsFn8suw/CqLa1MKYdFjrAzUP4jgC9QFgU9170nlObuJDCu7CdiRmdz6xAr488puPDKxEbW
         /ub46q/12U+9ZTv9EKHiw9cXEWAYSG0NmXIqhNnlV/ztmUauYI/fhkvNy0GjTbouOn3p6SGREigQ
         34a6lYk8zGYqYm8LEaCrHsxh+V7OdwkU4E4wt9dft2O7mCjCwwcuP3awHFK5XK9jO1vuo5HCRcGy
         3m/5LPo8vtcS54XXjULHg38CO2Xj35T34UUbhLBEUwuhexKFWZZ0XaFE3W6EVghvFcFylxREGBZK
         RZYhtPGb7mNzDZEYo6eA4uunV4kIL8VYWZLBXrCeKjiMZ65+3cOl0HOQbIVgsq1t501S4abDWGPe
         wzJgyvYSqQ6c749R/3Jl0Imdl5XFENCCnmb9qZPhothRpspUhNIEjlihjQMGZqB3wXWw9aaP76rm
         hALNhU28usFWz70sKKHJuik56fvABLsUJTAnmKZqtO2d1ujXwzw21ZaTpndwdLJWRiyMRnlq/AZk
         NMNAg59tZhsZj//mydjJnnCSlYfPwBhko3sK24HaPmpPys8s3lvLvOz02gPiI9M8fyLFx/HDmRv3
         sDVBGzr2jVPK1FF9WgnnWW+fs7Nle/H8Sp5dPBEb8i5NfwugzcEqWTxhLPA1v6AJ+44bdeY/35dD
         K0QGpOowYx9KHWmN5qdD7AwuKfQX5PiwDFn2dA+WcVw7u0xL9IueEFFlN5H8vLFFtDvNHPWWLUra
         6BdxbBFeza3IQkQ6uGobywe+VW0seBjCJm6wn02T8SXN7Dl19rsN4+329cMFA6
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From:   Rong Tao <rtoax@foxmail.com>
To:     mark.rutland@arm.com
Cc:     elver@google.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, rongtao@cestc.cn, rtoax@foxmail.com,
        tglx@linutronix.de
Subject: Re: [PATCH 1/2] stop_machine: Use non-atomic read multi_stop_data::state clearly
Date:   Wed, 25 Oct 2023 08:37:45 +0800
X-OQ-MSGID: <20231025003745.4255-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <ZTegiFbGQUAp1l0p@FVFF77S0Q05N>
References: <ZTegiFbGQUAp1l0p@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your advice, Mark.

Your commit information is clearer and easier to understand, I will use it
in the next patch version, thank you.

Rong Tao

