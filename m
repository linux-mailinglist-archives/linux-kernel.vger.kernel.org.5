Return-Path: <linux-kernel+bounces-159813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848718B3470
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428E02851C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC0B13FD8B;
	Fri, 26 Apr 2024 09:48:57 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD10713C9A7;
	Fri, 26 Apr 2024 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124937; cv=none; b=fuwa4W9n5idZg4ym7kfaMhZNTQqpELZBcsanmjkctVDRza3YO1cP8scjc941j55LMf1Ml8Y4rvswa3uufbhq3gmYysZPgWTxeE8gsV2/Mzl9UgmVuozWoWU8BJWjg8I5fDuM3PIDDNzZqfCSbEK98pkM0lxmWESG7y8aGnbqhgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124937; c=relaxed/simple;
	bh=HlWarb/RqnkOtCuXVRll0DMgrQQt7Rgvj2Uz8IobGpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJJHE9KA/zZWpNU3S8yBaZ43o/8LG07l7pevDFJIOWLJbPBRqwkjPUwHiPItid7DJgzvfdBOeQI1JudacqTZxBkTR4Lt/KHW8KUJ7xOaVDheoB6B80/oyG9/QWJ+DRasBJ330O7Dtfnh5bcrCll6KYZELp2TvAyhIMvk7pzhHQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516d2600569so2359278e87.0;
        Fri, 26 Apr 2024 02:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714124933; x=1714729733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22asdptnAUD8ROjJFV/g/b9ZWATdUhzJEJjpw7rWP4s=;
        b=xUthC2DYuIoTx0lwU5SYkYpBrjyqmR52rbnZ3UhSzDwYGogoW/THvDzbrlrejlJtkk
         NBRZe5EoBHlerPVY2EObkcCY219LsUwQHiuQ/p29B9Qlw52PlsyDQqV0ykfJG30Jdu5H
         Dhg9nMsgcEVjNdIkafniRHjzQUzLGRlRIJR0P1YhYIRlAb1vmfVlMRUkMiXgojpgMfll
         omHWssmHHVUogVTpw91iCHcJct7jTLxDnsJ2Gx+iHQfA6IqBR9cgXwBWNYZ33+203kz5
         unShRiE/HHRTiiQXSa1IVTaHYM/Su1vgeOUREDY1557vuTtYgENi/fKYmGlAsOMSMy08
         Msxw==
X-Forwarded-Encrypted: i=1; AJvYcCVcHkI97O+zAM3H2BjsJ+IsIauqEvSgMjaKVAZBu/8BZ9y8NT4Aklewn9SHaWC7O6hWVEZw0EjP9qpOxILI/fZHlhlZppnf/QgW9b0wOZC7FrtBTMUveoNGcQj+QWyJAXpalRxhE4xH+gczFj0B0efGuMMP1+LnwgHYSWP22ThW6E2R+t4w0kXPGxucrNzR
X-Gm-Message-State: AOJu0Yxjf4XZVK6STbMx4OmjV09UvAO6/G7iIiwdeKb2aOQy4xXXng8y
	9jtLJf3+4a/Dzng7joyrkajnAsVuIB2q7xE8XsQAq4v5ItTJct5nzAys0iZwtfM=
X-Google-Smtp-Source: AGHT+IFsy69PUmzf0eQz4ncObIQpgW+YrBvniXIfSzgPlzrmntEKYS1EIaeyca4jY9N+LMuSyJDWLQ==
X-Received: by 2002:ac2:5108:0:b0:516:d18b:eae8 with SMTP id q8-20020ac25108000000b00516d18beae8mr1426665lfb.41.1714124932695;
        Fri, 26 Apr 2024 02:48:52 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id x4-20020ac25dc4000000b0051bb0022c78sm1189404lfq.191.2024.04.26.02.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 02:48:52 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-518f8a69f82so2211596e87.2;
        Fri, 26 Apr 2024 02:48:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhnJfmrP8b2YAMteFEYIV3QG36pCBY+qjeyORyHf3QfZ2mjMopVEKGb6vrr8RMblb0TXpARhp9jEcHkkIS/cv66waoyVMSQ1BwS23bSTryPmnZQFDOkvVPzpD2XI7eLNHj+oa82b08kyxUyIoPy8nj/3cV6TJxxjHgLvWUu/rxJY/jeAsWo19YZ05JUX22
X-Received: by 2002:ac2:5b8b:0:b0:519:2d60:d71b with SMTP id
 o11-20020ac25b8b000000b005192d60d71bmr1400339lfn.22.1714124932298; Fri, 26
 Apr 2024 02:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426072006.358802-1-iam@sung-woo.kim> <964b0005-3a9d-499b-91d3-171a3c917b4a@web.de>
 <CAJNyHp+WFONaNbZVK3tPcT=9obEiuE3MvQzJK++HP-ffNdfX0w@mail.gmail.com> <dd466a68-f3ae-4dc1-8389-6adc463735db@moroto.mountain>
In-Reply-To: <dd466a68-f3ae-4dc1-8389-6adc463735db@moroto.mountain>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Fri, 26 Apr 2024 05:48:11 -0400
X-Gmail-Original-Message-ID: <CAJNyHpKEKoOKGsh8RSn+Tt=0mawG4Bz6LKwq3H2UFwuGuXH0vQ@mail.gmail.com>
Message-ID: <CAJNyHpKEKoOKGsh8RSn+Tt=0mawG4Bz6LKwq3H2UFwuGuXH0vQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_send_cmd
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-bluetooth@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	"Dave (Jing) Tian" <daveti@purdue.edu>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:38=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
org> wrote:
>
> Please just ignore Markus.  A lot of people have asked him to stop
> commenting on commit messages but he doesn't listen.  Here is a message
> from yesterday:
>
> https://lore.kernel.org/all/2024042547-shimmy-guileless-c7f2@gregkh/
>
> 1) It doesn't matter at all if there is anyone in the To: header.
> 2) You are allowed to ask questions.
> 3) Yes, the commit message will need to be changed but first fix the bug
>    and then we can worry about the commit message.
>
> regards,
> dan carpenter
>
>

Thank you for letting me know :)

