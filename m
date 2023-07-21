Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC4275BD09
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 06:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGUEAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 00:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGUEAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 00:00:17 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC26C1982;
        Thu, 20 Jul 2023 21:00:16 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68336d06620so1324868b3a.1;
        Thu, 20 Jul 2023 21:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689912016; x=1690516816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JPVX6otDrnHwN/de+EakZtScmrj1L1CckqpN5UTGJdw=;
        b=p6Ury7ltL42dLWYtJeUfhOLbCnLoT+sTFaiWDH8cIUN8KlrBKvPGGWLj8dH1fKwCmz
         Jk7ULSGLT9hX+t/2FR/2qJrdfn3MJg2fQlJa2A3YlVK2xlg9qod6xhhzjAP+cRQM8Mls
         /pmKP5XLQAxxrt93P/wKDrm7gF7vWyZbnEztTSngdQfQZFNug1FuTg1TMrsCTz2g7AZZ
         Zc2HhviFmME+drwiMbf6OZ7HGnX0fk2heaJ3e9nLi264oIigTph+8eeLFcJ28DUWb+E0
         rqrzjf4UzK4Ma31SY3padf3VeilKjdyGIJ07yXUTGXxGnStldH+XyMjTxW0O7a6gt37i
         j3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689912016; x=1690516816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPVX6otDrnHwN/de+EakZtScmrj1L1CckqpN5UTGJdw=;
        b=Xwaas2sn+0u24Jzvkn6Y+DCx1ZuYRWrtxG/kDL217ynclYcGbobNiWGkWypeG/JCfE
         umEc0IUYm+I5GP+S4GoXwcV5MHhcwvxulh6dWvb5lb4K/H3k8W5ELTUUJ9uPgR1eAH1V
         n69XSv4uhjDlkq2W25CkjSYWJ7iWSgGuEU1TOxQfVNMS1r6qXmknrz4OT9iwMc/EB3kV
         zLFyMEylHrQZ0uQeAyaG1BF/IHH2R5PrUyuAoUVuaC8xpu4vT6RUsVic0hYenROoqkXV
         qLJM4VLkmXVENz5NgIOvaY7QltTw+zyjW/WRraOPhTg5ImGN6qiGCMhxvbV8T4+Xl6yi
         QPTw==
X-Gm-Message-State: ABy/qLZ7ii1bIHbFWRu+KrRCzDyuEsujRBdnCJRhWLaNaCXOqrCGpRba
        fTSlXgsmL4khCc7MHrb0lYUV4WF3rfygEQ==
X-Google-Smtp-Source: APBJJlH8iJo8OJT92BKXoXKw9c3eZ9P0JbxqHTRNxOL25+iw6u4wU2x/fcDn69sbe8x0kzLyeslJsQ==
X-Received: by 2002:aa7:888b:0:b0:673:aca1:a0b0 with SMTP id z11-20020aa7888b000000b00673aca1a0b0mr980101pfe.3.1689912016079;
        Thu, 20 Jul 2023 21:00:16 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id m22-20020aa79016000000b00682562b1549sm1969182pfo.24.2023.07.20.21.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 21:00:15 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id EF7008196A07; Fri, 21 Jul 2023 11:00:10 +0700 (WIB)
Date:   Fri, 21 Jul 2023 11:00:10 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     pangzizhen001@208suo.com, oliver@neukum.org, aliakc@web.de,
        lenehan@twibble.org, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/scsi: Fix typos in comments
Message-ID: <ZLoCynrRoXHPn/Dx@debian.me>
References: <20230720160417.4434-1-wangjianli@cdjrlc.com>
 <0dbfe7a07c205bde3fc60408ce7aa55a@208suo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tUojydz+PJ84pRbC"
Content-Disposition: inline
In-Reply-To: <0dbfe7a07c205bde3fc60408ce7aa55a@208suo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tUojydz+PJ84pRbC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2023 at 12:06:11AM +0800, pangzizhen001@208suo.com wrote:
> Delete duplicate word "the"
>=20
> Signed-off-by: Zizhen Pang <pangzizhen001@208suo.com>
> ---
>  drivers/scsi/dc395x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
> index c8e86f8a631e..077e76407c58 100644
> --- a/drivers/scsi/dc395x.c
> +++ b/drivers/scsi/dc395x.c
> @@ -2052,7 +2052,7 @@ static void data_in_phase0(struct AdapterCtlBlk *ac=
b,
> struct ScsiReqBlk *srb,
>          /*
>           * KG: We should wait for the DMA FIFO to be empty ...
>           * but: it would be better to wait first for the SCSI FIFO and t=
hen
> the
> -         * the DMA FIFO to become empty? How do we know, that the device
> not already
> +         * DMA FIFO to become empty? How do we know, that the device not
> already
>           * sent data to the FIFO in a MsgIn phase, eg.?
>           */
>          if (!(DC395x_read8(acb, TRM_S1040_DMA_FIFOSTAT) & 0x80)) {

I'd like to write the comment above instead as "We should wait for the DMA
FIFO to be empty, but it would be better to wait first for the SCSI one and
then the DMA one to be emptied..."

But hey, you did not read review comments to all your submissions, many
of them (including mine) asking you to not corrupt your patches like this
one did.

Hence NAK from me.

Bye!

--=20
An old man doll... just what I always wanted! - Clara

--tUojydz+PJ84pRbC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZLoCwwAKCRD2uYlJVVFO
o/yqAP97ZqXlHc3rrSddM5kQKqSMc3wRtFn80O0PfzXELvHAYQD+OyCOc61XP+VK
Tomz4+5hzNY6Z+K5JMDnGhtFNH/qFQo=
=TekW
-----END PGP SIGNATURE-----

--tUojydz+PJ84pRbC--
