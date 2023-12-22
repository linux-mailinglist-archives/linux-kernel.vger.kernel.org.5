Return-Path: <linux-kernel+bounces-9807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 740AA81CBB0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 062EFB23655
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9754C24B20;
	Fri, 22 Dec 2023 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErT6Wgi+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8951A241FF;
	Fri, 22 Dec 2023 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7810827e54eso123282985a.2;
        Fri, 22 Dec 2023 07:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703257384; x=1703862184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzmZecV+oKdYBapCJ37Nvj5P7ttQFJPgIUktVMqWwtY=;
        b=ErT6Wgi+cDZcY/gprcpJYfKf47HwDo/PI/XP+V8nkVOM38NDo52bFX9Y4kTgnKlO99
         r+DWqBv6wDFVKe3tQmqjRei4nowO+oKdNgzUmR4f9quxUubY+VG3+F1vxtKL6OTF/ihZ
         RS0NNxMR8RtK0mmzQlL6GxHUOd4M/QnUetciefD8tEeh+dr1A1rVQ0Cpt0bj/SjK2p6r
         DIj+hFcmYEN7tTKy+3QRi8jo7+Olt5ukDTGBeTwdAQru2QPwDY7CyDAMST9wUKn0BZD/
         6UqG27EoNTboRlQzWcNUVCsOs+GRDWTsUp/ofJKtKEj0WV3ReAgu4IU1OaIqnqCkW9cn
         eY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703257384; x=1703862184;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tzmZecV+oKdYBapCJ37Nvj5P7ttQFJPgIUktVMqWwtY=;
        b=RuhMjDWKSnB+SHfyQLI0+R+Tghb2dj9+gUFEj/eXovQUG276umowSSPRXmvF77vfJZ
         USQToxRFYZ44bikjJTQAzaj3YgPCI9bK8Bs4C6GKakj05HmV0uYNpwbAWE6JMFw2zcNe
         Kzune6DRdDPJuEA4Pim+EGgJWrZZJyeeCgGlYXP8RantsjF6xLsFzlicK+SEaTkRgALn
         tx/7NBGbppxbKwI4Nqg4HbX48c9XsczPZrrCXiYv+BFO8DNBINpDZKzYoRH/HwFx8Sth
         WmdzXHs/5kL1+m8k1H1IBKjs2ZxUcjuvRNuJw1bbmnFuqpBsWn1c/4DZNjL4QBFAivTs
         12Xg==
X-Gm-Message-State: AOJu0YxpQPFdIh+QG7ONxqkCp8fqDdDjzrBfn+PqBQNBAWdgy4za7l7e
	RjV4ZbExvnE9UzfHbtziw5QC3lIJeRk=
X-Google-Smtp-Source: AGHT+IF/GXVTZuBXwvERU34ObI/nr9TJjabP7/zdJB9ykOdzRBNbYlbfEw90YhSANkoQPdXymaAp9Q==
X-Received: by 2002:a05:620a:b10:b0:77d:4cb9:89ac with SMTP id t16-20020a05620a0b1000b0077d4cb989acmr1786274qkg.32.1703257384242;
        Fri, 22 Dec 2023 07:03:04 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id q26-20020ae9e41a000000b007810de6a161sm1394913qkc.55.2023.12.22.07.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 07:03:03 -0800 (PST)
Date: Fri, 22 Dec 2023 10:03:03 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?SsO2cm4tVGhvcmJlbiBIaW56?= <jthinz@mailbox.tu-berlin.de>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?B?SsO2cm4tVGhvcmJlbiBIaW56?= <jthinz@mailbox.tu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Deepa Dinamani <deepa.kernel@gmail.com>
Message-ID: <6585a52790fd0_d4884294ea@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231221231901.67003-1-jthinz@mailbox.tu-berlin.de>
References: <20231221231901.67003-1-jthinz@mailbox.tu-berlin.de>
Subject: Re: [PATCH net] net: Implement missing
 getsockopt(SO_TIMESTAMPING_NEW)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

J=C3=B6rn-Thorben Hinz wrote:
> Commit 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW") added the new
> socket option SO_TIMESTAMPING_NEW. Setting the option is handled in
> sk_setsockopt(), querying it was not handled in sk_getsockopt(), though=
.
> =

> Following remarks on an earlier submission of this patch, keep the old
> behavior of getsockopt(SO_TIMESTAMPING_OLD) which returns the active
> flags even if they actually have been set through SO_TIMESTAMPING_NEW.
> =

> The new getsockopt(SO_TIMESTAMPING_NEW) is stricter, returning flags
> only if they have been set through the same option.
> =

> Fixes: 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW")
> Link: https://lore.kernel.org/lkml/20230703175048.151683-1-jthinz@mailb=
ox.tu-berlin.de/
> Link: https://lore.kernel.org/netdev/0d7cddc9-03fa-43db-a579-14f3e82261=
5b@app.fastmail.com/
> Signed-off-by: J=C3=B6rn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>

Reviewed-by: Willem de Bruijn <willemb@google.com>=

