Return-Path: <linux-kernel+bounces-135937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBAE89CD7A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC67284391
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D57B1487E0;
	Mon,  8 Apr 2024 21:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="goJN4DAf"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423F9147C75
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 21:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712611285; cv=none; b=ZNzV6kY7/RPxaZiEfli6iLu6aWRIgLeJY4zE9dIt3XgmdGk+gu/AEXRc2WNt8MNXVVGdQzSqt2Btz42q4q2i6WZGajCcET9xXrk59fUeLe01eqzmGwT8rkczkmAz7akSY2k4zPJBOJxrDh1eL1OZ+ohIC23utRWfcj5vybpXMl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712611285; c=relaxed/simple;
	bh=Sw4+k5a6MJWGjZVqHzvPeVGvtNP/9bYUYa4c2zZvwvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSO1ecLJrLtjznLQH8G/7vTcqfT18mE94aw52izt4FC2sv3q01Qp5+CNvBekhddYkOE1bN5h67+9PjQl1RDksrLmUffJf0kMlNFY41fWanY11R12IEkHEBPXdraA7qTw1TtH25GaMoViq0QNj++D1Zkk0rvkgcDKbi36312MbJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=goJN4DAf; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-343b92e54f5so3767844f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 14:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712611282; x=1713216082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWv/i5xh3+rBeyFNDgtM4EpK2GAFLELYYUjgkTjhu9Y=;
        b=goJN4DAfu4nuy9oNi0tIq9m4unEqcS2FHw6AbEuckPeT3gUmGTwwInWHBhFmbsQyN3
         xrOrD8YEybmhysAc2pRCX0SJD8+yn/1olxJsWzrTgo2Th9lfXeB+mVNHm2wYjHz6boID
         povWQ+RvmuVHvcAj6xX5d8Fq7TLmVQui5KAD/E3w9EU/58uepC7ztsEVlTz4M20Vyrpd
         Xbr4oRAvlA41huhc6Uvov6Ec7T0JpYCDyI+dS64N5J+qnx4FYXc6Tc9SJ9ZlCOTYKQqD
         V586TMqDxe+S8ODFMvGitaQmqFljBcxVu6j41LCRIm4RwpnwNgMCpLgzJUPJZ4DWJLXT
         09mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712611282; x=1713216082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWv/i5xh3+rBeyFNDgtM4EpK2GAFLELYYUjgkTjhu9Y=;
        b=DkN0gGbvL8EXykq/dj5Ua8S8qOevOcUdb5Isphi1KEw+UggUk++FvOtspCMXaOvmpO
         h9ch4guveJz3ytsTH/m5S65H6LW/jH2digd8se2l3FF8LIREAymAzIrsHfjeueNhjYTF
         Zg+OOZQXBJLDbLVSc93kO0Kr9asoUFs0ymdXVtSd3K03y80X4ASkJatGjwuCRlQRfn9N
         pS0K36+dPq6gYm708PeXChtIwFcZagSE3Ok0R9sD2yaI+tYKINZjigjHHVUuEQSdijU2
         /WRVJhFUxseVXucmW6SDRwEbeb/p/CdB/UqKftjyINSeeie0MSsarxPPQxt0urmhxmoL
         nSGA==
X-Forwarded-Encrypted: i=1; AJvYcCVW5KHt6DpwyolyvcIU3OAu0S31Di8RG9UXZgzhkK3YTnEBmu+/SSDVEC04tCRRhP5Ax9WikFLd2Ty4G88lzt7OLkOxAb3Sba4ATjqY
X-Gm-Message-State: AOJu0YzmU0shLIszkVqILgylIjc+yn8BG/EGweEF8+BXE14RAnz0zYAY
	38bK6ZT6ELNkq3ACiAj1v7exwCGlwZantOsrbNrLRM20dRpMMG0Q+/xaBGFrcAlE7j/y8Bk8Zhv
	teuuKKOsIoRro5JrUYW/DZXPqirMNmwlAFM5Y
X-Google-Smtp-Source: AGHT+IHeGJ6F4ll9rt0b252ElUO5EB31Rl2KzoLT24tHgP5ExIXWB82Osysw+y7ff6hsi+9LQqecR2QLrmDACtdEET0=
X-Received: by 2002:adf:fa8e:0:b0:343:b619:dd52 with SMTP id
 h14-20020adffa8e000000b00343b619dd52mr7230109wrr.0.1712611282291; Mon, 08 Apr
 2024 14:21:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408075052.3304511-1-arnd@kernel.org> <20240408143623.t4uj4dbewl4hyoar@quack3>
In-Reply-To: <20240408143623.t4uj4dbewl4hyoar@quack3>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 8 Apr 2024 14:21:10 -0700
Message-ID: <CAFhGd8ohK=tQ+_qBQF5iW10qoySWi6MsGNoL3diBGHsgsP+n_A@mail.gmail.com>
Subject: Re: [PATCH] [RESEND] orangefs: fix out-of-bounds fsid access
To: Jan Kara <jack@suse.cz>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Mike Marshall <hubcap@omnibond.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org, 
	Vlastimil Babka <vbabka@suse.cz>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 7:36=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> Frankly, this initializer is hard to understand for me. Why not simple:
>
>         buf->f_fsid[0] =3D ORANGEFS_SB(sb)->fs_id;
>         buf->f_fsid[1] =3D ORANGEFS_SB(sb)->id;
>

+1 for this idea, seems easier to read for me.

>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

