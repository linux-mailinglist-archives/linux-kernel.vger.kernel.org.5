Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB52775B5C4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjGTRiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjGTRiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:38:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F5DE52;
        Thu, 20 Jul 2023 10:38:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D662B61BAF;
        Thu, 20 Jul 2023 17:38:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF77C433C8;
        Thu, 20 Jul 2023 17:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689874693;
        bh=kMr0Uc9QOzmr89ynCagCH9ja5pAeUkQMKFWPrlpO2KM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O/4WjprMwnV7p/dZWKbZ2eM+2O6Atep6WZEn/rzv4hLjVsAjY1eFqJvaZ7tuuwnKt
         V4IBFspgCjj7fbSaOUmeiQi8A4mYYfzo+nD8sRunm20FNiSboEtlJbzHo6Abl7Lopx
         jmoufn2Uf5JUhAjqJrA6HBPtM7TjjKemovQ06aZBGvVzx1NxR4TGyrQnDDl8Nkn23t
         TGRxhN+KOUnq0XVNq/JsabsgK/xNtUQPzG24je2iOeXLmKvnSrOI1Bh1e3f4EdQ/fI
         bYth7Ifbl1V+r6kya/68KTAkHnh5dWjB9MtF6Y+rLENEieimEohbZUkqu4Ddpm+4fK
         H+Rj5ITBTG4kA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 20 Jul 2023 20:38:05 +0300
Message-Id: <CU76KX3XPZN9.V9GU2ZZKVKO@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Roberto Sassu" <roberto.sassu@huaweicloud.com>,
        <dhowells@redhat.com>, <dwmw2@infradead.org>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
Cc:     <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <pbrobinson@gmail.com>,
        <zbyszek@in.waw.pl>, <wiktor@metacode.biz>,
        <devel@lists.sequoia-pgp.org>, <gnupg-devel@gnupg.org>,
        <ebiggers@kernel.org>, <Jason@zx2c4.com>,
        <mail@maciej.szmigiero.name>, <antony@vennard.ch>,
        <konstantin@linuxfoundation.org>,
        <James.Bottomley@HansenPartnership.com>,
        "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: Re: [RFC][PATCH v3 0/9] KEYS: Introduce user asymmetric keys and
 signatures
X-Mailer: aerc 0.14.0
References: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jul 20, 2023 at 6:32 PM EEST, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Define a new TLV-based format for keys and signatures, aiming to store an=
d

"type-length-value (TLV) based"

> use in the kernel the crypto material from other unsupported formats
> (e.g. PGP).

Where's the motivation part and where is this defined?

BR, Jarkko
