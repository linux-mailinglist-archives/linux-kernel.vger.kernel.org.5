Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D40C7F218D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjKTXoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjKTXoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:44:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BE3C3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:44:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1359C433C7;
        Mon, 20 Nov 2023 23:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700523848;
        bh=Kd8MO4g1L5NTe6VF4FsH/eaduBF2fDgRgJuS7ZGu1iU=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Ufd0rVmR5y3R7QnornCtBcuirGAcrKKp42f3eDqcYIB1XonOVDSdvIw6LrO4cW2ar
         0NpeKZXlbxFXQqrGmG2KBLfCq9/M0n7dN8/1Dtc2JLwtubEj0mLNR6/jxRpyhuF9OR
         R9SxEJt5l1+Cr/VOEqAnN4vRCKbhLjltSO2E7Lx316gDOrTKyZ+sZIIToUVsG2vuio
         h5np78o+4dKBYHNZZFzQUkUCxZc3+p69vTiHJ7Y395UkGtLmJKQr88G0oKHWwoiIGO
         a5mrFDA/e6gvjX7JVIVBvk4BTRlex4VESUTbpYKwKmoz/14KtZRi7Jb49dbEDDyqRf
         ukRiua9v/JZeg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 21 Nov 2023 01:44:03 +0200
Message-Id: <CX41E533XH4S.1B6IZCU0PKPL2@kernel.org>
Cc:     <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>
Subject: Re: [RESEND PATCH v2] sign-file: Fix incorrect return values check
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Yusong Gao" <a869920004@gmail.com>, <davem@davemloft.net>,
        <dhowells@redhat.com>, <dwmw2@infradead.org>,
        <zohar@linux.ibm.com>, <herbert@gondor.apana.org.au>,
        <lists@sapience.com>, <dimitri.ledkov@canonical.com>
X-Mailer: aerc 0.15.2
References: <20231120013359.814059-1-a869920004@gmail.com>
In-Reply-To: <20231120013359.814059-1-a869920004@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Nov 20, 2023 at 3:33 AM EET, Yusong Gao wrote:
> There are some wrong return values check in sign-file when call OpenSSL
> API. For example the CMS_final() return 1 for success or 0 for failure.

Why not make it a closed sentence and list the functions that need to be
changed?

> The ERR() check cond is wrong because of the program only check the
> return value is < 0 instead of <=3D 0.
>

Lacking Fixes tag(s). See: ttps://www.kernel.org/doc/html/latest/process/su=
bmitting-patches.html

> Link:
> https://www.openssl.org/docs/manmaster/man3/CMS_final.html
> https://www.openssl.org/docs/manmaster/man3/i2d_CMS_bio_stream.html
> https://www.openssl.org/docs/manmaster/man3/i2d_PKCS7_bio.html
> https://www.openssl.org/docs/manmaster/man3/BIO_free.html

Replace with

Link: https://www.openssl.org/docs/manmaster/man3/

BR, Jarkko
