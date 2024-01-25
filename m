Return-Path: <linux-kernel+bounces-39413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C767583D0B5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0674F1C23706
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D616C134AF;
	Thu, 25 Jan 2024 23:31:38 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73A111A2;
	Thu, 25 Jan 2024 23:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706225498; cv=none; b=jiN0iDTVIsZRawicV1xmQoaFlgGsUD38g5buNoSg8zyx4l9lSwbnMfSrhOosAyjQ4duX5bTtSe9WsH0eKJwobkobrJNL88z9PCPhPseNPRhoSebY5orBNpBOGdhM7ZaSReYnHsoOVN4+eXv+BNR7tnRuqnoX4v+TXcKhUwYrels=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706225498; c=relaxed/simple;
	bh=KE/JvQmrHi3uMpYoT3NT/4yez4cQsaGTuCqRRiyYl80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ha6RbIH9TsDslFkSeKJDUchlYEJafmm8LcvJ1SfXGM39HhFL8ZifnIyTMpLnGcWb3yZQkJyES90Y+SWitoXQxSRWU/xRsP54o6xbjSIGyQBNd8A/z4myLAiGgIm565lL9YQ9hQy5BEc3p2uycuqhRicc7d/ymcqyf0AWfmrwNIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2907a17fa34so60021a91.1;
        Thu, 25 Jan 2024 15:31:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706225496; x=1706830296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHqjgs8+QxlFIbOEf1XBMDmlvl/t8IMshvxEVcI3NVY=;
        b=jf5emuR6FdMfEESup6AvQ9lzdRSmi+z4DAyFC4gIzrDi97kwUkbf/lfQbAAnw7Rqqo
         m7X3u6ZzazalL+pbQyB/0IImFJ91p2y44J1WO+37pdVSdhvYCZFJL86klTpqW1BuxWTr
         jxRWDKNulj2Twr9G22xFxAI0WWwxsA+OMu8J7PNI+f/puxh8FiP6scNNOjMGy+czD/iM
         eonJG17CtnWTdBY4l90VBbLSCcjbBhj+ILklTDsVjcARvvoBAqe4h+pjOqB9ogASfeMp
         2M6+dtMM+eiul1SoNokbLs1xTIPTmbvqo1jhcud5MnLYhAhrn/eJUcuftm5J6+6CjUWf
         gNDQ==
X-Gm-Message-State: AOJu0YyEw9zdqLkihMnJTVjRcMVE8Vi058F0lmuKtCicIzvpJbmKPf3l
	vc97TVsUXXG0ilmFkdfDMBXkILb2qxnpoJkDAJL8IPSmjqKc47ULZ9Kx+LaS9xYhL0YbevSDS/m
	0+15U5jiqu89Ca1eJOB3fD2dbCjk=
X-Google-Smtp-Source: AGHT+IH0Dw5P3tmsGW8BpZTQ4O5CyxMjaYYwIdEzmayvoi5dfka0xnL5Cz8tm/rWoi4UDHCMVZy7icZ4ygtZvKNUEKs=
X-Received: by 2002:a17:90a:a002:b0:290:f5db:c4ad with SMTP id
 q2-20020a17090aa00200b00290f5dbc4admr327728pjp.46.1706225495906; Thu, 25 Jan
 2024 15:31:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125184411.30757-1-kotborealis@awooo.ru> <CAP-5=fXWALXbbDSv9rY9DN3vRy8aynk2MQEBCbqC7drP-Xzcrg@mail.gmail.com>
In-Reply-To: <CAP-5=fXWALXbbDSv9rY9DN3vRy8aynk2MQEBCbqC7drP-Xzcrg@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 25 Jan 2024 15:31:24 -0800
Message-ID: <CAM9d7chePctxu6n5nKkS1w3ju=aTUuzyZfzA1MDBTd+KkzoTEg@mail.gmail.com>
Subject: Re: [PATCH] perf data convert: Output empty string for null pointer
To: Ian Rogers <irogers@google.com>
Cc: kotborealis@awooo.ru, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jan 25, 2024 at 12:59=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Thu, Jan 25, 2024 at 10:44=E2=80=AFAM <kotborealis@awooo.ru> wrote:
> >
> > From: Evgeny Pistun <kotborealis@awooo.ru>
> >
> > Providing ill-formed input to `perf data conver --to-json`
> > causes it to crash with segmentaton fault. There's a bug in
> > `output_json_string` functon: input string is not validated.
> > This could be reproduced by crafting input that does not specify
> > hostname/os-release/etc, which are written to 'headers' section of
> > outputted json.
> >
> > This patch adds a null pointer check. If `output_json_string` is
> > called with a null pointer, it should output empty string (`""`).
> >
> > Signed-off-by: Evgeny Pistun <kotborealis@awooo.ru>
>
> Reviewed-by: Ian Rogers <irogers@google.com>

I think this is related to this one:

  https://lore.kernel.org/linux-perf-users/20240117215101.77713-1-ilkka@os.=
amperecomputing.com/

I'm ok with making it robust, but also afraid it might
end up with a broken JSON if something is missing in
{ key: value } format.  IOW we may need to handle it in
a higher layer.

Thanks,
Namhyung

