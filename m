Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919407D97E9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjJ0MZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjJ0MZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:25:06 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368DBFA;
        Fri, 27 Oct 2023 05:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1698409502;
        bh=KmREfUcy5jm4Zpdo+lkmU9dwV5njzrSKpDztzvbFBK8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ejA+/H7DnpQ4MKb6lzAne4asm44jjYQTs3KW/SF+iHxv04IY23qZ9CxfjiBqzf2VO
         qH1Nkeu9eqpk5+eJBKF6n2p9vFxJycrnET9hb/7Jh3MYGyGwqviWZ2X6wNALYG8XJP
         q3adPoCzz7wENG/uP4RO5Q/mhVqT6V3/ymyXz9ck=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id ABC921287400;
        Fri, 27 Oct 2023 08:25:02 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id b8Oe44fgnsbz; Fri, 27 Oct 2023 08:25:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1698409502;
        bh=KmREfUcy5jm4Zpdo+lkmU9dwV5njzrSKpDztzvbFBK8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ejA+/H7DnpQ4MKb6lzAne4asm44jjYQTs3KW/SF+iHxv04IY23qZ9CxfjiBqzf2VO
         qH1Nkeu9eqpk5+eJBKF6n2p9vFxJycrnET9hb/7Jh3MYGyGwqviWZ2X6wNALYG8XJP
         q3adPoCzz7wENG/uP4RO5Q/mhVqT6V3/ymyXz9ck=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5575A12873FC;
        Fri, 27 Oct 2023 08:25:01 -0400 (EDT)
Message-ID: <6c733fad84445bd29df230ecb5310535bfef2254.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 5/6] tpm: Add tpm_buf_read_{u8,u16,u32}
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org
Cc:     keyrings@vger.kernel.org,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Julien Gomes <julien@arista.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 27 Oct 2023 08:24:59 -0400
In-Reply-To: <20231024011531.442587-6-jarkko@kernel.org>
References: <20231024011531.442587-1-jarkko@kernel.org>
         <20231024011531.442587-6-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-24 at 04:15 +0300, Jarkko Sakkinen wrote:
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -124,3 +124,72 @@ void tpm_buf_append_u32(struct tpm_buf *buf,
> const u32 value)
>         tpm_buf_append(buf, (u8 *)&value2, 4);
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
> +
> +/**
> + * tpm_buf_read() - Read from a TPM buffer
> + * @buf:       &tpm_buf instance
> + * @offset:    offset within the buffer
> + * @count:     the number of bytes to read
> + * @output:    the output buffer
> + */
> +static void tpm_buf_read(const struct tpm_buf *buf, off_t *offset,
> size_t count, void *output)
> +{
> +       if (*(offset + count) >= buf->length) {

I don't think you mean that; it's dereferencing a random location in
the stack, which is why I see this check trip randomly when testing.  I
think you mean

if (*offset + count >= buf->length) {

James

