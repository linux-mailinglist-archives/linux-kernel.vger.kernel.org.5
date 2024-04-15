Return-Path: <linux-kernel+bounces-145022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BF68A4E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B611F21AB0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8DB692FC;
	Mon, 15 Apr 2024 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+4ur96n"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46364487A5;
	Mon, 15 Apr 2024 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182509; cv=none; b=RbELkUmqHtOReXY968/2CzwSIAkWKngzGPC83ukyHEkCXEDJ7VZ/pUzARnpjQXehjEejFn5f7JA4xARrzvlG/L+tK/iyHl1EVh07XdwYyRNux8fLqWpK+mBMnyBB9rZrbeBY12RP2B3xFftHfozoZ5PUL+uGA4/2lOQ4n20g7v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182509; c=relaxed/simple;
	bh=U2+6Lr79GsLFHQ315u6tpD82JiM5TTUkPMj3699+nDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmxUYs/r9vvMo8qhn92vfIZy+nTwdEeoOxq843/eG3gcHnryXayOcqmHV7qYzzJ7jfwX1ndDjIPS9OmEacia6o/IFRnDZ5PRHM7lvY6pHoBxxmGIEkuYHuRK7H8+LhmvlHwlatG2vBCProWu6wzkKmhcTylAp48uvqTeQq0JmQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+4ur96n; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so3315781a12.3;
        Mon, 15 Apr 2024 05:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713182506; x=1713787306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2+6Lr79GsLFHQ315u6tpD82JiM5TTUkPMj3699+nDk=;
        b=i+4ur96nNGg+tNb25L7MiN6Sctc71e84SFTsQGXeumJPbdR8KSlHTsk5y92WCNDIjJ
         xUNnP6mJru9DXT5sKJVMXZK4olAMfOD6FZvZjNNyKxNKeH1qGXGfxBXh371j9lBTyC/W
         1CW8D8w4BaXJjeN2P+jSRlkcWX7zuXpiveoCyWZEWDOzDqjj4dWHms36Kh9rhdLQL8hc
         358+WSArOniPQjTOFX8uDS5FLfeQeQtikFgkOr/26jjs81BYbw50peoAEI0JdAfDsY0L
         qFtWXsUEqfDdTO90hVyuqO+SXgAQTH98LMneJHk+Ll9h67LCbXOgRRyVHt5Oge3PzJRT
         zYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713182506; x=1713787306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2+6Lr79GsLFHQ315u6tpD82JiM5TTUkPMj3699+nDk=;
        b=bmJ/Yz7vVO/vsTITeOF+9+UWuElZsjj5Inv0GBRMXknzHkde0Wf+wcb08sOIfbeBwf
         MLi0S7kfdiDC0jIxPpEPuITeSsemCcMW7Cr56JZQCj/X1P0y6tkfprDY1eCPYOkoFJ1i
         lFTbKP0Ypa9xfkdpQvSNxgOaDx0TKHi/SlAQ9rA8KVidwJq203sAorI9GxVfhh73upVv
         +8wGD8tDbZGlQ9YcwGJGcz1uPt7VRrA3/p3CkuyGV/4ICyh3cwdBqz3HVTnSbUufqj9N
         9t3hB+8Tke+G61oJM5AgEUBA9TKftb5utM0On7UESEUKXifps1Fb4c1ei+eF9f1pMPP0
         IXvg==
X-Forwarded-Encrypted: i=1; AJvYcCUe0ACynUXj4Ki2SpyOqUF9iTEIkzwIzBzqQVG3YsfxlTSGmjMfS6K2O4XEFKgi88Yny3X3M/UFnr18uZ1Gu2bKXHopg9ckbu+JCxApHfHBDX67nncOqg8Ee/SICmkEAqStCNq9H6igN0q9AumllzCfp8xRNeELh9cON5tYOWEZU+OBGEQa
X-Gm-Message-State: AOJu0YwFhX3XNttKGcMbhz9+aqhuK7YI5nYa2E76Ji0xLjLf/IHdK03D
	QpmJt6OCc3GVuJWWePEf80Jh1sOOxUCo3iMkZqjPae7AnNgYvUQPWMLC3CO6EDsC5bm/khSJ0pP
	yV5Fbs4Qo8uSj399uYZ7D+FgVfyGs7pkKCwA=
X-Google-Smtp-Source: AGHT+IGbhRTjcHd2K4ztbjm7oGGgtAEi1sZPmlLlZI6mWHz2v6XhYVkLuyaUclom/SQylPmkWyk1n/jJ4ZnyEo2KLtg=
X-Received: by 2002:a17:906:eec3:b0:a51:c84b:f17b with SMTP id
 wu3-20020a170906eec300b00a51c84bf17bmr7285354ejb.69.1713182506478; Mon, 15
 Apr 2024 05:01:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415100713.483399-1-colin.i.king@gmail.com>
In-Reply-To: <20240415100713.483399-1-colin.i.king@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 15 Apr 2024 20:01:09 +0800
Message-ID: <CAL+tcoBO2SPNYE+oRSkqk+YWRK0OiG5xj3uNZ448-AWMsG1A0g@mail.gmail.com>
Subject: Re: [PATCH][next] net/handshake: remove redundant assignment to
 variable ret
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 6:08=E2=80=AFPM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> The variable is being assigned an value and then is being re-assigned
> a new value in the next statement. The assignment is redundant and can
> be removed.
>
> Cleans up clang scan build warning:
> net/handshake/tlshd.c:216:2: warning: Value stored to 'ret' is never
> read [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

