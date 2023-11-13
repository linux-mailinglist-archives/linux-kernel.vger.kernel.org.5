Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863747EA314
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 19:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjKMStu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 13:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMStt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 13:49:49 -0500
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FB710F4;
        Mon, 13 Nov 2023 10:49:46 -0800 (PST)
Message-ID: <6bcf9eb2d4ca5faa17e8e0842c4d69fd.pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1699901384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YdugKrF1IHQlb6TkxWiEpumPtlmZ379QWs8fZvedX24=;
        b=YPH52W0vCrsa65YO0LWx28OiLIEZNBi9nurcA/VlQfU+CVhc4XSv9teWPiiXs1gcZ/1S6j
        2z6MMwfd8OkzBd5XtpWD0d1jPzocppDfGsmsY3/drw2AAPshTJlSBzCpZUPzSLbrfuvkB6
        ymCPO/7JjQd0NXRxBi4v+t/uLTYZ+SFDkZ71rVWk7UHbVdcKcTmE4govFPIHZNuaQcH2AV
        8Y3iAank794IxdExgLcjag4xkxyEzScpvdSHjKN5QJUrslHk0waL+X4k7/muesei2Gq/NX
        MK84RCVSmjfqn76DjhOU8Dt57bep+RotwQ0WgX5lh5w+ISu7XfufWzE4yVYqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1699901384; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YdugKrF1IHQlb6TkxWiEpumPtlmZ379QWs8fZvedX24=;
        b=IVzS7DHdzhuBCTwZEqcrJ0EebdfaWtnBVQZ6Tw+SV10HTFOC7qiUOOF+qiAgtNE2oqyUp3
        yujSJGmPc3XaAqgWbbde5G+cSFKXbfvWPX/QKlhBwyCwj1gTti0B3O6RsFH0yfPyNR5cmQ
        Va8kvIh3FMMkGlANinL+Cn7mBqvnXZ4eQ9jFKCa1hlIrTR54qLH1eRLh3q06w7kaRqcp52
        oSF1FZ/aQEHG6tbAR+yDY9uOlLwGLZ9Vso6JZbxxQ5/MaLlAAbBZpoqsjMp8VBF1Bl44Q0
        8tfv52fOJnxnh4V6zU67knG0RoWXoUnDTy4Ea8OKjFk0nd5Ztut2s8KFZrOyTw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1699901384; a=rsa-sha256;
        cv=none;
        b=govAlo1L714Gbqo1VbQfkM6vjRsK6bhNSG9DtUwjDdkU3lMBmC6+ud9z2NrKh9jj2D0PkB
        yIRk3dPQksDdh6Yi04mjjjTA1RpTozaISCoZrZrYIJYaTqcHrd9VbN+ciUQ2OioDao8vu9
        T8Ygh0cWuG/vVbIc+asUd+GgyLrWuhB5rsU8iuACu5+SNkWAG0m75Ykjzvec5KGLSpLOwe
        AloD5BcZc6XOF4a+NTZXcw6jhI8WBqi87a2SU59AqC9+nTDJhw51fgsqhPgGblhGPWfBCd
        olJoZV6+MNASjIPOVtxOL5/OR6QEOac9JvWGOdCc8SUlj7c2af8WnkYA58jEKw==
From:   Paulo Alcantara <pc@manguebit.com>
To:     Ekaterina Esina <eesina@astralinux.ru>,
        Steve French <sfrench@samba.org>
Cc:     Ekaterina Esina <eesina@astralinux.ru>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Aurelien Aptel <aaptel@suse.com>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Anastasia Belova <abelova@astralinux.ru>
Subject: Re: [PATCH] cifs: fix check of rc in function generate_smb3signingkey
In-Reply-To: <20231113164241.32310-1-eesina@astralinux.ru>
References: <20231113164241.32310-1-eesina@astralinux.ru>
Date:   Mon, 13 Nov 2023 15:49:41 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ekaterina Esina <eesina@astralinux.ru> writes:

> Remove extra check after condition, add check after generating key
> for encryption. The check is needed to return non zero rc before
> rewriting it with generating key for decryption.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: d70e9fa55884 ("cifs: try opening channels after mounting")
> Signed-off-by: Ekaterina Esina <eesina@astralinux.ru>
> Co-developed-by: Anastasia Belova <abelova@astralinux.ru>
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  fs/smb/client/smb2transport.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
