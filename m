Return-Path: <linux-kernel+bounces-5650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFCD818D9B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA5D1F22228
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5924F3174A;
	Tue, 19 Dec 2023 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mq3DhxDQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428EE20DE3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so15506a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703005344; x=1703610144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nRM2voBOWeWgYPSs3P1rkp2QaxKc2DKwbIgLygSDQM=;
        b=mq3DhxDQBWn07zKMgws3Xugcvnh9bSyOy3UzcbFkCdJsJ/G3gqKP1uluy/+WP2P4jU
         1e4p+xsX2yfTjpzUB2co0VlAZbyAywPrIf84YSPVLkG0VGNnb0XfdJUJ+jXkk8jlaFfw
         8vcBHzH8i1dhMIeRpeZJT953Aavph2qWFF4KpOghn53GUJJ4X/Xe9cAC8Xp5rjBygtwg
         DDEJtvTd2vtMlnNcNtF++wUenq9dMZxvOEG6MccquUXKkMwqcKx72JlM8PyNJwTPT2cB
         kFmanMQJ8Fb4hqCcMP4Dkm9rOxbm3RiQRqJJOUl5xo9ct3PdfGYv0EW0mlVeXksXKl58
         f4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005344; x=1703610144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nRM2voBOWeWgYPSs3P1rkp2QaxKc2DKwbIgLygSDQM=;
        b=MCy6E+1QcO6G4FUlmRdO8qv2J1hMp9n8Yoymqmv9MpmaHeSqefgRVncveEHRg5TrFp
         nZvkDXyPctY24Ge8uGRJ7TCWRASEnIbiuti4fDzbLu60/49nmzwFl/2spIHFUXMljED1
         Aq08JHF0nPjxsfxTKaqGx8vuHtMLWocgpQbhLDkcrCp+AAwsWVeT+9Y8odNrymK2M8lZ
         UtqJyUztiuZG06ImCwlNpeOutSQ9ICDuzFtgf9JOM4Z4CT4H43w32CPQf1ROPYKHuFBj
         Q4SNqFbowQfkOOpAozVr+dvIPFk8V1jJz0uSZkzAZ/9IAyscnqT9TLFNOhJ/cUpg1phD
         DXhA==
X-Gm-Message-State: AOJu0YxUnMJcUb88ezo1D5PPrrl9mCUTjfRcetzzp8nQcaPgEG5QVjDZ
	0zKQPucPHWRsD0fQhlQ9+qBA63icnvVvHRNK1uSmuK6SfzIIufUTcWs388wxnA==
X-Google-Smtp-Source: AGHT+IGp9ihenLbhfTpRo1AlD/nvyc0zBpF9guPowYjRPujjexXL3HOA0CI6mqrrvkUN92vD5xOF/2dKoZVGh8twVbU=
X-Received: by 2002:a50:9fab:0:b0:54c:f4fd:3427 with SMTP id
 c40-20020a509fab000000b0054cf4fd3427mr207958edf.7.1703005344201; Tue, 19 Dec
 2023 09:02:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219081453.718489-1-faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20231219081453.718489-1-faizal.abdul.rahim@linux.intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 Dec 2023 18:02:12 +0100
Message-ID: <CANn89iJvbXKgT3OSyLYMXpvoOXc+OEUt1eTzbHnZ0wG8ibvqcw@mail.gmail.com>
Subject: Re: [PATCH v3 net 0/4] qbv cycle time extension/truncation
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 9:17=E2=80=AFAM Faizal Rahim
<faizal.abdul.rahim@linux.intel.com> wrote:
>
> According to IEEE Std. 802.1Q-2018 section Q.5 CycleTimeExtension,
> the Cycle Time Extension variable allows this extension of the last old
> cycle to be done in a defined way. If the last complete old cycle would
> normally end less than OperCycleTimeExtension nanoseconds before the new
> base time, then the last complete cycle before AdminBaseTime is reached
> is extended so that it ends at AdminBaseTime.
>

Hmm... Is this series fixing any of the pending syzbot bugs ?

