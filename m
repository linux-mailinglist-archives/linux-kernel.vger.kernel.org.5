Return-Path: <linux-kernel+bounces-97148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121E187661C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296A81C20905
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5704086A;
	Fri,  8 Mar 2024 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq2kxw97"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D43FBBF;
	Fri,  8 Mar 2024 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907275; cv=none; b=J15XCIouzDhQZDNdZMBFgww8DDt1WW1p3/Ovo9tcbqlbjP45cYEsVfbCk/EHz7dtUWFLqURwSZfrxhPTPRlaYCsx3h9V/7RjGmuTGFBe3ZCYbaMNKI+rKDaWRQRH1VfaLr8bqRhzX+m4jQ7IVxoFJdujsaoI0k00AM1xq0sN6H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907275; c=relaxed/simple;
	bh=g0GXJcWTpI+e/pFZwlw2d/Iwn+qF6V6QGtpDqhChScw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAYAXAzJDchD6ah/TU7vmllf0AngTRKuk5vO8zN7skADAOjeJusg8CPH0o1BZT9EJZ3Aq24AcUQ72CVhbXpWCFDENCz44MBc/Mz8MKmgUF7wtAEybLT+Ncz1c3xtvuXzKja0N7I6vtB9h3pi93eJeDztCedunDRjHwxhyD/aQig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hq2kxw97; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a456ab934eeso314473166b.0;
        Fri, 08 Mar 2024 06:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709907272; x=1710512072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0GXJcWTpI+e/pFZwlw2d/Iwn+qF6V6QGtpDqhChScw=;
        b=Hq2kxw97qmoPSqnYZgZt7zewmkDvu4r2lfXqax5jvSPLsLCNpj5+iyg39QaWCBHEPo
         cSXnt8CDg+eHNulfU3KCXh0sAMyXHy639jA+O+ow7RF4vPhkN9H1f1R/jH3ZvEi3oEtV
         JWWduYwdve7PRaSFExvtBwMARTyFbGbcYKZQYXQ/4fCc0MYIszVnnCjh+/1UzkddeBAJ
         zkk5UaG41alZwZ6GOXRpi6px8fzsMzNWiNndDQ86iLZtTiCqpuzFHvihxA4ofSArv+7V
         j2BiszovumWGvtYIWzuZyQZiA4EOcOY+lZ7PeoQNnAKA3MXOit5Z9vsg3Z+9/V2Kb3y4
         B7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709907272; x=1710512072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0GXJcWTpI+e/pFZwlw2d/Iwn+qF6V6QGtpDqhChScw=;
        b=BqPr+yfWlTu4HJBB50jUo7buyw8UE0Xo2GVuoOkkeTB6TycAjIsaq4O0gM7YTwL0Uc
         tylNPF/HPzUhQoKbQs9ntnKWS2EbQ6WigRh4POpNNnAibCLt9V8CqDYZnPozGRqSIJga
         x22YNbg1tG24TZ7nZb5VCbckYUC2hAqQwd05QUH1aEIBy6RoI2gEdCzzT19eJ5LpV5DC
         41rcm9X1wroxdJ8rHtK7oIV9FBLJcM3EZA+5sIdkUlcdbvsv/mtADxzgStmnUtsoaR44
         +9QQs6W3uIU13m3rl7+PUyS1c0fCjjmT0k66Nl3R/HdsWMvgatYuD1EbVNfM3Y/5qJsf
         ES2w==
X-Forwarded-Encrypted: i=1; AJvYcCWZTpgMW/eGSkJx1SI0olZb421Ztd5gQQSU8DYXc6YJx9KhttiPo/uKgmLd9/t/dHe+cIPxUf6FB++XLuDc7O35YZYaXIpgE5GUxnGyEJA5tEVeJ7axIQIMQ5HAMZiKiNsSyK0I
X-Gm-Message-State: AOJu0YyMhqYW/0bSmSFbV42/9unJmqZLmMTJfkaIFxmwG0ywp4brbZRy
	o3J1AlOXbYMBUCF2Ql6DWNQu7yV/fFLQh864qAmfhzQiqB0Nn0fJNn29cu/boXstPTR/dTftvb2
	KH69JaSdrcYkrScj6M0J54l9Oids=
X-Google-Smtp-Source: AGHT+IGcurRtnrl4ACcNoMDTA2DAw2szwVWUdI63oXGVf0JaMDZDaqk4rxB4K7vLnO/zjqhai5Mk/EOVgCSxNEiOBbg=
X-Received: by 2002:a17:906:230e:b0:a44:2f23:1bdc with SMTP id
 l14-20020a170906230e00b00a442f231bdcmr15354781eja.26.1709907272090; Fri, 08
 Mar 2024 06:14:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58487A9704FD150CF76F542899272@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB58487A9704FD150CF76F542899272@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 8 Mar 2024 22:13:55 +0800
Message-ID: <CAL+tcoB4WY6st3=yOrfiXFKsv412Ljtr4dRrOoMq_2h3KXMJfg@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net/packet: Add getsockopt support for PACKET_COPY_THRESH
To: Juntong Deng <juntong.deng@outlook.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 9:08=E2=80=AFPM Juntong Deng <juntong.deng@outlook.c=
om> wrote:
>
> Currently getsockopt does not support PACKET_COPY_THRESH,
> and we are unable to get the value of PACKET_COPY_THRESH
> socket option through getsockopt.
>
> This patch adds getsockopt support for PACKET_COPY_THRESH.
>
> In addition, this patch converts access to copy_thresh to
> READ_ONCE/WRITE_ONCE.
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

