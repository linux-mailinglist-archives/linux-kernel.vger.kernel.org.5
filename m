Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C78277FE34
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354613AbjHQSyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354638AbjHQSy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:54:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDF02727;
        Thu, 17 Aug 2023 11:54:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ADD262086;
        Thu, 17 Aug 2023 18:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3D6C433C7;
        Thu, 17 Aug 2023 18:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692298466;
        bh=zmip0tMuh9lYHT7sGEmnyDeO+ajsiVS2dTUwRSKneNY=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=uMYTwU1CDa+fafEbVopJECeswGaU5o+F9LGde7Hsp8Vi2p/5yy2d89sNgg+mEjQLE
         O3U5SchcKIb/uO+/+yry6yG/uCnMPED+Vm6N76TAKmv0Jj4CzbpcfZtUaPOarUGhYg
         U81fwmBqImBfLlmXqBZ7egKGQkiYq33pji5Yg1zOKJMzQBb1vjCSYkmcPDx/95KZbZ
         aPaS8orFsAdhZ4pjKDxXN9J8r5GLOxQRvFNqyrkWmkkU4ad9qmbBLVePSZsgqncx/O
         pdaRr6P09gQDJcKXsuKbedCLsA+rFohPLr2wiSteWTGw4YcpcuR7ja8RDs7m/43q6Y
         4D1L9zeKaiQbA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 17 Aug 2023 18:54:23 +0000
Message-Id: <CUV1QLCMZTDX.3ACSGPQ4OY870@seitikki>
Cc:     <zohar@linux.ibm.com>, <keyrings@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kanth.ghatraju@oracle.com>,
        <konrad.wilk@oracle.com>
Subject: Re: [PATCH v2] certs: Reference revocation list for all keyrings
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Eric Snowberg" <eric.snowberg@oracle.com>, <dhowells@redhat.com>,
        <dwmw2@infradead.org>
X-Mailer: aerc 0.14.0
References: <20230817140407.1599240-1-eric.snowberg@oracle.com>
In-Reply-To: <20230817140407.1599240-1-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 17, 2023 at 2:04 PM UTC, Eric Snowberg wrote:
> Systems booted with shim have a Forbidden Signature Database called mokx.
> During boot, hashes and certs contained within the mokx are loaded into t=
he
> blacklist keyring.  When calling verify_pkcs7_message_sig the contents of
> the blacklist keyring (or revocation list) are referenced when validating
> keys on the platform keyring. Currently, when validating against the
> secondary or builtin keyrings, the revocation list is not referenced.  Mo=
ve
> up the check to allow the revocation list to be used with all keyrings,
> including the secondary and builtin, allowing the system owner to take
> corrective action should a vulnerability be found within keys contained
> within either keyring.
>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> v2 changes:
> Since this one seems to have been forgotten, added the two Reviewed-by ta=
gs.
> Unless there are any objections, could this be picked up?

Applied to -next.

BR, Jarkko
