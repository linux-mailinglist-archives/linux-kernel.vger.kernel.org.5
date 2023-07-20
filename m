Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D04C75B593
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjGTRZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjGTRZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:25:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A38BCC;
        Thu, 20 Jul 2023 10:25:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAD0B61B89;
        Thu, 20 Jul 2023 17:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C2DC433C8;
        Thu, 20 Jul 2023 17:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689873939;
        bh=O/dSf0cvKe3Wfsam8I+kpp2o81BfpqMYAQOnEETxOIs=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=lik5cCSGHDu3qb8cqwkwcRtZtyiIHy0IA2mAj0hxuya+jIvOJwlnyDXZXdYoRDRiw
         85ApqcnhV6zoWKZci3cnVxfaMuFezpNdAXWZRHgDxoPbzElAbjtQkveEVLzQtroypL
         vXey+RNmKO9YUNDI3Da8TDt4+laBd/whqtePv80KkezXhQaF/BoR3Ti3O7A9Zhv5MZ
         wiFhM1BXDzm6SZcQIhNOHgBpyxIWAb2JsZBwVwEKqcwAk2Wfppz7akdDxsW6kQtZrf
         Z1eyhWLveEaJugvTHopRX/dPyWSR8o7ik5ST2RatETZvEkLnSyCnjQJGmeovO6SsxS
         xqL7pMgkS7gjA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 20 Jul 2023 20:25:34 +0300
Message-Id: <CU76BC9V7H3Z.TQ3L8AZY1WD@suppilovahvero>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 0/4] selftests/sgx: Harden test enclave
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230719142500.13623-1-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230719142500.13623-1-jo.vanbulck@cs.kuleuven.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jul 19, 2023 at 5:24 PM EEST, Jo Van Bulck wrote:
> While I understand that the bare-metal Intel SGX selftest enclave is
> certainly not intended as a full-featured independent production runtime,
> it has been noted on this mailing list before that "people are likely to
> copy this code for their own enclaves" and that it provides a "great
> starting point if you want to do things from scratch" [1]. Thus, proper a=
nd
> complete example code is vital for security-sensitive functionality, like=
 the
> selftest example enclave.

If anyone copied the source code for their own enclave, they would have
to publish their source code, given the GPLv2 license.

There's a lot of source code in kselftest, which probably has at least
some security issues.

I'm not sure, at least based on this motivation, why would we care?

BR, Jarkko
