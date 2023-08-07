Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB917728E3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjHGPR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjHGPRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:17:24 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4D310DE;
        Mon,  7 Aug 2023 08:17:23 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bba48b0bd2so29399615ad.3;
        Mon, 07 Aug 2023 08:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691421443; x=1692026243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+9F0mm26547YwGdsOYT/6OgcExXxmjtiA50SQtPXRg=;
        b=JljrwEsM1fFtKPnszTzIISBcoRaaj7fBrx95Wccvs2g6MsC921pQR/6GbKbfooj9cC
         MNRSGq7fAbsYu+5r4It5zyJFFwXQYy2GI2q9HuaS9fTGzot+l2YzegkF4eeI9RXOiQu3
         ixmB3kf29LycmnoopQPqhEBFhm1BrrkwWtLsIZxbkQEHBu3PmQpu/ZCZZUVAyWZVJPpX
         RiraItHyTa5KIWZNwqTJqDDPp7Et0O4PmzRCmFYQ/5pWsNSLtoVqClVi0ne6ZJFaBzKL
         5xO3C5kI0lNCRa9XifcBTOeLBYxZ5Wpms8J/9B9vNcqNdZEH3ga77/FmZP5eybZXdSCM
         jPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691421443; x=1692026243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+9F0mm26547YwGdsOYT/6OgcExXxmjtiA50SQtPXRg=;
        b=C8ghGh3ajlpWh1cJ0BjhVfkJfBoGcRyQntf9FRFoCt6h5S+CeEIqOiBIMwLK919dUf
         /obUI8K/2qGLZ1hQkg4Bp3/6K6hSMI8bjeDSSNVc4qtQ3QZ5raAg0n2hlTSmeiip5ud0
         hGfVP1mfomO3/gl4E9VZ3IY+sxbzXCfRUZtPjpquCN1eqmCEDI0fbjbwwyc9xN0fyUYa
         88HW/QReYtLg7JMr9ARd6gb7n6SQCUN1oQlKwcpzL+OgDYv9TRjw46lT8GdHv6PNxyko
         RjDvroANf5xdhsCdcIOdx6JcY1OFT4S8tUnGtvTggFm5UKcsTOjDBejytgE9jp02xbMt
         AwdQ==
X-Gm-Message-State: AOJu0YyGtL8tM1Kz+9JxDObhaPH1IUkz2mttzlD2XMPr/avzeUsYe8R5
        aU+e3neLQ2M/FZRLdpSWk+s=
X-Google-Smtp-Source: AGHT+IEdWab8M45OJVYq6HKxCC/BIo1O8CXS+FMGJY+gu/L2pr/OZXQIAidO7BK76Zxz5T74hNQUEQ==
X-Received: by 2002:a17:903:191:b0:1bb:a056:2c5f with SMTP id z17-20020a170903019100b001bba0562c5fmr9832821plg.7.1691421442901;
        Mon, 07 Aug 2023 08:17:22 -0700 (PDT)
Received: from rajgad ([2601:204:df00:9cd0:b50f:ee2a:c29c:a732])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902bd8500b001b89b1b99fasm7018101pls.243.2023.08.07.08.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 08:17:22 -0700 (PDT)
Date:   Mon, 7 Aug 2023 08:17:21 -0700
From:   Atul Raut <rauji.raut@gmail.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     gregkh@linuxfoundation.org, kvalo@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ath6kl: replace one-element array with flexible-array
 member
Message-ID: <20230807151721.qasrym5x5lqoqjgd@rajgad>
References: <20230804045554.6934-1-rauji.raut@gmail.com>
 <2023080433-patio-staining-2cfe@gregkh>
 <87sf8zs2oi.fsf@kernel.org>
 <2023080410-unadorned-vertigo-c0b8@gregkh>
 <47f1a06b-8bfe-911a-3a05-da7d522b588f@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rcfpwov7x5kwjhxg"
