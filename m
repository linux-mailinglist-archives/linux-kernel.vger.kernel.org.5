Return-Path: <linux-kernel+bounces-100335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3AA8795DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9C41C227D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738157A730;
	Tue, 12 Mar 2024 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TENfrw3g"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4327A15A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710252981; cv=none; b=lNtWxd2bHxfkf3Y7L1uNcfqUcq4zkv/zwceyQW+L9Ej9nWpscisYy71JN4mjmQRqM+iWmFkh5saex+6Pzwrsy6IC2bQ1BBqgFmgYQw5DLe+kckT9VLFNdgdRXU29R1hiZACF0CJ/xCIbh4JnIv+0I0GVFnv4t8MuLUx4uC16c8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710252981; c=relaxed/simple;
	bh=Xe2jflIWmBOCrDgKu8vTJunMCy3V4P/f2yAusY6t6o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCZ5N67lMaovS/h8wOornSdn32gfSdwJ4CENqEMXZqII/xd+7oD1Soe1+FDvCcRnVFwP8gfzMVQGmRPKx0fBS2+4qaPzxkA6/D+VvsrZeH5osJW39R/w+CLAz7DN5Fm43ikAuW2a8w4gNUyP3NknNbbMfp97VuWutfQV7t5PTCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TENfrw3g; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a1f24cc010so1438230eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710252979; x=1710857779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PryMCW430H3sBQTt6N5uSE32FN3q7uZNf3BrOahNno=;
        b=TENfrw3gYCrGRoxN/D+0UkaoxAvv4f9UPmpa7vDcxncGK2LtkQ+LDKF0f3kH+9qghD
         Ru9encxxJXrEJ3LlYPkPTG5W14o2rIeeAIn914t8R09hutY3QRIGeV4cs1ui9CRLcB90
         be/uy1RhNufy0WwYWNKR/98zvLRWnrNZH7wUlZwpKt4x29eJcXn6d1q21+DNycW0IvTv
         oHFQe9IETFHfTmFQBs2SNm6I8od0BHRURv1gXpaPwPmyi4zxN3dbu+PXXUs3VVNbSEbH
         3u6jUSnSfEF18GTGu+vuhjLebLRGzMRulR76jCo9McKYH54RG57L7mc72ebTpeOD7CI5
         lrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710252979; x=1710857779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PryMCW430H3sBQTt6N5uSE32FN3q7uZNf3BrOahNno=;
        b=Rn2L1o7kXTeHWkZgEj1Mcp9/h7qXp2icKAWTLupHKhH9CyWeKQfRpp6wD0YxFQAfq3
         BKgDcQC46SCLPsLxpg8KU+6ID5SNNhXVeA1oSHUMWLk1+tWkrvBAz4531JgBFYVvzIvQ
         7pqpk43zjkaRmJo3Tr+Y6etj6zm7nlpA4ElLKtLhtkmqPrwvs138pm2iF1RDN+l89lAf
         2JEEz23G6/JT400Eqq6LKU0gKla4JzEM1mthoUKNLXH78+dN8m85I5cSP3JPK3jCCDKY
         ET8T5SLwLK197muZGB+KvRhZqjciwGc6cRy8ElgCA7oSWlAX4ckP1SWKFvLUMhPw560n
         +k9A==
X-Forwarded-Encrypted: i=1; AJvYcCUKZ/Xtct+OvWIy5EKCMm212ASQKZPprv3qk44ojp27J3L+Xl0ksvAmBpaC8DzlxxPSh0ArJ4c+NmSPnl8T/EbchOSSfK05WWtRtWph
X-Gm-Message-State: AOJu0YxE7aaOah1sWqYnF2823V/I3kEqIn//OkywTrX2f/LfNxk+2jbC
	MBhX1a1HORjJ3pOH2N5PUPOG1L8QCox8jZAcNpnDL+ewl2a0qkioLujthlL+2mFguBzGDWXCYX9
	r/YIks0iMShSZNi3NL3IvIwvuiTk=
X-Google-Smtp-Source: AGHT+IF8Wor4/RSzrG4762PBaDFxHtLXlGGWfOsP3m2qd2261gWNpqZ12XUJCqDKQXTWZZrsxTwAhWYeM6fi6QbhPNQ=
X-Received: by 2002:a05:6870:b24d:b0:221:7a96:9ca2 with SMTP id
 b13-20020a056870b24d00b002217a969ca2mr10818593oam.32.1710252979327; Tue, 12
 Mar 2024 07:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Ze9Ie67PCSvBU+og@MOLeToid> <9bffd12a-afae-45cd-a4f3-451872146bf3@moroto.mountain>
In-Reply-To: <9bffd12a-afae-45cd-a4f3-451872146bf3@moroto.mountain>
From: Felix Kimbu <felixkimbu1@gmail.com>
Date: Tue, 12 Mar 2024 15:16:08 +0100
Message-ID: <CAK=vLxJLOsqECJn+c=Mo0kY2878u1bhRzYEWo+yZZEUbqEee7g@mail.gmail.com>
Subject: Re: [PATCH] staging: p80211conv: Rename local foo to decrypt_check
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 10:03=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> With the rename the indenting did need to be updated, yes.  However it
> should have been:
>
>                 decrypt_check =3D wep_encrypt(wlandev, skb->data, p80211_=
wep->data,
>                                             skb->len,
>                                             wlandev->hostwep & HOSTWEP_DE=
FAULTKEY_MASK,
>                                             p80211_wep->iv, p80211_wep->i=
cv);
>
> [tab][tab][tab][tab][tab][space][space][space][space]skb->len,
>
> See my blog for how to resend a patch:
> https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
>
> regards,
> dan carpenter

Thank you for the feedback, Dan, let me correct that.