Content-Disposition: inline
In-Reply-To: <47f1a06b-8bfe-911a-3a05-da7d522b588f@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rcfpwov7x5kwjhxg
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Description: I appreciate the comments. Will refrain from altering this or any other submitted patches, as advised.
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 07:13:20AM -0700, Jeff Johnson wrote:
>On 8/4/2023 2:30 AM, Greg KH wrote:
>>On Fri, Aug 04, 2023 at 10:10:37AM +0300, Kalle Valo wrote:
>>>Greg KH <gregkh@linuxfoundation.org> writes:
>>>
>>>>On Thu, Aug 03, 2023 at 09:55:54PM -0700, Atul Raut wrote:
>>>>
>>>>>One-element arrays are no longer relevant, and their
>>>>>place has been taken by flexible array members thus,
>>>>>use a flexible-array member to replace the one-element
>>>>>array in struct ath6kl_usb_ctrl_diag_cmd_write
>>>>>
>>>>>This fixes warnings such as:
>>>>>./drivers/net/wireless/ath/ath6kl/usb.c:109:8-12: WARNING use flexible=
-array member instead (https://www.kernel.org/doc/html/latest/process/depre=
cated.html#zero-length-and-one-element-arrays)
>>>>>
>>>>>Signed-off-by: Atul Raut <rauji.raut@gmail.com>
>>>>>---
>>>>>  drivers/net/wireless/ath/ath6kl/usb.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>>diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wirel=
ess/ath/ath6kl/usb.c
>>>>>index 5220809841a6..c8ecc9e85897 100644
>>>>>--- a/drivers/net/wireless/ath/ath6kl/usb.c
>>>>>+++ b/drivers/net/wireless/ath/ath6kl/usb.c
>>>>>@@ -106,7 +106,7 @@ struct ath6kl_usb_ctrl_diag_cmd_write {
>>>>>  	__le32 cmd;
>>>>>  	__le32 address;
>>>>>  	__le32 value;
>>>>>-	__le32 _pad[1];
>>>>>+	__le32 _pad[];
>>>>
>>>>Are you sure this is actually a variable length array?
>>>
>>>It's not, it's just padding. We both told this in v1:
>>>
>>>https://patchwork.kernel.org/project/linux-wireless/patch/20230731012941=
=2E21875-1-rauji.raut@gmail.com/
>>
>>Hey, I'm consistent, nice!  :)
>>
>>But Atul, that's not good to ignore our review comments.  Usually that
>>ends up meaning that everyone will then just ignore your submissions,
>>generally a not-good resolution.
>>
>>thanks,
>>
>>greg k-h
>
>Since the 'pad' field is never directly accessed, suggest the author=20
>respin this this to use simply:
>	__le32 _pad;
>
>That will prevent others from trying to "fix" this actual one-element=20
>array in the future.

--rcfpwov7x5kwjhxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEk+Uz5/8aTg0U2TbgUdAfNFxksqcFAmTRCv0ACgkQUdAfNFxk
sqfOrQwAptc9XDlqik1wPWhDQR3FcwX0d30+AQUk9qPg47CfXTjoY0Wk2eN/f8H2
MSVv4UYFw4vePh83nPkdZMtmaMgck3TWCJ522khoWVM1Auj6y4piuOu7SyYnraPT
CHBxkeBHHOpicHCgCjtojdiaNRFxtCsAmr5dzpI+uKhLZqmUtXcU+CP73xmxcO+i
mMaWrHDvBAha9d1IIFCTcuO0wH+kvz+LJ5UcO9WGgbTjkpLYOwRpekDvHfvgeLPT
4bu/kUExrYnZ20ur34sujn+eBs2ISqAVvpniNrufGDCrUjpjIVHauxEQZgRbGrdF
vQnN992f/hw4+5LQHoVK1IC55GVL6WPw3Q9RIboEgJu5YxASKlSF4Tho1GLDs+Sm
lo+pyxL54zSALszhIjUdXiVSRiW8Oos062rrSfIqTwc0CD3SSdlbUeP4mAMgHkSp
P2P5Tgmevc723Kx05qCaSUa3DAYU4tXvf/YJRSmK4FkGejgdtIEYlDHxXFodPece
1TAGz34i
=Y0V4
-----END PGP SIGNATURE-----

--rcfpwov7x5kwjhxg--
